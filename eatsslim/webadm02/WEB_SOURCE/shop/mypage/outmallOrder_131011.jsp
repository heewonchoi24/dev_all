<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>

</head>
<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div> <!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1>
				Ÿ���θ� �ֹ�Ȯ��
			</h1>
			<div class="pageDepth">
				HOME > <strong>Ÿ���θ� �ֹ�Ȯ��</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="sixteen columns offset-by-one">
			<div class="row">
				<div class="one last col">
					<div class="graytitbox orderSearch center">
							<p class="marb10">�ٸ� ���θ����� �����Ͻ� ��������� �ñ��Ͻø� �̰����� ��ȸ�Ͻ� �� �ֽ��ϴ�.</p>
                            <label>
								<select name="select" id="select" style="width:130px;">
									<option>�ֹ���ȣ</option>
									<option>�ڵ�����ȣ</option>
								</select>
							</label>
							<label>
							<input type="text" name="textfield" id="textfield">
							</label>
							<label>
							<input type="submit" class="button dark small" name="button" value="��ȸ">
							</label>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="one last col">
						<table class="orderList" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<th>�ֹ�����/�ֹ���ȣ</th>
								<th class="none">��۱���</th>
								<th>��ǰ��</th>
								<th class="none">����</th>
								<th>����ݾ�</th>
								<th>�����ݾ�</th>
								<th>�ֹ�����</th>
								<th class="last">�ֹ���ȸ</th>
							</tr>
							<tr>
								<td>2013.08.01<a class="orderNum" href="/shop/mypage/orderInfo.jsp">A2013080138441</a></td>
								<td><div class="shipping font-blue">
										�Ϲ�
									</div></td>
								<td><div class="orderName">
										<a href="#">���̾�Ʈ�Ļ� 3��
										<p class="option">
											(����A+����B)
										</p>
										</a>
									</div></td>
								<td><div>
										1
									</div></td>
								<td><div>
										104,400��
									</div></td>
								<td><div>
										104,400��
									</div></td>
								<td><div class="font-maple">
										�����Ϸ�
									</div></td>
								<td><div class="button light small">
										<a class="lightbox" href="/shop/popup/deliveryinfo.jsp?lightbox[width]=800&lightbox[height]=550">�����ȸ</a>
									</div>
									<div class="button light small">
										<a class="lightbox" href="/shop/popup/foodschedule.jsp?lightbox[width]=850&lightbox[height]=550">�Ĵ�Ȯ��</a>
									</div></td>
							</tr>
							<tr>
								<td>2013.08.01<a class="orderNum" href="/shop/mypage/orderInfo.jsp">A2013080138441</a></td>
								<td><div class="shipping font-blue">
										�Ϲ�
									</div>								</td>
								<td><div class="orderName">
										<a href="#">�뷱������ũ(BOX)</a>
									</div></td>
								<td><div>
										1
									</div></td>
								<td><div>
										84,400��
									</div></td>
								<td><div>
										84,400��
									</div></td>
								<td><div class="font-maple">
										��ǰ�غ���
									</div></td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td colspan="8">�ֹ���ȣ �Ǵ� �ڵ�����ȣ�� �Է��Ͻø� �ֹ��Ͻ� ������ Ȯ���Ͻ� �� �ֽ��ϴ�.</td>
							</tr>
						</table>
					<!-- End orderList -->
				</div>
			</div>
			<!-- End row -->
			<div class="row">
				<div class="one last  col">
					<div class="pageNavi">
						<a class="latelypostslink" href="#"><<</a> <a class="previouspostslink" href="#"><</a>
						<span class="current">
						1
						</span>
						<a href="#">2</a> <a href="#">3</a> <a href="#">4</a> <a href="#">5</a> <a class="firstpostslink" href="#">></a> <a class="nextpostslink" href="#">>></a>
					</div>
				</div>
			</div>
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