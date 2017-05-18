<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="Bookmark" href="/favicon.ico" >
<link rel="Shortcut Icon" href="/favicon.ico" />
<!--[if lt IE 9]>
<script type="text/javascript" src="lib/html5shiv.js"></script>
<script type="text/javascript" src="lib/respond.min.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="h-ui/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="h-ui.admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="lib/Hui-iconfont/1.0.8/iconfont.css" />
<link rel="stylesheet" type="text/css" href="h-ui.admin/skin/default/skin.css" id="skin" />
<link rel="stylesheet" type="text/css" href="h-ui.admin/css/style.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/layui/css/layui.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/layui/css/modules/layer/default/layer.css">
<!--[if IE 6]>
<script type="text/javascript" src="lib/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script>
<![endif]-->
<!--/meta 作为公共模版分离出去-->

<title>添加用户 - 在线医疗报销系统后台</title>
</head>
<body>
<article class="page-container">
	<form action="" method="post" class=" layui-form form form-horizontal" id="form-member-add">
	    <div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>工号：</label>
			<div class="formControls col-xs-8 col-sm-9" style="width: 200px">
				<input type="text" class="input-text" value="" placeholder="" id="user_empId" name="stuOrEmpId">
			</div>
			<label class="form-label col-xs-4 col-sm-3" style="width: 100px"><span class="c-red">*</span>用户名：</label>
			<div class="formControls col-xs-8 col-sm-9" style="width: 200px">
				<input type="text" class="input-text" value="" placeholder="" id="user_name" name="name">
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">年龄：</label>
			<div class="formControls col-xs-8 col-sm-9" style="width: 100px">
				<input type="text" class="input-text" value="" placeholder="" id="user_age" name="age">
			</div>
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>性别：</label>
			<div class="formControls col-xs-8 col-sm-9 skin-minimal" style="width: 200px">
				<div class="radio-box" id="user_sex" >
					<input name="sex" type="radio" id="sex-1" value=1 checked>
					<label for="sex-1">男</label>
				</div>
				<div class="radio-box">
					<input type="radio" id="sex-2" name="sex"  value=0>
					<label for="sex-2">女</label>
				</div>
				</div>
		</div>

		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>密码：</label>
			<div class="formControls col-xs-8 col-sm-9" style="width: 500px">
				<input type="password" class="input-text" name="password" id="user_password">
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">手机：</label>
			<div class="formControls col-xs-8 col-sm-9" style="width: 200px">
				<input type="text" class="input-text" value="" placeholder="" id="user_phone" name="phoneNo">
			</div>
			<label class="form-label col-xs-4 col-sm-3" style="width: 100px">邮箱：</label>
			<div class="formControls col-xs-8 col-sm-9" style="width:200px">
				<input type="text" class="input-text" placeholder="@"  name="email" id="user_email">
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">身份：</label>
			<div class="formControls col-xs-8 col-sm-9" style="width: 200px;height: 31px">
				 <select id="roleId" name="roleId" onchange="gradeChange()" class="selectborder" style="width: 170px;height: 31px; display: block; border:  solid 1px #ddd;">
                 <option value=1>在职教职工</option>
                 <option value=2>学生</option>
                 <option value=3>退休教职工</option>
              </select>
			</div>
			<label class="form-label col-xs-4 col-sm-3" style="width: 100px" id="gs">工龄：</label>
			<div class="formControls col-xs-8 col-sm-9" style="width:200px">
				<input type="text" class="input-text" placeholder="@"  name="graduationYear" id="user_graduationYear">
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>身份证号：</label>
			<div class="formControls col-xs-8 col-sm-9" style="width:500px">
				<input type="text" class="input-text"  name="idcard" id="user_idcard">
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">部门：</label>
			<div class="formControls col-xs-8 col-sm-9" style="width:500px">
				<input type="text" class="input-text" name="department" id="user_department">
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">职位：</label>
			<div class="formControls col-xs-8 col-sm-9" style="width:500px">
				<input type="text" class="input-text"  name="job" id="user_job">
			</div>
		</div>
		
		<div class="row cl">
			<div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-3">
				<input class="btn btn-primary radius" type="submit" lay-submit lay-filter="formDemo" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
			</div>
		</div>
	</form>
</article>

<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script> 
<script type="text/javascript" src="lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="h-ui/js/H-ui.min.js"></script> 
<script type="text/javascript" src="h-ui.admin/js/H-ui.admin.js"></script>
<script type="text/javascript"
    src="${pageContext.request.contextPath }/js/layui/layui.js">
</script>
<script type="text/javascript"
    src="${pageContext.request.contextPath }/js/layui/lay/modules/layer.js">
</script>
<!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本--> 
<script type="text/javascript" src="lib/My97DatePicker/4.8/WdatePicker.js"></script>
<script type="text/javascript" src="lib/jquery.validation/1.14.0/jquery.validate.js"></script> 
<script type="text/javascript" src="lib/jquery.validation/1.14.0/validate-methods.js"></script> 
<script type="text/javascript" src="lib/jquery.validation/1.14.0/messages_zh.js"></script>
<script type="text/javascript">
$(function(){
	$('.skin-minimal input').iCheck({
		checkboxClass: 'icheckbox-blue',
		radioClass: 'iradio-blue',
		increaseArea: '20%'
	});
	
	$("#form-member-add").validate({
		rules:{
			stuOrEmpId:{
				required:true,
				minlength:2,
				maxlength:10
			},
			name:{
				required:true,
				minlength:2,
				maxlength:16
			},
			sex:{
				required:true,
			},
			password:{
				required:true,
			},
			idcard:{
				required:true,
			},
			phoneNo:{
				isMobile:true,
				digits:true,
			},
			email:{
				email:true,
			},
			graduationYear:{
				required:true,
				digits:true,
			},
			
		},
		onkeyup:false,
		focusCleanup:true,
		success:"valid",
		submitHandler:function(form){
			 $(form).ajaxSubmit({
	                dataType:"text",
	                url:"${pageContext.request.contextPath}/userAction_adduser.action",
	                success:function( jsondata ){
	                	if(jsondata=="failed"){
	     	  		    	 layer.msg("注册失败");
	     	  		    	 clearall();
	     		    	}
	     	  		     else{
	     		    		 layer.msg("注册成功");
	     		    		var index = parent.layer.getFrameIndex(window.name);
		        			parent.layer.close(index);
		        			parent.location.reload();
	     	  		     }         			
	                  }
	                }); 
	  		   
	  		 }
	});
});
function clearall() {
	$("#user_name").val("");
	$("#user_idcard").val("");
	$("#user_age").val("");
	$("#user_email").val("");
	$("#user_phone").val("");
	$("#user_department").val("");
	$("#user_job").val("");
	$("#user_graduationYear").val("");
	$("#user_password").val("");
	$("#user_stuOrEmpId").val("");
}

function gradeChange() {
	if($("#roleId option:selected").val()==1){
		$("#gs").text("工龄");
	}
	else{
		$("#gs").text("毕业年份");
	}
}
</script> 
<!--/请在上方写此页面业务相关的脚本-->
</body>
</html>