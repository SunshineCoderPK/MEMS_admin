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
	<table style="height: auto;" id="medicalitems">

	</table>
		<!-- 查询分区 -->
	<div class="easyui-window" title="查询报销项窗口" id="searchWindow" collapsible="false" minimizable="false" maximizable="false" style="top:20px;left:200px;">
		<div style="overflow:auto;padding:5px;" border="false">
			<form>
				<table class="table-edit" width="80%" align="center">
					<tr class="title">
						<td colspan="2">查询条件</td>
					</tr>
					<tr>
						<td>报销项编号</td>
						<td><input type="text" id="medicalNum"/></td>
					</tr>
					<tr>
						<td>报销项名称</td>
						<td><input type="text" id="medicalName"/></td>
					</tr>
					<tr>
						<td>报销类型</td>
						<td><select id="expenseTyp" class="easyui-combobox" name="报销类型">
						            <option value="" ></option>
									<option value="甲类">甲类</option>
									<option value="乙类">乙类</option>
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
			$("#medicalitems").datagrid({
				columns:[[//定义标题行所有的列
				          {field:'medicalNum',title:'类型编号',width:200,align:'center'},
				          {field:'medicalName',title:'报销项名称',width:200,align:'center',},
				          {field:'expenseTyp',title:'报销类型' , width:100,align:'center',},
				          {field:'isExpense',title:'是否医保' ,width:80,align:'center',formatter:function(value,row,index){
					          if(row.isExpense==false){
						          return "否";
						      }
					          else{
						          return "是";
					          }
					      }},
				          {field:'medicUnit',title:'单位',width:80,align:'center',formatter:function(value,row,index){
					          if(row.medicUnit==""){
						          return "";
						      }
					          else{
						          return row.medicUnit;
					          }
					      }},
				          {field:'medicalPrice',title:'最高限价/元', width:100, align:'center',formatter:function(value,row,index){
					          if(row.medicalPrice==null){
						          return "";
						      }
					          else{
						          return row.medicalPrice;
					          }
					      }},
				          {field:'remark',title:'备注', width:270, align:'center',formatter:function(value,row,index){
					          if(row.remark==""){
						          return "";
						      }
					          else{
						          return row.remark;
					          }
					      }},
				          ]],
			    url:'${pageContext.request.contextPath}/medicalItemAction_medicaliteminfo.action', //指定URL地址，控件自动发送ajax请求获取数据	
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
		        title: '查询报销项',
		        width: 400,
		        modal: true,
		        shadow: true,
		        closed: true,
		        height: 250,
		        resizable:false
		    });

		
	        
	        //绑定事件
			$("#btn").click(function(){
				var p ={medicalNum:$("#medicalNum").val(),medicalName:$("#medicalName").val(),
						expenseTyp:$("#expenseTyp").combobox('getValue')}
				//重新发起ajax请求，提交参数
				$("#medicalitems").datagrid("load",p);
				//关闭查询窗口
				$("#searchWindow").window("close");
				$("#medicalNum").val("");
				$("#medicalName").val("");
			});
		
		});

	  

	   function doSearch(){
			$('#searchWindow').window("open");
		}
	</script>
</div>
</body>
</html>