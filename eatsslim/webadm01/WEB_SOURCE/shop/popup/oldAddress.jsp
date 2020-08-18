<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%@ page import="java.sql.*"%>
<%@ include file="/lib/dbconn_phi.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String query		= "";
String mode			= ut.inject(request.getParameter("mode"));
String ztype		= ut.inject(request.getParameter("ztype"));
String schDong		= ut.inject(request.getParameter("dong"));
if (schDong != null && schDong.length() > 0) {
	schDong		= new String(schDong.getBytes("8859_1"), "EUC-KR");
}
String schZipcode	= ut.inject(request.getParameter("zipcode"));
if (schZipcode != null && schZipcode.length() > 0) {
	schZipcode	= schZipcode.replace("-","");
}
String schAddr		= ut.inject(request.getParameter("address"));
if (schAddr != null && schAddr.length() > 0) {
	schAddr		= new String(schAddr.getBytes("8859_1"), "EUC-KR");
}
String schAddrTxt	= ut.inject(request.getParameter("address_txt"));
if (schAddrTxt != null && schAddrTxt.length() > 0) {
	schAddrTxt	= new String(schAddrTxt.getBytes("8859_1"), "EUC-KR");
}
if (schAddrTxt.indexOf("~") > 0) {
	schAddr		= schAddr;
} else {
	schAddr		= schAddrTxt;
}
String bunji1		= ut.inject(request.getParameter("bunji1"));
String bunji2		= ut.inject(request.getParameter("bunji2"));
String table1		= "V_ZIPCODE_OLD";
String table2		= "V_ZIPCODE_NEW";
String zipcode		= "";
String zipcode1		= "";
String zipcode2		= "";
String address		= "";
String sido			= "";
String gugun		= "";
String dong			= "";
String bunji		= "";
String addressTxt	= "";
String devltype		= "";
String devlPtnCd	= "";
String where		= "";
int tCnt			= 0;
int i				= 1;

if (ztype.equals("1")) {
	where		+= " AND DLVPTNCD = '01' AND DLVYN = 'Y'";
	where		+= " AND DLVTYPE = '000"+ ztype +"'";
}

if (mode.equals("sch")) {
	if (schDong == null || schDong.equals("")) {
		ut.jsAlert(out, "읍/면/동을 입력하세요.");
		ut.jsBack(out);
		if (true) return;
	} else {
		query		= "SELECT COUNT(*) FROM PHIBABY."+table1;
		query		+= " WHERE DONG LIKE '%"+ schDong +"%'" + where;
		try {
			rs_phi	= stmt_phi.executeQuery(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if (true) return;
		}

		if (rs_phi.next()) {
			tCnt		= rs_phi.getInt(1);
		}
		rs_phi.close();

		query		= "SELECT ZIPCODE, SIDO, GUGUN, DONG, BUNJI, DLVTYPE, DLVPTNCD FROM PHIBABY."+ table1;
		query		+= " WHERE DONG LIKE '%"+ schDong +"%'" + where;
		query		+= " ORDER BY DONG, BUNJI";
		try {
			rs_phi	= stmt_phi.executeQuery(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if (true) return;
		}
	}
} else if (mode.equals("cng")) {
	query		= "SELECT COUNT(*) FROM PHIBABY."+table2;
	query		+= " WHERE ZIPCODE = '"+ schZipcode +"'" + where;
	if (!bunji1.equals("") && bunji1.length() > 0 && !bunji2.equals("") && bunji2.length() > 0) {
		query		+= " AND BUNJI LIKE '%"+ bunji1 +"-"+ bunji2 +"%'";
	} else if (!bunji1.equals("") && bunji1.length() > 0) {
		query		+= " AND BUNJI LIKE '%"+ bunji1 +"%'";
	}
	try {
		rs_phi	= stmt_phi.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if (true) return;
	}

	if (rs_phi.next()) {
		tCnt		= rs_phi.getInt(1);
	}
	rs_phi.close();

	query		= "SELECT ZIPCODE, SIDO, GUGUN, DONG, BUNJI, DLVTYPE, DLVPTNCD FROM PHIBABY."+ table2;
	query		+= " WHERE ZIPCODE = '"+ schZipcode +"'" + where;
	if (!bunji1.equals("") && bunji1.length() > 0 && !bunji2.equals("") && bunji2.length() > 0) {
		query		+= " AND BUNJI LIKE '%"+ bunji1 +"-"+ bunji2 +"%'";
	} else if (!bunji1.equals("") && bunji1.length() > 0) {
		query		+= " AND BUNJI LIKE '%"+ bunji1 +"%'";
	}
	query		+= " ORDER BY DONG, BUNJI, ZIPCODE";
	try {
		rs_phi	= stmt_phi.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if (true) return;
	}
}
%>

	<style>
	.keylock {
		height: 100%;
		filter: alpha(opacity=50);
		opacity: 0.5;
		-moz-opacity: 0.5;
	}
	.keylock input:disabled { 
		
	}
	.typehead {
		background: #58B7DD;
		border: 1px solid #4490AF;
		color: #FFFFFF;
		padding: 10px 30px;
		text-align: center;
	}
	</style>
</head>
<body>
<div class="pop-wrap">
	<div class="headpop">
		<h2>배달지 주소입력</h2>
		<p></p>
	</div>
	<div class="contentpop">
		<div class="popup columns offset-by-one">
			<div class="row">
				<div class="one last col">
					<ul class="tabNavi">
						<li class="active" style="max-width:50%;"><a href="oldAddress.jsp?ztype=<%=ztype%>">현 사용주소(지번명)로 검색</a></li>
						<li style="max-width:50%;"><a href="newAddress.jsp?ztype=<%=ztype%>">변경체계 주소(도로명)로 검색</a></li>
					</ul>
					<div class="divider"></div>
					<h4 class="marb20"> 고객님! <span class="font-blue">도로명 주소를 이용해 주세요</span></h4>
					<p>2014년 부터는 도로명 주소가 의무적으로 사용됩니다. 도로명 주소지를 검색해 주세요.</p>
				</div>
			</div>
			<!-- End row -->
			<div class="row">
				<div class="one last col">
					<div<%if (mode.equals("cng")) out.println(" class=\"keylock\"");%> style="width:49%;float:left;">
						<h3 class="typehead">현 사용주소(지번명) 검색 및 입력</h3>
						<form name="frm_zipcode" id="frm_zipcode" method="get" action="oldAddress.jsp">
							<input type="hidden" name="mode" value="sch" />
							<input type="hidden" name="ztype" value="<%=ztype%>" />
							<div class="postSearchBox" style="height:60px;">
								<p>현재 주소의 "읍/면/동"을 입력 해 주세요. </p>
								<label>읍/면/동</label>
								<input type="text" class="inputfield" name="dong" id="dong" value="<%=schDong%>"<%if (mode.equals("cng")) out.println(" disabled=\"disabled\"");%> />
								<span class="button small light" style="margin:0;"><a href="javascript:;" onclick="chkZipcode();">조회</a></span>
							</div>
						</form>
						<h5 class="mart20 marb5 font-green">해당하는 주소지를 선택해 주세요.</h5>
						<table class="tbmulti" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<th>우편번호</th>
								<th>현재주소</th>
							</tr>
						</table>
						<div class="frameBox marb10" style="height:200px; overflow-y:auto;">
							<table class="tbmulti" width="100%" border="0" cellspacing="0" cellpadding="0">
								<%
								if (mode.equals("cng")) {
								%>
								<tr>
									<td><%=schZipcode.substring(0,3)+"-"+schZipcode.substring(3,6)%></td>
									<td><%=schAddrTxt%></td>
								</tr>
								<%
								} else {
									if (tCnt > 0) {
										while (rs_phi.next()) {
											zipcode		= rs_phi.getString("ZIPCODE");
											zipcode1	= zipcode.substring(0,3);
											zipcode2	= zipcode.substring(3,6);
											sido		= rs_phi.getString("SIDO");
											gugun		= rs_phi.getString("GUGUN");
											dong		= rs_phi.getString("DONG");
											bunji		= (rs_phi.getString("BUNJI") != null)? rs_phi.getString("BUNJI") : "";
											address		= sido +" "+ gugun +" "+ dong;
											addressTxt	= sido +" "+ gugun +" "+ dong +" "+ bunji;
											devltype	= rs_phi.getString("DLVTYPE");
											devlPtnCd	= rs_phi.getString("DLVPTNCD");
											if (devltype.equals("0001") && devlPtnCd.equals("01")) {
								%>
								<tr id="zip_tr<%=i%>">
									<td><a href="javascript:;" onclick="chkPost('<%=zipcode1%>', '<%=zipcode2%>', '<%=address%>', '<%=addressTxt%>', <%=i%>);"><%=zipcode1+"-"+zipcode2%></a></td>
									<td><a href="javascript:;" onclick="chkPost('<%=zipcode1%>', '<%=zipcode2%>', '<%=address%>', '<%=addressTxt%>', <%=i%>);"><%=addressTxt%></a></td>
								</tr>
								<%
											}
											i++;
										}
									} else {
								%>
								<tr>
									<td colspan="2">검색된 주소지가 없습니다.</td>
								</tr>
								<%
									}
								}
								%>
							</table>
						</div>
						<form name="frm_address" id="frm_address" method="get" action="oldAddress.jsp">
							<input type="hidden" name="mode" value="cng" />
							<input type="hidden" name="ztype" value="<%=ztype%>" />
							<input type="hidden" name="dong" value="<%=schDong%>" />
							<input type="hidden" name="address" id="address" value="<%=schAddr%>" />
							<div class="marb20">
								<table class="inputfield" width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<th>현재주소</th>
										<td>
											<input name="zipcode" id="zipcode" type="text" class="ftfd" style="width:60px;" readonly="readonly" value="<%=schZipcode%>"<%if (mode.equals("cng")) out.println(" disabled=\"disabled\"");%> />
											<input name="address_txt" id="address_txt" type="text" class="ftfd" style="width:220px" readonly="readonly" value="<%=schAddrTxt%>"<%if (mode.equals("cng")) out.println(" disabled=\"disabled\"");%> />
										</td>
									</tr>
									<tr>
										<th>번지</th>
										<td>
											<input name="bunji1" id="bunji1" type="text" class="ftfd" style="width:60px;" value="<%=bunji1%>"<%if (mode.equals("cng")) out.println(" disabled=\"disabled\"");%> />
											-
											<input name="bunji2" id="bunji2" type="text" class="ftfd" style="width:60px;" value="<%=bunji2%>"<%if (mode.equals("cng")) out.println(" disabled=\"disabled\"");%> />
										</td>
									</tr>
								</table>
							</div>
							<div class="clear"></div>
							<div class="row">
								<div class="one last col center">
									<div class="button large gray"><a href="oldAddress.jsp?ztype=<%=ztype%>">초기화</a></div>
									<div class="button large dark"><a href="javascript:;" onclick="cngPost();">도로명 주소로 바꾸기 &gt;</a></div>
								</div>
							</div>
							<div class="clear"></div>
						</form>
					</div>
					<div<%if (!mode.equals("cng")) out.println(" class=\"keylock\"");%> style="width:49%;float:right;">
						<h3 class="typehead">변경체계 주소(도로명)로 바꾸기</h3>
						<div class="postSearchBox" style="height:60px;">
							<p>자동 변환된 도로명 주소입니다.</p>
							<p>정확한 배달을 위해 변환된 주소 정보를 확인해 주세요.</p>
						</div>						
						<h5 class="mart20 font-green">현재주소</h5>
						<p>
						<%if (mode.equals("cng")) {%>
							(<%=schZipcode.substring(0,3)+"-"+schZipcode.substring(3,6)%>)
						<%
							if (!bunji1.equals("") && bunji1.length() > 0 && !bunji2.equals("") && bunji2.length() > 0) {
								schAddr		+= " "+ bunji1 +"-"+ bunji2;
							} else if (!bunji1.equals("") && bunji1.length() > 0) {
								schAddr		+= " "+ bunji1;
							} else {
								schAddr		= schAddr;
							}

							out.println(schAddr);
						%>
						<%} else {%>
							&nbsp;
						<%}%>
						</p>
						<h5 class="mart20 marb5 font-green">도로명 주소</h5>
						<table class="tbmulti" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<th>우편번호</th>
								<th>도로명주소</th>
							</tr>
						</table>
						<div class="frameBox marb10" style="height:140px; overflow-y:auto;">
							<table class="tbmulti" width="100%" border="0" cellspacing="0" cellpadding="0">
								<%
								if (mode.equals("cng")) {
									if (tCnt > 0) {
										while (rs_phi.next()) {
											zipcode		= rs_phi.getString("ZIPCODE");
											zipcode1	= zipcode.substring(0,3);
											zipcode2	= zipcode.substring(3,6);
											sido		= rs_phi.getString("SIDO");
											gugun		= rs_phi.getString("GUGUN");
											dong		= rs_phi.getString("DONG");
											bunji		= (rs_phi.getString("BUNJI") != null)? rs_phi.getString("BUNJI") : "";
											address		= sido +" "+ gugun +" "+ dong;
											addressTxt	= sido +" "+ gugun +" "+ dong +" "+ bunji;
											devltype	= rs_phi.getString("DLVTYPE");
											devlPtnCd	= rs_phi.getString("DLVPTNCD");
											if (devltype.equals("0001") && devlPtnCd.equals("01")) {
								%>
								<tr id="zip_tr<%=i%>">
									<td><a href="javascript:;" onclick="insPost('<%=addressTxt%>', <%=i%>);"><%=zipcode1+"-"+zipcode2%></a></td>
									<td><a href="javascript:;" onclick="insPost('<%=addressTxt%>', <%=i%>);"><%=addressTxt%></a></td>
								</tr>
								<%
											} else {
								%>
								<tr>
									<td colspan="2">주소 변환에 실패하였습니다. 주소수정 또는 현재주소를 이용해주세요.</td>
								</tr>
								<%
											}
											i++;
										}
									} else {
								%>
								<tr>
									<td colspan="2">주소 변환에 실패하였습니다. 주소수정 또는 현재주소를 이용해주세요.</td>
								</tr>
								<%
									}
								}
								%>
							</table>
						</div>
						<input type="hidden" name="tcnt" id="tcnt" value="<%=tCnt%>" />
						<input type="hidden" id="ztype" value="<%=ztype%>" />
						<input type="hidden" name="new_zipcode" id="new_zipcode" value="<%=schZipcode%>" />
						<input type="hidden" name="new_zipcode1" id="new_zipcode1" value="<%=zipcode1%>" />
						<input type="hidden" name="new_zipcode2" id="new_zipcode2" value="<%=zipcode2%>" />
						<input type="hidden" name="old_address" id="old_address" value="<%=schAddr%>" />
						<input type="hidden" name="new_address" id="new_address" />
						<div class="marb20">
							<table class="inputfield" width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<th>기본 주소</th>
									<td><input name="zip_txt" id="zip_txt" type="text" class="ftfd" style="width:290px; margin-top:5px;" readonly="readonly"<%if (!mode.equals("cng")) out.println(" disabled=\"disabled\"");%> /></td>
								</tr>
								<tr>
									<th>상세 주소</th>
									<td><input name="address2" id="address2" type="text" class="ftfd" style="width:290px; margin-top:5px;"<%if (!mode.equals("cng")) out.println(" disabled=\"disabled\"");%> /></td>
								</tr>
							</table>
						</div>
						<div class="clear"></div>
						<div class="row">
							<div class="one last col center">
								<div class="button large gray"><a href="javascript:;" onclick="history.back();">&lt; 주소수정</a></div>
								<div class="button large dark">
									<%if (tCnt > 0) {%>
									<a href="javascript:;" onclick="confrimPost();">확인</a>
									<%} else {%>
									<a href="javascript:;" onclick="confrimPost();">현재주소사용</a>
									<%}%>
								</div>
							</div>
						</div>
						<div class="clear"></div>
					</div>
					<div class="clear"></div>
				</div>
			</div>
			<!-- End row --> 
		</div>
		<!-- End popup columns offset-by-one -->
	</div>
	<!-- End contentpop --> 
	<div id="floatMenu" style="display:none;">
		<%@ include file="/common/include/inc-floating.jsp"%>
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	$("#frm_zipcode").submit(chkZipcode);
});

function chkZipcode() {
	if (!$.trim($("#dong").val())) {
		alert("읍/면/동을 입력하세요.");
		$("#dong").focus();
		return false;
	} else {
		document.frm_zipcode.submit();
		return false;
	}
}

function chkPost(zip1, zip2, addr1, addr2, i) {
	$("#zipcode").val(zip1+"-"+zip2);
	$("#address").val(addr1);
	$("#address_txt").val(addr2);
	$(".tbmulti tr").css("background-color", "");
	$(".tbmulti tr").css("font-weight", "normal");
	$("#zip_tr"+ i).css("background-color", "yellow");
	$("#zip_tr"+ i).css("font-weight", "bold");
}

function cngPost() {
	if (!$.trim($("#zipcode").val()) || !$.trim($("#address").val())) {
		alert("검색된 주소를 선택해주세요.");
		$("#zipcode").focus();
		return false;
	} else {
		document.frm_address.submit();
		return false;
	}
}

function insPost(addr, i) {
	$("#new_address").val(addr);
	$("#zip_txt").val(addr);
	$(".tbmulti tr").css("background-color", "");
	$(".tbmulti tr").css("font-weight", "normal");
	$("#zip_tr"+ i).css("background-color", "yellow");
	$("#zip_tr"+ i).css("font-weight", "bold");
}

function confrimPost() {
	var tcnt	= $("#tcnt").val();
	var ztype	= $("#ztype").val();

	if (tcnt > 0) {
		if (!$.trim($("#new_address").val())) {
			alert("도로명 주소를 선택하세요.");
			return false;
		} else {
			if (ztype == "1") {
				$("#rcv_addr1", opener.document).val($("#old_address").val());
				$("#rcv_addr2", opener.document).val($("#address2").val());
				$("#rcv_zipcode", opener.document).val($("#new_zipcode").val());
				$("#rcv_zipcode1", opener.document).val($("#new_zipcode1").val());
				$("#rcv_zipcode2", opener.document).val($("#new_zipcode2").val());
			} else {
				$("#tag_addr1", opener.document).val($("#old_address").val());
				$("#tag_addr2", opener.document).val($("#address2").val());
				$("#tag_zipcode", opener.document).val($("#new_zipcode").val());
				$("#tag_zipcode1", opener.document).val($("#new_zipcode1").val());
				$("#tag_zipcode2", opener.document).val($("#new_zipcode2").val());
			}
			self.close();
		}
	} else {
		if (confirm("도로명주소로 변환이 어렵습니다.\n\n현재주소만 사용하시겠습니까?")) {
			if (ztype == "1") {
				$("#rcv_addr1", opener.document).val($("#old_address").val());
				$("#rcv_addr2", opener.document).val($("#address2").val());
				$("#rcv_zipcode", opener.document).val($("#new_zipcode").val());
				$("#rcv_zipcode1", opener.document).val($("#new_zipcode1").val());
				$("#rcv_zipcode2", opener.document).val($("#new_zipcode2").val());
			} else {
				$("#tag_addr1", opener.document).val($("#old_address").val());
				$("#tag_addr2", opener.document).val($("#address2").val());
				$("#tag_zipcode", opener.document).val($("#new_zipcode").val());
				$("#tag_zipcode1", opener.document).val($("#new_zipcode1").val());
				$("#tag_zipcode2", opener.document).val($("#new_zipcode2").val());
			}
			self.close();
		}
	}
}
</script>
</body>
</html>
<%@ include file="/lib/dbclose.jsp"%>
<%@ include file="/lib/dbclose_phi.jsp"%>