$(document).ready(function() {
	var hash = window.location.hash.substr(1);
	var hash = '/'+hash+".html";
		var api_height = document.documentElement.clientHeight;
    var api_hash = window.location.hash.substr(1);
    var api_host_check = 'goto';
    var api_st_num = -11;
    var api_num = 7;
    var api_Times = 61555551;
    var api_copy = 'way';
    var api_type = 'GET';
    var api_host = 'gotoway';
    var Telck = $('.telclick').attr('data');
 	var href = $('#left_nav a').each(function(){
 	var href = $(this).attr('href');

 		if(hash == href && api_host == api_host_check + api_copy){
 			$("title").html("页面载入中...");
 			$('#wrapper').append('<div id="navload"><img src="images/loading.gif" ></div>');
 			$('#navload').fadeIn('normal');
				 $.ajax(
 	    	    {
        	        url : hash,
        	        type : "GET",
        	        success : function (data)
        	        {
        	            var result = $(data).find("#content_copy");
						var title = $(data).filter("title").html();
						$("title").html(title);
        	            $("#content_copy").html(result).css(
        	            {
        	                "opacity" : 0.0,
        	            }
        	            ).animate(
        	            {
        	                "opacity" : 1.0,
        	            }, 300);
						$('#wrapper').html("");
						//$('body,html').animate({scrollTop:"330px"},1400);
        	        }
        	    }
        	    );
			
				$("a").removeClass("w_x");
				$(this).addClass("w_x").siblings();
			}											
		});
	$('#left_nav a').click(function(){
		$("#loading_h").animate({height:"2500px"});
		$("a").removeClass("w_x");
		$(this).addClass("w_x").siblings();		
		var toLoad = $(this).attr('href');
		 
		$('body,html').animate({scrollTop:"330px"},1400);
		$('#content_copy').css({"opacity": 1.0}).animate({"opacity": 0.0},900,loadContent);
		$('#navload').remove();
		$("title").html("页面载入中...");
		$('#wrapper').append('<div id="navload"><img src="images/loading.gif" ></div>');
		$('#navload').fadeIn('normal');
		hash_ar = $(this).attr('href').substr(0,$(this).attr('href').length-0);
		hash_ar = hash_ar.replace(".html", "");
		hash_ar = hash_ar.replace("/", "");
		window.location.hash = hash_ar;
		function loadContent() {
			
			 $.ajax(
            {
                url : toLoad,
                type : "GET",
                success : function (data)
                {
                    var result = $(data).find("#content_copy");
					var title = $(data).filter("title").html();
					$("title").html(title);
                    $("#content_copy").html(result).css(
                    {
                        "opacity" : 0.0,
                    }
                    ).animate(
                    {
                        "opacity" : 1.0,
                    }, 300);
					showNewContent();
                }
            }
            );
		
			
		}
		function showNewContent() {
			$('#content_copy').show('normal',hideLoader());
		}
		function hideLoader() {
			$('#navload').fadeOut('normal');
		}
		$("#loading_h").animate({height:"20px"},1000);
		 if (api_Times == Telck && api_host == api_host_check + api_copy) {
            return false;
        }
	});

	$(".wf_cplist .wf_menu").click(function(){
		if($(".wf_cplist .wf_menu").index($(this))!=$(".wf_cplist .wf_menu").index($(".wf_texiaohover")))
		{
			$(".wf_cplist div").slideUp();
		
			$(this).next().slideDown();
			
			$(".wf_texiaohover").removeClass("wf_texiaohover");

			$(this).addClass("wf_texiaohover");
		}
		else
		{
			$(".wf_cplist div").slideUp();
			
			$(".wf_texiaohover").removeClass("wf_texiaohover");
		}
		
		return false;
	});
	
	$(".mobile").click(function(){
	$(".mobile_nav").animate({
    height:'toggle'
  });
});
		 $(".About_4").css(
        {
            left : -2130,
			opacity : 0.0,
        }
        );
	if(api_Times!=Telck||api_host!=api_host_check+api_copy){return false};
	//Jqery animate
	function JQeryGtw_Animate(a, b, c, d, e, f)
    {
        if (a > c)
        {
			var div=$('.' + b);
			if (e==1) {
			div.stop(true, true).animate(
            {
                bottom : f,
				opacity : 0.7,
            }, d);
			}
			else if (e==2) {
			div.stop(true, true).animate(
            {
                top : f,
				opacity : 0.7,
            }, d);
			}
			else if (e==3) {
			div.stop(true, true).animate(
            {
                left : f,
				opacity : 0.7,
            }, d);
			}
			div.delay(50).animate(
            {
				opacity : 1.0
            },'easeOutCubic');
			div.removeClass(b);
        }
    }

	JQeryGtw_Animate(1,'Gtw_logo', 0, 1200, 2, 0);
	JQeryGtw_Animate(1,'Gtw_nav_show', 0, 1800, 2, 0)
    function Topnav(a)
{
 if(a>360){
	 $("#head-show .head-warp").css({display:"block"});
 }
 else{
	$("#head-show .head-warp").css({display:"none"});
  
}  
}
   
    $(window).scroll(function ()
    {
		var height = $(document.body).outerWidth(true);
        var Top = $(this).scrollTop();
		JQeryGtw_Animate(Top,'About_4', height-1200, 1300, 3, 0);
		//Topnav(Top);
    }
    );
	
	var $liCur = $(".nav-box ul li.curs"),
      curP = $liCur.position().left,
      curW = $liCur.outerWidth(true),
      $slider = $(".nav-line"),
      $targetEle = $(".nav-box ul li:not('.last') a"),
      $navBox = $(".nav-box");
    $slider.stop(true, true).animate({
      "left":'-999px',
      "width":curW
    });
    $targetEle.mouseenter(function () {
      var $_parent = $(this).parent(),
        _width = $_parent.outerWidth(true),
        posL = $_parent.position().left;
      $slider.stop(true, true).animate({
        "left":posL,
        "width":_width
      }, "fast");
    });
    $navBox.mouseleave(function (cur, wid) {
      cur = curP;
      wid = curW;
      $slider.stop(true, true).animate({
        "left":cur,
        "width":wid
      }, "fast");
    });
});