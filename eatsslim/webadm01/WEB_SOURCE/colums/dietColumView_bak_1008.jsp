<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<script type="text/javascript">
    $(document).ready(function(){
        //  Focus auto-focus fields
        $('.auto-focus:first').focus();
        
        //  Initialize auto-hint fields
        $('INPUT.auto-hint, TEXTAREA.auto-hint').focus(function(){
            if($(this).val() == $(this).attr('title')){ 
                $(this).val('');
                $(this).removeClass('auto-hint');
            }
        });
        
        $('INPUT.auto-hint, TEXTAREA.auto-hint').blur(function(){
            if($(this).val() == '' && $(this).attr('title') != ''){ 
                $(this).val($(this).attr('title'));
                $(this).addClass('auto-hint'); 
            }
        });
        
        $('INPUT.auto-hint, TEXTAREA.auto-hint').each(function(){
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
				다이어트 칼럼
			</h1>
			<div class="pageDepth">
				HOME > GO! 다이어트 > <strong>다이어트 칼럼</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="thirteen columns offset-by-one">
            <div class="row">
			    <div class="one last  col">
				   <div class="post-wrapper">
				      <div class="post-read">
					      <h2>14일 집중감량 프로그램 출시기념 22% 할인쿠폰 지급!</h2>
							  <ul class="meta-wrap">
								  <li><span class="cate"></span>다이어트 속설과 과학</li>
                                  <li><span class="date"></span>13.08.29</li>
								  <li><span class="account"></span>3,105</li>
								  <li><span class="comment"></span>121</li>
                                  <li style="float:right;">SNS Share</li>
							  </ul>
							  <div class="clear"></div>
						  <div class="post-contents">
						      <img src="/images/post_sample.jpg">
                            <!-- 이전/다음 컬럼 보기 -->
                            <div class="viewNavi">
                               <span class="prebtn floatleft"><a href="#"></a></span>
                               <span class="nextbtn floatright"><a href="#"></a></span>
                            </div>
                            <!-- End 이전/다음 컬럼 보기-->
						  </div>
						  <div class="col center"><div class="button small dark"><a href="/colums/dietColum.jsp">목록</a></div></div>
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
							  <textarea id="message" name="message" class="auto-hint" title="로그인 후 댓글을 입력해 주세요. 게시판과 무관한 욕설, 비방, 광고댓글은 임의로 삭제될 수 있습니다."></textarea>
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
        <%@ include file="/common/include/inc-sidecolums.jsp"%>
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
</div>
</body>
</html>