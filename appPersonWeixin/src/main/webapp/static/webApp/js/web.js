$(document).ready(function(){
//屏幕自适应
var minheight = parseInt($(window.parent).height())-parseInt($(window.parent.document).find("header").outerHeight())-parseInt($(window.parent.document).find("footer").outerHeight());
var main = $(window.parent.document).find(".pages_cont");
main.css("min-height",minheight);


$('.sp_s h2 a').toggle(function(){
	$('.sp_info .info_li li:gt(0)').hide();
	$(this).addClass('cur')
	},function(){	
	$('.sp_info .info_li li:gt(0)').show()
	$(this).removeClass('cur')
	})
	
$('.sp_n h2 a').toggle(function(){
	$('.sp_info .info_area p').hide();
	$(this).addClass('cur')
	},function(){	
	$('.sp_info .info_area p').show()
	$(this).removeClass('cur')
	})	
});


