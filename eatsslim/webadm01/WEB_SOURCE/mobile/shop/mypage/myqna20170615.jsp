<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-login-check.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%
String table		= "ESL_COUNSEL";
String query		= "";
String field		= ut.inject(request.getParameter("field"));
String keyword		= ut.inject(request.getParameter("keyword"));
String where		= "";
String param		= "";
String counselType	= "";
String title		= "";
String content		= "";
String instDate		= "";
String answerYn		= "";
String answerYnTxt	= "";
String answer		= "";
String answerDate	= "";
String counselID	= "";
String btnMod		= "";
String btnDel		= "";
String upFile		= "";
String imgUrl		= "";

///////////////////////////
int pgsize		= 10; //�������� �Խù� ��
int pagelist	= 10; //ȭ��� ������ ��
int iPage;			  // ���������� ��ȣ
int startpage;		  // ���� ������ ��ȣ
int endpage		= 0;
int totalPage	= 0;
int intTotalCnt	= 0;
int number;
int step		= 0;
int curNum		= 0;

where			= " WHERE MEMBER_ID = '"+ eslMemberId +"'";

if (request.getParameter("page") != null && request.getParameter("page").length()>0){
	iPage		= Integer.parseInt(request.getParameter("page"));
	startpage	= ((int)(iPage-1) / pagelist) * pagelist + 1;
}else{
	iPage		= 1;
	startpage	= 1;
}
if (request.getParameter("pgsize") != null && request.getParameter("pgsize").length()>0)
	pgsize		= Integer.parseInt(request.getParameter("pgsize"));

if (field != null && field.length() > 0 && keyword != null && keyword.length() > 0) {
	keyword		= new String(keyword.getBytes("8859_1"), "EUC-KR");
	param		+= "&amp;field="+ field +"&amp;keyword="+ keyword;
	where		+= " AND "+ field +" LIKE '%"+ keyword +"%'";
}

query		= "SELECT COUNT(ID) FROM "+ table + where; //out.print(query1); if(true)return;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
if (rs.next()) {
	intTotalCnt = rs.getInt(1); //�� ���ڵ� ��
}
if (rs != null) try { rs.close(); } catch (Exception e) {}
if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}

totalPage	= (int)(Math.ceil((float)intTotalCnt/pgsize)); // �� ������ ��
endpage		= startpage + pagelist - 1;
if (endpage > totalPage) {
	endpage = totalPage;
}
curNum		= intTotalCnt-pgsize*(iPage-1);
param		+= "&amp;pgsize=" + pgsize;

query		= "SELECT ID, COUNSEL_TYPE, TITLE, CONTENT, DATE_FORMAT(INST_DATE, '%Y.%m.%d') INST_DATE, UP_FILE, ";
query		+= "	ANSWER_YN, ANSWER, DATE_FORMAT(ANSWER_DATE, '%Y-%m-%d') ANSWER_DATE";
query		+= " FROM "+ table + where;
query		+= " ORDER BY ID DESC";
query		+= " LIMIT "+String.valueOf((iPage-1) * pgsize)+", "+String.valueOf(pgsize); //out.print(query); if(true)return;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
///////////////////////////
%>

<script>
$(function() {
	$( "#accordion" ).accordion({
		collapsible: true
	});
});


function confDel(counselID) {
	var msg = "������ �����Ͻðڽ��ϱ�? ���� �� ������ �� �����ϴ�."
	if(confirm(msg)){
		location.href = "/mobile/customer/indiqna_del_db.jsp?counselID="+ counselID +"&mode=del";
	}else{
		return;
	}
}
</script>

</head>
<body>
<div id="wrap">
    <div class="ui-header-fixed ui-shadow" style="overflow:hidden;">
       <%@ include file="/mobile/common/include/inc-header.jsp"%>
    </div>
    <!-- End ui-header -->
    <!-- Start Content -->
    <div id="content" class="oldClass">
        <h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">1:1 ����</span></span></h1>
            <div class="grid-navi">
            <table class="navi" border="0" cellspacing="10" cellpadding="0">
               <tr>
                 <td><a href="/mobile/customer/indiqna.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">1:1 �����ϱ�</span></span></a></td>
               </tr>
           </table>
           </div>
            <ul class="guide">
                <li>* 1:1 ���� ��ư�� Ŭ���Ͻþ� ������ �ֽø� ���� �ð����� �亯�帮���� �ϰڽ��ϴ�.</li>
                <!-- <li>* ��ϵ� ���ǻ����� �亯�� �Ϸ�Ǳ� ������ ������ �����մϴ�.</li> -->
            </ul>
            <div class="divider"></div>

            <div id="accordion" class="row">

<%
if (intTotalCnt > 0) {
	while (rs.next()) {
		counselID		= rs.getString("ID");
		counselType		= rs.getString("COUNSEL_TYPE");
		title			= rs.getString("TITLE");
		content			= ut.nl2br(rs.getString("CONTENT"));
		instDate		= rs.getString("INST_DATE");
		answerYn		= rs.getString("ANSWER_YN");
		upFile			= ut.isnull(rs.getString("UP_FILE"));
		if (upFile.equals("") || upFile == null) {
			imgUrl		= "";
		} else {
			imgUrl		= "<img src='"+ webUploadDir +"board/"+ upFile + "' width='100%' />";
		}

		if (answerYn.equals("Y")) {
			answerYnTxt		= "�亯�Ϸ�";
			answer			= ut.nl2br(rs.getString("ANSWER"));
			answerDate		= rs.getString("ANSWER_DATE");
			btnMod = "";
			btnDel = "";
		} else {
			answerYnTxt		= "�̴亯";
			answer			= "";
			answerDate		= "";
			btnMod = "<a href='/mobile/customer/indiqna.jsp?counselID="+ counselID +"' class='ui-btn ui-mini ui-btn-inline ui-btn-up-c'><span class='ui-btn-inner'><span class='ui-btn-text'>����</span></span></a>";
			btnDel = "<a href=\"javascript:confDel('"+ counselID +"');\" class='ui-btn ui-mini ui-btn-inline ui-btn-up-c'><span class='ui-btn-inner'><span class='ui-btn-text'>����</span></span></a>";
		}
%>
                <h3><b>Q</b><%=title%><div class="meta"><%=instDate%> <b>[<%=answerYnTxt%>]</b></div></h3>
                <div>
					<%=imgUrl%>
                    <p><%=content%></p>
					<div style="text-align:right;">
						<%=btnMod%>
						<%=btnDel%>
					</div>
                    <p class="answer">
						<span class="mark" style="float:left;">A</span>
						&nbsp;
						<%=answer%>
					</p>
                </div>

<%
	}
} else {
%>
				<div class="none">��ϵ� 1:1 ���ǰ� �����ϴ�.</div>
<%
}
%>

            </div>

            <!--
			<div class="grid-navi">
                <table class="navi" border="0" cellspacing="10" cellpadding="0">
                   <tr>
                     <td><a href="#" class="ui-btn ui-btn-inline ui-btn-up-d"><span class="ui-btn-inner"><span class="ui-btn-text">�����ϱ�</span></span></a></td>
                     <td><a href="#" class="ui-btn ui-btn-inline ui-btn-up-d"><span class="ui-btn-inner"><span class="ui-btn-text">�����ϱ�</span></span></a></td>
                   </tr>
                </table>
            </div>
			-->

    </div>
    <!-- End Content -->
    <div class="ui-footer">
        <%@ include file="/mobile/common/include/inc-footer.jsp"%>
    </div>
</div>
</body>
</html>