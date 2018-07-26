package com.nadri.web.cart;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.nadri.service.cart.CartService;
import com.nadri.service.domain.Cart;

//==> ��ٱ��� RestController
@RestController
@RequestMapping("/restcart/*")
public class CartRestController{

	///Field
	@Autowired
	@Qualifier("cartServiceImpl")
	private CartService cartService;
	
	public CartRestController(){
		System.out.println(this.getClass());
	}
	
	// addCartSpot�� �����ϱ� ���� POST �޼��� �Դϴ�.
	@RequestMapping(value="addCartSpot", method=RequestMethod.POST)
	public void addCartSpot( @RequestBody Cart cart ) throws Exception{		
		System.out.println("/restcart/addCartSpot : POST");

		System.out.println("cart : " + cart);
		
		//Business Logic
		cartService.addCartSpot(cart);
	}
	
	@RequestMapping(value="updateCart", method=RequestMethod.POST)
	public void updateCart( @RequestBody Cart cart ) throws Exception{
		System.out.println("/restcart/updateCart : POST");
		
		
	}
	
	@RequestMapping(value="deleteCart/{cartNo}", method=RequestMethod.POST)
	public void deleteCart( @PathVariable String cartNo ) throws Exception{
		System.out.println("/restcart/deleteCart : POST");
		
	}
}








