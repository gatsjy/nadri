package com.nadri.web.friend;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.nadri.common.Page;
import com.nadri.common.Search;
import com.nadri.service.domain.Friend;
import com.nadri.service.domain.User;
import com.nadri.service.friend.FriendService;
import com.nadri.service.user.UserService;

@RestController
@RequestMapping("/friend/*")
public class FriendRestController {

	//field
	@Autowired
	@Qualifier("friendServiceImpl")
	private FriendService friendService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	
	@Value("#{commonProperties['pageUnit']}")
	// @Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;

	@Value("#{commonProperties['pageSize']}")
	// @Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	//constructor method
	public FriendRestController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}

	////�������׽�Ʈ
	@RequestMapping(value="json/listFriendFromBoard/{userId}")
	public String listFriendFromBoard(@PathVariable String userId) throws Exception{
		System.out.println("/friend/json/listFriendFromBoard : GET"); //$.getJSON ���� �������°Ŷ� POST�� �ϸ� ����
				
		return friendService.listFriendFromBoard(userId);
	}
	@RequestMapping(value="json/chkFriend/{friendId}")
	public int chkFriend(@PathVariable String friendId, HttpSession session) throws Exception{
		System.out.println("/friend/json/chkFriend : GET / POST");
		
		User user = (User)session.getAttribute("user");
		
		return friendService.checkFriend(user.getUserId(), friendId, 1);
	}
	
	//method
	//ģ�� ���
	@RequestMapping(value="json/listFriend", method=RequestMethod.POST)
	public List<Friend> listFriend(@ModelAttribute("search") Search search, HttpSession session, Model model) throws Exception{
		System.out.println("friend/json/listFriend: POST");
		//���� ������
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		search.setSearchKeyword(((User)session.getAttribute("user")).getUserId());
		//map�� ģ�� ����Ʈ ���
		Map<String, Object> map = friendService.listFriend(search);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		//�𵨿� ����Ʈ, ������ ���� ���
		model.addAttribute("list",map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		//����Ʈ ��ȯ
		return (List)map.get("list");
	}
	
	//ģ�� �α�
	@RequestMapping(value="json/addFriend", method=RequestMethod.POST)
	public String addFriend(@RequestBody Map<String, Object> map, @ModelAttribute("friend") Friend friend, @ModelAttribute("search") Search search, HttpSession session, Model model) throws Exception {
		
		String userId2 = ((String) map.get("userId"));
		String friendId = ((String) map.get("friendId"));
		String userName = ((String)map.get("userName"));
		
		friend.setFriendId(friendId);
		friend.setUserId(userId2);
		System.out.println("ģ�� �α��� ģ�� ����: "+friend);
		//userid, friendId �� �� 0�̸� ģ��(1�� 0�̸� ģ�� ��û����)
		friendService.addFriend(friend, "0");
		
		return null;
	}
	
		
	//ģ�� ��û ���
	@RequestMapping(value = "json/cancelFriend", method=RequestMethod.POST)
	public String cancelFriend(@RequestBody Map<String, Object> map, @ModelAttribute("friend") Friend friend, @ModelAttribute("search") Search search,HttpSession session, Model model) throws Exception{
		System.out.println("json/cancelFriend()");
		
		String userId = ((String)map.get("userId"));
		String friendId = ((String)map.get("friendId"));
		String userName =  ((String)map.get("userName"));
		
		friend.setFriendId(friendId);
		friend.setUserId(userId);
		System.out.println(friend);
		
		friendService.cancelFriend(userId, friendId, 0);
		
		return null;
	}
	
	//ģ�� ����
	@RequestMapping(value = "json/deleteFriend", method=RequestMethod.POST)
	public String delectFriend(@RequestBody Map<String, Object> map, @ModelAttribute("friend") Friend friend, @ModelAttribute("search") Search search,HttpSession session, Model model) throws Exception{
		System.out.println("json/deleteFriend()");
		
		String userId = ((String)map.get("userId"));
		String friendId = ((String)map.get("friendId"));
		String userName =  ((String)map.get("userName"));
		
		friend.setFriendId(friendId);
		friend.setUserId(userId);
		System.out.println(friend);
		
		friendService.cancelFriend(userId, friendId, 0);
		return null;
	}
	
	//���� ģ�� ��û ����
	@RequestMapping(value="json/refuseFriend", method=RequestMethod.POST)
	public String refuseFriend(@RequestBody Map<String, Object> map, Model model) throws Exception{
		System.out.println("refuseFriend()");
		
		String userId = ((String)map.get("userId"));
		String friendId = ((String)map.get("friendId"));
		
		friendService.updateStatus(friendId, userId, 1);			
		
		return null;
	}
	
	
	@RequestMapping(value="json/okFriend", method=RequestMethod.POST)
	public String okFriend(@RequestBody Map<String, Object> map, Model model) throws Exception{
		System.out.println("okFriend()");
		
		return null;
	}
	
	//follow �߰�
	@RequestMapping(value="json/addFollow", method=RequestMethod.POST)
	public String addFollow(@RequestBody Map<String, Object> map, @ModelAttribute("friend") Friend friend, Model model) throws Exception{
		System.out.println("cutFriend()");
		System.out.println("restController addfollowFriend - start :: "+friend);
		
		String userId = ((String)map.get("userId"));
		String friendId = ((String)map.get("friendId"));
		String userName =  ((String)map.get("userName"));
		
		friend.setFriendId(friendId);
		friend.setUserId(userId);
		System.out.println("restController addFollow: "+friend);
		
		friendService.addFriend(friend, "1");
		
		
		return null;
	}
	
	//follow ���
	@RequestMapping(value="json/cancelFollow", method=RequestMethod.POST)
	public String cancelFollow(@RequestBody Map<String, Object> map, @ModelAttribute("friend") Friend friend, Model model) throws Exception{
		System.out.println("json/ancelFollow");
		
		String userId = ((String)map.get("userId"));
		String friendId = ((String)map.get("friendId"));
		String userName =  ((String)map.get("userName"));
		
		friend.setFriendId(friendId);
		friend.setUserId(userId);
		System.out.println("restController cancelFoller: "+friend);
		
		friendService.cancelFriend(userId, friendId, 1);
		return null;
	}
	
}
