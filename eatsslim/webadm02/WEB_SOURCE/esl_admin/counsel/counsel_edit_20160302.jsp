<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%viewPage	= true;%>
<%@ taglib uri="/WEB-INF/FCKeditor.tld" prefix="FCK" %>
<%@ include file="../include/inc-top.jsp"%>
<%@ include file="../lib/dbconn_tbr.jsp"%>
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
String cateOpt1			="<option value=''>==1������==</option>";
String cateOpt2			="<option value=''>==2������==</option>";
String cateOpt3			="<option value=''>==3������==</option>";
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
		
		
		
		//========1��
		query="select code, codename from V_CLAIM_GB where CODE_LEVEL = 1 and use_yn = 'Y'";
		try{rs_tbr = stmt_tbr.executeQuery(query);}catch(Exception e){out.println(e+"=>"+query);if(true)return;}
		while(rs_tbr.next()){
			if (ecs_cate1.equals(rs_tbr.getString("code")))
				cateOpt1+="<option value='"+rs_tbr.getString("code")+"' selected>"+rs_tbr.getString("codename")+"</option>";
			else
				cateOpt1+="<option value='"+rs_tbr.getString("code")+"'>"+rs_tbr.getString("codename")+"</option>";
		}

		//========2��
		query="select code, codename from V_CLAIM_GB where CODE_LEVEL = 2 and parentcode='"+ecs_cate1+"' and USE_YN = 'Y' order by code asc";
		//query="select code,catnm from gd_category_inquiry where length(code)=6 and code like '"+rs.getString("code").substring(0,3)+"%'";
		try{rs_tbr = stmt_tbr.executeQuery(query);}catch(Exception e){out.println(e+"=>"+query);if(true)return;}
		while(rs_tbr.next()){
			if (ecs_cate2.equals(rs_tbr.getString("code")))
				cateOpt2+="<option value='"+rs_tbr.getString("code")+"' selected>"+rs_tbr.getString("codename")+"</option>";
			else
				cateOpt2+="<option value='"+rs_tbr.getString("code")+"'>"+rs_tbr.getString("codename")+"</option>";
		}

		//========3��
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
	query		+= "	('"+ eslAdminId +"', '"+ userIp +"',  '���/���ǰ���', '1:1����', '/esl_admin/counsel/counsel_list.jsp', '"+member_id+"', '"+counselId+"', NOW())";
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
		oOption.text = "==2������==";
		for (i = document.getElementById("ecs_type3").length; i >= 0; i--){document.getElementById("ecs_type3").remove(i);}
		initOption(document.getElementById("ecs_type3"));

	}else if(dvLevel==2){
		ddlRegion=document.getElementById("ecs_type3");
		oOption.text = "==3������==";
		
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
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="Ȩ" /> &gt; ���/���ǰ��� &gt; <strong>1:1 ����</strong></p>
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
								<th scope="row"><span>�������</span></th>
								<td>
									<select name="counsel_type" style="width:230px;" required label="�������">
										<option value="01"<%if(counsel_type.equals("01")) out.println(" selected");%>>���(�̺�Ʈ, ��������)</option>
										<option value="02"<%if(counsel_type.equals("02")) out.println(" selected");%>>���빮��(����� ����, ȯ��, ��۹���)</option>
										<option value="03"<%if(counsel_type.equals("03")) out.println(" selected");%>>����Ҹ�(��۰��úҸ�)</option>
										<option value="04"<%if(counsel_type.equals("04")) out.println(" selected");%>>��ǰ����(��ǰ���� ����)</option>
										<option value="05"<%if(counsel_type.equals("05")) out.println(" selected");%>>��ǰ�Ҹ�(��ǰ�̿�Ҹ�)</option>
										<option value="09"<%if(counsel_type.equals("09")) out.println(" selected");%>>��Ÿ</option>
									</select>
								</td>
							</tr-->
							<tr>
								<th scope="row"><span>�������</span></th>
								<td>
									<select id="ecs_type1" name="ecs_type1" style="width:150px;" required label="�������1" onchange="readData(this,1)">
										<%=cateOpt1%>
									</select>
									<select id="ecs_type2" name="ecs_type2" style="width:150px;" required label="�������2" onchange="readData(this,2)">
										<%=cateOpt2%>
									</select>
									<select id="ecs_type3" name="ecs_type3" style="width:150px;" required label="�������3" >
										<%=cateOpt3%>
									</select>									
								</td>
							</tr>							
							<tr>
								<th scope="row"><span>�ۼ��ھ��̵�</span></th>
								<td>
									<%=member_id%>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>�ۼ���</span></th>
								<td>
									<input type="text" name="name" id="name" required label="�ۼ���" class="input1" style="width:100px;" maxlength="10" value="<%=name%>" readonly />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>����ó</span></th>
								<td>
									<input type="text" name="hp" id="name" required label="����ó" class="input1" style="width:100px;" maxlength="10" value="<%=hp%>" readonly />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>�̸���</span></th>
								<td>
									<input type="text" name="email" id="name" required label="�̸���" class="input1" style="width:400px;" maxlength="10" value="<%=email%>" readonly />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>����</span></th>
								<td>
									<input type="text" name="title" id="title" required label="����" class="input1" style="width:400px;" maxlength="100" value="<%=title%>" readonly />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>����</span></th>
								<td><textarea name="content" rows="6" style="width:600px;" required label="����" readonly><%=content%></textarea></td>
							</tr>
							<tr>
								<th scope="row"><span>÷������</span></th>
								<td colspan="3">
									<%if (!listImg.equals("") || listImg != null) {%>
										<a href="<%=webUploadDir +"board/"+ listImg%>" target="_blank"><%=listImg%></a>
										<!-- <img src="<%=webUploadDir +"board/"+ listImg%>" width="160" height="108" /> -->
									<%}%>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>�ۼ���IP</span></th>
								<td>
									<%=inst_ip%>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>�ۼ���</span></th>
								<td>
									<%=wdate%>
								</td>
							</tr>
							<tr>
								<td colspan="2" height="1" bgcolor="#dfdfdf"></td>
							</tr>
							<tr>
								<th scope="row"><span>�亯</span></th>
								<td>
									<textarea id="answer" name="answer" style="height:500px;width:100%;" type=editor><%=answer%></textarea>
									<!-- �������� Ȱ��ȭ ��ũ��Ʈ -->
									<script src="/editor/editor_board.js"></script>
									<script>
										mini_editor('/editor/');							
									</script>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btn_center">
						<a href="javascript:;" onclick="chkForm(document.frm_edit)" class="function_btn"><span>����</span></a>
						<a href="counsel_list.jsp?<%=param%>" class="function_btn"><span>���</span></a>
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
<script type="text/javascript">
$(document).ready(function() {
	$("#title").focus();
});
</script>
</body>
</html>
<%@ include file="../lib/dbclose_tbr.jsp" %>
<%@ include file="../lib/dbclose.jsp" %>