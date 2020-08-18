<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import ="javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<head>
  <meta charset="utf-8">
  <title>잇슬림 주문 변경방법 안내</title>
  <!-- Link Swiper's CSS -->
  <link rel="stylesheet" href="/mobile/common/css/swiper.min.css">

  <!-- Demo styles -->
  <style>

    body {
      font-family: Helvetica Neue, Helvetica, Arial, sans-serif;
      font-size: 40px;
      color:#a1a1a1;
	  width: 100%;
      margin: 0;
      padding: 0;
	  border:0;
	  vertical-align:middle;
	  position:absolute;
    }


    .swiper-container {
      width: 100%;
	  height:100%;
      position:relative;
    }
    .swiper-slide {
      text-align: center;
      font-size: 18px;
      background: #fff;

      /* Center slide text vertically */
      display: -webkit-box;
      display: -ms-flexbox;
      display: -webkit-flex;
      display: flex;
      -webkit-box-pack: center;
      -ms-flex-pack: center;
      -webkit-justify-content: center;
      justify-content: center;
      -webkit-box-align: center;
      -ms-flex-align: center;
      -webkit-align-items: center;
      align-items: center;
    }

	.swiper-slide img{
      width: 100%;
      position:relative;
	}
  </style>
</head>
<body>
  <!-- Swiper -->
  <div class="swiper-container">
    <div class="swiper-wrapper">
<!--      <div class="swiper-slide"><img src="/mobile/images/notice/cover.jpg" alt="잇슬림 주문 변경안내" border="0" /></div>-->
      <div class="swiper-slide" style="width:100%; display:inline-block;"><a href="/customer/service_mobile.jsp"><img src="/mobile/images/notice/01.jpg" alt="잇슬림 주문 변경안내" border="0" /></a></div>
      <div class="swiper-slide"><img src="/mobile/images/notice/02.jpg" alt="잇슬림 주문 변경안내" border="0" /></div>
      <div class="swiper-slide"><img src="/mobile/images/notice/03.jpg" alt="잇슬림 주문 변경안내" border="0" /></div>
      <div class="swiper-slide"><img src="/mobile/images/notice/04.jpg" alt="잇슬림 주문 변경안내" border="0" /></div>
    </div>
    <!-- Add Pagination -->
    <div class="swiper-pagination"></div>
    <!-- Add Arrows -->
    <div class="swiper-button-next"></div>
    <div class="swiper-button-prev"></div>
  </div>

  <!-- Swiper JS -->
  <script src="/mobile/common/js/swiper.min.js"></script>

  <!-- Initialize Swiper -->
  <script>
    var swiper = new Swiper('.swiper-container', {
      pagination: {
        el: '.swiper-pagination',
        type: 'fraction',
      },
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
      },
    });
  </script>
</body>
</html>