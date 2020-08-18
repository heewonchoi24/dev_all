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
	margin-right:15px;
}
.dailylist li a {
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
		    <h2>전문가 주간 코멘트</h2>
			<p></p>
		</div>
	    <div class="contentpop">
		    <div class="columns offset-by-one"> 
				<div class="row">
				   <div class="one last col center">
                      <div class="archive-title">
                         <h3>2013.11.20 ~ 2013.11.27 꾸준히 잘 따라 오셨네요.</h3>
                         <div class="archive-pagenavi">
                           <a class="prev" href="#">&lt;&lt;</a>
                           <a class="next" href="#">&gt;&gt;</a>
                         </div>
                      </div>
                      
                      <div class="archive-view">
                        <p>전문가 코멘트입니다.전문가 코멘트입니다.전문가 코멘트입니다.전문가 코멘트입니다.전문가 코멘트입니다.전문가 코멘트입니다.전문가 코멘트입니다.전문가 코멘트입니다.</p>
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