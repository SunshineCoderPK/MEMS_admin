package com.kaipan.mems.service;

import java.util.List;

import com.kaipan.mems.domain.Expensetype;
import com.kaipan.mems.utils.PageBean;

public interface IExpenseTypeService {

	public void pageQuery(PageBean pageBean);

	public Expensetype findExpensetype(int userRoleId, String medicalTyp, boolean isRetire, int hospTyp);

	public Expensetype findExpensetype(int userRoleId, String medicalTyp, boolean isRetire, int hospTyp,
			boolean healthCard);

	public void delexpensetype(int parseInt);

	public void deletebatch(String ids);

	public void saveBatch(List<Expensetype> list);

	public Expensetype findById(int id);

	public void update(Expensetype expensetype1);

	public void save(Expensetype model);

}
