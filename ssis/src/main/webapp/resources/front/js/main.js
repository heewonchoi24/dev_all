 var bxSlide;
  var bxAuto;
  var bxSpeed = 7000;
  var $bxPlayBtns = $("#spot.main .bx-play");


  $bxPlayBtns.on("click",function(){
    var $this = $(this);

    if(!$this.hasClass("on")){
      bxPlayBtn(true);
      $this.addClass("on");
    }else{
      bxPlayBtn(false);
      $this.removeClass("on");
    }

  });

  function bxPlayBtn(t){
    if(t){
      clearInterval(bxAuto);
      bxAuto = null;

      //console.log("stop");
    }else{
      setTimeout(function(){
        bxSlide.goToNextSlide();
        bxPageAuto();
      },500);

      //console.log("play");
    }
  }

  if($("#bxMain").find(".lst").length <= 1){
      $bxPlayBtns.remove();
  }else{

    bxSlide = $("#bxMain").bxSlider({
       mode: 'fade',
       auto: false,
       controls:false,
       autoControls: true,
       //randomStart:true,
       //stopAuto: true,
       speed:600,
       pause:6000,
       swipeThreshold:150,
        onSliderLoad: function(currentIndex){
           var  currentIndex = "#bxMain > .lst:eq("+currentIndex+")"
           motion(currentIndex);
        },
        onSlideBefore: function(currentIndex){
          motion(currentIndex);
        },
        onSlideAfter: function(currentIndex){}
      });


  }





    function bxPageAuto(sp){
      clearInterval(bxAuto);
      bxAuto = setInterval(function(){
        bxSlide.goToNextSlide();
      },bxSpeed);
    }


    bxPageAuto();



    function motion(currentIndex){
         var index = $(currentIndex).data("num");
         var $cont = $(currentIndex).find(".cont");
         var tl = new TimelineMax(),
             t2 = new TimelineMax();

             //console.log("play" + index);


           TweenMax.set($cont.find(".t1"),{opacity:0,y:30});
           TweenMax.set($cont.find(".t2"),{opacity:0,y:30});
           TweenMax.set($cont.find(".t3"),{opacity:0,y:30});
           TweenMax.set($cont.find(".btns"),{opacity:0,x:30});
           TweenMax.to($cont.find(".t1"),0.6,{opacity:1,y:0,delay:0});
           TweenMax.to($cont.find(".t2"),0.6,{opacity:1,y:0,delay:0.3});
           TweenMax.to($cont.find(".t3"),0.6,{opacity:1,y:0,delay:0.6});
           TweenMax.to($cont.find(".btns"),0.6,{opacity:1,x:0,delay:0.9});
           setTimeout(function(){
              $cont.find(".t,.btns").each(function(){ $(this).css({"opacity":"", "transform":""});})
                // $cont.find("").css({
                //   "opacity":"",
                //   "transform":""
                // });

           },1600);


         //  tl.staggerFrom($cont.find(".t"), 0.4, {
         //    opacity:0,
         //    y:[30],
         //    //ease:Back.easeOut.config(3),
         //    delay:0.2
         // },0.2)
         //  tl.from($cont.find(".btns"), 0.8, {opacity:0, x:50, ease:Back.easeOut.config(1) },"-=0.2");

          if($(currentIndex).find(".cont .wrap-step-type1").length > 0){

            TweenMax.set($(currentIndex).find(".cont .wrap-step-type1 .line"),{width:0,left:"50%"});
            TweenMax.to($(currentIndex).find(".cont .wrap-step-type1 .line"),0.6,{width:"100%",left:0});
            $(currentIndex).find(".cont .wrap-step-type1").addClass("on");

             TweenMax.set($(currentIndex).find(".cont .wrap-step-type1 .step.n1 .circle"),{opacity:0,x:30});
             TweenMax.set($(currentIndex).find(".cont .wrap-step-type1 .step.n2 .circle"),{opacity:0,x:30});
             TweenMax.set($(currentIndex).find(".cont .wrap-step-type1 .step.n3 .circle"),{opacity:0,x:30});
             TweenMax.set($(currentIndex).find(".cont .wrap-step-type1 .step.n4 .circle"),{opacity:0,x:30});

             TweenMax.to($(currentIndex).find(".cont .wrap-step-type1 .step.n1 .circle"),0.6,{opacity:1,x:0,delay:0});
             TweenMax.to($(currentIndex).find(".cont .wrap-step-type1 .step.n2 .circle"),0.6,{opacity:1,x:0,delay:0.3});
             TweenMax.to($(currentIndex).find(".cont .wrap-step-type1 .step.n3 .circle"),0.6,{opacity:1,x:0,delay:0.6});
             TweenMax.to($(currentIndex).find(".cont .wrap-step-type1 .step.n4 .circle"),0.6,{opacity:1,x:0,delay:0.9});


             TweenMax.set($(currentIndex).find(".cont .wrap-step-type1 .step.n1 .step_tit1"),{opacity:0,y:20});
             TweenMax.set($(currentIndex).find(".cont .wrap-step-type1 .step.n2 .step_tit1"),{opacity:0,y:20});
             TweenMax.set($(currentIndex).find(".cont .wrap-step-type1 .step.n3 .step_tit1"),{opacity:0,y:20});
             TweenMax.set($(currentIndex).find(".cont .wrap-step-type1 .step.n4 .step_tit1"),{opacity:0,y:20});

             TweenMax.to($(currentIndex).find(".cont .wrap-step-type1 .step.n1 .step_tit1"),0.6,{opacity:1,y:0,delay:0});
             TweenMax.to($(currentIndex).find(".cont .wrap-step-type1 .step.n2 .step_tit1"),0.6,{opacity:1,y:0,delay:0.3});
             TweenMax.to($(currentIndex).find(".cont .wrap-step-type1 .step.n3 .step_tit1"),0.6,{opacity:1,y:0,delay:0.6});
             TweenMax.to($(currentIndex).find(".cont .wrap-step-type1 .step.n4 .step_tit1"),0.6,{opacity:1,y:0,delay:0.9});

              setTimeout(function(){
                $(currentIndex).find(".cont .wrap-step-type1 .circle").each(function(){ $(this).css({"opacity":"", "transform":""});})
             },1600);

           };//if

          // t2.from($(currentIndex).find(".cont .wrap-step-type1 .line"), 0.6, { width:0,left:"50%", ease:Back.easeOut.config(1) },"+=0.7");

          // t2.staggerFrom($(currentIndex).find(".cont .wrap-step-type1 .circle"), 0.4, {
          //     opacity:0,
          //     x:[30]
          //     //ease:Back.easeOut.config(3),
          //     //delay:0.3
          //  },0.2)
          // };







    }