package com.kaipan.mems.web.action;

import javax.annotation.Resource;
import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.kaipan.mems.domain.Userinfo;
import com.kaipan.mems.service.IUserService;
import com.kaipan.mems.web.action.base.BaseAction;


@Controller
@Scope("prototype")
public class UserAction extends BaseAction<Userinfo> {
	
	@Resource
	private IUserService userService;
	
	private String checkcode;
	
	public void setCheckcode(String checkcode) {
		this.checkcode = checkcode;
	}
	
	public String login(){
		String key=(String)ServletActionContext.getRequest().getSession().getAttribute("key");
		
		if(StringUtils.isNotBlank(checkcode)&&checkcode.equals(key)){
			Userinfo userinfo=userService.login(model);
			
			if(userinfo != null){
				//登录成功,将User放入session域，跳转到系统首页
				ServletActionContext.getRequest().getSession().setAttribute("loginUser", userinfo);
				return "home";
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
	 * 用户退出
	 */
	public String logout(){
		//销毁session
		ServletActionContext.getRequest().getSession().invalidate();
		return "login";
	}
	
	/**
	 * 用户主页
	 */
	public String home() {
		return "home";
	}
}
