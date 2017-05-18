package com.kaipan.mems.dao.Impl;

import java.util.List;

import org.hibernate.Session;
import org.springframework.stereotype.Repository;

import com.kaipan.mems.dao.IExpenseDao;
import com.kaipan.mems.dao.base.Impl.BaseDaoImpl;
import com.kaipan.mems.domain.Expense;

@Repository
public class ExpenseDapImpl extends BaseDaoImpl<Expense> implements IExpenseDao{
	
	@Override
	public List<Integer> findAllYear() {
		Session session = this.getSession();
		List<Integer> years=session.createSQLQuery("SELECT  DISTINCT  YEAR(ExpenseTime) FROM expense WHERE  isCheck=2 AND isDelete=0 ").list();
		return years;
	}
	
	@Override
	public List accByYear() {
		Session session = this.getSession();
		String hql="select year(r.expenseTime) ,sum(r.personsalPay), sum(r.expensePay) from Expense as r where check=2 and isDelete=false group by year(r.expenseTime) ";
		return session.createQuery(hql).list();
	}
	

}
