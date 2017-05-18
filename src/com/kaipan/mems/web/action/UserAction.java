package com.kaipan.mems.web.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.struts2.ServletActionContext;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.kaipan.mems.domain.Admininfo;
import com.kaipan.mems.domain.Hospital;
import com.kaipan.mems.domain.Userinfo;
import com.kaipan.mems.service.IUserService;
import com.kaipan.mems.utils.JsonDateValueProcessor;
import com.kaipan.mems.utils.MD5Utils;
import com.kaipan.mems.utils.PageBean;
import com.kaipan.mems.web.action.base.BaseAction;

import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;


@Controller
@Scope("prototype")
public class UserAction extends BaseAction<Userinfo> {
	
	@Resource
	private IUserService userService;
	
	private String checkcode;
	
	private String oldPwd;
	
	public void setCheckcode(String checkcode) {
		this.checkcode = checkcode;
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
	
	private Userinfo userinfo;

	private String stuOrEmpId;
		
	public Userinfo getUserinfo() {
		return userinfo;
	}
	
	public void setUserinfo(Userinfo userinfo) {
		this.userinfo = userinfo;
	}
	
	public String getStuOrEmpId() {
		return stuOrEmpId;
	}
	
	public void setStuOrEmpId(String stuOrEmpId) {
		this.stuOrEmpId = stuOrEmpId;
	}
	
	public String login(){
		String key=(String)ServletActionContext.getRequest().getSession().getAttribute("key");
		
		if(StringUtils.isNotBlank(checkcode)&&checkcode.equals(key)){
			Userinfo loginuserinfo=userService.login(model);
			
			if(userinfo != null){
				//��¼�ɹ�,��User����session����ת��ϵͳ��ҳ
				if(userinfo.getImgsrc()==null){
					userinfo.setImgsrc("${pageContext.request.contextPath}/images/photo.jpg");
				}
				ServletActionContext.getRequest().getSession().setAttribute("loginUser", loginuserinfo);
				return "home";
			}else{
				//��¼ʧ�ܣ����ô�����ʾ��Ϣ����ת����¼ҳ��
				this.addActionError(this.getText("loginError"));
				return "login";
			}
			
		}
		else{
			//��֤�����,���ô�����ʾ��Ϣ����ת����¼ҳ��
			this.addActionError(this.getText("validateCodeError"));
			return "login";
		}
	}
	
	
	/**
	 * �û��˳�
	 */
	public String logout(){
		//����session
		ServletActionContext.getRequest().getSession().invalidate();
		return "login";
	}
	
	/**
	 * �û���ҳ
	 */
	public String home() {
		return "home";
	}
	
	/**
	 * �޸ĵ�ǰ��¼�û�����
	 * @throws IOException 
	 */
	public String editPassword() throws IOException{
		Userinfo user = (Userinfo) ServletActionContext.getRequest().getSession().getAttribute("loginUser");
		String password = model.getPassword();//������
		password = MD5Utils.md5(password);
		oldPwd=MD5Utils.md5(model.getName());
		String flag = "1";
		if(!user.getPassword().equals(oldPwd)){
			flag = "0";
			return NONE;
		}
		try{
			userService.editPassword(password,user.getStuOrEmpId());
		}catch (Exception e) {
			//�޸�����ʧ��
			flag = "0";
		}
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().print(flag);
		return NONE;
	}
	
	public String userinfo(){
		return "success";
	}
	
	
	/**
	 * �޸��û���Ϣ
	 * @return
	 * @throws IOException
	 */
	public String changeinfo() throws IOException{
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		if((model.getAge()==null)&&(model.getGraduationYear()==null)&&model.getEmail().equals("")&&model.getPhoneNo().equals(""))
		{
			ServletActionContext.getResponse().getWriter().print("failed");
		}
		else{
			Userinfo user = (Userinfo) ServletActionContext.getRequest().getSession().getAttribute("loginUser");
			if(model.getAge()!=null){
				user.setAge(model.getAge());
			}
			if(model.getGraduationYear()!=null){
				user.setGraduationYear(model.getGraduationYear());
			}
			if(!model.getEmail().equals("")){
				user.setEmail(model.getEmail());
			}
			if(!model.getPhoneNo().equals("")){
				user.setPhoneNo(model.getPhoneNo());
			}
			try {
				userService.update(user);
			} catch (Exception e) {
				ServletActionContext.getResponse().getWriter().print("failed");
				return NONE;
			}
			ServletActionContext.getResponse().getWriter().print("success");;
		}
		return NONE;
	}
	

	/**
	 * ��ҳ��ѯ�û�����
	 * @throws IOException 
	 */
	public String userinfos() throws IOException{
		PageBean pageBean = new PageBean();
		pageBean.setCurrentPage(page);
		pageBean.setPageSize(rows);
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Userinfo.class);
		String key=ServletActionContext.getRequest().getParameter("key");
		if(key!=null&&key!=""){
			detachedCriteria.add(Restrictions.or(Restrictions.like("stuOrEmpId", "%"+key+"%"), Restrictions.like("name", "%"+key+"%")));
		}
		String sex=ServletActionContext.getRequest().getParameter("msex");
		if(sex!=null&&sex!=""){
			Boolean bsex;
			if(sex.equals("1")){
				bsex=true;
			}
			else{
				bsex=false;
			}
			detachedCriteria.add(Restrictions.eq("sex", bsex));
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
			detachedCriteria.add(Restrictions.eq("isDelete", false));
		}
		String roleId=ServletActionContext.getRequest().getParameter("mroleId");
		
		if(roleId!=null&&roleId!=""){
			int role=Integer.parseInt(roleId);
			detachedCriteria.add(Restrictions.eq("roleId", role));
		}
		pageBean.setDetachedCriteria(detachedCriteria);
		userService.pageQuery(pageBean);
		
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
	 * ����id��ѯ����userinfo,�����ص�����Ա��Ϣ��ʾҳ��
	 * @throws IOException 
	 */
	public String userinfoDetail() throws IOException{
		String stuOrEmpId=ServletActionContext.getRequest().getParameter("stuOrEmpId");
		this.userinfo=userService.findById(stuOrEmpId);
		return "detail";
	}
	
	/**
	 * ����idɾ������Ա
	 * @throws IOException 
	 */
	public String deleteuser() throws IOException{
		String stuOrEmpId=ServletActionContext.getRequest().getParameter("stuOrEmpId");
		String flag = "1";
		try{
			userService.deleteuser(stuOrEmpId);
		}catch (Exception e) {
			//�޸�����ʧ��
			flag = "0";
		}
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().print(flag);
		return NONE;
	}
	
	
	/**
	 * �����û�����
	 * @throws IOException 
	 */
	public String resetPassword() throws IOException{
		String stuOrEmpId=ServletActionContext.getRequest().getParameter("stuOrEmpId");
		String pwd=MD5Utils.md5("000000");
		String flag = "1";
		try{
			userService.editPassword(pwd,stuOrEmpId);
		}catch (Exception e) {
			//�޸�����ʧ��
			flag = "0";
		}
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().print(flag);
		return NONE;
	}
	
	/**
	 * ����id����ɾ���û�
	 * @throws IOException 
	 */
	public String deletebatch() throws IOException{
		String ids=ServletActionContext.getRequest().getParameter("ids");
		try{
			userService.deletebatch(ids);
		}catch (Exception e) {
			//�޸�����ʧ��
		}
		return "list";
	}
	
	/**
	 * ���������û�
	 * @return
	 * @throws IOException
	 */
	public String signupuserbatch() throws IOException{
		String flag = "1";
		//ʹ�ãУϣɽ����ţ������ļ�
		try{
			HSSFWorkbook workbook = new HSSFWorkbook(new FileInputStream(myFile));
			//��õ�һ��sheetҳ
			HSSFSheet sheet = workbook.getSheetAt(0);
			List<Userinfo> list = new ArrayList<Userinfo>();
			for (Row row : sheet) {
				int rowNum = row.getRowNum();
				if(rowNum == 0){
					//��һ�У������У�����
					continue;
				}
				Userinfo signUser=new Userinfo();
				String stuOrEmpId = getStringCellValue((HSSFCell)row.getCell(0));
				if(stuOrEmpId!=null&&(!stuOrEmpId.isEmpty())){
					signUser.setStuOrEmpId(stuOrEmpId);
				}
				String name = getStringCellValue((HSSFCell)row.getCell(1));
				if(name!=null&&(!name.isEmpty())){
					signUser.setName(name);
				}
				String sex = getStringCellValue((HSSFCell)row.getCell(2));
				if(sex!=null&&(!sex.isEmpty())){
			        if(sex.equals("��")){
			        	signUser.setSex(true);
			        }
			        else{
			        	signUser.setSex(false);
			        }
				}
				String age = getStringCellValue((HSSFCell)row.getCell(3));
				if(age!=null&&(!age.isEmpty())){
					signUser.setAge(Integer.parseInt(age));
				}
				String password = getStringCellValue((HSSFCell)row.getCell(4));
				if(password!=null&&(!password.isEmpty())){
					signUser.setPassword(MD5Utils.md5(password));
				}
				String email = getStringCellValue((HSSFCell)row.getCell(5));
				if(email!=null&&(!email.isEmpty())){
					signUser.setEmail(email);
				}
				String idcard = getStringCellValue((HSSFCell)row.getCell(6));
				if(idcard!=null&&(!idcard.isEmpty())){
					signUser.setIdcard(idcard);
				}
				String phoneNo = getStringCellValue((HSSFCell)row.getCell(7));
				if(phoneNo!=null&&(!phoneNo.isEmpty())){
					signUser.setPhoneNo(phoneNo);
				}
				String roleId = getStringCellValue((HSSFCell)row.getCell(8));
				if(roleId!=null&&(!roleId.isEmpty())){
					 if(roleId.equals("��ְ��")){
				        	signUser.setRoleId(1);
				        }
				        else{
				        	signUser.setRoleId(2);
				        }
				}
				String graduationYear = getStringCellValue((HSSFCell)row.getCell(9));
				if(graduationYear!=null&&(!graduationYear.isEmpty())){
					signUser.setGraduationYear(Integer.parseInt(graduationYear));;
				}
				String seniority = getStringCellValue((HSSFCell)row.getCell(10));
				if(seniority!=null&&(!seniority.isEmpty())){
					signUser.setSeniority(Integer.parseInt(seniority));;
				}
				String department = getStringCellValue((HSSFCell)row.getCell(11));
				if(department!=null&&(!department.isEmpty())){
					signUser.setDepartment(department);
				}
				String job = getStringCellValue((HSSFCell)row.getCell(12));
				if(job!=null&&(!job.isEmpty())){
					signUser.setJob(job);
				}
				String imgsrc = "\\img\\user\\user_default.png";
				signUser.setImgsrc(imgsrc);
				String account=getStringCellValue((HSSFCell)row.getCell(13));
				if(account!=null&&(!account.isEmpty())){
					signUser.setAccount(Float.parseFloat(account));;
				}
				else {
					signUser.setAccount((float)0);
				}
		        signUser.setIsDelete(false);
				list.add(signUser);
			}
			userService.saveBatch(list);
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
	 * ����id�����޸��û���Ϣ����ʹ���id��Ϣ
	 * @throws IOException 
	 */
	public String changeUser() throws IOException{
//		this.stuOrEmpId=ServletActionContext.getRequest().getParameter("stuOrEmpId");
	    this.userinfo=userService.findById(ServletActionContext.getRequest().getParameter("stuOrEmpId"));
		return "change";
	}
	
	/**
	 * ����Ա����id�޸��û���Ϣ
	 * @return
	 * @throws IOException
	 */
	public String changeuserinfo() throws IOException{
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		String stuOrEmpId1=ServletActionContext.getRequest().getParameter("stuOrEmpId");
		if(stuOrEmpId1==null||stuOrEmpId1==""){
			ServletActionContext.getResponse().getWriter().print("failed");
			return NONE;
		}
		String sex=ServletActionContext.getRequest().getParameter("sex");		
		Userinfo updateuser = userService.findById(stuOrEmpId1);
		if(sex!=null)
		{
			if(sex.equals("1")){
				updateuser.setSex(true);
			}
			else{
				updateuser.setSex(false);
			}
		}
		if(model.getAge()!=null){
			updateuser.setAge(model.getAge());
		}
		if(model.getName()!=null&&!model.getName().isEmpty()){
			updateuser.setName(model.getName());
		}
		if(model.getDepartment()!=null&&!model.getDepartment().isEmpty()){
			updateuser.setDepartment(model.getDepartment());
		}
		if(model.getEmail()!=null&&!model.getEmail().isEmpty()){
			updateuser.setEmail(model.getEmail());
		}
		if(model.getIdcard()!=null&&!model.getIdcard().isEmpty()){
			updateuser.setIdcard(model.getIdcard());
		}
		if(model.getJob()!=null&&!model.getJob().isEmpty()){
			updateuser.setJob(model.getJob());
		}
		if(model.getPhoneNo()!=null&&!model.getPhoneNo().isEmpty()){
			updateuser.setPhoneNo(model.getPhoneNo());
		}
		if(model.getGraduationYear()!=null){
			if(updateuser.getRoleId()==1){
				updateuser.setSeniority(model.getGraduationYear());
			}
			else {
				updateuser.setGraduationYear(model.getGraduationYear());
			}
		}
		try {
			userService.update(updateuser);
		} catch (Exception e) {
			ServletActionContext.getResponse().getWriter().print("failed");
			return NONE;
		}
		ServletActionContext.getResponse().getWriter().print("success");
		return NONE;
	}
	
	/**
	 * ע���û�
	 * @throws IOException 
	 */
	public String adduser() throws IOException{
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		String sex=ServletActionContext.getRequest().getParameter("sex");
		if(sex.equals("1")){
			model.setSex(true);
		}
		else{
			model.setSex(false);
		}
		model.setIsDelete(false);
		model.setImgsrc("\\img\\user\\user_default.png");
		model.setPassword(MD5Utils.md5(model.getPassword()));
		model.setAccount((float)0);
		if(model.getRoleId()==1||model.getRoleId()==3){
			model.setSeniority(model.getGraduationYear());
			model.setGraduationYear(null);
		}
		try{
			userService.adduser(model);
		}catch (Exception e) {
			//ע��ʧ��
			ServletActionContext.getResponse().getWriter().print("failed");
			return NONE;
		}
		ServletActionContext.getResponse().getWriter().print("success");
		return NONE;
	}
	
	
	/**
	 * ��ѯ�����û���ѧ��
	 * @return
	 * @throws IOException
	 */
	public String alluserinfo() throws IOException{
		List <Userinfo> userinfos=userService.findAll();
		String[] excludes=new String[]{"sex","age","password","email","idcard","phoneNo","roleId",
				"graduationYear","seniority","department","job","isDelete","imgsrc","account"};
		this.writeList2Json(userinfos, excludes);
		return NONE;
	}
}
