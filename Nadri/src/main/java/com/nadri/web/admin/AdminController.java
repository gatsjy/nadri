package com.nadri.web.admin;


import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.nadri.common.Search;
import com.nadri.service.admin.AdminService;
import com.nadri.service.domain.Inquire;
import com.nadri.service.domain.Spot;
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
	@Qualifier("userServiceImpl")
	private UserService userService;

	public AdminController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{provinceProperties}")
	Map<String,String> map = new HashMap<String,String>();

	@RequestMapping(value = "addInquire")
	public String addInquire(@RequestParam("file") MultipartFile file, @ModelAttribute("inquire") Inquire inquire,
			@RequestParam("inquireCode") String inquireCode, @RequestParam("reportUserId") String reportUserId,
			Model model) throws Exception {
		System.out.println("addInquire -> controller ����");
		System.out.println("���� fileName : " + file.getOriginalFilename());
		String path = "C:\\Users\\Bit\\git\\nadri\\Nadri\\WebContent\\images\\test\\inquire";
		if (!file.isEmpty()) {
			System.out.println("FileUpload����");
			byte fileData[] = file.getBytes();
			FileOutputStream fos = new FileOutputStream(path + file.getOriginalFilename());
			fos.write(fileData);
			fos.flush();
			fos.close();
			inquire.setInquireFile1(file.getOriginalFilename());
		}
		inquire.setUserId("user02");
		System.out.println("inquire : " + inquire);
		adminService.addInquire(inquire);
		return "redirect:/admin/adminInquireTest.jsp";
	}

	@RequestMapping(value = "listInquire")
	public String getInquireList(Model model) {
		System.out.println("listInquire -> controller ����");
		List<Inquire> list = adminService.getInquireList();
		System.out.println(list.get(1).getInquireChkCode());
		int counter = 0;
		for (int i = 0; i < list.size(); i++) {
			String z = list.get(i).getInquireChkCode();
			if (z.equals("0")) {
				counter++;
			}
		}
		

		System.out.println("ó�� ������� ���� ���� = " + counter);
		model.addAttribute("count", counter);
		model.addAttribute("list", list);

		
		return "forward:/admin/adminInquireList.jsp";
	}

	@RequestMapping(value = "updateInquire")
	public String updateInquire(Model model, @RequestParam("inqCode") String inqCode,
			@RequestParam("chkCode") String chkCode) {
		System.out.println("updateInquire -> controller ����");
		System.out.println("���� ���ǹ�ȣ : " + inqCode);
		System.out.println("���� ó����ȣ : " + chkCode);
		Inquire inquire = new Inquire();
		inquire.setInquireChkCode(chkCode);
		inquire.setInquireNo(Integer.parseInt(inqCode));
		adminService.updateInquire(inquire);

		List<Inquire> list = adminService.getInquireList();
		System.out.println(list.get(1).getInquireChkCode());
		int counter = 0;
		for (int i = 0; i < list.size(); i++) {
			String z = list.get(i).getInquireChkCode();
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
	public String getSpotList(Model model) throws Exception {

		System.out.println("listSpot -> controller ����");
		List<Spot> list = spotService.getSpotList();

		System.out.println(list);

		model.addAttribute("list", list);
		model.addAttribute("count", list.size());

		return "forward:/admin/adminSpotList.jsp";
	}
	
	@RequestMapping(value = "addSpot", method=RequestMethod.GET)
	public String addSpotNav() {
		System.out.println("addSpotNavigation -> controller ����");
		return "redirect:/admin/adminAddSpot.jsp";
	}

	@RequestMapping(value = "addSpot", method=RequestMethod.POST)
	public String addSpot(@RequestParam("file") MultipartFile file,@ModelAttribute("spot")Spot spot,Model model) throws Exception {
		System.out.println("addSpot -> controller ����");
		System.out.println("���� Spot : "+spot);
		
		String path = "C:\\Users\\Bit\\git\\nadri\\Nadri\\WebContent\\images\\spot\\";
		if(!file.isEmpty()) {
		
		    String fileOriginName=""; //�� �������ϸ�
		      
	        fileOriginName = file.getOriginalFilename();
	         
	        System.out.println("���� ���ϸ� : "+fileOriginName);
	        SimpleDateFormat formatter = new SimpleDateFormat("YYMMDD_HHMMSS");
	        Calendar now = Calendar.getInstance();
	         
	        String extension = fileOriginName.split("\\.")[1]; //Ȯ���ڸ�
	        fileOriginName = formatter.format(now.getTime())+"."+extension;
	        System.out.println("����� ���ϸ� : "+fileOriginName);
			
			System.out.println("FileUpload����");
			File file1 = new File(path+fileOriginName);
			file.transferTo(file1);
            spot.setSpotImg(fileOriginName);
		}
		
		spotService.addSpot(spot);
		
		String prov = map.get(spot.getSpotProvince());
		
		System.out.println("���� ���� ã�Ƴ� �� : "+prov);
		
		spot.setSpotProvince(prov);
		
		model.addAttribute("spot",spot);
		
		return "forward:/admin/adminAddSpotView.jsp";
	}

	@RequestMapping(value = "updateSpot", method=RequestMethod.GET)
	public String updateSpot(@RequestParam("spotNo") String spotNo,Model model) throws Exception {
		System.out.println("updateSpot -> controller ����");
		System.out.println("���� ����� ��ȣ : "+spotNo);
		Spot spot = spotService.getSpot(Integer.parseInt(spotNo));
		model.addAttribute("spot",spot);
		model.addAttribute("spotNo",Integer.parseInt(spotNo));
		return "forward:/admin/adminUpdateSpot.jsp";
	}
	
	@RequestMapping(value = "updateSpot", method=RequestMethod.POST)
	public String updateSpotView(@RequestParam("file") MultipartFile file,@ModelAttribute("spot")Spot spot,Model model) throws Exception {
		System.out.println("updateSpot -> controller ����");
		System.out.println("���� ����� ���� : "+spot);
		
		String path = "C:\\Users\\Bit\\git\\nadri\\Nadri\\WebContent\\images\\spot\\";
		if(!file.isEmpty()) {
		
		    String fileOriginName=""; //�� �������ϸ�
		      
	        fileOriginName = file.getOriginalFilename();
	         
	        System.out.println("���� ���ϸ� : "+fileOriginName);
	        SimpleDateFormat formatter = new SimpleDateFormat("YYMMDD_HHMMSS");
	        Calendar now = Calendar.getInstance();
	         
	        String extension = fileOriginName.split("\\.")[1]; //Ȯ���ڸ�
	        fileOriginName = formatter.format(now.getTime())+"."+extension;
	        System.out.println("����� ���ϸ� : "+fileOriginName);
			
			System.out.println("FileUpload����");
			File file1 = new File(path+fileOriginName);
			file.transferTo(file1);
            spot.setSpotImg(fileOriginName);
		}else {
			Spot originalSpot = new Spot();
			originalSpot = spotService.getSpot(spot.getSpotNo());
			spot.setSpotImg(originalSpot.getSpotImg());
		}
		
		adminService.updateSpot(spot);
		model.addAttribute("spot",spot);
		
		
		return "forward:/admin/adminUpdateSpotView.jsp";
	}

	@RequestMapping(value = "deleteSpot")
	public String deleteSpot(Model model,@RequestParam("spotNo") String spotNo) throws Exception {
		System.out.println("deleteSpot -> controller ����");
		spotService.deleteSpot(spotNo);

		List<Spot> list = spotService.getSpotList();

		System.out.println(list);

		model.addAttribute("list", list);
		model.addAttribute("count", list.size());

		return "forward:/admin/adminSpotList.jsp";
	}

	@RequestMapping(value = "listGraph")
	public String getGraphList() {
		
		System.out.println("getGraphList -> controller ����");
		
		
		return "forward:/admin/adminGraphList.jsp";
	}

	@RequestMapping(value = "listLog")
	public String getLogList() {
		return "forward:/admin/adminUserLogList.jsp";
	}

	@RequestMapping(value = "listUser")
	public String getUserList() throws Exception {
		
		System.out.println("getUserList -> controller ����");
		
		Search search = null;
		
		Map<String, Object> map = userService.getUserList(search);
		
		return "forward:/admin/adminUserList.jsp";
	}
}
