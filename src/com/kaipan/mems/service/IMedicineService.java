package com.kaipan.mems.service;

import java.util.List;

import com.kaipan.mems.domain.Medicine;
import com.kaipan.mems.utils.PageBean;

public interface IMedicineService {
	public void pageQuery(PageBean pageBean);

	public List<Medicine> findAll();

	public Medicine findbyId(String parameter);

	public void deletemedicine(String medicNum);

	public void deletebatch(String ids);

	public void saveBatch(List<Medicine> list);

	public Medicine findById(String parameter);

	public void update(Medicine medicine);

	public void save(Medicine model);

}
