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
				<span>Ȩ</span><span>����������</span><strong>ȸ��Ż��</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="sixteen columns offset-by-one">
			<div class="row">
				<div class="one last col">
					<ul class="tabNavi">
						<li><a href="javascript:void(0);">ȸ��Ż��</a></li>
					</ul>
					<div class="clear"></div>
				</div>
			</div>
			<div class="row">
				<div class="one last col">
					<div class="member_leave_top">
						<img src="/dist/images/mypage/member_leave_top_img.png" />
						<h3>������ �Ҽ� �������� ������ �����ϰ� �ش� ������ ���� ȸ�� Ż�� �����մϴ�.</h3>
						<p>�����ϼ̴� ���̳� �Ҹ������� �˷��ֽø� ���� �ݿ��Ͽ� �������� �ؼ��� �帮���� ����ϰڽ��ϴ�.<br/> Ż�� ��, ������ ����� ��� ������ ���������� ������ �Ұ����ϵ��� �����˴ϴ�. </p>
					</div>
					<div class="divider"></div>
					<div class="sectionHeader">
						<h4>������ �����ϼ̳���?</h4>
					</div>
					<div class="member_leave_reason">
						<ul>
							<li>
								<input id="icd_1" type="radio" name="inconvenient_detail" value="��ǰ �Ҹ���">
								<label for="icd_1">��ǰ �Ҹ���</label>
							</li>
							<li>
								<input id="icd_2" type="radio" name="inconvenient_detail" value="������ ���� ����">
								<label for="icd_2">������ ���� ����</label>
							</li>
							<li>
								<input id="icd_3" type="radio" name="inconvenient_detail" value="��� �Ҹ���">
								<label for="icd_3">��� �Ҹ���</label>
							</li>
							<li>
								<input id="icd_4" type="radio" name="inconvenient_detail" value="�������� ���� ���">
								<label for="icd_4">�������� ���� ���</label>
							</li>
							<li>
								<input id="icd_5" type="radio" name="inconvenient_detail" value="��ȯ/��ǰ/ȯ�� �Ҹ�">
								<label for="icd_5">��ȯ/��ǰ/ȯ�� �Ҹ�</label>
							</li>
							<li>
								<input id="icd_6" type="radio" name="inconvenient_detail" value="��ģ��(������)">
								<label for="icd_6">��ģ��(������)</label>
							</li>
							<li>
								<input id="icd_7" type="radio" name="inconvenient_detail" value="��Ÿ����">
								<label for="icd_7">��Ÿ����</label>
							</li>
						</ul>
					</div>
					<div class="divider"></div>
					<div class="sectionHeader">
						<h4>���ɾ ��� ��Ź �帳�ϴ�.</h4>
					</div>
					<textarea id="comment_detail" name="content" rows="8" style="width:100%;" required="" label="����"></textarea>
				</div>
			</div>
			<div class="divider"></div>
			<div class="row">
				<div class="last col">
					<div class="center">
						<a href="javascript:void(0);" onClick="btn_memberLeave();" class="button2 large black">ȸ��Ż��</a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="/index_es.jsp" class="button2 large">���</a>
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