$(document).ready(function() {


/*table切换----1*/
	var one=1;
	$(".cont_header .all_people").click(function(event) {
		$(this).addClass('current').siblings('li').removeClass('current');
		$("div.cont_detail_left").show().siblings('.private_content_list,.call_log_list').hide();
	$(".cont_detail_right").show();
	$(".footer").show();
	$(".footer2,.footer3").hide();
		one=1;
	});


	/*table切换----2*/
	$(".cont_header .private").click(function(event) {
		$(this).addClass('current').siblings('li').removeClass('current');
		$("div.private_content_list").show().siblings('.cont_detail_left,.call_log_list').hide();
	$(".cont_detail_right").show();
	$(".footer2").show();
	$(".footer,.footer3").hide();
		one=2;
	});


	/*table切换----3*/
	$(".cont_header .call_log").click(function(event) {
		$(this).addClass('current').siblings('li').removeClass('current');
		$("div.call_log_list").show().siblings('.cont_detail_left,.private_content_list').hide();
		$(".cont_detail_right").hide();
		$(".footer3").show();
		$(".footer2,.footer").hide();
		one=3;
	});

	/*箭头切换功能*/
	/*此处是自定义箭头切换函数*/
	left=function(){
		$(".all_people").addClass('current').siblings().removeClass('current');
		$(".cont_detail_left ").show();
		$(".call_log_list,.private_content_list").hide();
		$(".footer,.cont_detail_right").show();
		$(".footer2,.footer3").hide();
	}

	mid=function(){
		$(".private").addClass('current').siblings().removeClass('current');
		$(".private_content_list").show();
		$(".cont_detail_left ,.call_log_list ").hide();
		$(".footer2,.cont_detail_right").show();
		$(".footer3,.footer").hide();
	}
	right=function(){
		$(".call_log").addClass('current').siblings().removeClass('current');
		$(".call_log_list").show();
		$(".cont_detail_left ,.private_content_list,.cont_detail_right").hide();
		$(".footer3").show();
		$(".footer2,.footer").hide();
	}


	/*$(".right_arr").click(function(event) {
		if (one==1) {
			mid();
			one=2;
		}else if (one==2) {
			right();
			one=3;
		}else if (one==3) {
			left();
			one=1;
		};
	});*/
	
	$(".right_arr").click(function(event) {
		if (one==1) {
			mid();
			one=2;
		}else if (one==2) {
			left();
			one=1;
		};
	});

	/*$(".left_arr").click(function(event) {
		if (one==1) {
			right();
			one=3;
		}else if (one==2) {
			left();
			one=1;
		}else if (one==3) {
			mid();
			one=2;
		};
	});*/
	
	$(".left_arr").click(function(event) {
		if (one==1) {
			mid();
			one=2;
		}else if (one==2) {
			left();
			one=1;
		};
	});
	
	$(".add").click(function(event) {
//		parent.parent.openUrlInFrameTab("com.hrhelper.hro.view.conference.Linkman.d", "新建报价单-受托方", null,null);
	});
	
	
	//查询公用联系人
	queryLinkmanUser(1);
	queryLinkman(1);
});

var publicLinkman = '' + 
	'<dl>' + 
		'<dt></dt>' + 
		'<dd>' + 
			'<p class="content_name">_NICK_NAME_</p>' + 
			'<p class="ID">_ROLE_NAMES_</p>' + 
		'</dd>' + 
		'<dd class="namber">_NETPHONE_</dd>' + 
		'<dd>' + 
			'<input  class="dial_btn" type="button" value="" onclick="selectionPhone(_NETPHONE_)">' + 
		'</dd>' + 
		'<dd>' + 
			'<ul class="ul_two ">' + 
				'<li>' + 
					'<input type="text" readonly="readonly"  value="_ORG_NAME_">' + 
					'<div class="modify">' + 
						'<span class="delete" title="删除"></span>' + 
						'<span class="change" title="转移到私用"></span>' + 
					'</div>' + 
				'</li>' + 
				'<li class="mid_input">' + 
					'<input type="text" value="_MOBILEPHONE_" readonly="readonly"><em onclick="selectionPhone(_MOBILEPHONE_)"></em>' + 
					'<input type="text" value="_TELPHONE_" readonly="readonly"><em class="two_em" onclick="selectionPhone(_TELPHONE_)"></em>' + 
				'</li>' + 
			'</ul>' + 
		'</dd>' + 
		'<dd class="line"><p class="dotted"></p></dd>' + 
	'</dl>';

var privateLinkman = '' + 
'<dl>' + 
	'<dt></dt>' + 
	'<dd>' + 
		'<p class="content_name">_NICK_NAME_</p>' + 
		'<p class="ID">_ROLE_NAMES_</p>' + 
	'</dd>' + 
	'<dd class="namber">_NETPHONE_</dd>' + 
	'<dd>' + 
		'<input  class="dial_btn" type="button" value="" onclick="selectionPhone(_NETPHONE_)">' + 
	'</dd>' + 
	'<dd>' + 
		'<ul class="ul_two ">' + 
			'<li>' + 
				'<input type="text" readonly="readonly"  value="_ORG_NAME_">' + 
				'<div class="modify">' + 
					'<span class="delete" title="删除"></span>' + 
					'<span class="change" title="转移到私用"></span>' + 
				'</div>' + 
			'</li>' + 
			'<li class="mid_input">' + 
				'<input type="text" value="_MOBILEPHONE_" readonly="readonly"><em onclick="selectionPhone(_MOBILEPHONE_)"></em>' + 
				'<input type="text" value="_TELPHONE_" readonly="readonly"><em class="two_em" onclick="selectionPhone(_TELPHONE_)"></em>' + 
			'</li>' + 
			'<li class="last_input">' + 
				'<textarea  style="color:#fff" placeholder="添加备注，回车保存">_LINKMAN_NOTE_</textarea>' + 
			'</li>' + 
		'</ul>' + 
	'</dd>' + 
	'<dd class="line"><p class="dotted"></p></dd>' + 
'</dl>';

function queryLinkmanUser(currentPage){
	//public_content_list
	if(currentPage<1) currentPage = 1;
	$.ajax({
		type : "post",
		url : contextPath + "/ephone/queryLinkmanUser.do",
		data : {
			"pageSize":999999,
			"pageNo":currentPage
		},
		dataType : "json",
		async : true,
		success : function(response){
			var target = $("#public_content_list");
			target.html("");
			if(response!=null && response.entities!=null && response.entities.length!=0){
				$.each(response.entities, function(i, linkman){
					target.append(publicLinkman.replace(/_NICK_NAME_/g, getData(linkman, "cname"))
							.replace(/_ROLE_NAMES_/g, getData(linkman, "roleNames"))
							.replace(/_NETPHONE_/g, getData(linkman, "netPhone"))
							.replace(/_ORG_NAME_/g, getData(linkman, "orgChineseName"))
							.replace(/_MOBILEPHONE_/g, getData(linkman, "mobile"))
							.replace(/_TELPHONE_/g, getData(linkman, "phone")));
				});
			}
			intiPublicContentList();
		},
		error : function(xhr, statusText, errorThrow){
			console.log(xhr);
			console.log(statusText);
			console.log(errorThrow);
		}
	});
}


function queryLinkman(currentPage){
	//private_content_list
	if(currentPage<1) currentPage = 1;
	$.ajax({
		type : "post",
		url : contextPath + "/ephone/queryLinkman.do",
		data : {
			"pageSize":999999,
			"pageNo":currentPage
		},
		dataType : "json",
		async : true,
		success : function(response){
			var target = $("#private_content_list");
			target.html("");
			if(response!=null && response.entities!=null && response.entities.length!=0){
				$.each(response.entities, function(i, linkman){
					target.append(privateLinkman.replace(/_NICK_NAME_/g, getData(linkman, "linkmanName"))
							.replace(/_ROLE_NAMES_/g, "")
							.replace(/_NETPHONE_/g, getData(linkman, "netphoneNumber"))
							.replace(/_ORG_NAME_/g, getData(linkman, "companyName"))
							.replace(/_MOBILEPHONE_/g, getData(linkman, "mobilephoneNumber"))
							.replace(/_TELPHONE_/g, getData(linkman, "telphoneNumber"))
							.replace(/_LINKMAN_NOTE_/g, getData(linkman, "linkmanNote")));
				});
			}
			intiPrivateContentList();
		},
		error : function(xhr, statusText, errorThrow){
			console.log(xhr);
			console.log(statusText);
			console.log(errorThrow);
		}
	});
}

function intiPublicContentList(){
	$("#public_content_list .ul_two").css('display', 'none');
	$("#public_content_list").find("dl dd:only-child,dl dt,dl dd:nth-child(2),dl dd:nth-child(3)").click(function(event) {
		$(this).siblings('dd').children('.ul_two').stop().slideToggle(200);
		$(this).parent().siblings('dl').children('dd').children('.ul_two').stop().slideUp(200);
	});
	
	/*此处是公用表单部分*/
	var  gaodu=$("#public_content_list").height(); //获取盒子的高度
	var  sum=parseInt(gaodu/100)+1;
	var i=0;
	$("#but_down").click(function(event) {
		i++;
		if (i<=sum) {
			$("#public_content_list").animate({
				top: -400*i,
			}, 600);
		}else{
			i=sum
		}
	});
	$("#but_up").click(function(event) {
		i--;
		if (i>=0) {
			$("#public_content_list").animate({
				top: -400*i,
			}, 600);
		}else{
			i=0
		}
	});
}

function intiPrivateContentList(){
	$("#private_content_list .ul_two").css('display', 'none');
	
	$("#private_content_list").find("dl dd:only-child,dl dt,dl dd:nth-child(2),dl dd:nth-child(3)").click(function(event) {
		$(this).siblings('dd').children('.ul_two').stop().slideToggle(200);
		$(this).parent().siblings('dl').children('dd').children('.ul_two').stop().slideUp(200);   
	});
	
	/*此处是公用表单部分*/
	var  gaodu=$("#private_content_list").height(); //获取盒子的高度
	var  sum=parseInt(gaodu/100)+1;
	var i=0;
	$("#but_down2").click(function(event) {
		i++;
		if (i<=sum) {
			$("#private_content_list").animate({
				top: -400*i,
			}, 600);
		}else{
			i=sum
		}
	});
	$("#but_up2").click(function(event) {
		i--;
		if (i>=0) {
			$("#private_content_list").animate({
				top: -400*i,
			}, 600);
		}else{
			i=0
		}
	});
}

function getData(obj, key){
	if(obj!=null && obj[key]!=null && obj[key]!=""){
		return obj[key];
	}
	return "";
}