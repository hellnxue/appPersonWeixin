/*global $,window*/
'use strict';
$(function(){
	function setBg() {
		var windowWidth = $(window).width();
		var windowHeight = $(window).height();
		var iScale = windowWidth / windowHeight;
		if( windowWidth > 640 ) windowWidth = 640;
		$('html').css({
					'font-size': windowWidth / 2 + 'px'
				});
	}
	setBg();
	window.onresize = function () {
		setBg();
	};
})