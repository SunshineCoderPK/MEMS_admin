package com.kaipan.mems.web.interceptor;

import org.apache.struts2.ServletActionContext;
import com.opensymphony.xwork2.ActionProxy;
import com.kaipan.mems.domain.Admininfo;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;

/**
 * 自定义一个struts2拦截器，实现用户未登录，自动跳转到登录页面
 * 
 * @author pankai
 * 
 */
public class MemsLoginInterceptor extends MethodFilterInterceptor {
	// 拦截方法
	protected String doIntercept(ActionInvocation invocation) throws Exception {
		Admininfo admin = (Admininfo) ServletActionContext.getRequest().getSession().getAttribute("loginAdmin");
		if(admin == null){
			//未登录，跳转到登录页面
			return "login";
		}
		return invocation.invoke();// 放行
	}
}
