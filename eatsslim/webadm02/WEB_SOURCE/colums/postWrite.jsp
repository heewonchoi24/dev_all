<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-login-check.jsp"%>
<%@ taglib uri="/WEB-INF/FCKeditor.tld" prefix="FCK" %>
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

	<script src="//code.jquery.com/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="/common/js/jquery.mousewheel.js"></script>
	<script type="text/javascript" src="/common/js/jquery.cycle.js"></script>
	<!-- 주문수량 Spinner -->
	<script type="text/javascript" src="/common/js/jquery.ui.widget.js"></script>
	<script type="text/javascript" src="/common/js/jquery.ui.button.js"></script>
	<!-- Lightbox -->
	<script type="text/javascript" src="/common/js/jquery.lightbox.js"></script>
	<!-- Bottom Panel -->
	<script type="text/javascript" src="/common/js/jquery.slidedrawer.js"></script>
	<script type="text/javascript" src="/common/js/jquery.selectBox.js"></script>
	<script type="text/javascript" src="/common/js/eatsslim2.js"></script>
	<script type="text/javascript" src="/common/js/util.js"></script>
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
<script type="text/javascript" src="/esl_admin/js/common.js"></script>
</head>
<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div> <!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1>
				다이어트 체험후기
			</h1>
			<div class="pageDepth">
				HOME > GO! 다이어트 > <strong>다이어트 체험후기</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="sixteen columns offset-by-one">
            <div class="row">
                <div class="one last  col">
                  <form name="frm" method="post" action="postWrite_db.jsp" enctype="multipart/form-data">
				  <input type="hidden" name="id" value="<%=noticeId%>">
				  <input type="hidden" name="inst_id" value="<%=eslMemberId%>">
				  <input type="hidden" name="mode" value="<%=mode%>">
					<input type="hidden" name="param" value="<%=param%>" />
					<input type="hidden" name="org_list_img" value="<%=listImg%>" />
					<table class="columWrite" width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <th>작성자</th>
                        <td><%=eslMemberId%></td>
                      </tr>
                      <tr>
                        <th>분류</th>
                        <td>
							<select name="press_url" id="press_url">
								<option value="">분류선택</option>
								<option value="4">이벤트후기</option>
								<option value="1">식사다이어트</option>
								<option value="2">프로그램다이어트</option>
								<option value="3">타입별다이어트</option>
							</select>				
						</td>
                      </tr>
					<script>$("#press_url").val('<%=pressUrl%>');</script>
                      <tr>
                        <th>제목</th>
                        <td><input name="title" type="text" class="ftfd" style="width:98%;" value="<%=title%>"></td>
                      </tr>
                      <tr>
                        <th>내용</th>
                        <td>
							<!--
							<textarea id="content" name="content" style="width:98%;height:100%" type=editor><%=content%></textarea>							
							<script src="/editor/editor_board.js"></script>
							<script>
							mini_editor("/editor/");
							</script>
							-->

						
									<FCK:editor id="content" basePath="/FCKeditor/"
									width="600"
									height="400"
									toolbarSet="Eatsslim"
									customConfigurationsPath="/FCKeditor/fckconfig.js">	
									<%=content%>
									</FCK:editor>
						</td>
                      </tr>
                      <tr>
                        <th>목록이미지</th>
                        <td>
                        <div class="customfile-container">
							<input type="file" id="list_img" class="ftfd" name="list_img" />

							<%if (!listImg.equals("")) {%>
								<br /><input type="checkbox" name="del_list_img" value="y" />삭제<br />
								<img src="<%=webUploadDir +"board/"+ listImg%>" width="160" height="108" />
							<%}%>
						</div>
                         <!-- <p>사진.jpg <input name="" type="checkbox" value=""> <a href="#">삭제</a></p>
                         <p class="font-gray">5Mbyte 미만의 jpg, gif 파일만 가능하며 가로 201px로 자동 조절됩니다.</p> -->
                        </td>
                      </tr>
                      <tr>
                        <td>&nbsp;</td>
                        <td align="center" style="padding:30px 0 20px 15px">
                            <div class="button large dark"  style="margin:0 10px;"><a href="javascript:postWrite();">등록하기</a></div>
                            <div class="button large light"  style="margin:0 10px;"><a href="postScript.jsp?<%=param%>">목록으로</a></div>
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
	<!-- End container -->
	<div id="footer">		
		<%@ include file="/common/include/inc-footer.jsp"%>
	</div> <!-- End footer -->
	<div id="floatMenu">
		<%@ include file="/common/include/inc-floating.jsp"%>
	</div>
</div>
</body>
</html>