package com.nadri.web.board;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.nadri.common.Search;
import com.nadri.service.board.BoardService;
import com.nadri.service.comment.CommentService;
import com.nadri.service.domain.Board;
import com.nadri.service.domain.Comment;
import com.nadri.service.domain.User;
import com.nadri.service.user.UserService;

@Controller
@RequestMapping("/board/*")
public class BoardController {

	@Autowired
	@Qualifier("boardServiceImpl")
	private BoardService boardService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	@Qualifier("commentServiceImpl")
	private CommentService commentService;
	
	public BoardController() {
		System.out.println(this.getClass());
	}

	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@Value("#{imgpathProperties['board']}")
	String imgPath;
	
	
	@RequestMapping(value="/board/addBoard", method=RequestMethod.GET)
	public String addBoard() throws Exception{
		System.out.println("/board/addBoard : GET");
		
		return "forward:/board/addBoard.jsp"; //redirect �ص� ������ URL ���߱� ���� ���!
	}
	
	@RequestMapping(value="/board/addBoard", method=RequestMethod.POST)
	public String addBoard(@ModelAttribute("board") Board board,
									MultipartHttpServletRequest request, @RequestParam("file") MultipartFile[] file) throws Exception{
		System.out.println("/board/addBoard : POST");
		
		String uploadPath = request.getRealPath(imgPath)+"\\"; //���Ͼ��ε� ���
		
		String fileOriginName=""; //�� �������ϸ�
		String fileMultiName=""; //���� ���ϸ�(��)
		
		for(int i=0; i<file.length; i++) {
			fileOriginName = file[i].getOriginalFilename();
			
			//������ �������� ������
			if(fileOriginName=="") {
				break;
			}
			
			System.out.println("���� ���ϸ� : "+fileOriginName);
			SimpleDateFormat formatter = new SimpleDateFormat("YYMMDD_HHMMSS_"+i);
			Calendar now = Calendar.getInstance();
			
			String extension = fileOriginName.split("\\.")[1]; //Ȯ���ڸ�
			fileOriginName = formatter.format(now.getTime())+"."+extension;
			System.out.println("����� ���ϸ� : "+fileOriginName);
			
			File f = new File(uploadPath+fileOriginName);
			file[i].transferTo(f);
			
			if(i==0) {
				fileMultiName += fileOriginName;
			}else {
				fileMultiName += ","+fileOriginName;
			}
		}
		
		System.out.println("���� ���ϸ�(��) : "+fileMultiName);
		board.setBoardImg(fileMultiName);
		board.setUser( (User)request.getSession().getAttribute("user") );
		
		boardService.addBoard(board);
		
		return "redirect:/board/listBoard";
	}
	
	@RequestMapping(value="updateBoard", method=RequestMethod.GET)
	public String updateBoard( @ModelAttribute Board board, Model model ) throws Exception{
		System.out.println("/board/updateBoard : GET");
		
		model.addAttribute("board", boardService.getBoard(board.getBoardNo()));
		
		return "forward:/board/updateBoard.jsp";
	}
	
	@RequestMapping(value="updateBoard", method=RequestMethod.POST)
	public String updateBoard( @ModelAttribute Board board,
										MultipartHttpServletRequest request, @RequestParam("file") MultipartFile[] file) throws Exception{
		System.out.println("/board/updateBoard : POST");
		
		String uploadPath = request.getRealPath(imgPath)+"\\"; //���Ͼ��ε� ���
		
		String fileOriginName=""; //�� �������ϸ�
		String fileMultiName=""; //���� ���ϸ�(��)
		
		//���ε�� �������� ����
		if( board.getBoardImg().contains(",") ) {
			for( String fileName : board.getBoardImg().split(",")) {
				new File(uploadPath+fileName).delete();
				System.out.println(fileName+" �����Ϸ�");
			}
		}else {
			new File(uploadPath+board.getBoardImg()).delete();
			System.out.println(board.getBoardImg()+" �����Ϸ�");
		}
		
		boolean fileFlag = true;
		for(int i=0; i<file.length; i++) {
			fileOriginName = file[i].getOriginalFilename();
			
			//������ �������� ������
			if(fileOriginName=="") {
				fileFlag = false;
				break;
			}
			
			System.out.println("���� ���ϸ� : "+fileOriginName);
			SimpleDateFormat formatter = new SimpleDateFormat("YYMMDD_HHMMSS_"+(i+1));
			Calendar now = Calendar.getInstance();
			
			String extension = fileOriginName.split("\\.")[1]; //Ȯ���ڸ�
			fileOriginName = formatter.format(now.getTime())+"."+extension;
			System.out.println("����� ���ϸ� : "+fileOriginName);
			
			File f = new File(uploadPath+fileOriginName);
			file[i].transferTo(f);
			
			if(i==0) {
				fileMultiName += fileOriginName;
			}else {
				fileMultiName += ","+fileOriginName;
			}
		}
		
		//������ �������������� �ν�Ʈ������ ���� �ֱ����ؼ� //DB�� �׷��� �Ǿ��־ ���߷���
		if(!fileFlag) {
			System.out.println("������ �������� �ʾƼ� null�� ���ϴ�.");
			board.setBoardImg(null);
		}else {
			System.out.println("���� ���ϸ�(��) : "+fileMultiName);
			board.setBoardImg(fileMultiName);
		}

		board.setUser( (User)request.getSession().getAttribute("user") );
		boardService.updateBoard(board);
		
		return "redirect:/board/listBoard";
	}
	
	@RequestMapping(value="getBoard")
	public String getBoard(@RequestParam("boardNo") int boardNo, Model model, HttpSession session) throws Exception{
		System.out.println("/board/getBoard : GET / POST");

		Board board = boardService.getBoard(boardNo);
		User user = userService.getUser(board.getUser().getUserId());
		board.setUser(user);

		if(session.getAttribute("user")!=null) {
			int likeFlag = boardService.getLikeFlag(boardNo, ((User)session.getAttribute("user")).getUserId() );
			model.addAttribute("likeFlag", likeFlag);
		}
		
		//����� ���� ���� ����
		if( board.getCommCnt()>0 ) {
			List<Comment> comment = commentService.getCommentList(boardNo);
			for( int i=0; i<comment.size(); i++) {
				comment.get(i).setUser( userService.getUser( (comment.get(i).getUser().getUserId()) ) );
			}
			board.setComment(comment);
			
			String commLastTime = (comment.get(comment.size()-1).getcommentTime()).toString().replace("-","").replace(":","").replace(" ","").substring(0,14);
			board.setCommLastTime(commLastTime);
		}
		
		model.addAttribute("board", board);
		
		return "forward:/board/getBoard.jsp";
	}
	
	@RequestMapping(value="listBoard")
	public String getBoardList( @ModelAttribute("search") Search search, Model model, HttpSession session) throws Exception{
		System.out.println("/board/getBoardList : GET / POST");
		
		if(search.getCurrentPage()==0 ){
			search.setCurrentPage(0);
		}
		search.setPageSize(pageSize);
		
		if(session.getAttribute("user")!=null) { //��ȸ��0, ȸ��1
			search.setMemberFlag(1);
		}
		
		List<Board> list = boardService.getBoardList(search);
		for( int i=0; i<list.size(); i++) {
			list.get(i).setUser( userService.getUser( (list.get(i).getUser().getUserId()) ) );
			//ȸ���� ��� session ���� ���ƿ� ���� ��������
			if(session.getAttribute("user")!=null) { 
				list.get(i).setLikeFlag( boardService.getLikeFlag( list.get(i).getBoardNo(), ((User)session.getAttribute("user")).getUserId()) );	
			}
			//����� ���� ���� ����
			if( list.get(i).getCommCnt()>0 ) {
				List<Comment> comment = commentService.getCommentList(list.get(i).getBoardNo());
				for( int j=0; j<comment.size(); j++) {
					comment.get(j).setUser( userService.getUser( (comment.get(j).getUser().getUserId()) ) );
				}
				list.get(i).setComment(comment);
				String commLastTime = (comment.get(comment.size()-1).getcommentTime()).toString().replace("-","").replace(":","").replace(" ","").substring(0,14);
				list.get(i).setCommLastTime(commLastTime);
			}
		}
		
		model.addAttribute("list", list);
		model.addAttribute("search", search);
		
		return "forward:/board/listBoard.jsp";
	}
	
	@RequestMapping(value="deleteBoard", method=RequestMethod.POST)
	public String deleteBoard(@RequestParam("boardNo") int boardNo) throws Exception{
		System.out.println("/board/deleteBoard : POST");
		
		boardService.deleteBoard(boardNo);
		
		return "redirect:/board/listBoard";
	}

	//���������� �ۼ��� �ۺ���
	@RequestMapping(value="getMyBoardList")
	public String getMyBoardList(Model model, HttpSession session) throws Exception{
		System.out.println("/board/getMyBoardList : GET / POST");
		
		User user = (User)session.getAttribute("user");
		
		if(user==null) { //������ ������ ���
			return "redirect:/index.jsp";
		}
		List<Board> list = boardService.getMyBoardList(user.getUserId());
		
		model.addAttribute("list", list);
		
		return "forward:/user/mypageBoardList.jsp";
	}
	
}
