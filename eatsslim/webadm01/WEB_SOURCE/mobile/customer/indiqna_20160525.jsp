<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-login-check.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%@ include file="/lib/dbconn_tbr.jsp"%>
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

String ecs_cate1		= "";
String ecs_cate2		= "";
String ecs_cate3		= "";
String cateOpt1			="<option value=''>==1차선택==</option>";
String cateOpt2			="<option value=''>==2차선택==</option>";
String cateOpt3			="<option value=''>==3차선택==</option>";

//out.println (counselID);
//if ( true ) return;

if (counselID != null && counselID.length() > 0) {
	query = "SELECT counsel_type, name, hp, email, title, content, up_file, ECS_CATE1, ECS_CATE2, ECS_CATE3 FROM ESL_COUNSEL WHERE id="+ counselID ;
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
		ecs_cate1	= rs.getString("ECS_CATE1");
		ecs_cate2	= rs.getString("ECS_CATE2");
		ecs_cate3	= rs.getString("ECS_CATE3");

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
	try{rs_tbr = stmt_tbr.executeQuery(query);}catch(Exception e){out.println(e+"=>"+query);if(true)return;}
	while(rs_tbr.next()){
		if (ecs_cate2.equals(rs_tbr.getString("code")))
			cateOpt2+="<option value='"+rs_tbr.getString("code")+"' selected>"+rs_tbr.getString("codename")+"</option>";
		else
			cateOpt2+="<option value='"+rs_tbr.getString("code")+"'>"+rs_tbr.getString("codename")+"</option>";
	}

	//========3차
	query="select code, codename from V_CLAIM_GB where CODE_LEVEL = 3 and parentcode='"+ecs_cate1+"' and PARENTCODE2 = '"+ecs_cate2+"' and USE_YN = 'Y' order by code asc";
	try{rs_tbr = stmt_tbr.executeQuery(query);}catch(Exception e){out.println(e+"=>"+query);if(true)return;}
	while(rs_tbr.next()){
		if (ecs_cate3.equals(rs_tbr.getString("code")))
			cateOpt3+="<option value='"+rs_tbr.getString("code")+"' selected>"+rs_tbr.getString("codename")+"</option>";
		else
			cateOpt3+="<option value='"+rs_tbr.getString("code")+"'>"+rs_tbr.getString("codename")+"</option>";
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
	
	//========1차
	query="select code,codename from v_claim_gb where code_level = 1 and use_yn = 'Y' ";
	try{rs_tbr = stmt_tbr.executeQuery(query);}catch(Exception e){out.println(e+"=>"+query);if(true)return;}
	while(rs_tbr.next()){
		cateOpt1+="<option value='"+rs_tbr.getString("code")+"'>"+rs_tbr.getString("codename")+"</option>";
	}
	rs_tbr.close();	
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

		<h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">고객센터</span></span></h1>
		
		<div class="grid-navi">
			<table class="navi" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><a href="/mobile/customer/notice.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">공지사항</span></span></a></td>
					<td><a href="/mobile/customer/indiqna.jsp" class="ui-btn ui-btn-inline ui-btn-up-f"><span class="ui-btn-inner"><span class="ui-btn-text">1:1문의하기</span></span><span class="active"></span></a></td>
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
			<h2>상담유형선택</h2>
			<ul class="form-line">
				<li>					
					<ul class="form-line ui-inline3">
					<li style="margin-right:5px;">
					<div class="select-box">
					<select id="ecs_type1" name="ecs_type1" required label="상담유형1" onchange="readData()" style="width:150px;">
						<%=cateOpt1%>
					</select>
					</div>
					</li>
					<li>
					<div class="select-box" id="groupSelect2">
						<select name="ecs_type2" id="ecs_type2" onChange="readData2();" style="width:150px;">
							<%=cateOpt2%>
						</select>
					</div>
					</li>
							<li>
					<div class="select-box"  id="groupSelect3">	
						<select name="ecs_type3" id="ecs_type3" style="width:150px;">
							<%=cateOpt3%>
						</select>
					</div>
					</li>
					<ul class="form-line ui-inline2">
				</li>
			</ul>
			
			<div class="divider"></div>
			
			<h2>문의내용</h2>
			<ul class="form-line">
				<li><label>작성자</label><input name="name" type="text" required label="작성자" value="<%=memName%>" /></li>
				<li><label>연락처</label><input name="hp" type="text" required label="연락처" value="<%=memHp%>" /></li>
				<li><label>이메일</label><input name="email" type="text" required label="이메일" value="<%=memEmail%>" /></li>
				<li><label>제목</label><input name="title" type="text" required label="제목" value="<%=title%>" /></li>
				<li>
					<label style="display:block">내용</label>
					<textarea name="content" rows="5" id="textarea" required label="내용"><%=content%></textarea>
				</li>
			</ul>
		</div>

<%
if (counselID != null && counselID.length() > 0) {
	txt_btn = "수정하기";
}
else {
	txt_btn = "문의하기";
}
%>

		<div class="grid-navi">
			<table class="navi" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><a href="javascript:;" class="ui-btn ui-btn-inline ui-btn-up-d" onClick="chkForm(document.frm_counsel)"><span class="ui-btn-inner"><span class="ui-btn-text"><%=txt_btn%></span></span></a></td>
					<!--td><a href="/mobile/customer/indiqna.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">취소</span></span></a></td-->
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


<script type="text/javascript">
var xmlhttp,arrRegion="",ddlRegion="";
var dvLvl;

function readData(){
	var sLists="",arrTmp="";
	
	var typeOptions ="";
	var groupCode	= $("#ecs_type1").val();
	//var groupCode	= $("#group_code").val();
	
	$.post("getCategory_ecs.jsp", {
		dvLevel: "1",
		code: groupCode,
		pcode: groupCode
	},
	function(data) {	
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				var groupArr		= "";
				typeOptions	= '<select name="ecs_type2" id="ecs_type2" style="width:150px;" onchange="readData2();">';
				typeOptions	+= "<option value=''>== 2차 선택 ==</option>";
				
				$(data).find("group").each(function() {
					groupArr		= $(this).text().split("@");
					
					for (i=0;i<groupArr.length-1;i++){
						//var e1 = document.createElement("OPTION");
						arrTmp=groupArr[i].split("|");			
						//e1.text = trim(arrTmp[1]);
						//e1.value =  trim(arrTmp[0]);
						//ddlRegion.add(e1);
							
						//$("#ecs_type2").append("<option value='"+trim(arrTmp[0])+"'>"+trim(arrTmp[1])+"</option>");
						
						typeOptions	+= "<option value='"+trim(arrTmp[0])+"'>"+trim(arrTmp[1])+"</option>";

					}		
					typeOptions	+= "</select>"					

				});
				//alert(typeOptions);
				$("#groupSelect2").html(typeOptions);
				$("#ecs_type2").selectBox();	
				
				// 3차 초기화
				typeOptions	= '<select name="ecs_type3" id="ecs_type3" style="width:150px;" >';
				typeOptions	+= "<option value=''>== 3차 선택 ==</option>";
				typeOptions	+= "</select>"	
				
				$("#groupSelect3").html(typeOptions);
				$("#ecs_type3").selectBox();	
				
				$("#ecs_type2").change(function() {
					
				});
			
			} else {
				$(data).find("error").each(function() {
					$(data).find("error").each(function() {
						alert($(this).text());
						//$("#group_id").val("");
					});
				});
			}
		});
	}, "xml");
	
	return false;
}

function readData2(){
	var sLists="",arrTmp="";
	
	var typeOptions ="";
	var groupCode	= $("#ecs_type1").val();
	var groupCode2	= $("#ecs_type2").val();
	
	$.post("getCategory_ecs.jsp", {
		dvLevel: "2",
		code: groupCode2,
		pcode: groupCode
	},
	function(data) {	
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				var groupArr		= "";
				typeOptions	= '<select name="ecs_type3" id="ecs_type3" style="width:150px;" >';
				typeOptions	+= "<option value=''>== 3차 선택 ==</option>";
				
				$(data).find("group").each(function() {
					groupArr		= $(this).text().split("@");
					
					for (i=0;i<groupArr.length-1;i++){
						//var e1 = document.createElement("OPTION");
						arrTmp=groupArr[i].split("|");			
						//e1.text = trim(arrTmp[1]);
						//e1.value =  trim(arrTmp[0]);
						//ddlRegion.add(e1);
							
						//$("#ecs_type2").append("<option value='"+trim(arrTmp[0])+"'>"+trim(arrTmp[1])+"</option>");
						
						typeOptions	+= "<option value='"+trim(arrTmp[0])+"'>"+trim(arrTmp[1])+"</option>";

					}		
					typeOptions	+= "</select>"					

				});
				//alert(typeOptions);
				$("#groupSelect3").html(typeOptions);
				$("#ecs_type3").selectBox();	
				
		
			} else {
				$(data).find("error").each(function() {
					$(data).find("error").each(function() {
						alert($(this).text());
						//$("#group_id").val("");
					});
				});
			}
		});
	}, "xml");
	
	return false;
}


</script>

</body>
</html>

<%@ include file="/lib/dbclose_tbr.jsp" %>
<%@ include file="/lib/dbclose.jsp" %>