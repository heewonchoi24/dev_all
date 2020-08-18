<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <title>Contact us page</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="icon" type="image/png" href="favicon.ico">

        <!--Google Fonts link-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet">


        <link href="https://fonts.googleapis.com/css?family=Crimson+Text:400,400i,600,600i,700,700i" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Roboto+Condensed:300,300i,400,400i,700,700i" rel="stylesheet">


        <link rel="stylesheet" href="/assets/css/slick.css">
        <link rel="stylesheet" href="/assets/css/slick-theme.css">
        <link rel="stylesheet" href="/assets/css/animate.css">
        <link rel="stylesheet" href="/assets/css/fonticons.css">
        <link rel="stylesheet" href="/assets/css/font-awesome.min.css">
        <link rel="stylesheet" href="/assets/css/bootstrap.css">
        <link rel="stylesheet" href="/assets/css/magnific-popup.css">
        <link rel="stylesheet" href="/assets/css/bootsnav.css">


        <!--For Plugins external css-->
        <!--<link rel="stylesheet" href="/assets/css/plugins.css" />-->

        <!--Theme custom css -->
        <link rel="stylesheet" href="/assets/css/style.css">
        <!--<link rel="stylesheet" href="/assets/css/colors/maron.css">-->

        <!--Theme Responsive css-->
        <link rel="stylesheet" href="/assets/css/responsive.css" />

        <script src="/assets/js/vendor/modernizr-2.8.3-respond-1.4.2.min.js"></script>
    </head>

    <body data-spy="scroll" data-target=".navbar-collapse">


        <!-- Preloader -->

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

        <!--End off Preloader -->


        <div class="culmn">
            <!--Home page style-->


            <nav class="navbar navbar-default navbar-fixed white no-background bootsnav text-uppercase">
                <!-- Start Top Search -->
                <div class="top-search">
                    <div class="container">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="fa fa-search"></i></span>
                            <input type="text" class="form-control" placeholder="Search">
                            <span class="input-group-addon close-search"><i class="fa fa-times"></i></span>
                        </div>
                    </div>
                </div>
                <!-- End Top Search -->

                <div class="container">    
                    <!-- Start Atribute Navigation -->
                    <div class="attr-nav">
                        <ul>
                            <li class="search"><a href="#"><i class="fa fa-search"></i></a></li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" >
                                    <i class="fa fa-shopping-bag"></i>
                                    <span class="badge">3</span>
                                </a>
                                <ul class="dropdown-menu cart-list">
                                    <li>
                                        <a href="#" class="photo"><img src="/assets/images/thumb01.jpg" class="cart-thumb" alt="" /></a>
                                        <h6><a href="#">Delica omtantur </a></h6>
                                        <p class="m-top-10">2x - <span class="price">$99.99</span></p>
                                    </li>
                                    <li>
                                        <a href="#" class="photo"><img src="/assets/images/thumb01.jpg" class="cart-thumb" alt="" /></a>
                                        <h6><a href="#">Delica omtantur </a></h6>
                                        <p class="m-top-10">2x - <span class="price">$99.99</span></p>
                                    </li>
                                    <li>
                                        <a href="#" class="photo"><img src="/assets/images/thumb01.jpg" class="cart-thumb" alt="" /></a>
                                        <h6><a href="#">Delica omtantur </a></h6>
                                        <p class="m-top-10">2x - <span class="price">$99.99</span></p>
                                    </li>
                                    <!---- More List ---->
                                    <li class="total">
                                        <span class="pull-right"><strong>Total</strong>: $0.00</span>
                                        <a href="#" class="btn btn-cart">Cart</a>
                                    </li>
                                </ul>
                            </li>

                        </ul>
                    </div>        
                    <!-- End Atribute Navigation -->

                    <!-- Start Header Navigation -->
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-menu">
                            <i class="fa fa-bars"></i>
                        </button>
                        <a class="navbar-brand" href="index.html">
                        </a>
                    </div>
                    <!-- End Header Navigation -->

                    <!-- Collect the nav links, forms, and other content for toggling -->
                    <%@ include file="common/header.jsp" %>
                </div>  


            </nav>


            <!--Home Sections-->

            <section id="hello" class="contact-banner bg-mega">
                <div class="overlay"></div>
               		<img src="/assets/images/main/main01.jpg" alt="" />
                <!-- <div class="container">
                    <div class="row">
                        <div class="main_home text-center">
                            <div class="contact_text">
                                <h1 class="text-white text-uppercase">Contact Us</h1>
                                <ol class="breadcrumb">
                                    <li><a href="#">Home</a></li>
                                    <li class="active"><a href="#">Contact Us</a></li>
                                </ol>
                            </div>
                        </div>
                    </div>End off row
                </div>End off container -->
            </section> <!--End off Home Sections-->


            <!--Call To Action Section-->

            <section id="action" class="action roomy-100">
                <div class="container">
                    <div class="row">
                        <div class="main_action text-center">
                            <div class="col-md-4">
                                <div class="action_item">
                                    <i class="fa fa-map-marker"></i>
                                    <h4 class="text-uppercase m-top-20">회사 주소 </h4>
                                    <p>서울시 영등포구 여의도동 14-8 극동 VIP빌딩 1103호 </p>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="action_item">
                                    <i class="fa fa-headphones"></i>
                                    <h4 class="text-uppercase m-top-20">연락처 </h4>
                                    <p>02. 2678. 0516 </p>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="action_item">
                                    <i class="fa fa-envelope-o"></i>
                                    <h4 class="text-uppercase m-top-20">이메일 </h4>
                                    <p>nong1767@hanmail.net </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>


            <!-- map section-->
<!--             <div id="map" class="map">
                <div class="ourmap"></div>
            </div> -->
            <div id="map" style="width:2000px;height:500px;"></div>
            <!-- End off Map section-->

            <!--Contact Us Section-->
<!--             <section id="contact" class="contact fix">
                <div class="container">
                    <div class="row">
                        <div class="main_contact p-top-100">

                            <div class="col-md-6 sm-m-top-30">
                                <form class="" action="subcribe.php">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <div class="form-group"> 
                                                <label>Your Name *</label>
                                                <input id="first_name" name="name" type="text" class="form-control" required="">
                                            </div>
                                        </div>

                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label>Your Email *</label>
                                                <input id="email" name="email" type="text" class="form-control">
                                            </div>
                                        </div>

                                        <div class="col-sm-12">
                                            <div class="form-group"> 
                                                <label>Your Message *</label>
                                                <textarea class="form-control" rows="6"></textarea>
                                            </div>
                                            <div class="form-group">
                                                <a href="" class="btn btn-default">SEND MESSAGE <i class="fa fa-long-arrow-right"></i></a>
                                            </div>
                                        </div>

                                    </div>

                                </form>
                            </div>

                            <div class="col-md-6">
                                <div class="contact_img">
                                    <img src="/assets/images/contact-img.png" alt="" />
                                </div>
                            </div>


                        </div>
                    </div>End off row
                </div>End off container
            </section>End off Contact Section -->

			<%@ include file="common/footer.jsp" %>

        </div>

        <!-- JS includes -->

        <script src="/assets/js/vendor/jquery-1.11.2.min.js"></script>
        <script src="/assets/js/vendor/bootstrap.min.js"></script>

        <script src="/assets/js/isotope.min.js"></script>
        <script src="/assets/js/jquery.magnific-popup.js"></script>
        <script src="/assets/js/jquery.easing.1.3.js"></script>
        <script src="/assets/js/slick.min.js"></script>
        <script src="/assets/js/jquery.collapse.js"></script>
        <script src="/assets/js/bootsnav.js"></script>


        <!-- paradise slider js -->
        <!-- 클릭한 위치의 위도는 37.529515920904956 이고, 경도는 126.92031395532696 입니다 -->
        <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=50feda03edd2a59fab77817c3a28b1a3"></script>
        <script>
        var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
        var options = { //지도를 생성할 때 필요한 기본 옵션
        	center: new kakao.maps.LatLng(37.529515920904956, 126.92031395532696), //지도의 중심좌표.
        	level: 3 //지도의 레벨(확대, 축소 정도)
        };

        var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
        
	    // 지도를 클릭한 위치에 표출할 마커입니다
	    var marker = new kakao.maps.Marker({ 
	        // 지도 중심좌표에 마커를 생성합니다 
	        position: map.getCenter() 
	    }); 
	    // 지도에 마커를 표시합니다
	    marker.setMap(map);
	    </script>

<!--         <script src="http://maps.google.com/maps/api/js?key=AIzaSyD_tAQD36pKp9v4at5AnpGbvBUsLCOSJx8"></script>
        <script src="/assets/js/gmaps.min.js"></script>
        <script>
            var map = new GMaps({
                el: '.ourmap',
                lat: -12.043333,
                lng: -77.028333,
                scrollwheel: false,
                zoom: 15,
                zoomControl: true,
                panControl: false,
                
                streetViewControl: false,
                mapTypeControl: false,
                overviewMapControl: false,
                clickable: false,
                styles: [{'stylers': [{'hue': 'gray'}, {saturation: -100},
                            {gamma: 0.80}]}]
            });

        </script> -->

        <script src="/assets/js/plugins.js"></script>
        <script src="/assets/js/main.js"></script>

    </body>
</html>
