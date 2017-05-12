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
import com.kaipan.mems.service.IUserService;
import com.kaipan.mems.utils.JsonDateValueProcessor;
import com.kaipan.mems.utils.MD5Utils;
import com.kaipan.mems.utils.PageBean;
import com.kaipan.mems.web.action.base.BaseAction;

import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;


@Controller
@Scope("prototype")
public class UserAction extends BaseAction<Userinfo> {
	
	@Resource
	private IUserService userService;
	
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
	
	private Userinfo userinfo;
	
	public Userinfo getUserinfo() {
		return userinfo;
	}
	
	public void setUserinfo(Userinfo userinfo) {
		this.userinfo = userinfo;
	}
	
	public String login(){
		String key=(String)ServletActionContext.getRequest().getSession().getAttribute("key");
		
		if(StringUtils.isNotBlank(checkcode)&&checkcode.equals(key)){
			Userinfo userinfo=userService.login(model);
			
			if(userinfo != null){
				//��¼�ɹ�,��User����session����ת��ϵͳ��ҳ
				if(userinfo.getImgsrc()==null){
					userinfo.setImgsrc("${pageContext.request.contextPath}/images/photo.jpg");
				}
				ServletActionContext.getRequest().getSession().setAttribute("loginUser", userinfo);
				return "home";
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
	 * �û��˳�
	 */
	public String logout(){
		//����session
		ServletActionContext.getRequest().getSession().invalidate();
		return "login";
	}
	
	/**
	 * �û���ҳ
	 */
	public String home() {
		return "home";
	}
	
	/**
	 * �޸ĵ�ǰ��¼�û�����
	 * @throws IOException 
	 */
	public String editPassword() throws IOException{
		Userinfo user = (Userinfo) ServletActionContext.getRequest().getSession().getAttribute("loginUser");
		String password = model.getPassword();//������
		password = MD5Utils.md5(password);
		oldPwd=MD5Utils.md5(model.getName());
		String flag = "1";
		if(!user.getPassword().equals(oldPwd)){
			flag = "0";
			return NONE;
		}
		try{
			userService.editPassword(password,user.getStuOrEmpId());
		}catch (Exception e) {
			//�޸�����ʧ��
			flag = "0";
		}
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().print(flag);
		return NONE;
	}
	
	public String userinfo(){
		return "success";
	}
	
	
	/**
	 * �޸��û���Ϣ
	 * @return
	 * @throws IOException
	 */
	public String changeinfo() throws IOException{
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		if((model.getAge()==null)&&(model.getGraduationYear()==null)&&model.getEmail().equals("")&&model.getPhoneNo().equals(""))
		{
			ServletActionContext.getResponse().getWriter().print("failed");
		}
		else{
			Userinfo user = (Userinfo) ServletActionContext.getRequest().getSession().getAttribute("loginUser");
			if(model.getAge()!=null){
				user.setAge(model.getAge());
			}
			if(model.getGraduationYear()!=null){
				user.setGraduationYear(model.getGraduationYear());
			}
			if(!model.getEmail().equals("")){
				user.setEmail(model.getEmail());
			}
			if(!model.getPhoneNo().equals("")){
				user.setPhoneNo(model.getPhoneNo());
			}
			try {
				userService.update(user);
			} catch (Exception e) {
				ServletActionContext.getResponse().getWriter().print("failed");
			}
			ServletActionContext.getResponse().getWriter().print("success");;
		}
		return NONE;
	}
	

	/**
	 * ��ҳ��ѯ�û�����
	 * @throws IOException 
	 */
	public String userinfos() throws IOException{
		PageBean pageBean = new PageBean();
		pageBean.setCurrentPage(page);
		pageBean.setPageSize(rows);
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Userinfo.class);
		String key=ServletActionContext.getRequest().getParameter("key");
		if(key!=null&&key!=""){
			detachedCriteria.add(Restrictions.or(Restrictions.like("stuOrEmpId", "%"+key+"%"), Restrictions.like("name", "%"+key+"%")));
		}
		String sex=ServletActionContext.getRequest().getParameter("sex");
		if(sex!=null&&sex!=""){
			Boolean bsex=Boolean.parseBoolean(sex);
			detachedCriteria.add(Restrictions.eq("sex", bsex));
		}
		String roleId=ServletActionContext.getRequest().getParameter("roleId");
		
		if(roleId!=null&&roleId!=""){
			int role=Integer.parseInt(roleId);
			detachedCriteria.add(Restrictions.eq("roleId", roleId));
		}
		pageBean.setDetachedCriteria(detachedCriteria);
		userService.pageQuery(pageBean);
		
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
	 * ����id��ѯ����userinfo,�����ص�����Ա��Ϣ��ʾҳ��
	 * @throws IOException 
	 */
	public String userinfoDetail() throws IOException{
		String stuOrEmpId=ServletActionContext.getRequest().getParameter("stuOrEmpId");
		this.userinfo=userService.findById(stuOrEmpId);
		return "detail";
	}
	
	/**
	 * ����idɾ������Ա
	 * @throws IOException 
	 */
	public String deleteuser() throws IOException{
		String stuOrEmpId=ServletActionContext.getRequest().getParameter("stuOrEmpId");
		String flag = "1";
		try{
			userService.deleteuser(stuOrEmpId);
		}catch (Exception e) {
			//�޸�����ʧ��
			flag = "0";
		}
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().print(flag);
		return NONE;
	}
	
	
	/**
	 * �����û�����
	 * @throws IOException 
	 */
	public String resetPassword() throws IOException{
		String stuOrEmpId=ServletActionContext.getRequest().getParameter("stuOrEmpId");
		String pwd=MD5Utils.md5("000000");
		String flag = "1";
		try{
			userService.editPassword(pwd,stuOrEmpId);
		}catch (Exception e) {
			//�޸�����ʧ��
			flag = "0";
		}
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().print(flag);
		return NONE;
	}
	
	/**
	 * ����id����ɾ���û�
	 * @throws IOException 
	 */
	public String deletebatch() throws IOException{
		String ids=ServletActionContext.getRequest().getParameter("ids");
		try{
			userService.deletebatch(ids);
		}catch (Exception e) {
			//�޸�����ʧ��
		}
		return "list";
	}
}
