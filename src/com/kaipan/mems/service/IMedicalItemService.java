package com.kaipan.mems.service;

import java.util.List;

import com.kaipan.mems.domain.Medicalitem;
import com.kaipan.mems.utils.PageBean;

public interface IMedicalItemService {

	public void pageQuery(PageBean pageBean);

	public List<Medicalitem> findAll();

	public Medicalitem findbyId(String parameter);

	public void deletemedicalitem(String medicalNum);

	public void deletebatch(String ids);

	public void saveBatch(List<Medicalitem> list);

	public Medicalitem findById(String medicalNum);

	public void update(Medicalitem medicalitem1);

	public void save(Medicalitem model);

}
