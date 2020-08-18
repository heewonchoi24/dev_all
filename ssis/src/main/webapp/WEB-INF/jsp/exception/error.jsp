<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1, maximum-scale=2, user-scalable=yes" />
    <script src="/js/jquery-1.12.4.min.js" type="text/javascript"></script>
    <title>보건복지 개인정보보호 지원시스템 &#124; 오류</title>
</head>
<body>
<style>
@charset "utf-8";

/*
* Noto Sans KR (korean) http://www.google.com/fonts/earlyaccess
*/

/* Font Style */
@font-face {
  font-family: 'Noto Sans';
  font-style: normal;
  font-weight: 300;
  src: url('../font/NotoSansKR-Light.woff2') format('woff2'),
       url('../font/NotoSansKR-Light.woff') format('woff'),
       url('../font/NotoSansKR-Light.otf') format('opentype');
}

@font-face {
  font-family: 'Noto Sans';
  font-style: normal;
  font-weight: 400;
  src: url('../font/NotoSansKR-Regular.woff2') format('woff2'),
       url('../font/NotoSansKR-Regular.woff') format('woff'),
       url('../font/NotoSansKR-Regular.otf') format('opentype');
}

@font-face {
   font-family: 'Noto Sans';
   font-style: normal;
   font-weight: 500;
   src: url('../font/NotoSansKR-Medium.woff2') format('woff2'),
        url('../font/NotoSansKR-Medium.woff') format('woff'),
        url('../font/NotoSansKR-Medium.otf') format('opentype'); 
}

@font-face {
   font-family: 'Noto Sans';
   font-style: normal;
   font-weight: 700;
   src: url('../font/NotoSansKR-Bold.woff2') format('woff2'),
        url('../font/NotoSansKR-Bold.woff') format('woff'),
        url('../font/NotoSansKR-Bold.otf') format('opentype'); 
}


/* reset */
/**{-webkit-text-size-adjust:none}*/

html { margin: 0; padding: 0; /*-webkit-text-size-adjust: none;*/ }
body { position: relative; background: #fafafa; /*-webkit-user-select: none; -webkit-touch-callout: none; -webkit-tap-highlight-color: rgba(0,0,0,0); word-break:keep-all; word-wrap:break-word;*/ }
html, body, div, dl, dt, dd, ul, ol, li, h1, h2, h3, h4, h5, h6, form, fieldset, legend, input, textarea, radio, select, p, button { margin: 0; padding: 0; font-family: 'Noto Sans','dotum','AppleGothic'; font-weight: 400; font-size: 14px; line-height: 1.2; color: #555; }
h1, h2, h3, h4, h5, h6 { font-weight: normal; font-size: 100%; }
ul, ol, li { list-style: none; }
fieldset, img { border: 0; vertical-align: middle; }
address, em { font-style: normal; }
table { width: 100%; border-collapse: collapse; border-spacing: 0; }
button { border: 0; background: none; cursor: pointer; }
hr { display: none; }
a { color: #555; text-decoration: none; }
a:hover, a:focus { color: #0074bd; text-decoration: underline; }
caption,legend { overflow: hidden; width: 0; height: 0; font-size: 0; line-height: 0; }
input {/*font-family:'Noto Sans KR','dotum','AppleGothic'; */ font-size: 100%; }
button, label, input[type=image] { cursor: pointer; vertical-align: middle; }
select, textarea { border: 1px solid #ccc; }
select { font-size:100%; background-color:#fff; border-radius: 0; height: 34px; padding: 2px; vertical-align: middle; border: 1px solid #ccc; font-size: 14px; color: #555;}
input[type="text"], input[type="password"], input[type="search"] { /*-webkit-appearance: none;*/ border: 1px solid #ccc; padding: 0 2px; height: 32px; vertical-align: middle; color: #555; }
input[type="checkbox"] { vertical-align: middle; margin-right: 3px; }
/*input:checked[type="checkbox"] { -webkit-appearance: checkbox; }*/
input[type="radio"] { vertical-align: middle; background: #fff; border: none;  }
input[readonly=readonly] { background: #ececec; }
button,input[type="button"],input[type="submit"],input[type="reset"],input[type="file"] { border-radius: 0; cursor: pointer; border: 0; }
textarea { /*-webkit-appearance: none;*/ padding: 0 2px; margin-bottom: -5px; }
img { max-width: 100%; }
article, aside, canvas, details, figcaption, figure, footer, header, hgroup, menu, nav, section, summary { display: block; }

.button { display: inline-block; vertical-align: middle; box-sizing: border-box; text-align: center; }
a.button { text-decoration: none; }
.bt1 { height: 40px; line-height: 40px; background: #037bc1; font-size: 17px; font-weight: 400; color: #fff!important; padding: 0 20px; min-width: 120px; }

/* error */
.error_wrap { text-align: center; background: url('../images/content/error_img.png') no-repeat center top; overflow: hidden; margin-top: 100px; } 
.error_wrap .e_title { font-size: 28px; font-weight: 500; color: #000; margin-top: 230px; }
.error_wrap .e_text { line-height: 28px; font-size: 17px; margin-top: 30px; }

.mt50 { margin-top: 50px!important; }
</style>

<div class="error_wrap">
    <p class="e_title">이용에 불편을 드려서 죄송합니다.</p>
    <p class="e_text">
        페이지의 주소가 잘못 입력되었거나, 페이지의 주소가 변경 혹은 삭제되어<br>
        요청하신 페이지를 찾을 수 없습니다.<br>
        입력하신 주소가 정확한지 다시한번 확인해 주시기 바랍니다.
    </p>
    <div class="mt50">
        <a href="/login/login.do" class="button bt1">로그인 페이지</a>
    </div>
</div>
</body>
</html>