package com.kaipan.mems.web.action;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.struts2.ServletActionContext;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.kaipan.mems.domain.Expensetype;
import com.kaipan.mems.domain.Medicalitem;
import com.kaipan.mems.domain.Medicine;
import com.kaipan.mems.service.IMedicalItemService;
import com.kaipan.mems.utils.JsonDateValueProcessor;
import com.kaipan.mems.utils.PageBean;
import com.kaipan.mems.web.action.base.BaseAction;

import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;


@Controller
@Scope("prototype")
public class MedicalItemAction extends BaseAction<Medicalitem>{
	@Resource
	private IMedicalItemService medicalItemService;
	
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
	public String medicaliteminfo() throws IOException{
		PageBean pageBean = new PageBean();
		pageBean.setCurrentPage(page);
		pageBean.setPageSize(rows);
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Medicalitem.class);
		String medicalNum=model.getMedicalNum();
		String medicalName=model.getMedicalName();
		String expenseTyp=model.getExpenseTyp();
		if(medicalNum!=null&&(!medicalNum.equals(""))){
			detachedCriteria.add(Restrictions.like("medicalNum", "%"+ medicalNum + "%"));
		}
		if(medicalName!=null&&(!medicalName.equals(""))){
			detachedCriteria.add(Restrictions.like("medicalName", "%"+ medicalName + "%"));
		}
		if(expenseTyp!=null&&(!expenseTyp.equals(""))){
			detachedCriteria.add(Restrictions.like("expenseTyp",  expenseTyp ));
		}
		pageBean.setDetachedCriteria(detachedCriteria);
		medicalItemService.pageQuery(pageBean);
		
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
	
	public String allmedicalItem() throws IOException{
		List <Medicalitem> medicalitems=medicalItemService.findAll();
		String[] excludes=new String[]{"expenseTyp","medicUnit","medicalPrice","isExpense","remark"};
		this.writeList2Json(medicalitems, excludes);
		return NONE;
	}

}
