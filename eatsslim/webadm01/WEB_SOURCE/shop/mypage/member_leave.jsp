<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-login-check.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
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

</head>
<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div>
	<!-- End header -->
	<div class="container">
		<div class="maintitle">
			<div class="pageDepth">
				<span>홈</span><span>마이페이지</span><strong>회원탈퇴</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="sixteen columns offset-by-one">
			<div class="row">
				<div class="one last col">
					<ul class="tabNavi">
						<li><a href="javascript:void(0);">회원탈퇴</a></li>
					</ul>
					<div class="clear"></div>
				</div>
			</div>
			<div class="row">
				<div class="one last col">
					<div class="member_leave_top">
						<img src="/dist/images/mypage/member_leave_top_img.png" />
						<h3>연동된 소셜 계정과의 연결을 해제하고 해당 계정에 대해 회원 탈퇴를 진행합니다.</h3>
						<p>불편하셨던 점이나 불만사항을 알려주시면 적극 반영하여 불편함을 해소해 드리도록 노력하겠습니다.<br/> 탈퇴 시, 서버에 저장된 모든 고객님의 개인정보는 복구가 불가능하도록 삭제됩니다. </p>
					</div>
					<div class="divider"></div>
					<div class="sectionHeader">
						<h4>무엇이 불편하셨나요?</h4>
					</div>
					<div class="member_leave_reason">
						<ul>
							<li>
								<input id="icd_1" type="radio" name="inconvenient_detail" value="상품 불만족">
								<label for="icd_1">상품 불만족</label>
							</li>
							<li>
								<input id="icd_2" type="radio" name="inconvenient_detail" value="실질적 혜택 부족">
								<label for="icd_2">실질적 혜택 부족</label>
							</li>
							<li>
								<input id="icd_3" type="radio" name="inconvenient_detail" value="배송 불만족">
								<label for="icd_3">배송 불만족</label>
							</li>
							<li>
								<input id="icd_4" type="radio" name="inconvenient_detail" value="개인정보 유출 우려">
								<label for="icd_4">개인정보 유출 우려</label>
							</li>
							<li>
								<input id="icd_5" type="radio" name="inconvenient_detail" value="교환/반품/환불 불만">
								<label for="icd_5">교환/반품/환불 불만</label>
							</li>
							<li>
								<input id="icd_6" type="radio" name="inconvenient_detail" value="불친절(고객응대)">
								<label for="icd_6">불친절(고객응대)</label>
							</li>
							<li>
								<input id="icd_7" type="radio" name="inconvenient_detail" value="기타사유">
								<label for="icd_7">기타사유</label>
							</li>
						</ul>
					</div>
					<div class="divider"></div>
					<div class="sectionHeader">
						<h4>진심어린 충고 부탁 드립니다.</h4>
					</div>
					<textarea id="comment_detail" name="content" rows="8" style="width:100%;" required="" label="내용"></textarea>
				</div>
			</div>
			<div class="divider"></div>
			<div class="row">
				<div class="last col">
					<div class="center">
						<a href="javascript:void(0);" onClick="btn_memberLeave();" class="button2 large black">회원탈퇴</a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="/index_es.jsp" class="button2 large">취소</a>
					</div>
				</div>
			</div>
		</div>
		<!-- End sixteen columns offset-by-one -->
		<div class="clear"></div>
	</div>
	<!-- End container -->
	<div id="footer">
		<%@ include file="/common/include/inc-footer.jsp"%>
	</div>
	<!-- End footer -->
	<div id="floatMenu">
		<%@ include file="/common/include/inc-floating.jsp"%>
	</div>
	<%@ include file="/common/include/inc-bottompanel.jsp"%>
</div>
<script type="text/javascript">
	$("#emailSelect").change(function(e) {
		var v = $(this).val();

		if(v != ""){
			$("#emailInput").prop('readonly', true);
		}else{
			$("#emailInput").prop('readonly', false);
		}

		$("#emailInput").val(v);
	});
</script>
</body>
</html>
<%@ include file="/lib/dbclose.jsp"%>