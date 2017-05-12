<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
		<center>
		<table width="96%" cellpadding="0" cellspacing="0">
        <tr>
            <td align="right" width="80">姓名：</td>
            <td>${admininfo.name }&nbsp;</td>
            <td align="right" width="90">身份证号码：</td>
            <td>${admininfo.idcard }&nbsp;</td>
            
            <td rowspan="6"><div align="center"><img id="pic_face" class="img" height="160" width="120" src="${admininfo.imgsrc}" style="padding:2px 2px 5px; border:1px #ddd solid;"></div>&nbsp;</td>
        </tr>
        <tr>
            <td align="right">性别：</td>     
            <td>${admininfo.sex?"男":"女" }&nbsp;</td>
            <td align="right">年龄：</td>
            <td>${(empty admininfo.age)?"":admininfo.age }&nbsp;</td>
        </tr>
        <tr>
            <td align="right">身份：</td>
            <td>管理员&nbsp;</td>
            <td align="right">工号：</td>
            <td>${admininfo.empId }&nbsp;</td>
        </tr>
        
        <tr>
            <td align="right">部门：</td>
            <td>${(admininfo.department eq null)?"":admininfo.department }&nbsp;</td>
            <td align="right">职位：</td>
            <td>${(admininfo.job eq null)?"":admininfo.job }&nbsp;</td>
        </tr>
        
        <tr>
            <td colspan="4" align="left">联系方式（如联系方式有变动请及时修改，以便能及时联系到你。谢谢！）</td>
            
        </tr>
        <tr class="end">
            <td align="right">邮箱：</td>
            <td>${(admininfo.email eq null)?"":admininfo.email }&nbsp;</td>
            <td align="right">联系方式：</td>
            <td>${(admininfo.phoneNo eq null)?"":admininfo.phoneNo }&nbsp;</td>
        <tr>
            <td align="right">联系地址：</td>
            <td colspan="4"></td>
        </tr> 
         <tr>
            <td colspan="5"align="left">备注</td>
            
        </tr>
        <tr align="center">
            <td colspan="9" height="60">
                ${(admininfo.remark eq null)?"":admininfo.remark }
            </td>
        </tr>           
    </table>
  </center>
</div>
<script type="text/javascript">

 
</script>
</body>
</html>