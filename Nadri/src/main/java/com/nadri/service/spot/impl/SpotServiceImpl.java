package com.nadri.service.spot.impl;

import java.util.List;
import java.util.Map;

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

	private SpotDao spotDao;
	
	///Method
	public void setSpotDao(SpotDao spotDao) {
		this.spotDao=spotDao;
	}
	
	///Constructor
	public SpotServiceImpl() {
		System.out.println(this.getClass());
	}
	
	// 1. 장소 10개를 보여주는 메소드
	@Override
	public List<Spot> getSpotList(int spotCode) throws Exception {
		return spotDao.getSpotList(spotCode);
	}
	
	// 1-1. 장소를 보여주는 메소드 
	public List<Spot> getRiverList(int spotCode) throws Exception {
		return spotDao.getRiverList(spotCode);
	}
		
	
	// 2. 장소 전체 보여주는 메소드
	@Override
	public List<Spot> getAllSpotList(int spotCode) throws Exception {
		return spotDao.getAllSpotList(spotCode);
	}

	// 3 스크롤을 내렸을때 무한 스크롤을 만들어 주는 메소드
	@Override
	public List<Spot> infiniteScrollDown(Spot spot) throws Exception {
		return spotDao.infiniteScrollDown(spot);
	}
	
	// 4. 장소 상세보기를 보여주는 메소드
	@Override
	   public Spot getSpot(int spotNo) throws Exception {
	      return spotDao.getSpot(spotNo);
	 }
	
	// 5. 주변 장소 정보를 가져오는 메소드
	@Override
	public List<Spot> searchAround(Spot spot) throws Exception {
		return spotDao.searchAround(spot);
	}
	
	// 5-1. 주변 식당 정보를 가져오는 메소드
	@Override
	public List<Spot> searchAroundRestaurant(Spot spot) throws Exception {
		return spotDao.searchAroundRestaurant(spot);
	}
	
	// 5-2. 주변 정보를 가져오는 안드로이드 메소드
	public List<Spot> searchAroundRest(Spot spot) throws Exception{
		return spotDao.searchAroundRest(spot);
	}
	
	/////////////////////////////////////////////////////////예지누나 추가!!(20180712)/////////////////////////////////////////////////////////////////
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
	   /////////////////////////////////////////////////////////예지누나 추가!!(20180712)/////////////////////////////////////////////////////////////////

	// 6. 게시판을 클릭했을때 조회수가 1씩 증가
	@Override
	public void updateSpotReadCnt(Spot spot) throws Exception {
		spotDao.updateSpotReadCnt(spot);
	}
	
	// 8. 검색한 장소를 가져옵니다.
	public List<Spot> getSearchSpotList(Search search) throws Exception {
		return spotDao.getSearchSpotList(search);
	}
	
	// 3. getRecommandSpotList 가져오는 메서드
	@Override
	public List<Spot> getRecommandSpotList(Map<String, Object> keyword) throws Exception {
		return spotDao.getRecommandSpotList(keyword);
	}
	
	// 10. 안드로이드에서 getSpot
	public List<Spot> getSpotListRest(Search search) throws Exception {
		return spotDao.getSpotListRest(search);
	}
	
}
