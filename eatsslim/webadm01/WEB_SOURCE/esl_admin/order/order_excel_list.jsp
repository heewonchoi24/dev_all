<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-top.jsp"%>
<%@ include file="../include/inc-cal-script.jsp" %>

	<script type="text/javascript" src="../js/sub.js"></script>
	<script type="text/javascript" src="../js/left.js"></script>
	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:6,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
		leftcon();
	})
	//]]>
	</script><link rel="stylesheet" type="text/css" href="/common/js/_calendars/jquery.datepick.layer.css" />
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick.js"></script>
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick-ko.js"></script>	
</head>
<body>
<div style="display: none;">
	<img id="calImg" src="/images/calendar.png" alt="Popup" class="trigger" style="vertical-align:middle;" />
</div>
<!-- wrap -->
<div id="wrap">
	<%@ include file="../include/inc-header.jsp" %>
	<!-- container -->
	<div id="container" class="group">
		<%@ include file="../include/inc-sidebar-order.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="Ȩ" /> &gt; �ֹ����� &gt; <strong>�ֹ�/������ ��ȸ</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form method="get" name="frm_list">
					<table class="table01" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="40%" />
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">
									<span>�Ⱓ</span>
								</th>
								<td>
									<input type="text" name="stdate" id="stdate" class="input1" maxlength="10" readonly="readonly" value="" />
									~
									<input type="text" name="ltdate" id="ltdate" class="input1" maxlength="10" readonly="readonly" value="" />
								</td>
								<th scope="row">
									<span>�������</span>
								</th>
								<td>
									<select style="width:80px;" name="sort" id="sort">
										<option value="1">�հ�</option>
										<option value="2">���ں�</option>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<span>����/����</span>
								</th>
								<td>
									<select style="width:80px;" name="pay_type">
										<option value="">��ü</option>
										<option value="1">����</option>
										<option value="2">����</option>
									</select>
								</td>
								<th scope="row">
									<span>ä��</span>
								</th>
								<td>
									<span>
										<select style="width:80px;" name="shop_type">
											<option value="">��ü</option>
											<option value="51">Ȩ������</option>
											<option value="53">�̼�(��ȭ)����</option>
											<option value="59">�������� �ֹ�</option>
											<option value="60">�̼�(Ȩ������)����</option>
											<option value="54">GS��</option>
											<option value="55">�Ե�����</option>
											<option value="56">����</option>
											<option value="57">Ƽ��</option>
											<option value="58">Ȩ����</option>
											<option value="61">NOOM</option>
										</select>
									</span>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<span>�ֹ�/���</span>
								</th>
								<td>
									<select style="width:80px;" name="etype">
										<option value="1">�ֹ�</option>
										<option value="2">���</option>
										<option value="3">�ֹ�(���)</option>
										<option value="4">���(���)</option>
									</select>
								</td>
								<th scope="row">
									<span>��ǰ����</span>
								</th>
								<td>
									<span>
										<select style="width:80px;" name="category">
											<option value="">��ü</option>
											<option value="01">�Ļ�</option>
											<option value="02">���α׷�</option>
											<option value="03">Ÿ�Ժ�</option>
										</select>
									</span>
								</td>
							</tr>
						</tbody>
					</table>
					<p class="btn_center"><a href="javascript:;" onclick="excelDown();" class="function_btn"><span>�����ٿ�ε�</span></a></p>
				</form>
			</div>
			<!-- //contents -->
		</div>
		<!-- //incon -->
	</div>
	<!-- //container -->
</div>
<!-- //wrap -->
<script type="text/javascript">
$(document).ready(function() {
	$('#stdate,#ltdate').datepick({ 
		onSelect: customRange,
		dateFormat: "yyyy-mm-dd",
		showTrigger: '#calImg'
	});
});

function customRange(dates) {
	if (this.id == 'stdate') { 
        $('#ltdate').datepick('option', 'minDate', dates[0] || null); 
    } else { 
        $('#stdate').datepick('option', 'maxDate', dates[0] || null); 
    }
}

function excelDown(){
	if (!$("#stdate").val()) {
		alert("���۱Ⱓ�� �Է��ϼ���.");
		$("#stdate").focus();
		return;
	}
	if (!$("#ltdate").val()) {
		alert("�����Ⱓ�� �Է��ϼ���.");
		$("#ltdate").focus();
		return;
	}
	var f	= document.frm_list;
	//f.target	= "ifrmHidden";
	if ($("#sort").val() == "1") {
		f.action	= "order_excel1.jsp";
	} else {
		f.action	= "order_excel2.jsp";
	}
	f.encoding="application/x-www-form-urlencoded";
	f.submit();	
}
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>