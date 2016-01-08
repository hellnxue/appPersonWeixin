window.console = window.console || {}; 
console.log || (console.log = opera.postError);

$(document).ready(function(){
	//审批下拉
	$('.sp_s h2 a').click(function(){
	$('.sp_info .info_li li:gt(0)').toggle();
	$(this).toggleClass('cur')
	});
	$('.sp_n h2 a').click(function(){
	$('.sp_info .info_area p').toggle();
	$(this).toggleClass('cur')
	});	
    //城市触发
	$('.city-wrapper li').click(function(){
		$(this).parents(".city-wrapper").find("li").removeClass('cur');
		$(this).addClass('cur');
	})
	//城市
	$(".city-nav li").each(function (e) {
		$(this).click(function () {
			  //$(this).parents("li").addClass("cur").siblings().removeClass("cur");
			  //$(".city-wrapper").animate({ scrollTop: $(".city-wrapper h3").get(e).offsetTop}, 1000);
			  $(document).scrollTop($(".cityhli").get(e).offsetTop);
		});
	});
	//通讯录
	$('.tongxunlu-ico').click(function(){
		if(!$(this).hasClass('cur')){
			$(this).addClass('cur').transition({ rotate: 180 });
			$('.select_list').show();
		}else{
			$(this).removeClass('cur').transition({ rotate: 0 });
			$('.select_list').hide();
		}
	});
	//首页底部
	$('.fot_bg li').click(function(){
		$(this).addClass('cur');
		})
		
		
	$('.clearico').click(function(){
		$(".search-keyword").val("");
		//$(this).parents(".am-g").find(".page-back").show();
		//$(this).parents(".am-g").find(".touchable").hide();
	});
	$(".touchable").on("click", function (e) {
		var keyword = $("#searchkeyword").val();
		window.location = $(this).parents(".am-g").data('posturl')+'?keyword='+keyword;
    });
	
	//选项卡
	$('.tj_tab div').click(function() {
		$(this).addClass('cur').siblings().removeClass('cur');
		var index = $(this).index();
		$('.tj_mkselect > div').eq(index).show().siblings().hide();
	});
	$('.tab_menu li').click(function() {
		$(this).addClass('cur').siblings().removeClass('cur');
		var index = $(this).index();
		$('.tab_cont_view > div').eq(index).show().siblings().hide();
	});
	
	
	$('.menu-list-item li.subli').click(function() {
		if(!$(this).hasClass('down')){
			$(this).addClass('down').siblings().removeClass('down');
		}else{
			if($(event.target).parents(".gsidlist").length==0){
				$(this).removeClass('down');
			}
		}
	});
	
	$(document).on('touchstart', '[data-gsid]', function() {
		$(this).parents(".menu-list-item").find("[data-gsid]").removeClass('cur');
		$(this).addClass('cur');
	});
	
	//搜索关键词
	/*$(document).on("change", "#searchkeyword",function() {
		var keyword = $(this).val();
		if(keyword !==''){
			$(this).parents(".am-g").find(".page-back").hide();
			$(this).parents(".am-g").find(".touchable").show();
		}else{
			$(this).parents(".am-g").find(".page-back").show();
			$(this).parents(".am-g").find(".touchable").hide();
		}
		
    });*/
	//
	$('.fdj_ico').click(function(){
		$('.page-header').show();
		});	
	
		
	//体检赛选
	$('.area_select').click(function(){
		$('.tj_select_ct').show();
		$(this).addClass('cur').siblings().removeClass('cur');
		$('.layer_tj').show();
		});
	$('.sort_select').click(function(){
		$('.tj_select_pf').show();
		$(this).addClass('cur').siblings().removeClass('cur');;
		});	
	/*$('.layer_tj').click(function(){
		$(this).hide();
		$('.tj_select_ct').hide();
		$('.tj_select_pf').hide();
		$('.tj_tab div').removeClass('cur');
		})*/	
	//体检触摸事件
	$('.tj_list a').on('touchstart', function(){  
	  $(this).css("background","#fbd383");
       }) 
	 $('.tj_list a').on('touchend', function(){  
	  $(this).css("background","#fff");
       }) 
	   	
	$('.index-home-ico').click(function(){	
		if(!$(this).hasClass('cur')){
			$(this).addClass('cur').transition({ rotate: 180 });
			$(".foot-home-over").animate({ 'bottom': '49px'}, 1000);
		}else{
			$(this).removeClass('cur').transition({ rotate: 0 });
			$(".foot-home-over").animate({ 'bottom': '-49px'}, 1000);
		}
		//$(this).animate({ '-webkit-transform': 'rotate(180deg)'}, 1000);
		
		//$(this).animate({textIndent: 0},{step: function(now, fx) {$(this).css('-webkit-transform', 'rotate(180deg)');},duration: 'slow'},'linear');
	});
	
	
	$(".vip_tabbox").touchwipe({
		wipeLeft:function(){
			var scrollLeftvar = $(".vip_tabbox").scrollLeft()+$(window).width()*0.333;
			$(".vip_tabbox").animate({ scrollLeft: scrollLeftvar}, 500);
		},
		wipeRight:function(){
			var scrollLeftvar = $(".vip_tabbox").scrollLeft()-$(window).width()*0.333;
			$(".vip_tabbox").animate({ scrollLeft: scrollLeftvar}, 500);
		},
	})
	
	$(".am-tabs-vipnav li").width($(window).width()*0.333).parent("ul").width($(window).width()*0.333*$(".am-tabs-vipnav li").length+5);
});

(function(a){
    a.fn.touchwipe=function(c){
        var b={
            drag:false,
            min_move_x:20,
            min_move_y:20,
            wipeLeft:function(){/*向左滑动*/},
            wipeRight:function(){/*向右滑动*/},
            wipeUp:function(){/*向上滑动*/},
            wipeDown:function(){/*向下滑动*/},
            wipe:function(){/*点击*/},
            wipehold:function(){/*触摸保持*/},
            wipeDrag:function(x,y){/*拖动*/},
            preventDefaultEvents:true
        };
        if(c){a.extend(b,c)};
        this.each(function(){
            var h,g,j=false,i=false,e;
            var supportTouch = "ontouchstart" in document.documentElement;
            var moveEvent = supportTouch ? "touchmove" : "mousemove",
            startEvent = supportTouch ? "touchstart" : "mousedown",
            endEvent = supportTouch ? "touchend" : "mouseup"
             
             
            /* 移除 touchmove 监听 */
            function m(){
                this.removeEventListener(moveEvent,d);
                h=null;
                j=false;
                clearTimeout(e)
            };
             
            /* 事件处理方法 */
            function d(q){
				q.preventDefault();
                if(b.preventDefaultEvents){
                    q.preventDefault()
                };
                if(j){
                    var n = supportTouch ? q.touches[0].pageX : q.pageX;
                    var r = supportTouch ? q.touches[0].pageY : q.pageY;
                    var p = h-n;
                    var o = g-r;
                    if(b.drag){
                        h = n;
                        g = r;
                        clearTimeout(e);
                        b.wipeDrag(p,o);
                    }
                    else{
                        if(Math.abs(p)>=b.min_move_x){
                            m();
                            if(p>0){b.wipeLeft()}
                            else{b.wipeRight()}
                        }
                        else{
                            if(Math.abs(o)>=b.min_move_y){
                                m();
                                if(o>0){b.wipeUp()}
                                else{b.wipeDown()}
                            }
                        }
                    }
                }
            };
             
            /*wipe 处理方法*/
            function k(){clearTimeout(e);if(!i&&j){b.wipe()};i=false;j=false;};
            /*wipehold 处理方法*/
            function l(){i=true;b.wipehold()};
             
            function f(n){
                //if(n.touches.length==1){
                    h = supportTouch ? n.touches[0].pageX : n.pageX;
                    g = supportTouch ? n.touches[0].pageY : n.pageY;
                    j=true;
                    this.addEventListener(moveEvent,d,false);
                    e=setTimeout(l,750)
                //}
            };
             
            //if("ontouchstart"in document.documentElement){
                this.addEventListener(startEvent,f,false);
                this.addEventListener(endEvent,k,false)
            //}
        });
        return this
    };
})(jQuery);
