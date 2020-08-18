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
        
        <%@ include file="common/link.jsp"%>
        
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

            <!--Portfolio Section-->
            <section id="gallery" class="gallery margin-top-120 bg-white">
                <!-- Portfolio container-->
                <div class="container">
                    <div class="row">
                        <div class="main-gallery main-model roomy-80">
                           <!-- 16:9 aspect ratio -->
							<div class="embed-responsive embed-responsive-16by9">
							  <iframe class="embed-responsive-item" src="https://youtu.be/71AXgPJbm8o"></iframe>
							</div>
							
							<!-- 4:3 aspect ratio -->
							<div class="embed-responsive embed-responsive-4by3">
							  <iframe class="embed-responsive-item" src="..."></iframe>
							  </div>
							</div>
                    </div>
                </div><!-- Portfolio container end -->
            </section><!-- End off portfolio section -->
			<%@ include file="common/footer.jsp" %>
        </div>
    </body>
</html>
