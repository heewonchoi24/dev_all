<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ page import="java.sql.*"%>
<%@ include file="/lib/dbconn_bm.jsp" %>
<%@ include file="/mobile/common/include/inc-top.jsp"%>

<%

String mode			= ut.inject(request.getParameter("ztype"));
if (!ut.isNaN(mode)) {
	mode = "0001";
}
request.setCharacterEncoding("euc-kr");
String query		= "";
String sido			= "";
String sidoOption	= "";

query		= "	SELECT SIDO_NM FROM CM_ZIP_SIDOGUNGU WHERE SIDO_NM != '����Ư����ġ��' GROUP BY SIDO_NM ORDER BY SIDO_NM ";
try {
	pstmt_bm	= conn_bm.prepareStatement(query);
	rs_bm	= stmt_bm.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

while (rs_bm.next()) {
	sido		= rs_bm.getString("SIDO_NM");
	//selected	= (sido.equals(schSido))? " selected=\"selected\"" : "";

	sidoOption	+= "<option value=\""+ sido +"\""+ sido +">"+ sido +"</option>\n";
}

%>
<style>
#loading {
	height: 100%;
	left: 0px;
	position: fixed;
	_position:absolute;
	top: 0px;
	width: 100%;
	filter:alpha(opacity=50);
	-moz-opacity:0.5;
	opacity : 0.5;
}

.loading {
	background-color: white;
	z-index: 199;
}

#loading_img{
	width:150px;
	position:absolute;
	top:50%;
	left:50%;
	height:150px;
	margin-top:-75px;
	margin-left:-75px;
	z-index: 200;
}
</style>
<script type="text/javascript">

jQuery(function($){
	var loading = $('<div id="loading" class="loading"></div><img id="loading_img" alt="loading" src="/mobile/images/agri_loading.gif" />').appendTo(document.body).hide();
	$(window).ajaxStart(function(){
		loading.show();
	}).ajaxStop(function() {
		loading.hide();
	}).ajaxError(function( event, request, settings ) {
		loading.hide();
	});
});
</script>
<link rel="stylesheet" type="text/css" media="all" href="/mobile/common/css/expansion.css">

</head>
<body>
<input type="hidden" name="t" id="t" value="li" />
<input type="hidden" name="dtype" id="dtype" value="<%=mode%>" />
<input type="hidden" name="gT" id="gT" value="" />
<div id="addressSearchPop">
	<div class="inner">
		<header class="pop_header">
			<button class="pop_close close2" onclick="self.close();">�ݱ�</button>
<!-- <%
if(mode.equals("0002")){
%>
			<button class="pop_close close2">�ݱ�</button>
<%
}
%> -->
			<% if (mode.equals("0001") || mode.equals("0002")) { %>
			<h1>������� ����</h1>
			<% } else { %>
			<h1>������� �˻�</h1>
			<% } %>
		</header>
		<div class="pop_content">
			<ul class="tab-navi">
				<li class="active" id="tabs1"><a href="javascript:void(0);" onclick="tab('1')">�����ּ� �˻�</a></li>
				<li id="tabs2"><a href="javascript:void(0);" onclick="tab('2')">���θ��ּ� �˻�</a></li>
			</ul>
			<form name="searchFrm" id="searchFrm">
				<input type="hidden" name="currentPage" id="currentPage" value="" />
				<input type="hidden" name="schPageSize" id="schPageSize" value="10" />
				<div id="div_ji">
					<div class="textArea">
						<p>ã���ô� ��/�� ������ ���� �� ��/���� �ּ� + �ǹ����� �Է��Ͻðų� �� �� �ϳ��� �Է��ϼŵ� �˻� �����մϴ�.</p>
						<p class="em">��) ����Ư����(��/��), ������ 724 (����+����), �����(�ǹ���)</p>
					</div>
					<div class="searchFrmAera">
						<table class="zipsearch">
							<tbody>
								<tr>
									<th>��/�� ����</th>
									<td>
										<select name="schSidoNm" id="schSidoNm" class="inp_st">
											<option value="">:: ���� ::</option>
											<%=sidoOption%>
										</select>
									</td>
								</tr>
								<tr>
									<th>��(��/��) ����</th>
									<td>
										<div class="ipt_group addr">
											<input type="text" class="inputfield ipt addname" name="schDong" id="schDong" maxlength="20" />
											<label>��/��/��</label>
									    	<input type="number" class="inputfield ipt number" name="schGbBonNo" onKeyDown="fnSearch(event);" id="schGbBonNo" maxlength="5" />
								    		<label> - </label>
								    		<input type="number" class="inputfield ipt number" name="schGbBuNo" onKeyDown="fnSearch(event);" id="schGbBuNo"  maxlength="5" />
									    	<label>����</label>
									    </div>
									</td>
								</tr>
								<tr>
									<th>�ǹ���</th>
									<td colspan='2'>
										<div class="ipt_group">
									    	<input name="schGmNmJi" id="schGmNmJi" type="text" class="ftfd ipt" onKeyDown="fnSearch(event);">
									    </div>
									</td>
								</tr>
								<tr>
									<td colspan='2' style='text-align:center'>
										<a href="javascript:void(0);" class="btn btn_dgray huge square" style="max-width: 100px;" onclick="pgSearch(1);">�˻�</a>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div id= "div_do">
					<input type="hidden" name="zip" 			id="zip" />
					<input type="hidden" name="addrJi"			id="addrJi" />
					<input type="hidden" name="delvPtTxt"		id="delvPtTxt" />
					<input type="hidden" name="delvType" 		id="delvType" />
					<input type="hidden" name="gmNm" 			id="gmNm" />
					<input type="hidden" name="bonCheck" 		id="bonCheck" />
					<input type="hidden" name="jisaCd" 			id="jisaCd" />
					<div class="textArea">
						<p>ã���ô� ��/�� ���� �� ���θ� �ּ� + �ǹ����� �Է��Ͻðų� �� �� �ϳ��� �Է��ϼŵ� �˻� �����մϴ�.</p>
						<p class="em">��) ����Ư����(��/��), �������(���θ�), �����(�ǹ���)</p>
					</div>
					<div class="searchFrmAera">
						<table class="zipsearch">
							<tbody>
								<tr>
									<th>��/�� ����</th>
									<td>
										<select name="dschSidoNm" id="dschSidoNm" class="inp_st">
											<option value="">:: ���� ::</option>
											<%=sidoOption%>
										</select>
									</td>
								</tr>
								<tr>
									<th>���θ�</th>
									<td>
										<div class="ipt_group addr2">
											<input name="schDoroNm" id="schDoroNm" type="text" onKeyDown="fnSearch(event);" class="ftfd ipt addname" />
									    	<input type="number" class="inputfield ipt number" onKeyDown="fnSearch(event);" name="schGmBonNo" id="schGmBonNo" maxlength="5" />
									    	<label> - </label>
									    	<input type="number" class="inputfield ipt number" onKeyDown="fnSearch(event);" name="schGmBuNo" id="schGmBuNo" maxlength="5" />
									    </div>
									</td>
								</tr>
								<tr>
									<th>�ǹ���</th>
									<td colspan='2'>
										<div class="ipt_group">
									    	<input name="schGmNm" id="schGmNm" type="text" class="ftfd ipt" onKeyDown="fnSearch(event);">
									    </div>
									</td>
								</tr>
								<tr>
									<td colspan='2' style='text-align:center'>
										<a href="javascript:void(0);" class="btn btn_dgray huge square" style="max-width: 100px;" onclick="pgSearch(1);">�˻�</a>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>

				<div class="textArea">
					<p>* �ش��ϴ� �ּ����� ������ �ּ���.</p>
				</div>

				<div class="addressList">
					<div class="inner">
						<table class="spectable" width="100%" border="0" cellspacing="0" cellpadding="0">
							<colgroup>
								<col width="15%" />
								<col width="auto" />
								<col width="6%" />
								<col width="6%" />
							</colgroup>
							<thead>
								<tr>
									<th>�����ȣ</th>
									<th>�ּ�</th>
									<th class="browntxt last">�Ϲ�</th>
									<th class="browntxt last">�ù�</th>
								</tr>
							</thead>
							<tbody id="resultList">

							<tbody>
						</table>
					</div>
				</div>

				<div class="pagingArea">
					<div id="div_paging"></div>
				</div>
			</form>
		</div>
	</div>
</div>
<!-- custom javascript area -->
<script type="text/javascript">
$(document).ready(function() {
	$("#schDong").focus();
	tab("1");
});

function fnSearch(e){
	if(e.keyCode == 13){
    	pgSearch("1");
    }
}

function tab(val){
	$("#currentPage").val("1");
	$("#resultList").html("");
	$("#schSidoNm").val("");
	$("#schSigunguNm").val("");
	$("#dschSidoNm").val("");
	$("#dschSigunguNm").val("");
	$("#schDong").val("");
	$("#schGbBonNo").val("");
	$("#schGbBuNo").val("");
	$("#schDoroNm").val("");
	$("#schGmNm").val("");
	$("#schGmBuNo").val("");
	$("#schGmBonNo").val("");

	if(val=="1"){
		$('#tabs1').addClass("active");
		$('#tabs2').removeClass("active");
		$("#t").val("li");
		$("#th_ji").show();
		$("#div_ji").show();
		$("#th_do").hide();
		$("#div_do").hide();
		$("#schDong").focus();
	}
	else {
		$('#tabs2').addClass("active");
		$('#tabs1').removeClass("active");
		$("#t").val("do");
		$("#schSidoNm").val("");
		$("#th_do").show();
		$("#div_do").show();
		$("#th_ji").hide();
		$("#div_ji").hide();
		$("#schDoroNm").focus();
	}
}
function pgSearch(val){
	$("#currentPage").val(val);

	if($("#t").val() == "" || $("#t").val() == "c")
		$("#t").val("li");
	if($("#t").val() =="li"){
		fnSearchJi();
	} else {
		fnSearchDo();
	}
}

function fnSearchJi() {
	if($("#currentPage").val() == "")
		$("#currentPage").val('1');

	if($("#schSidoNm").val() == ""){
		alert('��/���� �������ּ���.');
		$("#schSidoNm").focus();
		return false;
	}

	if ($.trim($("#schDong").val())) {
		$("#resultList").html("");
		$("#div_paging").html("");

		$.post("/shop/popup/searchJi_ajax_new.jsp", {
			mode: 'post',
			schSidoNm: $("#schSidoNm").val(),
			schDong: $("#schDong").val(),
			schGbBonNo: $("#schGbBonNo").val(),
			schGbBuNo: $("#schGbBuNo").val(),
			schGmNm: $("#schGmNmJi").val().replace(' ', ''),
			currentPage: $("#currentPage").val(),
			schPageSize: $("#schPageSize").val()
		},
		function(data) {
			$(data).find("result").each(function() {
				if ($(this).text() == "success") {
					$("#resultList").html("");

					var text 		= "";
					var addr1		= "";
					var addr2		= "";
					var trNum		= 0;
					var zipCd 	 	= "";
					var zipCdWithDash = "";
					var idxCnt		= 0;
					var startIdx	= 0;
					var endIdx		= 0;
					var zipcodeArr;

					$(data).find("address").each(function() {
						zipcodeArr = $(this).text().split("|");
						if (zipcodeArr[0] == "nodata") {
							text = '<tr><td colspan="4" class="none">�˻��� ��۰��������� �����ϴ�.</td></tr>';
						} else {
							if (trNum == 0) {
								startIdx 			= zipcodeArr[0];
							}
							addr1			= zipcodeArr[1];
							addr1           += (zipcodeArr[2] != null && zipcodeArr[2] != "null")? " " + zipcodeArr[2] : "";
							addr1           += (zipcodeArr[10] != null && zipcodeArr[10] != "null")? " " + zipcodeArr[10] : "";
							addr1			+= " "+ zipcodeArr[9];
						    addr1			+= (zipcodeArr[4] != 0)? " "+ zipcodeArr[3] +"-"+ zipcodeArr[4] : " "+ zipcodeArr[3];
						    addr1			+= (zipcodeArr[8] != null && zipcodeArr[8] != "null")? " " + zipcodeArr[8] : "";

							text += '<tr id="zipTr'+trNum+'" style="cursor:pointer" onclick="fnSetAddrJi('+trNum+', \''+zipcodeArr[0]+'\', \''+zipcodeArr[12]+'\', \'' + addr1 + '\', \'' + zipcodeArr[13] + '\', \'' + zipcodeArr[14] + '\', \'' + zipcodeArr[15] + '\')">';
							text += '	<td rowspan="3">'+zipcodeArr[0]+'</td>';
							text += '	<td class="address"><font color="#249ac1">(����)&nbsp;' + zipcodeArr[12] + '</font></td>';
							
							if ( zipcodeArr[13] == "O" ) {
								text += '	<td rowspan="2">����</td>';
							} else {
								text += '	<td rowspan="2">�Ұ���</td>';
							}
							if ( zipcodeArr[14] == "O" ) {
								text += '	<td rowspan="2">����</td>';
							} else {
								text += '	<td rowspan="2">�Ұ���</td>';
							}
							text += '</tr>';

							text += '<tr>';
							text += '	<td class="address">(���θ�)&nbsp;'+addr1+'</td>';
							text += '</tr>';

							text += '<tr>';
							text += '	<td colspan="3">' + zipcodeArr[16] + ' ('+ zipcodeArr[17] + ', ' + zipcodeArr[18] + ')</td>';
							text += '</tr>';

						}

						trNum++;
					});

					$("#resultList").html(text);

					var pagingArr;
					$(data).find("paging").each(function() {
						pagingArr = $(this).text().split("|");
						var divText = '<ul class="paging">';
						divText += '<li class="li_btn"><a href="javascript:;" onclick="pgSearch(1);"><img src="/images/popup/ico_first.gif" alt="ó��" /></a>';
						var sIdx = pagingArr[1] - 1;

						if(sIdx == '1')	{
							divText += '<a href="javascript:;" onclick="pgSearch(1);"><img src="/images/popup/ico_prev.gif" alt="����" /></a>';
						} else{
							divText += '<a href="javascript:;" onclick="pgSearch('+ sIdx +');"><img src="/images/popup/ico_prev.gif" alt="����" /></a>';
						}

						for(var i = pagingArr[1] ; i<=pagingArr[2]; i++){
							if($("#currentPage").val() == i)
								divText += '<strong><a href="javascript:;" onclick="pgSearch(' + i +');">' + i + '</a></strong>&nbsp;';
							else
								divText += '<a href="javascript:;" onclick="pgSearch(' + i + ');">' + i +'</a>&nbsp;';
						}
						<!-- Next 10 -->
						var eIdx = parseInt(pagingArr[2]) + 1;
						if(pagingArr[0] == pagingArr[2]){
							divText += '<a href="javascript:;" onclick="pgSearch('+ pagingArr[0] +');"><img src="/images/popup/ico_next.gif" alt="����" /></a>';
						} else{
							divText += '<a href="javascript:;" onclick="pgSearch('+ eIdx + ');"><img src="/images/popup/ico_next.gif" alt="����" /></a>';
						}
						divText += '<a href="javascript:;" onclick="pgSearch(' +  pagingArr[0] +');"><img src="/images/popup/ico_last.gif" alt="������" /></a>';
						divText += '</li>';
						divText += '</ul>';
						$("#div_paging").html(divText);
					});



				} else {
					$(data).find("error").each(function() {
						$(data).find("error").each(function() {

							text += '<tr>';
							text += '	<td colspan="4" class="none">';
							text += '		<p>�˻��� �ּҰ� �����ϴ�.<br/>���θ� �ּҰ� �˻����� �ʴ� ���� <a href="http://www.juso.go.kr" target="_blank"><font color="#249ac1">http://www.juso.go.kr</font></a> ����<br/>';
							text += '	 ��Ȯ�� �ּҸ� Ȯ���Ͻñ� �ٶ��ϴ�.</p>';
							text += '	</td>';
							text += '</tr>';

						});
					});
				}
			});
		}, "xml");

		return false;
	} else {
		alert('���� �ּ��� "��(��/��)"�� �Է��� �ּ���.');
		$("#schDong").focus();
		return false;
	}
}

function fnSearchDo() {

	if($("#currentPage").val() == "")
		$("#currentPage").val('1');

	if (!$.trim($("#dschSidoNm").val())) {
		alert("��/���� �������ּ���.");
		$("#dschSidoNm").focus();
		return false;
	} else if (!$.trim($("#schDoroNm").val()) && !$.trim($("#schGmNm").val())) {
		if(!$.trim($("#schDoroNm").val())){
			alert("���θ��� �Է��ϼ���.");
			$("#schDoroNm").focus();
		} else {
			alert("�ǹ����� �Է��ϼ���.");
			$("#schGmNm").focus();
		}
		 return false;
	} else {
		$("#resultList").html("");
		$("#div_paging").html("");

		$.post("/shop/popup/searchDo_ajax_new.jsp", {
			mode: 'post',
			schSidoNm: $("#dschSidoNm").val(),
			schDoroNm: $("#schDoroNm").val().replace(' ', ''),
			schGmNm: $("#schGmNm").val().replace(' ', ''),
			schGmBonNo: $("#schGmBonNo").val().replace(' ', ''),
			schGmBuNo: $("#schGmBuNo").val().replace(' ', ''),
			currentPage: $("#currentPage").val(),
			schPageSize: $("#schPageSize").val()
		},
		function(data) {
			$(data).find("result").each(function() {
				if ($(this).text() == "success") {
					$("#resultList").html("");

					var text 		= "";
					var addr1		= "";
					var addr2		= "";
					var trNum		= 0;
					var zipCd 	 	= "";
					var zipCdWithDash = "";
					var idxCnt		= 0;
					var startIdx	= 0;
					var endIdx		= 0;
					var zipcodeArr;

					$(data).find("address").each(function() {
						zipcodeArr = $(this).text().split("|");
						if (zipcodeArr[0] == "nodata") {
							text = '<tr><td colspan="4" class="none">�˻��� ��۰��������� �����ϴ�.</td></tr>';
						} else {
							if (trNum == 0) {
								startIdx 			= zipcodeArr[0];
							}
							addr1			= zipcodeArr[1];
							addr1           += (zipcodeArr[2] != null && zipcodeArr[2] != "null")? " " + zipcodeArr[2] : "";
							addr1           += (zipcodeArr[10] != null && zipcodeArr[10] != "null")? " " + zipcodeArr[10] : "";
							addr1			+= " "+ zipcodeArr[9];
						    addr1			+= (zipcodeArr[4] != 0)? " "+ zipcodeArr[3] +"-"+ zipcodeArr[4] : " "+ zipcodeArr[3];
						    addr1			+= (zipcodeArr[8] != null && zipcodeArr[8] != "null")? " " + zipcodeArr[8] : "";

							text += '<tr id="zipTr'+trNum+'" style="cursor:pointer" onclick="fnSetAddrDo('+trNum+', \''+zipcodeArr[0]+'\', \''+addr1+'\', \'' + zipcodeArr[12] + '\', \'' + zipcodeArr[13] + '\', \'' + zipcodeArr[14] + '\', \'' + zipcodeArr[15] + '\')">';
							text += '	<td rowspan="3">'+zipcodeArr[0]+'</td>';
							text += '	<td class="address"><font color="#249ac1">(���θ�)&nbsp;' + addr1 + '</font></td>';
							
							if ( zipcodeArr[13] == "O" ) {
								text += '	<td rowspan="2">����</td>';
							} else {
								text += '	<td rowspan="2">�Ұ���</td>';
							}
							if ( zipcodeArr[14] == "O" ) {
								text += '	<td rowspan="2">����</td>';
							} else {
								text += '	<td rowspan="2">�Ұ���</td>';
							}
							text += '</tr>';
							
							text += '<tr>';
							text += '	<td class="address">(����)&nbsp;'+ zipcodeArr[12] +'</td>';
							text += '</tr>';
							
							text += '<tr>';
							text += '	<td colspan="3">' + zipcodeArr[16] + ' ('+ zipcodeArr[17] + ', ' + zipcodeArr[18] + ')</td>';
							text += '</tr>';
							
						}

						trNum++;
					});

					$("#resultList").html(text);

					var pagingArr;
					$(data).find("paging").each(function() {
						pagingArr = $(this).text().split("|");
						var divText = '<ul class="paging">';
						divText += '<li class="li_btn"><a href="javascript:;" onclick="pgSearch(1);"><img src="/images/popup/ico_first.gif" alt="ó��" /></a>';
						var sIdx = pagingArr[1] - 1;

						if(sIdx == '1')	{
							divText += '<a href="javascript:;" onclick="pgSearch(1);"><img src="/images/popup/ico_prev.gif" alt="����" /></a>';
						} else{
							divText += '<a href="javascript:;" onclick="pgSearch('+ sIdx +');"><img src="/images/popup/ico_prev.gif" alt="����" /></a>';
						}

						for(var i = pagingArr[1] ; i<=pagingArr[2]; i++){
							if($("#currentPage").val() == i)
								divText += '<strong><a href="javascript:;" onclick="pgSearch(' + i +');">' + i + '</a></strong>&nbsp;';
							else
								divText += '<a href="javascript:;" onclick="pgSearch(' + i + ');">' + i +'</a>&nbsp;';
						}
						<!-- Next 10 -->
						var eIdx = parseInt(pagingArr[2]) + 1;
						if(pagingArr[0] == pagingArr[2]){
							divText += '<a href="javascript:;" onclick="pgSearch('+ pagingArr[0] +');"><img src="/images/popup/ico_next.gif" alt="����" /></a>';
						} else{
							divText += '<a href="javascript:;" onclick="pgSearch('+ eIdx + ');"><img src="/images/popup/ico_next.gif" alt="����" /></a>';
						}
						divText += '<a href="javascript:;" onclick="pgSearch(' +  pagingArr[0] +');"><img src="/images/popup/ico_last.gif" alt="������" /></a>';
						divText += '</li>';
						divText += '</ul>';
						$("#div_paging").html(divText);
					});



				} else {
					$(data).find("error").each(function() {
						$(data).find("error").each(function() {

							text += '<tr>';
							text += '	<td colspan="4" class="none">';
							text += '		<p>�˻��� �ּҰ� �����ϴ�.<br/>���θ� �ּҰ� �˻����� �ʴ� ���� <a href="http://www.juso.go.kr" target="_blank"><font color="#249ac1">http://www.juso.go.kr</font></a> ����<br/>';
							text += '	 ��Ȯ�� �ּҸ� Ȯ���Ͻñ� �ٶ��ϴ�.</p>';
							text += '	</td>';
							text += '</tr>';

						});
					});
				}
			});
		}, "xml");

		return false;
	}
}

function fnSetAddrJi(trNum, zip, addr, addr2, delvType1, delvType2, gmno) {
	if (delvType1 == 'X' && delvType2 == 'X') {
		alert("�ش������� ��� ���� �� �����ϴ�.\n�ٸ� �ּҸ� �������ּ���.");
		return false;
	} else if (delvType1 == 'X' && $("#dtype").val() == '0001') {
		alert("���Ϲ�� ��ǰ�� �ù��������� ��� ���� �� �����ϴ�.\n�ٸ� �ּҸ� �������ּ���.");
		return false;
	} else if (delvType2 == 'X' && $("#dtype").val() == '0002') {
		alert("�ù� ��ǰ�� ���Ϲ���������� ��� ���� �� �����ϴ�.\n�ٸ� �ּҸ� �������ּ���.");
		return false;
	} else {
		var gbNo	= '';
		if ($("#dtype").val() == '0001') {
			$("#rcv_zipcode", opener.document).val(zip);
			$("#rcv_addr1", opener.document).val(addr);
			$("#rcv_addr_bcode", opener.document).val(gmno);
		} else {
			$("#tag_zipcode", opener.document).val(zip);
			$("#tag_addr1", opener.document).val(addr);
		}

		if($("#dtype").val() == '0002'){
			$('.pop_close.close2').trigger('click');
		}else{
			$('.pop_close').trigger('click');
		}
	}
}

function fnSetAddrDo(trNum, zip, addr, addr2, delvType1, delvType2, gmno) {
	if (delvType1 == 'X' && delvType2 == 'X') {
		alert("�ش������� ��� ���� �� �����ϴ�.\n�ٸ� �ּҸ� �������ּ���.");
		return false;
	} else if (delvType1 == 'X' && $("#dtype").val() == '0001') {
		alert("���Ϲ�� ��ǰ�� �ù��������� ��� ���� �� �����ϴ�.\n�ٸ� �ּҸ� �������ּ���.");
		return false;
	} else if (delvType2 == 'X' && $("#dtype").val() == '0002') {
		alert("�ù� ��ǰ�� ���Ϲ���������� ��� ���� �� �����ϴ�.\n�ٸ� �ּҸ� �������ּ���.");
		return false;
	} else {
		if ($("#dtype").val() == '0001') {
			$("#rcv_zipcode", opener.document).val(zip);
			$("#rcv_addr1", opener.document).val(addr);
			$("#rcv_addr_bcode", opener.document).val(gmno);
		} else {
			$("#tag_zipcode", opener.document).val(zip);
			$("#tag_addr1", opener.document).val(addr);
		}

		if($("#dtype").val() == '0002'){
			$('.pop_close.close2').trigger('click');
		}else{
			$('.pop_close').trigger('click');
		}


	}
}

/*$('.pop_close.close2').off('click').on('click',function(){
    var $this = $(".content.on");
    var $siblings = $this.siblings(".content");

    $this.removeClass("on");
    $siblings.addClass("on");

    TweenMax.to($siblings,0.5,{'top' : '0vh', ease: Power3.easeInOut});
    TweenMax.to($this,0.5,{'top' : 150+'vh', ease: Power3.easeInOut});
});*/

</script>
<!-- custom javascript area -->
</body>
</html>