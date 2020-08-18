<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
</head>
<body>
<div class="pop-wrap">
  <div class="headpop">
    <h2>주문 취소</h2>
    <button id="cboxClose" type="button">close</button>
    <div class="clear"></div>
  </div>
  <div class="contentpop">
    <h2 class="ui-title">주문취소 상품</h2>
    <dl class="itemlist">
      <dt style="width:70%;">다이어트 식사 3식/1개
        <p class="font-gray">(퀴진A+퀴진B+알라까르떼COOL)</p>
      </dt>
      <dd style="width:30%;">104,400원</dd>
    </dl>
    <dl class="itemlist">
      <dt style="width:70%;">뷰티워터티/1BOX
        <p class="font-gray">(퀴진A+퀴진B+알라까르떼COOL)</p>
      </dt>
      <dd style="width:30%;">24,000원</dd>
    </dl>
    <h2 class="ui-title">결제정보 확인</h2>
    <dl class="itemlist">
      <dt style="width:70%;">결제방법</dt>
      <dd style="width:30%;">신용카드</dd>
      <dt style="width:70%;">상품합계금액</dt>
      <dd style="width:30%;">104,400원</dd>
      <dt style="width:70%;">상품할인</dt>
      <dd style="width:30%;">(-) 5,000원</dd>
      <dt style="width:70%;">전체 배송비</dt>
      <dd style="width:30%;">(+) 2,500원</dd>
    </dl>
    <div class="divider"></div>
    <dl class="itemlist redline" style="margin:0 10px;">
      <dt class="f16">총 결제금액</dt>
      <dd class="f16 font-orange">109,400원</dd>
    </dl>
    <div class="divider"></div>
    <h2 class="ui-title">취소사유</h2>
    <dl class="itemlist">
      <dt style="width:30%;">취소사유</dt>
      <dd style="width:70%;">
          <ul class="form-line" style="margin:0;">
             <li>
             <div class="select-box">
            <select>
               <option value="1">퀴진A/퀴진B/알라</option>
            </select>
             </div>
            </li>
           </ul>  
      </dd>
      <dt style="width:30%;">요청사항</dt>
      <dd style="width:70%;">
         <ul class="form-line" style="margin:0;">
             <li>
            <input name="" type="text" style="width:90%;">
        </li>
           </ul>
      </dd>
    </dl>
    <div class="divider"></div>
    <h2 class="ui-title">환불금액</h2>
    <dl class="itemlist">
      <dt style="width:30%;">환불계좌은행</dt>
      <dd style="width:70%;">
         <ul class="form-line" style="margin:0;">
             <li>
             <div class="select-box">
            <select>
               <option value="1">퀴진A/퀴진B/알라</option>
            </select>
             </div>
            </li>
           </ul>  
      </dd>
      <dt style="width:30%;">결제방법</dt>
      <dd style="width:70%;">총금액:200,000원</dd>
      <dt style="width:30%;">결제정보</dt>
      <dd style="width:70%;">50,000원(총20일중 5일 취소)</dd>
      <dt style="width:30%;">환불금액</dt>
      <dd class="f16 font-orange" style="width:70%;">100,000원</dd>
    </dl>
    <div class="divider"></div>
    <div class="grid-navi" style="margin:0 10px;">
            <table class="navi" border="0" cellspacing="10" cellpadding="0">
               <tr>
                 <td><a href="#" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">취소신청</span></span></a></td>
               </tr>
            </table>
        </div>
  </div>
  <!-- End contentpop -->
</div>
</body>
</html>
