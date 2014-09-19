!function(e,t){e.rails!==t&&e.error("jquery-ujs has already been loaded!");var a,n=e(document);e.rails=a={linkClickSelector:"a[data-confirm], a[data-method], a[data-remote], a[data-disable-with], a[data-disable]",buttonClickSelector:"button[data-remote], button[data-confirm]",inputChangeSelector:"select[data-remote], input[data-remote], textarea[data-remote]",formSubmitSelector:"form",formInputClickSelector:"form input[type=submit], form input[type=image], form button[type=submit], form button:not([type]), input[type=submit][form], input[type=image][form], button[type=submit][form], button[form]:not([type])",disableSelector:"input[data-disable-with]:enabled, button[data-disable-with]:enabled, textarea[data-disable-with]:enabled, input[data-disable]:enabled, button[data-disable]:enabled, textarea[data-disable]:enabled",enableSelector:"input[data-disable-with]:disabled, button[data-disable-with]:disabled, textarea[data-disable-with]:disabled, input[data-disable]:disabled, button[data-disable]:disabled, textarea[data-disable]:disabled",requiredInputSelector:"input[name][required]:not([disabled]),textarea[name][required]:not([disabled])",fileInputSelector:"input[type=file]",linkDisableSelector:"a[data-disable-with], a[data-disable]",buttonDisableSelector:"button[data-remote][data-disable-with], button[data-remote][data-disable]",CSRFProtection:function(t){var a=e('meta[name="csrf-token"]').attr("content");a&&t.setRequestHeader("X-CSRF-Token",a)},refreshCSRFTokens:function(){var t=e("meta[name=csrf-token]").attr("content"),a=e("meta[name=csrf-param]").attr("content");e('form input[name="'+a+'"]').val(t)},fire:function(t,a,n){var r=e.Event(a);return t.trigger(r,n),r.result!==!1},confirm:function(e){return confirm(e)},ajax:function(t){return e.ajax(t)},href:function(e){return e.attr("href")},handleRemote:function(n){var r,i,o,l,s,u,d,c;if(a.fire(n,"ajax:before")){if(l=n.data("cross-domain"),s=l===t?null:l,u=n.data("with-credentials")||null,d=n.data("type")||e.ajaxSettings&&e.ajaxSettings.dataType,n.is("form")){r=n.attr("method"),i=n.attr("action"),o=n.serializeArray();var m=n.data("ujs:submit-button");m&&(o.push(m),n.data("ujs:submit-button",null))}else n.is(a.inputChangeSelector)?(r=n.data("method"),i=n.data("url"),o=n.serialize(),n.data("params")&&(o=o+"&"+n.data("params"))):n.is(a.buttonClickSelector)?(r=n.data("method")||"get",i=n.data("url"),o=n.serialize(),n.data("params")&&(o=o+"&"+n.data("params"))):(r=n.data("method"),i=a.href(n),o=n.data("params")||null);return c={type:r||"GET",data:o,dataType:d,beforeSend:function(e,r){return r.dataType===t&&e.setRequestHeader("accept","*/*;q=0.5, "+r.accepts.script),a.fire(n,"ajax:beforeSend",[e,r])?void n.trigger("ajax:send",e):!1},success:function(e,t,a){n.trigger("ajax:success",[e,t,a])},complete:function(e,t){n.trigger("ajax:complete",[e,t])},error:function(e,t,a){n.trigger("ajax:error",[e,t,a])},crossDomain:s},u&&(c.xhrFields={withCredentials:u}),i&&(c.url=i),a.ajax(c)}return!1},handleMethod:function(n){var r=a.href(n),i=n.data("method"),o=n.attr("target"),l=e("meta[name=csrf-token]").attr("content"),s=e("meta[name=csrf-param]").attr("content"),u=e('<form method="post" action="'+r+'"></form>'),d='<input name="_method" value="'+i+'" type="hidden" />';s!==t&&l!==t&&(d+='<input name="'+s+'" value="'+l+'" type="hidden" />'),o&&u.attr("target",o),u.hide().append(d).appendTo("body"),u.submit()},formElements:function(t,a){return t.is("form")?e(t[0].elements).filter(a):t.find(a)},disableFormElements:function(t){a.formElements(t,a.disableSelector).each(function(){a.disableFormElement(e(this))})},disableFormElement:function(e){var a,n;a=e.is("button")?"html":"val",n=e.data("disable-with"),e.data("ujs:enable-with",e[a]()),n!==t&&e[a](n),e.prop("disabled",!0)},enableFormElements:function(t){a.formElements(t,a.enableSelector).each(function(){a.enableFormElement(e(this))})},enableFormElement:function(e){var t=e.is("button")?"html":"val";e.data("ujs:enable-with")&&e[t](e.data("ujs:enable-with")),e.prop("disabled",!1)},allowAction:function(e){var t,n=e.data("confirm"),r=!1;return n?(a.fire(e,"confirm")&&(r=a.confirm(n),t=a.fire(e,"confirm:complete",[r])),r&&t):!0},blankInputs:function(t,a,n){var r,i,o=e(),l=a||"input,textarea",s=t.find(l);return s.each(function(){if(r=e(this),i=r.is("input[type=checkbox],input[type=radio]")?r.is(":checked"):r.val(),!i==!n){if(r.is("input[type=radio]")&&s.filter('input[type=radio]:checked[name="'+r.attr("name")+'"]').length)return!0;o=o.add(r)}}),o.length?o:!1},nonBlankInputs:function(e,t){return a.blankInputs(e,t,!0)},stopEverything:function(t){return e(t.target).trigger("ujs:everythingStopped"),t.stopImmediatePropagation(),!1},disableElement:function(e){var n=e.data("disable-with");e.data("ujs:enable-with",e.html()),n!==t&&e.html(n),e.bind("click.railsDisable",function(e){return a.stopEverything(e)})},enableElement:function(e){e.data("ujs:enable-with")!==t&&(e.html(e.data("ujs:enable-with")),e.removeData("ujs:enable-with")),e.unbind("click.railsDisable")}},a.fire(n,"rails:attachBindings")&&(e.ajaxPrefilter(function(e,t,n){e.crossDomain||a.CSRFProtection(n)}),n.delegate(a.linkDisableSelector,"ajax:complete",function(){a.enableElement(e(this))}),n.delegate(a.buttonDisableSelector,"ajax:complete",function(){a.enableFormElement(e(this))}),n.delegate(a.linkClickSelector,"click.rails",function(n){var r=e(this),i=r.data("method"),o=r.data("params"),l=n.metaKey||n.ctrlKey;if(!a.allowAction(r))return a.stopEverything(n);if(!l&&r.is(a.linkDisableSelector)&&a.disableElement(r),r.data("remote")!==t){if(l&&(!i||"GET"===i)&&!o)return!0;var s=a.handleRemote(r);return s===!1?a.enableElement(r):s.error(function(){a.enableElement(r)}),!1}return r.data("method")?(a.handleMethod(r),!1):void 0}),n.delegate(a.buttonClickSelector,"click.rails",function(t){var n=e(this);if(!a.allowAction(n))return a.stopEverything(t);n.is(a.buttonDisableSelector)&&a.disableFormElement(n);var r=a.handleRemote(n);return r===!1?a.enableFormElement(n):r.error(function(){a.enableFormElement(n)}),!1}),n.delegate(a.inputChangeSelector,"change.rails",function(t){var n=e(this);return a.allowAction(n)?(a.handleRemote(n),!1):a.stopEverything(t)}),n.delegate(a.formSubmitSelector,"submit.rails",function(n){var r,i,o=e(this),l=o.data("remote")!==t;if(!a.allowAction(o))return a.stopEverything(n);if(o.attr("novalidate")==t&&(r=a.blankInputs(o,a.requiredInputSelector),r&&a.fire(o,"ajax:aborted:required",[r])))return a.stopEverything(n);if(l){if(i=a.nonBlankInputs(o,a.fileInputSelector)){setTimeout(function(){a.disableFormElements(o)},13);var s=a.fire(o,"ajax:aborted:file",[i]);return s||setTimeout(function(){a.enableFormElements(o)},13),s}return a.handleRemote(o),!1}setTimeout(function(){a.disableFormElements(o)},13)}),n.delegate(a.formInputClickSelector,"click.rails",function(t){var n=e(this);if(!a.allowAction(n))return a.stopEverything(t);var r=n.attr("name"),i=r?{name:r,value:n.val()}:null;n.closest("form").data("ujs:submit-button",i)}),n.delegate(a.formSubmitSelector,"ajax:send.rails",function(t){this==t.target&&a.disableFormElements(e(this))}),n.delegate(a.formSubmitSelector,"ajax:complete.rails",function(t){this==t.target&&a.enableFormElements(e(this))}),e(function(){a.refreshCSRFTokens()}))}(jQuery);var Config=function(){var e=function(e){var a={};return a.resources=e,e=t(e),a.$submit=$("#create_"+e),a.$show=$("#show_new_"+e),a.$form=$("#new_"+e),a},t=function(e){return e.slice(0,-1)};return{configure:e}},toggle=function(){var e={},t=function(t){e=Config().configure(t),e.$show.on("click",a)},a=function(){return n(e.$form)&&(e.$form.insertBefore(e.$show),e.$form.addClass("visible").slideDown(600,r)),!1},n=function(e){return!e.hasClass("visible")},r=function(){setTimeout(function(){e.$show.remove(),e.$submit.show()},300)};return{init:t}},create=function(){var e={},t=function(t){e=Config().configure(t),e.$submit.on("click",a)},a=function(){return n()?i():r()},n=function(){var t=e.$form.children('input[type="text"]').first(),a=t.val();return""!==a},r=function(){var t='<p class="error">Whoa! Submit something.</p>';return e.$form.prepend(t),!1},i=function(){var t=o(),a=e.$form.serialize();return $.post(t,a),l(),!1},o=function(){var t=window.location.pathname,a=t+"/"+e.resources;return a},l=function(){e.$form.children('input[type="text"]').val("")};return{init:t}},$submit=$(".product_submit");$submit.on("click",function(e){var t=$(this).parents(".modal"),a=t.find(".results_wrapper"),n=t.find(".errors"),r=t.find(".product_query").val();a.removeClass("open").find(".product").remove(),n.empty().hide(),""===r?(e.preventDefault(),n.append("<li>Search query cannot be blank!</li>").slideDown()):$submit.addClass("loading")}),$(".product_reset").on("click",function(e){e.preventDefault(),$(".results_wrapper .product").remove(),$("#product").val(""),$(".search_instructions").hide(),$(".results_wrapper").removeClass("open")}),$(document).on("ajax:success",".delete_product",function(){var e=$(this).parents(".product"),t=$(this).parents(".products");1===t.children(".product").length&&t.append('<div class="empty"><p>This scenario has no products!</p></div>'),e.remove()}),$(".js_modal_toggle").on("click",function(){var e=$(this).data("name"),t=$('.modal[data_name="'+e+'"]');t.toggleClass("visible"),setTimeout(function(){t.find('input[type="text"]').first().focus()},100)}),$(document).keyup(function(e){var t=$(".modal");27==e.keyCode&&t.hasClass("visible")&&t.removeClass("visible")}),$(".modal_overlay").on("click",function(){$(".modal").removeClass("visible")});var resultScroll=function(e,t){$(e).siblings(".results_container").animate({scrollTop:t},600)};$(".modal_scroll.top").on("click",function(){resultScroll(this,0)}),$(".modal_scroll.bottom").on("click",function(){resultScroll(this,$(".results").height())});