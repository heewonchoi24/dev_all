<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import ="javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-login-check.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%
String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
int tcnt			= 0;
int couponId		= 0;
String couponName	= "";
String couponNum	= "";
String saleType		= "";
int salePrice		= 0;
int useLimitCnt		= 0;
int useLimitPrice	= 0;
String useLimitTxt	= "";
String useGoods		= "";
String useGoodsTxt	= "";
String stdate		= "";
String ltdate		= "";
String counselID	= "";
String btnMod		= "";
String btnDel		= "";
String upFile		= "";
String imgUrl		= "";
NumberFormat nf		= NumberFormat.getNumberInstance();
%>
<script type="text/javascript">
// 소셜계정회원탈퇴
function btn_memberLeave(){
	//	무엇이 불편하셨나요?
	var	inconvenient_detail = $("input[type=radio][name=inconvenient_detail]:checked").val();
	//	진심어린 충고 부탁 드립니다.
	var comment_detail = $("#comment_detail").val(); 
	comment_detail = comment_detail.trim();

	console.log(inconvenient_detail);
	console.log(comment_detail);
	
    // post 방식으로 파라미터 값 전송
     if (confirm("회원 탈퇴를 진행하시겠습니까?")) {
	   $.post("member_leave_ajax.jsp", {
		   inconvenient_detail : inconvenient_detail
	      ,comment_detail      : comment_detail
		},
		function(data) {
			$(data).find("result").each(function() {
				if ($(this).text() == "success") {
					alert("회원탈퇴가 완료되었습니다. 감사합니다.");
					location.href = '/sso/logout.jsp';
				} 
				else {
					$(data).find("error").each(function() {
						alert($(this).text());
					});
				}
			});
		}, "xml");
	   return false;
    }
}
</script>
<script type="text/javascript" src="/common/js/date.js"></script>
<script type="text/javascript" src="/common/js/jquery.datePicker.js"></script>
<script type="text/javascript" src="/common/js/common.js"></script>
</head>
<body>
<div id="wrap" class="expansioncss">
	<%@ include file="/mobile/common/include/inc-header.jsp"%>
	<!-- End header -->
	<div id="container">
		<div class="container_inner">
			<section id="index_content" class="contents">
				<header class="cont_header">
					<h2>회원탈퇴</h2>
				</header>
				<div class="content" id="member_leave">
					<div class="boxTable">
						<div class="member_leave_top">
							<br>
							<img src="/dist/images/mypage/member_leave_top_img.png" />
							<br>
							<h3>연동된 소셜 계정과의 연결을 해제하고 해당 계정에 대해 회원 탈퇴를 진행합니다.</h3>
							<p>불편하셨던 점이나 불만사항을 알려주시면 적극 반영하여 불편함을 해소해 드리도록 노력하겠습니다.<br><br/> 탈퇴 시, 서버에 저장된 모든 고객님의 개인정보는 복구가 불가능하도록 삭제됩니다. </p>
						</div>
						<div class="divider"></div>
						<div class="sectionHeader">
							<h4>무엇이 불편하셨나요?</h4>
						</div>
						<div class="member_leave_reason">
							<ul>
								<li>
									<input id="icd_1" name="inconvenient_detail" type="radio" name="inconvenient_detail" value="상품 불만족">
									<label for="icd_1">상품 불만족</label>
								</li>
								<li>
									<input id="icd_2" name="inconvenient_detail" type="radio" name="inconvenient_detail" value="실질적 혜택 부족">
									<label for="icd_2">실질적 혜택 부족</label>
								</li>
								<li>
									<input id="icd_3" name="inconvenient_detail" type="radio" name="inconvenient_detail" value="배송 불만족">
									<label for="icd_3">배송 불만족</label>
								</li>
								<li>
									<input id="icd_4" name="inconvenient_detail" type="radio" name="inconvenient_detail" value="개인정보 유출 우려">
									<label for="icd_4">개인정보 유출 우려</label>
								</li>
								<li>
									<input id="icd_5" name="inconvenient_detail" type="radio" name="inconvenient_detail" value="교환/반품/환불 불만">
									<label for="icd_5">교환/반품/환불 불만</label>
								</li>
								<li>
									<input id="icd_6" name="inconvenient_detail" type="radio" name="inconvenient_detail" value="불친절(고객응대)">
									<label for="icd_6">불친절(고객응대)</label>
								</li>
								<li>
									<input id="icd_7" name="inconvenient_detail" type="radio" name="inconvenient_detail" value="기타사유">
									<label for="icd_7">기타사유</label>
								</li>
							</ul>
						</div>
						<div class="divider"></div>
						<div class="sectionHeader">
							<h4>진심어린 충고 부탁 드립니다.</h4>
						</div>
						<textarea id="comment_detail" name="content" rows="8" style="width:100%; box-sizing: border-box;" required="" label="내용"></textarea>
					</div>
					<div class="qnaBtns">
					<br>
					<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="javascript:void(0);" onClick="btn_memberLeave();" class="btn btn_dgray square" style="min-width: 80px;">회원탈퇴</a>
						&nbsp;&nbsp;
						<a href="/mobile/index.jsp" class="btn btn_gray square" style="min-width: 80px;">취소</a>
					<br>
					<br>
					</div>
				</div>
			</section>
			<section id="load_content" class="contents">

			</section>
		</div>
	</div>
	<!-- End container -->

		<%@ include file="/mobile/common/include/inc-footer.jsp"%>
	<!-- End footer -->
</div>
</body>
</html>
