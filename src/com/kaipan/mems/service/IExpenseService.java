package com.kaipan.mems.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.kaipan.mems.domain.Expense;
import com.kaipan.mems.utils.PageBean;

public interface IExpenseService {
	public void pageQuery(PageBean pageBean);

	public Expense findById(String expenseNum);

	public void delExpense(String expenseNum);

	public void add(Expense expense);

	public void update(Expense expense);

	public void deletebatch(String ids);

	public void doDelete(String expenseNum);

	public List<Integer> findAllYear();

	public List<Expense> findExpenses(DetachedCriteria detachedCriteria);

	public List accountByYear();
}
