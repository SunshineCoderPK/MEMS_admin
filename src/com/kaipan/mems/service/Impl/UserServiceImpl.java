package com.kaipan.mems.service.Impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kaipan.mems.dao.IUserInfoDao;
import com.kaipan.mems.domain.Userinfo;
import com.kaipan.mems.service.IUserService;
import com.kaipan.mems.utils.MD5Utils;

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

}
