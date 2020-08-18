<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String query			= "";
String table			= "ESL_ADMIN";
int aid					= 0;
String adminId			= "";
String adminName		= "";
String adminHp			= "";
String adminEmail		= "";
String[] in_admin_menu	= new String[] {};
String[] arrMenu		= new String[] {"ȸ������", "��ǰ����", "�ֹ�����", "�Խ��ǰ���", "���/���ǰ���", "���θ�ǰ���", "��������"};
String checked			= "";
String param			= "";
String iPage			= ut.inject(request.getParameter("page"));
String pgsize			= ut.inject(request.getParameter("pgsize"));

param		= "page="+ iPage +"&pgsize="+ pgsize;

if (request.getParameter("id") != null && request.getParameter("id").length() > 0) {
	aid			= Integer.parseInt(request.getParameter("id"));
	query		= "SELECT ADMIN_ID, ADMIN_NAME, ADMIN_HP, ADMIN_EMAIL, ADMIN_MENU FROM " + table +" WHERE ID ="+ aid;
	//out.println(query);if(true)return;
	try {
		rs	= stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}
	
	if(rs.next()){	
		adminId			= rs.getString("ADMIN_ID");
		adminName		= rs.getString("ADMIN_NAME");
		adminHp			= rs.getString("ADMIN_HP");
		adminEmail		= rs.getString("ADMIN_EMAIL");
		in_admin_menu	= rs.getString("ADMIN_MENU").split(",");
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
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="Ȩ" /> &gt; ���� &gt; <strong>�����ڼ���</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form name="frm_edit" id="frm_edit" method="post" action="admin_db.jsp">
					<input type="hidden" name="mode" value="upd" />
					<input type="hidden" name="admin_id" value="<%=adminId%>" />
					<input type="hidden" name="id" value="<%=aid%>" />
					<input type="hidden" name="param" value="<%=param%>" />
					<table class="tableView" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="40%" />
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><span>������ ID</span></th>
								<td style="padding-top:5px;"><%=adminId%></td>
								<th scope="row"><span>�����ڸ�</span></th>
								<td>
									<input type="text" class="input1" style="width:100px;" maxlength="20" name="admin_name" id="admin_name" required label="�����ڸ�" value="<%=adminName%>" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>��й�ȣ ����</span></th>
								<td>
									<input type="password" class="input2" style="width:100px;" maxlength="12" name="admin_pw" value="" required label="��й�ȣ" />
								</td>
								<th scope="row"><span>��й�ȣȮ��</span></th>
								<td>
									<input type="password" class="input2" style="width:100px;" maxlength="12"  name="admin_pw1" value="" required label="��й�ȣȮ��" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>�ڵ���</span></th>
								<td>
									<input type="text" class="input2" style="width:100px;" maxlength="14" onKeyup="this.value=this.value.replace(/[^0-9-]/g,'');" name="admin_hp" value="<%=adminHp%>" />
								</td>
								<th scope="row"><span>�̸���</span></th>
								<td>
									<input type="text" class="input2" style="width:140px;" maxlength="50" name="admin_email" value="<%=adminEmail%>" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>�޴�������</span></th>
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
						<a href="javascript:;" onclick="ckForm(document.frm_edit)" class="function_btn"><span>����</span></a>
						<a href="admin_list.jsp" class="function_btn"><span>���</span></a>
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
	$("#admin_name").focus();
});

function ckForm(f) {
	if (f.admin_pw.value.length > 0) {
		if (f.admin_pw.value != f.admin_pw1.value){
			alert("��й�ȣ�� ��й�ȣ Ȯ���� �ٸ��ϴ�.");
			f.admin_pw.value = f.admin_pw1.value = '';
			f.admin_pw.focus();
			return;
		}
		if(f.admin_pw.value.length < 8 || f.admin_pw.value.length > 20){
			alert('��й�ȣ�� 8���̻� 20�����Ϸ� �Է��ϼ���');
			f.admin_pw.focus();
			return;
		}		
		if ( !isAlpha(f.admin_pw.value) || !isNumeric(f.admin_pw.value) ) {
			alert('��/���� �������� ��й�ȣ�� ������ �ּ���.');
			f.admin_pw.focus();
			return;
		}
		var special_pattern = /[`~!@#$%^&*|\\\'\";:\/?]/gi;
		if( special_pattern.test(f.admin_pw.value) == false ){
			alert('��й�ȣ�� Ư�����ڰ� ���ԵǾ�� �մϴ�.');
			return;
		}
		if( f.admin_pw.value.indexOf(f.admin_id.value) > -1) {
			alert('��й�ȣ�� ID�� ������ �� �����ϴ�.');
			f.admin_pw.focus();
			return;
		}		
	
		var SamePass_0 = 0; //���Ϲ��� ī��Ʈ
		var SamePass_1 = 0; //���Ӽ�(+) ī��Ʈ
		var SamePass_2 = 0; //���Ӽ�(-) ī��Ʈ

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
			
			//���Ϲ��� ī��Ʈ
			if((chr_pass_0 == chr_pass_1) && (chr_pass_1 == chr_pass_2)) {
				SamePass_0++;
			} else {
				SamePass_0 = 0;
			}

			if (i > 2) {
				//���Ӽ�(+) ī��Ʈ
				if(chr_pass_0 - chr_pass_1 == 1 && chr_pass_1 - chr_pass_2 == 1 && chr_pass_2 - chr_pass_3 == 1) {
					SamePass_1++;
				} else {
					SamePass_1 = 0;
				}

				//���Ӽ�(-) ī��Ʈ
				if(chr_pass_0 - chr_pass_1 == -1 && chr_pass_1 - chr_pass_2 == -1 && chr_pass_2 - chr_pass_3 == -1) {
					SamePass_2++;
				} else {
					SamePass_2 = 0;
				}
			}
			
			if (SamePass_0 > 0) {
				alert('���Ϲ��ڸ� 3�� �̻� ������ �� �����ϴ�.');
				pw_passed = false;
			}

			if (SamePass_1 > 0 || SamePass_2 > 0) {
				alert('����, ���ڴ� 4�� ������ �� �����ϴ�.');
				pw_passed = false;
			}
			
			if (!pw_passed) {
				return false;
				break;
			}
		}
	}

	f.submit();

}
</script>
</body>
</html>