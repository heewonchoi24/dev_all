<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<meta name="robots" content="noindex">

<title>Pulmuone Vendor 관리자시스템</title>

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
			f.admin_id.focus();		
			var ck	= getCookie("vendorId");
			if (ck!="") {
				f.admin_id.value	= ck;
				f.save_id.checked	= true;
				f.admin_pw.focus();
			} else {
				f.admin_id.focus();
			}
		}
	</script>
</head>
<body onload="init()">
<form method="post" name="frm_login" action="login_db.jsp" onsubmit="return checkForm(this)">
	<input type="hidden" name="mode" value="login" />
	<div id="loginwrap">
		<div class="loginbox">
			<div class="login">
				<div class="bg_top">&nbsp;</div>
				<p class="p01"><span>Pulmuone</span></p>
				<fieldset >
					<legend>Vendor LOGIN</legend>
					<div class="login_bg">
						<div class="login_form">
							<dl>
								<dt>
									<label for="AdminId">ID</label>
								</dt>
								<dd>
									<input type="text" id="admin_id" name="admin_id" onfocus="this.select()" required label="아이디" />
								</dd>
								<dt>
									<label for="AdminPwd">Passward</label>
								</dt>
								<dd class="dd02">
									<input type="password" id="admin_pw" name="admin_pw" required label="비밀번호" />
								</dd>
							</dl>
							<p class="save_id">
								<input type="checkbox" id="save_id" name="save_id" value="Y"  />
								<label for="save_id"><span>ID저장하기</span></label>
							</p>
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