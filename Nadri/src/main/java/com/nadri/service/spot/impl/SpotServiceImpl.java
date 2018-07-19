package com.nadri.service.spot.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.nadri.common.Search;
import com.nadri.service.domain.Spot;
import com.nadri.service.spot.SpotDao;
import com.nadri.service.spot.SpotService;

@Service("spotServiceImpl")
public class SpotServiceImpl implements SpotService{

	///Field
	@Autowired
	@Qualifier("spotDaoImpl")
	
	///Constructor
	private SpotDao spotDao;
	
	///Method
	public void setmapDao(SpotDao spotDao) {
		this.spotDao=spotDao;
	}
	
	///Constructor
	public SpotServiceImpl() {
		System.out.println(this.getClass());
	}
	
	// 1. ��� ��ü�� �����ִ� �޼ҵ�
	@Override
	public List<Spot> getSpotList(int spotCode) throws Exception {
		return spotDao.getSpotList(spotCode);
	}
	
	// 2. �Ѱ�����Ʈ�� �����ִ� �޼ҵ�
	@Override
	public List<Spot> getRiverList(int spotCode) throws Exception {
		return spotDao.getRiverList(spotCode);
	}

	// 3. ���� ����Ʈ�� �����ִ� �޼ҵ�
	@Override
	public List<Spot> getRestaurantList(int spotCode) throws Exception {
		return spotDao.getRestaurantList(spotCode);
	}
	
	// 4. ��ũ���� �������� ���� ��ũ���� ����� �ִ� �޼ҵ�
	@Override
	public List<Spot> infiniteScrollDown(int bnoToStart) throws Exception {
		return spotDao.infiniteScrollDown(bnoToStart);
	}
	
	// 5. ��� �󼼺��⸦ �����ִ� �޼ҵ�
	@Override
	   public Spot getSpot(int spotNo) throws Exception {
	      return spotDao.getSpot(spotNo);
	 }
	
	// 6. �ֺ� ��� ������ �������� �޼ҵ�
	@Override
	public List<Spot> searchAround(Spot spot) throws Exception {
		return spotDao.searchAround(spot);
	}
	
	/////////////////////////////////////////////////////////�������� �߰�!!(20180712)/////////////////////////////////////////////////////////////////
	@Override
	   public List<Spot> getSpotList() throws Exception {
	      // TODO Auto-generated method stub
	      return spotDao.getSpotList();
	   }

	   @Override
	   public void deleteSpot(String spotNo) {
	      // TODO Auto-generated method stub
	      spotDao.deleteSpot(spotNo);
	   }

	   @Override
	   public void addSpot(Spot spot) {
	      // TODO Auto-generated method stub
	      spotDao.addSpot(spot);
	   }
	   /////////////////////////////////////////////////////////�������� �߰�!!(20180712)/////////////////////////////////////////////////////////////////

	// 7. �Խ����� Ŭ�������� ��ȸ���� 1�� ����
	@Override
	public void updateSpotReadCnt(Spot spot) throws Exception {
		spotDao.updateSpotReadCnt(spot);
	}
}
