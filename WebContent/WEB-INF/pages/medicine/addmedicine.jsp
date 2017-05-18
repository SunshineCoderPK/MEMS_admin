<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="Bookmark" href="/favicon.ico" >
<link rel="Shortcut Icon" href="/favicon.ico" />
<!--[if lt IE 9]>
<script type="text/javascript" src="lib/html5shiv.js"></script>
<script type="text/javascript" src="lib/respond.min.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="h-ui/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="h-ui.admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="lib/Hui-iconfont/1.0.8/iconfont.css" />
<link rel="stylesheet" type="text/css" href="h-ui.admin/skin/default/skin.css" id="skin" />
<link rel="stylesheet" type="text/css" href="h-ui.admin/css/style.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/layui/css/layui.css">
	<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/css/medicine.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/layui/css/modules/layer/default/layer.css">
<!--[if IE 6]>
<script type="text/javascript" src="lib/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script>
<![endif]-->
<!--/meta 作为公共模版分离出去-->

<title>添加用户 - 在线医疗报销系统后台</title>
</head>
<body>
<article class="page-container">
<div style="width: 700px;  display:inline-block ; margin-top: 30px">
	<form action="" method="post" class=" layui-form form form-horizontal" id="form-member-add" style="width: 700px">
	    <div class="row cl" style="margin-top: 20px;">
	        <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>编号：</label>
			<div class="formControls col-xs-8 col-sm-9" style="width: 200px">
				<input type="text" class="input-text" value="" placeholder="" id="med_medicNum" name="medicNum">
			</div>
			<label class="form-label col-xs-4 col-sm-3" style="width: 100px;padding-left: 0px;padding-right: 15px"><span class="c-red">*</span>中文名称：</label>
			<div class="formControls col-xs-8 col-sm-9" style="width: 200px">
				<input type="text" class="input-text" value="" placeholder="" id="med_medicName" name="medicCname">
			</div>
			
		</div>
		<div class="row cl" style="margin-top: 20px;">
			<label class="form-label col-xs-4 col-sm-3">英文名称：</label>
			<div class="formControls col-xs-8 col-sm-9" style="width:200px">
				<input type="text" class="input-text"  name="medicEname" id="med_medicEname">
			</div>
			<label class="form-label col-xs-4 col-sm-3" style="width: 100px;padding-left: 0px;padding-right: 15px"><span class="c-red">*</span>报销比例：</label>
			<div class="formControls col-xs-8 col-sm-9" style="width: 200px">
				<input type="text" class="input-text" value="" placeholder="" id="med_rate" name="rate">
			</div>
		</div>
		<div class="row cl" style="margin-top: 20px;">
			<label class="form-label col-xs-4 col-sm-3">汉语拼音：</label>
			<div class="formControls col-xs-8 col-sm-9" style="width: 200px">
				<input type="text" class="input-text" value="" placeholder="" id="med_medicSname" name="medicSname">
			</div>
			<label class="form-label col-xs-4 col-sm-3" style="width: 100px">剂型：</label>
			<div class="formControls col-xs-8 col-sm-9" style="width: 200px">
				<input type="text" class="input-text" value="" placeholder="" id="med_dosageTyp" name="dosageTyp">
			</div>
		</div>
		<div class="row cl" style="margin-top: 20px;">
			<label class="form-label col-xs-4 col-sm-3">报销类型：</label>
			<div class="formControls col-xs-8 col-sm-9" style="width: 200px;height: 31px">
				 <select id="med_expenseTyp" name="expenseTyp"  class="selectborder" style="width: 170px;height: 31px; display: block; border:  solid 1px #ddd;">
                 <option value="甲类">甲类</option>
                 <option value="乙类">乙类</option>
              </select>
			</div>
			<label class="form-label col-xs-4 col-sm-3" style="width: 100px" id="gs">单位：</label>
			<div class="formControls col-xs-8 col-sm-9" style="width:200px">
				<input type="text" class="input-text"  name="medicUnit" id="med_medicUnit">
			</div>
		</div>
		<div class="row cl" style="margin-top: 20px;">
			<label class="form-label col-xs-4 col-sm-3">是否医保：</label>
			<div class="formControls col-xs-8 col-sm-9" style="width: 200px;height: 31px">
				 <select id="med_isExpense" name="isExpense"  class="selectborder" style="width: 170px;height: 31px; display: block; border:  solid 1px #ddd;">
                 <option value=1>是</option>
                 <option value=0>否</option>
              </select>
			</div>
			<label class="form-label col-xs-4 col-sm-3" style="width: 100px" id="gs">最高限价：</label>
			<div class="formControls col-xs-8 col-sm-9" style="width:200px">
				<input type="text" class="input-text"   name="medicPrice" id="med_medicPrice">
			</div>
		</div>

		<div class="row cl" style="margin-top: 20px;">
			<label class="form-label col-xs-4 col-sm-3">备注：</label>
			<div class="formControls col-xs-8 col-sm-9" style="width:500px">
				<input type="text" class="input-text"  name="remark" id="med_remark">
			</div>
		</div>
		
		<div class="row cl" style="margin-top: 20px;">
			<div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-3">
				<input class="btn btn-primary radius" type="submit" lay-submit lay-filter="formDemo" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
			</div>
		</div>
	</form>
	</div>
</article>

<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script> 
<script type="text/javascript" src="lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="h-ui/js/H-ui.min.js"></script> 
<script type="text/javascript" src="h-ui.admin/js/H-ui.admin.js"></script>
<script type="text/javascript"
    src="${pageContext.request.contextPath }/js/layui/layui.js">
</script>
<script type="text/javascript"
    src="${pageContext.request.contextPath }/js/ajaxfileupload.js">
</script>
<script type="text/javascript"
    src="${pageContext.request.contextPath }/js/layui/lay/modules/layer.js">
</script>
<!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本--> 
<script type="text/javascript" src="lib/My97DatePicker/4.8/WdatePicker.js"></script>
<script type="text/javascript" src="lib/jquery.validation/1.14.0/jquery.validate.js"></script> 
<script type="text/javascript" src="lib/jquery.validation/1.14.0/validate-methods.js"></script> 
<script type="text/javascript" src="lib/jquery.validation/1.14.0/messages_zh.js"></script>
<script type="text/javascript">
$(function(){
	
	$("#form-member-add").validate({
		rules:{
			medicNum:{
				required: true,
			},
			medicCname:{
				required: true,
			},
			rate:{
				required: true,
				number:true,
			},
			medicPrice:{
				digits:true,
			},		
		},
		onkeyup:false,
		focusCleanup:true,
		success:"valid",
		submitHandler:function(form){
			 $(form).ajaxSubmit({
	                dataType:"text",
	                url:"${pageContext.request.contextPath}/medicineAction_addmedicine.action",
	                success:function( jsondata ){
	                	if(jsondata=="failed"){
	                		var index1=layer.alert('药品添加失败', {
		            		    skin: 'layui-layer-lan',
		            		    title:"提示信息",
		                		closeBtn: 0
		            		    ,anim: 4 //动画类型
		            		  },function(){
		            			  layer.close(index1);
		            			  clearall();
		                      });
	     		    	}
	     	  		     else{
	     	  		    	layer.alert('药品添加成功', {
		            		    skin: 'layui-layer-lan',
		            		    title:"提示信息",
		                		closeBtn: 0
		            		    ,anim: 4 //动画类型
		            		  },function(){
		            			  var index = parent.layer.getFrameIndex(window.name);
				        		  parent.layer.close(index);
				        		  parent.location.reload();
		                      });
	     	  		     }         			
	                  }
	                }); 
	  		   
	  		 }
	});
});
function clearall() {
	$("#med_medicNum").val("");
	$("#med_medicCname").val("");
	$("#med_medicEname").val("");
	$("#med_medicSname").val("");
	$("#med_dosageTyp").val("");
	$("#med_medicUnit").val("");
	$("#med_medicPrice").val("");
	$("#med_rate").val("");
	$("#med_remark").val("");
}


	

</script> 
<!--/请在上方写此页面业务相关的脚本-->
</body>
</html>