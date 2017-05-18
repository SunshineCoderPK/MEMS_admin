package com.kaipan.mems.dao;

import java.util.List;

import com.kaipan.mems.dao.base.IBaseDao;
import com.kaipan.mems.domain.Expense;

public interface IExpenseDao extends IBaseDao<Expense>{

	List<Integer> findAllYear();

	List accByYear();


}
