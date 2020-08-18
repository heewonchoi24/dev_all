
// 창 띄우기
function prdCallback(){
	var carouselEl = $('#layerPopupT2 .owl-carousel');
	
	carouselEl.each(function(){
		var obj = $(this)
		var carouselElBtn = obj.siblings('.owl-nav');
		obj.owlCarousel({
			margin:40,
			nav:false,
			dots:true,
			items:3
		});

		carouselElBtn.find(".owl-next").click(function() {
			obj.trigger('next.owl.carousel');
		});
		carouselElBtn.find(".owl-prev").click(function() {
			obj.trigger('prev.owl.carousel');
		});
	
		if (obj.find(".item").length <= 3){
			carouselElBtn.hide();
		}
	});
}//prdCallback


