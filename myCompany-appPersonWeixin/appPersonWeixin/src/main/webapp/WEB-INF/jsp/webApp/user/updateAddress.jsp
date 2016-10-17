<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<!-- 设置密码 -->
<es:webAppNewHeader title="体检预约" description="智阳网络技术" keywords="智阳网络技术"/>
<header class="am-header am-header-default am-no-layout" data-am-widget="header">
<div class="am-titlebar-left"> <a class="bak_ico" title="返回" href="javascript:history.go(-1)"><em></em></a> </div>
  <h1 class="am-header-title">修改收货地址</h1>
 <div class="am-titlebar-right"> <a title="" class="home_ico" href="${ctx}/webApp/index"><em></em></a> </div>
</header>
<body style="background-color: white">
 <form method="post" id="form2"  class="am-form" >
 <div class="add-address-edit">
  <ul class="am-list am-list-static am-list-border">
    <input id="province-value" type="hidden" value=""/>
    <input id="city-value" type="hidden" value=""/>
    <input id="area-value" type="hidden" value=""/>
    <input id="load-value" type="hidden" value="">
    <input id="province-id" type="hidden" value=""/>
    <input id="city-id" type="hidden" value=""/>
    <input id="area-id" type="hidden" value=""/>
     <input id="load-id" type="hidden" value="">
     <input id="receivingAddrId" type="hidden" value="${receivingAddrInfo.receivingAddrId }">
     
  	<li><label>收件人<i style="color:red">*</i></label>
  	<input type="text" size="40"  class="inputtip" id="receivingName" value="${receivingAddrInfo.receivingName }" pattern="^.{2,25}$" placeholder="长度不超过25个字符" data-validation-message="收货人姓名应为2-25个字符，一个汉字为两个字符" required>
  	</li>
  	
    <li><label>联系方式</label>
    <input type="text" class="inputtip" id="mobilePhone" value="${receivingAddrInfo.mobilePhone}" pattern="^1((3|5|8){1}\d{1}|70)\d{8}$" size="40" placeholder="请输入手机号码" data-validation-message="手机号码格式不正确"  required>
    </li>
    
    <li class="address-choose"><span class="am-fr"><em class="am-icon-angle-right"></em>
    </span><label>所在地区<i style="color:red">*</i></label><b class="address-view"><span id="p1"></span> <span id="p2"></span> <span id="p3"></span>&nbsp;<span id="p4"></span></b></span>
    </li>
    
    <li><label>详细地址<i style="color:red">*</i></label>
    <!-- <input type="text" class="inputtip" id="detailedAddr" size="40" placeholder="建议您如实填写详细收货地址，例如街道名称，门牌号码，楼层和房间号等信息" required> -->
       <textarea  class="inputtip" id="detailedAddr"class="js-pattern-detailAddress" placeholder="建议您如实填写详细收货地址，例如街道名称，门牌号码，楼层和房间号等信息"  cols="100" data-validation-message="5-120个字符，一个汉字为两个字符" required>${receivingAddrInfo.detailedAddr }</textarea>
    </li>
    
    <li>设为默认地址 <input type="checkbox" class="" id="ischecked"></li>
    
    
  </ul>
</div>
<div class="add-address-edit">
  <ul class="am-list am-list-static am-list-border">
  <li class="am-text-danger" data-am-modal="{target: '#my-alert'}">删除收货地址 </li>
  </ul>
</div>

<div class="btns am-g am-text-center"><input type="submit" class="am-btn am-btn-primary am-radius blue_btn am-radius am-btn-block am-margin-top-xl" id="doc-confirm-toggle" value="提 交"></div>
</form>
<div class="am-modal am-modal-alert" tabindex="-1" id="my-alertsuc">
  <div class="am-modal-dialog">
    <div class="am-modal-hd">收货地址修改成功！</div>
    <div class="am-modal-footer">
      <span class="am-modal-btn" data-am-modal-confirm>确定</span>
    </div>
  </div>
</div>
<div class="am-modal am-modal-alert" tabindex="-1" id="my-alert">
  <div class="am-modal-dialog" style="padding:0;">
    <div class="am-modal-hd">&nbsp;</div>
    <div class="am-modal-bd">
      <p>确定删除收货地址吗？</p>
      <p>&nbsp;</p>
    </div>
    <div class="am-modal-footer">
      <span class="am-modal-btn" id="delete">删除</span>
      <span class="am-modal-btn">取消</span>
    </div>
  </div>
</div>
<es:webAppNewFooter/>
<script src="${ctx}/static/assets/js/jquery.min.js"></script> 
<script src="${ctx}/static/assets/js/int.web.js"></script> 
<script src="${ctx}/static/assets/js/amazeui.js"></script> 
<script src="${ctx}/static/assets/js/jquery.transit.js"></script> 
<script src="${ctx}/static/assets/js/int.com.js" type="text/javascript"></script>
<script src="${ctx}/static/assets/js/int.addresschoose.js"></script> 
<script>
var ctx="${ctx}";

$(function() {
	var areaIds="${receivingAddrInfo.areaIds}";
	var areas="${receivingAddrInfo.area}";
	var isdefault=${receivingAddrInfo.isDefault};
	var areaIdsarray=areaIds.split(",");
	var areaarray=areas.split("/");
	$("#province-value").val(areaarray[0]);
	$("#city-value").val(areaarray[1]);
	$("#area-value").val(areaarray[2]);
	$("#load-value").val(areaarray[3]);
	
	$("#p1").html(areaarray[0]);
	$("#p2").html(areaarray[1]);
	$("#p3").html(areaarray[2]);
	$("#p4").html(areaarray[3]);
	
	$("#province-id").val(areaIdsarray[0]);
	$("#city-id").val(areaIdsarray[1]);
	$("#area-id").val(areaIdsarray[2]);
	$("#load-id").val(areaIdsarray[3]);
	
	if(isdefault){
		$("#ischecked").attr("checked",true);
		$("#ischecked").attr("disabled","disabled");
	}
	
	
	$('#form2').validator({
	    validate: function(validity) {
		    
			var $field=$(validity.field);
			
			 //验证不通过时
			if(!validity.valid){
			 
				  $field.next("span").html("").remove();
				  $field.after("<span style='color:red'>"+$field.data('validationMessage')+"</span>");
			}
		
	    },
		//验证通过时
		 onValid: function(validity) {
			  $(validity.field).next("span").html("").remove();
	    },
	   
	   // 验证通过时添加到域上的 class
       validClass: '',
       
       patterns: {
       	
 		   detailAddress:/^[\s\S]{5,120}$/
 		   
 	   },
	    
	   submit:function(){
			 var receivingName=$("#receivingName").val();
		 	 var mobilePhone=$("#mobilePhone").val();
		 	 var detailedAddr=$("#detailedAddr").val();
		 	 var isdefault=$("#ischecked").is(":checked")?1:0;
		 	 var area=$("#province-value").val()+"/"+$("#city-value").val()+"/"+$("#area-value").val()+"/"+$("#load-value").val();
		 	 var area_id=$("#province-id").val()+","+$("#city-id").val()+","+$("#area-id").val()+","+$("#load-id").val();
		 	 console.log("area="+area);
		 	 var handelsAre=area.replace("///","");
		 	 var obj={
		 			receivingAddrId:"${receivingAddrInfo.receivingAddrId}",
		 			receivingName:receivingName,
		 			mobilePhone:mobilePhone,
		 			detailedAddr:detailedAddr,
		 			isDefault:"${receivingAddrInfo.isDefault}",
		 			area:area,
		 			areaIds:area_id,
		 			isChecked:isdefault
		 	 };
		 	
		 	 var json=JSON.stringify(obj);	
			  if(!this.isFormValid()){//表单验证状态
			    return false;
			  }else{
				  if(handelsAre==""){
						tip("请选择所在地区！");
				 		return false;
				 	}
				    $.ajax({
						type:"post",
						contentType : "application/json",
						url:"${ctx}/hrhelper-platform/receiveUpdate",
						data:json,
						dataType:"json",
						async:false,
						success : function(data) {
							console.log(typeof data);
							if(data>0){
								
								tip("收货地址修改成功！","${ctx }/webApp/user/receiveAddress?param=onlyaddress");
							}else{
								tip("收货地址修改失败！");
							}
						}
						
					});
				    return false;
			  }
		}
	  });
	
	//删除地址
	 $("#delete").on("click",function(){
		 $.getJSON("${ctx}/hrhelper-platform/receiveDelete", {
			 receivingAddrId: "${receivingAddrInfo.receivingAddrId}"
	        }, function (data) {
	        	if(data>0){
						
					tip("收货地址删除成功！","${ctx }/webApp/user/receiveAddress?param=onlyaddress");
						
				}else{
					tip("收货地址删除失败！");
				}
	        });
	 });
});

//窗口提示
function tip(msg,url){
	$("#my-alertsuc").find(".am-modal-hd").html(msg);
	if(arguments.length==1){
		$("#my-alertsuc").modal();
	}else{
		$("#my-alertsuc").modal({
			 onConfirm: function(e) {
				 window.location.href=url;
			      }
			});
	};
	
};
</script> 
<div class="address-mask none"></div>
<div class="address_selected none">
	<div class="title">
    	 <span class="title-back address-choose-close"><i></i></span><span class="title-name">配送至</span>
    </div>
    <div class="address_list">
    	<ul class="am-list am-list-static am-list-border static-province" ></ul>
        <ul class="am-list am-list-static am-list-border none static-city" ></ul>
        <ul class="am-list am-list-static am-list-border none static-area" ></ul>
        <ul class="am-list am-list-static am-list-border none static-load"></ul>
    </div>
</div>
</body>
</html>