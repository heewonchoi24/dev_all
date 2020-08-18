<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js" lang="en">
<head>
<meta charset="utf-8">
<title>회원가입 완료</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" type="image/png" href="favicon.ico">
<link rel="stylesheet" href="/assets2/css/main.css" />
<%@ include file="common/link.jsp"%>

<style>
ul.alt li {
	border-top: solid 1px;
	padding: 0.5rem 0;
	width: 300px
}
</style>

<script>
	// 뒤로가기 막기 
	history.pushState(null, null, location.href);
	window.onpopstate = function() {
		history.go(1);
	};

	// 메인 페이지로 이동 버튼 
	function main() {
		$("#form").attr({
			method : "get",
			action : "/"
		}).submit();
	}
</script>
<body data-spy="scroll" data-target=".navbar-collapse">



	<div class="culmn">
		<!-- header -->
		<nav
			class="navbar navbar-default navbar-fixed white no-background bootsnav text-uppercase">
			<div class="container">
				<%@ include file="common/header.jsp"%>
			</div>
		</nav>

		<!-- Footer -->
		<footer id="footer" class="wrapper">
			<div class="inner">
				<section>
					<div class="box">
						<div class="content">
							<h2 class="align-center">성공적으로 가입되었습니다.</h2>
							<hr />
							<form action="#" method="get" id="form" name="form">
								<div class="field" style="font-size: 17px">
									<br /> 현재는 회원 승인 대기 상태입니다. 정회원이 되기 위해서는 첫 가입비/연회비 10,000(일만
									원)을 결제하셔야 정회원 전환이 됩니다. <br />
									<br />많은 후원 부탁드립니다. <br />감사합니다. <br /> <br /> <br /> <br />
									<br /> <br /> <br /> <br /> <br /> <br /> <br /> <br />
									<br /> <br /> <br />
									<p>
										<i class="fa fa-headphones"></i>&nbsp;&nbsp;&nbsp;고객센터 : 02.
										2678. 0516
									</p>
								</div>
								<ul class="actions" style="text-align: right">
									<li><input value="메인 화면으로 가기 " class="button special"
										type="button" onClick="main();"></li>
								</ul>
							</form>
						</div>
					</div>
				</section>
				<div class="copyright">(사) 박정희 대통령 정신문화 선양회</div>
			</div>
		</footer>
	</div>
</body>
</html>