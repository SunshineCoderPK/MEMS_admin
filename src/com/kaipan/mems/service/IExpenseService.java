package com.kaipan.mems.service;

import com.kaipan.mems.domain.Expense;
import com.kaipan.mems.utils.PageBean;

public interface IExpenseService {
	public void pageQuery(PageBean pageBean);

	public Expense findById(String expenseNum);
}
