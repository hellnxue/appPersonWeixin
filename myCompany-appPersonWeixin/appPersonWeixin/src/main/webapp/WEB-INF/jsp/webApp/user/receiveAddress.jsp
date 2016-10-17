<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<!-- 设置密码 -->
<es:webAppNewHeader title="体检预约" description="智阳网络技术" keywords="智阳网络技术"/>
<header class="am-header am-header-default am-no-layout" data-am-widget="header">
<div class="am-titlebar-left"> <a class="bak_ico" title="返回" href="javascript:history.go(-1)"><em></em></a> </div>
  <h1 class="am-header-title">收货地址</h1>
 <div class="am-titlebar-right"> <a title="" class="home_ico" href="${ctx}/webApp/index"><em></em></a> </div>
</header>
<body style="background-color: white">
 <div class="add-address">
  <ul class="am-list am-list-static am-list-border" id="datalist">
  </ul>
</div>
<div class="btns am-g am-text-center"><a class="am-btn am-btn-danger am-radius am-btn-block" href="${ctx }/webApp/user/addAddress" id="addressAdd">+ 新建地址</a></div>

<es:webAppNewFooter/>
<script src="${ctx}/static/assets/js/jquery.min.js"></script> 
<script src="${ctx}/static/assets/js/int.web.js"></script> 
<script src="${ctx}/static/assets/js/amazeui.js"></script> 
<script src="${ctx}/static/assets/js/jquery.transit.js"></script> 
<script src="${ctx}/static/assets/js/int.com.js" type="text/javascript"></script>
<script>

$(function() {
	
	    $("#addressAdd").on("click",function(){
	    	if("${paramflag}"=="onlyaddress"){
				window.location.href="${ctx }/webApp/user/addAddress?param=onlyaddress";
			}else{
				window.location.href="${ctx}/webApp/user/addAddress";
			}
	    	
	    });
	
	//查询收获地址列表
				$.ajax({
					type : "post",
					url : "${ctx}/hrhelper-platform/receiveList",
					dataType : "json",
					async : false,
					success : function(data) {
						if (data.errorMessage !== undefined) {
							console.log("错误消息！");
							return;
						}

						var arrays = data.key;
						var flag="${paramflag}";
						var clickfunction="getaddressinfo";
						var updatehref="${ctx }/webApp/user/updateAddress?receivingAddrId=";
						if(flag=="onlyaddress"){
							clickfunction="getaddressinfotouser";
							updatehref="${ctx }/webApp/user/updateAddress?param=onlyaddress&&receivingAddrId=";
						}
						arrays.forEach(function(item, index, array) {
									var li="<li>";
									if(item.isDefault==1){
										 li='<li class="cur">';
									}
									var mobile=item.mobilePhone;
									if(mobile==undefined){
										mobile="";
									}
									var datahtml = li+'<div class="am-g"> <div class="am-u-sm-10" style="cursor:pointer;" '
											+ 'onClick="'+clickfunction+'(' + "\'"+ item.receivingAddrId+ "\'"+ ',' + "\'"+ item.receivingName+ "\'"+ ','+
													"\'"
											+ mobile
											+ "\'"
											+ ','
											+ "\'"
											+ item.detailedAddr
											+ "\'"
											+ ')">'
											+ '<p><span class="am-padding-right-xl"><i class="am-icon-user"></i>'
											+ item.receivingName
											+ ' </span>'
											+ '<span id="phone"><i class="am-icon-phone"></i>'
											+ mobile
											+ '</span></p>'
											+ '<p class="am-text-sm am-list-item-text" >'
											+ item.detailedAddr
											+ '</p>'
											+ ' </div><div class="am-u-sm-2 am-vertical-align am-text-center" style="height:60px;">'
											+ '<div class="am-vertical-align-middle"><a onClick="updateaddress('+item.receivingAddrId+')" href="#">'
											+ '<i class="am-icon-edit am-text-xl"></i></a></div></div> </div> </li>';

									$("#datalist").append(datahtml);
									
									
								});
									
									/* if(flag=="onlyaddress"){
										console.log("llllllllllllll");
										$("#datalist li>div>div").removeAttr("onclick");
										
									} */

					}

				});

		

	});
	
    //点击选择收获地址
	function getaddressinfo(receivingAddrId,receivename, mobile, detailaddr) {
		var adname = encodeURI(encodeURI(receivename.trim()));
		var adphone = encodeURI(encodeURI(mobile.trim()));
		var adaddress = encodeURI(encodeURI(detailaddr.trim()));

		console.log("receivingAddrId==" + receivingAddrId);
		 window.location.href = "${ctx }/webApp/tijian/tijian13?adname="
				+ adname
				+ "&adphone="
				+ adphone
				+ "&adaddress="
				+ adaddress
				+"&receivingAddrId="
				+receivingAddrId
				+ "&year=${param.year}&month=${param.month}&day=${param.day}&service_id=${param.service_id}&service_store_id=${param.service_store_id}&prodid=${param.prodid}&&fkbox=${param.fkbox}&receivingAddrId=1";

	}
    
    //点击修改收货地址
    function getaddressinfotouser(receivingAddrId,receivename, mobile, detailaddr){
    	window.location.href="${ctx }/webApp/user/updateAddress?receivingAddrId="+receivingAddrId;
    }
    
    function updateaddress(receivingAddrId){
    		if("${paramflag}"=="onlyaddress"){
				window.location.href="${ctx }/webApp/user/updateAddress?receivingAddrId="+receivingAddrId+"&param=onlyaddress";
			}else{
				window.location.href="${ctx }/webApp/user/updateAddress?receivingAddrId="+receivingAddrId;
			}
    }
</script> 

</body>
</html>