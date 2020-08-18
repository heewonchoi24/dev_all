$(window).on('load',function(){
  if(navigator.userAgent.indexOf('WebKit')!=-1)
    console.log('%cCopyright © %s %cssis%c All rights reserved.', 'font-size:11px;color:#999;', new Date().getFullYear(),'font-size:22px;color:#000;-webkit-text-fill-color:#333;-webkit-text-stroke: 1px black;', 'font-size:11px;color:#999;');
});

var IS_MOBILE     = /mobile|android|bada|blackberry|blazer|ip(hone|od|ad)|windows (ce|phone)/i.test(navigator.userAgent||navigator.vendor||window.opera);
var WINDOW_HEIGHT   = window.innerHeight ? window.innerHeight : jQuery(window).height();
var SCROLL_TOP      = 0;
var SCROLL_TOP_PREV   = 0;
var SCROLL_DIRECTION  = "stop";

var TRANSFORM_TYPE    = "left";

var IS_IOS        = navigator.userAgent.toLowerCase().search(/ip(hone|ad|od)/i) > -1;
var IS_ANDROID      = navigator.userAgent.toLowerCase().indexOf("android")  > -1;
var IS_PHONEGAP     = false;
var IS_PHONEGAP_IOS   = false;
var IS_PHONEGAP_ANDROID = false;
var APP_VERSION_NUMBER  = 200;
var APP_MARKET_TYPE   = "appstore";

var LNB_FIRST_DEP,LNB_SECOND_DEP,LNB_THIRD_DEP;

//check browser
var isie=(/msie/i).test(navigator.userAgent); //ie
var isie6=(/msie 6/i).test(navigator.userAgent); //ie 6
var isie7=(/msie 7/i).test(navigator.userAgent); //ie 7
var isie8=(/msie 8/i).test(navigator.userAgent); //ie 8
var isie9=(/msie 9/i).test(navigator.userAgent); //ie 9
var isie10=(/msie 10/i).test(navigator.userAgent); //ie 9
var isfirefox=(/firefox/i).test(navigator.userAgent); //firefox
var isapple=(/applewebkit/i).test(navigator.userAgent); //safari,chrome
var isopera=(/opera/i).test(navigator.userAgent); //opera
var isios=(/(ipod|iphone|ipad)/i).test(navigator.userAgent);//ios
var isipad=(/(ipad)/i).test(navigator.userAgent);//ipad
var isandroid=(/android/i).test(navigator.userAgent);//android
var device;
var isieLw;
if(isie6 || isie7 || isie8){ isieLw=true;}

var pageNum , subNum, threeNum;

var mobileW = 750;


var opartsBOS = {
  site : {},
  init : function() {

    site = this;

    site.sideMenu();

    $(window).resize(function() {
      //site.resize();
    }).resize();

    $(window).scroll(function () {
      site.scroll();
    }).scroll();

    $('.select_field').each(function() {
      selectBox($(this));
    });

  },
  resize : function() {
    site.wW = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth,
    site.wH = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight,
    site.shH = $('#header').outerHeight(),
    site.isMobile = false;

    if(site.wW <= mobileW) {
      site.isMobile = true;
    }

    $('#sidebar, #main').css({height:site.wH - site.shH});
  },
  scroll : function() {

  },
  sideMenu : function() {
    $("#sidebar .menu ul li > a").click(function(e) {
      if($(this).next().is('.menu')){
        e.preventDefault();
        $(this).next().addClass('on');
      }
    });

    $("#sidebar .menu .back").click(function(e) {
      e.preventDefault();
      $(this).parent().removeClass('on');
    });

    $("#header .menu_btn").click(function(e) {
      e.preventDefault();
      if(!$('#sidebar > .menu').hasClass('on')){
        $('#sidebar > .menu').addClass('on');
        $('body').removeClass('sideHide');
      }else{
        $('#sidebar > .menu').removeClass('on');
        $('body').addClass('sideHide');
      }
    });
  },
  pageRead : function(t,e) {
    e.preventDefault();
    if($("#pageRead").length === 0){
      $("#wrap").append($("<div></div>").prop({id : 'pageRead'}));
    }
    $("#pageRead").html('<iframe src="'+t+'" width="100%" height="'+$("#pageRead").height()+'px"></iframe>');
    /*$.ajax({
      url : t,
      type : "get",
      dataType : "html",
      success : function(data){
        $("#pageRead").html(data);
      },
      error : function(a,b,c){
          alert(b);
      }
    });*/
  },
  closeRead : function() {
    $('#pageRead', parent.document).remove();
  }
}

/* Images Load Checking */
$.fn.imagesLoaded = function (fn) {
    var $imgs = this.find('img[src!=""]'), imgArr = {cpl : [], err : []};
    if (!$imgs.length){
        if(fn) fn();
        return;
    }
    var dfds = [], cnt = 0;
    $imgs.each(function(){
        var _this = this;
        var dfd = $.Deferred();
        dfds.push(dfd);
        var img = new Image();
        img.onload = function(){
            imgArr.cpl.push(_this);
            check();
        }
        img.onerror = function(){
            imgArr.err.push(_this);
            check();
        }
        img.src = this.src;
    });
    function check(){
        cnt++;
        if(cnt === $imgs.length){
            if(fn) fn.call(imgArr);
        }
    }
}

/* Modals */
var modalFn = {
    show : function(t, params){
        var defaults = {
            onStart : function(){},
            onLoad : function(){},
            onClose : "",
            btnCloseCl : 'modal_close',
            bgClose : true,
            bxId: "#modal_bx",
            bgId : '#modal_overlay',
            parent : false
        };
        params = params || {};
        for (var prop in defaults) {
            if (prop in params && typeof params[prop] === 'object') {
                for (var subProp in defaults[prop]) {if (! (subProp in params[prop])) params[prop][subProp] = defaults[prop][subProp];}
            } else if (! (prop in params)) {params[prop] = defaults[prop];}
        };
        var _this = this;
        if(typeof t != 'object' && $(params.bxId).length === 0){
            var bx_id = params.bxId.substring(params.bxId.indexOf('#')+1, params.bxId.indexOf('.') === -1 ? params.bxId.length : params.bxId.indexOf('.'));
            var bx_class = params.bxId.replace("#"+bx_id,"").replace("."," ");
            $("body").append($("<section></section>").prop({id : bx_id}).addClass(bx_class));
        }
        if($(params.bgId).length === 0){
            var bg_id = params.bgId.substring(params.bgId.indexOf('#')+1, params.bgId.indexOf('.') === -1 ? params.bgId.length : params.bgId.indexOf('.'));
            var bg_class = params.bgId.replace("#"+bg_id,"").replace("."," ");
            $("body").append($("<div></div>").prop({id : bg_id}).addClass(bg_class));
        }

        var bg = $(params.bgId);
        $('body').css('overflow','hidden');
        bg.css('display','block');
        typeof t != 'object' ? ajax() : show();
        function ajax(){
      $.ajax({
                url : t,
                type : "get",
                dataType : "html",
                data : params.data,
                success : function(data){
                    if($(params.bxId).length === 0){
                        var bx_id = params.bxId.substring(params.bxId.indexOf('#')+1, params.bxId.indexOf('.') === -1 ? params.bxId.length : params.bxId.indexOf('.'));
                        var bx_class = params.bxId.replace("#"+bx_id,"").replace("."," ");
                        $("body").append($("<section></section>").prop({id : bx_id}).addClass(bx_class));
                    }
                    var bx = $(params.bxId);
                    bx.html(data);
                    t = bx.find(">*").eq(0);
                    show();
                },
                error : function(a,b,c){
                    alert(b);
                }
            });
        }
        function show(){
            if(params.onLoad)params.onLoad();
            var posi = t.css('position');
            t.css('display','block');
            t.imagesLoaded(function(){
              if($(".modal.on").length > 0) params.parent = $('#'+$(".modal.on").attr("id"));
                bg.addClass('on');
                if(params.bgClose){
                    bg.off('click').on('click',function(){close()});
                }
                $(window).on('resize', {tg : t}, modalFn.resize).resize();
                if(params.parent){
                    params.parent.removeClass('on');
                }
                t.addClass('on');
                t.find('.'+params.btnCloseCl).on('click',function(){close()});
            });
        }
        function close() {
          modalFn.hide(t,params.parent,params.bgId, params.onClose, params.mobileUI);
        }
    },
    hide : function(t, parent, bgId, onClose, mobileUI){
        var bg = bgId ? $(bgId): $("#modal_overlay");
        var bx = $("#modal_bx");
        onClose ? onClose() : "";
        if(!parent){
            bg.off('click');
            bg.removeClass('on');
            $('body').css('overflow','');
        }else{
            bg.off('click').on('click',function(){modalFn.hide(parent);});
            parent.addClass('on');
        }
        t.removeClass('on notrans');
        setTimeout(function(){
            if(!parent){
                bg.remove();
                bx.remove();
            }
            t.css('display','none');
            t.css({'max-height':'', "top":''});
        },500);
        $(window).off('resize', modalFn.resize);
        this.close = null;
    },
    resize : function(e){
        var t = e.data.tg ? e.data.tg : e;
        var posi = t.css('position');
        var vH = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
        var bxHeadH = t.find(".modal_header").length != 0 ? t.find(".modal_header").outerHeight() : 0;
        var bxFootH = t.find(".modal_footer").length != 0 ? t.find(".modal_footer").outerHeight() : 0;
        var bxCont = t.find(".modal_content");
        var scl = posi =='fixed' ? 0 : $(window).scrollTop();
        bxCont.css({"height": ""});
        var bxH = t.outerHeight();
        if(bxCont.outerHeight() > bxH-bxHeadH-bxFootH) bxCont.css({"height": (bxH-bxHeadH-bxFootH)+1});
        bxH = t.outerHeight();
        t.css({"top":( bxH > vH ? scl : (vH-bxH)/2+scl )+"px"});
    }
};

// COMMA
function comma(num){
  num = num + "";
  num = num.replace(/[^\d]+/g, '');
  return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

$(function(){
  $('.priceComma').change(function(e) {
    var val = $(this).val();
    $(this).val(comma(val));
  }).change();
});

function readFileURL(input){
    var isIE = (navigator.appName=="Microsoft Internet Explorer");
    var isie8= (/msie 8/i).test(navigator.userAgent);
    var isie9 = (/msie 9/i).test(navigator.userAgent);
    var path = input.value;
    var ext = path.substring(path.lastIndexOf('.') + 1).toLowerCase();
    var inputField = $(input).closest('.fileinputs').find('.input > input');
    var ImgField = $(input).closest('.uploadImgFile').find('.thumb');

    if(path == ""){
      $(input).val('');
      inputField.val('');
      ImgField.html('');
      return;
    }

    if($(input).closest('.fileinputs').is('.excel')){
      inputField.val(input.files[0].name);
      return;
    }

    if($.inArray(ext, ['gif','png','jpg','jpeg']) == -1) {
      alert('gif, png, jpg, jpeg 파일만 가능합니다.');
      $(input).val('');
      inputField.val('');
      ImgField.html('');
      return;
    }

    var img = "",
        btnDel = '<button class="i-set close1" onclick="readFileDel(this);">삭제</button>'
    if($(input).closest('.uploadImgFlie').hasClass('noneDel')) btnDel = '';

    inputField.val(input.files[0].name);

    if(isie8 || isie9) {
      alert("ie9이하 버전은 미리보기 기능을 지원하지 않습니다.");
      img = btnDel;
      ImgField.html(img);
      //$(input).closest('.fakefile').find('.file').css('display', 'block');
    }else{
         if(input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                img = '<div class="img"><img src="'+e.target.result+'"/></div>'+btnDel;
                ImgField.html(img);
            }
            reader.readAsDataURL(input.files[0]);
         }
    }
}

var randomNum = {
    random : function(n1, n2) {
        return parseInt(Math.random() * (n2 -n1 +1)) + n1;
    },
    autoNo : function(n) {
        var value = "";
        for(var i=0; i<n; i++){
            value += randomNum.random(0,9);
        }
        return value;
    }
};

var imgUpload = {
  insertImg:  function(obj,dataItem) {
    var isIE = (navigator.appName=="Microsoft Internet Explorer");
    var isie8= (/msie 8/i).test(navigator.userAgent);
    var isie9 = (/msie 9/i).test(navigator.userAgent);
    var path = obj.value;
    var ext = path.substring(path.lastIndexOf('.') + 1).toLowerCase();

    if(path == ""){
      return;
    }

    if($.inArray(ext, ['gif','png','jpg','jpeg']) == -1) {
      alert('gif, png, jpg, jpeg 파일만 가능합니다.');
      return;
    }

    $(obj).closest('.uploadImgFile').find('.ajax_image_file').remove();
    $(obj).closest('.uploadImgFile').find('input.title').val(obj.files[0].name);

    if(isie8 || isie9) {
      alert("ie9이하 버전은 미리보기 기능을 지원하지 않습니다.");
      var img = '<div class="img ajax_image_file"></div>';
      $(obj).closest('.uploadImgFile').find('.thumb').prepend(img);
    }else{
         if(obj.files && obj.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                var img = '<div class="img ajax_image_file"><img src="'+e.target.result+'" /></div>';
                $(obj).closest('.uploadImgFile').find('.thumb').prepend(img);
            }
            reader.readAsDataURL(obj.files[0]);
         }
    }
  },
  deleteImg: function(obj) {
    $(obj).closest('.uploadImgFile').find('.ajax_image_file').remove('');
    $(obj).closest('.uploadImgFile').find('.hidden_img').val('');
    $(obj).closest('.uploadImgFile').find('input[type="file"]').val('');
    $(obj).closest('.uploadImgFile').find('.up_hidden_img').val('');
    $(obj).closest('.uploadImgFile').find('input.title').val('');
  }
}


$(document).ready(function() {
  $('.uploadImgFile .thumb').off().hover(
      function() {
          var h = $(this).outerHeight() - $(this).find('img').height();
          if(h < 0){
              $(this).find('img').stop().animate({
                  top: h
              }, 1000);
          }
      }, function() {
          $(this).find('img').stop().animate({
              top: 0
          }, 1000);
      }
  );
});


function selectBox(t) {
  _this = t;

  if(_this.find('.select_text').length > 0) return false;

  _this.append('<input type="text" class="select_text ipt" readonly />');
  _this.append('<ul class="select_list" tabindex="-1"></ul>');

  var selectText = _this.find('.select_text');
  var selectList = _this.find('.select_list');

  _this.find('option').each(function() {
    var selected = $(this).attr('selected') ? 'selected' : '';
    if($(this).val() == ''){
      selectText.attr('placeholder',$(this).text());
    }else{
      if($(this).attr('selected')) selectText.val($(this).text());
      if($(this).data('img') != undefined){
        selectList.append('<li class="'+selected+'" style="background-image:url('+$(this).data('img')+')"><span>'+$(this).text()+'</span></li>');
      }else{
        selectList.append('<li class="'+selected+'"><span>'+$(this).text()+'</span></li>');
      }
    }
      
  });

  if(selectList.find('.selected').length < 1 && selectText.attr('placeholder') == undefined){
    selectList.children().eq(0).addClass('selected')
    selectText.val(selectList.children().eq(0).text());
  }

  selectText.on('click', function(e) {
      selectList.addClass('active');
      selectList.focus();
      /*if(selectList.find('.selected').length > 0){
        setTimeout(function() {
          console.log(selectList.find('.selected').position());
          selectList.scrollTop(selectList.find('.selected').position().top);
        },300);
      }else{
        selectList.scrollTop(0);
      }*/
      
  });

  selectList.focusout(function(e) {
    selectList.removeClass('active');
  });

  selectList.find('span').on('click', function(e) {
    var text = $(this).text();
    selectText.val(text);
    $(this).closest('li').siblings().removeClass('selected').end().addClass('selected');
    selectList.removeClass('active');

    $(this).closest('.select_field').find('option').each(function() {
      if($(this).text() == text) $(this).prop('selected', 'selected'); 
    });

    $(this).closest('.select_field').find('select').change();
  });
}


var tabs = {
  init: function() {
    $(".tabs .tab a").click(function(e) {
      e.preventDefault();
      if(!$(this).hasClass('active')){
        $(this).closest('.tab').siblings('.active').removeClass('active').end().addClass('active');
        tabs.active();
      }
    });
    tabs.active();
  },
  active: function() {
    $(".tabs .tab").each(function(index, el) {
      var t = $(this).find('a').attr('href');
      if($(this).hasClass('active')){
        $(t).addClass('active').css({display:''})
      }else{
        $(t).removeClass('active').css({display:'none'});
      }
    });
  }
}