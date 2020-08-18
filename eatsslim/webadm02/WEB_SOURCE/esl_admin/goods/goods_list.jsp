<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../lib/dbconn_phi.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String table		= "PHIBABY.V_PRODUCT";
String query1		= "";
String query2		= "";
String query3		= "";
String field		= ut.inject(request.getParameter("field"));
String keyword		= ut.inject(request.getParameter("keyword"));
String where		= "";
String param		= "";
String prdtId		= "";
String prdtName		= "";
int stdPrice		= 0;
String setYn		= "";
String useYn		= "";
int goodsId			= 0;
String goodsType	= "";
int goodsPrice		= 0;
String gubun1		= "";
String gubun2		= "";
String gubun3		= "";

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
int curNum			= 0;
//where			= " WHERE SETYN = 'Y'";
//where			= " WHERE 1=1";
//where			= " WHERE USEYN = 'Y'";
where			= " where classlcd = 'H41' ";

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

query1		= "SELECT COUNT(PRDTID) FROM "+ table + where; //out.print(query1); if(true)return;
pstmt_phi	= conn_phi.prepareStatement(query1);
rs_phi		= pstmt_phi.executeQuery();
if (rs_phi.next()) {
	intTotalCnt = rs_phi.getInt(1); //�� ���ڵ� ��		
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

query2		= "SELECT * FROM (SELECT a.*, ROWNUM rnum FROM (SELECT PRDTID, PRDTNAME, STDPRICE, SETYN, USEYN FROM "+ table + where +" ORDER BY PRDTID DESC) a) WHERE rnum > ? * (? - 1) AND ROWNUM <= ?"; //out.print(query2); if(true)return;
pstmt_phi	= conn_phi.prepareStatement(query2);
pstmt_phi.setInt(1, pgsize);
pstmt_phi.setInt(2, iPage);
pstmt_phi.setInt(3, pgsize);
rs_phi		= pstmt_phi.executeQuery();
///////////////////////////
%>

	<script type="text/javascript" src="../js/sub.js"></script>
	<script type="text/javascript" src="../js/left.js"></script>
	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:1,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
		leftcon();
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
		<%@ include file="../include/inc-sidebar-product.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="Ȩ" /> &gt; ��ǰ���� &gt; <strong>��ǰ��������</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form method="get" name="frm_search" action="<%=request.getRequestURI()%>">
					<table class="table01" border="1" cellspacing="0">
						<colgroup>
							<col width="105px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">
									<span>
										<select style="width:80px;" name="field" onchange="this.form.keyword.focus()">
											<option value="PRDTNAME"<%if(field.equals("PRDTNAME")){out.print(" selected=\"selected\"");}%>>��ǰ��</option>
											<option value="PRDTID"<%if(field.equals("PRDTID")){out.print(" selected=\"selected\"");}%>>��ǰ�ڵ�</option>
										</select>
									</span>
								</th>
								<td><input type="text" class="input1" style="width:200px;" maxlength="30" name="keyword" value="<%=keyword%>" onfocus="this.select()"/></td>
							</tr>
						</tbody>
					</table>
					<p class="btn_center"><input type="image" src="../images/common/btn/btn_search.gif" alt="�˻�" /></p>			
					<div class="member_box">
						<p class="search_result">�� <strong><%=intTotalCnt%></strong>��</p>
						<p class="right_box">
							<select name="pgsize" onchange="this.form.submit()">
								<option value="10"<%if(pgsize==10)out.print(" selected");%>>10��������</option>
								<option value="20"<%if(pgsize==20)out.print(" selected");%>>20��������</option>
								<option value="40"<%if(pgsize==40)out.print(" selected");%>>40��������</option>
								<option value="100"<%if(pgsize==100)out.print(" selected");%>>100��������</option>
							</select>
						</p>
					</div>
				</form>
				<form name="frm_list" id="frm_list" method="post">
					<input type="hidden" name="mode" value="updAll" />
					<table class="table02" border="1" cellspacing="0">
						<colgroup>
							<col width="3%" />
							<col width="4%" />
							<col width="*" />
							<col width="6%" />
							<col width="6%" />
							<col width="22%" />
							<col width="14%" />
							<col width="8%" />
							<col width="8%" />
							<col width="6%" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="col"><span>��ȣ</span></th>
								<th scope="col"><span>��ǰ�ڵ�</span></th>
								<th scope="col"><span>��ǰ��</span></th>
								<th scope="col"><span>�Һ��ڰ�|����</span></th>
								<th scope="col"><span>�Һ��ڰ�|��</span></th>
								<th scope="col"><span>��ǰŸ��</span></th>
								<th scope="col"><span>����1</span></th>
								<th scope="col"><span>����2</span></th>
								<th scope="col"><span>����3</span></th>
								<th scope="col"><span>ó��</span></th>
							</tr>
							<%
							if (intTotalCnt > 0) {
								while (rs_phi.next()) {
									prdtId		= rs_phi.getString("PRDTID");
									prdtName	= rs_phi.getString("PRDTNAME");
									stdPrice	= rs_phi.getInt("STDPRICE");
									setYn		= rs_phi.getString("SETYN");
									useYn		= rs_phi.getString("USEYN");

									query3		= "SELECT ID, GOODS_TYPE, GOODS_PRICE, GUBUN1, GUBUN2, GUBUN3 FROM ESL_GOODS_SETTING WHERE GOODS_CODE = ?";
									pstmt		= conn.prepareStatement(query3);
									pstmt.setString(1, prdtId);
									rs			= pstmt.executeQuery();

									if (rs.next()) {
										goodsId		= rs.getInt("ID");
										goodsType	= rs.getString("GOODS_TYPE");
										goodsPrice	= rs.getInt("GOODS_PRICE");
										gubun1		= rs.getString("GUBUN1");
										gubun2		= rs.getString("GUBUN2");
										gubun3		= rs.getString("GUBUN3");
									} else {
										goodsId		= 0;
										goodsPrice	= 0;
										goodsType	= "";
										gubun1		= "";
										gubun2		= "";
										gubun3		= "";
									}
							%>
							<input type="hidden" name="goodsId" id="goodsId_<%=prdtId%>" value="<%=goodsId%>" />
							<input type="hidden" name="gubun1_val_<%=prdtId%>" name="gubun1_val_<%=prdtId%>" value="<%=gubun1%>" />
							<input type="hidden" name="gubun2_val_<%=prdtId%>" name="gubun2_val_<%=prdtId%>" value="<%=gubun2%>" />
							<input type="hidden" name="gubun3_val_<%=prdtId%>" name="gubun3_val_<%=prdtId%>" value="<%=gubun3%>" />
							<tr>
								<td><%=curNum%></td>
								<td><input type="text" name="goods_code" id="goods_code_<%=prdtId%>" value="<%=prdtId%>" readonly="readonly" style="width:50px;" /></td>
								<td><input type="text" name="goods_name_<%=prdtId%>" id="goods_name_<%=prdtId%>" value="<%=prdtName%>" readonly="readonly" style="width:170px;" /></td>
								<td><input type="text" name="goods_price_<%=prdtId%>" id="goods_price_<%=prdtId%>" value="<%=stdPrice%>" style="width:60px;" dir="rtl" maxlength="7" /></td>
								<td><%=goodsPrice%></td>
								<td>
									<label><input type="radio" name="goods_type_<%=prdtId%>" value="C" onclick="getGubun1('<%=prdtId%>');"<%if (goodsType.equals("C")) { out.println(" checked=\"checked\"");}%> /> ī�װ�</label>
									<label><input type="radio" name="goods_type_<%=prdtId%>" value="S" onclick="getGubun1('<%=prdtId%>');"<%if (goodsType.equals("S")) { out.println(" checked=\"checked\"");}%> /> �޴�</label>
									<label><input type="radio" name="goods_type_<%=prdtId%>" value="G" onclick="getGubun1('<%=prdtId%>');"<%if (goodsType.equals("G")) { out.println(" checked=\"checked\"");}%> /> ��Ʈ�׷�</label>
								</td>
								<td>
									<select name="gubun1_<%=prdtId%>" id="gubun1_<%=prdtId%>" onchange="getGubun2('<%=prdtId%>')">
										<option value="">����</option>
										<%if (goodsType.equals("G") && gubun1.length() > 0) {%>
										<option value="01"<%if (gubun1.equals("01")) { out.println(" selected=\"selected\"");}%>>�Ļ���̾�Ʈ</option>
										<option value="02"<%if (gubun1.equals("02")) { out.println(" selected=\"selected\"");}%>>���α׷����̾�Ʈ</option>
										<option value="03"<%if (gubun1.equals("03")) { out.println(" selected=\"selected\"");}%>>Ÿ�Ժ����̾�Ʈ</option>
										<option value="04"<%if (gubun1.equals("04")) { out.println(" selected=\"selected\"");}%>>����</option>
										<option value="50"<%if (gubun1.equals("50")) { out.println(" selected=\"selected\"");}%>>Ǯ��Ÿ�Ǳ��</option>
										<option value="09"<%if (gubun1.equals("09")) { out.println(" selected=\"selected\"");}%>>��Ÿ</option>
										<%}%>
									</select>
								</td>
								<td>
									<select name="gubun2_<%=prdtId%>" id="gubun2_<%=prdtId%>">
										<option value="">����</option>
										<%
										if (goodsType.equals("G") && gubun2.length() > 0) {
											if (gubun1.equals("01")) {
										%>
										<option value="11"<%if (gubun2.equals("11")) { out.println(" selected=\"selected\"");}%>>1��</option>
										<option value="12"<%if (gubun2.equals("12")) { out.println(" selected=\"selected\"");}%>>2��</option>
										<option value="13"<%if (gubun2.equals("13")) { out.println(" selected=\"selected\"");}%>>3��</option>
										<option value="14"<%if (gubun2.equals("14")) { out.println(" selected=\"selected\"");}%>>2��+����</option>
										<option value="15"<%if (gubun2.equals("15")) { out.println(" selected=\"selected\"");}%>>3��+����</option>
										<%
											} else if (gubun1.equals("02")) {
										%>
										<option value="21"<%if (gubun2.equals("21")) { out.println(" selected=\"selected\"");}%>>����</option>
										<option value="22"<%if (gubun2.equals("22")) { out.println(" selected=\"selected\"");}%>>����</option>
										<option value="23"<%if (gubun2.equals("23")) { out.println(" selected=\"selected\"");}%>>FULL-STEP</option>
										<%
											} else if (gubun1.equals("03")) {
										%>
										<option value="31"<%if (gubun2.equals("31")) { out.println(" selected=\"selected\"");}%>>��ũ������</option>
										<option value="32"<%if (gubun2.equals("32")) { out.println(" selected=\"selected\"");}%>>�뷱������ũ</option>
										<%
											} else if (gubun1.equals("50")) {
										%>
										<option value="01"<%if (gubun2.equals("01")) { out.println(" selected=\"selected\"");}%>>�����</option>
										<option value="02"<%if (gubun2.equals("02")) { out.println(" selected=\"selected\"");}%>>��Ÿ��</option>
										<option value="03"<%if (gubun2.equals("03")) { out.println(" selected=\"selected\"");}%>>�Ļ���</option>
										<option value="04"<%if (gubun2.equals("04")) { out.println(" selected=\"selected\"");}%>>��Ÿ</option>
										<%
											}
										}
										%>
									</select>
								</td>
								<td>
									<select name="gubun3_<%=prdtId%>" id="gubun3_<%=prdtId%>">
										<option value="">����</option>
										<%
										if (goodsType.equals("G") && gubun1.equals("02") && gubun3.length() > 0) {
											for (i = 1; i < 5; i++) {
										%>
										<option value="<%=i%>"<%if (gubun3.equals(i)) { out.println(" selected=\"selected\"");}%>><%=i%>����</option>
										<%
											}
										}
										%>
									</select>
								</td>
								<td>
									<%if (goodsId > 0) {%>
									<a href="javascript:;" onclick="chkEdit('<%=prdtId%>');" class="function_btn"><span>����</span></a>
									<%} else {%>
									<a href="javascript:;" onclick="chkEdit('<%=prdtId%>');" class="function_btn"><span>���</span></a>
									<%}%>
								</td>
							</tr>
							<%
									curNum--;
								}
							} else {
							%>
							<tr>
								<td colspan="9">���̿� ��ϵ� ��ǰ�� �����ϴ�.</td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</form>
				<%if (intTotalCnt > 0) {%>
				<div class="btn_style1">
					<p class="right_btn">
						<a href="javascript:;" onclick="chkWrite();" class="function_btn"><span>�ϰ����</span></a>
					</p>
				</div>
				<%@ include file="../include/inc-paging.jsp"%>
				<%}%>
			</div>
			<!-- //contents -->
		</div>
		<!-- //incon -->
	</div>
	<!-- //container -->
</div>
<!-- //wrap -->
<script type="text/javascript">
var newOptions		= "";
var selectedOption	= "";

function clearAll(obj) {
	newOptions	= {'' : '����'};
	selectedOption	= '';

	for (var i=1; i<4; i++) {
		makeOption(newOptions, $("#gubun"+ i +"_"+ obj), selectedOption);
	}
}

function getGubun1(obj) {
	var goodsType	= $("input[name=goods_type_"+ obj +"]:checked").val();
	
	if (goodsType == "G") {
		newOptions	= {
			''	 : '����',
			'01' : '�Ļ���̾�Ʈ',
			'02' : '���α׷����̾�Ʈ',
			'03' : 'Ÿ�Ժ����̾�Ʈ',
			'04' : '����',
			'50' : 'Ǯ��Ÿ�Ǳ��',
			'09' : '��Ÿ'
		}

		if ($("#goodsId_"+ obj).val() == 0) {
			selectedOption	= '';
		} else {
			selectedOption	= $("#gubun1_val"+ obj).val();
		}

		makeOption(newOptions, $("#gubun1_"+ obj), selectedOption);
	} else {
		clearAll(obj)
	}
}

function getGubun2(obj) {
	var gubun1Val		= $("#gubun1_"+ obj).val();
	var newOptions1		= {'' : '����'};
	var selectedOption1	= '';

	if (gubun1Val == "01") {
		newOptions	= {
			''	 : '����',
			'11' : '1��',
			'12' : '2��',
			'13' : '3��',
			'14' : '2��+����',
			'15' : '3��+����'
		}

		if ($("#goodsId_"+ obj).val() == 0) {
			selectedOption	= '';
		} else {
			selectedOption	= $("#gubun2_val"+ obj).val();
		}
	} else if (gubun1Val == "03") {
		newOptions	= {
			''	 : '����',
			'31' : '��ũ������(SS)',
			'32' : '�뷱������ũ'
		}

		if ($("#goodsId_"+ obj).val() == 0) {
			selectedOption	= '';
		} else {
			selectedOption	= $("#gubun2_val"+ obj).val();
		}
	} else if (gubun1Val == "50") {
		newOptions	= {
			''	 : '����',
			'01' : '�����',
			'02' : '��Ÿ��',
			'03' : '�Ļ���',
			'04' : '��Ÿ'
		}

		if ($("#goodsId_"+ obj).val() == 0) {
			selectedOption	= '';
		} else {
			selectedOption	= $("#gubun2_val"+ obj).val();
		}
	} else {
		newOptions	= {'' : '����'};
		selectedOption	= '';
	}

	makeOption(newOptions, $("#gubun2_"+ obj), selectedOption);
	makeOption(newOptions1, $("#gubun3_"+ obj), selectedOption1);
}

function chkWrite() {
	$.post("goods_ajax.jsp", $("#frm_list").serialize(),
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				alert("���������� ó���Ǿ����ϴ�.");
				document.location.reload();
			} else {
				var error_txt;
				$(data).find("error").each(function() {
					error_txt = $(this).text().split(":");
					alert(error_txt[1]);
					if (error_txt[0] != "no_txt")
						$("#" + error_txt[0]).focus();
				});
			}
		});
	}, "xml");
	return false;
}

function chkEdit(obj) {
	$.post("goods_ajax.jsp", {
		mode: "ins",
		goods_code: $("#goods_code_"+ obj).val(),
		goods_name: $("#goods_name_"+ obj).val(),
		goods_price: $("#goods_price_"+ obj).val(),
		goods_type: $("input[name=goods_type_"+ obj +"]:checked").val(),
		gubun1: $("#gubun1_"+ obj).val(),
		gubun2: $("#gubun2_"+ obj).val(),
		gubun3: $("#gubun3_"+ obj).val()
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				alert("���������� ó���Ǿ����ϴ�.");
				document.location.reload();
			} else {
				var error_txt;
				$(data).find("error").each(function() {
					error_txt = $(this).text().split(":");
					alert(error_txt[1]);
					if (error_txt[0] != "no_txt")
						$("#" + error_txt[0]).focus();
				});
			}
		});
	}, "xml");
	return false;
}
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>
<%@ include file="../lib/dbclose_phi.jsp" %>