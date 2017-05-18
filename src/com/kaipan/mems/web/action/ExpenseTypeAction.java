package com.kaipan.mems.web.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.PrimitiveIterator.OfDouble;

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

import com.kaipan.mems.domain.Announcement;
import com.kaipan.mems.domain.Expensetype;
import com.kaipan.mems.domain.Medicalitem;
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
	
	
	private Expensetype expensetype;
	
	public Expensetype getExpensetype() {
		return expensetype;
	}
	
	public void setExpensetype(Expensetype expensetype) {
		this.expensetype = expensetype;
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
	public String expenseTypeinfo() throws IOException{
		PageBean pageBean = new PageBean();
		pageBean.setCurrentPage(page);
		pageBean.setPageSize(rows);
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Expensetype.class);
		String key=ServletActionContext.getRequest().getParameter("key");
		if(key!=null&&key!=""){
			detachedCriteria.add(Restrictions.or(Restrictions.sqlRestriction("CAST({alias}.expenseTyp AS CHAR) like ?",  "%" + key + "%", StandardBasicTypes.STRING), Restrictions.like("medicalTyp", "%"+key+"%")));
		}
        String muserRoleId=ServletActionContext.getRequest().getParameter("muserRoleId");
		if(muserRoleId!=null&&(!muserRoleId.equals(""))){
			detachedCriteria.add(Restrictions.eq("userRoleId",  Integer.parseInt(muserRoleId) ));
		}
		String mhosptyp=ServletActionContext.getRequest().getParameter("mhosptyp");
		if(mhosptyp!=null&&(!mhosptyp.equals(""))){
			detachedCriteria.add(Restrictions.eq("hosptyp",  Integer.parseInt(mhosptyp) ));
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
		expenseTypeService.pageQuery(pageBean);
		
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
	 * ����idɾ��ҽ�Ʊ�������
	 * @throws IOException 
	 */
	public String delexpensetype() throws IOException{
		String expenseTyp=ServletActionContext.getRequest().getParameter("expenseTyp");
		String flag = "1";
		try{
			expenseTypeService.delexpensetype(Integer.parseInt(expenseTyp));
		}catch (Exception e) {
			//�޸�����ʧ��
			flag = "0";
		}
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().print(flag);
		return NONE;
	}
	
	
	/**
	 * ����id����ɾ����������
	 * @throws IOException 
	 */
	public String deletebatch() throws IOException{
		String ids=ServletActionContext.getRequest().getParameter("ids");
		try{
			expenseTypeService.deletebatch(ids);
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
	public String signupexpensetypebatch() throws IOException{
		String flag = "1";
		//ʹ�ãУϣɽ����ţ������ļ�
		try{
			HSSFWorkbook workbook = new HSSFWorkbook(new FileInputStream(myFile));
			//��õ�һ��sheetҳ
			HSSFSheet sheet = workbook.getSheetAt(0);
			List<Expensetype> list = new ArrayList<Expensetype>();
			for (Row row : sheet) {
				int rowNum = row.getRowNum();
				if(rowNum == 0){
					//��һ�У������У�����
					continue;
				}
				Expensetype signExpensetype=new Expensetype();
				String expenseTyp = getStringCellValue((HSSFCell)row.getCell(0));
				if(expenseTyp!=null&&(!expenseTyp.isEmpty())){
					signExpensetype.setExpenseTyp(Integer.parseInt(expenseTyp));
				}
				String userRoleId = getStringCellValue((HSSFCell)row.getCell(1));
				if(userRoleId!=null&&(!userRoleId.isEmpty())){
					if(userRoleId.equals("��ְ��")){
						signExpensetype.setUserRoleId(1);
					}
					else {
						signExpensetype.setUserRoleId(2);
					}
				}
				String medicalTyp = getStringCellValue((HSSFCell)row.getCell(2));
				if(medicalTyp!=null&&(!medicalTyp.isEmpty())){
					signExpensetype.setMedicalTyp(medicalTyp);
				}
				String hosptyp = getStringCellValue((HSSFCell)row.getCell(3));
				if(hosptyp!=null&&(!hosptyp.isEmpty())){
					switch (hosptyp) {
					case "У��һ��":
						signExpensetype.setHosptyp(1);
						break;
					case "У�����":
						signExpensetype.setHosptyp(2);
						break;
					case "У������":
						signExpensetype.setHosptyp(3);
						break;
					case "���ҽԺ":
						signExpensetype.setHosptyp(4);
						break;
					case "У��ҽԺ":
						signExpensetype.setHosptyp(5);
						break;
					default:
						break;
					}
				}
				String isRetire = getStringCellValue((HSSFCell)row.getCell(4));
				if(isRetire!=null&&(!isRetire.isEmpty())){
					if (isRetire.equals("��")) {
						signExpensetype.setIsRetire(true);
					} else {
						signExpensetype.setIsRetire(false);
					}
				}
				String healthCard = getStringCellValue((HSSFCell)row.getCell(5));
				if(healthCard!=null&&(!healthCard.isEmpty())){
					if (healthCard.equals("��")) {
						signExpensetype.setHealthCard(true);
					} else {
						signExpensetype.setHealthCard(false);
					}
				}
				String thresholdFee = getStringCellValue((HSSFCell)row.getCell(6));
				if(thresholdFee!=null&&(!thresholdFee.isEmpty())){
					signExpensetype.setThresholdFee(Float.parseFloat(thresholdFee));
				}
				String expenseProportion = getStringCellValue((HSSFCell)row.getCell(7));
				if(expenseProportion!=null&&(!expenseProportion.isEmpty())){
					signExpensetype.setExpenseProportion(Float.parseFloat(expenseProportion));
				}
		        signExpensetype.setIsDelete(false);
				list.add(signExpensetype);
			}
			expenseTypeService.saveBatch(list);
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
	 * ����id�����޸ı�������Ϣ����ʹ���id��Ϣ
	 * @throws IOException 
	 */
	public String changeexpensetype() throws IOException{
//		this.stuOrEmpId=ServletActionContext.getRequest().getParameter("stuOrEmpId");
	    this.expensetype=expenseTypeService.findById(Integer.parseInt(ServletActionContext.getRequest().getParameter("expenseTyp")));
		return "change";
	}
	
	
	/**
	 * ����Ա����id�޸ı�������Ϣ
	 * @return
	 * @throws IOException
	 */
	public String changetype() throws IOException{
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		String expenseTyp=ServletActionContext.getRequest().getParameter("expenseTyp");
		if(expenseTyp==null||expenseTyp==""){
			ServletActionContext.getResponse().getWriter().print("failed");
			return NONE;
		}
        Expensetype expensetype1=expenseTypeService.findById(Integer.parseInt(expenseTyp)); 
        if(model.getUserRoleId()!=0){
        	expensetype1.setUserRoleId(model.getUserRoleId());
        }
        if(model.getMedicalTyp()!=null&&!(model.getMedicalTyp().isEmpty())){
        	expensetype1.setMedicalTyp(model.getMedicalTyp());
        }
        if(model.getHosptyp()!=0){
        	expensetype1.setHosptyp(model.getHosptyp());
        }
        String  isRetire=ServletActionContext.getRequest().getParameter("isRetire");
        if(isRetire.equals("1")){
        	expensetype1.setIsRetire(true);  	
        }
        else {
			expensetype1.setIsRetire(false);
		}
        String  healthCard=ServletActionContext.getRequest().getParameter("healthCard");
        if(healthCard.equals("1")){
        	expensetype1.setHealthCard(true);  	
        }
        else {
			expensetype1.setHealthCard(false);
		}
        
        if(model.getThresholdFee()!=null){
        	expensetype1.setThresholdFee(model.getThresholdFee());
        }
        if(model.getExpenseProportion()!=null){
        	expensetype1.setExpenseProportion(model.getExpenseProportion());
        }
		try {
			expenseTypeService.update(expensetype1);
		} catch (Exception e) {
			ServletActionContext.getResponse().getWriter().print("failed");
			return NONE;
		}
		ServletActionContext.getResponse().getWriter().print("success");
		return NONE;
	}
	
	/**
	 * ����Ա��ӱ�������
	 * @return
	 * @throws IOException
	 */
	public String addtype() throws IOException{
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		model.setIsDelete(false);
		try {
			expenseTypeService.save(model);
		} catch (Exception e) {
			ServletActionContext.getResponse().getWriter().print("failed");
			return NONE;
		}
		ServletActionContext.getResponse().getWriter().print("success");
		return NONE;
	}


}
