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
	
	/////////////////////////////////////////////////////////�������� �߰�!!(20180712)/////////////////////////////////////////////////////////////////
	// 3. ��һ��� (admin only)
	public void deleteSpot(String spotNo);
	
	// 0. �ڵ���� ��ü ��� ��ȸ(admin only)
	public List<Spot> getSpotList() throws Exception;
	
	// 4. ����߰� (admin only)
	public void addSpot(Spot spot);
	/////////////////////////////////////////////////////////�������� �߰�!!(20180712)/////////////////////////////////////////////////////////////////
	
	// 7. �Խ����� Ŭ�������� ��ȸ���� 1�� ����
	public void updateSpotReadCnt(Spot spot) throws Exception;
}
