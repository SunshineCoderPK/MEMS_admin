package com.kaipan.mems.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kaipan.mems.dao.IUserInfoDao;
import com.kaipan.mems.domain.Userinfo;
import com.kaipan.mems.service.IUserService;
import com.kaipan.mems.utils.MD5Utils;
import com.kaipan.mems.utils.PageBean;

@Service
@Transactional
public class UserServiceImpl implements IUserService {
	
    @Autowired
    private IUserInfoDao userInfoDao;
    
	@Override
	public Userinfo login(Userinfo model) {
		String username=model.getStuOrEmpId();
		String password=model.getPassword();
		password=MD5Utils.md5(password);
		return userInfoDao.findByUsernameAndPassword(username, password);
	}

	@Override
	public void editPassword(String password, String id) {
		userInfoDao.executeUpdate("editPassword", password,id);
	}
	
	@Override
	public void update(Userinfo user) {
		userInfoDao.update(user);
	}
	
	@Override
	public void pageQuery(PageBean pageBean) {
		userInfoDao.pageQuery(pageBean);
	}
	
	@Override
	public Userinfo findById(String stuOrEmpId) {
		return userInfoDao.findById(stuOrEmpId);
	}
	
	@Override
	public void deleteuser(String stuOrEmpId) {
		boolean isDelete=true;
		userInfoDao.executeUpdate("delUser",isDelete, stuOrEmpId);
	}
	
	@Override
	public void deletebatch(String ids) {
		boolean isDelete=true;
		String[] staffIds = ids.split(",");
		for (String id : staffIds) {
			userInfoDao.executeUpdate("delUser",isDelete, id);
		}
	}
	
	@Override
	public void saveBatch(List<Userinfo> list) {
		for (Userinfo signUser : list) {
			userInfoDao.saveOrUpdate(signUser);
		}
	}
	
	@Override
	public void adduser(Userinfo model) {
		userInfoDao.save(model);
	}
	
	@Override
	public List<Userinfo> findAll() {
		return userInfoDao.findAll();
	}

}
