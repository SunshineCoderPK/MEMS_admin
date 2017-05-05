package com.kaipan.mems.service.Impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kaipan.mems.dao.IMedicalItemDao;
import com.kaipan.mems.dao.IMedicineDao;
import com.kaipan.mems.service.IMedicalItemService;
import com.kaipan.mems.utils.PageBean;

@Service
@Transactional
public class MedicialItemService implements IMedicalItemService {
	@Autowired
	private IMedicalItemDao medicalItemDao;
	
	public void pageQuery(PageBean pageBean) {
		medicalItemDao.pageQuery(pageBean);
	}
}
