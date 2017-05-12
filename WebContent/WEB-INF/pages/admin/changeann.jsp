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
	src="${pageContext.request.contextPath }/js/jquery.js"></script>
<link href="css/style1.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/layui/css/layui.css">

<script src="${pageContext.request.contextPath }/js/layui/layui.js"
	type="text/javascript">
</script>	
<title>Insert title here</title>
</head>
<body>

<div id="tab1" class="tabson">
    <input type="hidden" id="mId" value=${annId}>
    <div class="formtext">Hi，<b>admin</b>，欢迎您使用信息发布功能！</div>
    <form class="layui-form" id="change_ann_info">
    <ul class="forminfo">
    <li><label>公告标题<b>*</b></label><input name="annTitle"  id="annTitle" type="text" class="dfinput" style="width:518px;"/></li>
   

    <li><label>通知内容<b>*</b></label>
    
    </li>
    <li>
       <textarea name="annContent" id="LAY_demo1" style="display: none;float: left ;margin-left: 150px" >  

    </textarea>
    </li>
    <li><label>&nbsp;</label><input name="" type="button" class="btn" value="马上发布" lay-submit lay-filter="formDemo" /></li>
    </ul>
    </form>
    </div> 
</body>
<script type="text/javascript">
$(function () {
	var layedit;
	 var index;
	layui.use('layedit', function(){
		   layedit = layui.layedit;
		 index=layedit.build('LAY_demo1', {
			  height: 180, //设置编辑器高度
			});
		});

	layui.use(['form', 'layedit', 'laydate'], function(){  
		  var form = layui.form(); 

      
   form.on('submit(formDemo)', function(data) {
	   $.post('${pageContext.request.contextPath}/annocementAction_changeAnn.action?annId='+$("#mId").val(),{annTitle:$("#annTitle").val(),annContent:layedit.getContent(index)},function(res){
		     if(res=="failed"){
		    	 layer.msg("修改失败");
		    	 clearall();
	    		 }
		     else{
	    		    layer.msg("修改成功");
	    		    parent.location.reload();
		     } 
		  /*    parent.window.location.href="${pageContext.request.contextPath}/adminAction_changeAdmin.action?empId="+$("#mId").val();   */
          /*  var index = parent.layer.getFrameIndex(window.name); //获取窗口索引  
           parent.layer.close(index); 
           parent.window.location.href=parent.window.location.href; */
		   
		 });
		}); 
	});
})
</script>
</html>
