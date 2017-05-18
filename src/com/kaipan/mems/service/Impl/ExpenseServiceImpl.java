package com.kaipan.mems.service.Impl;


import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
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
	
	@Override
	public void deletebatch(String ids) {
		boolean isDelete=true;
		String[] staffIds=ids.split(",");
		for(String id:staffIds){
			expenseDao.executeUpdate("delExpense",isDelete,id);
			expensemedicalitemDao.executeUpdate("delExpenseMedicalitem",isDelete,id);
			expensemedicineDao.executeUpdate("delExpenseMedicine",isDelete,id);	
		}
	}
	
	@Override
	public void doDelete(String expenseNum) {
		expenseDao.executeUpdate("dodeleteexpense", expenseNum);
	}
	
	@Override
	public List<Integer> findAllYear() {
		return expenseDao.findAllYear();
	}
	
	@Override
	public List<Expense> findExpenses(DetachedCriteria detachedCriteria) {
		return expenseDao.findByCriteria(detachedCriteria);
	}
	
	@Override
	public List accountByYear() {
		return expenseDao.accByYear();
	}
	
}
