<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="javax.security.auth.message.callback.PrivateKeyCallback.Request"%>
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
	<input type="hidden" value="${medicalitem }"/>
	<div class="cztable">
		<table width="100%" cellpadding="0" cellspacing="0">
        <tr>
            <td align="center" width="80">报销项编号：</td>
            <td width="80" align="center">${medicalitem.medicalNum }&nbsp;</td>
            <td align="center" width="80">报销类型：</td>
            <td width="80" align="center">${(medicalitem.expenseTyp eq null)?"":medicalitem.expenseTyp}&nbsp;</td>
        </tr>
        <tr>
            <td align="center" width="80">报销项名称：</td>
            <td align="center" width="80">${medicalitem.medicalName }&nbsp;</td>
            <td align="center" width="80">单位：</td>
            <td align="center" width="80">${(empty medicalitem.medicUnit )?"":medicalitem.medicUnit}&nbsp;</td>
        </tr>
        <tr>
            <td align="center" width="80">最高限价：</td>
            <td align="center" width="80">${(medicalitem.medicalPrice==null or medicalitem.medicalPrice==0 )?"不限价":medicalitem.medicalPrice }&nbsp;</td>
            <td align="center" width="80">是否医保：</td>
            <td align="center" width="80">${medicalitem.isExpense?"是":"否" }&nbsp;</td>
        </tr>
        
        <tr>
            <td align="center" width="80">报销比例：</td>
            <td colspan="3" align="center">${(empty medicalitem.rate)?"无":medicalitem.rate }&nbsp;</td>

        </tr>
         <tr>
            <td  align="center" height="60px">备注</td>
            <td colspan="3" height="60">
                ${(medicalitem.remark eq null)?"":medicalitem.remark }
            </td>   
        </tr>  
        
    </table>
  
</div>

</body>
</html>