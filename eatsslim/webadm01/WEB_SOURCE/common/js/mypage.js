$(function () {
    $(".selectbox").each(function() {
        var text = $(this).find("option:selected").text();
        $(this).find("label").text(text);
    });
});


function selectbox(t) {
    var selectTarget = $(t);
    /*selectTarget.change(function(){
        var select_name = $(this).children('option:selected').html();
        $(this).siblings('label').html(select_name);
        $(this).is( ":disabled" ) ? $(this).parent().addClass('disabled') : $(this).parent().removeClass('disabled');
    }).change();*/
    var select_name = selectTarget.find(":selected").text();
    selectTarget.siblings('label').html(select_name);
    selectTarget.is( ":disabled" ) ? selectTarget.parent().addClass('disabled') : selectTarget.parent().removeClass('disabled');
}


/* images로드체크 */
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
        if(!t.selector && $(params.bxId).length === 0){
            var bx_id = params.bxId.substring(params.bxId.indexOf('#')+1, params.bxId.indexOf('.') === -1 ? params.bxId.length : params.bxId.indexOf('.'));
            var bx_class = params.bxId.replace("#"+bx_id,"").replace("."," ");
            $("body").append($("<div></div>").prop({id : bx_id}).addClass(bx_class));
        }
        if($(params.bgId).length === 0){
            var bg_id = params.bgId.substring(params.bgId.indexOf('#')+1, params.bgId.indexOf('.') === -1 ? params.bgId.length : params.bgId.indexOf('.'));
            var bg_class = params.bgId.replace("#"+bg_id,"").replace("."," ");
            $("body").append($("<div></div>").prop({id : bg_id}).addClass(bg_class));
        }

        var bg = $(params.bgId);
        $('body').css('overflow','hidden');
        bg.css('display','block');
        !t.selector ? ajax() : show();
        function ajax(){
            $.ajax({
                url : t,
                type : "get",
                dataType : "html",
                data : params.data,
                success : function(data){
                    var html = $("<div></div>").html(data).children();
                    var bx = $(params.bxId);
                    if(bx.find("#"+html.attr('id')).length <= 0) bx.append(html);
                    t = bx.find(">*").last();
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
                $("#popProgressBackground").remove();
                $("#popProgressCircle").remove();
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
            t.remove();
        },500);
        $(window).off('resize', modalFn.resize);
        this.close = null;
    },
    resize : function(e){
        var t = e.data.tg ? e.data.tg : e;
        var posi = t.css('position');
        var vH = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
        var bxH = t.outerHeight();
        var bxHeadH = t.find(".modal_header").length != 0 ? t.find(".modal_header").outerHeight() : 0;
        var bxFootH = t.find(".modal_footer").length != 0 ? t.find(".modal_footer").outerHeight() : 0;
        var bxCont = t.find(".modal_content");
        var scl = posi =='fixed' ? 0 : $(window).scrollTop();
        bxCont.css({"height": ""});
        if(bxCont.outerHeight() > bxH-bxHeadH-bxFootH) bxCont.css({"height": bxH-bxHeadH-bxFootH});
        bxH = t.outerHeight();
        t.css({"top":( bxH > vH ? scl : (vH-bxH)/2+scl )+"px"});
    }
};

function moveText(t) {
    for(var i = 0; i < t.length; i++){
        var moveText = t.eq(i);
        var outerWidth = moveText.width();
        var innerWidth = moveText.find('>*').width();
        console.log(outerWidth, innerWidth);
        if(outerWidth < innerWidth){
            var textAni = new TimelineMax({repeat:-1, repeatDelay: 3, delay:3}),
                textTar = moveText.find('>*'),
                moveTime = 0.01*(innerWidth-outerWidth);
            textAni.pause()
                .to(textTar,moveTime,{x: outerWidth-innerWidth})
                .to(textTar,moveTime,{x: 0}, "+=3")
                .play();
        }
    }
}