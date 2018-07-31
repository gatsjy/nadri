package com.nadri.web.schedule;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.nadri.common.Page;
import com.nadri.common.Search;
import com.nadri.service.cart.CartService;
import com.nadri.service.domain.Schedule;
import com.nadri.service.domain.User;
import com.nadri.service.domain.WayPoint;
import com.nadri.service.schedule.ScheduleService;

//==> ������ ���õ� �޼��� Controller
@Controller
@RequestMapping("/schedule/*")
public class ScheduleController {
		
	///Field
	@Autowired
	@Qualifier("scheduleServiceImpl")
	private ScheduleService scheduleService;
	
	@Autowired
	@Qualifier("cartServiceImpl")
	private CartService cartService;

	public ScheduleController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	int pageSize = 6;
	
	
	// addSchedule�� �����ϱ� ���� GET �޼��� �Դϴ�.
	@RequestMapping( value="addSchedule", method=RequestMethod.GET)
	public String addSchedule(Model model, HttpSession session, @ModelAttribute("user") User user,
										@ModelAttribute("search") Search search, @Param("date") Date date) throws Exception{
		
		System.out.println( "/addSchedule : GET");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		
		// ���ǿ��� userId �� �����ɴϴ�!
		String userId=((User) session.getAttribute("user")).getUserId();
		
		// model�� ����ϴ�!
		model.addAttribute("cart", cartService.getSpotCartList(userId));
		model.addAttribute("date", date);
		
		return "forward:/schedule/addSchedule.jsp";
	}
	
	// addSchedule�� �����ϱ� ���� POST �޼��� �Դϴ�.
	@RequestMapping( value="addSchedule",  method=RequestMethod.POST)
	public String addSchedule(Model model , @ModelAttribute WayPoint waypoint , @ModelAttribute Schedule schedule, @RequestParam("file") MultipartFile multipartFile, HttpSession session) throws Exception{
		
		System.out.println( "/addSchedule : POST");
		
		// ���ϸ� ���
		String fileName = multipartFile.getOriginalFilename();
		
		// ���� ��ü ����
		File file = new File("C:\\Users\\Bit\\git\\nadri\\Nadri\\WebContent\\images\\spot\\uploadFiles\\"+fileName);
		
		multipartFile.transferTo(file);
		
		//Business Logic
		schedule.setScheduleImg(fileName);
		
		// ���� ����ϴ� �κ�
		scheduleService.addSchedule(schedule);
		
		
		// ������ ����ϴ� �κ�
		for(int i = 0; i < schedule.getWayPoints().size() ; i++) {
			System.out.println("���۵Ǵ��� ��ȣ :"+i);
			schedule.getWayPoints().get(i).setWayPointNo(i);
			scheduleService.addWayPoint(schedule.getWayPoints().get(i));
			scheduleService.updateHashTag(schedule.getWayPoints().get(i).getWayPointTitle());
		}
		return "forward:/index.jsp";
	}
	
	// getSchedule�� �����ϱ� ���� GET �޼��� �Դϴ�.
	@RequestMapping( value="getSchedule",  method=RequestMethod.GET)
	public String getSchedule(@RequestParam("scheduleNo") int scheduleNo, Model model) throws Exception{
		
		System.out.println( "/getSchedule");

		// Model �� View ����
		model.addAttribute("schedule", scheduleService.getSchedule(scheduleNo));
		model.addAttribute("waypoint", scheduleService.getWayPoint(scheduleNo));
		
		return "forward:/schedule/getSchedule.jsp";
	}
	
	//���������� �� ������ ���� ���� �޼��� �Դϴ�.
   @RequestMapping(value="getMyScheduleList")
   public String getMyScheduleList(Model model, HttpSession session, @ModelAttribute("search") Search search) throws Exception{
      System.out.println("/schedule/getMyScheduleList : GET / POST");
      
      User user = (User)session.getAttribute("user");
        	
      if(user==null) { //������ ������ ���
         return "redirect:/";
      }
     
        //�������׺���̼� ���ִ� logic..
	  	if(search.getCurruntPage() <= 1 ){
			search.setCurruntPage(0);
			search.setStartRowNum(0);
		}else {
			search.setStartRowNum((search.getCurruntPage()-1)*pageSize);
		}
		search.setPageSize(pageSize);
	     
		search.setUserId(user.getUserId());

	    // Business logic ����
	    Map<String, Object> map = scheduleService.getMyScheduleList(search);
	      
		Page resultPage = new Page( search.getCurruntPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, 6);
		System.out.println(resultPage);

		// Model �� View ����
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		
		List<Schedule> list = (List<Schedule>)map.get("list");
		
		JSONArray jsonArray = new JSONArray();
		for(Schedule schedule : list) {
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("id", Integer.toString(schedule.getScheduleNo()));
			jsonObject.put("title", schedule.getScheduleTitle());
			jsonObject.put("start", new SimpleDateFormat("yyyy-MM-dd").format(schedule.getScheduleDate())+"T"+schedule.getStartHour());
			jsonObject.put("className", "generalDay");
			jsonArray.add(jsonObject);
		}
		
		//������ �ݺ�
		for(int i=1; i<=12; i++) {
			String apiURL = "";
			if(i<10) {
				apiURL = "http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getHoliDeInfo?ServiceKey=moTkip2aUv1fT8FhacDtyaJcKXWF000hyP1Iotjf%2FNyc3p%2FUTMNo8UFbsJgx0Uf4yunT7BDDSpf3d5pamt%2Fqvg%3D%3D&solYear=2018&solMonth=0"+i+"&_type=json";
			}else {
				apiURL = "http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getHoliDeInfo?ServiceKey=moTkip2aUv1fT8FhacDtyaJcKXWF000hyP1Iotjf%2FNyc3p%2FUTMNo8UFbsJgx0Uf4yunT7BDDSpf3d5pamt%2Fqvg%3D%3D&solYear=2018&solMonth="+i+"&_type=json";
			}
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("GET");
	        int responseCode = con.getResponseCode();
	        BufferedReader br;
	        if(responseCode==200) { //����ȣ��
	        	br = new BufferedReader(new InputStreamReader(con.getInputStream() , "UTF-8"));
	        } else { //�����߻�
	        	br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	        }
	        String inputLine;
	        StringBuffer response = new StringBuffer();
	        while ((inputLine = br.readLine()) != null)  {
	        	response.append(inputLine);
	        }
	        JSONParser parser = new JSONParser();
	        JSONObject holiday = (JSONObject)parser.parse(response.toString()); //������ json ��
	        //String holidayString = (((JSONObject)((JSONObject)holiday.get("response")).get("body")).get("items")).toString(); //���ϴ� ���� �Ľ��Ͽ� String���� ��ȯ
	        //JSONObject jsonObj = (JSONObject)parser.parse(holidayString); //
	        //JSONArray holidayArray = (JSONArray)jsonObj.get("item");
	        Long chkHolidayCnt = (Long)((JSONObject)((JSONObject)holiday.get("response")).get("body")).get("totalCount");
	        if(chkHolidayCnt==0) {
	        	System.out.println("==���³�����~");
	        	continue;
	        }
	        
	        JSONObject chkHoliday = (JSONObject)((JSONObject)((JSONObject)holiday.get("response")).get("body")).get("items");
	        System.out.println("**"+chkHoliday);
	        
	        if( chkHolidayCnt==1 ) {
		        JSONObject aloneHoliday = (JSONObject) chkHoliday.get("item");
	        	JSONObject jsonObject3 = new JSONObject();
	    		jsonObject3.put("id", "0");
	    		jsonObject3.put("title", aloneHoliday.get("dateName"));
	    		String tempDate = aloneHoliday.get("locdate").toString();
	    		tempDate = tempDate.substring(0, 4)+"-"+tempDate.substring(4, 6)+"-"+tempDate.substring(6);
	    		jsonObject3.put("start", tempDate);
	    		jsonObject3.put("className", "specialDay");
	    		jsonObject3.put("allDay", true);
				jsonArray.add(jsonObject3);
	        }else {
	        	JSONArray holidayArray = (JSONArray)(chkHoliday.get("item")); //���ϴ� ���� �Ľ��ؼ� array�� ����

		        for(int j=0 ; j<holidayArray.size() ; j++){
		            JSONObject tempObj = (JSONObject) holidayArray.get(j);
		    		JSONObject jsonObject3 = new JSONObject();
		    		jsonObject3.put("id", "0");
		    		jsonObject3.put("title", tempObj.get("dateName"));
		    		String tempDate = tempObj.get("locdate").toString();
		    		tempDate = tempDate.substring(0, 4)+"-"+tempDate.substring(4, 6)+"-"+tempDate.substring(6);
		    		jsonObject3.put("start", tempDate);
		    		jsonObject3.put("className", "specialDay");
		    		jsonObject3.put("allDay", true);
					jsonArray.add(jsonObject3);
		        }
	        }
		} //�� �ݺ� ��
		
        System.out.println("===============");
        System.out.println(jsonArray.toString());
		model.addAttribute("events_array", jsonArray.toString());
				
      return "forward:/user/mypageScheduleList.jsp";
   }
   
   // updateSchedule�� �����ϱ� ���� GET �޼��� �Դϴ�.
	@RequestMapping( value="updateSchedule",  method=RequestMethod.GET)
	public String updateSchedule(@RequestParam("scheduleNo") int scheduleNo, Model model) throws Exception{
		
		System.out.println( "/updateSchedule : GET");

		// Model �� View ����
		model.addAttribute("schedule", scheduleService.getSchedule(scheduleNo));
		model.addAttribute("waypoint", scheduleService.getWayPoint(scheduleNo));
		
		return "forward:/schedule/updateSchedule.jsp";
	}
	
	// updateSchedule�� �����ϱ� ���� GET �޼��� �Դϴ�.
	@RequestMapping( value="updateSchedule",  method=RequestMethod.POST)
	public String updateSchedule(Model model , @ModelAttribute WayPoint waypoint , @ModelAttribute Schedule schedule, @RequestParam("file") MultipartFile multipartFile, HttpSession session) throws Exception{
		
		System.out.println( "/updateSchedule : POST");
		
		// ���ϸ� ���
		String fileName = multipartFile.getOriginalFilename();
		
		// ���� ��ü ����
		File file = new File("C:\\Users\\Bitcamp\\git\\nadri\\Nadri\\WebContent\\images\\spot\\uploadFiles\\"+fileName);
		
		multipartFile.transferTo(file);
		
		//Business Logic
		schedule.setScheduleImg(fileName);
		
		// ���� ����ϴ� �κ�
		scheduleService.addSchedule(schedule); //������Ʈ schedule�̵��ϴ�.
		
		
		// ������ ����ϴ� �κ�
		for(int i = 0; i < schedule.getWayPoints().size() ; i++) {
			System.out.println("���۵Ǵ��� ��ȣ :"+i);
			scheduleService.addWayPoint(schedule.getWayPoints().get(i)); // ������Ʈ waypoint�� �ٲߴϴ�.
			scheduleService.updateHashTag(schedule.getWayPoints().get(i).getWayPointTitle());
		}
		return "forward:/index.jsp";
	}
}