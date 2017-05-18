package com.kaipan.mems.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kaipan.mems.dao.IExpenseTypeDao;
import com.kaipan.mems.domain.Expensetype;
import com.kaipan.mems.service.IExpenseTypeService;
import com.kaipan.mems.utils.PageBean;

@Service
@Transactional
public class ExpenseTypeService implements IExpenseTypeService {
	@Autowired
	private IExpenseTypeDao expenseTypeDao;
	
	
	public void pageQuery(PageBean pageBean) {
		expenseTypeDao.pageQuery(pageBean);
	}
	
	@Override
	public Expensetype findExpensetype(int userRoleId, String medicalTyp, boolean isRetire, int hospTyp) {
		return expenseTypeDao.findExpensetype(userRoleId,medicalTyp,isRetire,hospTyp);
	}
	
	@Override
	public Expensetype findExpensetype(int userRoleId, String medicalTyp, boolean isRetire, int hospTyp,
			boolean healthCard) {
		return expenseTypeDao.findExpensetype(userRoleId,medicalTyp,isRetire,hospTyp,healthCard);
	}
	
	@Override
	public void delexpensetype(int parseInt) {
		boolean isDelete=true;
		expenseTypeDao.executeUpdate("delexpensetype", isDelete,parseInt);
	}
	
	@Override
	public void deletebatch(String ids) {
		boolean isDelete=true;
		String[] staffIds = ids.split(",");
		for(String id:staffIds){
			expenseTypeDao.executeUpdate("delexpensetype", isDelete,Integer.parseInt(id));
		}
	}
	
	@Override
	public void saveBatch(List<Expensetype> list) {
		for(Expensetype expensetype:list){
		    expenseTypeDao.saveOrUpdate(expensetype);
		}
	}
	
	@Override
	public Expensetype findById(int id) {
		return expenseTypeDao.findById(id);
	}
	
	@Override
	public void update(Expensetype expensetype1) {
		expenseTypeDao.update(expensetype1);
	}
	
	@Override
	public void save(Expensetype model) {
		expenseTypeDao.save(model);
	}
}
