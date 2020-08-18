<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <title>Model page</title>
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

            <section id="hello" class="model-banner bg-mega">
                <div class="overlay"></div>
                	<img src="/assets/images/main/main01.jpg" alt="" />
                <!-- <div class="container">
                    <div class="row">
                        <div class="main_home text-center">
                            <div class="model_text">
                                <h1 class="text-white text-uppercase">OUR MODELS</h1>
                                <ol class="breadcrumb">
                                    <li><a href="#">Home</a></li>
                                    <li class="active"><a href="#">OUR MODELS</a></li>
                                </ol>
                            </div>
                        </div>
                    </div>End off row
                </div>End off container -->
            </section> <!--End off Home Sections-->




            <!--Portfolio Section-->
            <section id="gallery" class="gallery margin-top-120 bg-white">
                <!-- Portfolio container-->
                <div class="container">
                    <div class="row">
                        <div class="main-gallery main-model roomy-80">
                            <div class="col-md-12 m-bottom-60">
                                <div class="filters-button-group sm-text-center">
                                    <button class="button is-checked" data-filter="*">View all</button>
                                    <button class="button" data-filter=".metal">Catwalk</button>
                                    <button class="button" data-filter=".transition">Advertisement</button>
                                    <button class="button" data-filter=".alkali">Fashionista</button>
                                    <button class="button" data-filter=".ar">Model Photo</button>
                                </div>
                            </div>

                            <div style="clear: both;"></div>

                            <div class="grid models text-center">
                                <div class="grid-item model-item transition metal ium">
                                    <img alt="" src="/assets/images/model/1.jpg">
									<a href="model-details.html" class="btn btn-default m-top-20">View Details<i class="fa fa-long-arrow-right"></i></a>
                                </div><!-- End off grid item -->

                                <div class="grid-item model-item metalloid " >
                                    <img alt="" src="/assets/images/model/2.jpg">
									<a href="model-details.html" class="btn btn-default m-top-20">View Details<i class="fa fa-long-arrow-right"></i></a>
                                </div><!-- End off grid item -->

                                <div class="grid-item model-item post-transition metal">
                                    <img alt="" src="/assets/images/model/3.jpg">
									<a href="model-details.html" class="btn btn-default m-top-20">View Details<i class="fa fa-long-arrow-right"></i></a>
                                </div><!-- End off grid item -->

                                <div class="grid-item model-item post-transition metal ium" >
                                    <img alt="" src="/assets/images/model/4.jpg">
									<a href="model-details.html" class="btn btn-default m-top-20">View Details<i class="fa fa-long-arrow-right"></i></a>
                                </div><!-- End off grid item -->

                                <div class="grid-item model-item metal ar" >
                                    <img alt="" src="/assets/images/model/5.jpg">
									<a href="model-details.html" class="btn btn-default m-top-20">View Details<i class="fa fa-long-arrow-right"></i></a>
                                </div><!-- End off grid item -->

                                <div class="grid-item model-item alkali ar" >
                                    <img alt="" src="/assets/images/model/6.jpg">
									<a href="model-details.html" class="btn btn-default m-top-20">View Details<i class="fa fa-long-arrow-right"></i></a>
                                </div><!-- End off grid item -->

                                <div class="grid-item model-item alkali ar" >
                                    <img alt="" src="/assets/images/model/7.jpg">
									<a href="model-details.html" class="btn btn-default m-top-20">View Details<i class="fa fa-long-arrow-right"></i></a>
                                </div><!-- End off grid item -->

                                <div class="grid-item model-item alkali ar" >
                                    <img alt="" src="/assets/images/model/8.jpg">
									<a href="model-details.html" class="btn btn-default m-top-20">View Details<i class="fa fa-long-arrow-right"></i></a>
                                </div><!-- End off grid item -->

                                <div class="grid-item model-item alkali ar" >
                                    <img alt="" src="/assets/images/model/9.jpg">
									<a href="model-details.html" class="btn btn-default m-top-20">View Details<i class="fa fa-long-arrow-right"></i></a>
                                </div><!-- End off grid item -->

                                <div class="grid-item model-item alkali ar" >
                                    <img alt="" src="/assets/images/model/10.jpg">
									<a href="model-details.html" class="btn btn-default m-top-20">View Details<i class="fa fa-long-arrow-right"></i></a>
                                </div><!-- End off grid item -->

                                <div class="grid-item model-item alkali ar" >
                                    <img alt="" src="/assets/images/model/11.jpg">
									<a href="model-details.html" class="btn btn-default m-top-20">View Details<i class="fa fa-long-arrow-right"></i></a>
                                </div><!-- End off grid item -->

                                <div class="grid-item model-item alkali ar" >
                                    <img alt="" src="/assets/images/model/12.jpg">
									<a href="model-details.html" class="btn btn-default m-top-20">View Details<i class="fa fa-long-arrow-right"></i></a>
                                </div><!-- End off grid item -->
                            </div>

                            <div style="clear: both;"></div>

                        </div>
                    </div>
                </div><!-- Portfolio container end -->
            </section><!-- End off portfolio section -->

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

        <!--
                <script src="http://maps.google.com/maps/api/js?key=AIzaSyD_tAQD36pKp9v4at5AnpGbvBUsLCOSJx8"></script>
                <script src="/assets/js/gmaps.min.js"></script>
        
                <script>
                    function showmap() {
                        var mapOptions = {
                            zoom: 8,
                            scrollwheel: false,
                            center: new google.maps.LatLng(-34.397, 150.644),
                            mapTypeId: google.maps.MapTypeId.ROADMAP
                        };
                        var map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);
                        $('.mapheight').css('height', '350');
                        $('.maps_text h3').hide();
                    }
        
                </script>-->





        <script src="/assets/js/plugins.js"></script>
        <script src="/assets/js/main.js"></script>

    </body>
</html>
