package com.nadri.service.schedule.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.nadri.common.Search;
import com.nadri.service.domain.Schedule;
import com.nadri.service.domain.WayPoint;
import com.nadri.service.schedule.ScheduleDao;

@Repository("scheduleDaoImpl")
public class ScheduleDaoImpl implements ScheduleDao{
	
	///Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	///Constructor
	public ScheduleDaoImpl() {
		System.out.println(this.getClass());
	}
	
	// 1. ������ �߰��ϱ� ���� �޼���
	@Override
	public void addSchedule(Schedule schedule) throws Exception {
		sqlSession.insert("ScheduleMapper.addSchedule", schedule);
	}
	
	// 2. �������� �߰��ϱ� ���� �޼���
	@Override
	public void addWayPoint(WayPoint waypoint) throws Exception {
		sqlSession.insert("ScheduleMapper.addWayPoint", waypoint);
	}
	
	// 3. �����󼼺��⸦ ���� �޼���
	@Override
	public Schedule getSchedule(int scheduleNo) throws Exception {
		return sqlSession.selectOne("ScheduleMapper.getSchedule", scheduleNo);
	}
	
	// 4. �����󼼺��⸦ ���� �޼���(������)
	public List<WayPoint> getWayPoint(int scheduleNo) throws Exception {
		return sqlSession.selectList("ScheduleMapper.getWayPoint", scheduleNo);
	}
	
	// 5. ���������� ������ �ؽ��±׸� �߰����ֱ� ���� �޼���
	public void updateHashTag(String waypointTitle) throws Exception {
		sqlSession.update("ScheduleMapper.updateHashTag", waypointTitle);
	}
	
	// 6. ���������� �� ������ ���� ���� �޼���
   @Override
   public Map<String,Object> getMyScheduleList(Search search) throws Exception{
	   Map<String,Object> map = new HashMap<String,Object>();
	   List<Schedule> list = sqlSession.selectList("ScheduleMapper.getMyScheduleList", search);
	   int count = sqlSession.selectOne("ScheduleMapper.getTotalCount", search);
	   map.put("list", list);
	   map.put("totalCount", count);
	   return map;
   }

   // 7. �Խ��ǿ��� �������� ������ �� ���� �� �޼���
   @Override
   public int checkSchedule(String scheduleImg, String userId) throws Exception {
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("scheduleImg", scheduleImg);
      map.put("userId", userId);
      
      return sqlSession.selectOne("ScheduleMapper.checkSchedule", map);
   }
   
   // 8. ���� �����ϱ� ���� �޼���
   @Override
   public void copySchedule(Schedule schedule) throws Exception {
      sqlSession.insert("ScheduleMapper.copySchedule", schedule);
   }

   // 9. ������ �����ϴ� �޼���
   @Override
   public void deleteSchedule(int scheduleNo) throws Exception {
      System.out.println("-----��������");
      sqlSession.delete("ScheduleMapper.deleteSchedule", scheduleNo);
      System.out.println("-----�ۻ���");
      sqlSession.delete("BoardMapper.deleteBoardSchedule", scheduleNo);
      System.out.println("-----��");
   }
   
   // 10. ������ review�� ������Ʈ �մϴ�.
   public void updateScheduleReview(Schedule schedule) throws Exception {
	   sqlSession.update("ScheduleMapper.updateScheduleReview", schedule);
   }
	
}
