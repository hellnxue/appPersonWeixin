/*jQuery部分*/
$(document).ready(function() {
	  $(window).load(function() { 

   	if (screen.width<1279) {
   
   		$('head link[href*="style"]').attr('href','../css/list.css');
   		$(".head .right p").css('display', 'block');
   
   		$(".footer li .footer-tel").css('text-indent', '0em');
   		$(".search .text-search").css('width', '68%');
   		$(".search-pic").css('width', '70px');
        $(".right").css('width', '1000px');
      $(".article-h h2").css('padding', '3% 21% 0;');

      $(".footer li a").css('padding-left', '39px');
      $(".wechat span").css('left', '-40px');



/*弹出框部分*/
     

   	}


    if (document.body.clientWidth  <1279) {
   
      $('head link[href*="style"]').attr('href','../css/list.css');
      $(".head .right p").css('display', 'block');
   
      $(".footer li .footer-tel").css('text-indent', '0em');
      $(".search .text-search").css('width', '68%');
      $(".search-pic").css('width', '70px');
        $(".right").css('width', '1000px');
      $(".article-h h2").css('padding', '3% 21% 0;');

      $(".footer li a").css('padding-left', '39px');
      $(".wechat span").css('left', '-40px');
/*弹出框部分*/
     

    }
    

      $(".alert-body").hide();
      $(".error_massage").hide();
      $(".code_error").hide();  
       $(".write_please").hide(); 
      $(".noempty").hide();





});  
	
	/*show-erweima*/	
			
			$(".wechat").hover(function() {
			$(".wechat span").show();
			}, function() {
			$(".wechat span").hide();

			});


/*input-password 表单*/
	$(".sear-policy").focus(function(event) {
		/*$(".pw-t").hide();*/
		if ($(this).val()=="快速查找政策法规") {
				
                $(this).val("");
                $(this).css('color', '#404040');
            }
     		
     		
        }).blur(function(event) {
        	
           if ($(this).val()=="") { 
            $(this).val("快速查找政策法规");
            $(this).css('color', '#ccc');

            }
           
        });

   /* slide-block*/
 
  
  	var speed=300;
 $(".right .nav li").each(function(index) {
		$(this).mouseover(function(event) {
	
	 	 if (index==0) {
	 	  $(".right").children('p').stop().animate({"left": ""+index*166+"px"}, speed);
			}	 	 
		else if (index==1) {
	 	  $(".right").children('p').stop().animate({"left": ""+index*156+"px"}, speed);
			}	 	
		 else if (index==2) {
	 	  $(".right").children('p').stop().animate({"left": ""+index*156+"px"}, speed);
			}	 	
		else if (index==3) {
	 	  $(".right").children('p').stop().animate({"left": ""+index*156+"px"}, speed);
			}	 	
		

	 });

});


/*mouseover and  change picture*/
/*	$(".collection,.back,.opinion").mousemove(function(event) {
			


	});*/



/*window-scroll*/
	var h=$(".header").height();
	var	num=h;
	$(window).scroll(function(event) {
		var val=$(document).scrollTop();
		if (val>num) {
	
			$(".back-top").show();

		}
		else if(val<num) {
			$(".back-top").hide();
		}

	});


/*back-top*/


	$(".back").click(function(event) {
		$(window).scrollTop(0);
	});


/*...................................................................................*/
/*e-mail 表单*/
	$(".e-mail").focus(function(event) {
		
		if ($(this).val()=="请输入您的邮箱，以便与您作进一步沟通") {
				
                $(this).val("");
                $(this).css('color', '#404040');
            }
     		
     		
        }).blur(function(event) {
        	
           if ($(this).val()=="") { 
            $(this).val("请输入您的邮箱，以便与您作进一步沟通");
            $(this).css('color', '#ccc');

            }
           
        });
/*feedback-opinion 表单*/
	$(".opinion").focus(function(event) {
		
		if ($(this).val()=="请输入您的宝贵意见或建议") {
				
                $(this).val("");
                $(this).css('color', '#404040');
            }
     		
     		
        }).blur(function(event) {
        	
           if ($(this).val()=="") { 
            $(this).val("请输入您的宝贵意见或建议");
            $(this).css('color', '#ccc');

            }
           
        });


/* alert--弹出框部分 */

/*$(".alert-btn").click(function(event) {
   $(".alert-body").show();
   $(".alert-body").css({
    'background': 'rgba(0,0,0,0.05)',
     'position': 'absolute',
     'z-index':'9999',
     'margin':'0 0 0 10px',
     'top':'0',
     'padding':'18% 29% 11.3% 30%'
     
   });
$(".alert").show();
});*/
$(".alert-h-r").click(function(event) {


 $(".alert").hide();
$(".alert-body").css({
  'background': 'none',
  'z-index': '0',
  'padding': '0'
});

});


/*确定和取消*/

/*关闭选择提示框函数*/
/*function alert(){

 $(".alert").hide();
$(".alert-body").css({
  'background': 'none',
  'z-index': '0',
  'padding': '0'
});

}*/

$(".alert-btn").click(function(event) {

   $(".alert-body").show();
   $(".alert-body").css({
    'background': 'rgba(0,0,0,0.05)',
     'position': 'absolute',
    
     'margin':'0 0 0 10px',
     'top':'0',
     'padding':'15% 29% 14.5% 28%',
     'left':'1%', 'z-index':'9999',
     'top':'0'
   });
$(".alert").show();
});

/*关闭选择提示框*/
$(".alert-h-r").click(function(event) {


 $(".alert").hide();
$(".alert-body").css({
  'background': 'none',
  'z-index': '0',
  'padding': '0'
});


});

$(".alert-ok").click(function(event) {

 $(".alert").hide();
$(".alert-body").css({
  'background': 'none',
  'z-index': '0',
  'padding': '0'
});

});

$(".alert-cancle").click(function(event) {
  
 $(".alert").hide();
$(".alert-body").css({
  'background': 'none',
  'z-index': '0',
  'padding': '0'
});

});

/*注册界面切换*/
$("#register-content .registerform").each(function(index, el) {
         $(".phone_register").click(function(event) {
              $(this).addClass('current_color').siblings().removeClass('current_color');
              $("#register-content .registerform").eq(0).show().siblings().hide();
          });
          $(".e-mail").click(function(event) {
              $(this).addClass('current_color').siblings().removeClass('current_color');
              $("#register-content .registerform").eq(1).show().siblings().hide();
          });
});


//登陆页面切换

$(".changeTo_register").click(function(event) {
      $("#register-content").show();
      $(".welcome_reg").show();
      $("#login_content").hide();
      $(".welcom_login").hide();
});
$(".changeTo_login").click(function(event) {
      $("#register-content").hide();
      $(".welcome_reg").hide();
      $("#login_content").show();
      $(".welcom_login").show();
});

/*登录注册页面表单*/

/*user_name 表单*/
  $(".user_name").focus(function(event) {
    
    if ($(this).val()=="请输入用户名") {
        
                $(this).val("");
                $(this).css('color', '#717171');
            }
        
        
        }).blur(function(event) {
          
           if ($(this).val()=="") { 
            $(this).val("请输入用户名");
            $(this).css('color', '#c6c6c6');

            }
           
        });

 
/*email 表单*/
  $(".email").focus(function(event) {
    
    if ($(this).val()=="请输入邮箱账号") {
        
                $(this).val("");
                $(this).css('color', '#717171');
            }
        
        
        }).blur(function(event) {
          
           if ($(this).val()=="") { 
            $(this).val("请输入邮箱账号");
            $(this).css('color', '#c6c6c6');

            }
           
        });

/*mobile 表单*/
  $(".mobile").focus(function(event) {
    
    if ($(this).val()=="请输入手机号") {
        
                $(this).val("");
                $(this).css('color', '#717171');
            }
        
        
        }).blur(function(event) {
          
           if ($(this).val()=="") { 
            $(this).val("请输入手机号");
            $(this).css('color', '#c6c6c6');

            }
           
        });






  $("#Button1").click(function(event) {
    check();
    validate();
    chkEmail();
  });






});//此处是ready(function()) 函数结束


//邮箱检测
/*var valu=document.getElementById("email");
*/function check(){
    if($(".email").val()==""){
    $(".noempty").show();
    /*$("#tips").html("不能输入空的");*/
    return false;
   }
   if(!$(".email").val().match(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/)){
     $(".error_massage").show();
     $(".email").focus();
   }
 }
  


/*原生JS部分*/
var code ; //在全局 定义验证码      
function createCode(){       
code = "";      
var codeLength = 4;//验证码的长度      
var checkCode = document.getElementById("checkCode");      
checkCode.value = "";      
var selectChar = new Array(1,2,3,4,5,6,7,8,9,'a','b','c','d','e','f','g','h','j','k','l','m','n','p','q','r','s','t','u','v','w','x','y','z','A','B','C','D','E','F','G','H','J','K','L','M','N','P','Q','R','S','T','U','V','W','X','Y','Z');      
      
for(var i=0;i<codeLength;i++) {      
   var charIndex = Math.floor(Math.random()*60);      
  code +=selectChar[charIndex];      
}      
if(code.length != codeLength){      
  createCode();      
}      
checkCode.value = code;      
}      
      
     
function validate () {      
var inputCode = document.getElementById("input1").value.toUpperCase();      
var codeToUp=code.toUpperCase();  
if(inputCode.length <=0) {      
  $(".write_please").show(); 
  return false;      
}      
else if(inputCode != codeToUp ){      
   
   createCode();      
   return false;      
}      
else {      
/*  alert("输入正确，输入的验证码为："+inputCode); */     
  return true;      
}      
      
}      












