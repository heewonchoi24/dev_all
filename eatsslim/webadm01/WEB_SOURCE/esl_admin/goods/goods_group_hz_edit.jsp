<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%viewPage	= true;%>
<!-- %@ taglib uri="/WEB-INF/FCKeditor.tld" prefix="FCK" % -->
<%@ include file="../include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
int groupId			= 0;
String gubun2		= "";
String gubun3		= "";
String groupCode	= "";
String groupName	= "";
String groupInfo	= "";
String groupInfo1	= "";
String offerNotice	= "";
String cartImg		= "";
int groupPrice		= 0;
int groupPrice1		= 0;
int groupPrice2		= 0;
int groupPrice3		= 0;
int groupPrice4		= 0;
int kalInfo 		= 0;
String pgGroupCode	= "";
String pgGroupName	= "";
String goodsCode	= "";
String goodsName	= "";
int cid				= 0;
int amount			= 0;
int cateId			= 0;
String cateName		= "";
String keyword		= "";
String iPage		= ut.inject(request.getParameter("page"));
String pgsize		= ut.inject(request.getParameter("pgsize"));
String schGubun1	= ut.inject(request.getParameter("sch_gubun1"));
String schGubun2	= ut.inject(request.getParameter("sch_gubun2"));
String field		= ut.inject(request.getParameter("field"));
String groupImg     = "";
String listViewYn     = "";
String tag     = "";

String devlGoodsType			= "";
String devlFirstDay		= "";
String devlModiDay		= "";
String devlWeek3		= "";
String devlWeek5		= "";
String cateCode			= "";
String dispCateName		= "";
String dayEat			= "";



int noticeCt = 0;
List<Map> infoNoticeList = new ArrayList(); //-- ��ǰ����
List<Map> productNoticeList = new ArrayList(); //-- ��ǰ����
List<Map> deliveryNoticeList = new ArrayList(); //-- ��۰���
Map noticeMap = new HashMap(); //-- ���ÿ��� ���

if (request.getParameter("keyword") != null) {
	keyword				= ut.inject(request.getParameter("keyword"));
	keyword				= new String(keyword.getBytes("8859_1"), "EUC-KR");
}
String param		= "page="+ iPage +"&pgsize="+ pgsize +"&sch_gubun1="+ schGubun1 +"&sch_gubun2="+ schGubun2 +"&field="+ field +"&keyword="+ keyword;

if (request.getParameter("id") != null && request.getParameter("id").length() > 0) {
	groupId		= Integer.parseInt(request.getParameter("id"));

	query		= "SELECT GUBUN2, GUBUN3, GROUP_CODE, GROUP_NAME, GROUP_INFO, GROUP_INFO1, OFFER_NOTICE, CART_IMG, GROUP_PRICE, KAL_INFO, GROUP_IMGM, GROUP_IMGP, LIST_VIEW_YN, TAG, DEVL_GOODS_TYPE, DEVL_FIRST_DAY, DEVL_MODI_DAY, DEVL_WEEK3, DEVL_WEEK5, CATE_CODE, DISP_CATE_NAME, DAY_EAT";
	query		+= " FROM ESL_GOODS_GROUP ";
	query		+= " WHERE ID = "+ groupId;
	try {
		rs	= stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	if (rs.next()) {
		gubun2			= rs.getString("GUBUN2");
		gubun3			= rs.getString("GUBUN3");
		groupCode		= rs.getString("GROUP_CODE");
		groupName		= rs.getString("GROUP_NAME");
		groupInfo		= rs.getString("GROUP_INFO");
		groupInfo1		= rs.getString("GROUP_INFO1");
		offerNotice		= rs.getString("OFFER_NOTICE");
		cartImg			= rs.getString("CART_IMG");
		groupPrice		= rs.getInt("GROUP_PRICE");
		kalInfo			= rs.getInt("KAL_INFO");
		groupImg		= rs.getString("GROUP_IMGM");
		listViewYn		= rs.getString("LIST_VIEW_YN");
		tag				= rs.getString("TAG");
		devlGoodsType		= ut.isnull(rs.getString("DEVL_GOODS_TYPE") );
		devlFirstDay	= ut.isnull(rs.getString("DEVL_FIRST_DAY") );
		devlModiDay		= ut.isnull(rs.getString("DEVL_MODI_DAY") );
		devlWeek3		= ut.isnull(rs.getString("DEVL_WEEK3") );
		devlWeek5		= ut.isnull(rs.getString("DEVL_WEEK5") );
		cateCode		= ut.isnull(rs.getString("CATE_CODE") );
		dispCateName	= ut.isnull(rs.getString("DISP_CATE_NAME") );
		dayEat			= ut.isnull(rs.getString("DAY_EAT") );
	}
	if(groupInfo == null){
		groupInfo = "";
	}

	rs.close();

	//-- ��ǰ����
	query		= "SELECT ID, NOTICE_TITLE,	NOTICE_CONTENT ";
	query		+= " FROM ESL_GOODS_GROUP_NOTICE ";
	query		+= " WHERE NOTICE_TYPE='INFO' AND GOODS_GROUP_ID = "+ groupId;
	rs	= stmt.executeQuery(query);
	while(rs.next()){
		noticeMap = new HashMap();
		noticeMap.put("id",rs.getString("ID"));
		noticeMap.put("title",rs.getString("NOTICE_TITLE"));
		noticeMap.put("content",rs.getString("NOTICE_CONTENT"));
		infoNoticeList.add(noticeMap);
	}
	rs.close();

	//-- ��ǰ����
	query		= "SELECT ID, NOTICE_TITLE,	NOTICE_CONTENT ";
	query		+= " FROM ESL_GOODS_GROUP_NOTICE ";
	query		+= " WHERE NOTICE_TYPE='PRODUCT' AND GOODS_GROUP_ID = "+ groupId;
	rs	= stmt.executeQuery(query);
	while(rs.next()){
		noticeMap = new HashMap();
		noticeMap.put("id",rs.getString("ID"));
		noticeMap.put("title",rs.getString("NOTICE_TITLE"));
		noticeMap.put("content",rs.getString("NOTICE_CONTENT"));
		productNoticeList.add(noticeMap);
	}
	rs.close();

	//-- ��۰���
	query		= "SELECT ID, NOTICE_TITLE,	NOTICE_CONTENT ";
	query		+= " FROM ESL_GOODS_GROUP_NOTICE ";
	query		+= " WHERE NOTICE_TYPE='DELIVERY' AND GOODS_GROUP_ID = "+ groupId;
	rs	= stmt.executeQuery(query);
	while(rs.next()){
		noticeMap = new HashMap();
		noticeMap.put("id",rs.getString("ID"));
		noticeMap.put("title",rs.getString("NOTICE_TITLE"));
		noticeMap.put("content",rs.getString("NOTICE_CONTENT"));
		deliveryNoticeList.add(noticeMap);
	}
	rs.close();
}
if(groupImg == null){
	groupImg = "";
}
%>

	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:4,level_2:5,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
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
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="Ȩ" /> &gt; ��ǰ����&gt; ��Ʈ�׷���� &gt; <strong>�ǰ���</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form name="frm_write" id="frm_write" method="post" action="goods_group_hz_db.jsp" enctype="multipart/form-data">
					<input type="hidden" name="mode" value="upd" />
					<input type="hidden" name="id" value="<%=groupId%>" />
					<input type="hidden" name="param" value="<%=param%>" />
					<input type="hidden" name="gubun1" value="60" />
					<input type="hidden" name="org_cart_img" value="<%=cartImg%>" />
					<input type="hidden" name="org_group_img" value="<%=groupImg%>" />
					<table class="tableView" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="40%" />
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><span>����2</span></th>
								<td class="td_edit">
									<select name="gubun2" id="gubun2">
										<option value="">����</option>
									</select>
								</td>
								<th scope="row"><span>��Ʈ�׷��ڵ�</span></th>
								<td>
									<select name="group_code" id="group_code" required label="��Ʈ�׷��ڵ�" onchange="getGroup();">
										<option value="<%=groupCode%>"><%=groupCode+"("+groupName+")"%></option>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>��Ʈ�׷��</span></th>
								<td>
									<input type="text" class="input1" style="width:200px;" maxlength="50" name="group_name" id="group_name" value="<%=groupName%>" required label="��Ʈ�׷��" />
								</td>
								<th scope="row"><span>����</span></th>
								<td>
									<input type="text" class="input1" style="width:60px;" maxlength="7" name="group_price" id="group_price" value="<%=groupPrice%>" required label="����" dir="rtl" /> ��
								</td>
							</tr>
							<tr>
								<th scope="row"><span>�׷�����λ�</span></th>
								<td colspan="3">
									<input type="text" name="disp_cate_name" id="disp_cate_name" style="width:200px;" maxlength="50" value="<%=dispCateName%>"/>(�׷�� �տ� �� ī�װ�����)
								</td>
							</tr>
							<tr>
								<th scope="row"><span>�ļ���������</span></th>
								<td colspan="3">
									<input type="text" name="day_eat" id="day_eat" style="width:200px;" maxlength="50" value="<%=dayEat%>"/>(��: 1�� 3��)
								</td>
							</tr>
							<tr>
								<th scope="row"><span>����</span></th>
								<td colspan="3">
									<label><input type="radio" name="seen" value="N"<%=!"Y".equals(listViewYn) ? " checked":""%> /> �����</label>
									<label><input type="radio" name="seen" value="Y"<%="Y".equals(listViewYn) ? " checked":""%> /> ����</label>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>�±�</span></th>
								<td colspan="3">
									<label><input type="checkbox" name="tag" value="01"<%=tag.indexOf("01") != -1 ? " checked":""%> /> EVENT</label>
									<label><input type="checkbox" name="tag" value="02"<%=tag.indexOf("02") != -1 ? " checked":""%> /> Ư��</label>
									<label><input type="checkbox" name="tag" value="03"<%=tag.indexOf("03") != -1 ? " checked":""%> /> SALE</label>
									<label><input type="checkbox" name="tag" value="04"<%=tag.indexOf("04") != -1 ? " checked":""%> /> NEW</label>
									<label><input type="checkbox" name="tag" value="05"<%=tag.indexOf("05") != -1 ? " checked":""%> /> ��õ</label>
									<label><input type="checkbox" name="tag" value="06"<%=tag.indexOf("06") != -1 ? " checked":""%> /> ����Ʈ</label>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>��ǰ����</span></th>
								<td colspan="3">
									<input type="text" name="group_info1" id="group_info1" style="width:100%;" maxlength="50" value="<%=groupInfo1%>"/>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>���Į�θ�</span></th>
								<td colspan="3">
									<input type="text" name="kal_info" id="kal_info" class="input1" maxlength="50" value="<%=kalInfo%>"/>	Kcal	(���ڸ� ����)
								</td>
							</tr>
							<tr>
								<th scope="row"><span>��ǥ�̹���</span></th>
								<td colspan="3">
									<input type="file" name="group_img" value="" />
									<%if (!groupImg.equals("")) {%>
										<br /><input type="checkbox" name="del_group_img" value="y" />����<br />
										<img src="<%=webUploadDir +"goods/"+ groupImg%>"  width="200" />
									<%}%>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>ī�װ����ڵ�</span></th>
								<td colspan="3">
									<input type="text" name="cateCode" id="cateCode" size="20" maxlength="50" value="<%=cateCode%>"/>(�Ĵ����� : ī�װ��������� ī�װ����ڵ� ��:000000,111111)
								</td>
							</tr>
							<tr>
								<th scope="row"><span>��۱���</span></th>
								<td colspan="3">
									<label><input type="radio" name="devlGoodsType" value="0001"<%=!"0002".equals(devlGoodsType) ? " checked":""%> /> ���Ϲ��</label>
									<label><input type="radio" name="devlGoodsType" value="0002"<%="0002".equals(devlGoodsType) ? " checked":""%> /> �ù���</label>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>ù �����</span></th>
								<td colspan="3">
									<input type="text" name="devlFirstDay" id="devlFirstDay" size="4" maxlength="2" value="<%=devlFirstDay%>"/>(���ڷ� �Է� �ϼ���)
								</td>
							</tr>
							<tr>
								<th scope="row"><span>�������� �����</span></th>
								<td colspan="3">
									<input type="text" name="devlModiDay" id="devlModiDay" size="4" maxlength="2" value="<%=devlModiDay%>"/>(���ڷ� �Է� �ϼ���)
								</td>
							</tr>
							<tr>
								<th scope="row"><span>���Ϻ� ����</span></th>
								<td colspan="3">
									��3��:<input type="text" name="devlWeek3" id="devlWeek3" size="15" maxlength="50" value="<%=devlWeek3%>"/>��) 1,2,4,8<br />
									��5��:<input type="text" name="devlWeek5" id="devlWeek5" size="15" maxlength="50" value="<%=devlWeek5%>"/>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>��ǰ����</span></th>
								<td colspan="3">
									<table class="tableView" border="1" cellspacing="0">
										<colgroup>
											<col width="140px">
											<col>
										</colgroup>
										<tbody>
<%
noticeCt = 0;
for(Map nMap : infoNoticeList){
	noticeCt++;
%>
											<input type="hidden" name="info_notice_id" value="<%=nMap.get("id") %>">
											<tr>
												<th><span><input type="text" class="input4" id="info_notice_th_<%=noticeCt%>" name="info_notice_title" value="<%=nMap.get("title") %>"></span></th>
												<td><input type="text" class="input4" id="info_notice_td_<%=noticeCt%>" name="info_notice_content" value="<%=nMap.get("content") %>"></td>
											</tr>
<%
}
for(int v = noticeCt; v < 5; v++){
%>
											<input type="hidden" name="info_notice_id" value="0">
											<tr>
												<th><span><input type="text" class="input4" id="info_notice_th_<%=v%>" name="info_notice_title"></span></th>
												<td><input type="text" class="input4" id="info_notice_td_<%=v%>" name="info_notice_content"></td>
											</tr>
<%
}
%>
										</tbody>
									</table>
								</td>
							</tr>
						</tbody>
					</table>
					<br />
					<table class="tableView" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><span>��ǰ����</span></th>
								<td class="td_edit">
									<textarea id="group_info" name="group_info" style="width:90%;height:100px;" type=editor><%=groupInfo%></textarea>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>��۾ȳ�</span></th>
								<td class="">
									<table class="tableView" border="1" cellspacing="0">
										<colgroup>
											<col width="140px">
											<col>
										</colgroup>
										<tbody>
<%
noticeCt = 0;
for(Map nMap : deliveryNoticeList){
	noticeCt++;
%>
											<input type="hidden" name="delivery_notice_id" value="<%=nMap.get("id") %>">
											<tr>
												<th><span><input type="text" class="input4" id="delivery_notice_th_<%=noticeCt%>" name="delivery_notice_title" value="<%=nMap.get("title") %>"></span></th>
												<td><input type="text" class="input4" id="delivery_notice_td_<%=noticeCt%>" name="delivery_notice_content" value="<%=nMap.get("content") %>"></td>
											</tr>
<%
}
for(int v = noticeCt; v < 10; v++){
%>
											<input type="hidden" name="delivery_notice_id" value="0">
											<tr>
												<th><span><input type="text" class="input4" id="delivery_notice_th_<%=v%>" name="delivery_notice_title"></span></th>
												<td><input type="text" class="input4" id="delivery_notice_td_<%=v%>" name="delivery_notice_content"></td>
											</tr>
<%
}
%>
										</tbody>
									</table>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>��ǰ����<br />��������</span></th>
								<td class="">
									<table class="tableView" border="1" cellspacing="0">
										<colgroup>
											<col width="140px">
											<col>
										</colgroup>
										<tbody>
<%
noticeCt = 0;
for(Map nMap : productNoticeList){
	noticeCt++;
%>
											<input type="hidden" name="product_notice_id" value="<%=nMap.get("id") %>">
											<tr>
												<th><span><input type="text" class="input4" id="offer_notice_th_<%=noticeCt%>" name="product_notice_title" value="<%=nMap.get("title") %>"></span></th>
												<td><input type="text" class="input4" id="offer_notice_th_<%=noticeCt%>" name="product_notice_content" value="<%=nMap.get("content") %>"></td>
											</tr>
<%
}
for(int v = noticeCt; v < 30; v++){
%>
											<input type="hidden" name="product_notice_id" value="0">
											<tr>
												<th><span><input type="text" class="input4" id="offer_notice_th_<%=v%>" name="product_notice_title"></span></th>
												<td><input type="text" class="input4" id="offer_notice_th_<%=v%>" name="product_notice_content"></td>
											</tr>
<%
}
%>
										</tbody>
									</table>
								</td>
							</tr>
<%--
							<tr>
								<th scope="row"><span>��õ��ǰ</span></th>
								<td class="">
									<ul class="rec_prd_list">
										<li id="rec_prd_1">
											<input type="hidden" name="rec_prd_1" value="">
											<div class="photo"><img src="/dist/images/order/sample_order_list1.jpg"></div>
											<div class="title">�ﾾ����+�˶��� ����</div>
											<div class="btns">
												<a href="javascript:void(0);"  onclick="delRecPrd(1);">���� X</a>
											</div>
										</li>
										<li id="rec_prd_2">
											<input type="hidden" name="rec_prd_2" value="">
											<div class="photo"></div>
											<div class="title"></div>
											<div class="btns">
												<a href="javascript:void(0);" onclick="searchRecPrd(2);">�˻�</a>
											</div>
										</li>
										<li id="rec_prd_3">
											<input type="hidden" name="rec_prd_3" value="">
											<div class="photo"></div>
											<div class="title"></div>
											<div class="btns">
												<a href="javascript:void(0);" onclick="searchRecPrd(3);">�˻�</a>
											</div>
										</li>
										<li id="rec_prd_4">
											<input type="hidden" name="rec_prd_4" value="">
											<div class="photo"></div>
											<div class="title"></div>
											<div class="btns">
												<a href="javascript:void(0);" onclick="searchRecPrd(4);">�˻�</a>
											</div>
										</li>
									</ul>
								</td>
							</tr>
 --%>
						</tbody>
					</table>
					<div class="btn_center">
						<a href="javascript:;" onclick="setContent('group_info');chkForm(document.frm_write)"  class="function_btn"><span>����</span></a>
						<a href="goods_group_list.jsp?<%=param%>" class="function_btn"><span>���</span></a>
					</div>
				</form>
			</div>
			<!-- //contents -->
		</div>
		<!-- //incon -->
	</div>
	<!-- //container -->
</div>
<section id="searchRecPrd" class="modal">
    <div class="inner">
    	<button class="modal_close"><img src="../images/common/btn/btn_pop_close.png"></button>
    	<div class="modal_header">
			<h1>��ǰ�˻�</h1>
    	</div>
        <div class="modal_content">
        	<div class="searchArea">
				<form onsubmit="searchPrd(); return false;">
					<div class="ipt_group">
				    	<input type="text" class="ipt" name="searchPrdText" id="searchPrdText">
				    	<span class="ipt_right"><button type="submit" class="btn black">�˻�</button></span>
				    </div>
				</form>
        	</div>
        	<div class="searchResult">
        		<ul>
        			<!-- <li>
        				<a href="javascript:void(0);" onclick="setRecPrd(0001);">
        					<div class="photo"><img src="/dist/images/order/sample_order_list1.jpg"></div>
        					<div class="title">�ﾾ����+�˶��� ����</div>
        					<p>1�� 1��</p>
        				</a>
        			</li> -->
        			<!-- <li class="none">�˻��� ��ǰ�� �����ϴ�.</li> -->
        		</ul>
        	</div>
        </div>
    </div>
</section>
<!-- //wrap -->
<script type="text/javascript">
function setContent(str){
	$("#"+str).val($("#miniEditorIframe_"+str).get(0).contentDocument.body.innerHTML);
}
function getGroup() {
	$.post("goods_group_ajax.jsp", {
		mode: "getGroup",
		group_code: $("#group_code").val()
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				$(data).find("goodsName").each(function() {
					$("#group_name").val($(this).text());
				});
				$(data).find("goodsPrice").each(function() {
					$("#group_price").val($(this).text());
				});
			} else {
				$(data).find("error").each(function() {
					alert($(this).text());
					$("#group_name").val("");
					$("#group_price").val("");
				});
			}
		});
	}, "xml");
	return false;
}

function delTr(obj) {
	$(obj).parent().parent().remove();
}



var recPrdNum;
function searchRecPrd(id) {
	recPrdNum = id;
	modalFn.show($('#searchRecPrd'));
}

function delRecPrd(id) {
	$('input[name=rec_prd_'+id+']').val('');
	$('#rec_prd_'+id).find('.photo').html('');
	$('#rec_prd_'+id).find('.title').html('');
	$('#rec_prd_'+id).find('.btns').html('<a href="javascript:void(0);" onclick="searchRecPrd('+id+');">�˻�</a>');
}
function searchPrd() {
	var text = $("#searchPrdText").val();
	if(text == ""){
		alert("�˻�� �Է����ּ���!");
		return false;
	}else{
		var result = '';

		for (var i = 0; i < 5; i++) {
			result +=  '<li>';
			result +=		'<a href="javascript:void(0);" onclick="setRecPrd(this,0001);">';
	        result +=			'<div class="photo"><img src="/dist/images/order/sample_order_list1.jpg"></div>';
			result +=			'<div class="title">�ﾾ����+�˶��� ����</div>';
			result +=			'<p>1�� 1��</p>';
	        result +=		'</a>';
	        result +=	'</li>';
       	}

		$('.searchResult ul').html(result);
		$(window).resize();
	}
	return false;
}

function setRecPrd(t,id) {
	$('input[name=rec_prd_'+recPrdNum+']').val(id);
	$('#rec_prd_'+recPrdNum).find('.photo').html($(t).find('.photo').html());
	$('#rec_prd_'+recPrdNum).find('.title').html($(t).find('.title').html());
	$('#rec_prd_'+recPrdNum).find('.btns').html('<a href="javascript:void(0);"  onclick="delRecPrd('+recPrdNum+');">���� X</a>');

	modalFn.hide($('#searchRecPrd'));
	$(window).scrollTop($('#rec_prd_'+recPrdNum).offset().top);

}


</script>
<!-- �������� Ȱ��ȭ ��ũ��Ʈ -->
<script src="/editor/editor_board.js"></script>
<script>
	mini_editor('/editor/');
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>