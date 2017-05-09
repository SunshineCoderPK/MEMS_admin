package com.kaipan.mems.dao;

import com.kaipan.mems.dao.base.IBaseDao;
import com.kaipan.mems.domain.Admininfo;

public interface IAdminInfoDao extends IBaseDao<Admininfo>{

	public Admininfo findByIdAndPwd(String empId, String pwd);

}
