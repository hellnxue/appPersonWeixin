<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<!-- 设置密码 -->
<es:webAppNewHeader title="体检预约" description="智阳网络技术" keywords="智阳网络技术"/>
<header class="am-header am-header-default am-no-layout" data-am-widget="header">
<div class="am-titlebar-left"> <a class="bak_ico" title="返回" href="javascript:history.go(-1)"><em></em></a> </div>
  <h1 class="am-header-title">新建收货地址</h1>
 <div class="am-titlebar-right"> <a title="" class="home_ico" href="${ctx}/webApp/index"><em></em></a> </div>
</header>
<body style="background-color: white">
 <form method="post" id="form2"  class="am-form" >
 <div class="add-address-edit">
  <ul class="am-list am-list-static am-list-border">
    <!-- 隐藏域 -->
    <input id="province-value" type="hidden" value=""/>
    <input id="city-value" type="hidden" value=""/>
    <input id="area-value" type="hidden" value=""/>
    <input id="load-value" type="hidden" value="">
    <input id="province-id" type="hidden" value=""/>
    <input id="city-id" type="hidden" value=""/>
    <input id="area-id" type="hidden" value=""/>
     <input id="load-id" type="hidden" value="">
     
  	<li><label>收件人<i style="color:red">*</i></label>
  	<input type="text" size="40"  class="inputtip" id="receivingName" pattern="^.{2,25}$" placeholder="长度不超过25个字符" data-validation-message="收货人姓名应为2-25个字符，一个汉字为两个字符" required>
  	</li>
  	
    <li><label>联系方式</label>
    <input type="text" class="inputtip" id="mobilePhone" pattern="^1((3|5|8){1}\d{1}|70)\d{8}$" size="40" placeholder="请输入手机号码" data-validation-message="手机号码格式不正确"  required>
    </li>
    
    <li class="address-choose"><span class="am-fr"><em class="am-icon-angle-right"></em>
    </span><label>所在地区<i style="color:red">*</i></label><b class="address-view"><span></span> <span></span> <span></span></b></span>
    </li>
    
    <li><label>详细地址<i style="color:red">*</i></label>
    <!-- <input type="text" class="inputtip" id="detailedAddr" size="40" placeholder="建议您如实填写详细收货地址，例如街道名称，门牌号码，楼层和房间号等信息" required> -->
       <textarea disabled="disabled" class="js-pattern-detailAddress" class="inputtip" id="detailedAddr"  placeholder="建议您如实填写详细收货地址，例如街道名称，门牌号码，楼层和房间号等信息"  cols="100" data-validation-message="5-120个字符，一个汉字为两个字符" required></textarea>
    </li>
    
    <li>设为默认地址 <input type="checkbox" class="" id="ischecked"></li>
    
  </ul>
</div>
<div class="btns am-g am-text-center">

  <input type="submit" class="am-btn am-btn-primary am-radius blue_btn am-radius am-btn-block" id="doc-confirm-toggle" value="提 交">

</div>
 </form>
<div class="am-modal am-modal-alert" tabindex="-1" id="my-alert">
  <div class="am-modal-dialog">
    <div class="am-modal-hd">收货地址添加成功！</div>
    <div class="am-modal-footer">
      <span class="am-modal-btn" data-am-modal-confirm>确定</span>
    </div>
  </div>
</div>
<div class="footer">
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
<script src="${ctx}/static/assets/js/amazeui.js"></script> 
<script src="${ctx}/static/assets/js/int.web.js"></script> 
<script src="${ctx}/static/assets/js/jquery.transit.js"></script> 
<script src="${ctx}/static/assets/js/int.com.js" type="text/javascript"></script>
<script src="${ctx}/static/assets/js/int.addresschoose.js"></script> 
<script>
var ctx="${ctx}";
$(function() {
	$("#btn").on("click",function(){
		 $("#hello").prop("disabled","disabled");
		
	});
	$("#btn1").on("click",function(){
		 $("#hello").removeProp("disabled");
		
	});
	$('#form2').validator({
		//自定义验证
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
			 			receivingName:receivingName,
			 			mobilePhone:mobilePhone,
			 			detailedAddr:detailedAddr,
			 			isDefault:isdefault,
			 			area:area,
			 			areaIds:area_id
			 	};
			 	
			 	var json=JSON.stringify(obj);
			 	
			  if(!this.isFormValid()){//表单验证状态
			    return false;
			  }else{
				  if(handelsAre==""){
				 		alert("请选择所在地区！");
				 		return false;
				 	}
					$("#doc-confirm-toggle").prop("disabled","disabled");  
				     $.ajax({
						type:"post",
						contentType : "application/json",
						url:"${ctx}/hrhelper-platform/receiveAdd",
						data:json,
						dataType:"json",
						async:false,
						success : function(data) {
							console.log(typeof data);
							if(data>0){
								$("#doc-confirm-toggle").removeProp("disabled");  
								tip("收货地址添加成功！","${ctx }/webApp/user/receiveAddress?param=onlyaddress");
							}else{
								tip("收货地址添加失败！");
							}
						}
					}); 
				    return false;
			  }
		}
	  });
	
});
//窗口提示
function tip(msg,url){
	$("#my-alert").find(".am-modal-hd").html(msg);
	if(arguments.length==1){
		$("#my-alert").modal();
	}else{
		$("#my-alert").modal({
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
    	<ul class="am-list am-list-static am-list-border static-province" >
            <li><a data-value="1">北京</a></li>
            <li><a data-value="2">上海</a></li>
            <li><a data-value="3">天津</a></li>
            <li><a data-value="4">重庆</a></li>
            <li><a data-value="5">河北</a></li>
            <li><a data-value="6">山西</a></li>
            <li><a data-value="7">河南</a></li>
            <li><a data-value="8">辽宁</a></li>
            <li><a data-value="9">吉林</a></li>
            <li><a data-value="10">黑龙江</a></li>
            <li><a data-value="11">内蒙古</a></li>
            <li><a data-value="12">江苏</a></li>
            <li><a data-value="13">山东</a></li>
            <li><a data-value="14">安徽</a></li>
            <li><a data-value="15">浙江</a></li>
            <li><a data-value="16">福建</a></li>
            <li><a data-value="17">湖北</a></li>
            <li><a data-value="18">湖南</a></li>
            <li><a data-value="19">广东</a></li>
            <li><a data-value="20">广西</a></li>
            <li><a data-value="21">江西</a></li>
            <li><a data-value="22">四川</a></li>
            <li><a data-value="23">海南</a></li>
            <li><a data-value="24">贵州</a></li>
            <li><a data-value="25">云南</a></li>
            <li><a data-value="26">西藏</a></li>
            <li><a data-value="27">陕西</a></li>
            <li><a data-value="28">甘肃</a></li>
            <li><a data-value="29">青海</a></li>
            <li><a data-value="30">宁夏</a></li>
            <li><a data-value="31">新疆</a></li>
            <li><a data-value="32">台湾</a></li>
            <li><a data-value="42">香港</a></li>
            <li><a data-value="43">澳门</a></li>
            <li><a data-value="84">钓鱼岛</a></li>
        </ul>
        <ul class="am-list am-list-static am-list-border none static-city" ></ul>
        <ul class="am-list am-list-static am-list-border none static-area" ></ul>
        <ul class="am-list am-list-static am-list-border none static-load"></ul>
    </div>
</div>
</body>
</html>