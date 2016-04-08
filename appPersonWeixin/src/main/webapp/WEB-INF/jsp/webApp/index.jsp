<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<es:webAppNewHeader title="${appName}" description="智阳网络技术" keywords="智阳网络技术"/>

<header class="am-header am-header-default am-no-layout" data-am-widget="header"> 
   <h1 class="am-header-title index_title">${appName}</h1>
  <div class="am-titlebar-right"> <a title="" class="header-notice" href="msgs"></a><c:if test="${unReadPersonal>0}"> <span class="am-badge am-badge-danger am-round">${unReadPersonal}</span></c:if>  </div>
</header>

<div data-am-widget="slider" class="am-slider am-slider-a1" data-am-slider='{&quot;directionNav&quot;:false,touch:false}'  >
  <ul class="am-slides">
    <li> <img src="${ctx }/static/assets/images/fl04.png"> </li>
  </ul>
</div>

<div class="index_menu">
  <ul class="am-gallery am-avg-sm-2 am-gallery-default white-bg" data-am-gallery="{ pureview: true }">
    <!-- 资料上传-->
    <li id="tjyy">
      <div class="am-gallery-item"> <a href="${ctx }/webApp/user/dataUpload" > <img src="${ctx}/static/assets/images/fileUploads.png" alt="" />
        </a> </div>
    </li>
     <!-- 员工工资随时查 -->
    <li id="gzd">
      <div class="am-gallery-item"> <a href="${ctx}/webApp/salary" > <img src="${ctx}/static/assets/images/salaryData.png" alt="" />
        </a> </div>
    </li>
     <!-- 企业数据直通车 -->
    <li id="sbcx">
      <div class="am-gallery-item"> <a href="${ctx}/webApp/nationalGuard" class=""> <img src="${ctx}/static/assets/images/orgData.png"/>
        </a> </div>
    </li>
    <!--官方数据直通车 -->
    <li id="gzd">
      <div class="am-gallery-item"> <a href="${ctx }/webApp/sbGjjTools/officialData"> <img src="${ctx}/static/assets/images/officialData.png"/>
        </a> </div>
    </li>
    <!--体检预约 -->
    <li id="tjyy">
      <div class="am-gallery-item"> <a href="${ctx }/webApp/tijian/tijian" > <img src="${ctx}/static/assets/images/tijianData.png" alt="" />
        </a> </div>
    </li>
    <!--移动签到 -->
    <li id="tjyy">
      <div class="am-gallery-item"> <a href="${ctx }/webApp/empCheck" > <img src="${ctx}/static/assets/images/empChecks.png" alt="" />
        </a> </div>
    </li>
  </ul>
</div>

<div class="footer">
<div id="" class="am-navbar am-cf am-navbar-default am-no-layout" data-am-widget="navbar">
<!--[if (gte IE 9)|!(IE)]><!--> 
<script src="${ctx}/static/assets/js/jquery.min.js"></script> 
<script src="${ctx}/static/assets/js/int.web.js"></script> 
<script src="${ctx}/static/assets/js/amazeui.js"></script> 
<script src="${ctx}/static/assets/js/int.pageajax.js"></script>
<script src="${ctx}/static/assets/js/jquery.transit.js"></script> 
<ul class="am-navbar-nav am-cf am-avg-sm-5 fot_bg">
  <li class="footer01 cur"> <a href="${ctx}/webApp/index"> <span class="am-footer-ico"></span> <span class="am-navbar-label">首页</span></a></li>
  <li class="footer02"> <a href="${ctx}/webApp/empCheck"> <span class="am-footer-ico"></span> <span class="am-navbar-label">移动签到</span></a></li>
  <li class="footeradd"> <a> <span class="index-home-ico"><em></em></span></a></li>
  <li class="footer03"> <a href="${ctx}/webApp/msgs"> <span class="am-footer-ico"></span> <span class="am-navbar-label">消息</span></a></li>
  <li class="footer04"> <a href="${ctx}/webApp/user"> <span class="am-footer-ico"></span> <span class="am-navbar-label">我的</span></a></li>
</ul>
</div>
<div class="foot-home-over">
<div data-am-widget="slider" class="am-slider am-slider-default layer_list" data-am-slider='{&quot;animation&quot;:&quot;slide&quot;,&quot;slideshow&quot;:false}'>
  <ul style="margin-left:20px;">
    <li class="list01">
      <a href="${ctx}/webApp/tongxunlu"><dl class="icon01"><dt></dt><dd>通讯录</dd></dl></a>
    </li>
  </ul>
</div>
</div>
</div>
<script>
 
$(function() {
  var orgidArr=["354"];//企业id数组
  /**
    调用企业接口获得企业名称
  **/
  console.log("${mobile}");
    console.log("${userInfo.orgPerson.mobile}");
   $.getJSON("${ctx}/hrhelper-platform/orgInfo", {
            //mobile: "${mobile}"
	  		 mobile: "${userInfo.orgPerson.mobile}"
        }, function (data) {
           if(data.errorMessage!==undefined){
              console.log("错误消息！");
              return;
          }
          $("#orgName").text(data.ORG_CHINESE_NAME); 
          
          var orgid=data.org_id;
          var result= orgidArr.some(function(item,index,arrar){
      		   //console.log("item="+item);
      		   return item==orgid;
      		});
          
          //给指定的orgid去掉工资单  //org_id=354的用户，员工帮手只显示工资单
           if(result){
        	  $("#sbcx").remove();
        	  $("#gzb").remove();
        	  $("#tjyy").remove();
          } 
          
          
        }); 
});
</script> 
<!--<![endif]--> 
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.1/jquery.min.js"></script>
<![endif]--> 
<!--在这里编写你的代码-->

</body>
</html>