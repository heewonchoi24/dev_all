var acodian = {
    click: function(target) {
      var $target = $(target);
      $target.on('click', function() {

        if ($(this).hasClass('on')) {
          slideUp($target);
        } else {
          slideUp($target);
          $(this).addClass('on').next().stop().slideDown();
        }

        function slideUp($target) {
          $target.removeClass('on').next().stop().slideUp();
        }

      });
    }
  };



  $.fn.quickMenuFixed = function(o){
     var el = this;
      o = $.extend({
        wrap : "#container",
        standard : ".main-page.banner",
        lftSizeObj : ".main-page.banner .inr-c",
        headerFixed : true,
        marginLft : 15,
        marginTop : 0
      }, o || {});

      return this.each(function(){
        var $this = $(this);
        var $wrap = $(o.wrap);
        var $standard = $(o.standard);
        var $leftSizeObj = $(o.lftSizeObj);
        var headerFixed = o.headerFixed;
        var wT = 0 , oT = 0, wL = 0, ml = o.marginLft;

         $(window).on("scroll.quickMenu",function(){

           if($("#wrap-total").css("position") != "fixed"){

              if(headerFixed){
                headH = $("#header").outerHeight();
              }else{
                headerFixed = 0;
              }

              oT = $standard.offset().top;
              wW = $leftSizeObj.outerWidth();
              wT = $(window).scrollTop();
              mt = o.marginTop;

              if(wT > (oT - headH)){
                $this.css({
                  position : "fixed",
                  left:"50%",
                  "margin-left" : (wW/2) + ml,
                  top: headH + 45
                });
              }else{
                $this.css({
                  position : "",
                  left:"50%",
                  "margin-left" : (wW/2) + ml,
                  top: oT + mt
                });

              }

            }//if

         }).scroll();

      })//each
  }//quickMenuFixed


 $.fn.tableFixed = function(o){
     var el = this;
      o = $.extend({
        flag : true
      }, o || {});

      return this.each(function(){
        var $this = $(this);
        var flag = o.flag;

        var $tableOffset = $this.offset().top - $("#header").outerHeight(),
            $header =  $this.find(" .tbl thead").clone(),
            $tbody =  $this.find(" .tbl tbody").clone(),
            $colgroup =  $this.find(" .tbl colgroup").clone(),
            $fixedHeader = $this.find(".header-fixed");
            $fixedHeader.append($colgroup).append($header).append($tbody);
            $fixedHeader.find("tbody").css({
              "visibility":"hidden",
              "display":"none"
            })


            $(window).bind("resize", function() {
              $fixedHeader.width($this.find(" > .tbl").width());

                $fixedHeader.find("th").each(function(index){
                  var $that = $(this);
                  $that.css({
                    width : $this.find(" .tbl tbody tr *:nth-child("+(index + 1)+")").width()
                  })
                });
            });

            $(window).bind("scroll", function() {
                var offset = $(this).scrollTop();

                $fixedHeader.find("th").each(function(index){
                  var $that = $(this);
                  $that.css({
                    width : $this.find(" .tbl tbody tr *:nth-child("+(index + 1)+")").width()
                  })
                });

                if (offset >= $tableOffset && $fixedHeader.is(":hidden")) {
                    $fixedHeader.show().width($this.find(" > .tbl").width());
                }
                else if (offset < $tableOffset) {
                    $fixedHeader.hide();
                }
            });

      })//each
  }


$.fn.tableFixed2 = function(o){
     var el = this;
      o = $.extend({
        flag : true
      }, o || {});

      return this.each(function(){
        var $this = $(this);
        var flag = o.flag;
        var th_w = 0;
        var thFCol = 0;
        var thFColWidth = 0;
        var thFRow = 0;
        var thFRowHeight = 0;
        var thFRowCur = 0;

        var $tableOffset = ($this.offset().top) - $("#header").outerHeight(),
            $header =  $this.find(" .tbl thead").clone(),
            $tbody =  $this.find(" .tbl tbody").clone(),
            $tbodyColNum = $this.find(" .tbl tbody tr:first-child th").length;
            $tbodyRowNum = $this.find(" .tbl thead tr").length;
            $colgroup =  $this.find(" .tbl colgroup").clone(),
            $fixedHeader = $this.find(".header-fixed");
            $fixedHeader.find(".tb_1").append($colgroup).append($header).append($tbody);
            $fixedHeader.find(".tb_2").append($("<thead>"))
            $fixedBody = $this.find(".header-tbody-th");
            $fixedBody.find(".tb_1")
            .append($this.find(" .tbl thead").clone())
            .append($this.find(" .tbl colgroup").clone())
            .append($this.find(" .tbl tbody").clone());


            for (var k = 1; k <= $tbodyColNum; k++) {
              thFCol = thFCol + parseInt($this.find(".tbl thead tr:first-child th:nth-child("+k+")").attr("colspan"));
              if(thFCol == $tbodyColNum || isNaN(thFCol)){
                thFColWidth = (thFColWidth + $this.find(".tbl thead tr:first-child th:nth-child("+k+")").outerWidth(true));
                //console.log("thFColWidth :: " +  thFColWidth);
                break;
              }

            }



            for (var j = 1; j <= $tbodyRowNum; j++) {
              thFRowCur = parseInt($this.find(".tbl thead tr:first-child th:nth-child("+j+")").attr("rowspan"));
              //console.log(thFRowCur + "::: thFRowCur");
                thFRow = thFRow + thFRowCur;
               if(thFRow == $tbodyRowNum){
                $fixedHeader.find(".tb_2 thead").append($("<tr>"));
                $fixedHeader.find(".tb_2 thead tr:nth-child("+j+")").append($this.find(".tbl thead tr:first-child th:nth-child("+j+")").clone());

                 $fixedHeader.find(".tb_2 thead th:nth-child("+j+")").css({
                  "height": ( ($this.find(" .tbl thead").height() / $tbodyRowNum) * thFRowCur )
                 })
              //   //console.log(thFRowHeight);
                  break;
               }

            }


            $fixedHeader.find(".tb_2").css({
              "width": thFColWidth
            })





            for (var i = 1; i <= $tbodyColNum; i++) {
              th_w = th_w + ( $this.find(" .tbl tbody tr:first-child th:nth-child("+i+")").outerWidth(true));
              // console.log(th_w);
            }






            $fixedBody.css({
              "width": th_w
            })
            .find(".tb_1").css({
              "width": $this.find(".tbl").width()
            });



            $fixedHeader.css({
              "height": $this.find(" .tbl thead").height()
            }).find(".tb_1").css({
              "width": $this.find(".tbl").width()
            });


            $(window).bind("resize", function() {
              $fixedHeader.width($this.find(" > .tbl").width());
            });

            $(window).bind("scroll", function() {
                var offset = $(this).scrollTop();

                $fixedHeader.css({
                  "top":(offset - $tableOffset),
//                  "height": $this.find(" .tbl thead").height()
                });
                //console.log(offset);
                if (offset >= $tableOffset) {
                    $fixedHeader.show();
                    //.width($this.find(" > .tbl").width());
                }
                else if (offset < $tableOffset) {
                    $fixedHeader.hide();
                }
            });

      })//each
  }


function tableScrollMotion(){

    var myScroll;
    var position;

    function updatePosition () {
      console.log();
      $(".header-fixed .tb_1").css({
        "margin-left":(this.x)
      });
    }

    function loaded () {
      position = document.getElementById('position');

      if($(".wrap_table").width() > $(".wrap_table").find(".tbl").width() ){
        $("#wrap-Iscroll .scroller").css({
        "width": $(".wrap_table").width()
       }).find(".tbl").css({
        "width":"100%"
       });
      }else{
        $("#wrap-Iscroll .scroller").css({
        "width": $(".wrap_table").find(".tbl").width()
       });
      };





    myScroll = new IScroll('#wrap-Iscroll', {
      //fadeScrollbars: true,
      probeType: 3,
      scrollbars: true,
      scrollX: true,
      scrollY: false,
      //freeScroll: true,
      //mouseWheelSpeed:200,
      mouseWheel: false,
      click:true,
      interactiveScrollbars: true
    });


      myScroll.on('scroll', updatePosition);
      myScroll.on('scrollEnd', updatePosition);

      $(".wrap_table").tableFixed2();

    }

    loaded();

}


 function setViewPort() {
    var viewPortName = document.getElementById("viewPort");
      var viewPortWidth = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
      if(1024 >= viewPortWidth && viewPortWidth >= 901){
        viewPortName.setAttribute("content","width=1100, target-densitydpi=device-dpi , user-scalable=no");
      }else if(900 >= viewPortWidth && viewPortWidth >= 768){
        viewPortName.setAttribute("content","width=1000, target-densitydpi=device-dpi , user-scalable=no");
      }else if(767 >= viewPortWidth && viewPortWidth >= 421){
        viewPortName.setAttribute("content","width=640, target-densitydpi=device-dpi , user-scalable=no");
      }else if(420 >= viewPortWidth){
        viewPortName.setAttribute("content","width=640, target-densitydpi=device-dpi , user-scalable=no");
      }else{
        viewPortName.setAttribute("content","width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi");
      }

    // var windowWidth = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
    //   if (windowWidth <= 1024 && windowWidth >= 901) {
    //     $("meta[name=viewport]").attr("content", "width=1100, target-densitydpi=device-dpi , user-scalable=no");
    //   } else if (windowWidth <= 900 && windowWidth >= 768) {
    //     $("meta[name=viewport]").attr("content", "width=1000, target-densitydpi=device-dpi , user-scalable=no");
    //   } else
    //    if (windowWidth <= 767 && windowWidth >= 320) {
    //     $("meta[name=viewport]").attr("content", "width=650, target-densitydpi=device-dpi , user-scalable=no");
    //   } else {
    //     $("meta[name=viewport]").attr("content", "width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi");
    //   };
  //  alert(viewPortWidth);
};
//setViewPort

//  function setViewPort() {
//   var e = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
//   1024 >= e && e >= 901 ? $("meta[name=viewport]").attr("content", "width=1024, target-densitydpi=device-dpi , user-scalable=no") : 900 >= e && e >= 768 ? $("meta[name=viewport]").attr("content", "width=768, target-densitydpi=device-dpi , user-scalable=no") : 767 >= e && e >= 421 ? $("meta[name=viewport]").attr("content", "width=640, target-densitydpi=device-dpi , user-scalable=no") : 420 >= e ? $("meta[name=viewport]").attr("content", "width=420, target-densitydpi=device-dpi , user-scalable=no") : $("meta[name=viewport]").attr("content", "width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi")
// };;


setViewPort();



var homePageLeng;
var WinWdith = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
var pageNum , subNum, threeNum;
var winResizeTimeout;
var homePageFlag = (homePageLeng == "kor");
// var HeaderPcSize = homePageFlag ? 176 : 146;
var HeaderPcSize =176;
var HeaderIngPcSize = 90;
var mobileSizeMin = 860;
var headerHeight  = function(){
    var winW = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
    if(winW > mobileSizeMin){
          return  90;
    }else{
       return  143;
    }
};

var isie=(/msie/i).test(navigator.userAgent),isie6=(/msie 6/i).test(navigator.userAgent),isie7=(/msie 7/i).test(navigator.userAgent),isie8=(/msie 8/i).test(navigator.userAgent),isie9=(/msie 9/i).test(navigator.userAgent),isie10=(/msie 10/i).test(navigator.userAgent),isfirefox=(/firefox/i).test(navigator.userAgent),isapple=(/applewebkit/i).test(navigator.userAgent),isopera=(/opera/i).test(navigator.userAgent),isios=(/(ipod|iphone|ipad)/i).test(navigator.userAgent),isipad=(/(ipad)/i).test(navigator.userAgent),isandroid=(/android/i).test(navigator.userAgent),device;

 function spotTxtMotion(obj){
     $obj = $(obj);
     $obj.each(function(){
        var $they = $(this),
              $children = $they.children();
        var direction = $they.data("dmp-txt-direction"),
              delay = $they.data("dmp-txt-delay");
              speed = $they.data("dmp-txt-speed");
            $children.wrap("<span class='dmp-txt-viewport'>").wrap("<span class='dmp-txt-pos'>");
            if(direction == "top"){
              TweenLite.set($they.find(".dmp-txt-pos"), {y:-( $they.outerHeight()) });
              TweenLite.to($they.find(".dmp-txt-pos"), speed, {y:0, ease: Power2.easeOut,delay:delay, onComplete:moveEnd});
            }else if(direction == "bot"){
              TweenLite.set($they.find(".dmp-txt-pos"), {y:$they.outerHeight() });
              TweenLite.to($they.find(".dmp-txt-pos"), speed, {y:0, ease: Power2.easeOut, delay:delay, onComplete:moveEnd});
            }else if(direction == "left"){
              TweenLite.set($they.find(".dmp-txt-pos"), {x:-( $they.outerWidth()) });
              TweenLite.to($they.find(".dmp-txt-pos"), speed, {x:0, ease: Power2.easeOut,delay:delay, onComplete:moveEnd});
            }else if(direction == "right"){
              TweenLite.set($they.find(".dmp-txt-pos"), {x:$they.outerWidth() });
              TweenLite.to($they.find(".dmp-txt-pos"), speed, {x:0, ease: Power2.easeOut,delay:delay, onComplete:moveEnd});
            }//if::direction

            function moveEnd(){ };
     });//each
}//spotTxtMotion

function layerPopupv2(){
   var $win = $(window);
   var $html = $('html, body');
   var winTop = 0;

     this.open = function (url,func,da2,pos){
          var $wrap2 = $("#wrap-total");
          if(func != ''){
            var callbacks = $.Callbacks();
            callbacks.add( func );
          }

            if(url != undefined){
                       $.ajax({
                          type:"POST",
                          url:url,
                          dataType:"html",
                          data : da2,
                           success : function(data) {

                              var $data = $(data);
                              var h = $(window).height();
                              var t3 = new TimelineMax();
                              $("body").append( $data );

                              var $layerP2 = $(".layerPopupT2");
                              $layerP2.cover = $layerP2.find(".cover");






                              $layerP2.imagesLoaded( function() {
                                $layerP2.css({"display":"block",opacity:0});
                                if(callbacks != undefined){
                                    callbacks.fire();
                                  }

                                var contH = $(".wrap-popup-ty1").outerHeight();
                                var contW = $(".wrap-popup-ty1").width();
                                var margin = 100;

                                winTop = $(window).scrollTop();
                                 $wrap2.css({
                                  "position":"fixed",
                                  "top": -(winTop)
                                });

                                 t3.to($layerP2, 0.6, { y:0,opacity:1, ease:Back.easeOut.config(1) });


                                if( (contH+margin) < h ){

                                  $(".wrap-popup-ty1").css({
                                    "position":"fixed" ,
                                    "display":"block" ,
                                    "top":  ((h - contH) / 2) ,
                                    "margin-left": -(contW / 2) ,
                                    "left": "50%"

                                  });

                                  $layerP2.cover.css({"height":h});

                                }else{

                                  $(".wrap-popup-ty1").css({
                                    "position":"absolute",
                                    "display":"block",
                                    "top": margin,
                                    "margin-left": -(contW / 2) ,
                                    "left": "50%"
                                  });

                                  $(window).scrollTop(0);

                                  $layerP2.cover.css({"height":contH + 100 + 50});

                                }







                              });

                          },error : function(xhr, status, error) {

                          }
                      })

            }else{//if
                alert('데이타가 존재하지 않습니다.');
            }
     };//open
     this.close = function (id){
      var $id = $(id);
       var $wrap2 = $("#wrap-total");
        TweenMax.to($id, 0.6, { y:-10,opacity:0, ease:Back.easeOut.config(1), onComplete:myClose });
        function myClose(){
          $id.remove();
           $wrap2.css({
            "position":"",
            "top": ""
          });
           $(window).scrollTop(winTop);
        }
     };//close


}//layerPopup

window.layerPopupV2  = new layerPopupv2();



$(function(){
  // $("#header").css({
  //   "visibility":"visible",
  //   "opacity":0
  // });
  // $("#spot-sub").css({
  //   "visibility":"visible",
  //   "opacity":0
  // });
  // TweenLite.to($("#header"), 0.3, {opacity:1, delay:0.3});
  // TweenLite.to($("#spot-sub"), 0.3, {opacity:1, delay:0.3});
  scrollTopEvent(WinWdith);
  $("#header .box-scroll").find(".btn_lnb").on("click",function(){
       fixedTopMotion(false);
        scrollIngFlag = false;
   });

   // box-select-ty1 Layer Type
  $(".box-select-ty1").on('click',function(e){
    if ($(this).hasClass("on") == false){
      $(".box-select-ty1.on").find(".selectMenu").hide();
      $(".box-select-ty1.on").removeClass("on");

      $(this).find(".selectMenu").stop().slideDown('fast');
      $(this).addClass("on");
    } else {
      $(this).find(".selectMenu").hide();
      $(this).removeClass("on");
    }
  });
  $(".box-select-ty1 .selectMenu>li>a").on('click',function(e){
    $(this).parents(".box-select-ty1").find(".selectVal a").text($(this).text());
  });

  $(document).on('touchstart focusin mouseup',function(e){
    var container = $(".box-select-ty1");

    if (container.has(e.target).length === 0){
      container.find(".selectMenu").hide();
      container.removeClass("on");
    }
  });
  $(".box-select-ty1 .selectVal").on('keypress',function(e){
    if ($(this).parents(".box-select-ty1").hasClass("on") == false){
      $(".box-select-ty1.on").find(".selectMenu").hide();
      $(".box-select-ty1.on").removeClass("on");
      $(this).parents(".box-select-ty1").find(".selectMenu").stop().slideDown('fast',function(){
        $(this).parents(".box-select-ty1").addClass("on");
      });
    }
  });

})//$function

$(window).on("scroll.win",function(){
  var width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
 scrollTopEvent(width);
});//scroll

$(window).on("resize.win",function(){
  var width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
  winResizeTimeout = setTimeout(function(){
      scrollTopEvent(width);
  },50)

});//scroll


$.fn.fadeHover = function(o){
  var el = this;
  o = $.extend({
    flag : true
  }, o || {});

  return this.each(function(){
    var $this = $(this);
    var flag = o.flag;
    var imgIn = function(elemt){
        var imgOvr = elemt.find("span.i-h>img").attr("src").replace("_off","_on");
            elemt.find("span.i-h").append($("<img />").attr("src",imgOvr).css({
              "opacity":0,
              "position":"absolute",
              "left":0,
              "top":0
            }).addClass("ovr"))
            .find(".ovr").stop().animate({"opacity":1},200);
    }//imgin
    var imgOut = function(elemt,speed){
      elemt.find("span.i-h .ovr").stop().animate({"opacity":0},speed,function(){$(this).remove();});
    }//imgin

    el.resetHover = function(){
      $this.removeClass("on");
      imgOut($this,200);
    }


    if(!flag){
      $this.off().on("mouseenter mouseleave",function(e){
          var elemt = $(this);
            if(!elemt.hasClass("on")){
              (e.type == "mouseenter") ?  imgIn(elemt) : imgOut(elemt,200);
            }//hasClass
         });

        }else{//flag
          if(!$this.hasClass("on")){
            $this.siblings(".on").removeClass("on").trigger("mouseleave").end().addClass("on");
            if ($this.find(".ovr").length == 0)  imgIn($this);
          }
        }
  })//each
}//fadeHover


var iscrollFn = {
  area: "",
  isc : "",
  t: "",
  event: true,
  init: function(t) {
    this.t = t;

    this.area = this.t + " .i-sc";
    //this.area.height(this.t.outerHeight()-this.t.find('header').outerHeight()-this.t.find('footer').outerHeight()-40);
    this.setting();
  },
  handleTouchMove: function(e) {
    e.preventDefault();
  },
  setting: function(){
      // iscrollFn.isc = new IScroll(this.area, {
      //   scrollbars: 'custom',
      //   mouseWheel: true,
      //   disableMouse: true,
      //   preventDefault : true
      // });
      // $(window).off('resize.popupBox').on('resize.popupBox', iscrollFn.refresh);
      // iscrollFn.setCheck();
  },
  refresh: function(){
    setTimeout(function () {
          //iscrollFn.area.height(iscrollFn.t.outerHeight()-iscrollFn.t.find('header').outerHeight()-iscrollFn.t.find('footer').outerHeight()-40);
          iscrollFn.setCheck();
          iscrollFn.isc.refresh();
      }, 500);
  },
  destroy: function(){
          // iscrollFn.isc.destroy();
          // $(window).off('resize.popupBox');
  },
  setCheck: function(){

  //   var wW = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
  //   if(wW < 640) {
  //     iscrollFn.isc.destroy();
  //     document.removeEventListener('touchmove', this.handleTouchMove);
  //     this.event = true;
  //   }else{
  //     if(this.event){
  //       iscrollFn.isc.destroy();
  //       this.setting();
  //       this.event = false;
  //       document.addEventListener('touchmove', iscrollFn.handleTouchMove, false);
  //     }
  //   }

  //   var scroll_bar = this.area.find('.iScrollVerticalScrollbar');
  //   scroll_bar.css('display', scroll_bar.find('.iScrollIndicator').css('display'));
   }
};

function tabFixed(){

var $tab = $(".tab-ty1");
var tabOffsetBefore = $tab.offset().top;
var ww = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
var winScroll = $(window).scrollTop() + tabTop;
var tabWidth = $("#container.sub .container_inner").outerWidth();
var headerH ,tabTop, tebFixedSetTime, pc, mobile ;

      function responsive(){
          if (mobileSizeMin < ww){
                if(mobile){
                    reset();
                    tabOffsetBefore = $tab.offset().top;
                }
                pc = true;
                mobile = false;

            }else{
                if(pc){
                    reset();
                    tabOffsetBefore = $tab.offset().top;
                }
                pc = false;
                mobile = true;
            }
      };

      function reset(){
              $tab.css({
                "position":"relative",
                "width":"",
                "top": 0
              })
              .removeClass("f");
      }//reset

      function change(){
          $tab.css({
              "position":"fixed",
              "width":tabWidth,
              "top": tabTop
            })
            .addClass("f");
      }

      function tabResizeSet(){
          ww = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
          winScroll = $(window).scrollTop() + tabTop;
          //headerH = (mobileSizeMin < ww) ? $("#header").outerHeight() : $("#header-mobile").outerHeight();
          headerH = (mobileSizeMin < ww) ? 176 : 143;
          tabTop = headerH;
          tabWidth = $("#container.sub .container_inner").outerWidth();
          tabOffsetAfter = $tab.offset().top;
         responsive();
          // con("tabOffset:::: "+tabOffsetBefore);
          // con("winScroll:::: "+winScroll);
           if(winScroll > tabOffsetBefore){
              change();
            }else{
              reset();
            }

      }//tabResizeSet


     $(window).off("scroll.tabOffset").on("scroll.tabOffset",function(){
          tabResizeSet();
     }).off("resize.tabOffset").on("resize.tabOffset",function(){
        clearInterval(tebFixedSetTime);
        tebFixedSetTime = setTimeout(function(){
            tabResizeSet();
        },300);
     });

     tabResizeSet();

}; //tabFixed

function tab(o,s){
  $obj  = $(o);

  $obj.each(function(){
    var $this = $(this);
    var $total = $this.find("li").length;
    var $first = s-1;
    var $prev = $first;
    var tab_id = new Array();
    var $btn = $this.find("li");
    var $start = $btn.eq($first);

    for( var i=0; i<$total; i++){
      tab_id[i] = $btn.eq(i).find("a").attr("href");
      $(tab_id[i]).css("display","none");
      $(tab_id[$first]).css("display","block");
    }

    $start.addClass("on");

   $btn.bind("click",function(){
    var $this = $(this);
    var $index = $(this).index();

    if(!$this.hasClass("link")){
          if(!$this.hasClass("on")){
           $btn.each(function(){
            $(this).removeClass("onFak");
           });
           $this.addClass("on");
           $(tab_id[$prev]).css("display","none");
           $(tab_id[$index]).css("display","block");
           $prev = $index;
        }

        return false;

    }




   });


  });//each
}//tab

function tab2(o,s){
  $obj  = $(o);
  $obj.each(function(){
    var $this = $(this);
    var $total = $this.find("li").length;
    var $first = s-1;
    var $prev = $first;
    var tab_id = new Array();
    var $btn = $this.find("li");
    var $start = $btn.eq($first);

    for( var i=0; i<$total; i++){
      tab_id[i] = $btn.eq(i).find("a").attr("href");
      $(tab_id[i]).css("display","none");
      $(tab_id[$first]).css("display","block");
    }

    $start.addClass("on");

   $btn.bind("click",function(){
    var $this = $(this);
    var $index = $(this).index();

    if(!$this.hasClass("link")){
          if(!$this.hasClass("on")){
           $btn.each(function(){
            $(this).removeClass("on");
           });
           $this.addClass("on");
           $(tab_id[$prev]).css("display","none");
           $(tab_id[$index]).css("display","block");
           $prev = $index;
        }

        return false;

    }

   });


  });//each
}//tab


// input[type=file]
function setFilePath(oObj,tObj) {
  $("#"+tObj).val($("#"+oObj).val());
}
function resetUpFile(tObj) {
  $("#"+tObj).val('');
}

function setFileName(source, target) {
  var fullPath = $("#"+source).val();
  var fileName = fullPath.replace(/^.*[\\\/]/, '');
  $("#"+target).val(fileName);
}



//1280 * 720 == 16:9
function dmResize(box) {
  var $box = $(box);
  var res16_9 = {w:1280,h:720};
  $box.w =  $box.outerWidth();
  $box.h =  $box.outerHeight();
  var x_percent = $box.w / res16_9.w,
    y_percent = $box.h / res16_9.h;
  var x_num = parseInt(res16_9.w * y_percent),
    y_num = parseInt(res16_9.y * y_percent) + 2;

  if(x_num >= $box.w){
    $box.find(".dm_wrap").css({"height" : y_num});
    $box.find(".dm_box").css({"width" : x_num, "height" : y_num, "marginLeft" : x_num/-2 + "px", "marginTop" : y_num/-2 + "px"});
  }else{
    var x_num = parseInt(1280 * x_percent);
    var y_num = parseInt(720 * x_percent);
    $box.find(".dm_wrap").css({"height" : y_num});
    $box.find(".dm_box").css({"width" : x_num, "height" : y_num, "marginLeft" : x_num/-2 + "px", "marginTop" : y_num/-2 + "px"});
  }
}//dmResize




  function pageInfo(pNum,sNum,tNum){
  pageNum = pNum;
  subNum = sNum;
  threeNum = tNum;
  var lnbUl = $("#header .lnb .lnb_inner > ul.lst");
  var snbUl = $(".snb .lst");

  if(pageNum > 0 && pageNum <= lnbUl.find(">li").length){
    $(window).load(function(){
      setTimeout(function(){
        $(".lnb  .lst  > li.m"+pageNum).trigger('mouseenter');
      },500);

     })
    //lnbUl.find(" > li.m"+pageNum).addClass("on").find(">a>img").imgConversion(true);

  };

  if(subNum > 0 && subNum <= snbUl.find(">li").length){
    snbUl.find(" > li.s"+subNum).addClass("on").find(">a>span>img").imgConversion(true);

  };
};//pageInfo


function backgroundMotion(o,a,b,c,d){
      var $obj = $(o);
       var x = a;
       var y = b;
       var cut = c;
       var sec = d;
       var xTotal = 0;
       var yTotal = 0;
       var num = 0;
        setInterval(function(){
            if(num < 32){
                yTotal -=  y;
                $obj.css('background-position', xTotal + 'px '+ yTotal + 'px');
                num ++;
            }
        }, sec);
  };//backgroundMotion

var scrollStartFlag = false;
var scrollIngFlag = false;
var scrollMobileFlag = false;


function scrollTopEvent(w){
    var win = $(window),
    doc = $(document),
    body = (navigator.userAgent.indexOf('AppleWebKit') !== -1) ? $('body') : $('html');
    var top = win.scrollTop();

      if(top <= 300 ){
            btnTopMotion(true);
        }else{
          btnTopMotion(false);
        }

        function btnTopMotion(b){
            if(b){
              $(".btn-top").css("right","-124px");
            }else{
              $(".btn-top").css("right","");
            }
          };



    if(w >  mobileSizeMin){
        if(top <= 150 ){
          //con("sdfsfa");
          startScroll();
        }else{
          ingScroll();
        }
    }else{
      pcResetScroll();
    }

    function pcResetScroll(){
       if(!scrollMobileFlag){
           con("스크롤 ::: mobile");
          //상단 모션
          fixedTopMotion(false);
        }//if
        scrollMobileFlag = true;
        scrollStartFlag = false;
        scrollIngFlag = false;
    }//pcResetScroll

    function startScroll(){
      if(!scrollStartFlag){
         con("스크롤 ::: top");
        //상단 모션
        fixedTopMotion(false);
      }//if
      scrollStartFlag = true;
      scrollIngFlag = false;
      scrollMobileFlag = false;
    }//startScroll

    function ingScroll(){
      //console.log("ing-Start:::"+scrollStartFlag);
      //console.log("ing-Ing:::"+scrollIngFlag);
      if(!scrollIngFlag){
       con("스크롤 ::: ing");
        //상단 모션
        fixedTopMotion(true);
      }//if

      scrollIngFlag = true;
      scrollStartFlag = false;
      scrollMobileFlag = false;
    }//ingScroll

};//scrollTopEvent

function fixedTopMotion(b){
  var header = $("#wrap");
  var h_w = $("#header").outerHeight();
  // var headerTopMargin = (homePageFlag) ?  -41 : - 6;
  var headerTopMargin = -41;
  var ww = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
  // if(b){
  //   header.addClass("ing");
  //   $("#header .box-scroll").css({"display":"block"});
  //   TweenMax.set($("#header .box-scroll"),{"y":50});
  //   TweenMax.to($("#header .box-scroll"),0.2,{"opacity":1,"y":0});
  //   TweenMax.to($("#header .lnb"),0.2,{"y":20,"opacity":0,onComplete:function(){
  //       $("#header .lnb").css({"display":"none"});
  //   }});

  //   TweenMax.to($("#header .top"),0.2,{"margin-top":headerTopMargin,onComplete:function(){
  //       $("#header .top").css({"display":"none"});
  //     }});

  //   if(!homePageFlag){
  //         TweenMax.to($("#header .top > .lst_right"),0.2,{"opacity":0,"y":0});
  //   }

  //   TweenMax.to($("#header .search_top"),0.2,{"opacity":0,onComplete:function(){
  //       $("#header .search_top").css({"display":"none"});
  //   }});

  //   TweenMax.to($("#header .logo"),0.2,{"margin-top":22});
  //   TweenMax.to($("#header"),0.2,{"height":HeaderIngPcSize});

  //   if($("#spot.main").length > 0){
  //     TweenMax.to($("#spot.main"),0.2,{"top":HeaderIngPcSize});
  //   }

  //   lnbBgMotion(false,true);

  // }else{
  //   header.removeClass("ing");

  //   TweenMax.to($("#header .box-scroll"),0.2,{"opacity":0,onComplete:function(){
  //       $("#header .box-scroll").css({"display":"none"});
  //     }});

  //   $("#header .top").css({"display":"block"});
  //   TweenMax.to($("#header .top"),0.2,{"margin-top":0});

  //   if(!homePageFlag){
  //         TweenMax.to($("#header .top > .lst_right"),0.2,{"opacity":1,"y":0});
  //   }

  //   $("#header .lnb").css({"display":"block"});
  //   TweenMax.to($("#header .lnb"),0.2,{"y":0,"opacity":1});

  //   $("#header .search_top").css({"display":"block"});
  //   TweenMax.to($("#header .search_top"),0.2,{"y":0,"opacity":1});

  //   TweenMax.to($("#header .logo"),0.2,{"margin-top":28});
  //   if(ww <= mobileSizeMin){
  //     $("#wrap").css({"padding-top":$("#header-mobile").outerHeight() });
  //      if($("#spot.main").length > 0){  $("#spot.main").css({ "top":0}); };
  //   }else{

  //     TweenMax.to($("#header"),0.2,{"height":HeaderPcSize});

  //      if($("#spot.main").length > 0){
  //           $("#wrap").css({"padding-top":HeaderPcSize + $("#spot.main").outerHeight()  });
  //           TweenMax.to($("#spot.main"),0.2,{"top":HeaderPcSize});
  //       }else{
  //           $("#wrap").css({"padding-top":HeaderPcSize  });
  //       }

  //   }


  // }

}//fixedTopMotion







$.fn.extend({imgConversion : function(s,type){var xt = $(this).attr('src').lastIndexOf('.') + 1;xt = $(this).attr('src').substr(xt);if(s){$(this).attr('src', $(this).attr('src').replace('off.'+xt, (type != "hover")? 'on.'+xt :'hover.'+xt ));}else{$(this).attr('src', $(this).attr('src').replace((type != "hover")? 'on.'+xt : 'hover.'+xt , 'off.'+xt));};return $(this);}});
function con(l,t){if( "console" in window ){var log = (t == undefined) ? l : t + l; /*console.log(log);*/};};
(function (w) {var ua = window.navigator.userAgent;var msie = ua.indexOf("MSIE ");if(msie > 0 && parseInt(ua.substring(msie + 5, ua.indexOf(".", msie)), 10) < 7) {location.href = '/NoticeIE6.html';};})(window);
function setCookie(name,value,expiredays){var today = new Date();today.setDate(today.getDate()+expiredays);document.cookie = name + "=" + escape(value) + "; path=/; expires=" + today.toGMTString() + ";";}
function getCookie( name ) {
   var nameOfCookie = name + "=";
   var x = 0;
   while ( x <= document.cookie.length ){
           var y = (x+nameOfCookie.length);
           if ( document.cookie.substring( x, y ) == nameOfCookie ) {
                   if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
                           endOfCookie = document.cookie.length;
                   return unescape( document.cookie.substring( y, endOfCookie ) );
           }
           x = document.cookie.indexOf( " ", x ) + 1;
           if ( x == 0 )
                   break;
   }
   return "";
};
function boxSizeTotal(box,obj,a,b,c,d){
    var $box = box;
    var $obj = obj;
    var $a1 = a;
    var $a2 = b;
    var $a3 = c;
    var $a4 = d;
    var total = $box.outerHeight();

    if($a1 != undefined){
         total = total - $a1.outerHeight();
     };
   if($a2 != undefined){
        total = total - $a2.outerHeight();
   };
   if($a3 != undefined){
        total = total - $a3.outerHeight();
   };
   if($a4 != undefined){
        total = total - $a4.outerHeight();
   };

     return total;
};

function fadePlayMotion(play , t , speed){
  if(t){
    if(Modernizr.opacity){
        play.css({"display":"block","opacity":0}).stop().animate({"opacity":1},speed);
      }else{
        play.css({"display":"block"})
      }
  }else{//t
     if(Modernizr.opacity){
        play.stop().animate({"opacity":0},speed,function(){
          $(this).css("display","none");
        });
      }else{
        play.css({"display":"none"})
      }
  }

}//fadePlayMotion

function iCutter(obj){
  var o = $(obj);

    var divs = $(obj);
    divs.each(function(){
      var $this = $(this);
      var divAspect = $this.outerHeight() / $this.outerWidth();
      var img = $this.find('img');
      var imgAspect = img.outerHeight() / img.outerWidth();
      img.css({
            "max-width":"initial",
            "max-height":"initial"
      });
      if (imgAspect <= divAspect) {
          var imgWidthActual = $this.outerHeight() / imgAspect;
          var imgWidthToBe = $this.outerHeight() / divAspect;
          var marginLeft = -Math.round((imgWidthActual - imgWidthToBe) / 2)
          img.css({
            "width":"auto",
            "height":"100%",
            "margin-left":marginLeft
          });
        } else {

           img.css({
            "width":"100%",
            "height":"auto",
            "margin-top": -( ( img.outerHeight() - $this.outerHeight() ) / 2),
            "margin-left":0
          });
        }
    });//each



    /*window.onload = function() {

      for (var i = 0; i < divs.length; ++i) {
        var div = divs[i];
        var divAspect = div.offsetHeight / div.offsetWidth;
        console.log(divAspect)
        //div.style.overflow = 'hidden';

        var img = div.querySelector('img');
        var imgAspect = img.height / img.width;

        if (imgAspect <= divAspect) {
          var imgWidthActual = div.offsetHeight / imgAspect;
          var imgWidthToBe = div.offsetHeight / divAspect;
          var marginLeft = -Math.round((imgWidthActual - imgWidthToBe) / 2)
          img.style.cssText = 'width: auto; height: 100%; margin-left: '
                          + marginLeft + 'px;'
        } else {
          img.style.cssText = 'width: 100%; height: auto; margin-left: 0;';
        }
      }
    };*/
}//iCutter

function dotWindow(o , mode){
  var obj = $(o);
  var mode = mode;
  var mainTimeOutSet;
  function fontDot(){
      obj.dotdotdot({ watch: mode });
    }

     $(function(){
        $(window).on("resize.dotWin",function(){
          clearInterval(mainTimeOutSet);
          mainTimeOutSet = setTimeout(function(){
              fontDot();
          },1000);
        });
        fontDot();
      });

}//dotWindow

var LayerPopupFirst;

function LayerPopup(obj,dbp,t){
    var $allPopup = $(".PopupWrap");
    var $obj = $(obj);
    var $close = $(t);
    var objWidth = $obj.outerWidth();
    var objHeight = $obj.outerHeight();
    var winHeight = $(window).height();
    var scrollT = $(window).scrollTop();


  if(obj =="close"){
      if($(".dbp.PopupWrap").length > 0){
       popupRemove2();
      }else{

        var $box = $close.closest(".PopupWrap");
            if($box.find(".box_mainproduct_rolling").length > 0 ){
              if($box.find(".box_mainproduct_rolling").css("visibility") != "hidden"){
                      for (var i = 1; i <= $box.find(".box_mainproduct_rolling").find(".img").length; i++) {
                        if($box.find(".box_mainproduct_rolling").find(".img.n"+i).css("display") == "block"){
                            var num = ($box.find(".box_mainproduct_rolling").find(".img.n"+i).data("num")) + 1
                         }
                      }
                      $box.find(".box_mainproduct_rolling").animate({"opacity":0},300,function(){
                        $box.find(".box_mainproduct_rolling").css("visibility","hidden");
                        $box.find(".box_lft").css("display","block")
                        .find(".product_main .img.n"+num+" button").focus();
                        if($box.find(".box_rgh").length > 0){
                            $box.find(".box_rgh").css("display","block");
                            $box.css("height","");
                        }
                      })
                      return;
                  }else{
                   popupRemove();
                  }
            }else{
                popupRemove();
            }
      }


      if(LayerPopupFirst != undefined){
        setTimeout(function(){
          $(".f-mod").focus().removeClass("f-mod");
          LayerPopupFirst = undefined;
        },500);
       }
       if($box.find(".i-sc").length > 0){
            iscrollFn.destroy();
         }



  }else{

    LayerPopupFirst = $(t).addClass("f-mod");

    if(dbp == true){

       var backgound2 = $("<div>").attr({
             "class": "bg_cover dbp"
        }).css({
            "opacity":0,
             "z-index":310,
             "height": $(window).outerHeight()
        })
        $("body").append(backgound2);
        $obj.css({
          "position": (winHeight < objHeight ) ? "absolute" : "fixed",
           "display":"block",
           "opacity":0,
           // "width":objWidth,
           // "height":objHeight,
           "top": (winHeight < objHeight ) ? 100 : "50%",
           "margin-left":-( objWidth / 2),
           "margin-top": (winHeight < objHeight ) ? 0 : -( objHeight / 2),
           "z-index":320,
          }).addClass("dbp").stop().animate({"opacity":1},400);
        backgound2.stop().animate({"opacity":1},400);

       backgound2.off().on("click",function(){
            popupRemove2();
       });
         $(window).off("resize.popupResize2").on("resize.popupResize2",function(){
              popupCssSet();
        })
         popupCssSet();

    }else{
      // $(document).off().on('focusin.popupFocus','.cboxClose',function(e){
      //   $(".close").focus();
      // });
      var typeFlag = true;
      if(obj == "#popup-brand"){
          if($(t).closest(".lst_isotope").hasClass("s_hide")){
            return;
          }
      }

      if(obj == "#popup_sitemap"){
            typeFlag = false;
      }


       var backgound = $("<div>").attr({
             "class": "bg_cover"
        }).css({
            "opacity":0,
             "height": $("body").outerHeight()
        })


       $allPopup.css("display","none");
       var recentLoad = imagesLoaded($obj);
        recentLoad.off().on( 'always', function(){
          objWidth = $obj.outerWidth();
          objHeight = $obj.outerHeight();
          winHeight = $(window).height();
          scrollT = $(window).scrollTop();
          if(typeFlag){
              $obj.css({
                "display":"block",
                "position": (winHeight < objHeight ) ? "absolute" : "fixed",
                 "opacity":0,
                 // "width":objWidth,
                 // "height":objHeight,
                 "top": (winHeight < objHeight ) ? $(window).scrollTop() + 50 : "50%",
                 "z-index":300,
                 "margin-left":-( objWidth / 2),
                 "margin-top": (winHeight < objHeight ) ? 0 : -( objHeight / 2),
                }).stop().animate({"opacity":1},400);
            }else{
              $obj.css({
                "display":"block",
                 "opacity":0,
                 "z-index":300
                }).stop().animate({"opacity":1},400);
            }

          $("body").append(backgound);
         backgound.css({
          "height": ($("body").outerHeight() > (scrollT + objHeight) ) ? $("body").outerHeight()  : scrollT + objHeight + 150
         }).stop().animate({"opacity":1},400);

         $obj.find(".LayerPopup").attr("tabindex","0").focus();
         //$obj.find("button:first").focus();

         if($obj.find(".i-sc").length > 0){
            iscrollFn.init(obj);
         }

         if($obj.find(".box_mainproduct_rolling").length > 0){
            $obj.find(".box_mainproduct_rolling").css("height",$obj.outerHeight());
            // alert($obj.outerHeight());
            // alert( $obj.find(".box_mainproduct_rolling .bx-wrapper .bx-viewport .bxslider .img > span").height());

            var bxH = ( $obj.outerHeight() - $obj.find(".box_mainproduct_rolling .bx-wrapper .bx-viewport .bxslider .img > span").height() ) / 2;
            if(bxH < 0 ){
              $obj.find(".box_mainproduct_rolling .bx-wrapper .bx-viewport .bxslider .img > span").css("padding-top","1%");
            }
            $obj.find(".box_mainproduct_rolling .bx-wrapper .bx-viewport .bxslider .img > span").css("padding-top",bxH)
         }
       })

       backgound.off().on("click",function(){
            popupRemove();
       });
         $(window).off("resize.popupResize").on("resize.popupResize",function(){
              popupCssSet();
          })
         popupCssSet();
         $(".focus-frist").off("focusin").on("focusin",firstFocus);
         $(".btn-focus-back").off("focusin").on("focusin",backFocus);


     }//dbp

  }//if

  function backFocus(){
      $(this).prev().focus();
  }
  function firstFocus(){
      $(this).next().attr("tabindex","0").focus();
  }

  function popupCssSet(){
    objWidth = $obj.outerWidth();
    objHeight = $obj.outerHeight();
    winHeight = $(window).height();
     scrollT = $(window).scrollTop();
     if(typeFlag){
        $obj.css({
            // "width":objWidth,
            // "height":objHeight,
            "position": (winHeight < objHeight ) ? "absolute" : "fixed",
            "top": (winHeight < objHeight ) ? scrollT+ 50 : "50%",
            "margin-left":-( objWidth / 2),
            "margin-top": (winHeight < objHeight ) ? 0 : -( objHeight / 2),
          })
    };

    $(".bg_cover").css({
        "width":$("body").width(),
        "height":$("body").height()
      })

  }

    if($obj.find(".box_mainproduct_rolling").length > 0){
        $obj.find(".box_mainproduct_rolling").css("height",$obj.outerHeight());
        var bxH = ( $obj.outerHeight() - $obj.find(".box_mainproduct_rolling .bx-wrapper .bx-viewport .bxslider .img > span").height() ) / 2;
        if(bxH < 0 ){
              $obj.find(".box_mainproduct_rolling .bx-wrapper .bx-viewport .bxslider .img > span").css("padding-top","1%");
            }
         $obj.find(".box_mainproduct_rolling .bx-wrapper .bx-viewport .bxslider .img > span").css("padding-top",bxH)
     }

  function popupRemove(){
          rem();

      function rem(){
          $allPopup.css({
            "display":"none",
            "tabindex":""
          });
          $(".bg_cover").stop().animate({"opacity":0},400,function(){
            $(".bg_cover").remove();
           })
          $(window).off("resize.popupResize");

      }

  }

    function popupRemove2(){
      $(".dbp.PopupWrap").css("display","none").removeClass("dbp");
      $(".bg_cover.dbp").stop().animate({"opacity":0},400,function(){
        $(".bg_cover.dbp").remove();
       })
      $(window).off("resize.popupResize2")
  }

}//LayerPopup_type



var LayerPopupAbsFirst;

function LayerPopupAbs(obj,dbp,t){
    var $allPopup = $(".PopupWrap");
    var $obj = $(obj);
    var $close = $(t);
    var objWidth = $obj.outerWidth();
    var objHeight = $obj.outerHeight();
    var winHeight = $(window).height();
    var scrollT = $(window).scrollTop();


  if(obj =="close"){
      if($(".dbp.PopupWrap").length > 0){
       popupRemove2();
      }else{
        popupRemove();
      }


      if(LayerPopupAbsFirst != undefined){
        setTimeout(function(){
          $(".f-mod").focus().removeClass("f-mod");
          LayerPopupAbsFirst = undefined;
        },500);
       }




  }else{

    LayerPopupAbsFirst = $(t).addClass("f-mod");

    if(dbp == true){

       var backgound2 = $("<div>").attr({
             "class": "bg_cover dbp"
        }).css({
            "opacity":0,
             "z-index":310,
             "height": $(window).outerHeight()
        })
        $("body").append(backgound2);
        $obj.css({
          "position": (winHeight < objHeight ) ? "absolute" : "fixed",
           "display":"block",
           "opacity":0,
           // "width":objWidth,
           // "height":objHeight,
           "top": (winHeight < objHeight ) ? 100 : "50%",
           "margin-left":-( objWidth / 2),
           "margin-top": (winHeight < objHeight ) ? 0 : -( objHeight / 2),
           "z-index":320,
          }).addClass("dbp").stop().animate({"opacity":1},400);
        backgound2.stop().animate({"opacity":1},400);

       backgound2.off().on("click",function(){
            popupRemove2();
       });
         $(window).off("resize.popupResize2").on("resize.popupResize2",function(){
              popupCssSet();
        })
         popupCssSet();

    }else{
      // $(document).off().on('focusin.popupFocus','.cboxClose',function(e){
      //   $(".close").focus();
      // });
      var typeFlag = true;


       $allPopup.css("display","none");
       var recentLoad = imagesLoaded($obj);
        recentLoad.off().on( 'always', function(){
          objWidth = $obj.outerWidth();
          objHeight = $obj.outerHeight();
          winHeight = $(window).height();
          scrollT = $(window).scrollTop();
          if(typeFlag){
              $obj.css({
                "display":"block",
                "position":"absolute",
                 "opacity":0,
                 // "width":objWidth,
                 // "height":objHeight,
                 "z-index":300,
                 "margin-left":-( objWidth / 2)
                }).stop().animate({"opacity":1},400);
            }else{
              $obj.css({
                "display":"block",
                 "opacity":0,
                 "z-index":300
                }).stop().animate({"opacity":1},400);
            }



         $obj.find(".LayerPopup").attr("tabindex","0").focus();
         //$obj.find("button:first").focus();

         if($obj.find(".i-sc").length > 0){
            iscrollFn.init(obj);
         }

         if($obj.find(".box_mainproduct_rolling").length > 0){
            $obj.find(".box_mainproduct_rolling").css("height",$obj.outerHeight());
            var bxH = ( $obj.outerHeight() - $obj.find(".box_mainproduct_rolling .bx-wrapper .bx-viewport .bxslider .img > span").height() ) / 2;
            if(bxH < 0 ){
              $obj.find(".box_mainproduct_rolling .bx-wrapper .bx-viewport .bxslider .img > span").css("padding-top","1%");
            }
            $obj.find(".box_mainproduct_rolling .bx-wrapper .bx-viewport .bxslider .img > span").css("padding-top",bxH)
         }
       })

         $(window).off("resize.popupResize").on("resize.popupResize",function(){
              popupCssSet();
          })
         popupCssSet();
         $(".focus-frist").off("focusin").on("focusin",firstFocus);
         $(".btn-focus-back").off("focusin").on("focusin",backFocus);


     }//dbp

  }//if

  function backFocus(){
      $(this).prev().focus();
  }
  function firstFocus(){
      $(this).next().attr("tabindex","0").focus();
  }

  function popupCssSet(){
    objWidth = $obj.outerWidth();
    objHeight = $obj.outerHeight();
    winHeight = $(window).height();
     scrollT = $(window).scrollTop();
     if(typeFlag){
        $obj.css({
            // "width":objWidth,
            // "height":objHeight,
            "position": "absolute" ,
            "margin-left":-( objWidth / 2)
          })
    };

  }

    if($obj.find(".box_mainproduct_rolling").length > 0){
        $obj.find(".box_mainproduct_rolling").css("height",$obj.outerHeight());
        var bxH = ( $obj.outerHeight() - $obj.find(".box_mainproduct_rolling .bx-wrapper .bx-viewport .bxslider .img > span").height() ) / 2;
        if(bxH < 0 ){
              $obj.find(".box_mainproduct_rolling .bx-wrapper .bx-viewport .bxslider .img > span").css("padding-top","1%");
            }
         $obj.find(".box_mainproduct_rolling .bx-wrapper .bx-viewport .bxslider .img > span").css("padding-top",bxH)
     }

  function popupRemove(){
          rem();

      function rem(){
          $allPopup.css({
            "display":"none",
            "tabindex":""
          });
          $(".bg_cover").stop().animate({"opacity":0},400,function(){
            $(".bg_cover").remove();
           })
          $(window).off("resize.popupResize");

      }

  }

    function popupRemove2(){
      $(".dbp.PopupWrap").css("display","none").removeClass("dbp");
      $(".bg_cover.dbp").stop().animate({"opacity":0},400,function(){
        $(".bg_cover.dbp").remove();
       })
      $(window).off("resize.popupResize2")
  }

}//LayerPopup_type

function layerPopup3(){
   var $win = $(window);
   var $html = $('html, body');

     this.open = function (url,id,func,da2,pos){
            var $wrap = $('#wrap');
            if(func != ''){
              var callbacks = $.Callbacks();
              callbacks.add( func );
            }
            if(url != undefined){
                       $.ajax({
                          type:"GET",
                          url:url,
                          dataType:"html",
                          data : da2,
                           success : function(data) {
                              var cont ;
                              var $data = $(data);


                               if($("#"+id).length > 0){ $("#"+id).remove(); }
                                     newLayer();


                              function newLayer(){
                                  $("body").append( $("<div id="+id+" class='layerPopup'>") );
                                  $("#"+id).append($data)
                                    $("#"+id).imagesLoaded(function(){
                                      if(callbacks != undefined){
                                        callbacks.fire("#"+id, pos);
                                      }

                                        $("#"+id).bPopup({
                                          closeClass : "b-close",
                                          onClose: function(){
                                            $("#"+id).remove();
                                          }
                                          //modalClose : false
                                        });

                                    });

                              }

                          },
                           complete : function(data) {
                           },error : function(xhr, status, error) {

                           }
                      })

            }else{//if
                alert('');
            }
     };//open
     this.close = function (id){
      $("#"+id).close();
      //$("#"+id).remove();
     };//close


}//layerPopup3

window.layerPopup3  = new layerPopup3();




function stelra(obj,t,w){
        if(isie8 || isie7 || isie6 || Modernizr.touch){return};
        var WinWdith = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
        var o = $(obj),
              win = $(window),
              doc = $(document),
              viewport = win.height(),
              winTop = t,
              mobile = w
              body = (navigator.userAgent.indexOf('AppleWebKit') !== -1) ? $('body') : $('html');
              if(mobile == undefined){mobile = 1024};
              o.each(function(index){
                var $obj = $(this);
                var objOffsetTop = $obj.offset().top;
                var objOffsetTopHeight = objOffsetTop + $obj.outerHeight();
                var offSetMargin = objOffsetTopHeight - winTop;
                if(objOffsetTop < viewport ){ offSetMargin = win.scrollTop();};
                if(offSetMargin  > -(viewport)){
                  var childFlag = $obj.find(".dmp-child").length > 0;

                         if(childFlag){
                            var $c = $obj.find(".dmp-child");
                            if(mobile < WinWdith){
                                    $c.each(function(){
                                        var $ce = $(this);
                                        var direction = $ce.data("str-direction");
                                        var ratio = $ce.data("str-ratio");
                                        var flagTop = direction == "top";
                                        if(direction == "top"){
                                          if(offSetMargin > 0) { offSetMargin * -1 };
                                          TweenLite.to($ce, 0.2, {y:  -( offSetMargin / ratio) });
                                          }else if(direction == "bottom"){
                                          TweenLite.to($ce, 0.2, {y:  offSetMargin / ratio });
                                          }else if(direction == "left"){
                                          TweenLite.to($ce, 0.2, {x:offSetMargin / ratio});
                                          }else if(direction == "right"){
                                          TweenLite.to($ce, 0.2, {x:-(offSetMargin / ratio)});
                                          }
                                    });
                            }else{/*mobile*/
                              $c.each(function(){
                                    var $ce = $(this);
                                    $ce.css("transform","");
                                });
                            }/*mobile*/
                        }/*childFlag*/

      }else{
      };
    });//each
  };//stelra



function offSetcheck(obj , top){
    if(isie8 || isie7 || Modernizr.touch){return};

    var WinWdith = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
    var widthMobile = 1024
    var self = {
        step: 55,
        speed: 400,
        ease: "swing"
    }
    var o = $(obj),
          win = $(window),
          doc = $(document),
          step = self.step,
          speed = self.speed,
          viewport = win.height(),
          body = (navigator.userAgent.indexOf('AppleWebKit') !== -1) ? $('body') : $('html'),
          wheel = false;



    o.each(function(index){
      var $this = $(this);
      var antTop = $this.offset().top;
      var direction = "top",
            margin =0,
            speed = 0.5,
            delay = 0,
            size = 50;
      if($this.data("os-direction") != undefined) direction = $this.data("os-direction");
      if($this.data("os-speed") != undefined) speed = $this.data("os-speed");
      if($this.data("os-margin") != undefined) margin = $this.data("os-margin");
      if($this.data("os-delay") != undefined) delay = $this.data("os-delay");
      if($this.data("os-size") != undefined)  size = $this.data("os-size");
      var startPoint = antTop + margin;
        if(WinWdith > widthMobile){
           if(startPoint > top){
              if(!offSetcheckFlag2[index]){
              }
              offSetcheckFlag2[index] = true;
            }else{
              if(offSetcheckFlag2[index]){
                  if(direction == "left"){
                    TweenLite.set($this, {x:size,opacity:0});
                    TweenLite.to($this, speed, {x:0,opacity:1,delay:delay});
                  }else if(direction == "top"){
                    TweenLite.set($this, {y:size,opacity:0});
                    TweenLite.to($this, speed, {y:0,opacity:1,delay:delay});
                  }else if(direction == "right"){
                    TweenLite.set($this, {x:-(size),opacity:0});
                    TweenLite.to($this, speed, {x:0,opacity:1,delay:delay});
                  }else if(direction == "headline"){
                    $this.css({"overflow":"hidden"});
                    TweenLite.set($this.find("img"), {y:-(size)});
                    TweenLite.to($this.find("img"), speed, {y:0,delay:delay});
                  }else if(direction == "headlineTop"){
                    $this.css({"overflow":"hidden"});
                    TweenLite.set($this.find("img"), {y:size});
                    TweenLite.to($this.find("img"), speed, {y:0,delay:delay});
                  }else if(direction == "headlineLeft"){
                    $this.css({"overflow":"hidden"});
                    TweenLite.set($this.find("img"), {x:size});
                    TweenLite.to($this.find("img"), speed, {x:0,delay:delay});
                  }else if(direction == "headlineRight"){
                    $this.css({"overflow":"hidden"});
                    TweenLite.set($this.find("img"), {x:-(size)});
                    TweenLite.to($this.find("img"), speed, {x:0,delay:delay});
                  }

              }//if
              offSetcheckFlag2[index] = false;
            }//startPoint


        }else{ //WinWdith > widthMobile

            $this.css({"transform":"","opacity":""});

        } //WinWdith > widthMobile


    });//each
  }//offSetcheck




var W3CDOM = (document.createElement && document.getElementsByTagName);

function initFileUploads() {
   if (!W3CDOM) {
    return;
    }
   var fakeFileUpload = document.createElement('div');
   fakeFileUpload.className = 'fakefile';
   var image = document.createElement('img');
   image.src='/kor/images/common/btn_file_off.jpg';
   // fakeFileUpload.appendChild(image);
   var inputbox = document.createElement('input');
   $(inputbox)
   // .attr("placeholder","선택된 파일이 없습니다.")
   .addClass("ffile").prop('disabled', true);
    fakeFileUpload.appendChild(inputbox);

   var x = document.getElementsByTagName('input');
   for (var i=0;i<x.length;i++) {
    if (x[i].type != 'file') continue;
    if (x[i].parentNode.className != 'fileinputs') continue;
    x[i].className = 'file';
    var clone = fakeFileUpload.cloneNode(true);
    x[i].parentNode.appendChild(clone);
    x[i].relatedElement = clone.getElementsByTagName('input')[0];
    x[i].onchange = x[i].onmouseout = function () {
     this.relatedElement.value = this.value;
    }
   }
  // $(".fileinputs").each(function(){
  //   if($(this).data("src") != undefined) $(this).find(".fakefile > img").attr("src",$(this).data("src"));
  //   $(this).on("mouseenter mouseleave" , function(e){
  //       if($(this).find(".fakefile > img").length > 0){
  //           if(e.type == "mouseenter"){
  //             $(this).find(".fakefile > img").imgConversion(true);
  //           }else{
  //             $(this).find(".fakefile > img").imgConversion(false);
  //           }
  //       }


  //   });

  // });

    $(".fileinputs").each(function(){
    $(this).on("focusin focusout" , function(e){
            if(e.type == "focusin"){
              $(this).find(".fakefile > input").addClass("on");
            }else{
              $(this).find(".fakefile > input").removeClass("on");
            }
    });

  });

}//initFileUploads


/*!
  jQuery word-break keep-all Plugin
  ver 1.3.0

  Copyright 2012, Ahn Hyoung-woo (mytory@gmail.com)
  Dual licensed under the MIT or GPL Version 2 licenses.
  http://jquery.org/license

  https://github.com/mytory/jquery-word-break-keep-all
  http://mytory.co.kr/archives/2801

  Date: 2013-09-04
 */jQuery.fn.wordBreakKeepAll=function(option){var is_there_end_angle_bracket=function(str){return str.lastIndexOf('<')<str.lastIndexOf('>');};var is_there_start_angle_bracket=function(str){return str.lastIndexOf('>')<str.lastIndexOf('<');};var is_there_no_angle_bracket=function(str){return str.lastIndexOf('>')==str.lastIndexOf('<');};var defaultOption={OffForIE:false,useCSSonIE:true};var opt=$.extend(defaultOption,option);if(/MSIE/.test(navigator.userAgent)&&opt.OffForIE==false&&opt.useCSSonIE==true){var addWordBreakKeepAll=function(obj){$(obj).css({'word-break':'keep-all','word-wrap':'break-word'});if($(obj).css('display')=='inline'){$(obj).css('display','block');}};}else if(!/MSIE/.test(navigator.userAgent)||/MSIE/.test(navigator.userAgent)&&opt.OffForIE==false&&opt.useCSSonIE==false){var addWordBreakKeepAll=function(obj){var html=$(obj).html();html=html.replace(/(\r\n|\n|\r)/gm,' 竊껓펵竊딉폖짠 ');var textArr=html.split(' ');textArr=textArr.filter(function(e){return e;});$(obj).text('');var skip=false;var full_str='';for(var i=0,j=textArr.length;i<j;i++){var str=textArr[i];if(skip==false&&is_there_no_angle_bracket(str)&&str.indexOf('竊껓펵竊딉폖짠')==-1){full_str+='<span style="white-space: nowrap">'+str+'</span> ';}else{full_str+=str+' ';}
if(is_there_start_angle_bracket(str)){skip=true;}
if(is_there_end_angle_bracket(str)){skip=false;}};$(obj).html(full_str.replace(/竊껓펵竊딉폖짠/g,"\n"));};}
return this.each(function(){addWordBreakKeepAll(this);});};
/*! modernizr 3.3.1 (Custom Build) | MIT *
 * https://modernizr.com/download/?-audio-audioloop-audiopreload-backgroundblendmode-backgroundcliptext-backgroundsize-bgpositionxy-bgrepeatspace_bgrepeatround-bgsizecover-borderradius-boxshadow-boxsizing-canvas-canvasblending-canvaswinding-checked-cssanimations-csscalc-csscolumns-cssescape-cssexunit-cssfilters-cssgradients-cubicbezierrange-displaytable-ellipsis-flash-fullscreen-hashchange-hiddenscroll-history-htmlimports-ie8compat-json-lastchild-mediaqueries-rgba-svg-todataurljpeg_todataurlpng_todataurlwebp-touchevents-video-webaudio-hasevent-setclasses !*/
!function(A,e,t){function n(A,e){return typeof A===e}function a(){var A,e,t,a,w,o,i;for(var D in Q)if(Q.hasOwnProperty(D)){if(A=[],e=Q[D],e.name&&(A.push(e.name.toLowerCase()),e.options&&e.options.aliases&&e.options.aliases.length))for(t=0;t<e.options.aliases.length;t++)A.push(e.options.aliases[t].toLowerCase());for(a=n(e.fn,"function")?e.fn():e.fn,w=0;w<A.length;w++)o=A[w],i=o.split("."),1===i.length?Modernizr[i[0]]=a:(!Modernizr[i[0]]||Modernizr[i[0]]instanceof Boolean||(Modernizr[i[0]]=new Boolean(Modernizr[i[0]])),Modernizr[i[0]][i[1]]=a),E.push((a?"":"no-")+i.join("-"))}}function w(A){var e=C.className,t=Modernizr._config.classPrefix||"";if(m&&(e=e.baseVal),Modernizr._config.enableJSClass){var n=new RegExp("(^|\\s)"+t+"no-js(\\s|$)");e=e.replace(n,"$1"+t+"js$2")}Modernizr._config.enableClasses&&(e+=" "+t+A.join(" "+t),m?C.className.baseVal=e:C.className=e)}function o(){return"function"!=typeof e.createElement?e.createElement(arguments[0]):m?e.createElementNS.call(e,"http://www.w3.org/2000/svg",arguments[0]):e.createElement.apply(e,arguments)}function i(){var A=e.body;return A||(A=o(m?"svg":"body"),A.fake=!0),A}function D(A,e){if("object"==typeof A)for(var t in A)b(A,t)&&D(t,A[t]);else{A=A.toLowerCase();var n=A.split("."),a=Modernizr[n[0]];if(2==n.length&&(a=a[n[1]]),"undefined"!=typeof a)return Modernizr;e="function"==typeof e?e():e,1==n.length?Modernizr[n[0]]=e:(!Modernizr[n[0]]||Modernizr[n[0]]instanceof Boolean||(Modernizr[n[0]]=new Boolean(Modernizr[n[0]])),Modernizr[n[0]][n[1]]=e),w([(e&&0!=e?"":"no-")+n.join("-")]),Modernizr._trigger(A,e)}return Modernizr}function r(A){return A.replace(/([a-z])-([a-z])/g,function(A,e,t){return e+t.toUpperCase()}).replace(/^-/,"")}function d(A,t,n,a){var w,D,r,d,P="modernizr",s=o("div"),l=i();if(parseInt(n,10))for(;n--;)r=o("div"),r.id=a?a[n]:P+(n+1),s.appendChild(r);return w=o("style"),w.type="text/css",w.id="s"+P,(l.fake?l:s).appendChild(w),l.appendChild(s),w.styleSheet?w.styleSheet.cssText=A:w.appendChild(e.createTextNode(A)),s.id=P,l.fake&&(l.style.background="",l.style.overflow="hidden",d=C.style.overflow,C.style.overflow="hidden",C.appendChild(l)),D=t(s,A),l.fake?(l.parentNode.removeChild(l),C.style.overflow=d,C.offsetHeight):s.parentNode.removeChild(s),!!D}function P(A,e){return!!~(""+A).indexOf(e)}function s(A,e){return function(){return A.apply(e,arguments)}}function l(A,e,t){var a;for(var w in A)if(A[w]in e)return t===!1?A[w]:(a=e[A[w]],n(a,"function")?s(a,t||e):a);return!1}function u(A){return A.replace(/([A-Z])/g,function(A,e){return"-"+e.toLowerCase()}).replace(/^ms-/,"-ms-")}function c(e,n){var a=e.length;if("CSS"in A&&"supports"in A.CSS){for(;a--;)if(A.CSS.supports(u(e[a]),n))return!0;return!1}if("CSSSupportsRule"in A){for(var w=[];a--;)w.push("("+u(e[a])+":"+n+")");return w=w.join(" or "),d("@supports ("+w+") { #modernizr { position: absolute; } }",function(A){return"absolute"==getComputedStyle(A,null).position})}return t}function f(A,e,a,w){function i(){d&&(delete z.style,delete z.modElem)}if(w=n(w,"undefined")?!1:w,!n(a,"undefined")){var D=c(A,a);if(!n(D,"undefined"))return D}for(var d,s,l,u,f,B=["modernizr","tspan","samp"];!z.style&&B.length;)d=!0,z.modElem=o(B.shift()),z.style=z.modElem.style;for(l=A.length,s=0;l>s;s++)if(u=A[s],f=z.style[u],P(u,"-")&&(u=r(u)),z.style[u]!==t){if(w||n(a,"undefined"))return i(),"pfx"==e?u:!0;try{z.style[u]=a}catch(g){}if(z.style[u]!=f)return i(),"pfx"==e?u:!0}return i(),!1}function B(A,e,t,a,w){var o=A.charAt(0).toUpperCase()+A.slice(1),i=(A+" "+x.join(o+" ")+o).split(" ");return n(e,"string")||n(e,"undefined")?f(i,e,a,w):(i=(A+" "+Z.join(o+" ")+o).split(" "),l(i,e,t))}function g(A,e,n){return B(A,t,t,e,n)}var E=[],Q=[],p={_version:"3.3.1",_config:{classPrefix:"",enableClasses:!0,enableJSClass:!0,usePrefixes:!0},_q:[],on:function(A,e){var t=this;setTimeout(function(){e(t[A])},0)},addTest:function(A,e,t){Q.push({name:A,fn:e,options:t})},addAsyncTest:function(A){Q.push({name:null,fn:A})}},Modernizr=function(){};Modernizr.prototype=p,Modernizr=new Modernizr,Modernizr.addTest("history",function(){var e=navigator.userAgent;return-1===e.indexOf("Android 2.")&&-1===e.indexOf("Android 4.0")||-1===e.indexOf("Mobile Safari")||-1!==e.indexOf("Chrome")||-1!==e.indexOf("Windows Phone")?A.history&&"pushState"in A.history:!1}),Modernizr.addTest("ie8compat",!A.addEventListener&&!!e.documentMode&&7===e.documentMode),Modernizr.addTest("json","JSON"in A&&"parse"in JSON&&"stringify"in JSON),Modernizr.addTest("svg",!!e.createElementNS&&!!e.createElementNS("http://www.w3.org/2000/svg","svg").createSVGRect),Modernizr.addTest("webaudio",function(){var e="webkitAudioContext"in A,t="AudioContext"in A;return Modernizr._config.usePrefixes?e||t:t});var v=A.CSS;Modernizr.addTest("cssescape",v?"function"==typeof v.escape:!1);var C=e.documentElement,m="svg"===C.nodeName.toLowerCase(),I=function(){function A(A,e){var a;return A?(e&&"string"!=typeof e||(e=o(e||"div")),A="on"+A,a=A in e,!a&&n&&(e.setAttribute||(e=o("div")),e.setAttribute(A,""),a="function"==typeof e[A],e[A]!==t&&(e[A]=t),e.removeAttribute(A)),a):!1}var n=!("onblur"in e.documentElement);return A}();p.hasEvent=I,Modernizr.addTest("hashchange",function(){return I("hashchange",A)===!1?!1:e.documentMode===t||e.documentMode>7}),Modernizr.addTest("audio",function(){var A=o("audio"),e=!1;try{(e=!!A.canPlayType)&&(e=new Boolean(e),e.ogg=A.canPlayType('audio/ogg; codecs="vorbis"').replace(/^no$/,""),e.mp3=A.canPlayType('audio/mpeg; codecs="mp3"').replace(/^no$/,""),e.opus=A.canPlayType('audio/ogg; codecs="opus"')||A.canPlayType('audio/webm; codecs="opus"').replace(/^no$/,""),e.wav=A.canPlayType('audio/wav; codecs="1"').replace(/^no$/,""),e.m4a=(A.canPlayType("audio/x-m4a;")||A.canPlayType("audio/aac;")).replace(/^no$/,""))}catch(t){}return e}),Modernizr.addTest("canvas",function(){var A=o("canvas");return!(!A.getContext||!A.getContext("2d"))}),Modernizr.addTest("video",function(){var A=o("video"),e=!1;try{(e=!!A.canPlayType)&&(e=new Boolean(e),e.ogg=A.canPlayType('video/ogg; codecs="theora"').replace(/^no$/,""),e.h264=A.canPlayType('video/mp4; codecs="avc1.42E01E"').replace(/^no$/,""),e.webm=A.canPlayType('video/webm; codecs="vp8, vorbis"').replace(/^no$/,""),e.vp9=A.canPlayType('video/webm; codecs="vp9"').replace(/^no$/,""),e.hls=A.canPlayType('application/x-mpegURL; codecs="avc1.42E01E"').replace(/^no$/,""))}catch(t){}return e}),Modernizr.addTest("audioloop","loop"in o("audio")),Modernizr.addTest("canvasblending",function(){if(Modernizr.canvas===!1)return!1;var A=o("canvas").getContext("2d");try{A.globalCompositeOperation="screen"}catch(e){}return"screen"===A.globalCompositeOperation});var h=o("canvas");Modernizr.addTest("todataurljpeg",function(){return!!Modernizr.canvas&&0===h.toDataURL("image/jpeg").indexOf("data:image/jpeg")}),Modernizr.addTest("todataurlpng",function(){return!!Modernizr.canvas&&0===h.toDataURL("image/png").indexOf("data:image/png")}),Modernizr.addTest("todataurlwebp",function(){var A=!1;try{A=!!Modernizr.canvas&&0===h.toDataURL("image/webp").indexOf("data:image/webp")}catch(e){}return A}),Modernizr.addTest("canvaswinding",function(){if(Modernizr.canvas===!1)return!1;var A=o("canvas").getContext("2d");return A.rect(0,0,10,10),A.rect(2,2,6,6),A.isPointInPath(5,5,"evenodd")===!1}),Modernizr.addTest("rgba",function(){var A=o("a").style;return A.cssText="background-color:rgba(150,255,150,.5)",(""+A.backgroundColor).indexOf("rgba")>-1});var y=p._config.usePrefixes?" -webkit- -moz- -o- -ms- ".split(" "):["",""];p._prefixes=y,Modernizr.addTest("csscalc",function(){var A="width:",e="calc(10px);",t=o("a");return t.style.cssText=A+y.join(e+A),!!t.style.length}),Modernizr.addTest("cubicbezierrange",function(){var A=o("a");return A.style.cssText=y.join("transition-timing-function:cubic-bezier(1,0,0,1.1); "),!!A.style.length}),Modernizr.addTest("cssgradients",function(){for(var A,e="background-image:",t="gradient(linear,left top,right bottom,from(#9f9),to(white));",n="",a=0,w=y.length-1;w>a;a++)A=0===a?"to ":"",n+=e+y[a]+"linear-gradient("+A+"left top, #9f9, white);";Modernizr._config.usePrefixes&&(n+=e+"-webkit-"+t);var i=o("a"),D=i.style;return D.cssText=n,(""+D.backgroundImage).indexOf("gradient")>-1});var V={elem:o("modernizr")};Modernizr._q.push(function(){delete V.elem}),Modernizr.addTest("cssexunit",function(){var A,e=V.elem.style;try{e.fontSize="3ex",A=-1!==e.fontSize.indexOf("ex")}catch(t){A=!1}return A});var q="CSS"in A&&"supports"in A.CSS,S="supportsCSS"in A;Modernizr.addTest("supports",q||S);var b;!function(){var A={}.hasOwnProperty;b=n(A,"undefined")||n(A.call,"undefined")?function(A,e){return e in A&&n(A.constructor.prototype[e],"undefined")}:function(e,t){return A.call(e,t)}}(),p._l={},p.on=function(A,e){this._l[A]||(this._l[A]=[]),this._l[A].push(e),Modernizr.hasOwnProperty(A)&&setTimeout(function(){Modernizr._trigger(A,Modernizr[A])},0)},p._trigger=function(A,e){if(this._l[A]){var t=this._l[A];setTimeout(function(){var A,n;for(A=0;A<t.length;A++)(n=t[A])(e)},0),delete this._l[A]}},Modernizr._q.push(function(){p.addTest=D}),Modernizr.addAsyncTest(function(){var t,n,a=function(A){C.contains(A)||C.appendChild(A)},w=function(A){A.fake&&A.parentNode&&A.parentNode.removeChild(A)},r=function(A,e){var t=!!A;if(t&&(t=new Boolean(t),t.blocked="blocked"===A),D("flash",function(){return t}),e&&u.contains(e)){for(;e.parentNode!==u;)e=e.parentNode;u.removeChild(e)}};try{n="ActiveXObject"in A&&"Pan"in new A.ActiveXObject("ShockwaveFlash.ShockwaveFlash")}catch(d){}if(t=!("plugins"in navigator&&"Shockwave Flash"in navigator.plugins||n),t||m)r(!1);else{var P,s,l=o("embed"),u=i();if(l.type="application/x-shockwave-flash",u.appendChild(l),!("Pan"in l||n))return a(u),r("blocked",l),void w(u);P=function(){return a(u),C.contains(u)?(C.contains(l)?(s=l.style.cssText,""!==s?r("blocked",l):r(!0,l)):r("blocked"),void w(u)):(u=e.body||u,l=o("embed"),l.type="application/x-shockwave-flash",u.appendChild(l),setTimeout(P,1e3))},setTimeout(P,10)}}),D("htmlimports","import"in o("link")),Modernizr.addAsyncTest(function(){function A(n){clearTimeout(e);var w=n!==t&&"loadeddata"===n.type?!0:!1;a.removeEventListener("loadeddata",A,!1),D("audiopreload",w),a.parentNode.removeChild(a)}var e,n=300,a=o("audio"),w=a.style;if(!(Modernizr.audio&&"preload"in a))return void D("audiopreload",!1);w.position="absolute",w.height=0,w.width=0;try{if(Modernizr.audio.mp3)a.src="data:audio/mpeg;base64,//MUxAAB6AXgAAAAAPP+c6nf//yi/6f3//MUxAMAAAIAAAjEcH//0fTX6C9Lf//0//MUxA4BeAIAAAAAAKX2/6zv//+IlR4f//MUxBMCMAH8AAAAABYWalVMQU1FMy45//MUxBUB0AH0AAAAADkuM1VVVVVVVVVV//MUxBgBUATowAAAAFVVVVVVVVVVVVVV";else if(Modernizr.audio.m4a)a.src="data:audio/x-m4a;base64,AAAAGGZ0eXBNNEEgAAACAGlzb21pc28yAAAACGZyZWUAAAAfbWRhdN4EAABsaWJmYWFjIDEuMjgAAAFoAQBHAAACiG1vb3YAAABsbXZoZAAAAAB8JbCAfCWwgAAAA+gAAAAYAAEAAAEAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAG0dHJhawAAAFx0a2hkAAAAD3wlsIB8JbCAAAAAAQAAAAAAAAAYAAAAAAAAAAAAAAAAAQAAAAABAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAABUG1kaWEAAAAgbWRoZAAAAAB8JbCAfCWwgAAArEQAAAQAVcQAAAAAAC1oZGxyAAAAAAAAAABzb3VuAAAAAAAAAAAAAAAAU291bmRIYW5kbGVyAAAAAPttaW5mAAAAEHNtaGQAAAAAAAAAAAAAACRkaW5mAAAAHGRyZWYAAAAAAAAAAQAAAAx1cmwgAAAAAQAAAL9zdGJsAAAAW3N0c2QAAAAAAAAAAQAAAEttcDRhAAAAAAAAAAEAAAAAAAAAAAACABAAAAAArEQAAAAAACdlc2RzAAAAAAMZAAEABBFAFQAAAAABftAAAAAABQISCAYBAgAAABhzdHRzAAAAAAAAAAEAAAABAAAEAAAAABxzdHNjAAAAAAAAAAEAAAABAAAAAQAAAAEAAAAUc3RzegAAAAAAAAAXAAAAAQAAABRzdGNvAAAAAAAAAAEAAAAoAAAAYHVkdGEAAABYbWV0YQAAAAAAAAAhaGRscgAAAAAAAAAAbWRpcmFwcGwAAAAAAAAAAAAAAAAraWxzdAAAACOpdG9vAAAAG2RhdGEAAAABAAAAAExhdmY1Mi42NC4y";else if(Modernizr.audio.ogg)a.src="data:audio/ogg;base64,T2dnUwACAAAAAAAAAAD/QwAAAAAAAM2LVKsBHgF2b3JiaXMAAAAAAUSsAAAAAAAAgLsAAAAAAAC4AU9nZ1MAAAAAAAAAAAAA/0MAAAEAAADmvOe6Dy3/////////////////MgN2b3JiaXMdAAAAWGlwaC5PcmcgbGliVm9yYmlzIEkgMjAwNzA2MjIAAAAAAQV2b3JiaXMfQkNWAQAAAQAYY1QpRplS0kqJGXOUMUaZYpJKiaWEFkJInXMUU6k515xrrLm1IIQQGlNQKQWZUo5SaRljkCkFmVIQS0kldBI6J51jEFtJwdaYa4tBthyEDZpSTCnElFKKQggZU4wpxZRSSkIHJXQOOuYcU45KKEG4nHOrtZaWY4updJJK5yRkTEJIKYWSSgelU05CSDWW1lIpHXNSUmpB6CCEEEK2IIQNgtCQVQAAAQDAQBAasgoAUAAAEIqhGIoChIasAgAyAAAEoCiO4iiOIzmSY0kWEBqyCgAAAgAQAADAcBRJkRTJsSRL0ixL00RRVX3VNlVV9nVd13Vd13UgNGQVAAABAEBIp5mlGiDCDGQYCA1ZBQAgAAAARijCEANCQ1YBAAABAABiKDmIJrTmfHOOg2Y5aCrF5nRwItXmSW4q5uacc845J5tzxjjnnHOKcmYxaCa05pxzEoNmKWgmtOacc57E5kFrqrTmnHPGOaeDcUYY55xzmrTmQWo21uaccxa0pjlqLsXmnHMi5eZJbS7V5pxzzjnnnHPOOeecc6oXp3NwTjjnnHOi9uZabkIX55xzPhmne3NCOOecc84555xzzjnnnHOC0JBVAAAQAABBGDaGcacgSJ+jgRhFiGnIpAfdo8MkaAxyCqlHo6ORUuoglFTGSSmdIDRkFQAACAAAIYQUUkghhRRSSCGFFFKIIYYYYsgpp5yCCiqppKKKMsoss8wyyyyzzDLrsLPOOuwwxBBDDK20EktNtdVYY62555xrDtJaaa211koppZRSSikIDVkFAIAAABAIGWSQQUYhhRRSiCGmnHLKKaigAkJDVgEAgAAAAgAAADzJc0RHdERHdERHdERHdETHczxHlERJlERJtEzL1ExPFVXVlV1b1mXd9m1hF3bd93Xf93Xj14VhWZZlWZZlWZZlWZZlWZZlWYLQkFUAAAgAAIAQQgghhRRSSCGlGGPMMeegk1BCIDRkFQAACAAgAAAAwFEcxXEkR3IkyZIsSZM0S7M8zdM8TfREURRN01RFV3RF3bRF2ZRN13RN2XRVWbVdWbZt2dZtX5Zt3/d93/d93/d93/d93/d1HQgNWQUASAAA6EiOpEiKpEiO4ziSJAGhIasAABkAAAEAKIqjOI7jSJIkSZakSZ7lWaJmaqZneqqoAqEhqwAAQAAAAQAAAAAAKJriKabiKaLiOaIjSqJlWqKmaq4om7Lruq7ruq7ruq7ruq7ruq7ruq7ruq7ruq7ruq7ruq7ruq7rui4QGrIKAJAAANCRHMmRHEmRFEmRHMkBQkNWAQAyAAACAHAMx5AUybEsS9M8zdM8TfRET/RMTxVd0QVCQ1YBAIAAAAIAAAAAADAkw1IsR3M0SZRUS7VUTbVUSxVVT1VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVTVN0zRNIDRkJQAABADAYo3B5SAhJSXl3hDCEJOeMSYhtV4hBJGS3jEGFYOeMqIMct5C4xCDHggNWREARAEAAMYgxxBzyDlHqZMSOeeodJQa5xyljlJnKcWYYs0oldhSrI1zjlJHraOUYiwtdpRSjanGAgAAAhwAAAIshEJDVgQAUQAAhDFIKaQUYow5p5xDjCnnmHOGMeYcc44556B0UirnnHROSsQYc445p5xzUjonlXNOSiehAACAAAcAgAALodCQFQFAnACAQZI8T/I0UZQ0TxRFU3RdUTRd1/I81fRMU1U90VRVU1Vt2VRVWZY8zzQ901RVzzRV1VRVWTZVVZZFVdVt03V123RV3ZZt2/ddWxZ2UVVt3VRd2zdV1/Zd2fZ9WdZ1Y/I8VfVM03U903Rl1XVtW3VdXfdMU5ZN15Vl03Vt25VlXXdl2fc103Rd01Vl2XRd2XZlV7ddWfZ903WF35VlX1dlWRh2XfeFW9eV5XRd3VdlVzdWWfZ9W9eF4dZ1YZk8T1U903RdzzRdV3VdX1dd19Y105Rl03Vt2VRdWXZl2fddV9Z1zzRl2XRd2zZdV5ZdWfZ9V5Z13XRdX1dlWfhVV/Z1WdeV4dZt4Tdd1/dVWfaFV5Z14dZ1Ybl1XRg+VfV9U3aF4XRl39eF31luXTiW0XV9YZVt4VhlWTl+4ViW3feVZXRdX1ht2RhWWRaGX/id5fZ943h1XRlu3efMuu8Mx++k+8rT1W1jmX3dWWZfd47hGDq/8OOpqq+brisMpywLv+3rxrP7vrKMruv7qiwLvyrbwrHrvvP8vrAso+z6wmrLwrDatjHcvm4sv3Acy2vryjHrvlG2dXxfeArD83R1XXlmXcf2dXTjRzh+ygAAgAEHAIAAE8pAoSErAoA4AQCPJImiZFmiKFmWKIqm6LqiaLqupGmmqWmeaVqaZ5qmaaqyKZquLGmaaVqeZpqap5mmaJqua5qmrIqmKcumasqyaZqy7LqybbuubNuiacqyaZqybJqmLLuyq9uu7Oq6pFmmqXmeaWqeZ5qmasqyaZquq3meanqeaKqeKKqqaqqqraqqLFueZ5qa6KmmJ4qqaqqmrZqqKsumqtqyaaq2bKqqbbuq7Pqybeu6aaqybaqmLZuqatuu7OqyLNu6L2maaWqeZ5qa55mmaZqybJqqK1uep5qeKKqq5ommaqqqLJumqsqW55mqJ4qq6omea5qqKsumatqqaZq2bKqqLZumKsuubfu+68qybqqqbJuqauumasqybMu+78qq7oqmKcumqtqyaaqyLduy78uyrPuiacqyaaqybaqqLsuybRuzbPu6aJqybaqmLZuqKtuyLfu6LNu678qub6uqrOuyLfu67vqucOu6MLyybPuqrPq6K9u6b+sy2/Z9RNOUZVM1bdtUVVl2Zdn2Zdv2fdE0bVtVVVs2TdW2ZVn2fVm2bWE0Tdk2VVXWTdW0bVmWbWG2ZeF2Zdm3ZVv2ddeVdV/XfePXZd3murLty7Kt+6qr+rbu+8Jw667wCgAAGHAAAAgwoQwUGrISAIgCAACMYYwxCI1SzjkHoVHKOecgZM5BCCGVzDkIIZSSOQehlJQy5yCUklIIoZSUWgshlJRSawUAABQ4AAAE2KApsThAoSErAYBUAACD41iW55miatqyY0meJ4qqqaq27UiW54miaaqqbVueJ4qmqaqu6+ua54miaaqq6+q6aJqmqaqu67q6Lpqiqaqq67qyrpumqqquK7uy7Oumqqqq68quLPvCqrquK8uybevCsKqu68qybNu2b9y6ruu+7/vCka3rui78wjEMRwEA4AkOAEAFNqyOcFI0FlhoyEoAIAMAgDAGIYMQQgYhhJBSSiGllBIAADDgAAAQYEIZKDRkRQAQJwAAGEMppJRSSimllFJKKaWUUkoppZRSSimllFJKKaWUUkgppZRSSimllFJKKaWUUkoppZRSSimllFJKKaWUUkoppZRSSimllFJKKaWUUkqppJRSSimllFJKKaWUUkoppZRSSimllFJKKaWUUkoppZRSSimllFJKKaWUUkoppZRSSimllFJKKaWUUkoppZRSSimllFJKKaWUUkoppZRSSimllFJKKaWUUkoppZRSSimllFJKKaWUUkoppZRSSimllFJKKaWUUkoppZRSSimllFJKKaWUUkoppZRSSimllFJKKaWUUkoppZRSSimllFJKKaWUUkoppZRSSimllFJKKaWUUkoppZRSSimllFJKKaWUUkoppZRSSimllFJKKaWUUkoppZRSSimllFJKKaWUUkoplVJKKaWUUkoppZRSSimllFJKKaWUUkoppZRSSimllFJKKaWUUkoppZRSSimllFJKKaWUUkoppZRSSimllFJKKaWUUkoppZRSSimllFJKKaWUUkoppZRSCgCQinAAkHowoQwUGrISAEgFAACMUUopxpyDEDHmGGPQSSgpYsw5xhyUklLlHIQQUmktt8o5CCGk1FJtmXNSWosx5hgz56SkFFvNOYdSUoux5ppr7qS0VmuuNedaWqs115xzzbm0FmuuOdecc8sx15xzzjnnGHPOOeecc84FAOA0OACAHtiwOsJJ0VhgoSErAYBUAAACGaUYc8456BBSjDnnHIQQIoUYc845CCFUjDnnHHQQQqgYc8w5CCGEkDnnHIQQQgghcw466CCEEEIHHYQQQgihlM5BCCGEEEooIYQQQgghhBA6CCGEEEIIIYQQQgghhFJKCCGEEEIJoZRQAABggQMAQIANqyOcFI0FFhqyEgAAAgCAHJagUs6EQY5Bjw1BylEzDUJMOdGZYk5qMxVTkDkQnXQSGWpB2V4yCwAAgCAAIMAEEBggKPhCCIgxAABBiMwQCYVVsMCgDBoc5gHAA0SERACQmKBIu7iALgNc0MVdB0IIQhCCWBxAAQk4OOGGJ97whBucoFNU6iAAAAAAAAwA4AEA4KAAIiKaq7C4wMjQ2ODo8AgAAAAAABYA+AAAOD6AiIjmKiwuMDI0Njg6PAIAAAAAAAAAAICAgAAAAAAAQAAAAICAT2dnUwAE7AwAAAAAAAD/QwAAAgAAADuydfsFAQEBAQEACg4ODg==";else{if(!Modernizr.audio.wav)return void D("audiopreload",!1);a.src="data:audio/wav;base64,UklGRvwZAABXQVZFZm10IBAAAAABAAEARKwAAIhYAQACABAAZGF0YdgZAAAAAAEA/v8CAP//AAABAP////8DAPz/BAD9/wEAAAAAAAAAAAABAP7/AgD//wAAAQD//wAAAQD//wAAAQD+/wIA//8AAAAAAAD//wIA/v8BAAAA//8BAAAA//8BAP//AQAAAP//AQD//wEAAAD//wEA//8BAP//AQD//wEA//8BAP//AQD+/wMA/f8DAP3/AgD+/wIA/////wMA/f8CAP7/AgD+/wMA/f8CAP7/AgD//wAAAAAAAAAAAQD+/wIA/v8CAP7/AwD9/wIA/v8BAAEA/v8CAP7/AQAAAAAAAAD//wEAAAD//wIA/f8DAP7/AQD//wEAAAD//wEA//8CAP7/AQD//wIA/v8CAP7/AQAAAAAAAAD//wEAAAAAAAAA//8BAP//AgD9/wQA+/8FAPz/AgAAAP//AgD+/wEAAAD//wIA/v8CAP3/BAD8/wQA/P8DAP7/AwD8/wQA/P8DAP7/AQAAAAAA//8BAP//AgD+/wEAAAD//wIA/v8BAP//AQD//wEAAAD//wEA//8BAAAAAAAAAP//AgD+/wEAAAAAAAAAAAD//wEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP//AgD+/wIA/v8BAP//AQABAP7/AQD//wIA/v8CAP3/AwD/////AgD9/wMA/v8BAP//AQAAAP//AQD//wEA//8BAP//AAABAP//AAABAP//AQD//wAAAAACAP3/AwD9/wIA//8BAP//AQD//wEA//8BAP//AgD9/wMA/v8AAAIA/f8CAAAA/v8EAPv/BAD9/wIAAAD+/wQA+v8HAPr/BAD+/wEAAAD//wIA/f8EAPz/BAD7/wUA/P8EAPz/AwD+/wEAAAD//wEAAAAAAP//AgD8/wUA+/8FAPz/AwD9/wIA//8AAAEA/v8CAP//AQD//wAAAAABAP//AgD9/wMA/f8EAPz/AwD+/wAAAwD7/wUA/P8DAP7/AQAAAP//AgD+/wEAAQD+/wIA/v8BAAEA/v8CAP7/AQAAAP//AgD9/wMA/f8DAP7/AgD+/wEAAAAAAAEA//8AAAEA/v8DAP3/AgD//wEA//8BAP7/AwD9/wMA/v8BAP//AQAAAP//AgD9/wMA/v8BAP//AQAAAP//AgD+/wEAAQD+/wIA/////wIA//8AAAEA/f8DAP//AAABAP////8DAP3/AwD+/wEA//8BAP//AQAAAAAA//8BAP//AQD//wEA//8BAP//AAAAAAEA//8BAP7/AgD//wEA//8AAAAAAAAAAAAAAAD//wIA/v8BAAAA//8BAAEA/v8BAAAA//8DAPz/AwD+/wIA/v8CAP3/AwD+/wEAAAD//wEA//8BAAAA//8BAAAA/v8EAPv/BAD+/wAAAAABAP7/AgD//wAAAAABAP7/AgD//wAAAAAAAAAAAAABAP3/BAD8/wQA/f8BAAAAAAABAP7/AgD+/wIA/v8CAP7/AgD+/wIA/v8BAAAAAAD//wIA/f8DAP7/AAABAP//AAACAPz/BAD9/wIA//8AAP//AwD9/wMA/P8EAP3/AwD9/wIA//8BAP//AQD+/wMA/f8DAP7/AAABAP//AQAAAP//AQD//wIA/f8DAP7/AQAAAP//AQAAAAAA//8CAP7/AQABAP7/AgD+/wEAAQD+/wIA/v8CAP////8CAP7/AgD//wAAAAABAP7/AwD9/wIAAAD+/wMA/f8CAP//AQD+/wMA/f8CAP//AAACAPz/BQD6/wUA/v///wIA/v8CAP3/BAD7/wYA+v8FAPz/AwD/////AgD+/wEAAAD//wEAAAD//wIA/f8DAP7/AQAAAP//AgD//wAA//8BAAAAAAAAAP//AQD//wEA//8AAAIA/f8DAP3/AgAAAP//AQD//wEA//8AAAEA//8BAP////8CAP//AAABAP3/BAD9/wIA/v8BAAEA//8BAP7/AgD//wEA//8AAAEA//8BAP//AAAAAAEA//8BAP7/AgD//wEA//8AAAAAAQD+/wIA/v8BAAAAAAD//wIA/v8BAAAAAAAAAAAAAQD+/wMA/f8CAP//AQD//wIA/f8DAP7/AQD//wEA//8CAP7/AAABAP7/AwD9/wMA/v8AAAEA//8BAAAAAAD//wIA/v8BAAAA//8CAP7/AgD+/wEA//8CAP7/AgD//wAAAAAAAAAAAQD//wEA/v8DAPz/BQD8/wIA//8AAAEAAAD//wEA//8BAP//AQAAAAAA//8BAP//AgD+/wEAAAAAAP//AQD+/wMA/////wEA/v8CAP//AQD//wEA//8AAAEA//8BAAAA/v8EAPz/AwD+/wEAAAAAAAAA//8CAP7/AQD//wEA//8BAP//AAABAP7/AwD9/wIA//8BAP//AQD//wEA//8AAAEA/v8EAPv/BAD9/wIA//8BAP7/AwD9/wIA//8AAAEA//8BAP//AQD//wAAAQD//wEAAAD+/wMA/v8AAAIA/f8DAP7/AQD//wAAAQD+/wMA/f8CAP//AAABAP7/AgD+/wMA/f8CAP7/AQABAP7/AgD+/wIA/v8CAP7/AwD8/wMA//8AAAEA//8AAAAAAAABAP//AQD//wAAAQD//wIA/f8DAP3/AwD+/wAAAgD9/wIA//8AAAEAAAD+/wMA/P8FAPv/BAD9/wIA//8AAP//AgD+/wIA/v8BAAAAAAD//wEAAAAAAP//AQD//wEA//8BAP//AAABAP7/AwD9/wIA//8BAP//AAABAP//AQD//wAAAQD//wEA//8BAP//AAABAAAA//8BAP7/AwD9/wMA/f8DAP3/AgD//wEA//8BAP7/AgD//wAAAgD8/wQA/f8CAP//AQD+/wMA/f8CAP7/AgD//wAAAAAAAAAAAAABAP7/AwD9/wIA/v8DAP3/AwD9/wIA/v8DAPz/BQD7/wQA/f8CAP7/AwD9/wMA/f8CAP//AQAAAP7/AwD+/wEA//8AAAEAAAAAAP//AAABAP//AQAAAP7/AwD9/wMA/f8CAP//AQD//wEA//8AAAIA/f8CAAAA//8BAAAA//8BAAAA/v8EAPv/BAD9/wIA//8AAAEA/v8CAP//AAABAP//AAABAP//AAABAP7/AwD8/wQA/f8CAAAA/v8DAP3/AwD9/wMA/v8BAAAA//8BAAAA//8CAP7/AQAAAAAAAAAAAAAA//8CAP7/AgD+/wIA/v8CAP7/AgD//wAAAQD//wAAAQD//wAAAQD//wAAAQD+/wIA//8AAAAAAQD+/wMA/f8CAP//AQD//wEA//8AAAEA/v8DAP3/AgD//wAAAAABAP7/AwD9/wIA//8AAAEA/v8DAP3/AgD//wAAAAABAP7/AwD8/wMA/v8CAP//AAD//wIA/v8CAP7/AQABAP7/AQAAAP//AgD/////AQD//wEAAAD//wEA/v8EAPv/BAD9/wMA/v8BAAAA//8BAAEA/P8GAPr/BQD8/wMA/v8BAAAA//8CAP7/AQABAP3/BAD7/wYA+/8EAPz/AwD//wEA//8BAP7/BAD8/wMA/v8AAAIA/v8BAAAA//8BAAAA//8BAAAA//8CAP3/AwD+/wAAAgD8/wUA/P8DAP7/AAABAAAAAAD//wEAAAD//wIA/f8DAP7/AQAAAAAAAAAAAAAAAAAAAAAAAAAAAAEA/f8EAPz/AwD/////AgD+/wIA/f8DAP7/AgD+/wEA//8CAP7/AQD//wEAAAAAAP//AQAAAP//AgD9/wMA/v8BAAAA//8BAP//AQAAAP//AAACAP3/BAD7/wQA/v8BAAAA//8BAP//AQAAAP//AQAAAP7/BAD7/wUA+/8EAP3/AgD//wAAAQD+/wIA//8AAAEA/v8CAP//AQD+/wEAAAAAAAAAAAD//wEA//8CAP3/AwD9/wIA//8AAAAAAAAAAAAA//8BAP//AgD+/wEA//8CAP7/AQAAAP//AgD/////AgD/////AgD+/wIA//8AAP//AQABAP7/AgD9/wMA/v8CAP////8BAAAAAAAAAAAA//8CAP////8DAPz/AwD+/wEAAAAAAP//AQD//wEAAAD//wEAAAD+/wQA+/8FAPz/AgAAAP//AgD9/wMA/v8BAAAAAAD//wEAAAD//wIA/v8BAAAAAAD//wIA/v8BAAAA//8BAAAA//8CAP7/AQD//wEA//8BAAAA//8BAP//AAABAP//AQAAAP7/AgD//wEA//8AAAAAAQD+/wMA/P8EAP7///8DAPz/BQD8/wEAAQD+/wMA/v8AAAEA//8BAP//AQD//wEA/v8CAP//AQD//wAAAAABAAAA//8BAP//AQAAAAAA//8BAP//AgD+/wAAAQD//wIA/f8CAP//AQAAAP7/AwD9/wMA/v8BAP//AAABAP//AgD9/wIA//8BAAAA//8BAAAA//8CAP3/AwD+/wEAAAD+/wQA/P8DAP7/AAACAP7/AQAAAP//AQAAAP//AQAAAP//AgD9/wIAAAD//wIA/f8DAP7/AQD//wEA//8CAP7/AQD//wAAAQD//wEA//8AAAAAAQD//wEAAAD9/wUA+/8FAPz/AgD//wAAAQD//wAAAQD+/wMA/f8BAAEA/v8CAP7/AgD+/wIA/v8BAAAAAAAAAAAAAAD//wIA/v8CAP////8CAP7/AgD+/wIA/v8CAP7/AQAAAP//AQAAAP//AQD//wAAAQD//wAAAQD+/wMA/f8CAAAA/v8DAP3/AgAAAP//AQAAAP7/AwD9/wMA/v8BAP//AQD//wEAAAD+/wMA/f8CAAAA/v8CAP//AAAAAAEA//8AAAEA/v8DAP3/AwD9/wIA//8BAP//AgD8/wQA/v8BAAAA/v8CAP//AQD//wAAAAAAAAEA/f8EAPz/BAD9/wIA//8AAAAAAAABAP//AAAAAAAAAAABAP3/BAD9/wIA/v8BAAEA//8AAAAA//8CAP7/AgD9/wQA+/8FAPv/BQD8/wMA/f8DAP3/AwD+/wAAAgD9/wMA/f8CAAAA/v8EAPv/BQD7/wUA/P8DAP///v8DAP3/BAD8/wMA/f8DAP7/AQD//wEAAAD//wEA/v8CAAAA/v8CAP7/AgD//wAAAAAAAAAAAQD+/wIA//8AAAEA/v8DAPz/BAD9/wIA//8AAP//AgD//wEA/v8BAAAAAQD//wAAAAAAAAEA//8AAAEA//8BAP//AAABAP//AQD+/wIA/v8DAPz/BAD8/wQA/f8BAAAAAQD+/wMA/P8DAP//AAAAAAAAAAD//wMA+/8FAP3/AQABAP3/BAD8/wMA/v8BAAAA//8CAP3/AwD+/wEAAQD9/wMA/f8EAPz/BAD7/wQA/v8BAAEA/f8DAP7/AQAAAP//AgD+/wEAAAD//wIA/v8CAP7/AgD+/wEAAQD//wEA/v8CAP7/BAD7/wQA/f8CAAAA//8AAAAAAAABAP//AQD+/wEAAQD+/wMA/f8BAAEA/v8DAPz/AwD/////AwD8/wQA/P8DAP7/AgD//wAA//8BAAAAAAAAAP//AgD+/wEAAAD//wIA/v8BAAAA//8CAP3/AgD//wAAAQD+/wIA/v8BAAAA//8CAP7/AgD+/wEA//8CAP3/BAD7/wQA/v8BAAAA//8AAAEAAAD//wIA/f8DAP7/AgD+/wIA/v8CAP7/AgD+/wEAAAAAAP//AgD9/wMA/v8BAP//AgD9/wMA/v8AAAEA//8BAP//AQD//wEA//8AAAEA/v8EAPz/AgD//wAAAQAAAP//AAABAP//AQD//wEAAAD//wEA//8BAAEA/f8DAP7/AQABAP3/AwD+/wIA/////wEAAAAAAAAAAAD//wIA/v8CAP////8CAP7/AgD//wAA//8CAP3/BAD9/wAAAgD9/wMA/v8BAP//AQAAAP//AQAAAP//AgD9/wMA/f8EAPz/AwD+/wEAAAAAAAAAAAD//wIA/f8EAP3/AAABAAAA//8CAP7/AQAAAP//AQAAAAAA//8BAP//AQAAAP//AQAAAP//AQAAAP//AgD9/wMA/v8BAP//AQAAAP//AQD//wIA/v8CAP3/BAD9/wEAAAD//wEAAQD9/wMA/f8CAAAA/v8DAP3/AgD//wAAAQD+/wIA/v8CAP7/AQAAAP//AgD+/wEAAAAAAP//AwD7/wUA/f8BAAEA/v8BAAEA/v8DAP3/AgD//wEA//8BAP//AQD//wEA//8CAP3/BAD7/wQA/////wIA/v8AAAIA/v8CAP3/BAD7/wUA/P8DAP3/AwD9/wMA/v8AAAIA/v8CAP7/AgD+/wIA//8AAAEA/v8CAP7/AgD//wAAAAD//wEAAAAAAAAA//8BAP7/BAD7/wUA/P8CAAAA//8BAP//AQAAAP//AgD9/wMA/v8BAAAA//8BAAAA//8CAP3/AwD+/wEA//8CAP3/AwD+/wAAAwD8/wIAAAD//wIA/////wIA/v8CAP7/AgD+/wEAAAAAAAAAAAAAAP//AgD+/wIA//8AAAAA//8CAP7/AgD+/wEA//8CAP3/AwD9/wMA/v8BAP7/AwD9/wMA/f8CAP//AQD+/wIA//8BAP//AQD+/wMA/v8BAAAA//8BAAAA//8CAP7/AQAAAP//AgD+/wIA/v8CAP//AAAAAAEA//8BAP//AAABAAAA//8BAP//AQD//wEA//8BAP//AQAAAP//AQD//wEAAAD//wIA/f8CAAAA//8BAAAA//8BAP//AAABAP//AQD//wAAAAAAAAEA/v8CAP//AQD//wAAAAABAP7/AwD9/wIAAAD+/wIA//8BAP//AgD9/wMA/f8DAP7/AgD+/wEAAAAAAAEA/v8CAP7/AgD//wAAAAAAAAAAAAAAAP//AgD/////AgD9/wQA/f8BAAAAAAAAAAEA/f8DAP////8DAP3/AQABAP7/AgD//wAAAQD+/wMA/f8CAP7/AQABAP7/AwD7/wYA+v8FAP3/AQABAP7/AgD+/wMA/f8CAP7/AwD+/wEA//8BAP//AQAAAP7/BQD5/wcA+v8FAPz/AwD+/wIA/v8BAAAA//8DAPv/BQD8/wMA/////wEAAAAAAAAAAAD//wIA/f8DAP7/AQAAAP//AQAAAP//AgD+/wIA/v8BAAEA/f8EAPz/AwD+/wEA//8CAP7/AQD//wEA//8CAP7/AQAAAP//AgD+/wEAAAAAAAAAAAAAAAAAAAD//wIA/f8EAPz/AwD+/wEA//8CAP7/AgD+/wEAAQD+/wEAAQD+/wIA/////wIA//8AAAAAAAAAAAAAAAD//wEAAAAAAP//AgD9/wMA/v8BAP//AQAAAP//AQD//wEA//8BAP//AQD//wEA//8BAP//AQAAAP7/AwD9/wMA/v8BAP7/AwD9/wMA/v8BAP//AAABAP//AQD//wAAAAABAP//AAAAAAAAAQD//wEA/v8CAAAA/v8EAPv/BAD9/wIAAAD+/wMA/P8DAP//AAAAAP//AQD//wIA/f8DAP3/AwD9/wMA/v8BAAAA//8BAAAA//8CAP3/AwD9/wQA+/8FAPv/BQD8/wMA/v8BAAAA//8BAP//AgD+/wEAAAD//wIA/v8BAAEA/f8DAP3/AgAAAP//AQD//wAAAQD//wEA//8BAP//AQD//wEA/v8DAP3/AgAAAP7/AwD9/wIAAAD//wEAAAD//wIA/f8DAP7/AgD9/wQA+/8FAPz/AgAAAP//AgD9/wIA//8BAP//AQD//wEA//8BAP//AQD//wIA/f8DAP3/AgD//wAAAQD+/wIA/v8BAAEA/v8CAP7/AgD+/wMA/P8DAP//AAABAP7/AQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEA/v8CAP3/BAD8/wMA/v8BAAAAAAD//wEAAAAAAAAAAAD//wEAAAAAAAAA//8BAP//AgD+/wEA//8CAP3/AwD9/wMA/f8EAPv/BAD+/wAAAQD//wEA//8BAP//AAABAP//AQD//wEAAAD//wEA//8BAP//AgD9/wMA/v8AAAIA/f8DAP7/AAACAP3/AwD+/wEA//8BAP//AQAAAP//AQAAAP7/AwD9/wMA/v8AAAEA//8BAP//AAAAAAEA//8AAAEA/v8CAP//AAAAAAEA/v8DAPz/BAD9/wEAAQD+/wEAAQD9/wQA/P8DAP7/AQAAAAAAAAAAAAAAAAAAAAAAAQD+/wIA/////wIA/v8BAAAA//8BAP//AQD//wEA//8BAAAA/v8EAPz/AwD///7/BAD8/wMA/////wIA/v8CAP////8CAP7/AgD+/wIA/v8CAP////8CAP7/AwD9/wIA/v8CAP//AAABAP7/AwD9/wEAAQD+/wMA/f8CAP//AAAAAAEA/v8DAPz/BAD9/wIA/v8CAP7/AgD//wAAAAD//wIA/v8CAP7/AQAAAAAA//8CAP7/AgD+/wIA/v8CAP7/AwD8/wUA+v8GAPv/AwD//wAAAAAAAAAA//8DAPv/BQD9/wAAAgD9/wMA/v8BAP//AQAAAP//AgD9/wMA/v8BAAAA//8BAAAAAAAAAP//AQAAAAAAAAD//wEA//8CAP3/AwD+/wAAAgD+/wEAAAD//wIA/v8CAP7/AgD/////AwD8/wUA/P8CAP//AQD//wIA/f8DAP3/AwD+/wAAAQD+/wMA/f8DAP3/AgD//wAAAQD//wEA//8BAP7/AwD+/wEA//8AAAEA//8CAPz/BAD9/wIA//8AAAEA/v8DAPz/BAD9/wIA//8AAAEA/v8CAP7/AgD//wEA/f8EAPz/BAD+////AgD//wAAAQD//wAAAQD//wEA//8BAP7/AwD+/wEA"}}catch(i){return void D("audiopreload",!1)}a.setAttribute("preload","auto"),a.style.cssText="display:none",C.appendChild(a),setTimeout(function(){a.addEventListener("loadeddata",A,!1),e=setTimeout(A,n)},0)});var M=p.testStyles=d;Modernizr.addTest("hiddenscroll",function(){return M("#modernizr {width:100px;height:100px;overflow:scroll}",function(A){return A.offsetWidth===A.clientWidth})}),Modernizr.addTest("touchevents",function(){var t;if("ontouchstart"in A||A.DocumentTouch&&e instanceof DocumentTouch)t=!0;else{var n=["@media (",y.join("touch-enabled),("),"heartz",")","{#modernizr{top:9px;position:absolute}}"].join("");M(n,function(A){t=9===A.offsetTop})}return t}),Modernizr.addTest("checked",function(){return M("#modernizr {position:absolute} #modernizr input {margin-left:10px} #modernizr :checked {margin-left:20px;display:block}",function(A){var e=o("input");return e.setAttribute("type","checkbox"),e.setAttribute("checked","checked"),A.appendChild(e),20===e.offsetLeft})}),M("#modernizr{display: table; direction: ltr}#modernizr div{display: table-cell; padding: 10px}",function(A){var e,t=A.childNodes;e=t[0].offsetLeft<t[1].offsetLeft,Modernizr.addTest("displaytable",e,{aliases:["display-table"]})},2),M("#modernizr div {width:100px} #modernizr :last-child{width:200px;display:block}",function(A){Modernizr.addTest("lastchild",A.lastChild.offsetWidth>A.firstChild.offsetWidth)},2);var U=function(){var e=A.matchMedia||A.msMatchMedia;return e?function(A){var t=e(A);return t&&t.matches||!1}:function(e){var t=!1;return d("@media "+e+" { #modernizr { position: absolute; } }",function(e){t="absolute"==(A.getComputedStyle?A.getComputedStyle(e,null):e.currentStyle).position}),t}}();p.mq=U,Modernizr.addTest("mediaqueries",U("only all"));var R="Moz O ms Webkit",x=p._config.usePrefixes?R.split(" "):[];p._cssomPrefixes=x;var k=function(e){var n,a=y.length,w=A.CSSRule;if("undefined"==typeof w)return t;if(!e)return!1;if(e=e.replace(/^@/,""),n=e.replace(/-/g,"_").toUpperCase()+"_RULE",n in w)return"@"+e;for(var o=0;a>o;o++){var i=y[o],D=i.toUpperCase()+"_"+n;if(D in w)return"@-"+i.toLowerCase()+"-"+e}return!1};p.atRule=k;var Z=p._config.usePrefixes?R.toLowerCase().split(" "):[];p._domPrefixes=Z;var z={style:V.elem.style};Modernizr._q.unshift(function(){delete z.style}),p.testAllProps=B;var W=p.prefixed=function(A,e,t){return 0===A.indexOf("@")?k(A):(-1!=A.indexOf("-")&&(A=r(A)),e?B(A,e,t):B(A,"pfx"))};Modernizr.addTest("fullscreen",!(!W("exitFullscreen",e,!1)&&!W("cancelFullScreen",e,!1))),Modernizr.addTest("backgroundblendmode",W("backgroundBlendMode","text")),p.testAllProps=g,Modernizr.addTest("cssanimations",g("animationName","a",!0)),Modernizr.addTest("backgroundcliptext",function(){return g("backgroundClip","text")}),Modernizr.addTest("bgpositionxy",function(){return g("backgroundPositionX","3px",!0)&&g("backgroundPositionY","5px",!0)}),Modernizr.addTest("bgrepeatround",g("backgroundRepeat","round")),Modernizr.addTest("bgrepeatspace",g("backgroundRepeat","space")),Modernizr.addTest("backgroundsize",g("backgroundSize","100%",!0)),Modernizr.addTest("bgsizecover",g("backgroundSize","cover")),Modernizr.addTest("borderradius",g("borderRadius","0px",!0)),Modernizr.addTest("boxshadow",g("boxShadow","1px 1px",!0)),Modernizr.addTest("boxsizing",g("boxSizing","border-box",!0)&&(e.documentMode===t||e.documentMode>7)),function(){Modernizr.addTest("csscolumns",function(){var A=!1,e=g("columnCount");try{(A=!!e)&&(A=new Boolean(A))}catch(t){}return A});for(var A,e,t=["Width","Span","Fill","Gap","Rule","RuleColor","RuleStyle","RuleWidth","BreakBefore","BreakAfter","BreakInside"],n=0;n<t.length;n++)A=t[n].toLowerCase(),e=g("column"+t[n]),("breakbefore"===A||"breakafter"===A||"breakinside"==A)&&(e=e||g(t[n])),Modernizr.addTest("csscolumns."+A,e)}(),Modernizr.addTest("ellipsis",g("textOverflow","ellipsis")),Modernizr.addTest("cssfilters",function(){if(Modernizr.supports)return g("filter","blur(2px)");var A=o("a");return A.style.cssText=y.join("filter:blur(2px); "),!!A.style.length&&(e.documentMode===t||e.documentMode>9)}),a(),w(E),delete p.addTest,delete p.addAsyncTest;for(var T=0;T<Modernizr._q.length;T++)Modernizr._q[T]();A.Modernizr=Modernizr}(window,document);



/*!
 * imagesLoaded PACKAGED v4.1.4
 * JavaScript is all like "You images are done yet or what?"
 * MIT License
 */

!function(e,t){"function"==typeof define&&define.amd?define("ev-emitter/ev-emitter",t):"object"==typeof module&&module.exports?module.exports=t():e.EvEmitter=t()}("undefined"!=typeof window?window:this,function(){function e(){}var t=e.prototype;return t.on=function(e,t){if(e&&t){var i=this._events=this._events||{},n=i[e]=i[e]||[];return n.indexOf(t)==-1&&n.push(t),this}},t.once=function(e,t){if(e&&t){this.on(e,t);var i=this._onceEvents=this._onceEvents||{},n=i[e]=i[e]||{};return n[t]=!0,this}},t.off=function(e,t){var i=this._events&&this._events[e];if(i&&i.length){var n=i.indexOf(t);return n!=-1&&i.splice(n,1),this}},t.emitEvent=function(e,t){var i=this._events&&this._events[e];if(i&&i.length){i=i.slice(0),t=t||[];for(var n=this._onceEvents&&this._onceEvents[e],o=0;o<i.length;o++){var r=i[o],s=n&&n[r];s&&(this.off(e,r),delete n[r]),r.apply(this,t)}return this}},t.allOff=function(){delete this._events,delete this._onceEvents},e}),function(e,t){"use strict";"function"==typeof define&&define.amd?define(["ev-emitter/ev-emitter"],function(i){return t(e,i)}):"object"==typeof module&&module.exports?module.exports=t(e,require("ev-emitter")):e.imagesLoaded=t(e,e.EvEmitter)}("undefined"!=typeof window?window:this,function(e,t){function i(e,t){for(var i in t)e[i]=t[i];return e}function n(e){if(Array.isArray(e))return e;var t="object"==typeof e&&"number"==typeof e.length;return t?d.call(e):[e]}function o(e,t,r){if(!(this instanceof o))return new o(e,t,r);var s=e;return"string"==typeof e&&(s=document.querySelectorAll(e)),s?(this.elements=n(s),this.options=i({},this.options),"function"==typeof t?r=t:i(this.options,t),r&&this.on("always",r),this.getImages(),h&&(this.jqDeferred=new h.Deferred),void setTimeout(this.check.bind(this))):void a.error("Bad element for imagesLoaded "+(s||e))}function r(e){this.img=e}function s(e,t){this.url=e,this.element=t,this.img=new Image}var h=e.jQuery,a=e.console,d=Array.prototype.slice;o.prototype=Object.create(t.prototype),o.prototype.options={},o.prototype.getImages=function(){this.images=[],this.elements.forEach(this.addElementImages,this)},o.prototype.addElementImages=function(e){"IMG"==e.nodeName&&this.addImage(e),this.options.background===!0&&this.addElementBackgroundImages(e);var t=e.nodeType;if(t&&u[t]){for(var i=e.querySelectorAll("img"),n=0;n<i.length;n++){var o=i[n];this.addImage(o)}if("string"==typeof this.options.background){var r=e.querySelectorAll(this.options.background);for(n=0;n<r.length;n++){var s=r[n];this.addElementBackgroundImages(s)}}}};var u={1:!0,9:!0,11:!0};return o.prototype.addElementBackgroundImages=function(e){var t=getComputedStyle(e);if(t)for(var i=/url\((['"])?(.*?)\1\)/gi,n=i.exec(t.backgroundImage);null!==n;){var o=n&&n[2];o&&this.addBackground(o,e),n=i.exec(t.backgroundImage)}},o.prototype.addImage=function(e){var t=new r(e);this.images.push(t)},o.prototype.addBackground=function(e,t){var i=new s(e,t);this.images.push(i)},o.prototype.check=function(){function e(e,i,n){setTimeout(function(){t.progress(e,i,n)})}var t=this;return this.progressedCount=0,this.hasAnyBroken=!1,this.images.length?void this.images.forEach(function(t){t.once("progress",e),t.check()}):void this.complete()},o.prototype.progress=function(e,t,i){this.progressedCount++,this.hasAnyBroken=this.hasAnyBroken||!e.isLoaded,this.emitEvent("progress",[this,e,t]),this.jqDeferred&&this.jqDeferred.notify&&this.jqDeferred.notify(this,e),this.progressedCount==this.images.length&&this.complete(),this.options.debug&&a&&a.log("progress: "+i,e,t)},o.prototype.complete=function(){var e=this.hasAnyBroken?"fail":"done";if(this.isComplete=!0,this.emitEvent(e,[this]),this.emitEvent("always",[this]),this.jqDeferred){var t=this.hasAnyBroken?"reject":"resolve";this.jqDeferred[t](this)}},r.prototype=Object.create(t.prototype),r.prototype.check=function(){var e=this.getIsImageComplete();return e?void this.confirm(0!==this.img.naturalWidth,"naturalWidth"):(this.proxyImage=new Image,this.proxyImage.addEventListener("load",this),this.proxyImage.addEventListener("error",this),this.img.addEventListener("load",this),this.img.addEventListener("error",this),void(this.proxyImage.src=this.img.src))},r.prototype.getIsImageComplete=function(){return this.img.complete&&this.img.naturalWidth},r.prototype.confirm=function(e,t){this.isLoaded=e,this.emitEvent("progress",[this,this.img,t])},r.prototype.handleEvent=function(e){var t="on"+e.type;this[t]&&this[t](e)},r.prototype.onload=function(){this.confirm(!0,"onload"),this.unbindEvents()},r.prototype.onerror=function(){this.confirm(!1,"onerror"),this.unbindEvents()},r.prototype.unbindEvents=function(){this.proxyImage.removeEventListener("load",this),this.proxyImage.removeEventListener("error",this),this.img.removeEventListener("load",this),this.img.removeEventListener("error",this)},s.prototype=Object.create(r.prototype),s.prototype.check=function(){this.img.addEventListener("load",this),this.img.addEventListener("error",this),this.img.src=this.url;var e=this.getIsImageComplete();e&&(this.confirm(0!==this.img.naturalWidth,"naturalWidth"),this.unbindEvents())},s.prototype.unbindEvents=function(){this.img.removeEventListener("load",this),this.img.removeEventListener("error",this)},s.prototype.confirm=function(e,t){this.isLoaded=e,this.emitEvent("progress",[this,this.element,t])},o.makeJQueryPlugin=function(t){t=t||e.jQuery,t&&(h=t,h.fn.imagesLoaded=function(e,t){var i=new o(this,e,t);return i.jqDeferred.promise(h(this))})},o.makeJQueryPlugin(),o});



(function(a){if(typeof define==="function"&&define.amd&&define.amd.jQuery){define(["jquery"],a)}else{a(jQuery)}}(function(f){var p="left",o="right",e="up",x="down",c="in",z="out",m="none",s="auto",l="swipe",t="pinch",A="tap",j="doubletap",b="longtap",y="hold",D="horizontal",u="vertical",i="all",r=10,g="start",k="move",h="end",q="cancel",a="ontouchstart" in window,v=window.navigator.msPointerEnabled&&!window.navigator.pointerEnabled,d=window.navigator.pointerEnabled||window.navigator.msPointerEnabled,B="TouchSwipe";var n={fingers:1,threshold:75,cancelThreshold:null,pinchThreshold:20,maxTimeThreshold:null,fingerReleaseThreshold:250,longTapThreshold:500,doubleTapThreshold:200,swipe:null,swipeLeft:null,swipeRight:null,swipeUp:null,swipeDown:null,swipeStatus:null,pinchIn:null,pinchOut:null,pinchStatus:null,click:null,tap:null,doubleTap:null,longTap:null,hold:null,triggerOnTouchEnd:true,triggerOnTouchLeave:false,allowPageScroll:"auto",fallbackToMouseEvents:true,excludedElements:"label, button, input, select, textarea, a, .noSwipe"};f.fn.swipe=function(G){var F=f(this),E=F.data(B);if(E&&typeof G==="string"){if(E[G]){return E[G].apply(this,Array.prototype.slice.call(arguments,1))}else{f.error("Method "+G+" does not exist on jQuery.swipe")}}else{if(!E&&(typeof G==="object"||!G)){return w.apply(this,arguments)}}return F};f.fn.swipe.defaults=n;f.fn.swipe.phases={PHASE_START:g,PHASE_MOVE:k,PHASE_END:h,PHASE_CANCEL:q};f.fn.swipe.directions={LEFT:p,RIGHT:o,UP:e,DOWN:x,IN:c,OUT:z};f.fn.swipe.pageScroll={NONE:m,HORIZONTAL:D,VERTICAL:u,AUTO:s};f.fn.swipe.fingers={ONE:1,TWO:2,THREE:3,ALL:i};function w(E){if(E&&(E.allowPageScroll===undefined&&(E.swipe!==undefined||E.swipeStatus!==undefined))){E.allowPageScroll=m}if(E.click!==undefined&&E.tap===undefined){E.tap=E.click}if(!E){E={}}E=f.extend({},f.fn.swipe.defaults,E);return this.each(function(){var G=f(this);var F=G.data(B);if(!F){F=new C(this,E);G.data(B,F)}})}function C(a4,av){var az=(a||d||!av.fallbackToMouseEvents),J=az?(d?(v?"MSPointerDown":"pointerdown"):"touchstart"):"mousedown",ay=az?(d?(v?"MSPointerMove":"pointermove"):"touchmove"):"mousemove",U=az?(d?(v?"MSPointerUp":"pointerup"):"touchend"):"mouseup",S=az?null:"mouseleave",aD=(d?(v?"MSPointerCancel":"pointercancel"):"touchcancel");var ag=0,aP=null,ab=0,a1=0,aZ=0,G=1,aq=0,aJ=0,M=null;var aR=f(a4);var Z="start";var W=0;var aQ=null;var T=0,a2=0,a5=0,ad=0,N=0;var aW=null,af=null;try{aR.bind(J,aN);aR.bind(aD,a9)}catch(ak){f.error("events not supported "+J+","+aD+" on jQuery.swipe")}this.enable=function(){aR.bind(J,aN);aR.bind(aD,a9);return aR};this.disable=function(){aK();return aR};this.destroy=function(){aK();aR.data(B,null);aR=null};this.option=function(bc,bb){if(av[bc]!==undefined){if(bb===undefined){return av[bc]}else{av[bc]=bb}}else{f.error("Option "+bc+" does not exist on jQuery.swipe.options")}return null};function aN(bd){if(aB()){return}if(f(bd.target).closest(av.excludedElements,aR).length>0){return}var be=bd.originalEvent?bd.originalEvent:bd;var bc,bb=a?be.touches[0]:be;Z=g;if(a){W=be.touches.length}else{bd.preventDefault()}ag=0;aP=null;aJ=null;ab=0;a1=0;aZ=0;G=1;aq=0;aQ=aj();M=aa();R();if(!a||(W===av.fingers||av.fingers===i)||aX()){ai(0,bb);T=at();if(W==2){ai(1,be.touches[1]);a1=aZ=au(aQ[0].start,aQ[1].start)}if(av.swipeStatus||av.pinchStatus){bc=O(be,Z)}}else{bc=false}if(bc===false){Z=q;O(be,Z);return bc}else{if(av.hold){af=setTimeout(f.proxy(function(){aR.trigger("hold",[be.target]);if(av.hold){bc=av.hold.call(aR,be,be.target)}},this),av.longTapThreshold)}ao(true)}return null}function a3(be){var bh=be.originalEvent?be.originalEvent:be;if(Z===h||Z===q||am()){return}var bd,bc=a?bh.touches[0]:bh;var bf=aH(bc);a2=at();if(a){W=bh.touches.length}if(av.hold){clearTimeout(af)}Z=k;if(W==2){if(a1==0){ai(1,bh.touches[1]);a1=aZ=au(aQ[0].start,aQ[1].start)}else{aH(bh.touches[1]);aZ=au(aQ[0].end,aQ[1].end);aJ=ar(aQ[0].end,aQ[1].end)}G=a7(a1,aZ);aq=Math.abs(a1-aZ)}if((W===av.fingers||av.fingers===i)||!a||aX()){aP=aL(bf.start,bf.end);al(be,aP);ag=aS(bf.start,bf.end);ab=aM();aI(aP,ag);if(av.swipeStatus||av.pinchStatus){bd=O(bh,Z)}if(!av.triggerOnTouchEnd||av.triggerOnTouchLeave){var bb=true;if(av.triggerOnTouchLeave){var bg=aY(this);bb=E(bf.end,bg)}if(!av.triggerOnTouchEnd&&bb){Z=aC(k)}else{if(av.triggerOnTouchLeave&&!bb){Z=aC(h)}}if(Z==q||Z==h){O(bh,Z)}}}else{Z=q;O(bh,Z)}if(bd===false){Z=q;O(bh,Z)}}function L(bb){var bc=bb.originalEvent;if(a){if(bc.touches.length>0){F();return true}}if(am()){W=ad}a2=at();ab=aM();if(ba()||!an()){Z=q;O(bc,Z)}else{if(av.triggerOnTouchEnd||(av.triggerOnTouchEnd==false&&Z===k)){bb.preventDefault();Z=h;O(bc,Z)}else{if(!av.triggerOnTouchEnd&&a6()){Z=h;aF(bc,Z,A)}else{if(Z===k){Z=q;O(bc,Z)}}}}ao(false);return null}function a9(){W=0;a2=0;T=0;a1=0;aZ=0;G=1;R();ao(false)}function K(bb){var bc=bb.originalEvent;if(av.triggerOnTouchLeave){Z=aC(h);O(bc,Z)}}function aK(){aR.unbind(J,aN);aR.unbind(aD,a9);aR.unbind(ay,a3);aR.unbind(U,L);if(S){aR.unbind(S,K)}ao(false)}function aC(bf){var be=bf;var bd=aA();var bc=an();var bb=ba();if(!bd||bb){be=q}else{if(bc&&bf==k&&(!av.triggerOnTouchEnd||av.triggerOnTouchLeave)){be=h}else{if(!bc&&bf==h&&av.triggerOnTouchLeave){be=q}}}return be}function O(bd,bb){var bc=undefined;if(I()||V()){bc=aF(bd,bb,l)}else{if((P()||aX())&&bc!==false){bc=aF(bd,bb,t)}}if(aG()&&bc!==false){bc=aF(bd,bb,j)}else{if(ap()&&bc!==false){bc=aF(bd,bb,b)}else{if(ah()&&bc!==false){bc=aF(bd,bb,A)}}}if(bb===q){a9(bd)}if(bb===h){if(a){if(bd.touches.length==0){a9(bd)}}else{a9(bd)}}return bc}function aF(be,bb,bd){var bc=undefined;if(bd==l){aR.trigger("swipeStatus",[bb,aP||null,ag||0,ab||0,W,aQ]);if(av.swipeStatus){bc=av.swipeStatus.call(aR,be,bb,aP||null,ag||0,ab||0,W,aQ);if(bc===false){return false}}if(bb==h&&aV()){aR.trigger("swipe",[aP,ag,ab,W,aQ]);if(av.swipe){bc=av.swipe.call(aR,be,aP,ag,ab,W,aQ);if(bc===false){return false}}switch(aP){case p:aR.trigger("swipeLeft",[aP,ag,ab,W,aQ]);if(av.swipeLeft){bc=av.swipeLeft.call(aR,be,aP,ag,ab,W,aQ)}break;case o:aR.trigger("swipeRight",[aP,ag,ab,W,aQ]);if(av.swipeRight){bc=av.swipeRight.call(aR,be,aP,ag,ab,W,aQ)}break;case e:aR.trigger("swipeUp",[aP,ag,ab,W,aQ]);if(av.swipeUp){bc=av.swipeUp.call(aR,be,aP,ag,ab,W,aQ)}break;case x:aR.trigger("swipeDown",[aP,ag,ab,W,aQ]);if(av.swipeDown){bc=av.swipeDown.call(aR,be,aP,ag,ab,W,aQ)}break}}}if(bd==t){aR.trigger("pinchStatus",[bb,aJ||null,aq||0,ab||0,W,G,aQ]);if(av.pinchStatus){bc=av.pinchStatus.call(aR,be,bb,aJ||null,aq||0,ab||0,W,G,aQ);if(bc===false){return false}}if(bb==h&&a8()){switch(aJ){case c:aR.trigger("pinchIn",[aJ||null,aq||0,ab||0,W,G,aQ]);if(av.pinchIn){bc=av.pinchIn.call(aR,be,aJ||null,aq||0,ab||0,W,G,aQ)}break;case z:aR.trigger("pinchOut",[aJ||null,aq||0,ab||0,W,G,aQ]);if(av.pinchOut){bc=av.pinchOut.call(aR,be,aJ||null,aq||0,ab||0,W,G,aQ)}break}}}if(bd==A){if(bb===q||bb===h){clearTimeout(aW);clearTimeout(af);if(Y()&&!H()){N=at();aW=setTimeout(f.proxy(function(){N=null;aR.trigger("tap",[be.target]);if(av.tap){bc=av.tap.call(aR,be,be.target)}},this),av.doubleTapThreshold)}else{N=null;aR.trigger("tap",[be.target]);if(av.tap){bc=av.tap.call(aR,be,be.target)}}}}else{if(bd==j){if(bb===q||bb===h){clearTimeout(aW);N=null;aR.trigger("doubletap",[be.target]);if(av.doubleTap){bc=av.doubleTap.call(aR,be,be.target)}}}else{if(bd==b){if(bb===q||bb===h){clearTimeout(aW);N=null;aR.trigger("longtap",[be.target]);if(av.longTap){bc=av.longTap.call(aR,be,be.target)}}}}}return bc}function an(){var bb=true;if(av.threshold!==null){bb=ag>=av.threshold}return bb}function ba(){var bb=false;if(av.cancelThreshold!==null&&aP!==null){bb=(aT(aP)-ag)>=av.cancelThreshold}return bb}function ae(){if(av.pinchThreshold!==null){return aq>=av.pinchThreshold}return true}function aA(){var bb;if(av.maxTimeThreshold){if(ab>=av.maxTimeThreshold){bb=false}else{bb=true}}else{bb=true}return bb}function al(bb,bc){if(av.allowPageScroll===m||aX()){bb.preventDefault()}else{var bd=av.allowPageScroll===s;switch(bc){case p:if((av.swipeLeft&&bd)||(!bd&&av.allowPageScroll!=D)){bb.preventDefault()}break;case o:if((av.swipeRight&&bd)||(!bd&&av.allowPageScroll!=D)){bb.preventDefault()}break;case e:if((av.swipeUp&&bd)||(!bd&&av.allowPageScroll!=u)){bb.preventDefault()}break;case x:if((av.swipeDown&&bd)||(!bd&&av.allowPageScroll!=u)){bb.preventDefault()}break}}}function a8(){var bc=aO();var bb=X();var bd=ae();return bc&&bb&&bd}function aX(){return !!(av.pinchStatus||av.pinchIn||av.pinchOut)}function P(){return !!(a8()&&aX())}function aV(){var be=aA();var bg=an();var bd=aO();var bb=X();var bc=ba();var bf=!bc&&bb&&bd&&bg&&be;return bf}function V(){return !!(av.swipe||av.swipeStatus||av.swipeLeft||av.swipeRight||av.swipeUp||av.swipeDown)}function I(){return !!(aV()&&V())}function aO(){return((W===av.fingers||av.fingers===i)||!a)}function X(){return aQ[0].end.x!==0}function a6(){return !!(av.tap)}function Y(){return !!(av.doubleTap)}function aU(){return !!(av.longTap)}function Q(){if(N==null){return false}var bb=at();return(Y()&&((bb-N)<=av.doubleTapThreshold))}function H(){return Q()}function ax(){return((W===1||!a)&&(isNaN(ag)||ag<av.threshold))}function a0(){return((ab>av.longTapThreshold)&&(ag<r))}function ah(){return !!(ax()&&a6())}function aG(){return !!(Q()&&Y())}function ap(){return !!(a0()&&aU())}function F(){a5=at();ad=event.touches.length+1}function R(){a5=0;ad=0}function am(){var bb=false;if(a5){var bc=at()-a5;if(bc<=av.fingerReleaseThreshold){bb=true}}return bb}function aB(){return !!(aR.data(B+"_intouch")===true)}function ao(bb){if(bb===true){aR.bind(ay,a3);aR.bind(U,L);if(S){aR.bind(S,K)}}else{aR.unbind(ay,a3,false);aR.unbind(U,L,false);if(S){aR.unbind(S,K,false)}}aR.data(B+"_intouch",bb===true)}function ai(bc,bb){var bd=bb.identifier!==undefined?bb.identifier:0;aQ[bc].identifier=bd;aQ[bc].start.x=aQ[bc].end.x=bb.pageX||bb.clientX;aQ[bc].start.y=aQ[bc].end.y=bb.pageY||bb.clientY;return aQ[bc]}function aH(bb){var bd=bb.identifier!==undefined?bb.identifier:0;var bc=ac(bd);bc.end.x=bb.pageX||bb.clientX;bc.end.y=bb.pageY||bb.clientY;return bc}function ac(bc){for(var bb=0;bb<aQ.length;bb++){if(aQ[bb].identifier==bc){return aQ[bb]}}}function aj(){var bb=[];for(var bc=0;bc<=5;bc++){bb.push({start:{x:0,y:0},end:{x:0,y:0},identifier:0})}return bb}function aI(bb,bc){bc=Math.max(bc,aT(bb));M[bb].distance=bc}function aT(bb){if(M[bb]){return M[bb].distance}return undefined}function aa(){var bb={};bb[p]=aw(p);bb[o]=aw(o);bb[e]=aw(e);bb[x]=aw(x);return bb}function aw(bb){return{direction:bb,distance:0}}function aM(){return a2-T}function au(be,bd){var bc=Math.abs(be.x-bd.x);var bb=Math.abs(be.y-bd.y);return Math.round(Math.sqrt(bc*bc+bb*bb))}function a7(bb,bc){var bd=(bc/bb)*1;return bd.toFixed(2)}function ar(){if(G<1){return z}else{return c}}function aS(bc,bb){return Math.round(Math.sqrt(Math.pow(bb.x-bc.x,2)+Math.pow(bb.y-bc.y,2)))}function aE(be,bc){var bb=be.x-bc.x;var bg=bc.y-be.y;var bd=Math.atan2(bg,bb);var bf=Math.round(bd*180/Math.PI);if(bf<0){bf=360-Math.abs(bf)}return bf}function aL(bc,bb){var bd=aE(bc,bb);if((bd<=45)&&(bd>=0)){return p}else{if((bd<=360)&&(bd>=315)){return p}else{if((bd>=135)&&(bd<=225)){return o}else{if((bd>45)&&(bd<135)){return x}else{return e}}}}}function at(){var bb=new Date();return bb.getTime()}function aY(bb){bb=f(bb);var bd=bb.offset();var bc={left:bd.left,right:bd.left+bb.outerWidth(),top:bd.top,bottom:bd.top+bb.outerHeight()};return bc}function E(bb,bc){return(bb.x>bc.left&&bb.x<bc.right&&bb.y>bc.top&&bb.y<bc.bottom)}}}));
(function(t,e){if(typeof define==="function"&&define.amd){define(["jquery"],e)}else if(typeof exports==="object"){module.exports=e(require("jquery"))}else{e(t.jQuery)}})(this,function(t){t.transit={version:"0.9.12",propertyMap:{marginLeft:"margin",marginRight:"margin",marginBottom:"margin",marginTop:"margin",paddingLeft:"padding",paddingRight:"padding",paddingBottom:"padding",paddingTop:"padding"},enabled:true,useTransitionEnd:false};var e=document.createElement("div");var n={};function i(t){if(t in e.style)return t;var n=["Moz","Webkit","O","ms"];var i=t.charAt(0).toUpperCase()+t.substr(1);for(var r=0;r<n.length;++r){var s=n[r]+i;if(s in e.style){return s}}}function r(){e.style[n.transform]="";e.style[n.transform]="rotateY(90deg)";return e.style[n.transform]!==""}var s=navigator.userAgent.toLowerCase().indexOf("chrome")>-1;n.transition=i("transition");n.transitionDelay=i("transitionDelay");n.transform=i("transform");n.transformOrigin=i("transformOrigin");n.filter=i("Filter");n.transform3d=r();var a={transition:"transitionend",MozTransition:"transitionend",OTransition:"oTransitionEnd",WebkitTransition:"webkitTransitionEnd",msTransition:"MSTransitionEnd"};var o=n.transitionEnd=a[n.transition]||null;for(var u in n){if(n.hasOwnProperty(u)&&typeof t.support[u]==="undefined"){t.support[u]=n[u]}}e=null;t.cssEase={_default:"ease","in":"ease-in",out:"ease-out","in-out":"ease-in-out",snap:"cubic-bezier(0,1,.5,1)",easeInCubic:"cubic-bezier(.550,.055,.675,.190)",easeOutCubic:"cubic-bezier(.215,.61,.355,1)",easeInOutCubic:"cubic-bezier(.645,.045,.355,1)",easeInCirc:"cubic-bezier(.6,.04,.98,.335)",easeOutCirc:"cubic-bezier(.075,.82,.165,1)",easeInOutCirc:"cubic-bezier(.785,.135,.15,.86)",easeInExpo:"cubic-bezier(.95,.05,.795,.035)",easeOutExpo:"cubic-bezier(.19,1,.22,1)",easeInOutExpo:"cubic-bezier(1,0,0,1)",easeInQuad:"cubic-bezier(.55,.085,.68,.53)",easeOutQuad:"cubic-bezier(.25,.46,.45,.94)",easeInOutQuad:"cubic-bezier(.455,.03,.515,.955)",easeInQuart:"cubic-bezier(.895,.03,.685,.22)",easeOutQuart:"cubic-bezier(.165,.84,.44,1)",easeInOutQuart:"cubic-bezier(.77,0,.175,1)",easeInQuint:"cubic-bezier(.755,.05,.855,.06)",easeOutQuint:"cubic-bezier(.23,1,.32,1)",easeInOutQuint:"cubic-bezier(.86,0,.07,1)",easeInSine:"cubic-bezier(.47,0,.745,.715)",easeOutSine:"cubic-bezier(.39,.575,.565,1)",easeInOutSine:"cubic-bezier(.445,.05,.55,.95)",easeInBack:"cubic-bezier(.6,-.28,.735,.045)",easeOutBack:"cubic-bezier(.175, .885,.32,1.275)",easeInOutBack:"cubic-bezier(.68,-.55,.265,1.55)"};t.cssHooks["transit:transform"]={get:function(e){return t(e).data("transform")||new f},set:function(e,i){var r=i;if(!(r instanceof f)){r=new f(r)}if(n.transform==="WebkitTransform"&&!s){e.style[n.transform]=r.toString(true)}else{e.style[n.transform]=r.toString()}t(e).data("transform",r)}};t.cssHooks.transform={set:t.cssHooks["transit:transform"].set};t.cssHooks.filter={get:function(t){return t.style[n.filter]},set:function(t,e){t.style[n.filter]=e}};if(t.fn.jquery<"1.8"){t.cssHooks.transformOrigin={get:function(t){return t.style[n.transformOrigin]},set:function(t,e){t.style[n.transformOrigin]=e}};t.cssHooks.transition={get:function(t){return t.style[n.transition]},set:function(t,e){t.style[n.transition]=e}}}p("scale");p("scaleX");p("scaleY");p("translate");p("rotate");p("rotateX");p("rotateY");p("rotate3d");p("perspective");p("skewX");p("skewY");p("x",true);p("y",true);function f(t){if(typeof t==="string"){this.parse(t)}return this}f.prototype={setFromString:function(t,e){var n=typeof e==="string"?e.split(","):e.constructor===Array?e:[e];n.unshift(t);f.prototype.set.apply(this,n)},set:function(t){var e=Array.prototype.slice.apply(arguments,[1]);if(this.setter[t]){this.setter[t].apply(this,e)}else{this[t]=e.join(",")}},get:function(t){if(this.getter[t]){return this.getter[t].apply(this)}else{return this[t]||0}},setter:{rotate:function(t){this.rotate=b(t,"deg")},rotateX:function(t){this.rotateX=b(t,"deg")},rotateY:function(t){this.rotateY=b(t,"deg")},scale:function(t,e){if(e===undefined){e=t}this.scale=t+","+e},skewX:function(t){this.skewX=b(t,"deg")},skewY:function(t){this.skewY=b(t,"deg")},perspective:function(t){this.perspective=b(t,"px")},x:function(t){this.set("translate",t,null)},y:function(t){this.set("translate",null,t)},translate:function(t,e){if(this._translateX===undefined){this._translateX=0}if(this._translateY===undefined){this._translateY=0}if(t!==null&&t!==undefined){this._translateX=b(t,"px")}if(e!==null&&e!==undefined){this._translateY=b(e,"px")}this.translate=this._translateX+","+this._translateY}},getter:{x:function(){return this._translateX||0},y:function(){return this._translateY||0},scale:function(){var t=(this.scale||"1,1").split(",");if(t[0]){t[0]=parseFloat(t[0])}if(t[1]){t[1]=parseFloat(t[1])}return t[0]===t[1]?t[0]:t},rotate3d:function(){var t=(this.rotate3d||"0,0,0,0deg").split(",");for(var e=0;e<=3;++e){if(t[e]){t[e]=parseFloat(t[e])}}if(t[3]){t[3]=b(t[3],"deg")}return t}},parse:function(t){var e=this;t.replace(/([a-zA-Z0-9]+)\((.*?)\)/g,function(t,n,i){e.setFromString(n,i)})},toString:function(t){var e=[];for(var i in this){if(this.hasOwnProperty(i)){if(!n.transform3d&&(i==="rotateX"||i==="rotateY"||i==="perspective"||i==="transformOrigin")){continue}if(i[0]!=="_"){if(t&&i==="scale"){e.push(i+"3d("+this[i]+",1)")}else if(t&&i==="translate"){e.push(i+"3d("+this[i]+",0)")}else{e.push(i+"("+this[i]+")")}}}}return e.join(" ")}};function c(t,e,n){if(e===true){t.queue(n)}else if(e){t.queue(e,n)}else{t.each(function(){n.call(this)})}}function l(e){var i=[];t.each(e,function(e){e=t.camelCase(e);e=t.transit.propertyMap[e]||t.cssProps[e]||e;e=h(e);if(n[e])e=h(n[e]);if(t.inArray(e,i)===-1){i.push(e)}});return i}function d(e,n,i,r){var s=l(e);if(t.cssEase[i]){i=t.cssEase[i]}var a=""+y(n)+" "+i;if(parseInt(r,10)>0){a+=" "+y(r)}var o=[];t.each(s,function(t,e){o.push(e+" "+a)});return o.join(", ")}t.fn.transition=t.fn.transit=function(e,i,r,s){var a=this;var u=0;var f=true;var l=t.extend(true,{},e);if(typeof i==="function"){s=i;i=undefined}if(typeof i==="object"){r=i.easing;u=i.delay||0;f=typeof i.queue==="undefined"?true:i.queue;s=i.complete;i=i.duration}if(typeof r==="function"){s=r;r=undefined}if(typeof l.easing!=="undefined"){r=l.easing;delete l.easing}if(typeof l.duration!=="undefined"){i=l.duration;delete l.duration}if(typeof l.complete!=="undefined"){s=l.complete;delete l.complete}if(typeof l.queue!=="undefined"){f=l.queue;delete l.queue}if(typeof l.delay!=="undefined"){u=l.delay;delete l.delay}if(typeof i==="undefined"){i=t.fx.speeds._default}if(typeof r==="undefined"){r=t.cssEase._default}i=y(i);var p=d(l,i,r,u);var h=t.transit.enabled&&n.transition;var b=h?parseInt(i,10)+parseInt(u,10):0;if(b===0){var g=function(t){a.css(l);if(s){s.apply(a)}if(t){t()}};c(a,f,g);return a}var m={};var v=function(e){var i=false;var r=function(){if(i){a.unbind(o,r)}if(b>0){a.each(function(){this.style[n.transition]=m[this]||null})}if(typeof s==="function"){s.apply(a)}if(typeof e==="function"){e()}};if(b>0&&o&&t.transit.useTransitionEnd){i=true;a.bind(o,r)}else{window.setTimeout(r,b)}a.each(function(){if(b>0){this.style[n.transition]=p}t(this).css(l)})};var z=function(t){this.offsetWidth;v(t)};c(a,f,z);return this};function p(e,i){if(!i){t.cssNumber[e]=true}t.transit.propertyMap[e]=n.transform;t.cssHooks[e]={get:function(n){var i=t(n).css("transit:transform");return i.get(e)},set:function(n,i){var r=t(n).css("transit:transform");r.setFromString(e,i);t(n).css({"transit:transform":r})}}}function h(t){return t.replace(/([A-Z])/g,function(t){return"-"+t.toLowerCase()})}function b(t,e){if(typeof t==="string"&&!t.match(/^[\-0-9\.]+$/)){return t}else{return""+t+e}}function y(e){var n=e;if(typeof n==="string"&&!n.match(/^[\-0-9\.]+/)){n=t.fx.speeds[n]||t.fx.speeds._default}return b(n,"ms")}t.transit.getTransitionValue=d;return t});







;(function($, window, document, undefined) {

  var pluginName = 'stellar',
    defaults = {
      scrollProperty: 'scroll',
      positionProperty: 'position',
      horizontalScrolling: true,
      verticalScrolling: true,
      horizontalOffset: 0,
      verticalOffset: 0,
      responsive: false,
      parallaxBackgrounds: true,
      parallaxElements: true,
      hideDistantElements: true,
      hideElement: function($elem) { $elem.hide(); },
      showElement: function($elem) { $elem.show(); }
    },

    scrollProperty = {
      scroll: {
        getLeft: function($elem) { return $elem.scrollLeft(); },
        setLeft: function($elem, val) { $elem.scrollLeft(val); },

        getTop: function($elem) { return $elem.scrollTop(); },
        setTop: function($elem, val) { $elem.scrollTop(val); }
      },
      position: {
        getLeft: function($elem) { return parseInt($elem.css('left'), 10) * -1; },
        getTop: function($elem) { return parseInt($elem.css('top'), 10) * -1; }
      },
      margin: {
        getLeft: function($elem) { return parseInt($elem.css('margin-left'), 10) * -1; },
        getTop: function($elem) { return parseInt($elem.css('margin-top'), 10) * -1; }
      },
      transform: {
        getLeft: function($elem) {
          var computedTransform = getComputedStyle($elem[0])[prefixedTransform];
          return (computedTransform !== 'none' ? parseInt(computedTransform.match(/(-?[0-9]+)/g)[4], 10) * -1 : 0);
        },
        getTop: function($elem) {
          var computedTransform = getComputedStyle($elem[0])[prefixedTransform];
          return (computedTransform !== 'none' ? parseInt(computedTransform.match(/(-?[0-9]+)/g)[5], 10) * -1 : 0);
        }
      }
    },

    positionProperty = {
      position: {
        setLeft: function($elem, left) { $elem.css('left', left); },
        setTop: function($elem, top) { $elem.css('top', top); }
      },
      transform: {
        setPosition: function($elem, left, startingLeft, top, startingTop) {
          $elem[0].style[prefixedTransform] = 'translate3d(' + (left - startingLeft) + 'px, ' + (top - startingTop) + 'px, 0)';
        }
      }
    },

    // Returns a function which adds a vendor prefix to any CSS property name
    vendorPrefix = (function() {
      var prefixes = /^(Moz|Webkit|Khtml|O|ms|Icab)(?=[A-Z])/,
        style = $('script')[0].style,
        prefix = '',
        prop;

      for (prop in style) {
        if (prefixes.test(prop)) {
          prefix = prop.match(prefixes)[0];
          break;
        }
      }

      if ('WebkitOpacity' in style) { prefix = 'Webkit'; }
      if ('KhtmlOpacity' in style) { prefix = 'Khtml'; }

      return function(property) {
        return prefix + (prefix.length > 0 ? property.charAt(0).toUpperCase() + property.slice(1) : property);
      };
    }()),

    prefixedTransform = vendorPrefix('transform'),

    supportsBackgroundPositionXY = $('<div />', { style: 'background:#fff' }).css('background-position-x') !== undefined,

    setBackgroundPosition = (supportsBackgroundPositionXY ?
      function($elem, x, y) {
        $elem.css({
          'background-position-x': x,
          'background-position-y': y
        });
      } :
      function($elem, x, y) {
        $elem.css('background-position', x + ' ' + y);
      }
    ),

    getBackgroundPosition = (supportsBackgroundPositionXY ?
      function($elem) {
        return [
          $elem.css('background-position-x'),
          $elem.css('background-position-y')
        ];
      } :
      function($elem) {
        return $elem.css('background-position').split(' ');
      }
    ),

    requestAnimFrame = (
      window.requestAnimationFrame       ||
      window.webkitRequestAnimationFrame ||
      window.mozRequestAnimationFrame    ||
      window.oRequestAnimationFrame      ||
      window.msRequestAnimationFrame     ||
      function(callback) {
        setTimeout(callback, 1000 / 60);
      }
    );

  function Plugin(element, options) {
    this.element = element;
    this.options = $.extend({}, defaults, options);

    this._defaults = defaults;
    this._name = pluginName;

    this.init();
  }

  Plugin.prototype = {
    init: function() {
      this.options.name = pluginName + '_' + Math.floor(Math.random() * 1e9);

      this._defineElements();
      this._defineGetters();
      this._defineSetters();
      this._handleWindowLoadAndResize();
      this._detectViewport();

      this.refresh({ firstLoad: true });

      if (this.options.scrollProperty === 'scroll') {
        this._handleScrollEvent();
      } else {
        this._startAnimationLoop();
      }
    },
    _defineElements: function() {
      if (this.element === document.body) this.element = window;
      this.$scrollElement = $(this.element);
      this.$element = (this.element === window ? $('body') : this.$scrollElement);
      this.$viewportElement = (this.options.viewportElement !== undefined ? $(this.options.viewportElement) : (this.$scrollElement[0] === window || this.options.scrollProperty === 'scroll' ? this.$scrollElement : this.$scrollElement.parent()) );
    },
    _defineGetters: function() {
      var self = this,
        scrollPropertyAdapter = scrollProperty[self.options.scrollProperty];

      this._getScrollLeft = function() {
        return scrollPropertyAdapter.getLeft(self.$scrollElement);
      };

      this._getScrollTop = function() {
        return scrollPropertyAdapter.getTop(self.$scrollElement);
      };
    },
    _defineSetters: function() {
      var self = this,
        scrollPropertyAdapter = scrollProperty[self.options.scrollProperty],
        positionPropertyAdapter = positionProperty[self.options.positionProperty],
        setScrollLeft = scrollPropertyAdapter.setLeft,
        setScrollTop = scrollPropertyAdapter.setTop;

      this._setScrollLeft = (typeof setScrollLeft === 'function' ? function(val) {
        setScrollLeft(self.$scrollElement, val);
      } : $.noop);

      this._setScrollTop = (typeof setScrollTop === 'function' ? function(val) {
        setScrollTop(self.$scrollElement, val);
      } : $.noop);

      this._setPosition = positionPropertyAdapter.setPosition ||
        function($elem, left, startingLeft, top, startingTop) {
          if (self.options.horizontalScrolling) {
            positionPropertyAdapter.setLeft($elem, left, startingLeft);
          }

          if (self.options.verticalScrolling) {
            positionPropertyAdapter.setTop($elem, top, startingTop);
          }
        };
    },
    _handleWindowLoadAndResize: function() {
      var self = this,
        $window = $(window);

      if (self.options.responsive) {
        $window.bind('load.' + this.name, function() {
          self.refresh();
        });
      }

      $window.bind('resize.' + this.name, function() {
        self._detectViewport();

        if (self.options.responsive) {
          self.refresh();
        }
      });
    },
    refresh: function(options) {
      var self = this,
        oldLeft = self._getScrollLeft(),
        oldTop = self._getScrollTop();

      if (!options || !options.firstLoad) {
        this._reset();
      }

      this._setScrollLeft(0);
      this._setScrollTop(0);

      this._setOffsets();
      this._findParticles();
      this._findBackgrounds();

      // Fix for WebKit background rendering bug
      if (options && options.firstLoad && /WebKit/.test(navigator.userAgent)) {
        $(window).load(function() {
          var oldLeft = self._getScrollLeft(),
            oldTop = self._getScrollTop();

          self._setScrollLeft(oldLeft + 1);
          self._setScrollTop(oldTop + 1);

          self._setScrollLeft(oldLeft);
          self._setScrollTop(oldTop);
        });
      }

      this._setScrollLeft(oldLeft);
      this._setScrollTop(oldTop);
    },
    _detectViewport: function() {
      var viewportOffsets = this.$viewportElement.offset(),
        hasOffsets = viewportOffsets !== null && viewportOffsets !== undefined;

      this.viewportWidth = this.$viewportElement.width();
      this.viewportHeight = this.$viewportElement.height();

      this.viewportOffsetTop = (hasOffsets ? viewportOffsets.top : 0);
      this.viewportOffsetLeft = (hasOffsets ? viewportOffsets.left : 0);
    },
    _findParticles: function() {
      var self = this,
        scrollLeft = this._getScrollLeft(),
        scrollTop = this._getScrollTop();

      if (this.particles !== undefined) {
        for (var i = this.particles.length - 1; i >= 0; i--) {
          this.particles[i].$element.data('stellar-elementIsActive', undefined);
        }
      }

      this.particles = [];

      if (!this.options.parallaxElements) return;

      this.$element.find('[data-stellar-ratio]').each(function(i) {
        var $this = $(this),
          horizontalOffset,
          verticalOffset,
          positionLeft,
          positionTop,
          marginLeft,
          marginTop,
          $offsetParent,
          offsetLeft,
          offsetTop,
          parentOffsetLeft = 0,
          parentOffsetTop = 0,
          tempParentOffsetLeft = 0,
          tempParentOffsetTop = 0;

        // Ensure this element isn't already part of another scrolling element
        if (!$this.data('stellar-elementIsActive')) {
          $this.data('stellar-elementIsActive', this);
        } else if ($this.data('stellar-elementIsActive') !== this) {
          return;
        }

        self.options.showElement($this);

        // Save/restore the original top and left CSS values in case we refresh the particles or destroy the instance
        if (!$this.data('stellar-startingLeft')) {
          $this.data('stellar-startingLeft', $this.css('left'));
          $this.data('stellar-startingTop', $this.css('top'));
        } else {
          $this.css('left', $this.data('stellar-startingLeft'));
          $this.css('top', $this.data('stellar-startingTop'));
        }

        positionLeft = $this.position().left;
        positionTop = $this.position().top;

        // Catch-all for margin top/left properties (these evaluate to 'auto' in IE7 and IE8)
        marginLeft = ($this.css('margin-left') === 'auto') ? 0 : parseInt($this.css('margin-left'), 10);
        marginTop = ($this.css('margin-top') === 'auto') ? 0 : parseInt($this.css('margin-top'), 10);

        offsetLeft = $this.offset().left - marginLeft;
        offsetTop = $this.offset().top - marginTop;

        // Calculate the offset parent
        $this.parents().each(function() {
          var $this = $(this);

          if ($this.data('stellar-offset-parent') === true) {
            parentOffsetLeft = tempParentOffsetLeft;
            parentOffsetTop = tempParentOffsetTop;
            $offsetParent = $this;

            return false;
          } else {
            tempParentOffsetLeft += $this.position().left;
            tempParentOffsetTop += $this.position().top;
          }
        });

        // Detect the offsets
        horizontalOffset = ($this.data('stellar-horizontal-offset') !== undefined ? $this.data('stellar-horizontal-offset') : ($offsetParent !== undefined && $offsetParent.data('stellar-horizontal-offset') !== undefined ? $offsetParent.data('stellar-horizontal-offset') : self.horizontalOffset));
        verticalOffset = ($this.data('stellar-vertical-offset') !== undefined ? $this.data('stellar-vertical-offset') : ($offsetParent !== undefined && $offsetParent.data('stellar-vertical-offset') !== undefined ? $offsetParent.data('stellar-vertical-offset') : self.verticalOffset));

        // Add our object to the particles collection
        self.particles.push({
          $element: $this,
          $offsetParent: $offsetParent,
          isFixed: $this.css('position') === 'fixed',
          horizontalOffset: horizontalOffset,
          verticalOffset: verticalOffset,
          startingPositionLeft: positionLeft,
          startingPositionTop: positionTop,
          startingOffsetLeft: offsetLeft,
          startingOffsetTop: offsetTop,
          parentOffsetLeft: parentOffsetLeft,
          parentOffsetTop: parentOffsetTop,
          stellarRatio: ($this.data('stellar-ratio') !== undefined ? $this.data('stellar-ratio') : 1),
          width: $this.outerWidth(true),
          height: $this.outerHeight(true),
          isHidden: false
        });
      });
    },
    _findBackgrounds: function() {
      var self = this,
        scrollLeft = this._getScrollLeft(),
        scrollTop = this._getScrollTop(),
        $backgroundElements;

      this.backgrounds = [];

      if (!this.options.parallaxBackgrounds) return;

      $backgroundElements = this.$element.find('[data-stellar-background-ratio]');

      if (this.$element.data('stellar-background-ratio')) {
                $backgroundElements = $backgroundElements.add(this.$element);
      }

      $backgroundElements.each(function() {
        var $this = $(this),
          backgroundPosition = getBackgroundPosition($this),
          horizontalOffset,
          verticalOffset,
          positionLeft,
          positionTop,
          marginLeft,
          marginTop,
          offsetLeft,
          offsetTop,
          $offsetParent,
          parentOffsetLeft = 0,
          parentOffsetTop = 0,
          tempParentOffsetLeft = 0,
          tempParentOffsetTop = 0;

        // Ensure this element isn't already part of another scrolling element
        if (!$this.data('stellar-backgroundIsActive')) {
          $this.data('stellar-backgroundIsActive', this);
        } else if ($this.data('stellar-backgroundIsActive') !== this) {
          return;
        }

        // Save/restore the original top and left CSS values in case we destroy the instance
        if (!$this.data('stellar-backgroundStartingLeft')) {
          $this.data('stellar-backgroundStartingLeft', backgroundPosition[0]);
          $this.data('stellar-backgroundStartingTop', backgroundPosition[1]);
        } else {
          setBackgroundPosition($this, $this.data('stellar-backgroundStartingLeft'), $this.data('stellar-backgroundStartingTop'));
        }

        // Catch-all for margin top/left properties (these evaluate to 'auto' in IE7 and IE8)
        marginLeft = ($this.css('margin-left') === 'auto') ? 0 : parseInt($this.css('margin-left'), 10);
        marginTop = ($this.css('margin-top') === 'auto') ? 0 : parseInt($this.css('margin-top'), 10);

        offsetLeft = $this.offset().left - marginLeft - scrollLeft;
        offsetTop = $this.offset().top - marginTop - scrollTop;

        // Calculate the offset parent
        $this.parents().each(function() {
          var $this = $(this);

          if ($this.data('stellar-offset-parent') === true) {
            parentOffsetLeft = tempParentOffsetLeft;
            parentOffsetTop = tempParentOffsetTop;
            $offsetParent = $this;

            return false;
          } else {
            tempParentOffsetLeft += $this.position().left;
            tempParentOffsetTop += $this.position().top;
          }
        });

        // Detect the offsets
        horizontalOffset = ($this.data('stellar-horizontal-offset') !== undefined ? $this.data('stellar-horizontal-offset') : ($offsetParent !== undefined && $offsetParent.data('stellar-horizontal-offset') !== undefined ? $offsetParent.data('stellar-horizontal-offset') : self.horizontalOffset));
        verticalOffset = ($this.data('stellar-vertical-offset') !== undefined ? $this.data('stellar-vertical-offset') : ($offsetParent !== undefined && $offsetParent.data('stellar-vertical-offset') !== undefined ? $offsetParent.data('stellar-vertical-offset') : self.verticalOffset));

        self.backgrounds.push({
          $element: $this,
          $offsetParent: $offsetParent,
          isFixed: $this.css('background-attachment') === 'fixed',
          horizontalOffset: horizontalOffset,
          verticalOffset: verticalOffset,
          startingValueLeft: backgroundPosition[0],
          startingValueTop: backgroundPosition[1],
          startingBackgroundPositionLeft: (isNaN(parseInt(backgroundPosition[0], 10)) ? 0 : parseInt(backgroundPosition[0], 10)),
          startingBackgroundPositionTop: (isNaN(parseInt(backgroundPosition[1], 10)) ? 0 : parseInt(backgroundPosition[1], 10)),
          startingPositionLeft: $this.position().left,
          startingPositionTop: $this.position().top,
          startingOffsetLeft: offsetLeft,
          startingOffsetTop: offsetTop,
          parentOffsetLeft: parentOffsetLeft,
          parentOffsetTop: parentOffsetTop,
          stellarRatio: ($this.data('stellar-background-ratio') === undefined ? 1 : $this.data('stellar-background-ratio'))
        });
      });
    },
    _reset: function() {
      var particle,
        startingPositionLeft,
        startingPositionTop,
        background,
        i;

      for (i = this.particles.length - 1; i >= 0; i--) {
        particle = this.particles[i];
        startingPositionLeft = particle.$element.data('stellar-startingLeft');
        startingPositionTop = particle.$element.data('stellar-startingTop');

        this._setPosition(particle.$element, startingPositionLeft, startingPositionLeft, startingPositionTop, startingPositionTop);

        this.options.showElement(particle.$element);

        particle.$element.data('stellar-startingLeft', null).data('stellar-elementIsActive', null).data('stellar-backgroundIsActive', null);
      }

      for (i = this.backgrounds.length - 1; i >= 0; i--) {
        background = this.backgrounds[i];

        background.$element.data('stellar-backgroundStartingLeft', null).data('stellar-backgroundStartingTop', null);

        setBackgroundPosition(background.$element, background.startingValueLeft, background.startingValueTop);
      }
    },
    destroy: function() {
      this._reset();

      this.$scrollElement.unbind('resize.' + this.name).unbind('scroll.' + this.name);
      this._animationLoop = $.noop;

      $(window).unbind('load.' + this.name).unbind('resize.' + this.name);
    },
    _setOffsets: function() {
      var self = this,
        $window = $(window);

      $window.unbind('resize.horizontal-' + this.name).unbind('resize.vertical-' + this.name);

      if (typeof this.options.horizontalOffset === 'function') {
        this.horizontalOffset = this.options.horizontalOffset();
        $window.bind('resize.horizontal-' + this.name, function() {
          self.horizontalOffset = self.options.horizontalOffset();
        });
      } else {
        this.horizontalOffset = this.options.horizontalOffset;
      }

      if (typeof this.options.verticalOffset === 'function') {
        this.verticalOffset = this.options.verticalOffset();
        $window.bind('resize.vertical-' + this.name, function() {
          self.verticalOffset = self.options.verticalOffset();
        });
      } else {
        this.verticalOffset = this.options.verticalOffset;
      }
    },
    _repositionElements: function() {
      var scrollLeft = this._getScrollLeft(),
        scrollTop = this._getScrollTop(),
        horizontalOffset,
        verticalOffset,
        particle,
        fixedRatioOffset,
        background,
        bgLeft,
        bgTop,
        isVisibleVertical = true,
        isVisibleHorizontal = true,
        newPositionLeft,
        newPositionTop,
        newOffsetLeft,
        newOffsetTop,
        i;

      // First check that the scroll position or container size has changed
      if (this.currentScrollLeft === scrollLeft && this.currentScrollTop === scrollTop && this.currentWidth === this.viewportWidth && this.currentHeight === this.viewportHeight) {
        return;
      } else {
        this.currentScrollLeft = scrollLeft;
        this.currentScrollTop = scrollTop;
        this.currentWidth = this.viewportWidth;
        this.currentHeight = this.viewportHeight;
      }

      // Reposition elements
      for (i = this.particles.length - 1; i >= 0; i--) {
        particle = this.particles[i];

        fixedRatioOffset = (particle.isFixed ? 1 : 0);

        // Calculate position, then calculate what the particle's new offset will be (for visibility check)
        if (this.options.horizontalScrolling) {
          newPositionLeft = (scrollLeft + particle.horizontalOffset + this.viewportOffsetLeft + particle.startingPositionLeft - particle.startingOffsetLeft + particle.parentOffsetLeft) * -(particle.stellarRatio + fixedRatioOffset - 1) + particle.startingPositionLeft;
          newOffsetLeft = newPositionLeft - particle.startingPositionLeft + particle.startingOffsetLeft;
        } else {
          newPositionLeft = particle.startingPositionLeft;
          newOffsetLeft = particle.startingOffsetLeft;
        }

        if (this.options.verticalScrolling) {
          newPositionTop = (scrollTop + particle.verticalOffset + this.viewportOffsetTop + particle.startingPositionTop - particle.startingOffsetTop + particle.parentOffsetTop) * -(particle.stellarRatio + fixedRatioOffset - 1) + particle.startingPositionTop;
          newOffsetTop = newPositionTop - particle.startingPositionTop + particle.startingOffsetTop;
        } else {
          newPositionTop = particle.startingPositionTop;
          newOffsetTop = particle.startingOffsetTop;
        }

        // Check visibility
        if (this.options.hideDistantElements) {
          isVisibleHorizontal = !this.options.horizontalScrolling || newOffsetLeft + particle.width > (particle.isFixed ? 0 : scrollLeft) && newOffsetLeft < (particle.isFixed ? 0 : scrollLeft) + this.viewportWidth + this.viewportOffsetLeft;
          isVisibleVertical = !this.options.verticalScrolling || newOffsetTop + particle.height > (particle.isFixed ? 0 : scrollTop) && newOffsetTop < (particle.isFixed ? 0 : scrollTop) + this.viewportHeight + this.viewportOffsetTop;
        }

        if (isVisibleHorizontal && isVisibleVertical) {
          if (particle.isHidden) {
            this.options.showElement(particle.$element);
            particle.isHidden = false;
          }

          this._setPosition(particle.$element, newPositionLeft, particle.startingPositionLeft, newPositionTop, particle.startingPositionTop);
        } else {
          if (!particle.isHidden) {
            this.options.hideElement(particle.$element);
            particle.isHidden = true;
          }
        }
      }

      // Reposition backgrounds
      for (i = this.backgrounds.length - 1; i >= 0; i--) {
        background = this.backgrounds[i];

        fixedRatioOffset = (background.isFixed ? 0 : 1);
        bgLeft = (this.options.horizontalScrolling ? (scrollLeft + background.horizontalOffset - this.viewportOffsetLeft - background.startingOffsetLeft + background.parentOffsetLeft - background.startingBackgroundPositionLeft) * (fixedRatioOffset - background.stellarRatio) + 'px' : background.startingValueLeft);
        bgTop = (this.options.verticalScrolling ? (scrollTop + background.verticalOffset - this.viewportOffsetTop - background.startingOffsetTop + background.parentOffsetTop - background.startingBackgroundPositionTop) * (fixedRatioOffset - background.stellarRatio) + 'px' : background.startingValueTop);

        setBackgroundPosition(background.$element, bgLeft, bgTop);
      }
    },
    _handleScrollEvent: function() {
      var self = this,
        ticking = false;

      var update = function() {
        self._repositionElements();
        ticking = false;
      };

      var requestTick = function() {
        if (!ticking) {
          requestAnimFrame(update);
          ticking = true;
        }
      };

      this.$scrollElement.bind('scroll.' + this.name, requestTick);
      requestTick();
    },
    _startAnimationLoop: function() {
      var self = this;

      this._animationLoop = function() {
        requestAnimFrame(self._animationLoop);
        self._repositionElements();
      };
      this._animationLoop();
    }
  };

  $.fn[pluginName] = function (options) {
    var args = arguments;
    if (options === undefined || typeof options === 'object') {
      return this.each(function () {
        if (!$.data(this, 'plugin_' + pluginName)) {
          $.data(this, 'plugin_' + pluginName, new Plugin(this, options));
        }
      });
    } else if (typeof options === 'string' && options[0] !== '_' && options !== 'init') {
      return this.each(function () {
        var instance = $.data(this, 'plugin_' + pluginName);
        if (instance instanceof Plugin && typeof instance[options] === 'function') {
          instance[options].apply(instance, Array.prototype.slice.call(args, 1));
        }
        if (options === 'destroy') {
          $.data(this, 'plugin_' + pluginName, null);
        }
      });
    }
  };

  $[pluginName] = function(options) {
    var $window = $(window);
    return $window.stellar.apply($window, Array.prototype.slice.call(arguments, 0));
  };

  // Expose the scroll and position property function hashes so they can be extended
  $[pluginName].scrollProperty = scrollProperty;
  $[pluginName].positionProperty = positionProperty;

  // Expose the plugin class so it can be modified
  window.Stellar = Plugin;
}(jQuery, this, document));



(function(a){function d(b){var c=b||window.event,d=[].slice.call(arguments,1),e=0,f=!0,g=0,h=0;return b=a.event.fix(c),b.type="mousewheel",c.wheelDelta&&(e=c.wheelDelta/120),c.detail&&(e=-c.detail/3),h=e,c.axis!==undefined&&c.axis===c.HORIZONTAL_AXIS&&(h=0,g=-1*e),c.wheelDeltaY!==undefined&&(h=c.wheelDeltaY/120),c.wheelDeltaX!==undefined&&(g=-1*c.wheelDeltaX/120),d.unshift(b,e,g,h),(a.event.dispatch||a.event.handle).apply(this,d)}var b=["DOMMouseScroll","mousewheel"];if(a.event.fixHooks)for(var c=b.length;c;)a.event.fixHooks[b[--c]]=a.event.mouseHooks;a.event.special.mousewheel={setup:function(){if(this.addEventListener)for(var a=b.length;a;)this.addEventListener(b[--a],d,!1);else this.onmousewheel=d},teardown:function(){if(this.removeEventListener)for(var a=b.length;a;)this.removeEventListener(b[--a],d,!1);else this.onmousewheel=null}},a.fn.extend({mousewheel:function(a){return a?this.bind("mousewheel",a):this.trigger("mousewheel")},unmousewheel:function(a){return this.unbind("mousewheel",a)}})})(jQuery)



;(function($) {
    'use strict';

    $.srSmoothscroll = function(options) {

    var self = $.extend({
        step: 55,
        speed: 200,
        t: $(window).scrollTop(),
        ease: "swing"
    }, options || {});

    // private fields & init
    var win = $(window),
        doc = $(document),
        top = self.t,
        step = self.step,
        speed = self.speed,
        viewport = win.height(),
        body = (navigator.userAgent.indexOf('AppleWebKit') !== -1) ? $('body') : $('html'),
        wheel = false;

    // events
    $('body').mousewheel(function(event, delta) {
        wheel = true;

        if (delta < 0) // down
            top = (top+viewport) >= doc.height() ? top : top+=step;

        else // up
            top = top <= 0 ? 0 : top-=step;

        body.stop().animate({scrollTop: top}, speed, self.ease, function () {
            wheel = false;
        });

        return false;
    });

    $(".onsrSm , .selectBox-dropdown-menu, .i-sc").on("mouseenter mouseleave",function(e){
        if(e.type == "mouseenter"){
             $('body').off("mousewheel");
        }else{
            $.srSmoothscroll({
              // defaults
              step: 100,
              speed: 300,
              ease: 'swing',
              target: $('body'),
              container: $(window)
            });

        }
    });

    win
    .on('resize', function (e) {
        viewport = win.height();
    })
    .on('scroll', function (e) {
        if (!wheel)
            top = win.scrollTop();
    });

    };
})(jQuery);



!function(e,t){if("function"==typeof define&&define.amd)define(["exports"],t);else if("undefined"!=typeof exports)t(exports);else{var o={};t(o),e.bodyScrollLock=o}}(this,function(exports){"use strict";function r(e){if(Array.isArray(e)){for(var t=0,o=Array(e.length);t<e.length;t++)o[t]=e[t];return o}return Array.from(e)}Object.defineProperty(exports,"__esModule",{value:!0});var l=!1;if("undefined"!=typeof window){var e={get passive(){l=!0}};window.addEventListener("testPassive",null,e),window.removeEventListener("testPassive",null,e)}var d="undefined"!=typeof window&&window.navigator&&window.navigator.platform&&/iP(ad|hone|od)/.test(window.navigator.platform),c=[],u=!1,a=-1,s=void 0,v=void 0,f=function(t){return c.some(function(e){return!(!e.options.allowTouchMove||!e.options.allowTouchMove(t))})},m=function(e){var t=e||window.event;return!!f(t.target)||(1<t.touches.length||(t.preventDefault&&t.preventDefault(),!1))},o=function(){setTimeout(function(){void 0!==v&&(document.body.style.paddingRight=v,v=void 0),void 0!==s&&(document.body.style.overflow=s,s=void 0)})};exports.disableBodyScroll=function(i,e){if(d){if(!i)return void console.error("disableBodyScroll unsuccessful - targetElement must be provided when calling disableBodyScroll on IOS devices.");if(i&&!c.some(function(e){return e.targetElement===i})){var t={targetElement:i,options:e||{}};c=[].concat(r(c),[t]),i.ontouchstart=function(e){1===e.targetTouches.length&&(a=e.targetTouches[0].clientY)},i.ontouchmove=function(e){var t,o,n,r;1===e.targetTouches.length&&(o=i,r=(t=e).targetTouches[0].clientY-a,!f(t.target)&&(o&&0===o.scrollTop&&0<r?m(t):(n=o)&&n.scrollHeight-n.scrollTop<=n.clientHeight&&r<0?m(t):t.stopPropagation()))},u||(document.addEventListener("touchmove",m,l?{passive:!1}:void 0),u=!0)}}else{n=e,setTimeout(function(){if(void 0===v){var e=!!n&&!0===n.reserveScrollBarGap,t=window.innerWidth-document.documentElement.clientWidth;e&&0<t&&(v=document.body.style.paddingRight,document.body.style.paddingRight=t+"px")}void 0===s&&(s=document.body.style.overflow,document.body.style.overflow="hidden")});var o={targetElement:i,options:e||{}};c=[].concat(r(c),[o])}var n},exports.clearAllBodyScrollLocks=function(){d?(c.forEach(function(e){e.targetElement.ontouchstart=null,e.targetElement.ontouchmove=null}),u&&(document.removeEventListener("touchmove",m,l?{passive:!1}:void 0),u=!1),c=[],a=-1):(o(),c=[])},exports.enableBodyScroll=function(t){if(d){if(!t)return void console.error("enableBodyScroll unsuccessful - targetElement must be provided when calling enableBodyScroll on IOS devices.");t.ontouchstart=null,t.ontouchmove=null,c=c.filter(function(e){return e.targetElement!==t}),u&&0===c.length&&(document.removeEventListener("touchmove",m,l?{passive:!1}:void 0),u=!1)}else 1===c.length&&c[0].targetElement===t?(o(),c=[]):c=c.filter(function(e){return e.targetElement!==t})}});


/*================================================================================
 * @name: bPopup - if you can't get it up, use bPopup
 * @author: (c)Bjoern Klinggaard (twitter@bklinggaard)
 * @demo: http://dinbror.dk/bpopup
 * @version: 0.11.0.min
 ================================================================================*/
 (function(c){c.fn.bPopup=function(A,E){function L(){a.contentContainer=c(a.contentContainer||b);switch(a.content){case "iframe":var d=c('<iframe class="b-iframe" '+a.iframeAttr+"></iframe>");d.appendTo(a.contentContainer);t=b.outerHeight(!0);u=b.outerWidth(!0);B();d.attr("src",a.loadUrl);l(a.loadCallback);break;case "image":B();c("<img />").load(function(){l(a.loadCallback);F(c(this))}).attr("src",a.loadUrl).hide().appendTo(a.contentContainer);break;default:B(),c('<div class="b-ajax-wrapper"></div>').load(a.loadUrl,a.loadData,function(d,b,e){l(a.loadCallback,b);F(c(this))}).hide().appendTo(a.contentContainer)}}function B(){a.modal&&c('<div class="b-modal '+e+'"></div>').css({backgroundColor:a.modalColor,position:"fixed",top:0,right:0,bottom:0,left:0,opacity:0,zIndex:a.zIndex+v}).appendTo(a.appendTo).fadeTo(a.speed,a.opacity);C();b.data("bPopup",a).data("id",e).css({left:"slideIn"==a.transition||"slideBack"==a.transition?"slideBack"==a.transition?f.scrollLeft()+w:-1*(x+u):m(!(!a.follow[0]&&n||g)),position:a.positionStyle||"absolute",top:"slideDown"==a.transition||"slideUp"==a.transition?"slideUp"==a.transition?f.scrollTop()+y:z+-1*t:p(!(!a.follow[1]&&q||g)),"z-index":a.zIndex+v+1}).each(function(){a.appending&&c(this).appendTo(a.appendTo)});G(!0)}function r(){a.modal&&c(".b-modal."+b.data("id")).fadeTo(a.speed,0,function(){c(this).remove()});a.scrollBar||c("html").css("overflow","auto");c(".b-modal."+e).unbind("click");f.unbind("keydown."+e);k.unbind("."+e).data("bPopup",0<k.data("bPopup")-1?k.data("bPopup")-1:null);b.undelegate(".bClose, ."+a.closeClass,"click."+e,r).data("bPopup",null);clearTimeout(H);G();return!1}function I(d){y=k.height();w=k.width();h=D();if(h.x||h.y)clearTimeout(J),J=setTimeout(function(){C();d=d||a.followSpeed;var e={};h.x&&(e.left=a.follow[0]?m(!0):"auto");h.y&&(e.top=a.follow[1]?p(!0):"auto");b.dequeue().each(function(){g?c(this).css({left:x,top:z}):c(this).animate(e,d,a.followEasing)})},50)}function F(d){var c=d.width(),e=d.height(),f={};a.contentContainer.css({height:e,width:c});e>=b.height()&&(f.height=b.height());c>=b.width()&&(f.width=b.width());t=b.outerHeight(!0);u=b.outerWidth(!0);C();a.contentContainer.css({height:"auto",width:"auto"});f.left=m(!(!a.follow[0]&&n||g));f.top=p(!(!a.follow[1]&&q||g));b.animate(f,250,function(){d.show();h=D()})}function M(){k.data("bPopup",v);b.delegate(".bClose, ."+a.closeClass,"click."+e,r);a.modalClose&&c(".b-modal."+e).css("cursor","pointer").bind("click",r);N||!a.follow[0]&&!a.follow[1]||k.bind("scroll."+e,function(){if(h.x||h.y){var d={};h.x&&(d.left=a.follow[0]?m(!g):"auto");h.y&&(d.top=a.follow[1]?p(!g):"auto");b.dequeue().animate(d,a.followSpeed,a.followEasing)}}).bind("resize."+e,function(){I()});a.escClose&&f.bind("keydown."+e,function(a){27==a.which&&r()})}function G(d){function c(e){b.css({display:"block",opacity:1}).animate(e,a.speed,a.easing,function(){K(d)})}switch(d?a.transition:a.transitionClose||a.transition){case "slideIn":c({left:d?m(!(!a.follow[0]&&n||g)):f.scrollLeft()-(u||b.outerWidth(!0))-200});break;case "slideBack":c({left:d?m(!(!a.follow[0]&&n||g)):f.scrollLeft()+w+200});break;case "slideDown":c({top:d?p(!(!a.follow[1]&&q||g)):f.scrollTop()-(t||b.outerHeight(!0))-200});break;case "slideUp":c({top:d?p(!(!a.follow[1]&&q||g)):f.scrollTop()+y+200});break;default:b.stop().fadeTo(a.speed,d?1:0,function(){K(d)})}}function K(d){d?(M(),l(E),a.autoClose&&(H=setTimeout(r,a.autoClose))):(b.hide(),l(a.onClose),a.loadUrl&&(a.contentContainer.empty(),b.css({height:"auto",width:"auto"})))}function m(a){return a?x+f.scrollLeft():x}function p(a){return a?z+f.scrollTop():z}function l(a,e){c.isFunction(a)&&a.call(b,e)}function C(){z=q?a.position[1]:Math.max(0,(y-b.outerHeight(!0))/2-a.amsl);x=n?a.position[0]:(w-b.outerWidth(!0))/2;h=D()}function D(){return{x:w>b.outerWidth(!0),y:y>b.outerHeight(!0)}}c.isFunction(A)&&(E=A,A=null);var a=c.extend({},c.fn.bPopup.defaults,A);a.scrollBar||c("html").css("overflow","hidden");var b=this,f=c(document),k=c(window),y=k.height(),w=k.width(),N=/OS 6(_\d)+/i.test(navigator.userAgent),v=0,e,h,q,n,g,z,x,t,u,J,H;b.close=function(){r()};b.reposition=function(a){I(a)};return b.each(function(){c(this).data("bPopup")||(l(a.onOpen),v=(k.data("bPopup")||0)+1,e="__b-popup"+v+"__",q="auto"!==a.position[1],n="auto"!==a.position[0],g="fixed"===a.positionStyle,t=b.outerHeight(!0),u=b.outerWidth(!0),a.loadUrl?L():B())})};c.fn.bPopup.defaults={amsl:50,appending:!0,appendTo:"body",autoClose:!1,closeClass:"b-close",content:"ajax",contentContainer:!1,easing:"swing",escClose:!0,follow:[!0,!0],followEasing:"swing",followSpeed:500,iframeAttr:'scrolling="no" frameborder="0"',loadCallback:!1,loadData:!1,loadUrl:!1,modal:!0,modalClose:!0,modalColor:"#000",onClose:!1,onOpen:!1,opacity:.7,position:["auto","auto"],positionStyle:"absolute",scrollBar:!0,speed:250,transition:"fadeIn",transitionClose:!1,zIndex:9997}})(jQuery);