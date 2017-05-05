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
<!-- 导入jquery核心类库 -->
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
	href="${pageContext.request.contextPath }/css/expensedetail.css">
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
<script
	src="${pageContext.request.contextPath }/js/layui/lay/modules/layer.js"
	type="text/javascript">
</script>
</head>
<body>
	<div style="width: 650px;height: auto; border: black solid 1px ;" >
	<p style="font-size:20px;text-align:center; width: 100%;word-spacing:5px;margin-bottom: 5px" >医疗费报销单</p>
	<div class="line1">
	<span style="width: 50px;">姓名：</span><span style="width: 70px">${expense.userinfo.name} </span>
	<span style="width: 50px">学工号：</span><span style="width: 90px">${expense.userinfo.stuOrEmpId}</span>
	
	<span style="width: 50px">身份：</span><span style="width: 90px">${(expense.userinfo.roleId eq 1)?"教职工":((expense.userinfo.roleId eq 2)?"学生":"退休教职工")}</span>
	<span style="width: 70x">报销单编号：</span><span style="width: 90px">${expense.expenseNum}</span>
	</div>
	<div class="line1">
	<span style="width: 80px;">医疗类型：</span><span style="width: 100px">${expense.medicalTyp}</span>
	<span style="width: 80px">就诊医院：</span><span style="width: 150px">${expense.hospital.hospName}</span>
	<span style="width: 60px">报销比例：</span><span style="width: 90px">${expense.expensetype.expenseProportion}</span>
	</div>
	<center><hr class="hrline" align="center" /></center>
	<div style="height: auto">
	<center>
	     <table>
	     <c:if test="${ fn:length(expense.expensemedicalitems)gt 0}">
	         <tr>
	           <td rowspan= ${ fn:length(expense.expensemedicalitems)+1} width="30px">报销项</td><td  width="80px">编号</td>
	           <td width="120px">名称</td><td width="35px">单价</td><td width="35px">限价</td><td width="60px">类别</td><td width="40px">数量</td><td width="50px" colspan="2">能否报销</td>
	         </tr>
	         
	         <c:forEach items="${expense.expensemedicalitems}" var="item">
	         <tr>
	         <td>${item.medicalitem.medicalNum}</td> 
	         <td>${item.medicalitem.medicalName}</td> 
	         <td>${item.medicalUnitPrice}</td> 
	         <td>${item.medicalitem.medicalPrice}</td> 
	         <td>${item.medicalitem.expenseTyp}</td> 
	         <td>${item.medicalQuantity}</td> 
	         <td colspan="2">${item.medicalitem.isExpense?"是":"否"}</td> 
	         </tr>
	         </c:forEach>
	      </c:if>
	      
	      <c:if test="${ fn:length(expense.expensemedicines)gt 0}">  
	         <tr>
	           <td rowspan=${ fn:length(expense.expensemedicines)+1} width="30px">报销药品</td><td width="80px">编号</td>
	           <td width="120px">名称</td><td width="35px">单价</td><td width="35px">限价</td><td width="60px">类别</td><td width="30px">数量</td><td width="70px">来源</td><td width="50px">能否报销</td>
	         </tr>
	          
	         
	         
	         <c:forEach items="${expense.expensemedicines}" var="item">
	         <tr>
	         <td>${item.medicine.medicNum}</td> 
	         <td>${item.medicine.medicCname}</td> 
	         <td>${item.medicUnitPrice}</td> 
	         <td>${item.medicine.medicPrice}</td> 
	         <td>${item.medicine.expenseTyp}</td> 
	         <td>${item.medicQuantity}</td> 
	         <td>${(item.sourse eq 1)?"校内医院":"校外医院"}</td> 
	         <td>${item.medicine.isExpense?"是":"否"}</td> 
	         </tr>
	         </c:forEach>
	     </c:if>
	         
	     </table>
	     </center>
	</div>
	<center><hr class="hrline" align="center" /></center>
	<div class="line1">
	<span style="width: 100px;">消费总金额：</span><span style="width: 100px">${expense.total}</span>
	<span style="width: 80px">报销金额：</span><span style="width: 100px">${(expense.expensePay eq null)?"":expense.expensePay}</span>
	<span style="width: 100px">个人支付金额：</span><span style="width: 90px">${(expense.personsalPay eq null)?"":expense.personsalPay}</span>
	</div>
	<div class="line1">
	<span style="width: 100px;">审核意见：</span><span style="width: 100px">${(expense.check eq 1)?"待审核":((expense.check eq 2)?"审核通过":"不通过")}</span>
	<span style="width: 80px">审核人：</span><span style="width: 80px">${expense.admininfo.name}</span>
	<span style="width: 80px">审核时间：</span><span style="width: 140px">${expense.expenseTime}</span>
	</div>
	
	</div>

</body>
</html>