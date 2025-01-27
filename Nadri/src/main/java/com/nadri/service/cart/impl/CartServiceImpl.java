package com.nadri.service.cart.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.nadri.common.Search;
import com.nadri.service.cart.CartDao;
import com.nadri.service.cart.CartService;
import com.nadri.service.domain.Cart;
import com.nadri.service.domain.Spot;

@Service("cartServiceImpl")
public class CartServiceImpl implements CartService{
	
	///Field
	@Autowired
	@Qualifier("cartDaoImpl")
	
	private CartDao cartDao;
	
	///Method
	public void setCartDao(CartDao cartDao) {
		this.cartDao=cartDao;
	}
	
	///Constructor
	public CartServiceImpl() {
		System.out.println(this.getClass());
	}
	
	// 1. cart에 장소를 등록하는 메서드
	@Override
	public void addCartSpot(Cart cart) throws Exception {
		cartDao.addCartSpot(cart);
	}
	
	// 2. spot Cart를 가져오는 메서드
	@Override
	public List<Cart> getSpotCartList(String userId) throws Exception {
		return cartDao.getSpotCartList(userId);
	}

	@Override
	public void deleteCart(int cartNo) throws Exception {
		cartDao.deleteCart(cartNo);
	}

	@Override
	public void updateCart(Cart cart) throws Exception {
		cartDao.updateCart(cart);
	}

	@Override
	public Cart getCart(int cartNo) throws Exception {
		return cartDao.getCart(cartNo);
	}

}
