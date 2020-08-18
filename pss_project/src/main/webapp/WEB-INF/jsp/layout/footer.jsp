<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
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
		
		$(".t1").html(content);
		$(".address").html(content2);
	}, function(jqXHR, textStatus, errorThrown){
		
	});	
		
});

function privacyPopUp() {
	
	var openParam = "height=768px, width=1000px";

	window.open("/html/privacyPopUp.jsp", "privacyPopUp", openParam);

}
</script>

<div class="footer_wrap">
	<div class="site_link">
		<form name="link_frm1" method="post" target="_blank" title="새창열림"
			onsubmit="return go_url(this);">
			<fieldset>
				<legend>소속기관 사이트 이동</legend>
				<select name="site_link" title="소속기관 선택">
					<option selected>소속기관</option>
					<option value="http://www.cdc.go.kr">질병관리본부</option>
					<option value="http://ncmh.go.kr">국립정신건강센터</option>
					<option value="http://www.najumh.go.kr">국립나주병원</option>
					<option value="http://www.bgnmh.go.kr">국립부곡병원</option>
					<option value="http://www.cnmh.go.kr">국립춘천병원</option>
					<option value="http://www.knmh.go.kr">국립공주병원</option>
					<option value="http://www.sorokdo.go.kr">국립소록도병원</option>
					<option value="http://www.ncr.go.kr">국립재활원</option>
					<option value="http://www.mnth.go.kr">국립마산병원</option>
					<option value="http://www.tbmokpo.go.kr">국립목포병원</option>
					<option value="http://osong.mohw.go.kr">오송생명과학단지지원센터</option>
					<option value="http://www.nmhc.go.kr">국립망향의동산관리원</option>
					<option value="http://www.">건강보험분쟁조정위원회사무국</option>
				</select>
				<button type="submit" name="submit" value="submit"
					class="button bt2 gray_l">이동</button>
			</fieldset>
		</form>
		<form name="link_frm2" method="post" target="_blank" title="새창열림"
			onsubmit="return go_url(this);" class="mt05">
			<fieldset>
				<legend>소속기관 사이트 이동</legend>
				<select name="site_link" title="관련기관 선택">
					<option selected>관련기관</option>
					<option value="http://www.nhis.or.kr">국민건강보험공단</option>
					<option value="http://www.nps.or.kr">국민연금공단</option>
					<option value="http://www.hira.or.kr">건강보험심사평가원</option>
					<option value="http://www.khidi.or.kr">한국보건산업진흥원</option>
					<option value="http://www.kordi.or.kr">한국노인인력개발원</option>
					<option value="http://www.ssis.or.kr">사회보장정보원</option>
					<option value="http://www.kohi.or.kr">한국보건복지인력개발원</option>
					<option value="http://www.ncc.re.kr">국립암센터</option>
					<option value="http://www.redcross.or.kr">대한적십자사</option>
					<option value="http://www.kuksiwon.or.kr">한국보건의료인국가시험원</option>
					<option value="http://www.koddi.or.kr">한국장애인개발원</option>
					<option value="http://www.kofih.org">한국국제보건의료재단</option>
					<option value="http://kncsw.bokji.net">한국사회복지혐의회</option>
					<option value="http://www.nmc.or.kr">국립중앙의료원</option>
					<option value="http://www.kcpi.or.kr">한국보육진흥원</option>
					<option value="http://www.khealth.or.kr">한국건강증진개발원</option>
					<option value="http://www.k-medi.or.kr">한국의료분쟁조정중재원</option>
					<option value="http://www.neca.re.kr">한국보건의료연구원</option>
					<option value="http://www.kbiohealth.kr">오송첨단의료산업진흥재단</option>
					<option value="http://www.dgmif.re.kr">대구경북첨담의료산업진흥재단</option>
					<option value="http://www.koda1458.kr">한국장기조직기증원</option>
					<option value="http://www.kptb.kr">한국공공조직은행</option>
					<option value="http://www.nikom.or.kr">한약진흥재단</option>
					<option value="http://www.koiha.kr">의료기관평가인증원</option>
					<option value="http://www.nibp.kr">국가생명윤리정책원</option>
				</select>
				<button type="submit" name="submit" value="submit"
					class="button bt2 gray_l">이동</button>
			</fieldset>
		</form>
	</div>
	<ul class="footer_util">
		<p class="t1"></p>
		<p class="address"></p>
	</ul>
</div>