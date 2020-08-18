<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%viewPage	= true;%>
<%@ include file="../include/inc-top.jsp"%>
<%@ include file="../include/inc-cal-script.jsp" %>
<%
request.setCharacterEncoding("euc-kr");

String table		= "ESL_MEMBER";
String query		= "";
String mode			= ut.inject(request.getParameter("mode"));
String field		= ut.inject(request.getParameter("field"));
String keyword		= ut.inject(request.getParameter("keyword"));
String pCnt			= ut.inject(request.getParameter("p_cnt"));
String inStdate		= ut.inject(request.getParameter("in_stdate"));
String inLtdate		= ut.inject(request.getParameter("in_ltdate"));
String schMonth		= ut.inject(request.getParameter("sch_month"));
String schDay		= ut.inject(request.getParameter("sch_day"));
String sex			= ut.inject(request.getParameter("sex"));
String schEmailYn	= ut.inject(request.getParameter("sch_email_yn"));
String schSmsYn		= ut.inject(request.getParameter("sch_sms_yn"));
String month		= "";
String day			= "";
String where		= "";
int mid				= 0;
String memberName	= "";
String memberId		= "";
String email		= "";
String emailYn		= "";
String hp			= "";
String smsYn		= "";
String birthDate	= "";
int intTotalCnt		= 0;
String addClass		= "";

if (mode.equals("search")) {
	where			= " WHERE 1=1";

	if (field != null && field.length() > 0 && keyword != null && keyword.length() > 0) {
		keyword		= new String(keyword.getBytes("8859_1"), "EUC-KR");
		where		+= " AND "+ field +" LIKE '%"+ keyword +"%'";
	}

	if (pCnt != null && pCnt.length() > 0) {
		if (pCnt.equals("1")) {
			where		+= " AND PURCHASE_CNT > 0";
		} else {
			where		+= " AND PURCHASE_CNT = 0";
		}
	}

	if (inStdate != null && inStdate.length() > 0) {
		where			+= " AND (DATE_FORMAT(INST_DATE, '%Y-%m-%d') >= '"+ inStdate +"')";
	}

	if (inLtdate != null && inLtdate.length() > 0) {
		where			+= " AND (DATE_FORMAT(INST_DATE, '%Y-%m-%d') <= '"+ inLtdate +"')";
	}

	if (month != null && month.length() > 0) {
		where		+= " AND DATE_FORMAT(BIRTH_DATE, '%m') = '"+ month +"'";
	}

	if (day != null && day.length() > 0) {
		where		+= " AND DATE_FORMAT(BIRTH_DATE, '%d') = '"+ day +"'";
	}

	if (sex != null && sex.length() > 0) {
		where		+= " AND SEX = '"+ sex +"'";
	}

	if (schEmailYn != null && schEmailYn.length() > 0) {
		where		+= " AND EMAIL_YN = '"+ schEmailYn +"'";
	}

	if (schSmsYn != null && schSmsYn.length() > 0) {
		where		+= " AND SMS_YN = '"+ schSmsYn +"'";
	}

	query		= "SELECT COUNT(ID) FROM "+ table + where; //out.print(query1); if(true)return;
	pstmt		= conn.prepareStatement(query);
	rs			= pstmt.executeQuery();
	if (rs.next()) {
		intTotalCnt = rs.getInt(1); //�� ���ڵ� ��		
	}
	if (rs != null) try { rs.close(); } catch (Exception e) {}
	if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}

	query		= "SELECT ID, MEM_NAME, MEM_ID, EMAIL, EMAIL_YN, HP, SMS_YN, BIRTH_DATE";
	query		+= " FROM "+ table + where;
	query		+= " ORDER BY ID DESC"; //out.print(query); if(true)return;
	pstmt		= conn.prepareStatement(query);
	rs			= pstmt.executeQuery();

	addClass	= "";
} else {
	addClass	= "hidden";
}
%>

	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:1,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
	})
	//]]>
	</script>
	<link rel="stylesheet" type="text/css" href="/common/js/_calendars/jquery.datepick.layer.css" />
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
		<%@ include file="../include/inc-sidebar-promotion.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="Ȩ" /> &gt; ���θ�ǰ��� &gt; <strong>��������</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form name="frm_search" id="frm_search" method="get" action="<%=request.getRequestURI()%>">
					<input type="hidden" name="mode" value="search" />
					<h3>
						<input type="radio" name="mem_type" id="mem_type" value="1" checked="checked" /> ȸ���˻�
						<input type="radio" name="mem_type" id="mem_type" value="2" /> ȸ���������ε�
						<input type="radio" name="mem_type" id="mem_type" value="3" /> ȸ����������
					</h3>
					<table class="tableView sch_member" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="40%" />
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row" colspan="4">
									<span>Step1.ȸ���˻�</span>	- �˻������� ���Ͻø� �������ε��� ���� �ɸ� �� �ֽ��ϴ�.
								</th>
							</tr>
							<tr>
								<th scope="row">
									<span>
										<select style="width:80px;" name="field" onchange="this.form.keyword.focus()">
											<option value="MEM_NAME"<%if(field.equals("MEM_NAME")){out.print(" selected=\"selected\"");}%>>�̸�</option>
											<option value="MEM_ID"<%if(field.equals("MEM_ID")){out.print(" selected=\"selected\"");}%>>���̵�</option>
										</select>
									</span>
								</th>
								<td>
									<input type="text" class="input1" style="width:200px;" maxlength="30" name="keyword" value="<%=keyword%>" onfocus="this.select()" />
								</td>
								<th scope="row">
									<span>���ſ���</span>
								</th>
								<td>
									<label>
										<input type="radio" name="p_cnt" value=""<%if(pCnt.equals(""))out.print(" checked");%> />
										��ü
									</label>
									<label>
										<input type="radio" name="p_cnt" value="1"<%if(pCnt.equals("1"))out.print(" checked");%> />
										����
									</label>
									<label>
										<input type="radio" name="p_cnt" value="2"<%if(pCnt.equals("2"))out.print(" checked");%> />
										�̱���
									</label>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<span>ȸ��������</span>
								</th>
								<td colspan="3">
									<input type="text" name="in_stdate" id="in_stdate" class="input1" maxlength="10" readonly="readonly" value="<%=inStdate%>" />
									~
									<input type="text" name="in_ltdate" id="in_ltdate" class="input1" maxlength="10" readonly="readonly" value="<%=inLtdate%>" />
									<a href="javascript:setDate('in_stdate','in_ltdate','<%=cDate%>','<%=cDate%>')" style="margin-left:15px;" class="function_btn"><span>����</span></a>
									<a href="javascript:setDate('in_stdate','in_ltdate','<%=preDate3%>','<%=cDate%>')" class="function_btn"><span>3�ϰ�</span></a>
									<a href="javascript:setDate('in_stdate','in_ltdate','<%=preDate7%>','<%=cDate%>')" class="function_btn"><span>������</span></a>
									<a href="javascript:setDate('in_stdate','in_ltdate','<%=preMonth1%>','<%=cDate%>')" class="function_btn"><span>1����</span></a>
									<a href="javascript:setDate('in_stdate','in_ltdate','<%=preMonth3%>','<%=cDate%>')" class="function_btn"><span>3����</span></a>
									<a href="javascript:setDate('in_stdate','in_ltdate','<%=preYear1%>','<%=cDate%>')" class="function_btn"><span>12����</span></a>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>����</span></th>
								<td>
									<select name="sch_month">
										<option value="">��</option>
										<%
										for (i = 1; i < 13; i++) {
											month	= (i < 10)? "0" + Integer.toString(i) : Integer.toString(i);
										%>
										<option value="<%=month%>"<%if(schMonth.equals(month)){out.print(" selected=\"selected\"");}%>><%=month%></option>
										<%
										}
										%>
									</select>
									<select name="sch_day">
										<option value="">��</option>
										<%
										for (i = 1; i < 31; i++) {
											day		= (i < 10)? "0" + Integer.toString(i) : Integer.toString(i);
										%>
										<option value="<%=day%>"<%if(schDay.equals(day)){out.print(" selected=\"selected\"");}%>><%=day%></option>
										<%
										}
										%>
									</select>
								</td>
								<th scope="row"><span>����</span></th>
								<td>
									<input type="radio" name="sex" value=""<%if(sex.equals(""))out.print(" checked");%> />
									��ü
									<input type="radio" name="sex" value="M"<%if(sex.equals("M"))out.print(" checked");%> />
									��
									<input type="radio" name="sex" value="F"<%if(sex.equals("F"))out.print(" checked");%> />
									��
								</td>
							</tr>
							<tr>
								<th scope="row"><span>�̸��ϼ���</span></th>
								<td>
									<input type="radio" name="sch_email_yn" value=""<%if(schEmailYn.equals(""))out.print(" checked");%> />
									��ü
									<input type="radio" name="sch_email_yn" value="Y"<%if(schEmailYn.equals("Y"))out.print(" checked");%> />
									����
									<input type="radio" name="sch_email_yn" value="N"<%if(schEmailYn.equals("N"))out.print(" checked");%> />
									�ź�
								</td>
								<th scope="row"><span>SMS����</span></th>
								<td>
									<input type="radio" name="sch_sms_yn" value=""<%if(schSmsYn.equals(""))out.print(" checked");%> />
									��ü
									<input type="radio" name="sch_sms_yn" value="Y"<%if(schSmsYn.equals("Y"))out.print(" checked");%> />
									����
									<input type="radio" name="sch_sms_yn" value="N"<%if(schSmsYn.equals("N"))out.print(" checked");%> />
									�ź�
								</td>
							</tr>
						</tbody>
					</table>
					<p class="btn_center sch_member"><input type="image" src="../images/common/btn/btn_search.gif" alt="�˻�" /></p>
				</form>
				<form name="frm_write" id="frm_write" method="post" action="coupon_db.jsp" enctype="multipart/form-data">
					<input type="hidden" name="mode" value="ins" />
					<input type="hidden" name="member_yn" id="member_yn" value="Y" />
					<input type="hidden" name="member_type" id="member_type" value="1" />
					<div id="memberList" style="overflow:auto;height:200px;" class="<%=addClass%>">
						<br />
						<table class="tableView" border="1" cellspacing="0">
							<colgroup>
								<col width="4%" />
								<col width="15%" />
								<col width="15%" />
								<col width="*" />
								<col width="20%" />
								<col width="10%" />
							</colgroup>
							<tbody>
								<tr>
									<th scope="col" style="text-align:center;padding:0;"><span style="padding:0;"><input type="checkbox" id="selectall" /></span></th>
									<th scope="col" style="text-align:center;padding:0;"><span style="padding:0;">ȸ����</span></th>
									<th scope="col" style="text-align:center;padding:0;"><span style="padding:0;">���̵�</span></th>
									<th scope="col" style="text-align:center;padding:0;"><span style="padding:0;">�̸���</span></th>
									<th scope="col" style="text-align:center;padding:0;"><span style="padding:0;">�ڵ���</span></th>
									<th scope="col" style="text-align:center;padding:0;"><span style="padding:0;">����</span></th>
								</tr>
								<%
								if (intTotalCnt > 0) {
									while (rs.next()) {
										mid				= rs.getInt("ID");
										memberName		= rs.getString("MEM_NAME");
										memberId		= rs.getString("MEM_ID");
										email			= rs.getString("EMAIL");
										emailYn			= rs.getString("EMAIL_YN");
										hp				= rs.getString("HP");
										smsYn			= rs.getString("SMS_YN");
										birthDate		= rs.getString("BIRTH_DATE");
								%>
								<tr>
									<td><input type="checkbox" name="sel_member" class="selectable" value="<%=memberId%>" /></td>
									<td><%=memberName%></td>
									<td><%=memberId%></td>
									<td><%=email +"("+ emailYn +")"%></td>
									<td><%=hp +"("+ smsYn +")"%></td>
									<td><%=birthDate%></td>
								</tr>
								<%
									}
								} else {
								%>
								<tr>
									<td colspan="7">�˻��� ȸ���� �����ϴ�.</td>
								</tr>
								<%
								}
								%>
							</tbody>
						</table>
					</div>
					<div id="memberExcel" class="hidden">
						<br />
						<table class="tableView" border="1" cellspacing="0">
							<colgroup>
								<col width="140px" />
								<col width="*" />
							</colgroup>
							<tbody>
								<tr>
									<th scope="row" colspan="2"><span>**���ǻ���**</span></th>
								</tr>
								<tr>
									<th scope="row" colspan="2"><span>* ����(xlsȮ����)���ϸ� ���ε� �����մϴ�.</span></th>
								</tr>
								<tr>
									<th scope="row" colspan="2"><span>* ù��° ��Ʈ�� �����Ͱ� �־�� �մϴ�.(��Ʈ��:Sheet1)</span></th>
								</tr>
								<tr>
									<th scope="row" colspan="2"><span>* �����ۼ� �� �߰��� �� ���� ����� �մϴ�.</span></th>
								</tr>
								<tr>
									<td colspan="2">
										<a href="sample_excel.xls" class="function_btn"><span>���ôٿ�ε�</span></a>
									</td>
								</tr>
								<tr>
									<th scope="row"><span>����</span></th>
									<td>
										<input type="file" name="upfile" id="upfile" value="" />
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<br />
					<table class="tableView" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="40%" />
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row" colspan="4"><span>Step2.���������Է�</span></th>
							</tr>
							<tr>
								<th scope="row"><span>������</span></th>
								<td colspan="3">
									<input type="text" name="coupon_name" id="coupon_name" class="input1" style="width:300px;" maxlength="100" value="" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>����</span></th>
								<td>
									<input type="radio" name="coupon_type" value="01" checked="checked" />
									�¶���
									<input type="radio" name="coupon_type" value="02" />
									��������
								</td>
								<th scope="row"><span>���Ⱓ</span></th>
								<td>
									<input type="text" name="stdate" id="stdate" class="input1" maxlength="10" readonly="readonly" value="" />
									~
									<input type="text" name="ltdate" id="ltdate" class="input1" maxlength="10" readonly="readonly" value="" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>����׷�</span></th>
								<td>
									<input type="radio" name="vendor" value="01" checked="checked" />
									�̺�Ʈ
									<input type="radio" name="vendor" value="02" />
									CRM
									<input type="radio" name="vendor" value="03" />
									����ó
									<input type="radio" name="vendor" value="04" />
									CS
									<input type="radio" name="vendor" value="05" />
									��Ÿ
									<input type="radio" name="vendor" value="06" />
									�ű�ȸ��
								</td>
								<th scope="row"><span>KWP ����</span></th>
								<td>
									<input type="radio" name="kwp_yn" value="N" checked="checked" />
									������
									<input type="radio" name="kwp_yn" value="Y" />
									����
								</td>
							</tr>
							<tr>
								<th scope="row"><span>�������αݾ�</span></th>
								<td colspan="3">
									<input type="radio" name="sale_type" value="P" checked="checked" />
									��ǰ�ǸŰ�����
									<input type="text" name="sale_price1" id="sale_price1" value="0" class="input1" style="width:60px;" maxlength="3" dir="rtl" onblur="this.value=this.value.replace(/[^0-9]/g,'');" />
									% ����
									<input type="radio" name="sale_type" value="W" />
									��ǰ�ǸŰ�����
									<input type="text" name="sale_price2" id="sale_price2" value="0" class="input1" style="width:60px;" maxlength="7" dir="rtl" onkeyup="onlyNum(this);" />
									�� ����
								</td>
							</tr>
							<!--tr>
								<th scope="row"><span>��밡�ɿ���</span></th>
								<td colspan="3">
									<input type="radio" name="sale_use_yn" value="Y" checked="checked" />
									���� �̺�Ʈ �Ⱓ�� ���
									<input type="radio" name="sale_use_yn" value="N" />
									���� �̺�Ʈ �Ⱓ�� ���Ұ�
								</td>
							</tr-->
							<input type="hidden" name="sale_use_yn" value="Y" />
							<tr>
								<th scope="row"><span>�������</span></th>
								<td colspan="3">
									�����ּҼ���
									<input type="text" name="use_limit_cnt" id="use_limit_cnt" class="input1" style="width:60px;" maxlength="2" dir="rtl" value="0" onkeyup="onlyNum(this);" />
									�� /
									��ǰ�ǸŰ�����
									<input type="text" name="use_limit_price" id="use_limit_price" class="input1" style="width:60px;" maxlength="7" dir="rtl" value="0" onkeyup="onlyNum(this);" />
									�� �̻�
								</td>
							</tr>
							<tr>
								<th scope="row"><span>��밡��<br />��ǰ����</span></th>
								<td colspan="3">
									<span class="mr_10">
										<input type="radio" name="use_goods" value="01" checked="checked" />
										��ü��ǰ�� ���� ��밡��
									</span>
									<span class="mr_10">
										<input type="radio" name="use_goods" value="02" />
										Ư�� ��ǰ���� ���� ��밡��
									</span>
									<span class="mr_10">
										<input type="radio" name="use_goods" value="03" />
										�Ϲ� ��ǰ ��ü ��밡��
									</span>
									<span class="mr_10">
										<input type="radio" name="use_goods" value="04" />
										�ù� ��ǰ ��ü ��밡��
									</span>
									<div id="selGoods" class="cag01 hidden">
										<p class="mt_5">
											<div style="overflow:auto;height:200px;">
												<table cellspacing="0" class="table01" style="width:500px;">
													<%
													query		= "SELECT GROUP_CODE, GROUP_NAME";
													query		+= " FROM ESL_GOODS_GROUP";
													query		+= " WHERE USE_YN = 'Y'";
													query		+= " ORDER BY GUBUN1, GUBUN2, GROUP_CODE";
													try {
														rs		= stmt.executeQuery(query);
													} catch(Exception e) {
														out.println(e+"=>"+query);
														if (true) return;
													}

													while (rs.next()) {
													%>
													<tr>
														<td><input type="checkbox" name="group_code" value="<%=rs.getString("GROUP_CODE")+","+rs.getString("GROUP_NAME")%>" /></td>
														<td><%=rs.getString("GROUP_CODE")%></td>
														<td><%=rs.getString("GROUP_NAME")%></td>
													</tr>
													<%
													}
													rs.close();
													%>
												</table>
											</div>
										</p>
									</div>
								</td>
							</tr>
							<tr id="offline" class="hidden">
								<th scope="row"><span>�������ο�<br />�����߱�</span></th>
								<td colspan="3">
									<input type="text" name="max_coupon_cnt" id="max_coupon_cnt" class="input1" style="width:60px;" maxlength="7" dir="rtl" value="0" onkeyup="onlyNum(this);" />
									��
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btn_center">
						<a href="javascript:;" onclick="chkWrite();" class="function_btn"><span>����</span></a>
						<a href="coupon_list.jsp" class="function_btn"><span>���</span></a>
					</div>
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
	$('#in_stdate,#in_ltdate').datepick({ 
		onSelect: setPeriod,
		dateFormat: "yyyy-mm-dd",
		showTrigger: '#calImg'
	});

	$('#stdate,#ltdate').datepick({ 
		onSelect: setPeriod1,
		dateFormat: "yyyy-mm-dd",
		showTrigger: '#calImg'
	});

	$("#selectall").click(selectAll);

	$("input[name=mem_type]").click(function() {
		var memchk		= $(this).val();
		$("#member_type").val(memchk);
		if (memchk == '3') {
			$("#member_yn").val("N");
			$(".sch_member, #memberList, #memberExcel").addClass("hidden");
		} else if (memchk == '2') {
			$("#member_yn").val("Y");
			$(".sch_member, #memberList").addClass("hidden");
			$("#memberExcel").removeClass("hidden");
		} else {
			$("#member_yn").val("Y");
			$(".sch_member").removeClass("hidden");
			$("#memberList, #memberExcel").addClass("hidden");
		}
	});

	$("input[name=coupon_type]").click(function() {
		var couponType	= $("input[name=coupon_type]:checked").val();
		if (couponType == '01') {
			$("#offline").addClass("hidden");
		} else {
			$("#offline").removeClass("hidden");
		}
	});

	$("input[name=use_goods]").click(function() {
		var useGoods	= $("input[name=use_goods]:checked").val();
		if (useGoods == '02') {
			$("#selGoods").removeClass("hidden");
		} else {
			$("#selGoods").addClass("hidden");
		}
	});
});

function selectAll() {
    var checked = $("#selectall").attr("checked");

    $(".selectable").each(function(){
       var subChecked = $(this).attr("checked");
       if (subChecked != checked)
          $(this).click();
    });
}

function setPeriod(dates) {
	var stdate		= $("#in_stdate").val();
	var ltdate		= $("#in_ltdate").val();

	if (this.id == 'in_stdate') {
		$('#in_ltdate').datepick('option', 'minDate', dates[0] || null);
	} else {
		$('#in_stdate').datepick('option', 'maxDate', dates[0] || null);
	}
}

function setPeriod1(dates) {
	var stdate		= $("#stdate").val();
	var ltdate		= $("#ltdate").val();

	if (this.id == 'stdate') {
		$('#ltdate').datepick('option', 'minDate', dates[0] || null);
	} else {
		$('#stdate').datepick('option', 'maxDate', dates[0] || null);
	}
}

function chkWrite() {
	var memchk		= $("input[name=mem_type]:checked").val();
	var chk_member	= $(".selectable:checked");
	var saleType	= $("input[name=sale_type]:checked").val();

	if (memchk == '1' && chk_member.length < 1) {
		alert("������ �߱����� ȸ���� �����ϼ���.");
		return;
	}
	if (memchk == '2' && !$("#upfile").val()) {
		alert("���������� ���ε��ϼ���.");
		return;
	}
	if (!$.trim($("#coupon_name").val())) {
		alert("�������� �Է����ּ���.");
		$("#coupon_name").focus();
		return;
	}
	if (!$.trim($("#stdate").val())) {
		alert("���Ⱓ�� �Է����ּ���.");
		$("#stdate").focus();
		return;
	}
	if (!$.trim($("#ltdate").val())) {
		alert("���Ⱓ�� �Է����ּ���.");
		$("#ltdate").focus();
		return;
	}
	if (saleType == "P" && (!$("#sale_price1").val() || parseInt($("#sale_price1").val()) < 1)) {
		alert("�������αݾ��� �Է��ϼ���.");
		$("#sale_price1").select();
		return;
	}
	if (saleType == "W" && (!$("#sale_price2").val() || parseInt($("#sale_price2").val()) < 1)) {
		alert("�������αݾ��� �Է��ϼ���.");
		$("#sale_price2").select();
		return;
	}
	if ($("input[name=use_goods]:checked").val() == "02" && !$("input[name=group_code]:checked").val() && !$("input[name=group_name]:checked").val()) {
		alert("��ǰ�� ����ϼ���.");
		return;
	}
	if ($("input[name=coupon_type]:checked").val() == "02" && (!$("#max_coupon_cnt").val() || parseInt($("#max_coupon_cnt").val()) < 1)) {
		alert("�������� �����߱� ������ �Է��ϼ���.");
		$("#max_coupon_cnt").select();
		return;
	}

	document.frm_write.submit();
}
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>