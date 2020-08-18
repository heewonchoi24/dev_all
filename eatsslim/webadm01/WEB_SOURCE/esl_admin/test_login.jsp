<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<meta name="robots" content="noindex">

	<title>Pulmuone eatsslim 테스트 로그인</title>

	<link rel="stylesheet" type="text/css" href="css/styles.css" />
	<!--[if lte IE 6]><link rel="stylesheet" href="css/ie6.css" type="text/css" media="all"><![endif]-->
	<!--[if lte IE 7]><link rel="stylesheet" href="css/ie7.css" type="text/css" media="all"><![endif]-->
	<!--[if lte IE 8]><link rel="stylesheet" href="css/ie8.css" type="text/css" media="all"><![endif]-->
	<style type="text/css">
	body, html {background:#ebebeb;}
	</style>

	<script src="js/common.js"></script>
	<script type="text/javascript">
		function init() {
			var f	= document.frm_login;
			f.id.focus();
		}
	</script>
</head>
<body>
<form method="post" name="frm_login" action="/proc/checkMember.jsp" onsubmit="return checkForm(this)">
	<div id="loginwrap">
		<div class="loginbox">
			<div class="login">
				<div class="bg_top">&nbsp;</div>
				<p class="p01"><span>Pulmuone</span></p>
				<fieldset >
					<legend>TEST LOGIN</legend>
					<div class="login_bg">
						<div class="login_form">
							<dl>
								<dt>
									<label for="user_id">ID</label>
								</dt>
								<dd>
									<input type="text" id="id" name="id" onfocus="this.select()" required label="아이디" />
								</dd>
							</dl>
							<p class="login_btn">
								<input type="image" src="images/login/btn_login.gif" name="" />
							</p>
						</div>
					</div>
				</fieldset>
				<div class="login_bottom"></div>
			</div>
			<div class="loginfooter">
				<p class="copy">COPYRIGHT(C) 2013 PULMUONE HEALTH&LIVING CO,.LTD ALL RIGHT RESERVED.</p>
			</div>
		</div>
	</div>
</form>
</body>
</html>