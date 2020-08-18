<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="/lib/dbconn_phi.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String tabmenu		= request.getParameter("tabmenu");
if(tabmenu==null){tabmenu="1";}
String orderNum		= ut.inject(request.getParameter("ordno"));
int subNum			= 0;
if (request.getParameter("subno") != null && request.getParameter("subno").length()>0)
	subNum		= Integer.parseInt(request.getParameter("subno"));
System.out.println("subNum"+subNum);
String gubunCode	= ut.inject(request.getParameter("gcode"));
int seq				= 0;
if (request.getParameter("seq") != null && request.getParameter("seq").length()>0)
	seq			= Integer.parseInt(request.getParameter("seq"));

if (orderNum == null || orderNum.equals("")) {
	out.println("<script>self.close();</script>");
	if (true) return;
}

String query			= "";
String query1			= "";
Statement stmt1			= null;
ResultSet rs1			= null;
stmt1					= conn.createStatement();
int tcnt				= 0;
String memberId			= "";
String memberName		= "";
String payType			= "";
String rcvName			= "";
String rcvTel			= "";
String rcvHp			= "";
String rcvZipcode		= "";
String rcvAddr1			= "";
String rcvAddr2			= "";
String rcvRequest		= "";
String tagName			= "";
String tagTel			= "";
String tagHp			= "";
String tagZipcode		= "";
String tagAddr1			= "";
String tagAddr2			= "";
String tagRequest		= "";
String pgTid			= "";
String pgCardNum		= "";
String pgFinanceName	= "";
String pgAccountNum		= "";
String orderState		= "";
String orderDate		= "";
String orderDayState	= "";
String payDate			= "";
String minDate			= "";
String maxDate			= "";
String agId				= "";
String agName			= "";
int couponTprice		= 0;
String devlDates		= "";
int devlId				= 0;
String groupCode		= "";
SimpleDateFormat dt		= new SimpleDateFormat("yyyy-MM-dd");
String today			= dt.format(new Date());
String devlState		= "";
int payPrice			= 0;
int orderCnt			= 0;
String gubun1			= "";
String state			= "";
int compare				= 0;
String shopType			= "";
String outOrderNum		= "";
String groupName		= "";
String weekDay			= "";
String prdtSetName		= "";
String couponNum		= "";
String vendor			= "";

query		= "SELECT ";
query		+= "	MEMBER_ID, PAY_TYPE, RCV_NAME, RCV_TEL, RCV_HP, RCV_ZIPCODE, RCV_ADDR1, RCV_ADDR2, RCV_REQUEST,";
query		+= "	TAG_NAME, TAG_TEL, TAG_HP, TAG_ZIPCODE, TAG_ADDR1, TAG_ADDR2, TAG_REQUEST, PG_TID, PG_CARDNUM,";
query		+= "	PG_FINANCENAME, PG_ACCOUNTNUM, O.ORDER_STATE, ORDER_DATE, PAY_DATE, O.COUPON_PRICE, GUBUN1,";
query		+= "	ORDER_NAME, SHOP_TYPE, OUT_ORDER_NUM, OG.COUPON_NUM";
query		+= " FROM ESL_ORDER O, ESL_ORDER_GOODS OG, ESL_GOODS_GROUP G";
query		+= " WHERE O.ORDER_NUM = OG.ORDER_NUM AND OG.GROUP_ID = G.ID AND O.ORDER_NUM = '"+ orderNum +"' AND OG.ID = "+ subNum;
try {
	rs			= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	memberId		= rs.getString("MEMBER_ID");
	memberName		= rs.getString("ORDER_NAME");
	payType			= rs.getString("PAY_TYPE");
	rcvName			= rs.getString("RCV_NAME");
	rcvTel			= rs.getString("RCV_TEL");
	rcvHp			= rs.getString("RCV_HP");
	rcvZipcode		= rs.getString("RCV_ZIPCODE");
	rcvAddr1		= rs.getString("RCV_ADDR1");
	rcvAddr2		= rs.getString("RCV_ADDR2");
	rcvRequest		= rs.getString("RCV_REQUEST");
	tagName			= rs.getString("TAG_NAME");
	tagTel			= rs.getString("TAG_TEL");
	tagHp			= rs.getString("TAG_HP");
	tagZipcode		= rs.getString("TAG_ZIPCODE");
	tagAddr1		= rs.getString("TAG_ADDR1");
	tagAddr2		= rs.getString("TAG_ADDR2");
	tagRequest		= rs.getString("TAG_REQUEST");
	pgTid			= (rs.getString("PG_TID") == null)? "" : rs.getString("PG_TID");
	pgCardNum		= rs.getString("PG_CARDNUM");
	pgFinanceName	= rs.getString("PG_FINANCENAME");
	pgAccountNum	= rs.getString("PG_ACCOUNTNUM");
	orderState		= rs.getString("ORDER_STATE");
	orderDate		= rs.getString("ORDER_DATE");
	payDate			= rs.getString("PAY_DATE");
	couponTprice	= rs.getInt("COUPON_PRICE");
	gubun1			= rs.getString("GUBUN1");
	shopType		= rs.getString("SHOP_TYPE");
	outOrderNum		= ut.isnull(rs.getString("OUT_ORDER_NUM"));
	couponNum		= rs.getString("COUPON_NUM");

	query1		= "SELECT MIN(DEVL_DATE) MIN_DATE, MAX(DEVL_DATE) MAX_DATE";
	query1		+= " FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"' AND GOODS_ID = "+ subNum;
	try {
		rs1			= stmt.executeQuery(query1);
	} catch(Exception e) {
		out.println(e+"=>"+query1);
		if(true)return;
	}

	if (rs1.next()) {
		minDate			= rs1.getString("MIN_DATE");
		maxDate			= rs1.getString("MAX_DATE");
		devlDates		= ut.isnull(minDate) +"~"+ ut.isnull(maxDate);
	} else {
		devlDates		= "-";
	}

	query1		= "SELECT EODD.RCV_NAME, EODD.RCV_HP, EODD.AGENCYID, EODA.AGENCY_NAME FROM ESL_ORDER_DEVL_DATE EODD LEFT JOIN ESL_ORDER_DEVL_AGENCY EODA ON EODD.AGENCYID = EODA.AGENCY_ID ";
	query1		+= " WHERE EODD.ORDER_NUM = '"+ orderNum +"'" ;
	query1		+= " ORDER BY EODD.DEVL_DATE LIMIT 1  ";
	try {
		rs1			= stmt.executeQuery(query1);
	} catch(Exception e) {
		out.println(e+"=>"+query1);
		if(true)return;
	}

	if (rs1.next()) {
		agId			= ut.isnull(rs1.getString("AGENCYID"));
		agName			= ut.isnull(rs1.getString("AGENCY_NAME"));
		rcvName			= ut.isnull(rs1.getString("RCV_NAME"));
		rcvHp			= ut.isnull(rs1.getString("RCV_HP"));
	}
	rs1.close();

	if (!couponNum.equals("") && couponNum.length() > 0) {
		query1		= "SELECT C.VENDOR FROM ESL_COUPON C, ESL_COUPON_MEMBER CM";
		query1		+= " WHERE C.ID = CM.COUPON_ID AND CM.COUPON_NUM = '"+ couponNum +"'";
		try {
			rs1			= stmt.executeQuery(query1);
		} catch(Exception e) {
			out.println(e+"=>"+query1);
			if(true)return;
		}

		if (rs1.next()) {
			vendor			= rs1.getString("VENDOR");
		}
		rs1.close();
	}
}

rs.close();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<title>Pulmuone EATSSLIM �����ڽý���</title>

	<link rel="stylesheet" type="text/css" href="../css/styles.css" />
	<style type="text/css">
	html, body { height:auto; background:#fff;}
	</style>

	<script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
	<link rel="stylesheet" type="text/css" href="/common/js/_calendars/jquery.datepick.layer.css" />
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick.js"></script>
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick-ko.js"></script>	
</head>
<body>
<div style="display: none;">
	<img id="calImg" src="/images/calendar.png" alt="Popup" class="trigger" style="vertical-align:middle;" />
</div>
	<!-- popup_wrap -->
	<div class="popup_wrap">
		<h2>�ֹ�������</h2>
		<table class="table01 mt_5" border="1" cellspacing="0">
			<colgroup>
				<col width="100px" />
				<col width="36%" />
				<col width="100px" />
				<col width="*" />
			</colgroup>
			<tbody>
				<form name="frm_info_pt" id="frm_info_pt"  action="order_view_day_ajax.jsp">
				<input type="hidden" name="mode" value="updInfo" />
				<input type="hidden" name="order_num" value="<%=orderNum%>" />
				<tr>
					<th scope="row"><span>�ֹ���ȣ</span></th>
					<td><%=orderNum%>-<%=seq%></td>
					<th scope="row"><span>�����</span></th>
					<td><%=agId%><% if (agName != null && !agName.equals(""))  { out.print("("+agName+")"); } %></td>					
				</tr>
				<tr>
					<th scope="row"><span>�޴»��</span></th>
					<td>
						<input type="text" name="rcvName" id="rcvName" value="<%=rcvName%>" dir="rtl" style="width:100px;" />
					</td>
					<th scope="row"><span>����ó</span></th>
					<td>
						<input type="text" name="rcvHp" id="rcvHp" value="<%=rcvHp%>" dir="rtl" style="width:100px;" />
					</td>
				</tr>
				<tr>
					<th scope="row"><span>����ּ�</span></th>
					<td colspan="3">[<%=rcvZipcode%>] <%=rcvAddr1%> <%=rcvAddr2%></td>
				</tr>
				<tr>
					<th scope="row"><span>��۱Ⱓ</span></th>
					<td><%=devlDates%></td>
					<th scope="row"><span>�ֹ�����</span></th>
					<td>
						<%
						if (payType.equals("10") && Integer.parseInt(orderState)==0) {
							out.print("��������");
						} else {
							out.println(ut.getOrderState(orderState));
						}
						%>
					</td>
				</tr>
				<!--tr>
					<th scope="row"><span>�Ǹ� SHOP</span></th>
					<td><%=ut.getShopType(shopType)%></td>
					<th scope="row"><span>�ܺθ� �ֹ���ȣ</span></th>
					<td><%=outOrderNum%></td>
				</tr-->
				
				<div class="btn_style1">
					<p class="right_btn">
						<a href="javascript:;" onclick="updInfo();" class="function_btn"><span>��������</span></a>
						<!--a href="javascript:;" onclick="phiCopy();" class="function_btn"><span>��������</span></a-->
					</p>
				</div>
				</form>
			</tbody>
		</table>
		<br />
		<h3 class="tit_style1">�ֹ�����������</h3>
		<div class="tagMenu tab_style1">
			<ul class="tabmenu">
				<li<%if(tabmenu.equals("1"))out.print(" class='current'");%> id="t_1" onclick="show(1)">����� ����</li>
				<li<%if(tabmenu.equals("2"))out.print(" class='current'");%> id="t_2" onclick="show(2)">�ּ� ����</li>
				<li<%if(tabmenu.equals("3"))out.print(" class='current'");%> id="t_3" onclick="show(3)">���/ȯ��</li>
			</ul>
		</div>
		<div class="tab_con tab_style2">
		<!-------------------------------------->
			<div class="tab_layout" style="display:block;" id="tablmenu1">
			
					- ������ 0�� �ֹ��� �����մϴ�.<br />
					- �������� �� ���� ������ �Ʒ� �ٸ� ������ �����Ͻðų� �߰��� �ϼž��մϴ�.<br />
					- �������� �� ������ ������ ������ڸ� ����˴ϴ�.
			
				<form name="frm_devl_pt" id="frm_devl_pt"  action="order_view_day_ajax.jsp">
					<input type="hidden" name="mode" value="updPtAll" />
					<input type="hidden" name="order_num" value="<%=orderNum%>" />
					<input type="hidden" name="gubun_code" id="gubun_code" value="<%=gubunCode%>" />
					<input type="hidden" name="sub_num" id="sub_num" value="<%=subNum%>" />

					<div class="btn_style1">
						<p>
							������ : <input type="text" name="devl_date_pattern" id="devl_date_pattern" style="width:90px;" readonly="readonly" />
							������ : <input type="text" name="start_date_pattern" id="start_date_pattern" style="width:90px;" readonly="readonly" />
							���� : <input type="text" name="order_cnt" id="order_cnt" value="1" onkeyup="this.value=this.value.replace(/[^0-9-]/g,'');" dir="rtl" style="width:40px;" maxlength="1" />
							<input type="checkbox" id="pattern_days" name="pattern_days" value="2" />��
							<input type="checkbox" id="pattern_days" name="pattern_days" value="3" />ȭ
							<input type="checkbox" id="pattern_days" name="pattern_days" value="4" />��
							<input type="checkbox" id="pattern_days" name="pattern_days" value="5" />��
							<input type="checkbox" id="pattern_days" name="pattern_days" value="6" />��
							<a href="javascript:;" onclick="updPtDate();" class="function_btn"><span>��������</span></a>
						</p>
						
					</div>
				</form>
				<form name="frm_devl" id="frm_devl">
					<input type="hidden" name="mode" value="updAll" />
					<input type="hidden" name="order_num" value="<%=orderNum%>" />
					<input type="hidden" name="gubun_code" id="gubun_code" value="<%=gubunCode%>" />
					<input type="hidden" name="sub_num" id="sub_num" value="<%=subNum%>" />
					<div class="btn_style1">
						<p class="right_btn">
							<a href="javascript:;" onclick="updAll();" class="function_btn"><span>�ϰ�����</span></a>
							<!--a href="javascript:;" onclick="phiCopy();" class="function_btn"><span>��������</span></a-->
						</p>
					</div>
					<table class="table02 mt_5" border="1" cellspacing="0">
						<colgroup>
							<col width="4%" />
							<col width="14%" />
							<col width="*" />
							<col width="20%" />
							<col width="10%" />
							<col width="10%" />
							<col width="10%" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col"><span>No.</span></th>
								<th scope="col"><span>�������</span></th>
								<th scope="col"><span>��ǰ��</span></th>
								<th scope="col"><span>����Ϻ���</span></th>
								<th scope="col"><span>����</span></th>
								<th scope="col"><span>����</span></th>
								<th scope="col"><span>Ȯ��</span></th>
							</tr>
						</thead>
						<tbody>
							<%
							query		= "SELECT COUNT(ID)";
							query		+= " FROM ESL_ORDER_DEVL_DATE";
							query		+= " WHERE ORDER_NUM = '"+ orderNum +"'";
							query		+= " AND GOODS_ID = "+ subNum;
							query		+= " AND STATE < 90";
							query		+= " ORDER BY DEVL_DATE ASC, ID ASC";
							try {
								rs			= stmt.executeQuery(query);
							} catch(Exception e) {
								out.println(e+"=>"+query);
								if(true)return;
							}
							
							if (rs.next()) {
								tcnt		= rs.getInt(1);
							}

							rs.close();

							query		= "SELECT ID, DEVL_DATE, WEEKDAY(DEVL_DATE) WEEKDAY, ORDER_CNT, STATE, STATE_DETAIL, GROUP_CODE,";
							query		+= "	(SELECT GROUP_NAME FROM ESL_GOODS_GROUP WHERE GROUP_CODE = '"+ gubunCode +"') GROUP_NAME";
							query		+= " FROM ESL_ORDER_DEVL_DATE";
							query		+= " WHERE ORDER_NUM = '"+ orderNum +"'";
							query		+= " AND GOODS_ID = "+ subNum;
							query		+= " AND STATE < 90";
							query		+= " ORDER BY DEVL_DATE";
							try {
								rs			= stmt.executeQuery(query);
							} catch(Exception e) {
								out.println(e+"=>"+query);
								if(true)return;
							}

							if (tcnt > 0) {
								i = 1;
								while (rs.next()) {
									devlId		= rs.getInt("ID");
									groupCode	= rs.getString("GROUP_CODE");
									groupName	= rs.getString("GROUP_NAME");
									weekDay		= rs.getString("WEEKDAY");
									orderDayState	= rs.getString("STATE");
									prdtSetName	= "";

									query1		= "SELECT PRDTNAME FROM PHIBABY.V_PRODUCT WHERE PRDTID = '"+ groupCode +"'";
									try {
										rs_phi	= stmt_phi.executeQuery(query1);
									} catch(Exception e) {
										out.println(e+"=>"+query1);
										if(true)return;
									}
									if (rs_phi.next()) {
										prdtSetName		= rs_phi.getString("PRDTNAME");
									}
									rs_phi.close();
							%>
							<input type="hidden" name="devl_ids" value="<%=devlId%>" />
							<input type="hidden" name="org_devl_date_<%=devlId%>" id="org_devl_date_<%=devlId%>" value="<%=rs.getString("DEVL_DATE")%>" />
							<input type="hidden" name="org_order_cnt_<%=devlId%>" id="org_order_cnt_<%=devlId%>" value="<%=rs.getString("ORDER_CNT")%>" />
							<input type="hidden" name="org_order_good_<%=devlId%>" id="org_order_good_<%=devlId%>" value="<%=rs.getString("GROUP_CODE")%>" />
							<tr>
								<td><%=i%></td>
								<td><%=rs.getString("DEVL_DATE")+"("+ut.getWeekName(weekDay)+")"%></td>
								<td>
									<%if (groupCode.equals("0300668")) {%>
									���ð���
									<%} else if (groupCode.equals("0300576")) {%>
									����ũ�ͽ�(2��)
									<%} else {%>
									<%=groupName+"("+prdtSetName+")"%>
									<%}%>
								</td>
								<td>
									<%if (groupCode.equals("0300576")) {%>
									<%=rs.getString("DEVL_DATE")%>
									<%} else {%>
									<input type="text" name="devl_date_<%=devlId%>" id="devl_date_<%=devlId%>" class="date-pick" value="<%=rs.getString("DEVL_DATE")%>" style="width:90px;" readonly="readonly" />
									<%}%>
								</td>
								<td>
									<%if (groupCode.equals("0300576")) {%>
									<%=rs.getInt("ORDER_CNT")%>
									<input type="hidden" name="order_cnt_<%=devlId%>" id="order_cnt_<%=devlId%>" value="<%=rs.getInt("ORDER_CNT")%>" />
									<%} else {%>
									<input type="text" name="order_cnt_<%=devlId%>" id="order_cnt_<%=devlId%>" value="<%=rs.getInt("ORDER_CNT")%>" onkeyup="this.value=this.value.replace(/[^0-9-]/g,'');" dir="rtl" style="width:40px;" maxlength="2" />
									<%}%>
								</td>
								<td><%=ut.getDevlState(orderDayState)%><% if (orderDayState.equals("02")) { out.println("("+ut.getDevlStateDetail(rs.getString("STATE_DETAIL"))+")"); }%></td>
								<td><%if (!groupCode.equals("0300576")) {%><input type="button" value="Ȯ��" onclick="editDevlDate(<%=devlId%>)" /><%}%></td>
							</tr>
							<%
									i++;
								}
								rs.close();
							}
							%>							
						</tbody>
					</table>
				</form>
				<br />
				<form name="frm_devl_add" id="frm_devl_add">
					<input type="hidden" name="mode" value="addDevlDate" />
					<input type="hidden" name="order_num" value="<%=orderNum%>" />
					<input type="hidden" name="sub_num" value="<%=subNum%>" />
					<input type="hidden" name="gubun_code" value="<%=gubunCode%>" />
					<table class="table02 mt_5" border="1" cellspacing="0">
						<colgroup>
							<col width="*" />
							<col width="20%" />
							<col width="10%" />
							<col width="10%" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col"><span>��ǰ��</span></th>
								<th scope="col"><span>�����</span></th>
								<th scope="col"><span>����</span></th>
								<th scope="col"><span>Ȯ��</span></th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									<select name="group_code" id="group_code">
										<option value="">����</option>
										<%
										query		= "SELECT GROUP_CODE, GROUP_NAME FROM ESL_GOODS_GROUP G, ESL_ORDER_GOODS OG";
										query		+= " WHERE G.ID = OG.GROUP_ID";
										query		+= " AND OG.ORDER_NUM = '"+ orderNum +"' AND OG.ID = "+ subNum;
										try {
											rs	= stmt.executeQuery(query);
										} catch(Exception e) {
											out.println(e+"=>"+query);
											if(true)return;
										}

										if (rs.next()) {
										%>
										<option value="<%=rs.getString("GROUP_CODE")%>"><%=rs.getString("GROUP_NAME")%></option>
										<%
										}
										%>
										<option value="0300668">���ð���(4000)</option>
										<option value="03006681">���ð���(3600)</option>
										<option value="03006682">���ð���(0)</option>
									</select>
								</td>
								<td>
									<input type="text" name="stdate" class="date-pick" style="width:90px;" readonly="readonly" />
								</td>
								<td>
									<input type="text" name="order_cnt" id="order_cnt" value="1" onkeyup="this.value=this.value.replace(/[^0-9-]/g,'');" dir="rtl" style="width:40px;" maxlength="2" />
								</td>
								<td><input type="button" value="�߰�" onclick="addDevlDate()" /></td>
							</tr>					
						</tbody>
					</table>
				</form>
				<br />
				<form name="frm_gift" id="frm_gift">
					<input type="hidden" name="mode" value="setGift" />
					<input type="hidden" name="order_num" value="<%=orderNum%>" />
					<input type="hidden" name="sub_num" value="<%=subNum%>" />
					<input type="hidden" name="gubun_code" value="<%=gubunCode%>" />
					<table class="table02 mt_5" border="1" cellspacing="0">
						<colgroup>
							<col width="*" />
							<col width="10%" />
							<col width="40%" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col"><span>���ڼ���</span></th>
								<th scope="col"><span>Ÿ��</span></th>
								<th scope="col"><span>����</span></th>
								<th scope="col"><span>�����ݿ�</span></th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									<input type="text" name="stdate" class="date-pick" style="width:90px;" readonly="readonly" />
								</td>
								<td>
									<select name="giftType">
										<option value="021">������</option>
										<option value="022">��ǰ�Ҹ�</option>
										<option value="023">��۰���</option>
										<option value="024">�޸տ���</option>
										<option value="025">�ý��۰��ú���</option>
									</select>
								</td>
								<td><input type="text" name="order_cnt" id="order_cnt" value="1" onkeyup="this.value=this.value.replace(/[^0-9-]/g,'');" dir="rtl" style="width:40px;" maxlength="1" /></td>
								<td><input type="button" value="Ȯ��" onclick="setGift();" /></td>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
			<div class="tab_layout" id="tablmenu2">
				<table class="table02 mt_5" border="1" cellspacing="0">
					<colgroup>
						<col width="10%" />
						<col width="10%" />
						<col width="*" />
						<col width="10%" />
						<col width="20%" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col"><span>�������</span></th>
							<th scope="col"><span>��ǰ��</span></th>
							<th scope="col"><span>�ּ�</span></th>
							<th scope="col"><span>�����</span></th>
							<th scope="col"><span>��۸޸�</span></th>
						</tr>
					</thead>
					<tbody>
						<%
						System.out.println("gubunCode1   :::::"+gubunCode);
						System.out.println("orderNum1   :::::"+orderNum);
						System.out.println("subNum1  :::::"+subNum);
						query		= "SELECT DEVL_DATE, WEEKDAY(DEVL_DATE) WEEKDAY, RCV_ZIPCODE, RCV_ADDR1,";
						query		+= " RCV_ADDR2, ORDER_CNT, STATE, RCV_REQUEST, AGENCYID, ";
						query		+= "	(SELECT GROUP_NAME FROM ESL_GOODS_GROUP WHERE GROUP_CODE = '"+ gubunCode +"') GROUP_NAME, ";
						query		+= "	IFNULL((SELECT AGENCY_NAME FROM ESL_ORDER_DEVL_AGENCY WHERE AGENCY_ID = AGENCYID ), '') AGENCY_NAME";
						query		+= " FROM ESL_ORDER_DEVL_DATE";
						query		+= " WHERE ORDER_NUM = '"+ orderNum +"'";
						query		+= " AND GOODS_ID = "+ subNum;
						query		+= " ORDER BY DEVL_DATE";
						try {
							rs			= stmt.executeQuery(query);
						} catch(Exception e) {
							out.println(e+"=>"+query);
							if(true)return;
						}

						i = 0;
						while (rs.next()) {
							weekDay		= rs.getString("WEEKDAY");
						%>
						<tr>
							<td><%=rs.getString("DEVL_DATE")+"("+ut.getWeekName(weekDay)+")"%></td>
							<td><%=rs.getString("GROUP_NAME")%></td>
							<td><%="["+ rs.getString("RCV_ZIPCODE") +"] "+ rs.getString("RCV_ADDR1") +" "+ rs.getString("RCV_ADDR2")%></td>
							<td><%=rs.getString("AGENCYID")%><% if (rs.getString("AGENCY_NAME") != null && !rs.getString("AGENCY_NAME").equals(""))  { out.print("("+rs.getString("AGENCY_NAME")+")"); } %></td>
							<td><%=rs.getString("RCV_REQUEST")%></td>
						</tr>
						<%
							i++;
						}
						%>
					</tbody>
				</table>
				<br />
				<form name="frm_address" id="frm_address">
					<input type="hidden" name="mode" value="editAddress" />
					<input type="hidden" name="order_num" id="order_num" value="<%=orderNum%>" />
					<input type="hidden" name="sub_num" id="subnum" value="<%=subNum%>" />
					<input type="hidden" name="group_code" id="group_code" value="<%=gubunCode%>" />
					<table class="table01 mt_5" border="1" cellspacing="0">
						<colgroup>
							<col width="100px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><span>�����</span></th>
								<td class="td01">
									<input type="text" class="input1" name="rcv_zipcode" id="rcv_zipcode" maxlength="7" style="width:60px" onkeyup="this.value=this.value.replace(/[^0-9-]/g,'');" value="" readonly="readonly" />
									<a href="javascript:;" onclick="window.open('/shop/popup/AddressSearchJiPop.jsp?ztype=0001','chk_zipcode','width=800,height=650,top=50,left=100,scrollbars=yes,resizable=no,toolbar=no,status=no,menubar=no');" class="function_btn"><span>�����ȣ �˻�</span></a>
									<p class="mt_5">
										<input type="text" class="input1" name="rcv_addr1" id="rcv_addr1" style="width:70%;" maxlength="150" value=""  required label="����� �ּ�" readonly="readonly" />
										<input type="text" class="input1" name="addr2" style="width:70%;" maxlength="100" value=""  required label="����� �ּ�" />
									</p>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>��۸޸�</span></th>
								<td class="td01">
									<input type="text" class="input1" name="rcv_request" style="width:70%;" maxlength="60" value="" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>����Ⱓ</span></th>
								<td class="td01">
									<input type="text" name="stdate_addr" class="date-address" style="width:90px;" readonly="readonly" />
									<input type="text" name="ltdate_addr" class="date-address" style="width:90px;" readonly="readonly" />
								</td>
							</tr>
						</tbody>
					</table>
					<div style="text-align:right;margin-top:10px;">
						<input type="button" value="Ȯ��" onclick="editAddress()" />
					</div>
				</form>
				
				<form name="frm_agency" id="frm_agency">
					<input type="hidden" name="mode" value="editAgency" />
					<input type="hidden" name="order_num" id="order_num" value="<%=orderNum%>" />
					<input type="hidden" name="sub_num" id="subnum" value="<%=subNum%>" />
					<input type="hidden" name="group_code" id="group_code" value="<%=gubunCode%>" />
					<table class="table01 mt_5" border="1" cellspacing="0">
						<colgroup>
							<col width="100px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><span>�����</span></th>
								<td class="td01">
									<input type="text" class="input1" name="agcycode" id="agcycode" maxlength="7" style="width:60px" onkeyup="this.value=this.value.replace(/[^0-9-]/g,'');" value="" />
									<a href="javascript:;" onclick="window.open('agencyPop.jsp','chk_jisacode','width=350,height=600,scrollbars=yes,resizable=no,toolbar=no,status=no,menubar=no');" class="function_btn"><span>������ �˻�</span></a>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>����Ⱓ</span></th>
								<td class="td01">
									<input type="text" name="stdate_agcy" class="date-address" style="width:90px;" readonly="readonly" />
									<input type="text" name="ltdate_agcy" class="date-address" style="width:90px;" readonly="readonly" />
								</td>
							</tr>
						</tbody>
					</table>
					<div style="text-align:right;margin-top:10px;">
						<input type="button" value="Ȯ��" onclick="editAgency()" />
					</div>
				</form>
			</div>
			<div class="tab_layout" id="tablmenu3">
				<table class="table02 mt_5" border="1" cellspacing="0">
					<colgroup>
						<col width="25%" />
						<col width="25%" />
						<col width="25%" />
						<col width="25%" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col"><span>�������</span></th>
							<th scope="col"><span>��ǰ��</span></th>
							<th scope="col"><span>��ۻ���</span></th>
							<th scope="col"><span>�ֹ�����</span></th>
						</tr>
					</thead>
					<tbody>
						<%
						System.out.println("gubunCode   :::::"+gubunCode);
						System.out.println("orderNum   :::::"+orderNum);
						System.out.println("subNum  :::::"+subNum);
						query		= "SELECT ID, DEVL_DATE, WEEKDAY(DEVL_DATE) WEEKDAY, ORDER_CNT, STATE, GROUP_CODE,";
						query		+= "	(SELECT GROUP_NAME FROM ESL_GOODS_GROUP WHERE GROUP_CODE = '"+ gubunCode +"') GROUP_NAME";
						query		+= " FROM ESL_ORDER_DEVL_DATE";
						query		+= " WHERE ORDER_NUM = '"+ orderNum +"'";
						query		+= " AND GOODS_ID = "+ subNum;
						query		+= " AND STATE != '02'";
						query		+= " ORDER BY DEVL_DATE";
						try {
							rs			= stmt.executeQuery(query);
						} catch(Exception e) {
							out.println(e+"=>"+query);
							if(true)return;
						}

						i = 0;
						while (rs.next()) {
							state		= rs.getString("STATE");
							compare		= today.compareTo(rs.getString("DEVL_DATE"));
							if (Integer.parseInt(state) < 90) {
								if (compare >= 0) {
									devlState		= "��ۿϷ�";
								} else {
									devlState		= "����غ���";
								}
							} else {
								devlState		= ut.getDevlState(state);
							}
							prdtSetName	= "";

							groupCode	= rs.getString("GROUP_CODE");
							groupName	= rs.getString("GROUP_NAME");
							weekDay		= rs.getString("WEEKDAY");
							query1		= "SELECT PRDTNAME FROM PHIBABY.V_PRODUCT WHERE PRDTID = '"+ groupCode +"'";
							try {
								rs_phi	= stmt_phi.executeQuery(query1);
							} catch(Exception e) {
								out.println(e+"=>"+query1);
								if(true)return;
							}

							if (rs_phi.next()) {
								prdtSetName		= rs_phi.getString("PRDTNAME");
							}
							rs_phi.close();
						%>
						<tr>
							<td><%=rs.getString("DEVL_DATE")+"("+ut.getWeekName(weekDay)+")"%></td>
							<td>
								<%if (groupCode.equals("0300668")) {%>
								���ð���
								<%if (state.equals("01")) {%>
								<input type="button" value="���" onclick="refundBag('<%=payType%>', <%=rs.getInt("ORDER_CNT") * defaultBagPrice%>, <%=rs.getInt("ID")%>);" id="refundBag_<%=rs.getInt("ID")%>" />
								<span id="refundBag_ing_<%=rs.getInt("ID")%>" class="hidden">ó����...</span>
								<%}%>
								<%} else {%>
								<%=groupName+"("+prdtSetName+")"%>
								<%}%>
							</td>
							<td><%=devlState%></td>
							<td><%=ut.getDevlState(state)%></td>
						</tr>
						<%
							i++;
						}
						%>
					</tbody>
				</table>
				<br />
				<form name="frm_cancel" method="frm_cancel" action="order_db.jsp">
					<%
					query		= "SELECT ";
					query		+= "	PAY_PRICE, PAY_TYPE, RCV_HP, PG_CARDNUM, PG_FINANCENAME, PG_ACCOUNTNUM, PG_TID, SHOP_TYPE";
					query		+= " FROM ESL_ORDER WHERE ORDER_NUM = '"+ orderNum +"'";
					try {
						rs			= stmt.executeQuery(query);
					} catch(Exception e) {
						out.println(e+"=>"+query);
						if(true)return;
					}

					if (rs.next()) {
						payType			= rs.getString("PAY_TYPE");
						pgCardNum		= rs.getString("PG_CARDNUM");
						pgFinanceName	= rs.getString("PG_FINANCENAME");
						pgAccountNum	= rs.getString("PG_ACCOUNTNUM");
						rcvHp			= rs.getString("RCV_HP");
						pgTid			= rs.getString("PG_TID");
					}
					%>
					<input type="hidden" name="mode" value="cancel" />
					<input type="hidden" name="ctype" id="ctype" />
					<input type="hidden" name="bag_id" id="bag_id" />
					<input type="hidden" name="order_num" value="<%=orderNum%>" />
					<input type="hidden" name="sub_num" value="<%=subNum%>" />
					<input type="hidden" name="group_code" value="<%=gubunCode%>" />
					<input type="hidden" name="order_cnt" value="<%=i%>" />
					<input type="hidden" name="refund_price" id="refund_price" value="0" />
					<input type="hidden" name="pay_type" id="pay_type" value="<%=payType%>">
					<input type="hidden" name="LGD_RFPHONE" value="<%=rcvHp%>">
					<input type="hidden" name="refund_fee" value="0">
					<input type="hidden" name="pg_tid" value="<%=pgTid%>">
					<input type="hidden" id="out_num" value="<%=outOrderNum%>">
					<input type="hidden" id="vendor" value="<%=vendor%>">
					<table class="table02 mt_5" border="1" cellspacing="0">
						<colgroup>
							<col width="*" />
							<col width="25%" />
							<col width="25%" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col"><span>�Ⱓ����</span></th>
								<th scope="col"><span>ȯ�ұݾ�</span></th>
								<th scope="col"><span>ȯ���ϱ�</span></th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									<input type="text" name="stdate_cancel" id="stdate_cancel" style="width:90px;" readonly="readonly" />
									~
									<input type="text" name="ltdate_cancel" id="ltdate_cancel" style="width:90px;" readonly="readonly" />
								</td>
								<td>
									<span id="refund">0</span>��<br />
									<span style="color:red">(0��)</span>
								</td>
								<td>
									<input type="button" value="Ȯ��" onclick="refund('<%=payType%>');" id="refund_btn" />
									<span id="refund_ing" class="hidden">(ó����...)</span>
								</td>
							</tr>
						</tbody>
					</table>
					<%if (!payType.equals("10") || outOrderNum.length() > 0 || vendor.equals("03")) {%>
					<br />
					<table class="table02 mt_5" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>							
							<tr>
								<th>ȯ�Ұ�������</th>
								<td>
									<select name="bank_name" id="bank_name" style="width:172px;">
										<!--<option value="�泲����">�泲����</option>
										<option value="��������">��������</option>
										<option value="��������">��������</option>
										<option value="�������">�������</option>
										<option value="����">����</option>
										<option value="�뱸����">�뱸����</option>
										<option value="����ġ��ũ">����ġ��ũ</option>
										<option value="�λ�����">�λ�����</option>
										<option value="�������">�������</option>
										<option value="��ȣ��������">��ȣ��������</option>
										<option value="�������ݰ�">�������ݰ�</option>
										<option value="�����߾�ȸ">�����߾�ȸ</option>
										<option value="�ſ���������">�ſ���������</option>
										<option value="��������">��������</option>
										<option value="��ȯ����">��ȯ����</option>
										<option value="�츮����">�츮����</option>
										<option value="��ü��">��ü��</option>
										<option value="��������">��������</option>
										<option value="��������">��������</option>
										<option value="�ϳ�����">�ϳ�����</option>
										<option value="�ѱ���Ƽ����">�ѱ���Ƽ����</option>
										<option value="HSBC">HSBC</option>
										<option value="SC��������">SC��������</option>-->
										<option value="�泲">�泲</option>
										<option value="����">����</option>
										<option value="���">���</option>
										<option value="����">����</option>
										<option value="�뱸">�뱸</option>
										<option value="�λ�">�λ�</option>
										<option value="����">����</option>
										<option value="����">����</option>
										<option value="��ȯ">��ȯ</option>
										<option value="�츮">�츮</option>
										<option value="��ü��">��ü��</option>
										<option value="�ϳ�">�ϳ�</option>
										<option value="����">����</option>
										<option value="SC����">SC����</option>
										<option value="��Ƽ">��Ƽ</option>
										<option value="��������">��������</option>
									</select>
								</td>
							</tr>
							<tr>
								<th>ȯ�Ұ��� ������</th>
								<td><input type="text" class="input1" style="width:94px;" maxlength="30" name="bank_user" id="bank_user" /></td>
							</tr>
							<tr>
								<th>ȯ�Ұ��¹�ȣ</th>
								<td><input type="text" class="input1" style="width:144px;" maxlength="100" onBlur="this.value=this.value.replace(/[^0-9-]/g,'');" name="bank_account" id="bank_account" /></td>
							</tr>
						</tbody>
					</table>
					<%}%>
				</form>
			</div>
		</div>
	</div>
	<!-- //popup_wrap -->
	<iframe name="ifrmHidden" id="ifrmHidden" src="about:blank" style="width:100%;height:200px;display:none;"></iframe>
<script type="text/javascript">
$(document).ready(function() {
	$(".date-pick").datepick({ 
		dateFormat: "yyyy-mm-dd",
		showTrigger: '#calImg'
	});
	$(".date-address").datepick({ 
		dateFormat: "yyyy-mm-dd",
		showTrigger: '#calImg'
	});

	$('#stdate_cancel,#ltdate_cancel').datepick({ 
		onSelect: setRefund,
		dateFormat: "yyyy-mm-dd",
		showTrigger: '#calImg'
	}); 
	
	$("#devl_date_pattern").datepick({ 
		dateFormat: "yyyy-mm-dd",
		showTrigger: '#calImg'
	});
	
	$("#start_date_pattern").datepick({ 
		dateFormat: "yyyy-mm-dd",
		showTrigger: '#calImg'
	});
});

function refund(ptype) {
	var f	= document.frm_cancel;

	if (!$("#stdate_cancel").val()) {
		alert("���� �Ⱓ�� �����ϼ���.");
		$("#stdate_cancel").focus();
	} else if (!$("#ltdate_cancel").val()) {
		alert("���� �Ⱓ�� �����ϼ���.");
		$("#ltdate_cancel").focus();
	//} else if ($("#refund_price").val() < 1) {
	//	alert("ȯ�ұݾ��� �����ϴ�. �Ⱓ�� �����ϼ���.");
	} else if (ptype == '10') {
		$("#refund_ing").removeClass("hidden");
		$("#refund_btn").addClass("hidden");
		f.target	= "ifrmHidden";
		f.submit();
	} else if (ptype != '10' || $("#out_num").length > 52 || $("#vendor").val() == "03") {
		if (!$("#bank_name").val()) {
			alert("������ �����ϼ���.");
			$("#bank_name").focus();
		} else if (!$.trim($("#bank_user").val())) {
			alert("ȯ�Ұ��� �����ָ��� �Է��ϼ���");
			$("#bank_user").focus();
		} else if (!$.trim($("#bank_account").val())) {
			alert("ȯ�Ұ��¹�ȣ�� �Է��ϼ���");
			$("#bank_account").focus();
		} else {
			$("#refund_ing").removeClass("hidden");
			$("#refund_btn").addClass("hidden");
			f.target	= "ifrmHidden";
			f.submit();
		}
	}
}

function refundBag(ptype, rprice, bagId) {
	var f	= document.frm_cancel;
	$("#refund_price").val(rprice);
	$("#ctype").val("bag");
	$("#bag_id").val(bagId);
	
	if (ptype == '10') {
		$("#refundBag_ing_"+bagId).removeClass("hidden");
		$("#refundBag_"+bagId).addClass("hidden");
		f.target	= "ifrmHidden";
		f.submit();
	} else if (ptype != '10' || $("#out_num").length > 52 || $("#vendor").val() == "03") {
		if (!$("#bank_name").val()) {
			alert("������ �����ϼ���.");
			$("#bank_name").focus();
		} else if (!$.trim($("#bank_user").val())) {
			alert("ȯ�Ұ��� �����ָ��� �Է��ϼ���");
			$("#bank_user").focus();
		} else if (!$.trim($("#bank_account").val())) {
			alert("ȯ�Ұ��¹�ȣ�� �Է��ϼ���");
			$("#bank_account").focus();
		} else {
			$("#refundBag_ing_"+bagId).removeClass("hidden");
			$("#refundBag_"+bagId).addClass("hidden");
			f.target	= "ifrmHidden";
			f.submit();
		}
	}
}

function setRefund(dates) {
	var stdate		= $("#stdate_cancel").val();
	var ltdate		= $("#ltdate_cancel").val();

	if (this.id == 'stdate_cancel') {
		$('#ltdate_cancel').datepick('option', 'minDate', dates[0] || null);
	} else {
		$('#stdate_cancel').datepick('option', 'maxDate', dates[0] || null);
	}

	if (stdate.length > 0 && ltdate.length > 0) {
		$.post("order_view_day_ajax.jsp", {
			mode: "setRefund",
			order_num: $("#order_num").val(),
			group_code: $("#group_code").val(),
			stdate: stdate,
			ltdate: ltdate,
			sub_num: <%=subNum%>
		},
		function(data) {
			$(data).find("result").each(function() {
				if ($(this).text() == "success") {
					$(data).find("price").each(function() {
						$("#refund").text($(this).text());
						$("#refund_price").val($(this).text());
					});
				} else {
					$(data).find("error").each(function() {
						alert($(this).text());
						$("#refund").text(0);
						$("#refund_price").val(0);
						$("#stdate_cancel").val("");
						$("#ltdate_cancel").val("");
					});
				}
			});
		}, "xml");
		return false;
	}
}

function show(no){
	for(var i=1;i<=5;i++){			
		if(i==no){
			$("#tablmenu"+i).show();
			$("#t_"+i).removeClass("current").addClass("current");
		}else{
			$("#tablmenu"+i).hide();
			$("#t_"+i).removeClass("current");
		}
	}
	
}

function editDevlDate(num) {
	$.post("order_view_day_ajax.jsp", {
		mode: "editDevl",
		order_num: $("#order_num").val(),
		gubun_code: $("#gubun_code").val(),
		sub_num: $("#sub_num").val(),
		group_code: $("#group_code").val(),
		devl_id: num,
		org_devl_date: $("#org_devl_date_"+ num).val(),
		org_order_cnt: $("#org_order_cnt_"+ num).val(),
		org_order_good: $("#org_order_good_"+ num).val(),
		devl_date: $("#devl_date_"+ num).val(),
		order_cnt: $("#order_cnt_"+ num).val()
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				alert("���������� ó���Ǿ����ϴ�.");
				location.href = "order_view_day.jsp?tabmenu=1&ordno="+ $("#order_num").val() + "&subno=<%=subNum%>&gcode=<%=gubunCode%>&seq=<%=seq%>";
			} else {
				$(data).find("error").each(function() {
					alert($(this).text());
				});
			}
		});
	}, "xml");
	return false;
}

function addDevlDate() {
	$.post("order_view_day_ajax.jsp", $("#frm_devl_add").serialize(),
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				alert("���������� ó���Ǿ����ϴ�.");
				location.href = "order_view_day.jsp?tabmenu=1&ordno="+ $("#order_num").val() + "&subno=<%=subNum%>&gcode=<%=gubunCode%>&seq=<%=seq%>";
			} else {
				$(data).find("error").each(function() {
					alert($(this).text());
				});
			}
		});
	}, "xml");
	return false;
}

function setGift() {
	$.post("order_view_day_ajax.jsp", $("#frm_gift").serialize(),
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				alert("���������� ó���Ǿ����ϴ�.");
				location.href = "order_view_day.jsp?tabmenu=1&ordno="+ $("#order_num").val() + "&subno=<%=subNum%>&gcode=<%=gubunCode%>&seq=<%=seq%>";
			} else {
				$(data).find("error").each(function() {
					alert($(this).text());
				});
			}
		});
	}, "xml");
	return false;
}

function editAddress() {
	$.post("order_view_day_ajax.jsp", $("#frm_address").serialize(),
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				alert("���������� ó���Ǿ����ϴ�.");
				location.href = "order_view_day.jsp?tabmenu=2&ordno="+ $("#order_num").val() + "&subno=<%=subNum%>&gcode=<%=gubunCode%>&seq=<%=seq%>";
			} else {
				$(data).find("error").each(function() {
					alert($(this).text());
				});
			}
		});
	}, "xml");
	return false;
}

function editAgency() {
	$.post("order_view_day_ajax.jsp", $("#frm_agency").serialize(),
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				alert("���������� ó���Ǿ����ϴ�.");
				location.href = "order_view_day.jsp?tabmenu=2&ordno="+ $("#order_num").val() + "&subno=<%=subNum%>&gcode=<%=gubunCode%>&seq=<%=seq%>";
			} else {
				$(data).find("error").each(function() {
					alert($(this).text());
				});
			}
		});
	}, "xml");
	return false;
}

function updInfo() {
	//var f	= document.frm_devl_pt;
	//f.submit();
			
	$.post("order_view_day_ajax.jsp", $("#frm_info_pt").serialize(),
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				alert("���������� ó���Ǿ����ϴ�.");
				location.href = "order_view_day.jsp?tabmenu=1&ordno="+ $("#order_num").val() + "&subno=<%=subNum%>&gcode=<%=gubunCode%>&seq=<%=seq%>";
			} else {
				$(data).find("error").each(function() {
					alert($(this).text());
				});
			}
		});
	}, "xml");
	return false;

}


function updPtDate(num) {
	//var f	= document.frm_devl_pt;
	//f.submit();
			
	$.post("order_view_day_ajax.jsp", $("#frm_devl_pt").serialize(),
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				alert("���������� ó���Ǿ����ϴ�.");
				location.href = "order_view_day.jsp?tabmenu=1&ordno="+ $("#order_num").val() + "&subno=<%=subNum%>&gcode=<%=gubunCode%>&seq=<%=seq%>";
			} else {
				$(data).find("error").each(function() {
					alert($(this).text());
				});
			}
		});
	}, "xml");
	return false;

}


function updAll() {
	$.post("order_view_day_ajax.jsp", $("#frm_devl").serialize(),
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				alert("���������� ó���Ǿ����ϴ�.");
				location.href = "order_view_day.jsp?tabmenu=1&ordno="+ $("#order_num").val() + "&subno=<%=subNum%>&gcode=<%=gubunCode%>&seq=<%=seq%>";
			} else {
				$(data).find("error").each(function() {
					alert($(this).text());
				});
			}
		});
	}, "xml");
	return false;
}

function phiCopy() {
	$.post("order_view_day_ajax.jsp", {
		mode: "phiCopy",
		order_num: '<%=orderNum%>'
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				alert("���������� ó���Ǿ����ϴ�.");
				location.href = "order_view_day.jsp?tabmenu=1&ordno="+ $("#order_num").val() + "&subno=<%=subNum%>&gcode=<%=gubunCode%>&seq=<%=seq%>";
			} else {
				$(data).find("error").each(function() {
					alert($(this).text());
				});
			}
		});
	}, "xml");
	return false;
}
</script>
<%if(!tabmenu.equals("")){%>
<script type="text/javascript">
	show(<%=tabmenu%>);
</script>
<%}%>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>
<%@ include file="../lib/dbclose_phi.jsp"%>