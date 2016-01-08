$(document).ready(function() {
    // 列表选择js
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
			 
		});
		
		chooseData.click(function(e){
			chooseMask.show();
			chooseSelected.show();
			
			var province_data = $("#province-value").val();
			 
			
			$(".static-province li").each(function(){
				if($(this).children("a").html() == province_data){
					$(this).addClass('cur');
				}
			});
			 
			
			$(".static-province").show();
        });
		
		$(document).on('click', '.static-province li', function() {
			 
			$(this).addClass('cur').siblings("li").removeClass('cur');
			var province_val = $(".static-province li.cur").children("a").html();
			var province_id=$(".static-province li.cur").children("a").attr("data-value");
//			 console.log(province_val);
//			 console.log($(".static-province li.cur").children("a").attr("data-value"));
			 
			$("#address-view").val(province_val);
			$("#address-id").val(province_id);
			
			chooseMask.hide();
			chooseSelected.hide();
		});
		
		
    })($);

});