<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_phi.jsp"%>
<%
request.setCharacterEncoding("utf-8");

String ztype			= ut.inject(request.getParameter("ztype"));
String query		= "";
String sido			= "";
String gugun		= "";

query		= "SELECT DISTINCT SIDO FROM PHIBABY.V_ZIPCODE ORDER BY SIDO";
try {
	rs_phi	= stmt_phi.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}
%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<title>우편번호 검색</title>
</head>
<body>
	<div class="pop-wrap">
		<div class="headpop">
			<h2>우편번호 검색</h2>
			<p></p>
		</div>
		<div class="contentpop">
			<div class="popup columns offset-by-one"> 
				<div class="row">
					<div class="one last col">
						<form name="frm_zipcode">
							<input type="hidden" name="mode" value="getGugun" />
							<input type="hidden" name="ztype" id="ztype" value="<%=ztype%>" />
							<div class="postSearchBox">
								<p>우편번호를 검색하세요.</p>
								<!--p>동/읍/면/리 이름을 입력하세요. 예) 역삼동,화도읍,장유면</p-->
								<p>지번주소:동/읍/면/리 이름을 입력하세요. 예) 역삼동,화도읍,장유면</p>
                                <p>도로명주소(새주소):도로명을 입력하세요. 예) 중앙로,불정로 432번길</p>
								<input type="radio" name="zip_type" value="1" checked="checked" onclick="cngType(1);" />
								지번주소 검색
								<input type="radio" name="zip_type" value="2" onclick="cngType(2);" />
								도로명주소 검색<br />
								<div id="road" class="hidden">
									<label>시/도</label>
									<select name="sido" id="sido" style="width:160px;" onchange="getGugun();">
										<option value="">선택</option>
										<%
										while (rs_phi.next()) {
											sido		= rs_phi.getString("SIDO");
										%>
										<option value="<%=sido%>"><%=sido%></option>
										<%
										}

										rs_phi.close();
										%>
									</select><br />
									<label>구/군</label>
									<select name="gugun" id="gugun" style="width:160px;">
										<option value="">선택</option>
									</select>
								</div>
								<label>지번/도로명</label>
								<!--label>지번</label-->
								<input type="text" class="inputfield" name="dong" id="dong" />
								<span class="button small light" style="margin:0;"><a href="javascript:;" onclick="schZipCode();">조회</a></span>
							</div>
						</form>
						<!--div class="marb20 mart20" style="text-align:center;">
							<p class="bold7">검색결과에 주소가 검색될 경우, 배송가능한 지역입니다.<br />
							<font class="f12 font-gray">(주소 리스트에 검색되지 않을 경우 배송 불가한 지역입니다.)</font></p>
						</div-->						
                        <div class="divider"></div>
						<div class="frameBox">
							<table class="tbmulti" width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<th>우편번호</th>
									<th>주소</th>
								</tr>
							</table>
						</div> 
						<div class="clear"></div>
					</div>
				</div>
			</div>
			<!-- End popup columns offset-by-one -->	
		</div>
		<!-- End contentpop -->
	</div>
	<iframe id="ifrmHidden" name="ifrmHidden" src="about:blank" style="width:100%;height:200px;display:none;"></iframe>
<script type="text/javascript">
$('html').bind('keypress', function(e){
   if(e.keyCode == 13)   {
      return false;
   }
});

function cngType(obj) {
	if (obj == '1') {
		$("#road").addClass("hidden");
	} else {
		$("#road").removeClass("hidden");
	}
}

function getGugun() {
	if (!$.trim($("#sido").val())) {
		alert("검색하실 시도를 선택하세요.");
		$("#sido").select();
		return false;
	} else {
		var f	= document.frm_zipcode;
		f.action	= "/shop/sch_gugun.jsp";
		f.target	= "ifrmHidden";
		f.submit();
	}	
}

function schZipCode() {
	var zipType		= $("input[name=zip_type]:checked").val();
	if (zipType == "2" && !$("#sido").val()) {
		alert("시/도를 선택하세요.");
		return false;
	} else if (zipType == "2" && !$("#gugun").val()) {
		alert("구/군을 선택하세요.");
		return false;
	} else if (!$.trim($("#dong").val())) {
		alert("지번/도로명을 입력하세요.");
		return false;
	} else {
		$.post("zipcode_ajax_test.jsp", {
			mode: 'post',
			zip_type: zipType,
			sido: $("#sido").val(),
			gugun: $("#gugun").val(),
			dong: $("#dong").val(),
			ztype: $("#ztype").val()
		},
		function(data) {
			$(data).find("result").each(function() {
				if ($(this).text() == "success") {
					$(".tbmulti").html('<tr><th>우편번호</th><th>주소</th></tr>');
					var zipcodeArr;
					$(data).find("address").each(function() {
						zipcodeArr = $(this).text().split("|");
						if (zipcodeArr[0] == "nodata") {
							$(".tbmulti").append('<tr><td colspan="2">검색된 우편번호가 없습니다.</td></tr>');
						} else {
							$(".tbmulti").append('<tr><td>'+ zipcodeArr[0] +'</td><td><a href="javascript:;" onclick="setZipcode(\''+ zipcodeArr[2] +'\',\''+ zipcodeArr[3] +'\',\''+ zipcodeArr[1] +'\');">'+ zipcodeArr[1] +'</a></td></tr>');
						}
					});
				} else {
					$(data).find("error").each(function() {
						$(data).find("error").each(function() {
							alert($(this).text());
							$("#dong").focus();
						});
					});
				}
			});
		}, "xml");
		return false;
	}
}

function setZipcode(zip1, zip2, addr) {
	if ($("#ztype").val() == "1") {
		$("#rcv_zipcode1").val(zip1);
		$("#rcv_zipcode2").val(zip2);
		$("#rcv_addr1").val(addr);
	} else {
		$("#tag_zipcode1").val(zip1);
		$("#tag_zipcode2").val(zip2);
		$("#tag_addr1").val(addr);
	}
	$.lightbox().close();
}
</script>
</body>
</html>