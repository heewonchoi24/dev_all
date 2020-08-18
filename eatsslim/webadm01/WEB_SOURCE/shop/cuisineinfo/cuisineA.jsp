<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%
request.setCharacterEncoding("euc-kr");
String query 	= "";
String setId	= ut.inject(request.getParameter("set_id") );
String caregoryCode		= ut.inject(request.getParameter("caregoryCode") );
//System.out.println(caregoryCode);
query		= "SELECT ";
query		+= " 		(SELECT CATE_NAME FROM ESL_GOODS_CATEGORY WHERE ID = a.CATEGORY_ID) CATE_NAME, ";
query		+= " 		a.SET_NAME, a.BIG_IMG, b.PORTION_SIZE, c.PRDT_NAME, a.SET_INFO, c.PRDT_TYPE, c.PRODUCER, c.RAW_MATERIALS, b.CALORIE, ";
query		+= " 		b.CARBOHYDRATE_G, b.CARBOHYDRATE_P, b.SUGAR_G, b.SUGAR_P, b.PROTEIN_G, b.PROTEIN_P, ";
query		+= " 		b.FAT_G, b.FAT_P, b.SATURATED_FAT_G, b.SATURATED_FAT_P, b.TRANS_FAT_G, b.TRANS_FAT_P, b.CHOLESTEROL_G, b.CHOLESTEROL_P, b.NATRIUM_G, b.NATRIUM_P ";
query		+= " FROM ESL_GOODS_SET a ,ESL_GOODS_SET_CONTENT b, ESL_GOODS_SET_ORIGIN c";
query		+= " WHERE a.ID = b.SET_ID";
query		+= " AND a.ID = c.SET_ID";
query		+= " AND a.USE_YN = 'Y'";
query		+= " AND a.ID = '"+setId+"'";

System.out.println(query);

pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();

String cateName			= "";
String setName 			= "";
String portionSize 		= "";
String setInfo			= "";
String prdtType			= "";
String producer			= "";
String rawMaterials		= "";
String calorie			= "";
String carbohydrateG	= "";
String carbohydrateP	= "";
String sugarG			= "";
String sugarP  	        = "";
String proteinG	        = "";
String proteinP         = "";
String fatG	            = "";
String fatP	            = "";
String saturatedFatG	= "";
String saturatedFatP    = "";
String transFatG	    = "";
String transFatP        = "";
String cholesterolG     = "";
String cholesterolP     = "";
String natriumG         = "";
String natriumP         = "";
String prdtName			= "";
String bigImg			= "";
if(rs.next()){
	cateName = ut.isnull(rs.getString("CATE_NAME") );
	setName = rs.getString("SET_NAME");
	portionSize = rs.getString("PORTION_SIZE");
	setInfo = rs.getString("SET_INFO");
	prdtType = rs.getString("PRDT_TYPE");
	producer = rs.getString("PRODUCER");
	rawMaterials = rs.getString("RAW_MATERIALS");
	calorie = rs.getString("CALORIE");
	carbohydrateG = rs.getString("CARBOHYDRATE_G");
	carbohydrateP = rs.getString("CARBOHYDRATE_P");
	sugarG = rs.getString("SUGAR_G");
	sugarP = rs.getString("SUGAR_P");
	proteinG = rs.getString("PROTEIN_G");
	proteinP = rs.getString("PROTEIN_P");
	fatG = rs.getString("FAT_G");
	fatP = rs.getString("FAT_P");
	saturatedFatG = rs.getString("SATURATED_FAT_G");
	saturatedFatP = rs.getString("SATURATED_FAT_P");
	transFatG = rs.getString("TRANS_FAT_G");
	transFatP = rs.getString("TRANS_FAT_P");
	cholesterolG = rs.getString("CHOLESTEROL_G");
	cholesterolP = rs.getString("CHOLESTEROL_P");
	natriumG = rs.getString("NATRIUM_G");
	natriumP = rs.getString("NATRIUM_P");
	prdtName = rs.getString("PRDT_NAME");
	bigImg = rs.getString("BIG_IMG");
}
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<title>��ǰ ������</title>
</head>
<body>
<div class="pop-wrap-info">
	<div class="headerpop">
		<h2><%=cateName%></h2>
	</div>
	<div class="contentpop">
		<div class="info_summary">
			<div class="info_thumbnail">
				<img src="/data/goods/<%=bigImg %>" alt="�޴�����" width="450" height="450" />
				<p>* ���ظ� �������� �������� �� ��ǰ�� ���̰� ���� �� �ֽ��ϴ�.</p>
			</div>
			<div class="info_txt">
				<div class="info_summary_header">
					<h3><%=setName %><span class="title_bg"></span></h3>

					<p>��1ȸ ������ <%=portionSize %>g</p>
				</div>
				<div class="info_summary_cont">
					<%=setInfo %>
				</div>
			</div>
		</div>
		<div class="info_detail">
			<div class="info_detail_header">
				<h4>��������</h4>
				<p>�� ���뷮 <%=portionSize %>g, <%=calorie %>kcal</p>
			</div>
			<div class="info_detail_cont">
				<div class="info_detail_spec1">
					<table class="spectable">
						<thead>
							<tr>
								<th></th>
								<th>ź��ȭ��</th>
								<th>���</th>
								<th>�ܹ���</th>
								<th>����</th>
								<th>��ȭ����</th>
								<th>Ʈ��������</th>
								<th>�ݷ����׷�</th>
								<th>��Ʈ��</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th>�� �Է�</th>
								<td><span class="mg01"><%=carbohydrateG %><sub>g</sub></span></td>
								<td><span class="mg02"><%=sugarG %><sub>g</sub></span></td>
								<td><span class="mg03"><%=proteinG %><sub>g</sub></span></td>
								<td><span class="mg04"><%=fatG %><sub>g</sub></span></td>
								<td><span class="mg05"><%=saturatedFatG %><sub>g</sub></span></td>
								<td><span class="mg06"><%=transFatG %><sub>g</sub></span></td>
								<td><span class="mg07"><%=cholesterolG %><sub>mg</sub></span></td>
								<td><span class="mg08"><%=natriumG %><sub>mg</sub></span></td>
							</tr>
							<tr>
								<th>%���缺�� ����ġ</th>
								<td><span class="mg01"><%=carbohydrateP %><sub>%</sub></span></td>
								<td><span class="mg02"><%=sugarP %></span></td>
								<td><span class="mg03"><%=proteinP %><sub>%</sub></span></td>
								<td><span class="mg04"><%=fatP %><sub>%</sub></span></td>
								<td><span class="mg05"><%=saturatedFatP %><sub>%</sub></span></td>
								<td><span class="mg06"><%=transFatP %></span></td>
								<td><span class="mg07"><%=cholesterolP %><sub>%</sub></span></td>
								<td><span class="mg08"><%=natriumP %><sub>%</sub></span></td>
							</tr>
						</tbody>
					</table>
					<p>1�� ���缺�� ����ġ�� ���� ����(%)�� 2,000 kcal �����̹Ƿ� ������ �ʿ� ������ ���� �ٸ� �� �ֽ��ϴ�.</p>
				</div>
				<div class="info_detail_spec2">
					<table class="spectable2">
						<tbody>
							<tr>
								<th>��ǰ��</th>
								<td><%=setName %></td>
							</tr>
							<tr>
								<th>��ǰ�� ����</th>
								<td><%=prdtType %></td>
							</tr>
							<tr>
								<th>������ �� ������</th>
								<td><%=producer %></td>
							</tr>
							<tr>
								<th>������ �� �Է�</th>
								<td><%=rawMaterials %></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="info_detail_footer">
				<div class="info_detail_tip">
					<ul>
						<li>�ս����� ���е鲲 �� ���� ��ǰ�� �����ص帮���� ������, ������� ���� ���� �޴��� ���������� �����ϰ� �ֽ��ϴ�.</li>
						<li>������ �� ��ǰ�� ���̰� ���� �� �ִ� �� ���� ��Ź�帳�ϴ�.</li>
						<li>�ս��������� ���ʿ��� ��ȸ��ǰ ����� ���̰�, ���̾�Ʈ �Ľ����� ����̱� ���ؼ� �Ϻ� �޴��� �������� �����˴ϴ�.</li>
						<li>500 ����:�������� ���� / 400������:�Ϻ� �޴� ������ ���� / 300������:��ũ / 300����:����Ű / 400������:�Ϻ� �޴� ������ ����</li>
					</ul>
				</div>
				<div class="info_detail_caption">
					<p>��ǰ������ : 27�ð� �̳� ���� / ������� : �����Ϸκ��� 52�ð� �̳�(�����ϱ���)<br>�ս����� ���� ���Ǵ� ���������� 1:1 ���� �Ǵ� �� 080-800-0434�� �����ּ���.</p>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
<%@ include file="/lib/dbclose.jsp"%>