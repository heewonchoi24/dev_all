<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>메인 화면 </title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
 		
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

            <section id="hello" class="home bg-mega">
                <div class="overlay"></div>
               <!--  <div class="container"> -->
                    <img src="/assets/images/main/main01.jpg" alt="" />
                       <!--  <div class="main_home text-center">
                        1920 X 1070
                         	<img src="/assets/images/main/main01.jpg" alt="" />
                       
                            <div class="home_text">
                                <h4 class="text-white text-uppercase">a new creative studio</h4>
                                <h1 class="text-white text-uppercase">good design is always in season</h1>

                                <div class="separator"></div>

                                <h5 class=" text-uppercase text-white"><em>One day, the dream will come true with lorem ipsum dolor sit amet, 
                                        consectetuer adipiscing elit, nummy nibh euismod tincidunt laoreet.</em></h5>
         ƒ                   </div>
                        </div> -->
                    <!--End off row-->
               <!--  </div> --><!--End off container -->
            </section> <!--End off Home Sections-->


            <!--About Sections-->
            <section id="feature" class="feature p-top-100">
                <div class="container">
                    <div class="row">
                        <div class="main_feature">

                            <div class="col-md-6 m-top-120">
                                <!-- Head Title -->
                                <div class="head_title">
                                    <h2>박정희 대통령을 추모하며 </h2>
                                    <h5><em>박정희 대통령님의 관련 소식은 이곳에서 확인하실 수 있습니다. </em></h5>
                                    <div class="separator_left"></div>
                                </div><!-- End off Head Title -->

                                <div class="feature_content wow fadeIn m-top-40">
                                    <div class="feature_btns m-top-30">
                                        <a href="https://nsearch.chosun.com/search/total.search?query=박정희&cs_search=gnbtotal" class="btn btn-default text-uppercase" style="width:200px">조선일보 <i class="fa fa-long-arrow-right"></i></a>
                                    </div>
                                    <div class="feature_btns m-top-30">
                                        <a href="https://news.joins.com/search/?keyword=박정희" class="btn btn-default text-uppercase" style="width:200px">중앙일보 <i class="fa fa-long-arrow-right"></i></a>
                                    </div>
                                    <div class="feature_btns m-top-30">
                                        <a href="http://www.donga.com/news/search?query=박정희&x=0&y=0" class="btn btn-default text-uppercase" style="width:200px">동아일보 <i class="fa fa-long-arrow-right"></i></a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="feature_photo wow fadeIn sm-m-top-40">
                                    <div class="photo_border"></div>
                                    <div class="feature_img">
                                        <img src="/assets/images/main/main02.jpg" alt="" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div><!--End off row-->
                </div><!--End off container -->
                <br />
                <br />
                <br />
                <br />
                <hr />
                <br />
                <br />

               <!--  <div class="container">
                    <div class="row">
                        <div class="main_counter text-center">
                            <div class="col-md-3">
                                <div class="counter_item">
                                    <h2 class="statistic-counter"><em> 29 </em></h2>
                                    <div class="separator_small"></div>
                                    <h5>Projects Finished</h5>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="counter_item sm-m-top-40">
                                    <h2 class="statistic-counter"><em>124</em></h2>
                                    <div class="separator_small"></div>
                                    <h5>Happy Clients</h5>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="counter_item sm-m-top-40">
                                    <h2 class="statistic-counter"><em>76</em></h2>
                                    <div class="separator_small"></div>
                                    <h5>Hours of work</h5>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="counter_item sm-m-top-40">
                                    <h2 class="statistic-counter"><em>500</em> </h2>
                                    <div class="separator_small"></div>
                                    <h5>Cup of coffee</h5>
                                </div>
                            </div>
                        </div>
                    </div>End off row
                </div>End off container -->

                <div class="container">
                    <div class="row">

		                <!--Our Work Section-->
		                <div class="col-md-4">
		                    <div class="blog_fashion_right">
		                        <div class="fashion_test text-center">
		                            <img class="img-circle" src="/assets/images/blog-test-img1.jpg" alt="" />
		
		                            <h6 class="m-top-20">공지사항 </h6>
		                            <p class="m-top-20">With the waves from somewhere so far. 
		                                We comes with elegants and beautiful. 
		                                Just do what we love and always love what we do</p>
		                        </div>
		                    </div>
		                </div>
		                <div class="col-md-4">
		                    <div class="blog_fashion_right">
		                        <div class="fashion_test text-center">
		                            <img class="img-circle" src="/assets/images/blog-test-img1.jpg" alt="" />
		
		                            <h6 class="m-top-20">1:1 문의하기 </h6>
		                            <p class="m-top-20">With the waves from somewhere so far. 
		                                We comes with elegants and beautiful. 
		                                Just do what we love and always love what we do</p>
		                        </div>
		                    </div>
		                </div>
		                <div class="col-md-4">
		                    <div class="blog_fashion_right">
		                        <div class="fashion_test text-center">
		                            <img class="img-circle" src="/assets/images/blog-test-img1.jpg" alt="" />
		
		                            <h6 class="m-top-20"></h6>
		                            <p class="m-top-20">With the waves from somewhere so far. 
		                                We comes with elegants and beautiful. 
		                                Just do what we love and always love what we do</p>
		                        </div>
		                    </div>
		                </div>		                
                    </div> <!--End off row -->
                </div>
                
                <br />
                <br />
                <br />
                <hr />
                <br />
                <br />
                <br />
                

            </section> <!--End off About section -->

            <!--Gallery Section-->
<!--             <section id="gallery" class="gallery margin-top-120 bg-grey">
                Gallery container
                <div class="container">
                    <div class="row">
                        <div class="main-gallery roomy-80">
                            <div class="col-md-12">
                                <div class="head_title text-left sm-text-center wow fadeInDown">
                                    <h2>Our Gallery</h2>
                                    <h5><em>Some our recent works is here. Discover them now!</em></h5>
                                    <div class="separator_left"></div>
                                </div>
                            </div>
                            <div class="col-md-12 m-bottom-60">
                                <div class="filters-button-group text-right sm-text-center">
                                    <button class="button is-checked" data-filter="*">View all</button>
                                    <button class="button" data-filter=".metal">Catwalk</button>
                                    <button class="button" data-filter=".transition">Advertisement</button>
                                    <button class="button" data-filter=".alkali">Fashionista</button>
                                    <button class="button" data-filter=".ar">Model Photo</button>
                                </div>
                            </div>

                            <div style="clear: both;"></div>

                            <div class="grid text-center">
                                <div class="grid-item transition metal ium">
                                    <img alt="" src="/assets/images/porfolio-01.jpg">
                                    <div class="grid_hover_area text-center">
                                        <div class="grid_hover_text m-top-110">
                                            <h4 class="text-white">Sloggi’s collection</h4>
                                            <h5 class="text-white"><em>Fashionista</em></h5>
                                            <a href="/assets/images/porfolio-01.jpg" class="popup-img text-white m-top-40">View Project <i class="fa fa-long-arrow-right"></i></a>
                                        </div>
                                    </div>End off grid Hover area
                                </div>End off grid item

                                <div class="grid-item metalloid " >
                                    <img alt="" src="/assets/images/porfolio-02.jpg">
                                    <div class="grid_hover_area text-center">
                                        <div class="grid_hover_text m-top-150">
                                            <h4 class="text-white">Sloggi’s collection</h4>
                                            <h5 class="text-white"><em>Fashionista</em></h5>
                                            <a href="/assets/images/porfolio-02.jpg" class="popup-img text-white m-top-50">View Project <i class="fa fa-long-arrow-right"></i></a>
                                        </div>
                                    </div>End off grid Hover area
                                </div>End off grid item

                                <div class="grid-item post-transition metal numberGreaterThan50">
                                    <img alt="" src="/assets/images/porfolio-03.jpg">
                                    <div class="grid_hover_area text-center">
                                        <div class="grid_hover_text m-top-50">
                                            <h4 class="text-white">Sloggi’s collection</h4>
                                            <h5 class="text-white"><em>Fashionista</em></h5>
                                            <a href="/assets/images/porfolio-03.jpg" class="popup-img text-white m-top-40">View Project <i class="fa fa-long-arrow-right"></i></a>
                                        </div>
                                    </div>End off grid Hover area
                                </div>End off grid item
                                
                                <div class="grid-item alkali ar" >
                                    <img alt="" src="/assets/images/porfolio-06.jpg">
                                    <div class="grid_hover_area text-center">
                                        <div class="grid_hover_text m-top-50">
                                            <h4 class="text-white">Sloggi’s collection</h4>
                                            <h5 class="text-white"><em>Fashionista</em></h5>
                                            <a href="/assets/images/porfolio-06.jpg" class="popup-img text-white m-top-40">View Project <i class="fa fa-long-arrow-right"></i></a>
                                        </div>
                                    </div>End off grid Hover area
                                </div>End off grid item

                                <div class="grid-item post-transition metal ium" >
                                    <img alt="" src="/assets/images/porfolio-04.jpg">
                                    <div class="grid_hover_area text-center">
                                        <div class="grid_hover_text m-top-150">
                                            <h4 class="text-white">Sloggi’s collection</h4>
                                            <h5 class="text-white"><em>Fashionista</em></h5>
                                            <a href="/assets/images/porfolio-04.jpg" class="popup-img text-white m-top-50">View Project <i class="fa fa-long-arrow-right"></i></a>
                                        </div>
                                    </div>End off grid Hover area
                                </div>End off grid item


                                <div class="grid-item metal ar" >
                                    <img alt="" src="/assets/images/porfolio-05.jpg">
                                    <div class="grid_hover_area text-center">
                                        <div class="grid_hover_text m-top-110">
                                            <h4 class="text-white">Sloggi’s collection</h4>
                                            <h5 class="text-white"><em>Fashionista</em></h5>
                                            <a href="/assets/images/porfolio-05.jpg" class="popup-img text-white m-top-40">View Project <i class="fa fa-long-arrow-right"></i></a>
                                        </div>
                                    </div>End off grid Hover area
                                </div>End off grid item



                            </div>

                            <div style="clear: both;"></div>

                        </div>
                    </div>
                </div>Portfolio container end
            </section>End off portfolio section -->

            <!--Testimonial Section-->
<!--             <section id="testimonial" class="testimonial fix roomy-100">
                <div class="container">
                    <div class="row">
                        <div class="main_testimonial text-center">

                            <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                                <div class="carousel-inner" role="listbox">
                                    <div class="item active testimonial_item">
                                        <div class="col-sm-10 col-sm-offset-1">

                                            <div class="test_authour">
                                                <img class="img-circle" src="/assets/images/test-img.jpg" alt="" />
                                                <h6 class="m-top-20">Laingockien</h6>
                                                <h5><em>The most handsome men in the world</em> </h5>
                                            </div>

                                            <p class=" m-top-40">I’ve just wordked with Pouseidon last week. Uhm.  
                                                I can say this is the best team that I have ever worked together. 
                                                All of them are very, very professional and creative, their unbelieved 
                                                plan made our concept become perfect. I recommend you to try one of
                                                their solutions youself. Once again,  thanks so much, Pouseidon. 5 stars for you!! </p>


                                        </div>
                                    </div>
                                    <div class="item testimonial_item">
                                        <div class="col-sm-10 col-sm-offset-1">

                                            <div class="test_authour">
                                                <img class="img-circle" src="/assets/images/test-img.jpg" alt="" />
                                                <h6 class="m-top-20">Laingockien</h6>
                                                <h5><em>The most handsome men in the world</em> </h5>
                                            </div>

                                            <p class=" m-top-40">I’ve just wordked with Pouseidon last week. Uhm.  
                                                I can say this is the best team that I have ever worked together. 
                                                All of them are very, very professional and creative, their unbelieved 
                                                plan made our concept become perfect. I recommend you to try one of
                                                their solutions youself. Once again,  thanks so much, Pouseidon. 5 stars for you!! </p>


                                        </div>
                                    </div>
                                    <div class="item testimonial_item">
                                        <div class="col-sm-10 col-sm-offset-1">

                                            <div class="test_authour">
                                                <img class="img-circle" src="/assets/images/test-img.jpg" alt="" />
                                                <h6 class="m-top-20">Laingockien</h6>
                                                <h5><em>The most handsome men in the world</em> </h5>
                                            </div>

                                            <p class=" m-top-40">I’ve just wordked with Pouseidon last week. Uhm.  
                                                I can say this is the best team that I have ever worked together. 
                                                All of them are very, very professional and creative, their unbelieved 
                                                plan made our concept become perfect. I recommend you to try one of
                                                their solutions youself. Once again,  thanks so much, Pouseidon. 5 stars for you!! </p>

                                        </div>
                                    </div>

                                </div>

                                Controls
                                <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
                                    <span class="fa fa-long-arrow-left" aria-hidden="true"></span>
                                    <span class="sr-only">Previous</span>
                                </a>
                                <span class="slash">/</span>
                                <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
                                    <span class="fa fa-long-arrow-right" aria-hidden="true"></span>
                                    <span class="sr-only">Next</span>
                                </a>

                            </div>
                        </div>
                    </div>End off row
                </div>End off container

                <br />
                <br />
                <br />
                <hr />
                <br />
                <br />
                <br />

                <div class="container">
                    <div class="row">
                        <div class="main_cbrand text-center">
                            <div class="col-md-2 col-sm-4 col-xs-6">
                                <div class="cbrand_item m-bottom-10">
                                    <a href=""><img src="/assets/images/brand-img1.png" alt="" /></a>
                                </div>
                            </div>
                            <div class="col-md-2 col-sm-4 col-xs-6">
                                <div class="cbrand_item m-bottom-10">
                                    <a href=""><img src="/assets/images/brand-img2.png" alt="" /></a>
                                </div>
                            </div>
                            <div class="col-md-2 col-sm-4 col-xs-6">
                                <div class="cbrand_item m-bottom-10">
                                    <a href=""><img class="" src="/assets/images/brand-img3.png" alt="" /></a>
                                </div>
                            </div>
                            <div class="col-md-2 col-sm-4 col-xs-6">
                                <div class="cbrand_item m-bottom-10">
                                    <a href=""><img src="/assets/images/brand-img4.png" alt="" /></a>
                                </div>
                            </div>
                            <div class="col-md-2 col-sm-4 col-xs-6">
                                <div class="cbrand_item m-bottom-10">
                                    <a href=""><img src="/assets/images/brand-img5.png" alt="" /></a>
                                </div>
                            </div>
                            <div class="col-md-2 col-sm-4 col-xs-6">
                                <div class="cbrand_item m-bottom-10">
                                    <a href=""><img src="/assets/images/brand-img1.png" alt="" /></a> 
                                </div>
                            </div>
                        </div>
                    </div>End off row
                </div>End off container
            </section> End off Testimonial section -->

            <!--Models section-->

            <section id="models" class="models bg-grey roomy-80">
                <div class="container">
                    <div class="row">
                        <div class="main_models text-center">
                            <div class="col-md-12">
                                <div class="head_title text-left sm-text-center wow fadeInDown">
                                    <h2>갤러리 </h2>
                                    <!-- <h5><em>The success of Pouseidon is passion and love. Meet them now!</em></h5> -->
                                    <div class="separator_left"></div>
                                </div>
                            </div>

                            <div class="col-md-3 col-sm-6">
                                <div class="model_item m-top-30">
                                    <div class="model_img">
                                        <img src="/assets/images/model-img01.jpg" alt="" />
                                        <div class="model_caption">
                                            <h5 class="text-white">자세히 보기 </h5>
                                        </div>
                                    </div>
                                </div>
                            </div><!-- End off col-md-3 -->

                            <div class="col-md-3 col-sm-6">
                                <div class="model_item m-top-30">
                                    <div class="model_img">
                                        <img src="/assets/images/model-img02.jpg" alt="" />
                                        <div class="model_caption">
                                            <h5 class="text-white">자세히 보기 </h5>
                                        </div>
                                    </div>
                                </div>
                            </div><!-- End off col-md-3 -->

                            <div class="col-md-3 col-sm-6">
                                <div class="model_item m-top-30">
                                    <div class="model_img">
                                        <img src="/assets/images/model-img03.jpg" alt="" />
                                        <div class="model_caption">
                                            <h5 class="text-white">자세히 보기 </h5>
                                        </div>
                                    </div>
                                </div>
                            </div><!-- End off col-md-3 -->

                            <div class="col-md-3 col-sm-6">
                                <div class="model_item m-top-30">
                                    <div class="model_img">
                                        <img src="/assets/images/model-img04.jpg" alt="" />
                                        <div class="model_caption">
                                            <h5 class="text-white">자세히 보기 </h5>
                                        </div>
                                    </div>
                                </div>
                            </div><!-- End off col-md-3 -->

                            <div class="col-md-3 col-sm-6">
                                <div class="model_item m-top-30">
                                    <div class="model_img">
                                        <img src="/assets/images/model-img05.jpg" alt="" />
                                        <div class="model_caption">
                                            <h5 class="text-white">자세히 보기 </h5>
                                        </div>
                                    </div>
                                </div>
                            </div><!-- End off col-md-3 -->

                            <div class="col-md-3 col-sm-6">
                                <div class="model_item m-top-30">
                                    <div class="model_img">
                                        <img src="/assets/images/model-img06.jpg" alt="" />
                                        <div class="model_caption">
                                            <h5 class="text-white">자세히 보기 </h5>
                                        </div>
                                    </div>
                                </div>
                            </div><!-- End off col-md-3 -->

                            <div class="col-md-3 col-sm-6">
                                <div class="model_item m-top-30">
                                    <div class="model_img">
                                        <img src="/assets/images/model-img07.jpg" alt="" />
                                        <div class="model_caption">
                                            <h5 class="text-white">자세히 보기 </h5>
                                        </div>
                                    </div>
                                </div>
                            </div><!-- End off col-md-3 -->

                            <div class="col-md-3 col-sm-6">
                                <div class="model_item meet_team m-top-30">
                                    <a href="">더 보기 <i class="fa fa-long-arrow-right"></i></a>
                                </div>
                            </div><!-- End off col-md-3 -->

                        </div>
                    </div>
                </div>
            </section>

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
        
    </body>
</html>
