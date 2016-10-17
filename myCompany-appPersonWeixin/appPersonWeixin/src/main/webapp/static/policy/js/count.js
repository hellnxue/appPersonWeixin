function initFun(){



/*管理界面切换*/
    $('.count-footer li').click(function(e){
        $(window.parent).scrollTop(320);//让屏幕卷曲的上边高度等于292px
        

        var customer = $('.count-footer .customer');
        customer.each(function(){
            if($(this).find('.btn').data('fixed') == 1){
               
                $(this).find('.customer').stop().slideDown().animate({
                },{
                easing: $(this).attr('rel'),
                duration: 1000
            });
            } else {
                $(this).stop().slideUp(200);
            }
        });
        $(this).find('.customer').stop().slideDown().animate({
                },{
                easing: $(this).attr('rel'),
                duration: 1000
            });
    });



    $(".customer .btn").click(function(){


        if(!$(this).data('fixed')){
            console.log($(this));
            $(this).addClass('bg-change');
            $(this).data('fixed', 1);
        } else {
            $(this).removeClass('bg-change');
            $(this).data('fixed', 0);
        }

   
    });

    /*中部月份切换*/

    var $leng=2;
    var $rig=1;
//    $("#year_last").click(function(event) {
//    	calDate(-1,'Y');
//    });
//    $("#year_next").click(function(event) {
//    	calDate(1,'Y');
//    });
    $("#month_last").click(function(event) {
    	calDate(-1,'M');
    });
    $("#month_next").click(function(event) {
    	calDate(1,'M');
    });





 //缓动函数
    jQuery.easing.jswing=jQuery.easing.swing;jQuery.extend(jQuery.easing,{def:"easeOutQuad",swing:function(e,f,a,h,g){return jQuery.easing[jQuery.easing.def](e,f,a,h,g)},easeInQuad:function(e,f,a,h,g){return h*(f/=g)*f+a},easeOutQuad:function(e,f,a,h,g){return -h*(f/=g)*(f-2)+a},easeInOutQuad:function(e,f,a,h,g){if((f/=g/2)<1){return h/2*f*f+a}return -h/2*((--f)*(f-2)-1)+a},easeInCubic:function(e,f,a,h,g){return h*(f/=g)*f*f+a},easeOutCubic:function(e,f,a,h,g){return h*((f=f/g-1)*f*f+1)+a},easeInOutCubic:function(e,f,a,h,g){if((f/=g/2)<1){return h/2*f*f*f+a}return h/2*((f-=2)*f*f+2)+a},easeInQuart:function(e,f,a,h,g){return h*(f/=g)*f*f*f+a},easeOutQuart:function(e,f,a,h,g){return -h*((f=f/g-1)*f*f*f-1)+a},easeInOutQuart:function(e,f,a,h,g){if((f/=g/2)<1){return h/2*f*f*f*f+a}return -h/2*((f-=2)*f*f*f-2)+a},easeInQuint:function(e,f,a,h,g){return h*(f/=g)*f*f*f*f+a},easeOutQuint:function(e,f,a,h,g){return h*((f=f/g-1)*f*f*f*f+1)+a},easeInOutQuint:function(e,f,a,h,g){if((f/=g/2)<1){return h/2*f*f*f*f*f+a}return h/2*((f-=2)*f*f*f*f+2)+a},easeInSine:function(e,f,a,h,g){return -h*Math.cos(f/g*(Math.PI/2))+h+a},easeOutSine:function(e,f,a,h,g){return h*Math.sin(f/g*(Math.PI/2))+a},easeInOutSine:function(e,f,a,h,g){return -h/2*(Math.cos(Math.PI*f/g)-1)+a},easeInExpo:function(e,f,a,h,g){return(f==0)?a:h*Math.pow(2,10*(f/g-1))+a},easeOutExpo:function(e,f,a,h,g){return(f==g)?a+h:h*(-Math.pow(2,-10*f/g)+1)+a},easeInOutExpo:function(e,f,a,h,g){if(f==0){return a}if(f==g){return a+h}if((f/=g/2)<1){return h/2*Math.pow(2,10*(f-1))+a}return h/2*(-Math.pow(2,-10*--f)+2)+a},easeInCirc:function(e,f,a,h,g){return -h*(Math.sqrt(1-(f/=g)*f)-1)+a},easeOutCirc:function(e,f,a,h,g){return h*Math.sqrt(1-(f=f/g-1)*f)+a},easeInOutCirc:function(e,f,a,h,g){if((f/=g/2)<1){return -h/2*(Math.sqrt(1-f*f)-1)+a}return h/2*(Math.sqrt(1-(f-=2)*f)+1)+a},easeInElastic:function(f,h,e,l,k){var i=1.70158;var j=0;var g=l;if(h==0){return e}if((h/=k)==1){return e+l}if(!j){j=k*0.3}if(g<Math.abs(l)){g=l;var i=j/4}else{var i=j/(2*Math.PI)*Math.asin(l/g)}return -(g*Math.pow(2,10*(h-=1))*Math.sin((h*k-i)*(2*Math.PI)/j))+e},easeOutElastic:function(f,h,e,l,k){var i=1.70158;var j=0;var g=l;if(h==0){return e}if((h/=k)==1){return e+l}if(!j){j=k*0.3}if(g<Math.abs(l)){g=l;var i=j/4}else{var i=j/(2*Math.PI)*Math.asin(l/g)}return g*Math.pow(2,-10*h)*Math.sin((h*k-i)*(2*Math.PI)/j)+l+e},easeInOutElastic:function(f,h,e,l,k){var i=1.70158;var j=0;var g=l;if(h==0){return e}if((h/=k/2)==2){return e+l}if(!j){j=k*(0.3*1.5)}if(g<Math.abs(l)){g=l;var i=j/4}else{var i=j/(2*Math.PI)*Math.asin(l/g)}if(h<1){return -0.5*(g*Math.pow(2,10*(h-=1))*Math.sin((h*k-i)*(2*Math.PI)/j))+e}return g*Math.pow(2,-10*(h-=1))*Math.sin((h*k-i)*(2*Math.PI)/j)*0.5+l+e},easeInBack:function(e,f,a,i,h,g){if(g==undefined){g=1.70158}return i*(f/=h)*f*((g+1)*f-g)+a},easeOutBack:function(e,f,a,i,h,g){if(g==undefined){g=1.70158}return i*((f=f/h-1)*f*((g+1)*f+g)+1)+a},easeInOutBack:function(e,f,a,i,h,g){if(g==undefined){g=1.70158}if((f/=h/2)<1){return i/2*(f*f*(((g*=(1.525))+1)*f-g))+a}return i/2*((f-=2)*f*(((g*=(1.525))+1)*f+g)+2)+a},easeInBounce:function(e,f,a,h,g){return h-jQuery.easing.easeOutBounce(e,g-f,0,h,g)+a},easeOutBounce:function(e,f,a,h,g){if((f/=g)<(1/2.75)){return h*(7.5625*f*f)+a}else{if(f<(2/2.75)){return h*(7.5625*(f-=(1.5/2.75))*f+0.75)+a}else{if(f<(2.5/2.75)){return h*(7.5625*(f-=(2.25/2.75))*f+0.9375)+a}else{return h*(7.5625*(f-=(2.625/2.75))*f+0.984375)+a}}}},easeInOutBounce:function(e,f,a,h,g){if(f<g/2){return jQuery.easing.easeInBounce(e,f*2,0,h,g)*0.5+a}return jQuery.easing.easeOutBounce(e,f*2-g,0,h,g)*0.5+h*0.5+a}});



};

/**
 * 计算年份/月份
 * type     类型： “Y”-年份，“M”-月份
 * date		当前检索日期，格式：YYYY-MM
 * arg		月份加数值，值： 1下一月、-1上一月
 * */
function calDate(arg,type){
	var now_year = $("#now_year span").text();
	var now_month = $("#now_month b").text();
	if( type != null && arg != null ){
		if( type == 'Y' ){
			now_year = parseInt(now_year) + parseInt(arg);
		}else if( type == 'M' ){
			now_month = parseInt(now_month) + parseInt(arg);
			if( now_month > 12 ){//如果月份大于12月了，则加1年，月份修改为1月
				now_month = 1;
				now_year = parseInt(now_year) + 1;
			}else if( now_month == 0 ){//如果月份小于1月了，则减1年，月份修改为12月
				now_month = 12;
				now_year = parseInt(now_year) - 1;
			}
		}
		var newDate = now_year + "-" + now_month;
		$("#searchDate").val(newDate);
		$("#now_year span").text(now_year);
		$("#now_month b").text(now_month);
		getTaskData();
	}
};

function getTaskData(){
	if( searchDate != null ){
		var side = $.cookie('side');
		if( side == null || side == undefined ){side=2;}
		var month = $('#searchDate').val();
		var urlStr = path + "/task/getTaskByMonty.do?side="+side+"&month="+month;
		$.ajax({
			type:"post",
			url : urlStr,
			dataType:"json",
			success : function(response){
				if( response.success && response.result ){
					var _taskArr = response.result.split(",");
					if( _taskArr != null && _taskArr.length > 0 ){
						$(_taskArr).each(function(i) {
							var _taskObj = _taskArr[i];
							if( _taskObj != null ){
								var _arr = _taskObj.split(":");
								if( _arr != null && _arr.length == 2 ){
									$("#"+_arr[0]).text(_arr[1]);
								}
							}
						});
					}
				}
			},
			error : function(xhr, statusText, error){
				alert(statusText);
			}
		});
	}
};

function toStr( obj ){
	if( obj == undefined || obj == null ){
		return "";
	}else{
		return obj.toString();
	}
};

function toInt( obj ){
	if( obj == undefined || obj == null || obj == "" ){
		return 0;
	}else{
		return parseInt(obj);
	}
};

function setCount( obj ){
	var now_year = $("#now_year span").text();
	var now_month = $("#now_month b").text();
	return parseInt(toInt(obj) / parseInt(now_month) + parseInt(now_year) / 100 );
};

function loadTask(){
	setCaidangClass();
	var side = $.cookie('side');
	if( side == null || side == undefined ){side=2;}
	$.ajax({
		type:"post",
		url : path + "/task/query.do?side="+side,
		dataType:"json",
		success : function(response){
			if(response.success){
				var result = response.result;
				
				var searchDate = response.searchDate;
				if( searchDate != null ){
					$("#searchDate").val(searchDate);
					var arr = searchDate.split("-");
					$("#now_year span").text(arr[0]);
					$("#now_month b").text(arr[1]);
				}
				
				var task = result.task;
				var htmlStr = "";
				var _taskGroup = 1;
				if( task != null && task.length > 0 ){
					htmlStr += "<li>";
					$(task).each(function(i) {
						var _taskObj = task[i];
						if( _taskGroup != _taskObj.taskGroup ){
							htmlStr += "</li><li>";
							_taskGroup = _taskObj.taskGroup;
						}
						if( toInt(_taskObj.isTitle) == 1 ){
							htmlStr += "<h3>" + toStr(_taskObj.taskName) + "</h3>";
						}else{
							htmlStr += "<p>" + toStr(_taskObj.taskName) + "：<span id=\"" + toStr(_taskObj.taskCode) + "\">0</span></p>";
						}
					});
					htmlStr += "</li>";
				}
				$("#task").html(htmlStr);
				
				/*
				var task = result.task;
				var htmlStr = "";
				if( task != null ){
					$(task).each(function(i) {
						var data = task[i].data;
						htmlStr += ""
							+ "<li>"
							+ "<h3>" + toStr(task[i].name) + "</h3>"
							+ "<p>总计： <span class=\"total-clo\">" + setCount(data.orderCount) + "</span></p>"
							+ "<p>未生成：<span>" + setCount(data.notGenerate) + "</span></p>"
							+ "<p>已生成：<span>" + setCount(data.generate) + "</span></p>"
							+ "<p>已发送：<span>" + setCount(data.send) + "</span></p>"
							+ "<p>已确认：<span>" + setCount(data.confirm) + "</span></p>"
							+ "</li>";
					});
				}
				$("#task").html(htmlStr);
				*/
				var notice = result.notice;
				var bool = false;
	        	if( notice != null ){
	        		var htmlStr1 = "";
					var htmlStr2 = "";
					var htmlStr3 = "";
					var htmlStr4 = "";
					var htmlStr5 = "";
	        		var classArr = ["one","two","three","four","five"];
	        		var nameArr = ["业务","订单","财务","待办","工具"];
	        		$(notice.orgFunction).each(function(i) {
	        			var _orgBloks = notice.orgFunction.orgFunctions;
	        			if( _orgBloks != null ){
	        				$(_orgBloks).each(function(j) {
	        					var _orgBlok = _orgBloks[j];
	        					if( _orgBlok != null ){
	        						var _intoArea = parseInt(toInt(_orgBlok.intoArea)-1);
	        						htmlStr = ""
		        	        			+ "<li>"
		        	        			+ "<a href=\"javascript:\" class=\"" + classArr[_intoArea] + "\">"
		        	        			+ "    <h3><!-- 订单 --></h3>"
		        	        			+ "</a>"
		        	        			+ "<div class=\"customer\" style=\"display:none\"rel=\"easeInOutBack\">"
		        	        			+ "    <h4>"
		        	        			+ "        <button class=\"btn\"><!-- &#xf005b; --></button>"
		        	        			+ nameArr[_intoArea]
		        	        			+ "    </h4>"
		        	        			+ "    <ol>";
		        					
		        					var _orgs = _orgBlok.orgFunctions;
		        					if( _orgs != null ){
		        						var bool = false;
		        						$(_orgs).each(function(k) {
		        							var _org = _orgs[k];
		        							if( _org != null ){
		        								if( bool ){
    	        									htmlStr += "<ul class=\"line-gray\"></ul></li>";
    	        								}
		        								bool = true;
		        								htmlStr += ""
				        							+ "<li><h5><a href=\"javascript:jump('"+_org.functionId+"','"+_org.functionName+"','"+_org.linkUrl+"')\">" 
    	        									+ toStr(_org.functionName) + "</a></h5>";
			        							var _orgChis = _org.orgFunctions;
			    	        					if( _orgChis != null ){
			    	        						$(_orgChis).each(function(n) {
			    	        							var _orgChi = _orgChis[n];
			    	        							if( _orgChi != null ){
			    	        								htmlStr += " <a href=\"javascript:jump('"+_orgChi.functionId+"','"+_orgChi.functionName+"','"+_orgChi.linkUrl+"')\">"  
		    	        									+ toStr(_orgChi.functionName);
			    	        								if( toInt(_orgChi.countSql) > 0 ){
			    	        									htmlStr += "<i class=\"custom-bg-b\"><span id=\"org-count-" +_orgChi.functionId+ "\">0</span></i>";
			    	        								}
			    	        								htmlStr += "</a>";
			    	        							}
			    	        						});
			    	        					}
		        							}
		        						});
		        					}
		        					htmlStr += ""
		        	        			+ "    </ol>"
		        	        			+ "</div>"
		        	        			+ "</li>"
		        	        			;
	        					}
	        					if( _intoArea == 0 ){
	        						htmlStr1 = htmlStr;
	        					}else if( _intoArea == 1 ){
	        						htmlStr2 = htmlStr;
	        					}else if( _intoArea == 2 ){
	        						htmlStr3 = htmlStr;
	        					}else if( _intoArea == 3 ){
	        						htmlStr4 = htmlStr;
	        					}else if( _intoArea == 4 ){
	        						htmlStr5 = htmlStr;
	        					}
	        				});
	        			}
	        		});
	        		htmlStr = htmlStr1 + htmlStr2 + htmlStr3 + htmlStr4 + htmlStr5;
	        		$("#notice").html(htmlStr);
	        		initFun();
	        		
	        		/**********加载统计数据**********/
	        		$("#task").append("<input type=\"hidden\" id=\"taskCount\"/>");
	        		$("#taskCount").ready(function(){
	        			if( task != null && task.length > 0 ){
	        				getTaskData();
	        			}
	        		});
	        	
	        		/**********加载面板数据**********/
	        		$("#notice").append("<input type=\"hidden\" id=\"blockArr\"/>");
	        		$("#blockArr").ready(function(){
	        			var blockArr = notice.blockArr;
	        			$(this).val(blockArr);
	        			//延时加载数据
		        		$(blockArr).each(function(n) {
		        			var types = blockArr[n];
		        			var blockType = n;
		        			var side = $.cookie('side');
		        			if( side == null || side == undefined ){side=2;}
		        			var urlStr = path + "/task/lazyLoadCount.do?side="+side+"&blockType="+blockType+"&types="+types;
		        			if( toStr(types).length > 0 ){
		        				$.ajax({
				        			type:"post",
				        			url : urlStr,
				        			dataType:"json",
				        			success : function(response){
				        				if(response.success){
				        					var result = response.result;
				        					if( result != null && result.length > 0 ){
				        						var _arr = result.split(",");
				        						if( _arr != null && _arr.length > 0 ){
				        							$(_arr).each(function(m) {
				        								if( _arr[m] != null ){
				        									var _orgArr = _arr[m].split(":");
				        									if( _orgArr != null && _orgArr.length == 2 && _orgArr[0] != null && _orgArr[1] != null ){
				        										$("#org-count-"+_orgArr[0]).text(_orgArr[1]);
				        									}
				        								}
				        							});
				        						}
				        					}
				        				}
				        			},
			        				error : function(xhr, statusText, error){
			        					alert(statusText);
			        				}
			        			});
		        			}
		        		});
	        		});
	        	}
			}else{
				alert(response.message);
			}
		},
		error : function(xhr, statusText, error){
			alert(statusText);
		}
	});	
};

function jump(id,name,url){
	/*var id = toStr(org.functionId);
	var name = toStr(org.functionName);
	var url = toStr(org.linkUrl);*/
	if(url == "null"){
		return;
	}
	var cookieId = $.cookie("side");
	if(cookieId==null||cookieId==undefined){cookieId=2;}
	parent.$(".zhuce").show();
	parent.$("#leftMenu").show();
	//parent.$("#rightMenu").show();
	parent.$("#iframeCount").hide();
	if(cookieId == 1){
		id = "WT"+id;
		parent.$("#wtBut").click();
		parent.$("#div_pannelWT").show();
		parent.CreateDivWT(id,url,name,'link');
		return;
	}else{
		parent.$("#stBut").click();
		parent.$("#div_pannel").show();
		parent.CreateDiv(id,url,name,'link');
	}
}

/**
 * 加载公告数据
 * */
function getAnnouncement(){
	var urlStr = path + "/task/getAnnouncement.do?pageSize=4&pageNo=1";
	$.ajax({
		type:"post",
		url : urlStr,
		dataType:"json",
		success : function(response){
			if(response.success){
				var result = response.result;
				if( null != result && result.length > 0 ){
					var htmlStr = "";
					$(result).each(function(i){
						var obj = result[i];
						htmlStr += "<li title=\""+obj.title+"\"><a href=\""+path+"/announcement/detailAnnouncement.do?annId="+obj.id+"\"  target=\"_blank\" >"+subString(obj.title)+"</a></li>";
					});
					$(".gonggao>ul").html(htmlStr);
				}
			}
		},
		error : function(xhr, statusText, error){
			alert(statusText);
		}
	});
}

/**
 * 修改委托方或受托方
 * */
function changeSide(side){
	//修改COOKIE
	$.cookie('side',side);
	loadTask();
}

/**
 * 设置菜单样式
 * */
function setCaidangClass(){
	var side = $.cookie('side');
	var className = "dq";
	var addIndex = 0;
	var delIndex = 1;
	if( side == 1 ){
		className = "dq1";
		addIndex = 1;
		delIndex = 0;
	}
	$(".caidang li:eq("+addIndex+")").attr("class",className);
	$(".caidang li:eq("+delIndex+")").attr("class",null);
}

/**
 * 根据字符串获取长度
 * */
function subString(s) { 
	var m = 0;
	var n = 0;
	var a = s.split("");
	//显示的汉子最多为15个，  5个数字=3个汉子
	//每次将得到的数字或字母的个数转成汉字的个数，然后再加上当前已有的汉字个数，总数不超过15个
	for (var i=0;i<a.length;i++) { 
		if( (n * 3 / 5 + m ) <= 15 ){
			if (a[i].charCodeAt(0)<299) { 
				n++; 
			}else{
				m++;
			}
		}
	}
	return s.substr(0,n+m);
}