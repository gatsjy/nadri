package com.nadri.service.cart;

import java.util.List;

import com.nadri.common.Search;
import com.nadri.service.domain.Cart;

public interface CartDao {
	
	// 1. cart�� ��Ҹ� ����ϴ� �޼���
	public void addCartSpot(Cart cart) throws Exception; 
	
	// 2. spot Cart�� �������� �޼���
	public List<Cart> getSpotCartList(String userId) throws Exception;

}
