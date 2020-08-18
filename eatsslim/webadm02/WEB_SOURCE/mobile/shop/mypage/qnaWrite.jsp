<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
</head>
<body>
<div id="wrap">
    <div class="ui-header-fixed ui-shadow" style="overflow:hidden;">
       <%@ include file="/mobile/common/include/inc-header.jsp"%>
    </div>
    <!-- End ui-header -->
    <!-- Start Content -->
    <div id="content">
        <h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">1:1 ���ǽ�û</span></span></h1>
        <div class="divider"></div>
        <div class="row">
        <h2>���Ǳ��м���</h2>
            <ul class="form-line">
            <li>
            <input type="radio" id="c1" name="cc" />
            <label for="c1"><span></span>���Ű��ù���</label>
              <div class="select-box">
                <select>
                  <option value="1">�׸��� �����ϼ���.</option>
                  <option value="2">Second item</option>
                </select>
              </div>
              <div class="clear"></div>
            </li>
            <li>
            <input type="radio" id="c2" name="cc" />
            <label for="c1"><span></span>�Ϲݻ�㹮��</label>
              <div class="select-box">
                <select>
                  <option value="1">�׸��� �����ϼ���.</option>
                  <option value="2">Second item</option>
                </select>
              </div>
              <div class="clear"></div>
            </li>
            <li>
            <input type="radio" id="c3" name="cc" />
            <label for="c1"><span></span>��Ÿ����</label>
              <div class="select-box">
                <select>
                  <option value="1">�׸��� �����ϼ���.</option>
                  <option value="2">Second item</option>
                </select>
              </div>
              <div class="clear"></div>
            </li>
            </ul>
            <div class="divider"></div>
           <h2>���ǳ���</h2> 
              <ul class="form-line">
                  <li><label>�̸���</label><input name="" type="email"></li>
                  <li><label>����</label><input name="" type="text"></li>
                  <li>
                      <label style="display:block">����</label>
                      <textarea name="textarea" rows="5" id="textarea"></textarea>
                  </li>
              </ul>
        </div>
         <div class="grid-navi">
            <table class="navi" border="0" cellspacing="10" cellpadding="0">
               <tr>
                 <td><a href="#" class="ui-btn ui-btn-inline ui-btn-up-d"><span class="ui-btn-inner"><span class="ui-btn-text">�����ϱ�</span></span></a></td>
                 <td><a href="#" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">���</span></span></a></td>
               </tr>
            </table>
        </div>
    </div>
    <!-- End Content -->
    <div class="ui-footer">
       <%@ include file="/mobile/common/include/inc-footer.jsp"%>
    </div>
</div>
</body>
</html>