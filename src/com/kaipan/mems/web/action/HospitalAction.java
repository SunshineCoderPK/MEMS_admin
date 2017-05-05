package com.kaipan.mems.web.action;

import java.io.IOException;
import java.util.Date;

import javax.annotation.Resource;

import org.apache.struts2.ServletActionContext;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.kaipan.mems.domain.Hospital;
import com.kaipan.mems.service.IHospitalService;
import com.kaipan.mems.utils.JsonDateValueProcessor;
import com.kaipan.mems.utils.PageBean;
import com.kaipan.mems.web.action.base.BaseAction;

import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

@Controller
@Scope("prototype")
public class HospitalAction extends BaseAction<Hospital> {
	@Resource
	private IHospitalService hospitalService;
	
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
	public String hospitalinfo() throws IOException{
		PageBean pageBean = new PageBean();
		pageBean.setCurrentPage(page);
		pageBean.setPageSize(rows);
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Hospital.class);
		String hospId=model.getHospId();
		String hospName=model.getHospName();
		int hospTyp=model.getHospTyp();
		if(hospId!=null&&(!hospId.equals(""))){
			detachedCriteria.add(Restrictions.like("hospId", "%"+ hospId + "%"));
		}
		if(hospName!=null&&(!hospName.equals(""))){
			detachedCriteria.add(Restrictions.like("hospName", "%"+ hospName + "%"));
		}
		if(hospTyp!=0){
			detachedCriteria.add(Restrictions.eq("hospTyp",  hospTyp ));
		}
		pageBean.setDetachedCriteria(detachedCriteria);
		hospitalService.pageQuery(pageBean);
		
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
