<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-login-check.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
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

	<div class="ui-header-fixed ui-shadow" style="overflow:hidden;">
		<%@ include file="/mobile/common/include/inc-header.jsp"%>
	</div>
	<!-- End ui-header -->
	
	<!-- Start Content -->
	<div id="content">

		<h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">������</span></span></h1>
		
		<div class="grid-navi">
			<table class="navi" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><a href="/mobile/customer/notice.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">��������</span></span></a></td>
					<td><a href="/mobile/customer/indiqna.jsp" class="ui-btn ui-btn-inline ui-btn-up-f"><span class="ui-btn-inner"><span class="ui-btn-text">1:1�����ϱ�</span></span><span class="active"></span></a></td>
				</tr>
			</table>
		</div>
		
		<div class="divider"></div>


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


		<div class="row">
			<h2>���Ǳ��м���</h2>
			<ul class="form-line">
				<li>
					<label for="c1"><span></span>�������</label>
					
					<div class="select-box">
						<select name="counsel_type" required label="�������">
							<option value="">����</option>
							<option value="01"<%if(counsel_type.equals("01")) out.println(" selected");%>>��ȯ/ȯ��</option>
							<option value="02"<%if(counsel_type.equals("02")) out.println(" selected");%>>ȸ������</option>
							<option value="03"<%if(counsel_type.equals("03")) out.println(" selected");%>>��������</option>
							<option value="04"<%if(counsel_type.equals("04")) out.println(" selected");%>>��۰���</option>
							<option value="09"<%if(counsel_type.equals("09")) out.println(" selected");%>>��Ÿ</option>
						</select>
					</div>
					
					<div class="clear"></div>
				</li>
			</ul>
			
			<div class="divider"></div>
			
			<h2>���ǳ���</h2>
			<ul class="form-line">
				<li><label>�ۼ���</label><input name="name" type="text" required label="�ۼ���" value="<%=memName%>" /></li>
				<li><label>����ó</label><input name="hp" type="text" required label="����ó" value="<%=memHp%>" /></li>
				<li><label>�̸���</label><input name="email" type="text" required label="�̸���" value="<%=memEmail%>" /></li>
				<li><label>����</label><input name="title" type="text" required label="����" value="<%=title%>" /></li>
				<li>
					<label style="display:block">����</label>
					<textarea name="content" rows="5" id="textarea" required label="����"><%=content%></textarea>
				</li>
			</ul>
		</div>

<%
if (counselID != null && counselID.length() > 0) {
	txt_btn = "�����ϱ�";
}
else {
	txt_btn = "�����ϱ�";
}
%>

		<div class="grid-navi">
			<table class="navi" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><a href="javascript:;" class="ui-btn ui-btn-inline ui-btn-up-d" onClick="chkForm(document.frm_counsel)"><span class="ui-btn-inner"><span class="ui-btn-text"><%=txt_btn%></span></span></a></td>
					<!--td><a href="/mobile/customer/indiqna.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">���</span></span></a></td-->
				</tr>
			</table>
		</div>


</form>


	</div>
	<!-- End Content -->
	
	<div class="ui-footer">
        <%@ include file="/mobile/common/include/inc-footer.jsp"%>
    </div>

</div>

</body>
</html>