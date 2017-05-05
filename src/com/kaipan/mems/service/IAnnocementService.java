package com.kaipan.mems.service;

import com.kaipan.mems.domain.Announcement;
import com.kaipan.mems.utils.PageBean;

public interface IAnnocementService {
	public void pageQuery(PageBean pageBean);

	public Announcement findAnnouncementById(String annId);
}
