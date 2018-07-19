package com.nadri.web.schedule;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.nadri.service.domain.Schedule;
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

	public ScheduleController(){
		System.out.println(this.getClass());
	}
	
	// addSchedule�� �����ϱ� ���� GET �޼��� �Դϴ�.
	@RequestMapping( value="addSchedule", method=RequestMethod.GET)
	public String addSchedule(Model model) throws Exception{
		
		System.out.println( "/addSchedule : GET");
		
		return "forward:/schedule/addSchedule.jsp";
	}
	
	// addSchedule�� �����ϱ� ���� POST �޼��� �Դϴ�.
	@RequestMapping( value="addSchedule",  method=RequestMethod.POST)
	public String addSchedule(Model model , @ModelAttribute WayPoint waypoint , @ModelAttribute Schedule schedule) throws Exception{
		
		System.out.println( "/addSchedule : POST");
		
		// ���� ����ϴ� �κ�
		scheduleService.addSchedule(schedule);
		
		// ������ ����ϴ� �κ�
		for(int i = 0; i < schedule.getWayPoints().size() ; i++) {
			System.out.println("���۵Ǵ��� ��ȣ :"+i);
			schedule.getWayPoints().get(i).setWayPointNo(i);
			scheduleService.addWayPoint(schedule.getWayPoints().get(i));
			scheduleService.updateHashTag(schedule.getWayPoints().get(i).getWayPointTitle());
		}
		return null;
	}
	
	// addSchedule�� �����ϱ� ���� POST �޼��� �Դϴ�.
	@RequestMapping( value="getSchedule",  method=RequestMethod.GET)
	public String addSchedule(@RequestParam("scheduleNo") int scheduleNo, Model model) throws Exception{
		
		System.out.println( "/getSchedule");

		// Model �� View ����
		model.addAttribute("schedule", scheduleService.getSchedule(scheduleNo));
		model.addAttribute("waypoint", scheduleService.getWayPoint(scheduleNo));
		
		return "forward:/schedule/getSchedule.jsp";
	}
	
}