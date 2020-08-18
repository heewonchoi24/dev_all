<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import ="javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-login-check.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%
String table		= "ESL_ORDER";
String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
String stdate		= ut.inject(request.getParameter("stdate"));
String ltdate		= ut.inject(request.getParameter("ltdate"));
String stateType	= ut.inject(request.getParameter("state_type"));
String where		= "";
String param		= "";
String orderNum		= "";
String orderDate	= "";
int payPrice		= 0;
String payType		= "";
String orderState	= "";
int cnt				= 0;
NumberFormat nf		= NumberFormat.getNumberInstance();
Calendar cal = Calendar.getInstance();
cal.setTime(new Date()); //����
String cDate=(new SimpleDateFormat("yyyy-MM-dd")).format(cal.getTime());
cal.setTime(new Date());
cal.add ( Calendar.MONTH, -1 ); //1������
String preMonth3=(new SimpleDateFormat("yyyy-MM-dd")).format(cal.getTime());
where			= " WHERE MEMBER_ID = '"+ eslMemberId +"' AND ORDER_STATE > 0 AND ORDER_STATE < 90";
where			+= " AND DATE_FORMAT(ORDER_DATE, '%Y-%m-%d') BETWEEN '"+ preMonth3 +"' AND '"+ cDate +"'";

query		= "SELECT COUNT(*)";
query		+= " FROM "+ table + where; //out.print(query); if(true)return;
try {
	rs = stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	cnt		= rs.getInt(1);
}
rs.close();

query		= "SELECT ORDER_NUM, DATE_FORMAT(ORDER_DATE, '%Y.%m.%d') ORDER_DATE, ORDER_NAME, PAY_TYPE, PAY_PRICE,";
query		+= "	ORDER_STATE, ORDER_ENV";
query		+= " FROM "+ table + where;
query		+= " ORDER BY ORDER_NUM DESC"; //out.print(query); if(true)return;
try {
	rs = stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}
///////////////////////////
%>
<script type="text/javascript" src="/common/js/date.js"></script>
<script type="text/javascript" src="/common/js/jquery.datePicker.js"></script>
<script type="text/javascript" src="/common/js/common.js"></script>
</head>

<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div>
	<!-- End header -->
	<div class="container">
		<div class="container_inner">
			<section id="index_content" class="contents">
				<header class="cont_header">
					<h2>���� �ս���</h2>
				</header>
				<div class="content">
					<div class="recent_goods">
						<dl>
							<dt><span>�ֱ� ������ ��ǰ</span></dt>
							<dd>
								<ul>
									<li>
										<div class="img"><a href="javascript:void(0);"><img src="/mobile/common/images/thumb_sample.jpg" alt=""></a></div>
										<div class="desc">
											<div class="title"><a href="javascript:void(0);">[�ﾾ����]</a></div>
											<div class="d_period"><span>�� ~ ��</span>17.12.23 ~ 18.01.21</div>
											<div class="d_destination">
												����� ����� 180 ��ȭ���� 3��
												����� ����� 180 ��ȭ���� 3��
												����� ����� 180 ��ȭ���� 3��
											</div>
											<div class="bx_btn">
												<button type="button" class="btn small btn_dgray" onclick="pSlideFn.onAddCont({direction:'next',url:'__ajax_mypage_detail.html'});">�ֹ���</button>
												<button type="button" class="btn small btn_white" onclick="pSlideFn.onAddCont({direction:'next',url:'__ajax_mypage_calendar.html'});">���Ķ����</button>
											</div>
										</div>
									</li>
									<li>
										<div class="img"><a href="javascript:void(0);"><img src="/mobile/common/images/thumb_sample.jpg" alt=""></a></div>
										<div class="desc">
											<div class="title"><a href="javascript:void(0);">[����]</a></div>
											<div class="d_period"><span>��/ȭ/��/��</span>17.12.23 ~ 18.01.21</div>
											<div class="d_destination">
												����� ����� 180 ��ȭ���� 3��
												����� ����� 180 ��ȭ���� 3��
												����� ����� 180 ��ȭ���� 3��
											</div>
											<div class="bx_btn">
												<button type="button" class="btn small btn_dgray" onclick="pSlideFn.onAddCont({direction:'next',url:'__ajax_mypage_detail.html'});">�ֹ���</button>
												<button type="button" class="btn small btn_white" onclick="pSlideFn.onAddCont({direction:'next',url:'__ajax_mypage_calendar.html'});">���Ķ����</button>
											</div>
										</div>
									</li>
									<li>
										<div class="img"><a href="javascript:void(0);"><img src="/mobile/common/images/thumb_sample.jpg" alt=""></a></div>
										<div class="desc">
											<div class="title"><a href="javascript:void(0);">[�˶��� ����]</a></div>
											<div class="d_period"><span>��/��/��</span>17.12.23 ~ 18.01.21</div>
											<div class="d_destination">
												����� ����� 180 ��ȭ���� 3��
												����� ����� 180 ��ȭ���� 3��
												����� ����� 180 ��ȭ���� 3��
											</div>
											<div class="bx_btn">
												<button type="button" class="btn small btn_dgray" onclick="pSlideFn.onAddCont({direction:'next',url:'__ajax_mypage_detail.html'});">�ֹ���</button>
												<button type="button" class="btn small btn_white" onclick="pSlideFn.onAddCont({direction:'next',url:'__ajax_mypage_calendar.html'});">���Ķ����</button>
											</div>
										</div>
									</li>
								</ul>
							</dd>
						</dl>
					</div>
					<div class="order_link">
						<ul>
							<li><a href="javascript:void(0);">�ֹ���ü ����Ʈ<span></span></a></li>
							<li><a href="javascript:void(0);">���� ����Ʈ<span></span></a></li>
							<li><a href="javascript:void(0);">1:1 ����<span></span></a></li>
						</ul>
					</div>
				</div>
			</section>
			<section id="load_content" class="contents">
				
			</section>
		</div>
	</div>
	<!-- End container -->

	<div id="footer">
		<%@ include file="/common/include/inc-footer.jsp"%>
	</div>
	<!-- End footer -->
</div>
</body>
</html>