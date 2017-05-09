package com.kaipan.mems.web.action;

import java.io.IOException;
import java.util.Date;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.kaipan.mems.domain.Admininfo;
import com.kaipan.mems.service.IAdminInfoService;
import com.kaipan.mems.utils.JsonDateValueProcessor;
import com.kaipan.mems.utils.MD5Utils;
import com.kaipan.mems.utils.PageBean;
import com.kaipan.mems.web.action.base.BaseAction;

import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;


/**
 * @author PanKai
 *
 */

@Controller
@Scope("prototype")
public class AdminAction extends BaseAction<Admininfo>{
	@Resource
	private IAdminInfoService adminInfoService;
	
	private String checkcode;
	
	private String oldPwd;
	
	public void setCheckcode(String checkcode) {
		this.checkcode = checkcode;
	}
	
	private int page;//页码
	private int rows;//每页显示的记录数
	public void setRows(int rows) {
		this.rows = rows;
	}
	
	public void setPage(int page) {
		this.page = page;
	}
    
	
	private Admininfo admininfo;
	
	private String empId;
	
	
	public Admininfo getAdmininfo() {
		return admininfo;
	}
	
	public void setAdmininfo(Admininfo admininfo) {
		this.admininfo = admininfo;
	}
	
	
	public String getEmpId() {
		return empId;
	}
	
	public void setEmpId(String empId) {
		this.empId = empId;
	}
    
	/**
	 * 管理员登陆
	 * @return
	 */
	public String login(){
		String key=(String)ServletActionContext.getRequest().getSession().getAttribute("key");
		
		if(StringUtils.isNotBlank(checkcode)&&checkcode.equals(key)){
			Admininfo admininfo=adminInfoService.login(model);
			
			if(admininfo != null){
				//登录成功,将admininfo放入session域，跳转到系统首页
				if(admininfo.getImgsrc()==null){
					admininfo.setImgsrc("${pageContext.request.contextPath}/images/photo.jpg");
				}
				ServletActionContext.getRequest().getSession().setAttribute("loginUser", admininfo);
				if(admininfo.getRoleId()==1){
					return "super";
				}
				else{
					return "admin";
				}	
			}else{
				//登录失败，设置错误提示信息，跳转到登录页面
				this.addActionError(this.getText("loginError"));
				return "login";
			}
			
		}
		else{
			//验证码错误,设置错误提示信息，跳转到登录页面
			this.addActionError(this.getText("validateCodeError"));
			return "login";
		}
	}
	
	
	/**
	 * 管理员主页
	 */
	public String adminIndex() {
		return "home";
	}
	
	/**
	 * 超级管理员主页
	 */
	public String superIndex() {
		return "home";
	}
	
	/**
	 * 用户退出
	 */
	public String logout(){
		//销毁session
		ServletActionContext.getRequest().getSession().invalidate();
		return "login";
	}
	
	/**
	 * 分页查询管理员方法
	 * @throws IOException 
	 */
	public String admininfos() throws IOException{
		PageBean pageBean = new PageBean();
		pageBean.setCurrentPage(page);
		pageBean.setPageSize(rows);
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Admininfo.class);
		detachedCriteria.add(Restrictions.or(Restrictions.isNull("isDelete"),Restrictions.eq("isDelete", false)));
		String key=ServletActionContext.getRequest().getParameter("key");
		if(key!=null&&key!=""){
			detachedCriteria.add(Restrictions.or(Restrictions.like("empId", "%"+key+"%"), Restrictions.like("name", "%"+key+"%")));
		}
        
		pageBean.setDetachedCriteria(detachedCriteria);
		adminInfoService.pageQuery(pageBean);
		
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
	 * 根据id查询具体admininfo,并返回到管理员信息显示页面
	 * @throws IOException 
	 */
	public String admininfoDetail() throws IOException{
		String empId=ServletActionContext.getRequest().getParameter("empId");
		this.admininfo=adminInfoService.findById(empId);
		return "detail";
	}
	
	/**
	 * 重置管理员密码
	 * @throws IOException 
	 */
	public String resetPassword() throws IOException{
		String empId=ServletActionContext.getRequest().getParameter("empId");
		String pwd=MD5Utils.md5("000000");
		String flag = "1";
		try{
			adminInfoService.editPassword(pwd,empId);
		}catch (Exception e) {
			//修改密码失败
			flag = "0";
		}
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().print(flag);
		return NONE;
	}
	
	/**
	 * 根据id删除管理员
	 * @throws IOException 
	 */
	public String deleteAdmin() throws IOException{
		String empId=ServletActionContext.getRequest().getParameter("empId");
		String flag = "1";
		try{
			adminInfoService.deleteAdmin(empId);
		}catch (Exception e) {
			//修改密码失败
			flag = "0";
		}
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().print(flag);
		return NONE;
	}
	

	/**
	 * 根据id返回修改管理员信息界面和传递id信息
	 * @throws IOException 
	 */
	public String changeAdmin() throws IOException{
		this.empId=ServletActionContext.getRequest().getParameter("empId");
		return "change";
	}
}

