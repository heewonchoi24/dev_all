<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>

<%@ include file="myMatching_header.jsp"%>

<div class="pop-wrap">

	<%@ include file="myMatching_title.jsp"%>

	<div class="contentpop">
		<div class="popup columns offset-by-one"> 

			<div class="row">
				<div class="one last col center">
					
					<h4 class="mart20 font-blue">Q. ���� ���̾�Ʈ �ܰ� �� � STEP�ΰ���?</h4>
					
					<div class="divider"></div>

					<a id="choiceA" href="myMatching_step1-1.jsp">
						<div class="stepCheck choice" style="float:left;">
							<span class="checkA"></span>
							<p>ü�߰��� ������ �ʿ��� �ܰ��̴�.</p>
						</div>
					</a>

					<a id="choiceB" href="myMatching_step1-2.jsp">
						<div class="stepCheck choice" style="float:right;">
							<span class="checkB"></span>
							<p>���̾�Ʈ�� ������� ����������,<br />
							ü�߰��� �ӵ��� �����ϸ鼭 ������<br />
							ü���� �����ϴ� �Ϳ� ������ �ִ�.</p>
						</div>
					</a>
					
					<div class="clear"></div>  
					
				</div>
			</div>
			<!-- End row -->  

			<div class="row">
				<div class="one last col center">
					<!-- <p class="floatleft">* ������ �����Ͻ� �� ���� ��ư�� Ŭ���� �ּ���.</p> -->
					<p class="floatleft">* ������ ������ �ּ���.</p>
					<div class="floatright">
						<!-- <div class="button large gray"><a href="#">< ����</a></div> -->
						<!-- <div class="button large dark lightbox"><a href="/shop/popup/myrecommend.jsp">������� ></a></div> -->
					</div>
				</div>
			</div>
			<!-- End row -->

		</div>
		<!-- End popup columns offset-by-one -->	

	</div>
	<!-- End contentpop -->

</div>

<%@ include file="myMatching_footer.jsp"%>