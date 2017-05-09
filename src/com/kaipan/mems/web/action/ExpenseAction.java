package com.kaipan.mems.web.action;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.struts2.ServletActionContext;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.EscapedErrors;

import com.kaipan.mems.domain.Expense;
import com.kaipan.mems.domain.Expensemedicalitem;
import com.kaipan.mems.domain.ExpensemedicalitemId;
import com.kaipan.mems.domain.Expensemedicine;
import com.kaipan.mems.domain.ExpensemedicineId;
import com.kaipan.mems.domain.Expensetype;
import com.kaipan.mems.domain.Hospital;
import com.kaipan.mems.domain.Medicalitem;
import com.kaipan.mems.domain.Medicine;
import com.kaipan.mems.domain.Userinfo;
import com.kaipan.mems.service.IExpenseService;
import com.kaipan.mems.service.IExpenseTypeService;
import com.kaipan.mems.service.IExpensemedicalitemService;
import com.kaipan.mems.service.IExpensemedicineService;
import com.kaipan.mems.service.IHospitalService;
import com.kaipan.mems.service.IMedicalItemService;
import com.kaipan.mems.service.IMedicineService;
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
	
	@Resource
	private IHospitalService hospitalService;
	
	@Resource
	private IExpenseTypeService expenseTypeService;
	
	@Resource
	private IExpensemedicineService expensemedicineService;
	
	@Resource
	private IExpensemedicalitemService expensemedicalitemService;
	
	@Resource
	private IMedicineService medicineService;
	
	@Resource
	private IMedicalItemService medicalItemService;
	
	private Expense expense;
	
	
	private int page;//ҳ��
	private int rows;//ÿҳ��ʾ�ļ�¼��
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
	 * ��ҳ��ѯ��ʷ�嵥����
	 * @throws IOException 
	 */
	public String historyExpenseInfo() throws IOException{
		PageBean pageBean = new PageBean();
		pageBean.setCurrentPage(page);
		pageBean.setPageSize(rows);
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Expense.class);
		detachedCriteria.add(Restrictions.or(Restrictions.isNull("isDelete"),Restrictions.eq("isDelete", false)));
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
		detachedCriteria.add(Restrictions.eq("check", 2 ));

		pageBean.setDetachedCriteria(detachedCriteria);
		expenseService.pageQuery(pageBean);
		
		//��PageBean����תΪjson����
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
	 * ����id��ѯ����expense
	 * @throws IOException 
	 */
	public String hisExpenseDetail() throws IOException{
		String expenseNum=ServletActionContext.getRequest().getParameter("expenseNum");
		this.expense=expenseService.findById(expenseNum);
		return "detail";
	}
	
	
	
	/**
	 * ��ҳ��ѯ����˷���
	 * @throws IOException 
	 */
	public String ischeckExpenseInfo() throws IOException{
		PageBean pageBean = new PageBean();
		pageBean.setCurrentPage(page);
		pageBean.setPageSize(rows);
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Expense.class);
		detachedCriteria.add(Restrictions.or(Restrictions.isNull("check"),Restrictions.eq("check", 1)));
		detachedCriteria.add(Restrictions.or(Restrictions.isNull("isDelete"),Restrictions.ne("isDelete", true)));
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
		
		//��PageBean����תΪjson����
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
	 * ��ҳ��ѯɾ��δͨ����������
	 * @throws IOException 
	 */
	public String deleteExpenseInfo() throws IOException{
		PageBean pageBean = new PageBean();
		pageBean.setCurrentPage(page);
		pageBean.setPageSize(rows);
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Expense.class);

		detachedCriteria.add(Restrictions.eq("check", 3 ));
		detachedCriteria.add(Restrictions.or(Restrictions.isNull("isDelete"),Restrictions.ne("isDelete", true)));
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
		
		//��PageBean����תΪjson����
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
	 * ����idɾ��expense
	 * @throws IOException 
	 */
	public String delExpense() throws IOException{
		String flag = "1";
		try{
			String expenseNum=ServletActionContext.getRequest().getParameter("expenseNum");
			expenseService.delExpense(expenseNum);
		}catch (Exception e) {
			flag = "0";
		}
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().print(flag);
		return NONE;
	}
	
	/**
	 * ���expense
	 * @throws IOException 
	 */
	public String addExpense() throws IOException{
		String flag = "1";
		Expense expense=new Expense();
		int random = (int) (Math.random() * 10000); // �����
		
		//���ɱ��������
		String expenseNum=System.currentTimeMillis() +""+ random;
		expense.setExpenseNum(expenseNum); // ͨ���õ�ϵͳʱ���������������ļ����������ظ�
		
		//���뱨������Ϣ
		Userinfo userinfo=(Userinfo) ServletActionContext.getRequest().getSession().getAttribute("loginUser");
		Userinfo userinfo2=new Userinfo();
		userinfo2.setStuOrEmpId(userinfo.getStuOrEmpId());
		expense.setUserinfo(userinfo2);
		expense.setUserName(userinfo.getName());
		
		//���뱨��ҽԺ��Ϣ
		Hospital hospital=new Hospital();
		String hospId=ServletActionContext.getRequest().getParameter("hospId");
		hospital.setHospId(hospId);
		expense.setHospital(hospital);
			
		
		//���뱨������
		int userRoleId=userinfo.getRoleId();
		String medicalTyp=ServletActionContext.getRequest().getParameter("medicalTyp");
		boolean isRetire;
		if(userinfo.getSeniority()!=null&&userinfo.getSeniority()>30){
			isRetire=true;
		}else{
			isRetire=false;
		}
		int hospTyp=findHospital(hospId).getHospTyp();
		boolean healthCard=Boolean.parseBoolean(ServletActionContext.getRequest().getParameter("healthCard"));
		Expensetype expensetype;
		if(userRoleId==2){
			expensetype=findExpensetype(userRoleId, medicalTyp, isRetire, hospTyp);
		}else{
			expensetype=findExpensetype(userRoleId, medicalTyp, isRetire, hospTyp,healthCard);
		}
		int expenseTyp=expensetype.getExpenseTyp();
		Expensetype newexpensetype=new Expensetype();
		newexpensetype.setExpenseTyp(expenseTyp);
		expense.setExpensetype(newexpensetype);
		
		//����ҽ������
		expense.setMedicalTyp(medicalTyp);
		
		expenseService.add(expense);
		
		//�����ܽ���ҩƷ,������,�������,����Ӧ�����
		float total=0;
		float expensePay=0;
		int countmedicine=Integer.parseInt(ServletActionContext.getRequest().getParameter("countmedicine"));
		int countmedicalitem=Integer.parseInt(ServletActionContext.getRequest().getParameter("countmedicalitem"));
		
		//����ҩƷ
		for(int i=0;i<countmedicine;i++){
			if(ServletActionContext.getRequest().getParameter("expensemedicines["+i+"][medicNum]")==null){
				continue;
			}
			Expensemedicine expensemedicine=new Expensemedicine();
			ExpensemedicineId expensemedicineId=new ExpensemedicineId();
			expensemedicineId.setExpenseNum(expenseNum);
			expensemedicineId.setMedicNum(ServletActionContext.getRequest().getParameter("expensemedicines["+i+"][medicNum]"));
			expensemedicine.setId(expensemedicineId);
			
			float medicUnitPrice=Float.parseFloat(ServletActionContext.getRequest().getParameter("expensemedicines["+i+"][medicUnitPrice]"));
			int medicQuantity=Integer.parseInt(ServletActionContext.getRequest().getParameter("expensemedicines["+i+"][medicQuantity]"));
			int sourse=Integer.parseInt(ServletActionContext.getRequest().getParameter("expensemedicines["+i+"][sourse]"));
			expensemedicine.setMedicQuantity(medicQuantity);
			expensemedicine.setMedicUnitPrice(medicUnitPrice);
		    expensemedicine.setSourse(sourse);
		    expensemedicine.setIsDelete(false);
		    expensemedicineService.add(expensemedicine);
		    
		    total+=medicUnitPrice*medicQuantity;
		    
		    Medicine medicine=medicineService.findbyId(ServletActionContext.getRequest().getParameter("expensemedicines["+i+"][medicNum]"));
		    //ȷ����������
		    float expenseProportion;
		    if(userRoleId==1&&sourse!=5){
		    	Expensetype expensetype2=findExpensetype(userRoleId, medicalTyp, isRetire, sourse,healthCard);
		    	expenseProportion=expensetype2.getExpenseProportion();
		    }
		    else{
		    	expenseProportion=expensetype.getExpenseProportion();
		    }
		    
		    //ȷ��ҩƷ�۸��Ƿ񳬹��޶����
		    float price;
		    if(medicine.getMedicPrice()!=null&&medicUnitPrice>medicine.getMedicPrice()){
		    	price=medicine.getMedicPrice();
		    }else {
				price=medicUnitPrice;
			}
		    
		    expensePay+=price*medicQuantity*expenseProportion;
		    
		}
		
		
		//������
		for(int i=0;i<countmedicalitem;i++){
			if(ServletActionContext.getRequest().getParameter("expensemedicalitems["+i+"][medicalNum]")==null){
				continue;
			}
			Expensemedicalitem expensemedicalitem=new Expensemedicalitem();
			ExpensemedicalitemId expensemedicalitemId=new ExpensemedicalitemId();
			expensemedicalitemId.setExpenseNum(expenseNum);
			expensemedicalitemId.setMedicalNum(ServletActionContext.getRequest().getParameter("expensemedicalitems["+i+"][medicalNum]"));
			expensemedicalitem.setId(expensemedicalitemId);
			
			float medicalUnitPrice=Float.parseFloat(ServletActionContext.getRequest().getParameter("expensemedicalitems["+i+"][medicalUnitPrice]"));
			int medicalQuantity=Integer.parseInt(ServletActionContext.getRequest().getParameter("expensemedicalitems["+i+"][medicalQuantity]"));
			expensemedicalitem.setMedicalQuantity(medicalQuantity);
			expensemedicalitem.setMedicalUnitPrice(medicalUnitPrice);

			expensemedicalitem.setIsDelete(false);
		    expensemedicalitemService.add(expensemedicalitem);
		    
		    total+=medicalUnitPrice*medicalQuantity;
		    
		    Medicalitem medicalitem=medicalItemService.findbyId(ServletActionContext.getRequest().getParameter("expensemedicalitems["+i+"][medicalNum]"));
		   
		    //ȷ����������
		    float expenseProportion;
		    expenseProportion=expensetype.getExpenseProportion();

		    
		    //ȷ��������۸��Ƿ񳬹��޶����
		    float price;
		    if(medicalitem.getMedicalPrice()!=null&&medicalUnitPrice>medicalitem.getMedicalPrice()){
		    	price=medicalitem.getMedicalPrice();
		    }else {
				price=medicalUnitPrice;
			}
		    
		    expensePay+=price*medicalQuantity*expenseProportion;
		    
		}
		
		expense.setCheck(1);
		expense.setTotal(total);
		expense.setExpensePay(expensePay);
		expense.setPersonsalPay(total-expensePay);
		expenseService.update(expense);
 
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().print(flag);
		return NONE;
	}
	
	//����������������
	private Expensetype findExpensetype(int userRoleId, String medicalTyp, boolean isRetire, int hospTyp,
			boolean healthCard) {
		return expenseTypeService.findExpensetype(userRoleId,medicalTyp,isRetire,hospTyp,healthCard);
	}

	//���������������ͣ����Ϸ����ؼ��ֲ�ͬ
	
	private Expensetype findExpensetype(int userRoleId,String medicalTyp,boolean isRetire,int hospTyp)throws IOException{
		return expenseTypeService.findExpensetype(userRoleId,medicalTyp,isRetire,hospTyp);
	}
	
	// ����ҽԺ

	private Hospital findHospital(String id) throws IOException{
		return hospitalService.findHospital(id);		
	}

}
