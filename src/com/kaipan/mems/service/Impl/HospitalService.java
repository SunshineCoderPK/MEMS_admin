package com.kaipan.mems.service.Impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kaipan.mems.dao.IHospitalDao;
import com.kaipan.mems.service.IHospitalService;
import com.kaipan.mems.utils.PageBean;

@Service
@Transactional
public class HospitalService  implements IHospitalService {
	@Autowired
	private IHospitalDao hospitalDao;
	
	@Override
	public void pageQuery(PageBean pageBean) {
		hospitalDao.pageQuery(pageBean);
	}
}
