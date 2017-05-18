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
    <li><a href="#">审核报销</a></li>
    </ul>
    </div>
    
    <div class="rightinfo">
     <div  style="margin-top: 30px;margin-bottom: 20px">
    
    	<ul class="seachform url1" style="margin-left: 100px">
    	<li style="margin-right: 10px;margin-left: 0px"><label>综合查询</label><input id="searchkey" name="" type="text" class="scinput" /></li>
    
    <li style="margin-right: 30px"><label>人员类型</label>  
    <div class="vocation">
    <select class="select3"  id="expense_userRoleId">
    <option value="">全部</option>
    <option value=1>在职教职工</option>
    <option value=2>学生</option>
    <option value=3>退休教职工</option>
    </select>
    </div>
    </li>
    
    <li style="margin-right: 30px"><label>医院类型</label>  
    <div class="vocation">
    <select class="select3"  id="expense_hosptyp">
    <option value="">全部</option>
    <option value=5>校内医院</option>
    <option value=1>校外一级</option>
    <option value=2>校外二级</option>
    <option value=3>校外三级</option>
    <option value=4>异地医院</option>
    </select>
    </div>
    </li>
		<li><label>&nbsp;</label><input style="margin-left: 20px" name="" type="button" class="scbtn" value="查询" onclick="searchbykey()"/></li>			
		</ul>
 
    </div>
   
   
    </div>
   
<div id="expenses" style="margin-top: 80px" ></div>

<script type="text/javascript">
var  click=0;
$(function(){
	$("#expenses").datagrid({
		columns:[[//定义标题行所有的列
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

		      {field:'_operate',title:'操作', align:'center',width:1,formatter: function formatOper(val,row,index){  
				    return '<a href="#" onclick="checkExpense('+index+')"><img href="#" title="审核"  src="images/edit.png"></img></a>';  
			  }},
		      ]],
	    url:'${pageContext.request.contextPath}/expenseAction_ischeckExpenseInfo.action', //指定URL地址，控件自动发送ajax请求获取数据	
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


	/*搜索*/
	function searchbykey() {
		var p = {
			key : $("#searchkey").val(),
			muserRoleId : $("#expense_userRoleId option:selected").val(),
			mhosptyp: $("#expense_hosptyp option:selected").val(),
		};
		$("#expenses").datagrid("load", p);
		$("#searchkey").val("");
	}

	/*审核单条报销记录*/
	function checkExpense(index) {
		click = 1;
		var confirmindex = layer
				.confirm(
						'审核报销',
						{
							btn : [ '通过', '不通过' ]
						//按钮
						},
						function() {
							var rows = $('#expenses').datagrid('getRows');
							var row = rows[index];
							var expenseNum = row.expenseNum;
							var url = "${pageContext.request.contextPath}/expenseAction_checkExpense.action";
							$.post(url, {
								"expenseNum" : expenseNum,
								"result":2
							}, function(data) {
								if (data == '1') {
									//删除成功
									layer.msg("操作成功");
								} else {
									//删除失败
									layer.msg("操作失败");
								}
								$("#expenses").datagrid("load", "");
								return false;
							});
						}, function() {
							var rows = $('#expenses').datagrid('getRows');
							var row = rows[index];
							var expenseNum = row.expenseNum;
							var url = "${pageContext.request.contextPath}/expenseAction_checkExpense.action";
							$.post(url, {
								"expenseNum" : expenseNum,
								"result":3
							}, function(data) {
								if (data == '1') {
									//删除成功
									layer.msg("操作成功");
								} else {
									//删除失败
									layer.msg("操作失败");
								}
								$("#expenses").datagrid("load", "");
								return false;
							});
							layer.close(confirmindex);
						});

	}

</script>
</body>
</html>