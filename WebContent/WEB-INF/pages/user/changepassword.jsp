<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="javax.security.auth.message.callback.PrivateKeyCallback.Request"%>
<%@page import="com.kaipan.mems.domain.Userinfo"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery-1.8.3.js"></script>
<!-- 导入easyui类库 -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui/ext/portal.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/css/default.css">	
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/layui/css/layui.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/layui/css/modules/layer/default/layer.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/css/changepassword.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/easyui/ext/jquery.portal.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/easyui/ext/jquery.cookie.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/easyui/locale/easyui-lang-zh_CN.js">
</script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/FormatDate.js">
</script>
<script src="${pageContext.request.contextPath }/js/layui/layui.js"
	type="text/javascript">
</script>
</head>
<body>

	<h2 class="mbx">我的信息 &gt; 密码修改</h2>
	<div class="cztable">
		<table border="0" cellspacing="0" cellpadding="0" width="500px"
			style="margin: 30px auto 0px auto;">
			<tr align="center">
				<th style="width: 20%; text-align: left;">旧密码：</th>
				<td style="width: 70%; text-align: left;"><input id="txtOldPwd" 
                    required="true" data-options="validType:'length[4,10]'"
					value="" type="password" class="input_2 txtinput1  easyui-validatebox" /></td>
			</tr>
			<tr align="center">
				<th style="width: 20%; text-align: left;">新密码：</th>
				<td style="width: 70%; text-align: left;"><input id="txtNewPwd"
				    required="true" data-options="validType:'length[4,10]'"  
					value="" type="password" class="input_2 txtinput1 easyui-validatebox" />&nbsp;&nbsp;6~16个字符，区分大小写</td>
			</tr>
			<tr align="center">
				<th style="width: 20%; text-align: left;">确认新密码：</th>
				<td style="width: 70%; text-align: left;"><input
					id="txtConfirmNewPwd" value="" type="password"
					required="true" data-options="validType:'length[4,10]'" 
					class="input_2 txtinput1 easyui-validatebox" /></td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;"><input
					type="submit" id="btnSubmit" value="确认修改"
					onclick="changePassword()" class="input2" /></td>
			</tr>
		</table>
	</div>
	<script type="text/javascript" language="javascript">
    function changePassword() {
        var oldPwd = $("#txtOldPwd").val();
        var newPwd = $("#txtNewPwd").val();
        var confirmNewPwd = $("#txtConfirmNewPwd").val();
        if(oldPwd == newPwd){
        	$.messager.alert("提示信息","新旧密码相同！","warning");
			
		}else if(confirmNewPwd!=newPwd){
			//输入不一致，提示用户输入不一致
			$.messager.alert("提示信息","两次输入密码不一致！","warning");
		}
		else {
			//输入一致，发送ajax请求，修改当前用户的密码
			var url = "${pageContext.request.contextPath}/userAction_editPassword.action";
			$.post(url,{"password":newPwd,"name":oldPwd},function(data){
				if(data == '1'){
					//修改密码成功
					$.messager.alert("提示信息","密码修改成功！","info");
				}else{
					//修改失败
					$.messager.alert("提示信息","旧密码错误！","warning");
				}
			});
		}
		$("#txtOldPwd").val("");
		$("#txtNewPwd").val("");
		$("#txtConfirmNewPwd").val("");
    }
</script>
</body>
</html>