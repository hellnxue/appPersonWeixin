<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<es:webAppNewHeader title="雇员激活" description="智阳网络技术" keywords="智阳网络技术"/>
<header class="am-header am-header-default am-no-layout" data-am-widget="header">
  <div class="am-titlebar-left"> <a class="bak_ico" title="返回" href="javascript:history.go(-1)"><em></em></a> </div>
  <h1 class="am-header-title">密码设置</h1>
  <div class="am-titlebar-right"> <a title="" class="home_ico" href="${ctx}/webApp/index"><em></em></a> </div>
</header>
<div class="vip-center_form">
	<div class="yz_step">
    	<span>验证账户信息</span><span class="cur">登录密码设置</span>
        <p class="line am-cf"><em class="am-fl"></em><em class="am-fr cur"></em></p>
    </div>
  <div class="input_list" id="widget-list">
  <form id="form1" name="form1" enctype="multipart/form-data" class="form-horizontal" action="${ctx }/webApp/anon/accountActivate2" method="post">
    <ul class="am-list m-widget-list" style="transition-timing-function: cubic-bezier(0.1, 0.57, 0.1, 1); transition-duration: 0ms; transform: translate(0px, 0px) translateZ(0px);">
      <li>
        <div class="lines"><span>
          <input  id="new_password" name="new_password" class="am-form-field am-input-lg" type="password" placeholder="密码为6-18位字符,建议为字母和数字的组合">
          </span></div>
      </li>
      <span id="errorM1" style="color:red"></span>
     
      <li>
        <div class="lines"><span>
          <input id="a_new_password" name="a_new_password" class="am-form-field am-input-lg" type="password" placeholder="请输入确认密码">
          </span></div>
      </li>
    </ul>
    <span id="errorM2" style="color:red"></span>
    <p align="center" style="padding:0 2rem;">
      <input id="activeSubmit" name="activeSubmit" type="button" class="am-btn am-btn-primary am-radius am-btn-block am-btn-lg" value="完 成">
    </p>
  </form>    
  </div>
</div>

<es:webAppNewFooter/>
<script src="${ctx}/static/assets/js/rulesValidation.js"></script> 
<!--在这里编写你的代码-->
<script type="text/javascript">
$(function() {
	
	var statu="${tip}";
	console.log("status=="+statu);
	if(statu=="true"){
		alert("恭喜您，账号激活成功！");
		location.replace("${ctx}/webApp/logout");
	}else if(statu=="false"){
		
		alert("账号激活失败！");
	}
	
	
	
	$("#new_password").on("focus",function(){
		$("#errorM1").html("");
		$("#errorM2").html("");
	});
	$("#a_new_password").on("focus",function(){
		$("#errorM1").html("");
		$("#errorM2").html("");
	});
	 $("#activeSubmit").on("click",function(){	
		var new_password=$("#new_password").val();
		var a_new_password=$("#a_new_password").val();
		var mobile="${inputMobile}";
		//密码验证
		if(!required(new_password)){
			$("#errorM1").html("请填写密码！");
			return false;
		}
		if(!rangeLength(new_password)){
			$("#errorM1").html("密码长度为6-18位！");
			return false;
		}
		if(numberCheck(new_password)===false){
			$("#errorM1").html("密码不能全是数字！");
			return false;
		}
		if(!passwordCheck(new_password)){
			$("#errorM1").html("密码格式不正确！");
			return false;
		}
		  if (new_password == a_new_password){
			 // $("#form1").submit();
			 //判断该手机号码是否已被激活
			    $.getJSON("${ctx}/hrhelper-platform/isToBeActiveAccountInfo.e", {
		           mobile: "13671832769"
				}, function (data) {
					console.log("data=="+data.message);
					if (data.message === "true"){
						 
						//表单提交,执行激活
						$("#form1").submit();
					}else{
						alert(data.code);	 
						return false;
						//alert("该手机号码已被激活！");	
						//window.location.href="${ctx}/webApp/anon/accountActivate";
					}
				}); 
				  
			}else{
				//alert("两次输入的密码不一致");
				$("#errorM2").html("两次输入的密码不一致！");
				return false;
			} 
		  
	}); 
	
});	
	
	

</script>

</body>
</html>