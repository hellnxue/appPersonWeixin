<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<!-- 修改密码 -->
<es:webAppNewHeader title="${appName}" description="智阳网络技术" keywords="智阳网络技术"/>
<header class="am-header am-header-default am-no-layout" data-am-widget="header">
  <div class="am-titlebar-left"> <a class="bak_ico" title="返回" href="javascript:history.go(-1)"><em></em></a> </div>
  <h1 class="am-header-title">修改密码</h1>
  <div class="am-titlebar-right"> <a title="" class="home_ico" href="${ctx}/webApp/index"><em></em></a> </div>
</header>
 	<form id="form1" method="post" name="form1" enctype="multipart/form-data" class="form-horizontal" style="margin-top:20px;">
		<div class="vip-center_form">
		  <div class="input_list" id="widget-list">
		 
		    <ul class="am-list m-widget-list" style="transition-timing-function: cubic-bezier(0.1, 0.57, 0.1, 1); transition-duration: 0ms; transform: translate(0px, 0px) translateZ(0px);">
		      <li>
		        <div class="lines"><span>
		          <input class="am-form-field am-input-lg" type="password" placeholder="请输入原密码" id="old_password" name="old_password"   minlength="6" maxlength="18" data-validation-message="密码长度为6-18位！" required>
		          </span></div>
		      </li>
		      
		      <li>
		        <div class="lines"><span>
		          <input class="am-form-field am-input-lg" type="password" pattern="^\d*[a-zA-Z]+[a-zA-Z0-9]*$" minlength="6" maxlength="18" placeholder="请输入新密码 " data-validation-message="密码为6-18位字符,建议为字母和数字的组合！" id="new_password" name="new_password" required>
		          </span></div>
		      </li>
		      <li>
		        <div class="lines"><span>
		          <input class="am-form-field am-input-lg" type="password" data-equal-to="#new_password" placeholder="请再次输入新密码" data-validation-message="两次密码输入不一致！" id="a_new_password" name="a_new_password" required>
		          </span></div>
		      </li>
		    </ul>
		  </div>
		</div>
		
		<div class="am-container am-topbar-fixed-bottom am-block am-padding-left-0 am-padding-right-0"  >
		        <input type="submit" class="am-btn am-btn-secondary am-btn-block am-btn-lg am-padding-vertical " value="确认" id="btn_submit"  > 
	    </div>
 	</form>
 	<div class="am-modal am-modal-alert" tabindex="-1" id="my-alert">
	  <div class="am-modal-dialog">
	    <div class="am-modal-hd"></div>
	    <div class="am-modal-footer">
	      <span class="am-modal-btn" data-am-modal-confirm>确定</span>
	    </div>
	  </div>
	</div> 
<script src="${ctx}/static/assets/js/jquery.min.js"></script> 
<script src="${ctx}/static/assets/js/int.web.js"></script> 
<script src="${ctx}/static/assets/js/amazeui.js"></script> 
<script src="${ctx}/static/assets/js/int.pageajax.js"></script>
<script src="${ctx}/static/assets/js/jquery.transit.js"></script> 
<script src="${ctx}/static/assets/js/int.com.js" type="text/javascript"></script>
<script src="${ctx}/static/assets/js/int.datecur.js" type="text/javascript"></script>
<script type="text/javascript"  src="${ctx}/static/assets/js/jquery.dialog.js"></script>
<script type="text/javascript"  src="${ctx}/static/assets/js/jquery.bgiframe.min.js"></script>
<script src="${ctx}/static/assets/js/rulesValidation.js"></script> 
<script type="text/javascript">
$(function() {
	
	var statu="${tip}";
	var pwdStatu="${pwdTip}";
	if(pwdStatu=="false"){
		 $("#old_password").closest("li").after("<span style='color:red'>"+"原始密码不正确！"+"</span>");
	}
	
	if(statu=="true"){
		$("#my-alert").find(".am-modal-hd").html("密码修改成功！");
		$("#my-alert").modal();
		setTimeout(function(){location.replace("${ctx}/webApp/logout");},1000);
		
	}else if(statu=="false"){
		$("#my-alert").find(".am-modal-hd").html("密码修改失败！");
		$("#my-alert").modal();
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