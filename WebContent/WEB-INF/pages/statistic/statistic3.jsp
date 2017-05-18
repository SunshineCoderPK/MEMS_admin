<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- 导入jquery核心类库 -->
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery-1.8.3.js"></script>
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
	href="${pageContext.request.contextPath }/css/addexpense.css">
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
<script src="${pageContext.request.contextPath }/js/layui/layui.js"
	type="text/javascript">
</script>	
<script src="${pageContext.request.contextPath }/js/layui/lay/modules/layer.js"
	type="text/javascript">
</script>	
<script src="${pageContext.request.contextPath }/js/echarts.js"
	type="text/javascript">
</script>	


</head>
<body>
 <div class="am-cf am-padding">
      <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">按人员类型统计</strong> / <small>Statistic by usertype</small>
      <div style="float: right;"><label>年度</label>
      <input id="year" class="easyui-combobox" style="width: 100px"
					name="年份" /></div>
      </div>
    </div>
    <hr/>
   <div  id="main" style="width: 100%;height:400px;">
   </div>
	
</body>
<script type="text/javascript">
var myChart = echarts.init(document.getElementById('main'));

//指定图表的配置项和数据
option = {
    title : {
        text: "",
        subtext: '南丁格尔玫瑰图',
        x:'center'
    },
    tooltip : {
        trigger: 'item',
        formatter: "{a} <br/>{b} : {c} ({d}%)"
    },
    legend: {
        x : 'center',
        y : 'bottom',
        data:[]
    },
    toolbox: {
        show : true,
        feature : {
            mark : {show: true},
            dataView : {show: true, readOnly: false},
            magicType : {
                show: true,
                type: ['pie', 'funnel']
            },
            restore : {show: true},
            saveAsImage : {show: true}
        }
    },
    calculable : true,
    series : [
        {
            name:'半径模式',
            type:'pie',
            radius : [30, 110],
            center : ['50%', '50%'],
            roseType : 'radius',
            data:[]
        },
    ]
};

// 使用刚指定的配置项和数据显示图表。
myChart.setOption(option);

myChart.showLoading();    //数据加载完之前先显示一段简单的loading动画

$("#year").combobox({
	   url:'${pageContext.request.contextPath}/expenseAction_allyear.action', 
	   panelHeight: 'auto',//自动高度适合
	   valueField:'year',   
	   textField:'year',
	   onLoadSuccess: function () { //加载完成后,设置选中第一项
           var val = $(this).combobox("getData");
           for (var item in val[0]) {
               if (item == "year") {
                   $(this).combobox("select", val[0][item]);
               }
           }
       },
       onChange:function(){  
           var year=$("#year").combobox("getValue");
           $.ajax({
               type : "post",
               async : true,            //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
               url : "${pageContext.request.contextPath}/expenseAction_statistic3.action",    //请求发送到TestServlet处
               data : {"year":year},
               dataType : "json",        //返回数据形式为json
               success : function(result) {
                   //请求成功时执行该函数内容，result即为服务器返回的json对象
                   if (result) {
                          myChart.hideLoading();    //隐藏加载动画
                          myChart.setOption({        //加载数据图表
                        	  title : {
                        	        text: result.title,
                        	        subtext: '南丁格尔玫瑰图',
                        	        x:'center'
                        	    },
                        	    tooltip : {
                        	        trigger: 'item',
                        	        formatter: "{a} <br/>{b} : {c}元 ({d}%)"
                        	    },
                        	    legend: {
                        	        x : 'center',
                        	        y : 'bottom',
                        	        data:result.categories,
                        	    },
                        	    toolbox: {
                        	        show : true,
                        	        feature : {
                        	            mark : {show: true},
                        	            dataView : {show: true, readOnly: false},
                        	            magicType : {
                        	                show: true,
                        	                type: ['pie', 'funnel']
                        	            },
                        	            restore : {show: true},
                        	            saveAsImage : {show: true}
                        	        }
                        	    },
                        	    calculable : true,
                        	    series : [
                        	        {
                        	            name:'半径模式',
                        	            type:'pie',
                        	            radius : [30, 110],
                        	            center : ['50%', '50%'],
                        	            roseType : 'radius',
                        	            data:result.sourse,
                        	        },
                        	    ]
                          });
                          
                   }
               
              },

               error : function(errorMsg) {
                   //请求失败时执行该函数
               alert("图表请求数据失败!");
               myChart.hideLoading();
               }
          })
       }
            
 });



</script>

</html>
