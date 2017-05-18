package com.kaipan.mems.service.Impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kaipan.mems.dao.IExpensemedicineDao;
import com.kaipan.mems.domain.Expensemedicine;
import com.kaipan.mems.service.IExpensemedicineService;

@Service
@Transactional
public class ExpensemdeicineServiceImpl implements IExpensemedicineService{
	@Autowired
	private IExpensemedicineDao expensemedicineDao;
	
	@Override
	public void add(Expensemedicine expensemedicine) {
		expensemedicineDao.save(expensemedicine);
	}
	
	@Override
	public void doDelete(String expenseNum) {
		expensemedicineDao.executeUpdate("dodeletemedicine", expenseNum);
	}

}
