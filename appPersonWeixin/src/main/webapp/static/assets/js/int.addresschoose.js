//根据条件加载地区
function  getAreaInfo( parentId, identifier){
	$.ajax({
		url : ctx+"/hrhelper-platform/areaInfo",
		type : "get",
		dataType : "json",
		data : {
			parentId : parentId,		
			identifier : identifier			
		},
		async:false,  
		success : function(data) {
			 if(data.errorMessage!==undefined){
	              console.log("错误消息！");
	              return;
	          }
	         var arearry=data.key;
	         var item_list="";
	         if(arearry){
	        	 arearry.forEach(function(item,index,array){
	        		 item_list+='<li><a data-value="'+item.id+'">'+item.areaName+'</a></li>';
	        		 
	        	 });
	        	 
	        	 switch(identifier){
		         	case 1:
		         		$(".static-province").html(item_list);
		         		break;
		         	case 2:
		         		$(".static-city").html(item_list).show();
		         		$(".static-province").hide();
		         		break;
		         	case 3:
		         		$(".static-area").html(item_list).show();
		         		$(".static-city").hide();
		         		break;
		         	case 4:
		         		$(".static-load").html(item_list).show();
						$(".static-area").hide();
		         		break;
		         	default:
		         		console.log("hello");
		        	 
		         }
	         }
	         
			
		}
	});
	
}

$(document).ready(function() {
	getAreaInfo(null, 1);//地域
	
    // 地址选择类
    (function() {
        var chooseData = $('.address-choose'),
		chooseMask = $('.address-mask'),
		chooseSelected = $('.address_selected');
		
		$(document).mouseup(function(event){ 
		  if($(event.target).parents(".address_selected").length==0){
			chooseMask.hide();
			chooseSelected.hide();
		  } 
		});
		
		$(".address-choose-close").click(function(e){
			chooseMask.hide();
			chooseSelected.hide();
			$(".static-city").hide();
			$(".static-area").hide();
			$(".static-load").hide();
		});
		
		chooseData.click(function(e){
			chooseMask.show();
			chooseSelected.show();
			
			var province_data = $("#province-value").val(),
			city_data = $("#city-value").val(),
			area_data = $("#area-value").val(),
			load_data = $("#load-value").val();
			
			$(".static-province li").each(function(){
				if($(this).children("a").html() == province_data){
					$(this).addClass('cur');
				}
			});
			$(".static-city li").each(function(){
				if($(this).children("a").html() == city_data){
					$(this).addClass('cur');
				}
			});
			$(".static-area li").each(function(){
				if($(this).children("a").html() == area_data){
					$(this).addClass('cur');
				}
			});
			$(".static-load li").each(function(){
				if($(this).children("a").html() == load_data){
					$(this).addClass('cur');
				}
			});
			
			$(".static-province").show();
        });
		
		//省
		$(".static-province li").on("click", function (e) {
			var dataid = $(this).children("a").data('value');
			$(this).addClass('cur').siblings("li").removeClass('cur');
			getAreaInfo( dataid, 2);
			
		});
		
		//市
		$(document).on('click', '.static-city li', function() {
			var dataid = $(this).children("a").data('value');
			$(this).addClass('cur').siblings("li").removeClass('cur');
			getAreaInfo( dataid, 3);
		});
		
		//区
		$(document).on('click', '.static-area li', function() {
			var dataid = $(this).children("a").data('value');
			$(this).addClass('cur').siblings("li").removeClass('cur');
			getAreaInfo( dataid, 4);
		});
		
		
		$(document).on('click', '.static-load li', function() {
			$(this).addClass('cur').siblings("li").removeClass('cur');
			
			var province_val = $(".static-province li.cur").children("a").html(),
			city_val = $(".static-city li.cur").children("a").html(),
			area_val = $(".static-area li.cur").children("a").html(),
			load_val = $(".static-load li.cur").children("a").html();
			
			var province_id=$(".static-province li.cur").children("a").attr("data-value");
			var city_id=$(".static-city li.cur").children("a").attr("data-value");
			var area_id=$(".static-area li.cur").children("a").attr("data-value");
			var load_id=$(".static-load li.cur").children("a").attr("data-value");
			
			
			$("#province-value").val(province_val);
			$("#city-value").val(city_val);
			$("#area-value").val(area_val);
			$("#load-value").val(load_val);
			
			$("#province-id").val(province_id);
			$("#city-id").val(city_id);
			$("#area-id").val(area_id);
			$("#load-id").val(load_id);
			
			$(".address-view").html("<span>"+province_val+"</span> <span>"+city_val+"</span> <span>"+area_val+"</span> <span  id='lastAdress'>"+load_val+"</span>");
			 
			var lastAddress=$(".address-view").find("#lastAdress").text();
			if(lastAddress!=""){
				
				$("#detailedAddr").removeAttr("disabled");
				
			 }
			$(".static-load").hide();
			chooseMask.hide();
			chooseSelected.hide();
		});
		
		
    })($);

});