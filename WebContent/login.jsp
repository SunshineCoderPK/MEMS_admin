<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="UTF-8">
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<title>高校医疗报销系统_后台</title>

<link href="${pageContext.request.contextPath }/h-ui/css/H-ui.min.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath }/h-ui.admin/css/H-ui.login.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath }/h-ui.admin/css/style.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath }/lib/Hui-iconfont/1.0.8/iconfont.css" rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery-1.8.3.js"></script>
</head>

<body >
<input type="hidden" id="TenantId" name="TenantId" value="" />
<div class="header"></div>
<div class="loginWraper">
  <div class="loginBox">
    <form class="form form-horizontal" action="${pageContext.request.contextPath }/adminAction_login.action" method="post" id="loginform" >
      <div class="row cl">
        <label class="form-label col-xs-3"><i class="Hui-iconfont">&#xe60d;</i></label>
        <div class="formControls col-xs-8">
          <input id="loginform:id" name="empId" type="text" placeholder="账户" class="input-text size-L">
        </div>
      </div>
      <div class="row cl">
        <label class="form-label col-xs-3"><i class="Hui-iconfont">&#xe60e;</i></label>
        <div class="formControls col-xs-8">
          <input id="loginform:password" name="password" type="password" placeholder="密码" class="input-text size-L">
        </div>
      </div>
      <div class="row cl">
					<div class="formControls col-xs-8 col-xs-offset-3">
						<input class="input-text size-L" type="text" placeholder="验证码" name="checkcode" id="validate"
							onblur="if(this.value==''){this.value='验证码:'}"
							onclick="if(this.value=='验证码:'){this.value='';}" value="验证码:"
							style="width: 150px;"> 
							<img id="loginform:vCode"
							src="${pageContext.request.contextPath }/validatecode.jsp"
							style="vertical-align: bottom;" alt="验证码"
							onclick="javascript:document.getElementById('loginform:vCode').src='${pageContext.request.contextPath }/validatecode.jsp?'+Math.random();" />
						<a id="kanbuq" href="javascript:;" onclick="javascript:document.getElementById('loginform:vCode').src='${pageContext.request.contextPath }/validatecode.jsp?'+Math.random();">看不清，换一张</a>
					</div>
				</div>
      <div class="row cl">
        <div class="formControls col-xs-8 col-xs-offset-3">
          <label for="online">
            <input type="checkbox" name="online" id="online" value="">
            记住密码</label>
        </div>
      </div>
				<div>
					<font color="red"> <s:actionerror />
					</font>
				</div>
		<div class="row cl">
        <div class="formControls col-xs-8 col-xs-offset-3">
          <input  type="submit" class="btn btn-success radius size-L" value="&nbsp;登&nbsp;&nbsp;&nbsp;&nbsp;录&nbsp;" />
          <input id="reset" type="reset" class="btn btn-default radius size-L" value="&nbsp;取&nbsp;&nbsp;&nbsp;&nbsp;消&nbsp;"/>
        </div>
      </div>
    </form>
  </div>
</div>
<div class="footer">Copyright 高校医疗报销系统 by sunshine</div>
<script type="text/javascript" src="${pageContext.request.contextPath }/lib/jquery/1.9.1/jquery.min.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath }/h-ui/js/H-ui.min.js"></script>

</body>
</html>