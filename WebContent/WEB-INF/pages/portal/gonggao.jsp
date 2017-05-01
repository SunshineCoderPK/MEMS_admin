<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div style="padding: 10px">
	<table style="height: auto;" id="annocements">

	</table>
	<div id="announcement" >
	</div>
	<script type="text/javascript">
		$(function(){
			$("#annocements").datagrid({
				columns:[[//定义标题行所有的列
				          {field:'annId',title:'编号',width:100,align:'center'},
				          {field:'annTitle',title:'标题',width:500,align:'center'},
				          {field:'annContent',title:'内容',width:0,align:'center', hidden:true},
				          {field:'admininfo',title:'发送人',width:150,align:'center', formatter: function(value,row,index){
								if (row.admininfo){
									return row.admininfo.name;
								} else {
									return value;
								}
							},
						  },
				          {field:'publishTime',title:'发送日期',width:250,align:'center',}
				          ]],
			    url:'${pageContext.request.contextPath}/annocementAction_pageQuery.action', //指定URL地址，控件自动发送ajax请求获取数据	
				singleSelect:true,//是否可以单选
				pagination:true,//分页条
				pageList:[10,15,20],//分页条中的下拉框选项
			    rownumbers:true,
			    striped:true,
			    idField : 'annId',
			    onClickRow: function(index,row){
				       alert(row);
				       $("#announcement").window({
				    	   width:600,    
			    		    height:400,    
			    		    modal:true ,});
				      },
		    
			});
		});
	</script>
</div>