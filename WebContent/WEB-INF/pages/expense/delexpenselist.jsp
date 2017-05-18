<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--[if lt IE 9]>
<script type="text/javascript" src="lib/html5shiv.js"></script>
<script type="text/javascript" src="lib/respond.min.js"></script>
<![endif]-->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery-1.8.3.js"></script>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui/ext/portal.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/css/changedatagrid.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/css/header.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/layui/css/layui.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/layui/css/modules/layer/default/layer.css">

<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/easyui/ext/jquery.portal.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/easyui/ext/jquery.cookie.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/easyui/locale/easyui-lang-zh_CN.js">
</script>
<script src="${pageContext.request.contextPath }/js/layui/layui.js"
	type="text/javascript">
</script>	
<script src="${pageContext.request.contextPath }/js/layui/lay/modules/layer.js"
	type="text/javascript">
</script>	
<script src="${pageContext.request.contextPath }/js/jquery.ocupload-1.1.2.js"
	type="text/javascript">
</script>
<script type="text/javascript" src="lib/My97DatePicker/4.8/WdatePicker.js"></script>
</head>
<body>
<div class="place">
    <span>位置：</span>
    <ul class="placeul">
    <li><a href="#">首页</a></li>
    <li><a href="#">报销清单管理</a></li>
    <li><a href="#">删除报销</a></li>
    </ul>
    </div>
    
    <div class="rightinfo">
     <div  style="margin-top: 10px">
    
    	<ul class="seachform url1" style="margin-left: 100px">
    	<li style="margin-right: 10px;margin-left: 0px"><label>综合查询</label><input id="searchkey" name="" type="text" class="scinput" /></li>
		 <li class="vocation" style="margin-left: 20px"><label>时间</label><input type="text"  onfocus="WdatePicker({  })" id="datemin" class="time_input Wdate" style="width:120px;height: 33px">
		-
		<input type="text" onfocus="WdatePicker({ minDate:'#F{$dp.$D(\'datemin\')}' })" id="datemax" class=" time_input Wdate" style="width:120px;height: 33px">
		</li>
		 
        <li style="margin-left: 20px"><label>状态</label>
					<div class="vocation">
						<select class="select3" id="expense_status">
							<option value=0>正常</option>
							<option value=1>已删除</option>
							<option value="">全部</option>
						</select>
					</div>
				</li> 	
		<li><label>&nbsp;</label><input style="margin-left: 20px" name="" type="button" class="scbtn" value="查询" onclick="searchbykey()"/></li>			
		</ul>
 
    </div>
   
    	 

     <div class="tools" style="margin-top: 10px">
    
    	<ul class="toolbar">
    	<li style="width: 80px"  onclick="selectall()" href="#"><span><img src="images/t06.png"/></span>全选</li>
    	<li style="width: 110px"  onclick="clearselall()" href="#"><span><img src="images/t06.png"/></span>清空选择</li>
		<li style="width: 110px"  onclick="doDelete()" href="#"><span><img src="images/t03.png"/></span>批量删除</li>			
		</ul>

    </div>
   
    </div>
   
<div id="expenses" style="margin-top: 50px" ></div>

<script type="text/javascript">
var  click=0;
$(function(){
	$("#expenses").datagrid({
		columns:[[//定义标题行所有的列
			  {field:'expenseNum',checkbox : true,}, 
			  {field:'expensenum',title:'报销单编号',width:1.5,align:'center',formatter:function(value,row,index){
		          return row.expenseNum;
		      }},
	          {field:'expensetype',title:'报销比例',width:1,align:'center',formatter: function(value,row,index){
		          return row.expensetype.expenseProportion*100+"%";	
			  }},
	          {field:'total',title:'消费总金额' , width:1.7,align:'center',},
	          {field:'expensePay',title:'报销金额' , width:2,align:'center', formatter:function(value,row,index){
		          if(row.expensePay==null){
			          return "";
			      }
		          else {
			          return row.expensePay;
			      }
		      }},
	          {field:'check',title:'审核意见',width:1.5,align:'center',formatter:function(value,row,index){
		          return "审核不通过"
		      }},
	          {field:'admininfo',title:'审核人', width:1, align:'center',formatter: function(value,row,index){
		          return row.admininfo.name;	
			  }},
	          {field:'expenseTime',title:'审核时间',width:1, align:'center',},
	          {field:'isDelete',title:'状态',align:'center',width:0.8,formatter: function formatOper(val,row,index){
				  if(row.isDelete){
					  return '<label class="status_label">已删除</label>';
				  }  
				  else{
					  return '<label class="status_label">正常</label>';
			      }
			  }},
		      {field:'_operate',title:'操作', align:'center',width:1,formatter: function formatOper(val,row,index){  
				    return '<a href="#" onclick="delExpense('+index+')"><img href="#" title="删除"  src="images/delete.ico"></img></a>';  
			  }},
		      ]],
	    url:'${pageContext.request.contextPath}/expenseAction_deleteExpenseInfo.action', //指定URL地址，控件自动发送ajax请求获取数据	
		singleSelect:false,//是否可以单选
		pagination:true,//分页条
		pageList:[7,10,15],//分页条中的下拉框选项
	    rownumbers:true,
	    striped:true,   
	    fitColumns:true,
	    checkOnSelect:false,
	    onClickRow: function(index,row){
	    	if(click==1){
			    click=0;
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
	  
	   /*  onLoadSuccess : function(){
	    	  //解决一个样式bug
	    	  $(".borderdiv").remove();
	    	  var height = $(".datagrid-view2 .datagrid-body").outerHeight() - $(".datagrid-view2 .datagrid-btable").outerHeight();
	    	  if(height > 0){
	    	    $(".datagrid-view2 .datagrid-body").css("position", "relative").append("<div class='borderdiv'></div>");
	    	    $(".borderdiv").css({
	    	      height : height,
	    	      borderLeft : "1px solid #ccc",
	    	      position : "absolute",
	    	      right : "18px"
	    	    });
	    	  }
	    	} */
	    }); 

	 $(window).resize(function(){
		 var wid= document.body.clientWidth*1;
		 //alert(wid);
		 resize(wid);
		});

		//调整表格的局
		function resize(wid){
		 $('#expenses').datagrid('resize', 
		   { width:wid, 
		     });
		} 


	

});


	/*全选*/
	function selectall() {
		$("#expenses").datagrid("checkAll");
	}

	/*清空选择*/
	function clearselall() {
		$("#expenses").datagrid("uncheckAll");
	}

	/*搜索*/
	function searchbykey() {
		var p = {
			key : $("#searchkey").val(),
			mindate : $("#datemin").val(),
			maxdate : $("#datemax").val(),
			status: $("#expense_status option:selected").val(),
		};
		$("#expenses").datagrid("load", p);
		$("#searchkey").val("");
		$("#datemin").val("");
		$("#datemax").val("");
	}

	/*删除单条报销记录*/
	function delExpense(index) {
		click = 1;
		var confirmindex = layer
				.confirm(
						'确定删除？',
						{
							btn : [ '是', '否' ]
						//按钮
						},
						function() {
							var rows = $('#expenses').datagrid('getRows');
							var row = rows[index];
							var expenseNum = row.expenseNum;
							var url = "${pageContext.request.contextPath}/expenseAction_delExpense.action";
							$.post(url, {
								"expenseNum" : expenseNum
							}, function(data) {
								if (data == '1') {
									//删除成功
									layer.msg("删除成功");
								} else {
									//删除失败
									layer.msg("删除失败");
								}
								$("#expenses").datagrid("load", "");
								return false;
							});
						}, function() {
							layer.close(confirmindex);
						});

	}

	//批量删除药品
	function doDelete() {
		//获得选中的行
		var rows = $("#expenses").datagrid("getSelections");
		if (rows.length == 0) {
			//没有选中，提示
			layer.alert('请选择需要删除的记录！', {
				skin : 'layui-layer-lan',
				closeBtn : 0,
				anim : 4
			//动画类型
			});
		} else {
			var confirmindex = layer
					.confirm(
							'确定删除？',
							{
								btn : [ '是', '否' ]
							//按钮
							},
							function() {
								var array = new Array();
								//选中了记录,获取选中行的id
								for (var i = 0; i < rows.length; i++) {
									var id = rows[i].expenseNum;
									array.push(id);
								}
								var ids = array.join(",");
								//发送请求，传递ids参数
								window.location.href = '${pageContext.request.contextPath}/expenseAction_deletebatch.action?ids='
										+ ids;
								/* var url = "${pageContext.request.contextPath}/medicineAction_deletemedicine.action";
								$.post(url, {
									"empId" : empId
								}, function(data) {
									if (data == '1') {
										//修改密码成功
										layer.msg("删除成功");
									} else {
										//修改失败
										layer.msg("删除失败");
									}
									$("#medicines").datagrid("load", "");
									return false;
								});	 */
							}, function() {
								layer.close(confirmindex);
							});

		}
	}
</script>
</body>
</html>