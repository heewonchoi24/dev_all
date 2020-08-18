<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<link rel="stylesheet" type="text/css" media="all" href="/mobile/common/css/orderGuide.css">
</head>
<body>
<div id="wrap">
  <div class="ui-header-fixed ui-shadow" style="overflow:hidden;">
    <%@ include file="/mobile/common/include/inc-header.jsp"%>
  </div>
  <!-- End ui-header -->
  <!-- Start Content -->
  <div id="content" class="oldClass">
    <h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">�ս��� ���̵�</span></span></h1>
    <div class="grid-navi eatsstory">
      <table class="navi" cellspacing="10" cellpadding="0">
        <tr>
          <td><a href="/mobile/intro/checkLocation.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">�������<br />
            Ȯ��</span></span></a></td>
          <td><a href="/mobile/intro/findMenu.jsp" class="ui-btn ui-btn-inline ui-btn-up-f"><span class="ui-btn-inner"><span class="ui-btn-text">���ϴ�<br />
            �Ĵ�ã��</span></span><span class="active"></span></a></td>
          <td><a href="/mobile/intro/orderForm.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">�ֹ��ϱ�<br />
            ��������</span></span></a></td>
          <td><a href="/mobile/intro/changeOrder.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">�ֹ�����<br />
            Type1</span></span></a></td>
          <td><a href="/mobile/intro/changeOrderKakao.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">�ֹ�����<br />
            Type2</span></span></a></td>
        </tr>
      </table>
    </div>



<div class="row" id="orderGuide">
	<div><img src="/mobile/images/step02.jpg" alt="�������Ȯ��"></div>
            
			<ul class="accordion">
					<li class="accordion1">
						<a href="#" class="active">�Ļ��߽��� ���̾�Ʈ</a>
						<div class="acc_content">
							<div class="inner">
								<div class="acc_contentTop">
									<p>���ϴ� ��Ÿ���� �ս��� ���̾�Ʈ������ 1�� ���� �ļ�, �Ⱓ ���� �����Ӱ� ������ �� �ִ� ���̾�Ʈ��</p>
									<ul class="col4">
										<li>
											<img src="/mobile/common/images/guide/ico_1_1.png">
											<p>1�� 1��</p>
										</li>
										<li>
											<img src="/mobile/common/images/guide/ico_1_2.png">
											<p>1�� 1��<br/>+�����</p>
										</li>
										<li>
											<img src="/mobile/common/images/guide/ico_1_3.png">
											<p>1�� 2��</p>
										</li>
										<li>
											<img src="/mobile/common/images/guide/ico_1_4.png">
											<p>1�� 3��</p>
										</li>
									</ul>
								</div>
								<ul class="prd_list">
									<li>
										<div class="photo"><img src="/images/order_guide_img_1_1.jpg"><!-- <img src="/mobile/common/images/guide/order_guide_detail_1.jpg"> --> <div class="cal_info"><p>400Kcal ����</p></div></div>
										<div class="info">
											<p class="title">400 ������(��20�� �޴�)</p>
											<p class="dec">����, ��ǰ�丮, ������, ����������� ������ ������ Į�θ� �����Ļ�</p>
											<div class="btns">
												<a href="/mobile/shop/order_list.jsp?menuF=1&menuS=1&eatCoun=">�ڼ�������</a>
												<a href="/mobile/shop/order_view.jsp?cateCode=0300700&cartId=32&groupCode=0300717&pramType=list">�ٷα���</a>
											</div>
										</div>
									</li>
									<li>
										<div class="photo"><img src="/images/order_guide_img_1_2.jpg"><!-- <img src="/mobile/common/images/guide/order_guide_detail_1.jpg"> --> <div class="cal_info"><p>300Kcal ����</p></div></div>
										<div class="info">
											<p class="title">300 ������(�� 10�� �޴�)</p>
											<p class="dec">�ż��� ä�ҿ� ���� ������ ������ ��鿩 �������� ���� �� �ִ� �丮�� ������</p>
											<div class="btns">
												<a href="/mobile/shop/order_list.jsp?menuF=1&menuS=2&eatCoun=">�ڼ�������</a>
												<a href="/mobile/shop/order_view.jsp?cateCode=0300702&cartId=34&groupCode=0300719&pramType=list">�ٷα���</a>
											</div>
										</div>
									</li>
									<li>
										<div class="photo"><img src="/images/order_guide_img_1_3.jpg"><!-- <img src="/mobile/common/images/guide/order_guide_detail_1.jpg"> --> <div class="cal_info"><p>300Kcal ����</p></div></div>
										<div class="info">
											<p class="title">300 ����(�� 10�� �޴�)</p>
											<p class="dec">���� ���缳�迡 ���߾� �丮�� One-dish meal ���� �丮 ��ǰ</p>
											<div class="btns">
												<a href="/mobile/shop/order_list.jsp?menuF=1&menuS=3&eatCoun=">�ڼ�������</a>
												<a href="/mobile/shop/order_view.jsp?cateCode=0300965&cartId=43&groupCode=0300957&pramType=list">�ٷα���</a>
											</div>
										</div>
									</li>
									<li>
										<div class="photo"><img src="/images/order_guide_img_1_4.jpg"><!-- <img src="/mobile/common/images/guide/order_guide_detail_1.jpg"> --> <div class="cal_info"><p>200Kcal ����</p></div></div>
										<div class="info">
											<p class="title">�̴Ϲ�(�� 6�� �޴�)</p>
											<p class="dec">���̼����� ǳ���� �ǰ������ ����Ǫ��� Į�θ��� ���߰� ������ ���� ������ ���� �Ź�</p>
											<div class="btns">
												<a href="/mobile/shop/order_list.jsp?menuF=1&menuS=4&eatCoun=">�ڼ�������</a>
												<a href="/mobile/shop/order_view.jsp?cateCode=0&cartId=52&groupCode=0300993&pramType=list">�ٷα���</a>
											</div>
										</div>
									</li>
								</ul>
								<!-- <div class="bx">
									<div class="bx_top">
										<div class="title">���̾�Ʈ �Ļ縦 <span>����</span>�ϼ̳���?</div>
										<p>���̾�Ʈ�� ������ �Ǵ� ������� <span>���� �ֹ��Ͻø� ���� ���� ȿ��</span>�� ���� �� �ֽ��ϴ�.</p>
									</div>
									<ul class="prd_list style2">
										<li>
											<div class="photo"><img src="/mobile/common/images/guide/temp_prd_1_4.jpg"></div>
											<div class="info">
												<p class="dec">Į�θ� �������� ������� ��������� �Ѽտ� ��~�����ϰ� ���� <span>�ս��� �̴Ϲ�!</span></p>
												<div class="btns">
													<a href="#">�ڼ��� ����</a>
													<a href="#">�ٷα���</a>
												</div>
											</div>
										</li>
										<li>
											<div class="photo"><img src="/mobile/common/images/guide/temp_prd_1_5.jpg"></div>
											<div class="info">
												<p class="dec">Į�θ��� ���߰�, ������ ä�� ü�������� ��ǰ, 7���� ��� ���� �������� ����� ���� <span>�뷱�� ����ũ!</span></p>
												<div class="btns">
													<a href="#">�ڼ��� ����</a>
													<a href="#">�ٷα���</a>
												</div>
											</div>
										</li>
									</ul>
								</div> -->
							</div>
						</div>
					</li>
					<li class="accordion2">
						<a href="#">������ ���̾�Ʈ ���α׷�</a>
						<div class="acc_content">
							<div class="inner">
								<div class="acc_contentTop">
									<p>���̾�Ʈ ������ ���� �ս������� �����ϴ� ���̾�Ʈ ���� ���α׷�</p>
									<ul class="col4">
										<li>
											<img src="/mobile/common/images/guide/ico_2_1.png">
											<p>�ܱ�<br/>���α׷�</p>
										</li>
										<li>
											<img src="/mobile/common/images/guide/ico_2_2.png">
											<p>����<br/>���α׷�</p>
										</li>
										<li>
											<img src="/mobile/common/images/guide/ico_2_3.png">
											<p>Ŭ����<br/>���α׷�</p>
										</li>
										<li>
											<img src="/mobile/common/images/guide/ico_2_4.png">
											<p>����Ʈ�׷�</p>
										</li>
									</ul>
								</div>
								<ul class="prd_list">
									<li>
										<div class="photo"><img src="/images/order_guide_img_2_1.jpg"><!-- <img src="/mobile/common/images/guide/order_guide_detail_2.jpg"> --> <div class="cal_info"><p>1000Kcal(1��) ����</p></div></div>
										<div class="info">
											<p class="title">�ܱ� ���α׷�</p>
											<p class="dec">�ܱⰣ�� ������ �������� �ϴ� �е��� ���� 3��, 6�� ������ �ܱ����α׷�</p>
											<div class="btns">
												<a href="/mobile/shop/order_list.jsp?menuF=2&menuS=1">�ڼ�������</a>
												<a href="/mobile/shop/order_view.jsp?cateCode=0&cartId=54&groupCode=0300978&pramType=list">�ٷα���</a>
											</div>
										</div>
									</li>
									<li>
										<div class="photo"><img src="/images/order_guide_img_2_2.jpg"><!-- <img src="/mobile/common/images/guide/order_guide_detail_3.jpg"> --> <div class="cal_info"><p>1200Kcal(1��) ����</p></div></div>
										<div class="info">
											<p class="title">���� ���α׷�</p>
											<p class="dec">������, �Ⱓ���� ����ȭ�� ���� ���踦 �������� �� �ս����� ��ǥ ���� ���α׷�</p>
											<div class="btns">
												<a href="/mobile/shop/order_list.jsp?menuF=2&menuS=2">�ڼ�������</a>
												<a href="/mobile/shop/order_view.jsp?cateCode=0&cartId=88&groupCode=024&pramType=list">�ٷα���</a>
											</div>
										</div>
									</li>
									<li>
										<div class="photo"><img src="/images/order_guide_img_2_3.jpg"><!-- <img src="/mobile/common/images/guide/order_guide_detail_4.jpg"> --> <div class="cal_info"><p>900Kcal(1��) ����</p></div></div>
										<div class="info">
											<p class="title">Ŭ���� ���α׷�</p>
											<p class="dec">�������� Ŭ���� �ֽ��� ���� �ǰ��� ü�� ��� ���� �ս��� �Ĵ����� ���� ������ �����ϴ� ���̾�Ʈ ���α׷�</p>
											<div class="btns">
												<a href="/mobile/shop/order_list.jsp?menuF=2&menuS=3">�ڼ�������</a>
												<a href="/mobile/shop/order_view.jsp?cateCode=0&cartId=82&groupCode=02271&pramType=list">�ٷα���</a>
											</div>
										</div>
									</li>
									<li>
										<div class="photo"><img src="/images/order_guide_img_2_4.jpg"><!-- <img src="/mobile/common/images/guide/order_guide_detail_5.jpg"> --> <div class="cal_info"><p>800Kcal(1��) ����</p></div></div>
										<div class="info">
											<p class="title">����Ʈ�׷�</p>
											<p class="dec">10g���� ��Ȯ�� ����Ʈ ü�߰�� App���� ������ �׷����̱׷��� �ս��� �Ĵ��� �����ϴ� ����Ʈ�� ���α׷�</p>
											<div class="btns">
												<a href="/mobile/shop/order_list.jsp?menuF=2&menuS=4">�ڼ�������</a>
												<a href="/mobile/shop/order_view.jsp?cateCode=0&cartId=85&groupCode=02411&pramType=list">�ٷα���</a>
											</div>
										</div>
									</li>
								</ul>
							</div>
						</div>
					</li>
					<li class="accordion3">
						<a href="#">�� ���� ���� �ǰ���</a>
						<div class="acc_content">
							<div class="inner">
								<div class="acc_contentTop">
									<p>�ǰ� ���� �Ǵ� ü�� ����, ������ ���� �������� ������ ������ �ǰ��� �Ļ� ��ǰ </p>
									<ul class="col2">
										<li>
											<img src="/mobile/common/images/guide/ico_3_1.png">
											<p>1�� 1��</p>
										</li>
										<li>
											<img src="/mobile/common/images/guide/ico_3_2.png">
											<p>1�� 2��</p>
										</li>
									</ul>
								</div>
								<ul class="prd_list">
									<li>
										<div class="photo"><img src="/images/order_guide_img_3_1.jpg"><!-- <img src="/mobile/common/images/guide/order_guide_detail_6.jpg"> --> <div class="cal_info"><p>500Kcal ����</p></div></div>
										<div class="info">
											<p class="title">�ﾾ����(20�� �޴�)</p>
											<p class="dec">�ǰ��� ü�� ������ ���ÿ� �� �� �ִ� �������� �ǰ� ���ö�</p>
											<div class="btns">
												<a href="/mobile/shop/order_list.jsp?menuF=3&menuS=1&eatCoun=">�ڼ�������</a>
												<a href="/mobile/shop/order_view.jsp?cateCode=0301369&cartId=89&groupCode=0301369&pramType=list">�ٷα���</a>
											</div>
										</div>
									</li>
								</ul>
							</div>
						</div>
					</li>
				</ul>



      <div class="divider"></div>
    </div>
  </div>

  <!-- End Content -->
  <div class="ui-footer">
    <%@ include file="/mobile/common/include/inc-footer.jsp"%>
  </div>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		// Store variables
		var accordion_head = $('.accordion > li > a'),
			accordion_body = $('.accordion > li > .acc_content');
		// Open the first tab on load
		accordion_head.first().addClass('active').next().slideDown('normal');
		// Click function
		accordion_head.on('click', function(e) {
			// Disable header links
			e.preventDefault();
			// Show and hide the tabs on click
			var _this = $(this);
			if (_this.attr('class') != 'active'){
				accordion_body.slideUp('normal');
				_this.next().stop(true,true).slideToggle('normal', function() {
					$("html, body").stop().animate({scrollTop:_this.offset().top}, 500, 'swing');
				});
				accordion_head.removeClass('active');
				_this.addClass('active');
			}else{
				accordion_body.slideUp('normal');
				accordion_head.removeClass('active');
			}
		});
	});
</script>

</body>
</html>