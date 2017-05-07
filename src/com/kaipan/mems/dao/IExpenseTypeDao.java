package com.kaipan.mems.dao;

import com.kaipan.mems.dao.base.IBaseDao;
import com.kaipan.mems.domain.Expensetype;

public interface IExpenseTypeDao extends IBaseDao<Expensetype>{

	Expensetype findExpensetype(int userRoleId, String medicalTyp, boolean isRetire, int hospTyp);

	Expensetype findExpensetype(int userRoleId, String medicalTyp, boolean isRetire, int hospTyp, boolean healthCard);

}
