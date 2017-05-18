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


</head>
<body>
 <div class="am-cf am-padding">
      <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">提交报销</strong> / <small>Submit reimbursement</small></div>
    </div>

    <hr/>
   <div>
   <form id="from1">
		<table class="table-edit" width="80%" align="center"
			style="margin-top: 50px;">
			<tr>
			    <td>报销人学/工号</td>
				<td><input id="stuOrEmpId" class="easyui-combobox"
					name="报销人" /></td>
				<td>医疗类型</td>
				<td><select id="medicalType" class="easyui-combobox"
					name="医疗类型">
						<option value="一般门诊">一般门诊</option>
						<option value="住院">住院</option>
						<option value="特殊门诊">特殊门诊</option>
				</select></td>
				<td>就诊医院</td>
				<td><input id="hospId" class="easyui-combobox"
					name="就诊医院" />
				</td>
				<td>保健卡</td>
				<td><select id="healthCard" class="easyui-combobox"
					name="保健卡">
						<option value=true>有</option>
						<option value=false>无</option>
				</select></td>
			</tr>
		</table>
		<table id="medicines" class="table-edit" width="80%" align="center"
			style="margin-top: 50px;">
			<tr>
				<th style="width: 200px">药品名称</th>
				<th style="width: 100px">单价</th>
				<th style="width: 100px">数量</th>
				<th style="width: 100px">来源</th>
				<th><input type="button" value="添加" style="width: 100px" onclick="addmedicine()"></th>
			</tr>
			<tr>
				<td><center><input id="medicNum_1" class="easyui-combobox" name="药品名称" style="width: 200px" data-options="required:true"/></center></td>
				<td><center><input type="text" class="easyui-validatebox" id="medicUnitPrice_1" data-options="required:true"/></center></td>
				<td><center><input type="text"  class="easyui-validatebox" id="medicQuantity_1" data-options="required:true"/></center></td>
				<td><center>
						<input id="sourse_1" class="easyui-combobox" name="药品来源"
							data-options="
		valueField: 'value',
		textField: 'label',
		required:true,
		data: [{
			label: '校内医院',
			value: 5
		},{
			label: '校外一级医院',
			value: 1
		},{
			label: '校外二级医院',
			value: 2
		},{
			label: '校外三级医院',
			value: 3
		},{
			label: '异地医院',
			value: 4
		}]" />
					</center></td>
			</tr>
		</table>

		<table id="medicalitems" class="table-edit" width="80%" align="center"
			style="margin-top: 50px;">
			<tr>
				<th style="width: 200px">报销项名称</th>
				<th style="width: 100px">单价</th>
				<th style="width: 100px">数量</th>
				<th style="width: 300px"><input type="button" value="添加" style="width: 100px"  onclick="addmedicalitem()"></th>
			</tr>
			<tr>
				<td><center>
						<input id="medicalNum_1" class="easyui-combobox" name="报销项名称"
							style="width: 200px" data-options="required:true"/>
					
					</center></td>
				<td><center>
						<input type="text" class="easyui-validatebox" id="medicalUnitPrice_1" data-options="required:true"/>
					</center></td>
				<td><center>
						<input type="text" class="easyui-validatebox" id="medicalQuantity_1" data-options="required:true" />
					</center></td>
			</tr>
		</table>
		</form>
		<center><input type="button" class="layui-btn layui-btn-normal layui-btn-small " style="width: 100px;margin-top: 50px;margin-bottom: 50px;  background-color: #1E9FFF;" value="提交" onclick="add()"/></center>
	</div>
	
</body>
<script type="text/javascript">
   var countmedicine=1;
   var countmedicalitem=1;
   $("#hospId").combobox({
	   url:'${pageContext.request.contextPath}/hospitalAction_allhospitalinfo.action', 
	   panelHeight: 'auto',//自动高度适合
	   valueField:'hospId',   
	   textField:'hospName',
	   required: true,
	   });

   $("#stuOrEmpId").combobox({
	   url:'${pageContext.request.contextPath}/userAction_alluserinfo.action', 
	   panelHeight: 'auto',//自动高度适合
	   valueField:'stuOrEmpId',   
	   textField:'stuOrEmpId',
	   required: true,
	   });

   $("#medicalType").combobox({
	   panelHeight: 'auto',//自动高度适合
	   required: true,
	   });
   
   $("#healthCard").combobox({
	   panelHeight: 'auto',//自动高度适合
	   required: true,
	   });

   $("#sourse_1").combobox({
	   panelHeight: 'auto',//自动高度适合
	   required: true,
	   });

   $("#medicNum_1").combobox({
	   url:'${pageContext.request.contextPath}/medicineAction_allmedicine.action', 
	   panelHeight: 'auto',//自动高度适合
	   valueField:'medicNum',   
	   textField:'medicCname',
	   required: true,
	   });

   $("#medicalNum_1").combobox({
	   url:'${pageContext.request.contextPath}/medicalItemAction_allmedicalItem.action', 
	   panelHeight: 'auto',//自动高度适合
	   valueField:'medicalNum',   
	   textField:'medicalName',
	   required: true,
	   });

   function addmedicine() {
	   countmedicine++;
	   if(countmedicine>6){
		   layer.msg("单次报销药品不超过6条，请分次报销");
		   return false;
	   }
	   
	   var html='<tr><td><center><input id="medicNum_'+countmedicine+'\" class="easyui-combobox" data-options="required:true" name="药品名称" style="width: 200px"/></center></td><td><center><input type="text" class="easyui-validatebox" data-options="required:true" id="medicUnitPrice_'+countmedicine
	   +'\"/></center></td><td><center><input type="text" class="easyui-validatebox" id="medicQuantity_'+countmedicine+'\"/></center></td><td><center><input id="sourse_'+countmedicine
	   +'\" class="easyui-combobox" data-options="required:true" name="药品来源" /></center></td></tr>';
	   $("#medicines").append(html);
	   $("#medicNum_"+countmedicine).combobox({
		   url:'${pageContext.request.contextPath}/medicineAction_allmedicine.action', 
		   panelHeight: 'auto',//自动高度适合
		   valueField:'medicNum',   
		   textField:'medicCname',
		   required: true,
		});

	   $("#sourse_"+countmedicine).combobox({ 
		   panelHeight: 'auto',//自动高度适合
		   valueField:'value',   
		   textField:'label',
		   required: true,
		   data:[{
				label: '校内医院',
				value: 5
			},{
				label: '校外一级医院',
				value: 1
			},{
				label: '校外二级医院',
				value: 2
			},{
				label: '校外三级医院',
				value: 3
			},{
				label: '异地医院',
				value: 4
			}],
		});

	   $('#medicUnitPrice_'+countmedicine).validatebox({    
		    required: true,    
		});  
	   $('#medicQuantity_'+countmedicine).validatebox({    
		    required: true,    
		});
   }

   function addmedicalitem() {
	   countmedicalitem++;
	   if(countmedicalitem>6){
		   layer.msg("单次报销药品不超过6条，请分次报销");
		   return false;
	   }
	   
	   var html='<tr><td><center><input id="medicalNum_'+countmedicalitem+'\" class="easyui-combobox"  data-options="required:true" name="报销项名称" style="width: 200px"/></center></td><td><center><input type="text" class="easyui-validatebox" data-options="required:true" id="medicalUnitPrice_'+countmedicalitem
	   +'\"/></center></td><td><center><input type="text" class="easyui-validatebox" data-options="required:true" id="medicalQuantity_'+countmedicalitem+'\"/></center></td></tr>';
	   $("#medicalitems").append(html);
	   $("#medicalNum_"+countmedicalitem).combobox({
		   url:'${pageContext.request.contextPath}/medicalItemAction_allmedicalItem.action', 
		   panelHeight: 'auto',//自动高度适合
		   valueField:'medicalNum',   
		   textField:'medicalName',
		   required: true,
		});

	   $('#medicalUnitPrice_'+countmedicine).validatebox({    
		    required: true,    
		});  
	   $('#medicalQuantity_'+countmedicine).validatebox({    
		    required: true,    
		});	
   }


   function add() {
	   var v = $("#from1").form("validate"); 
	   if(v){
		   var data='{"stuOrEmpId":\"'+$("#stuOrEmpId").combobox("getValue")+'\","medicalTyp":\"'+$("#medicalType").combobox("getValue")+
		   '\","healthCard":\"'+$("#healthCard").combobox("getValue")+
		   '\","hospId":\"'+$("#hospId").combobox("getValue")+'\","countmedicine":\"'+
		   countmedicine+'\","countmedicalitem":\"'+countmedicalitem+'\","expensemedicines":[';
		   for(var i=0;i<countmedicine-1;i++){
			   data+='{"medicNum":\"'+$("#medicNum_"+(i+1)).combobox("getValue");
			   data+='\","medicUnitPrice":\"'+$("#medicUnitPrice_"+(i+1)).val();
			   data+='\","medicQuantity":\"'+$("#medicQuantity_"+(i+1)).val();
			   data+='\","sourse":\"'+$("#sourse_"+(i+1)).combobox("getValue")+'\"},';
		   }

		   data+='{"medicNum":\"'+$("#medicNum_"+countmedicine).combobox("getValue");
		   data+='\","medicUnitPrice":\"'+$("#medicUnitPrice_"+countmedicine).val();
		   data+='\","medicQuantity":\"'+$("#medicQuantity_"+countmedicine).val();
		   data+='\","sourse":\"'+$("#sourse_"+countmedicine).combobox("getValue")+'\"}';
		   data+='],';
		 

		   data+='"expensemedicalitems":[';
		   for(var i=0;i<countmedicalitem-1;i++){
			   data+='{"medicalNum":\"'+$("#medicalNum_"+(i+1)).combobox("getValue");
			   data+='\","medicalUnitPrice":\"'+$("#medicalUnitPrice_"+(i+1)).val();
			   data+='\","medicalQuantity":\"'+$("#medicalQuantity_"+(i+1)).val();
			   data+='\"},';
		   }
		   data+='{"medicalNum":\"'+$("#medicalNum_"+countmedicalitem).combobox("getValue");
		   data+='\","medicalUnitPrice":\"'+$("#medicalUnitPrice_"+countmedicalitem).val();
		   data+='\","medicalQuantity":\"'+$("#medicalQuantity_"+countmedicalitem).val();
		   data+='\"}';
		   data+=']';
		   data+='}';
		   var obj=$.parseJSON(data);
		   var url = "${pageContext.request.contextPath}/expenseAction_addExpense.action";
			$.post(url,obj,function(data){
				if(data == '1'){
					  layer.alert('报销信息添加成功', {
	            		    skin: 'layui-layer-lan',
	            		    title:"提示信息",
	                		closeBtn: 0
	            		    ,anim: 4 //动画类型
	            		  },function(){
	                		  window.location.href=window.location.href;
	                      });
				}else{
					 layer.alert('提交失败，同一报销项不能多次添加', {
	            		    skin: 'layui-layer-lan',
	            		    title:"提示信息",
	                		closeBtn: 0
	            		    ,anim: 4 //动画类型
	            		  },function(){
	                		  window.location.href=window.location.href;
	                      });
				}
			});
	   }
	   
	
}
</script>

</html>
