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
     <li><a class="defaulttab cartbtn" rel="cart-wrap" href="#">��ٱ���</a></li>
     <li><a class="defaulttab couponbtn" rel="coupon-wrap" href="#">������</a></li>
   </ul>
  <div class="layerContainer">
    <div class="layer-content" id="cart-wrap">
      <div>
        <div class="button light small center"> <a href="/shop/cart.jsp">��ٱ��� �ڼ�������</a> </div>
      </div>
      <div class="onethree-fix firstpart" style="width:330px;">
        <h4>�Ϲ��ǰ</h4>
        <dl>
        <dt>
          <input type="checkbox" class="selectable" value="" />
          <label>1��2��(����,�˶���HOT)</label>
        </dt>
        <dd>
          <input class="spinner" name="buy_qty" style="width:30px;" value="" />
        </dd>
        </dl>
        <dl>
        <dt><label>ù ���������</label></dt>
        <dd>
          <input name="devlDate" id="devlDate" class="date-pick" value="" />
        </dd>
        </dl>
        <dl>
        <dt><label>�Ⱓ : 2��(5��)</label></dt>
        <dd><span class="won">104,400��</span></dd>
        </dl>
        <div class="lineSeparator"></div>
        <dl>
        <dt>
          <input type="checkbox" class="selectable" value="" />
          <label>���ð���</label>
        </dt>
        <dd>
          <input class="spinner" name="buy_qty" style="width:30px;" value="" />
        </dd>
        </dl>
        <dl>
        <dt></dt>
        <dd><span class="won">5,000��</span></dd>
        </dl>
        <div style="display:none;">��ٱ��Ͽ� ���� ��ǰ�� �����ϴ�.</div>
      </div>
      <div class="onethree-fix lastpart" style="width:340px;">
        <h4>�ù��ǰ</h4>
        <dl>
        <dt>
          <input type="checkbox" class="selectable" value="" />
          <label>1��2��(����,�˶���HOT)</label>
        </dt>
        <dd>
          <input class="spinner" name="buy_qty" style="width:30px;" value="" />
        </dd>
        </dl>
        <dl>
        <dt><label>ù ���������</label></dt>
        <dd>
          <input name="devlDate" id="devlDate" class="date-pick" value="" />
        </dd>
        </dl>
        <dl>
        <dt><label>�Ⱓ : 2��(5��)</label></dt>
        <dd><span class="won">104,400��</span></dd>
        </dl>
        <div class="lineSeparator"></div>
        <dl>
        <dt>
          <input type="checkbox" class="selectable" value="" />
          <label>���ð���</label>
        </dt>
        <dd>
          <input class="spinner" name="buy_qty" style="width:30px;" value="" />
        </dd>
        </dl>
        <dl>
        <dt></dt>
        <dd><span class="won">5,000��</span></dd>
        </dl>
        <div style="display:none;">��ٱ��Ͽ� ���� ��ǰ�� �����ϴ�.</div>
      </div>
      <div class="onethree-fix bg-gray floatright" style="width:230px;padding:10px 10px 15px 10px;">
         <div style="padding:20px 20px 0 20px;">
         <dl>
            <dt><label>�ֹ��ݾ�</label></dt>
            <dd>106,000��</dd>
         </dl>
         <dl>
            <dt><label>�� ��ۺ�</label></dt>
            <dd>0��</dd>
         </dl>
         </div>
         <div class="lineSeparator"></div>
         <div style="padding:0 20px 15px 20px; text-align:right;">
         <p>�� ���� �����ݾ�</p>
         <p class="won">320,500��</p>
         </div>
         <div class="center">
         <div class="button large dark iconBtn"><a href="/shop/cart.jsp"><span class="star"></span>�ٷα���</a></div>
         </div>
      </div>
      <div class="clear"></div>
    </div>
    <!-- End cart-wrap -->
    <div class="layer-content" id="coupon-wrap">
      <div class="mycoupon">
        <div class="sectionHeader">
          <h4> <b class="font-blue"><%=eslMemberName%>��</b>, �ݰ����ϴ�. ���Բ��� ��밡���� ������ <b class="font-maple">3</b>�� �ֽ��ϴ�. </h4>
          <div class="floatright button dark small"> <a href="/shop/mypage/couponList.jsp">�������� ������</a> </div>
        </div>
        <div class="element onefourth">
          <div class="couponImage sale">
            <div class="couponInfo"> 10,000�� </div>
          </div>
          <div class="post-text">
            <h5> <a href="#">ȸ������ ��������</a> </h5>
            <div class="review-text"> ��� �ֹ��� ��밡�� </div>
            <div class="review-date"> 2013.07.28~2013.08.28 </div>
          </div>
        </div>
        <div class="element onefourth">
          <div class="couponImage present">
            <div class="couponInfo"> 30% ���� </div>
          </div>
          <div class="post-text">
            <h5> <a href="#">[7�� �̺�Ʈ]Quick���α׷�</a> </h5>
            <div class="review-text"> 75,600�� �̻� ���Ž� ��밡�� </div>
            <div class="review-date"> 2013.07.28~2013.08.28 </div>
          </div>
        </div>
        <div class="element onefourth">
          <div class="couponImage sale">
            <div class="couponInfo"> 10,000�� </div>
          </div>
          <div class="post-text">
            <h5> <a href="#">ȸ������ ��������</a> </h5>
            <div class="review-text"> ��� �ֹ��� ��밡�� </div>
            <div class="review-date"> 2013.07.28~2013.08.28 </div>
          </div>
        </div>
        <div class="element onefourth last">
          <div class="couponImage present">
            <div class="couponInfo"> 30% ���� </div>
          </div>
          <div class="post-text">
            <h5> <a href="#">[7�� �̺�Ʈ]Quick���α׷�</a> </h5>
            <div class="review-text"> 75,600�� �̻� ���Ž� ��밡�� </div>
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
      <span style="padding-right:10px;">�α����� ���ּ���.</span>
      <div class="button dark small"> <a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=600&lightbox[height]=350">�α���</a> </div>
      </div>
    </div>
    <!-- End login-wrap --> 
  </div>
  <!-- End layerContainer -->
</div>
<!-- End layerWrap -->