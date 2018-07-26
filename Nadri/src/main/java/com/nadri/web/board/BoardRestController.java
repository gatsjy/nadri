package com.nadri.web.board;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.nadri.common.Search;
import com.nadri.service.board.BoardService;
import com.nadri.service.comment.CommentService;
import com.nadri.service.domain.Board;
import com.nadri.service.domain.Comment;
import com.nadri.service.domain.Schedule;
import com.nadri.service.domain.User;
import com.nadri.service.friend.FriendService;
import com.nadri.service.schedule.ScheduleService;
import com.nadri.service.user.UserService;

@RestController
@RequestMapping("/board/*")
public class BoardRestController {

	@Autowired
	@Qualifier("boardServiceImpl")
	private BoardService boardService;

	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	@Qualifier("commentServiceImpl")
	private CommentService commentService;
	
	@Autowired
	@Qualifier("friendServiceImpl")
	private FriendService friendService;
	
	@Autowired
	@Qualifier("scheduleServiceImpl")
	private ScheduleService scheduleService;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	@Value("#{imgpathProperties['board']}")
	String imgPath;
	
	public BoardRestController() {
		System.out.println(this.getClass());
	}
	
	//�Խù�
	@RequestMapping(value="json/addBoard", method=RequestMethod.POST) //�Ϲ� �Խù� �ۼ� //�ȵ���̵��
	public void addBoard( @RequestBody Board board ) throws Exception{
		System.out.println("/board/json/addBoard : POST");
		
		boardService.addBoard(board);
	}

	@RequestMapping(value="json/addBoard/{scheduleNo}", method=RequestMethod.POST) //���� �Խù� �ۼ�
	public void addBoard( @PathVariable int scheduleNo, HttpSession session ) throws Exception{
		System.out.println("/board/json/addBoard/{scheduleNo} : POST");
		
		Schedule schedule = scheduleService.getSchedule(scheduleNo);
		User user = (User)session.getAttribute("user");
		user = userService.getUser(user.getUserId());
		
		Board board = new Board();
		board.setBoardTitle(schedule.getScheduleTitle());
		board.setBoardContent(schedule.getScheduleDetail());
		board.setBoardImg(schedule.getScheduleImg());
		board.setOpenRange(schedule.getOpenRange());
		board.setHashTag(schedule.getHashTag());
		board.setUser(user);
		board.setBoardCode(scheduleNo);
		
		boardService.addBoard(board);
	}
	
	@RequestMapping(value="json/deleteBoard/{boardNo}", method=RequestMethod.POST)
	public void deleteBoard( @PathVariable int boardNo, HttpServletRequest request ) throws Exception{
		System.out.println("/board/json/deleteBoard : POST");
		
		Board board = boardService.getBoard(boardNo);
		
		String uploadPath = request.getRealPath(imgPath)+"\\"; //���Ͼ��ε� ���
				
		//���ε�� �������� ����
		if( board.getBoardImg().contains(",") ) {
			for( String fileName : board.getBoardImg().split(",")) {
				new File(uploadPath+fileName).delete();
				System.out.println(fileName+" �����Ϸ�");
			}
		}
		
		boardService.deleteBoard(boardNo);
	}
	
	@RequestMapping(value="json/getBoardList/{currentPage}", method=RequestMethod.POST)
	public List<Board> getBoardList( @PathVariable int currentPage, HttpSession session ) throws Exception{
		System.out.println("/board/json/getBoardList : POST");
		
		Search search = new Search();
		search.setStartRowNum( (currentPage+1)*pageSize );
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

		return list;
	}
	
	@RequestMapping(value="json/checkBoard/{boardCode}", method=RequestMethod.POST)
	public int checkBoard( @PathVariable int boardCode, HttpSession session ) throws Exception{ //�ۼ��� ������ �������� �̹� �ƴ��� üũ
		System.out.println("/board/json/checkBoard : POST");
		
		User user = (User)session.getAttribute("user");
		
		return boardService.checkBoard(boardCode, user.getUserId());
	}
	
	//���ƿ�
	@RequestMapping(value="json/addLike/{boardNo}", method=RequestMethod.POST)
	public int addLike( @PathVariable int boardNo, HttpSession session ) throws Exception{
		System.out.println("/board/json/addLike : POST");
		
		User user = (User)session.getAttribute("user");
		boardService.addLike(boardNo, user.getUserId()); //�߰��ϰ�

		return boardService.getLikeCount(boardNo); //����� ���� ����
	}

	@RequestMapping(value="json/deleteLike/{boardNo}", method=RequestMethod.POST)
	public int deleteLike( @PathVariable int boardNo, HttpSession session ) throws Exception{
		System.out.println("/board/json/deleteLike : POST");

		User user = (User)session.getAttribute("user");
		boardService.deleteLike(boardNo, user.getUserId());
		
		return boardService.getLikeCount(boardNo); //����� ���� ����
	}
	
	//���
	@RequestMapping(value="json/addComment/{userId}", method=RequestMethod.POST) 
	public Comment addComment( @RequestBody Comment comment, @PathVariable String userId ) throws Exception{
		System.out.println("/board/json/addComment : POST");
		
		/* �˸��� ���
		String cc = comment.getCommentContent(); //�Ѿ�� ����
		if( cc.contains("@") ) { //ģ����ȯ
			String[] friend = cc.split("@");
			for( int i=1; i<friend.length; i++) { //���⼭ �˸��߰�
				String friendId = friend[i].split(" ")[0];
				comment.setFriend( userService.getUser(friendId) );
			}
		}else { //ģ����ȯX
			System.out.println("@ģ����ȯX");
		}
		//*/
		
		comment.setUser( userService.getUser(userId) );
		commentService.addComment(comment);
		
		Comment returnComm = commentService.getComment(comment.getCommentNo());
		returnComm.setUser( userService.getUser( returnComm.getUser().getUserId() ) );
		
		return returnComm;
	}

	@RequestMapping(value="json/deleteComment/{boardNo}/{commentNo}", method=RequestMethod.POST) 
	public int deleteComment( @PathVariable int boardNo, @PathVariable int commentNo ) throws Exception{
		System.out.println("/board/json/deleteComment : POST");
		
		commentService.deleteComment(commentNo);
		
		return commentService.getCommentCount(boardNo); //����� ���� ����
	}

	//����ȭ�� ��õ�Խù� (�ֽ�)
	@RequestMapping(value="recomBoardNew")
	public String recomBoardNew(Model model) throws Exception{
		System.out.println("/board/recomBoardNew : GET / POST");
		
		Search search = new Search();
		search.setSearchCondition("�ֽ�");
		List<Board> list = boardService.getRecomBoard(search);
		
		model.addAttribute("recomBoardNew", list);
		
		return "forward:/index.jsp";
	}
	//����ȭ�� ��õ�Խù� (�ϰ�)
	@RequestMapping(value="recomBoardDay")
	public String recomBoardDay(Model model) throws Exception{
		System.out.println("/board/recomBoardDay : GET / POST");
		
		Search search = new Search();
		search.setSearchCondition("�ϰ�");
		List<Board> list = boardService.getRecomBoard(search);
		
		model.addAttribute("recomBoardDay", list);
		
		return "forward:/index.jsp";
	}
	//����ȭ�� ��õ�Խù� (�ְ�)
	@RequestMapping(value="recomBoardWeek")
	public String recomBoardWeek(Model model) throws Exception{
		System.out.println("/board/recomBoardWeek : GET / POST");
		
		Search search = new Search();
		search.setSearchCondition("�ְ�");
		List<Board> list = boardService.getRecomBoard(search);
		
		model.addAttribute("recomBoardWeek", list);
		
		return "forward:/index.jsp";
	}
	//����ȭ�� ��õ�Խù� (����)
	@RequestMapping(value="recomBoardMonth")
	public String recomBoardMonth(Model model) throws Exception{
		System.out.println("/board/recomBoardMonth : GET / POST");
		
		Search search = new Search();
		search.setSearchCondition("����");
		List<Board> list = boardService.getRecomBoard(search);
		
		model.addAttribute("recomBoardMonth", list);
		
		return "forward:/index.jsp";
	}
}
