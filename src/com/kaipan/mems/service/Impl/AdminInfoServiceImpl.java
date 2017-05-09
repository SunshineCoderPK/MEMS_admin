package com.kaipan.mems.service.Impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kaipan.mems.dao.IAdminInfoDao;
import com.kaipan.mems.domain.Admininfo;
import com.kaipan.mems.service.IAdminInfoService;
import com.kaipan.mems.utils.MD5Utils;
import com.kaipan.mems.utils.PageBean;

@Service
@Transactional
public class AdminInfoServiceImpl implements IAdminInfoService {
	
	@Autowired
	private IAdminInfoDao adminInfoDao;
	
	@Override
	public Admininfo login(Admininfo model) {
		String empId=model.getEmpId();
		String pwd=model.getPassword();
		pwd=MD5Utils.md5(pwd);
		return adminInfoDao.findByIdAndPwd(empId,pwd);
	}
	
	@Override
	public void pageQuery(PageBean pageBean) {
		adminInfoDao.pageQuery(pageBean);
	}
	
	@Override
	public Admininfo findById(String empId) {
		return adminInfoDao.findById(empId);
	}
	
	@Override
	public void editPassword(String pwd, String empId) {
		adminInfoDao.executeUpdate("editAdminPassword", pwd,empId);
	}
	
	@Override
	public void deleteAdmin(String empId) {
		boolean isDelete=true;
		adminInfoDao.executeUpdate("delAdmin",isDelete, empId);
	}

}
