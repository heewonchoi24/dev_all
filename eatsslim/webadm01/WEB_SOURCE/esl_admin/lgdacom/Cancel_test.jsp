<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<html>
<head>
    <title>LG유플러스 전자결제 결제취소 샘플 페이지</title>
</head>
<body>
    <form method="post" id="LGD_PAYINFO" action="Cancel.jsp">
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
                <td>
                <input type="submit" value="결제 취소"/><br/>
                </td>
            </tr>
        </table>
    </div>
    </form>

</body>
</html>
