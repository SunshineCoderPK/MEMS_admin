package com.kaipan.mems.web.action;

import java.io.IOException;

import javax.annotation.Resource;
import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.kaipan.mems.domain.Userinfo;
import com.kaipan.mems.service.IUserService;
import com.kaipan.mems.utils.MD5Utils;
import com.kaipan.mems.web.action.base.BaseAction;


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
}
