package com.kaipan.mems.service;

import com.kaipan.mems.domain.Expensetype;
import com.kaipan.mems.utils.PageBean;

public interface IExpenseTypeService {

	public void pageQuery(PageBean pageBean);

	public Expensetype findExpensetype(int userRoleId, String medicalTyp, boolean isRetire, int hospTyp);

	public Expensetype findExpensetype(int userRoleId, String medicalTyp, boolean isRetire, int hospTyp,
			boolean healthCard);

}
