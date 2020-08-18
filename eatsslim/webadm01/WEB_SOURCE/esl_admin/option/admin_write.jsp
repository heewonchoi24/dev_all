<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-top.jsp"%>
<%
String[] in_admin_menu	= new String[] {};
String[] arrMenu		= new String[] {"회원관리", "상품관리", "주문관리", "게시판관리", "상담/문의관리", "프로모션관리", "설정관리"};
String checked			= "";
%>

	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:1,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
	})
	//]]>
	</script>
</head>
<body>
<!-- wrap -->
<div id="wrap">
	<%@ include file="../include/inc-header.jsp" %>
	<!-- container -->
	<div id="container" class="group">
		<%@ include file="../include/inc-sidebar-option.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 설정 &gt; <strong>관리자설정</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form name="frm_write" id="frm_write" method="post" action="admin_db.jsp">
					<input type="hidden" name="mode" value="ins" />
					<table class="tableView" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="40%" />
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><span>관리자 ID</span></th>
								<td style="height:45px;padding-top:5px;">
									<input type="text" class="input2" style="width:100px;" maxlength="12" name="admin_id" id="admin_id" style="ime-mode:disabled" onkeyup="document.frm_write.hiddenID.value=''" required label="관리자 ID" />
									<a href="javascript:;" onclick="idCheck();" class="function_btn"><span>중복확인</span></a>
									<input type="hidden" id="hiddenID" value="" />
									<span class="org" id="resultID"></span>
								</td>
								<th scope="row"><span>관리자명</span></th>
								<td>
									<input type="text" class="input1" style="width:100px;" maxlength="20" name="admin_name" required label="관리자명" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>비밀번호</span></th>
								<td>
									<input type="password" class="input2" style="width:100px;" maxlength="12" name="admin_pw" value="" required label="비밀번호" />
								</td>
								<th scope="row"><span>비밀번호확인</span></th>
								<td>
									<input type="password" class="input2" style="width:100px;" maxlength="12"  name="admin_pw1" value="" required label="비밀번호확인" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>핸드폰</span></th>
								<td>
									<input type="text" class="input2" style="width:100px;" maxlength="14" onKeyup="this.value=this.value.replace(/[^0-9-]/g,'');" name="admin_hp" />
								</td>
								<th scope="row"><span>이메일</span></th>
								<td>
									<input type="text" class="input2" style="width:140px;" maxlength="50" name="admin_email" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>메뉴사용권한</span></th>
								<td colspan="3">
									<%
									cnt=0;
									for( i = 0; i < arrMenu.length; i++ ){
										cnt=i+1;
										checked="";
										for( int j = 0; j < in_admin_menu.length; j++ ){
											if(String.valueOf(cnt).equals(in_admin_menu[j]))checked=" checked";
										}
									%>
									<span class="mr_10">
										<input type="checkbox" class="chk1" name="admin_menu" value="<%=cnt%>"<%=checked%>/> <%=arrMenu[i]%>
									</span>
									<%}%>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btn_center">
						<a href="javascript:;" onclick="ckForm(document.frm_write)" class="function_btn"><span>저장</span></a>
						<a href="admin_list.jsp" class="function_btn"><span>목록</span></a>
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
	$("#admin_id").focus();
});

function idCheck() {
	var f = document.frm_write;
	if (!trim(f.admin_id.value)) {
		alert("아이디를 입력하십시오.");
		f.admin_id.focus();
		return;
	}
	if(f.admin_id.value.length < 6 || f.admin_id.value.length > 12) {
		alert('아이디는 6자이상 12자이하로 입력하세요');
		f.admin_id.focus();
		return;
	}
	/*
	if (!isAlpha(f.admin_id.value) || !isNumeric(f.admin_id.value)) {
		alert('영/숫자 조합으로 아이디를 설정해 주세요.');
		f.admin_id.focus();
		return;
	}
	*/
	document.getElementById("ifrmHidden").src="idCheck.jsp?admin_id="+f.admin_id.value;
}

function ckForm(f) {
	if (f.hiddenID.value != f.admin_id.value) {
		alert( "아이디 중복확인을 하시기 바랍니다.");			
		f.admin_id.focus();
		return;
	}
	if(f.admin_id.value.length < 6 || f.admin_id.value.length > 12) {
		alert('아이디는 6자이상 12자이하로 입력하세요');
		f.admin_id.focus();
		return;
	}
	if (trim(f.admin_pw.value) == "") {
		alert('비밀번호를 입력하세요');
		f.admin_pw.focus();
		return;
	}
	if (f.admin_pw.value != f.admin_pw1.value) {
		alert("비밀번호와 비밀번호 확인이 다릅니다.");
		f.admin_pw.value = f.admin_pw1.value = '';
		f.admin_pw.focus();
		return;
	}
	if(f.admin_pw.value.length < 8 || f.admin_pw.value.length > 20) {
		alert('비밀번호는 8자이상 20자이하로 입력하세요');
		f.admin_pw.focus();
		return;
	}
	if ( !isAlpha(f.admin_pw.value) || !isNumeric(f.admin_pw.value) ) {
		alert('영/숫자 조합으로 비밀번호를 설정해 주세요.');
		f.admin_pw.focus();
		return;
	}
	var special_pattern = /[`~!@#$%^&*|\\\'\";:\/?]/gi;
	if( special_pattern.test(f.admin_pw.value) == false ){
		alert('비밀번호는 특수문자가 포함되어야 합니다.');
		return;
	}
	if( f.admin_pw.value.indexOf(f.admin_id.value) > -1) {
		alert('비밀번호는 ID를 포함할 수 없습니다.');
		f.admin_pw.focus();
		return;
	}		
	
	var SamePass_0 = 0; //동일문자 카운트
	var SamePass_1 = 0; //연속성(+) 카운트
	var SamePass_2 = 0; //연속성(-) 카운트

	var chr_pass_0;
	var chr_pass_1;
	var chr_pass_2;
	var chr_pass_3;
	
	var pw_passed = true;
	
	var pw = f.admin_pw.value;
	
	for (var i=2;i<pw.length;i++) {
		
		if (i == 2) {
			chr_pass_0 = pw.charCodeAt(i-2);
			chr_pass_1 = pw.charCodeAt(i-1);
			chr_pass_2 = pw.charCodeAt(i);
		} else {
			chr_pass_0 = pw.charCodeAt(i-3);
			chr_pass_1 = pw.charCodeAt(i-2);
			chr_pass_2 = pw.charCodeAt(i-1);
			chr_pass_3 = pw.charCodeAt(i);
		}
		
		//동일문자 카운트
		if((chr_pass_0 == chr_pass_1) && (chr_pass_1 == chr_pass_2)) {
			SamePass_0++;
		} else {
			SamePass_0 = 0;
		}

		if (i > 2) {
			//연속성(+) 카운트
			if(chr_pass_0 - chr_pass_1 == 1 && chr_pass_1 - chr_pass_2 == 1 && chr_pass_2 - chr_pass_3 == 1) {
				SamePass_1++;
			} else {
				SamePass_1 = 0;
			}

			//연속성(-) 카운트
			if(chr_pass_0 - chr_pass_1 == -1 && chr_pass_1 - chr_pass_2 == -1 && chr_pass_2 - chr_pass_3 == -1) {
				SamePass_2++;
			} else {
				SamePass_2 = 0;
			}
		}
		
		if (SamePass_0 > 0) {
			alert('동일문자를 3자 이상 연속할 수 없습니다.');
			pw_passed = false;
		}

		if (SamePass_1 > 0 || SamePass_2 > 0) {
			alert('영문, 숫자는 4자 연속할 수 없습니다.');
			pw_passed = false;
		}
		
		if (!pw_passed) {
			return false;
			break;
		}
	}
		
	f.submit();
}
</script>
</body>
</html>