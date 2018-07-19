package com.nadri.service.schedule.impl;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

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
	
}
