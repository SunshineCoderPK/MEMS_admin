package com.kaipan.mems.web.action;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.apache.struts2.ServletActionContext;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.aop.ThrowsAdvice;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.kaipan.mems.domain.Admininfo;
import com.kaipan.mems.domain.Announcement;
import com.kaipan.mems.service.IAnnocementService;
import com.kaipan.mems.utils.JsonDateValueProcessor;
import com.kaipan.mems.utils.PageBean;
import com.kaipan.mems.web.action.base.BaseAction;
import com.sun.org.apache.bcel.internal.generic.NEW;

import javassist.expr.NewArray;

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
	
	
	private String annId;
	
	public String getAnnId() {
		return annId;
	}
	
	public void setAnnId(String annId) {
		this.annId = annId;
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
		String searchkey=ServletActionContext.getRequest().getParameter("key");
		if(searchkey!=null&&!searchkey.isEmpty()){
			detachedCriteria.add(Restrictions.or(Restrictions.or(Restrictions.like("annId", "%"+searchkey+"%"), 
					Restrictions.like("annTitle", "%"+searchkey+"%")),Restrictions.like("annContent", "%"+searchkey+"%")));
		}
		String datemin=ServletActionContext.getRequest().getParameter("datemin");
		if(datemin!=null&&!datemin.isEmpty()){
			try {
				SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd"); 
				Date minDate=df.parse(datemin);
				detachedCriteria.add(Restrictions.ge("publishTime", minDate));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		String datemax=ServletActionContext.getRequest().getParameter("datemax");
		if(datemax!=null&&!datemax.isEmpty()){
			try {
				SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd"); 
				Date maxDate=df.parse(datemax);
				detachedCriteria.add(Restrictions.le("publishTime", maxDate));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
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
	

	/**
	 * 根据id查找公告
	 * @throws IOException 
	 */
	public String findAnnouncementById() throws IOException{
		Announcement announcement=annocementService.findAnnouncementById(model.getAnnId());
		String[] excludes = new String[]{};
		this.writeObject2Json(announcement,excludes);
		return NONE;
	}
	
	
	/**
	 * 根据id删除公告
	 * @throws IOException 
	 */
	public String deleteAnn() throws IOException{
		String annId=ServletActionContext.getRequest().getParameter("annId");
		String flag = "1";
		try{
			annocementService.deleteAnn(annId);
		}catch (Exception e) {
			//删除失败
			flag = "0";
		}
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().print(flag);
		return NONE;
	}
	
	

	/**
	 * 跟据id修改公告信息
	 * @return
	 * @throws IOException
	 */
	public String changeAnn() throws IOException{
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		String annId1=ServletActionContext.getRequest().getParameter("annId");
		if(annId1==null||annId1==""){
			ServletActionContext.getResponse().getWriter().print("failed");
			return NONE;
		}
		model.setAnnContent(ServletActionContext.getRequest().getParameter("annContent"));
		Announcement updateannouncement=annocementService.findAnnouncementById(annId1);
		if(!model.getAnnTitle().isEmpty()){
			updateannouncement.setAnnTitle(model.getAnnTitle());
		}
	    if(!model.getAnnContent().contains("\n\n")){
	    	updateannouncement.setAnnContent(model.getAnnContent());
	    }
		try {
			annocementService.update(updateannouncement);
		} catch (Exception e) {
			ServletActionContext.getResponse().getWriter().print("failed");
		}
		ServletActionContext.getResponse().getWriter().print("success");
		return NONE;
	}
	
	/**
	 * 根据id返回修改公告信息界面和传递id信息
	 * @throws IOException 
	 */
	public String changeAnninfo() throws IOException{
		this.annId=ServletActionContext.getRequest().getParameter("annId");
		return "change";
	}
	
	/**
	 * 根据id批量删除公告
	 * @throws IOException 
	 */
	public String deletebatch() throws IOException{
		String ids=ServletActionContext.getRequest().getParameter("ids");
		try{
			annocementService.deletebatch(ids);
		}catch (Exception e) {
			//修改密码失败
		}
		return "list";
	}
	
	/**
	 * 发布公告信息
	 * @return
	 * @throws IOException
	 */
	public String publishAnn() throws IOException{
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		Admininfo admininfo=(Admininfo)ServletActionContext.getRequest().getSession().getAttribute("loginUser");
		model.setAnnContent(ServletActionContext.getRequest().getParameter("annContent"));
		Admininfo newadmin=new Admininfo();
		newadmin.setEmpId(admininfo.getEmpId());
		Announcement updateannouncement=new Announcement();
		int random = (int) (Math.random() * 10000); // 随机数
		SimpleDateFormat dft = new SimpleDateFormat("yyyyMMdd");//设置日期格式
		String annId = dft.format(new Date()) +""+ random; // 通过得到系统时间加随机数生成新文件名，避免重复
		updateannouncement.setAnnId(annId);
		updateannouncement.setAdmininfo(newadmin);
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		updateannouncement.setPublishTime(new Date());
		updateannouncement.setIsDelete(false);
		if(!model.getAnnTitle().isEmpty()){
			updateannouncement.setAnnTitle(model.getAnnTitle());
		}
	    if(!model.getAnnContent().contains("\n\n")){
	    	updateannouncement.setAnnContent(model.getAnnContent());
	    }
		try {
			annocementService.save(updateannouncement);
		} catch (Exception e) {
			ServletActionContext.getResponse().getWriter().print("failed");
		}
		ServletActionContext.getResponse().getWriter().print("success");
		return NONE;
	}
	
	
}
