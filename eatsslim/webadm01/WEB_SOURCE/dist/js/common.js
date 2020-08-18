/* 이미지 로딩 */
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
$.fn.ensureLoad = function(handler) {//개별 이미지 로드 완료 체크
    return this.each(function() {
        if(this.complete) {
            handler.call(this);
        }else{
            $(this).load(handler);
            this.onerror = function(){
                handler.call(this);
            }
        }
    });
}
$.fn.checkImgsLoad = function(fn){ //다중 이미지 로드 완료 체크
    var img = this.find('img[src!=""]');
    var cntLoad = 0;
    if(img.length === 0){
        fn();
    }else{
        return img.ensureLoad(function(){
            cntLoad++;
            if(cntLoad === img.length){
                fn();
            }
        });
    }
}

/* 왼쪽 네비게이션 메뉴 */
function leftNavFn(leftmenu){
    var $body = $("body");
    var $bg = $("#bg_left_menu");
    var $this = $("#left_nav");
    var $closeBtn = $this.find(".btn_close");
    var $navCon = $this.find(".nav_menu");

    if($body.hasClass("navFn")){
        $bg.removeClass("on");
        $this.removeClass("on");
        $body.removeClass("navFn");
    }else{
        $bg.addClass("on");
        $this.addClass("on");
        $body.addClass("navFn");
    }
}

/* 푸터 메뉴 */
$.fn.footerMenu = function(opt) {
    var _this = this, fm = this.find("ul"), fmW, fmlW, fmH, _thisH = this.height(),
        btnMore = this.find(".btn_more");

    $(window).resize(function() {
        fmW = fm.width();
        fmlW = 0;
        fm.find("li").each(function() {
            fmlW += $(this).outerWidth();
        });
        if(fmW < fmlW) {
            _this.addClass("active");
        }else{
            _this.removeClass("active");
        }
    }).resize();

    btnMore.click(function(e) {
        if(!_this.hasClass("on")){
            TweenMax.to( _this,0.5,{height: fm.outerHeight(), ease: Power1.easeInOut, onComplete:function(){
                _this.addClass("on");
                _this.css("height", "");
            }});
        }else{
            TweenMax.to( _this,0.5,{height: _thisH, ease: Power1.easeInOut, onComplete:function(){
                _this.removeClass("on");
                _this.css("height", "");
            }});
        }
    });
};

/* common 팝업 */
var popFn = {
    show : function(t, params){
        var defaults = {
            onStart : "",
            onLoad : function(){},
            onClose : "",
            btnCloseCl : 'pop_close',
            bgId : '#pop_bg_common.t1',
            align : true,
            htmlCl : "",
            resize : true
        };
        params = params || {};
        for (var prop in defaults) {
            if (prop in params && typeof params[prop] === 'object') {
                for (var subProp in defaults[prop]) {if (! (subProp in params[prop])) params[prop][subProp] = defaults[prop][subProp];}
            } else if (! (prop in params)) {params[prop] = defaults[prop];}
        };
        var _this = this;
        if($("body > "+params.bgId).length === 0){
            var bg_id = params.bgId.substring(params.bgId.indexOf('#')+1, params.bgId.indexOf('.') === -1 ? params.bgId.length : params.bgId.indexOf('.'));
            var bg_class = params.bgId.replace("#"+bg_id,"").replace("."," ");
            $("body").append($("<div></div>").prop({id : bg_id}).addClass(bg_class));
        }
        var bg = $("body > "+params.bgId);
        params.htmlCl && $('html').addClass(params.htmlCl);
        t.css('display','block');
        bg.css('display','block');
        !params.onStart ? show() : params.onStart(t, show);
        function show(){
            var posi = t.css('position');
            t.checkImgsLoad(function(){
                bg.addClass('on');
                bg.off('click').on('click',function(){popFn.hide(t,'',params.bgId, params.onClose);});

                if(params.align){
                    var vH = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
                    var bxH = t.outerHeight();
                    var scl = posi =='fixed' ? 0 : $(window).scrollTop();
                    // t.css({"top":$("#header").outerHeight()});
                }
                t.addClass('on');
                t.find('.'+params.btnCloseCl).on('click',function(){popFn.hide(t,'',params.bgId, params.onClose);});
                $(document).keyup(function(e){if(e.keyCode == 27){popFn.hide(t,'',params.bgId, params.onClose);}});
                if(params.onLoad)params.onLoad();
            });
            if(params.align && params.resize){$(window).on('resize', {tg : t, posi : posi}, popFn.resize);}
            _this.close = function(){popFn.hide(t,'',params.bgId, params.onClose);}
        }
    },
    hide : function(t, change, bgId, onClose){
        var bg = bgId ? $(bgId): $("#pop_bg_common");
        onClose ? onClose() : "";
        bg.off('click');
        if(!change)bg.removeClass('on');
        t.removeClass('on notrans');
        $('html').removeClass('of_hide2');
        setTimeout(function(){
        //  if(!change)bg.remove();
            t.css('display','none');
            t.css({'max-height':'', "top":''});
        },500);
        $(window).off('resize', popFn.resize);
        this.close = null;
    },
    resize : function(e){
        var t = e.data.tg;
        var vH = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
        var bxH = t.outerHeight();
        var scl = e.data.posi =='fixed' ? 0 : $(window).scrollTop();
        //t.css({"top":( bxH > vH ? scl : (vH-bxH)/2+scl )+"px"});
    }
};

// function calcitemToggle(o) {
//     var _this = $(o);
//     var p = _this.closest("dt");
//     var gp = p.closest("dl");

//     p.toggleClass("show");
//     gp.siblings().find("dt").removeClass("show");
// }


/*ajax 팝업 띄우기*/
function ajaxShowPopCont(o){
    var t = o.target ? $(o.target) : $("#pop_bx_common");
    o.data = o.data || {};
    o.bg = o.bg || "#pop_bg_common.t1";
    $.ajax({
        url : o.url,
        type : o.type || "get",
        dataType : "html",
        data : o.data,
        success : function(data){
            if(!o.append)t.html('');
            t.append(data);
            var popup = o.pop ? $(o.pop) : t.find(">*").eq(0);
            popFn.show(popup, {motion : o.motion || true, bgId : o.bg, onStart : o.onStart, onLoad : o.onLoad, onClose : o.onClose, resize : o.resize === undefined ?  true : o.resize});
        },
        error : function(a,b,c){
            alert(c);
        }
    })
}


/* 장바구니 관련 메뉴 */
var cartFn = {
    onInit : function(){  
        var cFrame = $("#cart"), cSection = cFrame.find(".cart_detail");
        var cSectionH = cSection.outerHeight(); 
        var itemLength = cFrame.find(".bx_item").length;
        $("#cartCount").val(itemLength);
        cFrame.css("transform","translateY(24rem)");
        cFrame.removeClass("on");
    },
    onFold : function(){    //단순하게 장바구니 열리고 닫히고
        var cFrame = $("#cart"); 
        var itemLength = $("#cartCount").val();

        $("#cartCount").val(itemLength);
        if(cFrame.hasClass("on")){
            cFrame.css("transform","translateY(24rem)");
            cFrame.removeClass("on");
        }else{
            cFrame.addClass("on");
            cFrame.css("transform","translateY(0rem)");
        }

    },
    onAdd : function(obj){      //상품 추가했을경우  //추후 수정 예정.
        var t = $('.'+obj);
        var itemLength = cFrame.find(".bx_item").length;
        var img = t.find("img");
        var appendBx = "";

        img.clone().addClass("img_clone").css({'position':'absolute', 'z-index':110, top : img.offset().top, left : img.offset().left, 'opacity' : 0.7}).prependTo($('body'));

        var clone = $(".img_clone");
        var cartIcon = $("#cart .goods_count dt img");
        var duration = 1;

        TweenMax.to( clone, duration / 2, {css:{scale:.04, opacity:.8}, ease:Power1.easeInOut});            
        TweenMax.to( clone, duration / 2, {css:{top:cartIcon.offset().top-273, left:cartIcon.offset().left-258}, ease:Quad.easeInOut});
        TweenMax.to( clone, .1, {
            css:{opacity:0},
            ease:Power1.easeInOut,
            delay : .8,
            onComplete : function(){
                TweenMax.to(cartIcon, duration / 4, {y:10, ease:Power3.easeOut});
                TweenMax.to(cartIcon, duration / 2, {y:0, ease:Bounce.easeOut, delay:duration / 8});
                clone.remove();          
                
                itemLength++;
                $("#cartCount").val(itemLength);
                cFrame.find("#cart_qty").empty().text(str);
                

                appendBx += '<div class="bx_item">';
                appendBx += '    <div class="goods_image">';
                appendBx += '        <img src="'+$(".goods_thumbnail img").attr("src")+'" width="179" height="139" alt="">';
                appendBx += '    </div>';
                appendBx += '    <div class="goods_desc">';
                appendBx += '        <div class="goods_title">'+$(".goods_title h2").text()+'</div>';
                appendBx += '        <div class="goods_caption">월~금 / 1주일분</div>';
                appendBx += '        <div class="goods_foot">';
                appendBx += '            <div class="goods_price">'+$(".goods_info section dd strong").text()+'</div>';
                appendBx += '            <button type="button" class="goods_options">옵션변경</button>';
                appendBx += '        </div>';
                appendBx += '    </div>';
                appendBx += '    <button type="button" class="goods_del" onclick="cartFn.onDelete(this);"></button>';
                appendBx += '</div>';

                if(!$("#cart").hasClass("on")){
                    setTimeout(function(){
                        $(".showCart").trigger("click");
                    },200);
                }
                
                setTimeout(function(){
                    $("#cart section .fc_inner").append(appendBx).css("width",$("#cartCount").val() * 195);
                    $("#cart section .fc_inner .bx_item:last-child").addClass("action");

                    var target = $("#cart section .fc_inner .bx_item.action:last-child");
                    var tl = new TimelineMax({
                        paused: false
                    });
                    tl.to(target, .3, {css:{scale: 1.2, opacity: .4},  ease: Back.easeIn} );
                    tl.to(target, .05, {css:{scale: 1, opacity: 1},  ease: Power1.easeOut} );
                },800);
                
                setTimeout(function(){
                    $(".showCart").trigger("click");
                },1800);
            }
        });
        cartFn.onFold();
    },
    onDelete : function(t){     //상품 삭제했을경우
        var cFrame = $("#cart");
        var _this = $(t);
        var target = _this.closest(".bx_item");
        var itemLength = cFrame.find(".bx_item").length;
        var tl = new TimelineMax({
            paused: false
        });
        tl.to(target, .3, {css:{scale: .4, opacity: .6},  ease: Back.easeIn} );
        tl.to(target, .05, {css:{scale: .8, opacity: 0},  ease: Power1.easeOut} );
        tl.addCallback(function(){target.remove();});

        itemLength--;
        $("#cartCount").val(itemLength);
        cFrame.find("#cart_qty").empty().text(itemLength);

        if(itemLength <= 0) {
            cartFn.onFold();
        }
    }
}


/* 페이지 전체 슬라이드 되는 모션 */
var moveFlag, idxBx, loadBx, direction;
var pSlideFn = {
    onSetCont : function(o){
        o = o || {};
        var contain = $("#container");
        var loadBx = contain.find("#load_content");
        if(o.url === undefined) return;
        $.ajax({
            url : o.url,
            type : o.type || 'GET',
            data : o.data || {},
            async : false,
            dataType : 'html',
            success : function(data){
                loadBx.html(data);
                loadBx.imagesLoaded();
            },
            error : function(a,b,c){
                alert('error : ' + c);
            }
        })
    },
    onAddCont : function(o){
        var contain = $("#container");
        console.log("o = "+o);
        (o.direction === 'next') ? contain.addClass("subpage") : contain.removeClass("subpage");
        pSlideFn.onSetCont({url : o.url, data : o.data});
    }
}



// jQuery Contents
$(function(){
    $(".footer_top").footerMenu();

    $(".selector").on("click",function(){
        if($(this).hasClass("on")){
            $(this).removeClass("on");
        }else {
            $(".selector").removeClass("on");
            $(this).addClass("on");
        }
    });
});
