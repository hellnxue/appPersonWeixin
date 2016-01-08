window.console = window.console || {}; 
console.log || (console.log = opera.postError);
//function flash()
function Comflash(flashView) {
	var _titles = flashView.find(".flashbut li");
	var _bodies = flashView.find(".flashlist li");
    var defaultOpts = {
        interval: 3000,
        fadeInTime: 'slow',
        fadeOutTime: 'slow'
    };
    var _count = _titles.length;
    var _current = 0;
    var _intervalID = null;
    var stop = function() {
        window.clearInterval(_intervalID);
    };
    var slide = function(opts) {
        if (opts) {
            _current = opts.current || 0;
        } else {
            _current = (_current >= (_count - 1)) ? 0 : (++_current);
        };
        _bodies.filter(":visible").fadeOut(defaultOpts.fadeOutTime,
        function() {
            _bodies.eq(_current).fadeIn(defaultOpts.fadeInTime);
            //_bodies.removeClass("current").eq(_current).addClass("current");
        });
        _titles.removeClass("current").eq(_current).addClass("current");
        //_titles_bg.removeClass("current").eq(_current).addClass("current");
    }; //endof slide
    var go = function() {
        stop();
        _intervalID = window.setInterval(function() {
            slide();
        },
        defaultOpts.interval);
    }; //endof go
    var itemMouseOver = function(target, items) {
        stop();
        var i = $.inArray(target, items);
        slide({
            current: i
        });
    }; //endof itemMouseOver
    _titles.hover(function() {
        if ($(this).attr('class') != 'current') {
            itemMouseOver(this, _titles);
        } else {
            stop();
        }
    },
    go);
    //_titles_bg.hover(function() { itemMouseOver(this, _titles_bg); }, go);
    _bodies.hover(stop, go);
    //trigger the slidebox
    go();
};
// 图片左右滚动
function DY_scroll(wraper, prev, next, img, speed, or) {
    var wraper = $(wraper);
    var prev = $(prev);
    var next = $(next);
    var img = $(img).find('ul');
    var w = img.find('li').outerWidth(true);
    var s = speed;
    next.click(function() {
        img.animate({
            'margin-left': -w
        },
        function() {
            img.find('li').eq(0).appendTo(img);
            img.css({
                'margin-left': 0
            });
        });
    });
    prev.click(function() {
        img.find('li:last').prependTo(img);
        img.css({
            'margin-left': -w
        });
        img.animate({
            'margin-left': 0
        });
    });
    if (or == true) {
        ad = setInterval(function() {
            next.click();
        },
        s * 1000);
        wraper.hover(function() {
            clearInterval(ad);
        },
        function() {
            ad = setInterval(function() {
                next.click();
            },
            s * 1000);
        });

    }
};

$.fn.iVaryVal=function(iSet,CallBack){
	/*
	 * Minus:点击元素--减小
	 * Add:点击元素--增加
	 * Input:表单元素
	 * Min:表单的最小值，非负整数
	 * Max:表单的最大值，正整数
	 */
	iSet=$.extend({Minus:$('.J_minus'),Add:$('.J_add'),Input:$('.J_input'),Min:1,Max:50},iSet);
	var C=null,O=null;
	//插件返回值
	var $CB={};
	//增加
	iSet.Add.each(function(i){
		$(this).click(function(){
			O=parseInt(iSet.Input.eq(i).val());
			(O+1<=iSet.Max) || (iSet.Max==null) ? iSet.Input.eq(i).val(O+1) : iSet.Input.eq(i).val(iSet.Max);
			//输出当前改变后的值
			$CB.val=iSet.Input.eq(i).val();
			$CB.index=i;
			//回调函数
			if (typeof CallBack == 'function') {
                CallBack($CB.val,$CB.index,iSet.Input.eq(i));
            }
		});
	});
	//减少
	iSet.Minus.each(function(i){
		$(this).click(function(){
			O=parseInt(iSet.Input.eq(i).val());
			O-1<iSet.Min ? iSet.Input.eq(i).val(iSet.Min) : iSet.Input.eq(i).val(O-1);
			$CB.val=iSet.Input.eq(i).val();
			$CB.index=i;
			//回调函数
			if (typeof CallBack == 'function') {
				CallBack($CB.val,$CB.index,iSet.Input.eq(i));
		  	}
		});
	});
	//手动
	iSet.Input.bind({
		'click':function(){
			O=parseInt($(this).val());
			$(this).select();
		},
		'keyup':function(e){
			if($(this).val()!=''){
				C=parseInt($(this).val());
				//非负整数判断
				if(/^[1-9]\d*|0$/.test(C)){
					$(this).val(C);
					O=C;
				}else{
					$(this).val(O);
				}
			}
			//输出当前改变后的值
			$CB.val=$(this).val();
			$CB.index=iSet.Input.index(this);
			//回调函数
			if (typeof CallBack == 'function') {
                CallBack($CB.val,$CB.index,$(this));
            }
		},
		'blur':function(){
			$(this).trigger('keyup');
			if($(this).val()==''){
				$(this).val(O);
			}
			//判断输入值是否超出最大最小值
			if(iSet.Max){
				if(O>iSet.Max){
					$(this).val(iSet.Max);
				}
			}
			if(O<iSet.Min){
				$(this).val(iSet.Min);
			}
			//输出当前改变后的值
			$CB.val=$(this).val();
			$CB.index=iSet.Input.index(this);
			//回调函数
			if (typeof CallBack == 'function') {
                CallBack($CB.val,$CB.index,$(this));
            }
		}
	});
};
function b(){
	h = $(window).height();
	t = $(document).scrollTop();
	if(t > h){
		$('#gotop').show();
	}else{
		$('#gotop').hide();
	}
}


//图片滚动 调用方法 imgscroll({speed: 30,amount: 1,dir: "up"});
$.fn.imgscroll = function(o){
	var defaults = {
		speed: 40,
		amount: 0,
		width: 1,
		dir: "left"
	};
	o = $.extend(defaults, o);
	
	return this.each(function(){
		var _li = $("li", this);
		_li.parent().parent().css({overflow: "hidden", position: "relative"}); //div
		_li.parent().css({margin: "0", padding: "0", overflow: "hidden", position: "relative", "list-style": "none"}); //ul
		_li.css({position: "relative", overflow: "hidden"}); //li
		if(o.dir == "left") _li.css({float: "left"});
		
		//初始大小
		var _li_size = 0;
		for(var i=0; i<_li.size(); i++)
			_li_size += o.dir == "left" ? _li.eq(i).outerWidth(true) : _li.eq(i).outerHeight(true);
		
		//循环所需要的元素
		if(o.dir == "left") _li.parent().css({width: (_li_size*3)+"px"});
		_li.parent().empty().append(_li.clone()).append(_li.clone()).append(_li.clone());
		_li = $("li", this);

		//滚动
		var _li_scroll = 0;
		function goto(){
			_li_scroll += o.width;
			if(_li_scroll > _li_size)
			{
				_li_scroll = 0;
				_li.parent().css(o.dir == "left" ? { left : -_li_scroll } : { top : -_li_scroll });
				_li_scroll += o.width;
			}
				_li.parent().animate(o.dir == "left" ? { left : -_li_scroll } : { top : -_li_scroll }, o.amount);
		}
		
		//开始
		var move = setInterval(function(){ goto(); }, o.speed);
		_li.parent().hover(function(){
			clearInterval(move);
		},function(){
			clearInterval(move);
			move = setInterval(function(){ goto(); }, o.speed);
		});
	});
};

var NumbersAnimate={
	Target:null,
	Numbers:0,
	Duration:500,
	Animate:function(){
		var array=NumbersAnimate.Numbers.toString().split("");
		//遍历数组
		for(var i=0;i<array.length;i++){
			var currentN=array[i];
			//数字append进容器
			var t=$("<span></span>");
			if(currentN !=='，'){
				$(t).append("<span class=\"childNumber\">"+array[i]+"</span>");
			}else{
				$(t).append("<span class=\"seg\">"+array[i]+"</span>");
			}
			$(t).css("left",21*i+"px");
			$(NumbersAnimate.Target).append(t);
			
			
			if(currentN !=='，'){
				//生成滚动数字,根据当前数字大小来定
				for(var j=0;j<=currentN;j++){
					var tt;
					
					if(j==currentN){
						 tt=$("<span class=\"main\"><span>"+j+"</span></span>");
					 }else{
						 tt=$("<span class=\"childNumber\">"+j+"</span>");
					}
					
					$(t).append(tt);
					$(tt).css("margin-top",(j+1)*34+"px");
				}
			}else{
				 tt=$("<span class=\"seg\">"+currentN+"</span>");
				 $(t).append(tt);
			}
			
			
			$(t).animate({marginTop:-((parseInt(currentN)+1)*34)+"px"},NumbersAnimate.Duration,function(){
				$(this).find(".childNumber").remove();
			});
		}
	},
	ChangeNumber:function(numbers){
		var oldArray=NumbersAnimate.Numbers.toString().split("");
		var newArray=numbers.toString().split("");
		for(var i=0;i<oldArray.length;i++){
			var o=oldArray[i];
			var n=newArray[i];
			if(o!=n){
			   var c=$($(".main")[i]);
			   var num=parseInt($(c).html());
			   //var top=parseInt($($(c).find("span")[0]).css("marginTop").replace('px', '')); 
			   var top=parseInt($($(c).find("span")[0]).css("marginTop")); 
			   
			   for(var j=0;j<=n;j++){
				   var nn=$("<span>"+j+"</span>");
				   if(j==n){
					   nn=$("<span>"+j+"</span>");
				   }else{
					   nn=$("<span class=\"yy\">"+j+"</span>");
				   }
				   $(c).append(nn);
				   $(nn).css("margin-top",(j+1)*34+top+"px");
			   }
			  //var margintop=parseInt($(c).css("marginTop").replace('px', '')); 
			  var margintop=parseInt($(c).css("marginTop"));   
			   $(c).animate({marginTop:-((parseInt(n)+1)*34)+margintop+"px"},NumbersAnimate.Duration,function(){
				   $($(this).find("span")[0]).remove();
				   $(".yy").remove();
				  });
			}
		}
		NumbersAnimate.Numbers=numbers;
	},
	
	RandomNum:function(m,a){
		var Range = a - m;   
		var Rand = Math.random();   
		return(m + Math.round(Rand * Range));   
	}
};