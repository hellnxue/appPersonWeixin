/*$(document).ready(function(){
	// 字符验证数字
	jQuery.validator.addMethod(
	    "numberCheck",
	    function(value, element) {
	        return this.optional(element) ||!( /^[0-9]+$/.test(value));
	    },
		 "用户名不能全是数字"
		 );
	//字符验证格式
	jQuery.validator.addMethod("stringCheck", function(value, element) {
	return this.optional(element) || /^[a-zA-Z0-9_-]+$/.test(value);
	}, "用户名只能包括英文字母、数字和下划线_和-"); 	 
	 
	//用户名重复性
	jQuery.validator.addMethod("repLoginNameCheck", function(value, element) {
	var flag=false;
	var loginName=$("#loginName").val();
	 $.ajax({
			type:"post",
			url:"repetitionName.do",
			data:{"loginName":loginName},
			async:false,
			success : function(data) {
				if(data=="success"){
					flag=true;
				}
			}
			
		});
	console.log("flag==="+flag);
	return this.optional(element) || flag;
	}, "用户名重复！"); 
	
	//用户名重复性（企业）
	jQuery.validator.addMethod("repOrgLoginNameCheck", function(value, element) {
	var flag=false;
	var loginName=$("#ologinName").val();
	 $.ajax({
			type:"post",
			url:"repetitionName.do",
			data:{"loginName":loginName},
			async:false,
			success : function(data) {
				if(data=="success"){
					flag=true;
				}
			}
			
		});
	console.log("flag==="+flag);
	return this.optional(element) || flag;
	}, "用户名重复！"); 
	
	//邮箱重复性
	jQuery.validator.addMethod("repEmail", function(value, element) {
	var flag=false;
	var oemail=$("#oemail").val();
	 $.ajax({
			type:"post",
			url:"repetitionEmail.do",
			data:{"email":oemail},
			async:false,
			success : function(data) {
				if(data=="success"){
					flag=true;
				}
			}
			
		});
	console.log("flag==="+flag);
	return this.optional(element) || flag;
	}, "邮箱重复！"); 
	
	//公司名称重复性
	jQuery.validator.addMethod("repOrgName", function(value, element) {
	var flag=false;
	var orgName=$("#orgName").val();
	 $.ajax({
			type:"post",
			url:"repetitionOrgName.do",
			data:{"orgName":orgName},
			async:false,
			success : function(data) {
				if(data=="success"){
					flag=true;
				}
			}
			
		});
	console.log("flag==="+flag);
	return this.optional(element) || flag;
	}, "公司名称重复！"); 
	
	// 验证密码
	jQuery.validator.addMethod(
	    "passwordCheck",
	    function(value, element) {
	        return this.optional(element) ||!(/^[^a-zA-Z0-9]+$/.test(value));
	    },
		 "密码格式不正确！"
		 );
	
	//手机号码重复性(个人)
	jQuery.validator.addMethod("repPersonMobileCheck", function(value, element) {
	var flag=false;
	var mobile=$("#mobile").val();
	 $.ajax({
			type:"post",
			url:"repetitionMobil.do",
			data:{"mobile":mobile},
			async:false,
			success : function(data) {
				if(data=="success"){
					flag=true;
				}
			}
			
		});
	console.log("mflag==="+flag);
	return this.optional(element) || flag;
	}, "手机号码重复！"); 
	
	//手机号码重复性(企业)
	jQuery.validator.addMethod("repOrgMobileCheck", function(value, element) {
	var flag=false;
	var mobile=$("#omobile").val();
	 $.ajax({
			type:"post",
			url:"repetitionMobil.do",
			data:{"mobile":mobile},
			async:false,
			success : function(data) {
				if(data=="success"){
					flag=true;
				}
			}
			
		});
	console.log("mflag==="+flag);
	return this.optional(element) || flag;
	}, "手机号码重复！"); 

	// 检测长度（中文字两个字节）
	jQuery.validator.addMethod("byteRangeLength", function(value, element, param) {
	var length = value.length;
	for(var i = 0; i < value.length; i++){
	if(value.charCodeAt(i) > 127){
	length++;
	}
	}
	return this.optional(element) || ( length >= param[0] && length <= param[1] );
	}, "请确保输入的值在3-15个字节之间(一个中文字算2个字节)");

	// 身份证号码验证
	jQuery.validator.addMethod("isIdCardNo", function(value, element) {
	return this.optional(element) || isIdCardNo(value);
	}, "请正确输入您的身份证号码");


	// 手机号码验证
	jQuery.validator.addMethod("isMobile", function(value, element) {
	var flag =isValidityMobile(value);
	return this.optional(element) || flag;
	}, "请正确填写您的手机号码");


	// 电话号码验证
	jQuery.validator.addMethod("isTel", function(value, element) {
	var tel = /^\d{3,4}-?\d{7,9}$/; //电话号码格式010-12345678
	return this.optional(element) || (tel.test(value));
	}, "请正确填写您的电话号码");


	// 联系电话手机验证
	jQuery.validator.addMethod("isPhone", function(value,element) {
	var mobile =/^((\+86)|(86))?(1)\d{10}$/;
	return this.optional(element) || mobile.test(value);
	}, "请正确填写您的联系电话");

	// 邮政编码验证
	jQuery.validator.addMethod("isZipCode", function(value, element) {
	var tel = /^[0-9]{6}$/;
	return this.optional(element) || (tel.test(value));
	}, "请正确填写您的邮政编码");

	// 联系人姓名验证
	jQuery.validator.addMethod("isName", function(value, element) {
	var name = /^[\u4E00-\u9FA5a-zA-Z]+$/;
	return this.optional(element) || (name.test(value));
	}, "姓名格式不正确！");
	
	//验证码正确性(个人)
	jQuery.validator.addMethod("checkCodePerson", function(value, element) {
	var flag=false;
	var code=$("#code").val();
	var mobile=$("#mobile").val();
	 $.ajax({
			type:"post",
			url:"checkCode.do",
			data:{"functionCode":"personregister","send_target":mobile,"randomCode":code},
			async:false,
			success : function(data) {
				if(data=="true"){
					flag=true;
				}
			}
			
		});
	console.log("mflag==="+flag);
	return this.optional(element) || flag;
	}, "验证码不正确！");
	
	//验证码正确性(企业)
	jQuery.validator.addMethod("checkCodeOrg", function(value, element) {
	var flag=false;
	var code=$("#ocode").val();
	var mobile=$("#omobile").val();
	 $.ajax({
			type:"post",
			url:"checkCode.do",
			data:{"functionCode":"orgregister","send_target":mobile,"randomCode":code},
			async:false,
			success : function(data) {
				if(data=="true"){
					flag=true;
				}
			}
			
		});
	console.log("mflag==="+flag);
	return this.optional(element) || flag;
	}, "验证码不正确！");

}); 
*/


function required(new_password){
	
	if(new_password!==""){
		return true;
	}
	return false;
	//return "请填写密码！";
}
function passwordCheck(new_password){
	
	if(/^[^a-zA-Z0-9]+$/.test(new_password)){
		return false;
	};
	
	return true;
	//return "密码格式不正确！";
}

function numberCheck(new_password){
	
	if(/^[0-9]+$/.test(new_password)){
		return false;
	};
	
	return true;
	//return "密码不能全是数字！";
}

function rangeLength(new_password){
	if(new_password.length>=6&&new_password.length<=18){
		return true;
	}
	return false;
	//return "密码长度为6-18位！";
}

