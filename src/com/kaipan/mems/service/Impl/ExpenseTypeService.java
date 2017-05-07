package com.kaipan.mems.service.Impl;

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
}
