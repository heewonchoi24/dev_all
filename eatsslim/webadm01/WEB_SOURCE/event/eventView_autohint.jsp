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
				�������� �̺�Ʈ
			</h1>
			<div class="pageDepth">
				HOME > EVENT > <strong>�������� �̺�Ʈ</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="sixteen columns offset-by-one">
			<div class="row">
			    <div class="one last  col">
				   <div class="post-wrapper">
				      <div class="post-read">
					      <h2>14�� ���߰��� ���α׷� ��ñ�� 22% �������� ����!</h2>
							  <ul class="meta-wrap">
								  <li><span class="time"></span><strong>�̺�Ʈ�Ⱓ</strong> 2013.08.01 ~ 2013.08.14</li>
								  <li><span class="who"></span><strong>�̺�Ʈ���</strong> �ս��� �¶��� ���԰� ���</li>
								  <li><span class="win"></span><strong>��÷�ڹ�ǥ</strong> 2013.08.16</li>
                                  <li style="float:right;">SNS Share</li>
							  </ul>
							  <div class="clear"></div>
						  <div class="post-contents">
						      <img src="/images/event_sample.jpg">
						  </div>
						  <div class="col center"><div class="button small dark"><a href="/event/currentEvent.jsp">���</a></div></div>
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
							  <textarea id="comment" name="comment" class="auto-hint" title="�α��� �� ����� �Է��� �ּ���. �Խ��ǰ� ������ �弳, ���, �������� ���Ƿ� ������ �� �ֽ��ϴ�."></textarea>
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