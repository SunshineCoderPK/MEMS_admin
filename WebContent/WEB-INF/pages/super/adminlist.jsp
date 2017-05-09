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
<body>
<div class="place">
    <span>位置：</span>
    <ul class="placeul">
    <li><a href="#">首页</a></li>
    <li><a href="#">管理员管理</a></li>
    <li><a href="#">管理员列表</a></li>
    </ul>
    </div>
    
    <div class="rightinfo">
    
    <div class="tools">
    
    	<ul class="toolbar">
    	<li style="width: 80px"  onclick="selectall()" href="#"><span><img src="images/t06.png"/></span>全选</li>
    	<li style="width: 110px"  onclick="clearselall()" href="#"><span><img src="images/t06.png"/></span>清空选择</li>
		<li style="width: 110px"  onclick="" href="#"><span><img src="images/t03.png"/></span>批量删除</li>
				
		</ul>
			<div  class="search_div"><input type="text" id="searchkey" class="search_input">
					<button onclick="searchbykey()" class="search_btn" type="button">搜索</button></div>
    </div>
    </div>
   
<div id="admins" style="margin-top: 50px" ></div>

<script type="text/javascript">
var  click=0;
$(function(){
	$("#admins").datagrid({
		columns:[[//定义标题行所有的列
			      {field :'empId',checkbox : true,},
		          {field:'empid',title:'工号',width:0.7 ,align:'center',formatter:function(value,row,index){
			          return row.empId;
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
			      {field:'_operate',title:'操作',width:1, align:'center',formatter: function formatOper(val,row,index){  
					    return '<a href="#"  onclick="editAdmin('+index+')"><img  href="#" title="编辑" src="images/edit.png"></a></img>&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" onclick="resetPwd('+index+')"><img href="#" title="重置密码"  src="images/redopwd.ico"></img></a>&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" onclick="deleteAdmin('+index+')"><img href="#" title="删除"  src="images/delete.ico"></img></a>';  
				  }},
		          ]],
	    url:'${pageContext.request.contextPath}/adminAction_admininfos.action', //指定URL地址，控件自动发送ajax请求获取数据	
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
				id:"admininfodetail",
				type : 2,
				closeBtn : 0,
				title: false,
				shadeClose : true,
				scrollbar: false,
				area : [ '780px', '390px' ],
				anim :3,
				content :"${pageContext.request.contextPath}/adminAction_admininfoDetail.action?empId="+row.empId,
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
		 $('#admins').datagrid('resize', 
		   { width:wid, 
		     });
		} 

});


	/*全选*/
	function selectall() {
		$("#admins").datagrid("checkAll");
	}

	/*清空选择*/
	function clearselall() {
		$("#admins").datagrid("uncheckAll");
	}

	/*搜索*/
	function searchbykey() {
		var key = $('#searchkey').val();
		var p = {
			key : $("#searchkey").val()
		};
		$("#admins").datagrid("load", p);

	}

	/*重置密码*/

	function resetPwd(index) {
		click=1;
		var rows = $('#admins').datagrid('getRows');
		var row = rows[index];
		var empId = row.empId;
		var url = "${pageContext.request.contextPath}/adminAction_resetPassword.action?empId="+empId;
		

	}

	/*删除用户*/

	function deleteAdmin(index) {
		click=1;
		var confirmindex=layer.confirm('确定删除？', {
			  btn: ['是','否'] //按钮
			}, function(){
				var rows = $('#admins').datagrid('getRows');
				var row = rows[index];
				var empId = row.empId;
				var url = "${pageContext.request.contextPath}/adminAction_deleteAdmin.action";
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
					$("#admins").datagrid("load", "");
					return false;
				});	
			 }, function(){
			  layer.close(confirmindex);
			});
		
	}

	/*修改管理员信息*/
	function editAdmin(index) {
		click=1;
		var rows = $('#admins').datagrid('getRows');
		var row = rows[index];
		var empId = row.empId;
		var index1=layer.open({
			id:"changeadmin",
			type :2,
			title: ['管理员信息修改', 'font-size:18px;'], 
			area : [ '780px', '390px' ],
			content :"${pageContext.request.contextPath}/adminAction_changeAdmin.action?empId="+row.empId,
		});
		layer.full(index1);
	}

	/*用户-添加*/
	function member_add(title, url, w, h) {
		layer_show(title, url, w, h);
	}
	/*用户-查看*/
	function member_show(title, url, id, w, h) {
		layer_show(title, url, w, h);
	}
	/*用户-停用*/
	function member_stop(obj, id) {
		layer
				.confirm(
						'确认要停用吗？',
						function(index) {
							$
									.ajax({
										type : 'POST',
										url : '',
										dataType : 'json',
										success : function(data) {
											$(obj)
													.parents("tr")
													.find(".td-manage")
													.prepend(
															'<a style="text-decoration:none" onClick="member_start(this,id)" href="javascript:;" title="启用"><i class="Hui-iconfont">&#xe6e1;</i></a>');
											$(obj)
													.parents("tr")
													.find(".td-status")
													.html(
															'<span class="label label-defaunt radius">已停用</span>');
											$(obj).remove();
											layer.msg('已停用!', {
												icon : 5,
												time : 1000
											});
										},
										error : function(data) {
											console.log(data.msg);
										},
									});
						});
	}

	/*用户-启用*/
	function member_start(obj, id) {
		layer
				.confirm(
						'确认要启用吗？',
						function(index) {
							$
									.ajax({
										type : 'POST',
										url : '',
										dataType : 'json',
										success : function(data) {
											$(obj)
													.parents("tr")
													.find(".td-manage")
													.prepend(
															'<a style="text-decoration:none" onClick="member_stop(this,id)" href="javascript:;" title="停用"><i class="Hui-iconfont">&#xe631;</i></a>');
											$(obj)
													.parents("tr")
													.find(".td-status")
													.html(
															'<span class="label label-success radius">已启用</span>');
											$(obj).remove();
											layer.msg('已启用!', {
												icon : 6,
												time : 1000
											});
										},
										error : function(data) {
											console.log(data.msg);
										},
									});
						});
	}
	/*用户-编辑*/
	function member_edit(title, url, id, w, h) {
		layer_show(title, url, w, h);
	}
	/*密码-修改*/
	function change_password(title, url, id, w, h) {
		layer_show(title, url, w, h);
	}
	/*用户-删除*/
	function member_del(obj, id) {
		layer.confirm('确认要删除吗？', function(index) {
			$.ajax({
				type : 'POST',
				url : '',
				dataType : 'json',
				success : function(data) {
					$(obj).parents("tr").remove();
					layer.msg('已删除!', {
						icon : 1,
						time : 1000
					});
				},
				error : function(data) {
					console.log(data.msg);
				},
			});
		});
	}
</script>
</body>
</html>