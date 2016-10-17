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
        var teMonth = date.getMonth();
        var teYear = date.getFullYear();
        //console.log(date.toLocaleString());
        (function() {
            var month = date.getMonth();
            date.setDate(1);
            date.setMonth(month + 1);
            date.setDate(0);
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
            var month = date.getMonth() - 1;
            date.setMonth(month + 1);
            date.setDate(0);
            //console.log(date);
            getCountDays(date);
            setCurrMonth(date);
        });

        $makedate.on('click', '.right-btn',
        function() {
            var month = date.getMonth() + 1;
            date.setMonth(date.getMonth() + 1);
            date.setDate(1);

            getCountDays(date);
            setCurrMonth(date);
        });

        // 计算一个月有多少天
        function getCountDays(date) {
            var tem = new Date(date.getFullYear(), date.getMonth() + 1, 0);
            var count = tem.getDate();

            tem.setDate(1);
            var week = tem.getDay();

            if (week == 0) {
                // week = 7;
            };

            $.ajax({
                url: dateUrl,
                type: 'get',
                dataType: 'json',
                data: {
                    year: date.getFullYear(),
                    month: date.getMonth() + 1
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
			var daycur = day;
			$.ajax({
                url: bookingUrl,
                type: 'get',
                dataType: 'json',
                data: {year: year, month: month, day: day}
            })
            .done(function(data) {
                // console.log("success");
                //var html = template('dateTpl', data);
				$.Dialog({ title: '提示消息', content: '<div class="errortip">'+data.tipinfo+'</div>', fixed: true, buttonshow: true,okEvent: function(data, args) {
					console.log(args);
					$("[data-day]").removeClass('license').removeClass('ban').removeClass('full');
					$("[data-day='"+ daycur +"']").addClass('booking');
					//.siblings().removeClass('active')
	  
				}});
				
            })
            .fail(function() {
                // console.log("error");
            })
            .always(function() {
                // console.log("complete");
            });
			
        }

        // 当前月份
        function setCurrMonth(date) {
			console.log(date.getMonth());
            var month = date.getFullYear() + ' 年 ' + (date.getMonth() + 1) + ' 月';
            var monthArr = ['一月份', '二月份', '三月份', '四月份', '五月份', '六月份', '七月份', '八月份', '九月份', '十月份', '十一月份', '十二月份']

            $makedate.find('h3').text(month);

        }
    })($);

});