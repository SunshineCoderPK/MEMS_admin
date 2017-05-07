package com.kaipan.mems.service;

import java.util.List;

import com.kaipan.mems.domain.Medicine;
import com.kaipan.mems.utils.PageBean;

public interface IMedicineService {
	public void pageQuery(PageBean pageBean);

	public List<Medicine> findAll();

	public Medicine findbyId(String parameter);

}
