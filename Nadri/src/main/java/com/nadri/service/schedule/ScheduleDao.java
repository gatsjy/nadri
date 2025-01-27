package com.nadri.service.schedule;

import java.util.List;
import java.util.Map;

import com.nadri.common.Search;
import com.nadri.service.domain.Schedule;
import com.nadri.service.domain.WayPoint;

public interface ScheduleDao {
	
	// 1. 일정을 추가하기 위한 메서드
	public void addSchedule(Schedule schedule) throws Exception; 
	
	// 2. 경유지를 추가하기 위한 메서드
	public void addWayPoint(WayPoint waypoint) throws Exception;
	
	// 3. 일정상세보기를 위한 메서드(일정)
	public Schedule getSchedule(int scheduleNo) throws Exception;
	
	// 4. 일정상세보기를 위한 메서드(경유지)
	public List<WayPoint> getWayPoint(int scheduleNo) throws Exception;
	
	// 5. 일정생성후 일정에 해쉬태그를 추가해주기 위한 메서드
	public void updateHashTag(String waypointTitle) throws Exception;
	
   // 6. 마이페이지 내 일정을 보기 위한 메서드
   public Map<String,Object> getMyScheduleList(Search search) throws Exception;

   // 7. 게시판에서 일정복사 눌렀을 때 실행 할 메서드
   public int checkSchedule(String scheduleImg, String userId) throws Exception;
   
   // 8. 일정 복사하기 위한 메서드
   public void copySchedule(Schedule schedule) throws Exception;

   // 9. 일정을 삭제하는 메서드
   public void deleteSchedule(int scheduleNo) throws Exception;
   
   // 10. 일정의 review를 업데이트 합니다.
   public void updateScheduleReview(Schedule schedule) throws Exception;
   
   // 11. 안드로이드로 일정을 뿌려줍니다.
   public List<Schedule> getMyScheduleListRest(String userId) throws Exception;
   
   // 12. 가장 최근 데이터를 가져옵니다.
   public int maxScheduleNo() throws Exception;
}
