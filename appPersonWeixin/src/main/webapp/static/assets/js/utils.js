	//根据时间的毫秒值处理时间获得年月日
	function getHandleDate(ms,flag) {
		var date = new Date(ms);
		var month = Number(date.getMonth() + 1) + "";
		if (month.length < 2) {
			month = "0" + month;
		}
		var day = Number(date.getDate()) + "";
		if (day.length < 2) {
			day = "0" + day;
		}
		if(flag==="yyyy-mm-dd"){
			var handleDate = date.getFullYear() + "-" + month + "-" + day;
		}else{
			 handleDate = date.getFullYear() + "年" + month + "月" + day+" "+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds();
		}
		return handleDate;
	}
	
	var timerc1=0; //全局时间变量（秒数）
	var times;
	function add1(){ //加时函数
		if(timerc1 > 0){ //如果不到1秒
		    --timerc1; //时间变量自减1
		   
		   $("#sendcaptcha").addClass("am-disabled");
		   $("#sendcaptcha").attr("value",parseInt(timerc1)+"后重获取");
		};
		if (timerc1==0) {
		   $("#sendcaptcha").removeClass("am-disabled");
		   $("#sendcaptcha").attr("value", "获取验证码");
	       clearInterval(times);
		 }
	};
	
	function inputDisabled(){
		  if($("#messagecode").val().length>0){
			  $("#submit").removeClass("am-disabled");
		  }else{
			  $("#submit").addClass("am-disabled");
		  }
	}
	
	function errorCodeTip(msg){
		 $("#sendcaptcha").closest("li").next("span").html("").remove();
		 $("#sendcaptcha").closest("li").after("<span style='color:red'>"+msg+"！"+"</span>");
	}
	
	function getCheckCode(path){
		 $.getJSON(path+"/hrhelper-platform/anon/sendCertifyMessage.e", {
	  			
			}, function (data) {  
				if (true == true){
					 timerc1=60;//时间初始化
					 times=setInterval(add1,1000);			
				}else{
					$("#my-alert").find(".am-modal-hd").html(data.code);
					$("#my-alert").modal();     
				}
			 });
	}
	
	  /*将中文字符串转换为utf-8编码*/
	  function toUtf8(str) {    
		    var out, i, len, c;    
		    out = "";    
		    len = str.length;    
		    for(i = 0; i < len; i++) {    
		        c = str.charCodeAt(i);    
		        if ((c >= 0x0001) && (c <= 0x007F)) {    
		            out += str.charAt(i);    
		        } else if (c > 0x07FF) {    
		            out += String.fromCharCode(0xE0 | ((c >> 12) & 0x0F));    
		            out += String.fromCharCode(0x80 | ((c >>  6) & 0x3F));    
		            out += String.fromCharCode(0x80 | ((c >>  0) & 0x3F));    
		        } else {    
		            out += String.fromCharCode(0xC0 | ((c >>  6) & 0x1F));    
		            out += String.fromCharCode(0x80 | ((c >>  0) & 0x3F));    
		        }    
		    }    
		    return out;    
		}