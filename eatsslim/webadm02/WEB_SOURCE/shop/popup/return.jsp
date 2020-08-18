<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />

	<title>반품 상세내역</title>

</head>
<body>
	<div class="pop-wrap">
		<div class="headpop">
		    <h2>반품 상세내역</h2>
			<p></p>
		</div>
	    <div class="contentpop">
		    <div class="popup columns offset-by-one"> 
                    <form action="" method="post">
                    <div class="row">
					    <div class="one last col">
                            <div class="sectionHeader">
                                <h3>반품 신청내역</h>
                            </div>
                               <table class="inputfield" width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <th>신청일</th>
                                    <td>2013.08.29 14:47:25 /구매자</td>
                                    <th>교환완료일</th>
                                    <td>2013.08.29 14:47:25 /구매자</td>
                                 </tr>
                                <tr>
                                    <th>교환사유</th>
                                    <td colspan="3"><span class="bold7">구매의사 취소</span> 다른 제품으로 구입하기 위해</td>
                                </tr>
                                <tr>
                                    <th>교환 운송장 정보</th>
                                    <td colspan="3">
                                     <p><label>택배사</label><input name="" type="text" class="ftfd" style="width:200px;"></p>
                                     <p><label>택배 배송일</label><input name="" type="text" class="ftfd" style="width:200px;"></p>
                                     <p><label>송장번호 입력</label><input name="" type="text" class="ftfd" style="width:200px;"> <span class="button dark small"><a href="#">배송조회</a></span></p>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <!-- End row -->
                    <div class="row">
					    <div class="one last col">
                            <div class="sectionHeader">
                                <h4>반품 보류 사유</h4>
                           </div>
                               <table class="inputfield" width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td>
                                    <textarea cols="" rows="7" style="width:600px;"></textarea>
                                  </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <!-- End row -->
                    </form>
                    <div class="row">
                        <div class="one last col center">
                            <div class="button large dark">
                                <a class="lightbox" href="/shop/popup/returnResult.jsp?lightbox[width]=700&lightbox[height]=500">확인</a>
                            </div>
                        </div>	
		        	</div>
			  </div>
			  <!-- End popup columns offset-by-one -->	
		</div>
		<!-- End contentpop -->
	</div>
</body>
</html>