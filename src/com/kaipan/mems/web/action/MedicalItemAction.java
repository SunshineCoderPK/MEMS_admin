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


import com.kaipan.mems.domain.Medicalitem;
import com.kaipan.mems.domain.Userinfo;
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
	
    private Medicalitem medicalitem;
	
	public Medicalitem getMedicalitem() {
		return medicalitem;
	}
	
	public void setMedicalitem(Medicalitem medicalitem) {
		this.medicalitem = medicalitem;
	}
	
	//�����ϴ����ļ�
	private File myFile;

	public void setMyFile(File myFile) {
		this.myFile = myFile;
	}

	public File getMyFile() {
		return myFile;
	}
			
	
	private int page;//ҳ��
	private int rows;//ÿҳ��ʾ�ļ�¼��

	
	public void setRows(int rows) {
		this.rows = rows;
	}
	
	public void setPage(int page) {
		this.page = page;
	}
	
	
	
	/**
	 * ��ҳ��ѯ����
	 * @throws IOException 
	 */
	public String medicaliteminfo() throws IOException{
		PageBean pageBean = new PageBean();
		pageBean.setCurrentPage(page);
		pageBean.setPageSize(rows);
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Medicalitem.class);
		String key=ServletActionContext.getRequest().getParameter("key");
		if(key!=null&&key!=""){
			detachedCriteria.add(Restrictions.or(Restrictions.like("medicalNum", "%"+key+"%"), Restrictions.like("medicalName", "%"+key+"%")));
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
		medicalItemService.pageQuery(pageBean);
		
		//��PageBean����תΪjson����
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setExcludes(new String[]{"currentPage","detachedCriteria","pageSize"});
		jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor()); 
		JSONObject jsonObject = JSONObject.fromObject(pageBean, jsonConfig);
		String json = jsonObject.toString();
		ServletActionContext.getResponse().setContentType("text/json;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().print(json);
		return NONE;
	}
	
	/**
	 * ��ѯ���б����select�������
	 * @throws IOException 
	 */
	public String allmedicalItem() throws IOException{
		List <Medicalitem> medicalitems=medicalItemService.findAll();
		String[] excludes=new String[]{"expenseTyp","medicUnit","medicalPrice","isExpense","remark"};
		this.writeList2Json(medicalitems, excludes);
		return NONE;
	}
	
	/**
	 * ����idɾ��ҽ�Ʊ�����
	 * @throws IOException 
	 */
	public String deletemedicalitem() throws IOException{
		String medicalNum=ServletActionContext.getRequest().getParameter("medicalNum");
		String flag = "1";
		try{
			medicalItemService.deletemedicalitem(medicalNum);
		}catch (Exception e) {
			//�޸�����ʧ��
			flag = "0";
		}
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().print(flag);
		return NONE;
	}
	
	
	/**
	 * ����id����ɾ��������
	 * @throws IOException 
	 */
	public String deletebatch() throws IOException{
		String ids=ServletActionContext.getRequest().getParameter("ids");
		try{
			medicalItemService.deletebatch(ids);
		}catch (Exception e) {
			//�޸�����ʧ��
		}
		return "list";
	}
	
	/**
	 * �������뱨����
	 * @return
	 * @throws IOException
	 */
	public String signupmedicalitembatch() throws IOException{
		String flag = "1";
		//ʹ�ãУϣɽ����ţ������ļ�
		try{
			HSSFWorkbook workbook = new HSSFWorkbook(new FileInputStream(myFile));
			//��õ�һ��sheetҳ
			HSSFSheet sheet = workbook.getSheetAt(0);
			List<Medicalitem> list = new ArrayList<Medicalitem>();
			for (Row row : sheet) {
				int rowNum = row.getRowNum();
				if(rowNum == 0){
					//��һ�У������У�����
					continue;
				}
				Medicalitem signMedicalitem=new Medicalitem();
				String medicalNum = getStringCellValue((HSSFCell)row.getCell(0));
				if(medicalNum!=null&&(!medicalNum.isEmpty())){
					signMedicalitem.setMedicalNum(medicalNum);
				}
				String medicalName = getStringCellValue((HSSFCell)row.getCell(1));
				if(medicalName!=null&&(!medicalName.isEmpty())){
					signMedicalitem.setMedicalName(medicalName);
				}
				String expenseTyp = getStringCellValue((HSSFCell)row.getCell(2));
				if(expenseTyp!=null&&(!expenseTyp.isEmpty())){
					signMedicalitem.setExpenseTyp(expenseTyp);
				}
				String medicUnit = getStringCellValue((HSSFCell)row.getCell(3));
				if(medicUnit!=null&&(!medicUnit.isEmpty())){
					signMedicalitem.setMedicUnit(medicUnit);
				}
				String medicalPrice = getStringCellValue((HSSFCell)row.getCell(4));
				if(medicalPrice!=null&&(!medicalPrice.isEmpty())){
					signMedicalitem.setMedicalPrice(Float.parseFloat(medicalPrice));
				}
				String isExpense = getStringCellValue((HSSFCell)row.getCell(5));
				if(isExpense!=null&&(!isExpense.isEmpty())){
					if (isExpense.equals("��")) {
						signMedicalitem.setIsExpense(true);
					} else {
						signMedicalitem.setIsExpense(false);
					}
				}
				String remark = getStringCellValue((HSSFCell)row.getCell(6));
				if(remark!=null&&(!remark.isEmpty())){
					signMedicalitem.setRemark(remark);
				}
				String rate = getStringCellValue((HSSFCell)row.getCell(7));
				if(rate!=null&&(!rate.isEmpty())){
					signMedicalitem.setRate(Float.parseFloat(rate));
				}
		        signMedicalitem.setIsDelete(false);
				list.add(signMedicalitem);
			}
			medicalItemService.saveBatch(list);
		}catch (Exception e) {
			flag = "0";
		}
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().print(flag);
		return NONE;
	}
	
	
	 /**
     * ��ȡ��Ԫ����������Ϊ�ַ������͵�����
     * 
     * @param cell Excel��Ԫ��
     * @return String ��Ԫ����������
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
	 * ����id��ѯ����Medicalitem,�����ص�����Ա��Ϣ��ʾҳ��
	 * @throws IOException 
	 */
	public String medicalitemDetail() throws IOException{
		String medicalNum=ServletActionContext.getRequest().getParameter("medicalNum");
		this.medicalitem=medicalItemService.findById(medicalNum);
		return "detail";
	}
	
	
	/**
	 * ����id�����޸ı�������Ϣ����ʹ���id��Ϣ
	 * @throws IOException 
	 */
	public String changemeditem() throws IOException{
//		this.stuOrEmpId=ServletActionContext.getRequest().getParameter("stuOrEmpId");
	    this.medicalitem=medicalItemService.findById(ServletActionContext.getRequest().getParameter("medicalNum"));
		return "change";
	}
	
	
	/**
	 * ����Ա����id�޸ı�������Ϣ
	 * @return
	 * @throws IOException
	 */
	public String changemedicalitem() throws IOException{
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		String medicalNum1=ServletActionContext.getRequest().getParameter("medicalNum");
		if(medicalNum1==null||medicalNum1==""){
			ServletActionContext.getResponse().getWriter().print("failed");
			return NONE;
		}
        Medicalitem medicalitem1=medicalItemService.findById(medicalNum1);
        if(model.getMedicalName()!=null&&!(model.getMedicalName().isEmpty())){
        	medicalitem1.setMedicalName(model.getMedicalName());
        }
        if(model.getRate()!=null){
        	medicalitem1.setRate(model.getRate());
        }
        if(model.getExpenseTyp()!=null&&!(model.getExpenseTyp().isEmpty())){
        	medicalitem1.setExpenseTyp(model.getExpenseTyp());
        }
        if(model.getMedicUnit()!=null&&!(model.getMedicUnit().isEmpty())){
        	medicalitem1.setMedicUnit(model.getMedicUnit());
        }
        String isExpense=ServletActionContext.getRequest().getParameter("isExpense");
        if(isExpense.equals("1")){
        	medicalitem1.setIsExpense(true);
        }else{
        	medicalitem1.setIsExpense(false);
        }
        if(model.getMedicalPrice()!=null){
        	medicalitem1.setMedicalPrice(model.getMedicalPrice());
        }
        if(model.getRemark()!=null&&!(model.getRemark().isEmpty())){
        	medicalitem1.setRemark(model.getRemark());
        }
		try {
			medicalItemService.update(medicalitem1);
		} catch (Exception e) {
			ServletActionContext.getResponse().getWriter().print("failed");
			return NONE;
		}
		ServletActionContext.getResponse().getWriter().print("success");
		return NONE;
	}
	
	/**
	 * ����Ա��ӱ�������Ϣ
	 * @return
	 * @throws IOException
	 */
	public String addmedicalitem() throws IOException{
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		model.setIsDelete(false);
		try {
			medicalItemService.save(model);
		} catch (Exception e) {
			ServletActionContext.getResponse().getWriter().print("failed");
			return NONE;
		}
		ServletActionContext.getResponse().getWriter().print("success");
		return NONE;
	}


}
