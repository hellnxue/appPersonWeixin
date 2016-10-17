function initElement(){
	$(".phone-pic").hide();
	$(".re-phone").hide();					
	$(".over-phone").hide();	
	$(".bo").hide();	
	$(".tong").hide();	
	$(".cover").hide();	
	$(".yes-no").hide();
	
	/*	Delete */
	$('.delete-btn').click(function() {
		var numbers = $('.number-area .numbers').text();
		var numbers2 = $('.number-area .numbers').text().length;
		$('.number-area .numbers').text(numbers.substr(0, numbers2 - 1));
		$('.speaker .numbers').text(numbers.substr(0, numbers2 - 1));
		if (numbers.substr(0, numbers2 - 1)=="") {
			$(".bo").hide();
			$(".circle").css('background-position', '0 -22px');
			$(".btn-btn").css('background-position', '0 0');

		}
		
	});
	
	var numbers = new Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9");
	$.each(numbers, function(i, ele){
		$('.numbers-container .pushed' + i).click(function() {
			$('.number-area .numbers').append(i + '');//此处numbers获取拨号按钮上的数字
			$(".btn-btn").css('background-position', '0 -105px');
			$(".bo").show();
			$(".circle").css('background-position', '0 0');
		});	
	})
	
	$('.numbers-container .pushedasterisk').click(function() {
		$('.number-area .numbers').append('*');
	});

	$('.numbers-container .pushednumber').click(function() {
		$('.number-area .numbers').append('#');
	});
	
	call($(".btn-btn"), true);
	
}

function call(obj, bool){
	$(obj).unbind("click");
	if(bool){
		$(obj).bind("click", function() {//此处是拨通电话
			dialInputPhone();
			$(".bo").hide();
			$(".tong").show();
			$(".numbers").hide();
			$(".phone-pic").show();
			$(".cover").show();
			$(this).css('background-position', '-1px -49px');
			$(".btn-people").css('background-position', '0 -49px');
			$(".btn-del").css('background-position', '0 -49px');
			call(this, false);
		});
	}else{
		$(obj).bind("click", function() {//此处是挂机
			hangInputPhone();
			$(".bo").show();
			$(".tong").hide();
			$(".numbers").show();
			$(".phone-pic").hide();
			$(".cover").hide();
			$(this).css('background-position', '0px -105px');
			$(".btn-people").css('background-position', '0 0px');
			$(".btn-del").css('background-position', '0 0px');
			call(this, true);
		});
	}
}



function executeNetPhone(params, url){
	$.ajax({
		type : "post",
		url : url,
		data : params,
		dataType : "jsonp",
		jsonp : "callbackfun",
		async : true,
		success : function(response){
			console.log(response);
		},
		error : function(xhr, statusText, errorThrow){
			console.log(xhr);
			console.log(statusText);
			console.log(errorThrow);
			//alert(statusText);
		}
	});
}


function callPhoneNumber(){
	$(".btn-btn").click();
}

function setPhoneNumber(phoneNumber){
	$(".numbers").text(phoneNumber);
	$(".btn-btn").css('background-position', '0 -105px');
	$(".bo").show();
	$(".circle").css('background-position', '0 0');
}

function openLinkmanWindow(contextPath){
	window.open(contextPath + "/ephone/linkman.do", "linkmanWindow", "height=505,width=345,top=0,left=0,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no");
}
