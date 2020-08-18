
;(function($){
$.fn.dbTabsmall2=function(options){
	var opt={
		imgWidth:960,           //가로
		imgHeight:402,          //세로
		motionType:'fade in',      //모션타입('none','x','y','fade')
		motionSpeed:900,        //모션속도
		autoRollingTime:3000    //자동롤링속도(밀리초)
	}
	$.extend(opt,options);
	return this.each(function(){
		var $this=$(this);
		var $imgSet=$this.find('.nanum_imgSet');
		var $imgList=$this.find('.nanum_imgSet li');
		var $menuSet=$this.find('.nanum_menuSet');
		var $menuList=$this.find('.nanum_menuSet li');
		var $dirList=$this.find('.dir');
		var dirIs=$dirList.length;
		if(dirIs){
			var $nextBtn=$this.find('.next');
			var $prevBtn=$this.find('.prev');
		}
		var listNum=$imgList.length;
		var currentImg=0;
		var oldCurrentImg=-1
		var timerId=0;
		var dir='next';
		init();

		function init(){
			setCss();
			setMouseEvent();
			setEnterFrame();
			setAnimation();
		}

		function setCss(){
			$imgSet.css({'width':opt.imgWidth,'height':opt.imgHeight,'position':'relative'});
			$imgList.css({'position':'absolute','left':0,'top':0,'display':'block'});						
			for(var i=0;i<listNum;i++){
				switch(opt.motionType){	
					case 'x':
						$imgList.eq(i).css({'left':opt.imgWidth*i});						
						break;
					case 'y':
						$imgList.eq(i).css({'top':opt.imgHeight*i});
						break;
					default :
						if(i==currentImg){
							$imgList.eq(i).show();
						}else{
							$imgList.eq(i).hide();
						}
				}
			}			
			
		}

		function setMouseEvent(){
			$this.bind('mouseenter',function(){
				clearInterval(timerId);
			})
			$this.bind('mouseleave',function(){
				setEnterFrame();
			})
			$menuList.bind('click',function(){
				currentImg=$(this).index();
				setAnimation();
			});
			if(dirIs){
				$dirList.bind('click',function(){
					setReplace($(this).find('img'),'src','_off','_on');
				});
				$dirList.bind('mouseleave',function(){
					setReplace($(this).find('img'),'src','_on','_off');
				});
				$nextBtn.bind('click',function(){
					dir='next';
					changeCurrent();
				});
				$prevBtn.bind('click',function(){
					dir='prev';
					changeCurrent();
				});
			}			
		}

		function changeCurrent(){
			if(dir=='next'){
				currentImg=++currentImg%listNum;
			}else{
				currentImg=(currentImg==0)?listNum-1:--currentImg%listNum;
			}
			setAnimation();
		}

		function setEnterFrame(){
			timerId=setInterval(changeCurrent,opt.autoRollingTime);			
		}

		function setAnimation(){
			switch (opt.motionType){
				case 'fade':
					$imgList.eq(oldCurrentImg).stop(true,true).fadeOut(opt.motionSpeed);
					$imgList.eq(currentImg).stop(true,true).fadeIn(opt.motionSpeed);
					break;
				case 'x':
					$imgSet.stop().animate({'left':-currentImg*opt.imgWidth},opt.motionSpeed)
					break;
				case 'y':
					$imgSet.stop().animate({'top':-currentImg*opt.imgHeight},opt.motionSpeed)
					break;
				default:
					$imgList.eq(oldCurrentImg).hide();
					$imgList.eq(currentImg).show();
			}

			setReplace($menuList.eq(oldCurrentImg).find('img'),'src','_on','_off');
			setReplace($menuList.eq(currentImg).find('img'),'src','_off','_on');
			$menuList.eq(oldCurrentImg).removeClass('small_select');
			$menuList.eq(currentImg).addClass('small_select');	
			oldCurrentImg=currentImg;
		}

		function setReplace(_mc,_attr,_old,_new){
			var str=_mc.attr(_attr);
			if(String(str).search(_old)!=-1){
				_mc.attr(_attr,str.replace(_old,_new));
			}
		}
	})
}
})(jQuery)