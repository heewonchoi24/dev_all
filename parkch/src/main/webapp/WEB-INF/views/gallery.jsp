<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="common/link.jsp"%>
<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->

  <head>
        <meta charset="utf-8">
        <title>갤러리</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="icon" type="image/png" href="favicon.ico">
       <!--  <script>
        function goDetail(){
        }
        </script> -->

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
                <div class="container">    
                    <%@ include file="common/header.jsp" %>
                </div>  
            </nav>

	        <style>
			.main-gallery .grid-item img{
				max-width: 100%;
				height: 220px;
			}
			.separator_left {
				width: 100px;
			}
	        </style>
        	
            <section id="gallery" class="gallery margin-top-120 bg-white">
                <div class="container">
                    <div class="row">
                        <div class="main-gallery main-model roomy-80">
	                        <div class="head_title" style="margin-bottom: 70px;">
								<h2>갤러리</h2>
								<div class="separator_left"></div>
							</div>
                            <div style="clear: both;"></div>
                            <div class="grid models text-center">
                                <div class="grid-item model-item transition metal ium">
                                    <img alt="" src="/assets/images/gallery/picture01.jpg">
                                </div><!-- End off grid item -->

                                <div class="grid-item model-item metalloid " >
                                    <img alt="" src="/assets/images/gallery/picture02.jpg" >
                                </div><!-- End off grid item -->

                                <div class="grid-item model-item post-transition metal">
                                    <img alt="" src="/assets/images/gallery/picture03.jpg">
                                </div><!-- End off grid item -->

                                <div class="grid-item model-item post-transition metal ium" >
                                    <img alt="" src="/assets/images/gallery/picture04.jpg">
                                </div><!-- End off grid item -->

                                <div class="grid-item model-item metal ar" >
                                    <img alt="" src="/assets/images/gallery/picture05.jpg">
                                </div><!-- End off grid item -->

                                <div class="grid-item model-item alkali ar" >
                                    <img alt="" src="/assets/images/gallery/picture06.jpg">
                                </div><!-- End off grid item -->

                                <div class="grid-item model-item alkali ar" >
                                    <img alt="" src="/assets/images/gallery/picture07.jpg">
                                </div><!-- End off grid item -->

                                <div class="grid-item model-item alkali ar" >
                                    <img alt="" src="/assets/images/gallery/picture08.jpg">
                                </div><!-- End off grid item -->

                                <div class="grid-item model-item alkali ar" >
                                    <img alt="" src="/assets/images/gallery/picture09.jpg">
                                </div><!-- End off grid item -->

                                <div class="grid-item model-item alkali ar" >
                                    <img alt="" src="/assets/images/gallery/picture10.jpg">
                                </div><!-- End off grid item -->

                                <div class="grid-item model-item alkali ar" >
                                    <img alt="" src="/assets/images/gallery/picture11.jpg">
                                </div><!-- End off grid item -->

                                <div class="grid-item model-item alkali ar" >
                                    <img alt="" src="/assets/images/gallery/picture12.jpg">
									<!-- <a href="model-details.html" class="btn btn-default m-top-20">View Details<i class="fa fa-long-arrow-right"></i></a> -->
                                </div><!-- End off grid item -->
                            </div>

                            <div style="clear: both;"></div>

                        </div>
                    </div>
                </div><!-- Portfolio container end -->
            </section><!-- End off portfolio section -->
			<%@ include file="common/footer.jsp" %>
        </div>
    </body>
</html>
