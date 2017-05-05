package com.kaipan.mems.web.action;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.apache.struts2.ServletActionContext;
import org.hibernate.criterion.DetachedCriteria;
import org.springframework.aop.ThrowsAdvice;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.kaipan.mems.domain.Announcement;
import com.kaipan.mems.service.IAnnocementService;
import com.kaipan.mems.utils.JsonDateValueProcessor;
import com.kaipan.mems.utils.PageBean;
import com.kaipan.mems.web.action.base.BaseAction;

/**
 * 公告管理
 * @author pankai
 *
 */
@Controller
@Scope("prototype")
public class AnnocementAction extends BaseAction<Announcement>{

	@Resource
	private IAnnocementService annocementService;
	
	
	private int page;//页码
	private int rows;//每页显示的记录数
	public void setRows(int rows) {
		this.rows = rows;
	}
	
	public void setPage(int page) {
		this.page = page;
	}
	
	/**
	 * 分页查询方法
	 * @throws IOException 
	 */
	public String pageQuery() throws IOException{
		PageBean pageBean = new PageBean();
		pageBean.setCurrentPage(page);
		pageBean.setPageSize(rows);
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Announcement.class);
		pageBean.setDetachedCriteria(detachedCriteria);
		annocementService.pageQuery(pageBean);
		
		//将PageBean对象转为json返回
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setExcludes(new String[]{"currentPage","detachedCriteria","pageSize"});
		jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor()); 
		JSONObject jsonObject = JSONObject.fromObject(pageBean, jsonConfig);
		String json = jsonObject.toString();
		ServletActionContext.getResponse().setContentType("text/json;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().print(json);
		return NONE;
	}
	
	
	public String findAnnouncementById() throws IOException{
		Announcement announcement=annocementService.findAnnouncementById(model.getAnnId());
		String[] excludes = new String[]{};
		this.writeObject2Json(announcement,excludes);
		return NONE;
	}
	
	
}
