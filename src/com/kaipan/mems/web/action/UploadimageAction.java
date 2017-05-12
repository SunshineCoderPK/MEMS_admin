package com.kaipan.mems.web.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.json.annotations.JSON;
import org.apache.commons.fileupload.FileItem;

import com.kaipan.mems.domain.Admininfo;
import com.kaipan.mems.domain.Userinfo;
import com.kaipan.mems.service.IAdminInfoService;
import com.kaipan.mems.service.IUserService;
import com.opensymphony.xwork2.ActionSupport;


public class UploadimageAction extends ActionSupport{
	private String foldername;
	private File file;
	private String fileFileName;
    private String fileFileContentType;
    private String messageString;
    
    @Resource
	private IUserService userService;
    
    @Resource
	private IAdminInfoService adminInfoService;
    
    
	public String getFileFileName() {
		return fileFileName;
	}
	public void setFileFileName(String fileFileName) {
		this.fileFileName = fileFileName;
	}
	public String getFileFileContentType() {
		return fileFileContentType;
	}
	public void setFileFileContentType(String fileFileContentType) {
		this.fileFileContentType = fileFileContentType;
	}

	private JSONArray json_uploadimage_response;
	public File getFile() {
		return file;
	}
	public void setFile(File file) {
		this.file = file;
	}

	
	public String uploadimg() throws Exception{
		System.out.println("upload_image()");
		foldername=ServletActionContext.getRequest().getParameter("folder");
		ServletActionContext.getResponse().setContentType("text/json;charset=UTF-8");
		try{
			String flag="";
			Map map = new HashMap();
			String pathString="E:/Mems/Image/"+foldername;
			HttpSession session = ServletActionContext.getRequest().getSession();
//			String reString="[{res:'success'}]";
//			json_uploadimage_response=JSONArray.fromObject(reString);
			System.out.println("pathstring = "+pathString);//获得项目路径
		
			String filepathString=pathString;
			//构建文件对象
			File folder=new File(filepathString);
			//检测文件夹是否存在，如果不存在，则新建images目录
			if(!folder.exists()){
			    folder.mkdirs();
			}
			System.out.println("filepathstring = "+filepathString);
			String name = fileFileName.substring(fileFileName.lastIndexOf(".")); // 得到后缀名
			if(!(name.equals(".jpg") || name.equals(".gif")||name.equals(".png")||name.equals(".JPG")
					||name.equals(".GIF")||name.equals(".PNG")))
			{
				flag="fail1";
				map.put("data", flag);
				JSONObject jsonObject = JSONObject.fromObject(map);
				ServletActionContext.getResponse().getWriter().print(jsonObject);
				return NONE;
			}
			if(this.getFile()==null)
			{
				flag="fail2";
				map.put("data", flag);
				JSONObject jsonObject = JSONObject.fromObject(map);
				ServletActionContext.getResponse().getWriter().print(jsonObject);
				return NONE;
			}
			int random = (int) (Math.random() * 10000); // 随机数
			String fileName = System.currentTimeMillis() + random + fileFileName.substring(fileFileName.indexOf(".")); // 通过得到系统时间加随机数生成新文件名，避免重复
			System.out.println(System.currentTimeMillis());
		
	        
        	FileInputStream inputStream = new FileInputStream(this.getFile());
	        FileOutputStream outputStream = new FileOutputStream(filepathString + "\\" + fileName);
	        byte[] buf = new byte[1024];
	        int length = 0;
	        while ((length = inputStream.read(buf)) != -1) {
	            outputStream.write(buf, 0, length);
	        }
	        inputStream.close();
	        outputStream.flush();
	        String imgsrc="\\img"+"\\"+foldername+"\\"+fileName;
            if(foldername.equals("user")){
            	Userinfo userinfo=(Userinfo)session.getAttribute("loginUser");
            	userinfo.setImgsrc(imgsrc);
            	userService.update(userinfo);
            }
            if(foldername.equals("admin")){
            	if(ServletActionContext.getRequest().getParameter("empId")!=null&&ServletActionContext.getRequest().getParameter("empId")!=""){
            		String empId=ServletActionContext.getRequest().getParameter("empId");
            		Admininfo admininfo=adminInfoService.findById(empId);
                	admininfo.setImgsrc(imgsrc);
                	adminInfoService.update(admininfo);
                	ServletActionContext.getRequest().getSession().setAttribute("loginAdmin", admininfo);
            	}
            	else{
            		flag="fail3";
    				map.put("data", flag);
    				return NONE;
            	}
            }
            flag=imgsrc;
			map.put("data", flag);
			JSONObject jsonObject = JSONObject.fromObject(map);
			ServletActionContext.getResponse().getWriter().print(jsonObject);
			return NONE;
			}catch (Exception e){
			    e.printStackTrace();
			    // String reString="[{res:'error'}]";
			    // json_uploadimage_response=JSONArray.fromObject(reString);
			    return NONE;
		    }	
	}
		
	public JSONArray getJson_uploadimage_response() {
		return json_uploadimage_response;
	}
	public void setJson_uploadimage_response(JSONArray json_uploadimage_response) {
		this.json_uploadimage_response = json_uploadimage_response;
	}
	public String getMessageString() {
		return messageString;
	}
	public void setMessageString(String messageString) {
		this.messageString = messageString;
	}
}

