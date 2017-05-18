package com.kaipan.mems.service;

import com.kaipan.mems.domain.Expensemedicalitem;

public interface IExpensemedicalitemService {

	public void add(Expensemedicalitem expensemedicalitem);

	public void doDelete(String expenseNum);

}
