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
<script src="${pageContext.request.contextPath }/js/macarons.js"
	type="text/javascript">
</script>	


</head>
<body>
 <div class="am-cf am-padding">
      <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">按医疗类型统计</strong> / <small>Statistic</small>

    </div>
    <hr/>
   <div  id="main" style="width: 100%;height:400px;">
   </div>
	
</div>
</body>
<script type="text/javascript">

var myChart = echarts.init(document.getElementById('main'),'macarons');

//指定图表的配置项和数据
option = {
		 title : {
		        text: "历年报销数据统计",
		        x:'center'
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
		                type: ['bar', 'line']
		            },
		            restore : {show: true},
		            saveAsImage : {show: true}
		        }
		  },
		  calculable : true,
		  xAxis: [{
	            'type': 'category',
	            'axisLabel': {
	                'interval': 0
	            },
	            'data': [],
	            splitLine: {
	                show: false
	            }
	       }],
	       yAxis: [{
	            type: 'value',
	            name: '报销总金额',
	        }],
	        series : [
	            {
	                name:'报销费用',
	                type:'bar',
	                stack: '总量',      
	                barWidth:30,
	                data:[],
	            },
	            {
	                name:'医疗费用',
	                type:'bar',
	                stack: '总量',
	                barWidth:30,
	                data:[],
	            }
	        ]
	};
   

// 使用刚指定的配置项和数据显示图表。

myChart.setOption(option);
myChart.showLoading(); 

 $.ajax({
          type : "post",
          async : true,            //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
          url : "${pageContext.request.contextPath}/expenseAction_statistic1.action",    //请求发送到TestServlet处
          data : {},
          dataType : "json",        //返回数据形式为json
          success : function(result) {
              //请求成功时执行该函数内容，result即为服务器返回的json对象
              if (result) {
                     myChart.hideLoading();    //隐藏加载动画
                     myChart.setOption({        //加载数据图表
                   	  title : {
             		        text: "历年报销数据统计",
             		        x:'center'
             		 },
             		 tooltip : {
             		        trigger: 'item',
             		        formatter: "{a} <br/>{b} : {c}元"
             		 },
             		 legend: {
             		        x : 'center',
             		        y : 'bottom',
             		        data:["报销费用","个人自付"],
             		 },
             		 toolbox: {
             		        show : true,
             		        feature : {
             		            mark : {show: true},
             		            dataView : {show: true, readOnly: false},
             		            magicType : {
             		                show: true,
             		                type: ['bar', 'line']
             		            },
             		            restore : {show: true},
             		            saveAsImage : {show: true}
             		        }
             		  },
             		  calculable : true,
             		  xAxis: [{
             	            'type': 'category',
             	            'axisLabel': {
             	                'interval': 0
             	            },
             	            'data':result.year,
             	            splitLine: {
             	                show: false
             	            }
             	       }],
             	       yAxis: [{
             	            type: 'value',
             	            name: '报销总金额',
             	        }],
             	        series : [
             	            {
             	                name:'报销费用',
             	                type:'bar',
             	                stack: '总量',      
             	                barWidth:30,
             	                data:result.expensePays,
             	                itemStyle : { normal: {label : {show: true}}},
             	            },
             	            {
             	                name:'个人自付',
             	                type:'bar',
             	                stack: '总量',
             	                barWidth:30,
             	                data:result.totals,
             	                itemStyle : { normal: {label : {show: true}}}, 
            
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
            



</script>

</html>