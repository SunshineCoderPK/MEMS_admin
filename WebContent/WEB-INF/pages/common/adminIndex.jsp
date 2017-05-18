<%@page import="javax.security.auth.message.callback.PrivateKeyCallback.Request"%>
<%@page import="com.kaipan.mems.domain.Admininfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="Bookmark" href="/favicon.ico" >
<link rel="Shortcut Icon" href="/favicon.ico" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/h-ui/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/h-ui.admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/lib/Hui-iconfont/1.0.8/iconfont.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/h-ui.admin/skin/default/skin.css" id="skin" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/h-ui.admin/css/style.css" />

<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery-1.8.3.js"></script>
<title>高校医疗报销系统_后台</title>
</head>

<body>
<header class="navbar-wrapper">
	<div class="navbar navbar-fixed-top">
		<div class="container-fluid cl"> <a class="logo navbar-logo f-l mr-10 hidden-xs" >医疗报销系统后台</a> 
			
			<a aria-hidden="false" class="nav-toggle Hui-iconfont visible-xs" href="javascript:;">&#xe667;</a>
			<nav class="nav navbar-nav">
				<ul class="cl">
					<li class="dropDown dropDown_hover"><a href="javascript:;" class="dropDown_A"><i class="Hui-iconfont">&#xe600;</i> 新增 <i class="Hui-iconfont">&#xe6d5;</i></a>
						<ul class="dropDown-menu menu radius box-shadow">
							<li><a href="javascript:;" onclick="member_add('添加医疗项','${pageContext.request.contextPath }/page_medicalitem_addmeditem.action','','510')"><i class="Hui-iconfont">&#xe616;</i> 医疗项</a></li>
							<li><a href="javascript:;" onclick="member_add('添加药品','${pageContext.request.contextPath }/page_medicine_addmedicine.action','','510')"><i class="Hui-iconfont">&#xe616;</i> 药品</a></li>
							<li><a href="javascript:;" onclick="member_add('添加报销类型','${pageContext.request.contextPath }/page_expenseType_addexpensetype.action','800','390')"><i class="Hui-iconfont">&#xe616;</i> 报销类型</a></li>
							<li><a href="javascript:;" onclick="member_add('添加医院','${pageContext.request.contextPath }/page_hospital_addhospital.action','500','300')"><i class="Hui-iconfont">&#xe616;</i> 医院</a></li>
							
					</ul>
				</li>
			</ul>
		</nav>
			<nav id="Hui-userbar" class="nav navbar-nav navbar-userbar hidden-xs">
				<ul class="cl">
					<li>超级管理员</li>
					<li class="dropDown dropDown_hover">
					<%
			         Admininfo  admininfo=(Admininfo)request.getSession().getAttribute("loginAdmin");
			        %>
						<a href="#" class="dropDown_A"><%=admininfo.getName() %> <i class="Hui-iconfont">&#xe6d5;</i></a>
						<ul class="dropDown-menu menu radius box-shadow">
							<li><a href="#" onclick="logoutFun()">退出</a></li>
					</ul>
				</li>
					<!-- <li id="Hui-msg"> <a href="#" title="消息"><span class="badge badge-danger">1</span><i class="Hui-iconfont" style="font-size:18px">&#xe68a;</i></a> </li> -->
					<li id="Hui-skin" class="dropDown right dropDown_hover"> <a href="javascript:;" class="dropDown_A" title="换肤"><i class="Hui-iconfont" style="font-size:18px">&#xe62a;</i></a>
						<ul class="dropDown-menu menu radius box-shadow">
							<li><a href="javascript:;" data-val="default" title="默认（黑色）">默认（黑色）</a></li>
							<li><a href="javascript:;" data-val="blue" title="蓝色">蓝色</a></li>
							<li><a href="javascript:;" data-val="green" title="绿色">绿色</a></li>
							<li><a href="javascript:;" data-val="red" title="红色">红色</a></li>
							<li><a href="javascript:;" data-val="yellow" title="黄色">黄色</a></li>
							<li><a href="javascript:;" data-val="orange" title="橙色">橙色</a></li>
					</ul>
				</li>
			</ul>
		</nav>
	</div>
</div>
</header>
<aside class="Hui-aside">
	<div class="menu_dropdown bk_2">
		<dl id="menu-article">
			<dt><i class="Hui-iconfont">&#xe616;</i> 资讯管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
			<dd>
				<ul>
					<li><a data-href="${pageContext.request.contextPath }/page_admin_announcement.action" data-title="资讯列表" href="javascript:void(0)">资讯列表</a></li>
					<li><a data-href="${pageContext.request.contextPath }/page_admin_publishann.action" data-title="发布公告" href="javascript:void(0)">发布公告</a></li>
			</ul>
		</dd>
	</dl>
	<dl id="menu-article">
			<dt><i class="Hui-iconfont">&#xe60d;</i> 个人信息<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
			<dd>
				<ul>
					<li><a data-href="${pageContext.request.contextPath }/page_admin_myselfinfo.action" data-title="个人资料" href="javascript:void(0)">个人资料</a></li>
			</ul>
		</dd>
	</dl>
		<dl id="menu-picture">
			<dt><i class="Hui-iconfont">&#xe60d;</i> 用户管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
			<dd>
				<ul>
					<li><a data-href="${pageContext.request.contextPath }/page_admin_userlist.action" data-title="用户列表" href="javascript:void(0)">用户列表</a></li>
					<li><a data-href="${pageContext.request.contextPath }/page_admin_signupuser.action" data-title="注册用户" href="javascript:void(0)">注册用户</a></li>
			</ul>
		</dd>
	</dl>
		<dl id="menu-product">
			<dt><i class="Hui-iconfont">&#xe620;</i> 报销信息管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
			<dd>
				<ul>
					<li><a data-href="${pageContext.request.contextPath }/page_medicalitem_medicalitemlist.action" data-title="医疗项管理" href="javascript:void(0)">医疗项管理</a></li>
					<li><a data-href="${pageContext.request.contextPath }/page_medicine_medicinelist.action" data-title="药品管理" href="javascript:void(0)">药品管理</a></li>
					<li><a data-href="${pageContext.request.contextPath }/page_expenseType_expensetypelist.action" data-title="报销类型管理" href="javascript:void(0)">报销类型管理</a></li>
					<li><a data-href="${pageContext.request.contextPath }/page_hospital_hospitallist.action" data-title="医院管理" href="javascript:void(0)">医院管理</a></li>
			</ul>
		</dd>
	</dl>
		<dl id="menu-comments">
			<dt><i class="Hui-iconfont">&#xe616;</i> 报销业务<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
			<dd>
				<ul>
					<li><a data-href="${pageContext.request.contextPath }/page_expenses_addExpense.action" data-title="提交报销" href="javascript:;">提交报销</a></li>
					<li><a data-href="${pageContext.request.contextPath }/page_expense_checkexpenselist.action" data-title="报销审核" href="javascript:void(0)">报销审核</a></li>
			</ul>
		</dd>
	</dl>
		<dl id="menu-member">
			<dt><i class="Hui-iconfont">&#xe616;</i> 报销清单管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
			<dd>
				<ul>
					<li><a data-href="${pageContext.request.contextPath }/page_expense_expenselist.action" data-title="历史报销" href="javascript:;">历史报销</a></li>
					<li><a data-href="${pageContext.request.contextPath }/page_expense_delexpenselist.action" data-title="删除报销" href="javascript:;">删除报销</a></li>
<!-- 					<li><a data-href="member-del.html" data-title="年度报销" href="javascript:;">年度报销</a></li> -->
			</ul>
		</dd>
	</dl>
		<dl id="menu-tongji">
			<dt><i class="Hui-iconfont">&#xe61a;</i> 报销统计<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
			<dd>
				<ul>
				<li><a data-href="${pageContext.request.contextPath }/page_statistic_statistic1.action" data-title="历年报销数据" href="javascript:;">历年报销数据</a></li>
				<li><a data-href="${pageContext.request.contextPath }/page_statistic_statistic4.action" data-title="按医疗类型统计" href="javascript:;">按医疗类型统计</a></li>
				<li><a data-href="${pageContext.request.contextPath }/page_statistic_statistic2.action" data-title="按医院类型统计" href="javascript:;">按医院类型统计</a></li>
				<li><a data-href="${pageContext.request.contextPath }/page_statistic_statistic3.action" data-title="按人员类型统计" href="javascript:;">按人员类型统计</a></li>
			</ul>
		</dd>
	</dl>
<!-- 		<dl id="menu-system">
			<dt><i class="Hui-iconfont">&#xe62e;</i> 系统管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
			<dd>
				<ul>
					<li><a data-href="system-base.html" data-title="备份记录" href="javascript:void(0)">备份记录</a></li>
					<li><a data-href="system-category.html" data-title="数据备份" href="javascript:void(0)">数据备份</a></li>
					<li><a data-href="system-data.html" data-title="数据还原" href="javascript:void(0)">数据还原</a></li>
			</ul>
		</dd>
	</dl> -->
</div>
</aside>
<div class="dislpayArrow hidden-xs"><a class="pngfix" href="javascript:void(0);" onClick="displaynavbar(this)"></a></div>
<section class="Hui-article-box">
	<div id="Hui-tabNav" class="Hui-tabNav hidden-xs">
		<div class="Hui-tabNav-wp">
			<ul id="min_title_list" class="acrossTab cl">
				<li class="active">
					<span title="我的桌面" data-href="welcome.html">我的桌面</span>
					<em></em></li>
		</ul>
	</div>
		<div class="Hui-tabNav-more btn-group"><a id="js-tabNav-prev" class="btn radius btn-default size-S" href="javascript:;"><i class="Hui-iconfont">&#xe6d4;</i></a><a id="js-tabNav-next" class="btn radius btn-default size-S" href="javascript:;"><i class="Hui-iconfont">&#xe6d7;</i></a></div>
</div>
	<div id="iframe_box" class="Hui-article">
		<div class="show_iframe">
			<div style="display:none" class="loading"></div>
			<iframe scrolling="yes" frameborder="0" src="welcome.html"></iframe>
	</div>
</div>
</section>

<div class="contextMenu" id="Huiadminmenu">
	<ul>
		<li id="closethis">关闭当前 </li>
		<li id="closeall">关闭全部 </li>
</ul>
</div>
<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="${pageContext.request.contextPath }/lib/jquery/1.9.1/jquery.min.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath }/lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/h-ui.admin/js/H-ui.admin.js"></script>
<!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="${pageContext.request.contextPath }/lib/jquery.contextmenu/jquery.contextmenu.r2.js"></script>
<script type="text/javascript">
$(function(){
	/*$("#min_title_list li").contextMenu('Huiadminmenu', {
		bindings: {
			'closethis': function(t) {
				console.log(t);
				if(t.find("i")){
					t.find("i").trigger("click");
				}		
			},
			'closeall': function(t) {
				alert('Trigger was '+t.id+'\nAction was Email');
			},
		}
	});*/
});
/*个人信息*/
function myselfinfo(){
	layer.open({
		type: 1,
		area: ['300px','200px'],
		fix: false, //不固定
		maxmin: true,
		shade:0.4,
		title: '查看信息',
		content: '<div>管理员信息</div>'
	});
}

/*资讯-添加*/
function article_add(title,url){
	var index = layer.open({
		type: 2,
		title: title,
		content: url
	});
	layer.full(index);
}
/*图片-添加*/
function picture_add(title,url){
	var index = layer.open({
		type: 2,
		title: title,
		content: url
	});
	layer.full(index);
}
/*产品-添加*/
function product_add(title,url){
	var index = layer.open({
		type: 2,
		title: title,
		content: url
	});
	layer.full(index);
}
/*-添加*/
function member_add(title,url,w,h){
	layer_show(title,url,w,h);
}

/*用户-退出*/
function logoutFun() {
	layer.msg('确定退出系统？', {
		  time: 0 //不自动关闭
		  ,btn: [' 退   出    ', '再看看']
		  ,yes: function(index){
			  location.href = '${pageContext.request.contextPath }/adminAction_logout';
		  }
		});
}


</script> 

</body>
</html>