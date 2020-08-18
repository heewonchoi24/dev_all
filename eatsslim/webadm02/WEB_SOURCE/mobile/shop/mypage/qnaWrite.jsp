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
        <h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">1:1 문의신청</span></span></h1>
        <div class="divider"></div>
        <div class="row">
        <h2>문의구분선택</h2>
            <ul class="form-line">
            <li>
            <input type="radio" id="c1" name="cc" />
            <label for="c1"><span></span>구매관련문의</label>
              <div class="select-box">
                <select>
                  <option value="1">항목을 선택하세요.</option>
                  <option value="2">Second item</option>
                </select>
              </div>
              <div class="clear"></div>
            </li>
            <li>
            <input type="radio" id="c2" name="cc" />
            <label for="c1"><span></span>일반상담문의</label>
              <div class="select-box">
                <select>
                  <option value="1">항목을 선택하세요.</option>
                  <option value="2">Second item</option>
                </select>
              </div>
              <div class="clear"></div>
            </li>
            <li>
            <input type="radio" id="c3" name="cc" />
            <label for="c1"><span></span>기타문의</label>
              <div class="select-box">
                <select>
                  <option value="1">항목을 선택하세요.</option>
                  <option value="2">Second item</option>
                </select>
              </div>
              <div class="clear"></div>
            </li>
            </ul>
            <div class="divider"></div>
           <h2>문의내용</h2> 
              <ul class="form-line">
                  <li><label>이메일</label><input name="" type="email"></li>
                  <li><label>제목</label><input name="" type="text"></li>
                  <li>
                      <label style="display:block">내용</label>
                      <textarea name="textarea" rows="5" id="textarea"></textarea>
                  </li>
              </ul>
        </div>
         <div class="grid-navi">
            <table class="navi" border="0" cellspacing="10" cellpadding="0">
               <tr>
                 <td><a href="#" class="ui-btn ui-btn-inline ui-btn-up-d"><span class="ui-btn-inner"><span class="ui-btn-text">문의하기</span></span></a></td>
                 <td><a href="#" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">취소</span></span></a></td>
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