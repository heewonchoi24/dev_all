<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%
String temp_no		= (String)session.getAttribute("esl_customer_num");
if(temp_no!=null){
	if(temp_no.equals("1")){//통합회원 sso에서 약관동의 안한 사람은 회원세션소멸
		session.setAttribute("esl_member_idx","");
		session.setAttribute("esl_member_id",null);
		session.setAttribute("esl_member_name","");
		session.setAttribute("esl_customer_num","");
		session.setAttribute("esl_member_code",""); //통합회원 구분
		response.sendRedirect("https://www.eatsslim.co.kr/sso/logout.jsp");if(true)return;
	}
}

String query        = "";
String query1       = "";
Statement stmt1     = null;
ResultSet rs1       = null;
SimpleDateFormat dt = new SimpleDateFormat("yyyy-MM-dd");
String today        = dt.format(new Date());

String groupName  = "";
String groupInfo1 = "";
String aType       = "";
String bType       = "";
int kalInfo          = 0;
int groupPrice1   = 0;
int totalPrice      = 0;
int bTypeNum      = 0;
String cartImg      = "";
String groupImg      = "";
String groupCode  = "";
String gubun2      = "";
String sikdan      = "";
String tag          = "";
String dayEat      = "";
double dBtype;
int groupPrice    = 0;

List<Integer> list_groupId = new ArrayList<Integer>();
List<String> list_groupCode = new ArrayList<String>();
List<String> list_groupName = new ArrayList<String>();

// 체험단 메뉴 리스트 가져오기
query         = " SELECT ID, GROUP_CODE, GROUP_NAME ";             
query        += " FROM ESL_GOODS_GROUP EGG ";
query        += " WHERE USE_YN = 'Y' ";
query        += " AND LIST_VIEW_YN = 'Y' ";
query        += " AND GUBUN1 = '01' ";
query        += " AND ID IN ('105','34','43','32','89') ";
query        += " ORDER BY GROUP_NAME ASC ";

try {
    rs = stmt.executeQuery(query);
} catch(Exception e) {
    System.out.println(e+"=>"+query);
    if(true)return;
}

while(rs.next()){
	list_groupId.add(rs.getInt("ID"));
    list_groupCode.add(rs.getString("GROUP_CODE"));
    list_groupName.add(rs.getString("GROUP_NAME"));

	//System.out.println(list_groupcode + " , " + list_groupname);
}
rs.close();
%>
</head>
<body>
<form method="post" name="frm_exp" id="frm_exp">
	<input type="hidden" id="groupId" name="groupId" value="" />
	<input type="hidden" id="groupCode" name="groupCode" value="" />
</form>
<div id="wrap">

    <div class="ui-header-fixed ui-shadow" style="overflow:hidden;">
       <%@ include file="/mobile/common/include/inc-header.jsp"%>
    </div>
    <!-- End ui-header -->
    <!-- Start Content -->
    <div id="content">
        <h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">체험단</span></span></h1>
        <div class="row">
			<div id="experience_content">
				<img src="/images/experience/exp_event_img_01.jpg" />
				<div class="experience_item_list">
					<ul>
					<%
					for(int i = 0; i < list_groupCode.size(); i++){
					
						if(list_groupCode.get(i).equals("0301544")){
						%>
						<li>
							<input type="radio" name="exp_item" id="exp_item_01" group_id="<%=list_groupId.get(i)%>" group_code="0301544">
							<label for="exp_item_01">
								<img src="/images/experience/exp_item_img_01.jpg" />
								<div class="chk" group_id="<%=list_groupId.get(i)%>" group_code="0301544"></div>
							</label>
						</li>	
						<%
						}
						if(list_groupCode.get(i).equals("0300719")){
						%>
						<li>
							<input type="radio" name="exp_item" id="exp_item_02" group_id="<%=list_groupId.get(i)%>" group_code="0300719">
							<label for="exp_item_02">
								<img src="/images/experience/exp_item_img_02.jpg" />
								<div class="chk" ></div>
							</label>
						</li>
						<%
						}
						if(list_groupCode.get(i).equals("0300957")){
						%>
						<li>
							<input type="radio" name="exp_item" id="exp_item_03" group_id="<%=list_groupId.get(i)%>" group_code="0300957">
							<label for="exp_item_03">
								<img src="/images/experience/exp_item_img_03.jpg" />
								<div class="chk" ></div>
							</label>
						</li>
						<%
						}
						if(list_groupCode.get(i).equals("0300717")){
						%>
						<li>
							<input type="radio" name="exp_item" id="exp_item_04" group_id="<%=list_groupId.get(i)%>" group_code="0300717">
							<label for="exp_item_04">
								<img src="/images/experience/exp_item_img_04.jpg" />
								<div class="chk" ></div>
							</label>
						</li>
						<%
						}
						if(list_groupCode.get(i).equals("0301369")){
						%>
						<li>
							<input type="radio" name="exp_item" id="exp_item_05" group_id="<%=list_groupId.get(i)%>" group_code="0301369">
							<label for="exp_item_05">
								<img src="/images/experience/exp_item_img_05.jpg" />
								<div class="chk" ></div>
							</label>
						</li>
						<%
						}
					}
					%>
					</ul>
				</div>
				<div class="experience_item_req">
					<a href="#" class="btn_go_order"><img src="/images/experience/exp_event_btn.jpg" /></a>
				</div>
				<img src="/images/experience/exp_event_img_02.jpg" />
			</div>
        </div>
    </div>
    <!-- End Content -->
    <div class="ui-footer">
       <%@ include file="/mobile/common/include/inc-footer.jsp"%>
    </div>
</div>
<!-- 미디어큐브 스크립트 2016-06-24 -->
<script language='JavaScript1.1' src='//pixel.mathtag.com/event/js?mt_id=1035515&mt_adid=158356&v1=&v2=&v3=&s1=&s2=&s3='></script>

</body>
<script>
//로그인 N 팝업
var eslMemberId = '<%=eslMemberId%>';
$(".btn_go_order").click(function(){
   if(eslMemberId != ""){
		$(':radio[name="exp_item"]:checked').each(function() {
			var group_code = $(this).attr("group_code");
			var group_id = $(this).attr("group_id");
			$("#groupCode").val(group_code);	
			$("#groupId").val(group_id);	
		});

	   if($(':radio[name="exp_item"]:checked').length < 1){
			alert("체험단 메뉴를 선택해주세요.");
			return false;
	   }else{

			$.post("experience_ajax.jsp", $("#frm_exp").serialize(),
			function(data) {
				$(data).find("result").each(function() {
					//alert($(this).text());
					if ($(this).text() == "success") {
						location.href='/mobile/shop/order.jsp?mode=L&promotion=exp';
					} else {
						$(data).find("error").each(function() {
							$(data).find("error").each(function() {
								alert($(this).text());
							});
						});
					}
				});
			}, "xml");
			return false;
	   }
   }else{
	    var msg = "로그인이 필요한 서비스 입니다. 로그인 하시겠습니까? (소셜로그인은 체험단 신청이 불가합니다.)";
		if (confirm(msg)) {
			var url = "/mobile/customer/login.jsp";
			$(location).attr('href',url);
		}else{
			return true;
		}
   }
});
</script>
</html>