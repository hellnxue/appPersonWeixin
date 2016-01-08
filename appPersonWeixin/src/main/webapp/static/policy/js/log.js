
$(document).ready(function() {
	var useCaptcha="${configure.getString('bdf2.useCaptchaForLogin')}"; 
	var useRemember="${configure.getString('bdf2.useRememberMeForLogin')}"; 
	window.checkForm=function(){
		var errorInfo=$("#errorInfo"); 
		var username=$("#username_").val(); 
		if(username==""){ 
			errorInfo.html("用户名不能为空!"); 
			$("#username_").focus(); 
			return false; 
		} 
		var password=$("#password_").val(); 
		if(password==""){ 
			errorInfo.html("密码不能为空!"); 
			$("#password_").focus(); 
			return false; 
		}	 
		var captcha=$("#captcha_").val(); 
		if(useCaptcha=="true" && captcha==""){
			errorInfo.html("验证码不能为空!"); 
			$("#captcha_").focus(); 
			return false; 
		};
	};
	function layoutLoginContainer(){ 
		var height=$(window).height(); 
		var width=$(window).width(); 
		var bgImgFolder="${configure.getString('bdf2.login.backgroundImageFolder')}"; 
		var bgImg="login-bg1.jpg"; 
		var bgHeight=464; 
		var loginInfoHeight=380; 
		if(useCaptcha=="true" && useRemember=="false"){ 
			loginInfoHeight=360; 
		} 
		if(useCaptcha=="false" && useRemember=="true"){ 
			loginInfoHeight=310; 
		}	 
		if(useCaptcha=="false" && useRemember=="false"){ 
			loginInfoHeight=290; 
		}		 
		if(width<1670 && width>1370){ 
			bgImg="login-bg2.jpg"; 
			bgHeight=543; 
		}else if(width<1950 && width>1660){ 
			bgImg="login-bg3.jpg"; 
			bgHeight=652; 
		}else if(width>1950){ 
			bgImg="login-bg4.jpg"; 
			var bgHeight=869; 
		} 
		var container=$("#loginContainer"); 
		container.css("position","absolute"); 
		container.css("top",(height-bgHeight)/2); 
		container.css("background","url("+bgImgFolder+"/"+bgImg+")"); 
		container.css("height",bgHeight+"px"); 
		container.css("width","100%"); 
		var loginInfo=$("#loginInfo"); 
		loginInfo.css("position","absolute"); 
		loginInfo.css("right","100px"); 
		loginInfo.css("height",loginInfoHeight+"px"); 
		loginInfo.css("top",(bgHeight-loginInfoHeight)/2+"px"); 
		 
		var titleContainer=$("#titleContainer"); 
		titleContainer.css("position","absolute"); 
		titleContainer.css("left","20px"); 
		titleContainer.css("top",(height-bgHeight)/2-55); 
	} 
	$(window).resize(function(){ 
		layoutLoginContainer(); 
	}); 
	$(document).ready(function() {
	/*home back*/
		$(".right").hover(function() {
			$(".back").toggle();
		});
		$(".left").hover(function() {
			$(".meu").toggle();
		});


	/*input-user 表单*/
		
	/*用户注册-register*/

		$(".register").click(function(event) {
			$(".login-box").addClass('anima');
			$(".forget,.auto-login,.register").hide();
			$("#check").hide();
			$(".quit-log").fadeIn(1700);
			
			$(".btn").fadeOut(0);
			
			$(".user").fadeOut(0);
			$(".newUser").fadeIn(10);
			$(".reg").fadeIn(1700);
			$(".quit-log").css({
				"display": 'block'
			});
				$(".login-box").removeClass('anima-fan');
		});

	/*用户登录-register*/
		$(".forget,.auto-login,.register").show();

	$(".quit-log").click(function(event) {
			$(".user").fadeIn();
			$(".newUser").hide();
			$(".login-box").addClass('anima-fan');
			$(".forget,.auto-login,.register").show();
			$("#check").show();
			$(".quit-log").hide();
			$(".reg").hide();
			$(".btn").fadeIn(1700);
		$(".login-box").removeClass('anima');
	});
		layoutLoginContainer(); 
		var container=$("#loginContainer"); 
	//	showTime(); 
		//window.setInterval(function(){ showTime(); },1000); 
		var showType=Math.floor(Math.random()*10); 
		if(showType<2){ 
			container.slideDown(500); 
		}else if(showType>1 && showType<3){ 
			container.show(500); 
		}else if(showType>2 && showType<5){ 
			container.fadeIn(500); 
		}else if(showType>4 && showType<7){ 
			container.slideToggle(500); 
		}else{ 
			container.fadeIn(500); 
		} 
		$("#captchaImg").click(function(){ 
			this.src="${request.getContextPath()}${configure.getString('bdf2.generateCaptchaUrl')}${configure.getString('bdf2.controllerSuffix')}?width=181&height=60&random="+Math.random(); 
		}); 
		var error="${authenticationExceptionMessage}"; 
		if(error && error!=""){ 
			if(error=="Bad credentials")error="用户名或密码不正确"; 
			$("#errorInfo").html(error); 
		} 
		if(useRemember=="true"){ 
			$("#rememberMeContainer").show(); 
		}else{ 
			$("#rememberMeContainer").hide(); 
		} 
		if(useCaptcha=="true"){ 
			$("#captchaContainer").show(); 
		}else{ 
			$("#captchaContainer").hide(); 
		}	 
		$("#username_").focus(); 
	});
	
	$(window).load(function() {
   	if (screen.width<1279) {
      $(".body").css('width', '100%');
      $(".login-box").css('right', '50%');
   	}
   });
	
	$(window).load(function() {
		//$(".register").hide();
		$(".login-und-r .forget").css('margin-left', '85px');
	});
/*home back*/
	$(".right").hover(function() {
		$(".back").toggle();
	});
	$(".left").hover(function() {
		$(".meu").toggle();
	});


/*input-user 表单*/
	$(".userName").focus(function(event) {
		if ($(this).val()=="注册邮箱/用户名") {
                $(this).val("");
     			 $(this).css('color', '#404040');
     		}
        }).blur(function(event) {
            if ($(this).val()=="") { 
            $(this).val("注册邮箱/用户名");
           	 $(this).css('color', '#cbcbcb');
            }
           
        });
	/*input-password 表单*/
/*用户注册*/

	$(".register").click(function(event) {
		$(".usertype").hide();
		$(".login-box").addClass('anima');
		$(".login-box").css({
			"height": '293px',"border-radius": '10px',
			"top": "25.5%"
		});
		$(".forget,.auto-login,.register").hide();
		$("#check").hide();
		$(".login-und").addClass("anima");
		$(".quit-log").fadeIn(500);
		$(".pw-t").css({
			"top": '53%',
			"right": '11%',"width":"250px"
			
		});
		$(".btn").fadeOut(0);
		$(".pw").addClass('anima');
		$(".pw-t").addClass('anima');
		$(".userName").addClass('anima');
		$(".user").fadeOut(0);
		
		$(".newUser").fadeIn(10);
		$(".newUser").addClass('anima');
		$(".reg").addClass('anima');
		$(".reg").fadeIn(500);
		$(".quit-log").css({
			"display": 'block'
		});
		
			$(".login-box").removeClass('anima-fan');
			
	});

/*用户登录*/

$(".quit-log").click(function(event) {

	$(".login-box").css({"height": '248px',
			"top": "32.5%","border-radius":"0 0 10px 10px"});
$(".usertype").show();
	/*$(".login-box").css('height', '248px');*/
	    $(".login-und").removeClass("anima");
	    $(".pw-t").css({
	    	"top": '43%',
	    	
	    	"right": '11%'
	    });
	    $(".pw-t").removeClass("anima");
	    $(".pw").removeClass('anima');
	    $(".userName").removeClass("anima");
	    $(".newUser").removeClass("anima");
	    $(".reg").removeClass("anima");
		$(".user").fadeIn();
		$(".newUser").hide();
		$(".login-box").addClass('anima-fan');
		$(".forget,.auto-login,.register").show();
		$("#check").show();
		$(".quit-log").hide();
		$(".reg").hide();
		$(".btn").fadeIn(500);
	$(".login-box").removeClass('anima');
     $(".login-box").addClass('border-left');
	


});


/*用户类型选择*/
/*个体用户*/
	$(".people").click(function(event) {
		$(this).addClass('current');
		$(".supplier").removeClass('current');
		$(".register").show();
		$(".login-und-r .forget").css('margin-left', '0');

	});

/*供应商用户*/
	$(".supplier").click(function(event) {
		$(".login-und-r .forget").css('margin-left', '85px');
		$(this).addClass('current');
		$(".people").removeClass('current');		
		$(".register").hide();
	});

/*显示屏大小判断*/

$(window).load(function() {
	if ($(".pw").val()!="") { 
		   $(".pw").focus();
            }
    if (screen.width<1279) {
      $(".login-box").css('right', '1%');

    }
   });  
});