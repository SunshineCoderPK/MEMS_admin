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
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/css/medicineinfos.css">
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
	<table style="height: auto;" id="medicines">

	</table>
		<!-- 查询分区 -->
	<div class="easyui-window" title="查询药品窗口" id="searchWindow" collapsible="false" minimizable="false" maximizable="false" style="top:20px;left:200px;">
		<div style="overflow:auto;padding:5px;" border="false">
			<form>
				<table class="table-edit" width="80%" align="center">
					<tr class="title">
						<td colspan="2">查询条件</td>
					</tr>
					<tr>
						<td>药品编号</td>
						<td><input type="text" id="medicNum"/></td>
					</tr>
					<tr>
						<td>药品名称</td>
						<td><input type="text" id="medicCname"/></td>
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
			$("#medicines").datagrid({
				columns:[[//定义标题行所有的列
				          {field:'medicNum',title:'药品编号',width:200,align:'center'},
				          {field:'medicCname',title:'药品名称',width:250,align:'center',},
				         
				           {field:'medicEname',title:'药品英文名称',width:300,align:'center',formatter:function(value,row,index){
					          if(row.medicEname==""){
						          return "";
						      }
					          else{
						          return row.medicEname;
					          }
					      }},
					      {field:'medicSname',title:'拼音名称',align:'center',hidden:true,},
					      {field:'dosageTyp',title:'药品剂型',align:'center',hidden:true,},
					      {field:'remark',title:'备注',align:'center',hidden:true,},
					      {field:'imgsrc',title:'图片',align:'center',hidden:true,},
					      {field:'isExpense',title:'是否医保' ,width:80,align:'center',formatter:function(value,row,index){
					          if(row.isExpense==false){
						          return "否";
						      }
					          else{
						          return "是";
					          }
					      }},
				          {field:'expenseTyp',title:'报销类型' , width:100,align:'center',},
				          {field:'medicUnit',title:'单位', hidden:true,align:'center',formatter:function(value,row,index){
					          if(row.medicUnit==""){
						          return "";
						      }
					          else{
						          return row.medicUnit;
					          }
					      }},
				          {field:'medicPrice',title:'最高限价/元', width:100, align:'center',formatter:function(value,row,index){
					          if(row.medicPrice==null){
						          return "";
						      }
					          else{
						          return row.medicPrice;
					          }
					      }},
				          ]],
			    url:'${pageContext.request.contextPath}/medicineAction_medicineinfo.action', //指定URL地址，控件自动发送ajax请求获取数据	
				singleSelect:true,//是否可以单选
				pagination:true,//分页条
				pageList:[10,15,20],//分页条中的下拉框选项
			    rownumbers:true,
			    striped:true,   
			    toolbar : toolbar,
			    fitColumns:true,
			    onClickRow: function(index,row){
				    var html='<table class="mediframe"><tr> <td  rowspan="3" width="250px" height="170px"><img class="img1" height="160" width="240" style="padding:2px 2px 5px; border:1px #ddd solid;" src="';
				    if(row.imgsrc!=""){
					    html+=row.imgsrc+'"';
				    }
				    else{
					    html+='/img/default.jpg'+'"';
				    }

				    html+='></td><td> 编号：<label>'+row.medicNum;
				    html+='</label></td></tr><tr><td> 中文名：<label>'+row.medicCname;
				    html+='</label></td></tr><tr> <td> 英文名：<label>';
				    if(row.medicEname!=""){
					    html+=row.medicEname;
				    }
				    html+='</label></td></tr><tr><td> 拼音：<label>';
				    if(row.medicSname!=""){
					    html+=row.medicSname;
				    }
				    html+='</label></td><td> 是否医保：<label>';
				    if(row.isExpense!=null&&row.isExpense!=""){
					    if(row.isExpense==1){
					    	html+='是';
						}else{
							html+='否';
						}
				    }
				    html+='<label></label></td></tr><tr> <td> 单位：<label>';
				    if(row.medicUnit!=""){
					    html+=row.medicUnit;
				    }
				    html+='</label></td><td> 剂型：<label>';
				    if(row.dosageTyp!=""){
					    html+=row.dosageTyp;
				    }
				    html+='</label></td></tr><tr> <td> 报销类型：<label>';
				    html+=row.expenseTyp;
				    html+='</label></td><td> 最高限价：<label>';
				    if(row.medicPrice!=null){
					    html+=row.medicPrice;
				    }
				    html+='</label></td></tr><tr><td colspan="2" height="70px"> 备注：<label>';
				    if(row.remark!=""){
					    html+=row.remark;
				    }
				    html+='</label></td></tr></table>';
				    var index1=layer.open({
						id:"infochange",
						type : 1,
						closeBtn : 0,
						title: false,
						shadeClose : true,
						scrollbar: false,
						area : [ '500px', '380px' ],
						anim :3,
						content :html,
					});
		        },
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
				var p ={medicNum:$("#medicNum").val(),medicCname:$("#medicCname").val(),
						expenseTyp:$("#expenseTyp").combobox('getValue')}
				//重新发起ajax请求，提交参数
				$("#medicines").datagrid("load",p);
				//关闭查询窗口
				$("#searchWindow").window("close");
				$("#medicNum").val("");
				$("#medicCname").val("");
			});
		
		});

	  

	   function doSearch(){
			$('#searchWindow').window("open");
		}
	</script>
</div>
</body>
</html>