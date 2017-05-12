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
       <div style="margin-top: 20px;">
    <ul class="seachform url1">
    
    <li style="margin-right: 30px;margin-left: 70px"><label>综合查询</label><input id="searchkey" name="" type="text" class="scinput" /></li>
    <li style="margin-right: 30px"><label>性别</label>  
    <div class="vocation">
    <select class="select3"  id="user_sex">
    <option value="">全部</option>
    <option value=1>男</option>
    <option value=0>女</option>
    </select>
    </div>
    </li>
    
    <li style="margin-right: 30px"><label>身份</label>  
    <div class="vocation" >
    <select class="select3" id="user_roleId">
    <option value=0>全部</option>
    <option value=1>教职工</option>
    <option value=2>学生</option>
    </select>
    </div>
    </li>
    

    
    <li><label>&nbsp;</label><input name="" type="button" class="scbtn" value="查询"/></li>
    
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


	/*全选*/
	function selectall() {
		$("#users").datagrid("checkAll");
	}

	/*清空选择*/
	function clearselall() {
		$("#users").datagrid("uncheckAll");
	}

	/*搜索*/
	function searchbykey() {
		var key = $('#searchkey').val();
		var p = {
			key : $("#searchkey").val(),
			sex : $("#user_sex").val(),
			roleId:$("#user_roleId").val()
		};
		$("#users").datagrid("load", p);
		$("#searchkey").val("");
	}

	/*重置密码*/

	function resetPwd(index) {
		click=1;
		var rows = $('#users').datagrid('getRows');
		var row = rows[index];
		var empId = row.empId;
		var url = "${pageContext.request.contextPath}/userAction_resetPassword.action?stuOrEmpId="+row.stuOrEmpId;
		

	}

	/*删除用户*/

	function deleteuser(index) {
		click=1;
		var confirmindex=layer.confirm('确定删除？', {
			  btn: ['是','否'] //按钮
			}, function(){
				var rows = $('#users').datagrid('getRows');
				var row = rows[index];
				var stuOrEmpId = row.stuOrEmpId;
				var url = "${pageContext.request.contextPath}/userAction_deleteuser.action";
				$.post(url, {
					"stuOrEmpId" : stuOrEmpId
				}, function(data) {
					if (data == '1') {
						//修改密码成功
						layer.msg("删除成功");
					} else {
						//修改失败
						layer.msg("删除失败");
					}
					$("#users").datagrid("load", "");
					return false;
				});	
			 }, function(){
			  layer.close(confirmindex);
			});
		
	}

	/*修改用户信息*/
	function edituser(index) {
		click=1;
		var rows = $('#users').datagrid('getRows');
		var row = rows[index];
		var empId = row.empId;
		var index1=layer.open({
			id:"changeuser",
			type :2,
			title: ['管理员信息修改', 'font-size:18px;'], 
			area : [ '780px', '390px' ],
			content :"${pageContext.request.contextPath}/userAction_changeuser.action?stuOrEmpId="+row.stuOrEmpId,
		});
		layer.full(index1);
	}

	//批量删除用户
	function doDelete(){
		//获得选中的行
		var rows = $("#users").datagrid("getSelections");
		if(rows.length == 0){
			//没有选中，提示
			  layer.alert('请选择需要删除的记录！', {
               skin: 'layui-layer-lan'
               ,closeBtn: 0
                ,anim: 4 //动画类型
              });
		}else{
			var confirmindex=layer.confirm('确定删除？', {
				  btn: ['是','否'] //按钮
				}, function(){
					var array = new Array();
					//选中了记录,获取选中行的id
					for(var i=0;i<rows.length;i++){
						var id = rows[i].stuOrEmpId;
						array.push(id);
					}
					var ids = array.join(",");
					//发送请求，传递ids参数
					window.location.href = '${pageContext.request.contextPath}/userAction_deletebatch.action?ids='+ids;
					/* var url = "${pageContext.request.contextPath}/userAction_deleteuser.action";
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
						$("#users").datagrid("load", "");
						return false;
					});	 */
				 }, function(){
				  layer.close(confirmindex);
				});
			
		}
	}
	
</script>
</body>
</html>