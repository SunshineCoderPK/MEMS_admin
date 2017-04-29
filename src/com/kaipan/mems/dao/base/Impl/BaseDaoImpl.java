package com.kaipan.mems.dao.base.Impl;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;
import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.kaipan.mems.dao.base.IBaseDao;

public abstract class BaseDaoImpl<T>extends HibernateDaoSupport implements IBaseDao<T> {
	//实体类型
		private Class<T> entityClass;
		//使用注解方式进行依赖注入
		@Resource
		public void setMySessionFactory(SessionFactory sessionFactory){
			super.setSessionFactory(sessionFactory);
		}
		
		/**
		 * 在构造方法中动态获得操作的实体类型
		 */
		public BaseDaoImpl() {
			//获得父类（BaseDaoImpl<T>）类型
			ParameterizedType genericSuperclass = (ParameterizedType) this.getClass().getGenericSuperclass();
			//获得父类上的泛型数组
			Type[] actualTypeArguments = genericSuperclass.getActualTypeArguments();
			entityClass = (Class<T>) actualTypeArguments[0];
		}
		
		public void save(T entity) {
			this.getHibernateTemplate().save(entity);
		}

		public void delete(T entity) {
			this.getHibernateTemplate().delete(entity);
		}

		public void update(T entity) {
			this.getHibernateTemplate().update(entity);
		}

		public T findById(Serializable id) {
			return this.getHibernateTemplate().get(entityClass, id);
		}

		public List<T> findAll() {//FROM User
			String hql = "FROM  " + entityClass.getSimpleName();
			return (List<T>)(this.getHibernateTemplate().find(hql));
		}

		
//		@Override
//		public void executeUpdate(String queryName, Object... objects) {
//		// TODO Auto-generated method stub
//		
//		}
}
