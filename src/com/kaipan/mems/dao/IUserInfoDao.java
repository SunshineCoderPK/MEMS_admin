package com.kaipan.mems.dao;

import com.kaipan.mems.dao.base.IBaseDao;
import com.kaipan.mems.domain.Userinfo;

public interface IUserInfoDao extends IBaseDao<Userinfo>{
	public Userinfo findByUsernameAndPassword(String username, String password);
}
