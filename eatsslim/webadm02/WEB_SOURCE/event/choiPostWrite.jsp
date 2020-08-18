<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-login-check.jsp"%>
<%
String query		= "";
String memName		= "";
String title		= "";
String content		= "";
String category		= "";
String listImg		= "";
String mode			= "write";
int postId			= 0;

query		= "SELECT MEM_NAME FROM ESL_MEMBER WHERE MEM_ID = '"+ eslMemberId +"'";
try {
	rs	= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	memName		= rs.getString("MEM_NAME");
}
rs.close();

if (request.getParameter("id") != null && request.getParameter("id").length() > 0) {
	postId		= Integer.parseInt(request.getParameter("id"));
	mode		= "edit";
}

if (postId > 0) {
	query		= "SELECT TITLE, CONTENT, LIST_IMG, CATEGORY FROM ESL_CHOI_POSTSCRIPT";
	query		+= " WHERE ID = "+ postId +" AND INST_ID = '"+ eslMemberId +"'";
	try {
		rs	= stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	if (rs.next()) {
		title		= rs.getString("TITLE");
		content		= rs.getString("CONTENT");
		listImg		= rs.getString("LIST_IMG");
		category	= rs.getString("CATEGORY");
	}

	if(title.equals("")){
		out.print("<script>history.go(-1);</script>");
		if(true)return;
	}
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta http-equiv="Cache-Control" content="no-cache"/>
	<meta http-equiv="Expires" content="0"/>
	<meta http-equiv="Pragma" content="no-cache"/>
	<meta name="robots" content="noindex,nofollow,noarchive">

	<title>바른 다이어트 잇슬림</title>

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
		font-family:"Nanum Gothic", 나눔 고딕;
		font-size:13px;
	}
	</style>
	<script src="//code.jquery.com/jquery-1.9.1.min.js"></script>
    <!--[if gte IE 9]>
	<style type="text/css">
	.gradient {filter: none;}
	</style>
    <![endif]-->
	<script src="postWrite.js"></script>
</head>
<body onload="mini_editor('/editor/');">
<div id="wrap">
	<div class="container">
		<div class="maintitle">
			<h1>최과장이 쏘는 잇슬림 체험후기</h1>
			<div class="pageDepth"></div>
			<div class="clear"></div>
		</div>
		<div class="sixteen columns offset-by-one">
			<div class="row">
				<div class="one last col">
					<form name="frm" method="post" action="choiPostWrite_db.jsp" enctype="multipart/form-data">
						<input type="hidden" name="id" value="<%=postId%>">
						<input type="hidden" name="inst_id" value="<%=eslMemberId%>">
						<input type="hidden" name="mode" value="<%=mode%>">
						<input type="hidden" name="org_list_img" value="<%=listImg%>" />
						<table class="columWrite1" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<th>작성자</th>
								<td class="td"><%=eslMemberId%></td>
							</tr>
							<tr>
								<th>분류</th>
								<td class="td">
									<select name="category" id="category">
										<option value="">분류선택</option>
										<option value="1"<%if(category.equals("1")){out.print(" selected=\"selected\"");}%>>식사다이어트</option>
										<option value="2"<%if(category.equals("2")){out.print(" selected=\"selected\"");}%>>프로그램다이어트</option>
										<option value="3"<%if(category.equals("3")){out.print(" selected=\"selected\"");}%>>타입별다이어트</option>
									</select>
								</td>
							</tr>
								<tr>
								<th>제목</th>
								<td class="td"><input name="title" type="text" class="ftfd" style="width:98%;" value="<%=title%>" /></td>
							</tr>
							<tr>
								<th>내용</th>
								<td class="td">
									<textarea id="content" name="content" style="height:500px;width:100%;" type=editor><%=content%></textarea>
									<!-- 웹에디터 활성화 스크립트 -->
									<script src="/editor/editor_board.js"></script>
								</td>
							</tr>
							<tr>
								<th>목록이미지</th>
								<td class="td">
									<div class="customfile-container">
										<input type="file" id="list_img" class="ftfd" name="list_img" />
										<%if (!listImg.equals("")) {%>
										<br /><input type="checkbox" name="del_list_img" value="y" />삭제<br />
										<img src="<%=webUploadDir +"board/"+ listImg%>" width="160" height="108" />
										<%}%>
									</div>
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td class="td" align="center" style="padding:30px 0 20px 15px">
									<div class="button large dark"  style="margin:0 10px;"><a href="javascript:postWrite();">등록하기</a></div>
									<div class="button large light"  style="margin:0 10px;"><a href="javascript:;" onclick="self.close();">목록으로</a></div>
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div> <!-- End Row -->
		</div> <!-- End sixteen columns offset-by-one -->
		<div class="clear"></div>
	</div>
</div>
</body>
</html>