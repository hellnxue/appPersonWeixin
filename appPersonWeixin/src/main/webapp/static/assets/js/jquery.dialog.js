/*
 * Dialog 1.0
 * version: 3.0 (03/27/2014)
 * @ jQuery v1.3.*
 *
 * Licensed under the GPL:
 *   http://www.mohism.cn
 *
 * Copyright 2013, 2016 Junill [ web@mohism.cn ] 
 *  
*/
$.extend($, {
    Dialog: function(setting) {
        var ps = $.fn.extend({
            data: {},
            marginTop: 100,
            buttonText: { ok: '确认', cancel: '取消' },
            okEvent: function(e) { },
            width: 270,
            fixed: true,
			location:false,
            title: '信息提示',
            content: '这是一个信息提示插件!',
            skinId: 'dialog-main'
        }, setting);
        //var allSel = $('select').hide(), doc = $(document);
        var  doc = $(document);

        ps.docWidth = doc.width();
        ps.docHeight = doc.height();
        var cache, cacheKey = 'jericho_modal';

        if ($('#dialog-overlay').length == 0) {
            $('<div id="dialog-overlay" class="dialog-overlay"/>\
                <div class="dialog-main" id="dialog-main" >\
                    <div class="dialog-middle">\
                        <div class="dialog-middle-content">\
                            <div class="dialog-content" id="dialog-container-content" />\
                            <div class="dialog-opts">\
                                <input type="button"/>&nbsp;&nbsp;<input type="button" id="DialogCancel" />\
                            </div>\
                        </div>\
						<button class="dialog-close"></button>\
                    </div>\
                </div>').appendTo('body');
            //$(document.body).find('form:first-child') || $(document.body)
        }

        if (window[cacheKey] == undefined) {
            cache = {
                overlay: $('#dialog-overlay'),
                modal: $('#dialog-main'),
                cancel: $('.dialog-close'),
                opts: $('.dialog-opts'),
                body: $('#dialog-container-content')
            };
            cache.title = cache.body.prev();
            cache.buttons = cache.opts.children();
            window[cacheKey] = cache;
        }
        cache = window[cacheKey];
        var args = {
            hide: function() {
                cache.modal.fadeOut();
                cache.overlay.hide();
            },
            isCancelling: false
        };

        if (!cache.overlay.is(':visible')) {
            cache.overlay.css({ opacity: .3 }).show();
            cache.modal.attr('class', ps.skinId)
                        .css({
                            position: (ps.fixed ? 'fixed' : 'absolute'),
                            width: ps.width,
                            left: (ps.docWidth - ps.width) / 2,
                            top: (ps.marginTop)
                        }).fadeIn();
        }
        cache.title.html(ps.title);
        //OK BUTTON
		if(ps.buttonshow){
		  cache.opts.show();
		  cache.buttons.eq(0).val(ps.buttonText.ok).unbind('click').click(function(e) {
			  //allSel.show();
			  ps.okEvent(ps.data, args);
			  if (!args.isCancelling) {
				  args.hide();
			  }
		  }).next().val(ps.buttonText.cancel).one('click', function() { args.hide(); if(ps.location){location.reload();} /*allSel.show();*/ });
		}
		//CANCEL BUTTON
        //cache.buttons.next().val(ps.buttonText.cancel).one('click', function() { args.hide(); allSel.show(); });
		//cache.cancel.live("click",function(){  args.hide(); /*allSel.show();*/if(ps.location){location.reload();} });
		cache.cancel.one('click', function() { args.hide(); /*allSel.show();*/if(ps.location){location.reload();} });

        if (typeof ps.content == 'string') {
            $('#dialog-container-content').html(ps.content);
        }
        if (typeof ps.content == 'function') {
            ps.content(cache.body);
        }
    }
})





/**操作参考**/
/*$('a.fixed').click(function() {
  $.fn.jmodal({
	  data: { innerText: $(this).text() },
	  title: 'Information',
	  content: 'I am always fixed in the middle of screen(just scroll)!',
	  buttonText: { ok: 'Yes,It is.', cancel: 'No' },
	  fixed: true,
	  okEvent: function(data, args) {
		  alert(data.innerText);
	  }
  });
});

$('a.absolute').click(function() {
  $.fn.jmodal({
	  title: 'Information',
	  content: 'I am a absolute dialog!',
	  buttonText: { ok: 'Yes,It is.', cancel: 'No' },
	  okEvent: function(data, args) {
	  
	  }
  });
});

$('a.ajax').click(function() {
  $.fn.jmodal({
	  title: 'Information',
	  content: function(body) {
		  body.html('loading...');
		  body.load('template/msn.htm');
	  },
	  buttonText: { ok: 'Yes,It is.', cancel: 'No' },
	  okEvent: function(data, args) {
		  
	  }
  });
});

var txtInput;
$('a.withtext').click(function() {
  $.fn.jmodal({
	  title: 'input',
	  content: function(body) {
		  body.html('<input type="text" id="txtInput" />');
		  txtInput = $('#txtInput');
	  },
	  buttonText: { ok: 'Yes,It is.', cancel: 'No' },
	  okEvent: function(data, args) {
		  if($.trim(txtInput.val())==''){
			  args.isCancelling=true;
			  alert('required.');
		  }
		  else{
			  args.isCancelling=false;
			  alert(txtInput.val());
		  }
	  }
  });
});*/