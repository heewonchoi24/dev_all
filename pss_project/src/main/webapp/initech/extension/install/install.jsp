<%@ page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="Cache-control" content="no-cache">
	<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1, maximum-scale=2, user-scalable=yes" />
	<link rel="stylesheet" type="text/css" href="/css/common.css" media="all" />
	<link rel="stylesheet" type="text/css" href="/css/content.css" media="all" />
    <script src="/js/jquery-1.12.4.min.js" type="text/javascript"></script>
    <script src="/js/common.js" type="text/javascript"></script>
    <title>보건복지 개인정보보호 지원시스템</title>

	<script type="text/javascript" src="/initech/extension/common/js/jquery.js"></script>
	<script type="text/javascript" src="../crosswebex6.js"></script>
	<script type="text/javascript">
			
		window.onload = function(){

			// 모듈 설치 체크 대기
			cwModuleInstallWaitWithNoPopup(function(){
				CROSSWEBEX_INSTALL.cwInstallCheck("installCheckCallback");
			});
		};
		
		function installCheckCallback(result){
			if(result){
				alert(CROSSWEBEX_UTIL.loadStringTable().WARN.C_W_030); // "설치가 완료 되었습니다.\n이전 페이지로 돌아갑니다."
				window.opener.location.reload(false);
				window.close();
			}
		}
	</script>
</head>

<body>
<div class="file_layer">
    <div class="layer_top">
        <strong>프로그램 설치</strong>
    </div>
    <div class="layer_content">
        <div class="inisafe">
            <strong class="title">INISAFE CrossWeb EX 보안 프로그램 설치</strong>
            <ul class="list01 mt20">
                <li>공인인증서 등록 시 필요한 설치 프로그램입니다.</li>
                <li>사용하시는 브라우저에 맞게 설치해주세요.
                    <ul class="list02">
                        <li><strong class="c_blue">모든 브라우져</strong> : 필수 설치 프로그램</li>
                        <li><strong class="c_blue" >크롬/파이어폭스</strong> : 확장기능 다운로드, Client Down</li>                        
                    </ul>
                </li>                
            </ul>
            
            <div class="box2 tc mt10">
            	<a href="#" class="button bt1 gray" onclick="CROSSWEBEX_INSTALL.download('crosswebex', 'client')" value="Client Download" >필수 설치 프로그램</a>
                <a href="#" class="button bt1 gray" onclick="CROSSWEBEX_INSTALL.download('crosswebex', 'extension')" value="Extension Install"	id="textbtn3">확장기능 다운로드</a>
            </div>
            <div class="mt10">※ 고객센터 : 1644-5040</div>
        </div>
    </div>
</div>
</body>
</html>