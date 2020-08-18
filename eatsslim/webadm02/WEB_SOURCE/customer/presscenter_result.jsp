<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/common/include/inc-top.jsp"%>

	<script type="text/javascript" src="/common/js/datefield.js"></script>
</head>
<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div> <!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1>
				언론보도
			</h1>
			<div class="pageDepth">
				HOME > 고객센터 > <strong>언론보도</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="twelve columns offset-by-one ">
			<div class="row">
				<div class="threefourth last col">
					<ul class="tabNavi">
						<li>
							<a href="notice.jsp">공지사항</a>
						</li>
						<li>
							<a href="faq.jsp">FAQ</a>
						</li>
						<li>
							<a href="indiqna.jsp">1:1문의</a>
						</li>
						<li>
							<a href="service_member.jsp">이용안내</a>
						</li>
						<li class="active">
							<a href="presscenter.jsp">언론보도</a>
						</li>
					</ul>
					<div class="clear">
					</div>
				</div>
			</div>
			
			<div class="row" style="margin-bottom:40px;">
				<div class="threefourth last col">
					<div class="searchBar floatleft">
							<label>
								<select name="select" id="select" style="width:70px;">
									<option>제목</option>
									<option>내용</option>
								</select>
							</label>
							<label>
							<input type="text" name="textfield" id="textfield">
							</label>
							<label>
							<input type="submit" class="button dark small" name="button" value="검색">
							</label>
					</div>
					<!--div class="floatright">
							<label>
								<select name="select" id="select" class="formsel" >
									<option>4개씩 보기</option>
									<option>8개씩 보기</option>
								</select>
							</label>
					</div-->
					<div class="result floatright">
						검색결과 <strong>12건</strong>
					</div>
				</div>
			</div>
			<!-- End row -->
			<div class="row" style="margin-bottom:40px;">
				<div class="threefourth last col">
					<div class="pressbbs">
						<div class="nonresult">
						검색결과가 없습니다.
						</div>
						<div class="report first">
						   <div>
						    <a class="report-thumb" style="background:url(../images/presslogo/p_01.gif)" href="presscenterView.jsp" title="마리끌레르, 2013년 6월호"></a>
						    <a class="report-link" href="#">
							<div class="report-title">마리끌레르 2013년 6월호</div>
						    <span class="meta"><strong>DATE</strong> 2013.08.23</span>
							</a>
						   </div>
						</div>
						<div class="report">
						   <div>
						    <a class="report-thumb" style="background:url(../images/presslogo/p_02.gif)" href="presscenterView.jsp" title="헬스조선, 2013 4월30일자"></a>
						    <a class="report-link" href="#">
							<div class="report-title">헬스조선, 2013 4월30일자</div>
						    <span class="meta"><strong>DATE</strong> 2013.08.23</span>
							</a>
						   </div>
						</div>
						<div class="report">
						   <div>
						    <a class="report-thumb" style="background:url(../images/presslogo/p_03.gif)" href="presscenterView.jsp" title="레몬트리, 2013년 4월호"></a>
						    <a class="report-link" href="#">
							<div class="report-title">레몬트리, 2013년 4월호</div>
						    <span class="meta"><strong>DATE</strong> 2013.08.23</span>
							</a>
						   </div>
						</div>
						<div class="report last">
						   <div>
						    <a class="report-thumb" style="background:url(../images/presslogo/p_04.gif)" href="presscenterView.jsp" title="중앙일보. 2012년 11월14일자"></a>
						    <a class="report-link" href="#">
							<div class="report-title">중앙일보. 2012년 11월14일자</div>
						    <span class="meta"><strong>DATE</strong> 2013.08.23</span>
							</a>
						   </div>
						</div>
						<div class="report first">
						   <div>
						    <a class="report-thumb" style="background:url(../images/presslogo/p_05.gif)" href="presscenterView.jsp" title="마리끌레르, 2013년 6월호"></a>
						    <a class="report-link" href="#">
							<div class="report-title">마리끌레르 2013년 6월호</div>
						    <span class="meta"><strong>DATE</strong> 2013.08.23</span>
							</a>
						   </div>
						</div>
						<div class="report">
						   <div>
						    <a class="report-thumb" style="background:url(../images/presslogo/p_06.gif)" href="presscenterView.jsp" title="헬스조선, 2013 4월30일자"></a>
						    <a class="report-link" href="#">
							<div class="report-title">헬스조선, 2013 4월30일자</div>
						    <span class="meta"><strong>DATE</strong> 2013.08.23</span>
							</a>
						   </div>
						</div>
						<div class="report">
						   <div>
						    <a class="report-thumb" style="background:url(../images/presslogo/p_07.gif)" href="presscenterView.jsp" title="레몬트리, 2013년 4월호"></a>
						    <a class="report-link" href="#">
							<div class="report-title">레몬트리, 2013년 4월호</div>
						    <span class="meta"><strong>DATE</strong> 2013.08.23</span>
							</a>
						   </div>
						</div>
						<div class="report last">
						   <div>
						    <a class="report-thumb" style="background:url(../images/presslogo/p_08.gif)" href="presscenterView.jsp" title="중앙일보. 2012년 11월14일자"></a>
						    <a class="report-link" href="#">
							<div class="report-title">중앙일보. 2012년 11월14일자</div>
						    <span class="meta"><strong>DATE</strong> 2013.08.23</span>
							</a>
						   </div>
						</div>
						<div class="report first">
						   <div>
						    <a class="report-thumb" style="background:url(../images/presslogo/p_09.gif)" href="presscenterView.jsp" title="마리끌레르, 2013년 6월호"></a>
						    <a class="report-link" href="#">
							<div class="report-title">마리끌레르 2013년 6월호</div>
						    <span class="meta"><strong>DATE</strong> 2013.08.23</span>
							</a>
						   </div>
						</div>
						<div class="report">
						   <div>
						    <a class="report-thumb" style="background:url(../images/presslogo/p_10.gif)" href="presscenterView.jsp" title="헬스조선, 2013 4월30일자"></a>
						    <a class="report-link" href="#">
							<div class="report-title">헬스조선, 2013 4월30일자</div>
						    <span class="meta"><strong>DATE</strong> 2013.08.23</span>
							</a>
						   </div>
						</div>
						<div class="report">
						   <div>
						    <a class="report-thumb" style="background:url(../images/presslogo/p_11.gif)" href="presscenterView.jsp" title="레몬트리, 2013년 4월호"></a>
						    <a class="report-link" href="#">
							<div class="report-title">레몬트리, 2013년 4월호</div>
						    <span class="meta"><strong>DATE</strong> 2013.08.23</span>
							</a>
						   </div>
						</div>
						<div class="report last">
						   <div>
						    <a class="report-thumb" style="background:url(../images/presslogo/p_12.gif)" href="presscenterView.jsp" title="중앙일보. 2012년 11월14일자"></a>
						    <a class="report-link" href="#">
							<div class="report-title">중앙일보. 2012년 11월14일자</div>
						    <span class="meta"><strong>DATE</strong> 2013.08.23</span>
							</a>
						   </div>
						</div>
					</div>
					<!-- End pressbbs -->
				</div>
			</div>
			<!-- End row -->
			<div class="row">
			    <div class="threefourth last col">
				<div class="pageNavi">
					  <a class="latelypostslink" href="#"><<</a>
					  <a class="previouspostslink" href="#"><</a>
					  <span class="current">1</span>
					  <a href="#">2</a>
					  <a href="#">3</a>
					  <a href="#">4</a>
					  <a href="#">5</a>
					  <a class="firstpostslink" href="#">></a>
					  <a class="nextpostslink" href="#">>></a>
					</div>
				</div>	
			</div>
		</div>
		<!-- End twelve columns offset-by-one -->
		<div class="sidebar four columns">
		    <p><a href="#"><img src="../images/side_banner_01.jpg" alt="잇슬림 한눈에 알아보기" width="242" height="211" /></a></p>
			<div class="bestfaq">
			   <h3>자주하는 질문</h3>
			   <ul>
			       <li><a href="#">식단 구매시 잇슬림 퀴진 이외 어떤 서비스를 받게되나요?</a></li>
				   <li><a href="#">프로그램 진행 중 궁금한 사항이 있으면 어떻게 하면 되나요?</a></li>
				   <li><a href="#">잇슬림 퀴진에 대해 설면해 주세요.</a></li>
				   <li><a href="#">어떤 종류의 음식이 제공되나요?</a></li>
				   <li><a href="#">별도의 조리가 필요한가요?</a></li>
			   </ul>
			</div>
		</div>
		<!-- End sidebar four columns -->
		<div class="clear">
		</div>
	</div>
	<!-- End container -->
	<div id="footer">		
		<%@ include file="/common/include/inc-footer.jsp"%>
	</div> <!-- End footer -->
	<div id="floatMenu">
		<%@ include file="/common/include/inc-floating.jsp"%>
	</div>
	<%@ include file="/common/include/inc-bottompanel.jsp"%>
</div>
</body>
</html>