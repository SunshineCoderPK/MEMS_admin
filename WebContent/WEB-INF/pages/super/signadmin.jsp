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


  <link rel="stylesheet" href="css/amazeui.min.css"/>
  <link rel="stylesheet" href="css/admin.css">
  
  <script type="text/javascript" src="assets/js/jquery.min.js"></script>
<script type="text/javascript" src="assets/js/amazeui.min.js"></script>

</head>
<body>
<!-- content start -->
  <div class="admin-content">
    <div class="am-cf am-padding">
      <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">个人资料</strong> / <small>Personal information</small></div>
    </div>

    <hr/>

    <div class="am-g">

      <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8">
        <div class="am-panel am-panel-default">
          <div class="am-panel-bd">
            <div class="am-g">
              <div class="am-u-md-4" style="width:100%">
                <center><img class="am-img-circle am-img-thumbnail" src="/img/user_default.png" alt="" style="width: 130px;height: 170px;"/></center>
              </div>
              <div class="am-u-md-8" style="width:100%">
                <center><form class="am-form">
                  <div class="am-form-group">
                    <input type="file" id="user-pic" style="margin-left: 70px;margin-bottom: 20px;margin-top: 20px">
                    <button type="button" style="width: 130px; " class="am-btn am-btn-primary am-btn-xs">保存</button>
                  </div>
                </form>
                </center>
              </div>
            </div>
          </div>
        </div>

        

      </div>

      <div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4">
        <form class="am-form am-form-horizontal">
          <div class="am-form-group">
            <label for="user-name" class="am-u-sm-3 am-form-label">姓名 / Name</label>
            <div class="am-u-sm-9">
              <input type="text" id="user-name" placeholder="姓名 / Name">
            </div>
          </div>
       
       
          <div class="am-form-group">
            <label for="user-name" class="am-u-sm-3 am-form-label">工号 / Id</label>
            <div class="am-u-sm-9">
              <input type="text" id="user-empId" placeholder="工号 / Id">
            </div>
          </div>
          
          <div class="am-form-group">
            <label for="user-name" class="am-u-sm-3 am-form-label">身份证号 / IdCard</label>
            <div class="am-u-sm-9">
              <input type="text" id="user-IdCard" placeholder="身份证号 / IdCard">
            </div>
          </div>
          
           <div class="am-form-group">
            <label for="user-QQ" class="am-u-sm-3 am-form-label">年龄</label>
            <div class="am-u-sm-9">
              <input type="text" id="user-QQ" placeholder="输入你的年龄">
            </div>
          </div>
          
          <div class="am-form-group">
            <label for="user-QQ" class="am-u-sm-3 am-form-label">性别</label>
            <div class="am-u-sm-9">
              <select>
              <option>男</option>
              <option>女</option>
              </select>
            </div>
          </div>

          <div class="am-form-group">
            <label for="user-email" class="am-u-sm-3 am-form-label">电子邮件 / Email</label>
            <div class="am-u-sm-9">
              <input type="email" id="user-email" placeholder="输入你的电子邮件 / Email">
            </div>
          </div>

          <div class="am-form-group">
            <label for="user-phone" class="am-u-sm-3 am-form-label">电话 / Telephone</label>
            <div class="am-u-sm-9">
              <input type="email" id="user-phone" placeholder="输入你的电话号码 / Telephone">
            </div>
          </div>

          <div class="am-form-group">
            <label for="user-QQ" class="am-u-sm-3 am-form-label">部门</label>
            <div class="am-u-sm-9">
              <input type="email" id="user-QQ" >
            </div>
          </div>
          
         
          

          <div class="am-form-group">
            <label for="user-weibo" class="am-u-sm-3 am-form-label">职位</label>
            <div class="am-u-sm-9">
              <input type="email" id="user-weibo" >
            </div>
          </div>

          <div class="am-form-group">
            <label for="user-intro" class="am-u-sm-3 am-form-label">备注 / Intro</label>
            <div class="am-u-sm-9">
              <textarea class="" rows="5" id="user-intro" placeholder="备注信息"></textarea>
              <small>250字以内写出备注信息...</small>
            </div>
          </div>

          <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">
              <button type="button" class="am-btn am-btn-primary">保存修改</button>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
  <!-- content end -->
</body>
</html>