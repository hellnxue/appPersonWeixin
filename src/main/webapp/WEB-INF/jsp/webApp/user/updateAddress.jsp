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
    <input type="text" class="inputtip" id="mobilePhone" value="${receivingAddrInfo.mobilePhone }" size="40" class="">
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
</div><div class="footer">
<div id="" class="am-navbar am-cf am-navbar-default am-no-layout" data-am-widget="navbar">
<ul class="am-navbar-nav am-cf am-avg-sm-5 fot_bg">
  <li class="footer01 cur"> <a href="${ctx}/webApp/index"> <span class="am-footer-ico"></span> <span class="am-navbar-label">首页</span></a></li>
  <li class="footer02"> <a href="${ctx}/webApp/empCheck"> <span class="am-footer-ico"></span> <span class="am-navbar-label">移动签到</span></a></li>
  <li class="footeradd"> <a> <span class="index-home-ico"><em></em></span></a></li>
  <li class="footer03"> <a href="${ctx}/webApp/msgs"> <span class="am-footer-ico"></span> <span class="am-navbar-label">消息</span></a></li>
  <li class="footer04"> <a href="${ctx}/webApp/user"> <span class="am-footer-ico"></span> <span class="am-navbar-label">我的</span></a></li>
</ul>
</div>
<div class="foot-home-over">
<div data-am-widget="slider" class="am-slider am-slider-default layer_list" data-am-slider='{&quot;animation&quot;:&quot;slide&quot;,&quot;slideshow&quot;:false}'>
  <ul style="margin-left:20px;">
    <li class="list01">
      <a href="${ctx}/webApp/tongxunlu"><dl class="icon01"><dt></dt><dd>通讯录</dd></dl></a>
    </li>
  </ul>
</div>
</div>
</div>
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
			 	
			  if(!this.isFormValid()){//表单验证状态
			   
			    return false;
			  }else{
				  if(handelsAre==""){
				 		alert("请选择所在地区！");
				 		return false;
				 	}
				    $.ajax({
						type:"post",
						url:"${ctx}/hrhelper-platform/receiveUpdate",
						data:{"receivingAddrId":${receivingAddrInfo.receivingAddrId},"userId":${receivingAddrInfo.userId},"receivingName":receivingName,"mobilePhone":mobilePhone,"detailedAddr":detailedAddr,"ischecked":isdefault,"isdefault":${receivingAddrInfo.isDefault},"area":area,"areaid":area_id},
						dataType:"json",
						async:false,
						success : function(data) {
							console.log(typeof data);
							if(data>0){
								alert("地址修改成功！");
								window.location.href="${ctx }/webApp/user/receiveAddress?param=onlyaddress";
							}else{
								alert("地址修改失败！");
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
					alert("地址删除成功！");
						window.location.href="${ctx }/webApp/user/receiveAddress?param=onlyaddress";
				}else{
					alert("地址修改失败！");
				}
	        });
	 });
});

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