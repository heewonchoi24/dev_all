<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<script type="text/javascript" src="/common/js/date.js"></script>
<script type="text/javascript" src="/common/js/jquery.datePicker.js"></script>
<script type="text/javascript" src="/common/js/jquery.ui.spinner.js"></script>
<script type="text/javascript" src="/common/js/jquery.ui.button.js"></script>
<script type="text/javascript">  
$(document).ready(function() {
	var devlDate = new Date();
	devlDate.setDate (devlDate.getDate() + 6);
	Date.format	= 'yyyy.mm.dd';
	$('.date-pick').datePicker({
		startDate: devlDate,
		clickInput:true
	});

	$(".spinner").spinner({
		max: 9,
		min: 1
	});
});

</script>
<script type="text/javascript">
<!--
$(document).ready(function() {
 
	$('.panelbtn a').click(function(){
		switch_tabs($(this));
	});
 
	switch_tabs($('.defaulttab'));
 
});
 
function switch_tabs(obj)
{
	$('.layer-content').hide();
	$('.ordertabs a').removeClass("selected");
	var id = obj.attr("rel");
 
	$('#'+id).show();
	obj.addClass("selected");
}
//-->
</script>

<div id="layerWrap">
   <ul class="panelbtn">
     <li><a class="defaulttab cartbtn" rel="cart-wrap" href="#">장바구니</a></li>
     <li><a class="defaulttab couponbtn" rel="coupon-wrap" href="#">쿠폰북</a></li>
   </ul>
  <div class="layerContainer">
    <div class="layer-content" id="cart-wrap">
      <div>
        <div class="button light small center"> <a href="/shop/cart.jsp">장바구니 자세히보기</a> </div>
      </div>
      <div class="onethree-fix firstpart" style="width:330px;">
        <h4>일배상품</h4>
        <dl>
        <dt>
          <input type="checkbox" class="selectable" value="" />
          <label>1일2식(퀴진,알라까르떼HOT)</label>
        </dt>
        <dd>
          <input class="spinner" name="buy_qty" style="width:30px;" value="" />
        </dd>
        </dl>
        <dl>
        <dt><label>첫 배송일지정</label></dt>
        <dd>
          <input name="devlDate" id="devlDate" class="date-pick" value="" />
        </dd>
        </dl>
        <dl>
        <dt><label>기간 : 2주(5일)</label></dt>
        <dd><span class="won">104,400원</span></dd>
        </dl>
        <div class="lineSeparator"></div>
        <dl>
        <dt>
          <input type="checkbox" class="selectable" value="" />
          <label>보냉가방</label>
        </dt>
        <dd>
          <input class="spinner" name="buy_qty" style="width:30px;" value="" />
        </dd>
        </dl>
        <dl>
        <dt></dt>
        <dd><span class="won">5,000원</span></dd>
        </dl>
        <div style="display:none;">장바구니에 담은 상품이 없습니다.</div>
      </div>
      <div class="onethree-fix lastpart" style="width:340px;">
        <h4>택배상품</h4>
        <dl>
        <dt>
          <input type="checkbox" class="selectable" value="" />
          <label>1일2식(퀴진,알라까르떼HOT)</label>
        </dt>
        <dd>
          <input class="spinner" name="buy_qty" style="width:30px;" value="" />
        </dd>
        </dl>
        <dl>
        <dt><label>첫 배송일지정</label></dt>
        <dd>
          <input name="devlDate" id="devlDate" class="date-pick" value="" />
        </dd>
        </dl>
        <dl>
        <dt><label>기간 : 2주(5일)</label></dt>
        <dd><span class="won">104,400원</span></dd>
        </dl>
        <div class="lineSeparator"></div>
        <dl>
        <dt>
          <input type="checkbox" class="selectable" value="" />
          <label>보냉가방</label>
        </dt>
        <dd>
          <input class="spinner" name="buy_qty" style="width:30px;" value="" />
        </dd>
        </dl>
        <dl>
        <dt></dt>
        <dd><span class="won">5,000원</span></dd>
        </dl>
        <div style="display:none;">장바구니에 담은 상품이 없습니다.</div>
      </div>
      <div class="onethree-fix bg-gray floatright" style="width:230px;padding:10px 10px 15px 10px;">
         <div style="padding:20px 20px 0 20px;">
         <dl>
            <dt><label>주문금액</label></dt>
            <dd>106,000원</dd>
         </dl>
         <dl>
            <dt><label>총 배송비</label></dt>
            <dd>0원</dd>
         </dl>
         </div>
         <div class="lineSeparator"></div>
         <div style="padding:0 20px 15px 20px; text-align:right;">
         <p>총 결제 예정금액</p>
         <p class="won">320,500원</p>
         </div>
         <div class="center">
         <div class="button large dark iconBtn"><a href="/shop/cart.jsp"><span class="star"></span>바로구매</a></div>
         </div>
      </div>
      <div class="clear"></div>
    </div>
    <!-- End cart-wrap -->
    <div class="layer-content" id="coupon-wrap">
      <div class="mycoupon">
        <div class="sectionHeader">
          <h4> <b class="font-blue"><%=eslMemberName%>님</b>, 반갑습니다. 고객님께서 사용가능한 쿠폰이 <b class="font-maple">3</b>장 있습니다. </h4>
          <div class="floatright button dark small"> <a href="/shop/mypage/couponList.jsp">보유쿠폰 더보기</a> </div>
        </div>
        <div class="element onefourth">
          <div class="couponImage sale">
            <div class="couponInfo"> 10,000원 </div>
          </div>
          <div class="post-text">
            <h5> <a href="#">회원가입 축하쿠폰</a> </h5>
            <div class="review-text"> 모든 주문시 사용가능 </div>
            <div class="review-date"> 2013.07.28~2013.08.28 </div>
          </div>
        </div>
        <div class="element onefourth">
          <div class="couponImage present">
            <div class="couponInfo"> 30% 할인 </div>
          </div>
          <div class="post-text">
            <h5> <a href="#">[7월 이벤트]Quick프로그램</a> </h5>
            <div class="review-text"> 75,600원 이상 구매시 사용가능 </div>
            <div class="review-date"> 2013.07.28~2013.08.28 </div>
          </div>
        </div>
        <div class="element onefourth">
          <div class="couponImage sale">
            <div class="couponInfo"> 10,000원 </div>
          </div>
          <div class="post-text">
            <h5> <a href="#">회원가입 축하쿠폰</a> </h5>
            <div class="review-text"> 모든 주문시 사용가능 </div>
            <div class="review-date"> 2013.07.28~2013.08.28 </div>
          </div>
        </div>
        <div class="element onefourth last">
          <div class="couponImage present">
            <div class="couponInfo"> 30% 할인 </div>
          </div>
          <div class="post-text">
            <h5> <a href="#">[7월 이벤트]Quick프로그램</a> </h5>
            <div class="review-text"> 75,600원 이상 구매시 사용가능 </div>
            <div class="review-date"> 2013.07.28~2013.08.28 </div>
          </div>
        </div>
        <div class="clear"></div>
      </div>
      <!-- End mycoupon --> 
    </div>
    <!-- End coupon-wrap -->
    <div id="login-wrap" style="display:none;">
      <div class="loginguide">
      <div class="logo"></div>
      <span style="padding-right:10px;">로그인을 해주세요.</span>
      <div class="button dark small"> <a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=600&lightbox[height]=350">로그인</a> </div>
      </div>
    </div>
    <!-- End login-wrap --> 
  </div>
  <!-- End layerContainer -->
</div>
<!-- End layerWrap -->