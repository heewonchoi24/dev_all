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
				��к���
			</h1>
			<div class="pageDepth">
				HOME > ������ > <strong>��к���</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="twelve columns offset-by-one ">
			<div class="row">
				<div class="threefourth last col">
					<ul class="tabNavi">
						<li>
							<a href="notice.jsp">��������</a>
						</li>
						<li>
							<a href="faq.jsp">FAQ</a>
						</li>
						<li>
							<a href="indiqna.jsp">1:1����</a>
						</li>
						<li>
							<a href="service_member.jsp">�̿�ȳ�</a>
						</li>
						<li class="active">
							<a href="presscenter.jsp">��к���</a>
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
									<option>����</option>
									<option>����</option>
								</select>
							</label>
							<label>
							<input type="text" name="textfield" id="textfield">
							</label>
							<label>
							<input type="submit" class="button dark small" name="button" value="�˻�">
							</label>
					</div>
					<!--div class="floatright">
							<label>
								<select name="select" id="select" class="formsel" >
									<option>4���� ����</option>
									<option>8���� ����</option>
								</select>
							</label>
					</div-->
					<div class="result floatright">
						�˻���� <strong>12��</strong>
					</div>
				</div>
			</div>
			<!-- End row -->
			<div class="row" style="margin-bottom:40px;">
				<div class="threefourth last col">
					<div class="pressbbs">
						<div class="nonresult">
						�˻������ �����ϴ�.
						</div>
						<div class="report first">
						   <div>
						    <a class="report-thumb" style="background:url(../images/presslogo/p_01.gif)" href="presscenterView.jsp" title="����������, 2013�� 6��ȣ"></a>
						    <a class="report-link" href="#">
							<div class="report-title">���������� 2013�� 6��ȣ</div>
						    <span class="meta"><strong>DATE</strong> 2013.08.23</span>
							</a>
						   </div>
						</div>
						<div class="report">
						   <div>
						    <a class="report-thumb" style="background:url(../images/presslogo/p_02.gif)" href="presscenterView.jsp" title="�ｺ����, 2013 4��30����"></a>
						    <a class="report-link" href="#">
							<div class="report-title">�ｺ����, 2013 4��30����</div>
						    <span class="meta"><strong>DATE</strong> 2013.08.23</span>
							</a>
						   </div>
						</div>
						<div class="report">
						   <div>
						    <a class="report-thumb" style="background:url(../images/presslogo/p_03.gif)" href="presscenterView.jsp" title="����Ʈ��, 2013�� 4��ȣ"></a>
						    <a class="report-link" href="#">
							<div class="report-title">����Ʈ��, 2013�� 4��ȣ</div>
						    <span class="meta"><strong>DATE</strong> 2013.08.23</span>
							</a>
						   </div>
						</div>
						<div class="report last">
						   <div>
						    <a class="report-thumb" style="background:url(../images/presslogo/p_04.gif)" href="presscenterView.jsp" title="�߾��Ϻ�. 2012�� 11��14����"></a>
						    <a class="report-link" href="#">
							<div class="report-title">�߾��Ϻ�. 2012�� 11��14����</div>
						    <span class="meta"><strong>DATE</strong> 2013.08.23</span>
							</a>
						   </div>
						</div>
						<div class="report first">
						   <div>
						    <a class="report-thumb" style="background:url(../images/presslogo/p_05.gif)" href="presscenterView.jsp" title="����������, 2013�� 6��ȣ"></a>
						    <a class="report-link" href="#">
							<div class="report-title">���������� 2013�� 6��ȣ</div>
						    <span class="meta"><strong>DATE</strong> 2013.08.23</span>
							</a>
						   </div>
						</div>
						<div class="report">
						   <div>
						    <a class="report-thumb" style="background:url(../images/presslogo/p_06.gif)" href="presscenterView.jsp" title="�ｺ����, 2013 4��30����"></a>
						    <a class="report-link" href="#">
							<div class="report-title">�ｺ����, 2013 4��30����</div>
						    <span class="meta"><strong>DATE</strong> 2013.08.23</span>
							</a>
						   </div>
						</div>
						<div class="report">
						   <div>
						    <a class="report-thumb" style="background:url(../images/presslogo/p_07.gif)" href="presscenterView.jsp" title="����Ʈ��, 2013�� 4��ȣ"></a>
						    <a class="report-link" href="#">
							<div class="report-title">����Ʈ��, 2013�� 4��ȣ</div>
						    <span class="meta"><strong>DATE</strong> 2013.08.23</span>
							</a>
						   </div>
						</div>
						<div class="report last">
						   <div>
						    <a class="report-thumb" style="background:url(../images/presslogo/p_08.gif)" href="presscenterView.jsp" title="�߾��Ϻ�. 2012�� 11��14����"></a>
						    <a class="report-link" href="#">
							<div class="report-title">�߾��Ϻ�. 2012�� 11��14����</div>
						    <span class="meta"><strong>DATE</strong> 2013.08.23</span>
							</a>
						   </div>
						</div>
						<div class="report first">
						   <div>
						    <a class="report-thumb" style="background:url(../images/presslogo/p_09.gif)" href="presscenterView.jsp" title="����������, 2013�� 6��ȣ"></a>
						    <a class="report-link" href="#">
							<div class="report-title">���������� 2013�� 6��ȣ</div>
						    <span class="meta"><strong>DATE</strong> 2013.08.23</span>
							</a>
						   </div>
						</div>
						<div class="report">
						   <div>
						    <a class="report-thumb" style="background:url(../images/presslogo/p_10.gif)" href="presscenterView.jsp" title="�ｺ����, 2013 4��30����"></a>
						    <a class="report-link" href="#">
							<div class="report-title">�ｺ����, 2013 4��30����</div>
						    <span class="meta"><strong>DATE</strong> 2013.08.23</span>
							</a>
						   </div>
						</div>
						<div class="report">
						   <div>
						    <a class="report-thumb" style="background:url(../images/presslogo/p_11.gif)" href="presscenterView.jsp" title="����Ʈ��, 2013�� 4��ȣ"></a>
						    <a class="report-link" href="#">
							<div class="report-title">����Ʈ��, 2013�� 4��ȣ</div>
						    <span class="meta"><strong>DATE</strong> 2013.08.23</span>
							</a>
						   </div>
						</div>
						<div class="report last">
						   <div>
						    <a class="report-thumb" style="background:url(../images/presslogo/p_12.gif)" href="presscenterView.jsp" title="�߾��Ϻ�. 2012�� 11��14����"></a>
						    <a class="report-link" href="#">
							<div class="report-title">�߾��Ϻ�. 2012�� 11��14����</div>
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
		    <p><a href="#"><img src="../images/side_banner_01.jpg" alt="�ս��� �Ѵ��� �˾ƺ���" width="242" height="211" /></a></p>
			<div class="bestfaq">
			   <h3>�����ϴ� ����</h3>
			   <ul>
			       <li><a href="#">�Ĵ� ���Ž� �ս��� ���� �̿� � ���񽺸� �ްԵǳ���?</a></li>
				   <li><a href="#">���α׷� ���� �� �ñ��� ������ ������ ��� �ϸ� �ǳ���?</a></li>
				   <li><a href="#">�ս��� ������ ���� ������ �ּ���.</a></li>
				   <li><a href="#">� ������ ������ �����ǳ���?</a></li>
				   <li><a href="#">������ ������ �ʿ��Ѱ���?</a></li>
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