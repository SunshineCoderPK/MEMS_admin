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
    <li><a href="#">医疗项管理</a></li>
    </ul>
    </div>
    
    <div class="rightinfo">
       <div style="margin-top: 20px;">
    <ul class="seachform url1">
    
    <li style="margin-right: 30px;margin-left: 70px"><label>综合查询</label><input id="searchkey" name="" type="text" class="scinput" /></li>
    <li style="margin-right: 30px"><label>类型</label>  
    <div class="vocation">
    <select class="select3"  id="medicalitem_expenseTyp">
    <option value="">全部</option>
    <option value="甲类">甲类</option>
    <option value="乙类">乙类</option>
    </select>
    </div>
    </li>
    
    <li style="margin-right: 30px"><label>状态</label>  
    <div class="vocation">
    <select class="select3"  id="medicalitem_status">
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
	    <li style="padding-right: 0px;width: 110px"">  <span><img src="images/t01.png"/> </span><input  type="button" id="uploadmedicalitems" class="clearbtn" value="批量注册" style="height:100%;"/></li> 
				
		</ul>

    </div>
    </div>
   
<div id="medicalitems" style="margin-top: 50px" ></div>

<script type="text/javascript">
var  click=0;
$(function(){
	$("#medicalitems").datagrid({
		columns:[[//定义标题行所有的列
			  {field:'medicalNum',checkbox : true,}, 
			  {field:'medicalnum',title:'类型编号',width:2,align:'center',formatter:function(value,row,index){
		          return row.medicalNum;
		      }},
	          {field:'medicalName',title:'报销项名称',width:2,align:'center',},
	          {field:'expenseTyp',title:'报销类型' , width:0.6,align:'center',},
	          {field:'isExpense',title:'是否医保' ,width:0.6,align:'center',formatter:function(value,row,index){
		          if(row.isExpense==false){
			          return "否";
			      }
		          else{
			          return "是";
		          }
		      }},
	        
	          {field:'medicalPrice',title:'最高限价/元', width:1, align:'center',formatter:function(value,row,index){
		          if(row.medicalPrice==null||row.medicalPrice==0){
			          return "不限价";
			      }
		          else{
			          return row.medicalPrice;
		          }
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
					    return '<a href="#"  onclick="editmedicalitem('+index+')"><img  href="#" title="编辑" src="images/edit.png"></img></a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" onclick="deletemedicalitem('+index+')"><img href="#" title="删除"  src="images/delete.ico"></img></a>';  
				  }},
		      ]],
	    url:'${pageContext.request.contextPath}/medicalItemAction_medicaliteminfo.action', //指定URL地址，控件自动发送ajax请求获取数据	
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
				id:"medicaliteminfodetail",
				type : 2,
				closeBtn : 0,
				title: false,
				shadeClose : true,
				scrollbar: false,
				area : [ '450px', '248px' ],
				anim :3,
				content :"${pageContext.request.contextPath}/medicalItemAction_medicalitemDetail.action?medicalNum="+row.medicalNum,
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
		 $('#medicalitems').datagrid('resize', 
		   { width:wid, 
		     });
		} 


	$("#uploadmedicalitems").upload({
         action: '${pageContext.request.contextPath}/medicalItemAction_signupmedicalitembatch.action',  
         name: 'myFile',
         enctype: 'multipart/form-data',
         onComplete: function(data) {
            if(data == '1'){
            	//上传成功
            	  layer.alert('报销项导入成功', {
            		    skin: 'layui-layer-lan',
            		    title:"提示信息",
                		closeBtn: 0
            		    ,anim: 4 //动画类型
            		  },function(){
                		  window.location.href='${pageContext.request.contextPath}/page_medicalitem_medicalitemlist';
                      });
            }else{
            		//失败
            	layer.alert('报销项导入失败,文件选择错误', {
        		    skin: 'layui-layer-lan',
        		    title:"提示信息",
            		closeBtn: 0
        		    ,anim: 4 //动画类型
        		  },function(){
            		  window.location.href='${pageContext.request.contextPath}/page_medicalitem_medicalitemlist';
                  });
            }
          }
		});

});


	/*全选*/
	function selectall() {
		$("#medicalitems").datagrid("checkAll");
	}

	/*清空选择*/
	function clearselall() {
		$("#medicalitems").datagrid("uncheckAll");
	}

	/*搜索*/
	function searchbykey() {
		var key = $('#searchkey').val();
		var p = {
			key : $("#searchkey ").val(),
			mexpenseTyp : $("#medicalitem_expenseTyp option:selected").val(),
			status: $("#medicalitem_status option:selected").val(),
		};
		$("#medicalitems").datagrid("load", p);
		$("#searchkey").val("");
	}

	

	/*删除报销项*/

	function deletemedicalitem(index) {
		click=1;
		var confirmindex=layer.confirm('确定删除？', {
			  btn: ['是','否'] //按钮
			}, function(){
				var rows = $('#medicalitems').datagrid('getRows');
				var row = rows[index];
				var medicalNum = row.medicalNum;
				var url = "${pageContext.request.contextPath}/medicalItemAction_deletemedicalitem.action";
				$.post(url, {
					"medicalNum" : medicalNum
				}, function(data) {
					if (data == '1') {
						//修改密码成功
						layer.msg("删除成功");
					} else {
						//修改失败
						layer.msg("删除失败");
					}
					$("#medicalitems").datagrid("load", "");
					return false;
				});	
			 }, function(){
			  layer.close(confirmindex);
			});
		
	}

	/*修改报销项信息*/
	function editmedicalitem(index) {
		click=1;
		var rows = $('#medicalitems').datagrid('getRows');
		var row = rows[index];
		var medicalNum = row.medicalNum;
		var index1=layer.open({
			id:"changemedicalitem",
			type :2,
			title: ['报销项信息修改', 'font-size:18px;'], 
			area : [ '800px', '390px' ],
			content :"${pageContext.request.contextPath}/medicalItemAction_changemeditem.action?medicalNum="+row.medicalNum,
		});
	}

	//批量删除报销项
	function doDelete(){
		//获得选中的行
		var rows = $("#medicalitems").datagrid("getSelections");
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
						var id = rows[i].medicalNum;
						array.push(id);
					}
			  		var ids = array.join(","); 
					//发送请求，传递ids参数
					window.location.href = '${pageContext.request.contextPath}/medicalItemAction_deletebatch.action?ids='+ids;
					/* var url = "${pageContext.request.contextPath}/medicalitemAction_deletemedicalitem.action";
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
						$("#medicalitems").datagrid("load", "");
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