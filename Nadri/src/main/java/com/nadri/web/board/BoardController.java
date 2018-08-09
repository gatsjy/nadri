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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	public synchronized String addBoard(HttpSession session) throws Exception{
		System.out.println("/board/addBoard : GET");
		
		if(session.getAttribute("user")==null) { //��ȸ���� �����ϸ� ����Ʈ�� ������
			return "redirect:/board/listBoard";
		}else {
			//redirect �ص� ������ URL ���߱� ���� ���!
			return "forward:/board/addBoard.jsp"; //ȸ���� ��� �ۼ��������� �鿩�����ֱ�
		}
	}
	
	@RequestMapping(value="/board/addBoard", method=RequestMethod.POST)
	public synchronized String addBoard(@ModelAttribute("board") Board board, @RequestParam("file") MultipartFile[] file,
									MultipartHttpServletRequest request, Model model,
									RedirectAttributes redirectAttributes) throws Exception{
		System.out.println("/board/addBoard : POST");
		
		String uploadPath = "C:\\Users\\Bitcamp\\git\\nadri\\Nadri\\WebContent\\images\\board\\posts\\"; //���Ͼ��ε� ���
		
		String fileOriginName=""; //�� �������ϸ�
		String fileMultiName=""; //���� ���ϸ�(��)
		
		for(int i=0; i<file.length; i++) {
			fileOriginName = file[i].getOriginalFilename();
			
			//������ �������� ������
			if(fileOriginName=="") {
				break;
			}
			
			System.out.println("���� ���ϸ� : "+fileOriginName);
			SimpleDateFormat formatter = new SimpleDateFormat("yyMMdd_HHmmss_"+i);
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
		if( fileMultiName.trim()=="" ) {
			board.setBoardImg(null);
		}else {
			board.setBoardImg(fileMultiName);
		}
		board.setUser( (User)request.getSession().getAttribute("user") );
		board.setBoardCode(0); //�Խ��ǿ��� �ۼ��Ѱ� 0����, ���������Ѱ� 1��(rest���� 1�� ó���ϸ� ��)
		
		boardService.addBoard(board);
		
		//�����ɿ� �ʿ�
		redirectAttributes.addAttribute("myBoardCnt", boardService.getMyCount("board", board.getUser().getUserId()));
		
		return "redirect:/board/listBoard";
	}
	
	@RequestMapping(value="updateBoard", method=RequestMethod.GET)
	public synchronized String updateBoard( @ModelAttribute Board board, Model model, HttpSession session ) throws Exception{
		System.out.println("/board/updateBoard : GET");
		
		User user = (User)session.getAttribute("user");
		Board bb = boardService.getBoard(board.getBoardNo());
		
		if(bb == null) { //�������� �ʴ� �Խù� �� ���
			return "forward:/mainError.jsp";
		}
		
		if( user==null ) { 														//��ȸ���̶�� ����Ʈ�� ����������
			return "redirect:/board/listBoard";
		}else if( !user.getUserId().equals(bb.getUser().getUserId()) ) { //�ۼ��ڰ� ��û�Ѱ� �ƴ� ���
			return "redirect:/board/listBoard";
		}else { 																//ȸ���̸鼭 �ۼ��ڰ� ��û�� ���
			model.addAttribute("board", bb);
			
			return "forward:/board/updateBoard.jsp";	
		}
	}
	
	@RequestMapping(value="updateBoard", method=RequestMethod.POST)
	public synchronized String updateBoard( @ModelAttribute Board board,
										MultipartHttpServletRequest request, @RequestParam("file") MultipartFile[] file) throws Exception{
		System.out.println("/board/updateBoard : POST");
		
		//String uploadPath = request.getRealPath(imgPath)+"\\"; //���Ͼ��ε� ���
		//String uploadPath = "C:\\Users\\Bitcamp\\git\\nadri\\Nadri\\WebContent\\images\\board\\posts\\"; //���Ͼ��ε� ���
		String uploadPath = "C:\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\Nadri\\images\\board\\posts\\"; //���Ͼ��ε� ���(�ٷκ����ֱ�)

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
			SimpleDateFormat formatter = new SimpleDateFormat("yyMMdd_HHmmss_"+(i+1));
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
		
		return "forward:/board/listBoard";
	}
	
	@RequestMapping(value="getBoard")
	public synchronized String getBoard(@RequestParam("boardNo") int boardNo, Model model, HttpSession session) throws Exception{
		System.out.println("/board/getBoard : GET / POST");

		Board board = boardService.getBoard(boardNo);
		
		if( board==null ) { //�ش� �Խù��� �������� ���� ��
			return "forward:/mainError.jsp";
		}
		System.out.println("@"+board.getOpenRange());
		System.out.println("@"+board.getUser().getUserId());
		if( board.getOpenRange()=="2" ) { //����� �Խù��ε�
			if( board.getUser().getUserId()!=((User)session.getAttribute("user")).getUserId() ) { //������ �ƴ� ���
				return "forward:/lockError.jsp";
			}
		}
		
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
	public synchronized String getBoardList( @ModelAttribute("search") Search search, Model model, HttpSession session,
										@RequestParam(value="myBoardCnt", defaultValue="0") int boardCnt) throws Exception{
		System.out.println("/board/getBoardList : GET / POST");
		
		if(search.getCurrentPage()==0 ){
			search.setCurrentPage(0);
		}
		search.setPageSize(pageSize);
		
		String userId="";
		if(session.getAttribute("user")!=null) { //��ȸ��0, ȸ��1
			search.setMemberFlag(1);
			userId = ((User)session.getAttribute("user")).getUserId();
		}
		
		List<Board> list = boardService.getBoardList(search, userId);
		
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
		//�����ɿ� �ʿ�
		model.addAttribute("myBoardCnt", boardCnt);
		
		return "forward:/board/listBoard.jsp";
	}
	
	@RequestMapping(value="deleteBoard", method=RequestMethod.POST)
	public synchronized String deleteBoard(@RequestParam("boardNo") int boardNo) throws Exception{
		System.out.println("/board/deleteBoard : POST");
		
		boardService.deleteBoard(boardNo);
		
		return "redirect:/board/listBoard";
	}

	//���������� �ۼ��� �ۺ���
	@RequestMapping(value="getMyBoardList")
	public synchronized String getMyBoardList(Model model, HttpSession session) throws Exception{
		System.out.println("/board/getMyBoardList : GET / POST");
		
		User user = (User)session.getAttribute("user");
		
		if(user==null) { //������ ������ ���
			return "redirect:/";
		}
		List<Board> list = boardService.getMyBoardList(user.getUserId());
		
		model.addAttribute("list", list);
		
		return "forward:/user/mypageBoardList.jsp";
	}
	
}
