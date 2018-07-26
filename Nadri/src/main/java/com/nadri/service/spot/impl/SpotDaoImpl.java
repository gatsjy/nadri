package com.nadri.service.spot.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.nadri.common.Search;
import com.nadri.service.domain.Spot;
import com.nadri.service.spot.SpotDao;

@Repository("spotDaoImpl")
public class SpotDaoImpl implements SpotDao{
	
	///Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	///Constructor
	public SpotDaoImpl() {
		System.out.println(this.getClass());
	}

	/// 1. ��Ҹ���Ʈ�� �ҷ����� �޼ҵ�(10����)
	@Override
	public List<Spot> getSpotList(int spotCode) throws Exception {
		return sqlSession.selectList("SpotMapper.getSpotList", spotCode);
	}
	
	// 2. ��Ҹ���Ʈ�� �����ִ� �޼ҵ�(��ü)
	@Override
	public List<Spot> getAllSpotList(int spotCode) throws Exception {
		return sqlSession.selectList("SpotMapper.getAllSpotList",spotCode);
	}
	
	// 3. ��ũ���� �������� ���� ��ũ���� ����� �ִ� �޼ҵ�
	@Override
	public List<Spot> infiniteScrollDown(Spot spot) throws Exception {
		return sqlSession.selectList("SpotMapper.infiniteScrollDown", spot);
	}	
	
	// 4. ��� �󼼺��⸦ �����ִ� �޼ҵ�
	@Override
	public Spot getSpot(int spotNo) throws Exception {
	      return sqlSession.selectOne("SpotMapper.getSpot", spotNo);
	   }
	
	// 5. �ֺ� ��� ������ �������� �޼ҵ�
	@Override
	public List<Spot> searchAround(Spot spot) throws Exception {
		return sqlSession.selectList("SpotMapper.searchAround", spot);
	}
	
	/////////////////////////////////////////////////////////�������� �߰�!!(20180712)/////////////////////////////////////////////////////////////////
	@Override
	   public List<Spot> getSpotList() throws Exception {
	      // TODO Auto-generated method stub
	      return sqlSession.selectList("SpotMapper.listSpot");
	   }

	   @Override
	   public void deleteSpot(String spotNo) {
	      // TODO Auto-generated method stub
	      sqlSession.delete("SpotMapper.deleteSpot", Integer.parseInt(spotNo));
	   }

	   @Override
	   public void addSpot(Spot spot) {
	      // TODO Auto-generated method stub
	      sqlSession.insert("SpotMapper.addSpot", spot);
	   }
	   /////////////////////////////////////////////////////////�������� �߰�!!(20180712)/////////////////////////////////////////////////////////////////
	  
	// 6. �Խ����� Ŭ�������� ��ȸ���� 1�� ����
	@Override
	public void updateSpotReadCnt(Spot spot) throws Exception {
		sqlSession.update("SpotMapper.updateSpotReadCnt", spot);
	}
	
	// 7. ��ü ����� ������ �����ɴϴ�.
	public int getTotalSpot() throws Exception {
		return sqlSession.selectOne("SpotMapper.getTotalSpot");
	}
	
	// 8. �˻��� ��Ҹ� �����ɴϴ�.
	public List<Spot> getSearchSpotList(Search search) throws Exception {
		return sqlSession.selectList("SpotMapper.getSearchSpotList", search);
	}
	
}