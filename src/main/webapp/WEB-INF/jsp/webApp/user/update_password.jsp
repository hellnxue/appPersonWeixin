<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<!-- 修改密码 -->
<es:webAppNewHeader title="${appName}" description="智阳网络技术" keywords="智阳网络技术"/>
<header class="am-header am-header-default am-no-layout" data-am-widget="header">
  <div class="am-titlebar-left"> <a class="bak_ico" title="返回" href="javascript:history.go(-1)"><em></em></a> </div>
  <h1 class="am-header-title">用户密码</h1>
  <div class="am-titlebar-right"> <a title="" class="home_ico" href="${ctx}/webApp/index"><em></em></a> </div>
</header>
<div class="vip-center_form">
 <div class="yz_step">
    	<span>验证手机号码</span><span class="cur">密码设置</span>
        <p class="line am-cf"><em class="am-fl"></em><em class="cur am-fr"></em></p>
    </div>
  <div class="input_list" id="widget-list">
  <form id="form1" method="post" name="form1" enctype="multipart/form-data" class="form-horizontal">
    <ul class="am-list m-widget-list" style="transition-timing-function: cubic-bezier(0.1, 0.57, 0.1, 1); transition-duration: 0ms; transform: translate(0px, 0px) translateZ(0px);">
      <li>
        <div class="lines"><span>
          <input class="am-form-field am-input-lg" type="password" placeholder="请输入原密码" id="old_password" name="old_password"   minlength="6" maxlength="18" data-validation-message="密码长度为6-18位！" required>
          </span></div>
      </li>
      
      <li>
        <div class="lines"><span>
          <input class="am-form-field am-input-lg" type="password" pattern="^\d*[a-zA-Z]+[a-zA-Z0-9]*$" minlength="6" maxlength="18" placeholder="请输入新密码  密码为6-18位字符,建议为字母和数字的组合！" data-validation-message="密码为6-18位字符,建议为字母和数字的组合" id="new_password" name="new_password" required>
          </span></div>
      </li>
      <li>
        <div class="lines"><span>
          <input class="am-form-field am-input-lg" type="password" data-equal-to="#new_password" placeholder="请再次输入新密码" data-validation-message="两次密码输入不一致！" id="a_new_password" name="a_new_password" required>
          </span></div>
      </li>
    </ul>
    <p align="center" style="padding:0 2rem;">
      <input type="submit"  class="am-btn am-btn-primary am-radius am-btn-block am-btn-lg" value="完成" id="btn_submit">
    </p>
   </form>
  </div>
</div>
<es:webAppNewFooter/>
<script src="${ctx}/static/assets/js/rulesValidation.js"></script> 
<script type="text/javascript">
$(function() {
	
	var statu="${tip}";
	var pwdStatu="${pwdTip}";
	console.log("pwdStatu=="+"${pwdTip}");
	if(pwdStatu=="false"){
		 $("#old_password").closest("li").after("<span style='color:red'>"+"原始密码不正确！"+"</span>");
	}
	
	if(statu=="true"){
		alert("密码修改成功！");
		location.replace("${ctx}/webApp/logout");
	}else if(statu=="false"){
		alert("密码修改失败！");
	}
    
	
	$('#form1').validator({
		//自定义验证
	    validate: function(validity) {
		    	
			var $field=$(validity.field);
			 //验证不通过时
			if(!validity.valid){
			 
				  $field.closest("li").next("span").html("").remove();
				  $field.closest("li").after("<span style='color:red'>"+$field.data('validationMessage')+"</span>");
			}
		
	    },
		//验证通过时
		 onValid: function(validity) {
			  $(validity.field).closest("li").next("span").html("").remove();
		 
	    },
	    // 验证通过时添加到域上的 class
        validClass: '',
	    
		submit:function(){
			 
			  if(!this.isFormValid()){//表单验证状态
			    return false;
			  }else{
				   
				 $("#form1").submit();
				  
			  }
		}
	  });
});
</script>
</body>
</html>