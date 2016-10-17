<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit">
    <meta name="hotcss" content="max-width=750">
    <title>我的积分</title>
    <link rel="stylesheet" href="${ctx}/static/huifuli/css/normalize.css">
    <link rel="stylesheet" href="${ctx}/static/huifuli/css/main.css">
    <script src="${ctx}/static/huifuli/js/hotcss.min.js"></script>
</head>
<body>
<div class="header">
        我的积分
        <a href="javascript:history.go(-1)" class="h_back"><i class="icon icon-backward"></i></a>
    </div>
    <div class="container" id="tab">
        <div class="hd panel-heading">
            <ul class="panel-nav">
                <li><a href="javascript://">全部</a></li>
                <li><a href="javascript://">领取记录</a></li>
                <li><a href="javascript://">消费记录</a></li>
            </ul>
        </div>
        <div class="bd panel-body" id="tab-bd">
            <div class="panel-body-content">
                <ul class="float" id="allhtml">
                </ul>
            </div>
            <div class="panel-body-content">
                <ul class="float" id="lingqu">
                </ul>
            </div>
            <div class="panel-body-content">
                <ul class="float" id="xiaofei">
                </ul>
            </div>
        </div>
    </div>
    <script src="${ctx}/static/huifuli/js/jquery.js"></script>
    <script src="${ctx}/static/huifuli/js/TouchSlide.1.1.js"></script>
    <script src="${ctx}/static/huifuli/js/main.js"></script>
    <script type="text/javascript">
        TouchSlide({
            slideCell: '#tab',
            endFun: function(i) { //高度自适应
                var bd = document.getElementById('tab-bd');
                bd.parentNode.style.height = bd.children[i].children[0].offsetHeight + 'px';
                if ( i>0 ) {
                    bd.parentNode.style.transition = '200ms';
                }
            }
        });
        
        var resultObj=${result};
        $(function(){
       	 		var obj=resultObj.obj[0].list;
       	 		for(var i=0;i<obj.length;i++){
       	 			var type=obj[i].operateType;
       	 			var yue=obj[i].balance;
       	 			var total=obj[i].point;
       	 			var date=obj[i].createDate;
       	 			var typeStr="";
       	 			var style=""
       	 			if(type == 1 || type == 3 || type == 6 ){
       	 			style="text-green m-b-md";
       	 			total="-"+total;
       	 			}else{
       	 			style="text-red m-b-md";
       	 			total="+"+total;
       	 			}
       	 			switch(type)
       	 			{
       	 			case 1:
       	 			 typeStr="消费";
       	 	 		 break;
       	 			case 2:
       	 		 	typeStr="充值";
       	 	 		 break;
       	 			case 3:
      	 		 	typeStr="赠送";
      	 			break;
       	 			case 4:
     	 			 typeStr="退款";
     	 			break;
       				case 5:
  	 		 		typeStr="受赠";
  	 		 		break;
       				case 6:
      	 			 typeStr="现金福利卡充值";
      	 			 break;
       	 			default:
       	 			typeStr="";
       	 			}
       	 			var allhtml='<li> <div class="panel-body-content-left">'+
                    		'<strong>'+typeStr+'</strong>'+
                    		'<p class="text-gray m-t-md">余额：'+yue+'</p></div>'+
                			'<div class="panel-body-content-right">'+
                   			'<p class="'+style+'">'+total+'</p>'+
                  			'<strong>'+date+'</strong> </div></li>';
                  	$("#allhtml").append(allhtml);		
                  	if(type == 1 || type == 3 || type == 6 ){
                  		$("#xiaofei").append(allhtml);
           	 			}else{
           	 			$("#lingqu").append(allhtml);
           	 			}
       	 		}
        	 
         });
    </script>
</body>
</html>
