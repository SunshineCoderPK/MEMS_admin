package com.kaipan.mems.web.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.struts2.ServletActionContext;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.hibernate.type.StandardBasicTypes;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.kaipan.mems.domain.Expensetype;
import com.kaipan.mems.domain.Hospital;
import com.kaipan.mems.domain.Medicalitem;
import com.kaipan.mems.service.IHospitalService;
import com.kaipan.mems.utils.JsonDateValueProcessor;
import com.kaipan.mems.utils.PageBean;
import com.kaipan.mems.web.action.base.BaseAction;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

@Controller
@Scope("prototype")
public class HospitalAction extends BaseAction<Hospital> {
	@Resource
	private IHospitalService hospitalService;
	
	//接收上传的文件
	private File myFile;

	public void setMyFile(File myFile) {
		this.myFile = myFile;
	}

	public File getMyFile() {
		return myFile;
	}
	
	
	private Hospital hospital;
	
	public Hospital getHospital() {
		return hospital;
	}
	
	public void setHospital(Hospital hospital) {
		this.hospital = hospital;
	}
	
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
		String key=ServletActionContext.getRequest().getParameter("key");
		if(key!=null&&key!=""){
			detachedCriteria.add(Restrictions.or(Restrictions.like("hospId", "%"+key+"%"), Restrictions.like("hospName", "%"+key+"%")));
		}
		String mhosptyp=ServletActionContext.getRequest().getParameter("mhosptyp");
		if(mhosptyp!=null&&(!mhosptyp.equals(""))){
			detachedCriteria.add(Restrictions.eq("hospTyp",  Integer.parseInt(mhosptyp) ));
		}
		String isDelete=ServletActionContext.getRequest().getParameter("status");
		if(isDelete!=null&&isDelete!=""){
			Boolean bisDelete;
			if(isDelete.equals("1")){
				bisDelete=true;
			}
			else{
				bisDelete=false;
			}
			detachedCriteria.add(Restrictions.eq("isDelete", bisDelete));
		}
		if(isDelete==null){
			detachedCriteria.add(Restrictions.ne("isDelete", true));
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
	
	
	public String allhospitalinfo() throws IOException{
		List <Hospital> hospitals=hospitalService.findAll();
		String[] excludes=new String[]{"hospTyp"};
		this.writeList2Json(hospitals, excludes);
		return NONE;
	}
	
	/**
	 * 根据id删除医院
	 * @throws IOException 
	 */
	public String delhospital() throws IOException{
		String hospId=ServletActionContext.getRequest().getParameter("hospId");
		String flag = "1";
		try{
			hospitalService.delhospital(hospId);
		}catch (Exception e) {
			//修改密码失败
			flag = "0";
		}
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().print(flag);
		return NONE;
	}
	
	/**
	 * 根据id批量删除医院
	 * @throws IOException 
	 */
	public String deletebatch() throws IOException{
		String ids=ServletActionContext.getRequest().getParameter("ids");
		try{
			hospitalService.deletebatch(ids);
		}catch (Exception e) {
			//修改密码失败
		}
		return "list";
	}
	
	/**
	 * 批量导入报销项
	 * @return
	 * @throws IOException
	 */
	public String signuphospitalbatch() throws IOException{
		String flag = "1";
		//使用ＰＯＩ解析Ｅｘｃｅｌ文件
		try{
			HSSFWorkbook workbook = new HSSFWorkbook(new FileInputStream(myFile));
			//获得第一个sheet页
			HSSFSheet sheet = workbook.getSheetAt(0);
			List<Hospital> list = new ArrayList<Hospital>();
			for (Row row : sheet) {
				int rowNum = row.getRowNum();
				if(rowNum == 0){
					//第一行，标题行，忽略
					continue;
				}
				Hospital signHospital=new Hospital();
				String hospId = getStringCellValue((HSSFCell)row.getCell(0));
				if(hospId!=null&&(!hospId.isEmpty())){
					signHospital.setHospId(hospId);
				}
				String hospName = getStringCellValue((HSSFCell)row.getCell(1));
				if(hospName!=null&&(!hospName.isEmpty())){
					signHospital.setHospName(hospName);
				}
				String hospTyp = getStringCellValue((HSSFCell)row.getCell(2));
				if(hospTyp!=null&&(!hospTyp.isEmpty())){
					switch (hospTyp) {
					case "校内医院":
						signHospital.setHospTyp(5);
						break;
					case "校外一级医院":
						signHospital.setHospTyp(1);
						break;
					case "校外二级医院":
						signHospital.setHospTyp(2);
						break;
					case "校外三级医院":
						signHospital.setHospTyp(3);
						break;
					case "异地医院":
						signHospital.setHospTyp(4);
						break;
					default:
						break;
					}
					
				}
		        signHospital.setIsDelete(false);
				list.add(signHospital);
			}
			hospitalService.saveBatch(list);
		}catch (Exception e) {
			flag = "0";
		}
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().print(flag);
		return NONE;
	}
	
	
	 /**
     * 获取单元格数据内容为字符串类型的数据
     * 
     * @param cell Excel单元格
     * @return String 单元格数据内容
     */
    private String getStringCellValue(HSSFCell cell) {
        String strCell = "";
        if (cell == null) {
            return "";
        }
        switch (cell.getCellType()) {
        case HSSFCell.CELL_TYPE_STRING:
            strCell = cell.getStringCellValue();
            break;
        case HSSFCell.CELL_TYPE_NUMERIC:
        	cell.setCellType(HSSFCell.CELL_TYPE_STRING);
            strCell = cell.getStringCellValue();
            break;
        case HSSFCell.CELL_TYPE_BOOLEAN:
            strCell = String.valueOf(cell.getBooleanCellValue());
            break;
        case HSSFCell.CELL_TYPE_BLANK:
            strCell = "";
            break;
        default:
            strCell = "";
            break;
        }
        if (strCell.equals("") || strCell == null) {
            return "";
        }
        return strCell;
    }
    
    
    /**
	 * 根据id返回修改报销项信息界面和传递id信息
	 * @throws IOException 
	 */
	public String changehospital() throws IOException{
//		this.stuOrEmpId=ServletActionContext.getRequest().getParameter("stuOrEmpId");
	    this.hospital=hospitalService.findById(ServletActionContext.getRequest().getParameter("hospId"));
		return "change";
	}
	
	/**
	 * 操作员跟据id修改报销项信息
	 * @return
	 * @throws IOException
	 */
	public String changehop() throws IOException{
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		String hospId=ServletActionContext.getRequest().getParameter("hospId");
		if(hospId==null||hospId==""){
			ServletActionContext.getResponse().getWriter().print("failed");
			return NONE;
		}
        Hospital hospital1=hospitalService.findById(hospId); 
        if(model.getHospName()!=null&&!(model.getHospName().isEmpty())){
        	hospital1.setHospName(model.getHospName());
        }
        if(model.getHospTyp()!=0){
        	hospital1.setHospTyp(model.getHospTyp());
        }
		try {
			hospitalService.update(hospital1);
		} catch (Exception e) {
			ServletActionContext.getResponse().getWriter().print("failed");
			return NONE;
		}
		ServletActionContext.getResponse().getWriter().print("success");
		return NONE;
	}
	
	/**
	 * 操作员添加医院
	 * @return
	 * @throws IOException
	 */
	public String addhop() throws IOException{
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		model.setIsDelete(false);
		try {
			hospitalService.save(model);
		} catch (Exception e) {
			ServletActionContext.getResponse().getWriter().print("failed");
			return NONE;
		}
		ServletActionContext.getResponse().getWriter().print("success");
		return NONE;
	}
	
}
