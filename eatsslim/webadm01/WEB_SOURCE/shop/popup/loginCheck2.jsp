<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<script type="text/javascript">
var returnUrl = location.pathname + location.search;
if(returnUrl == null && returnUrl == "") returnUrl = "/";
document.cookie = "returnUrl" + "=" + escape(returnUrl) + "; path=/;";
</script>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />

	<title>로그인</title>
</head>
<body>
	<div class="pop-wrap ff_noto">
		<div class="headpop">
		    <h2>로그인</h2>
			
		</div>
	    <div class="contentpop">
		   <div class="pop_section3">
		   		<h3>SNS 로그인 사용자를 위한<br>추가 정보 입력 안내</h3>
		   		<p>잇슬림 서비스 이용을 위해 휴대전화 번호를 필수로<br>입력해 주셔야 합니다. 사용하시는 휴대전화 번호를<br>입력해주세요.</p>
		   		<h4>휴대전화 번호 입력</h4>
		   		<input type="text" placeholder="숫자만 입력해주세요." maxlength="11" class="inp_st inp_st100p addPNum"/>
		   		<p class="caution_text"></p>
		   		<div class="btn_group">
		   			<button type="submit">확인</button>
		   			<a href="/sso/logout.jsp">취소</a>
		   		</div>
		   </div>
		</div>
		<!-- End contentpop -->
	</div>
</body>
<script type="text/javascript">
$(":input").filter(".addPNum")
.css("imeMode", "disabled")
.keypress(function(event){		
	if (event.which && (event.which < 48 || event.which > 57))
	{			
		event.preventDefault();
	}
}).keyup(function(){	
	if( $(this).val() != null && $(this).val() != '' ) {
		if($(this).val().length < 10) {
        	$(".caution_text").empty().text("10~11자리의 숫자만 입력해주세요.");
		}else{
			$(".caution_text").empty();
		}
    }else{
    	$(".caution_text").empty().text("휴대전화 번호를 입력해주세요.");
    };
});
</script>
</html>