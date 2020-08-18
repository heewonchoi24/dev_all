<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<style>
.promotiontabNavi {
	margin-left:6px;
}
.promotiontabNavi li {
	float: left;
	margin-right: 5px;
}
.eventchapter {
	position: relative;
}
.eventchapter .support {
	display: block;
	position: absolute;
	width: 108px;
	height: 108px;
}
.eventchapter .support.a-part {
	left: 49px;
	top: 348px;
}
.eventchapter .support.b-part {
	left: 204px;
	top: 348px;
}
.eventchapter .a-account {
	position:absolute;
	left:37px;
	top:666px;
}
.eventchapter .b-account {
	position:absolute;
	left:198px;
	top:666px;
}
.eventchapter .a-account input, .eventchapter .b-account input {
	width:124px;
	height:62px;
	font-size:44px;
	font-weight:700;
	line-height:62px;
	text-align:center;
	border:none;
	background:transparent;
}
.eventchapter .diary-btn-a, .eventchapter .diary-btn-b {
	position:absolute;
	display:block;
	width:102px;
	height:92px;
}
.eventchapter .diary-btn-a {
	left:377px;
	top:310px;
}
.eventchapter .diary-btn-b {
	left:884px;
	top:310px;
}
.eventchapter .support-btn {
	position:absolute;
	display:block;
	left:28px;
	top:558px;
	width:344px;
	height:54px;
}
.eventchapter .choi-diary {
	position:absolute;
	left:28px;
	top:222px;
	width:460px;
	height:266px;
}
.eventchapter .choi-diary ul , .eventchapter .lee-diary ul  {
	margin:25px 30px 20px;
}
.eventchapter .advisor-comment ul {
	margin:15px 30px;
}
.eventchapter .choi-diary ul li, .eventchapter .lee-diary ul li, .eventchapter .advisor-comment ul li {
	line-height:200%;
}
.eventchapter .choi-diary span, .eventchapter .lee-diary span, .eventchapter .advisor-comment span {
	padding-right:40px;
}
.eventchapter .choi-diary span {
	color:#00A4A6;
}
.eventchapter .lee-diary {
	position:absolute;
	left:533px;
	top:222px;
	width:460px;
	height:266px;
}
.eventchapter .lee-diary span {
	color:#EF6797;
}
.eventchapter .advisor-comment {
	position:absolute;
	left:285px;
	top:518px;
	width:712px;
	height:167px;
}
.pageNavipr {
	margin:0 auto;
	font-size:11px;
	clear:both;
	display:block;
	text-align:center;
	padding:3px;
	height:15;
	line-height:15px;
}
.pageNavipr span.current {
	color:#FF6600;
}
.pageNavipr a, .pageNavipr span {
	color: #555;
	display: inline-block;
	zoom:1;
	display: -moz-inline-stack;
 *display:inline/*IE7 HACK*/;
	_display:inline;/*IE6 HACK*/
	font-size: 11px;
	margin-left: 3px;
	text-align: center;
	width: 15px;
}

</style>
</head><body>
<div id="wrap">
  <div id="header">
    <%@ include file="/common/include/inc-header.jsp"%>
  </div>
  <!-- End header -->
  <div class="container" style="width:1024px;">
    <div class="maintitle">
      <h1> 최과장 VS 이대리 </h1>
      <div class="pageDepth"> HOME > <strong>잇슬림 프로모션</strong> </div>
      <div class="clear"> </div>
    </div>
    <div class="row">
      <div id="event01" class="marb50">
        <ul class="promotiontabNavi marb20">
          <li class="active"> <a href="#event01"><img src="/images/promotion/pr1120/btn_01_on.png" width="334" height="56" alt="event-1"></a> </li>
          <li> <a href="#event02"><img src="/images/promotion/pr1120/btn_02_off.png" width="334" height="56" alt="event-2"></a> </li>
          <li> <a href="#event03"><img src="/images/promotion/pr1120/btn_03_off.png" width="334" height="56" alt="event-3"></a> </li>
          <div class="clear"></div>
        </ul>
        <div class="eventchapter" style="background:url(/images/promotion/pr1120/pr_top.jpg) no-repeat 0 0; width:1024px; height:756px;"> 
        <a href="#" class="support a-part"></a> 
        <a href="#" class="support b-part"></a>
          <div class="a-account">
            <input type="text" value="0" readonly="readonly">
          </div>
          <div class="b-account">
            <input type="text" value="0" readonly="readonly">
          </div>
        </div>
        <div><img src="/images/promotion/pr1120/pr_top_info.jpg" width="1024" height="458"></div>
      </div>
      <div id="event02" class="marb40">
        <ul class="promotiontabNavi marb20">
          <li> <a href="#event01"><img src="/images/promotion/pr1120/btn_01_off.png" width="334" height="56" alt="event-1"></a> </li>
          <li> <a href="#event02"><img src="/images/promotion/pr1120/btn_02_on.png" width="334" height="56" alt="event-2"></a> </li>
          <li> <a href="#event03"><img src="/images/promotion/pr1120/btn_03_off.png" width="334" height="56" alt="event-3"></a> </li>
          <div class="clear"></div>
        </ul>
        <div class="eventchapter" style="background:url(/images/promotion/pr1120/pr_middle.jpg) no-repeat 0 0; width:1024px; height:644px;"> 
        <a href="#" class="diary-btn-a"><img src="/images/promotion/pr1120/btn_diary_a.png" width="102" height="92"></a> 
        <a href="#" class="diary-btn-b"><img src="/images/promotion/pr1120/btn_diary_b.png" width="102" height="92"></a> 
        <a href="#" class="support-btn"><img src="/images/promotion/pr1120/btn_contact.png" width="344" height="54"></a> 
        </div>
      </div>
      <div id="event03" class="marb50">
        <ul class="promotiontabNavi marb20">
          <li> <a href="#event01"><img src="/images/promotion/pr1120/btn_01_off.png" width="334" height="56" alt="event-1"></a> </li>
          <li> <a href="#event02"><img src="/images/promotion/pr1120/btn_02_off.png" width="334" height="56" alt="event-2"></a> </li>
          <li> <a href="#event03"><img src="/images/promotion/pr1120/btn_03_on.png" width="334" height="56" alt="event-3"></a> </li>
          <div class="clear"></div>
        </ul>
        <div class="eventchapter marb50" style="background:url(/images/promotion/pr1120/pr_bottom.jpg) no-repeat 0 0; width:1024px; height:696px;">
           <div class="choi-diary">
              <ul>
                  <li><a href="javascript:;" onClick="window.open('/promotion/diary.jsp','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=900,height=500')"><span>7일차(화)</span>벌써 일주일째다.</a></li>
                  <li><a href="javascript:;" onClick="window.open('/promotion/diary.jsp','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=900,height=500')"><span>6일차(월)</span>벌써 일주일째다.</a></li>
                  <li><a href="javascript:;" onClick="window.open('/promotion/diary.jsp','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=900,height=500')"><span>5일차(일)</span>벌써 일주일째다.</a></li>
                  <li><a href="javascript:;" onClick="window.open('/promotion/diary.jsp','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=900,height=500')"><span>4일차(토)</span>벌써 일주일째다.</a></li>
                  <li><a href="javascript:;" onClick="window.open('/promotion/diary.jsp','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=900,height=500')"><span>3일차(금)</span>벌써 일주일째다.</a></li>
                  <li><a href="javascript:;" onClick="window.open('/promotion/diary.jsp','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=900,height=500')"><span>2일차(목)</span>벌써 일주일째다.</a></li>
                  <li><a href="javascript:;" onClick="window.open('/promotion/diary.jsp','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=900,height=500')"><span>1일차(수)</span>벌써 일주일째다.</a></li>
              </ul>
              <div class="pageNavipr">
                  <a class="latelypostslink" href="#">&lt;&lt;</a>
                  <a class="previouspostslink" href="#">&lt;</a>
                  <a href="#">1</a>
                  <a href="#">2</a>
                  <a href="#">3</a>
                  <a href="#">4</a>
                  <a href="#">5</a>
                  <a class="firstpostslink" href="#">&gt;</a>
                  <a class="nextpostslink" href="#">&gt;&gt;</a>
              </div>
           </div>
           <div class="lee-diary">
           <ul>
                  <li><a href="javascript:;" onClick="window.open('/promotion/diary.jsp','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=900,height=500')"><span>7일차(화)</span>아! 치맥의 유혹...</a></li>
                  <li><a href="javascript:;" onClick="window.open('/promotion/diary.jsp','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=900,height=500')"><span>6일차(월)</span>아! 치맥의 유혹...</a></li>
                  <li><a href="javascript:;" onClick="window.open('/promotion/diary.jsp','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=900,height=500')"><span>5일차(일)</span>아! 치맥의 유혹...</a></li>
                  <li><a href="javascript:;" onClick="window.open('/promotion/diary.jsp','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=900,height=500')"><span>4일차(토)</span>아! 치맥의 유혹...</a></li>
                  <li><a href="javascript:;" onClick="window.open('/promotion/diary.jsp','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=900,height=500')"><span>3일차(금)</span>아! 치맥의 유혹...</a></li>
                  <li><a href="javascript:;" onClick="window.open('/promotion/diary.jsp','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=900,height=500')"><span>2일차(목)</span>아! 치맥의 유혹...</a></li>
                  <li><a href="javascript:;" onClick="window.open('/promotion/diary.jsp','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=900,height=500')"><span>1일차(수)</span>아! 치맥의 유혹...</a></li>
              </ul>
              <div class="pageNavipr">
                  <a class="latelypostslink" href="#">&lt;&lt;</a>
                  <a class="previouspostslink" href="#">&lt;</a>
                  <a href="#">1</a>
                  <a href="#">2</a>
                  <a href="#">3</a>
                  <a href="#">4</a>
                  <a href="#">5</a>
                  <a class="firstpostslink" href="#">&gt;</a>
                  <a class="nextpostslink" href="#">&gt;&gt;</a>
              </div>
           </div>
           <div class="advisor-comment">
           <ul>
                  <li><a href="javascript:;" onClick="window.open('/promotion/comment.jsp','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=900,height=500')"><span>2013.11.20~2013.11.27</span>꾸준히 잘 따라오셨네요.</a></li>
                  <li><a href="javascript:;" onClick="window.open('/promotion/comment.jsp','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=900,height=500')"><span>2013.11.20~2013.11.27</span>꾸준히 잘 따라오셨네요.</a></li>
                  <li><a href="javascript:;" onClick="window.open('/promotion/comment.jsp','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=900,height=500')"><span>2013.11.20~2013.11.27</span>꾸준히 잘 따라오셨네요.</a></li>
                  <li><a href="javascript:;" onClick="window.open('/promotion/comment.jsp','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=900,height=500')"><span>2013.11.20~2013.11.27</span>꾸준히 잘 따라오셨네요.</a></li>
              </ul>
              <div class="pageNavipr">
                  <a class="latelypostslink" href="#">&lt;&lt;</a>
                  <a class="previouspostslink" href="#">&lt;</a>
                  <a href="#">1</a>
                  <a href="#">2</a>
                  <a href="#">3</a>
                  <a href="#">4</a>
                  <a href="#">5</a>
                  <a class="firstpostslink" href="#">&gt;</a>
                  <a class="nextpostslink" href="#">&gt;&gt;</a>
              </div>
           </div>
           
        </div>
        <div><img src="/images/promotion/pr1120/pr_preview.jpg" width="1024" height="228"></div>
      </div>
    </div>
    <!-- End Row -->
    <div class="clear"> </div>
  </div>
  <!-- End container -->
  <div id="footer">
    <%@ include file="/common/include/inc-footer.jsp"%>
  </div>
  <!-- End footer -->
  <div id="floatMenu">
    <%@ include file="/common/include/inc-floating.jsp"%>
  </div>
</div>
</body>
</html>