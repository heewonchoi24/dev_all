<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%viewPage	= true;%>
<%@ taglib uri="/WEB-INF/FCKeditor.tld" prefix="FCK" %>
<%@ include file="../include/inc-top.jsp"%>
<%@ include file="../lib/dbconn_tbr.jsp"%>
<script type="text/javascript" src="/smarteditor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="/smarteditor/quick_photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js" charset="utf-8"> </script>

<%
request.setCharacterEncoding("euc-kr");

int counselId				= 0;
String query			= "";
String member_id		= "";
String counsel_type		= "";
String name				= "";
String hp				= "";
String email			= "";
String title			= "";
String content			= "";
String listImg			= "";
String inst_ip			= "";
String wdate			= "";
String answer_yn		= "";
String answer			= "";
String answer_id		= "";
String param			= "";
String keyword			= "";
String iPage			= ut.inject(request.getParameter("page"));
String pgsize			= ut.inject(request.getParameter("pgsize"));
String schCate			= ut.inject(request.getParameter("sch_cate"));
String field			= ut.inject(request.getParameter("field"));
String ecs_cate1		= "";
String ecs_cate2		= "";
String ecs_cate3		= "";
String cateOpt1			="<option value=''>==1차선택==</option>";
String cateOpt2			="<option value=''>==2차선택==</option>";
String cateOpt3			="<option value=''>==3차선택==</option>";
String userIp			= request.getRemoteAddr();
if (request.getParameter("keyword") != null) {
	keyword					= ut.inject(request.getParameter("keyword"));
	keyword					= new String(keyword.getBytes("8859_1"), "EUC-KR");
}
param			= "page="+ iPage +"&pgsize="+ pgsize +"&field="+ field +"&keyword="+ keyword;

if (request.getParameter("id") != null && request.getParameter("id").length() > 0) {
	counselId	= Integer.parseInt(request.getParameter("id"));

	query		= "SELECT MEMBER_ID, COUNSEL_TYPE, NAME, HP, EMAIL, TITLE, CONTENT, UP_FILE, INST_IP,";
	query		+= "	DATE_FORMAT(INST_DATE, '%Y.%m.%d %H:%i') WDATE, ANSWER_YN, ANSWER, ANSWER_ID,";
	query		+= "	ECS_CATE1, ECS_CATE2, ECS_CATE3 ";
	query		+= " FROM ESL_COUNSEL";
	query		+= " WHERE ID = ?";
	pstmt		= conn.prepareStatement(query);
	pstmt.setInt(1, counselId);
	rs			= pstmt.executeQuery();

	if (rs.next()) {
		member_id		= rs.getString("MEMBER_ID");
		counsel_type	= rs.getString("COUNSEL_TYPE");
		name			= rs.getString("NAME");
		hp				= rs.getString("HP");
		email			= rs.getString("EMAIL");
		title			= rs.getString("TITLE");
		content			= rs.getString("CONTENT");
		listImg			= ut.isnull(rs.getString("UP_FILE"));
		inst_ip			= rs.getString("INST_IP");
		wdate			= rs.getString("WDATE");
		answer_yn		= rs.getString("ANSWER_YN");
		answer			= (rs.getString("ANSWER") == null)? "" : rs.getString("ANSWER");
		ecs_cate1		= rs.getString("ECS_CATE1");
		ecs_cate2		= rs.getString("ECS_CATE2");
		ecs_cate3		= rs.getString("ECS_CATE3");
		
		
		
		//========1차
		query="select code, codename from V_CLAIM_GB where CODE_LEVEL = 1 and use_yn = 'Y'";
		try{rs_tbr = stmt_tbr.executeQuery(query);}catch(Exception e){out.println(e+"=>"+query);if(true)return;}
		while(rs_tbr.next()){
			if (ecs_cate1.equals(rs_tbr.getString("code")))
				cateOpt1+="<option value='"+rs_tbr.getString("code")+"' selected>"+rs_tbr.getString("codename")+"</option>";
			else
				cateOpt1+="<option value='"+rs_tbr.getString("code")+"'>"+rs_tbr.getString("codename")+"</option>";
		}

		//========2차
		query="select code, codename from V_CLAIM_GB where CODE_LEVEL = 2 and parentcode='"+ecs_cate1+"' and USE_YN = 'Y' order by code asc";
		//query="select code,catnm from gd_category_inquiry where length(code)=6 and code like '"+rs.getString("code").substring(0,3)+"%'";
		try{rs_tbr = stmt_tbr.executeQuery(query);}catch(Exception e){out.println(e+"=>"+query);if(true)return;}
		while(rs_tbr.next()){
			if (ecs_cate2.equals(rs_tbr.getString("code")))
				cateOpt2+="<option value='"+rs_tbr.getString("code")+"' selected>"+rs_tbr.getString("codename")+"</option>";
			else
				cateOpt2+="<option value='"+rs_tbr.getString("code")+"'>"+rs_tbr.getString("codename")+"</option>";
		}

		//========3차
		//query="select code,catnm from gd_category_inquiry where length(code)=9 and code like '"+rs.getString("code").substring(0,6)+"%'";
		query="select code, codename from V_CLAIM_GB where CODE_LEVEL = 3 and parentcode='"+ecs_cate1+"' and PARENTCODE2 = '"+ecs_cate2+"' and USE_YN = 'Y' order by code asc";
		try{rs_tbr = stmt_tbr.executeQuery(query);}catch(Exception e){out.println(e+"=>"+query);if(true)return;}
		while(rs_tbr.next()){
			if (ecs_cate3.equals(rs_tbr.getString("code")))
				cateOpt3+="<option value='"+rs_tbr.getString("code")+"' selected>"+rs_tbr.getString("codename")+"</option>";
			else
				cateOpt3+="<option value='"+rs_tbr.getString("code")+"'>"+rs_tbr.getString("codename")+"</option>";
		}
		
	}
	
	query		= "INSERT INTO ESL_PRIVACY_LOG";
	query		+= "	(WORK_ID, HOST_IP, WORK_CATE1, WORK_CATE2, WORK_URL, WORK_CUST_ID, WORK_ORDER_NUM, WORK_DATE)";
	query		+= " VALUES";
	query		+= "	('"+ eslAdminId +"', '"+ userIp +"',  '상담/문의관리', '1:1문의', '/esl_admin/counsel/counsel_list.jsp', '"+member_id+"', '"+counselId+"', NOW())";
	try {
		stmt.executeUpdate(query);
	} catch(Exception e) {
		out.println(e);
		if(true)return;
	}	
	
} else {
	ut.jsBack(out);
	if (true) return;
}
%>

	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:1,level_2:4,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
	})
	//]]>
	</script>
	

<script type="text/javascript">
function readData(obj,dvLevel){
	var sLists="",arrRegion="",ddlRegion="",arrTmp="",url;
	var lat,lng,zoom,code,pcode;
	var xmlhttp;


	var oOption = document.createElement("OPTION");
	oOption.value = "";
	if(dvLevel==1){
		ddlRegion=document.getElementById("ecs_type2");
		oOption.text = "==2차선택==";
		for (i = document.getElementById("ecs_type3").length; i >= 0; i--){document.getElementById("ecs_type3").remove(i);}
		initOption(document.getElementById("ecs_type3"));

	}else if(dvLevel==2){
		ddlRegion=document.getElementById("ecs_type3");
		oOption.text = "==3차선택==";
		
		if (document.getElementById("ecs_type1").options[document.getElementById("ecs_type1").selectedIndex].value) {
			pcode=document.getElementById("ecs_type1").options[document.getElementById("ecs_type1").selectedIndex].value;
		}
	}
	
	if(obj.options[obj.selectedIndex].value){
		code=obj.options[obj.selectedIndex].value;
	}

	if(dvLevel != "4"){ 
		if(window.XMLHttpRequest) {
			xmlhttp = new XMLHttpRequest();
		} else {
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		url="./getCategory_ecs.jsp?dvLevel="+dvLevel+"&code="+code+"&pcode="+pcode;
		//alert(url);
		xmlhttp.open("GET",url, false);
		xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded : text/xml;charset=utf-8");
		xmlhttp.send(null);
		sLists=trim(xmlhttp.responseText);	
		arrRegion = sLists.split("@");
		//alert(sLists);return;
		//alert(arrRegion.length);
		for (i = ddlRegion.length; i >= 0; i--){
			ddlRegion.remove(i);
		}	
		if(arrRegion.length<2){
			oOption.text="==========";
		}
		ddlRegion.add(oOption);
		for (i=0;i<arrRegion.length-1;i++){
				var e1 = document.createElement("OPTION");
				arrTmp=arrRegion[i].split("|");			
				e1.text = trim(arrTmp[1]);
				e1.value =  trim(arrTmp[0]);
				ddlRegion.add(e1);
				//alert(arrTmp[0]);
		}
	}

}

function initOption(obj){
	var oOption = document.createElement("OPTION");
	oOption.text = "==========";;
	oOption.value = "";
	obj.add(oOption);
}

</script>
	
	
</head>
<body>
<!-- wrap -->
<div id="wrap">
	<%@ include file="../include/inc-header.jsp" %>
	<!-- container -->
	<div id="container" class="group">
		<%@ include file="../include/inc-sidebar-counsel.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 상담/문의관리 &gt; <strong>1:1 문의</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form name="frm_edit" id="frm_edit" method="post" action="counsel_db.jsp" enctype="multipart/form-data">
					<input type="hidden" name="mode" value="upd" />
					<input type="hidden" name="id" value="<%=counselId%>" />
					<input type="hidden" name="param" value="<%=param%>" />
					<input type="hidden" name="org_list_img" value="<%=listImg%>" />
					<table class="tableView" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<!--tr>
								<th scope="row"><span>상담유형</span></th>
								<td>
									<select name="counsel_type" style="width:230px;" required label="상담유형">
										<option value="01"<%if(counsel_type.equals("01")) out.println(" selected");%>>기업(이벤트, 쿠폰문의)</option>
										<option value="02"<%if(counsel_type.equals("02")) out.println(" selected");%>>유통문의(배송일 변경, 환불, 배송문의)</option>
										<option value="03"<%if(counsel_type.equals("03")) out.println(" selected");%>>유통불만(배송관련불만)</option>
										<option value="04"<%if(counsel_type.equals("04")) out.println(" selected");%>>제품문의(제품관련 문의)</option>
										<option value="05"<%if(counsel_type.equals("05")) out.println(" selected");%>>제품불만(제품이용불만)</option>
										<option value="09"<%if(counsel_type.equals("09")) out.println(" selected");%>>기타</option>
									</select>
								</td>
							</tr-->
							<tr>
								<th scope="row"><span>상담유형</span></th>
								<td>
									<select id="ecs_type1" name="ecs_type1" style="width:150px;" required label="상담유형1" onchange="readData(this,1)">
										<%=cateOpt1%>
									</select>
									<select id="ecs_type2" name="ecs_type2" style="width:150px;" required label="상담유형2" onchange="readData(this,2)">
										<%=cateOpt2%>
									</select>
									<select id="ecs_type3" name="ecs_type3" style="width:150px;" required label="상담유형3" >
										<%=cateOpt3%>
									</select>									
								</td>
							</tr>							
							<tr>
								<th scope="row"><span>작성자아이디</span></th>
								<td>
									<%=member_id%>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>작성자</span></th>
								<td>
									<input type="text" name="name" id="name" required label="작성자" class="input1" style="width:100px;" maxlength="10" value="<%=name%>" readonly />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>연락처</span></th>
								<td>
									<input type="text" name="hp" id="name" required label="연락처" class="input1" style="width:100px;" maxlength="10" value="<%=hp%>" readonly />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>이메일</span></th>
								<td>
									<input type="text" name="email" id="name" required label="이메일" class="input1" style="width:400px;" maxlength="10" value="<%=email%>" readonly />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>제목</span></th>
								<td>
									<input type="text" name="title" id="title" required label="제목" class="input1" style="width:400px;" maxlength="100" value="<%=title%>" readonly />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>내용</span></th>
								<td><textarea name="content" rows="6" style="width:600px;" required label="내용" readonly><%=content%></textarea></td>
							</tr>
							<tr>
								<th scope="row"><span>첨부파일</span></th>
								<td colspan="3">
									<%if (!listImg.equals("") || listImg != null) {%>
										<a href="<%=webUploadDir +"board/"+ listImg%>" target="_blank"><%=listImg%></a>
										<!-- <img src="<%=webUploadDir +"board/"+ listImg%>" width="160" height="108" /> -->
									<%}%>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>작성자IP</span></th>
								<td>
									<%=inst_ip%>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>작성일</span></th>
								<td>
									<%=wdate%>
								</td>
							</tr>
							<tr>
								<td colspan="2" height="1" bgcolor="#dfdfdf"></td>
							</tr>
							<tr>
								<th scope="row"><span>답변</span></th>
								<td>
                                   <form id="f_content" name="f_content" method="post">
                                        <textarea name="answer" id="answer" style="height:500px;width:100%;">                 
									<%
										if (answer.equals("") || answer == null) {
												out.print("안녕하세요. 고객님.<br>건강하고 맛있는 풀무원 잇슬림입니다.<br><br><br>");

												out.print("감사합니다.<br>풀무원 잇슬림 담당자 드림.<br>");												
												out.print("<TABLE border=1 styele='vertical-align:center'><TBODY><TR><TD style='BACKGROUND-COLOR: blue'><FONT style='FONT-SIZE: 20px; COLOR: white'><B>&nbsp;&nbsp;!!카카오톡 모바일고객센터 오픈!!&nbsp;&nbsp;</B></FONT></TD></TR></TBODY></TABLE><br>");
												out.print("[이용방법]<br>");
												out.print("1.카카오톡 플러스 친구에서 '풀무원 잇슬림' 옐로우아이디 친구 추가<br>");
												out.print("<img src='http://www.eatsslim.co.kr/images/kakaoplus.jpg'/><br/><br/>");
												out.print("[인증방식]<br>");
												out.print("1.잇슬림 몰 주문 : 휴대폰번호 + 인증문자(4자리 숫자) + 이름으로 인증합니다.<br>");
												out.print("2.외부쇼핑몰 주문 : 티몬, 풀무원샵 등 외부쇼핑몰에서 구매한 경우 외부쇼핑몰 주문번호를 입력하여 인증합니다.<br><br>");
												out.print(" [모바일 고객센터 기능]<br>");
												out.print("1.배송정보 조회 및 스케쥴 변경<br>");
												out.print("2.문의하기<br><br>");												
										} else {
											out.print(answer);
										}										
									%>
										</textarea>
									</form>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btn_center">
						<a href="javascript:;" onclick="submitContents()" class="function_btn"><span>수정</span></a>
						<a href="counsel_list.jsp?<%=param%>" class="function_btn"><span>목록</span></a>
					</div>
				</form>
			</div>
			<!-- //contents -->
		</div>
		<!-- //incon -->
	</div>
	<!-- //container -->
</div>
<!-- //wrap -->

<!-- smart editor 2.0 -->
<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
    oAppRef: oEditors,
    elPlaceHolder: "answer",
    sSkinURI: "/smarteditor/SmartEditor2Skin.html",
    fCreator: "createSEditor2",
    // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
    bUseToolbar : true,           
    // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
    bUseVerticalResizer : true,   
    // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
    bUseModeChanger : true
});
// ‘저장’ 버튼을 누르는 등 저장을 위한 액션을 했을 때 submitContents가 호출된다고 가정한다.
function submitContents() {
    oEditors.getById["answer"].exec("UPDATE_CONTENTS_FIELD", []);
    if($("#ecs_type1").val() == ""){
        alert("[상담유형1] 필수 입력 사항입니다");
        $("#ecs_type1").focus();
        return false;
    }
    if($("#ecs_type2").val() == ""){
        alert("[상담유형2] 필수 입력 사항입니다");
        $("#ecs_type2").focus();
        return false;
    }
    if($("#ecs_type3").val() == ""){
        alert("[상담유형3] 필수 입력 사항입니다");
        $("#ecs_type3").focus();
        return false;
    }
	if(confirm('수정 하시겠습니까?') ){
        document.frm_edit.submit();
        var forms = document.f_content;
        forms.submit();       
    }
}
// 2013.06.27 위지윅편집기 SmartEditor2 (program/common/se2) 사진첨부기능
function pasteHTML(filepath){
    var sHTML = '<span style="color:#FF0000;"><img src="'+filepath+'"></span>';
    oEditors.getById["answer"].exec("PASTE_HTML", [sHTML]);
}
</script>

</body>
</html>
<%@ include file="../lib/dbclose_tbr.jsp" %>
<%@ include file="../lib/dbclose.jsp" %>