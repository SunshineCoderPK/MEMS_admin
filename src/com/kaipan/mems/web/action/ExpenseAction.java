package com.kaipan.mems.web.action;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;

import org.apache.struts2.ServletActionContext;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.kaipan.mems.domain.Expense;
import com.kaipan.mems.domain.Medicine;
import com.kaipan.mems.service.IExpenseService;
import com.kaipan.mems.utils.JsonDateValueProcessor;
import com.kaipan.mems.utils.PageBean;
import com.kaipan.mems.web.action.base.BaseAction;

import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

@Controller
@Scope("prototype")
public class ExpenseAction extends BaseAction<Expense>{
	
	@Resource
	private IExpenseService expenseService;
	
	private Expense expense;
	
	
	private int page;//页码
	private int rows;//每页显示的记录数
	public void setRows(int rows) {
		this.rows = rows;
	}
	
	public void setPage(int page) {
		this.page = page;
	}
	
	
	public Expense getExpense() {
		return expense;
	}
	
	public void setExpense(Expense expense) {
		this.expense = expense;
	}
	
	/**
	 * 分页查询方法
	 * @throws IOException 
	 */
	public String historyExpenseInfo() throws IOException{
		PageBean pageBean = new PageBean();
		pageBean.setCurrentPage(page);
		pageBean.setPageSize(rows);
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Expense.class);
		detachedCriteria.add(Restrictions.eq("check",2));
		
		String expenseNum=model.getExpenseNum();
		String medicalType=model.getMedicalTyp();
		if(expenseNum!=null&&(!expenseNum.equals(""))){
			detachedCriteria.add(Restrictions.like("expenseNum", "%"+ expenseNum + "%"));
		}
		if(medicalType!=null&&(!medicalType.equals(""))){
			detachedCriteria.add(Restrictions.like("medicalTyp", "%"+ medicalType + "%"));
		}
		
		if(ServletActionContext.getRequest().getParameter("mintotal")!=null&&
			ServletActionContext.getRequest().getParameter("mintotal")!=""){
			float mintotal=Float.parseFloat(ServletActionContext.getRequest().getParameter("mintotal"));
			detachedCriteria.add(Restrictions.ge("total", mintotal));
		}
		if(ServletActionContext.getRequest().getParameter("maxtotal")!=null&&
			ServletActionContext.getRequest().getParameter("maxtotal")!=""){
			float maxtotal=Float.parseFloat(ServletActionContext.getRequest().getParameter("maxtotal"));	
			detachedCriteria.add(Restrictions.le("total", maxtotal));
		}
		if(ServletActionContext.getRequest().getParameter("mindate")!=null&&
			ServletActionContext.getRequest().getParameter("mindate")!=""){
			String mindate=ServletActionContext.getRequest().getParameter("mindate");
			try {
				SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd"); 
				Date minDate=df.parse(mindate);
				detachedCriteria.add(Restrictions.ge("expenseTime", minDate));
			} catch (Exception e) {
				e.printStackTrace();
			}	 
		}
		if(ServletActionContext.getRequest().getParameter("maxdate")!=null&&
			ServletActionContext.getRequest().getParameter("maxdate")!=""){
			String maxdate=ServletActionContext.getRequest().getParameter("maxdate");
			try {
				SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd"); 
				Date maxDate=df.parse(maxdate);
				detachedCriteria.add(Restrictions.le("expenseTime", maxDate));
			} catch (Exception e) {
				e.printStackTrace();
			}	 
		}

		pageBean.setDetachedCriteria(detachedCriteria);
		expenseService.pageQuery(pageBean);
		
		//将PageBean对象转为json返回
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setExcludes(new String[]{"currentPage","detachedCriteria","pageSize"});
		jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor());   
		jsonConfig.setExcludes(new String[]{"expensemedicalitems","expensemedicines"});
		JSONObject jsonObject = JSONObject.fromObject(pageBean, jsonConfig);
		String json = jsonObject.toString();
		ServletActionContext.getResponse().setContentType("text/json;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().print(json);
		return NONE;
	}
	
	
	/**
	 * 根据id查询具体expense
	 * @throws IOException 
	 */
	public String hisExpenseDetail() throws IOException{
		String expenseNum=ServletActionContext.getRequest().getParameter("expenseNum");
		this.expense=expenseService.findById(expenseNum);
		return "detail";
	}
	

}
