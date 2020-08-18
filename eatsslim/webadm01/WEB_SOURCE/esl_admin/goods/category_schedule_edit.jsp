<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%viewPage = true;%>
<%@ include file="../include/inc-top.jsp"%>
<!-- �߰��� �κ� ���� -->
<%@ page import ="java.util.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<!-- �߰��� �κ� �� -->

<%
request.setCharacterEncoding("euc-kr");
int cateId			= 0;
String setCode		= "";

if (request.getParameter("cateId") != null && request.getParameter("cateId").length() > 0)
		cateId		= Integer.parseInt(request.getParameter("cateId"));
%>

<!-- �߰��� �κ� ���� -->
<%
String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
//int i				= 0;
String chkMonth		= "";
String chkDay		= "";
String nowDate		= "";

String cateCode	    = ut.inject(request.getParameter("cateCode"));
String cateName     = ut.inject(request.getParameter("cateName"));

Calendar cal		= Calendar.getInstance();
int nowYear			= cal.get(Calendar.YEAR);
int nowMonth		= cal.get(Calendar.MONTH)+1;
int nowDay			= cal.get(Calendar.DAY_OF_MONTH);

int year			= nowYear;
int month			= nowMonth;

String today		= nowYear +"-"+ nowMonth +"-"+ nowDay;
String strYear		= request.getParameter("year");
String strMonth		= request.getParameter("month");
String cDate		= (new SimpleDateFormat("yyyyMMdd")).format(cal.getTime());// ex) 20180722

System.out.println("cDate: " + cDate);

if (strYear != null) {
	year				= Integer.parseInt(strYear);
}
if (strMonth != null) {
	month				= Integer.parseInt(strMonth);
}

//System.out.println("cateCode: " + cateCode);
//System.out.println("cateName: " + cateName);

int setId			= 0;
String setName		= "";
String prdtName		= "";

int preYear=year, preMonth=month-1;
if (preMonth < 1) {
	preYear				= year-1;
	preMonth			= 12;
}

int nextYear=year,nextMonth=month+1;
if (nextMonth>12) {
	nextYear			= year+1;
	nextMonth			= 1;
}

cal.set(year,month-1,1);
int startDay		= 1;
int endDay			= cal.getActualMaximum(Calendar.DAY_OF_MONTH);
int week			= cal.get(Calendar.DAY_OF_WEEK);

// �Ĵ�ǥ �̸� �������� ������ 
query		= "SELECT CATE_NAME FROM ESL_GOODS_CATEGORY WHERE CATE_CODE = " + cateCode;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
%>
<!-- �߰��� �κ� �� -->
	<script type="text/javascript">
	
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:5,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
	})
	//]]>
	
	function btn_submit2() {
		var cateCode = $("#f_cateCode").val();
		var cateId = $("#f_cateId").val();
		var r_stdate = $("#r_stdate").val();// �ݺ�������
		var r_ltdate = $("#r_ltdate").val();// �ݺ�������
		var mr_stdate = $("#mr_stdate").val();// �޴��ݺ� ������
		var mr_ltdate = $("#mr_ltdate").val();// �޴��ݺ� ������
		
		if($("#r_stdate").val() == "" || $("#r_ltdate").val() == "" || $("#mr_stdate").val() == "" || $("#mr_ltdate").val() == ""){
			alert("���õ��� ���� ��¥�� �ֽ��ϴ�.");
			return false;
		}

		if (confirm("�ݿ� �Ͻðڽ��ϱ�?")) {
			$.post("goods_change_ajax.jsp", {
				mode: "submit2_goodsChange",
				r_stdate: r_stdate,
				r_ltdate: r_ltdate,
				mr_stdate: mr_stdate,
				mr_ltdate: mr_ltdate,
				cateCode: cateCode,
				cateId: cateId
			},
			function(data) {
				$(data).find("result").each(function() {
					if ($(this).text() == "insert") {
						alert("���������� ��ϵǾ����ϴ�.");
						location.href = 'category_schedule_edit.jsp?cateCode=<%=cateCode%>&cateId=<%=cateId %>&year=<%=year %>&month=<%=month%>';
					}
					if($(this).text() == "error") {
						alert("�ݿ��� �����߽��ϴ�.");
						location.href = 'category_schedule_edit.jsp?cateCode=<%=cateCode%>&cateId=<%=cateId %>&year=<%=year %>&month=<%=month%>';
					}
				});
			}, "xml");
		}
		
	}

	function btn_submit1() {
		var deliveryDate = $("#delivery_date").val();
		var setCode = $("#set_code").val();
		var cateCode = $("#f_cateCode").val();
		var cateId = $("#f_cateId").val();
	
		if($("#delivery_date").val() == ""){
			alert("������� �������ּ���.");
			return false;
		}
		
		if (confirm("�ݿ� �Ͻðڽ��ϱ�?")) {
			$.post("goods_change_ajax.jsp", {
				mode: "submit1_goodsChange",
				deliveryDate: deliveryDate,
				setCode: setCode,
				cateCode: cateCode,
				cateId: cateId
			},
			function(data) {
				$(data).find("result").each(function() {
					if ($(this).text() == "insert") {
						alert("���������� ��ϵǾ����ϴ�.");
						location.href = 'category_schedule_edit.jsp?cateCode=<%=cateCode%>&cateId=<%=cateId %>&year=<%=year %>&month=<%=month%>';
					}
					if ($(this).text() == "update") {
						alert("���������� �����Ǿ����ϴ�.");
						location.href = 'category_schedule_edit.jsp?cateCode=<%=cateCode%>&cateId=<%=cateId %>&year=<%=year %>&month=<%=month%>';
											}
					if($(this).text() == "error") {
						alert("�ݿ��� �����߽��ϴ�.");
						location.href = 'category_schedule_edit.jsp?cateCode=<%=cateCode%>&cateId=<%=cateId %>&year=<%=year %>&month=<%=month%>';
					}
				});
			}, "xml");
		}
		
	}
	
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
		<%@ include file="../include/inc-sidebar-product.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="Ȩ" /> &gt; ��ǰ���� &gt; <strong>�Ĵܰ���</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<h3>
				<%
				if(rs.next()){
					cateName = rs.getString("CATE_NAME");
				}
				%>
				<%=cateName %> �Ĵ�ǥ
				</h3>
				<div class="calendar_top">
 					<a href="category_schedule_edit.jsp?cateCode=<%=cateCode%>&cateId=<%=cateId %>&year=<%=preYear %>&month=<%=preMonth%>"><</a>
					<span><%=year%>.<b><%=month%></span>
					<a href="category_schedule_edit.jsp?cateCode=<%=cateCode%>&cateId=<%=cateId %>&year=<%=nextYear %>&month=<%=nextMonth%>">></a>	
				</div>
				<table class="tableView calendar" border="1" cellspacing="0">
					<colgroup>
						<col width="14.555%" />
						<col width="14.555%" />
						<col width="14.555%" />
						<col width="14.555%" />
						<col width="14.555%" />
						<col width="14.555%" />
						<col width="14.555%" />
					</colgroup>
					<thead>
						<tr>
							<th scope="row"><span>��</span></th>
							<th scope="row"><span>��</span></th>
							<th scope="row"><span>ȭ</span></th>
							<th scope="row"><span>��</span></th>
							<th scope="row"><span>��</span></th>
							<th scope="row"><span>��</span></th>
							<th scope="row"><span>��</span></th>
						</tr>
					</thead>
					<!-- �Ĵ�ǥ ����Ʈ ���� -->
					<%
					int newLine = 0;
					for (i = 1; i < week; i++) {
					%>
						<td>
							<div class="cont"></div>
						</td>
					<%
						newLine++;
					}
					chkMonth	= (month < 10)? "0" + Integer.toString(month) : Integer.toString(month);
					query		= "SELECT DATE_FORMAT(HOLIDAY, '%Y-%m-%d') HOLIDAY, HOLIDAY_NAME";
					query		+= " FROM ESL_SYSTEM_HOLIDAY WHERE DATE_FORMAT(HOLIDAY, '%Y') =  '"+ year  + "' AND DATE_FORMAT(HOLIDAY, '%m') =  '"+  chkMonth  + "' AND HOLIDAY_TYPE = '02' ";
					query		+= " ORDER BY HOLIDAY DESC, ID DESC";
					//out.println(query);
					pstmt		= conn.prepareStatement(query);
					rs			= pstmt.executeQuery();

					String arrholidayId[] =  new String[31];
					String arrholidayName[] =  new String[31];
					int nDayCnt = 0;
					while (rs.next()) {
						arrholidayId[nDayCnt]		= rs.getString("HOLIDAY");
						arrholidayName[nDayCnt]		= rs.getString("HOLIDAY_NAME");
						System.out.println("arrholidayId[nDayCnt] ::"+arrholidayId[nDayCnt]);
						System.out.println("arrholidayName[nDayCnt] ::"+arrholidayName[nDayCnt]);
						nDayCnt++;
					}

					int j = 0;
					boolean bHoliday;
					String surHolidayName = "";
					for (i = startDay; i <= endDay; i++) {
						bHoliday = false;
						chkMonth	= (month < 10)? "0" + Integer.toString(month) : Integer.toString(month);
						chkDay		= (i < 10)? "0" + Integer.toString(i) : Integer.toString(i);
						nowDate		= Integer.toString(year) +"-"+ chkMonth +"-"+ chkDay;

						for (j=0;j<nDayCnt;j++) {
							if (nowDate.equals(arrholidayId[j])) {
								bHoliday = true;
								surHolidayName = arrholidayName[j];
								System.out.println("surHolidayName ::"+surHolidayName);
							}
						}
							
						// 2015-05-05, 2015-05-25 �޹��� ���� �߰� ��û �ݿ�
						if (bHoliday || nowDate.equals("2015-01-01") || nowDate.equals("2015-02-18") || nowDate.equals("2015-02-19") || nowDate.equals("2015-02-20") || nowDate.equals("2015-05-05") || nowDate.equals("2015-05-25")) {
							setName		= "";
							prdtName		= "";
						} else {
							query		 = " SELECT S.ID, S.SET_NAME, CS.CATEGORY_ID ";
							query		+= " FROM ESL_GOODS_CATEGORY_SCHEDULE CS, ESL_GOODS_SET S";
							query		+= " WHERE CS.SET_CODE = S.SET_CODE";
							query		+= " AND CATEGORY_CODE = '"+ cateCode +"'";
							query		+= " AND DEVL_DATE = '"+ nowDate +"'";
							query		+= " ORDER BY SET_NAME";
							try {
								rs	= stmt.executeQuery(query);
							} catch(Exception e) {
								out.println(e+"=>"+query);
								if(true)return;
							}

							setName		= "";
							prdtName	= "";
							while (rs.next()) {
								setId		= rs.getInt("ID");
								setName		= "<span>"+ rs.getString("SET_NAME") +"</span><br />";
							}
							rs.close();

							query		= "SELECT SET_ID, PRDT_NAME FROM ESL_GOODS_SET_ORIGIN WHERE SET_ID = "+ setId +" ORDER BY ID";
							try {
								rs	= stmt.executeQuery(query);
							} catch(Exception e) {
								out.println(e+"=>"+query);
								if(true)return;
							}
							prdtName	= "";
							while (rs.next()) {
								prdtName	+= "��"+ rs.getString("PRDT_NAME") +"<br />";
							}
							rs.close();
						}
					%>
						<td class="fc-day fc-mon fc-widget-content fc-past<%if (newLine == 6) out.println(" fc-last");%>" data-date="<%=nowDate%>">
							<%if (setName.equals("") || setName == null) {%>
								<div>
									<div class="num"><%=i%></div>
									<div class="cont">
									<%
										if (bHoliday) { out.print(surHolidayName); }
									%>
									</div>
								</div>
							<%} else {%>
								<div>
									<div class="num">
										<%=i%>
										<%if (cateCode.equals("0301590") && (newLine == 6)) out.println(" <strong><font color=red>�ݿ��� �Բ� ���</font></strong>");%>
									</div>
									<div class="cont"><%=setName+prdtName%></div>
								</div>
							<%}%>
						</td>
					<%
						newLine++;
						if (newLine == 7 && i != endDay) {
							out.print("</tr><tr class='fc-week fc-last'>");
							newLine=0;
						}
					}

					while (newLine > 0 && newLine < 7) {
					%>
						<td class="fc-day fc-sat fc-widget-content fc-past<%if (newLine == 6) out.println(" fc-last");%>">
							<div>
								<div class="fc-day-content"></div>
							</div>
						</td>
					<%
						newLine++;
					}
					out.print("</tr>");
					%>
					<!-- �Ĵ�ǥ ����Ʈ �� -->
				</table>
				<br /><br />
				<form name="frm_write" id="frm_write" method="post">
					<input type="hidden" ID="f_mode" name="f_mode" value="submit1_goodsChange" />
					<input type="hidden" id="f_cateCode" name="f_cateCode" value="<%=cateCode%>" />
					<input type="hidden" id="f_cateId" name="f_cateId" value="<%=cateId%>" />
					<table class="tableView calendar_input" border="1" cellspacing="0">
						<colgroup>
							<col width="" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<td>
								&nbsp;&nbsp;�Ĵܺ���&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="text" name="delivery_date" id="delivery_date" class="input1" maxlength="10" readonly="readonly" value="" placeholder="�����" />
									&nbsp;&nbsp;
									<select class="input1" maxlength="1000" name="set_code" id="set_code" style="width:1000px;">
										<%
										query		= " SELECT T1.SET_CODE AS SET_CODE, T1.SET_NAME AS SET_NAME, T2.PRDT_NAME AS PRDT_NAME FROM ESL_GOODS_SET T1, ESL_GOODS_SET_ORIGIN T2";
										query	   += " WHERE T1.ID = T2.SET_ID";
										query	   += " AND T1.CATEGORY_ID = '" + cateId + "'";
										query      += " AND T1.USE_YN = 'Y'  group by SET_NAME, PRDT_NAME, SET_CODE ";
										pstmt	    = conn.prepareStatement(query);
										rs			= pstmt.executeQuery();
										while (rs.next()) {
											setName	    = rs.getString("SET_NAME");
											setCode		= rs.getString("SET_CODE");
											prdtName	= rs.getString("PRDT_NAME");
										%>
											<option value="<%=setCode%>"><%=setName%>(<%=prdtName%>)</option>
										<%
										}
										%>
									</select>
									<!-- <input type="text" class="input1" style="width:100px;" maxlength="30" name="menucoode" value="" placeholder="�޴��ڵ�">
									<a href="javascript:void(0);" onclick="" class="function_btn"><span>�˻�</span></a>
									<input type="text" class="input1" style="width:200px;" maxlength="30" name="menucname" value="" readonly="readonly" placeholder="�޴���"/> -->
								</td>
								<td class="td_center">
									<a href="javascript:void(0);" onclick="btn_submit1();" class="function_btn" ><span>�����ϱ�</span></a>
								</td>
							</tr>
							<tr>
								<td>
								&nbsp;&nbsp;�ϰ�����&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="text" name="r_stdate" id="r_stdate" class="input1" maxlength="10" readonly="readonly" value="" / placeholder="�ݺ�������">
									~
									<input type="text" name="r_ltdate" id="r_ltdate" class="input1" maxlength="10" readonly="readonly" value="" / placeholder="�ݺ�������">
									&nbsp;&nbsp;&nbsp;>&nbsp;&nbsp;&nbsp;
									<input type="text" name="mr_stdate" id="mr_stdate" class="input1" maxlength="10" readonly="readonly" value="" / placeholder="�޴��ݺ� ������">
									~
									<input type="text" name="mr_ltdate" id="mr_ltdate" class="input1" maxlength="10" readonly="readonly" value="" / placeholder="�޴��ݺ� ������">
								</td>
								<td class="td_center">
									<a href="javascript:void(0);" onclick="btn_submit2();" class="function_btn"><span>�����ϱ�</span></a>
								</td>
							</tr>
						</tbody>
					</table>
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
	$('#delivery_date,#r_stdate,#r_ltdate,#mr_stdate,#mr_ltdate').datepick({
		onSelect: setPeriod,
		dateFormat: "yyyy-mm-dd",
		showTrigger: '#calImg',
		showWeekends:true
	});
});

function setPeriod(dates) {
	var stdate		= $("#stdate").val();
	var ltdate		= $("#ltdate").val();

	if (this.id == 'stdate') {
		$('#ltdate').datepick('option', 'minDate', dates[0] || null);
	} else {
		$('#stdate').datepick('option', 'maxDate', dates[0] || null);
	}
}
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>