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
		    <h2>�ְ����� ���̾�Ʈ �ϱ�</h2>
			<p></p>
		</div>
	    <div class="contentpop">
		    <div class="columns offset-by-one"> 
				<div class="row">
				   <div class="one last col center">
                      <div class="archive-title">
                         <h3>���̾ �����Դϴ�.</h3>
                         <div class="archive-pagenavi">
                           <a class="prev" href="#">&lt;&lt;</a>
                           <a class="next" href="#">&gt;&gt;</a>
                         </div>
                      </div>
                      <div class="dayfood">
                         <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td width="105" align="center" bgcolor="#58B7DD" style="color:#FFF;">������<br>�ս�����ǰ</td>
                            <td bgcolor="#F4F4F4">
                                <ul class="dailylist">
                                  <li>
                                     <img src="/images/promotion/pr1120/thumb.jpg" width="95" height="74">
                                     <p>��ũ������</p>
                                  </li>
                                  <li>
                                     <img src="/images/promotion/pr1120/thumb.jpg" width="95" height="74">
                                     <p>��ũ������</p>
                                  </li>
                                  <li>
                                     <img src="/images/promotion/pr1120/thumb.jpg" width="95" height="74">
                                     <p>��ũ������</p>
                                  </li>
                                  <li>
                                     <img src="/images/promotion/pr1120/thumb.jpg" width="95" height="74">
                                     <p>��ũ������</p>
                                  </li>
                                  <div class="clear"></div>
                                </ul>
                            </td>
                          </tr>
                        </table>

                      </div>
                      <div class="archive-view">
                        <p>���̾�Ʈ �ϱ��Դϴ�.���̾�Ʈ �ϱ��Դϴ�.���̾�Ʈ �ϱ��Դϴ�.���̾�Ʈ �ϱ��Դϴ�.���̾�Ʈ �ϱ��Դϴ�.���̾�Ʈ �ϱ��Դϴ�.���̾�Ʈ �ϱ��Դϴ�.���̾�Ʈ �ϱ��Դϴ�.���̾�Ʈ �ϱ��Դϴ�.</p>
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