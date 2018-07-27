package com.nadri.service.schedule.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.nadri.service.domain.Schedule;
import com.nadri.service.domain.WayPoint;
import com.nadri.service.schedule.ScheduleDao;
import com.nadri.service.schedule.ScheduleService;

@Service("scheduleServiceImpl")
public class ScheduleServiceImpl implements ScheduleService{

	///Field
	@Autowired
	@Qualifier("scheduleDaoImpl")
	
	///Constructor
	private ScheduleDao scheduleDao;
	
	///Method
	public void setScheduleDao(ScheduleDao scheduleDao) {
		this.scheduleDao=scheduleDao;
	}
	
	///Constructor
	public ScheduleServiceImpl() {
		System.out.println(this.getClass());
	}
	
	// 1. ������ �߰��ϱ� ���� �޼���
	@Override
	public void addSchedule(Schedule schedule) throws Exception {
		scheduleDao.addSchedule(schedule);
	}
	
	// 2. �������� �߰��ϱ� ���� �޼���
	@Override
	public void addWayPoint(WayPoint waypoint) throws Exception {
		scheduleDao.addWayPoint(waypoint);
	}

	// 3. �����󼼺��⸦ ���� �޼���
	@Override
	public Schedule getSchedule(int scheduleNo) throws Exception {
		return scheduleDao.getSchedule(scheduleNo);
	}
	
	// 4. �����󼼺��⸦ ���� �޼���(������)
	@Override
	public List<WayPoint> getWayPoint(int scheduleNo) throws Exception {
		return scheduleDao.getWayPoint(scheduleNo);
	}
	
	// 5. ���������� ������ �ؽ��±׸� �߰����ֱ� ���� �޼���
	@Override
	public void updateHashTag(String waypointTitle) throws Exception {
		scheduleDao.updateHashTag(waypointTitle);
	}
	
	// 6. ���������� �� ������ ���� ���� �޼���
   @Override
   public List<Schedule> getMyScheduleList(String userId) throws Exception {
      return scheduleDao.getMyScheduleList(userId);
   }

   // 7. �Խ��ǿ��� �������� ������ �� ���� �� �޼���
   @Override
   public int checkSchedule(String scheduleImg, String userId) throws Exception {
      return scheduleDao.checkSchedule(scheduleImg, userId);
   }
   
   // 8. ���� �����ϱ� ���� �޼���
   @Override
   public void copySchedule(Schedule schedule) throws Exception{
      scheduleDao.copySchedule(schedule);
   }

   // 9. ������ �����ϴ� �޼���
   @Override
   public void deleteSchedule(int scheduleNo) throws Exception {
      scheduleDao.deleteSchedule(scheduleNo);
   }

}
