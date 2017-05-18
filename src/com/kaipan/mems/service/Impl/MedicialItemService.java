package com.kaipan.mems.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kaipan.mems.dao.IMedicalItemDao;
import com.kaipan.mems.dao.IMedicineDao;
import com.kaipan.mems.domain.Medicalitem;
import com.kaipan.mems.domain.Userinfo;
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
	
	@Override
	public List<Medicalitem> findAll() {
		return medicalItemDao.findAll();
	}
	
	@Override
	public Medicalitem findbyId(String parameter) {  
		return medicalItemDao.findById(parameter);
	}
	
	@Override
	public void deletemedicalitem(String medicalNum) {
		boolean isDelete=true;
		medicalItemDao.executeUpdate("delmedicalitem", isDelete,medicalNum);
	}
	
	@Override
	public void deletebatch(String ids) {
		boolean isDelete=true;
		String[] staffIds = ids.split(",");
		for (String id : staffIds) {
			medicalItemDao.executeUpdate("delmedicalitem",isDelete, id);
		}
	}
	
	@Override
	public void saveBatch(List<Medicalitem> list) {
		for (Medicalitem signMedicalitem  : list) {
			medicalItemDao.saveOrUpdate(signMedicalitem );
		}
	}
	
	
	@Override
	public Medicalitem findById(String medicalNum) {
		return medicalItemDao.findById(medicalNum);
    }
	
	@Override
	public void update(Medicalitem medicalitem1) {
		medicalItemDao.update(medicalitem1);
	}
	
	@Override
	public void save(Medicalitem model) {
		medicalItemDao.save(model);
	}
}
