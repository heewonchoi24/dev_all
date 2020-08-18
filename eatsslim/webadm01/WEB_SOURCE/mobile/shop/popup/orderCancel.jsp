<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-login-check.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String query			= "";
String orderNum			= ut.inject(request.getParameter("ono"));
int goodsPrice			= 0;
//int payPrice			= 0;
payPrice			= 0;
int couponPrice			= 0;
int devlPrice			= 0;
String payType			= "";
String pgCardNum		= "";
String pgFinanceName	= "";
String pgAccountNum		= "";
String orderDate		= "";
String rcvHp		= "";
String pgTid		= "";
String orderName = "";
int orderCnt		= 0;
NumberFormat nf = NumberFormat.getNumberInstance();

query		= "SELECT DATE_FORMAT(ORDER_DATE, '%Y.%m.%d %H:%i') ORDER_DATE, GOODS_PRICE, PAY_PRICE, ORDER_NAME, ";
query		+= "	COUPON_PRICE, DEVL_PRICE, PAY_TYPE, PG_CARDNUM, PG_FINANCENAME, PG_ACCOUNTNUM, ORDER_STATE, RCV_HP, PG_TID";
query		+= " FROM ESL_ORDER WHERE ORDER_NUM = '"+ orderNum +"'";
try {
rs			= stmt.executeQuery(query);
} catch(Exception e) {
out.println(e+"=>"+query);
if(true)return;
}

if (rs.next()) {
	goodsPrice		= rs.getInt("GOODS_PRICE");
	payPrice		= rs.getInt("PAY_PRICE");
	couponPrice		= rs.getInt("COUPON_PRICE");
	devlPrice		= rs.getInt("DEVL_PRICE");
	payType			= rs.getString("PAY_TYPE");
	pgCardNum		= ut.isnull(rs.getString("PG_CARDNUM"));
	pgFinanceName	= ut.isnull(rs.getString("PG_FINANCENAME"));
	pgAccountNum	= ut.isnull(rs.getString("PG_ACCOUNTNUM"));
	orderDate		= rs.getString("ORDER_DATE");
	rcvHp			= rs.getString("RCV_HP");
	pgTid			= rs.getString("PG_TID");
	orderName		= rs.getString("ORDER_NAME");
}
rs.close();
%>
</head>
<body>
<form name="frm_cancel" method="post" action="/proc/order_edit_proc.jsp">
	<input type="hidden" name="mode" value="cancel">
	<input type="hidden" name="code" value="CD1">
	<input type="hidden" name="order_num" id="order_num" value="<%=orderNum%>">
	<input type="hidden" name="pay_type" id="pay_type" value="<%=payType%>">
	<input type="hidden" name="LGD_RFPHONE" id="LGD_RFPHONE" value="<%=rcvHp%>">
	<input type="hidden" name="item_cnt" id="item_cnt" value="<%=orderCnt%>">
	<input type="hidden" name="rprice" id="rprice" value="<%=payPrice%>">
	<input type="hidden" name="rfee" id="rfee" value="1">
	<input type="hidden" name="pgTID" id="pgTID" value="<%=pgTid%>">
	<input type="hidden" name="cancelFrom" value="mobile" />
<div class="pop-wrap">
  <div class="headpop">
    <h2>�ֹ� ���</h2>
    <button id="cboxClose" type="button">close</button>
    <div class="clear"></div>
  </div>
  <div class="contentpop">
    <!--  
    <h2 class="ui-title">�ֹ���� ��ǰ</h2>
    <dl class="itemlist">
      <dt style="width:70%;">���̾�Ʈ �Ļ� 3��/1��
        <p class="font-gray">(����A+����B+�˶���COOL)</p>
      </dt>
      <dd style="width:30%;">104,400��</dd>
    </dl>
    <dl class="itemlist">
      <dt style="width:70%;">��Ƽ����Ƽ/1BOX
        <p class="font-gray">(����A+����B+�˶���COOL)</p>
      </dt>
      <dd style="width:30%;">24,000��</dd>
    </dl>
    -->
    <h2 class="ui-title">�������� Ȯ��</h2>
    <dl class="itemlist">
      <dt style="width:70%;">�������</dt>
      <dd style="width:30%;"><%=ut.getPayType(payType)%></dd>
      <dt style="width:70%;">��ǰ�հ�ݾ�</dt>
      <dd style="width:30%;"><%=nf.format(goodsPrice)%>��</dd>
      <dt style="width:70%;">��ǰ����</dt>
      <dd style="width:30%;">(-) <%=nf.format(couponPrice)%>��</dd>
      <dt style="width:70%;">��ü ��ۺ�</dt>
      <dd style="width:30%;">(+) <%=nf.format(devlPrice)%>��</dd>
    </dl>
    <div class="divider"></div>
    <dl class="itemlist redline" style="margin:0 10px;">
      <dt class="f16">�� �����ݾ�</dt>
      <dd class="f16 font-orange"><%=nf.format(payPrice)%>��</dd>
    </dl>
    <%if (payType.equals("30")) {%>
    <div class="divider"></div>
    <h2 class="ui-title">��һ���</h2>
    <dl class="itemlist">
      <dt style="width:30%;">��һ���</dt>
      <dd style="width:70%;">
          <ul class="form-line" style="margin:0;">
             <li>
             <div class="select-box">
            <select name="reason_type" id="reason_type" required label="��һ�������">
				<option value="">��һ����� ����</option>
				<option value="1">�����ǻ����</option>
				<option value="2">��ǰ �߸� �ֹ�</option>
				<option value="3">��ǰ���� ����</option>
				<option value="4">���� �� ��ǰ �Ҹ���</option>
            </select>
             </div>
            </li>
           </ul>  
      </dd>
      <div class="divider"></div>
      <dt style="width:30%;">ȯ�Ұ�������</dt>
      <dd style="width:70%;">
         <ul class="form-line" style="margin:0;">
             <li>
             <div class="select-box">
            <select name="bankName" id="bankName"><option value="�泲">�泲</option>
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
				</select>
             </div>
            </li>
           </ul>  
      </dd>
      <div class="divider"></div>
      <dt style="width:30%;">ȯ�Ұ��� ������</dt>
      <dd style="width:70%;">
         <ul class="form-line" style="margin:0;">
             <li><input type="text" class="input1" maxlength="30" name="bankUser" id="bankUser" /></li>
           </ul>
      </dd>
      <div class="divider"></div>
      <dt style="width:30%;">ȯ�Ұ��¹�ȣ</dt>
      <dd style="width:70%;">
         <ul class="form-line" style="margin:0;">
             <li><input type="text" class="input1" maxlength="100" onBlur="this.value=this.value.replace(/[^0-9-]/g,'');" name="bankAccount" id="bankAccount" /></li>
           </ul>
      </dd>
      <!-- <dt style="width:30%;">��û����</dt>
      <dd style="width:70%;">
         <ul class="form-line" style="margin:0;">
             <li>
            <input name="" type="text" style="width:90%;">
        </li>
           </ul>
      </dd> -->
    </dl>
    <%}%>
    <div class="divider"></div>
    <div class="grid-navi" style="margin:0 10px;">
            <table class="navi" border="0" cellspacing="10" cellpadding="0">
               <tr>
                 <td><a href="javascript:;" class="ui-btn ui-btn-inline ui-btn-up-b" onclick="orderCancel('<%=orderNum%>');"><span class="ui-btn-inner"><span class="ui-btn-text">��ҽ�û</span></span></a></td>
               </tr>
            </table>
        </div>
  </div>
  <!-- End contentpop -->
</div>
</form>
<script type="text/javascript">
function orderCancel(ono) {
	var msg = "������ �ֹ��� ����Ͻðڽ��ϱ�?"
	if(confirm(msg)){
		document.frm_cancel.submit();
	}else{
		return;
	}
}
</script>
</body>
</html>
