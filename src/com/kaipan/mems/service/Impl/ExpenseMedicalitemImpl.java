package com.kaipan.mems.service.Impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kaipan.mems.dao.IExpensemedicalitemDao;
import com.kaipan.mems.domain.Expensemedicalitem;
import com.kaipan.mems.service.IExpensemedicalitemService;

@Service
@Transactional
public class ExpenseMedicalitemImpl implements IExpensemedicalitemService{
	@Autowired
	private IExpensemedicalitemDao expensemedicalitemDao;
	
	@Override
	public void add(Expensemedicalitem expensemedicalitem) {
		expensemedicalitemDao.save(expensemedicalitem);
	}
	
	@Override
	public void doDelete(String expenseNum) {
		expensemedicalitemDao.executeUpdate("dodeletemedicalitem", expenseNum);
	}

}
