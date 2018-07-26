package com.nadri.web.cart;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.nadri.service.cart.CartService;
import com.nadri.service.domain.Cart;
import com.nadri.service.domain.Spot;
import com.nadri.service.domain.User;

@Controller
@RequestMapping("/cart/*")
public class CartController {

	///Field
	@Autowired
	@Qualifier("cartServiceImpl")
	private CartService cartService;
	
	public CartController(){
		System.out.println(this.getClass());
	}

	//���������� �� ��ҹٱ��ϸ� ���� ���� �޼��� �Դϴ�.
	@RequestMapping(value="getMyCartList")
	public String getMyCartList(Model model, HttpSession session) throws Exception{
		System.out.println("/schedule/getMyCartList : GET / POST");
		
		User user = (User)session.getAttribute("user");
		
		if(user==null) { //������ ������ ���
			return "redirect:/";
		}
		List<Cart> list = cartService.getSpotCartList(user.getUserId());
		System.out.println("===�Ѿ�� ��===");
		System.out.println(list);
		System.out.println("===�Ѿ�� ��===");
		
		model.addAttribute("list", list);
		
		return "forward:/user/mypageCartList.jsp";
	}
}

