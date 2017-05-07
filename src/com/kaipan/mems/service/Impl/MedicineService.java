package com.kaipan.mems.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kaipan.mems.dao.IMedicineDao;
import com.kaipan.mems.domain.Medicine;
import com.kaipan.mems.service.IMedicineService;
import com.kaipan.mems.utils.PageBean;


@Service
@Transactional
public class MedicineService implements IMedicineService {
	@Autowired
	private IMedicineDao medicineDao;
	
	@Override
	public void pageQuery(PageBean pageBean) {
		medicineDao.pageQuery(pageBean);
	}
	
	@Override
	public List<Medicine> findAll() {
		return medicineDao.findAll();
	}
	
	@Override
	public Medicine findbyId(String parameter) {
		return medicineDao.findById(parameter);
	}
}
