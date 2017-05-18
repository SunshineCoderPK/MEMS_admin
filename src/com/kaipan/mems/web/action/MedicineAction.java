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
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.kaipan.mems.domain.Hospital;
import com.kaipan.mems.domain.Medicalitem;
import com.kaipan.mems.domain.Medicine;
import com.kaipan.mems.service.IMedicineService;
import com.kaipan.mems.utils.JsonDateValueProcessor;
import com.kaipan.mems.utils.PageBean;
import com.kaipan.mems.web.action.base.BaseAction;

import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

@Controller
@Scope("prototype")
public class MedicineAction extends BaseAction<Medicine> {
	@Resource
	private IMedicineService medicineService;
	
	private Medicine medicine;
	
	public Medicine getMedicine() {
		return medicine;
	}
	
	public void setMedicine(Medicine medicine) {
		this.medicine = medicine;
	}
	
	//接收上传的文件
	private File myFile;

	public void setMyFile(File myFile) {
		this.myFile = myFile;
	}

	public File getMyFile() {
		return myFile;
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
	public String medicineinfo() throws IOException{
		PageBean pageBean = new PageBean();
		pageBean.setCurrentPage(page);
		pageBean.setPageSize(rows);
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Medicine.class);
		String key=ServletActionContext.getRequest().getParameter("key");
		if(key!=null&&key!=""){
			detachedCriteria.add(Restrictions.or(Restrictions.like("medicNum", "%"+key+"%"), Restrictions.like("medicCname", "%"+key+"%")));
		}
        String mexpenseTyp=ServletActionContext.getRequest().getParameter("mexpenseTyp");
		if(mexpenseTyp!=null&&(!mexpenseTyp.equals(""))){
			detachedCriteria.add(Restrictions.like("expenseTyp",  mexpenseTyp ));
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
		medicineService.pageQuery(pageBean);
		
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
	
	public String allmedicine() throws IOException{
		List <Medicine> medicines=medicineService.findAll();
		String[] excludes=new String[]{"medicEname","medicSname","dosageTyp","expenseTyp","medicUnit","medicPrice","isExpense","remark"};
		this.writeList2Json(medicines, excludes);
		return NONE;
	}
	
	/**
	 * 根据id删除医疗报销项
	 * @throws IOException 
	 */
	public String deletemedicine() throws IOException{
		String medicNum=ServletActionContext.getRequest().getParameter("medicNum");
		String flag = "1";
		try{
			medicineService.deletemedicine(medicNum);
		}catch (Exception e) {
			//修改密码失败
			flag = "0";
		}
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().print(flag);
		return NONE;
	}
	
	/**
	 * 根据id批量删除报销项
	 * @throws IOException 
	 */
	public String deletebatch() throws IOException{
		String ids=ServletActionContext.getRequest().getParameter("ids");
		try{
			medicineService.deletebatch(ids);
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
	public String signupmedicinebatch() throws IOException{
		String flag = "1";
		//使用ＰＯＩ解析Ｅｘｃｅｌ文件
		try{
			HSSFWorkbook workbook = new HSSFWorkbook(new FileInputStream(myFile));
			//获得第一个sheet页
			HSSFSheet sheet = workbook.getSheetAt(0);
			List<Medicine> list = new ArrayList<Medicine>();
			for (Row row : sheet) {
				int rowNum = row.getRowNum();
				if(rowNum == 0){
					//第一行，标题行，忽略
					continue;
				}
				Medicine signMedicine=new Medicine();
				String medicNum = getStringCellValue((HSSFCell)row.getCell(0));
				if(medicNum!=null&&(!medicNum.isEmpty())){
					signMedicine.setMedicNum(medicNum);
				}
				String medicCname = getStringCellValue((HSSFCell)row.getCell(1));
				if(medicCname!=null&&(!medicCname.isEmpty())){
					signMedicine.setMedicCname(medicCname);;
				}
				String medicEname = getStringCellValue((HSSFCell)row.getCell(2));
				if(medicEname!=null&&(!medicEname.isEmpty())){
					signMedicine.setMedicEname(medicEname);
				}
				String medicSname = getStringCellValue((HSSFCell)row.getCell(3));
				if(medicSname!=null&&(!medicSname.isEmpty())){
					signMedicine.setMedicSname(medicSname);
				}
				String dosageTyp = getStringCellValue((HSSFCell)row.getCell(4));
				if(dosageTyp!=null&&(!dosageTyp.isEmpty())){
					signMedicine.setDosageTyp(dosageTyp);
				}
				String expenseTyp = getStringCellValue((HSSFCell)row.getCell(5));
				if(expenseTyp!=null&&(!expenseTyp.isEmpty())){
					signMedicine.setExpenseTyp(expenseTyp);
				}
				String medicUnit = getStringCellValue((HSSFCell)row.getCell(6));
				if(medicUnit!=null&&(!medicUnit.isEmpty())){
					signMedicine.setMedicUnit(medicUnit);
				}
				String medicPrice = getStringCellValue((HSSFCell)row.getCell(7));
				if(medicPrice!=null&&(!medicPrice.isEmpty())){
					signMedicine.setMedicPrice(Float.parseFloat(medicPrice));
				}
				String isExpense = getStringCellValue((HSSFCell)row.getCell(8));
				if(isExpense!=null&&(!isExpense.isEmpty())){
					if (isExpense.equals("是")) {
						signMedicine.setIsExpense(true);
					} else {
						signMedicine.setIsExpense(false);
					}
				}
				String remark = getStringCellValue((HSSFCell)row.getCell(9));
				if(remark!=null&&(!remark.isEmpty())){
					signMedicine.setRemark(remark);
				}
				String rate = getStringCellValue((HSSFCell)row.getCell(10));
				if(rate!=null&&(!rate.isEmpty())){
					signMedicine.setRate(Float.parseFloat(rate));
				}
				String imgsrc = getStringCellValue((HSSFCell)row.getCell(11));
				if(imgsrc!=null&&(!imgsrc.isEmpty())){
					signMedicine.setImgsrc(imgsrc);
				}
				else{
					signMedicine.setImgsrc("\\img\\user\\1.jpg");
				}
				
		        signMedicine.setIsDelete(false);
				list.add(signMedicine);
			}
			medicineService.saveBatch(list);
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
	 * 根据id返回修改药品信息界面和传递id信息
	 * @throws IOException 
	 */
	public String changemeditem() throws IOException{
	    this.medicine=medicineService.findById(ServletActionContext.getRequest().getParameter("medicNum"));
		return "change";
	}
	
	/**
	 * 操作员跟据id修改药品信息
	 * @return
	 * @throws IOException
	 */
	public String changemedicine() throws IOException{
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		String medicNum1=ServletActionContext.getRequest().getParameter("medicNum");
		if(medicNum1==null||medicNum1==""){
			ServletActionContext.getResponse().getWriter().print("failed");
			return NONE;
		}
        Medicine medicine1=medicineService.findById(medicNum1);
        if(model.getMedicCname()!=null&&!(model.getMedicCname().isEmpty())){
        	medicine1.setMedicCname(model.getMedicCname());
        }
        if(model.getMedicEname()!=null&&!(model.getMedicEname().isEmpty())){
        	medicine1.setMedicEname(model.getMedicEname());
        }
        if(model.getMedicSname()!=null&&!(model.getMedicSname().isEmpty())){
        	medicine1.setMedicSname(model.getMedicSname());
        }
        if(model.getDosageTyp()!=null&&!(model.getDosageTyp().isEmpty())){
        	medicine1.setDosageTyp(model.getDosageTyp());
        }
        if(model.getRate()!=null){
        	medicine1.setRate(model.getRate());
        }
        if(model.getExpenseTyp()!=null&&!(model.getExpenseTyp().isEmpty())){
        	medicine1.setExpenseTyp(model.getExpenseTyp());
        }
        if(model.getMedicUnit()!=null&&!(model.getMedicUnit().isEmpty())){
        	medicine1.setMedicUnit(model.getMedicUnit());
        }
        String isExpense=ServletActionContext.getRequest().getParameter("isExpense");
        if(isExpense.equals("1")){
        	medicine1.setIsExpense(true);
        }else{
        	medicine1.setIsExpense(false);
        }
        if(model.getMedicPrice()!=null){
        	medicine1.setMedicPrice(model.getMedicPrice());
        }
        if(model.getRemark()!=null&&!(model.getRemark().isEmpty())){
        	medicine1.setRemark(model.getRemark());
        }
		try {
			medicineService.update(medicine1);
		} catch (Exception e) {
			ServletActionContext.getResponse().getWriter().print("failed");
			return NONE;
		}
		ServletActionContext.getResponse().getWriter().print("success");
		return NONE;
	}
	
	/**
	 * 操作员添加药品信息
	 * @return
	 * @throws IOException
	 */
	public String addmedicine() throws IOException{
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		model.setIsDelete(false);
		model.setImgsrc("\\img\\medicine\\default.jpg");
		try {
			medicineService.save(model);
		} catch (Exception e) {
			ServletActionContext.getResponse().getWriter().print("failed");
			return NONE;
		}
		ServletActionContext.getResponse().getWriter().print("success");
		return NONE;
	}


}
