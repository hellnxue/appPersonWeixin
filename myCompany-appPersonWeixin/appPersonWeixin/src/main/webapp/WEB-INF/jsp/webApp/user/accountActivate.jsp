<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf"%>
<!-- 忘记密码、找回密码 -->
<es:webAppNewHeader title="雇员激活" description="智阳网络技术" keywords="智阳网络技术" />
<header class="am-header am-header-default am-no-layout"
	data-am-widget="header">
	<div class="am-titlebar-left">
		<a class="bak_ico" title="返回" href="javascript:history.go(-1)"><em></em></a>
	</div>
	<h1 class="am-header-title">验证账户信息</h1>
	<div class="am-titlebar-right">
		<a title="" class="home_ico" href="${ctx}/webApp/index"><em></em></a>
	</div>
</header>
<div class="vip-center_form">
	<div class="yz_step">
		<span class="cur">验证账户信息</span><span>登录密码设置</span>
		<p class="line am-cf">
			<em class="cur am-fl"></em><em class="am-fr"></em>
		</p>
	</div>
	<div class="input_list" id="widget-list">
		<form id="form1" name="form1" enctype="multipart/form-data"
			class="form-horizontal">
			<ul class="am-list m-widget-list"
				style="transition-timing-function: cubic-bezier(0.1, 0.57, 0.1, 1); transition-duration: 0ms; transform: translate(0px, 0px) translateZ(0px);">
				<li>
					<div class="lines">
						<span> <input id="mobile" name="mobile"
							class="am-form-field am-input-lg" type="number"
							placeholder="请输入手机号码">
						</span>
					</div>
				</li>
				<li>
					<div class="am-g lines">
								<span class="am-u-sm-8"><input value="" id="gCheckCode" class="am-form-field am-input-lg"
									name="gCheckCode" placeholder="请输入图片验证码" onblur="imgCode()"> 
									</span> <span class="am-u-sm-4"> 
									<img
									src="${ctx}/kaptcha.jpg" height="34" width ="100" id="kaptchaImage"
									alt="图片验证码" title="看不清？点击更换验证码" />
								</span>
						</div>
				</li>
				<li>
					<div class="am-g lines">
						<span class="am-u-sm-8"> <input id="messagecode"
							name="messagecode" type="number"
							class="am-form-field am-input-lg" placeholder="请输入短信验证码">
						</span> <span class="am-u-sm-4"> <input type="button"
							class="am-btn am-btn-warning am-radius am-btn-sm" value="获取验证码"
							id="sendcaptcha"> <span class="Time"
							style="display: none"><em class="time_sub" id="time_sub"></em>秒后重新发送</span>
						</span>
					</div>
				</li>
			</ul>
			<p align="center" style="padding: 0 2rem;">
				<input id="activeSubmit" type="button"
					class="am-btn am-btn-primary am-radius am-btn-block am-btn-lg"
					value="下一步">
			</p>
		</form>
		<span
			style="color: red; margin-left: 1.03rem; margin-top: 0.46rem; display: block;"
			id="errorTip"> </span>
	</div>
</div>

<es:webAppNewFooter />

<!--在这里编写你的代码-->
<script type="text/javascript">

var bool = false;
function errorCodeTip(msg){
	 $("#sendcaptcha").closest("li").next("span").html("").remove();
	 $("#sendcaptcha").closest("li").after("<span style='color:red'>"+msg+"</span>");
}

function imgCode(){
	var code = $("#gCheckCode").val();
	$.getJSON("${ctx}/webApp/anon/imgCode", {
        code: code
		}, function (data) {
			if(data){
				bool = true ; 
				errorCodeTip("");
			}else{
				bool = false ;
				errorCodeTip("图片验证码输入错误！");
			}
			
		});
}
$(function() {

	var codeCheck="${codeTip}";
	if(codeCheck=="false"){
		errorCodeTip("验证码输入错误！");
	}
	 $('#kaptchaImage')
	    .css({
	    	cursor: 'pointer'
	    })
	    .on('click', function() {
	        $(this).attr('src', '${ctx}/kaptcha.jpg?' + Math.floor(Math.random()*100) );
	    })
	var imgCheck="${imgTip}";
	if(imgCheck=="false"){
		errorCodeTip("验证码输入错误！");
	}
	var timerc1=0; //全局时间变量（秒数）
	var times;
	function add1(){ //加时函数
		if(timerc1 > 0){ //如果不到1秒
		    --timerc1; //时间变量自减1
		    $("#sendcaptcha").hide().siblings('.Time').show();
		    $(".Time #time_sub").html(parseInt(timerc1)); //写入分秒数
		   // $("#time_sub").html(Number(parseInt(timerc%60/10)).toString()+(timerc%10)); //写入秒数（两位）
		};
		if (timerc1==0) {
			  $("#sendcaptcha").show().siblings('span.Time').hide();
		       clearInterval(times);
		 }
	};
		
	/**
	 * 获取验证码（个人）
	 * 
	 */
	$("#sendcaptcha").on("click",function(){
		var gCheckCode = $("#gCheckCode").val();
		if(gCheckCode==""){
			alert("请输入图片验证码！");
			return false;
		}
		if(!bool){
			return false;
		}
		var mobile=$("#mobile").val();

		var isempty=false;
		if(mobile!==""){//验证是否为空
			isempty=true;
		}
		if(!isempty ){
			alert("请填写正确的手机号码！");
			return false;
		}
		var  msgcode = $("#gCheckCode").val();
  	    $.getJSON("${ctx}/hrhelper-platform/anon/sendMessage.e", {
           mobile: mobile, functionCode: "personregister" , msgcode:msgcode
		}, function (data) {
			if (data) {
				$("#mobile").attr("readonly","readonly");
				 timerc1=60;//时间初始化
				 times=setInterval(add1,1000);						
			}else{
				alert(data.code);	     
			}
		});	  
	});
	
	$("#activeSubmit").on("click", function() {
		var messagecode = $("#messagecode").val();
		if(messagecode == ""){
			return false;
		}
		
		$.getJSON("${ctx}/webApp/anon/duanxin", {
			messagecode : messagecode
		}, function(data) {
			console.log(data);
			if (data) {
				$('#form1').attr('action', '${ctx}/webApp/anon/accountActivate');
				$('#form1').submit();
				return true;
			} else {
				errorCodeTip("请填写验证码！");
				return false;
			}
		});
	});
});
</script>

</body>
</html>