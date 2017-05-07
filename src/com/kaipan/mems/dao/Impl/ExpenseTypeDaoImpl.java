package com.kaipan.mems.dao.Impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.kaipan.mems.dao.IExpenseTypeDao;
import com.kaipan.mems.dao.base.Impl.BaseDaoImpl;
import com.kaipan.mems.domain.Expensetype;
import com.kaipan.mems.domain.Userinfo;

@Repository
public class ExpenseTypeDaoImpl extends BaseDaoImpl<Expensetype> implements IExpenseTypeDao {
	@Override
	public Expensetype findExpensetype(int userRoleId, String medicalTyp, boolean isRetire, int hospTyp) {
		String hql="FROM Expensetype u WHERE u.userRoleId = ? AND u.medicalTyp = ? AND u.isRetire = ? AND u.hosptyp = ?";
		List<Object> list=(this.getHibernateTemplate().find(hql,userRoleId,medicalTyp,isRetire,hospTyp));
		
		if(list!=null&&list.size()>0){
			return (Expensetype)list.get(0);
		}
		else {
			return null;
		}
	}
	
	
	@Override
	public Expensetype findExpensetype(int userRoleId, String medicalTyp, boolean isRetire, int hospTyp,
			boolean healthCard) {
		String hql="FROM Expensetype u WHERE u.userRoleId = ? AND u.medicalTyp = ? AND u.isRetire = ? AND u.hosptyp = ? AND u.healthCard = ? ";
		List<Object> list=(this.getHibernateTemplate().find(hql,userRoleId,medicalTyp,isRetire,hospTyp,healthCard));
		
		if(list!=null&&list.size()>0){
			return (Expensetype)list.get(0);
		}
		else {
			return null;
		}
	}
}
