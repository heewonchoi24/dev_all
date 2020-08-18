<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_phi.jsp"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<title>배송지 가능지역 확인</title>
</head>
<body>
	<div class="pop-wrap">
		<div class="headpop">
			<h2>배송지 가능지역 확인</h2>
			<p></p>
		</div>
		<div class="contentpop">
			<div class="popup columns offset-by-one"> 
				<div class="row">
					<div class="one last col">
						<form name="frm_zipcode">
							<div class="postSearchBox">
								<p>찾고자 하는 지역의 동/읍/면/리 건물명을 입력하세요.</p>
								<p>(예: 서울시 강남구 신사1동일 경우, '신사' 또는 '신사동'을 입력하시면 됩니다.</p>
								<label>지역 검색어</label>
								<input type="text" class="inputfield" name="dong" id="dong"> <span class="button small light" style="margin:0;"><a href="javascript:;" onclick="schZipCode();">조회</a></span>
							</div>
						</form>
						<div class="marb20 mart20" style="text-align:center;">
							<p class="bold7">검색결과에 주소가 검색될 경우, 배송가능한 지역입니다.<br />
							<font class="f12 font-gray">(주소 리스트에 검색되지 않을 경우 배송 불가한 지역입니다.)</font></p>
						</div>
						<div class="frameBox">
							<table class="tbmulti" width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<th>우편번호</th>
									<th>주소</th>
								</tr>
								<tr>
								<td>151-015</td>
								<td class="left">서울 관악구 신림동</td>
								</tr>
								<tr>
								<td>151-016</td>
								<td class="left">서울 관악구 신림동 서울관악우체국</td>
								</tr>
								<tr>
								<td>151-708</td>
								<td class="left">서울 관악구 신림동 태영아파트</td>
								</tr>
								<tr>
								<td>151-706</td>
								<td class="left">서울 관악구 신림동 서울관악우체국</td>
								</tr>
								<tr>
								<td>151-800</td>
								<td class="left">서울 관악구 신림동 태영아파트</td>
								</tr>
							</table>
						</div> 
						<div class="clear"></div>
					</div>
				</div>
				<!-- End row -->
				<div class="row">
					<div class="one last col">
						<div class="pageNavi">
							<a class="latelypostslink" href="#"><<</a>
							<a class="previouspostslink" href="#"><</a>
							<span class="current">1</span>
							<a href="#">2</a>
							<a href="#">3</a>
							<a href="#">4</a>
							<a href="#">5</a>
							<a class="firstpostslink" href="#">></a>
							<a class="nextpostslink" href="#">>></a>
						</div>
					</div>	
				</div>
			</div>
			<!-- End popup columns offset-by-one -->	
		</div>
		<!-- End contentpop -->
	</div>
</body>
</html>