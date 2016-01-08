$(document).ready(function() {
    window.headslider = new Swipe(document.getElementById("headslider"), {
        startSlide: 0,
        speed: 600,
        auto: 2e3,
        autoRestart: !0,
        continuous: !0,
        callback: function(e) {
            $(".banner .trigger span").each(function(t) {
                t == e ? $(this).addClass("cur") : $(this).removeClass("cur")
            })
        }
    });
    var e = function() {
        var e = new Date;
        e.getHours() > 7 && e.setDate(e.getDate() + 1),
        e.setHours(7),
        e.setMinutes(0),
        e.setSeconds(0);
        var t = e.getTime() - Date.now(),
        a = Math.floor(t / 36e5 % 24),
        o = Math.floor(t / 6e4 % 60),
        i = Math.floor(t / 1e3 % 60);
        a = 10 > a ? "0" + a: a,
        o = 10 > o ? "0" + o: o,
        i = 10 > i ? "0" + i: i,
        $("#hour").html(a),
        $("#minute").html(o),
        $("#second").html(i)
    };
    e(),
    setInterval(e, 1e3),
    window.limitslider = new Swipe(document.getElementById("limitslider"), {
        startSlide: 0,
        speed: 600,
        auto: 2e3,
        autoRestart: !0,
        continuous: !0,
        callback: function(e) {
            $(".limit .trigger span").each(function(t) {
                t == e ? $(this).addClass("cur") : $(this).removeClass("cur")
            })
        }
    }),
    $("#float_head").css("visibility", "hidden"),
    $("#float_head").css("display", "block");
    var t = $("#float_head").height();
    $("#float_head").css("visibility", ""),
    $("#float_head").css("display", "none"),
    $(window).scroll(function() {
        var e = $(this).scrollTop();
        e >= t ? ($("#float_head").show(), $(".back_top").show()) : ($("#float_head").hide(), $(".back_top").hide())
    }),
    $(".back_top").click(function() {
        var e = 0,
        t = 800,
        a = 5;
        t /= a;
        var o = $(window).scrollTop(),
        i = (o - e) / t,
        r = setInterval(function() {
            var e = $(window).scrollTop();
            0 >= e ? clearInterval(r) : (e -= i, $(window).scrollTop(e))
        },
        a)
    }),
    $("#recommendationTab").click(function() {
        $(this).addClass("cur"),
        $("#historyTab").removeClass("cur"),
        $("#recommendation").show(),
        $("#history").hide()
    }),
    $("#historyTab").click(function() {
        $(this).addClass("cur"),
        $("#recommendationTab").removeClass("cur"),
        $("#recommendation").hide(),
        $("#history").show()
    }),
    template.config("openTag", "<%"),
    template.config("closeTag", "%>");
    try {
        if (localStorage) {
            var a = localStorage.getItem("t_products_history") || [];
            a.length > 0 ? (a = JSON.parse(a).reverse().join(","), $.ajax({
                type: "GET",
                url: "http://app.yixun.com/tjson.php?mod=asearch&act=getbyids",
                dataType: "jsonp",
                jsonp: "callback",
                data: {
                    ids: a
                },
                success: function(e) {
                    if (0 == e.errno) {
                        for (var t in e.data) {
                            e.data[t].show_price = (e.data[t].show_price / 100).toFixed(2);
                            var a = e.data[t],
                            o = a.product_char_id,
                            i = o.split("-", 3),
                            r = parseInt(i[2]) % 2 ? "http://img1.icson.com/product/pic200/": "http://img2.icson.com/product/pic200/";
                            r += i[0] + "/" + i[1] + "/" + o + ".jpg",
                            e.data[t].picUrl = r
                        }
                        var s = ($("#history ul").html(), template("artTemplate", e));
                        $("#history ul").html(s)
                    }
                },
                error: function() {}
            })) : $("#history ul").html("")
        }
    } catch(o) {}
    var i = navigator.userAgent.toLocaleLowerCase(),
    r = "http://stat.51buy.com/stat.fcg?",
    s = ["type=1", "uid=0", "pageid=103620100", "plevel=2", "tag=", "url=" + encodeURI(window.location.href), "refer=", "referid=0", "guid=0", "resolution=", "color=", "pid=0", "ext="],
    n = "whid=1992";
    i.indexOf("micromessenger") > -1 ? n = "whid=1997": i.indexOf("yixun") > -1 ? i.indexOf("android") > -1 ? n = "whid=99042": i.indexOf("iphone") > -1 ? n = "whid=99041": i.indexOf("ipad") > -1 && (n = "whid=99043") : n = i.indexOf("android") > -1 ? "whid=1990": i.indexOf("iphone") > -1 || i.indexOf("ipad") > -1 ? "whid=1991": "whid=1992",
    s.push(n);
    var d = new Image(1, 1);
    d.src = r + s.join("&")
});