package com.kaipan.mems.web.interceptor;

import org.apache.struts2.ServletActionContext;
import com.opensymphony.xwork2.ActionProxy;
import com.kaipan.mems.domain.Admininfo;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;

/**
 * �Զ���һ��struts2��������ʵ���û�δ��¼���Զ���ת����¼ҳ��
 * 
 * @author pankai
 * 
 */
public class MemsLoginInterceptor extends MethodFilterInterceptor {
	// ���ط���
	protected String doIntercept(ActionInvocation invocation) throws Exception {
		Admininfo admin = (Admininfo) ServletActionContext.getRequest().getSession().getAttribute("loginAdmin");
		if(admin == null){
			//δ��¼����ת����¼ҳ��
			return "login";
		}
		return invocation.invoke();// ����
	}
}
