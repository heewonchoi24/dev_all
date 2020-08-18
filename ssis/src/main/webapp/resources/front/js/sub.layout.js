var $lnb = $("#lnb");
var $container = $("#container");
var $shareSub = $container.find(".path .lst_sns > ul > li");
var subLayoutSetTime;

var locationHash = location.href;
var arrlocationHash = locationHash.split("#");
var Hash = new String(arrlocationHash[1]);


$(window).on("resize.subLayout",function(){
  clearInterval(subLayoutSetTime);
  subLayoutSetTime = setTimeout(function(){
    subLayoutResize();
  },1000)

});
$(window).on("scroll.subLayout",function(){
  subLayoutScroll();
  clearInterval(subLayoutSetTime);
  subLayoutSetTime = setTimeout(function(){
    subLayoutResize();
  },1000)
});

$(function(){
  clearInterval(subLayoutSetTime);
  subLayoutSetTime = setTimeout(function(){
    subLayoutResize();
  },0);
  subInit();
});




function subInit(){
  // alert($("#header").outerHeight() );
  // alert($container.offset().top );
  if(Hash == "container"){
      // if(WinWdith < mobileSizeMin){
      //         $(window).scrollTop($container.offset().top - $("#header-mobile").outerHeight());
      // }
  }

  if(pageNum > 0){
      var menuOn = $lnb.find(">ul>li.m"+pageNum);
      menuOn.addClass("on");
      if(subNum > 0){
        var subMenuOn = $(".rtitle > .lst > ul > li.n"+subNum);
        subMenuOn.addClass("on");
      }

  }
}

var contentMotionBoxFlag = false;
function contentMotionBox(ty,bot){

  var WinWdith = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
  if(WinWdith > mobileSizeMin){
  var time1 = 1.0;
  var time1_delay = 1;
  var time2 = 0.6;
  var time2_delay = 1.2;
  var time3_delay = 1.6;
  if(ty == true){
      time2_delay = 1.6;
      time3_delay = 1.6;
  }
  var bot = bot;
  if(bot == undefined){
    bot = 0;
  }



  TweenLite.set($("#container.sub .path"),{"y":30,"visibility":"visible","opacity":0});
  TweenLite.set($("#container.sub .contentMotion"),{"y":30,"visibility":"visible","opacity":0});
  if($("#spot-sub .thumb .cont").length > 0){
      TweenLite.set($("#spot-sub .thumb .cont"),{"y":30,"visibility":"visible","opacity":0});
      TweenLite.to($("#spot-sub .thumb .cont"),time1,{"y":0,"opacity":1,delay:time1_delay});
  }

  if($("#container.sub .tab-ty1").length > 0){
      TweenLite.set($("#container.sub .tab-ty1"),{"y":30,"visibility":"visible","opacity":0});
      TweenMax.to($("#container.sub .tab-ty1"),time2,{"opacity":1,"y":0,delay:time2_delay});
  }

  if($("#container.sub .tab-ty2").length > 0){
      TweenLite.set($("#container.sub .tab-ty2"),{"y":30,"visibility":"visible","opacity":0});
      TweenMax.to($("#container.sub .tab-ty2"),time2,{"opacity":1,"y":0,delay:time2_delay});
  }

  TweenLite.to($("#spot-sub .thumb .img"),time1,{"bottom":bot,delay:time1_delay});
  TweenMax.to($("#container.sub .path"),time2,{"opacity":1,"y":0,delay:time2_delay});
  TweenMax.to($("#container.sub .contentMotion"),time2,{"opacity":1,"y":0,delay:time3_delay});
    setTimeout(function(){
      contentMotionBoxFlag = true;
    },time3_delay)


  }else{
      contentMotionBoxFlag = true;
      TweenLite.set($("#container.sub .path"),{"visibility":"visible"});
      TweenLite.set($("#container.sub .contentMotion"),{"visibility":"visible"});
      TweenLite.set($("#spot-sub .thumb .cont"),{"visibility":"visible"});
      TweenLite.set($("#container.sub .tab-ty1"),{"visibility":"visible"});
      TweenLite.set($("#container.sub .tab-ty2"),{"visibility":"visible"});

    }

};//contentMotionBox




var rtitleSizeSetTime;

function subLayoutResize(){
   var win = $(window),
    doc = $(document),
    body = (navigator.userAgent.indexOf('AppleWebKit') !== -1) ? $('body') : $('html');
    var top = win.scrollTop();
    var WinWdith = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
    var WinHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
    var $header = $("#header");
    var $spot = $("#spot");
    //if(pageNum > 0  && pageNum <= $lnb.find(">ul>li").length ){
      if(pageNum > 0  && pageNum != 99){
        if(top <= 140){
            if(pageNum <= 5){
              var menuOn = $lnb.find(">ul>li.m"+pageNum);
              var menuX = menuOn.offset().left + (menuOn.outerWidth() / 2);
              var menuY = menuOn.offset().top;
            }else{
              var menuOn = $lnb.find(">ul>li.m5");
              var menuX = menuOn.offset().left + (menuOn.outerWidth() / 2);
              var menuY = menuOn.offset().top;
            }

              var w_rtitle_child = $(".rtitle").find(".lst > ul > li:eq(0)").outerWidth();
              var w_rtitle =  0;
              for (var i = 1; i <= $(".rtitle").find(".lst > ul > li").length; i++) {
                   w_rtitle += $(".rtitle").find(".lst > ul > li:nth-child("+i+")").outerWidth() + 30;
                   //console.log(w_rtitle);
              }

              //var w_rtitle = w_rtitle_child * $(".rtitle").find(".lst > ul > li").length;
              var w_rtitle_total = w_rtitle + menuX;
              var boxTotal = $("#container > .container_inner").outerWidth() + $("#container > .container_inner").offset().left;



               //alert(w_rtitle_total - boxTotal);
               var aaaa = w_rtitle_total - boxTotal;
               var bbbb = ((w_rtitle_child)/2);
               var cccc = Math.round(aaaa / bbbb);

                // 짝홀수 구분
               if(cccc%2==0 ){
                    cccc = cccc + 1;
               }
               if(cccc<=0 ){
                    cccc = 1;
               }
                $(".rtitle").css({
                    // "display":"block",
                    "width" : w_rtitle,
                    "left" : menuX -  ( bbbb * cccc ),
                    "top" : 5,
                    "visibility":"visible"
                  })
            }
      }//if::pageNum
};//subLayoutResize

function subLayoutScroll(){
  var win = $(window),
    doc = $(document),
    body = (navigator.userAgent.indexOf('AppleWebKit') !== -1) ? $('body') : $('html');
    var top = win.scrollTop();
    var WinWdith = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;

    //pc버젼일때만 작동
    if(WinWdith > 860){
      if(top > 0  && top < 100){
        //TweenLite.to($(".rtitle"),0.2,{"y":-(top),"opacity":1});
      }else if(top >= 100){
        //TweenLite.to($(".rtitle"),0.4,{"opacity":0});

      }

    }// if


};



if(!Modernizr.touchevents && !isie6 && !isie7 && !isie8 ){

    var scrollMotionBox = ".dmp-parallax", scrollMotionchild = ".dmp-group";
    var offSetcheckFlag = [],offSetcheckFlag2 = [];
        for (var i = 0; i < $(scrollMotionBox).length; i++) { offSetcheckFlag[i] = false;}
        for (var i = 0; i < $(scrollMotionchild).length; i++) { offSetcheckFlag2[i] = false;}
          $(window).on("scroll.mainStelra",function(){
              var win = $(window),
                    doc = $(document),
                    viewport = win.height(),
                    body = (navigator.userAgent.indexOf('AppleWebKit') !== -1) ? $('body') : $('html');
              var top = win.scrollTop() + viewport;
              stelra(scrollMotionBox,top);
              offSetcheck(scrollMotionchild ,top);
            });
            stelra(scrollMotionBox , $(window).scrollTop() + $(window).height());
            offSetcheck(scrollMotionchild ,$(window).scrollTop() + $(window).height());
            function winComplete(){}
            spotTxtMotion(".dmp-hm");

  }//if




function iCutterLoad(obj){
  var o = $(obj);

  $(window).on("load",function(){
    var divs = $(obj);
    divs.each(function(){
      var $this = $(this);
      var divAspect = $this.outerHeight() / $this.outerWidth();
      var img = $this.find('img');
      var imgAspect = img.outerHeight() / img.outerWidth();

      if (imgAspect <= divAspect) {
          var imgWidthActual = $this.outerHeight() / imgAspect;
          var imgWidthToBe = $this.outerHeight() / divAspect;
          var marginLeft = -Math.round((imgWidthActual - imgWidthToBe) / 2)
          img.css({
            "width":"auto",
            "height":"100%",
            "margin-left":marginLeft,
            "visibility":"visible",
            "opacity":0
          });
        } else {
           img.css({
            "width":"100%",
            "height":"auto",
            "margin-left":0,
            "visibility":"visible",
            "opacity":0
          });
        }



    });//each
  });//load


}//iCutter



function iCutter(obj){
  var $o = $(obj);

    $o.each(function(){

      var $this = $(this);
      var img = $this.find('img');
      img.css({"width":"","height":"","margin-left":"","margin-top":"", "visibility":"", "opacity":""});
      var divAspect = $this.outerHeight() / $this.outerWidth();
      var imgAspect = img.outerHeight() / img.outerWidth();
      var imgWidthActual = $this.outerHeight() / imgAspect;
      var imgWidthToBe = $this.outerHeight() / divAspect;



      con(imgAspect <= divAspect);
      con("img ::" + img.outerHeight());
      con(" $this ::" + $this.outerHeight());

      if (imgAspect <= divAspect) {
          img.css({
            "width":"auto",
            "height":"100%",
            "visibility":"visible",
            "margin-top":0,
            "visibility":"visible",
            "opacity":0
          });


          img.css({ "margin-left":  -Math.round((imgWidthActual - imgWidthToBe) / 2)  });

        } else {
           img.css({
            "width":"100%",
            "height":"auto",
            "visibility":"visible",
            "margin-left":0,
            "visibility":"visible",
            "opacity":0

          });

            img.css({ "margin-top": -Math.round( (img.outerHeight() -  $this.outerHeight()) / 2 ) });
        }

        img.stop().animate({"opacity":1},0);
    });//each

}//iCutterLoadNone


function iCutInit(){
	iCutter('.i-cut');
}

function dotInit(){
	if ($('.t-dot').length> 0){
		$('.t-dot').dotdotdot();
	}
}


function tooltip(){
	//툴팁
	var tooltip = '[class^="tooltip"]';
	$('.tooltip').on('mouseenter mouseleave', function(e) {
		var $this = $(this),
			$href = $this.data('cont'),
			$top = $this.offset().top + 42,
			$left = $this.offset().left - 13;

		var config = {
			tooltipstyle : {
				position : 'absolute',
				top : $top,
				left : $left,
				zIndex: 9999
			}};

		var $obj = $("body > .toolview");
		(e.type == 'mouseenter') ? $this.siblings('.tooltip_cont').clone().addClass("toolview").appendTo("body").css(config.tooltipstyle) : $obj.fadeOut(200).remove();
		return false;
	});
}


$(function(){

  //공유하기 pc
  //$shareSub.fadeHover({flag:false});
  $shareSub.siblings(".btn_share").find("> a").on("keydown click",function(e){
      if(e.which == 13 || e.which == 1){
            var $this =$(this);
            var $popup = $("#popup-share-Bubble");

            var mapAni = new TimelineMax();
            mapAni.fromTo($popup,.5,{y:10,opacity:0,display:"block"},{y:0,opacity:1});
              //if(e.which == 13 ){
                setTimeout(function(){
                  $popup.find("button:eq(0)").focus();
                },300);
            //   }else{
            //    $shareSub.siblings(".btn_share").fadeHover({flag:true});
            // }
            //$popup.attr("tabindex",0);
            $popup.find(".close").off().on("keydown click",close);//close
            function close(){
                //$shareSub.resetHover();
                TweenMax.to($popup,.5,{y:10,opacity:0,onComplete:function(){
                  $popup.css("display","none");
                }});
                if(e.which == 13){
                    setTimeout(function(){
                    $("#container.sub .path .lst_sns .btn_share > a").focus();
                    },300);
                }

            };
            e.preventDefault();
      }
  })//click



	dotInit();
	tooltip();
})//ready

$(window).on("load",function(){
    //alert();

	iCutInit();
});


