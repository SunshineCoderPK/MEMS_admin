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
<div style="width: 700px;  display:inline-block ; margin-top: 50px">
     <input type="hidden" value="${medicine.medicNum} " id="medid"/>
	<form action="" method="post" class=" layui-form form form-horizontal" id="form-member-add" style="width: 700px">
	    <div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">中文名称：</label>
			<div class="formControls col-xs-8 col-sm-9" style="width: 200px">
				<input type="text" class="input-text" value="" placeholder="" id="med_medicName" name="medicCname">
			</div>
			<label class="form-label col-xs-4 col-sm-3" style="width: 100px">报销比例：</label>
			<div class="formControls col-xs-8 col-sm-9" style="width: 200px">
				<input type="text" class="input-text" value="" placeholder="" id="med_rate" name="rate">
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">英文名称：</label>
			<div class="formControls col-xs-8 col-sm-9" style="width:500px">
				<input type="text" class="input-text"  name="medicEname" id="med_medicEname">
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">汉语拼音：</label>
			<div class="formControls col-xs-8 col-sm-9" style="width: 200px">
				<input type="text" class="input-text" value="" placeholder="" id="med_medicSname" name="medicSname">
			</div>
			<label class="form-label col-xs-4 col-sm-3" style="width: 100px">剂型：</label>
			<div class="formControls col-xs-8 col-sm-9" style="width: 200px">
				<input type="text" class="input-text" value="" placeholder="" id="med_dosageTyp" name="dosageTyp">
			</div>
		</div>
		<div class="row cl">
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
		<div class="row cl">
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

		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">备注：</label>
			<div class="formControls col-xs-8 col-sm-9" style="width:500px">
				<input type="text" class="input-text"  name="remark" id="med_remark">
			</div>
		</div>
		
		<div class="row cl">
			<div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-3">
				<input class="btn btn-primary radius" type="submit" lay-submit lay-filter="formDemo" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
			</div>
		</div>
	</form>
	</div>
	 <div class="am-panel-bd">
            <div class="am-g">
              <div class="am-u-md-4" style="width:100%">
                <center><img id="medimg" class="am-img-circle am-img-thumbnail"   alt="照片"   src="${medicine.imgsrc}" style="width: 200px;height: 170px;padding: 2px;"/></center>
              </div>
              <div class="am-u-md-8" style="width:100%">
                <center><form class="am-form">
                  <div class="am-form-group">
                    <input type="file"  name="file" contentEditable="false"  id="medpic" style="margin-left: 70px;margin-bottom: 20px;margin-top: 20px">
                   
                    <button type="button" style="width: 130px; " class="am-btn am-btn-primary " onclick="upload_image()">保存</button>
                  </div>
                </form>
                </center>
              </div>
            </div>
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
	                url:"${pageContext.request.contextPath}/medicineAction_changemedicine.action?medicNum="+$("#medid").val(),
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
	$("#med_medicCname").val("");
	$("#med_medicEname").val("");
	$("#med_medicSname").val("");
	$("#med_dosageTyp").val("");
	$("#med_medicUnit").val("");
	$("#med_medicPrice").val("");
	$("#med_rate").val("");
	$("#med_remark").val("");
}


function upload_image(){
	 $.ajaxFileUpload
    (
        {
            url:'${pageContext.request.contextPath}/uploadimageAction_uploadimg.action?medicNum='+$("#medid").val(),//用于文件上传的服务器端请求地址
            secureuri:false,//一般设置为false
            fileElementId:'medpic',//文件上传空间的id属性  <input type="file" id="file" name="file" />
            dataType: 'json',//返回值类型 一般设置为json
            data : {
                folder:"medicine",
            },
            success: function (data, status)  //服务器成功响应处理函数
            {
           	 if(data.data=="fail1"){
               	 layer.msg("所选文件非图片格式");
	                 return false;
	             }
           	 if(data.data=="fail3"){
               	 layer.msg("请注册该用户后再上传图片");
	                 return false;
	             }
	             if(data.data=="fail2"){
	            	 layer.msg("你选择的图片错误或者该图片已经损坏！");
	            	 return false;
		         }
                //从服务器返回的json中取出message中的数据,其中message为在struts2中定义的成员变量
                $("#medimg").attr("src",data.data);
                
            },
            error: function (data, status, e)//服务器响应失败处理函数
            {
           	 layer.msg("你选择的图片错误或者该图片已经损坏！");
           	 return false;              
            }
        }
    )
}

</script> 
<!--/请在上方写此页面业务相关的脚本-->
</body>
</html>