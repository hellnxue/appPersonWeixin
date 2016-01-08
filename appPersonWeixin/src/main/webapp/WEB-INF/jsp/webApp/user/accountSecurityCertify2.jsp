<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<!-- 忘记密码、找回密码 -->
<es:webAppNewHeader title="${appName}" description="智阳网络技术" keywords="智阳网络技术"/>
<header class="am-header am-header-default am-no-layout" data-am-widget="header">
  <div class="am-titlebar-left"> <a class="bak_ico" title="返回" href="javascript:history.go(-1)"><em></em></a> </div>
  <h1 class="am-header-title">安全认证</h1>
  <div class="am-titlebar-right"> <a title="" class="home_ico" href="${ctx}/webApp/index"><em></em></a> </div>
</header>
<div class="vip-center_form">
	<div class="yz_step yz_step_mm">
    	<span>验证手机号码</span><span>验证身份证</span><span class="cur">密码设置</span>
        <p class="line am-cf"><em class="am-fl"></em><em class="am-fl am-s cur"></em><em class="am-fr"></em></p>
    </div>
  <div class="input_list" id="widget-list">
  <form id="form1" name="form1" enctype="multipart/form-data" class="form-horizontal">
    <ul class="am-list m-widget-list" style="transition-timing-function: cubic-bezier(0.1, 0.57, 0.1, 1); transition-duration: 0ms; transform: translate(0px, 0px) translateZ(0px);">
      <li>
        <div class="lines"><span>
          <input id="passportCode" name="passportCode" class="am-form-field am-input-lg" type="number" placeholder="请填写身份证">
          </span></div>
      </li>
    </ul>
    <p align="center" style="padding:0 2rem;">
      <input id="sendcaptcha" type="submit" class="am-btn am-btn-primary am-radius am-btn-block am-btn-lg" value="下一步">
    </p>
  </form>      
  </div>
</div>


<es:webAppNewFooter/>
<!--在这里编写你的代码-->
<script type="text/javascript">
$(function() {

	/**
	 * 获取验证码（个人）
	 * 
	 */
	$("#sendcaptcha").on("click",function(){
	    
	    var passportCode=$("#passportCode").val();
		
		if (passportCode == ""){
			alert("请输入绑定的身份证号码");
			return false;
		}else{
			return true;
		}
	});

});
</script>
</body>
</html>