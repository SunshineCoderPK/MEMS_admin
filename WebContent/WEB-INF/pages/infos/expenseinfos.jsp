<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<script src="${pageContext.request.contextPath }/js/layui/layui.js"
	type="text/javascript">
</script>	
<script src="${pageContext.request.contextPath }/js/layui/lay/modules/layer.js"
	type="text/javascript">
</script>	


</head>
<body>
<div style="padding: 10px">
	<table style="height: auto;" id="expensetypes">

	</table>
		<!-- 查询分区 -->
	<div class="easyui-window" title="查询报销规则窗口" id="searchWindow" collapsible="false" minimizable="false" maximizable="false" style="top:20px;left:200px">
		<div style="overflow:auto;padding:5px;" border="false">
			<form>
				<table class="table-edit" width="80%" align="center">
					<tr class="title">
						<td colspan="2">查询条件</td>
					</tr>
					<tr>
						<td>报销人员</td>
						<td><select id="userType" class="easyui-combobox" name="人员类型">
									<option value=1 >教职工</option>
									<option value=2>学生</option>
							</select></td>
					</tr>
					<tr>
						<td>医疗类型</td>
						<td><select id="medicalType" class="easyui-combobox" name="医疗类型">
									<option value="一般门诊" >一般门诊</option>
									<option value="住院">住院</option>
									<option value="特殊门诊">特殊门诊</option>
							</select></td>
					</tr>
					<tr>
						<td>医院类型</td>
						<td><select id="hospType" class="easyui-combobox" name="医院类型">
									<option value=5 >校内医院</option>
									<option value=1>校外一级医院</option>
									<option value=2>校外二级医院</option>
									<option value=3>校外三级医院</option>
									<option value=4>异地医院</option>
							</select></td>
					</tr>
					<tr>
						<td>是否退休</td>
						<td><select id="isretire" class="easyui-combobox" name="是否退休">
									<option value=0>否</option>
									<option value=1>是</option>
							</select></td>
					</tr>
					<tr>
						<td colspan="2" align="center"><a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a> </td>
					</tr>
				</table>
			</form>
		</div>
	</div>
<script type="text/javascript">
	   $(function(){
		   var toolbar = [ {
				id : 'button-view',	
				text : '查询',
				iconCls : 'icon-search',
				handler :doSearch
			}];
			$("#expensetypes").datagrid({
				columns:[[//定义标题行所有的列
				          {field:'expenseTyp',title:'类型编号',width:100,align:'center'},
				          {field:'userRoleId',title:'用户身份',width:100,align:'center',formatter:function(value,row,index){
					          if(row.userRoleId==1){
						          return "教职工";
						      }
					          else{
						          return "学生";
					          }
					      }},
				          {field:'medicalTyp',title:'医疗类型' , width:170,align:'center',},
				          {field:'hosptyp',title:'医院类型' , width:200,align:'center', formatter:function(value,row,index){
					          if(row.hosptyp==5){
						          return "校内医院";
						      }
					          else if(row.hosptyp==1){
						          return "校外一级医院";
					          }
					          else if(row.hosptyp==2){
						          return "校外二级医院";
					          }
					          else if(row.hosptyp==3){
					        	  return "校外三级医院";
					          }
					          else {
						          return "异地医院"
						      }
					      }},
				          {field:'isRetire',title:'是否退休',width:150,align:'center',formatter:function(value,row,index){
					          if(row.isRetire==false){
						          return "未退休";
						      }
					          else{
						          return "退休或工龄大于30年";
					          }
					      }},
				          {field:'thresholdFee',title:'门槛费/元', width:100, align:'center',},
				          {field:'healthCard',title:'保健卡',width:100, align:'center',formatter:function(value,row,index){
					          if(row.healthCard==false){
						          return "无";
						      }
					          else{
						          return "有";
					          }
					      }},
				          {field:'expenseProportion',title:'报销比例', width:100, align:'center',formatter:function(value,row,index){
					          return value*100+"%";
					      }},
				          ]],
			    url:'${pageContext.request.contextPath}/expenseTypeAction_expenseTypeinfo.action', //指定URL地址，控件自动发送ajax请求获取数据	
				singleSelect:true,//是否可以单选
				pagination:true,//分页条
				pageList:[10,15,20],//分页条中的下拉框选项
			    rownumbers:true,
			    striped:true,   
			    toolbar : toolbar,
			    fitColumns:true,
			  
			    });


			// 查询分区
			$('#searchWindow').window({
		        title: '查询报销规则',
		        width: 400,
		        modal: true,
		        shadow: true,
		        closed: true,
		        height: 250,
		        resizable:false
		    });

		
	        
	        //绑定事件
			$("#btn").click(function(){
				var p ={userRoleId:$("#userType").combobox('getValue'),medicalTyp:$("#medicalType").combobox('getValue'),
						hosptyp:$("#hospType").combobox('getValue'),isRetire:$("#isretire").combobox('getValue'),}
				//重新发起ajax请求，提交参数
				$("#expensetypes").datagrid("load",p);
				//关闭查询窗口
				$("#searchWindow").window("close");
			});
		
		});

	  

	   function doSearch(){
			$('#searchWindow').window("open");
		}
	</script>
</div>
</body>
</html>