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
<body>
<div class="place">
    <span>位置：</span>
    <ul class="placeul">
    <li><a href="#">首页</a></li>
    <li><a href="#">用户管理</a></li>
    <li><a href="#">批量注册</a></li>
    </ul>
    </div>
    
    <div class="rightinfo">



    <ul class="seachform url1" style="margin-left: 300px;margin-top: 10px">
    
    <li style="margin-right: 30px;margin-left: 70px"><input id="uploadusers" name="" type="text" class="scinput" /></li>


    <li><label>&nbsp;</label><input name="" type="button" class="scbtn" value="批量注册"/></li>
    
    </ul>
    	 


    <div class="tools" style="margin-top: 10px">
    
    	<ul class="toolbar">
    	<li style="width: 80px"  onclick="selectall()" href="#"><span><img src="images/t06.png"/></span>全选</li>
    	<li style="width: 110px"  onclick="clearselall()" href="#"><span><img src="images/t06.png"/></span>清空选择</li>
		<li style="width: 110px"  onclick="doDelete()" href="#"><span><img src="images/t03.png"/></span>批量删除</li>
				
		</ul>

    </div>
    </div>
   
<div id="users" style="margin-top: 50px" ></div>
<script type="text/javascript">
var  click=0;
$(function(){
	$("#users").datagrid({
		columns:[[//定义标题行所有的列
			      {field :'stuOrEmpId',checkbox : true,},
		          {field:'stuOrEmpid',title:'学/工号',width:0.7 ,align:'center',formatter:function(value,row,index){
			          return row.stuOrEmpId;
			      }},
		          {field:'name',title:'姓名',width:0.7,align:'center',},
		          {field:'sex',title:'性别' , align:'center',formatter:function(value,row,index){
			          if(row.sex==false){
				          return "女";
			          }
			          else {
				          return "男";
			          }
			      }},
		          {field:'email',title:'邮箱' , width:1,align:'center', formatter:function(value,row,index){
			          if(row.email==null||row.email==""){
				          return "";
				      }
			          else {
				          return row.email;
			          }
			      }},
		          {field:'idcard',title:'身份证号',width:1,align:'center'},
		          {field:'phoneNo',title:'手机号', width:1, align:'center', formatter:function(value,row,index){
			          if(row.phoneNo==null||row.phoneNo==""){
				          return "";
				      }
			          else {
				          return row.phoneNo;
			          }
			      }},
			      {field:'isDelete',title:'状态',width:0.5,align:'center',formatter: function formatOper(val,row,index){
					  if(row.isDelete){
						  return '<label class="status_label">已删除</label>';
					  }  
					  else{
						  return '<label class="status_label">正常</label>';
				      }
				  }},
			      {field:'_operate',title:'操作',width:1, align:'center',formatter: function formatOper(val,row,index){  
					    return '<a href="#"  onclick="edituser('+index+')"><img  href="#" title="编辑" src="images/edit.png"></img></a>&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" onclick="resetPwd('+index+')"><img href="#" title="重置密码"  src="images/redopwd.ico"></img></a>&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" onclick="deleteuser('+index+')"><img href="#" title="删除"  src="images/delete.ico"></img></a>';  
				  }},
		          ]],
	    url:'${pageContext.request.contextPath}/userAction_userinfos.action', //指定URL地址，控件自动发送ajax请求获取数据	
		singleSelect:false,//是否可以单选
		pagination:true,//分页条
		pageList:[7,10,15,],//分页条中的下拉框选项
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
				id:"userinfodetail",
				type : 2,
				closeBtn : 0,
				title: false,
				shadeClose : true,
				scrollbar: false,
				area : [ '680px', '390px' ],
				anim :3,
				content :"${pageContext.request.contextPath}/userAction_userinfoDetail.action?stuOrEmpId="+row.stuOrEmpId,
			});
		},
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
		 $('#users').datagrid('resize', 
		   { width:wid, 
		     });
		} 

});
</script>
</body>
</html>