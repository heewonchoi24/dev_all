<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta http-equiv="Cache-Control" content="no-cache"/>
	<meta http-equiv="Expires" content="0"/>
	<meta http-equiv="Pragma" content="no-cache"/>
	<meta name="robots" content="noindex,nofollow,noarchive">

	<title>�ս��� ��ǰ ������</title>

	<link rel="stylesheet" type="text/css" media="all" href="http://www.eatsslim.com/common/css/layout.css" />
    <link rel="stylesheet" type="text/css" media="all" href="http://www.eatsslim.com/common/css/skeleton.css" />
    <!--[if gte IE 9]>
	<style type="text/css">
	.gradient {filter: none;}
	</style>
    <![endif]-->
<%
request.setCharacterEncoding("euc-kr");

String query			= "";
int setId				= 0;
String cateName			= "";
String setName			= "";
String setInfo			= "";
String bigImg			= "";
String imgUrl			= "";
String portionSize		= "";
String calorie			= "";
String carbohydrateG	= "";
String carbohydrateP	= "";
String sugarG			= "";
String sugarP			= "";
String proteinG			= "";
String proteinP			= "";
String fatG				= "";
String fatP				= "";
String saturatedFatG	= "";
String saturatedFatP	= "";
String transFatG		= "";
String transFatP		= "";
String cholesterolG		= "";
String cholesterolP		= "";
String natriumG			= "";
String natriumP			= "";
String makeDate			= "";
int tcnt				= 0;

if (request.getParameter("set_id") != null && request.getParameter("set_id").length() > 0) {
	setId	= Integer.parseInt(request.getParameter("set_id"));

	query		= "SELECT SET_NAME, SET_INFO, BIG_IMG, PORTION_SIZE, CALORIE, CARBOHYDRATE_G, CARBOHYDRATE_P,";
	query		+= "	SUGAR_G, SUGAR_P, PROTEIN_G, PROTEIN_P, FAT_G, FAT_P, SATURATED_FAT_G, SATURATED_FAT_P,";
	query		+= "	TRANS_FAT_G, TRANS_FAT_P, CHOLESTEROL_G, CHOLESTEROL_P, NATRIUM_G, NATRIUM_P, MAKE_DATE,";
	query		+= "	(SELECT CATE_NAME FROM ESL_GOODS_CATEGORY WHERE ID = CATEGORY_ID) CATE_NAME";
	query		+= " FROM ESL_GOODS_SET S, ESL_GOODS_SET_CONTENT SC ";
	query		+= " WHERE S.ID = SC.SET_ID AND S.ID = "+ setId;
	try {
		rs = stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e);
		if(true)return;
	}

	if (rs.next()) {
		cateName		= rs.getString("CATE_NAME");
		setName			= rs.getString("SET_NAME");
		setInfo			= rs.getString("SET_INFO");
		bigImg			= rs.getString("BIG_IMG");
		if (bigImg.equals("") || bigImg == null) {
			imgUrl		= "/images/popup_quizin_sample.jpg";
		} else {			
			imgUrl		= webUploadDir +"goods/"+ bigImg;
		}
		portionSize		= rs.getString("PORTION_SIZE");
		calorie			= rs.getString("CALORIE");
		carbohydrateG	= (rs.getString("CARBOHYDRATE_G").equals(""))? "" : rs.getString("CARBOHYDRATE_G") + "<sub>g</sub>";
		carbohydrateP	= (rs.getString("CARBOHYDRATE_P").equals(""))? "" : rs.getString("CARBOHYDRATE_P") + "<sub>%</sub>";
		sugarG			= (rs.getString("SUGAR_G").equals(""))? "" : rs.getString("SUGAR_G") + "<sub>g</sub>";
		sugarP			= (rs.getString("SUGAR_P").equals(""))? "" : rs.getString("SUGAR_P") + "<sub>%</sub>";
		proteinG		= (rs.getString("PROTEIN_G").equals(""))? "" : rs.getString("PROTEIN_G") + "<sub>g</sub>";
		proteinP		= (rs.getString("PROTEIN_P").equals(""))? "" : rs.getString("PROTEIN_P") + "<sub>%</sub>";
		fatG			= (rs.getString("FAT_G").equals(""))? "" : rs.getString("FAT_G") + "<sub>g</sub>";
		fatP			= (rs.getString("FAT_P").equals(""))? "" : rs.getString("FAT_P") + "<sub>%</sub>";
		saturatedFatG	= (rs.getString("SATURATED_FAT_G").equals(""))? "" : rs.getString("SATURATED_FAT_G") + "<sub>g</sub>";
		saturatedFatP	= (rs.getString("SATURATED_FAT_P").equals(""))? "" : rs.getString("SATURATED_FAT_P") + "<sub>%</sub>";
		transFatG		= (rs.getString("TRANS_FAT_G").equals(""))? "" : rs.getString("TRANS_FAT_G") + "<sub>g</sub>";
		transFatP		= (rs.getString("TRANS_FAT_P").equals(""))? "" : rs.getString("TRANS_FAT_P") + "<sub>%</sub>";
		cholesterolG	= (rs.getString("CHOLESTEROL_G").equals(""))? "" : rs.getString("CHOLESTEROL_G") + "<sub>mg</sub>";
		cholesterolP	= (rs.getString("CHOLESTEROL_P").equals(""))? "" : rs.getString("CHOLESTEROL_P") + "<sub>%</sub>";
		natriumG		= (rs.getString("NATRIUM_G").equals(""))? "" : rs.getString("NATRIUM_G") + "<sub>mg</sub>";
		natriumP		= (rs.getString("NATRIUM_P").equals(""))? "" : rs.getString("NATRIUM_P") + "<sub>%</sub>";
		makeDate		= rs.getString("MAKE_DATE");
	}

	rs.close();
} else {
%>
<script type="text/javascript">
$.lightbox().close();
</script>
<%
}
%>

</head>
<body>
<div class="pop-wrap">
	<div class="headpop">
		<h2><%=cateName%></h2>
		<p></p>
	</div>
	<div class="contentpop">
		<div class="popup columns offset-by-one">
			<h4><%=setName%> <span class="f13">��1ȸ ������ <%=portionSize%>g</span></h4>
			<div class="row">
				<div class="one last col">
					<ul class="listSort" style="margin-bottom:0;">
						<li><span class="current">���缺��ǥ</span></li>
						<!--li><a href="#">��ǰ�����������</a></li-->
					</ul>
				</div>
				<div class="clear"></div>
			</div>
			<!-- End row -->
			<div class="row">
				<div class="one last col">
					<p>
						* ���ظ� �������� �������� �� ��ǰ�� ���̰� ���� �� �ֽ��ϴ�.<br />
						* ���� ���޵��� ������ �� ��ǰ�� ����� �� �ֽ��ϴ�.
					</p>
                    <div class="foodinfo-img">
						<img src="<%=imgUrl%>" alt="�޴�����" width="710" height="265" />
						<div class="info-caption">
							<h3>�޴�����</h3>
							<p><%=setInfo%></p>
						</div>
					</div>
				</div>
			</div>
			<!-- End row -->
			<div class="row">
				<div class="one last col">
					<h2 class="floatleft">���� <%=calorie%>kcal</h2>
					<span class="floatright">%����� ����ġ : 1�� ����� ����ġ�� ���� ����</span>
					<div class="clear"></div>
				</div>
				<div class="one last col">
					<table class="spectable" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th></th>
							<th>ź��ȭ��</th>
							<th>���</th>
							<th>�ܹ���</th>
							<th>����</th>
							<th>��ȭ����</th>
							<th>Ʈ��������</th>
							<th>�ݷ���Ʈ��</th>
							<th>��Ʈ��</th>
						</tr>
						<tr>
							<th>1ȸ �������� �Է�</th>
							<td><span class="mg01"><%=carbohydrateG%></span></td>
							<td><span class="mg02"><%=sugarG%></span></td>
							<td><span class="mg03"><%=proteinG%></span></td>
							<td><span class="mg04"><%=fatG%></span></td>
							<td><span class="mg05"><%=saturatedFatG%></span></td>
							<td><span class="mg06"><%=transFatG%></span></td>
							<td><span class="mg07"><%=cholesterolG%></span></td>
							<td class="last"><span class="mg08"><%=natriumG%></span></td>
						</tr>
						<tr>
							<th>%����� ����ġ</th>
							<td><span class="mg01"><%=carbohydrateP%></span></td>
							<td><span class="mg02"><%=sugarP%></span></td>
							<td><span class="mg03"><%=proteinP%></span></td>
							<td><span class="mg04"><%=fatP%></span></td>
							<td><span class="mg05"><%=saturatedFatP%></span></td>
							<td><span class="mg06"><%=transFatP%></span></td>
							<td><span class="mg07"><%=cholesterolP%></span></td>
							<td class="last"><span class="mg08"><%=natriumP%></span></td>
						</tr>
					</table>
				</div>
			</div>
			<!-- End row -->
			<%
			query		= "SELECT COUNT(ID) FROM ESL_GOODS_SET_ORIGIN WHERE SET_ID = "+ setId;
			try {
				rs = stmt.executeQuery(query);
			} catch(Exception e) {
				out.println(e+"=>"+query);
				if(true)return;
			}
			if (rs.next()) {
				tcnt = rs.getInt(1); //�� ���ڵ� ��		
			}

			rs.close();

			query		= "SELECT PRDT_NAME, PRDT_TYPE, PRODUCER, RAW_MATERIALS FROM ESL_GOODS_SET_ORIGIN ";
			query		+= " WHERE SET_ID = "+ setId;
			try {
				rs = stmt.executeQuery(query);
			} catch(Exception e) {
				out.println(e+"=>"+query);
				if(true)return;
			}
			if (tcnt > 0) {
			%>
			<div class="row">
				<div class="one last col">
					<table class="spectable" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th width="20%">��ǰ��</th>
							<th width="20%">��ǰ�� ����</th>
							<th width="20%">������ �� ������</th>
							<th width="40%">������ �� �Է�</th>
						</tr>
						<%						
						String prdtName			= "";
						String prdtType			= "";
						String producer			= "";
						String rawMaterials		= "";

						while (rs.next()) {
							prdtName		= rs.getString("PRDT_NAME");
							prdtType		= rs.getString("PRDT_TYPE");
							producer		= rs.getString("PRODUCER");
							rawMaterials	= rs.getString("RAW_MATERIALS");
						%>
						<tr>
							<td><%=prdtName%></td>
							<td><%=prdtType%></td>
							<td><%=producer%></td>
							<td class="last center"><%=rawMaterials%></td>
						</tr>
						<%
						}
						%>
					</table>
				</div>
			</div>
			<%
			}
			%>
			<!-- End row -->
			<div class="row">
				<div class="one last col">
					<div class="guide">
						<ul>
							<li><%=makeDate%></li>
							<li>���� : �ս��� ������ ���� ���Ǵ� <strong>�����ս��� 1:1 ����</strong> �Ǵ� <strong>�� 080-022-0085</strong>�� �����ּ���.</li>
						</ul>
					</div>
				</div>
			</div>
			<!-- End row -->
		</div>
		<!-- End popup columns offset-by-one -->
	</div>
	<!-- End contentpop -->
</div>
</body>
</html>
<%@ include file="/lib/dbclose.jsp"%>