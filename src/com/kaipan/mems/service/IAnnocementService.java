package com.kaipan.mems.service;

import com.kaipan.mems.domain.Announcement;
import com.kaipan.mems.utils.PageBean;

public interface IAnnocementService {
	public void pageQuery(PageBean pageBean);

	public Announcement findAnnouncementById(String annId);

	public void deleteAnn(String annId);

	public void update(Announcement updateannouncement);

	public void deletebatch(String ids);

	public void save(Announcement updateannouncement);
}
