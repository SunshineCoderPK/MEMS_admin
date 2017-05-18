package com.kaipan.mems.service;

import java.util.List;

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

	public void saveBatch(List<Userinfo> list);

	public void adduser(Userinfo model);

	public List<Userinfo> findAll();
}
