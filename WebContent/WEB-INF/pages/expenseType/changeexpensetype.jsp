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
     <input type="hidden" value="${expensetype.expenseTyp} " id="medid"/>
     <input type="hidden" value="${expensetype.medicalTyp }" id="expmed"/>
	<form action="" method="post" class=" layui-form form form-horizontal" id="form-member-add">
	    <div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">编号：</label>
			<div class="formControls col-xs-8 col-sm-9" style="width: 200px">
				<input type="text" class="input-text" value="${expensetype.expenseTyp}" disabled="true"  id="typ_expenseTyp" >
			</div>
			<label class="form-label col-xs-4 col-sm-3" style="width: 100px">报销比例：</label>
			<div class="formControls col-xs-8 col-sm-9" style="width: 200px">
				<input type="text" class="input-text" value="" placeholder="" id="typ_expenseProportion" name="expenseProportion">
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">人员类型：</label>
			<div class="formControls col-xs-8 col-sm-9" style="width: 200px;height: 31px" >
				 <select id="typ_userRoleId" name="userRoleId"  class="selectborder" style="width: 170px;height: 31px; display: block; border:  solid 1px #ddd;">
                 <option value=1>教职工</option>
                 <option value=2>学生</option>
              </select>
			</div>
			<label class="form-label col-xs-4 col-sm-3" style="width: 100px" id="gs">医疗类型：</label>
			<div class="formControls col-xs-8 col-sm-9" style="width: 200px;height: 31px">
				 <select id="typ_medicalTyp" name="medicalTyp"  class="selectborder" style="width: 170px;height: 31px; display: block; border:  solid 1px #ddd;">
				 <option value="一般门诊">一般门诊</option>
                 <option value="住院">住院</option>
                 <option value="特殊门诊">特殊门诊</option>
              </select>
              </div>
		</div>
			<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">医院类型：</label>
			<div class="formControls col-xs-8 col-sm-9" style="width: 200px;height: 31px">
				 <select id="typ_hosptyp" name="hosptyp"  class="selectborder" style="width: 170px;height: 31px; display: block; border:  solid 1px #ddd;">
                 <option value=5>校内医院</option>
                 <option value=1>校外一级</option>
                 <option value=2>校外二级</option>
                 <option value=3>校外三级</option>
                 <option value=4>异地医院</option>
              </select>
			</div>
			<label class="form-label col-xs-4 col-sm-3" style="width: 100px" id="gs">是否退休：</label>
			<div class="formControls col-xs-8 col-sm-9" style="width: 200px;height: 31px">
				 <select id="typ_isRetire" name="isRetire"  class="selectborder" style="width: 170px;height: 31px; display: block; border:  solid 1px #ddd;">
                 <option value=1>已达标准</option>
                 <option value=0>未退休</option>
              </select>
              </div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">保健卡：</label>
			<div class="formControls col-xs-8 col-sm-9" style="width: 200px;height: 31px">
				 <select id="typ_healthCard" name="healthCard"  class="selectborder" style="width: 170px;height: 31px; display: block; border:  solid 1px #ddd;">
                 <option value=1>有</option>
                 <option value=0>无</option>
              </select>
			</div>
			<label class="form-label col-xs-4 col-sm-3" style="width: 100px" id="gs">门槛费：</label>
			<div class="formControls col-xs-8 col-sm-9" style="width:200px">
				<input type="text" class="input-text"   name="thresholdFee" id="typ_thresholdFee">
			</div>
		</div>
	
		<div class="row cl">
			<div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-3">
				<input class="btn btn-primary radius" type="submit" lay-submit lay-filter="formDemo" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
			</div>
		</div>
	</form>
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
	$("#typ_userRoleId option[value='"+${expensetype.userRoleId }+"']").attr("selected","selected"); 
	var s=$("#expmed").val();
	$("#typ_medicalTyp ").val(s); 
	$("#typ_hosptyp option[value='"+${expensetype.hosptyp }+"']").attr("selected","selected");
	var isretire; 
	if(${expensetype.isRetire }=='true'){
		isretire=1;
	}
	else{
		isretire=0;
	}
	$("#typ_isRetire option[value='"+isretire+"']").attr("selected","selected");
	var healthCard; 
	if(${expensetype.healthCard }=='true'){
		healthCard=1;
	}
	else{
		healthCard=0;
	}
	$("#typ_healthCard option[value='"+healthCard+"']").attr("selected","selected");
	$("#form-member-add").validate({
		rules:{
			thresholdFee:{
				digits:true,
			},		
		},
		onkeyup:false,
		focusCleanup:true,
		success:"valid",
		submitHandler:function(form){
			 $(form).ajaxSubmit({
	                dataType:"text",
	                url:"${pageContext.request.contextPath}/expenseTypeAction_changetype.action?expenseTyp="+$("#medid").val(),
	                success:function( jsondata ){
	                	if(jsondata=="failed"){
	     	  		    	 layer.msg("修改失败");
	     	  		    	 clearall();
	     		    	}
	     	  		     else{
	     		    		 layer.msg("修改成功");
	     		    		var index = parent.layer.getFrameIndex(window.name);
		        			parent.layer.close(index);
		        			parent.location.reload();
	     	  		     }         			
	                  }
	                }); 
	  		   
	  		 }
	});
});
function clearall() {
	$("#typ_thresholdFee").val("");
	$("#typ_expenseProportion").val("");
}


</script> 
<!--/请在上方写此页面业务相关的脚本-->
</body>
</html>