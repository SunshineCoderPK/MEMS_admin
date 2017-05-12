package com.kaipan.mems.service;

import com.kaipan.mems.domain.Admininfo;
import com.kaipan.mems.utils.PageBean;

public interface IAdminInfoService {

	public Admininfo login(Admininfo model);

	public void pageQuery(PageBean pageBean);

	public Admininfo findById(String empId);

	public void editPassword(String pwd, String empId);

	public void deleteAdmin(String empId);

	public void update(Admininfo admininfo);

	public void deletebatch(String ids);

	public void addadmin(Admininfo model);

}
