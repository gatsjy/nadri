package com.nadri.web.admin;


import java.io.File;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.nadri.common.Search;
import com.nadri.service.admin.AdminService;
import com.nadri.service.board.BoardService;
import com.nadri.service.domain.Board;
import com.nadri.service.domain.Comment;
import com.nadri.service.domain.Inquire;
import com.nadri.service.domain.Reward;
import com.nadri.service.domain.Spot;
import com.nadri.service.user.UserService;
import com.nadri.service.domain.User;
import com.nadri.service.spot.SpotService;


@RestController
@RequestMapping("/restAdmin/*")
public class AdminRestController {
	
	@Autowired
	@Qualifier("adminServiceImpl")
	private AdminService adminService;
	
	@Autowired
	@Qualifier("boardServiceImpl")
	private BoardService boardService;

	@Autowired
	@Qualifier("spotServiceImpl")
	private SpotService spotService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;


	public AdminRestController() {
		System.out.println(this.getClass());
	}
	
	@RequestMapping(value = "addInquire/{reportUser}/{inquireCode}/{write_enc}/{title_enc}/{inquireLink}", method=RequestMethod.POST)
	public String addInquire(HttpServletRequest request,@PathVariable String inquireLink,@PathVariable String title_enc,@PathVariable String write_enc,@PathVariable String reportUser,@PathVariable String inquireCode,@RequestParam("inquire_file")MultipartFile file,@ModelAttribute("inquire") Inquire inquire,Model model) throws Exception {
		System.out.println("addInquire -> Restcontroller ����");
		System.out.println("���� fileName : "+file.getOriginalFilename());
		System.out.println(reportUser+" / "+inquireCode);
		System.out.println("inquireLink = "+inquireLink);
		String inquireTitle = URLDecoder.decode(title_enc,"UTF-8");
		String inquireWrite = URLDecoder.decode(write_enc,"UTF-8");
		inquire.setInquireTitle(inquireTitle);
		inquire.setInquireWrite(inquireWrite);
		inquire.setReportUserId(reportUser);
		inquire.setInquireLink(inquireLink);
		//String path = "C:\\Users\\Bit\\git\\nadri\\Nadri\\WebContent\\images\\inquire\\";
		String path = "C:\\Users\\Bitcamp\\git\\nadri\\Nadri\\WebContent\\images\\inquire\\";
		if(!file.isEmpty()) {
		      
		     String fileOriginName=""; //�� �������ϸ�
		      
	        fileOriginName = file.getOriginalFilename();
	         
	        System.out.println("���� ���ϸ� : "+fileOriginName);
	        SimpleDateFormat formatter = new SimpleDateFormat("YYMMDD_HHMMSS_");  // ���Ŀ� ���⿡ �������̵����
	        Calendar now = Calendar.getInstance();
	         
	        String extension = fileOriginName.split("\\.")[1]; //Ȯ���ڸ�
	        fileOriginName = formatter.format(now.getTime())+"."+extension;
	        System.out.println("����� ���ϸ� : "+fileOriginName);
			
			System.out.println("FileUpload����");
			File file1 = new File(path+fileOriginName);
			file.transferTo(file1);
            inquire.setInquireFile1(fileOriginName);
            
		}
		HttpSession session = request.getSession(true);
		User user = (User)session.getAttribute("user");
		
		inquire.setUserId(user.getUserId());
		
		if (reportUser.equals("null")) {
			inquire.setReportUserId(null);
		}
		
		if (inquireLink.equals("null")) {
			inquire.setInquireLink(null);
		}
		
		System.out.println("inquire : "+inquire);
		adminService.addInquire(inquire);
		
		return "done";
	}
	
	@RequestMapping(value = "addInquireNoFile/{reportUser}/{inquireCode}/{write_enc}/{title_enc}/{inquireLink}", method=RequestMethod.POST)
	public String addInquireNoFile(HttpServletRequest request,@PathVariable String inquireLink,@PathVariable String title_enc,@PathVariable String write_enc,@PathVariable String reportUser,@PathVariable String inquireCode,@ModelAttribute("inquire") Inquire inquire,Model model) throws Exception {
		System.out.println("addInquireNoFile -> Restcontroller ����");
		System.out.println(reportUser+" / "+inquireCode);
		System.out.println("inquireLink = "+inquireLink);
		String inquireTitle = URLDecoder.decode(title_enc,"UTF-8");
		String inquireWrite = URLDecoder.decode(write_enc,"UTF-8");
		inquire.setInquireTitle(inquireTitle);
		inquire.setInquireWrite(inquireWrite);
		inquire.setReportUserId(reportUser);
		inquire.setInquireLink(inquireLink);
		
		HttpSession session = request.getSession(true);
		User user = (User)session.getAttribute("user");
		
		inquire.setUserId(user.getUserId());
		
		if (reportUser.equals("null")) {
			inquire.setReportUserId(null);
		}
		
		if (inquireLink.equals("null")) {
			inquire.setInquireLink(null);
		}
		
		System.out.println("inquire : "+inquire);
		adminService.addInquire(inquire);
		
		return "done";
	}
	
	@RequestMapping(value="chkInquire/{inquireChkCode}/{inquireNo}", method=RequestMethod.GET)
	public boolean chkInquire(@PathVariable String inquireChkCode,@PathVariable String inquireNo) {
		System.out.println("chkInquire ����! IN REST CONTROLLER");
		Inquire inquire = new Inquire();
		System.out.println("inq C Code : "+inquireChkCode);
		System.out.println("inq No : "+inquireNo);
		inquire.setInquireChkCode(inquireChkCode);
		System.out.println(inquire);
		inquire.setInquireNo(Integer.parseInt(inquireNo));
		adminService.updateInquire(inquire);
		System.out.println("returned?");
		return true;
	}
	
	@RequestMapping(value="userLog/{userId}/{duration}",produces = "text/json; charset=UTF-8")
	public String userLog(@PathVariable String userId,@PathVariable String duration) {
		
		System.out.println("userLog -> Restcontroller ����");
		System.out.println("�Ѱܹ��� �������̵�� �Ⱓ : "+userId+" / "+duration);
		
		int num = 0;
		
		if(duration.equals("week")) {
			num = Calendar.WEEK_OF_YEAR;
		}else if(duration.equals("month")) {
			num = Calendar.MONTH;
		}
		
		System.out.println("���޵Ǵ� �ѹ��� : "+num);
		Map<String,Object> map = userService.getUserLog(userId, num, duration);
		System.out.println("restController���� ���� map ��ü : "+map);
		Map<String,Object> colmap = new LinkedHashMap<String,Object>();
		Map<String,Object> realMap = new LinkedHashMap<String,Object>();
		colmap.put("String", "Activity");
		colmap.put("number", "count");
		realMap.put("cols", colmap);
		realMap.put("rows", map);
		Gson gson = new Gson();
		String json = gson.toJson(realMap, LinkedHashMap.class);
		System.out.println("���޵Ǵ� json = "+json);
		return json;

	}
	
	@RequestMapping(value="graphChange/{duration}", method=RequestMethod.GET)
	public List graphChange(@PathVariable String duration) {
		List<List<Integer>> graphList = new ArrayList<List<Integer>>();	
		return null;
	}
	
	@RequestMapping(value="blockUser/{userId}",method=RequestMethod.GET)
	public String blockUser(@PathVariable String userId) {
		System.out.println("blockUser -> Restcontroller ����");
		int updated = adminService.blockUser(userId);
		if (updated == 0) {
			return "fail";
		}else {			
			return "success";
		}
	}
	
	@RequestMapping(value="getReward/{rewardName}/{rewardLevel}")
	public String getReward(@PathVariable String rewardName,@PathVariable String rewardLevel,HttpServletRequest request) {
		System.out.println("getReward -> Restcontroller ����");
		HttpSession session = request.getSession(true);
		User user = (User)session.getAttribute("user");
		String userId = user.getUserId();
		Reward reward = new Reward();
		
		reward.setUserId(userId);
		reward.setRewardName(rewardName);
		reward.setRewardLevel(rewardLevel);
		
		adminService.getReward(reward);
		
		return "Done";
	}
	
	@RequestMapping(value="listUser",method=RequestMethod.POST)
	public User listUser(@ModelAttribute("search") Search search) {
		System.out.println("getReward -> Restcontroller ����");
		return null;
	}
	
	@RequestMapping(value = "deleteSpot/{spotNo}")
	public List deleteSpot(Model model, @PathVariable String spotNo) throws Exception {
		System.out.println("deleteSpot -> controller ����");
		spotService.deleteSpot(spotNo);

		List<Spot> list = spotService.getSpotList();

		System.out.println(list);

		model.addAttribute("list", list);
		model.addAttribute("count", list.size());
		
		List<List> returnList = new ArrayList<List>();
		
		returnList.add(list);

		return returnList;
	}
	
	@RequestMapping(value="getReplyDetail/{inquirelink}")
	public Map getReply(@PathVariable String inquirelink) {
		
		System.out.println("getReply -> controller ����");
		/*adminService.getReply(inquireLink)*/
		Map<String,String> map = new HashMap<String,String>();
		Comment comment = adminService.getReply(inquirelink);
		
		map.put("commContent", comment.getCommentContent());
		map.put("userId", comment.getUser().getUserId());
		return map;
	}
	
	@RequestMapping(value="updateInquire/{inquireCode}/{chkCode}/{inquireChkReason}")
	public String upadateInquire(@PathVariable String inquireCode ,@PathVariable String chkCode,@PathVariable String inquireChkReason) {
		System.out.println("upadateInquire -> controller ����");
		System.out.println("���� ���� �ڵ� = "+inquireCode);
		System.out.println("���� ���� üũ�ڵ� = "+chkCode);
		System.out.println("���� ���� ó������ = "+inquireChkReason);
		Inquire inquire = new Inquire();
		inquire.setInquireChkCode(chkCode);
		inquire.setInquireNo(Integer.parseInt(inquireCode));
		
		if(inquireChkReason.equals('0')) {			
			inquire.setInquireChkReason("��� ����");
		}else if(inquireChkReason.equals('1')) {
			inquire.setInquireChkReason("�弳 �� ����");
		}else if(inquireChkReason.equals('2')) {
			inquire.setInquireChkReason("������ǰ���");
		}else if(inquireChkReason.equals('3')) {
			inquire.setInquireChkReason("����� �Խ�");
		}
		
		adminService.updateInquire(inquire);
		return "done";
	}

	@RequestMapping(value="getWriter/{boardNo}")
	public String getWriter(@PathVariable String boardNo) throws Exception {
		System.out.println("upadateInquire -> controller ����");
		
		Board board = boardService.getBoard(Integer.parseInt(boardNo));
		
		
		return board.getUser().getUserId();
	}
	
}
