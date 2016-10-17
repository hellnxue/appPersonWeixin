<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
 
<!doctype html>
<html class="no-js">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="智阳网络技术">
<meta name="keywords" content="智阳网络技术">
<meta name="viewport"
        content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>名片</title>

<!-- Set render engine for 360 browser -->
<meta name="renderer" content="webkit">

<!-- No Baidu Siteapp-->
<meta http-equiv="Cache-Control" content="no-siteapp"/>
<link rel="icon" type="image/png" href="assets/i/favicon.png">

<!-- Add to homescreen for Chrome on Android -->
<meta name="mobile-web-app-capable" content="yes">
<link rel="icon" sizes="192x192" href="assets/i/app-icon72x72@2x.png">

<!-- Add to homescreen for Safari on iOS -->
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="apple-mobile-web-app-title" content="智阳科技"/>
<link rel="apple-touch-icon-precomposed" href="assets/i/app-icon72x72@2x.png">

<!-- Tile icon for Win8 (144x144 + tile color) -->
<meta name="msapplication-TileImage" content="assets/i/app-icon72x72@2x.png">
<meta name="msapplication-TileColor" content="#0e90d2">
<link rel="stylesheet" href="${ctx}/static/assets/css/amazeui.min.css">
<link rel="stylesheet" href="${ctx}/static/assets/css/app.css">
<style type="text/css">
.bg {
  background-size: cover;
  background-position: center center;
  background-repeat: no-repeat;
  background-attachment: scroll;
}
.bg-gender-female {
  background-image: url(${ctx}/static/assets/images/userCard/female_bg@2x.png);
}
.bg-gender-male {
  background-image: url(${ctx}/static/assets/images/userCard/male_bg@2x.png);
}
.ram-header {
   height: 44px;
   background-color: #56baec;
}
.am-header .ram-header-title {
    font-size: 17px;
}
.am-header .ram-titlebar-right{
font-size: 15px;
}
.widget-icon{
    margin-right:12px;
}

.sp_list li a img.widget-icon1 {
    
    margin-right: 20px;
}

.sp_list li a img.widget-icon2 {
    
    margin-right: 14px;
}

.widget-name{
   font-size:17px;
}

.ram-list {
    margin-bottom: 0;
     
}

.rsp_list li {
    
    height: 44px;
    margin: 6px;
}
.am-border-top{
  border-top: 1px solid #dedede;
}
.am-border-bottom{
  border-bottom: 1px solid #dedede;
}
.am-list{
  margin-bottom: 0;
}

.am-list > li:first-child{
    border-top-width: 0;
}
.am-list > li:last-child{
    border-bottom-width: 0;
}
.am-list > li {
    border-style: dashed;
    border-color:#d4a8ba;
}
.am-text-white{
  color: #ffffff;
}
.am-text-gray{
  color: #ababab;
}
.am-background{
  background-image: url('${ctx}/static/assets/images/userCard/repeat_bg.png');
  background-repeat: repeat-y;
  background-size: 100% 100%;
}

 @media all and (-webkit-min-device-pixel-ratio: 1.5){
  .am-background{
    background-image: url('${ctx}/static/assets/images/userCard/repeat_bg@2x.png');
    background-size: 100% 100%;
  }
} 

.am-name{
  font-size: 1.6rem;
}
strong{
  font-size: 1.2rem;
}
.am-u-sm-p p{
  font-size: 1.2rem;
  color:#666;
  line-height: 30px;
}
.am-text-p{
  font-size: 1.2rem;
  color:#8f8e94;
}
.am-panel{
  border-width: 0;
}
</style>
</head>

<body class="bg bg-gender-female">
<!-- 分享缩略图 -->
<div style='margin:0 auto;display:none;'>
	<img src=''  id="share"/>
</div>
<div class="img am-text-center am-margin-top-sm am-margin-left-sm am-margin-right-sm">
        <img src="${ctx}/static/assets/images/userCard/p1_top_bg.png" width="100%" data-at2x="${ctx}/static/assets/images/userCard/p1_top_bg@2x.png"  class="am-block">
  </div>
<div class="am-background am-padding-left am-padding-right am-margin-left-sm am-margin-right-sm am-padding-top-xs">
    <div class="img am-text-center ">
      <img src="${companyLogo}"  id= "imglogo" max-height="48px" max-width="400px">
    </div>    
</div>
 <div class="img am-text-center am-margin-left-sm am-margin-right-sm">
        <img src="${ctx}/static/assets/images/userCard/band_bg.png" width="100%" data-at2x="${ctx}/static/assets/images/userCard/band_bg@2x.png" class="am-block">
  </div>
<div class="am-margin-bottom-0 am-background am-cf am-margin-left-sm am-margin-right-sm">
    <div class="ram-panel-bd am-padding-left-sm">
       <div class="img am-text-left am-u-sm-4">
        <img src="${ctx}/static/assets/images/userCard/img1.jpg" id="headImg" class="am-img-thumbnail am-circle am-text-middle" width="80rem">
      </div> 
      <div class="am-text-left am-u-sm-8 am-padding-left-0" >
        <p class="am-margin-top-xs"><strong class="am-name" id="userName"> </strong><img id="sex" src="${ctx}/static/assets/images/userCard/user_female.png" data-at2x="${ctx}/static/assets/images/userCard/user_female@2x.png" class="am-margin-left-sm"></p>
        <small class="am-block am-text-xs am-padding-top-xs" id="companyName"> </small>
        <small class="am-block am-text-xs" id="positionName"> </small>
      </div> 
   </div>     
</div>
    <div class="img am-text-center am-margin-left-sm am-margin-right-sm">
        <img src="${ctx}/static/assets/images/userCard/band_bg.png"  width="100%" data-at2x="${ctx}/static/assets/images/userCard/band_bg@2x.png" class="am-block">
    </div>
<div class="am-background am-padding-left am-padding-right am-margin-left-sm am-margin-right-sm">
  <ul class="am-list am-list-static am-padding-lg am-padding-top-0 am-padding-bottom-0">
    <li>
      <div class="am-g">
        <div class="am-u-sm-2 am-text-center">
            <img src="${ctx}/static/assets/images/userCard/iphone.png" data-at2x="${ctx}/static/assets/images/userCard/iphone@2x.png" >
        </div>
        <div class="am-u-sm-2 am-padding-left-0 am-u-sm-p am-padding-right-0">
          <p>手机</p>
        </div>
          <div class="am-u-sm-8 am-text-primary am-text-left am-padding-left-0">
            <a  id="telmobile"><strong id="mobile"> </strong></a>
          </div> 
      </div>
    </li>
    <li>
      <div class="am-g">
        <div class="am-u-sm-2 am-text-center">
           <img src="${ctx}/static/assets/images/userCard/wechat.png" data-at2x="${ctx}/static/assets/images/userCard/wechat@2x.png"> 
        </div>
        <div class="am-u-sm-2 am-u-sm-p am-padding-left-0 am-padding-right-0">
          <p class="">微信</p>
        </div>
          <div class="am-u-sm-8 am-text-left am-padding-left-0">
            <strong id="nickName"></strong>
          </div>
      </div>
    </li>
    <li>
      <div class="am-g ">
        <div class="am-u-sm-2 am-text-center">
            <img src="${ctx}/static/assets/images/userCard/mail.png" data-at2x="${ctx}/static/assets/images/userCard/mail@2x.png">  
        </div>
         <div class="am-u-sm-2 am-u-sm-p am-padding-left-0 am-padding-right-0">
          <p class="">邮箱</p>
        </div>
          <div class="am-u-sm-8 am-text-left am-padding-left-0">
            <strong id="mail"></strong>
          </div>
      </div>
    </li>
    <li>
      <div class="am-g">
        <div class="am-u-sm-2 am-text-center">
            <img src="${ctx}/static/assets/images/userCard/department.png" data-at2x="${ctx}/static/assets/images/userCard/department@2x.png">   
        </div>
        <div class="am-u-sm-2 am-u-sm-p am-padding-left-0 am-padding-right-0">
          <p class="" >部门</p>
          </div>
          <div class="am-u-sm-8 am-text-left am-padding-left-0 ">
            <strong id="department"></strong>
          </div>
      </div>
    </li>
    <li class="am-text-center am-g">
      <div id="qrCodeCanvas" style="display:none"></div>
      <div class="am-u-sm-6 am-padding-right-0" >
        <img src="${ctx}/static/assets/images/userCard/qrcode.png" alt="QRCode"  class="am-img-responsive" id="qrCodeImg"> 
     
      </div>
      <div class="am-u-sm-6 am-padding-right-0 am-vertical-align" style="height:90px;">
        <p class="am-vertical-align-middle am-text-p">长按识别二维码 保存联系人至手机通讯录</p>
      </div>
    </li>
  </ul>
</div>
<div class="img am-text-center am-margin-left-sm am-margin-right-sm">
  <img src="${ctx}/static/assets/images/userCard/P3_btm_bg.png" width="100%" class="am-block" data-at2x="${ctx}/static/assets/images/userCard/P3_btm_bg@2x.png">
</div>
<script src="${ctx}/static/assets/js/jquery.min.js"></script> 
<script src="${ctx}/static/assets/js/amazeui.js"></script> 
<script src="${ctx}/static/assets/js/retina.min.js"></script> 
<script type="text/javascript"  src="${ctx}/static/assets/js/utils.js"></script>
<script type="text/javascript" src="${ctx}/static/assets/js/jquery.qrcode.min.js"></script>
<script>
  //var jsonObj={"json":{"companyName":"北京昊基","department":"财务部","mail":"1032755896@qq.com","mobile":"13688888888","positionName":"财务主管","sex":0,"userName":"刘德华"}};
  var cardObj={};
 
  var search=location.search;
  var idcard="";
  var nickName="";//昵称
  var headImg="";//头像
  if(search){
	  
	  var searchArry=search.split("&");
	  idcard=searchArry[0].split("idcard=")[1];
	  nickName=searchArry[1].split("nickname=")[1];
	  headImg=searchArry[2].split("headimgurl=")[1];
	  
	  $("#nickName").html(decodeURI(nickName));
	  if(headImg){
		  $("#headImg").attr("src",headImg);//头像
	 	  $("#share").attr("src",headImg);//缩略图
	  }
	  
  }
  
  $(function(){
	// 创建对象
	  var img = new Image();
	  // 改变图片的src
	  var url = $("#imglogo").attr("src");
	  img.src = url;
	  img.onload =function(){
		  if(img.height>48){
			  $("#imglogo").attr("width" , "auto");
			  $("#imglogo").attr("height" , "48");
		  }
		  if(img.width>400){
			  $("#imglogo").attr("width" , "auto");
		  }
		  console.log('width:'+img.width+',height:'+img.height);
	  }
	  if(idcard){
		  getUserInfo(idcard);
	  }
	  
	  
  });
//获取用户信息
  function getUserInfo(idcard){
	   
	      $.getJSON("${ctx}/jabava/getUserInfoByCardId", {idcard: idcard }, function (jsonObj) {
			 if(jsonObj&&jsonObj.json){   
				 var uObj=jsonObj.json; 
				 
				 //write here......
				 
					$("#userName").html(uObj.userName);
				    $("title").html(uObj.userName+"的名片");
					$("#companyName").html(uObj.companyName);
					$("#positionName").html(uObj.positionName);
					$("#mobile").html(uObj.mobile);
					
					$("#telmobile").attr("href","tel:"+uObj.mobile);
					$("#mail").html(uObj.mail);
					$("#department").html(uObj.department);
					
					cardObj.userName=uObj.userName;
					cardObj.companyName=uObj.companyName;
					cardObj.mail=uObj.mail;
					cardObj.mobile=uObj.mobile;
					
					
					var sex=uObj.sex;//0为男性,1为女性
					if(sex==0){
						$("#sex").attr("src","${ctx}/static/assets/images/userCard/user_male.png").attr("data-at2x","${ctx}/static/assets/images/userCard/user_male@2x.png");
						$("body").addClass("bg-gender-male");
					 }
					cardImg(cardObj); 
		  	   }
			 
			 
		}) ;     
  } 
  
 //二维码
  function cardImg(cardObj){
	var cardInfo="BEGIN:VCARD\n"+"VERSION:3.0\n"+"FN:"+toUtf8(cardObj.userName)+"\n"+"TEL;CELL;VOICE:"+cardObj.mobile+"\n"+"EMAIL;PREF;INTERNET:"+cardObj.mail+"\n"+"ORG:"+toUtf8(cardObj.companyName)+"\n"+"END:VCARD\n";
	$("#qrCodeCanvas").qrcode({ 
		width:300,   
		height:300,   
		text:cardInfo   
    });
	
	 var imgSrc= $("canvas")[0].toDataURL("image/png");
	 $("#qrCodeImg").attr("src",imgSrc);
  }
</script>

</body>
</html>