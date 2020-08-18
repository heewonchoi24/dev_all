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
// �ҼȰ���ȸ��Ż��
function btn_memberLeave(){
	//	������ �����ϼ̳���?
	var	inconvenient_detail = $("input[type=radio][name=inconvenient_detail]:checked").val();
	//	���ɾ ��� ��Ź �帳�ϴ�.
	var comment_detail = $("#comment_detail").val(); 
	comment_detail = comment_detail.trim();

	console.log(inconvenient_detail);
	console.log(comment_detail);
	
    // post ������� �Ķ���� �� ����
     if (confirm("ȸ�� Ż�� �����Ͻðڽ��ϱ�?")) {
	   $.post("member_leave_ajax.jsp", {
		   inconvenient_detail : inconvenient_detail
	      ,comment_detail      : comment_detail
		},
		function(data) {
			$(data).find("result").each(function() {
				if ($(this).text() == "success") {
					alert("ȸ��Ż�� �Ϸ�Ǿ����ϴ�. �����մϴ�.");
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
					<h2>ȸ��Ż��</h2>
				</header>
				<div class="content" id="member_leave">
					<div class="boxTable">
						<div class="member_leave_top">
							<br>
							<img src="/dist/images/mypage/member_leave_top_img.png" />
							<br>
							<h3>������ �Ҽ� �������� ������ �����ϰ� �ش� ������ ���� ȸ�� Ż�� �����մϴ�.</h3>
							<p>�����ϼ̴� ���̳� �Ҹ������� �˷��ֽø� ���� �ݿ��Ͽ� �������� �ؼ��� �帮���� ����ϰڽ��ϴ�.<br><br/> Ż�� ��, ������ ����� ��� ������ ���������� ������ �Ұ����ϵ��� �����˴ϴ�. </p>
						</div>
						<div class="divider"></div>
						<div class="sectionHeader">
							<h4>������ �����ϼ̳���?</h4>
						</div>
						<div class="member_leave_reason">
							<ul>
								<li>
									<input id="icd_1" name="inconvenient_detail" type="radio" name="inconvenient_detail" value="��ǰ �Ҹ���">
									<label for="icd_1">��ǰ �Ҹ���</label>
								</li>
								<li>
									<input id="icd_2" name="inconvenient_detail" type="radio" name="inconvenient_detail" value="������ ���� ����">
									<label for="icd_2">������ ���� ����</label>
								</li>
								<li>
									<input id="icd_3" name="inconvenient_detail" type="radio" name="inconvenient_detail" value="��� �Ҹ���">
									<label for="icd_3">��� �Ҹ���</label>
								</li>
								<li>
									<input id="icd_4" name="inconvenient_detail" type="radio" name="inconvenient_detail" value="�������� ���� ���">
									<label for="icd_4">�������� ���� ���</label>
								</li>
								<li>
									<input id="icd_5" name="inconvenient_detail" type="radio" name="inconvenient_detail" value="��ȯ/��ǰ/ȯ�� �Ҹ�">
									<label for="icd_5">��ȯ/��ǰ/ȯ�� �Ҹ�</label>
								</li>
								<li>
									<input id="icd_6" name="inconvenient_detail" type="radio" name="inconvenient_detail" value="��ģ��(������)">
									<label for="icd_6">��ģ��(������)</label>
								</li>
								<li>
									<input id="icd_7" name="inconvenient_detail" type="radio" name="inconvenient_detail" value="��Ÿ����">
									<label for="icd_7">��Ÿ����</label>
								</li>
							</ul>
						</div>
						<div class="divider"></div>
						<div class="sectionHeader">
							<h4>���ɾ ��� ��Ź �帳�ϴ�.</h4>
						</div>
						<textarea id="comment_detail" name="content" rows="8" style="width:100%; box-sizing: border-box;" required="" label="����"></textarea>
					</div>
					<div class="qnaBtns">
					<br>
					<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="javascript:void(0);" onClick="btn_memberLeave();" class="btn btn_dgray square" style="min-width: 80px;">ȸ��Ż��</a>
						&nbsp;&nbsp;
						<a href="/mobile/index.jsp" class="btn btn_gray square" style="min-width: 80px;">���</a>
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
