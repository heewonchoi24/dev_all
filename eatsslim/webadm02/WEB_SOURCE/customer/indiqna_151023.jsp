<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-login-check.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%
String query		= "";
String counselID	= ut.inject(request.getParameter("counselID"));
String memName		= "";
String memEmail		= "";
String emailId		= "";
String emailAddr	= "";
String memHp		= "";
String memHp1		= "";
String memHp2		= "";
String memHp3		= "";
String counsel_type	= "";
String title		= "";
String content		= "";
String up_file		= "";

String txt_btn		= "";

String[] tmp		= new String[]{};

//out.println (counselID);
//if ( true ) return;

if (counselID != null && counselID.length() > 0) {	
	query = "SELECT counsel_type, name, hp, email, title, content, up_file FROM ESL_COUNSEL WHERE id="+ counselID ;
	try {
		rs			= stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	if (rs.next()) {
		counsel_type= rs.getString("counsel_type");
		memName		= rs.getString("name");
		memEmail	= rs.getString("email");
		memHp		= rs.getString("hp");
		title		= rs.getString("title");
		content		= rs.getString("content");
		up_file		= rs.getString("up_file");

		if (memEmail != null && memEmail.length()>0) {
			tmp			= memEmail.split("@");
			emailId		= tmp[0];
			emailAddr	= tmp[1];
		}

		if (memHp != null && memHp.length()>10) {
			tmp			= memHp.split("-");
			memHp1		= tmp[0];
			memHp2		= tmp[1];
			memHp3		= tmp[2];
		}
	}
}
else {
	query = "SELECT MEM_NAME, EMAIL, HP FROM ESL_MEMBER WHERE MEM_ID = '"+ eslMemberId +"'";
	try {
		rs			= stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	if (rs.next()) {
		memName		= rs.getString("MEM_NAME");
		memEmail	= rs.getString("EMAIL");
		if (memEmail != null && memEmail.length()>0) {
			tmp			= memEmail.split("@");
			emailId		= tmp[0];
			emailAddr	= tmp[1];
		}
		memHp		= rs.getString("HP");
		if (memHp != null && memHp.length()>10) {
			tmp			= memHp.split("-");
			memHp1		= tmp[0];
			memHp2		= tmp[1];
			memHp3		= tmp[2];
		}	
	}
}

rs.close();
%>

	<script type="text/javascript" src="/common/js/common.js"></script>
</head>
<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div>
	<!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1>1:1����</h1>
			<div class="pageDepth">
				HOME &gt; ������ &gt; <strong>1:1����</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="twelve columns offset-by-one ">
			<div class="row">
				<div class="threefourth last col">
					<ul class="tabNavi">
						<li><a href="notice.jsp">��������</a></li>
						<li><a href="faq.jsp">FAQ</a></li>
						<%if (eslMemberId.equals("")) {%>
						<li><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=600&lightbox[height]=350">1:1����</a></li>
						<%} else {%>
						<li class="active"><a href="indiqna.jsp">1:1����</a></li>
						<%}%>
						<li><a href="service_member.jsp">�̿�ȳ�</a></li>
						<li><a href="presscenter.jsp">��к���</a></li>
					</ul>
					<div class="clear"></div>
				</div>
			</div>
			<div class="row" style="margin-bottom:40px;">
				<div class="threefourth last col">
					<div class="guide qnaImg">
						<ul>
							<li>���� �Ͻñ� ���� <strong class="font-blue">FAQ</strong>�� �����Ͻø� ���� �ö���� ������ �亯�� Ȯ���Ͻ� �� �ֽ��ϴ�.</li>
							<li>������ ���� �Ͻ� ���뿡 ���� �亯�� 24�ð�(������ ����) �̳��� <strong class="font-blue"> 1:1 ���ǰԽ��� > ���� ���ǳ���</strong>�� ���� Ȯ�� �����Ͻʴϴ�.</li>
						</ul>
					</div>
				</div>
			</div>
			<!-- End row -->
			<div class="row" style="margin-bottom:40px;">
				<div class="threefourth last col">


<form name="frm_counsel" method="post" action="indiqna_db.jsp" enctype="multipart/form-data">
<input type="hidden" name="counselID" value="<%=counselID%>" />

<%
if (counselID != null && counselID.length() > 0) {
%>
	<input type="hidden" name="mode" value="mod" />
<%
} else {	
%>
	<input type="hidden" name="mode" value="ins" />
<%
}	
%>




						<table class="inputfield" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<th>�������</th>
								<td>
									<select name="counsel_type" style="width:210px;" required label="�������">
										<option value="">����</option>
										<option value="01"<%if(counsel_type.equals("01")) out.println(" selected");%>>���</option>
										<option value="02"<%if(counsel_type.equals("02")) out.println(" selected");%>>���</option>
										<option value="03"<%if(counsel_type.equals("03")) out.println(" selected");%>>��ǰ�̿�</option>
										<option value="04"<%if(counsel_type.equals("04")) out.println(" selected");%>>�ֹ�����</option>
										<option value="05"<%if(counsel_type.equals("05")) out.println(" selected");%>>���񽺰���</option>
										<option value="09"<%if(counsel_type.equals("09")) out.println(" selected");%>>��Ÿ</option>
									</select>
								</td>
							</tr>
							<tr>
								<th>�ۼ���</th>
								<td><input name="name" type="text" class="ftfd" required label="�ۼ���" value="<%=memName%>" /></td>
							</tr>
							<tr>
								<th>����ó</th>
								<td>
									<select name="hp1" id="hp1" style="width:70px;" required label="����ó">
										<option>����</option>
										<option value="010"<%if(memHp1.equals("010")){out.print(" selected=\"selected\"");}%>>010</option>
									 	<option value="011"<%if(memHp1.equals("011")){out.print(" selected=\"selected\"");}%>>011</option>
									 	<option value="016"<%if(memHp1.equals("016")){out.print(" selected=\"selected\"");}%>>016</option>
									 	<option value="017"<%if(memHp1.equals("017")){out.print(" selected=\"selected\"");}%>>017</option>
									 	<option value="018"<%if(memHp1.equals("018")){out.print(" selected=\"selected\"");}%>>018</option>
									 	<option value="019"<%if(memHp1.equals("019")){out.print(" selected=\"selected\"");}%>>019</option>
									</select>
									-
									<input name="hp2" type="text" class="ftfd" style="width:70px;" maxlength="4" onKeyUp="onlyNum(this);if(this.value.length==4) hp3.focus();" value="<%=memHp2%>" required label="����ó" />
									-
									<input name="hp3" type="text" class="ftfd" style="width:70px;" maxlength="4" onKeyUp="onlyNum(this);if(this.value.length==4) email_id.focus();" value="<%=memHp3%>" required label="����ó" />
								</td>
							</tr>
							<input type="hidden" name="email_id" value="<%=emailId%>" />
							<input type="hidden" name="email_addr" value="<%=emailAddr%>" />
							<!--tr>
								<th>�̸���</th>
								<td>
									<input name="email_id" id="email_id" type="text" class="ftfd" maxlength="19" value="<%=emailId%>" required label="�̸���" />
									@
									<input name="email_addr" id="email_addr" type="text" class="ftfd" maxlength="30" value="<%=emailAddr%>" required label="�̸���" />
									<select name="email_sel" id="email_sel" style="width:100px;" onChange="setEmail()">
										<option value="self"<%if(emailAddr.equals("self")){out.print(" selected=\"selected\"");}%>>�����Է�</option>
										<option value="naver.com"<%if(emailAddr.equals("naver.com")){out.print(" selected=\"selected\"");}%>>naver.com</option>
										<option value="chol.com"<%if(emailAddr.equals("chol.com")){out.print(" selected=\"selected\"");}%>>chol.com</option>
										<option value="dreamwiz.com"<%if(emailAddr.equals("dreamwiz.com")){out.print(" selected=\"selected\"");}%>>dreamwiz.com</option>
										<option value="empal.com"<%if(emailAddr.equals("empal.com")){out.print(" selected=\"selected\"");}%>>empal.com</option>
										<option value="freechal.com"<%if(emailAddr.equals("freechal.com")){out.print(" selected=\"selected\"");}%>>freechal.com</option>
										<option value="gmail.com"<%if(emailAddr.equals("gmail.com")){out.print(" selected=\"selected\"");}%>>gmail.com</option>
										<option value="hanafos.com"<%if(emailAddr.equals("hanafos.com")){out.print(" selected=\"selected\"");}%>>hanafos.com</option>
										<option value="hanmail.net"<%if(emailAddr.equals("hanmail.net")){out.print(" selected=\"selected\"");}%>>hanmail.net</option>
										<option value="hanmir.com"<%if(emailAddr.equals("hanmir.com")){out.print(" selected=\"selected\"");}%>>hanmir.com</option>
										<option value="hitel.net"<%if(emailAddr.equals("hitel.net")){out.print(" selected=\"selected\"");}%>>hitel.net</option>
										<option value="hotmail.com"<%if(emailAddr.equals("hotmail.com")){out.print(" selected=\"selected\"");}%>>hotmail.com</option>
										<option value="korea.com"<%if(emailAddr.equals("korea.com")){out.print(" selected=\"selected\"");}%>>korea.com</option>
										<option value="lycos.co.kr"<%if(emailAddr.equals("lycos.co.kr")){out.print(" selected=\"selected\"");}%>>lycos.co.kr</option>
										<option value="nate.com"<%if(emailAddr.equals("nate.com")){out.print(" selected=\"selected\"");}%>>nate.com</option>
										<option value="netian.com"<%if(emailAddr.equals("netian.com")){out.print(" selected=\"selected\"");}%>>netian.com</option>
										<option value="paran.com"<%if(emailAddr.equals("paran.com")){out.print(" selected=\"selected\"");}%>>paran.com</option>
										<option value="yahoo.com"<%if(emailAddr.equals("yahoo.com")){out.print(" selected=\"selected\"");}%>>yahoo.com</option>
										<option value="yahoo.co.kr"<%if(emailAddr.equals("yahoo.co.kr")){out.print(" selected=\"selected\"");}%>>yahoo.co.kr</option>
									</select>
								</td>
							</tr-->
							<tr>
								<th>��&nbsp;&nbsp;&nbsp;��</th>
								<td><input name="title" type="text" class="ftfd" style="width:98%;" required label="����" value="<%=title%>" /></td>
							</tr>
							<tr>
								<th>��&nbsp;&nbsp;&nbsp;��</th>
								<td><textarea name="content" rows="6" style="width:98%;" required label="����"><%=content%></textarea></td>
							</tr>
							<tr>
								<th>÷������</th>
								<td>
									<div class="customfile-container">
										<input type="file" id="up_file" class="ftfd" name="up_file" multiple />
									</div>
								</td>
							</tr>
						</table>
					</form>
					<!-- End Table -->
				</div>
			</div>
			<!-- End row -->
			<div class="row">
				<div class="threefourth last col">
					<div class="center">

<%
if (counselID != null && counselID.length() > 0) {
	txt_btn = "���� �����ϱ�";
}
else {
	txt_btn = "���� ����ϱ�";
}
%>
						<input onClick="chkForm(document.frm_counsel)" type="button" class="button large dark" value="<%=txt_btn%>" />
					</div>
				</div>
			</div>
		</div>
		<!-- End twelve columns offset-by-one -->
		<div class="sidebar four columns">
			<%@ include file="/common/include/inc-sidecustomer.jsp"%>
		</div>
		<!-- End sidebar four columns -->
		<div class="clear">
		</div>
	</div>
	<!-- End container -->
	<div id="footer">
		<%@ include file="/common/include/inc-footer.jsp"%>
	</div>
	<!-- End footer -->
	<div id="floatMenu">
		<%@ include file="/common/include/inc-floating.jsp"%>
	</div>
	<%@ include file="/common/include/inc-bottompanel.jsp"%>
</div>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>