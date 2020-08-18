var WinWdith = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
var mySideScroll ,myHomeScroll1 = false,myHomeScroll2 = false,myHomeScroll3 = false,myHomeScroll4 = false,myHomeScroll5 = false,myHomeScroll6 = false;


var wideFlag = false,
        normalFlag = false , 
        tablet1Flag = false , 
        tablet2Flag = false,   
        mobile1Flag = false, 
        mobile2Flag = false

var scrollStartFlag = false
var scrollIngFlag = false

function goBack() {
    window.history.back()
}

function pageInfo(pNum,sNum,tNum){
  var pageNum = pNum;
  var subNum = sNum;
  var threeNum = tNum;
  var pathFlag = false;
  var pathIndex = 0;
  var pathbox = $('<div class="layerPathBox"><div class="inner"></div></div>');
  var dep1txt = $(".path > .depth.dep1").find(".s"+pageNum+" > a").text();
  var dep1href = $(".path > .depth.dep1").find(".s"+pageNum+" > a").attr("href");
  var dep2txt = $(".path > .depth.dep2").find(".s"+subNum+" > a").text();
  var dep2href = $(".path > .depth.dep2").find(".s"+subNum+" > a").attr("href");
  $(".path > .depth.dep1 > a").text(dep1txt).attr("href",dep1href);
  $(".path > .depth.dep2 > a").text(dep2txt).attr("href",dep2href);

  if(pageNum > 0 && pageNum <= 5){
    $("#lnb .list > li.on").removeClass("on");
    $("#lnb .list > li.m"+pageNum).addClass("on");
  }


  function pathMotion(e){
    e.preventDefault();
    
    if(pathIndex != $(this).parent().index()){
        pathIndex = $(this).parent().index();
        var positionLeft = Math.round( $(this).position().left +  $(this).parent().position().left + parseInt($("#container_sub .path > .depth").css("margin-left")) -1 );
        var lst = $(this).next().find(">ul").clone();
        if (!pathFlag) { 
          $(".path").append(pathbox.css({"display":"block","height":0}));
        }//pathFlag
        if($(".path").find(".layerPathBox .inner").find(">ul").length > 0){
            
            $(".path").find(".layerPathBox .inner").animate({
              "left":-($(".path").find(".layerPathBox").find("ul").outerWidth(true))
            },500,function(){
              $(this).find(">ul:first").remove();
              $(this).css("left",0);
            });
        }

        $(".path").find(".layerPathBox .inner").append(lst);
          if (!pathFlag) {
            pathbox.css({"left":positionLeft}).stop().animate({
              "height":lst.outerHeight()
            },500);
          }else{
            pathbox.stop().animate({
              "left":positionLeft,
              "height":lst.outerHeight()
            },500);

          }
        
        pathFlag = true;
    }else{
      reSet();
        
    } 
    function reSet(){
      $(".path").find(".layerPathBox").slideUp(300,function(){$(this).find("ul").remove().end().remove()});
        pathIndex = 0;
        pathFlag = false;
        $(window).off("resize");
    }
    $(window),off("resize.pageInfo").on("resize.pageInfo",reSet)  ;
  };//pathMotion

  function pathMotion2(e){
    e.preventDefault();
    $(".path > .depth").each(function(){
        $(this).find(".path_dep").slideUp(400);
      });
    if($(this).next().css("display") == "none"){
      $(this).next().slideToggle(400);
    }else{
    }
    

  };
  //$(".path > .depth > a").on("click",pathMotion);
  $(".path > .depth > a").off("click.pageInfo").on("click.pageInfo",pathMotion2);

}//pageInfo


 function resizeEvent(w){
    var win = $(window),
    doc = $(document),
    width = w,
    step = self.step,
    speed = self.speed,
    viewport = win.height(),
    body = (navigator.userAgent.indexOf('AppleWebKit') !== -1) ? $('body') : $('html');
    con("width:::::"+width);

    var wide = 1280,
    noamal = 1024,
    tablet = 768,
    mobile = 640,
    mobile2 = 420
   
    if(width > wide ){ // 1281
      WideMotion();
    }else if(width <= wide && width > noamal ){ // 1280 ~ 1025
      normalMotion();
    }else if(width <= noamal && width > tablet ){ // 1023 ~ 769
      tablet1Motion();
    }else if(width <= tablet && width > mobile ){ //768 ~ 641
      tablet2Motion();   
    }else if(width <= mobile && width >= mobile2 ){ //640 ~ 420
      mobile1Motion();   
    }else if(width <= mobile2-1 && width >= 320 ){ //419 ~ 320
      mobile2Motion();       
    }

    function WideMotion(){
      if(!wideFlag){
        con("1281");
        //topFIxedMotion(false,false);
      }//if
      wideFlag = true;
      normalFlag = false;
      tablet1Flag = false;
      tablet2Flag = false;
      mobile1Flag = false;           
      mobile2Flag = false;           
    }

      function normalMotion(){
      if(!normalFlag){
        con("1280 ~ 1025");
         //topFIxedMotion(false,false);
      }//if
      wideFlag = false;
      normalFlag = true;
      tablet1Flag = false;
      tablet2Flag = false;
      mobile1Flag = false;           
      mobile2Flag = false;             
    }

     function tablet1Motion(){
      if(!tablet1Flag){
       con("1023 ~ 769");
        //topFIxedMotion(true,true);
      }//if
      wideFlag = false;
      normalFlag = false;
      tablet1Flag = true;
      tablet2Flag = false;
      mobile1Flag = false;           
      mobile2Flag = false;             
    }

     function tablet2Motion(){
      if(!tablet2Flag){
        con("768 ~ 641");
       // topFIxedMotion(true,true);
        //console.log("tablet2Flag")
      }//if
      wideFlag = false;
      normalFlag = false;
      tablet1Flag = false;
      tablet2Flag = true;
      mobile1Flag = false;           
      mobile2Flag = false;             
    }

     function mobile1Motion(){
      if(!mobile1Flag){
        con("640 ~ 421");
        //topFIxedMotion(true,true);
        //console.log("모바일 영역1")
      }//if
      wideFlag = false;
      normalFlag = false;
      tablet1Flag = false;
      tablet2Flag = false;
      mobile1Flag = true;           
      mobile2Flag = false;             
    }

     function mobile2Motion(){
      if(!mobile2Flag){
        con("419 ~ 320");
        //topFIxedMotion(true,true);
        //console.log("모바일 영역")
      }//if
      wideFlag = false;
      normalFlag = false;
      tablet1Flag = false;
      tablet2Flag = false;
      mobile1Flag = false;           
      mobile2Flag = true;             
    }
  };

  function scrollTopEvent(w){
    
    var win = $(window),
    doc = $(document),
    body = (navigator.userAgent.indexOf('AppleWebKit') !== -1) ? $('body') : $('html');
    var top = win.scrollTop();
    con("scroll:::::"+top);

    if(w >  960){
        if(top <= 41 ){
          startScroll();
        }else{
          ingScroll();
        }
    }else{
      //topFIxedMotion(false,true);

    }

    function startScroll(){
      //console.log("start-Start:::"+scrollStartFlag); 
      //console.log("start-Ing:::"+scrollIngFlag); 
      if(!scrollStartFlag){
        //console.log("start");
        //상단 모션
        //topFIxedMotion(false,false);

      }//if
      scrollStartFlag = true;
      scrollIngFlag = false;
      
    }

      function ingScroll(){
      //console.log("ing-Start:::"+scrollStartFlag); 
      //console.log("ing-Ing:::"+scrollIngFlag); 
      if(!scrollIngFlag){
       //console.log("ing");
        //상단 모션
       // topFIxedMotion(true,false);

      }//if
      scrollStartFlag = false;
      scrollIngFlag = true;
      
    }


  
  };




  //


$(window).resize(function(){
  var width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
  resizeEvent(width);
  scrollTopEvent(width);
})

  $(window).on("scroll",function(){
    var width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
   scrollTopEvent(width);
  })
  




scrollTopEvent(WinWdith);
resizeEvent(WinWdith);











//인풋 라벨 숨김
function LabelHidden(obj){
$(obj).each(function(){
     
     if($(this)[0].tagName == "INPUT"){
        var $input = $(this);
     }else{
        var $input = $(this).find("input");
     }

      
        if($input.val() != ""){
            $(this).siblings("label").css("display","none");  
          }
          

          $input.on("change" , function(e){
            
            
            if($(this).val() != ""){
               if($(this).prev("label").length > 0){
                    $(this).prev("label").css("display","none"); 
                  }else{
                    $(this).parent().prev("label").css("display","none"); 
                  }
            }

          });
           $input.prev("label").on("click",function(){
              $(this).css("display","none").next().focus(); 
           }); 
          $input.on("focusin focusout" , function(e){
            
            if(e.type == "focusin" ) {
              if($(this).prev("label").length > 0){
                    $(this).prev("label").css("display","none");
                  }else{
                    $(this).parent().prev("label").css("display","none"); 
                  }
            }else{
              if($(this).val() == ""){
                 if($(this).prev("label").length > 0){
                    $(this).prev("label").css("display","block"); 
                  }else{
                    $(this).parent().prev("label").css("display","block"); 
                  }
              }
            }
          });//focusin focusout

  });//each
};//LabelHidden

function checkListMotion(obj){
  if(obj == undefined){
    var o = $(".lst_check");
  }else{
    var o = $(obj);
  }

    o.each(function(){
      //if($(this).hasClass("radio")){
        var $this = $(this)
        var prev;
        $this.find(">span").each(function(){
          if($(this).find(" > input").prop("checked")){
            $(this).addClass("on");
          } 
        });//each
      //}else{


      //}//if
    }); //each

    o.find(" > span > label").off().on("click",function(){
      if($(this).parent().parent().hasClass("radio")){
       $(this).parent().siblings(".on").removeClass("on").end().addClass("on");
     }else{
      $(this).parent().toggleClass("on");
     }//if

  });
}

/*탭/셀렉터 변환*/
function tabTransformation(num){
  var transType1Flag = false;
  var transType2Flag = false;
  var bodyId = $("#tabType1Body");
  var tabArea = $('.tabType1');
  var tabHeadline = tabArea.find('.h_tab');
  var tabLst = tabArea.find(">ul");
  var dataLink = tabLst.find("> li:eq("+(num-1)+") >a").data("src");
  
  
  tabHeadline.on("click",function(){
    if(tabLst.css("display") == "block"){
      $(this).removeClass("on");
      tabLst.slideUp(300);
    }else{
      $(this).addClass("on");
      tabLst.slideDown(300);
    }
    
  });
  tabArea.on("mouseleave",function(){
    if(tabHeadline.hasClass("on")){
      tabHeadline.removeClass("on");
      tabLst.slideUp(300);
    }

  });



    function ajaxStart(d,num){
    	/*본문호출*/
	$.ajax({
	  url : d,
	  type : "get",
	  ansync : false,
	  dataType:"html",
	  success : function(data) {
            if(bodyId.height() > 10) bodyId.css("min-height","").css("min-height",bodyId.outerHeight());
            $("<div id='tmpData' style='visibility: hidden;'></div>").html(data).appendTo(bodyId);
            var data2 = bodyId.find("#tmpData").html();        
            $("#tmpData").remove();
            bodyId.children().remove();
            tabLst.find("> li.on").removeClass("on").end().find("> li:eq("+num+")").addClass("on");
            tabHeadline.find("button").text(tabLst.find("> li.on >  a").text());
            bodyId.append(data2).find("> *").css({"opacity":0});
            
	      bodyId.imagesLoaded(function(){
	      bodyId.find("> *").delay(300).animate({"opacity":1},1000,function(){  });
              
	      /*	for(var i=0; i < bodyId.find("> *").length; i++ ){
	      		console.log(i)
	      		
	      	}*/
	      	
	      });//imagesLoaded
	  },
	  error : function(xhr, status, error) {
	    alert("준비중입니다.");
	  }
	 }); 	  

    }	
 	

  function tabResize(){
    var width = $(window).width();
    if(width >  990){
       transType1();
      }else{
       transType2();
      }

    function transType1(){
      if(!transType1Flag){
        //width >  990
        tabLst.find("> li >a").off("click.tranClick");
        tabLst.css("display","block");

      }//if
      transType1Flag = true;
      transType2Flag = false;
    }

      function transType2(){
      if(!transType2Flag){
        //width <  990
        tabLst.css("display","none");        
        tabLst.find("> li >a").on("click.tranClick",function(){
          tabLst.slideUp(300);
        });


      }//if
      transType1Flag = false;
      transType2Flag = true;
    }

  }
  tabLst.find(">li>a").on("click",function(e){
    e.preventDefault();
  	var link = $(this).data("src");
  	var num = $(this).parent().index();
      //$("html,body").stop().animate({scrollTop:tabArea.offset().top - 80 },300)
  	ajaxStart(link,num);

  	return false;
  });
  $(window).on("resize",tabResize);
  tabResize();
  ajaxStart(dataLink,num-1);
}//tabTransformation


/*탭/셀렉터 변환*/
function tabTransformation2(obj,num){
  var transType1Flag = false;
  var transType2Flag = false;
  var tabArea = $(obj);
  var tabHeadline = tabArea.find('.h_tab');
  var tabLst = tabArea.find(">ul");
  var dataLink = tabLst.find("> li:eq("+(num-1)+") >a").data("src");
  
  tabHeadline.on("click",function(){
    if(tabLst.css("display") == "block"){
      $(this).removeClass("on");
      tabLst.slideUp(300);
      
    }else{
      $(this).addClass("on");
      tabLst.slideDown(300);
    }
    
  });
   
  tabArea.on("mouseleave",function(){
    if(tabHeadline.hasClass("on")){
      tabHeadline.removeClass("on");
      tabLst.slideUp(300);
    }

  });

  

  function tabResize(){
    var width = $(window).width();
    if(width >  990){
       transType1();
      }else{
       transType2();
      }

    function transType1(){
      if(!transType1Flag){
        //width >  990
        tabLst.css("display","block").removeClass("trans");        
        tabLst.find("> li >a").off("click.tranClick");

      }//if
      transType1Flag = true;
      transType2Flag = false;
    }

      function transType2(){
      if(!transType2Flag){
        //width <  990
        tabLst.css("display","none").addClass("trans");
        tabLst.find("> li >a").on("click.tranClick",function(){
          tabLst.slideUp(300);
        });


      }//if
      transType1Flag = false;
      transType2Flag = true;
    }

  }
 /* tabLst.find(">li>a").on("click",function(e){
    e.preventDefault();
    var link = $(this).data("src");
    var num = $(this).parent().index();
      //$("html,body").stop().animate({scrollTop:tabArea.offset().top - 80 },300)
    //ajaxStart(link,num);

    return false;
  });*/
  $(window).on("resize",tabResize);
  tabResize();
  
}//tabTransformation






 //로그인 
 function layerPopup(o){
  var obj = $(o);
  var close =obj.find(".close");
    if(obj.css("display") == "block"){
      $("#cover").animate({"opacity":0},600,function(){$(this).remove();});
      obj.stop().animate({"margin-top":-50,"opacity":0},500,function(){
        $(this).css("display","none");
      });
    }else{
      obj.css({
        "display":"block",
        "opacity":0,
        "margin-top":-50,
        "top":$(window).scrollTop() + 50
      }).stop().animate({"margin-top":0,"opacity":1},500);


        
        if(isie7 || isie8){

             var backgound = $("<div>").attr({
                 "id": "cover"
               }).css({
                 "width": "100%",
                 "height": $("body").outerHeight(),
                 "z-index":100,
                 "display":"block"
               })
        	$("#cover").css({"display":"block"},600);	
        }else{

             var backgound = $("<div>").attr({
                 "id": "cover"
               }).css({
                 "width": "100%",
                 "height": $("body").outerHeight(),
                 "z-index":100,
                 "opacity":0,
                 "display":"block"
               }).animate({"opacity":1},600); 
        }
        

        $("#wrap").append(backgound);

         $("#cover , .layerPopup .close").on("click",function(){
	          	if(isie7 || isie8){
          		  $("#cover").css({"opacity":0});
          		  $("#cover").remove();
	              obj.stop().animate({"margin-top":-50,"opacity":0},500,function(){
	              	$(this).css("display","none");
	              	$("#cover , .close").off("click");
	     			 });
	          	}else{
	          		 $("#cover").animate({"opacity":0},600,function(){$(this).remove();});
	              obj.stop().animate({"margin-top":-50,"opacity":0},500,function(){
	              	$(this).css("display","none");
	              	$("#cover , .layerPopup .close").off("click");
	     			 });

	          	}
          });
    }
    $("body , html").scrollTop(0);
 }//layerPopup
	


$(function(){

  mySideScroll = new IScroll(".lnbScrollBox", { 
    scrollX: false, 
    scrollbars: 'custom',
    mouseWheelSpeed:200,
     mouseWheel: true ,
     preventDefaultException: { tagName: /^(INPUT|TEXTAREA|BUTTON|SELECT|A)$/ }
   
   
   });

	// 사이드 메뉴
	var sideFlag = false; 
	var sideObj = $("#allMenu");
	var sideArr = $("#allMenu .allMenu_tab .arr");
	var sideArrOffset = [-83,51];
	var sideParent , sideBtnFlag;
	// 상단 메뉴
	var msv;



	
	/*리사이즈*/
	function resizeMotion(){
		if(sideFlag) sideRemove();
	};



	/*메뉴*/
	function lnbMotion(e){
		var o = $(this)
		var dep2 =  o.find(".depth2");
           var bar = $(".lnb_bar");
		if(e.type =="mouseenter"){
                con("open"+$(this).attr("class"));

			clearInterval(msv);
                if($(this).find(".depth2").length > 0){
      			$("#lnb .list > li").each(function(){
      				$(this).removeClass("ovr").find(".depth2").css({"display":"block"});
      			});
      			$(this).addClass("ovr");
                }
			bar.css({"display":"block"});
		}else{
                con("close");
			msv = setTimeout(function(){
  			    $("#lnb .list > li").each(function(){
                        $(this).removeClass("ovr").find(".depth2").css({"display":"none"});
                      });
                      bar.css({"display":"none"});
			},100)
		};
	}

	$("#lnb .list > li , .lnb_bar").on("mouseenter mouseleave",lnbMotion);
	/* //메뉴*/





	/* 사이드 메뉴 */

	function sideInit(num){
		var  start = $("#allMenu .allMenu_tab > ul > li:eq("+num+")");
		start.addClass("on").find("img").attr("src",start.find("img").attr("src").split("off").join("on"));
		sideParent = $(start.find(">a").attr("href"));
		sideArr.css("margin-left", sideArrOffset[0]  );
		
	}//sideMotion

	function sideMargin(obj,cont,margin){
		var objWIdth = obj.outerWidth(true) + margin;
		var sideMargin = cont.offset().left;
		if(objWIdth > sideMargin){
			return objWIdth - sideMargin;	
		}
	}//sideMargin

	function sideRemove(){
		var wrap = $("#wrap");
		var cont = $(".container_inner");
		var partner = $("#partner");
		var footer = $("#footer");
           var cover = $("#cover");
		sideBtnFlag.find("img").imgConversion(false);
		var objWIdth = sideObj.outerWidth(true);
		cont.stop().animate({"left":0},300,"easeInQuad");
		partner.stop().animate({"left":0},300,"easeInQuad");
		footer.stop().animate({"left":0},300,"easeInQuad");
            if(isie7 || isie8){
                $("#cover").remove(); 
              }else{
               $("#cover").animate({"opacity":0},600,function(){
                 $("#cover").remove();  
               }); 
              }
            $(window).off("resize",sideRemove);
		sideObj.stop().animate({"left":-(objWIdth)},300,"easeInQuad",function(){
            $(this).css("display","none");
              wrap.css({
                "width":"",
                "height":"",
                "overflow":"visible"
              })
            
          });
		sideFlag = false;

	}

	function sideTabClick(){

		var $this = $(this);
		var index = $this.index();
		if(!$this.hasClass("on")){
			sideArr.stop().animate({"margin-left": sideArrOffset[index]},300,"easeInQuad");
			$("#allMenu .allMenu_tab > ul > li.on").removeClass("on").find(".ico>img").imgConversion(false);
			$this.addClass("on").find(".ico>img").imgConversion(true);
			var target = $($(this).find(">a").attr("href"));
			sideParent.css("display","none");
			target.css("display","block");
			sideParent = target;
		}//if
		return false;
	};//sideTabClick

	function sideLstClick(e){

		$this = $(this).parent();
		if(!$this.hasClass("on")){
			$this.siblings(".on").removeClass("on").find(".depth2").stop().animate({"height":0},300,"easeInQuad",function(){
				$(this).css({
					"display":"none",
					"height":""
				})
			});
			var height = $this.find(".depth2").outerHeight(true);	
			$this.addClass("on").find(".depth2").css({
					"display":"block",
					"height":0
				}).stop().animate({"height":height},300,"easeInQuad");

		}else{
			$this.removeClass("on").find(".depth2").stop().animate({"height":0},300,"easeInQuad",function(){
				$(this).css({
					"display":"none",
					"height":""
				})
			});

		}
		e.preventDefault();

	}







	function sideMotion(){
		var $this = $(this);
		var wrap = $("#wrap");
		var cont = $(".container_inner");
		var partner = $("#partner");
		var footer = $("#footer");
           var cover = $('<div id="cover"></div>');
           var winW = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
           var winH = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
		var objWIdth = sideObj.outerWidth(true);
		var winHeight = parseInt( $("#wrap").outerHeight(true) ) -  parseInt(sideObj.css("top"));
		sideBtnFlag = $this;
		if (sideFlag) {
			sideRemove($this);
                /*$.srSmoothscroll({step: 100,speed: 400,ease: 'swing'});*/
		}else{
                /*상단 탑 배너*/
                var $topBanner = $("#topSlideBanner");
                if($topBanner.css("display") != "none"){
                  $topBanner.css("display","none");
                }


                $("body").off("mousewheel");
  			$this.find("img").imgConversion(true);
			wrap.css({
				"width":winW,
                      "height":winH - ($("#header").outerHeight()),
				"overflow":"hidden"
			})

        

                
                 if(isie7 || isie8){
                  cover.css({
                     "display":"block",
                     "width": "100%",
                     "height": $("body").outerHeight(),
                     "z-index":49
                   });
                  }else{
                   cover.css({
                     "display":"block",
                     "width": "100%",
                     "height": $("body").outerHeight(),
                     "z-index":49,
                     "opacity":1
                   });
                   $("#cover").animate({"opacity":1},600); 
                  }

                  cover.appendTo("#wrap").off().on('click', sideRemove);

                $(window).on("resize",sideRemove);


			
			cont.stop().animate({"left":sideMargin(sideObj,cont,0)},300,"easeInQuad");
			partner.stop().animate({"left":sideMargin(sideObj,cont,0)},300,"easeInQuad");
			footer.stop().animate({"left":sideMargin(sideObj,cont,0)},300,"easeInQuad");
			sideObj.css({
				"display":"block",
				"height":winHeight
			}).stop().animate({"left":0},300,"easeInQuad");
			//alert();
			$(".lnbScrollBox").css({
				"height":$(window).height() -$(".lnbScrollBox").offset().top
			})
			sideFlag = true;
			mySideScroll.refresh();
			$(".allMenuLst_left_title_wrap > *").find(">a").off().on("click",function(e){
						e.preventDefault();	
					})
			$(".allMenuLst_left_title_wrap > *").off().on("click",function(e){
					if(!$(this).hasClass("on")){
						var pos = $(".lnbScrollBox .inner");
						var posHeight = new Array;

						for (var i = 0; i < pos.find(".list  > li").length; i++) {
							posHeight[i] = pos.find(".list  > li:eq("+i+")").offset().top - pos.find(".list  > li:eq(0)").offset().top;
						};

                                var index = "#allMenu #allMenuLst .list > li.m" + ($(this).index()+1) ; 

                                mySideScroll.scrollToElement(index,600);
            /*  var dsfsf = -(posHeight[$(this).index()]);
					  pos.transition({ y:  dsfsf},function(){
                                 mySideScroll.scrollTo(0,dsfsf,0 ); 
                              });
*/
               
						$(".allMenuLst_left_title_wrap > *").each(function(){
								$(this).removeClass("on").find("img").imgConversion(false);

						});
						$(this).removeClass("ovr").addClass("on").find("img").imgConversion(true);

					}
			}).on("mouseenter mouseleave",function(e){
				if(!$(this).hasClass("on")){	
					if(e.type == "mouseenter"){
						//$(this).addClass("ovr").find("img").imgConversion(true);
					}else{
						//$(this).removeClass("ovr").find("img").imgConversion(false);
					}
				}
					


			});
		}

	}//sideMotion
	sideInit(0);
	$("#allMenu .allMenu_tab > ul > li").on("click",sideTabClick);
	$("#header .allMenu , #header .allMenu2").on("click",sideMotion);
	$("#allMenu #allMenuLst > ul > li > a").on("click",sideLstClick);


	/* //사이드 메뉴 */


	/* 메인배너 */
	





var scrollStartFlag = false;
var scrollIngFlag = false;
var ChangingTop = $("#header > .header_inner").outerHeight();
var scrollTopMargin = -86;
var resizeWidth = $(window).width();

  function scrollTopEvent(w){
    //상단 슬라이드 배너로 인한 리사이즈 if제거
    //if(resizeWidth > 990){
      var win = $(window),
      doc = $(document),
      body = (navigator.userAgent.indexOf('AppleWebKit') !== -1) ? $('body') : $('html');
      var top = win.scrollTop();
      var width = win.width();
      con("sdfsasfdfsdfasdf"+ChangingTop);
          if(top <= ChangingTop ){
            startScroll();
          }else{
            ingScroll();
          }
     // }//resizeWidth      
    }//scrollTopEvent

  function startScroll(b){
      if(!scrollStartFlag){
        //console.log("start");
        topFIxedMotion(false);
      }//if
      scrollStartFlag = true;
      scrollIngFlag = false;
    }//startScroll

      function ingScroll(b){
      if(!scrollIngFlag){
        //console.log("ing");
        topFIxedMotion(true);
      }//if
      scrollStartFlag = false;
      scrollIngFlag = true;
    }//ingScroll

       function topFIxedMotion(b){
      var wrap =$("#wrap");
      var header = $("#header"); 
      var container_inner = $(".container_inner");


      if(b){//아래
         wrap.css({
          //  "padding-top":140
          })
          header.css({
            "position" : "fixed",
            "margin-top" : ((window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth) > 990) ? scrollTopMargin : 0,
          })
           $("#wrap").css({
                "padding-top" :""
              }); 
          //.css("margin-top",-(header.outerHeight())).animate({"margin-top":scrollTopMargin},300);
      }else{// 상단
       wrap.css({
            //"padding-top":0
          })
            header.css({
              "position" : "absolute",
              "margin-top":0
            });
             $("#wrap").css({
                "padding-top" :""
              }); 

      }//if:b

    }//topFIxedMotion

    var normalFlag = false;
    var mobile1Flag = false;
    function resizeMotion(){
      resizeWidth = $(window).width();
      resizeWidth2 = $("#wrap").width();
/*      console.log("window"+resizeWidth);
      console.log("#wrap"+resizeWidth2);*/
      var header = $("#header"); 
      //상단 슬라이드 배너로 인한 리사이즈 if제거
     //  if(resizeWidth < 990){
       //     normalMotion();
         // }else{
            mobile1Motion();   
         //}

          function normalMotion(){
            if(!normalFlag){

               header.css({
                "position" : "fixed",
                "margin-top":0
              });

               $("#wrap").css({
                "padding-top" :0
              }); 


            }//if
            normalFlag = true;
            mobile1Flag = false;           
          }

            function mobile1Motion(){
            if(!mobile1Flag){
              var top = $(window).scrollTop();
              if(top > 86){
                 header.css({
                  "position" : "fixed",
                  "margin-top": ((window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth) > 990)  ? -86 : 0
                });
                $("#wrap").css({
                "padding-top" :0
              }); 
              }
              scrollTopEvent();

            }//if
            normalFlag = false;
            mobile1Flag = true;           
          }


    };

 
  $(window).resize(function(){
    resizeMotion();
    //scrollTopEvent(width,topHeight);
  });


  $(window).on("scroll",function(){
    //var topHeight = $("#header > .header_inner").outerHeight();
   scrollTopEvent();
  })
  scrollTopEvent();
  resizeMotion();

  
});//$.function







(function(a){if(typeof define==="function"&&define.amd&&define.amd.jQuery){define(["jquery"],a)}else{a(jQuery)}}(function(f){var p="left",o="right",e="up",x="down",c="in",z="out",m="none",s="auto",l="swipe",t="pinch",A="tap",j="doubletap",b="longtap",y="hold",D="horizontal",u="vertical",i="all",r=10,g="start",k="move",h="end",q="cancel",a="ontouchstart" in window,v=window.navigator.msPointerEnabled&&!window.navigator.pointerEnabled,d=window.navigator.pointerEnabled||window.navigator.msPointerEnabled,B="TouchSwipe";var n={fingers:1,threshold:75,cancelThreshold:null,pinchThreshold:20,maxTimeThreshold:null,fingerReleaseThreshold:250,longTapThreshold:500,doubleTapThreshold:200,swipe:null,swipeLeft:null,swipeRight:null,swipeUp:null,swipeDown:null,swipeStatus:null,pinchIn:null,pinchOut:null,pinchStatus:null,click:null,tap:null,doubleTap:null,longTap:null,hold:null,triggerOnTouchEnd:true,triggerOnTouchLeave:false,allowPageScroll:"auto",fallbackToMouseEvents:true,excludedElements:"label, button, input, select, textarea, a, .noSwipe"};f.fn.swipe=function(G){var F=f(this),E=F.data(B);if(E&&typeof G==="string"){if(E[G]){return E[G].apply(this,Array.prototype.slice.call(arguments,1))}else{f.error("Method "+G+" does not exist on jQuery.swipe")}}else{if(!E&&(typeof G==="object"||!G)){return w.apply(this,arguments)}}return F};f.fn.swipe.defaults=n;f.fn.swipe.phases={PHASE_START:g,PHASE_MOVE:k,PHASE_END:h,PHASE_CANCEL:q};f.fn.swipe.directions={LEFT:p,RIGHT:o,UP:e,DOWN:x,IN:c,OUT:z};f.fn.swipe.pageScroll={NONE:m,HORIZONTAL:D,VERTICAL:u,AUTO:s};f.fn.swipe.fingers={ONE:1,TWO:2,THREE:3,ALL:i};function w(E){if(E&&(E.allowPageScroll===undefined&&(E.swipe!==undefined||E.swipeStatus!==undefined))){E.allowPageScroll=m}if(E.click!==undefined&&E.tap===undefined){E.tap=E.click}if(!E){E={}}E=f.extend({},f.fn.swipe.defaults,E);return this.each(function(){var G=f(this);var F=G.data(B);if(!F){F=new C(this,E);G.data(B,F)}})}function C(a4,av){var az=(a||d||!av.fallbackToMouseEvents),J=az?(d?(v?"MSPointerDown":"pointerdown"):"touchstart"):"mousedown",ay=az?(d?(v?"MSPointerMove":"pointermove"):"touchmove"):"mousemove",U=az?(d?(v?"MSPointerUp":"pointerup"):"touchend"):"mouseup",S=az?null:"mouseleave",aD=(d?(v?"MSPointerCancel":"pointercancel"):"touchcancel");var ag=0,aP=null,ab=0,a1=0,aZ=0,G=1,aq=0,aJ=0,M=null;var aR=f(a4);var Z="start";var W=0;var aQ=null;var T=0,a2=0,a5=0,ad=0,N=0;var aW=null,af=null;try{aR.bind(J,aN);aR.bind(aD,a9)}catch(ak){f.error("events not supported "+J+","+aD+" on jQuery.swipe")}this.enable=function(){aR.bind(J,aN);aR.bind(aD,a9);return aR};this.disable=function(){aK();return aR};this.destroy=function(){aK();aR.data(B,null);aR=null};this.option=function(bc,bb){if(av[bc]!==undefined){if(bb===undefined){return av[bc]}else{av[bc]=bb}}else{f.error("Option "+bc+" does not exist on jQuery.swipe.options")}return null};function aN(bd){if(aB()){return}if(f(bd.target).closest(av.excludedElements,aR).length>0){return}var be=bd.originalEvent?bd.originalEvent:bd;var bc,bb=a?be.touches[0]:be;Z=g;if(a){W=be.touches.length}else{bd.preventDefault()}ag=0;aP=null;aJ=null;ab=0;a1=0;aZ=0;G=1;aq=0;aQ=aj();M=aa();R();if(!a||(W===av.fingers||av.fingers===i)||aX()){ai(0,bb);T=at();if(W==2){ai(1,be.touches[1]);a1=aZ=au(aQ[0].start,aQ[1].start)}if(av.swipeStatus||av.pinchStatus){bc=O(be,Z)}}else{bc=false}if(bc===false){Z=q;O(be,Z);return bc}else{if(av.hold){af=setTimeout(f.proxy(function(){aR.trigger("hold",[be.target]);if(av.hold){bc=av.hold.call(aR,be,be.target)}},this),av.longTapThreshold)}ao(true)}return null}function a3(be){var bh=be.originalEvent?be.originalEvent:be;if(Z===h||Z===q||am()){return}var bd,bc=a?bh.touches[0]:bh;var bf=aH(bc);a2=at();if(a){W=bh.touches.length}if(av.hold){clearTimeout(af)}Z=k;if(W==2){if(a1==0){ai(1,bh.touches[1]);a1=aZ=au(aQ[0].start,aQ[1].start)}else{aH(bh.touches[1]);aZ=au(aQ[0].end,aQ[1].end);aJ=ar(aQ[0].end,aQ[1].end)}G=a7(a1,aZ);aq=Math.abs(a1-aZ)}if((W===av.fingers||av.fingers===i)||!a||aX()){aP=aL(bf.start,bf.end);al(be,aP);ag=aS(bf.start,bf.end);ab=aM();aI(aP,ag);if(av.swipeStatus||av.pinchStatus){bd=O(bh,Z)}if(!av.triggerOnTouchEnd||av.triggerOnTouchLeave){var bb=true;if(av.triggerOnTouchLeave){var bg=aY(this);bb=E(bf.end,bg)}if(!av.triggerOnTouchEnd&&bb){Z=aC(k)}else{if(av.triggerOnTouchLeave&&!bb){Z=aC(h)}}if(Z==q||Z==h){O(bh,Z)}}}else{Z=q;O(bh,Z)}if(bd===false){Z=q;O(bh,Z)}}function L(bb){var bc=bb.originalEvent;if(a){if(bc.touches.length>0){F();return true}}if(am()){W=ad}a2=at();ab=aM();if(ba()||!an()){Z=q;O(bc,Z)}else{if(av.triggerOnTouchEnd||(av.triggerOnTouchEnd==false&&Z===k)){bb.preventDefault();Z=h;O(bc,Z)}else{if(!av.triggerOnTouchEnd&&a6()){Z=h;aF(bc,Z,A)}else{if(Z===k){Z=q;O(bc,Z)}}}}ao(false);return null}function a9(){W=0;a2=0;T=0;a1=0;aZ=0;G=1;R();ao(false)}function K(bb){var bc=bb.originalEvent;if(av.triggerOnTouchLeave){Z=aC(h);O(bc,Z)}}function aK(){aR.unbind(J,aN);aR.unbind(aD,a9);aR.unbind(ay,a3);aR.unbind(U,L);if(S){aR.unbind(S,K)}ao(false)}function aC(bf){var be=bf;var bd=aA();var bc=an();var bb=ba();if(!bd||bb){be=q}else{if(bc&&bf==k&&(!av.triggerOnTouchEnd||av.triggerOnTouchLeave)){be=h}else{if(!bc&&bf==h&&av.triggerOnTouchLeave){be=q}}}return be}function O(bd,bb){var bc=undefined;if(I()||V()){bc=aF(bd,bb,l)}else{if((P()||aX())&&bc!==false){bc=aF(bd,bb,t)}}if(aG()&&bc!==false){bc=aF(bd,bb,j)}else{if(ap()&&bc!==false){bc=aF(bd,bb,b)}else{if(ah()&&bc!==false){bc=aF(bd,bb,A)}}}if(bb===q){a9(bd)}if(bb===h){if(a){if(bd.touches.length==0){a9(bd)}}else{a9(bd)}}return bc}function aF(be,bb,bd){var bc=undefined;if(bd==l){aR.trigger("swipeStatus",[bb,aP||null,ag||0,ab||0,W,aQ]);if(av.swipeStatus){bc=av.swipeStatus.call(aR,be,bb,aP||null,ag||0,ab||0,W,aQ);if(bc===false){return false}}if(bb==h&&aV()){aR.trigger("swipe",[aP,ag,ab,W,aQ]);if(av.swipe){bc=av.swipe.call(aR,be,aP,ag,ab,W,aQ);if(bc===false){return false}}switch(aP){case p:aR.trigger("swipeLeft",[aP,ag,ab,W,aQ]);if(av.swipeLeft){bc=av.swipeLeft.call(aR,be,aP,ag,ab,W,aQ)}break;case o:aR.trigger("swipeRight",[aP,ag,ab,W,aQ]);if(av.swipeRight){bc=av.swipeRight.call(aR,be,aP,ag,ab,W,aQ)}break;case e:aR.trigger("swipeUp",[aP,ag,ab,W,aQ]);if(av.swipeUp){bc=av.swipeUp.call(aR,be,aP,ag,ab,W,aQ)}break;case x:aR.trigger("swipeDown",[aP,ag,ab,W,aQ]);if(av.swipeDown){bc=av.swipeDown.call(aR,be,aP,ag,ab,W,aQ)}break}}}if(bd==t){aR.trigger("pinchStatus",[bb,aJ||null,aq||0,ab||0,W,G,aQ]);if(av.pinchStatus){bc=av.pinchStatus.call(aR,be,bb,aJ||null,aq||0,ab||0,W,G,aQ);if(bc===false){return false}}if(bb==h&&a8()){switch(aJ){case c:aR.trigger("pinchIn",[aJ||null,aq||0,ab||0,W,G,aQ]);if(av.pinchIn){bc=av.pinchIn.call(aR,be,aJ||null,aq||0,ab||0,W,G,aQ)}break;case z:aR.trigger("pinchOut",[aJ||null,aq||0,ab||0,W,G,aQ]);if(av.pinchOut){bc=av.pinchOut.call(aR,be,aJ||null,aq||0,ab||0,W,G,aQ)}break}}}if(bd==A){if(bb===q||bb===h){clearTimeout(aW);clearTimeout(af);if(Y()&&!H()){N=at();aW=setTimeout(f.proxy(function(){N=null;aR.trigger("tap",[be.target]);if(av.tap){bc=av.tap.call(aR,be,be.target)}},this),av.doubleTapThreshold)}else{N=null;aR.trigger("tap",[be.target]);if(av.tap){bc=av.tap.call(aR,be,be.target)}}}}else{if(bd==j){if(bb===q||bb===h){clearTimeout(aW);N=null;aR.trigger("doubletap",[be.target]);if(av.doubleTap){bc=av.doubleTap.call(aR,be,be.target)}}}else{if(bd==b){if(bb===q||bb===h){clearTimeout(aW);N=null;aR.trigger("longtap",[be.target]);if(av.longTap){bc=av.longTap.call(aR,be,be.target)}}}}}return bc}function an(){var bb=true;if(av.threshold!==null){bb=ag>=av.threshold}return bb}function ba(){var bb=false;if(av.cancelThreshold!==null&&aP!==null){bb=(aT(aP)-ag)>=av.cancelThreshold}return bb}function ae(){if(av.pinchThreshold!==null){return aq>=av.pinchThreshold}return true}function aA(){var bb;if(av.maxTimeThreshold){if(ab>=av.maxTimeThreshold){bb=false}else{bb=true}}else{bb=true}return bb}function al(bb,bc){if(av.allowPageScroll===m||aX()){bb.preventDefault()}else{var bd=av.allowPageScroll===s;switch(bc){case p:if((av.swipeLeft&&bd)||(!bd&&av.allowPageScroll!=D)){bb.preventDefault()}break;case o:if((av.swipeRight&&bd)||(!bd&&av.allowPageScroll!=D)){bb.preventDefault()}break;case e:if((av.swipeUp&&bd)||(!bd&&av.allowPageScroll!=u)){bb.preventDefault()}break;case x:if((av.swipeDown&&bd)||(!bd&&av.allowPageScroll!=u)){bb.preventDefault()}break}}}function a8(){var bc=aO();var bb=X();var bd=ae();return bc&&bb&&bd}function aX(){return !!(av.pinchStatus||av.pinchIn||av.pinchOut)}function P(){return !!(a8()&&aX())}function aV(){var be=aA();var bg=an();var bd=aO();var bb=X();var bc=ba();var bf=!bc&&bb&&bd&&bg&&be;return bf}function V(){return !!(av.swipe||av.swipeStatus||av.swipeLeft||av.swipeRight||av.swipeUp||av.swipeDown)}function I(){return !!(aV()&&V())}function aO(){return((W===av.fingers||av.fingers===i)||!a)}function X(){return aQ[0].end.x!==0}function a6(){return !!(av.tap)}function Y(){return !!(av.doubleTap)}function aU(){return !!(av.longTap)}function Q(){if(N==null){return false}var bb=at();return(Y()&&((bb-N)<=av.doubleTapThreshold))}function H(){return Q()}function ax(){return((W===1||!a)&&(isNaN(ag)||ag<av.threshold))}function a0(){return((ab>av.longTapThreshold)&&(ag<r))}function ah(){return !!(ax()&&a6())}function aG(){return !!(Q()&&Y())}function ap(){return !!(a0()&&aU())}function F(){a5=at();ad=event.touches.length+1}function R(){a5=0;ad=0}function am(){var bb=false;if(a5){var bc=at()-a5;if(bc<=av.fingerReleaseThreshold){bb=true}}return bb}function aB(){return !!(aR.data(B+"_intouch")===true)}function ao(bb){if(bb===true){aR.bind(ay,a3);aR.bind(U,L);if(S){aR.bind(S,K)}}else{aR.unbind(ay,a3,false);aR.unbind(U,L,false);if(S){aR.unbind(S,K,false)}}aR.data(B+"_intouch",bb===true)}function ai(bc,bb){var bd=bb.identifier!==undefined?bb.identifier:0;aQ[bc].identifier=bd;aQ[bc].start.x=aQ[bc].end.x=bb.pageX||bb.clientX;aQ[bc].start.y=aQ[bc].end.y=bb.pageY||bb.clientY;return aQ[bc]}function aH(bb){var bd=bb.identifier!==undefined?bb.identifier:0;var bc=ac(bd);bc.end.x=bb.pageX||bb.clientX;bc.end.y=bb.pageY||bb.clientY;return bc}function ac(bc){for(var bb=0;bb<aQ.length;bb++){if(aQ[bb].identifier==bc){return aQ[bb]}}}function aj(){var bb=[];for(var bc=0;bc<=5;bc++){bb.push({start:{x:0,y:0},end:{x:0,y:0},identifier:0})}return bb}function aI(bb,bc){bc=Math.max(bc,aT(bb));M[bb].distance=bc}function aT(bb){if(M[bb]){return M[bb].distance}return undefined}function aa(){var bb={};bb[p]=aw(p);bb[o]=aw(o);bb[e]=aw(e);bb[x]=aw(x);return bb}function aw(bb){return{direction:bb,distance:0}}function aM(){return a2-T}function au(be,bd){var bc=Math.abs(be.x-bd.x);var bb=Math.abs(be.y-bd.y);return Math.round(Math.sqrt(bc*bc+bb*bb))}function a7(bb,bc){var bd=(bc/bb)*1;return bd.toFixed(2)}function ar(){if(G<1){return z}else{return c}}function aS(bc,bb){return Math.round(Math.sqrt(Math.pow(bb.x-bc.x,2)+Math.pow(bb.y-bc.y,2)))}function aE(be,bc){var bb=be.x-bc.x;var bg=bc.y-be.y;var bd=Math.atan2(bg,bb);var bf=Math.round(bd*180/Math.PI);if(bf<0){bf=360-Math.abs(bf)}return bf}function aL(bc,bb){var bd=aE(bc,bb);if((bd<=45)&&(bd>=0)){return p}else{if((bd<=360)&&(bd>=315)){return p}else{if((bd>=135)&&(bd<=225)){return o}else{if((bd>45)&&(bd<135)){return x}else{return e}}}}}function at(){var bb=new Date();return bb.getTime()}function aY(bb){bb=f(bb);var bd=bb.offset();var bc={left:bd.left,right:bd.left+bb.outerWidth(),top:bd.top,bottom:bd.top+bb.outerHeight()};return bc}function E(bb,bc){return(bb.x>bc.left&&bb.x<bc.right&&bb.y>bc.top&&bb.y<bc.bottom)}}}));




(function(a){if(typeof define==="function"&&define.amd&&define.amd.jQuery){define(["jquery"],a)}else{a(jQuery)}}(function(f){var p="left",o="right",e="up",x="down",c="in",z="out",m="none",s="auto",l="swipe",t="pinch",A="tap",j="doubletap",b="longtap",y="hold",D="horizontal",u="vertical",i="all",r=10,g="start",k="move",h="end",q="cancel",a="ontouchstart" in window,v=window.navigator.msPointerEnabled&&!window.navigator.pointerEnabled,d=window.navigator.pointerEnabled||window.navigator.msPointerEnabled,B="TouchSwipe";var n={fingers:1,threshold:75,cancelThreshold:null,pinchThreshold:20,maxTimeThreshold:null,fingerReleaseThreshold:250,longTapThreshold:500,doubleTapThreshold:200,swipe:null,swipeLeft:null,swipeRight:null,swipeUp:null,swipeDown:null,swipeStatus:null,pinchIn:null,pinchOut:null,pinchStatus:null,click:null,tap:null,doubleTap:null,longTap:null,hold:null,triggerOnTouchEnd:true,triggerOnTouchLeave:false,allowPageScroll:"auto",fallbackToMouseEvents:true,excludedElements:"label, button, input, select, textarea, a, .noSwipe"};f.fn.swipe=function(G){var F=f(this),E=F.data(B);if(E&&typeof G==="string"){if(E[G]){return E[G].apply(this,Array.prototype.slice.call(arguments,1))}else{f.error("Method "+G+" does not exist on jQuery.swipe")}}else{if(!E&&(typeof G==="object"||!G)){return w.apply(this,arguments)}}return F};f.fn.swipe.defaults=n;f.fn.swipe.phases={PHASE_START:g,PHASE_MOVE:k,PHASE_END:h,PHASE_CANCEL:q};f.fn.swipe.directions={LEFT:p,RIGHT:o,UP:e,DOWN:x,IN:c,OUT:z};f.fn.swipe.pageScroll={NONE:m,HORIZONTAL:D,VERTICAL:u,AUTO:s};f.fn.swipe.fingers={ONE:1,TWO:2,THREE:3,ALL:i};function w(E){if(E&&(E.allowPageScroll===undefined&&(E.swipe!==undefined||E.swipeStatus!==undefined))){E.allowPageScroll=m}if(E.click!==undefined&&E.tap===undefined){E.tap=E.click}if(!E){E={}}E=f.extend({},f.fn.swipe.defaults,E);return this.each(function(){var G=f(this);var F=G.data(B);if(!F){F=new C(this,E);G.data(B,F)}})}function C(a4,av){var az=(a||d||!av.fallbackToMouseEvents),J=az?(d?(v?"MSPointerDown":"pointerdown"):"touchstart"):"mousedown",ay=az?(d?(v?"MSPointerMove":"pointermove"):"touchmove"):"mousemove",U=az?(d?(v?"MSPointerUp":"pointerup"):"touchend"):"mouseup",S=az?null:"mouseleave",aD=(d?(v?"MSPointerCancel":"pointercancel"):"touchcancel");var ag=0,aP=null,ab=0,a1=0,aZ=0,G=1,aq=0,aJ=0,M=null;var aR=f(a4);var Z="start";var W=0;var aQ=null;var T=0,a2=0,a5=0,ad=0,N=0;var aW=null,af=null;try{aR.bind(J,aN);aR.bind(aD,a9)}catch(ak){f.error("events not supported "+J+","+aD+" on jQuery.swipe")}this.enable=function(){aR.bind(J,aN);aR.bind(aD,a9);return aR};this.disable=function(){aK();return aR};this.destroy=function(){aK();aR.data(B,null);aR=null};this.option=function(bc,bb){if(av[bc]!==undefined){if(bb===undefined){return av[bc]}else{av[bc]=bb}}else{f.error("Option "+bc+" does not exist on jQuery.swipe.options")}return null};function aN(bd){if(aB()){return}if(f(bd.target).closest(av.excludedElements,aR).length>0){return}var be=bd.originalEvent?bd.originalEvent:bd;var bc,bb=a?be.touches[0]:be;Z=g;if(a){W=be.touches.length}else{bd.preventDefault()}ag=0;aP=null;aJ=null;ab=0;a1=0;aZ=0;G=1;aq=0;aQ=aj();M=aa();R();if(!a||(W===av.fingers||av.fingers===i)||aX()){ai(0,bb);T=at();if(W==2){ai(1,be.touches[1]);a1=aZ=au(aQ[0].start,aQ[1].start)}if(av.swipeStatus||av.pinchStatus){bc=O(be,Z)}}else{bc=false}if(bc===false){Z=q;O(be,Z);return bc}else{if(av.hold){af=setTimeout(f.proxy(function(){aR.trigger("hold",[be.target]);if(av.hold){bc=av.hold.call(aR,be,be.target)}},this),av.longTapThreshold)}ao(true)}return null}function a3(be){var bh=be.originalEvent?be.originalEvent:be;if(Z===h||Z===q||am()){return}var bd,bc=a?bh.touches[0]:bh;var bf=aH(bc);a2=at();if(a){W=bh.touches.length}if(av.hold){clearTimeout(af)}Z=k;if(W==2){if(a1==0){ai(1,bh.touches[1]);a1=aZ=au(aQ[0].start,aQ[1].start)}else{aH(bh.touches[1]);aZ=au(aQ[0].end,aQ[1].end);aJ=ar(aQ[0].end,aQ[1].end)}G=a7(a1,aZ);aq=Math.abs(a1-aZ)}if((W===av.fingers||av.fingers===i)||!a||aX()){aP=aL(bf.start,bf.end);al(be,aP);ag=aS(bf.start,bf.end);ab=aM();aI(aP,ag);if(av.swipeStatus||av.pinchStatus){bd=O(bh,Z)}if(!av.triggerOnTouchEnd||av.triggerOnTouchLeave){var bb=true;if(av.triggerOnTouchLeave){var bg=aY(this);bb=E(bf.end,bg)}if(!av.triggerOnTouchEnd&&bb){Z=aC(k)}else{if(av.triggerOnTouchLeave&&!bb){Z=aC(h)}}if(Z==q||Z==h){O(bh,Z)}}}else{Z=q;O(bh,Z)}if(bd===false){Z=q;O(bh,Z)}}function L(bb){var bc=bb.originalEvent;if(a){if(bc.touches.length>0){F();return true}}if(am()){W=ad}a2=at();ab=aM();if(ba()||!an()){Z=q;O(bc,Z)}else{if(av.triggerOnTouchEnd||(av.triggerOnTouchEnd==false&&Z===k)){bb.preventDefault();Z=h;O(bc,Z)}else{if(!av.triggerOnTouchEnd&&a6()){Z=h;aF(bc,Z,A)}else{if(Z===k){Z=q;O(bc,Z)}}}}ao(false);return null}function a9(){W=0;a2=0;T=0;a1=0;aZ=0;G=1;R();ao(false)}function K(bb){var bc=bb.originalEvent;if(av.triggerOnTouchLeave){Z=aC(h);O(bc,Z)}}function aK(){aR.unbind(J,aN);aR.unbind(aD,a9);aR.unbind(ay,a3);aR.unbind(U,L);if(S){aR.unbind(S,K)}ao(false)}function aC(bf){var be=bf;var bd=aA();var bc=an();var bb=ba();if(!bd||bb){be=q}else{if(bc&&bf==k&&(!av.triggerOnTouchEnd||av.triggerOnTouchLeave)){be=h}else{if(!bc&&bf==h&&av.triggerOnTouchLeave){be=q}}}return be}function O(bd,bb){var bc=undefined;if(I()||V()){bc=aF(bd,bb,l)}else{if((P()||aX())&&bc!==false){bc=aF(bd,bb,t)}}if(aG()&&bc!==false){bc=aF(bd,bb,j)}else{if(ap()&&bc!==false){bc=aF(bd,bb,b)}else{if(ah()&&bc!==false){bc=aF(bd,bb,A)}}}if(bb===q){a9(bd)}if(bb===h){if(a){if(bd.touches.length==0){a9(bd)}}else{a9(bd)}}return bc}function aF(be,bb,bd){var bc=undefined;if(bd==l){aR.trigger("swipeStatus",[bb,aP||null,ag||0,ab||0,W,aQ]);if(av.swipeStatus){bc=av.swipeStatus.call(aR,be,bb,aP||null,ag||0,ab||0,W,aQ);if(bc===false){return false}}if(bb==h&&aV()){aR.trigger("swipe",[aP,ag,ab,W,aQ]);if(av.swipe){bc=av.swipe.call(aR,be,aP,ag,ab,W,aQ);if(bc===false){return false}}switch(aP){case p:aR.trigger("swipeLeft",[aP,ag,ab,W,aQ]);if(av.swipeLeft){bc=av.swipeLeft.call(aR,be,aP,ag,ab,W,aQ)}break;case o:aR.trigger("swipeRight",[aP,ag,ab,W,aQ]);if(av.swipeRight){bc=av.swipeRight.call(aR,be,aP,ag,ab,W,aQ)}break;case e:aR.trigger("swipeUp",[aP,ag,ab,W,aQ]);if(av.swipeUp){bc=av.swipeUp.call(aR,be,aP,ag,ab,W,aQ)}break;case x:aR.trigger("swipeDown",[aP,ag,ab,W,aQ]);if(av.swipeDown){bc=av.swipeDown.call(aR,be,aP,ag,ab,W,aQ)}break}}}if(bd==t){aR.trigger("pinchStatus",[bb,aJ||null,aq||0,ab||0,W,G,aQ]);if(av.pinchStatus){bc=av.pinchStatus.call(aR,be,bb,aJ||null,aq||0,ab||0,W,G,aQ);if(bc===false){return false}}if(bb==h&&a8()){switch(aJ){case c:aR.trigger("pinchIn",[aJ||null,aq||0,ab||0,W,G,aQ]);if(av.pinchIn){bc=av.pinchIn.call(aR,be,aJ||null,aq||0,ab||0,W,G,aQ)}break;case z:aR.trigger("pinchOut",[aJ||null,aq||0,ab||0,W,G,aQ]);if(av.pinchOut){bc=av.pinchOut.call(aR,be,aJ||null,aq||0,ab||0,W,G,aQ)}break}}}if(bd==A){if(bb===q||bb===h){clearTimeout(aW);clearTimeout(af);if(Y()&&!H()){N=at();aW=setTimeout(f.proxy(function(){N=null;aR.trigger("tap",[be.target]);if(av.tap){bc=av.tap.call(aR,be,be.target)}},this),av.doubleTapThreshold)}else{N=null;aR.trigger("tap",[be.target]);if(av.tap){bc=av.tap.call(aR,be,be.target)}}}}else{if(bd==j){if(bb===q||bb===h){clearTimeout(aW);N=null;aR.trigger("doubletap",[be.target]);if(av.doubleTap){bc=av.doubleTap.call(aR,be,be.target)}}}else{if(bd==b){if(bb===q||bb===h){clearTimeout(aW);N=null;aR.trigger("longtap",[be.target]);if(av.longTap){bc=av.longTap.call(aR,be,be.target)}}}}}return bc}function an(){var bb=true;if(av.threshold!==null){bb=ag>=av.threshold}return bb}function ba(){var bb=false;if(av.cancelThreshold!==null&&aP!==null){bb=(aT(aP)-ag)>=av.cancelThreshold}return bb}function ae(){if(av.pinchThreshold!==null){return aq>=av.pinchThreshold}return true}function aA(){var bb;if(av.maxTimeThreshold){if(ab>=av.maxTimeThreshold){bb=false}else{bb=true}}else{bb=true}return bb}function al(bb,bc){if(av.allowPageScroll===m||aX()){bb.preventDefault()}else{var bd=av.allowPageScroll===s;switch(bc){case p:if((av.swipeLeft&&bd)||(!bd&&av.allowPageScroll!=D)){bb.preventDefault()}break;case o:if((av.swipeRight&&bd)||(!bd&&av.allowPageScroll!=D)){bb.preventDefault()}break;case e:if((av.swipeUp&&bd)||(!bd&&av.allowPageScroll!=u)){bb.preventDefault()}break;case x:if((av.swipeDown&&bd)||(!bd&&av.allowPageScroll!=u)){bb.preventDefault()}break}}}function a8(){var bc=aO();var bb=X();var bd=ae();return bc&&bb&&bd}function aX(){return !!(av.pinchStatus||av.pinchIn||av.pinchOut)}function P(){return !!(a8()&&aX())}function aV(){var be=aA();var bg=an();var bd=aO();var bb=X();var bc=ba();var bf=!bc&&bb&&bd&&bg&&be;return bf}function V(){return !!(av.swipe||av.swipeStatus||av.swipeLeft||av.swipeRight||av.swipeUp||av.swipeDown)}function I(){return !!(aV()&&V())}function aO(){return((W===av.fingers||av.fingers===i)||!a)}function X(){return aQ[0].end.x!==0}function a6(){return !!(av.tap)}function Y(){return !!(av.doubleTap)}function aU(){return !!(av.longTap)}function Q(){if(N==null){return false}var bb=at();return(Y()&&((bb-N)<=av.doubleTapThreshold))}function H(){return Q()}function ax(){return((W===1||!a)&&(isNaN(ag)||ag<av.threshold))}function a0(){return((ab>av.longTapThreshold)&&(ag<r))}function ah(){return !!(ax()&&a6())}function aG(){return !!(Q()&&Y())}function ap(){return !!(a0()&&aU())}function F(){a5=at();ad=event.touches.length+1}function R(){a5=0;ad=0}function am(){var bb=false;if(a5){var bc=at()-a5;if(bc<=av.fingerReleaseThreshold){bb=true}}return bb}function aB(){return !!(aR.data(B+"_intouch")===true)}function ao(bb){if(bb===true){aR.bind(ay,a3);aR.bind(U,L);if(S){aR.bind(S,K)}}else{aR.unbind(ay,a3,false);aR.unbind(U,L,false);if(S){aR.unbind(S,K,false)}}aR.data(B+"_intouch",bb===true)}function ai(bc,bb){var bd=bb.identifier!==undefined?bb.identifier:0;aQ[bc].identifier=bd;aQ[bc].start.x=aQ[bc].end.x=bb.pageX||bb.clientX;aQ[bc].start.y=aQ[bc].end.y=bb.pageY||bb.clientY;return aQ[bc]}function aH(bb){var bd=bb.identifier!==undefined?bb.identifier:0;var bc=ac(bd);bc.end.x=bb.pageX||bb.clientX;bc.end.y=bb.pageY||bb.clientY;return bc}function ac(bc){for(var bb=0;bb<aQ.length;bb++){if(aQ[bb].identifier==bc){return aQ[bb]}}}function aj(){var bb=[];for(var bc=0;bc<=5;bc++){bb.push({start:{x:0,y:0},end:{x:0,y:0},identifier:0})}return bb}function aI(bb,bc){bc=Math.max(bc,aT(bb));M[bb].distance=bc}function aT(bb){if(M[bb]){return M[bb].distance}return undefined}function aa(){var bb={};bb[p]=aw(p);bb[o]=aw(o);bb[e]=aw(e);bb[x]=aw(x);return bb}function aw(bb){return{direction:bb,distance:0}}function aM(){return a2-T}function au(be,bd){var bc=Math.abs(be.x-bd.x);var bb=Math.abs(be.y-bd.y);return Math.round(Math.sqrt(bc*bc+bb*bb))}function a7(bb,bc){var bd=(bc/bb)*1;return bd.toFixed(2)}function ar(){if(G<1){return z}else{return c}}function aS(bc,bb){return Math.round(Math.sqrt(Math.pow(bb.x-bc.x,2)+Math.pow(bb.y-bc.y,2)))}function aE(be,bc){var bb=be.x-bc.x;var bg=bc.y-be.y;var bd=Math.atan2(bg,bb);var bf=Math.round(bd*180/Math.PI);if(bf<0){bf=360-Math.abs(bf)}return bf}function aL(bc,bb){var bd=aE(bc,bb);if((bd<=45)&&(bd>=0)){return p}else{if((bd<=360)&&(bd>=315)){return p}else{if((bd>=135)&&(bd<=225)){return o}else{if((bd>45)&&(bd<135)){return x}else{return e}}}}}function at(){var bb=new Date();return bb.getTime()}function aY(bb){bb=f(bb);var bd=bb.offset();var bc={left:bd.left,right:bd.left+bb.outerWidth(),top:bd.top,bottom:bd.top+bb.outerHeight()};return bc}function E(bb,bc){return(bb.x>bc.left&&bb.x<bc.right&&bb.y>bc.top&&bb.y<bc.bottom)}}}));