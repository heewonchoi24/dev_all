<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
    <!-- Calendar -->
    <script type="text/javascript" src="/mobile/common/js/date.js"></script>
    <script type="text/javascript" src="/mobile/common/js/jquery.datePicker.js"></script>
	<script type="text/javascript">  
    $(function()
    {
        $('.date-pick')
            .datePicker({createButton:false})
            .bind('click',
                function()
                {
                    $(this).dpDisplay();
                    this.blur();
                    return false;
                }
            );
        // tl is the default so don't bother setting it's position
        $('#custom-offset').dpSetOffset(10, 300);
    });
    </script>
</head>
<body>
<div id="wrap">
    <div class="ui-header-fixed" style="overflow:hidden;">
        <%@ include file="/mobile/common/include/inc-header.jsp"%>
        <ul class="subnavi">
            <li><a href="/mobile/shop/dietMeal.jsp">���̾�Ʈ�Ļ�</a></li>
            <li class="current"><a href="/mobile/shop/reductionProgram.jsp">���̾�Ʈ ���α׷�</a></li>
            <li><a href="/mobile/shop/secretSoup.jsp">��ɽ� ���̾�Ʈ</a></li>
        </ul>
    </div>
    <!-- End ui-header -->
    
    <!-- Start Content -->
    <div id="content" style="margin-top:135px;">
           <h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">���̾�Ʈ ���α׷� ��ǰ����</span></span></h1>
           <div class="row bg-gray">
               <ul class="itembox">
				   <li>
				   <h3>��۰������� Ȯ��</h3>
                   <p>��۰��� �������� Ȯ���� �ּ���.</p>
				   <a href="/mobile/shop/popup/deliverypossi.jsp?lightbox[iframe]=true&lightbox[width]=300&lightbox[height]=400" class="ui-btn ui-mini ui-btn-inline ui-btn-up-c lightbox"><span class="ui-btn-inner"><span class="ui-btn-text">�˻�</span></span></a>
				   </li>
				   <li>
				   <h3>���α׷� ���� ����</h3>
				   		<ul class="form-line">
                            <li>
                              <div class="select-box">
                                <select>
                                  <option value="1">���� ���α׷�</option>
                                  <option value="2">���� ���α׷�</option>
                                  <option value="3">Full-Step ���α׷�</option>
                                </select>
                              </div>
                              <div class="clear"></div>
                            </li>
                        </ul>
				   </li>
				   <li>
				   <h3>�Ļ� �Ⱓ�� ����</h3>
				       <ul class="form-line ui-inline2">
                            <li style="margin-right:10px;">
                             <div class="select-box">
                                <select>
                                  <option value="1">�� 5��</option>
                                </select>
                              </div>
                             </li>
                             <li>
                             <div class="select-box">
                                <select>
                                  <option value="1">2�ְ�</option>
                                </select>
                              </div>
                             </li>
                             <div class="clear"></div>
                        </ul>
					</li>
					<li>
					 <h3>ù ����� ����</h3>
					 <div>
					 <input name="date1" id="date1" class="date-pick" />
					 </div>	
					<div class="clear"></div>	
					</li>
                    <li>
					<h3>��������</h3>
					<div class="quantity" style="width:100%;">
						<input class="minus" type="button" value="-">
						<input class="input-text qty text" maxlength="12" title="Qty" size="4" value="1" data-max="0" data-min="1" name="quantity">
						<input class="plus" type="button" value="+">
					</div>
					<div class="clear"></div>
					</li>
                    <li>
					 <input type="checkbox" id="c1" name="cc" />
                     <label for="c1"><span></span><strong class="f16">���ð��� ����</strong></label>
                     <p class="font-green">���ð����� �ʼ��� �����ϼž� ��ǰ�� �ż��ϰ� ��۹����� �� �ֽ��ϴ�.</p>
					</li>
				 </ul>
           </div>
            <dl class="itemlist redline">
                <dt class="f16">�� ���Ű���</dt>
                    <dd class="f16 font-orange">
                    <del class="f12 font-brown">119,400��</del> 109,400��</dd>
            </dl>
           <div class="grid-navi">
            <table class="navi" border="0" cellspacing="10" cellpadding="0">
               <tr>
                 <td><a href="/mobile/shop/cart.jsp" class="ui-btn ui-btn-inline ui-btn-up-d"><span class="ui-btn-inner"><span class="ui-btn-text">��ٱ���</span></span></a></td>
                 <td><a href="/mobile/shop/order.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">�ٷα���</span></span></a></td>
               </tr>
            </table>
           </div>
           <ul class="ui-listview">
                <li class="ui-li ui-li-static ui-btn-up-e ui-btn-icon-right ui-li-has-arrow ui-first-child">
                <a href="#" class="font-green">��ǰ������</a><span class="ui-icon ui-icon-arrow-r"> </span>
                </li>
                <li class="ui-li ui-li-static ui-btn-up-e ui-btn-icon-right ui-li-has-arrow"><a href="#" class="font-green">��۾ȳ�</a><span class="ui-icon ui-icon-arrow-r"> </span></li>
                <li class="ui-li ui-li-static ui-btn-up-e ui-btn-icon-right ui-li-has-arrow ui-last-child"><a href="#" class="font-green">��ǰ����</a><span class="ui-icon ui-icon-arrow-r"> </span></li>
          </ul>
    </div>
    <!-- End Content -->
    <div class="ui-footer">
       <%@ include file="/mobile/common/include/inc-footer.jsp"%>
    </div>
</div>
</body>
</html>