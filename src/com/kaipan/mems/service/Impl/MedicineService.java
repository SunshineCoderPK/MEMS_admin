package com.kaipan.mems.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kaipan.mems.dao.IMedicineDao;
import com.kaipan.mems.domain.Medicalitem;
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
	
	@Override
	public void deletemedicine(String medicNum) {
	    boolean isDelete=true;
		medicineDao.executeUpdate("delmedicine", isDelete,medicNum);
	}
	
	@Override
	public void deletebatch(String ids) {
		boolean isDelete=true;
		String[] staffIds = ids.split(",");
		for (String id : staffIds) {
			medicineDao.executeUpdate("delmedicine",isDelete, id);
		}
	}
	
	@Override
	public void saveBatch(List<Medicine> list) {
		for (Medicine signMedicine  : list) {
			medicineDao.saveOrUpdate(signMedicine );
		}
	}
	
	@Override
	public Medicine findById(String parameter) {
		return medicineDao.findById(parameter);
	}
	
	@Override
	public void update(Medicine medicine) {
		medicineDao.update(medicine);
	}
	
	@Override
	public void save(Medicine model) {
		medicineDao.save(model);
	}
}
