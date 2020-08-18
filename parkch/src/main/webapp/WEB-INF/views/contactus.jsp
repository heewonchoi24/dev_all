<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="common/link.jsp"%>
<!doctype html>
<html class="no-js" lang="en">
<head>
<meta charset="utf-8">
<title>오시는 길</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">

</head>

<body data-spy="scroll" data-target=".navbar-collapse">

	<div id="loading">
		<div id="loading-center">
			<div id="loading-center-absolute">
				<div class="object"></div>
				<div class="object"></div>
				<div class="object"></div>
				<div class="object"></div>
				<div class="object"></div>
				<div class="object"></div>
				<div class="object"></div>
				<div class="object"></div>
				<div class="object"></div>
				<div class="object"></div>
			</div>
		</div>
	</div>

	<div class="culmn">
		<nav
			class="navbar navbar-default navbar-fixed white no-background bootsnav text-uppercase">
			<div class="container">
				<%@ include file="common/header.jsp"%>
			</div>
		</nav>
		
        <style>
		.separator_left {
			width: 130px;
		}
        </style>		

		<section id="action" class="action roomy-100">
			<div class="container">
				<div class="row">
					<div class="head_title" style="margin-bottom: 70px;">
						<h2>오시는 길</h2>
						<div class="separator_left"></div>
					</div>
					<div class="main_action text-center">
						<div class="col-md-4">
							<div class="action_item">
								<i class="fa fa-map-marker"></i>
								<h4 class="text-uppercase m-top-20">회사 주소</h4>
								<p>서울시 영등포구 여의도동 14-8 극동 VIP빌딩 1103호</p>
							</div>
						</div>
						<div class="col-md-4">
							<div class="action_item">
								<i class="fa fa-headphones"></i>
								<h4 class="text-uppercase m-top-20">연락처</h4>
								<p>02. 2678. 0516</p>
							</div>
						</div>
						<div class="col-md-4">
							<div class="action_item">
								<i class="fa fa-envelope-o"></i>
								<h4 class="text-uppercase m-top-20">이메일</h4>
								<p>nong1767@hanmail.net</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>

	<div id="map" style="width: 2000px; height: 500px; margin-bottom: 200px;"></div>
	<%@ include file="common/footer.jsp"%>

	<!-- paradise slider js -->
	<!-- 클릭한 위치의 위도는 37.529515920904956 이고, 경도는 126.92031395532696 입니다 -->
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=50feda03edd2a59fab77817c3a28b1a3"></script>
	<script>
			var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
			var options = { //지도를 생성할 때 필요한 기본 옵션
				center : new kakao.maps.LatLng(37.529515920904956,
						126.92031395532696), //지도의 중심좌표.
				level : 3
			//지도의 레벨(확대, 축소 정도)
			};

			var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

			// 지도를 클릭한 위치에 표출할 마커입니다
			var marker = new kakao.maps.Marker({
				// 지도 중심좌표에 마커를 생성합니다 
				position : map.getCenter()
			});
			// 지도에 마커를 표시합니다
			marker.setMap(map);
		</script>
</body>
</html>
