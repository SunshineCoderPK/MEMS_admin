package com.kaipan.mems.dao.base;


import java.io.Serializable;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.kaipan.mems.utils.PageBean;

/**
 * 通用接口，增删改查
 * @author PanKai
 *
 * @param <T>
 */
public interface IBaseDao<T> {
	public void save(T entity);
	public void delete(T entity);
	public void update(T entity);
	public T findById(Serializable id);
	public void saveOrUpdate(T entity);
	public List<T> findAll();
	
	public void executeUpdate(String queryName,Object ...objects);
	public List<T> execute(String queryName,Object ...objects);
	public void pageQuery(PageBean pageBean);
	public List<T> findByCriteria(DetachedCriteria detachedCriteria);
	

}
