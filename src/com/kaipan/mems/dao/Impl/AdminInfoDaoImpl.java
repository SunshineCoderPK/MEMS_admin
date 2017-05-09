package com.kaipan.mems.dao.Impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.kaipan.mems.dao.IAdminInfoDao;
import com.kaipan.mems.dao.base.Impl.BaseDaoImpl;
import com.kaipan.mems.domain.Admininfo;
import com.kaipan.mems.domain.Userinfo;

@Repository
public class AdminInfoDaoImpl extends BaseDaoImpl<Admininfo> implements IAdminInfoDao {
	@Override
	public Admininfo findByIdAndPwd(String empId, String pwd) {
		String hql="FROM Admininfo u WHERE u.empId = ? AND u.password = ?";
		List<Object> list=(this.getHibernateTemplate().find(hql,empId,pwd));
		
		if(list!=null&&list.size()>0){
			return (Admininfo)list.get(0);
		}
		else {
			return null;
		}
	}
}
