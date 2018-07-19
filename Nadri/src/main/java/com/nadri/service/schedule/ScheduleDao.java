package com.nadri.service.schedule;

import java.util.List;

import com.nadri.service.domain.Schedule;
import com.nadri.service.domain.WayPoint;

public interface ScheduleDao {
	
	// 1. ������ �߰��ϱ� ���� �޼���
	public void addSchedule(Schedule schedule) throws Exception; 
	
	// 2. �������� �߰��ϱ� ���� �޼���
	public void addWayPoint(WayPoint waypoint) throws Exception;
	
	// 3. �����󼼺��⸦ ���� �޼���(����)
	public Schedule getSchedule(int scheduleNo) throws Exception;
	
	// 4. �����󼼺��⸦ ���� �޼���(������)
	public List<WayPoint> getWayPoint(int scheduleNo) throws Exception;
	
	// 5. ���������� ������ �ؽ��±׸� �߰����ֱ� ���� �޼���
	public void updateHashTag(String waypointTitle) throws Exception;

}
