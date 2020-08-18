<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-login-check.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta http-equiv="Cache-Control" content="no-cache"/>
	<meta http-equiv="Expires" content="0"/>
	<meta http-equiv="Pragma" content="no-cache"/>
	<meta name="robots" content="noindex,nofollow,noarchive">

	<title>�ٸ� ���̾�Ʈ �ս���</title>

	<link rel="stylesheet" type="text/css" media="all" href="/common/css/layout.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/common/css/skeleton.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/common/css/color-theme.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/common/css/jquery-ui.css" />
    <link rel="stylesheet" type="text/css" media="all" href="/common/css/jquery.selectBox.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/common/css/jquery.lightbox.css" />
    <link rel="stylesheet" type="text/css" media="print" href="/common/css/print.css" />
<style>
table.columWrite1 {
	background:#F9F9F9;
	border-top:1px solid #DDD;
	border-bottom:1px solid #DDD;
	border-left:1px solid #DDD;
}
table.columWrite1 th {
	border-right:1px solid #DDD;
	text-align:center;
	font-size:14px;
}
table.columWrite1 .td {
	border-right:1px solid #DDD;
	padding:10px 10px 10px 20px;
	text-align:left;
}
table.columWrite1 input.ftfd {
	padding:4px 3px;
	border:1px solid #DDDDDD;
}
table.columWrite1 textarea {
	padding:3px;
	border:1px solid #DDDDDD;
	font-family:"Nanum Gothic", ���� ���;
	font-size:13px;
}
</style>


	<script src="//code.jquery.com/jquery-1.9.1.min.js"></script>

    <!--[if gte IE 9]>
	<style type="text/css">
	.gradient {filter: none;}
	</style>
    <![endif]-->



<%
String query		= "";
String memName		= "";
String memEmail		= "";
String emailId		= "";
String emailAddr	= "";
String memHp		= "";
String memHp1		= "";
String memHp2		= "";
String memHp3		= "";
String[] tmp		= new String[]{};

String title = "";
String content = "";
String pressUrl = "";
String listImg			= "";
String mode = "write";
String param			= "";
String keyword			= "";
String iPage			= ut.inject(request.getParameter("page"));
String pgsize			= ut.inject(request.getParameter("pgsize"));
String schCate			= ut.inject(request.getParameter("sch_cate"));
String field			= ut.inject(request.getParameter("field"));
int noticeId		= 0;


query		= "SELECT MEM_NAME, EMAIL, HP FROM ESL_MEMBER WHERE MEM_ID = '"+ eslMemberId +"'";
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
rs.close();


if (request.getParameter("keyword") != null) {
	keyword					= ut.inject(request.getParameter("keyword"));
	keyword					= new String(keyword.getBytes("8859_1"), "EUC-KR");
}
param			= "page="+ iPage +"&pgsize="+ pgsize +"&field="+ field +"&keyword="+ keyword;


if (request.getParameter("id") != null && request.getParameter("id").length() > 0) {
	noticeId	= Integer.parseInt(request.getParameter("id"));
	mode = "edit";
}

	if(noticeId > 0){
		query		= "SELECT * FROM ESL_PO WHERE ID="+noticeId+" and INST_ID = '"+ eslMemberId +"'";
		try {
			rs			= stmt.executeQuery(query);
		} catch(Exception e) {
			//out.println(e+"=>"+query);
			if(true)return;
		}

		if (rs.next()) {

			title = rs.getString("title");
			content = rs.getString("content");
			listImg			= rs.getString("LIST_IMG");
			pressUrl			= rs.getString("PRESS_URL");
		}

		if(title.equals("")){
			out.print("<script>history.go(-1);</script>");
			if(true)return;
		}
	}
%>


<script src="postWrite.js"></script>

</head>
<body onload="mini_editor('/editor/');">
<div id="wrap">

	<div class="container">
		<div class="maintitle">
			<h1>
				���̾�Ʈ ü���ı�
			</h1>
			<div class="pageDepth">
				
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="sixteen columns offset-by-one">
            <div class="row">
                <div class="one last  col">
                  <form name="frm" method="post" action="postWritePopup_db.jsp" enctype="multipart/form-data">
				  <input type="hidden" name="id" value="<%=noticeId%>">
				  <input type="hidden" name="inst_id" value="<%=eslMemberId%>">
				  <input type="hidden" name="mode" value="<%=mode%>">
					<input type="hidden" name="param" value="<%=param%>" />
					<input type="hidden" name="org_list_img" value="<%=listImg%>" />
					<table class="columWrite1" width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <th>�ۼ���</th>
                        <td class="td"><%=eslMemberId%></td>
                      </tr>
                      <tr>
                        <th>�з�</th>
                        <td class="td">
							<select name="press_url" id="press_url">
								<option value="">�з�����</option>
								<option value="4"<%if(pressUrl.equals("4")){out.print(" selected");}%>>�̺�Ʈ�ı�</option>
								<option value="1"<%if(pressUrl.equals("1")){out.print(" selected");}%>>�Ļ���̾�Ʈ</option>
								<option value="2"<%if(pressUrl.equals("2")){out.print(" selected");}%>>���α׷����̾�Ʈ</option>
								<option value="3"<%if(pressUrl.equals("3")){out.print(" selected");}%>>Ÿ�Ժ����̾�Ʈ</option>
							</select>				
						</td>
                      </tr>

                      <tr>
                        <th>����</th>
                        <td class="td"><input name="title" type="text" class="ftfd" style="width:98%;" value="<%=title%>"></td>
                      </tr>
                      <tr>
                        <th>����</th>
                        <td class="td">
							<textarea id="content" name="content" style="height:500px;width:100%;" type=editor><%=content%></textarea>
							<!-- �������� Ȱ��ȭ ��ũ��Ʈ -->
							<script src="/editor/editor_board.js"></script>
							<script>
							
							</script>

						<!--
									<FCK:editor id="content" basePath="/FCKeditor/"
									width="600"
									height="400"
									toolbarSet="Eatsslim"
									customConfigurationsPath="/FCKeditor/fckconfig.js">	
									<%=content%>
									</FCK:editor>	-->	
						</td>
                      </tr>
                      <tr>
                        <th>����̹���</th>
                        <td class="td">
                        <div class="customfile-container">
							<input type="file" id="list_img" class="ftfd" name="list_img" />

							<%if (!listImg.equals("")) {%>
								<br /><input type="checkbox" name="del_list_img" value="y" />����<br />
								<img src="<%=webUploadDir +"board/"+ listImg%>" width="160" height="108" />
							<%}%>
						</div>
                         <!-- <p>����.jpg <input name="" type="checkbox" value=""> <a href="#">����</a></p>
                         <p class="font-gray">5Mbyte �̸��� jpg, gif ���ϸ� �����ϸ� ���� 201px�� �ڵ� �����˴ϴ�.</p> -->
                        </td>
                      </tr>
                      <tr>
                        <td>&nbsp;</td>
                        <td class="td" align="center" style="padding:30px 0 20px 15px">
                            <div class="button large dark"  style="margin:0 10px;"><a href="javascript:postWrite();">����ϱ�</a></div>
                            <div class="button large light"  style="margin:0 10px;"><a href="javascript:;" onclick="self.close();">�������</a></div>
                        </td>
                      </tr>
                  </table>
                  </form>
                </div>
            </div>
            <!-- End Row -->
		</div>
		<!-- End sixteen columns offset-by-one -->
		<div class="clear">
		</div>
	</div>

</div>
</body>
</html>