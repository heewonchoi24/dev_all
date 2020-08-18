<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<html>
<head>
    <title>LG유플러스 전자결제 결제 부분취소 샘플 페이지</title>
</head>
<body>
    <form method="post" id="LGD_PAYINFO" action="PartialCancel.jsp">
    <div>
        <table>	
            <tr>
                <td>상점아이디(t를 제외한 아이디) </td>
                <td><input type="text" name="CST_MID" value="pmoamio"/></td>
            </tr>
            <tr>
                <td>서비스,테스트 </td>
                <td><input type="text" name="CST_PLATFORM" value="test"/></td>
            </tr>
            <tr>
                <td>LG유플러스 거래번호 </td>
                <td><input type="text" name="LGD_TID" value=""/></td>
            </tr>
            <tr>
                <td>부분취소 금액 </td>
                <td><input type="text" name="LGD_CANCELAMOUNT" value=""/></td>
            </tr>
            <tr>
                <td>취소전 남은 금액(신용카드만 선택) </td>
                <td><input type="text" name="LGD_REMAINAMOUNT" value=""/></td>
            </tr>
            <tr>
                <td>면세부분취소 금액 (과세/면세 혼용상점만 적용)</td>
                <td><input type="text" name="LGD_CANCELTAXFREEAMOUNT" value=""/></td>
            </tr>
            <tr>
                <td>취소사유 </td>
                <td><input type="text" name="LGD_CANCELREASON" value=""/></td>
            </tr>			
			<tr>
                <td>환불계좌 은행코드 (가상계좌만 필수)</td>
                <td><input type="text" name="LGD_RFBANKCODE" value=""/></td>
            </tr>
		    <tr>
                <td>환불계좌 번호 (가상계좌만 필수)</td>
                <td><input type="text" name="LGD_RFACCOUNTNUM" value=""/></td>
            </tr>
            <tr>
                <td>환불계좌 예금주 (가상계좌만 필수)</td>
                <td><input type="text" name="LGD_RFCUSTOMERNAME" value="홍길동"/></td>
            </tr>
            <tr>
                <td>요청자 연락처 (가상계좌만 필수)</td>
                <td><input type="text" name="LGD_RFPHONE" value="01022223333"/></td>
            </tr>
	            
            <tr>
                <td>
                <input type="submit" value="부분 취소"/><br/>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
