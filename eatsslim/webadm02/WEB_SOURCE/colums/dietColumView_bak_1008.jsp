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
				���̾�Ʈ Į��
			</h1>
			<div class="pageDepth">
				HOME > GO! ���̾�Ʈ > <strong>���̾�Ʈ Į��</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="thirteen columns offset-by-one">
            <div class="row">
			    <div class="one last  col">
				   <div class="post-wrapper">
				      <div class="post-read">
					      <h2>14�� ���߰��� ���α׷� ��ñ�� 22% �������� ����!</h2>
							  <ul class="meta-wrap">
								  <li><span class="cate"></span>���̾�Ʈ �Ӽ��� ����</li>
                                  <li><span class="date"></span>13.08.29</li>
								  <li><span class="account"></span>3,105</li>
								  <li><span class="comment"></span>121</li>
                                  <li style="float:right;">SNS Share</li>
							  </ul>
							  <div class="clear"></div>
						  <div class="post-contents">
						      <img src="/images/post_sample.jpg">
                            <!-- ����/���� �÷� ���� -->
                            <div class="viewNavi">
                               <span class="prebtn floatleft"><a href="#"></a></span>
                               <span class="nextbtn floatright"><a href="#"></a></span>
                            </div>
                            <!-- End ����/���� �÷� ����-->
						  </div>
						  <div class="col center"><div class="button small dark"><a href="/colums/dietColum.jsp">���</a></div></div>
						  <div class="comment-wrap">
						      <div class="sectionHeader">
								  <h4>
									  ���(1)
								  </h4>
								  <div class="floatright button dark small">
								     <a href="#">��۵��</a>
								  </div>
								  <div class="clear"></div>
							  </div>
							  <textarea id="message" name="message" class="auto-hint" title="�α��� �� ����� �Է��� �ּ���. �Խ��ǰ� ������ �弳, ���, �������� ���Ƿ� ������ �� �ֽ��ϴ�."></textarea>
						      <ul>
							    <li class="comment depth-1" >
								   <div class="commentheader">
								       <h5>hong8****</h5>
									   <div class="metastamp">2013.08.07</div>
									   <div class="myadmin">
								       <a href="#">���</a> �� <a href="#">����</a> �� <a href="#">����</a>
								   </div>
								   </div>
								   <p>�ູ���̷����� ��! �ߺ��� ���ϴ�.</p>
								   <div class="lineSeparator"></div>
								   <ul>
								       <li class="comment depth-2" >
									   <div class="commentheader">
										   <h5>������</h5>
										   <div class="metastamp">2013.08.07</div>
									   </div>
									   <p>�� ���� ȭ�����Դϴ�.</p>
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