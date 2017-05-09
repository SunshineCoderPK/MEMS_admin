<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery-1.8.0.min.js"></script>
<!-- 导入easyui类库 -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui/ext/portal.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/css/default.css">	
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/layui/css/layui.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/layui/css/modules/layer/default/layer.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/css/userinfo.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/easyui/ext/jquery.portal.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/easyui/ext/jquery.cookie.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/easyui/locale/easyui-lang-zh_CN.js">
</script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/FormatDate.js">
</script>
<script type="text/javascript"
    src="${pageContext.request.contextPath }/js/layui/layui.js">
</script>
<script type="text/javascript"
    src="${pageContext.request.contextPath }/js/layui/lay/modules/layer.js">
</script>
<script type="text/javascript"
    src="${pageContext.request.contextPath }/js/ajaxfileupload.js">
</script>
</head>
<body>
	
	<div class="cztable">
		<center>
		<table width="96%" cellpadding="0" cellspacing="0">
        <tr>
            <td align="right" width="80">姓名：</td>
            <td>${admininfo.name }&nbsp;</td>
            <td align="right" width="90">身份证号码：</td>
            <td>${admininfo.idcard }&nbsp;</td>
            
            <td rowspan="6"><div align="center"><img id="pic_face" class="img" height="160" width="120" src="${admininfo.imgsrc}" style="padding:2px 2px 5px; border:1px #ddd solid;"></div>&nbsp;</td>
        </tr>
        <tr>
            <td align="right">性别：</td>     
            <td>${admininfo.sex?"女":"男" }&nbsp;</td>
            <td align="right">年龄：</td>
            <td>${(empty admininfo.age)?"":admininfo.age }&nbsp;</td>
        </tr>
        <tr>
            <td align="right">身份：</td>
            <td>管理员&nbsp;</td>
            <td align="right">工号：</td>
            <td>${admininfo.empId }&nbsp;</td>
        </tr>
        
        <tr>
            <td align="right">部门：</td>
            <td>${(admininfo.department eq null)?"":admininfo.department }&nbsp;</td>
            <td align="right">职位：</td>
            <td>${(admininfo.job eq null)?"":admininfo.job }&nbsp;</td>
        </tr>
        
        <tr>
            <td colspan="4" align="left">联系方式（如联系方式有变动请及时修改，以便能及时联系到你。谢谢！）</td>
            
        </tr>
        <tr class="end">
            <td align="right">邮箱：</td>
            <td>${(admininfo.email eq null)?"":admininfo.email }&nbsp;</td>
            <td align="right">联系方式：</td>
            <td>${(admininfo.phoneNo eq null)?"":admininfo.phoneNo }&nbsp;</td>
        <tr>
            <td align="right">联系地址：</td>
            <td colspan="4"></td>
        </tr> 
         <tr>
            <td colspan="5"align="left">备注</td>
            
        </tr>
        <tr align="center">
            <td colspan="9" height="60">
                ${(admininfo.remark eq null)?"":admininfo.remark }
            </td>
        </tr>           
    </table>
  </center>
</div>
<script type="text/javascript">

    var index;
	function changeinfo() {
		
		var html = '<div class=" layui-form change_info_form" ><label class="layui-form-label">年龄</label><div class="layui-input-block"><input type="text" id="userage" name="age" lay-verify="age" autocomplete="off" placeholder="请输入年龄" class="layui-input"></div><label class="layui-form-label">毕业年份</label><div class="layui-input-block"><input type="text" id="usergraduationYear" name="graduationYear" lay-verify="year" autocomplete="off" placeholder="请输入毕业年份" class="layui-input"></div><label class="layui-form-label">邮箱</label><div class="layui-input-block"><input type="text" id="useremail" name="email" lay-verify="email" autocomplete="off" placeholder="请输入邮箱" class="layui-input " ></div><label class="layui-form-label">联系方式</label><div class="layui-input-block"><input type="text" id="userphoneNo" name="phoneNo" lay-verify="phone" autocomplete="off" placeholder="请输入手机号" class="layui-input " ></div><div class="buttonbar layui-input-block" ><button class="layui-btn layui-btn-normal layui-btn-small " lay-submit lay-filter="formDemo">修改</button><button id="reset" class="layui-btn layui-btn-normal layui-btn-small" onclick="reset()">重置</button><button id="cancel" class="layui-btn layui-btn-normal layui-btn-small" onclick="cancel()">取消</button></div></div>'	
		
		
		index=layer.open({
			id:"infochange",
			type : 1,
			title : '个人信息修改',
			closeBtn : 0,
			shadeClose : false,
			scrollbar: false,
			area : [ '500px', '300px' ],
			anim :3,
			content : html,
		});

		layui.use(['form', 'layedit', 'laydate'], function(){  
			  var form = layui.form(); 
	          form.verify({
				age : function(value) {
					if (value!=""&&!(/^[1-9]\d{0,2}$/).test(value)||parseInt(value)> 120 || parseInt(value) < 0) {
						return '年龄在0-120之间';
					}
				},
				year : function(value) {
					if (value!=""&&!(/^[1-9]\d{3}$/).test(value)) {
						return '毕业年份必须为4位数字';
					}
				}
				,
				phone : function(value) {
					if (value!=""&&!(/^1[3|4|5|7|8]\d{9}$/).test(value)) {
						return '手机必须11位，只能是数字！';
					}
				}
				,
				email : function(value) {
					if (value!=""&&!(/^[a-z0-9._%-]+@([a-z0-9-]+\.)+[a-z]{2,4}$|^1[3|4|5|7|8]\d{9}$/).test(value)) {
						return '邮箱格式不对';
					}
				}
			});

	          
	       form.on('submit(formDemo)', function(data) {
	    	   $.post('${pageContext.request.contextPath}/userAction_changeinfo.action',data.field,function(res){
	    		     if(res=="failed"){
	    		    	 layer.msg("修改失败");
                        clearinfo();
		    		 }
	    		     else{
		    		    layer.msg("修改成功");
		    		    layer.close(index);
		    		    window.location.href=window.location.href;
	    		     } 
	    		 });
			}); 
		});
	}

	function clearinfo(){
		$("#userage").val("");
		$("#usergraduationYear").val("");
		$("#useremail").val("");
		$("#userphoneNo").val("");
	}

	function reset(){
		clearinfo();
	}
	
	function cancel() {
		layer.close(index);
	}

	function upload_image(){
		alert("1");
		 $.ajaxFileUpload
	     (
	         {
	             url:'${pageContext.request.contextPath}/uploadimageAction_uploadimg.action',//用于文件上传的服务器端请求地址
	             secureuri:false,//一般设置为false
	             fileElementId:'uploadimg',//文件上传空间的id属性  <input type="file" id="file" name="file" />
	             dataType: 'json',//返回值类型 一般设置为json
	             data : {
                     folder:"user",
                 },
	             success: function (data, status)  //服务器成功响应处理函数
	             {
	            	 if(data.data=="fail1"){
	                	 layer.msg("所选文件非图片格式");
		                 return false;
		             }
		             if(data.data=="fail2"){
		            	 layer.msg("你选择的图片错误或者该图片已经损坏！");
		            	 return false;
			         }
	                 //从服务器返回的json中取出message中的数据,其中message为在struts2中定义的成员变量
	                 $("#pic_face").attr("src",data.data);
	                 
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
</body>
</html>