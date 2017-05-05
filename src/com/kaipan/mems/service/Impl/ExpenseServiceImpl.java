package com.kaipan.mems.service.Impl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kaipan.mems.dao.IExpenseDao;
import com.kaipan.mems.domain.Expense;
import com.kaipan.mems.service.IExpenseService;
import com.kaipan.mems.utils.PageBean;

@Service
@Transactional
public class ExpenseServiceImpl implements IExpenseService {
	
	@Autowired
	private IExpenseDao expenseDao;
	
	@Override
	public void pageQuery(PageBean pageBean) {
	    expenseDao.pageQuery(pageBean);
	}
	
	@Override
	public Expense findById(String expenseNum) {
		return expenseDao.findById(expenseNum);
	}
}
