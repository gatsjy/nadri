package com.nadri.service.spot;

import java.util.List;
import java.util.Map;

import com.nadri.common.Search;
import com.nadri.service.domain.Spot;

public interface SpotService {
	
	// 1. ��� ��ü�� �����ִ� �޼ҵ�
	public List<Spot> getSpotList(int spotCode) throws Exception;
	
	// 2. �Ѱ�����Ʈ�� �����ִ� �޼ҵ�
	public List<Spot> getRiverList(int spotCode) throws Exception;
	
	// 3. ���� ����Ʈ ��ü �����ִ� �޼ҵ�
	public List<Spot> getRestaurantList(int spotCode) throws Exception;
	
	// 4. ��ũ���� �������� ���� ��ũ���� ����� �ִ� �޼ҵ�
	public List<Spot> infiniteScrollDown(int bnoToStart) throws Exception;
	
	// 5. ��� �󼼺��⸦ �����ִ� �޼ҵ�
	public Spot getSpot(int spotNo) throws Exception;
	
	// 6. �ֺ� ��� ������ �������� �޼ҵ�
	public List<Spot> searchAround(Spot spot) throws Exception;
}
