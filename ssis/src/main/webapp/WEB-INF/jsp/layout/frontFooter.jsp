<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
 
<script>
$(document).ready(function(){
	
	pUrl = "/footer/getfooterText.do";
	pParam = {};

	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
		var	content = data.CONTENT; 	
		var	content2 = data.CONTENT2;
		
		$(".t1.add2").html(content);
		$(".address.2").html(content2);
	}, function(jqXHR, textStatus, errorThrown){
		
	});	
		
});
</script>

<footer id="footer">
  <h1 class="blind">하단 메뉴</h1>
  <div class="inr-c clearfix">
      <div class="area_lft">
		<p class="t1 add2"></p>
		<p class="address 2"></p>
      </div>
      <!-- //left -->
      <div class="area_rgh">
        <div class="area-col">
          <div class="box-select-ty1 footer up familySite">
            <div class="selectVal" tabindex="0"><a href="#this" tabindex="-1">소속기관</a></div>
             <ul class="selectMenu">
                <li><a href="http://www.cdc.go.kr" target="_blank">질병관리본부</a></li>
                <li><a href="http://ncmh.go.kr" target="_blank">국립정신건강센터</a></li>
                <li><a href="http://www.najumh.go.kr" target="_blank">국립나주병원</a></li>
                <li><a href="http://www.bgnmh.go.kr" target="_blank">국립부곡병원</a></li>
                <li><a href="http://www.cnmh.go.kr" target="_blank">국립춘천병원</a></li>
                <li><a href="http://www.knmh.go.kr" target="_blank">국립공주병원</a></li>
                <li><a href="http://www.sorokdo.go.kr" target="_blank">국립소록도병원</a></li>
                <li><a href="http://www.ncr.go.kr" target="_blank">국립재활원</a></li>
                <li><a href="http://www.mnth.go.kr" target="_blank">국립마산병원</a></li>
                <li><a href="http://www.tbmokpo.go.kr" target="_blank">국립목포병원</a></li>
                <li><a href="http://osong.mohw.go.kr" target="_blank">오송생명과학단지지원센터</a></li>
                <li><a href="http://www.nmhc.go.kr" target="_blank">국립망향의동산관리원</a></li>
                <li><a href="http://www." target="_blank">건강보험분쟁조정위원회사무국</a></li>
             </ul>
          </div>
        </div>
        <!-- //area-col -->

        <div class="area-col">
          <div class="box-select-ty1 footer up familySite">
            <div class="selectVal" tabindex="0"><a href="#this" tabindex="-1">관련기관</a></div>
             <ul class="selectMenu">
                <li><a href="http://www.nhis.or.kr" target="_blank">국민건강보험공단</a></li>
                <li><a href="http://www.nps.or.kr" target="_blank">국민연금공단</a></li>
                <li><a href="http://www.hira.or.kr" target="_blank">건강보험심사평가원</a></li>
                <li><a href="http://www.khidi.or.kr" target="_blank">한국보건산업진흥원</a></li>
                <li><a href="http://www.kordi.or.kr" target="_blank">한국노인인력개발원</a></li>
                <li><a href="http://www.ssis.or.kr" target="_blank">사회보장정보원</a></li>
                <li><a href="http://www.kohi.or.kr" target="_blank">한국보건복지인력개발원</a></li>
                <li><a href="http://www.ncc.re.kr" target="_blank">국립암센터</a></li>
                <li><a href="http://www.redcross.or.kr" target="_blank">대한적십자사</a></li>
                <li><a href="http://www.kuksiwon.or.kr" target="_blank">한국보건의료인국가시험원</a></li>
                <li><a href="http://www.koddi.or.kr" target="_blank">한국장애인개발원</a></li>
                <li><a href="http://www.kofih.org" target="_blank">한국국제보건의료재단</a></li>
                <li><a href="http://kncsw.bokji.net" target="_blank">한국사회복지혐의회</a></li>
                <li><a href="http://www.nmc.or.kr" target="_blank">국립중앙의료원</a></li>
                <li><a href="http://www.kcpi.or.kr" target="_blank">한국보육진흥원</a></li>       
                <li><a href="http://www.khealth.or.kr" target="_blank">한국건강증진개발원</a></li>
                <li><a href="http://www.k-medi.or.kr" target="_blank">한국의료분쟁조정중재원</a></li>
                <li><a href="http://www.neca.re.kr" target="_blank">한국보건의료연구원</a></li>
                <li><a href="http://www.kbiohealth.kr" target="_blank">오송첨단의료산업진흥재단</a></li>
                <li><a href="http://www.dgmif.re.kr" target="_blank">대구경북첨담의료산업진흥재단</a></li>
                <li><a href="http://www.koda1458.kr" target="_blank">한국장기조직기증원</a></li>
                <li><a href="http://www.kptb.kr" target="_blank">한국공공조직은행</a></li>
                <li><a href="http://www.nikom.or.kr" target="_blank">한약진흥재단</a></li>
                <li><a href="http://www.koiha.kr" target="_blank">의료기관평가인증원</a></li>
                <li><a href="http://www.nibp.kr" target="_blank">국가생명윤리정책원</a></li>     
             </ul>
          </div>
        </div>
        <!-- //area-col -->

      </div>
      <!-- //area_right -->
  </div>
  <!-- //inr-c -->
</footer>

<!-- Quick Menu -->
<script type="text/javascript">
if(pageNum == "0"){
  $(function(){
     // 퀵메뉴 스크립트
     $(".wrap_quickMenu").quickMenuFixed({
        wrap : "#container",
        standard : "#spot.main",
        lftSizeObj : ".main-page.banner .inr-c",
        headerFixed : true,
        marginLft : 15
     });
  })
}
</script>
<script type="text/javascript">
if(pageNum != "0"){
  $(function(){
     // 퀵메뉴 스크립트
     $(".wrap_quickMenu").quickMenuFixed({
        wrap : "#container",
        standard : "#container",
        lftSizeObj : "#container .container_inner",
        headerFixed : true,
        marginLft : 15,
        marginTop : 42
     });
  })
}
</script>
<!--// Quick Menu -->

<script src="/resources/front/js/sub.layout.js"></script>
<script>
$(function(){
	var pUrl = "/admin/contact/quickMenuCall.do";
	var pParam = {};
    pParam.open_yn = "Y";
    
	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
		var i = data["quickMenuList"];
		var str = "";
		if(i.length == 0) return false;
		if(i.ICON_NM != '' && i.LINK != '' && i.IMG_PATH != '' && i.IMG_NM != ''){
			$("#ajax_quickMenu").css("display", "block");
			for(var k = 0; k < i.length; k++){
				str += "<li><div class='ico'>"
				str += "<a href='#' onclick="+'move("'+i[k].LINK+'"); return false;'+">"
				str += "<img src = '"+i[k].IMG_PATH+"/"+i[k].IMG_NM+"' alt = '이미지'>"
				str += "</a></div>";
				str += "<div class='txt'>";
				str += "<a href='#' onclick="+'move("'+i[k].LINK+'"); return false;'+">"+i[k].ICON_NM+"</a>";
				str += "</div></li>";
			}
			$(".wrap_quickMenu .area_cont ul").after(str);
		}
	}, function(jqXHR, textStatus, errorThrown){
		
	});
})
</script>

<!-- Quick Menu -->
<c:if test="${'1' eq sessionScope.userInfo.authorId or '2' eq sessionScope.userInfo.authorId}">
	<div id="ajax_quickMenu">
		<div class="wrap_quickMenu">
			<header class="head">
				<h1>QUICK<br>MENU</h1>
			</header>
		   	<div class="area_cont">
		       	<ul></ul>
		    </div>
		</div>
	</div>
</c:if>
<!--// Quick Menu -->