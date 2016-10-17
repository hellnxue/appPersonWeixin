<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!doctype html>
<html class="no-js">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="智阳网络技术">
<meta name="keywords" content="智阳网络技术">
<meta name="viewport"
        content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>智阳网络—官方社保数据直通车</title>

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
body{
  background: #ffffff;
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
.am-list > li:first-child{
    border-top-width: 0;
}
.am-list > li:last-child{
    border-bottom-width: 0;
}
.am-text-white{
  color: #ffffff;
}
.am-text-grays{
  color: #ababab;
}
.am-no-border{
  border: 0;
}
.am-custom-select {
	opacity:0;
}
.am-custom-label{
	position:absolute;
	left:3.5rem;
	/* width:100%; */
	height:100%;
	font-weight:normal;
}
.am-custom-label:before{
	position:absolute;
	right:50px;
	content:">";
}
</style>
</head>

<body>
<!-- 分享缩略图 -->
<div style='margin:0 auto;display:none;'>
	<img src='${ctx}/static/assets/images/verson1/zy_slt.png' />
</div>
<div class="am-panel am-panel-default am-no-border"  style="background: url(${ctx}/static/assets/images/verson1/login-banner.jpg) no-repeat; background-size: cover; min-height:245px;">
     <div class="am-panel-bd ram-panel-bd am-padding-top-xl">
      <div class="img am-text-center am-margin-top-sm">
        <img src="${ctx}/static/assets/images/verson1/login-logo.png" width="36%">
      </div>
      <div class="am-text-center am-text-white">
        <h2 class="am-margin-top-xs">官方社保数据查询</h2>
      </div>
    </div>
</div>
<form action="" method="post"  >
<div class="am-header-one am-padding-left-lg am-padding-right-lg">
  <ul class="am-list am-list-static am-margin-bottom-xs">
    <li>
      <div class="am-g">
          <div class="am-u-sm-4 am-padding-0">
            <span class="am-text-grays">查询城市</span>
          </div>
          <div class="am-u-sm-8">
          	<label for="city" class="am-custom-label am-u-sm-11" data-show="selected"></label>
           <div class="am-form-group">
           		
		      <select name="city" id="city" class="am-no-border am-form-select am-u-sm-12 am-custom-select"></select>
		      <span class="am-form-caret"></span>
		    </div>
          </div>
      </div>
      
    </li>
    <li>
      <div class="am-g">
          <div class="am-u-sm-4 am-padding-0">
            <span class="am-text-grays">查询类型</span>
          </div>
          <div class="am-u-sm-8">
           <label for="type" class="am-custom-label am-u-sm-11" data-show="selected"></label>
           <div class="am-form-group">
		      <select name="type" id="types" class="am-no-border am-form-select am-u-sm-12 am-custom-select">
		      
		      </select>
		      <span class="am-form-caret"></span>
		    </div>
          </div>
      </div>
      
    </li>
     <li data-type="name">
     <div class="am-g">
          <div class="am-u-sm-4 am-padding-0">
            <span class="am-text-grays">用户名</span>
          </div>
          <div class="am-u-sm-8">
           <div class="am-form-group">
            <input type="text" class="am-no-border am-u-sm-12" name="name" id="name" maxlength="10" required>
           </div>
          </div>
      </div>
    </li>
    <li data-type="idcard">
      <div class="am-g">
          <div class="am-u-sm-4 am-padding-0">
            <span class="am-text-grays">身份证号码</span>
          </div>
          <div class="am-u-sm-8">
           <div class="am-form-group">
            <input type="text" class="am-no-border am-u-sm-12" name="idcard" id="idcard" maxlength="18" required>
           </div>
          </div>
      </div>
    </li>
    <li data-type="cardNo">
      <div class="am-g">
          <div class="am-u-sm-4 am-padding-0">
            <span class="am-text-grays" id="shebaoNo">社保账号</span>
          </div>
          <div class="am-u-sm-8">
           <div class="am-form-group">
            <input type="text" class="am-no-border am-u-sm-12" name="cardNo" id="cardNo" maxlength="18" required>
           </div>
          </div>
      </div>
    </li>
    <li>
      <div class="am-g">
          <div class="am-u-sm-4 am-padding-0">
            <span class="am-text-grays">查询密码</span>
          </div>
          <div class="am-u-sm-8">
          	<div class="am-form-group">
            	<input type="password" class="am-no-border am-u-sm-12"   name="pwd" id="pwd" required>
            </div>
          </div>
      </div>
    </li>
    
    <li class="am-padding-top-0">
     <span style="color:red;margin-top:0.46rem;display:block;" id="errorTip"></span>
        <button type="submit"   class="am-btn am-btn-primary am-radius am-btn-block am-margin-top-lg am-btn-xl">查询</button>
    </li>
  </ul>
</div>
</form>

<div class="am-header-one am-padding-left-lg am-padding-right-lg am-padding-top-sm am-padding-bottom-lg">
  <p class="am-text-xs am-text-center">
      <strong class="am-link-muted" data-tip="tip">友情提示：</strong>
      <span class="am-text-grays" id="tip">用户首次申请密码时，请携带本人有效身份证件前往就近的街镇社区事务受理服务中心或各区县社保分中心自助查询机进行设置和申请。</span>
  </p>
</div>

<!--[if (gte IE 9)|!(IE)]><!--> 
<script src="${ctx}/static/assets/js/jquery.min.js"></script> 
<script src="${ctx}/static/assets/js/int.web.js"></script> 
<script src="${ctx}/static/assets/js/amazeui.js"></script> 
<script src="${ctx}/static/assets/js/int.pageajax.js"></script>
<script src="${ctx}/static/assets/js/jquery.transit.js"></script> 
<script src="${ctx}/static/assets/js/int.com.js"></script>
<script src="${ctx}/static/assets/js/int.datecur.js"></script>
<script src="${ctx}/static/assets/js/jquery.dialog.js"></script>
<script src="${ctx}/static/assets/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript">
var tip="${codeTip}";
if(tip){
	$("#errorTip").html(tip);
}

var objArray=[
              { city:{name:"上海",value:"shagnhai"},
                typeAry:[
            	          {name:"上海社保",value:"5",tip:"友情提醒：用户首次申请密码时，请携带本人有效身份证件前往就近的街镇社区事务受理服务中心或各区县社保分中心自助查询机进行设置和申请。"}
            		    ]
               },
              { city:{name:"北京",value:"beijing"},
                typeAry:[
                          {name:"北京社保",value:"6",tip:"友情提醒：若您是首次登录，请先注册北京市社会保险网上申报查询系统，完成登录密码设置。"}
                          , {name:"北京公积金（市管）",value:"4",tip:"友情提醒：若您是首次登录，请先注册北京市社会保险网上申报查询系统，完成登录密码设置。"}
            		    ]
              },
              <!--广东省 -->
             { city:{name:"深圳",value:"shengzhen"},
                 typeAry:[
                           {name:"深圳公积金",value:"27",tip:""},{name:"深圳社保",value:"25",tip:""}
                           
             		    ]
               } ,
               <!--浙江省 -->
              { city:{name:"杭州",value:"hangzhou"},
                  typeAry:[
                            {name:"杭州公积金",value:"8",tip:""}
                            
              		    ]
                },
             { city:{name:"台州",value:"taizhou"},
                 typeAry:[
                           {name:"台州社保",value:"30",tip:""}
                           
             		    ]
               } ,
             { city:{name:"连云港市",value:"lianyungang"},
                 typeAry:[
                           {name:"连云港市社保",value:"32",tip:""}
                           
             		    ]
               },
               <!--河南省 -->
              { city:{name:"郑州",value:"zhengzhou"},
                  typeAry:[
                            {name:"郑州公积金",value:"9",tip:""}
                            
              		    ]
                },
             <!--安徽省 -->
             { city:{name:"合肥",value:"hefei"},
                 typeAry:[
                           {name:"合肥公积金",value:"23",tip:""},{name:"合肥社保",value:"24",tip:""}
                           
             		    ]
               },
               <!--山东省 -->
             { city:{name:"德州",value:"dezhou"},
                 typeAry:[
                           {name:"德州社保",value:"31",tip:""}
                           
             		    ]
               } ,
             { city:{name:"青岛",value:"qingdao"},
                 typeAry:[
                          {name:"青岛公积金",value:"10",tip:""},{name:"青岛社保",value:"21",tip:""}
                          
            		    ]
              },
            { city:{name:"泰安",value:"taian"},
                typeAry:[
                         {name:"泰安社保",value:"34",tip:""}
                         
           		    ]
             },
             <!--福建省 -->
            { city:{name:"福州",value:"fuzhou"},
                typeAry:[
                          {name:"福州公积金",value:"22",tip:""}
                          
            		    ]
              } ,
              
              <!--湖南省 -->
           { city:{name:"常德",value:"fuzhou"},
               typeAry:[
                         {name:"常德公积金",value:"36",tip:""}
                         
           		    ]
             } ,
          { city:{name:"衡阳",value:"fuzhou"},
              typeAry:[
                        {name:"衡阳公积金",value:"38",tip:""}
                        
          		    ]
            } ,
              <!--江苏省 -->
           { city:{name:"苏州",value:"suzhou"},
               typeAry:[
                        {name:"苏州社保",value:"33",tip:""}
                        
          		    ]
            },
           { city:{name:"南通",value:"suzhou"},
               typeAry:[
                        {name:"南通公积金",value:"35",tip:""}
                        
          		    ]
            },
            <!--内蒙古省 -->
           { city:{name:"呼和浩特",value:"fuzhou"},
               typeAry:[
                         {name:"呼和浩特公积金",value:"28",tip:""},{name:"呼和浩特社保",value:"29",tip:""}
                         
           		    ]
             } ,
             <!--湖北省 -->
            { city:{name:"武汉",value:"wuhan"},
                typeAry:[
                         {name:"武汉社保",value:"13",tip:""}
                          
            		    ]
              },
            { city:{name:"襄阳",value:"hubei"},
                typeAry:[
                          {name:"襄阳社保",value:"14",tip:""}
            		    ]
              } ,
            { city:{name:"恩施",value:"hubei"},
               typeAry:[
                         {name:"恩施社保",value:"15",tip:""}
           		    ]
             } ,
           { city:{name:"咸宁",value:"hubei"},
               typeAry:[
                         {name:"咸宁社保",value:"16",tip:""}
           		    ]
             } ,
            { city:{name:"荆门",value:"hubei"},
                typeAry:[
                          {name:"荆门社保",value:"17",tip:""}
            		    ]
              } ,
            { city:{name:"黄石",value:"hubei"},
                typeAry:[
                          {name:"黄石社保",value:"18",tip:""}
            		    ]
              } ,
            { city:{name:"鄂州",value:"hubei"},
                typeAry:[
                          {name:"鄂州社保",value:"19",tip:""}
            		    ]
              } ,
            { city:{name:"仙桃",value:"hubei"},
                typeAry:[
                          {name:"仙桃社保",value:"20",tip:""}
                          
            		    ]
              } ,
              <!--云南省 -->
           { city:{name:"曲靖",value:"qujin"},
               typeAry:[
                         {name:"曲靖公积金",value:"26",tip:""}
                         
           		    ]
             } ,
              ];
var sb_form_action="${ctx}/webApp/anon/sbGjjTools/detail";		//社保查询地址
var gjj_form_action="${ctx}/webApp/anon/sbGjjTools/detail_paf";  //公积金查询地址
/*初始化城市下拉列表*/
 function initCityItem(objArray){
	 var cityOpts="";
	 var sltFlag="selected";
	 var sltCity="";
	 objArray.forEach(function(item,index,ary){
		 //默认选中第一项
		 if(index!=0){
		   sltFlag="";
			 
		 }else{
			 sltCity=item.city.name;
		 }
		 //根据传入后台选中的城市value，获取该选中的项的info
		 if("${selectedCityValue}"==item.city.value){
			 sltCity=item.city.name;
			 
		  }   
		 cityOpts+='<option value="'+item.city.value+'" '+sltFlag+' >'+item.city.name+'</option>';
		 
	 });
	 
	$("#city").html(cityOpts);
	initTypeItem(objArray,sltCity);
	 $('[data-show="selected"]').eq("0").html(sltCity); 
	//根据后台返回的项重新设置选中的项
	if("${selectedCityValue}"){
		$("#city option").removeAttr("selected");
		$("#city option[value='${selectedCityValue}']").attr("selected","selected");
	}
 }
 
 /*根据选择的city初始化缴纳类型下拉列表*/
 function initTypeItem(objArray,sltCity){
	
	 var typeOpts="";
	 var sltFlag="selected";
	 var sltType="";
	 var lstValue="";
	 var lstTip="";
	 objArray.forEach(function(item,index,ary){
		if(item.city.name==sltCity){
			var sltTypeAry=item.typeAry;
			sltTypeAry.forEach(function(item,index,ary){
				   //默认选中第一项
				   if(index!=0){
					   sltFlag="";
					 }else{
						 sltType=item.name;
						 lstValue=item.value;
						 lstTip=item.tip;
					 }
				   //根据传入后台选中的类型value，获取该选中的项的info
				   if("${selectedTypeValue}"==item.value){
					 sltType=item.name;
					 lstValue=item.value;
					 lstTip=item.tip;
				 	}   
				typeOpts+='<option value="'+item.value+'" '+sltFlag+'>'+item.name+'</option>';
				
			});
		}
		 
	 });
	 
	 $("#tip").html(lstTip);//友情提示
	 if(lstValue=="9"){
		 $("[data-tip='tip']").html("");//友情提示
	 }else{
		 $("[data-tip='tip']").html("友情提示：");
	 }
	 handlerType(lstValue);
	 $("#types").html(typeOpts);
	 $('[data-show="selected"]').eq("1").html(sltType); 
	 //根据后台返回的项重新设置选中的项
	 if("${selectedTypeValue}"&&$("#types option[value='${selectedTypeValue}']")[0]!=undefined){
			$("#types option").removeAttr("selected");
			$("#types option[value='${selectedTypeValue}']").attr("selected","selected");
		}
 }
 
/**
 * 根据缴纳类型做相应处理
     社保：身份证+密码
   公积金：姓名+密码
  郑州公积金：姓名+身份证+密码
 */
 function handlerType(typeValue){
	 if(typeValue == 26||typeValue == 15){
			$("input[name='pwd']").attr("type","hidden").parents("li").hide();
		}
		else{
			$("input[name='pwd']").attr("type","text").parents("li").show();
		}
	 if(typeValue == 8||typeValue == 22||typeValue == 23||typeValue == 26||typeValue == 27||typeValue == 9){
			$("#shebaoNo").html("公积金账号");
		}
		else{
			if(typeValue == 4){
			$("#shebaoNo").html("联名卡号");
			}
			else if(typeValue == 19){
		    $("#shebaoNo").html("个人编号");
			}
			else{
			$("#shebaoNo").html("社保账号");
			}
		}
	 switch(typeValue){
		case "4"://北京公积金市管公积金
			 $("form").attr("action",gjj_form_action);
				$("input[name='cardNo']").attr("type","text").parents("li").show();
				$("input[name='name']").attr("type","hidden").parents("li").hide();
				$("input[name='idcard']").attr("type","hidden").parents("li").hide();   
				break;
		case "5"://上海社保
			$("form").attr("action",sb_form_action);
			$("input[name='cardNo']").attr("type","text").parents("li").show();
			$("input[name='name']").attr("type","hidden").parents("li").hide();
			$("input[name='idcard']").attr("type","hidden").parents("li").hide(); 
			break;
		case "6"://北京社保
			
			$("form").attr("action",sb_form_action);
			$("input[name='cardNo']").attr("type","text").parents("li").show();
			$("input[name='name']").attr("type","hidden").parents("li").hide();
			$("input[name='idcard']").attr("type","hidden").parents("li").hide();   
			break;
     case "8"://杭州公积金
			
			$("form").attr("action",gjj_form_action);
			$("input[name='cardNo']").attr("type","text").parents("li").show();
			$("input[name='name']").attr("type","hidden").parents("li").hide();
			$("input[name='idcard']").attr("type","hidden").parents("li").hide();   
			break;
		case "9"://郑州公积金
			
			$("form").attr("action",gjj_form_action);
			$("input[name='cardNo']").attr("type","text").parents("li").show();
			$("input[name='name']").attr("type","text").parents("li").show();
			$("input[name='idcard']").attr("type","text").parents("li").show();   
			break;
		case "10"://青岛公积金
			
			$("form").attr("action",gjj_form_action);
			$("input[name='cardNo']").attr("type","hidden").parents("li").hide();
			$("input[name='name']").attr("type","hidden").parents("li").hide();
			$("input[name='idcard']").attr("type","text").parents("li").show();   
			break;
     // case "11"://天津公积金
			
		//	$("form").attr("action",gjj_form_action);
		//	$("input[name='cardNo']").attr("type","hidden").parents("li").hide();
		//	$("input[name='name']").attr("type","hidden").parents("li").hide();
		//	$("input[name='idcard']").attr("type","text").parents("li").show();   
		//	break;
		
     case "13"://武汉社保			
     	$("form").attr("action",sb_form_action);
			$("input[name='name']").attr("type","hidden").parents("li").hide();
			$("input[name='cardNo']").attr("type","text").parents("li").show();
			$("input[name='idcard']").attr("type","hidden").parents("li").hide();   
			break;	
     case "14"://湖北襄阳社保			
     	$("form").attr("action",sb_form_action);
     	$("input[name='idcard']").attr("type","text").parents("li").show(); 
			$("input[name='cardNo']").attr("type","hidden").parents("li").hide();
			$("input[name='name']").attr("type","hidden").parents("li").hide();
			  
			break;	
     case "15"://湖北恩施社保			
     	$("form").attr("action",sb_form_action);
			$("input[name='name']").attr("type","text").parents("li").show();
			$("input[name='cardNo']").attr("type","hidden").parents("li").hide();
			$("input[name='idcard']").attr("type","text").parents("li").show();  
			break;	
     case "16"://湖北咸宁社保			
     	$("form").attr("action",sb_form_action);
     	$("input[name='name']").attr("type","text").parents("li").show();
     	$("input[name='cardNo']").attr("type","hidden").parents("li").hide();
			$("input[name='idcard']").attr("type","text").parents("li").show();  
			break;
     case "17"://湖北荆门社保			
     	$("form").attr("action",sb_form_action);
     	$("input[name='cardNo']").attr("type","hidden").parents("li").hide();
			$("input[name='name']").attr("type","text").parents("li").show();
			$("input[name='idcard']").attr("type","text").parents("li").show(); 
			break;
     case "18"://湖北黄石社保			
     	$("form").attr("action",sb_form_action);
			$("input[name='name']").attr("type","hidden").parents("li").hide();
			$("input[name='cardNo']").attr("type","hidden").parents("li").hide();
			$("input[name='idcard']").attr("type","text").parents("li").show();  
			break;	
     case "19"://湖北鄂州社保			
     	$("form").attr("action",sb_form_action);
			$("input[name='name']").attr("type","hidden").parents("li").hide();
			$("input[name='idcard']").attr("type","text").parents("li").show(); 
			$("input[name='cardNo']").attr("type","text").parents("li").show();   
			break;	
     case "20"://湖北仙桃社保			
     	$("form").attr("action",sb_form_action);
			$("input[name='name']").attr("type","hidden").parents("li").hide();
			$("input[name='idcard']").attr("type","text").parents("li").show();   
			$("input[name='cardNo']").attr("type","hidden").parents("li").hide();   
			break;
     case "21"://青岛社保			
     	$("form").attr("action",sb_form_action);
			$("input[name='name']").attr("type","hidden").parents("li").hide();
			$("input[name='idcard']").attr("type","text").parents("li").show();   
			$("input[name='cardNo']").attr("type","hidden").parents("li").hide();   
			break;
    case "22"://福州公积金			
 	    $("form").attr("action",gjj_form_action);
 	    $("input[name='name']").attr("type","hidden").parents("li").hide();
			$("input[name='idcard']").attr("type","hidden").parents("li").hide();   
			$("input[name='cardNo']").attr("type","text").parents("li").show();   
			break;
    case "23"://合肥公积金			
 	    $("form").attr("action",gjj_form_action);
	    	$("input[name='name']").attr("type","hidden").parents("li").hide();
			$("input[name='idcard']").attr("type","hidden").parents("li").hide();   
			$("input[name='cardNo']").attr("type","text").parents("li").show();   
			break;
    case "24"://合肥社保			
    	$("form").attr("action",sb_form_action);
			$("input[name='name']").attr("type","text").parents("li").show();
			$("input[name='idcard']").attr("type","text").parents("li").show();   
			$("input[name='cardNo']").attr("type","hidden").parents("li").hide();   
			break;
    case "25"://深圳社保			
       	$("form").attr("action",sb_form_action);
     	$("input[name='name']").attr("type","hidden").parents("li").hide();
			$("input[name='idcard']").attr("type","hidden").parents("li").hide();   
			$("input[name='cardNo']").attr("type","text").parents("li").show();  
			break;
    case "26"://曲靖公积金			
   	    $("form").attr("action",gjj_form_action);
  	    $("input[name='name']").attr("type","hidden").parents("li").hide();
			$("input[name='idcard']").attr("type","text").parents("li").show();   
			$("input[name='cardNo']").attr("type","text").parents("li").show(); 
			break;
    case "27"://深圳公积金			
	    $("form").attr("action",gjj_form_action);
	    	$("input[name='name']").attr("type","hidden").parents("li").hide();
			$("input[name='idcard']").attr("type","hidden").parents("li").hide();   
			$("input[name='cardNo']").attr("type","text").parents("li").show();   
			break;
    case "28"://呼和浩特公积金			
   	    $("form").attr("action",gjj_form_action);
  	   		$("input[name='name']").attr("type","text").parents("li").show();
			$("input[name='idcard']").attr("type","text").parents("li").show();   
			$("input[name='cardNo']").attr("type","hidden").parents("li").hide();   
			break;
    case "29"://呼和浩特社保			
      	$("form").attr("action",sb_form_action);
    	    $("input[name='name']").attr("type","hidden").parents("li").hide();
			$("input[name='idcard']").attr("type","text").parents("li").show();   
			$("input[name='cardNo']").attr("type","hidden").parents("li").hide();  
			break;
    case "30"://德州社保			
      	$("form").attr("action",sb_form_action);
    	    $("input[name='name']").attr("type","hidden").parents("li").hide();
			$("input[name='idcard']").attr("type","text").parents("li").show();   
			$("input[name='cardNo']").attr("type","hidden").parents("li").hide();  
			break;
    case "31"://台州社保			
      	$("form").attr("action",sb_form_action);
    	    $("input[name='name']").attr("type","hidden").parents("li").hide();
			$("input[name='idcard']").attr("type","text").parents("li").show();   
			$("input[name='cardNo']").attr("type","hidden").parents("li").hide();  
			break;
    case "32"://连云港社保			
       	$("form").attr("action",sb_form_action);
     	    $("input[name='name']").attr("type","hidden").parents("li").hide();
			$("input[name='idcard']").attr("type","text").parents("li").show();   
			$("input[name='cardNo']").attr("type","hidden").parents("li").hide();  
			break;
    case "33"://苏州社保			
       	$("form").attr("action",sb_form_action);
     	    $("input[name='name']").attr("type","hidden").parents("li").hide();
			$("input[name='idcard']").attr("type","hidden").parents("li").hide();   
			$("input[name='cardNo']").attr("type","text").parents("li").show();  
			break;
    case "34"://泰安社保			
       	$("form").attr("action",sb_form_action);
            $("input[name='name']").attr("type","hidden").parents("li").hide();
			$("input[name='idcard']").attr("type","text").parents("li").show();   
			$("input[name='cardNo']").attr("type","hidden").parents("li").hide();  
			break;
    case "35"://南通公积金
		
		$("form").attr("action",gjj_form_action);
		$("input[name='cardNo']").attr("type","hidden").parents("li").hide();
		$("input[name='name']").attr("type","text").parents("li").show();
		$("input[name='idcard']").attr("type","text").parents("li").show();   
		break;
    case "36"://常德公积金
		
		$("form").attr("action",gjj_form_action);
		$("input[name='cardNo']").attr("type","hidden").parents("li").hide();
		$("input[name='name']").attr("type","hidden").parents("li").hide();
		$("input[name='idcard']").attr("type","text").parents("li").show();   
		break;
    case "38"://衡阳公积金
		
		$("form").attr("action",gjj_form_action);
		$("input[name='cardNo']").attr("type","hidden").parents("li").hide();
		$("input[name='name']").attr("type","hidden").parents("li").hide();
		$("input[name='idcard']").attr("type","text").parents("li").show();   
		break;
		default:
			$("form").attr("action","");
	
	} 
		
	}
/**
 * 为所有下拉框绑定选择事件
 */
function select($show,$select,i){
    
    $select.change(function(){
    	
    	$show.html($select.find('option:checked').text());
        var tempValue=$select.find("option:checked").val();
        var tempName=$select.find('option:checked').text();
        //选城市
    	if(i==0){
    		//console.log("选city");
    		initTypeItem(objArray,tempName);
    		
    	}else{//选类型
    		
    		//console.log("选type");
    		handlerType(tempValue);
    	}
    	
    	$("#errorTip").html("");
    	
    });  
}
$(function(){
	initCityItem(objArray);
	var  $select = $('select'),
	$selectShow =  $('[data-show="selected"]');
	$.each($select, function(i){
	    select($selectShow.eq(i),$select.eq(i),i);
	});
	
	$("#idcard").blur(function(){
			
			if($(this).val().length>0){
				$("#errorTip").remove();
			}
		});
	
});
</script>
</body>
</html>

