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
<script type="text/javascript" src="lib/My97DatePicker/4.8/WdatePicker.js"></script>
<body>
<div class="place">
    <span>位置：</span>
    <ul class="placeul">
    <li><a href="#">首页</a></li>
    <li><a href="#">资讯管理</a></li>
    <li><a href="#">资讯列表</a></li>
    </ul>
    </div>
    
    <div class="rightinfo">

    <div style="height: 30px;margin-top: 20px;margin-left: 390px;">
    <input type="text"  onfocus="WdatePicker({  })" id="datemin" class="time_input Wdate" style="width:120px;">
		-
		<input type="text" onfocus="WdatePicker({ minDate:'#F{$dp.$D(\'datemin\')}' })" id="datemax" class=" time_input Wdate" style="width:120px;">
    	 <div  class="search_div" style="margin-right: 100px;"><input type="text" id="searchkey" class="search_input">
					<button onclick="searchbykey()" class="search_btn" type="button">搜索</button></div>
    </div>
   

  
    
    <div class="tools">
    
    	<ul class="toolbar">
    	<li style="width: 80px"  onclick="selectall()" href="#"><span><img src="images/t06.png"/></span>全选</li>
    	<li style="width: 110px"  onclick="clearselall()" href="#"><span><img src="images/t06.png"/></span>清空选择</li>
		<li style="width: 110px"  onclick="doDelete()" href="#"><span><img src="images/t03.png"/></span>批量删除</li>
				
		</ul>
		
    </div>
    </div>
   
<div id="anns" style="margin-top: 50px" ></div>

<script type="text/javascript">
var  click=0;
$(function(){
	$("#anns").datagrid({
		columns:[[//定义标题行所有的列
			  {field :'annId',checkbox : true,},
	          {field:'annid',title:'编号',width:0.7,align:'center',formatter:function(value,row,index){
		          return row.annId;
		      }},
	          {field:'annTitle',title:'标题',width:2,align:'center'},
	          {field:'annContent',title:'内容',align:'center', hidden:true},
	          {field:'admininfo',title:'发送人',width:0.7,align:'center', formatter: function(value,row,index){
					if (row.admininfo){
						return row.admininfo.name;
					} else {
						return value;
					}
				},
			  },
	          {field:'publishTime',title:'发送日期',width:1,align:'center',},
			  {field:'isDelete',title:'状态',width:0.5,align:'center',formatter: function formatOper(val,row,index){
				  if(row.isDelete){
					  return '<label class="status_label">已删除</label>';
				  }  
				  else{
					  return '<label class="status_label">正常</label>';
			      }
			  }},
			  {field:'_operate',title:'操作', width:0.6, align:'center',formatter: function formatOper(val,row,index){  
				    return '<a href="#"  onclick="editAnn('+index+')"><img  href="#" title="编辑" src="images/edit.png"></img></a>&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" onclick="deleteAnn('+index+')"><img href="#" title="删除"  src="images/delete.ico"></img></a>';  
			  }},
	          ]],
        url:'${pageContext.request.contextPath}/annocementAction_pageQuery.action', //指定URL地址，控件自动发送ajax请求获取数据	
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
		    
		    var url='${pageContext.request.contextPath}/annocementAction_findAnnouncementById.action';
		    $.post(url,{"annId":row.annId},function(data){
		    	var index1 = layer.open({
			    	  title:data.annTitle,
		    		  type: 1,
		    		  content: ""+data.annContent,
		    		  area: ['320px', '195px'],
		    		  maxmin: true
		    		});
		    		layer.full(index1);
			});	
		},
	    }); 

	 $(window).resize(function(){
		 var wid= document.body.clientWidth*1;
		 //alert(wid);
		 resize(wid);
		});

		//调整表格的局
		function resize(wid){
		 $('#anns').datagrid('resize', 
		   { width:wid, 
		     });
		} 

});


	/*全选*/
	function selectall() {
		$("#anns").datagrid("checkAll");
	}

	/*清空选择*/
	function clearselall() {
		$("#anns").datagrid("uncheckAll");
	}

	/*搜索*/
	function searchbykey() {
		var datemin=$("#datemin").val();
		var datemax=$("#datemax").val();
		var key = $('#searchkey').val();
		var p = {
			key : $("#searchkey").val(),
			datemin:datemin,
			datemax:datemax
		};
		$("#anns").datagrid("load", p);
		$("#datemin").val("");
		$("#datemax").val("");
		$('#searchkey').val("");

	}


	/*删除公告*/

	function deleteAnn(index) {
		click=1;
		var confirmindex=layer.confirm('确定删除？', {
			  btn: ['是','否'] //按钮
			}, function(){
				var rows = $('#anns').datagrid('getRows');
				var row = rows[index];
				var annId= row.annId;
				var url = "${pageContext.request.contextPath}/annocementAction_deleteAnn.action";
				$.post(url, {
					"annId" : annId
				}, function(data) {
					if (data == '1') {
						//修改密码成功
						layer.msg("删除成功");
					} else {
						//修改失败
						layer.msg("删除失败");
					}
					$("#anns").datagrid("load", "");
					return false;
				});	
			 }, function(){
			  layer.close(confirmindex);
			});
		
	}

	/*修改公告信息*/
	function editAnn(index) {
		click=1;
		var rows = $('#anns').datagrid('getRows');
		var row = rows[index];
		var annId = row.annId;
		var index1=layer.open({
			id:"changeann",
			type :2,
			title: ['公告信息修改', 'font-size:18px;'], 
			area : [ '780px', '390px' ],
			content :"${pageContext.request.contextPath}/annocementAction_changeAnninfo.action?annId="+row.annId,
		});
		layer.full(index1);
	}

	//批量删除公告
	function doDelete(){
		//获得选中的行
		var rows = $("#anns").datagrid("getSelections");
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
						var id = rows[i].annId;
						array.push(id);
					}
					var ids = array.join(",");
					//发送请求，传递ids参数
					window.location.href = '${pageContext.request.contextPath}/annocementAction_deletebatch.action?ids='+ids;
					/* var url = "${pageContext.request.contextPath}/adminAction_deleteAdmin.action";
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
						$("#anns").datagrid("load", "");
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