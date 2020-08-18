<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>

<%@ include file="myMatching_header.jsp"%>

<div class="pop-wrap">

	<%@ include file="myMatching_title.jsp"%>

	<div class="contentpop">
		<div class="popup columns offset-by-one"> 

			<div class="row">
				<div class="one last col center">
					<h4 class="mart20 font-blue">Q. 나의 다이어트 스타일?</h4>

					<div class="divider"></div>

					<a id="choiceA" href="myMatching_result_3.jsp">
						<div class="stepCheck choice" style="float:left;">
							<span class="checkA"></span>
							<p>간편한 쉐이크</p>
						</div>
					</a>

					<a id="choiceB" href="myMatching_result_4.jsp">
						<div class="stepCheck choice" style="float:right;">
							<span class="checkB"></span>
							<p>신선하고 맛있는 수프 스타일</p>
						</div>
					</a>

					<div class="clear"></div>
				</div>
			</div>
			<!-- End row -->  

			<div class="row">
				<div class="one last col center">
					<!-- <p class="floatleft">* 유형을 선택하신 후 다음 버튼을 클릭해 주세요.</p> -->
					<p class="floatleft">* 유형을 선택해 주세요.</p>
					<div class="floatright">
					<div class="button large gray"><a href="javascript:history.back(-1);">< 이전</a></div>
						<!-- <div class="button large dark lightbox"><a href="/shop/popup/myrecommend.jsp">결과보기 ></a></div> -->
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