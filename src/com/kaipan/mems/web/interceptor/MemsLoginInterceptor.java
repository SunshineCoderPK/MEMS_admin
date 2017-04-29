package com.kaipan.mems.web.interceptor;

import org.apache.struts2.ServletActionContext;
import com.opensymphony.xwork2.ActionProxy;
import com.kaipan.mems.domain.Userinfo;
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
		Userinfo user = (Userinfo) ServletActionContext.getRequest().getSession().getAttribute("loginUser");
		if(user == null){
			//未登录，跳转到登录页面
			return "login";
		}
		return invocation.invoke();// 放行
	}
}
