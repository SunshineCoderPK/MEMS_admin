<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@page import="javax.security.auth.message.callback.PrivateKeyCallback.Request"%>
<%@page import="com.kaipan.mems.domain.Admininfo"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--[if lt IE 9]>
<script type="text/javascript" src="lib/html5shiv.js"></script>
<script type="text/javascript" src="lib/respond.min.js"></script>
<![endif]-->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery-1.8.3.js"></script>


  <link rel="stylesheet" href="css/amazeui.min.css"/>
  <link rel="stylesheet" href="css/admin.css">
 <script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery-1.8.0.min.js"></script>
<!-- 导入easyui类库 -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/layui/css/layui.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/layui/css/modules/layer/default/layer.css">


<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/FormatDate.js">
</script>
<script type="text/javascript"
    src="${pageContext.request.contextPath }/js/layui/layui.js">
</script>
<script type="text/javascript"
    src="${pageContext.request.contextPath }/js/layui/lay/modules/layer.js">
</script>
<script type="text/javascript"
    src="${pageContext.request.contextPath }/js/ajaxfileupload.js">
</script>
<script type="text/javascript" src="js/amazeui.min.js"></script>


</head>
<body>
<%
			Admininfo admininfo = (Admininfo) request.getSession().getAttribute("loginAdmin");
		%>
 <input type="hidden" id="mId" value=${empId}>
<!-- content start -->
  <div class="admin-content">
    <div class="am-cf am-padding">
      <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">个人资料</strong> / <small>Personal information</small></div>
    </div>

    <hr/>

    <div class="am-g">

      <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8">
        <div class="am-panel am-panel-default">
          <div class="am-panel-bd">
            <div class="am-g">
              <div class="am-u-md-4" style="width:100%">
                <center><img id="adminimg" class="am-img-circle am-img-thumbnail" src="<%=admininfo.getImgsrc() %> " style="width: 130px;height: 170px;"/></center>
              </div>
              <div class="am-u-md-8" style="width:100%">
                <center><form class="am-form">
                  <div class="am-form-group">
                    <input type="file"  name="file" contentEditable="false"  id="adminpic" style="margin-left: 70px;margin-bottom: 20px;margin-top: 20px">
                   
                    <button type="button" style="width: 130px; " class="am-btn am-btn-primary am-btn-xs" onclick="upload_image()">保存</button>
                  </div>
                </form>
                </center>
              </div>
            </div>
          </div>
        </div>

        

      </div>

      <div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4">
        <form class="layui-form am-form am-form-horizontal" id="change_admin_info">
          <div class="am-form-group">
            <label for="user-name" class="am-u-sm-3 am-form-label"  >姓名 / Name</label>
            <div class="am-u-sm-9" style="width: 100px;">
               <label for="user-name" class="am-u-sm-3 am-form-label" style="width: 100px; text-align: center"><%=admininfo.getName()%></label>
            </div>
            <label for="user-name" class="am-u-sm-3 am-form-label" style="width: 150px;">工号 / EmpId</label>
            <div class="am-u-sm-9" style="width: 100px; margin: 0;float: left;" >
               <label for="user-name" id="empId" style="width: 100px; text-align: center;padding-top : 10px" class="am-u-sm-3 am-form-label"><%=admininfo.getEmpId()%></label>
            </div>
          </div>
       
       
          
          <div class="am-form-group">
            <label for="user-idcard" class="am-u-sm-3 am-form-label">身份证号 / IdCard</label>
            <div class="am-u-sm-9" >
              <label for="user-name" class="am-u-sm-3 am-form-label" style="padding-top: 10px"><%=admininfo.getIdcard()%></label>
            </div>
          </div>
          
           <div class="am-form-group">
            <label for="user-age" class="am-u-sm-3 am-form-label">年龄</label>
            <div class="am-u-sm-9" style="width: 150px;height: 30px">
              <input type="text" id="admin-age"  style="width: 100px; height: 30px" name="age" value="<%=(admininfo.getAge()==null)?"":admininfo.getAge() %>" lay-verify="age" >
            </div>
        
            <label for="user-sex" class="am-u-sm-3 am-form-label" style="width: 150px;text-align: left;">性别</label>
             <% String sex;
            if(admininfo.getSex()==null){
            	sex="";
            }else if(admininfo.getSex()==false)
            {
            	sex="女";
            }
            else{
            	sex="男";
            }
            %>
            <div class="am-u-sm-9" style="width: 100px; margin: 0;float: left;padding-left: 0;">
             <label for="user-name" id="empId" style="width: 100px; text-align: left;padding-left: 0;" class="am-u-sm-3 am-form-label"><%=sex %></label>
            </div>
          </div>

          <div class="am-form-group">
            <label for="user-email" class="am-u-sm-3 am-form-label">电子邮件 / Email</label>
            <div class="am-u-sm-9">
              <input type="email" id="admin-email" name="email"  value="<%=(admininfo.getEmail()==null)?"":admininfo.getEmail() %>" lay-verify="email" placeholder="输入你的电子邮件 / Email">
            </div>
          </div>

          <div class="am-form-group">
            <label for="admin-phone" class="am-u-sm-3 am-form-label">电话 / Telephone</label>
            <div class="am-u-sm-9">
              <input type="text" id="admin-phone"name="phoneNo" lay-verify="phone" value="<%=(admininfo.getPhoneNo()==null)?"":admininfo.getPhoneNo() %>" placeholder="输入你的电话号码 / Telephone">
            </div>
          </div>

          <div class="am-form-group">
            <label for="user-QQ" class="am-u-sm-3 am-form-label">部门</label>
            <div class="am-u-sm-9">
              <input type="text" name="department" id="admin-dep" value="<%=(admininfo.getDepartment()==null)?"":admininfo.getDepartment() %>" >
            </div>
          </div>
          
         
          

          <div class="am-form-group">
            <label for="admin-weibo" class="am-u-sm-3 am-form-label">职位</label>
            <div class="am-u-sm-9">
              <input type="text" name="job" id="admin-job" value="<%=(admininfo.getJob()==null)?"":admininfo.getJob() %>" >
            </div>
          </div>

          <div class="am-form-group">
            <label for="user-intro" class="am-u-sm-3 am-form-label">备注 / Intro</label>
            <div class="am-u-sm-9">
              <textarea class="" rows="5" id="admin-intro" name="remark" placeholder="备注信息" value="<%=admininfo.getRemark()%>"></textarea>
              <small>250字以内写出备注信息...</small>
            </div>
          </div>

          <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">
              <button type="button" lay-submit lay-filter="formDemo" class="am-btn am-btn-primary">保存修改</button>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
  <!-- content end -->
</body>
<script type="text/javascript">
function upload_image(){
	 $.ajaxFileUpload
     (
         {
             url:'${pageContext.request.contextPath}/uploadimageAction_uploadimg.action?empId='+$("#empId").text(),//用于文件上传的服务器端请求地址
             secureuri:false,//一般设置为false
             fileElementId:'adminpic',//文件上传空间的id属性  <input type="file" id="file" name="file" />
             dataType: 'json',//返回值类型 一般设置为json
             data : {
                 folder:"admin",
             },
             success: function (data, status)  //服务器成功响应处理函数
             {
            	 if(data.data=="fail1"){
                	 layer.msg("所选文件非图片格式");
	                 return false;
	             }
            	 if(data.data=="fail3"){
                	 layer.msg("请注册该用户后再上传图片");
	                 return false;
	             }
	             if(data.data=="fail2"){
	            	 layer.msg("你选择的图片错误或者该图片已经损坏！");
	            	 return false;
		         }
                 //从服务器返回的json中取出message中的数据,其中message为在struts2中定义的成员变量
                 $("#adminimg").attr("src",data.data);
                 
             },
             error: function (data, status, e)//服务器响应失败处理函数
             {
            	 layer.msg("你选择的图片错误或者该图片已经损坏！");
            	 return false;              
             }
         }
     )
}

$(function () {
	layui.use(['form', 'layedit', 'laydate'], function(){  
		  var form = layui.form(); 
        form.verify({
			age : function(value) {
				if (value!=""&&!(/^[1-9]\d{0,2}$/).test(value)||parseInt(value)> 120 || parseInt(value) < 0) {
					return '年龄在0-120之间';
				}
			},
			phone : function(value) {
				if (value!=""&&!(/^1[3|4|5|7|8]\d{9}$/).test(value)) {
					return '手机必须11位，只能是数字！';
				}
			}
			,
			email : function(value) {
				if (value!=""&&!(/^[a-z0-9._%-]+@([a-z0-9-]+\.)+[a-z]{2,4}$|^1[3|4|5|7|8]\d{9}$/).test(value)) {
					return '邮箱格式不对';
				}
			}
		});

        
     form.on('submit(formDemo)', function(data) {
  	   $.post('${pageContext.request.contextPath}/adminAction_changeadmininfo.action?empId='+$("#empId").text(),data.field,function(res){
  		     if(res=="failed"){
  		    	 layer.msg("修改失败");
  		    	 window.location.href=window.location.href;
	    		 }
  		     else{
	    		    layer.msg("修改成功");
	    		    window.location.href=window.location.href;
  		     } 
  		  /*    parent.window.location.href="${pageContext.request.contextPath}/adminAction_changeAdmin.action?empId="+$("#mId").val();   */
            /*  var index = parent.layer.getFrameIndex(window.name); //获取窗口索引  
             parent.layer.close(index); 
             parent.window.location.href=parent.window.location.href; */
  		   
  		 });
		}); 
	});
})

function clearall() {
	$("#admin-name").val("");
	$("#admin-IdCard").val("");
	$("#admin-age").val("");
	$("#admin-email").val("");
	$("#admin-phone").val("");
	$("#admin-dep").val("");
	$("#admin-job").val("");
	$("#admin-intro").val("");
	
}
</script>
</html>