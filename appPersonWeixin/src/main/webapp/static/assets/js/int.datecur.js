$(document).ready(function() {
    // 预约日历
    (function() {
        var $makedate = $('#makedate'),
        $dataList = $makedate.find('.data-list'),
        dateUrl = $makedate.data('url'),
        bookingUrl = $makedate.data('bookurl');
        if (!$makedate.length) {
            return;
        };

        var date = new Date();
        var teday = date.getDate();
        var teMonth = date.getMonth()+1;
        var teYear = date.getFullYear();
        //console.log(date.toLocaleString());
        (function() {
           /* var month = date.getMonth();
            date.setDate(1);
            date.setMonth(month + 1);
            date.setDate(0);*/
            getCountDays(date);
            setCurrMonth(date);
            //console.log(month)
        })();

        $dataList.on('click', '.license',
        function() {
            var $span = $(this);
            var day = parseInt($span.data('day'));
            $span.addClass('active').siblings().removeClass('active');
            gainBooking(date.getFullYear(), date.getMonth() + 1, day);
        });

        $makedate.on('click', '.left-btn',
        function() {
        	 date.setDate(1);
            var month = date.getMonth() - 1;
            date.setMonth(month);
           
            //console.log(date);
            getCountDays(date);
            setCurrMonth(date);
        });

        $makedate.on('click', '.right-btn',
        function() {
        	 date.setDate(1);
            var month = date.getMonth() + 1;
            console.log("right-------"+month);
            date.setMonth(month);
           

            getCountDays(date);
            setCurrMonth(date);
        });

        // 计算一个月有多少天
        function getCountDays(date) {
        	 
        	 var service_id=$("#serviceId").val();
             var service_store_id=$("#servicestoreid").val();
             var userid=$("#userid").val();
            var tem = new Date(date.getFullYear(),date.getMonth()+1, 0);
            console.log("date="+tem);
            var count = tem.getDate();
            tem.setDate(1);
            var week = tem.getDay();

           /* if (week == 0) {
                // week = 7;
            };
*/
            $.ajax({
                url: dateUrl,
                type: 'get',
                dataType: 'json',
                data: {
                	service_id : service_id,      //服务券id
        			service_store_id : service_store_id,//门店id
        			userid:userid,//用户id
        			year : date.getFullYear(),
        			month : date.getMonth() + 1

                }
            }).done(function(data) {

                if (data == null || data == '') {
                    data = {};
                    data.list = [];
                };
                var html = '',
                licensearr = data.license,
                banarr = data.ban,
                bookingarr = data.booking,
                fullarr = data.full;
                //console.log(data.license);
                for (var i = 0; i < week; i++) {
                    html += '<a class="none"><span></span></a>';
                };

                for (var i = 1; i <= count; i++) {
                    html += '<a data-day="' + i + '" class="';

                    if (i < 8 - week) {
                        html += ' none';
                    }

                    if ($.inArray(i, licensearr) >= 0) {
                        html += ' license';
                    }

                    if ($.inArray(i, banarr) >= 0) {
                        html += ' ban';
                    }

                    if ($.inArray(i, fullarr) >= 0) {
                        html += ' full';
                    }

                    if ($.inArray(i, bookingarr) >= 0) {
                        html += ' booking';
                    }

                    if (teday === i && teMonth === date.getMonth() && teYear === date.getFullYear()) {
                        html += ' teday';
                    }

                    html += '" href="javascript:void(0);">';

                    html += i;
                    html += '<span></span></a>';
                };

                // 置入
                $dataList.removeClass('animate').html(html);
                // setTimeout(function () {
                $dataList.addClass('animate')
                // },30);

                //$dataList.find('.has:first').trigger('click');
            }).fail(function() {
                // console.log("error");
            }).always(function() {
                // console.log("complete");
            });
        }

        // 预约提交情况
        function gainBooking(year, month, day) {
            console.log(year + '年/' + month + '月/' + day + '日');
            var service_id=$("#serviceId").val();
            var service_store_id=$("#servicestoreid").val();
			var daycur = day;
			var result=year+"年"+month+"月"+day+"日";
			var info="您确定预约"+result+"的体检项目吗？";
			window.location.href=ctx+"/webApp/tijian/tijian13?year="+year+"&month="+month+"&day="+day+"&service_id="+service_id+"&service_store_id="+service_store_id+"&prodid="+proid;
			
			/*$.Dialog({ title: '提示消息', content: '<div class="errortip">'+info+'</div>', fixed: true, buttonshow: true,okEvent: function(data, args) {
				
				$.ajax({
	                url: ctx+"/hrhelper-platform/submitMedicalAppointment",
	                type: 'get',
	                dataType: 'json',
	                data: {year: year, month: month, day: day,username:username,service_id:service_id,service_store_id:service_store_id}
	            })
	            .done(function(data) {
	                // console.log("success");
	                //var html = template('dateTpl', data);
//	            	console.log(args);
//					$("[data-day]").removeClass('license').removeClass('ban').removeClass('full');
//					$("[data-day='"+ daycur +"']").addClass('booking');
					//.siblings().removeClass('active')
					location.reload(true); 
					
	            })
	            .fail(function() {
	                // console.log("error");
	            })
	            .always(function() {
	                // console.log("complete");
	            });
				
			}});*/
			
			
			
			
			
        }

        // 当前月份
        function setCurrMonth(date) {
        	
            var month = date.getFullYear() + ' 年 ' + (date.getMonth() + 1) + ' 月';
            $makedate.find('h3').text(month);

        }
    })($);

});