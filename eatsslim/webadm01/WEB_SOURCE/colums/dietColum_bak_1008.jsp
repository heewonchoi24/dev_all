<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<script type="text/javascript">  
$(document).ready(function(){
    var $container = $('.fluidbox');

    var gutter = 12;
    var min_width = 240;
    $container.imagesLoaded( function(){
        $container.masonry({
            itemSelector : '.box',
            gutterWidth: gutter,
            isAnimated: true,
              columnWidth: function( containerWidth ) {
                var box_width = (((containerWidth - 3*gutter)/4) | 0) ;

                if (box_width < min_width) {
                    box_width = (((containerWidth - gutter)/2) | 0);
                }

                if (box_width < min_width) {
                    box_width = containerWidth;
                }

                $('.box').width(box_width);

                return box_width;
              }
        });
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
		<div class="sixteen columns offset-by-one">
			<div class="row">
                <div class="one last  col">
                    <div class="graytitbox">
                        <ul class="filter floatleft" style="margin-top:5px;">
                            <li class="current"><a href="#">ALL(153)</a></li>
                            <li><a href="#">���̾�Ʈ �Ļ�(53)</a></li>
                            <li><a href="#">���̾�Ʈ ���α׷�(23)</a></li>
                            <li><a href="#">���̾�Ʈ ��ɽ�(42)</a></li>
                        </ul>
                        <div class="searchBar floatright">
							<label>
								<select name="select" id="select" style="width:70px;">
									<option>����</option>
									<option>����</option>
								</select>
							</label>
							<label>
							<input type="text" name="textfield" id="textfield">
							</label>
							<label>
							<input type="submit" class="button dark small" name="button" value="�˻�">
							</label>
                        </div>
                        <div class="clear"></div>
                    </div>
                </div>
            </div>
            <!-- End Row -->
            <div class="row">
			    <div class="one last  col">
				   <div class="fluidbox">
				      <div class="box">
                         <div class="article">
                              <a href="/colums/dietColumView.jsp">
                              <img alt="�ս����÷�" class="thumbnail" src="/images/Jaipur-1.jpg">
                              </a>
                              <p class="cate">[��Ȱ����]</p>
                              <a href="/colums/dietColumView.jsp">
                              <h4>�ｺƮ���� ����</h4>
                              <p>���� �α�ɱ׷� "�����ͽ���"�� ������ �ȹ��� ȭ���Դϴ�.
                              ������ ��ġ ���� �Ǹ����� ��տ� �Ŵ޷� ���⿡ ����� �����ս��� �������� 
                              �����ε���. �ȹ��� ���� źź���� ������� ���ŵ� �ü��� ��ҽ��ϴ�.</p>
                              </a>
                              <ul class="meta-wrap">
                                  <li><span class="date"></span>13.08.29</li>
                                  <li><span class="account"></span>3,105</li>
                                  <li><span class="comment"></span>121</li>
                              </ul>
                         </div>
                     </div>
                     <div class="box">
                         <div class="article">
                              <a href="/colums/dietColumView.jsp">
                              <img alt="�ս����÷�" class="thumbnail" src="/images/Jaipur-2.jpg">
                              </a>
                              <p class="cate">[���̾�Ʈ �Ӽ��� ����]</p>
                              <a href="/colums/dietColumView.jsp">
                              <h4>�� �� �ٳ�� ���, �ǰ����� ì�ܶ�!</h4>
                              <p>���źҸ� ��ٷ��� �ܰ��� �����ް�! ������ ���� �������, �ٴٷ� ���� �޷�������
                              ������ ���� ���࿡�� ������ ���� ���� �� �ִٴ� ���!
                              �����ð� ���� �ڼ��� �ɾ� �ְų� ��Ÿ� �������� ���� ����� �������� ��ġ�� ��� �ͱ�￩����!</p>
                              </a>
                              <ul class="meta-wrap">
                                  <li><span class="date"></span>13.08.29</li>
                                  <li><span class="account"></span>3,105</li>
                                  <li><span class="comment"></span>121</li>
                              </ul>
                         </div>
                     </div>
                     <div class="box">
                         <div class="article">
                              <a href="/colums/dietColumView.jsp">
                              <img alt="�ս����÷�" class="thumbnail" src="/images/Jaipur-3.jpg">
                              </a>
                              <p class="cate">[��Ȱ����]</p>
                              <a href="/colums/dietColumView.jsp">
                              <h4>���޴��� ���� ���̽���</h4>
                              <p>�̷��� ������? ������ ���� ���� ���� ���̽��� �����. </p>
                              </a>
                              <ul class="meta-wrap">
                                  <li><span class="date"></span>13.08.29</li>
                                  <li><span class="account"></span>3,105</li>
                                  <li><span class="comment"></span>121</li>
                              </ul>
                         </div>
                     </div>
                     <div class="box">
                         <div class="article">
                              <a href="/colums/dietColumView.jsp">
                              <img alt="�ս����÷�" class="thumbnail" src="/images/Jaipur-4.jpg">
                              </a>
                              <p class="cate">[��Ȱ����]</p>
                              <a href="/colums/dietColumView.jsp">
                              <h4>������ �غ��ϴ� õ������</h4>
                              <p>"������ �� �ؾ���" ��� ���� ���� ���� ��ŭ �ﺹ������ �� ����� ���� ��ġ�� ����.
                              �ΰ����� ������ �����ʰ� ����ö �츮 �ǰ��� ������ õ�������� �˾ƺ���. </p>
                              </a>
                              <ul class="meta-wrap">
                                  <li><span class="date"></span>13.08.29</li>
                                  <li><span class="account"></span>3,105</li>
                                  <li><span class="comment"></span>121</li>
                              </ul>
                         </div>
                     </div>
                     <div class="box">
                         <div class="article">
                              <a href="/colums/dietColumView.jsp">
                              <img alt="�ս����÷�" class="thumbnail" src="/images/Jaipur-5.jpg">
                              </a>
                              <p class="cate">[���̾�Ʈ �԰Ÿ�]</p>
                              <a href="/colums/dietColumView.jsp">
                              <h4>���ִ� ���İ� �Բ��ϴ� ����� �ƴ��Ѱ� �Ҽ�...</h4>
                              <p>���� ���̴��� �Ļ縦 �Ű��� �𸣴� ������� ģ���� �δ� ��ȸ�� ���Ѵ�. 
                              �Բ� ���� ������ ���� ���ɻ翡 ���� �̾߱⸦ ������ "�Ҽ� ���̴� (Social Dining)"�� �ߴ� �͵� �ٷ� �׷� ������. </p>
                              </a>
                              <ul class="meta-wrap">
                                  <li><span class="date"></span>13.08.29</li>
                                  <li><span class="account"></span>3,105</li>
                                  <li><span class="comment"></span>121</li>
                              </ul>
                         </div>
                     </div>
                     <div class="box">
                         <div class="article">
                              <a href="/colums/dietColumView.jsp">
                              <img alt="�ս����÷�" class="thumbnail" src="/images/Jaipur-6.jpg">
                              </a>
                              <p class="cate">[���̾�Ʈ �԰Ÿ�]</p>
                              <a href="/colums/dietColumView.jsp">
                              <h4>�ѿ����� ������ ���ɺ��� <����� ����ƾ></h4>
                              <p>LOW Į�θ�, LOW ������, NO �����, NO �ΰ����ҷ� �ǰ��� ���� �����͵��� ���� ����� ������ ����
                              ��ǰ��� �ǰ��Ӹ� �ƴ϶� ȯ����� �����ϴ� ����� ����ƾ�� ������ ����Ʈ�� ��ܺ���. </p>
                              </a>
                              <ul class="meta-wrap">
                                  <li><span class="date"></span>13.08.29</li>
                                  <li><span class="account"></span>3,105</li>
                                  <li><span class="comment"></span>121</li>
                              </ul>
                         </div>
                     </div>	
                     <div class="box">
                         <div class="article">
                              <a href="/colums/dietColumView.jsp">
                              <img alt="�ս����÷�" class="thumbnail" src="/images/Jaipur-7.jpg">
                              </a>
                              <p class="cate">[��Ȱ����]</p>
                              <a href="/colums/dietColumView.jsp">
                              <h4>����+��Ʈ�Ͻ�=������ �ູ�� ���� ��϶�</h4>
                              <p>"������ �� �ؾ���" ��� ���� ���� ���� ��ŭ �ﺹ������ �� ����� ���� ��ġ�� ����.
                              �ΰ����� ������ �����ʰ� ����ö �츮 �ǰ��� ������ õ�������� �˾ƺ���. </p>
                              </a>
                              <ul class="meta-wrap">
                                  <li><span class="date"></span>13.08.29</li>
                                  <li><span class="account"></span>3,105</li>
                                  <li><span class="comment"></span>121</li>
                              </ul>
                         </div>
                     </div>	
                     <div class="box">
                         <div class="article">
                              <a href="/colums/dietColumView.jsp">
                              <img alt="�ս����÷�" class="thumbnail" src="/images/Jaipur-8.jpg">
                              </a>
                              <p class="cate">[��Ȱ����]</p>
                              <a href="/colums/dietColumView.jsp">
                              <h4>�츮 ���� �츮�� ��ũ�κ��ƽ ��Ģ</h4>
                              <p>Ŀ�ٶ� ȣ�� �ӿ� �����޿� �̾� ���� ��ũ�κ��ƽ ����. �ǰ��� �丮�� �����ǰ���
                              ��Ű�ڴٴ� ������ �־��� ��ŷŬ���� ������ ã�ƺ��Ҵ�.</p>
                              </a>
                              <ul class="meta-wrap">
                                  <li><span class="date"></span>13.08.29</li>
                                  <li><span class="account"></span>3,105</li>
                                  <li><span class="comment"></span>121</li>
                              </ul>
                         </div>
                     </div>											
				   </div>
                   <!-- End Fluidbox -->
                   <div class="readmore">
                       <button id="">Read More...</button>
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
</div>
<script src="/common/js/jquery.masonry.min.js"></script>
</body>
</html>