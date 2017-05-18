package com.kaipan.mems.web.action;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.struts2.ServletActionContext;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Disjunction;
import org.hibernate.criterion.Restrictions;
import org.hibernate.type.StandardBasicTypes;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.EscapedErrors;

import com.kaipan.mems.domain.Admininfo;
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
import com.kaipan.mems.service.IUserService;
import com.kaipan.mems.utils.Chartsourse;
import com.kaipan.mems.utils.JsonDateValueProcessor;
import com.kaipan.mems.utils.PageBean;
import com.kaipan.mems.utils.Year;
import com.kaipan.mems.web.action.base.BaseAction;

import net.sf.json.JSONArray;
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
	
	@Resource
	private IUserService userService;
	
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
	 * 分页查询历史清单方法
	 * @throws IOException 
	 */
	public String historyExpenseInfo() throws IOException{
		PageBean pageBean = new PageBean();
		pageBean.setCurrentPage(page);
		pageBean.setPageSize(rows);
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Expense.class);
		detachedCriteria.add(Restrictions.or(Restrictions.isNull("isDelete"),Restrictions.eq("isDelete", false)));
		String key=ServletActionContext.getRequest().getParameter("key");
		if(key!=null&&key!=""){
			detachedCriteria.add(Restrictions.or(Restrictions.like("userName", "%"+key+"%"),
					             Restrictions.or(Restrictions.like("expenseNum", "%"+key+"%"), 
					            		        Restrictions.like("medicalTyp", "%"+key+"%"))));
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
		String muserRoleId = ServletActionContext.getRequest().getParameter("muserRoleId");
		if (muserRoleId != null && (!muserRoleId.equals(""))) {
//			detachedCriteria.createAlias("expense","expense",DetachedCriteria.LEFT_JOIN).createAlias("expense.userinfo","userinfo",DetachedCriteria.LEFT_JOIN);
			detachedCriteria.createAlias("userinfo", "t");
			detachedCriteria.add(Restrictions.eq("t.roleId", Integer.parseInt(muserRoleId)));
		}
		String mhosptyp = ServletActionContext.getRequest().getParameter("mhosptyp");
		if (mhosptyp != null && (!mhosptyp.equals(""))) {
			detachedCriteria.createAlias("hospital", "h");
			detachedCriteria.add(Restrictions.eq("h.hospTyp", Integer.parseInt(mhosptyp)));
		}
		detachedCriteria.add(Restrictions.eq("check", 2 ));

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
	
	
	
	/**
	 * 分页查询待审核方法
	 * @throws IOException 
	 */
	public String ischeckExpenseInfo() throws IOException{
		PageBean pageBean = new PageBean();
		pageBean.setCurrentPage(page);
		pageBean.setPageSize(rows);
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Expense.class);
		detachedCriteria.add(Restrictions.or(Restrictions.isNull("check"),Restrictions.eq("check", 1)));
		detachedCriteria.add(Restrictions.or(Restrictions.isNull("isDelete"),Restrictions.ne("isDelete", true)));
		String key=ServletActionContext.getRequest().getParameter("key");
		if(key!=null&&key!=""){
			detachedCriteria.add(Restrictions.or(Restrictions.like("userName", "%"+key+"%"),
					             Restrictions.or(Restrictions.like("expenseNum", "%"+key+"%"), 
					            		        Restrictions.like("medicalTyp", "%"+key+"%"))));
		}
		String muserRoleId = ServletActionContext.getRequest().getParameter("muserRoleId");
		if (muserRoleId != null && (!muserRoleId.equals(""))) {
//			detachedCriteria.createAlias("expense","expense",DetachedCriteria.LEFT_JOIN).createAlias("expense.userinfo","userinfo",DetachedCriteria.LEFT_JOIN);
			detachedCriteria.createAlias("userinfo", "t");
			detachedCriteria.add(Restrictions.eq("t.roleId", Integer.parseInt(muserRoleId)));
		}
		String mhosptyp = ServletActionContext.getRequest().getParameter("mhosptyp");
		if (mhosptyp != null && (!mhosptyp.equals(""))) {
			detachedCriteria.createAlias("hospital", "h");
			detachedCriteria.add(Restrictions.eq("h.hospTyp", Integer.parseInt(mhosptyp)));
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
	 * 分页查询删除未通过报销方法
	 * @throws IOException 
	 */
	public String deleteExpenseInfo() throws IOException{
		PageBean pageBean = new PageBean();
		pageBean.setCurrentPage(page);
		pageBean.setPageSize(rows);
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Expense.class);

		detachedCriteria.add(Restrictions.eq("check", 3 ));
		String key=ServletActionContext.getRequest().getParameter("key");
		if(key!=null&&key!=""){
			Disjunction dis = Restrictions.disjunction();
			dis.add(Restrictions.like("userName", "%"+key+"%"));
			dis.add(Restrictions.like("expenseNum", "%"+key+"%"));
			dis.add(Restrictions.like("medicalTyp", "%"+key+"%"));
			if(key.contains("在职教职工")){
				detachedCriteria.createAlias("userinfo", "t");
				dis.add(Restrictions.eq("t.roleId", 1));
			}
			if(key.contains("学生")){
				detachedCriteria.createAlias("userinfo", "t");
				dis.add(Restrictions.eq("t.roleId", 2));
			}
			if(key.contains("退休教职工")){
				detachedCriteria.createAlias("userinfo", "t");
				dis.add(Restrictions.eq("t.roleId", 3));
			}
			if(key.contains("教职工")){
				detachedCriteria.createAlias("userinfo", "t");
				dis.add(Restrictions.ne("t.roleId", 2));
			}
			detachedCriteria.add(dis);
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
	 * 根据id删除expense
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
	 * 根据id批量删除报销单
	 * @throws IOException 
	 */
	public String deletebatch() throws IOException{
		String ids=ServletActionContext.getRequest().getParameter("ids");
		try{
			expenseService.deletebatch(ids);
		}catch (Exception e) {
			//删除失败
		}
		return "list";
	}
	
	/**
	 * 添加expense
	 * @throws IOException 
	 */
	public String addExpense() throws IOException{
		
		String flag = "1";
     	int random = (int) (Math.random() * 10000); // 随机数
		
		//生成报销单编号
		String expenseNum=System.currentTimeMillis() +""+ random;
		try{
		Expense expense=new Expense();
	
		expense.setExpenseNum(expenseNum); // 通过得到系统时间加随机数生成新文件名，避免重复
		
		//导入报销人信息
		String stuOrEmpId=ServletActionContext.getRequest().getParameter("stuOrEmpId");
		Userinfo userinfo=userService.findById(stuOrEmpId);
;		Userinfo userinfo2=new Userinfo();
		userinfo2.setStuOrEmpId(stuOrEmpId);
		expense.setUserinfo(userinfo2);
		expense.setUserName(userinfo.getName());
		
		//导入报销医院信息
		Hospital hospital=new Hospital();
		String hospId=ServletActionContext.getRequest().getParameter("hospId");
		hospital.setHospId(hospId);
		expense.setHospital(hospital);
			
		
		//导入报销类型
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
		
		//导入医疗类型
		expense.setMedicalTyp(medicalTyp);
		
		expenseService.add(expense);
		
		//导入总金额和药品,报销项,报销金额,个人应付金额
		float total=0;
		float expensePay=0;
		int countmedicine=Integer.parseInt(ServletActionContext.getRequest().getParameter("countmedicine"));
		int countmedicalitem=Integer.parseInt(ServletActionContext.getRequest().getParameter("countmedicalitem"));
		
		//报销药品
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
		    //确定报销比例
		    float expenseProportion;
		    if(userRoleId==1&&sourse!=5){
		    	Expensetype expensetype2=findExpensetype(userRoleId, medicalTyp, isRetire, sourse,healthCard);
		    	expenseProportion=expensetype2.getExpenseProportion();
		    }
		    else{
		    	expenseProportion=expensetype.getExpenseProportion();
		    }
		    
		    //确定药品价格是否超过限定金额
		    float price;
		    if(medicine.getMedicPrice()!=null&&medicUnitPrice>medicine.getMedicPrice()){
		    	price=medicine.getMedicPrice();
		    }else {
				price=medicUnitPrice;
			}
		    
		    expensePay+=price*medicQuantity*expenseProportion;
		    
		}
		
		
		//报销项
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
		   
		    //确定报销比例
		    float expenseProportion;
		    expenseProportion=expensetype.getExpenseProportion();

		    
		    //确定报销项价格是否超过限定金额
		    float price;
		    if(medicalitem.getMedicalPrice()!=null&&medicalUnitPrice>medicalitem.getMedicalPrice()){
		    	price=medicalitem.getMedicalPrice();
		    }else {
				price=medicalUnitPrice;
			}
		    
		    expensePay+=price*medicalQuantity*expenseProportion;
		    
		}
		
		expense.setCheck(2);
		expense.setIsDelete(false);
		expense.setTotal(total);
		expense.setExpensePay(expensePay);
		expense.setPersonsalPay(total-expensePay);
		Date date=new Date();
		expense.setExpenseTime(date);
		Admininfo admininfo=new Admininfo();
		admininfo.setEmpId(((Admininfo)ServletActionContext.getRequest().getSession().getAttribute("loginAdmin")).getEmpId());
		expense.setAdmininfo(admininfo);
		expenseService.update(expense);
		}catch (Exception e) {
			flag="0";
			expensemedicineService.doDelete(expenseNum);
			expensemedicalitemService.doDelete(expenseNum);
			expenseService.doDelete(expenseNum);
		}
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().print(flag);
		return NONE;
	}
	
	//查找所属报销类型
	private Expensetype findExpensetype(int userRoleId, String medicalTyp, boolean isRetire, int hospTyp,
			boolean healthCard) {
		return expenseTypeService.findExpensetype(userRoleId,medicalTyp,isRetire,hospTyp,healthCard);
	}

	//查找所属报销类型，与上方法关键字不同
	
	private Expensetype findExpensetype(int userRoleId,String medicalTyp,boolean isRetire,int hospTyp)throws IOException{
		return expenseTypeService.findExpensetype(userRoleId,medicalTyp,isRetire,hospTyp);
	}
	
	// 查找医院

	private Hospital findHospital(String id) throws IOException{
		return hospitalService.findHospital(id);		
	}
	
	/**
	 * 审核expense
	 * @throws IOException 
	 */
	public String checkExpense() throws IOException{
		String flag = "1";
		try{
			String expenseNum=ServletActionContext.getRequest().getParameter("expenseNum");
			String result=ServletActionContext.getRequest().getParameter("result");
			Expense checkexpense=expenseService.findById(expenseNum);
			checkexpense.setCheck(Integer.parseInt(result));
			Date date=new Date();
			checkexpense.setExpenseTime(date);
			Admininfo admininfo=new Admininfo();
			admininfo.setEmpId(((Admininfo)ServletActionContext.getRequest().getSession().getAttribute("loginAdmin")).getEmpId());
			checkexpense.setAdmininfo(admininfo);
			expenseService.update(checkexpense);
		}catch (Exception e) {
			flag = "0";
		}
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().print(flag);
		return NONE;
	}
	
	
	public String allyear() throws IOException{
		List <Integer> years=expenseService.findAllYear();
		List<Year> cYears=new ArrayList<Year>();
		for(int year:years){
			Year newyear=new Year();
			newyear.setYear(String.valueOf(year));
			cYears.add(newyear);
		}
		String[] excludes=new String[]{};
		this.writeList2Json(cYears,excludes);
		return NONE;

	}
    
	//按人员类型统计
	public String statistic3() throws IOException{
		String year=ServletActionContext.getRequest().getParameter("year");
		String mintime=year+"-00-00 00:00:00";
		String maxtime=year+"-12-31 23:59:59";
		SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		Date timemin=null;
		try {
			timemin = df.parse(mintime);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		Date timemax=null;
		try {
			timemax = df.parse(maxtime);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		DetachedCriteria detachedCriteria1= DetachedCriteria.forClass(Expense.class);
		detachedCriteria1.add(Restrictions.between("expenseTime", timemin, timemax));
		detachedCriteria1.add(Restrictions.eq("check", 2));
		detachedCriteria1.add(Restrictions.eq("isDelete", false));
		detachedCriteria1.createAlias("userinfo", "t");
		detachedCriteria1.add(Restrictions.eq("t.roleId", 2));
		List<Expense> sExpenses=expenseService.findExpenses(detachedCriteria1);
		float stotal=0;
		for(Expense sExpense:sExpenses){
			stotal+=sExpense.getExpensePay();
		}
		
		DetachedCriteria detachedCriteria2= DetachedCriteria.forClass(Expense.class);
		detachedCriteria2.add(Restrictions.between("expenseTime", timemin, timemax));
		detachedCriteria2.add(Restrictions.eq("check", 2));
		detachedCriteria2.add(Restrictions.eq("isDelete", false));
		detachedCriteria2.createAlias("userinfo", "t");
		detachedCriteria2.add(Restrictions.eq("t.roleId", 1));
		List<Expense> tExpenses=expenseService.findExpenses(detachedCriteria2);
		float ttotal=0;
		for(Expense tExpense:tExpenses){
			ttotal+=tExpense.getExpensePay();
		}
		
		DetachedCriteria detachedCriteria3= DetachedCriteria.forClass(Expense.class);
		detachedCriteria3.add(Restrictions.between("expenseTime", timemin, timemax));
		detachedCriteria3.add(Restrictions.eq("check", 2));
		detachedCriteria3.add(Restrictions.eq("isDelete", false));
		detachedCriteria3.createAlias("userinfo", "t");
		detachedCriteria3.add(Restrictions.eq("t.roleId", 3));
		List<Expense> oExpenses=expenseService.findExpenses(detachedCriteria3);
		float ototal=0;
		for(Expense oExpense:oExpenses){
			ototal+=oExpense.getExpensePay();
		}
		
		
		
		// 将PageBean对象转为json返回
	
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("title", year+"医疗报销统计图(人员类型统计)");
		jsonObject.put("categories", new String[]{"在职教职工","学生","退休教职工"});
		JSONArray sourse = new JSONArray();  
		JSONObject node1 = new JSONObject(); 
		node1.put("value", ttotal);
		node1.put("name", "在职教职工");
		JSONObject node2 = new JSONObject(); 
		node2.put("value", stotal);
		node2.put("name", "学生");
		JSONObject node3 = new JSONObject(); 
		node3.put("value", ototal);
		node3.put("name", "退休教职工");
		sourse.add(node1);
		sourse.add(node2);
		sourse.add(node3);
		jsonObject.put("sourse", sourse);
		String json = jsonObject.toString();
		ServletActionContext.getResponse().setContentType("text/json;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().print(json);
		return NONE;
	}
	
	
	//按医疗类型统计
	public String statistic2() throws IOException {
		String year = ServletActionContext.getRequest().getParameter("year");
		String mintime = year + "-00-00 00:00:00";
		String maxtime = year + "-12-31 23:59:59";
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date timemin = null;
		try {
			timemin = df.parse(mintime);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		Date timemax = null;
		try {
			timemax = df.parse(maxtime);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		DetachedCriteria detachedCriteria1 = DetachedCriteria.forClass(Expense.class);
		detachedCriteria1.add(Restrictions.between("expenseTime", timemin, timemax));
		detachedCriteria1.add(Restrictions.eq("check", 2));
		detachedCriteria1.add(Restrictions.eq("isDelete", false));
		detachedCriteria1.createAlias("hospital", "t");
		detachedCriteria1.add(Restrictions.eq("t.hospTyp", 5));
		List<Expense> h1Expenses = expenseService.findExpenses(detachedCriteria1);
		float h1total = 0;
		for (Expense h1Expense : h1Expenses) {
			h1total += h1Expense.getExpensePay();
		}

		DetachedCriteria detachedCriteria2 = DetachedCriteria.forClass(Expense.class);
		detachedCriteria2.add(Restrictions.between("expenseTime", timemin, timemax));
		detachedCriteria2.add(Restrictions.eq("check", 2));
		detachedCriteria2.add(Restrictions.eq("isDelete", false));
		detachedCriteria2.createAlias("hospital", "t");
		detachedCriteria2.add(Restrictions.eq("t.hospTyp", 1));
		List<Expense> h2Expenses = expenseService.findExpenses(detachedCriteria2);
		float h2total = 0;
		for (Expense h2Expense : h2Expenses) {
			h2total += h2Expense.getExpensePay();
		}

		DetachedCriteria detachedCriteria3 = DetachedCriteria.forClass(Expense.class);
		detachedCriteria3.add(Restrictions.between("expenseTime", timemin, timemax));
		detachedCriteria3.add(Restrictions.eq("check", 2));
		detachedCriteria3.add(Restrictions.eq("isDelete", false));
		detachedCriteria3.createAlias("hospital", "t");
		detachedCriteria3.add(Restrictions.eq("t.hospTyp", 2));
		List<Expense> h3Expenses = expenseService.findExpenses(detachedCriteria3);
		float h3total = 0;
		for (Expense h3Expense : h3Expenses) {
			h3total += h3Expense.getExpensePay();
		}
		
		DetachedCriteria detachedCriteria4 = DetachedCriteria.forClass(Expense.class);
		detachedCriteria4.add(Restrictions.between("expenseTime", timemin, timemax));
		detachedCriteria4.add(Restrictions.eq("check", 2));
		detachedCriteria4.add(Restrictions.eq("isDelete", false));
		detachedCriteria4.createAlias("hospital", "t");
		detachedCriteria4.add(Restrictions.eq("t.hospTyp", 3));
		List<Expense> h4Expenses = expenseService.findExpenses(detachedCriteria4);
		float h4total = 0;
		for (Expense h4Expense : h4Expenses) {
			h4total += h4Expense.getExpensePay();
		}
		
		DetachedCriteria detachedCriteria5 = DetachedCriteria.forClass(Expense.class);
		detachedCriteria5.add(Restrictions.between("expenseTime", timemin, timemax));
		detachedCriteria5.add(Restrictions.eq("check", 2));
		detachedCriteria5.add(Restrictions.eq("isDelete", false));
		detachedCriteria5.createAlias("hospital", "t");
		detachedCriteria5.add(Restrictions.eq("t.hospTyp", 4));
		List<Expense> h5Expenses = expenseService.findExpenses(detachedCriteria5);
		float h5total = 0;
		for (Expense h5Expense : h5Expenses) {
			h5total += h5Expense.getExpensePay();
		}

		// 将PageBean对象转为json返回

		JSONObject jsonObject = new JSONObject();
		jsonObject.put("title", year + "医疗报销统计图(医院类型统计)");
		jsonObject.put("categories", new String[] {  "校医院", "校外一级医院", "校外二级医院","校外三级医院","异地医院" });
		JSONArray sourse = new JSONArray();
		JSONObject node1 = new JSONObject();
		node1.put("value", h1total);
		node1.put("name", "校医院");
		JSONObject node2 = new JSONObject();
		node2.put("value", h2total);
		node2.put("name", "校外一级医院");
		JSONObject node3 = new JSONObject();
		node3.put("value", h3total);
		node3.put("name", "校外二级医院");
		JSONObject node4 = new JSONObject();
		node4.put("value", h4total);
		node4.put("name", "校外三级医院");
		JSONObject node5 = new JSONObject();
		node5.put("value", h5total);
		node5.put("name", "异地医院");
		sourse.add(node1);
		sourse.add(node2);
		sourse.add(node3);
		sourse.add(node4);
		sourse.add(node5);
		jsonObject.put("sourse", sourse);
		String json = jsonObject.toString();
		ServletActionContext.getResponse().setContentType("text/json;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().print(json);
		return NONE;
	}
	
	
	//历年统计
	public String statistic1() throws IOException {
		List <Integer> years=expenseService.findAllYear();
        List<Object[]> rows=expenseService.accountByYear();
        ArrayList<String> curyears=new ArrayList<String>();
        ArrayList<String> totals=new ArrayList<String>();
        ArrayList<String> expenPays=new ArrayList<String>();
        for(Object[] total:rows){
            curyears.add(String.valueOf(total[0]));
            totals.add(String.valueOf(total[1]));
            expenPays.add(String.valueOf(total[2]));
        }
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("year", curyears);
		jsonObject.put("totals", totals);
		jsonObject.put("expensePays", expenPays);
		String json = jsonObject.toString();
		ServletActionContext.getResponse().setContentType("text/json;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().print(json);
		return NONE;
	}
	
	//历年统计
	public String statistic4() throws IOException {
		String year=ServletActionContext.getRequest().getParameter("year");
		String mintime=year+"-00-00 00:00:00";
		String maxtime=year+"-12-31 23:59:59";
		SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		Date timemin=null;
		try {
			timemin = df.parse(mintime);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		Date timemax=null;
		try {
			timemax = df.parse(maxtime);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		DetachedCriteria detachedCriteria1= DetachedCriteria.forClass(Expense.class);
		detachedCriteria1.add(Restrictions.between("expenseTime", timemin, timemax));
		detachedCriteria1.add(Restrictions.eq("check", 2));
		detachedCriteria1.add(Restrictions.eq("isDelete", false));
		detachedCriteria1.add(Restrictions.like("medicalTyp", "%一般门诊%"));
		List<Expense> sExpenses=expenseService.findExpenses(detachedCriteria1);
		float stotal=0;
		for(Expense sExpense:sExpenses){
			stotal+=sExpense.getExpensePay();
		}
		
		DetachedCriteria detachedCriteria2= DetachedCriteria.forClass(Expense.class);
		detachedCriteria2.add(Restrictions.between("expenseTime", timemin, timemax));
		detachedCriteria2.add(Restrictions.eq("check", 2));
		detachedCriteria2.add(Restrictions.eq("isDelete", false));
		detachedCriteria2.add(Restrictions.like("medicalTyp", "%住院%"));
		List<Expense> tExpenses=expenseService.findExpenses(detachedCriteria2);
		float ttotal=0;
		for(Expense tExpense:tExpenses){
			ttotal+=tExpense.getExpensePay();
		}
		
		DetachedCriteria detachedCriteria3= DetachedCriteria.forClass(Expense.class);
		detachedCriteria3.add(Restrictions.between("expenseTime", timemin, timemax));
		detachedCriteria3.add(Restrictions.eq("check", 2));
		detachedCriteria3.add(Restrictions.eq("isDelete", false));
		detachedCriteria3.add(Restrictions.like("medicalTyp", "%特殊门诊%"));
		List<Expense> oExpenses=expenseService.findExpenses(detachedCriteria3);
		float ototal=0;
		for(Expense oExpense:oExpenses){
			ototal+=oExpense.getExpensePay();
		}
		
		
		
		// 将PageBean对象转为json返回
	
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("title", year+"医疗报销统计图(医疗类型统计)");
		jsonObject.put("categories", new String[]{"一般门诊","住院","特殊门诊"});
		JSONArray sourse = new JSONArray();  
		JSONObject node1 = new JSONObject(); 
		node1.put("value", ttotal);
		node1.put("name", "一般门诊");
		JSONObject node2 = new JSONObject(); 
		node2.put("value", stotal);
		node2.put("name", "住院");
		JSONObject node3 = new JSONObject(); 
		node3.put("value", ototal);
		node3.put("name", "特殊门诊");
		sourse.add(node1);
		sourse.add(node2);
		sourse.add(node3);
		jsonObject.put("sourse", sourse);
		String json = jsonObject.toString();
		ServletActionContext.getResponse().setContentType("text/json;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().print(json);
		return NONE;
	}

}
