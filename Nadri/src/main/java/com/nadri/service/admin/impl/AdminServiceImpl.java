package com.nadri.service.admin.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.nadri.service.admin.AdminDao;
import com.nadri.service.admin.AdminService;
import com.nadri.service.domain.Inquire;
import com.nadri.service.domain.Spot;

@Service("adminServiceImpl")
public class AdminServiceImpl implements AdminService{
	
	@Autowired
	@Qualifier("adminDaoImpl")
	private AdminDao adminDao;
	
	public void setAdminDao(AdminDao adminDao) {
		this.adminDao = adminDao;
	}
	
	public AdminServiceImpl() {
		
	}

	@Override
	public void addInquire(Inquire inquire) {
		// TODO Auto-generated method stub
		adminDao.addInquire(inquire);
	}

	@Override
	public List<Inquire> getInquireList() {
		// TODO Auto-generated method stub
		return adminDao.getInquireList();
	}
	@Override
	public void updateInquire(Inquire inquire) {
		// TODO Auto-generated method stub
		System.out.println("get in updateInquire");
		adminDao.updateInquire(inquire);
	}

	@Override
	public Inquire getInquire(int inquireNo) {
		// TODO Auto-generated method stub
		return adminDao.getInquire(inquireNo);
	}

	@Override
	public void updateSpot(Spot spot) {
		// TODO Auto-generated method stub
		adminDao.updateSpot(spot);
	}

	@Override
	public Map<String, Object> getGraphLog(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return adminDao.getGraphLog(map);
	}

	@Override
	public int blockUser(String userId) {
		// TODO Auto-generated method stub
		return adminDao.blockUser(userId);
	}


}
