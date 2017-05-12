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
import com.kaipan.mems.domain.Userinfo;
import com.kaipan.mems.service.IAdminInfoService;
import com.kaipan.mems.utils.JsonDateValueProcessor;
import com.kaipan.mems.utils.MD5Utils;
import com.kaipan.mems.utils.PageBean;
import com.kaipan.mems.web.action.base.BaseAction;
import com.sun.xml.internal.bind.v2.runtime.MarshallerImpl;

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
	
	private int page;//ҳ��
	private int rows;//ÿҳ��ʾ�ļ�¼��
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
	 * ����Ա��½
	 * @return
	 */
	public String login(){
		String key=(String)ServletActionContext.getRequest().getSession().getAttribute("key");
		
		if(StringUtils.isNotBlank(checkcode)&&checkcode.equals(key)){
			Admininfo admininfo=adminInfoService.login(model);
			
			if(admininfo != null){
				//��¼�ɹ�,��admininfo����session����ת��ϵͳ��ҳ
				if(admininfo.getImgsrc()==null){
					admininfo.setImgsrc("${pageContext.request.contextPath}/images/photo.jpg");
				}
				ServletActionContext.getRequest().getSession().setAttribute("loginAdmin", admininfo);
				if(admininfo.getRoleId()==1){
					return "super";
				}
				else{
					return "admin";
				}	
			}else{
				//��¼ʧ�ܣ����ô�����ʾ��Ϣ����ת����¼ҳ��
				this.addActionError(this.getText("loginError"));
				return "login";
			}
			
		}
		else{
			//��֤�����,���ô�����ʾ��Ϣ����ת����¼ҳ��
			this.addActionError(this.getText("validateCodeError"));
			return "login";
		}
	}
	
	
	/**
	 * ����Ա��ҳ
	 */
	public String adminIndex() {
		return "home";
	}
	
	/**
	 * ��������Ա��ҳ
	 */
	public String superIndex() {
		return "home";
	}
	
	/**
	 * �û��˳�
	 */
	public String logout(){
		//����session
		ServletActionContext.getRequest().getSession().invalidate();
		return "login";
	}
	
	/**
	 * ��ҳ��ѯ����Ա����
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
		
		//��PageBean����תΪjson����
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
	 * ����id��ѯ����admininfo,�����ص�����Ա��Ϣ��ʾҳ��
	 * @throws IOException 
	 */
	public String admininfoDetail() throws IOException{
		String empId=ServletActionContext.getRequest().getParameter("empId");
		this.admininfo=adminInfoService.findById(empId);
		return "detail";
	}
	
	/**
	 * ���ù���Ա����
	 * @throws IOException 
	 */
	public String resetPassword() throws IOException{
		String empId=ServletActionContext.getRequest().getParameter("empId");
		String pwd=MD5Utils.md5("000000");
		String flag = "1";
		try{
			adminInfoService.editPassword(pwd,empId);
		}catch (Exception e) {
			//�޸�����ʧ��
			flag = "0";
		}
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().print(flag);
		return NONE;
	}
	
	/**
	 * ����idɾ������Ա
	 * @throws IOException 
	 */
	public String deleteAdmin() throws IOException{
		String empId=ServletActionContext.getRequest().getParameter("empId");
		String flag = "1";
		try{
			adminInfoService.deleteAdmin(empId);
		}catch (Exception e) {
			//�޸�����ʧ��
			flag = "0";
		}
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().print(flag);
		return NONE;
	}
	

	/**
	 * ����id�����޸Ĺ���Ա��Ϣ����ʹ���id��Ϣ
	 * @throws IOException 
	 */
	public String changeAdmin() throws IOException{
		this.empId=ServletActionContext.getRequest().getParameter("empId");
		return "change";
	}
	
	/**
	 * ��������Ա����id�޸Ĺ���Ա��Ϣ
	 * @return
	 * @throws IOException
	 */
	public String changeadmininfo() throws IOException{
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		String empId1=ServletActionContext.getRequest().getParameter("empId");
		if(empId1==null||empId1==""){
			ServletActionContext.getResponse().getWriter().print("failed");
			return NONE;
		}
		String sex=ServletActionContext.getRequest().getParameter("sex");
		
		Admininfo updateadmin = adminInfoService.findById(empId1);
		String empIding=null;
		if(sex!=null)
		{
			if(sex.equals("1")){
				updateadmin.setSex(true);
			}
			else{
				updateadmin.setSex(false);
			}
		}
		else{
			empIding=((Admininfo)ServletActionContext.getRequest().getSession().getAttribute("loginAdmin")).getEmpId();
		}
		if(model.getAge()!=null){
			updateadmin.setAge(model.getAge());
		}
		if(model.getName()!=null&&!model.getName().isEmpty()){
			updateadmin.setName(model.getName());
		}
		if(model.getDepartment()!=null&&!model.getDepartment().isEmpty()){
			updateadmin.setDepartment(model.getDepartment());
		}
		if(model.getEmail()!=null&&!model.getEmail().isEmpty()){
			updateadmin.setEmail(model.getEmail());
		}
		if(model.getIdcard()!=null&&!model.getIdcard().isEmpty()){
			updateadmin.setIdcard(model.getIdcard());
		}
		if(model.getJob()!=null&&!model.getJob().isEmpty()){
			updateadmin.setJob(model.getJob());
		}
		if(model.getPhoneNo()!=null&&!model.getPhoneNo().isEmpty()){
			updateadmin.setPhoneNo(model.getPhoneNo());
		}
		if(model.getRemark()!=null&&!model.getRemark().isEmpty()){
			updateadmin.setRemark(model.getRemark());
		}
		try {
			adminInfoService.update(updateadmin);
		} catch (Exception e) {
			ServletActionContext.getResponse().getWriter().print("failed");
		}
		if(empIding!=null){
			Admininfo admininfoing=adminInfoService.findById(empIding);
			ServletActionContext.getRequest().getSession().setAttribute("loginAdmin", admininfoing);
	    }
		ServletActionContext.getResponse().getWriter().print("success");

		return NONE;
	}
	
	
	/**
	 * ����id����ɾ������Ա
	 * @throws IOException 
	 */
	public String deletebatch() throws IOException{
		String ids=ServletActionContext.getRequest().getParameter("ids");
		try{
			adminInfoService.deletebatch(ids);
		}catch (Exception e) {
			//�޸�����ʧ��
		}
		return "list";
	}
	
	/**
	 * ע�����Ա
	 * @throws IOException 
	 */
	public String addadmin() throws IOException{
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		String sex=ServletActionContext.getRequest().getParameter("sex");
		if(sex.equals("1")){
			model.setSex(true);
		}
		else{
			model.setSex(false);
		}
		model.setRoleId(2);
		model.setIsDelete(false);
		model.setImgsrc("\\img\\user\\user_default.png");
		model.setPassword(MD5Utils.md5(model.getPassword()));
		try{
			adminInfoService.addadmin(model);
		}catch (Exception e) {
			//ע��ʧ��
			ServletActionContext.getResponse().getWriter().print("failed");
			return NONE;
		}
		ServletActionContext.getResponse().getWriter().print("success");
		return NONE;
	}
}

