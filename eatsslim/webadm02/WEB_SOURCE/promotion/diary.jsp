<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<style>
.archive-title {
	position:relative;
	border-bottom:1px solid #DEDEDE;
	padding:10px;
}
.archive-pagenavi {
	position:absolute;
	width:100%;
	left:0;
	top:13px;
}
.archive-pagenavi .prev {
	position:absolute;
	left:10px;
	width:25px;
	height:25px;
}
.archive-pagenavi .next {
	position:absolute;
	right:10px;
	width:25px;
	height:25px;
}
.archive-view {
	margin:25px;
	text-align:left;
}
.dailylist {
	margin:15px;
}
.dailylist li {
	float:left;
	display:block;
	margin-right:15px;
	text-align:center;
}
.dailylist li img {
	margin-bottom:5px;
}
.dailylist li p {
	margin-bottom:0;
}
</style>    
</head>
<body>
	<div class="pop-wrap">
		<div class="headpop">
		    <h2>최과장의 다이어트 일기</h2>
			<p></p>
		</div>
	    <div class="contentpop">
		    <div class="columns offset-by-one"> 
				<div class="row">
				   <div class="one last col center">
                      <div class="archive-title">
                         <h3>다이어리 제목입니다.</h3>
                         <div class="archive-pagenavi">
                           <a class="prev" href="#">&lt;&lt;</a>
                           <a class="next" href="#">&gt;&gt;</a>
                         </div>
                      </div>
                      <div class="dayfood">
                         <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td width="105" align="center" bgcolor="#58B7DD" style="color:#FFF;">제공된<br>잇슬림제품</td>
                            <td bgcolor="#F4F4F4">
                                <ul class="dailylist">
                                  <li>
                                     <img src="/images/promotion/pr1120/thumb.jpg" width="95" height="74">
                                     <p>시크릿수프</p>
                                  </li>
                                  <li>
                                     <img src="/images/promotion/pr1120/thumb.jpg" width="95" height="74">
                                     <p>시크릿수프</p>
                                  </li>
                                  <li>
                                     <img src="/images/promotion/pr1120/thumb.jpg" width="95" height="74">
                                     <p>시크릿수프</p>
                                  </li>
                                  <li>
                                     <img src="/images/promotion/pr1120/thumb.jpg" width="95" height="74">
                                     <p>시크릿수프</p>
                                  </li>
                                  <div class="clear"></div>
                                </ul>
                            </td>
                          </tr>
                        </table>

                      </div>
                      <div class="archive-view">
                        <p>다이어트 일기입니다.다이어트 일기입니다.다이어트 일기입니다.다이어트 일기입니다.다이어트 일기입니다.다이어트 일기입니다.다이어트 일기입니다.다이어트 일기입니다.다이어트 일기입니다.</p>
                      </div>
                      
                   </div> 
				</div>
				<!-- End row -->  
			  </div>
			  <!-- End popup columns offset-by-one -->	
		</div>
		<!-- End contentpop -->
	</div>
</body>
</html>