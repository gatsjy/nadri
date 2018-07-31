package com.nadri.web.cart;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
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

//==> ��ٱ��� RestController
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
   @RequestMapping(value="/getMyCartList")
   public synchronized String getMyCartList(Model model, HttpSession session) throws Exception{
      System.out.println("/cart/getMyCartList : GET / POST");
      
      User user = (User)session.getAttribute("user");
      
      if(user==null) { //������ ������ ���
         return "redirect:/";
      }
      JSONArray jsonArray = new JSONArray();
      List<Cart> list = cartService.getSpotCartList(user.getUserId());
      System.out.println("===�Ѿ�� ��===");
      System.out.println(list);
      System.out.println("===�Ѿ�� ��===");
      
      for(Cart cart : list) {
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("spotX", cart.getCartX());
			jsonObject.put("spotY", cart.getCartY());
			jsonObject.put("spotAddress", cart.getCartAddress());
			jsonObject.put("spotTitle", cart.getCartTitle());
			jsonObject.put("spotImg", cart.getCartImg());
			jsonObject.put("spotCreateTime", cart.getCartCreateTime());
			jsonObject.put("spotNo", cart.getSpotNo());
			jsonObject.put("spotDetail", cart.getCartDetail());
			jsonArray.add(jsonObject);
		}
      
      model.addAttribute("list", list);
      model.addAttribute("cart", jsonArray);
      
      return "forward:/user/mypageCartList.jsp";
   }
	
}

