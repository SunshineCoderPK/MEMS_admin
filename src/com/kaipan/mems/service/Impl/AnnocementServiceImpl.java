package com.kaipan.mems.service.Impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kaipan.mems.utils.PageBean;
import com.kaipan.mems.dao.IAnnocementDao;
import com.kaipan.mems.domain.Announcement;
import com.kaipan.mems.service.IAnnocementService;

@Service
@Transactional
public class AnnocementServiceImpl implements IAnnocementService{
	@Autowired
	private IAnnocementDao annocementDao;
	
	public void pageQuery(PageBean pageBean) {
		annocementDao.pageQuery(pageBean);
	}
	
	@Override
	public Announcement findAnnouncementById(String annId) {
		return annocementDao.findById(annId);
	}
	
	@Override
	public void deleteAnn(String annId) {
		boolean isDelete=true;
		annocementDao.executeUpdate("delAnn", isDelete,annId);
	}
	
	@Override
	public void update(Announcement updateannouncement) {
		annocementDao.update(updateannouncement);
	}
	
	@Override
	public void deletebatch(String ids) {
		boolean isDelete=true;
		String[] staffIds = ids.split(",");
		for (String id : staffIds) {
			annocementDao.executeUpdate("delAnn",isDelete, id);
		}
	}
	
	@Override
	public void save(Announcement updateannouncement) {
		annocementDao.save(updateannouncement);
	}
}
