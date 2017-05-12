<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="javax.security.auth.message.callback.PrivateKeyCallback.Request"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery-1.8.0.min.js"></script>
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
	href="${pageContext.request.contextPath }/css/userinfo.css">
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
<script type="text/javascript"
    src="${pageContext.request.contextPath }/js/layui/layui.js">
</script>
<script type="text/javascript"
    src="${pageContext.request.contextPath }/js/layui/lay/modules/layer.js">
</script>
<script type="text/javascript"
    src="${pageContext.request.contextPath }/js/ajaxfileupload.js">
</script>
</head>
<body>
	
	<div class="cztable">
		<table width="100%" cellpadding="0" cellspacing="0">
        <tr>
            <td align="right" width="80">姓名：</td>
            <td>${userinfo.name }&nbsp;</td>
            <td align="right" width="90">身份证号码：</td>
            <td>${userinfo.idcard }&nbsp;</td>
            
            <td rowspan="7"><div align="center"><img id="pic_face" class="img" height="160" width="120" src="${userinfo.imgsrc}" style="padding:2px 2px 5px; border:1px #ddd solid;"></div>&nbsp;</td>
        </tr>
        <tr>
            <td align="right">性别：</td>
            <td>${userinfo.sex?"男":"女" }&nbsp;</td>
            <td align="right">年龄：</td>
            <td>${(empty userinfo.age)?"":userinfo.age }&nbsp;</td>
        </tr>
        <tr>
            <td align="right">身份：</td>
            <td>${(userinfo.roleId==1)?"教职工":"学生" }&nbsp;</td>
            <td align="right">学/工号：</td>
            <td>${userinfo.stuOrEmpId }&nbsp;</td>
        </tr>
        
        <tr>
            <td align="right">毕业年份：</td>
            <td>${(empty userinfo.graduationYear)?"":userinfo.graduationYear }&nbsp;</td>
            
            <td align="right">工龄：</td>
            <td>${(empty userinfo.seniority)?"":userinfo.seniority }&nbsp;</td>
        </tr>
        <tr>
            <td align="right">学院/部门：</td>
            <td>${(empty userinfo.department)?"":userinfo.department }&nbsp;</td>
            <td align="right">专业/职位：</td>
            <td>${(empty userinfo.job)?"":userinfo.job }&nbsp;</td>
        </tr>
        
        <tr>
            <td colspan="4" align="left">联系方式（如联系方式有变动请及时修改，以便能及时联系到你。谢谢！）</td>
            
        </tr>
        <tr class="end">
            <td align="right">邮箱：</td>
            <td>${(empty userinfo.email)?"":userinfo.email }&nbsp;</td>
            <td align="right">联系方式：</td>
            <td >${(empty userinfo.phoneNo)?"":userinfo.phoneNo }&nbsp;</td>
			</tr> 
        <tr>
            <td align="right">联系地址：</td>
            <td colspan="4"></td>
        </tr> 
         <tr>
            <td colspan="5" align="left" height="60px">备注</td>
            
        </tr>         
    </table>
  
</div>

</body>
</html>