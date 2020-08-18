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

query		= "	SELECT SIDO_NM FROM CM_ZIP_SIDOGUNGU GROUP BY SIDO_NM ORDER BY SIDO_NM ";
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
	
</head>
<body>
<input type="hidden" name="t" id="t" value="li" />
<input type="hidden" name="dtype" id="dtype" value="<%=mode%>" />
<input type="hidden" name="gT" id="gT" value="" />
<div class="pop-wrap">
	<div class="headpop">
	<% if (mode.equals("0001") || mode.equals("0002")) { %>
	<h3>������� ����</h3>
	<% } else { %>
	<h3>������� �˻�</h3>
	<% } %>	
		<a href="javascript:;" onclick="self.close();" class="popup_close"><span>�ݱ�</span></a>
	</div>
	<div class="contentpop_address">
		<ul class="greentab two_tab clearfix">				
			<li><a href="javascript:" onclick="tab('1')" class="defaulttab" id="tabs1">�����ּ� �˻�</a></li>
			<li><a href="javascript:" onclick="tab('2')" id="tabs2">���θ��ּ� �˻�</a></li>				
		</ul>			
			<div class="seperater" style="margin-top: 5px; margin-bottom: 5px; background-color: #E1E1E1; height: 1px;"></div>
			<form name="searchFrm" id="searchFrm">
			<input type="hidden" name="currentPage" id="currentPage" value="" />
			<input type="hidden" name="schPageSize" id="schPageSize" value="10" />
			<div id= "div_ji">
				<div class="center" style="padding: 5px 0;">
					<p>ã���ô� ��/�� ������ ���� �� ��/���� �ּ� + �ǹ����� �Է��Ͻðų� �� �� �ϳ��� �Է��ϼŵ� �˻� �����մϴ�.</p>
				</div>
				<div class="graybg" style="padding: 10px 15px;">
					<table class="zipsearch" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th><span class="highlight">*&nbsp;</span>��/�� ����</th>
							<td>
								<select name="schSidoNm" id="schSidoNm" style="width: 100px;">
									<option value="">:: ���� ::</option>
									<%=sidoOption%>
								</select>
							</td>
						</tr>
						<tr>
							<td colspan='2'>
								<input type="text" class="inputfield" name="schDong" id="schDong" style="width: 40px;" maxlength="20" />��(��/��)
								&nbsp;<input type="number" class="inputfield" name="schGbBonNo" onKeyDown="fnSearch(event);" id="schGbBonNo" style="width: 30px;" maxlength="5" />
								&nbsp;-&nbsp;<input type="number" class="inputfield" name="schGbBuNo" onKeyDown="fnSearch(event);" id="schGbBuNo" style="width: 20px;" maxlength="5" />����
							</td>
						</tr>
						<tr>
							<td colspan='2'>
								&nbsp;�ǹ���
								<input name="schGmNmJi" id="schGmNmJi" type="text" onKeyDown="fnSearch(event);" class="ftfd" style="width: 100px;" />
							</td>
						</tr>
						<tr>
							<td colspan='2' style='text-align:center'>
								<a href="javascript:;" class="button green small" onclick="pgSearch(1);">��ȸ</a> 
							</td>
						</tr>
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
						<p>ã���ô� ��/�� ���� �� ���θ� �ּ� + �ǹ����� �Է��Ͻðų� �� �� �ϳ��� �Է��ϼŵ� �˻� �����մϴ�.</p>
					<div class="graybg">
					<table class="zipsearch" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th><span class="highlight">*&nbsp;</span>��/�� ����</th>
							<td>											
								<select name="dschSidoNm" id="dschSidoNm" style="width: 100px;">
									<option value="">:: ���� ::</option>
									<%=sidoOption%>
								</select>
							</td>
						</tr>
						<tr>
							<td colspan='2'>
							���θ�
							<input name="schDoroNm" id="schDoroNm" type="text" onKeyDown="fnSearch(event);" class="ftfd" style="width: 50px;" />
							&nbsp;
							<input type="number" class="inputfield" onKeyDown="fnSearch(event);" name="schGmBonNo" id="schGmBonNo" style="width: 30px;" maxlength="5" />-							
							<input type="number" class="inputfield" onKeyDown="fnSearch(event);" name="schGmBuNo" id="schGmBuNo" style="width: 20px;" maxlength="5" />
							�ǹ���
							<input name="schGmNm" id="schGmNm" type="text" onKeyDown="fnSearch(event);" class="ftfd" style="width: 80px;" />
							</td>							
						</tr>
						<tr>
							<td colspan='2' style='text-align:center; height: 30px;'>
								<a href="javascript:;" class="button green small" onclick="pgSearch(1);">��ȸ</a>
							</td>
						</tr>
						
					</table>	
				</div>					
			</div>
			<div class="row">
				<p class="addtxt">* �ش��ϴ� �ּ����� ������ �ּ���.</p>
				<div style="height: 240px; overflow-x: auto; overflow-y: scroll;">
					<table class="spectable" width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="15%" />
							<col width="auto" />
							<col width="5%" />
							<col width="5%" />
						</colgroup>
						<tr>
							<th>�����ȣ</th>
							<th>�ּ�</th>
							<th class="browntxt last">�Ϲ�</th>
							<th class="browntxt last">�ù�</th>
						</tr>
						<tbody id="resultList">
						<tbody>
					</table>
				</div>
			</div>	
			<div style='text-align:center;'>
				<div id ="div_paging" style="font-size:18px"></div>
			</div>
		</div>
	</div>
	</form>
</div>
<!-- custom javascript area -->
<script type="text/javascript">
$(document).ready(function() {
	$("#schDong").focus();
	tab("1");
	//$("#searchFrm").submit(fnSearchJi);
	//gubun = ("<%=request.getParameter("t") %>");
	//$('.greentab two_tab clearfix a').click(function(){
		//switch_tabs($(this));
	//});
	//switch_tabs($('.defaulttab'));
});

function fnSearch(e){
	if(e.keyCode == 13){
    	pgSearch("1");
    }
}
	
function tab(val){	
	$("#currentPage").val("1");
	
	//if(id =="li_li" || id =="li_cli"){	
	$("#currentPage").val("1");
	$("#resultList").html("");
	//$("#zip1").val("");
	//$("#addr1").val("");
	//$("#addr2").val("");
	//$("#doZip1").val("");
	//$("#doAddr1").val("");
	//$("#doAddr2").val("");
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
		$('#tabs1').addClass("current");	
		$('#tabs2').removeClass("current");
	
		$("#t").val("li");
		$("#th_ji").show();		
		//jiTitle.style.display="block";
		$("#div_ji").show();
		$("#th_do").hide();
		//$("#doTitle").hide();
		$("#div_do").hide();		
		//$("#searchFrm").submit(fnSearchJi);
		$("#schDong").focus();	
	} 
	else {
		$('#tabs2').addClass("current");	
		$('#tabs1').removeClass("current");
	
		//else if(id =="li_do" || id =="li_cdo"){		
			$("#t").val("do");
			$("#schSidoNm").val("");
			$("#th_do").show();
			//$("#doTitle").show();
			$("#div_do").show();
			$("#th_ji").hide();		
			//jiTitle.style.display="none";
			$("#div_ji").hide();
			//$("#searchFrm").submit(fnSearchDo);
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
	//$("#zip1").val("");	
	//$("#addr1").val("");
	//$("#addr2").val("");
	
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
		//var data = "schSidoNm=" + $("#schSidoNm").val();
		//data	+= "&schSigunguNm=" + $("#schSigunguNm").val();
		//data	+= "&schGbBonNo=" + $("#schGbBonNo").val();
		//data	+= "&schGbBuNo=" + $("#schGbBuNo").val();
		//data	+= "&schDong=" + $("#schDong").val();
		//data	+= "&currentPage=" + $("#currentPage").val();
		//data	+= "&schPageSize=" + $("#schPageSize").val();
		

		$.post("/shop/popup/searchJi_ajax.jsp", {
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
					//$(".tbmulti").html('<tr><th>�����ȣ</th><th>�ּ�</th><th>�Ϲ�</th><th>�ù�</th></tr>');
					var zipcodeArr;
					$(data).find("address").each(function() {
						zipcodeArr = $(this).text().split("|");
						if (zipcodeArr[0] == "nodata") {
							text = '<tr><td colspan="3">�˻��� ��۰��������� �����ϴ�.</td></tr>';
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
						
							//addr2			= zipcodeArr[1];
							//addr2			+=  (zipcodeArr[2] != null)? " " + zipcodeArr[2] : "";
							//addr2			+=  (zipcodeArr[10] != null && zipcodeArr[10] != "null")? "&nbsp;" + zipcodeArr[10] : "";
							//addr2			+=  (zipcodeArr[11] != null && zipcodeArr[11] != "null")? "&nbsp;" + zipcodeArr[11] : "";
							//addr2			+=  (zipcodeArr[7] != null && zipcodeArr[7] != "null")? "&nbsp;" + zipcodeArr[7] : "";
							//addr2			+=  "&nbsp;" + zipcodeArr[8];
							
							text += '<tr id="zipTr'+trNum+'" style="cursor:pointer" onclick="fnSetAddrJi('+trNum+', \''+zipcodeArr[0]+'\', \''+zipcodeArr[12]+'\', \'' + addr1 + '\', \'' + zipcodeArr[13] + '\', \'' + zipcodeArr[14] + '\', \'' + zipcodeArr[15] + '\')">';
							text += '	<td rowspan="2">'+zipcodeArr[0]+'</td>';
							text += '	<td><font color="blue">(����)&nbsp;' + zipcodeArr[12] + '</font></td>';
							text += '	<td rowspan="2">'+zipcodeArr[13]+'</td>';
							text += '	<td rowspan="2">'+zipcodeArr[14]+'</td>';
							text += '</tr>';
							text += '<tr>';						
							text += '	<td>(���θ�)&nbsp;'+addr1+'</td>';						
							text += '</tr>';

						//$(".resultList").append('<tr><td>'+ zipcodeArr[0] +'</td><td>'+ zipcodeArr[1] +'</td><td>'+ zipcodeArr[4] +'</td><td>'+ zipcodeArr[5] +'</td></tr>');
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
							text += '	<td colspan="3">';
							text += '		<p>�˻��� �ּҰ� �����ϴ�.<br/>���θ� �ּҰ� �˻����� �ʴ� ���� <a href="http://www.juso.go.kr" target="_blank"><font color="blue">http://www.juso.go.kr</font></a> ����<br/>'; 
							text += '	 ��Ȯ�� �ּҸ� Ȯ���Ͻñ� �ٶ��ϴ�.</p>';
							//text += '		<p>';
							//text += '			�˻��� �ȵǽø� "����"�� Ŭ���ϼ���. -->> //<a class="button small gray">����</a>';
							//text += '		</p>';
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
	//$("#zip1").val("");	
	//$("#addr1").val("");
	//$("#addr2").val("");
	
	if($("#currentPage").val() == "")
		$("#currentPage").val('1');
	
	if (!$.trim($("#dschSidoNm").val())) {
		alert("��/���� �������ּ���.");
		$("#dschSidoNm").focus();
		return false;
	} /*else if (!$.trim($("#schSigunguNm").val()) && $("#dschSidoNm").val != "����Ư����ġ��") {
		alert("��/��/���� �����ϼ���.");
		$("#schSigunguNm").focus();
		return false;
	} */else if (!$.trim($("#schDoroNm").val()) && !$.trim($("#schGmNm").val())) {
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
	
		$.post("/shop/popup/searchDo_ajax.jsp", {
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
					//$(".tbmulti").html('<tr><th>�����ȣ</th><th>�ּ�</th><th>�Ϲ�</th><th>�ù�</th></tr>');
					var zipcodeArr;
					$(data).find("address").each(function() {
						zipcodeArr = $(this).text().split("|");
						if (zipcodeArr[0] == "nodata") {
							text = '<tr><td colspan="3">�˻��� ��۰��������� �����ϴ�.</td></tr>';
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
						
							//addr2			= zipcodeArr[1];
							//addr2			+=  (zipcodeArr[2] != null)? " " + zipcodeArr[2] : "";
							//addr2			+=  (zipcodeArr[10] != null && zipcodeArr[10] != "null")? "&nbsp;" + zipcodeArr[10] : "";
							//addr2			+=  (zipcodeArr[11] != null && zipcodeArr[11] != "null")? "&nbsp;" + zipcodeArr[11] : "";
							//addr2			+=  (zipcodeArr[7] != null && zipcodeArr[7] != "null")? "&nbsp;" + zipcodeArr[7] : "";
							//addr2			+=  "&nbsp;" + zipcodeArr[8];
							
							text += '<tr id="zipTr'+trNum+'" style="cursor:pointer" onclick="fnSetAddrDo('+trNum+', \''+zipcodeArr[0]+'\', \''+addr1+'\', \'' + zipcodeArr[12] + '\', \'' + zipcodeArr[13] + '\', \'' + zipcodeArr[14] + '\', \'' + zipcodeArr[15] + '\')">';
							text += '	<td rowspan="2">'+zipcodeArr[0]+'</td>';
							text += '	<td><font color="blue">(���θ�)&nbsp;' + addr1 + '</font></td>';
							text += '	<td rowspan="2">'+zipcodeArr[13]+'</td>';
							text += '	<td rowspan="2">'+zipcodeArr[14]+'</td>';
							text += '</tr>';
							text += '<tr>';						
							text += '	<td>(����)&nbsp;'+ zipcodeArr[12] +'</td>';						
							text += '</tr>';

						//$(".resultList").append('<tr><td>'+ zipcodeArr[0] +'</td><td>'+ zipcodeArr[1] +'</td><td>'+ zipcodeArr[4] +'</td><td>'+ zipcodeArr[5] +'</td></tr>');
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
							text += '	<td colspan="3">';
							text += '		<p>�˻��� �ּҰ� �����ϴ�.<br/>���θ� �ּҰ� �˻����� �ʴ� ���� <a href="http://www.juso.go.kr" target="_blank"><font color="blue">http://www.juso.go.kr</font></a> ����<br/>'; 
							text += '	 ��Ȯ�� �ּҸ� Ȯ���Ͻñ� �ٶ��ϴ�.</p>';
							//text += '		<p>';
							//text += '			�˻��� �ȵǽø� "����"�� Ŭ���ϼ���. -->> //<a class="button small gray">����</a>';
							//text += '		</p>';
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
		/*if ($.trim(gmNm) != "") {
			var data = "schZip="+ zip +"&schGmNm="+ gmNm;
			$.ajax({
				type :'POST',
				url: "<c:url value='/front/shop/getDoJibun.do'/>",
				data :  data,
				dataType:"json",
				success:function(responseData){			
					if(responseData.result != null && responseData.result.length > 0){
						for(var idx = 0; idx < responseData.result.length; idx++) {
							gbBonNo		= responseData.result[idx].gbBonNo;
							gbBuNo		= responseData.result[idx].gbBuNo;
						}
						
						gbNo	=  (gbBuNo == 0)? gbBuNo : gbBonNo + gbBuNo; 
					}
				},
				error:function(xhr, textStatus, errorThrown) {
					alert("�����ڿ��� ���� �ϼ���.");
				}
			});
		}*/
		if ($("#dtype").val() == '0001') {
			$("#rcv_zipcode", opener.document).val(zip);		
			$("#rcv_addr1", opener.document).val(addr);
			$("#rcv_addr_bcode", opener.document).val(gmno);
			//$("#ahAddr2Ji", opener.document).val(" " + addr2Ji);
		} else {
			$("#tag_zipcode", opener.document).val(zip);
			$("#tag_addr1", opener.document).val(addr);
		}
		
		self.close();	
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
			//$("#ahAddr2Ji", opener.document).val(" " + addr2Ji);
		} else {
			$("#tag_zipcode", opener.document).val(zip);
			$("#tag_addr1", opener.document).val(addr);
		}
		
		self.close();	
	}
}

</script>
<!-- custom javascript area -->
</body>
</html>