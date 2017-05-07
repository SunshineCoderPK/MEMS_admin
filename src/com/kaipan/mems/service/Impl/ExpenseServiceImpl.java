package com.kaipan.mems.service.Impl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kaipan.mems.dao.IExpenseDao;
import com.kaipan.mems.dao.IExpensemedicalitemDao;
import com.kaipan.mems.dao.IExpensemedicineDao;
import com.kaipan.mems.domain.Expense;
import com.kaipan.mems.service.IExpenseService;
import com.kaipan.mems.utils.PageBean;

@Service
@Transactional
public class ExpenseServiceImpl implements IExpenseService {
	
	@Autowired
	private IExpenseDao expenseDao;
	
	@Autowired
	private IExpensemedicalitemDao expensemedicalitemDao;
	
	@Autowired
	private IExpensemedicineDao expensemedicineDao;
	
	
	@Override
	public void pageQuery(PageBean pageBean) {
	    expenseDao.pageQuery(pageBean);
	}
	
	@Override
	public Expense findById(String expenseNum) {
		return expenseDao.findById(expenseNum);
	}
	
	@Override
	public void delExpense(String expenseNum) {
		boolean isDelete=true;
		expenseDao.executeUpdate("delExpense",isDelete,expenseNum);
		expensemedicalitemDao.executeUpdate("delExpenseMedicalitem",isDelete,expenseNum);
		expensemedicineDao.executeUpdate("delExpenseMedicine",isDelete,expenseNum);	
	}
	
	@Override
	public void add(Expense expense) {
		expenseDao.save(expense);
	}
	
	@Override
	public void update(Expense expense) {
		expenseDao.update(expense);
	}
}
