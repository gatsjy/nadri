package com.nadri.web.user;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.mysql.cj.Session;
import com.nadri.common.Page;
import com.nadri.common.Search;
import com.nadri.service.domain.User;
import com.nadri.service.user.UserService;


@Controller
@RequestMapping("/user/*")
public class UserController {

	//field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;

	
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;

	//constructor method
	public UserController(){
		System.out.println(this.getClass());
	}

	
	//method
	//유저 가입: get방식
	@RequestMapping(value="addUser", method=RequestMethod.GET)
	public String addUser() throws Exception {
		
		System.out.println("/user/addUser : GET");
		
		return "redirect:/user/addUserView.jsp";
	}
	
	//유저 가입: post방식
	@RequestMapping(value="addUser", method=RequestMethod.POST)
	public String addUser( @ModelAttribute("user") User user, MultipartHttpServletRequest request,  @RequestParam("file") MultipartFile[] file ) throws Exception {
		
		System.out.println("/user/addUser : POST");
		System.out.println("useradd - :" +user);
		
		//파일 업로드
		String uploadPath = request.getRealPath("/images/profile");
		
		String fileOriginName = "";
		String fileMultiName = "";
		for(int i=0; i<file.length; i++) {
			fileOriginName = file[i].getOriginalFilename();
			
			if(fileOriginName=="") {
				break;
			}

			SimpleDateFormat formatter = new SimpleDateFormat("yyMMdd_HHmmss_"+(i+1));
			Calendar now = Calendar.getInstance();
			
			//확장자명
			String extension = fileOriginName.split("\\.")[1];
			
			//fileOriginName에 날짜+.+확장자명으로 저장시킴.
			fileOriginName = formatter.format(now.getTime())+"."+extension;
			System.out.println("변경된 파일명 : "+fileOriginName);
			
			File f = new File(uploadPath+"\\"+fileOriginName); 
			file[i].transferTo(f) ;
			

			if(i==0) { fileMultiName += fileOriginName; }
			else{ fileMultiName += ","+fileOriginName; }
		}
			File f = new File("C:/Users/Bit/git/nadri/Nadri/WebContent/chatFiles/" + user.getUserId() ) ;
			boolean result = f.mkdir() ;
			
			if( result ) {
				System.out.println(" 성공 ") ;
			} else {
				System.out.println(" 실패 ") ;
			}
		
		System.out.println("*"+fileMultiName);
		user.setProfileImg(fileMultiName);
			
		userService.addUser(user);
				
		return "redirect:/";
	}
	
	//유저 정보 조회
	@RequestMapping(value="getUser", method=RequestMethod.GET)
	public String getUser(HttpSession session, Model model ) throws Exception {
		System.out.println("/user/getUser : GET");
		User user = (User) session.getAttribute("user");
		if(user != null) {
		String userId = user.getUserId();
		
		//business logic
		user = userService.getUser(userId);
		
		//model과 view 연결		
		model.addAttribute("user", user);
		System.out.println("--------------getUser---------------");
		System.out.println("개인정보조회 : "+user);
		}else {
			return"forward:/";
		}
		return "forward:/user/getUser.jsp";
	}
	
	//유저 정보 수정: get방식
	@RequestMapping(value="updateUser", method= RequestMethod.GET)
	public String updateUser( HttpSession session, Model model, User user) throws Exception{
		System.out.println("/user/updateUser : GET");
		
		//business logic
		user = (User)session.getAttribute("user");
		
		if(user != null) {
		user = userService.getUser(user.getUserId());
		
		//model과 view 연결	
		model.addAttribute("user", user);
		}else {
			return"forward:/";
		}
		
		return "forward:/user/updateUser.jsp";
	}
	
	//유저 정보 수정: post방식
	@RequestMapping(value="updateUser", method= RequestMethod.POST)
	public String updateUser( @ModelAttribute("user") User user, Model model , HttpSession session, HttpServletResponse response, @RequestParam("file") MultipartFile[] file, MultipartHttpServletRequest request ) throws Exception{
		System.out.println("/user/updateUser : POST");
		
		/*user.setProfileImg("");
		if(file != null && !file.isEmpty()){
			user.setProfileImg(file.getOriginalFilename());
		}*/
		System.out.println("--------------------------------------------");
		System.out.println("controller - updateUser:: "+ user);
		System.out.println("--------------------------------------------");
		
		//파일 업로드(수정시)
		String uploadPath = request.getRealPath("/images/profile");
		
		String fileOriginName = "";
		String fileMultiName = "";
		for(int i=0; i<file.length; i++) {
			fileOriginName = file[i].getOriginalFilename();
			
			if(fileOriginName=="") {
				break;
			}
			SimpleDateFormat formatter = new SimpleDateFormat("yyMMdd_HHmmss_"+(i+1));
			Calendar now = Calendar.getInstance();
			
			//확장자명
			String extension = fileOriginName.split("\\.")[1];
			
			//fileOriginName에 날짜+.+확장자명으로 저장시킴.
			fileOriginName = formatter.format(now.getTime())+"."+extension;
			System.out.println("변경된 파일명 : "+fileOriginName);
			
			File f = new File(uploadPath+"\\"+( (User)session.getAttribute("user") ).getUserId()); //file[i].getOriginalFilename());
			file[i].transferTo(f);
			if(i==0) { fileMultiName += fileOriginName; }
			else{ fileMultiName += ","+fileOriginName; }
		}
		System.out.println("*"+fileMultiName);
//		user.setProfileImg(fileMultiName);					//set을 해주면 새로 값이 들어가는 셈 - 업데이트에는 필요없음
		
		if(user.getSex().equals("남성")) {
			user.setSex("0");
		} else {
			user.setSex("1");
		}
		//비즈니스 로직
		userService.updateUser(user);
		user = userService.getUser(user.getUserId());
		
		return "forward:/user/getUser.jsp";
	}

	
	//로그인: get방식
	@RequestMapping(value="login", method=RequestMethod.GET)
	public String login() throws Exception{
		System.out.println("/user/login : GET");

		return "redirect:/";
	}
	
	//로그인: post방식
	@RequestMapping(value="login", method=RequestMethod.POST)
	public String login( @ModelAttribute("user") User user , HttpSession session, HttpServletRequest request ) throws Exception{
		System.out.println("/user/login : POST");
		
		User dbUser=userService.getUser(user.getUserId());
		
		//입력한 회원정보가 없을 때
		if(dbUser==null) {
			System.out.println("해당하는 회원이 없습니다");
			return "redirect:/";
		}
		
		if( user.getPassword().equals(dbUser.getPassword()) ){
			session.setAttribute("user", dbUser);
			
		}
		
		return "redirect:/";
	}
	
	//로그아웃
	@RequestMapping(value="logout", method=RequestMethod.GET)
	public String logout( HttpSession session ) throws Exception{
		System.out.println("/user/logout : GET");
		
		session.invalidate();
		
		return "redirect:/index.jsp";
	}
	
	//유저 아이디 중복 체크
	@RequestMapping(value="checkDuplication", method=RequestMethod.POST)
	public String checkDuplication( @RequestParam("userId") String userId , Model model ) throws Exception{
		System.out.println("/user/checkDuplication : POST");
		//비즈니스 로직
		boolean result=userService.checkDuplication(userId);
		//모델과 뷰 연결
		model.addAttribute("result", new Boolean(result));
		model.addAttribute("userId", userId);

		return "forward:/user/checkDuplication.jsp";
	}
	
	//유저 목록
	@RequestMapping(value="listUser")
	public String listUser( @ModelAttribute("search") Search search, @RequestParam(value="sort", required=false, defaultValue="asc") String sort,
								Model model , HttpServletRequest request, HttpSession session) throws Exception{
		
		System.out.println("/user/listUser : GET / POST");
		User user = (User) session.getAttribute("user");
		if(user != null){
		if(search.getCurrentPage()==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=userService.getUserList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println("listUser :: resultPage :: "+resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("sort", sort);
	}else {
		return "forward:/";
	}
		
		return "forward:/user/listUser.jsp";
	}
	
	//회원탈퇴 화면 소환
	@RequestMapping(value="quitUser", method=RequestMethod.GET)
	public String quitUser(@RequestParam("userId") String userId, Model model) throws Exception{
		
		System.out.println("/user/quitUser:GET");
		
		User user = userService.getUser(userId);
		
		model.addAttribute("user", user);
		
		return "forward:/user/quitUser.jsp";
	}
	
	//회원탈퇴
	@RequestMapping(value="quitUser/{userId}", method=RequestMethod.POST)
	public String quitUser(@PathVariable String userId, HttpSession session) throws Exception{
		
		System.out.println("/user/quitUser : POST");
		
		userService.quitUser(userId);
		session.invalidate();
		
		return "redirect:/index.jsp";
	}

	//아이디 찾기 화면 소환
	@RequestMapping(value="findUser", method=RequestMethod.GET)
	public String findUser() throws Exception{
		
		System.out.println("/user/findUser: GET");
		
		return "forward:/user/findUser.jsp";
	}
	
	//비밀번호 찾기 화면 소환
	@RequestMapping(value="findPassword", method=RequestMethod.GET)
	public String findPassword() throws Exception{
		
		System.out.println("/user/findPassword: GET");
		
		return "forward:/user/findPassword.jsp";
	}
	

	//sns 로그인
	@RequestMapping(value="snsLogin/{userId}")
	public String snsLogin( @PathVariable String userId, HttpSession session ) throws Exception{
		System.out.println("/user/snsLogin : GET / POST");
		
		User dbUser = userService.getUser(userId);
		
		session.setAttribute("user", dbUser);
		
		return "forward:/index.jsp";
	}
	
	
	
}

