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
<%-- <link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/css/userinfo.css"> --%>
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
	<table style="height: auto;" id="historyExpenses">

	</table>
		<!-- 查询分区 -->
	<div class="easyui-window" title="查询未通过报销单" id="searchWindow" collapsible="false" minimizable="false" maximizable="false" style="top:20px;left:200px">
		<div style="overflow:auto;padding:5px;" border="false">
			<form id="his_expense">
				<table class="table-edit" width="80%" align="center">
					<tr class="title">
						<td colspan="2">查询条件</td>
					</tr>
					<tr>
						<td>报销单编号</td>
						<td><input type="text" id="expenseNum"/></td>
					</tr>
					<tr>
						<td>医疗类型</td>
						<td><select id="medicalType" class="easyui-combobox" name="医疗类型">
						            <option value="" >空</option>
									<option value="一般门诊" >一般门诊</option>
									<option value="住院">住院</option>
									<option value="特殊门诊">特殊门诊</option>
							</select></td>
					</tr>
					<tr>
						<td>消费总金额区间</td>
						<td><input type="text" id="mintotal" style="width: 50px" class="easyui-validatebox" data-options="validType:'isfloat'"/>   --   
						<input type="text" id="maxtotal" style="width: 50px" class="easyui-validatebox" data-options="validType:'isfloat'"/></td>
					</tr>
					<tr>
						<td>报销时间区间</td>
						<td><input  id="mindate"  type= "text" class= "easyui-datebox"  style="width: 85px"> </input> --
						<input  id="maxdate"  type= "text" class= "easyui-datebox"  style="width: 85px"> </input>
						</td>  
					</tr>
					
					<tr>
						<td colspan="2" align="center"><a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a> </td>
					</tr>
				</table>
			</form>
		</div>
	</div>
<script type="text/javascript">
       var ISOneRow = 1;
	   $(function(){
		   var toolbar = [ {
				id : 'button-view',	
				text : '查询',
				iconCls : 'icon-search',
				handler :doSearch
			}];
			$("#historyExpenses").datagrid({
				columns:[[//定义标题行所有的列
				          {field:'expenseNum',title:'报销单编号',width:100,align:'center'},
				          {field:'expensetype',title:'报销比例',width:100,align:'center',formatter: function(value,row,index){
					          return row.expensetype.expenseProportion*100+"%";	
						  }},
				          {field:'total',title:'消费总金额' , width:170,align:'center',},
				          {field:'expensePay',title:'报销金额' , width:200,align:'center', formatter:function(value,row,index){
					          if(row.expensePay==null){
						          return "";
						      }
					          else {
						          return row.expensePay;
						      }
					      }},
				          {field:'check',title:'审核意见',width:150,align:'center',formatter:function(value,row,index){
					          return "不通过"
					      }},
				          {field:'admininfo',title:'审核人', width:100, align:'center',formatter: function(value,row,index){
				        	 return row.admininfo.name;
						  }},
				          {field:'expenseTime',title:'审核时间',width:100, align:'center',formatter: function(value,row,index){
				        	 return row.expenseTime;
						  }},
						  {field:'_operate',title:'操作',width:100, align:'center',formatter: function formatOper(val,row,index){  
							    return '<a href="#" onclick="editUser('+index+')">删除</a>';  
						  }},
				          ]],
			    url:'${pageContext.request.contextPath}/expenseAction_deleteExpenseInfo.action', //指定URL地址，控件自动发送ajax请求获取数据	
				singleSelect:true,//是否可以单选
				pagination:true,//分页条
				pageList:[10,15,20],//分页条中的下拉框选项
			    rownumbers:true,
			    striped:true,   
			    toolbar : toolbar,
			    fitColumns:true,
			    onClickRow: function(index,row){
			    	if(ISOneRow==0){
						ISOneRow=1;
						return false;
					}
			    	var index1=layer.open({
						id:"his_expenseinfo",
						type : 2,
						closeBtn : 0,
						title: false,
						shadeClose : true,
						scrollbar: false,
						area : [ '650px', '400px' ],
						anim :3,
						content :"${pageContext.request.contextPath}/expenseAction_hisExpenseDetail.action?expenseNum="+row.expenseNum,
					});
				}
			  
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
				
				
				var v = $("#his_expense").form("validate"); 
				if(v){
				   var p ={expenseNum:$("#expenseNum").val(),medicalTyp:$("#medicalType").combobox('getValue'),
						mintotal:$("#mintotal").val(),maxtotal:$("#maxtotal").val(),
						mindate:$("#mindate").datebox('getValue'),maxdate:$("#maxdate").datebox('getValue'),
						}
				   //重新发起ajax请求，提交参数
				   $("#historyExpenses").datagrid("load",p);
				   //关闭查询窗口
				   $("#searchWindow").window("close");
				   $("#expenseNum").val("");
				   $("#mintotal").val("");
				   $("#maxtotal").val("");
				   $("#mindate").datebox('setValue', '');
				   $("#maxdate").datebox('setValue', '');
				   
				}
			});
		
		});

	  

	   function doSearch(){
			$('#searchWindow').window("open");
		}

	   $.extend($.fn.validatebox.defaults.rules, {    
		    isfloat: {    
		    validator: function(value,param){   
			    return (/^\d+(.\d+)?$/).test(value);
			},
			message : '请输入正数'
		}
	   });

	   function editUser(index){  
		   ISOneRow=0;
		   $('#historyExpenses').datagrid('selectRow',index);// 关键在这里  
		    var row = $('#historyExpenses').datagrid('getSelected');
		   var url="${pageContext.request.contextPath}/expenseAction_delExpense.action";   
			$.post(url,{"expenseNum":row.expenseNum},function(data){
				if(data == '1'){
					//修改密码成功
					 layer.msg("删除成功");
				}else{
					//修改失败
					 layer.msg("删除失败");
				}
			});
			window.opener.location.reload(); 
			return false;
	   }  
</script>
</div>
</body>
</html>