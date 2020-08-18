<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../common/include/inc-login-check.jsp"%>
<%viewPage	= true;%>
<%@ include file="../common/include/inc-top.jsp"%>
<%@ include file="../lib/dbconn_tbr.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

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
		ecs_cate1		= rs.getString("ECS_CATE1");
		ecs_cate2		= rs.getString("ECS_CATE2");
		ecs_cate3		= rs.getString("ECS_CATE3");

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

%>dhdP

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
			<h1>1:1문의</h1>
			<div class="pageDepth">
				HOME &gt; 고객센터 &gt; <strong>1:1문의</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="twelve columns offset-by-one ">
			<div class="row">
				<div class="threefourth last col">
					<ul class="tabNavi">
						<li><a href="notice.jsp">공지사항</a></li>
						<li><a href="faq.jsp">FAQ</a></li>
						<%if (eslMemberId.equals("")) {%>
						<li><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=640&lightbox[height]=680">1:1문의</a></li>
						<%} else {%>
						<li class="active"><a href="indiqna.jsp">1:1문의</a></li>
						<%}%>
						<li><a href="service_member.jsp">이용안내</a></li>
						<li><a href="presscenter.jsp">언론보도</a></li>
					</ul>
					<div class="clear"></div>
				</div>
			</div>
			<div class="row" style="margin-bottom:40px;">
				<div class="threefourth last col">
					<div class="guide qnaImg">
						<ul>
							<li>문의 하시기 전에 <strong class="font-blue">FAQ</strong>를 참고하시면 자주 올라오는 질문과 답변을 확인하실 수 있습니다.</li>
							<li>고객님의 문의 하신 내용에 대한 답변은 24시간(영업일 기준) 이내에 <strong class="font-blue"> 1:1 문의게시판 > 나의 문의내역</strong>을 통해 확인 가능하십니다.</li>
						</ul>
					</div>
				</div>
			</div>
			<!-- End row -->
			<div class="row" style="margin-bottom:40px;">
				<div class="threefourth last col">


<form name="frm_counsel" method="post" action="indiqna_db_.jsp" enctype="multipart/form-data">
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
								<th scope="row"><span>상담유형</span></th>
								<td>
							
									<select id="ecs_type1" name="ecs_type1" required label="상담유형1" onchange="readData()" style="width:150px;">
											<%=cateOpt1%>
									</select>
							
									<span id="groupSelect2">
										<select name="ecs_type2" id="ecs_type2" onChange="readData2();" style="width:150px;">
											<%=cateOpt2%>
										</select>
									</span>
								
									<span id="groupSelect3">
										<select name="ecs_type3" id="ecs_type3" style="width:150px;">
											<%=cateOpt3%>
										</select>
									</span>
								
									<!--select id="ecs_type1" name="ecs_type1" style="width:150px;" required label="상담유형1" onchange="readData()">
										<%=cateOpt1%>
									</select>
									
									<div id="groupSelect2">
										<select name="ecs_type2" id="ecs_type2" onChange="readData2();" style="width:235px;">
											<option value=''>==2차선택==</option>
										</select>
									</div>
									<div id="groupSelect3">
										<select name="ecs_type3" id="ecs_type3" style="width:235px;">
											<option value=''>==3차선택==</option>
										</select>
									</div-->
								</td>
							</tr>
							<tr>
								<th>작성자</th>
								<td><input name="name" type="text" class="ftfd" required label="작성자" value="<%=memName%>" /></td>
							</tr>
							<tr>
								<th>연락처</th>
								<td>
									<select name="hp1" id="hp1" style="width:70px;" required label="연락처">
										<option>선택</option>
										<option value="010"<%if(memHp1.equals("010")){out.print(" selected=\"selected\"");}%>>010</option>
									 	<option value="011"<%if(memHp1.equals("011")){out.print(" selected=\"selected\"");}%>>011</option>
									 	<option value="016"<%if(memHp1.equals("016")){out.print(" selected=\"selected\"");}%>>016</option>
									 	<option value="017"<%if(memHp1.equals("017")){out.print(" selected=\"selected\"");}%>>017</option>
									 	<option value="018"<%if(memHp1.equals("018")){out.print(" selected=\"selected\"");}%>>018</option>
									 	<option value="019"<%if(memHp1.equals("019")){out.print(" selected=\"selected\"");}%>>019</option>
									</select>
									-
									<input name="hp2" type="text" class="ftfd" style="width:70px;" maxlength="4" onKeyUp="onlyNum(this);if(this.value.length==4) hp3.focus();" value="<%=memHp2%>" required label="연락처" />
									-
									<input name="hp3" type="text" class="ftfd" style="width:70px;" maxlength="4" onKeyUp="onlyNum(this);if(this.value.length==4) email_id.focus();" value="<%=memHp3%>" required label="연락처" />
								</td>
							</tr>
							<input type="hidden" name="email_id" value="<%=emailId%>" />
							<input type="hidden" name="email_addr" value="<%=emailAddr%>" />
							<!--tr>
								<th>이메일</th>
								<td>
									<input name="email_id" id="email_id" type="text" class="ftfd" maxlength="19" value="<%=emailId%>" required label="이메일" />
									@
									<input name="email_addr" id="email_addr" type="text" class="ftfd" maxlength="30" value="<%=emailAddr%>" required label="이메일" />
									<select name="email_sel" id="email_sel" style="width:100px;" onChange="setEmail()">
										<option value="self"<%if(emailAddr.equals("self")){out.print(" selected=\"selected\"");}%>>직접입력</option>
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
								<th>제&nbsp;&nbsp;&nbsp;목</th>
								<td><input name="title" type="text" class="ftfd" style="width:98%;" required label="제목" value="<%=title%>" /></td>
							</tr>
							<tr>
								<th>내&nbsp;&nbsp;&nbsp;용</th>
								<td><textarea name="content" rows="6" style="width:98%;" required label="내용"><%=content%></textarea></td>
							</tr>
							<tr>
								<th>첨부파일</th>
								<td>
								
										<input type="file" id="up_file" class="ftfd" name="up_file" />
								
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
	txt_btn = "문의 수정하기";
}
else {
	txt_btn = "문의 등록하기";
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


<%@ include file="../lib/dbclose_tbr.jsp" %>
<%@ include file="../lib/dbclose.jsp" %>