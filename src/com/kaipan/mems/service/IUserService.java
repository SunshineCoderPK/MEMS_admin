package com.kaipan.mems.service;

import com.kaipan.mems.domain.Userinfo;
import com.kaipan.mems.utils.PageBean;

public interface IUserService {

	public Userinfo login(Userinfo model);

	public void editPassword(String password, String id);

	public void update(Userinfo user);

	public void pageQuery(PageBean pageBean);

	public Userinfo findById(String empId);

	public void deleteuser(String stuOrEmpId);

	public void deletebatch(String ids);
}
