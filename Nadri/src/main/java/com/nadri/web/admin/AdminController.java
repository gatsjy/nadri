package com.nadri.web.admin;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.nadri.common.Page;
import com.nadri.common.Search;
import com.nadri.service.admin.AdminService;
import com.nadri.service.board.BoardService;
import com.nadri.service.comment.CommentService;
import com.nadri.service.domain.Board;
import com.nadri.service.domain.Inquire;
import com.nadri.service.domain.Spot;
import com.nadri.service.domain.User;
import com.nadri.service.spot.SpotService;
import com.nadri.service.user.UserService;

@Controller
@RequestMapping("/admin/*")
public class AdminController {

	@Autowired
	@Qualifier("adminServiceImpl")
	private AdminService adminService;

	@Autowired
	@Qualifier("spotServiceImpl")
	private SpotService spotService;

	@Autowired
	@Qualifier("boardServiceImpl")
	private BoardService boardService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	@Qualifier("commentServiceImpl")
	private CommentService commentService;
	
	public AdminController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	int pageSize = 5;

	@Value("#{provinceProperties}")
	Map<String, String> map = new HashMap<String, String>();
	
	@RequestMapping(value = "adminIndex")
	public String adminIndex(Model model) throws Exception {
		System.out.println("adminIndex -> controller ����");
		Search search = new Search();
		search.setSearchCondition("�ְ�");
		List<User> userList = adminService.latestRegUsers();
		List<Board> boardList = boardService.getRecomBoard(search);
		System.out.println("board�� ���� = "+boardList.size());
		
		for(Board board:boardList) {
			System.out.println(board);
			System.out.println("boardList �� �̹��� = "+board.getBoardImg());
			if(board.getBoardImg().equals("no_img")) {
				board.setBoardImg("no_image.jpg");
			}else {
				if (board.getBoardImg().contains(",")) {
					int comma = board.getBoardImg().indexOf(",");
					String imgSingle = board.getBoardImg().substring(0, comma);
					board.setBoardImg(imgSingle);
				}else {
					System.out.println("1���� ������ �̹����� ���� ���� �Խù�");
				}
								
			}
		}
	    
		model.addAttribute("userList",userList);
		model.addAttribute("boardList",boardList);
		return "/admin/adminIndex.jsp";
	}

	@RequestMapping(value = "listInquire")
	public String getInquireList(Model model,Search search) {
		
		System.out.println("listInquire -> controller ����");

		if(search.getCurruntPage() <= 1 ){
			search.setCurruntPage(0);
			search.setStartRowNum(0);
		}else {
			search.setStartRowNum((search.getCurruntPage()-1)*pageSize);
		}
		search.setPageSize(pageSize);
		
		// Business logic ����
		Map<String , Object> map=adminService.getInquireList(search);
		List<Inquire> list = new ArrayList<Inquire>();
		Page resultPage = new Page( search.getCurruntPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, 5);
		System.out.println(resultPage);
		
		// Model �� View ����
		model.addAttribute("list", list);
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		
		return "forward:/admin/adminInquireList.jsp";
	}

	@RequestMapping(value = "updateInquire")
	public String updateInquire(Model model, @RequestParam("inqCode") String inqCode,
			@RequestParam("chkCode") String chkCode,Search search) {
		System.out.println("updateInquire -> controller ����");
		System.out.println("���� ���ǹ�ȣ : " + inqCode);
		System.out.println("���� ó����ȣ : " + chkCode);
		Inquire inquire = new Inquire();
		inquire.setInquireChkCode(chkCode);
		inquire.setInquireNo(Integer.parseInt(inqCode));
		adminService.updateInquire(inquire);

		Map<String, Object> list = adminService.getInquireList(search);
		System.out.println(((Inquire) list.get(1)).getInquireChkCode());
		int counter = 0;
		for (int i = 0; i < list.size(); i++) {
			String z = ((Inquire) list.get(i)).getInquireChkCode();
			if (z.equals("0")) {
				counter++;
			}
		}
		System.out.println("ó�� ������� ���� ���� = " + counter);
		model.addAttribute("count", counter);
		model.addAttribute("list", list);

		return "forward:/admin/adminInquireList.jsp";
	}

	@RequestMapping(value = "listSpot")
	public String getSpotList(Model model,Search search) throws Exception {

		System.out.println("getSpotList -> controller ����");

		if(search.getCurruntPage() <= 1 ){
			search.setCurruntPage(0);
			search.setStartRowNum(0);
		}else {
			search.setStartRowNum((search.getCurruntPage()-1)*pageSize);
		}
		search.setPageSize(pageSize);
		
		// Business logic ����
		Map<String , Object> map=adminService.getSpotList(search);
		
		Page resultPage = new Page( search.getCurruntPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, 5);
		System.out.println(resultPage);
		
		// Model �� View ����
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		
		return "forward:/admin/adminSpotList.jsp";
	}

	@RequestMapping(value = "addSpot", method = RequestMethod.GET)
	public String addSpotNav() {
		System.out.println("addSpotNavigation -> controller ����");
		return "forward:/admin/adminAddSpot.jsp";
	}

	@RequestMapping(value = "addSpot", method = RequestMethod.POST)
	public String addSpot(@RequestParam("file") MultipartFile file, @ModelAttribute("spot") Spot spot, Model model)
			throws Exception {
		System.out.println("addSpot -> controller ����");
		System.out.println("���� Spot : " + spot);

		String path = "C:\\Users\\Bit\\git\\nadri\\Nadri\\WebContent\\images\\spot\\";
		if (!file.isEmpty()) {

			String fileOriginName = ""; // �� �������ϸ�

			fileOriginName = file.getOriginalFilename();

			System.out.println("���� ���ϸ� : " + fileOriginName);
			SimpleDateFormat formatter = new SimpleDateFormat("YYMMDD_HHMMSS");
			Calendar now = Calendar.getInstance();

			String extension = fileOriginName.split("\\.")[1]; // Ȯ���ڸ�
			fileOriginName = formatter.format(now.getTime()) + "." + extension;
			System.out.println("����� ���ϸ� : " + fileOriginName);

			System.out.println("FileUpload����");
			File file1 = new File(path + fileOriginName);
			file.transferTo(file1);
			spot.setSpotImg(fileOriginName);
		}

		spotService.addSpot(spot);

		String prov = map.get(spot.getSpotProvince());

		System.out.println("���� ���� ã�Ƴ� �� : " + prov);

		spot.setSpotProvince(prov);

		model.addAttribute("spot", spot);
		
		Thread.sleep(2500);

		return "forward:/admin/adminAddSpotView.jsp";
	}

	@RequestMapping(value = "updateSpot", method = RequestMethod.GET)
	public String updateSpot(@RequestParam("spotNo") String spotNo, Model model) throws Exception {
		System.out.println("updateSpot -> controller ����");
		System.out.println("���� ����� ��ȣ : " + spotNo);
		Spot spot = spotService.getSpot(Integer.parseInt(spotNo));
		model.addAttribute("spot", spot);
		model.addAttribute("spotNo", Integer.parseInt(spotNo));
		return "forward:/admin/adminUpdateSpot.jsp";
	}

	@RequestMapping(value = "updateSpot", method = RequestMethod.POST)
	public String updateSpotView(@RequestParam("file") MultipartFile file, @ModelAttribute("spot") Spot spot,
			Model model) throws Exception {
		System.out.println("updateSpot -> controller ����");
		System.out.println("���� ����� ���� : " + spot);

		String path = "C:\\Users\\Bit\\git\\nadri\\Nadri\\WebContent\\images\\spot\\";
		if (!file.isEmpty()) {

			String fileOriginName = ""; // �� �������ϸ�

			fileOriginName = file.getOriginalFilename();

			System.out.println("���� ���ϸ� : " + fileOriginName);
			SimpleDateFormat formatter = new SimpleDateFormat("YYMMDD_HHMMSS");
			Calendar now = Calendar.getInstance();

			String extension = fileOriginName.split("\\.")[1]; // Ȯ���ڸ�
			fileOriginName = formatter.format(now.getTime()) + "." + extension;
			System.out.println("����� ���ϸ� : " + fileOriginName);

			System.out.println("FileUpload����");
			File file1 = new File(path + fileOriginName);
			file.transferTo(file1);
			spot.setSpotImg(fileOriginName);
		} else {
			Spot originalSpot = new Spot();
			originalSpot = spotService.getSpot(spot.getSpotNo());
			spot.setSpotImg(originalSpot.getSpotImg());
		}

		adminService.updateSpot(spot);
		model.addAttribute("spot", spot);

		return "forward:/admin/adminUpdateSpotView.jsp";
	}

	@RequestMapping(value = "deleteSpot")
	public String deleteSpot(Model model, @RequestParam("spotNo") String spotNo) throws Exception {
		System.out.println("deleteSpot -> controller ����");
		spotService.deleteSpot(spotNo);

		List<Spot> list = spotService.getSpotList();

		System.out.println(list);

		model.addAttribute("list", list);
		model.addAttribute("count", list.size());

		return "forward:/admin/adminSpotList.jsp";
	}
	
	@RequestMapping(value="listGraph")
	public String graphTest(Model model) {
		
		System.out.println("graphTest -> controller ����");
		Map<String, Object> pre_map1 = new HashMap<String, Object>();
		Map<String, Object> pre_map2 = new HashMap<String, Object>();
		Map<String, Object> pre_map3 = new HashMap<String, Object>();
		Map<String, Object> pre_map4 = new HashMap<String, Object>();

		pre_map1.put("no", "board_no");
		pre_map1.put("table", "board");
		pre_map1.put("time", "board_time");

		pre_map2.put("no", "comment_no");
		pre_map2.put("table", "comment");
		pre_map2.put("time", "comm_time");

		pre_map3.put("no", "inquire_no");
		pre_map3.put("table", "inquire");
		pre_map3.put("time", "inquire_time");

		pre_map3.put("no", "schedule_no");
		pre_map4.put("table", "schedule");
		pre_map4.put("time", "schedule_createtime");

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("one", pre_map1);
		map.put("two", pre_map2);
		map.put("three", pre_map3);
		map.put("four", pre_map4);
		
		Map<String, Object> findmap = adminService.getGraphLog((HashMap<String, Object>) map);
		
		System.out.println("ã�� Map = " + findmap);

		SimpleDateFormat form_day = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat form_timeonly = new SimpleDateFormat("HH");
		SimpleDateFormat form_week = new SimpleDateFormat("u");
		SimpleDateFormat form_month = new SimpleDateFormat("dd");

		Calendar cal = Calendar.getInstance(Locale.KOREA);
		cal.getTime();

		Date today_before = cal.getTime();
		String today = form_day.format(today_before);
		
		int week = cal.getWeeksInWeekYear();
		System.out.println("���° ������ ǥ�� : "+week);

		Map<String, Object> countermap = new HashMap<String, Object>();

		int[] list_board_day = new int[24];
		int[] list_comment_day = new int[24];
		int[] list_inquire_day = new int[24];
		int[] list_schedule_day = new int[24];
		
		int[] list_board_week = new int[7];
		int[] list_comment_week = new int[7];
		int[] list_inquire_week = new int[7];
		int[] list_schedule_week = new int[7];
		
		int monthMaxDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);	
		System.out.println("�̹����� �����ϱ�� : "+monthMaxDay);
		
		int[] list_board_month = new int[monthMaxDay];
		int[] list_comment_month = new int[monthMaxDay];
		int[] list_inquire_month = new int[monthMaxDay];
		int[] list_schedule_month = new int[monthMaxDay];

		for (int i = 0; i <= findmap.size(); i++) {

			// day_data
			if (i == 0) {
				System.out.println("1��° for���� �����ֽ��ϴ�.");
				List<Date> list = (List<Date>) findmap.get("list_board_day");
				for (Date day : list) {
					String changeDate = form_timeonly.format(day);
					list_board_day[Integer.parseInt(changeDate)]++;
				}
			} else if (i == 1) {
				System.out.println("2��° for���� �����ֽ��ϴ�.");
				List<Date> list = (List<Date>) findmap.get("list_comment_day");
				for (Date day : list) {
					String changeDate = form_timeonly.format(day);
					list_comment_day[Integer.parseInt(changeDate)]++;
				}
			} else if (i == 2) {
				System.out.println("3��° for���� �����ֽ��ϴ�.");
				List<Date> list = (List<Date>) findmap.get("list_inquire_day");
				for (Date day : list) {
					String changeDate = form_timeonly.format(day);
					list_inquire_day[Integer.parseInt(changeDate)]++;
				}
			} else if (i == 3) {
				System.out.println("4��° for���� �����ֽ��ϴ�.");
				List<Date> list = (List<Date>) findmap.get("list_schedule_day");
				for (Date day : list) {
					String changeDate = form_timeonly.format(day);
					list_schedule_day[Integer.parseInt(changeDate)]++;
				}
			}

			// week_data
			else if (i == 4) {
				System.out.println("5��° for���� �����ֽ��ϴ�.");
				List<Date> list = (List<Date>) findmap.get("list_board_week");
				for (Date day : list) {
					String changeDate = form_week.format(day);
					list_board_week[Integer.parseInt(changeDate)-1]++;
				}
			}
			else if (i == 5) {
				System.out.println("6��° for���� �����ֽ��ϴ�.");
				List<Date> list = (List<Date>) findmap.get("list_comment_week");
				for (Date day : list) {
					String changeDate = form_week.format(day);
					list_comment_week[Integer.parseInt(changeDate)-1]++;
				}
			}
			else if (i == 6) {
				System.out.println("7��° for���� �����ֽ��ϴ�.");
				List<Date> list = (List<Date>) findmap.get("list_inquire_week");
				for (Date day : list) {
					String changeDate = form_week.format(day);
					list_inquire_week[Integer.parseInt(changeDate)-1]++;
				}
			}
			else if (i == 7) {
				System.out.println("8��° for���� �����ֽ��ϴ�.");
				List<Date> list = (List<Date>) findmap.get("list_schedule_week");
				for (Date day : list) {
					String changeDate = form_week.format(day);
					list_schedule_week[Integer.parseInt(changeDate)-1]++;
				}
			}
			
			// month_data
			else if(i==8) {
				System.out.println("9��° for���� �����ֽ��ϴ�.");
				List<Date> list = (List<Date>) findmap.get("list_board_month");
				for (Date day : list) {
					String changeDate = form_month.format(day);
					list_board_month[Integer.parseInt(changeDate)-1]++;
				}
			}else if(i==9) {
				System.out.println("10��° for���� �����ֽ��ϴ�.");
				List<Date> list = (List<Date>) findmap.get("list_comment_month");
				for (Date day : list) {
					String changeDate = form_month.format(day);
					list_comment_month[Integer.parseInt(changeDate)-1]++;
				}
			}else if(i==10) {
				System.out.println("11��° for���� �����ֽ��ϴ�.");
				List<Date> list = (List<Date>) findmap.get("list_inquire_month");
				for (Date day : list) {
					String changeDate = form_month.format(day);
					list_inquire_month[Integer.parseInt(changeDate)-1]++;
				}
			}else if(i==11) {
				System.out.println("12��° for���� �����ֽ��ϴ�.");
				List<Date> list = (List<Date>) findmap.get("list_schedule_month");
				for (Date day : list) {
					String changeDate = form_month.format(day);
					list_schedule_month[Integer.parseInt(changeDate)-1]++;
				}
			}
		}
		
		List<Object> list1 = new ArrayList<Object>();
		List<Object> list2 = new ArrayList<Object>();
		List<Object> list3 = new ArrayList<Object>();
		List<Object> list4 = new ArrayList<Object>();
		
		List<Object> list5 = new ArrayList<Object>();
		List<Object> list6 = new ArrayList<Object>();
		List<Object> list7 = new ArrayList<Object>();
		List<Object> list8 = new ArrayList<Object>();
		
		List<Object> list9 = new ArrayList<Object>();
		List<Object> list10 = new ArrayList<Object>();
		List<Object> list11 = new ArrayList<Object>();
		List<Object> list12 = new ArrayList<Object>();
		
		List<Object> month = new ArrayList<Object>();
		
		for (int i : list_board_day) {
			list1.add(i);
		}
		for (int i : list_comment_day) {
			list2.add(i);
		}
		for (int i : list_inquire_day) {
			list3.add(i);
		}
		for (int i : list_schedule_day) {
			list4.add(i);
		}
		
		for (int i : list_board_week) {
			list5.add(i);
		}
		for (int i : list_comment_week) {
			list6.add(i);
		}
		for (int i : list_inquire_week) {
			list7.add(i);
		}
		for (int i : list_schedule_week) {
			list8.add(i);
		}
		
		for (int i : list_board_month) {
			list9.add(i);
		}
		for (int i : list_comment_month) {
			list10.add(i);
		}
		for (int i : list_inquire_month) {
			list11.add(i);
		}
		for (int i : list_schedule_month) {
			list12.add(i);
		}
		
		int day = 1;
		for(int z = 0; z < monthMaxDay; z++) {
			month.add("'"+day+"��'");
			day++;
		}
		
		model.addAttribute("boardDay", list1);
		model.addAttribute("commDay", list2);
		model.addAttribute("inquireDay", list3);
		model.addAttribute("scheduleDay", list4);
		
		model.addAttribute("boardWeek", list5);
		model.addAttribute("commWeek", list6);
		model.addAttribute("inquireWeek", list7);
		model.addAttribute("scheduleWeek", list8);
		
		model.addAttribute("boardMonth", list9);
		model.addAttribute("commMonth", list10);
		model.addAttribute("inquireMonth", list11);
		model.addAttribute("scheduleMonth", list12);
		
		model.addAttribute("month", month);
		
		return "forward:/admin/adminGraphList.jsp";
	}

	@RequestMapping(value = "sssslistGraph")
	public String getGraphList(Model model) {

		System.out.println("getGraphList -> controller ����");
		Map<String, Object> pre_map1 = new HashMap<String, Object>();
		Map<String, Object> pre_map2 = new HashMap<String, Object>();
		Map<String, Object> pre_map3 = new HashMap<String, Object>();
		Map<String, Object> pre_map4 = new HashMap<String, Object>();

		pre_map1.put("no", "board_no");
		pre_map1.put("table", "board");
		pre_map1.put("time", "board_time");

		pre_map2.put("no", "comment_no");
		pre_map2.put("table", "comment");
		pre_map2.put("time", "comm_time");

		pre_map3.put("no", "inquire_no");
		pre_map3.put("table", "inquire");
		pre_map3.put("time", "inquire_time");

		pre_map3.put("no", "schedule_no");
		pre_map4.put("table", "schedule");
		pre_map4.put("time", "schedule_createtime");

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("one", pre_map1);
		map.put("two", pre_map2);
		map.put("three", pre_map3);
		map.put("four", pre_map4);

		Map<String, Object> findmap = adminService.getGraphLog((HashMap<String, Object>) map);

		System.out.println("ã�� Map = " + findmap);

		SimpleDateFormat form_day = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat form_timeonly = new SimpleDateFormat("HH");
		SimpleDateFormat form_week = new SimpleDateFormat("u");
		SimpleDateFormat form_month = new SimpleDateFormat("dd");

		Calendar cal = Calendar.getInstance(Locale.KOREA);
		cal.getTime();

		Date today_before = cal.getTime();
		String today = form_day.format(today_before);
		
		int week = cal.getWeeksInWeekYear();
		System.out.println("���° ������ ǥ�� : "+week);

		Map<String, Object> countermap = new HashMap<String, Object>();

		int[] list_board_day = new int[24];
		int[] list_comment_day = new int[24];
		int[] list_inquire_day = new int[24];
		int[] list_schedule_day = new int[24];
		
		int[] list_board_week = new int[7];
		int[] list_comment_week = new int[7];
		int[] list_inquire_week = new int[7];
		int[] list_schedule_week = new int[7];
		
		int monthMaxDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);	
		System.out.println("�̹����� �����ϱ�� : "+monthMaxDay);
		
		int[] list_board_month = new int[monthMaxDay];
		int[] list_comment_month = new int[monthMaxDay];
		int[] list_inquire_month = new int[monthMaxDay];
		int[] list_schedule_month = new int[monthMaxDay];

		for (int i = 0; i <= findmap.size(); i++) {

			// day_data
			if (i == 0) {
				System.out.println("1��° for���� �����ֽ��ϴ�.");
				List<Date> list = (List<Date>) findmap.get("list_board_day");
				for (Date day : list) {
					String changeDate = form_timeonly.format(day);
					list_board_day[Integer.parseInt(changeDate)]++;
				}
			} else if (i == 1) {
				System.out.println("2��° for���� �����ֽ��ϴ�.");
				List<Date> list = (List<Date>) findmap.get("list_comment_day");
				for (Date day : list) {
					String changeDate = form_timeonly.format(day);
					list_comment_day[Integer.parseInt(changeDate)]++;
				}
			} else if (i == 2) {
				System.out.println("3��° for���� �����ֽ��ϴ�.");
				List<Date> list = (List<Date>) findmap.get("list_inquire_day");
				for (Date day : list) {
					String changeDate = form_timeonly.format(day);
					list_inquire_day[Integer.parseInt(changeDate)]++;
				}
			} else if (i == 3) {
				System.out.println("4��° for���� �����ֽ��ϴ�.");
				List<Date> list = (List<Date>) findmap.get("list_schedule_day");
				for (Date day : list) {
					String changeDate = form_timeonly.format(day);
					list_schedule_day[Integer.parseInt(changeDate)]++;
				}
			}

			// week_data
			else if (i == 4) {
				System.out.println("5��° for���� �����ֽ��ϴ�.");
				List<Date> list = (List<Date>) findmap.get("list_board_week");
				for (Date day : list) {
					String changeDate = form_week.format(day);
					list_board_week[Integer.parseInt(changeDate)-1]++;
				}
			}
			else if (i == 5) {
				System.out.println("6��° for���� �����ֽ��ϴ�.");
				List<Date> list = (List<Date>) findmap.get("list_comment_week");
				for (Date day : list) {
					String changeDate = form_week.format(day);
					list_comment_week[Integer.parseInt(changeDate)-1]++;
				}
			}
			else if (i == 6) {
				System.out.println("7��° for���� �����ֽ��ϴ�.");
				List<Date> list = (List<Date>) findmap.get("list_inquire_week");
				for (Date day : list) {
					String changeDate = form_week.format(day);
					list_inquire_week[Integer.parseInt(changeDate)-1]++;
				}
			}
			else if (i == 7) {
				System.out.println("8��° for���� �����ֽ��ϴ�.");
				List<Date> list = (List<Date>) findmap.get("list_schedule_week");
				for (Date day : list) {
					String changeDate = form_week.format(day);
					list_schedule_week[Integer.parseInt(changeDate)-1]++;
				}
			}
			
			// month_data
			else if(i==8) {
				System.out.println("9��° for���� �����ֽ��ϴ�.");
				List<Date> list = (List<Date>) findmap.get("list_board_month");
				for (Date day : list) {
					String changeDate = form_month.format(day);
					list_board_month[Integer.parseInt(changeDate)-1]++;
				}
			}else if(i==9) {
				System.out.println("10��° for���� �����ֽ��ϴ�.");
				List<Date> list = (List<Date>) findmap.get("list_comment_month");
				for (Date day : list) {
					String changeDate = form_month.format(day);
					list_comment_month[Integer.parseInt(changeDate)-1]++;
				}
			}else if(i==10) {
				System.out.println("11��° for���� �����ֽ��ϴ�.");
				List<Date> list = (List<Date>) findmap.get("list_inquire_month");
				for (Date day : list) {
					String changeDate = form_month.format(day);
					list_inquire_month[Integer.parseInt(changeDate)-1]++;
				}
			}else if(i==11) {
				System.out.println("12��° for���� �����ֽ��ϴ�.");
				List<Date> list = (List<Date>) findmap.get("list_schedule_month");
				for (Date day : list) {
					String changeDate = form_month.format(day);
					list_schedule_month[Integer.parseInt(changeDate)-1]++;
				}
			}
		}

		List<List<Object>> dayGraphList = new ArrayList<List<Object>>();
		List<List<Object>> weekGraphList = new ArrayList<List<Object>>();
		List<List<Object>> monthGraphList = new ArrayList<List<Object>>();

		for (int x = 0; x < 24; x++) {
			dayGraphList.add(x, new ArrayList<Object>());
			dayGraphList.get(x).add("'"+x+"��'");
			dayGraphList.get(x).add(list_board_day[x]);
			dayGraphList.get(x).add(list_comment_day[x]);
			dayGraphList.get(x).add(list_inquire_day[x]);
			dayGraphList.get(x).add(list_schedule_day[x]);
		}
		
		for (int x = 0; x < 7; x++) {
			weekGraphList.add(x, new ArrayList<Object>());
			if(x==0) {
				weekGraphList.get(x).add("'������'");
			}else if(x==1) {
				weekGraphList.get(x).add("'ȭ����'");
			}else if(x==2) {
				weekGraphList.get(x).add("'������'");
			}else if(x==3) {
				weekGraphList.get(x).add("'�����'");
			}else if(x==4) {
				weekGraphList.get(x).add("'�ݿ���'");
			}else if(x==5) {
				weekGraphList.get(x).add("'�����'");
			}else if(x==6) {
				weekGraphList.get(x).add("'�Ͽ���'");
			}
			weekGraphList.get(x).add(list_board_week[x]);
			weekGraphList.get(x).add(list_comment_week[x]);
			weekGraphList.get(x).add(list_inquire_week[x]);
			weekGraphList.get(x).add(list_schedule_week[x]);
		}
		
		for (int x = 0; x < monthMaxDay; x++) {
			int i = x+1;
			monthGraphList.add(x, new ArrayList<Object>());
			monthGraphList.get(x).add("'"+i+"��'");
			monthGraphList.get(x).add(list_board_month[x]);
			monthGraphList.get(x).add(list_comment_month[x]);
			monthGraphList.get(x).add(list_inquire_month[x]);
			monthGraphList.get(x).add(list_schedule_month[x]);
		}

		model.addAttribute("dayGraph", dayGraphList);
		model.addAttribute("weekGraph", weekGraphList);
		model.addAttribute("monthGraph", monthGraphList);

		return "forward:/admin/adminGraphList.jsp";
	}


	@RequestMapping(value = "listUser")
	public String getUserList(Model model,Search search) throws Exception {

		System.out.println("getUserList -> controller ����");
		
		System.out.println(search.getCurruntPage());

		if(search.getCurruntPage() <= 1 ){
			search.setCurruntPage(0);
			search.setStartRowNum(0);
		}else {
			search.setStartRowNum((search.getCurruntPage()-1)*pageSize);
		}
		search.setPageSize(pageSize);
		
		// Business logic ����
		Map<String , Object> map=adminService.getUserList(search);
		
		Page resultPage = new Page( search.getCurruntPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, 5);
		System.out.println(resultPage);
		
		// Model �� View ����
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		
		return "forward:/admin/adminUserList.jsp";
	}
}
