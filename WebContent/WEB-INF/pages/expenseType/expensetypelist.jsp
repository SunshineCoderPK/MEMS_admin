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
</script></head>
<body>
<div class="place">
    <span>位置：</span>
    <ul class="placeul">
    <li><a href="#">首页</a></li>
    <li><a href="#">报销信息管理</a></li>
    <li><a href="#">报销类型管理</a></li>
    </ul>
    </div>
    
    <div class="rightinfo">
       <div style="margin-top: 20px;">
    <ul class="seachform url1">
    
    <li style="margin-right: 30px;margin-left: 0px"><label>综合查询</label><input id="searchkey" name="" type="text" class="scinput" /></li>
    
    <li style="margin-right: 30px"><label>人员类型</label>  
    <div class="vocation">
    <select class="select3"  id="expensetype_userRoleId">
    <option value="">全部</option>
    <option value=1>在职教职工</option>
    <option value=2>学生</option>
    <option value=3>退休教职工</option>
    </select>
    </div>
    </li>
    
    <li style="margin-right: 30px"><label>医院类型</label>  
    <div class="vocation">
    <select class="select3"  id="expensetype_hosptyp">
    <option value="">全部</option>
    <option value=5>校内医院</option>
    <option value=1>校外一级</option>
    <option value=2>校外二级</option>
    <option value=3>校外三级</option>
    <option value=4>异地医院</option>
    </select>
    </div>
    </li>
    
    <li style="margin-right: 30px"><label>状态</label>  
    <div class="vocation">
    <select class="select3"  id="expensetype_status">
    <option value=0>正常</option>
    <option value=1>已删除</option>
    <option value="">全部</option>
    </select>
    </div>
    </li>

    

    
    <li><label>&nbsp;</label><input name="" type="button" class="scbtn" value="查询" onclick="searchbykey()"/></li>
    
    </ul>
    	 
    </div>
    
    <div class="tools" style="margin-top: 10px">
    
    	<ul class="toolbar">
    	<li style="width: 80px"  onclick="selectall()" href="#"><span><img src="images/t06.png"/></span>全选</li>
    	<li style="width: 110px"  onclick="clearselall()" href="#"><span><img src="images/t06.png"/></span>清空选择</li>
		<li style="width: 110px"  onclick="doDelete()" href="#"><span><img src="images/t03.png"/></span>批量删除</li>
	    <li style="padding-right: 0px;width: 110px"">  <span><img src="images/t01.png"/> </span><input  type="button" id="uploadexpensetypes" class="clearbtn" value="批量注册" style="height:100%;"/></li> 
				
		</ul>

    </div>
    </div>
   
<div id="expensetypes" style="margin-top: 50px" ></div>

<script type="text/javascript">
var  click=0;
$(function(){
	$("#expensetypes").datagrid({
		columns:[[//定义标题行所有的列
			  {field:'expenseTyp',checkbox : true,},
			  {field:'expensetyp',title:'类型编号',width:1,align:'center',formatter:function(value,row,index){
		          return row.expenseTyp;
		      }},
	          {field:'userRoleId',title:'用户身份',width:1.5,align:'center',formatter:function(value,row,index){
		          if(row.userRoleId==1){
			          return "在职教职工";
			      }
		          else if(row.userRoleId==2){
			          return "学生";
		          }
		          else {
			          return "退休教职工"
			      }
		          
		      }},
	          {field:'medicalTyp',title:'医疗类型' , width:1.7,align:'center',},
	          {field:'hosptyp',title:'医院类型' , width:2,align:'center', formatter:function(value,row,index){
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
	          {field:'isRetire',title:'是否退休',width:1.5,align:'center',formatter:function(value,row,index){
		          if(row.isRetire==false){
			          return "未退休";
			      }
		          else{
			          return "退休或工龄大于30年";
		          }
		      }},
	          {field:'thresholdFee',title:'门槛费/元', width:1, align:'center',},
	          {field:'healthCard',title:'保健卡',width:1, align:'center',formatter:function(value,row,index){
		          if(row.healthCard==false){
			          return "无";
			      }
		          else{
			          return "有";
		          }
		      }},
	          {field:'expenseProportion',title:'报销比例', width:1, align:'center',formatter:function(value,row,index){
		          return value*100+"%";
		      }},
		      
			      {field:'isDelete',title:'状态',align:'center',width:0.8,formatter: function formatOper(val,row,index){
					  if(row.isDelete){
						  return '<label class="status_label">已删除</label>';
					  }  
					  else{
						  return '<label class="status_label">正常</label>';
				      }
				  }},
			      {field:'_operate',title:'操作', align:'center',width:1,formatter: function formatOper(val,row,index){  
					    return '<a href="#"  onclick="editexpensetype('+index+')"><img  href="#" title="编辑" src="images/edit.png"></img></a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" onclick="deleteexpensetype('+index+')"><img href="#" title="删除"  src="images/delete.ico"></img></a>';  
				  }},
		      ]],
	    url:'${pageContext.request.contextPath}/expenseTypeAction_expenseTypeinfo.action', //指定URL地址，控件自动发送ajax请求获取数据	
		singleSelect:false,//是否可以单选
		pagination:true,//分页条
		pageList:[7,10,15,],//分页条中的下拉框选项
	    rownumbers:true,
	    striped:true,   
	    fitColumns:true,
	    checkOnSelect:false,
	  
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
		 $('#expensetypes').datagrid('resize', 
		   { width:wid, 
		     });
		} 


	$("#uploadexpensetypes").upload({
         action: '${pageContext.request.contextPath}/expenseTypeAction_signupexpensetypebatch.action',  
         name: 'myFile',
         enctype: 'multipart/form-data',
         onComplete: function(data) {
            if(data == '1'){
            	//上传成功
            	  layer.alert('报销类型导入成功', {
            		    skin: 'layui-layer-lan',
            		    title:"提示信息",
                		closeBtn: 0
            		    ,anim: 4 //动画类型
            		  },function(){
                		  window.location.href='${pageContext.request.contextPath}/page_expenseType_expensetypelist';
                      });
            }else{
            		//失败
            	layer.alert('报销类型导入失败,文件选择错误', {
        		    skin: 'layui-layer-lan',
        		    title:"提示信息",
            		closeBtn: 0
        		    ,anim: 4 //动画类型
        		  },function(){
            		  window.location.href='${pageContext.request.contextPath}/page_expenseType_expensetypelist';
                  });
            }
          }
		});

});


	/*全选*/
	function selectall() {
		$("#expensetypes").datagrid("checkAll");
	}

	/*清空选择*/
	function clearselall() {
		$("#expensetypes").datagrid("uncheckAll");
	}

	/*搜索*/
	function searchbykey() {
		var key = $('#searchkey').val();
		var p = {
			key : $("#searchkey ").val(),
			muserRoleId : $("#expensetype_userRoleId option:selected").val(),
			mhosptyp: $("#expensetype_hosptyp option:selected").val(),
			status: $("#expensetype_status option:selected").val(),
		};
		$("#expensetypes").datagrid("load", p);
		$("#searchkey").val("");
	}

	

	/*删除报销类型*/

	function deleteexpensetype(index) {
		click=1;
		var confirmindex=layer.confirm('确定删除？', {
			  btn: ['是','否'] //按钮
			}, function(){
				var rows = $('#expensetypes').datagrid('getRows');
				var row = rows[index];
				var expenseTyp = row.expenseTyp;
				var url = "${pageContext.request.contextPath}/expenseTypeAction_delexpensetype.action";
				$.post(url, {
					"expenseTyp" : expenseTyp
				}, function(data) {
					if (data == '1') {
						//修改密码成功
						layer.msg("删除成功");
					} else {
						//修改失败
						layer.msg("删除失败");
					}
					$("#expensetypes").datagrid("load", "");
					return false;
				});	
			 }, function(){
			  layer.close(confirmindex);
			});
		
	}

	/*修改报销类型信息*/
	function editexpensetype(index) {
		click=1;
		var rows = $('#expensetypes').datagrid('getRows');
		var row = rows[index];
		var expenseTyp = row.expenseTyp;
		var index1=layer.open({
			id:"changeexpensetype",
			type :2,
			title: ['报销类型信息修改', 'font-size:18px;'], 
			area : [ '800px', '390px' ],
			content :"${pageContext.request.contextPath}/expenseTypeAction_changeexpensetype.action?expenseTyp="+row.expenseTyp,
		});
	}

	//批量删除报销类型
	function doDelete(){
		//获得选中的行
		var rows = $("#expensetypes").datagrid("getSelections");
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
						var id = rows[i].expenseTyp;
						array.push(id);
					}
			  		var ids = array.join(","); 
					//发送请求，传递ids参数
					window.location.href = '${pageContext.request.contextPath}/expenseTypeAction_deletebatch.action?ids='+ids;
					/* var url = "${pageContext.request.contextPath}/expensetypeAction_deleteexpensetype.action";
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
						$("#expensetypes").datagrid("load", "");
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