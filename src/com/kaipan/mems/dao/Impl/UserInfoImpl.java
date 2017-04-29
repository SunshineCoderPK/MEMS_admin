package com.kaipan.mems.dao.Impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.kaipan.mems.dao.IUserInfoDao;
import com.kaipan.mems.dao.base.Impl.BaseDaoImpl;
import com.kaipan.mems.domain.Userinfo;


@Repository
public class UserInfoImpl extends BaseDaoImpl<Userinfo> implements IUserInfoDao {
	@Override
	public Userinfo findByUsernameAndPassword(String username, String password) {
		
		String hql="FROM Userinfo u WHERE u.stuOrEmpId = ? AND u.password = ?";
		List<Object> list=(this.getHibernateTemplate().find(hql,username,password));
		
		if(list!=null&&list.size()>0){
			return (Userinfo)list.get(0);
		}
		else {
			return null;
		}
	}
}
