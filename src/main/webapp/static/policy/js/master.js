$(document).ready(function() {

	/*晃动的导航*/
//擦除效果
	jQuery.extend(jQuery.easing,
		{
			easeOutBack: function (x, t, b, c, d, s) {
				s = s || 1.3;
				return c*((t=t/d-1)*t*((s+1)*t + s) + 1) + b;
		}
	});
	
	//nav初始化选中
	var navCurr = $("#navCurr");
	$("#navSelected").css("left", navCurr[0].offsetLeft);
	
	//nav里的链接hover效果
	$("#navBd li").hover(function(){
		/*$(".navSelected").css('width', '150px');*/
			if(!!$("#navSelected").stop(true).animate({left:$(this)[0].offsetLeft}, 400, "easeOutBack")) {
				$(this).siblings().removeClass("navHover").end().addClass("navHover");
				$(this).find("a").hide().fadeIn(0);
			}
			
		}, function(){
			$(this).removeClass("navHover");
			$("#navCurr").addClass("navHover");
			//window.setTimeout(function(){$("#navCurr").parent().addClass("navHover")},100);
			$("#navSelected").stop(true).animate({left:navCurr[0].offsetLeft}, 300, "easeOutBack");
		}
	);



/*window-scroll*/
	/*var h=$(".sear-last").height();*/

	$(window).scroll(function(event) {	
		var	num=300;
		var val=$(document).scrollTop();
		if (val>num) {
	
			$(".back-top").show();
			/*$(".back-top").css('display', 'block');*/

		}
		else if(val<num) {
			$(".back-top").hide();
			/*$(".back-top").css('display', 'none');*/
		}

	});


/*back-top*/


	$(".back").click(function(event) {
		$(window).scrollTop(0);
	});


/*...................................................................................*/

/*搜索框*/
	$(".inp").focus(function(event) {
		/*$(".pw-t").hide();*/
		if ($(this).val()=="默认搜索条件") {
				
                $(this).val("");
                $(this).css('color', '#404040');
            }
     		
     		
        }).blur(function(event) {
        	
           if ($(this).val()=="") { 
            $(this).val("默认搜索条件");
            $(this).css('color', '#ccc');

            }
           
        });


/*购物数目显示部分*/

$(".shop-car").hover(function() {

	$(".hide").show(0, function() {
		$("hide").hover(function() {
			$(this).show();
		}, function() {
			$(this).hide();
		});
		
	});
}, function() {
	$(".hide").hide(50); 
});


/*二级分类显示模块*/
$(".close-btn").click(function(event) {
	
	$(".nav-l-list").hide();
});
$(".head-waibao").hover(function() {
	$("#nav-l-list-one").stop().show(100, function() {
		$(this).css('left', '202px');
		$("#nav-l-list-one").hover(function() {
			$(this).show();
		}, function() {
			$(this).hide();
		});
		
	});
}, function() {
	$("#nav-l-list-one").hide(50);
	$("#nav-l-list-one").css('left', '180px');
});

$(".head-tijian").hover(function() {
	$("#nav-l-list-two").stop().show(100, function() {
		$(this).css({
			"left": '202px',
			"margin-top": '-53px'
		});
		$("#nav-l-list-two").hover(function() {
			$(this).show();
		}, function() {
			$(this).hide();
		});
		
	});
}, function() {
	$("#nav-l-list-two").hide(50);
	$("#nav-l-list-two").css('left', '180px');
});

$(".head-baoxian").hover(function() {
	
	$("#nav-l-list-three").stop().show(100, function() {
		$(this).css({
			"left": '202px',
			"margin-top": '-106px'
		});
		$("#nav-l-list-three").hover(function() {
			$(this).show();
		}, function() {
			$(this).hide();
		});
		
	});
}, function() {
	$("#nav-l-list-three").hide(50);
	$("#nav-l-list-three").css('left', '180px');
});

$(".head-nian").hover(function() {
	
	$("#nav-l-list-four").stop().show(100, function() {
		$(this).css({
			"left": '202px',
			"margin-top": '-159px'
		});
		$("#nav-l-list-four").hover(function() {
			$(this).show();
		}, function() {
			$(this).hide();
		});
		
	});
}, function() {
	$("#nav-l-list-four").hide(50);
	$("#nav-l-list-four").css('left', '180px');
});



$(".head-other").hover(function() {

	$("#nav-l-list-five").stop().show(100, function() {
		$(this).css({
			"left": '202px',
			"margin-top": '-212px'
		});
		$("#nav-l-list-five").hover(function() {
			$(this).show();
		}, function() {
			$(this).hide();
		});
		
	});
}, function() {
	$("#nav-l-list-five").hide(50);
	$("#nav-l-list-five").css('left', '180px');
});




/*右侧热销榜列表*/

$(window).load(function() {//页面载入就执行
	$(".back-top").hide();
	$("#first").hide();
	

$(".lis-num li").hover(function() {
	
	$(this).children('a').hide();
	$(this).children('div').addClass('display-block');
	$(this).siblings().children('div').removeClass('display-block');
	$(this).siblings().children('a').show();
	$("#num-one").hide();	
}, function() {
	/* Stuff to do when the mouse leaves the element */
});



});
/*..................................................................................................................................*/
/*一楼,,table页切换*/
$(".con-r-h h5").each(function(index) {
	

$(this).hover(function() {
	$(this).addClass('floor-clo').siblings().removeClass("floor-clo");
	$(this).children('em').addClass('arrow-floor');
	$(this).siblings().children('em').removeClass('arrow-floor');
	$(".con-r-und .und-l").eq(index).show().siblings('.und-l').hide();
}, function() {
	/* Stuff to do when the mouse leaves the element */
});




});

/*二楼右侧标题颜色和三角颜色切换*/
$(".qing-bot h5").hover(function() {

	$(this).addClass('qing-clo').siblings().removeClass("qing-clo");
	$(this).children('em').addClass('qing-bot-arr');
	
}, function() {
	/* Stuff to do when the mouse leaves the element */
});

/*三楼右侧标题颜色和三角颜色切换*/
$(".green-bot h5").hover(function() {
	
	$(this).addClass('green-clo').siblings().removeClass("green-clo");
	$(this).children('em').addClass('green-bot-arr');
	
}, function() {
	/* Stuff to do when the mouse leaves the element */
});



/*四楼右侧标题颜色和三角颜色切换*/
$(".orange-bot h5").hover(function() {
	
	$(this).addClass('orange-clo').siblings().removeClass("orange-clo");
	$(this).children('em').addClass('oran-bot-arr');
	
}, function() {
	/* Stuff to do when the mouse leaves the element */
});





/*banner 轮播图*/
	var $keyB=0;
			var $red=0;
			var speedBanner=5000;
			var timer1=setInterval(autoplayB, speedBanner)

			function autoplayB(){
				$keyB++;
				if ($keyB>3) {
					
					$(".head .qie ul").css("left",0);
					$keyB=1;
				}
				$(".head .qie ul").stop().animate({left:-$keyB*795}, 500);

				$red++;
				
				if ($red>2) {
					$red=0;
					}
				$(".head>.qie>ol li").eq($red).addClass('current').siblings().removeClass('current');
			}
			 $(".head").hover(function() {
			 	clearInterval(timer1);
			 }, function() {
			 	clearInterval(timer1);
			 	timer1=setInterval(autoplayB, speedBanner)
			 });
			  $(".head>.qie>ol li ").mouseover(function(event) {
			  var $keyB=$(this).index();
			 
			 $(this).addClass('current').siblings().removeClass('current');
			 $(".head .qie ul").stop().animate({left:-$keyB*795}, 500);
			  });


/*.........................................................................................................................*/

/*sma-qie 轮播图*/
            var $keyS=1;
			var $circleS=1;
			$(".arrow-l").click(function(event) {
				autoplayS();
			});
			
			$(".arrow-r").click(function(event) {
				$keyS--;
				if ($keyS<0) {
					$keyS=1;
					$(".sma-qie ul ").css("left","0");
				}
				$(".sma-qie ul").stop().animate({left:-$keyS*728}, 300);

				$circleS--;
				
				if ($circleS<0) {
					$circleS=1;
					}
		});
			var speed=8000;
			var timerS=setInterval(autoplayS, speed)

			function autoplayS(){
				$keyS++;
				if ($keyS>2) {
					$keyS=1;
					$(".sma-qie ul").css("left",0);
				}
				$(".sma-qie ul").stop().animate({left:-$keyS*728}, 300);

				$circleS++;
				
				if ($circleS>1) {
					$circleS=0;
					}

			}
			 $(".sma-qie").hover(function() {
			 	clearInterval(timerS);
			 }, function() {
			 	clearInterval(timerS);
			 	timerS=setInterval(autoplayS, speed)
			 });
			  $(".sma-qie ul ").click(function(event) {
			  var $keyS=$(this).index();
			 var $circleS=$(this).index();
			 /*$(".subbanner ul li").eq($circleS).addClass('current').siblings().removeClass();*/
			 $(this).stop().animate({left:-$keyS*728}, 300);
			  });






















});