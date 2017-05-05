package com.kaipan.mems.web.action;

import java.io.IOException;
import java.util.Date;

import javax.annotation.Resource;

import org.apache.struts2.ServletActionContext;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.kaipan.mems.domain.Announcement;
import com.kaipan.mems.domain.Expensetype;
import com.kaipan.mems.service.IExpenseTypeService;
import com.kaipan.mems.service.Impl.ExpenseTypeService;
import com.kaipan.mems.utils.JsonDateValueProcessor;
import com.kaipan.mems.utils.PageBean;
import com.kaipan.mems.web.action.base.BaseAction;

import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

@Controller
@Scope("prototype")
public class ExpenseTypeAction extends BaseAction<Expensetype> {
	
	@Resource
	private IExpenseTypeService expenseTypeService;
	
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
	public String expenseTypeinfo() throws IOException{
		PageBean pageBean = new PageBean();
		pageBean.setCurrentPage(page);
		pageBean.setPageSize(rows);
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Expensetype.class);
		if(model.getIsRetire()!=null){
			int userRoleId = model.getUserRoleId();
			String medicalTyp = model.getMedicalTyp();
			int hosptyp = model.getHosptyp();
			boolean isRetire = model.getIsRetire();
			detachedCriteria.add(Restrictions.eq("userRoleId", userRoleId));
			detachedCriteria.add(Restrictions.like("medicalTyp", medicalTyp));
			detachedCriteria.add(Restrictions.eq("hosptyp", hosptyp));
			detachedCriteria.add(Restrictions.eq("isRetire", isRetire));
		}
		pageBean.setDetachedCriteria(detachedCriteria);
		expenseTypeService.pageQuery(pageBean);
		
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

}
