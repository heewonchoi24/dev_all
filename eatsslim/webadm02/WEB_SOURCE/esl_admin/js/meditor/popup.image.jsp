<%
//include dirname(__FILE__) . "/../../lib/lib.func.php";
%>
<title>이미지 등록하기</title>
<style>

body,td,input {font:9pt 굴림}
</style>
<script language="javascript">
</script>

<form method=post action="indb.jsp?code=<%=request.getParameter("code")%>&idx=<%=request.getParameter("idx")%>" enctype="multipart/form-data">
<input type=hidden name="mode" value="InsertImage">

<table width=100%>
<tr>
	<td style="font:bold 20px 돋움;padding:10 0 0 5; letter-spacing:-1">이미지 등록하기</td>
</tr>
<tr><td height=10></td></tr>
<tr>
	<td>
	<table width=100%><tr><td nowrap>- 이미지 업로드하기</td><td width=100%><hr></td></tr></table>
	</td>
</tr>
<tr>
	<td>

	<table width=100% cellpadding=0 cellspacing=0>
	<tr>
		<td style="padding:0 10 0 10"><input type=file name="attachfile" style="width:100%"></td>
	</tr>
	</table>


	<div style="margin-top:20px; display:none;" id="imgurlSpace">
		<table width=100%><tr><td nowrap style="padding-bottom:10">- 또는, 이미지 주소넣기</td><td width=100%><hr></td></tr></table>

		<table width=100% cellpadding=0 cellspacing=0>
		<tr>
			<td style="padding:0 10 0 10"><input type="input" name="mini_url" value="http://" style="width:100%;"></td>
		</tr>
		<tr>
			<td align="right" style="padding:5 10 0 0">
			<input type="button" value="내 WebFTP 보기" style="width:120px" onclick="webftp()">
			<input type="button" value="내 이미지호스팅 보기" style="width:130px" onclick="imghost()">
			</td>
		</tr>
		</table>
	</div>

	</td>
</tr>
<tr>
	<td>
	<table width=100% style="margin-top:20px;"><tr><td nowrap>- 이미지사이즈</td><td width=100%><hr></td></tr></table>
	</td>
</tr>
<tr><td style="padding-left:14"><font color=555555>원래 사이즈 그대로 보이고 싶다면 입력안해도 됩니다.<!--이미지의 크기를 다르게 보일 경우에만 입력하세요.--></td></tr>
<tr>
	<td style="padding:0 10px">

	<table width=100%>
	<tr>
		<td>가로 픽셀 : <input type=text name=imgWidth size=10></td>
		<td>세로 픽셀 : <input type=text name=imgHeight size=10></td>
	</tr>
	</table>

	</td>
</tr>
<tr><td><hr></td></tr>
<tr>
	<td align=center style="padding:5px">

	<input type=submit value="확인" style="width:100px">
	<input type=button value="취소" style="width:100px" onclick="window.close()">

	</td>
</tr>
</table>

</form>


<script language="javascript">
if (opener.document.location.href.toString().match(/\/admin\//)){
	document.getElementById('imgurlSpace').style.display = 'block';
}
</script>
