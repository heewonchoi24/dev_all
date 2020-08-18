<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<script type="text/javascript">
    $(document).ready(function() {
        $('#comment.auto-hint').focus(function(){
            if($(this).val() == $(this).attr('title')){ 
                $(this).val('');
                $(this).removeClass('auto-hint');
            }
        });
        
        $('#comment.auto-hint').blur(function(){
            if($(this).val() == '' && $(this).attr('title') != ''){ 
                $(this).val($(this).attr('title'));
                $(this).addClass('auto-hint'); 
            }
        });
        
        $('#comment.auto-hint').each(function(){
            if($(this).attr('title') == ''){ return; }
            if($(this).val() == ''){ $(this).val($(this).attr('title')); }
            else { $(this).removeClass('auto-hint'); } 
        });
    });
</script>
</head>
<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div> <!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1>
				진행중인 이벤트
			</h1>
			<div class="pageDepth">
				HOME > EVENT > <strong>진행중인 이벤트</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="sixteen columns offset-by-one">
			<div class="row">
			    <div class="one last  col">
				   <div class="post-wrapper">
				      <div class="post-read">
					      <h2>14일 집중감량 프로그램 출시기념 22% 할인쿠폰 지급!</h2>
							  <ul class="meta-wrap">
								  <li><span class="time"></span><strong>이벤트기간</strong> 2013.08.01 ~ 2013.08.14</li>
								  <li><span class="who"></span><strong>이벤트대상</strong> 잇슬림 온라인 가입고객 모두</li>
								  <li><span class="win"></span><strong>당첨자발표</strong> 2013.08.16</li>
                                  <li style="float:right;">SNS Share</li>
							  </ul>
							  <div class="clear"></div>
						  <div class="post-contents">
						      <img src="/images/event_sample.jpg">
						  </div>
						  <div class="col center"><div class="button small dark"><a href="/event/currentEvent.jsp">목록</a></div></div>
						  <div class="comment-wrap">
						      <div class="sectionHeader">
								  <h4>
									  댓글(1)
								  </h4>
								  <div class="floatright button dark small">
								     <a href="#">댓글등록</a>
								  </div>
								  <div class="clear"></div>
							  </div>
							  <textarea id="comment" name="comment" class="auto-hint" title="로그인 후 댓글을 입력해 주세요. 게시판과 무관한 욕설, 비방, 광고댓글은 임의로 삭제될 수 있습니다."></textarea>
						      <ul>
							    <li class="comment depth-1" >
								   <div class="commentheader">
								       <h5>hong8****</h5>
									   <div class="metastamp">2013.08.07</div>
									   <div class="myadmin">
								       <a href="#">댓글</a> ㅣ <a href="#">수정</a> ㅣ <a href="#">삭제</a>
								   </div>
								   </div>
								   <p>행복바이러스의 힘! 잘보고 갑니다.</p>
								   <div class="lineSeparator"></div>
								   <ul>
								       <li class="comment depth-2" >
									   <div class="commentheader">
										   <h5>관리자</h5>
										   <div class="metastamp">2013.08.07</div>
									   </div>
									   <p>네 고객님 화이팅입니다.</p>
									   <div class="lineSeparator"></div>
									   </li>
								   </ul>
								</li>
							  </ul>
						  </div>
					  </div>
				   </div>
				</div>
			</div>
			<!-- End Row -->
		</div>
		<!-- End sixteen columns offset-by-one -->
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