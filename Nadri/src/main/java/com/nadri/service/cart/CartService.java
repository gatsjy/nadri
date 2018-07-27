package com.nadri.service.cart;

import java.util.List;

import com.nadri.common.Search;
import com.nadri.service.domain.Cart;

public interface CartService {
	
	// 1. cart�� ��Ҹ� ����ϴ� �޼���
	public void addCartSpot(Cart cart) throws Exception; 
	
	// 2. spot Cart�� �������� �޼���
	public List<Cart> getSpotCartList(String userId) throws Exception;

	public void deleteCart(int cartNo) throws Exception;

	public void updateCart(Cart cart) throws Exception;

	public Cart getCart(int cartNo) throws Exception;

}
