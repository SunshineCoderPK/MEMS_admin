package com.kaipan.mems.service;

import java.util.List;

import com.kaipan.mems.domain.Hospital;
import com.kaipan.mems.utils.PageBean;

public interface IHospitalService {

	public void pageQuery(PageBean pageBean);

	public List<Hospital> findAll();

	public Hospital findHospital(String id);

}
