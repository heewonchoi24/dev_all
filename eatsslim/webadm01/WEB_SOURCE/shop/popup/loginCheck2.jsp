<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<script type="text/javascript">
var returnUrl = location.pathname + location.search;
if(returnUrl == null && returnUrl == "") returnUrl = "/";
document.cookie = "returnUrl" + "=" + escape(returnUrl) + "; path=/;";
</script>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />

	<title>�α���</title>
</head>
<body>
	<div class="pop-wrap ff_noto">
		<div class="headpop">
		    <h2>�α���</h2>
			
		</div>
	    <div class="contentpop">
		   <div class="pop_section3">
		   		<h3>SNS �α��� ����ڸ� ����<br>�߰� ���� �Է� �ȳ�</h3>
		   		<p>�ս��� ���� �̿��� ���� �޴���ȭ ��ȣ�� �ʼ���<br>�Է��� �ּž� �մϴ�. ����Ͻô� �޴���ȭ ��ȣ��<br>�Է����ּ���.</p>
		   		<h4>�޴���ȭ ��ȣ �Է�</h4>
		   		<input type="text" placeholder="���ڸ� �Է����ּ���." maxlength="11" class="inp_st inp_st100p addPNum"/>
		   		<p class="caution_text"></p>
		   		<div class="btn_group">
		   			<button type="submit">Ȯ��</button>
		   			<a href="/sso/logout.jsp">���</a>
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
        	$(".caution_text").empty().text("10~11�ڸ��� ���ڸ� �Է����ּ���.");
		}else{
			$(".caution_text").empty();
		}
    }else{
    	$(".caution_text").empty().text("�޴���ȭ ��ȣ�� �Է����ּ���.");
    };
});
</script>
</html>