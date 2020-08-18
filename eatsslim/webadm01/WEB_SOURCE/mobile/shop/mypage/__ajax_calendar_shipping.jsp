<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%
String orderNum     = ut.inject(request.getParameter("ordno"));
String goodsId      = ut.inject(request.getParameter("goodsId"));
String groupCode    = ut.inject(request.getParameter("groupCode"));
String devlDate     = "";
String tagZipcode   = "";
String tagAddr1     = "";
String tagAddr2     = "";

String query        = "";
%>
<link rel="stylesheet" type="text/css" media="all" href="/mobile/common/css/expansion.css">
<div id="changeDateCal">
    <div class="inner">
        <header class="pop_header">
            <button class="pop_close close2">닫기</button>
            <h1>배송지 확인</h1>
        </header>
        <div class="pop_content">
            <div class="orderBox">
                <div class="boxTable shippingHistory">
                    <table>
                        <thead>
                            <tr>
                                <th>배송일자</th>
                                <th>배송주소</th>
                            </tr>
                        </thead>
                        <tbody>
<%
query        = "SELECT ";
query       += "    DEVL_DATE, ";
query       += "    ORDER_CNT, GROUP_CODE, STATE, ";
query       += "    RCV_ZIPCODE, RCV_ADDR1, RCV_ADDR2 ";
query       += " FROM ESL_ORDER_DEVL_DATE A";
query       += " WHERE ORDER_NUM = '"+ orderNum +"' AND GOODS_ID = "+ goodsId;
query       += " AND STATE in ('01', '02')";
query       += " AND GROUP_CODE <> '0300668'"; //-- 배송가방은 노출하지 않는다.
query       += " ORDER BY DEVL_DATE ASC";
try {
    rs  = stmt.executeQuery(query);
} catch(Exception e) {
    out.println(e+"=>"+query);
    if(true)return;
}

while (rs.next()) {
    devlDate    = rs.getString("DEVL_DATE");
    tagZipcode      = rs.getString("RCV_ZIPCODE");
    tagAddr1        = rs.getString("RCV_ADDR1");
    tagAddr2        = rs.getString("RCV_ADDR2");
%>
                            <tr>
                                <th><%=devlDate%></th>
                                <td>(<%=tagZipcode%>) <%=tagAddr1%> <%=tagAddr2%></td>
                            </tr>
<%
}
rs.close();
%>
                            <!-- <tr>
                                <th>2017.06.21</th>
                                <td>(08020) 서울특별시 양천구 오목로 180 평화빌딩 4층</td>
                            </tr> -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    moveText($('.moveText'));

    $('.pop_close.close2').off('click').on('click',function(){
        var $this = $(".content.on");
        var $siblings = $this.siblings(".content");

        $this.removeClass("on");
        $siblings.addClass("on");

        TweenMax.to($siblings,0.5,{'top' : '0vh', ease: Power3.easeInOut});
        TweenMax.to($this,0.5,{'top' : 150+'vh', ease: Power3.easeInOut});
    });


</script>