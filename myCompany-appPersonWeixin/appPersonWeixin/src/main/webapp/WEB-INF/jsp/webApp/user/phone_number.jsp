<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<es:webAppNewHeader title="${appName}" description="智阳网络技术" keywords="智阳网络技术"/>

<header class="am-header am-header-default am-no-layout" data-am-widget="header">
  <div class="am-titlebar-left"> <a class="bak_ico" title="返回" href="javascript:history.go(-1)"><em></em></a> </div>
  <h1 class="am-header-title">更换手机号</h1>
  <div class="am-titlebar-right"> <a title="" class="home_ico" href="${ctx}/webApp/index"><em></em></a> </div>
</header>
	<form id="form1" name="form1" enctype="multipart/form-data" class="form-horizontal" method="post" style="margin-top:20px;">
		<div class="vip-center_form" >
		 
		  <div class="input_list" id="widget-list">
		 
		    <ul class="am-list m-widget-list" style="transition-timing-function: cubic-bezier(0.1, 0.57, 0.1, 1); transition-duration: 0ms; transform: translate(0px, 0px) translateZ(0px);">
		      <li>
		        <div class="am-g lines"><span class="am-u-sm-8">
		          <input  id="mobile" name="mobile" type="number" class="am-form-field am-input-lg" placeholder="请输入新的手机号码">
		          </span> <span class="am-u-sm-4">
		          <input type="button"  class="am-btn am-btn-warning am-radius am-btn-sm" value="获取验证码" id="sendcaptcha">
		          </span></div>
		      </li>
		      <li>
		        <div class="lines"><span>
		          <input id="messagecode" name="messagecode"   class="am-form-field am-input-lg" type="number" placeholder="请输入验证码">
		          </span></div>
		      </li>
		      
		    </ul>
		   
		  </div>
		</div>
		<div class="am-container am-topbar-fixed-bottom am-block am-padding-left-0 am-padding-right-0"  >
		        <input type="submit" class="am-btn am-btn-secondary am-btn-block am-btn-lg am-padding-vertical " value="确认" id="submit"  > 
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
<script type="text/javascript"  src="${ctx}/static/assets/js/utils.js"></script>
<script type="text/javascript">


$(function() {

	var codeCheck="${codeTip}";
	if(codeCheck=="false"){
		errorCodeTip("验证码输入错误");
	}
		
	/**
	 * 获取验证码（个人）
	 * 
	 */
	$("#sendcaptcha").on("click",function(){
		
		var mobile=$("#mobile").val();
		var isempty=false;
		if(mobile!==""){//验证是否为空
			isempty=true;
		}
		if(!isempty ){
			$("#my-alert").find(".am-modal-hd").html("请填写正确的手机号码！");
			$("#my-alert").modal();
			return false;
		}
			 	 	 		
  	    $.getJSON("${ctx}/hrhelper-platform/anon/sendMessage.e", {
           mobile: mobile, functionCode: "modifyMobile"
		}, function (data) {
			if (data == true){
				 timerc1=60;//时间初始化
				 times=setInterval(add1,1000);				
			}else{
				$("#my-alert").find(".am-modal-hd").html(data.code);
				$("#my-alert").modal();
			}
		});	   
	});
	
	$("#submit").on("click",function(){	
		var messagecode=$("#messagecode").val();
		var newMobile=$.trim($("#mobile").val());
		var isempty=false;
	    if("${mobile}"==newMobile){
	    	$("#my-alert").find(".am-modal-hd").html("输入的手机号码与原始手机号码重复！");
			$("#my-alert").modal();
	    	return false;
	    }
		if(messagecode!==""){//验证是否为空
			isempty=true;
		    return true;
		}
		
		if(!isempty ){
			errorCodeTip("请填写验证码");
			return false;
		}
		return true;
		
	});
	
	inputDisabled();
    $("#messagecode").on("keyup",function(){
	  inputDisabled();
    });  
});


 
 
</script>
</body>
</html>