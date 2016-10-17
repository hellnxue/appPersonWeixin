/*var currentpage = 0;
var totalpage = 50;
$(document).ready(function() {

    $(window).scroll(function() {
        var scrollTop = $(this).scrollTop(); //滚动条距离顶部的高度
        var scrollHeight = $(document).height(); //当前页面的总高度
        var windowHeight = $(this).height(); //当前可视的页面高度
        if (scrollTop + windowHeight >= scrollHeight) { //距离顶部+当前高度 >=文档总高度 即代表滑动到底部
			ajaxRed(); //开始加载ajax
        }
    });
	
	
    function ajaxRed() {
    	console.log("延迟加载");
       // $(document).ajaxStart(function() { //ajax开始执行（此方法必须jquery1.6版本及以下可以使用，高版本不支持）
            $( ".loading_view" ).show();
       // }).ajaxStop(function() {
			$( ".loading_view" ).hide();
		//});
        currentpage++; //执行成功页码+1
        if (currentpage >= totalpage) {
            return currentpage; //判断页码是否达到限定的加载次数;
            return false;
        }
        var html = "",url=$(".page-ajax-li").attr('data-url');
        $.ajax({ async:false,  type: "GET", url: url, data: "", success: function(msg){
			$(msg).appendTo(".page-ajax-li"); //将生成的文本追加到ID table_more子级最后
		}});
        
        console.log("currentpage==========="+currentpage);
        return currentpage; //返回执行后的页码数
    }
});*/