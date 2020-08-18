<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />

	<title>배송지 확인</title>
</head>
<body>
	<div class="pop-wrap">
		<div class="headpop">
		    <h2>배송지 확인</h2>
			<p>고객님께서 선택하신 메뉴에는 일배상품이 포함되어 있습니다.<br />배송지를 입력하신 후 배송가능 지역인지 확인 부탁드립니다.</p>
		</div>
	    <div class="contentpop">
		    <div class="popup columns offset-by-one"> 
					<div class="row">
					   <div class="one last col">
					      <p class="mart30 marb20">
                          <span><input name="" type="radio" value=""> 최근 배송지</span>
                          <span><input name="" type="radio" value=""> 새 배송지 입력</span>
                          </p>
                          <div class="divider"></div>
                          <div>
                          <label>우편번호</label>
                          <input name="" type="text" class="ftfd" style="width:50px;"> - <input name="" type="text" class="ftfd" style="width:50px;"> <span class="button dark small"><a href="#">우편번호 검색</a></span>
							<br />
						  <input name="" type="text" class="ftfd" style="width:340px; margin-top:5px;">
						  <input name="" type="text" class="ftfd" style="width:340px; margin-top:5px;">
                          </div>
                          <p class="font-green bold7">*배송지를 입력해주세요.</p>
					   </div>
					</div>
					<!-- End row -->  
					<div class="row">
						<div class="one last col">
							<span class="bold7" style="padding-right:30px;">배송지 주소를 입력하시면 배달 가능여부를 알려드립니다.</span><span class="button small white"><a href="#">다음단계 ></a></span>
						</div>
					</div>
					<!-- End row -->
			  </div>
			  <!-- End popup columns offset-by-one -->	
		</div>
		<!-- End contentpop -->
	</div>
</body>
</html>