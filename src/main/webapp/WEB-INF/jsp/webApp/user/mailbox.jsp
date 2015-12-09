<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<es:webAppNewHeader title="${appName}" description="智阳网络技术" keywords="智阳网络技术"/>
<header class="am-header am-header-default am-no-layout" data-am-widget="header">
  <div class="am-titlebar-left"> <a class="bak_ico" title="返回" href="javascript:history.go(-1)"><em></em></a> </div>
  <h1 class="am-header-title">修改邮箱</h1>
  <div class="am-titlebar-right"> <a title="" class="home_ico" href="${ctx}/webApp/index"><em></em></a> </div>
</header>
<div class="vip-center_form">
   <div class="yz_step">
    	<span>手机验证码</span><span class="cur">修改邮箱</span>
        <p class="line am-cf"><em class="am-fl"></em><em class="cur am-fr"></em></p>
    </div>
    <h3>现在的邮箱：${email}</h3>
     <div class="input_list" id="widget-list">
  <form id="form1" name="form1" enctype="multipart/form-data" class="form-horizontal">
    <ul class="am-list m-widget-list" style="transition-timing-function: cubic-bezier(0.1, 0.57, 0.1, 1); transition-duration: 0ms; transform: translate(0px, 0px) translateZ(0px);">
        <li>
        <div class="lines"><span>
          <input class="am-form-field am-input-lg" type="text" placeholder="请输入新邮箱账号" id="email" name="email">
          </span></div>
       </li>
     <!--  <li>
        <div class="am-g lines"><span class="am-u-sm-8">
          <input id="messagecode" name="messagecode" type="number" class="am-form-field am-input-lg" placeholder="请输入验证码">
          </span>
           <span class="am-u-sm-4">
          <input type="button" class="am-btn am-btn-warning am-radius am-btn-sm" value="获取验证码" id="sendcaptcha">
          </span>
          </div>
      </li> -->
    </ul>
    <p align="center" style="padding:0 2rem;">
      <input type="submit" class="am-btn am-btn-primary am-radius am-btn-block am-btn-lg" value="完成" id="submit">
    </p>
  </form>     
  </div>
</div>

<es:webAppNewFooter/>
<script type="text/javascript">
$(function() {
	 $("#submit").on("click",function(){	
		 var newEmail=$.trim($("#email").val());
	    if("${email}"==newEmail){
	    	alert("输入的邮箱与原始邮箱重复！");
	    	return false;
	    }
	    if(newEmail.length>50){
	    	alert('邮箱长度不能大于50');
	    	return false;
	    }
		return true;
		
	}); 
});
</script>
</body>
</html>