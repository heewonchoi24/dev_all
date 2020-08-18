/*팝업 캘린더*/
var CalendarPopFn = function(params){
    params = params || {};
    var _this = this, popInner, currBx, nextBx, contOutBx, moveMotion, moving;
    this.popBx = '#pop_bx_calendar';

    this.setCont = function(o){
        o = o || {};
        if(o.url === undefined) throw new Error('URL 주소가 필요합니다.');
        var inp = o.targetInput;
        var selcDate = o.selectDate;
        var t = _this.popBx.find('.content:not(".on")').eq(0);
        $.ajax({
            url : o.url,
            type : params.type || 'GET',
            data : o.data || {},
            async : true,
            dataType : 'html',
            success : function(data){
            	$("#popProgressBackground").remove();
            	$("#popProgressCircle").remove();
                t.html(data).siblings('.on').removeClass('on').end().addClass('on');
                t.imagesLoaded(function(){
                    moveMotion = !moveMotion;
                    o.callFn && o.callFn();
                    $(inp).val(selcDate);
                });

                moving = false;
            },
            /*beforeSend : function(){
            	$('body').append('<div id="popProgressBackground"></div><div id="popProgressCircle"><img src="/mobile/common/images/ico/calLoading.png"><p>Waiting</p></div>');
            },*/
            error : function(a,b,c){
                alert('error : ' + c);
                moving = false;
            }
        })
    };

    this.showPop = function(){
        ajaxShowPopCont({
            url : '/mobile/shop/mypage/__ajax_calendar_default.html',
            data : params.data || {},
            resize : false,
            onStart : function(bx, showFn){
                $('html, body').animate({
                    scrollTop: 0
                }, 200);
                _this.popBx = $(_this.popBx);
                popInner = _this.popBx.find('> .inner');
                contOutBx = _this.popBx.find('#bx_multi_content');
                _this.setCont({callFn : showFn, url : params.url || '/mobile/shop/mypage/__ajax_calendar_default.html'});
            }
        });
    };

    this.addCont = function(o){
        if(moving) return;
        moving = true;
        o  = o || {};
        var pos;
        var targetInput = o.targetInput || "";
        if(o.showSide) _this.addSubSect({url:o.showSide, noShow : true});
        if(o.direc === 'prev') {
            pos = -1;
            var direc = -1;
        }else if (o.direc === 'up'){
            pos = 1;
            var direc = -1;
        }else if (o.direc === 'down'){
            pos = 1;
            var direc = 1;
        }else{
            pos = -1;
            var direc = 1;
        }

        currBx = _this.popBx.find('.content.on').eq(0);
        nextBx = _this.popBx.find('.content:not(".on")').eq(0);

        if(pos === 1){
            currBx.css({'left':'0'});
            nextBx.css({'left':'0'});
            TweenMax.set(nextBx,{'top' : 150*direc+'vh'});
            function move(){
                TweenMax.to(nextBx,0.5,{'top' : '0vh', ease: Power3.easeInOut});
                TweenMax.to(currBx,0.5,{'top' : -150*direc+'vh', ease: Power3.easeInOut});
                if(o.showSide) _this.popBx.addClass('show_right_sec');
            }
        }else{
            currBx.css({'top':'0'});
            nextBx.css({'top':'0'});
            TweenMax.set(nextBx,{'left' : 100*direc+'%'});
            function move(){
                TweenMax.to(nextBx,0.5,{'left' : '0%', ease: Power3.easeInOut});
                TweenMax.to(currBx,0.5,{'left' : -100*direc+'%', ease: Power3.easeInOut});
                if(o.showSide) _this.popBx.addClass('show_right_sec');
            }
        }

        _this.setCont({url : o.url, callFn : move, data : o.data, selectDate : o.selectDate, targetInput : targetInput});
    };

    this.showPop();
};


var calendarPop;
var order = $('#orderNum').val();
var groupCode = $('#groupCode').val();
var subNum = $('#goodsId').val();
var Now = new Date();
if(subNum === undefined) {
	subNum = "";
}else{
	subNum = $('#goodsId').val();
}

var devlDates = $('#devlDates').val();
var devlDay = $('#devlDay').val();
var goods = $('#goods').val();
var calendarFn = {
    changePattern : function(){
    	//alert(subNum);
        window.calendarPop = new CalendarPopFn({url:'/mobile/shop/mypage/__ajax_calendar_changepattern.jsp?orderNum='+order+'&goodsId='+subNum+'&groupCode='+groupCode+'&devlDates='+devlDates+'&devlDay='+devlDay+'&goods='+goods});
    },
    selectTerm : function(){
        window.calendarPop = new CalendarPopFn({url:'/mobile/shop/mypage/__ajax_calendar_changeschedule.jsp?orderNum='+order+'&goodsId='+subNum+'&groupCode='+groupCode+'&devlDates='+devlDates+'&devlDay='+devlDay+'&goods='+goods});
    },
    selectDelivery : function(){
        window.calendarPop = new CalendarPopFn({url:'/mobile/shop/mypage/__ajax_calendar_changearea.jsp?orderNum='+order+'&goodsId='+subNum+'&groupCode='+groupCode+'&devlDates='+devlDates+'&devlDay='+devlDay+'&goods='+goods});
    },
    searchPost : function(){
        calendarPop.addCont({url : 'ajax/AddressSearchJiPop.html', direc : 'down'});
        // calendarPop.addCont({url : 'ajax/__ajax_calendar_changeareaPost.html', direc : 'down'});
    }
};

