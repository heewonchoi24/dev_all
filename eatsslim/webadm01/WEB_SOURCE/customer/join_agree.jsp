<%@ page import="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ include file="/lib/config.jsp"%>

<!doctype html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="Generator" content="EditPlus®">
		<meta name="Author" content="">
		<meta name="Keywords" content="">
		<meta name="Description" content="">
		<title>잇슬림 회원가입 약관동의</title>


		<script src="/common/js/jquery-1.9.1.js"></script>
		<script type="text/javascript" src="/common/js/jquery.mousewheel.js"></script>
		<script type="text/javascript" src="/common/js/jquery.cycle.js"></script>
		<!-- 주문수량 Spinner -->
		<script type="text/javascript" src="/common/js/jquery.ui.widget.js"></script>
		<script type="text/javascript" src="/common/js/jquery.ui.button.js"></script>
		<!-- Lightbox -->
		<script type="text/javascript" src="/common/js/jquery.lightbox.js"></script>
		<script type="text/javascript" src="/common/js/jquery.mCustomScrollbar.js"></script>
		<script type="text/javascript" src="/common/js/slick.js"></script>
		<script type="text/javascript" src="/common/js/Tweenmax.min.js"></script>
		<!-- Bottom Panel -->
		<script type="text/javascript" src="/common/js/jquery.slidedrawer.js"></script>
		<script type="text/javascript" src="/common/js/jquery.selectBox.js"></script>
		<script type="text/javascript" src="/common/js/util.js"></script>



<style type="text/css">
/*@charset "utf-8";*/

/********************************************************************************************************************************************************
	 default Style - 페이지 내 공통으로 적용되는 스타일입니다.
*********************************************************************************************************************************************************/
body *{text-shadow:none;scrollbar-face-color:#eee;scrollbar-arrow-color:#999;scrollbar-track-color:#fff;scrollbar-3dlight-color:#eee;scrollbar-darkshadow-color:#eee;scrollbar-highlight-color:#eee;scrollbar-shadow-color:#eee}
body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,code,form,fieldset,legend,input,textarea,p,blockquote,th,td,address,figure,figcaption{margin:0;padding:0;text-shadow:none}
table{width:100%;border:0;border-collapse:collapse;border-spacing:0;font-size:inherit}
fieldset,img{border:0;vertical-align:middle}
address,caption,cite,code,dfn,em,strong,th,var{font-style:normal}
li{list-style:none}
h1,h2,h3,h4,h5,h6{font-size:100%;font-weight:normal}
input,textarea,select{font-family:inherit;font-size:0.9em;font-weight:inherit;vertical-align:middle}
body{position:relative;width:100%;height:100%;font-family:"Noto Sans KR", sans-serif;font-size:12px;color:#999;background:#fff;line-height:1.3}
hr,caption,legend {display:none}
a {text-decoration:none;font-weight:normal;text-shadow:none}
a, a:active,a:focus, button{background:none}
wrap, header, gnb, visual, container, section, article, aside, nav ,contents, showcase, contact, footer, water {display:block;position:relative}

.clfix:after {content:".";display:block;height:0px;clear:both;visibility:hidden}
.clfix {display:inline-block}
.clfix {display:block}
* html .clfix {height:1%} /* Hides from IE-mac */
.clfix {zoom:1} /*for IE 5.5-7*/
.blind {font-size:0;height:1px !important;overflow:hidden !important;position:absolute !important;top:-9999px !important;width: 1px !important}



/********************************************************************************************************************************************************
	layout Style - 페이지 내 공통으로 적용되는 스타일입니다.
*********************************************************************************************************************************************************/
html {height:100%}
#wrap {font-size:12px;height:100%}
#container {position:absolute;top:0;width:100%;height:100%;z-index:100;background:#fff}
#container_web {width:550px;height:100%;z-index:100;margin:0px auto;background:#fff}
#header {position:relative;margin:10px auto;color:#095e37;height:50px;background:#fff;z-index:10}
#header h1 {height:40px;font-size:22px;text-align:center;padding-top:25px;font-weight:bold;}
#header h1 a {color:#095e37;font-weight:bold;letter-spacing:-1px}
#content {position:relative}
.header_line {border-bottom:2px solid #52884e}

/* footer 영역 */
#footer {background:rgb(255, 255, 255);margin:0;text-align:center;padding-bottom:10px;clear:both;border-top-color:rgb(34, 34, 34);border-top-width:2px;border-top-style:solid;position:relative;z-index:10}
#footer .link {padding:10px 0px 8px;text-align:center;clear:both;font-weight:bold;border-bottom-color:rgb(216, 216, 217);border-bottom-width:1px;border-bottom-style:solid}
#footer .link a {color:rgb(68, 68, 68)}
#footer span {width:60px;text-align:center;color:rgb(194, 194, 194);font-weight:normal;display:inline-block}
#footer address {padding:14px 0px 10px;color:rgb(118, 118, 118);line-height:20px;clear:both}
#footer address p {font-size:12px}
#footer address strong {padding:0px 10px 0px 0px;color:rgb(51, 51, 51);font-weight:normal;display:inline-block}
#footer address a {color:rgb(37, 95, 179)}
#footer address .copyright {margin-top:3px;font-size:12px}
.top {right:20px;bottom:0px;position:fixed}

#skipnavigation {position:absolute;left:0;top:-1000px;width:100%;height:0px;z-index:1000;line-height:0px;font-size:0px}
#skipnavigation a{display:block;text-align:center;width:100%;line-height:0px;font-size:0px}
#skipnavigation a:focus, #skipnavigation a:hover, #skipnavigation a:active {position:absolute;left:0px;top:1000px;padding:8px 0;display:block;height:20px;background:#20262c;font-size:12px;font-weight:bold;line-height:18px;color:#fff}

.loading {position:absolute;left:50%;top:30%;margin-left:-75px;z-index:999}


/********************************************************************************************************************************************************
	common Style - 페이지 내 공통으로 적용되는 스타일입니다.
*********************************************************************************************************************************************************/
/* text */
h2 {display:inline-block;color:#283e29;font-size:18px;line-height:30px;font-family:"Noto Sans KR", sans-serif;font-weight:bold;letter-spacing:-1px;margin-bottom:5px;}
.textH2 {color:#28323e;font-size:16px;font-family:"Noto Sans KR", sans-serif;}

/* gnb */
.gnb {width:100%;height:66px;z-index:10;border-bottom:2px solid #52884e;border-top:2px solid #52884e;margin-bottom:20px}
.gnb p{height:66px;color:#28323e;font-size:14px;font-family:"Noto Sans KR", sans-serif;text-align:center;padding:16px 10px 10px 0px;}
.gnb li{float:left;height:64px;border-bottom:2px solid #52884e;border-top:2px solid #52884e}
.gnb li a {display:block;height:64px;line-height:24px;border-left:1px solid #d0d0d0;background:#fff;color:#585858;font-size:13px;font-family:"Noto Sans KR", sans-serif;text-align:center;font-weight:bold;letter-spacing:-1px}
.gnb li:first-child a {border-left:0}
.gnb li.on a {background:#b0cc5a;color:#fff}
.gnb li span {display:block;margin:0 auto;background:url('../images/ico/ico_gnb.png') no-repeat}
.gnb li span.ico_login {width:33px;height:35px;background-position:-43px 6px}
.gnb li span.ico_memberJoin {width:37px;height:35px;background-position:-40px -36px}
.gnb li span.ico_idSearch {width:33px;height:35px;background-position:-43px -80px}
.gnb li span.ico_pwSearch {width:33px;height:35px;background-position:-43px -127px}
.gnb li span.ico_infoModify {width:50px;height:35px;background-position:-50px -170px}
.gnb li span.ico_siteAgree {width:33px;height:35px;background-position:-43px -215px}
.gnb li span.ico_memberDropout {width:33px;height:35px;background-position:-43px -260px}
.gnb li.on span.ico_login {background:url('../images/ico/ico_gnb.png') no-repeat 0 6px !important}
.gnb li.on span.ico_memberJoin {background:url('../images/ico/ico_gnb.png') no-repeat 0 -36px !important}
.gnb li.on span.ico_idSearch {background:url('../images/ico/ico_gnb.png') no-repeat 0 -80px !important}
.gnb li.on span.ico_pwSearch {background:url('../images/ico/ico_gnb.png') no-repeat 0 -127px !important}
.gnb li.on span.ico_infoModify {background:url('../images/ico/ico_gnb.png') no-repeat 0 -170px !important}
.gnb li.on span.ico_siteAgree {background:url('../images/ico/ico_gnb.png') no-repeat 0 -215px !important}
.gnb li.on span.ico_memberDropout {background:url('../images/ico/ico_gnb.png') no-repeat 0 -260px !important}

.gnbDiv2 li {width:50%}
.gnbDiv3 li {width:33%}
.gnbDiv3 li:first-child {width:34%}
.gnbDiv4 li {width:25%}

/** contentWrap **/
.contentWrap {padding:18px 15px 50px}
.contentWrap .accordion .txt {width:75%;}
.contentWrap .accordion .date {width:20%;}

/** boxBasic **/
.boxBasic {border:2px solid #e0e0e0;background:#fff;margin-bottom:10px}
.boxBasic .guide {position:relative;width:100%}
.boxBasic .tl {display:block;position:absolute;top:-2px;left:-2px;width:12px;height:12px;background:url(../images/common/bg_round_corner.gif) no-repeat;font-size:0;z-index:1}
.boxBasic .tr {display:block;position:absolute;top:-2px;left:-10px;width:12px;height:12px;margin-left:100%;background:url(../images/common/bg_round_corner.gif) 100% 0 no-repeat;font-size:0;z-index:1}
.boxBasic .lb {display:block;position:absolute;top:-10px;left:-2px;width:12px;height:12px;background:url(../images/common/bg_round_corner.gif) 0 100% no-repeat;font-size:0}
.boxBasic .rb {display:block;position:absolute;top:-10px;left:-10px;width:12px;height:12px;margin-left:100%;background:url(../images/common/bg_round_corner.gif) 100% 100% no-repeat;font-size:0}
.boxBasic .cont {position:relative}


/*20160503 추가*/
.boxBasic .btnjoin{position:relative; display: inline-block; width: 95%; font-family:"Noto Sans KR", sans-serif; font-size: 14px; font-weight: bold; letter-spacing: -0.5px;  padding:12px 10px 12px;min-height:24px; background: url(../images/common/arrow.png) no-repeat right;}
.boxBasic .btnjoin a{display: block; font-weight: bold; color:#4c4c4c;}
.boxBasic .btnjoin .green1,.boxBasic .btnjoin .green2{display: inline-block; width: 120px; padding:15px 10px; margin-right:5px; border-radius: 6px; color:#fff; text-align: center;}
.boxBasic .btnjoin .green1{background-color: #b0cc5a; }
.boxBasic .btnjoin .green2{background-color: #52884e; min-height: 80px; }
.boxBasic .btnjoin .green2 img{margin:5px 0px}
.boxBasic .btnjoin .leftBox{float:left; display: inline-block;}
.boxBasic .btnjoin .rightTxt{display: inline-block; vertical-align: middle; min-height: 110px; line-height: 110px;}

/** boxInfo **/
.boxInfo {border:2px solid #e0e0e0;background:#f6f6f6;margin-bottom:10px}
.boxInfo .cont_ce {position:relative;color:#333;text-align:center;font-size:15px;padding:34px 0}
.boxInfo .cont_ce span {color:#884501;font-weight:bold}

/* accordion - list */
.accordion {position:relative}
.accordion .title {position:relative;padding:15px;font-size:15px}
.accordion .title a {color:#333}
.accordion .title a:hover {color:#769c00}
.accordion .title a.view {color:#333}

.accordion .title2 {padding:15px 15px 0;border-top:2px solid #e0e0e0}
.accordion .title2 span {float:right;font-weight:bold}
.accordion .title2 span a {color:#769c00}
.accordion .title2 p {font-weight:normal;font-size:13px;color:#666;margin-bottom:20px}

/* 더보기화살표 .accordion .title a.view {color:#333;width:13px;height:7px;background:url(../images/btn/btn_arrow.gif) no-repeat right 7px;padding-right:20px} */
.accordion .title a:hover.view {color:#769c00}
.accordion .agree_cont {display:none;overflow-y:scroll;height:150px;padding:15px;border-top:2px solid #e0e0e0}
.accordion .agree_cont strong {display:block;font-weight:bold;font-size:13px;color:#666;margin-bottom:5px}
.accordion .agree_cont p {font-weight:normal;font-size:13px;color:#666;margin-bottom:20px}

/* accordion - view */
.accordion_v {position:relative}
.accordion_v .title {position:relative;padding:15px;font-size:15px;color:#333}
.accordion_v .agree_cont {overflow-y:auto;height:140px;padding:15px;border-top:2px solid #e0e0e0}
.accordion_v .agree_cont strong {display:block;font-weight:bold;font-size:13px;color:#666;margin-bottom:5px}
.accordion_v .agree_cont p {font-weight:normal;font-size:13px;color:#666;margin-bottom:20px}

/* formBasic */
.formBasic {width:100%;table-layout:fixed}
.formBasic th {padding:5px 0px 5px 10px;text-align:left;color:#333;font-weight:normal;border-bottom:2px solid #e0e0e0}
.formBasic td {padding:5px 10px 5px 10px;border-bottom:2px solid #e0e0e0;-ms-word-break:break-all}
.formBasic td p {color:#333;font-size:15px;line-height:24px;font-weight:bold}
.formBasic th.none {padding-bottom:0;border-bottom:none}
.formBasic td.none {padding-bottom:0;border-bottom:none}
.formBasic th.nonepb5 {padding-bottom:5px;border-bottom:none}
.formBasic td.nonepb5 {padding-bottom:5px;border-bottom:none}
.formBasic tr:last-child td {border-bottom:0}
.formBasic tr:last-child th {border-bottom:0}

/* formBasic_in */
.formBasic_in {width:100%;table-layout:fixed}
.formBasic_in th {padding:0 0 5px 10px;border-bottom:none;text-align:left;color:#333;font-weight:normal}
.formBasic_in td {padding:0 0 5px;border-bottom:none;-ms-word-break:break-all}
.formBasic_in td p {color:#333;font-size:15px;line-height:24px}
.formBasic_in th.none {padding-bottom:0;border-bottom:none}
.formBasic_in td.none {padding-bottom:0;border-bottom:none}
.formBasic_in th.nonepb5 {padding-bottom:5px;border-bottom:none}
.formBasic_in td.nonepb5 {padding-bottom:5px;border-bottom:none}
.formBasic_in tr:last-child td {border-bottom:0}
.formBasic_in tr:last-child th {border-bottom:0}

/* inputStyle */
.inputStyleWrap {position:relative}
.inputStyle_ce {position:relative;text-align:center;font-size:15px;padding:14px 0 12px;min-height:24px}
.inputStyle_ri {position:relative;float:right}
.inputStyle_ce a, .inputStyle_ri a {overflow:hidden}
.btn_check, .btn_radio {color:#4c4c4c;font-size:15px;letter-spacing:-1px}
.btn_check img {width:27px;height:25px;margin-top:-4px}
.btn_radio img {width:24px;height:24px}
.radioStyleWrap {float:right;margin-top:7px;margin-right:17px}

/** common **/
.plr5 {padding:0 5px !important}
.ptb0 {padding-top:0 !important;padding-bottom:0 !important}
.mb5 {margin-bottom:5px !important}
.mt0 {margin-top:0px !important}
.mt10 {margin-top:10px !important}
.mt20 {margin-top:20px !important}
.ml30 {margin-left:30px !important}
.ww {width:100% !important}

/* tableBasic */
.tbBasic {width:100%;border-top:2px solid #52884e;font-size:13px}
.tbBasic th {height:44px;/*padding:13px 0;*/vertical-align:middle;background:#eef5ec;color:#283e29;text-align:center;font-weight:normal}
.tbBasic td {height:44px;color:#666;font-size:100%;text-align:center}
.tbBasic td.textL {padding:0 15px;text-align:left}
.tbBasic td.styleBg {background:#f8f8f8;color:#283e29}
.tbBasic th, .tbBasic td {border-right:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0}
.tbBasic th.last, .tbBasic td.last {border-right:0}

/* infoBasic */
.infoBasic {margin-bottom:5px}
.infoBasic li {padding:0 0 8px 10px;background:url('../images/common/bullet_01.png') no-repeat 0 4px;background-size:5px 5px;color:#666;font-size:13px;line-height:100%}

.cellFirst {width:100%;display:table}
/*.cellFirst input {width:100%}
.cellFirst select {width:100%}*/
.cellw1 {width:34%;display:table-cell;vertical-align:top}
.cellw2 {width:33%;display:table-cell;vertical-align:top}
.cellw3 {width:50%;display:table-cell;vertical-align:top}
.cellw4 {width:100%;display:table-cell;vertical-align:top}
.cellDesh {padding:0px 2px;line-height:42px;text-align:center;display:table-cell}
.cellBtn1 {width:78px;text-align:right;display:block;padding-left:5px;letter-spacing:-1px}
.cellRadio1 {width:130px;text-align:right;display:block;padding-top:10px}
.cellRadio2 {width:100%;text-align:center;display:block;padding-top:10px;padding-bottom:10px}

.inputInfo {position:relative;display:block;border:1px solid ##b5b5b5}
.inputInfo .inner_g {height:30px;border:2px solid #dadada;padding:5px;margin-bottom:5px;}
.inputInfo_id {position:relative;display:block;border:1px solid #dadada}
.inputInfo_id .inner_g_id {height:36px;border:1px solid #dadada;padding:8px 10px 0px 0px;margin-left:65px}
.inputInfo_pw {position:relative;display:block;border:1px solid #dadada}
.inputInfo_pw .inner_g_pw {height:36px;border:1px solid #dadada;padding:8px 10px 0px 0px;margin-left:65px}
.tf_g {position:relative;display:inline-block;height:27px;border:0;padding:0px;border:0px currentColor;color:#666;font-size:15px;font-weight:bold;z-index:5}



.inputDisable_h {height:auto}
.inputDisable {background:url(../images/common/bg_form.png) no-repeat left 0;padding-left:10px}
.inputDisable span {display:block;height:44px;color:#666;font-size:15px;font-weight:bold;line-height:44px;background:url(../images/common/bg_form.png) no-repeat right -49px}

/* select box */
.selectBox2 {display:block;width:100%;height:44px !important;border:2px solid #dadada;background:#fff;line-height:44px;font-size:15px;font-weight:bold;color:#666;padding-left:6px}
.selectBox {display:block;width:100%;height:44px !important;border:2px solid #dadada;background:#fff;line-height:44px;font-size:15px;font-weight:bold;color:#666;padding-left:6px}
.select {display:inline-block;*display:inline;position:relative;width:100%;background:#fff;line-height:normal;vertical-align:middle;*zoom:1}
.select *{margin:0;padding:0;font-size:15px;font-weight:bold;cursor:pointer}
.select .my_value {overflow:visible;position:relative;top:0;left:0;z-index:2;border:2px solid #dadada;background:transparent;color:#666;text-align:left;line-height:19px;_line-height:normal}
.select .my_value.selected {font-weight:bold}
.select.open .my_value, .select .my_value.outLine {border:2px solid #dadada}
.select button.my_value {width:100%;height:44px;*padding-left:8px;text-indent:8px;*text-indent:0}
.select div.my_value {height:19px;text-indent:3px}
.select .ctrl {position:absolute;top:0;right:0;width:23px;height:40px;border:2px solid #dadada;border-left:2px solid #eaeaea;background:#fff}
.select .arrow {position:absolute;width:0;height:0;top:19px;right:9px;border-top:3px solid #999;border-left:3px solid #fff;border-right:3px solid #fff;font-size:0;line-height:0}
.select ul {overflow:hidden;position:absolute;top:42px;left:0;width:100%;border:0;border-top:2px solid #dadada;border-bottom:2px solid #dadada;background:#fff;list-style:none;z-index:9999}
.select ul.a_list {display:none}
.select.open ul.a_list {display:block}
.select ul.i_list {left:-2000%}
.select.open ul.i_list {left:0}
.select li {overflow:hidden;position:relative;height:26px;border-left:2px solid #dadada;border-right:2px solid #dadada;white-space:nowrap}
.select li input.option {position:absolute;width:100%;height:28px;line-height:28px}
.select li label {position:absolute;top:0;left:0;width:100%;height:26px;background:#fff;color:#666;line-height:26px;text-indent:8px;*text-indent:6px}
.select li a {display:block;height:26px;background:#fff;color:#666;line-height:26px;text-indent:8px;*text-indent:6px;text-decoration:none}
.select li.hover * {background:#999;color:#fff}

.textarea {margin-right:12px}
.textarea .tf_inner {width:100%;height:150px;padding:11px 0 11px 8px;border:2px solid #dadada;color:#666;font-size:15px;font-weight:bold;}
.ipt_check {border: 0px currentColor;width:18px;height:18px}
.ipt_radio {border: 0px currentColor;width:19px;height:19px}

.addressBox {display:block;border:2px solid #dadada;border-radius:5px;background:#fff;margin-top:5px}
.addressBox ul {padding:5px 0 5px 5px}
.addressBox ul li {font-size:12px;margin-bottom:1px;background:none;line-height:17px;color:#4c4c4c}
.addressBox ul li a {color:#4c4c4c;padding;display:block;padding:5px 6px}
.addressBox ul li a:hover {background:#ebebeb;color:#333}
.addressBox ul li a.on {background:#AEAEAE;color:#fff}



/********************************************************************************************************************************************************
	btn, icon 공통작업
*********************************************************************************************************************************************************/
.btnBasic_green {margin:30px 0 0;background:green;text-align:center}
.btnBasic_green a {display:block;height:54px;color:#fff;font-size:18px;line-height:54px;background:green}
.btnBasic_gray {background:url(../images/btn/btn_bg.gif) no-repeat left -148px;text-align:center}
.btnBasic_gray a {display:block;height:44px;color:#4c4c4c;font-size:12px;line-height:44px;background:url(../images/btn/btn_bg.gif) no-repeat right -212px}
.btnBasic_grayDisable {background:url(../images/btn/btn_bg.gif) no-repeat left -404px;text-align:center}
.btnBasic_grayDisable span {display:block;height:44px;color:#888;font-size:12px;line-height:44px;background:url(../images/btn/btn_bg.gif) no-repeat right -468px}


.btnIconWrap {margin:5px 0 0 0;text-align:center}
.btnIconWrap li {float:left;width:34.5%}
.btnIconWrap li:first-child {width:31%}
.btnIconWrap li:first-child .btnIcon_gray {margin-left:0}
.btnIcon_gray {position:relative;background:url(../images/btn/btn_bg.gif) no-repeat left -276px;margin-top:5px;text-align:center}
.btnIcon_gray a {display:block;height:44px;color:#4c4c4c;font:normal 15px "Noto Sans KR";background:##666600 no-repeat right -340px}
.btnIcon_gray a:hover, .btnIcon_gray a:active, .btnIcon_gray a:focus {color:#2b6a2e}
.btnIcon_gray span.btnIco_email {padding:4px 0 12px 34px;background:url('../images/ico/ico_gnb.png') no-repeat 0 -309px;width:26px;height:17px;line-height:44px}
.btnIcon_gray span.btnIco_phone {padding:4px 0 12px 27px;background:url('../images/ico/ico_gnb.png') no-repeat -57px -315px;width:19px;height:27px;line-height:44px}
.btnIcon_gray span.btnIco_emailphone {padding:4px 0 12px 45px;background:url('../images/ico/ico_gnb.png') no-repeat -0px -403px;width:38px;height:27px;line-height:44px}
.btnIcon_gray span.btnIco_check {padding:4px 0 12px 26px;background:url('../images/ico/ico_gnb.png') no-repeat -26px -359px;width:23px;height:24px;line-height:44px}
.btnIcon_gray span.btnIco_close {padding:4px 0 12px 26px;background:url('../images/ico/ico_gnb.png') no-repeat 0 -359px;width:23px;height:24px;line-height:44px}


.textArea_text {margin:0px 0px 20px;padding:0px;line-height:18px;font-size:12px;font-style:normal}
.textArea_ol {padding:20px 0;overflow:hidden;font-size:12px;font-style:normal;border-top:1px solid #e5e5e5;border-bottom:1px solid #e5e5e5}
.textArea_ol .ol1 {margin:0px 50px 0px 0px;padding:0px;font-size:12px;font-style:normal;float:left}
.textArea_ol .ol2 {margin:0px;padding:0px;font-size:12px;font-style:normal;float:left}
.textArea_ol li {list-style:none;margin:0px;padding:0px;height:22px;font-size:12px;font-style:normal}
.textArea_ol li span.first_letter {margin:0px;padding:0px 8px 0px 0px;width:14px;text-align:right;font-size:12px;font-style:normal;float:left;display:block}
.textArea_ol a.green {margin:0px;padding:0px;color:#417c01;font-size:12px;font-style:normal;font-weight:bold;text-decoration:none}

.textArea {font:12px/normal 돋움, Dotum;margin:0px;padding:0 0 45px;color:#666}
.textArea a.green {margin:0px;padding:0px;color:#417c01;font-size:12px;font-style:normal;text-decoration:none}
.textArea h4 {font:bold 14px/normal 돋움, Dotum;margin-top:45px;padding:0px;color:#333;letter-spacing:-1px}
.textArea h4.tit {margin:22px 0px 0px 18px;padding:0px;color:#333;font:bold 12px/normal 돋움, Dotum}
.textArea h5 {margin:22px 0px 0px 18px;padding:0px;color:#666;font:bold 12px/normal 돋움, Dotum}
.textArea p.depth1 {margin:10px 0px 0px 18px;padding:0px;line-height:18px;font-size:12px;font-style:normal;position:relative}
.textArea p.depth2 {margin:10px 0px 0px 36px;padding:0px;line-height:18px;font-size:12px;font-style:normal;position:relative} 
.textArea ul.depth1 {margin:0px 0px -2px 18px;padding:0px;font-size:12px;font-style:normal}
.textArea ul.depth1 li {list-style:none;margin:0px;padding:0px;line-height:18px;font-size:12px;font-style:normal;position:relative}
.textArea ul.depth1_1 {margin:22px 0px -2px 18px;padding:0px 0px 0px 9px;font-size:12px;font-style:normal}
.textArea ul.depth1_1 li {list-style:none;margin:0px;padding:0px;line-height:18px;position:relative}
.textArea ul.depth1_1 li span.first_letter {margin:0px 0px 0px -9px}
.textArea ul.depth1_2 {margin:22px 0px -2px 18px;padding:0px 0px 0px 17px;font:bold 12px/normal 돋움, Dotum}
.textArea ul.depth1_2 li {list-style:none;margin:0px;padding:0px;line-height:18px;font:bold 12px/normal 돋움, Dotum;position:relative}
.textArea ul.depth1_2 li span.first_letter {margin:0px 0px 0px -17px}
.textArea ul.depth1_3 {margin:12px 0px -2px 18px;padding:0px 0px 0px 16px;font-size:12px;font-style:normal}
.textArea ul.depth1_3 li {list-style:none;margin:0px;padding:3px 0px 0px;line-height:18px;font-size:12px;font-style:normal;position:relative}
.textArea ul.depth1_3 li span.first_letter {margin:0px 0px 0px -16px}
.textArea ul.depth2_1 {margin:0px 0px -2px 36px;padding:0px 0px 0px 20px;font-size:12px;font-style:normal}
.textArea ul.depth2_1 li {list-style:none;margin:0px;padding:0px;line-height:18px;font-size:12px;font-style:normal;position:relative}
.textArea ul.depth2_1 li span.first_letter {margin:0px 0px 0px -20px}
.textArea ul.depth2_2 {margin:0px 0px -2px 36px;padding:0px 0px 0px 9px;font-size:12px;font-style:normal}
.textArea ul.depth2_2 li {list-style:none;margin:0px;padding:0px;line-height:18px;font-size:12px;font-style:normal;position:relative}
.textArea ul.depth2_2 li span.first_letter {margin:0px 0px 0px -9px}
.textArea ul.depth3_1 {margin:0px 0px -2px 0px;padding:0px 0px 0px 15px;font-size:12px;font-style:normal}
.textArea ul.depth3_1 li {list-style:none;margin:0px;padding:0px;line-height:18px;font-size:12px;font-style:normal;position:relative}
.textArea ul.depth3_1 li span.first_letter {margin:0px 0px 0px -15px}
.textArea ul.depth3_2 {margin:0px 0px -2px 0px;padding:0px 0px 0px 20px;font-size:12px;font-style:normal}
.textArea ul.depth3_2 li {list-style:none;margin:0px;padding:0px;line-height:18px;font-size:12px;font-style:normal;position:relative}
.textArea ul.depth3_2 li span.first_letter {margin:0px 0px 0px -20px}

.textArea .contactTable {margin-left:18px}
.textArea .contactTable table {position:relative;font:12px/normal 돋움, Dotum;margin:10px 0px 0px 0px;padding:0px;color:#666;letter-spacing:normal}
.textArea .contactTable table tr {margin:0px;padding:0px;font-size:12px;font-style:normal}
.textArea .contactTable table th {background:#f7f7f7;margin:0px;padding:7px 7px 3px;border:1px solid #ccc;text-align:center;font-size:12px;font-style:normal;border-image:none}
.textArea .contactTable table td {margin:0px;padding:7px 7px 3px;border:1px solid #ccc;font-size:12px;font-style:normal;border-image:none}

.textArea .contact {background:#f7f7f7;margin:5px 0px 23px 18px;padding:20px 30px 20px 0px;font-size:12px;font-style:normal}
.textArea .contact table {margin:0px;padding:0px;width:100%;font-size:12px;font-style:normal;border-collapse:collapse;border-spacing:0px}
.textArea .contact table tr {margin:0px;padding:0px;font-size:12px;font-style:normal}
.textArea .contact table th {margin:0px;padding:5px 0px 9px 29px;border:0px currentColor;text-align:left;color:#333;letter-spacing:-1px;font-size:12px;font-style:normal;border-image:none}
.textArea .contact table th.line {border-width:0px 0px 0px 1px;margin:0px;padding:5px 0px 9px 29px;text-align:left;color:#333;letter-spacing:-1px;font-size:12px;font-style:normal;border-left-color:#e5e5e5;border-left-style:solid}
.textArea .contact table td {margin:0px;padding:3px 25px 3px 29px;width:185px;font-size:12px;font-style:normal}
.textArea .contact table td.col2 {margin:0px;padding:3px 0px 3px 29px;width:185px;font-size:12px;font-style:normal;border-left-color:#e5e5e5;border-left-width:1px;border-left-style:solid}

 /* 추가 css */
.cell_radio {width:130px;text-align:right;display:block;padding-left:2px;letter-spacing:-1px}
.inputDisable_h {height:auto}
.inputDisable {background:url(../images/common/bg_form.png) no-repeat left 0;padding-left:10px}
.inputDisable span {display:block;height:44px;color:#666;font:bold 15px "Noto Sans KR";line-height:44px;background:url(../images/common/bg_form.png) no-repeat right -49px}
/*라디오버튼 줄바꿈시 추가*/
.cell_radio2 {height: 24px; padding-top: 10px;text-align:center;}

/* 20150824 추가 */
.cellBtn2 {width: 178px;text-align: right;display: block;padding-left: 0px;padding-top: 5px;letter-spacing: -1px;}
.btninfo_green {color:#ffffff; background:#006600;text-align:center}
.btninfo_green a {display:block;height:15px;color:#ffffff;font:normal 12px "Noto Sans KR";line-height:15px;background:##006600}
.accordion .title a.infomation {color:#fff}
.font_red {color:#ff0000;}
		
	@media all and (min-width:600px){
		.modal{position:absolute;top:50%;left:50%;width:500px;margin:-150px 0 0 -280px;padding:28px 28px 0 28px;border:2px solid #555;background:#fff;font-size:16px;}
		.btn_box{text-align: center; margin-bottom:50px; margin-top:30px;}
		.yes,.no{height:30px; width:120px; padding-top:8px;}
		.yes a,.no a{font-size:16x; font-weight:bold; color:#fff; text-decoration:none;}
		.modal .close{font-size:16px; top:10px; right:10px; }
	}

		
@media all and (max-width:640px) {
#container {width:100%;height:100%;z-index:100;margin:0px auto;background:#fff}
}
</style>


	
<script type="text/javascript">
function goAgree2() {

	$("#memNum").val("<%=eslCustomerNum%>");
	var user_num = $.trim($("#memNum").val());
	if (user_num == "") {
		alert("세션이 종료되었습니다.\n다시 로그인해 주세요.");
		return;
	}


	var policyParam = "";
	policyParam = policyParam + "0002400000";
	if(!$("#safeAgree_34").is(":checked")) {
		alert("잇슬림 이용약관을(를) 선택 하십시오.");	
		$("#safeAgree_34").focus();
		policyParam = policyParam + "|N:16:34:1:N";
		return false;
	}else	{
		policyParam = policyParam + "|Y:16:34:1:N";
	}
	if(!$("#safeAgree_35").is(":checked")) {
		alert("잇슬림 개인정보 수집 · 이용 동의을(를) 선택 하십시오.");	
		$("#safeAgree_35").focus();
		policyParam = policyParam + "|N:16:35:2:N";
		return false;
	}else{
		policyParam = policyParam + "|Y:16:35:2:N";
	}
	$("#safeAgree").val(policyParam);
	return true;
}
</script>

</head>


<body>
<div id="wrap">
	<div id="container_web" >
		<!-- header -->
		<div id="header">
			<h1>잇슬림 회원가입</h1>
		</div>
		<!-- //header -->
		<!-- gnb -->
		<div class="gnb">
		 <p>잇슬림 회원은 인증없이 가입할 수 있으며,<br />잇슬림만의 맞춤화된 배송 안내 서비스와 혜택을 제공받을 수 있습니다.</p>
		</div>
		<!-- //gnb -->	
	    <!-- //header -->
		<!-- content -->
		<div id="content">
			<a href="#none" id="skip_content"></a>
			<form name="registerForm" id="registerForm" method="post" action="/customer/register_Frm_sns.jsp"> 
			<input name="memName" id="memName" type="hidden"/>
			<input name="memNum" id="memNum" type="hidden"/>
			<input name="memEmail" id="memEmail" type="hidden"/>
			<input name="memHp" id="memHp" type="hidden"/>
			<input name="memEmailYn" id="memEmailYn" type="hidden"/>
			<input name="memSmsYn" id="memSmsYn" type="hidden"/>
			<input name="emailMod" id="emailMod" type="hidden"/>

			<div class="contentWrap">

<!-- 약관 출력 start -->					
<h2>잇슬림 회원관리약관</h2>

<div class="boxBasic">
	<div class="accordion">
		<div class="title">
		<a href="javascript:viewCont_es('1');" class="view"><strong>이용약관</strong></a>
			<div class="inputStyle_ri">
				<span class="btn_check">
				<label for="safeAgree_34" style="cursor:pointer;">동의</label>
				<input type="checkbox" name="safeAgree_34" id="safeAgree_34" class="ipt_check" value="1">
				</span>
			</div>
		</div>
<div class="title2" id="drop_cont1"><p>제1조 목적
이 약관은 풀무원건강생활(주)(이하, ‘회사’)가 운영하는 [풀무원건강생활, 풀무원로하스, 녹즙, 베이비밀, 잇슬림]에서 제공하는...<span><a href="javascript:viewCont('1');" class="view">[더보기]</a></span></p></div>
<div class="agree_cont" tabindex="0" id="agree_cont1">제1조 목적<br />
이 약관은 풀무원건강생활(주)(이하, ‘회사’)가 운영하는 [풀무원건강생활, 풀무원로하스, 녹즙, 베이비밀, 잇슬림]에서 제공하는 인터넷 관련 서비스(이하, ‘서비스’라 한다)를 이용함에 있어 사이버몰과 이용자의 권리・의무 및 책임사항을 규정함을 목적으로 합니다.<br />

제2조 정의<br />
① ‘몰’이란 ‘회사’가 재화 또는 용역(이하, ‘재화 등’이라 함)을 이용자에게 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 재화 등을 거래할 수 있도록 설정한 가상의 영업장을 말하며, 아울러 사이버몰을 운영하는 사업자의 의미로도 사용합니다.<br />
② 이용자란 ‘몰’에 접속하여 이 약관에 따라 ‘몰’이 제공하는 서비스를 받는 회원 또는 비회원을 말합니다.<br />
③ ‘회원’이라 함은 ‘몰’에 회원등록을 한 자로서, 계속적으로 ‘몰’이 제공하는 서비스를 이용할 수 있는 자를 말합니다.<br />
④ ‘비회원’이라 함은 회원에 가입하지 않고 ‘몰’이 제공하는 서비스를 이용하는 자를 말합니다.<br />

제3조 약관 등의 명시와 설명 및 개정<br />
① ‘몰’은 이 약관의 내용과 상호 및 대표자 성명, 영업소 소재지 주소(소비자의 불만을 처리할 수 있는 곳의 주소를 포함), 전화번호・모사전송번호・전자우편주소, 사업자등록번호, 통신판매업 신고번호, 개인정보관리책임자 등을 이용자가 쉽게 알 수 있도록 ‘몰’의 초기 서비스화면(전면)에 게시합니다. 다만, 약관의 내용은 이용자가 연결화면을 통하여 볼 수 있도록 할 수 있습니다.<br />
② ‘몰’은 이용자가 약관에 동의하기에 앞서 약관에 정하여져 있는 내용 중 청약철회, 배송책임, 환불조건 등과 같은 중요한 내용을 이용자가 이해할 수 있도록 별도의 연결화면 또는 팝업화면 등을 제공하여 이용자의 확인을 구하여야 합니다.<br />
③ ‘몰’은 「전자상거래 등에서의 소비자보호에 관한 법률」, 「약관의 규제에 관한 법률」, 「전자문서 및 전자거래기본법」, 「전자금융거래법」, 「전자서명법」, 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」, 「방문판매 등에 관한 법률」, 「소비자기본법」 등 관련 법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.<br />
④ ‘몰’이 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 몰의 초기화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다. 다만, 이용자에게 불리하게 약관내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예기간을 두고 공지합니다. 이 경우 ‘몰’은 개정 전 내용과 개정 후 내용을 명확하게 비교하여 이용자가 알기 쉽도록 표시합니다.<br />
⑤ ‘몰’이 약관을 개정할 경우에는 그 개정약관은 그 적용일자 이후에 체결되는 계약에만 적용되고 그 이전에 이미 체결된 계약에 대해서는 개정 전의 약관조항이 그대로 적용됩니다. 다만 이미 계약을 체결한 이용자가 개정약관 조항의 적용을 받기를 원하는 뜻을 제3항에 의한 개정약관의 공지기간 내에 ‘몰’에 송신하여 ‘몰’의 동의를 받은 경우에는 개정약관 조항이 적용됩니다.<br />
⑥ 이용자는 변경된 약관에 동의하지 않을 경우 회원 탈퇴(이용계약의 해지)를 요청할 수 있으며, 회사가 제4항에 따라 변경된 약관을 공지 또는 통지하면서 이용자에게 약관 변경 적용일까지 거부의사를 표시하지 아니할 경우 약관 변경에 동의한 것으로 간주한다는 내용을 공지 또는 통지하였음에도 이용자 명시적으로 약관 변경에 거부의사를 표시하지 아니하면, ‘회사’는 이용자가 변경 약관에 동의한 것으로 간주합니다.<br />
⑦ 이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 전자상거래 등에서의 소비자보호에 관한 법률, 약관의 규제 등에 관한 법률, 공정거래위원회가 정하는 「전자상거래 등에서의 소비자 보호지침」 및 관계법령 또는 상관례에 따릅니다.<br />

제4조 서비스의 제공 및 변경<br />
① ‘몰’은 다음과 같은 업무를 수행합니다.<br />
1. 재화 또는 용역에 대한 정보 제공 및 구매계약의 체결<br />
2. 구매계약이 체결된 재화 또는 용역의 배송<br />
3. 기타 ‘몰’이 정하는 업무<br />
② ‘몰’은 재화 또는 용역의 품절 또는 기술적 사양의 변경 등의 경우에는 장차 체결되는 계약에 의해 제공할 재화 또는 용역의 내용을 변경할 수 있습니다. 이 경우에는 변경된 재화 또는 용역의 내용 및 제공일자를 명시하여 현재의 재화 또는 용역의 내용을 게시한 곳에 즉시 공지합니다.<br />
③ ‘몰’이 제공하기로 이용자와 계약을 체결한 서비스의 내용을 재화 등의 품절 또는 기술적 사양의 변경 등의 사유로 변경할 경우에는 그 사유를 이용자에게 통지 가능한 주소로 즉시 통지합니다.<br />
④ 전항의 경우 ‘몰’은 이로 인하여 이용자가 입은 손해를 배상합니다. 다만, ‘몰’이 고의 또는 과실이 없음을 입증하는 경우에는 그러하지 아니합니다.<br />

제5조 서비스의 중단<br />
① ‘몰’은 컴퓨터 등 정보통신설비의 보수점검?교체 및 고장, 통신의 두절 등의 사유가 발생한 경우에는 서비스의 제공을 일시적으로 중단할 수 있습니다.<br />
② ‘몰’은 1항의 사유로 서비스의 제공이 일시적으로 중단됨으로 인하여 이용자 또는 제3자가 입은 손해에 대하여 배상합니다. 단, ‘몰’이 고의 또는 과실이 없음을 입증하는 경우에는 그러하지 아니합니다.<br />
③ 사업종목의 전환, 사업의 포기, 업체 간의 통합 등의 이유로 서비스를 제공할 수 없게 되는 경우에는 “몰”은 제8조에 정한 방법으로 이용자에게 통지하고 당초 “몰”에서 제시한 조건에 따라 소비자에게 보상합니다. 다만, “몰”이 보상기준 등을 고지하지 아니한 경우에는 이용자들의 마일리지 또는 적립금 등을 “몰”에서 통용되는 통화가치에 상응하는 현물 또는 현금으로 이용자에게 지급합니다.<br />

제6조 회원가입<br />
① 이용자는 ‘몰’이 정한 가입 양식에 따라 회원정보를 기입한 후 이 약관에 동의한다는 의사표시를 함으로서 회원가입을 신청합니다.<br />
② ‘몰’은 제1항과 같이 회원으로 가입할 것을 신청한 이용자 중 다음 각 호에 해당하지 않는 한 ‘회원’으로 등록합니다.<br />
1. 가입신청자가 이 약관 제7조 제3항에 의하여 이전에 회원자격을 상실한 적이 있는 경우, 다만 제7조 제3항에 의한 회원자격 상실 후 3년이 경과한 자로서 ‘몰’의 회원재가입 승낙을 얻은 경우에는 예외로 한다.<br />
2. 등록 내용에 허위, 기재누락, 오기가 있는 경우<br />
3. 기타 회원으로 등록하는 것이 ‘몰’의 기술상 현저히 지장이 있다고 판단되는 경우<br />
③ 회원가입계약의 성립 시기는 ‘몰’의 승낙이 회원에게 도달한 시점으로 합니다.<br />
④ ‘회원’은 회원가입 시 등록한 사항에 변경이 있는 경우, 상당한 기간 이내에 ‘몰’에 대하여 회원정보 수정 등의 방법으로 그 변경사항을 알려야 합니다.<br />

제7조 회원 탈퇴 및 자격 상실 등<br />
① ‘회원’은 ‘몰’에 언제든지 탈퇴를 요청할 수 있으며 ‘몰’은 즉시 회원탈퇴를 처리합니다.<br />
② ‘회원’이 다음 각 호의 사유에 해당하는 경우, ‘몰’은 회원자격을 제한 및 정지시킬 수 있습니다.<br />
③ ‘몰’이 회원 자격을 제한?정지 시킨 후, 동일한 행위가 2회 이상 반복되거나 30일 이내에 그 사유가 시정되지 아니하는 경우 ‘몰’은 회원자격을 상실시킬 수 있습니다.<br />
④ ‘몰’이 회원자격을 상실시키는 경우에는 회원등록을 말소합니다. 이 경우 ‘회원’에게 이를 통지하고, 회원등록 말소 전에 최소한 30일 이상의 기간을 정하여 소명할 기회를 부여합니다.<br />

제8조 회원에 대한 통지<br />
① ‘몰’ 이 ‘회원’에 대한 통지를 하는 경우, ‘회원’이 ‘몰’과 미리 약정하여 지정한 전자우편 주소로 할 수 있습니다.<br />
② ‘몰’은 불특정다수 회원에 대한 통지의 경우 1주일이상 ‘몰’ 게시판에 게시함으로서 개별 통지에 갈음할 수 있습니다. 다만, 회원 본인의 거래와 관련하여 중대한 영향을 미치는 사항에 대하여는 개별통지를 합니다.<br />

제9조 구매신청<br />
이용자는 ‘몰’상에서 다음 또는 이와 유사한 방법에 의하여 구매를 신청하며, ‘몰’은 이용자가 구매신청을 함에 있어서 다음의 각 내용을 알기 쉽게 제공하여야 합니다.<br />
1. 재화 등의 검색 및 선택<br />
2. 성명, 주소, 전화번호, 전자우편주소(또는 이동전화번호)등의 입력<br />
3. 약관내용, 청약철회권이 제한되는 서비스, 배송료・설치비 등의 비용부담과 관련한 내용에 대한 확인<br />
4. 이 약관에 동의하고 위 3.호의 사항을 확인하거나 거부하는 표시(예, 마우스 클릭)<br />
5. 재화 등의 구매신청 및 이에 관한 확인 또는 ‘몰’의 확인에 대한 동의<br />
6. 결제방법의 선택<br />

제10조 계약의 성립<br />
① ‘몰’은 제9조와 같은 구매신청에 대하여 다음 각 호에 해당하면 승낙하지 않을 수 있습니다. 다만, 미성년자와 계약을 체결하는 경우에는 법정대리인의 동의를 얻지 못하면 미성년자 본인 또는 법정대리인이 계약을 취소할 수 있다는 내용을 고지하여야 합니다.<br />
1. 신청 내용에 허위, 기재누락, 오기가 있는 경우<br />
2. 미성년자가 담배, 주류 등 청소년보호법에서 금지하는 재화 및 용역을 구매하는 경우<br />
3. 기타 구매신청에 승낙하는 것이 ‘몰’의 기술상 현저히 지장이 있다고 판단하는 경우<br />
② ‘몰’의 승낙이 제12조제1항의 수신확인통지형태로 이용자에게 도달한 시점에 계약이 성립한 것으로 봅니다.<br />
③ ‘몰’의 승낙의 의사표시에는 이용자의 구매 신청에 대한 확인 및 판매가능 여부, 구매신청의 정정 취소 등에 관한 정보 등을 포함하여야 합니다.<br />

제11조 지급방법<br />
‘몰’에서 구매한 재화 또는 용역에 대한 대금지급방법은 다음 각 호의 방법 중 가용한 방법으로 할 수 있습니다. 단, ‘몰’은 이용자의 지급방법에 대하여 재화 등의 대금에 어떠한 명목의 수수료도 추가하여 징수할 수 없습니다.<br />
1. 폰뱅킹, 인터넷뱅킹, 메일 뱅킹 등의 각종 계좌이체 <br />
2. 선불카드, 직불카드, 신용카드 등의 각종 카드 결제<br />
3. 온라인무통장입금<br />
4. 전자화폐에 의한 결제<br />
5. 마일리지 등 “몰”이 지급한 포인트에 의한 결제<br />
6. ‘몰’과 계약을 맺었거나 “몰”이 인정한 상품권에 의한 결제  <br />
7. 기타 전자적 지급 방법에 의한 대금 지급 등<br />

제12조 수신확인통지, 구매신청 변경 및 취소<br />
① ‘몰’은 이용자의 구매신청이 있는 경우 이용자에게 수신확인통지를 합니다.<br />
② 수신확인통지를 받은 이용자는 의사표시의 불일치 등이 있는 경우에는 수신확인통지를 받은 후 즉시 구매신청 변경 및 취소를 요청할 수 있고 “몰”은 배송 전에 이용자의 요청이 있는 경우에는 지체 없이 그 요청에 따라 처리하여야 합니다. 다만 이미 대금을 지불한 경우에는 제15조의 청약철회 등에 관한 규정에 따릅니다.<br />


제13조 재화 등의 공급<br />
① ‘몰’은 이용자와 재화 등의 공급시기에 관하여 별도의 약정이 없는 이상, 이용자가 청약을 한 날부터 7일 이내에 재화 등을 배송할 수 있도록 주문제작, 포장 등 기타의 필요한 조치를 취합니다. 다만, ‘몰’이 이미 재화 등의 대금의 전부 또는 일부를 받은 경우에는 대금의 전부 또는 일부를 받은 날부터 3영업일 이내에 조치를 취합니다.  이때 ‘몰’은 이용자가 재화 등의 공급 절차 및 진행 사항을 확인할 수 있도록 적절한 조치를 합니다.<br />
② ‘몰’은 이용자가 구매한 재화에 대해 배송수단, 수단별 배송비용 부담자, 수단별 배송기간 등을 명시합니다. 만약 ‘몰’이 약정 배송기간을 초과한 경우에는 그로 인한 이용자의 손해를 배상하여야 합니다. 다만 ‘몰’이 고의?과실이 없음을 입증한 경우에는 그러하지 아니합니다.<br />

제14조 포인트 또는 적립금 제도의 운영<br />
① ‘몰‘은 회원에게 포인트 또는 마일리지(‘몰‘이 회원에게 일정한 조건에 따라 부여하는 것으로 재산적 가치는 없음)를 부여할 수 있습니다.<br />
② ‘몰’은 포인트 획득, 사용 방법 등에 관련된 세부 이용 지침을 별도로 정하여 시행할 수 있으며, 회원은 그 지침 에 따라야 합니다. ‘몰’이 상이한 시기와 발생 원인에 따라서 회원에게 포인트를 부여하여 회원이 합산된 포인트 중 일부를 사용할 경우 포인트의 차감 순서나 포인트의 소멸시효 기간 등은 ‘몰‘이 결정하여 공지합니다.<br />
③ ‘몰‘은 이용지가 ‘몰’에서 정한 특정한 조건을 충족할 경우 구매대금의 일정비율을 적립금으로 제공하는 적립금 제도를 운영하고 있습니다.(일부 상품 제외)<br />
④ 누적된 적립금은 적립금의 적립 시점으로부터 일정기간 사용하지 않을 경우 자동 소멸됩니다.<br />
⑤ 위 제3항 내지 4항에 따른 적립조건 및 적립비율과 적립금의 이용기간은 ‘몰’이 별도 정한 바에 따릅니다.<br />
⑥ 이용 해지와 동시에 적립된 적립금은 소멸되며 재가입 하여도 한 번 소멸된 적립금은 다시 적용되지 않습니다.<br />

제15조 환금<br />
‘몰’은 이용자가 구매 신청한 재화 등이 품절 등의 사유로 인도 또는 제공을 할 수 없을 때에는 지체 없이 그 사유를 이용자에게 통지하고 사전에 재화 등의 대금을 받은 경우에는 대금을 받은 날부터 3영업일 이내에 환급하거나 환급에 필요한 조치를 취합니다.<br />

제16조 청약철회 등<br />
① ‘몰’과 재화 등의 구매에 관한 계약을 체결한 이용자는 「전자상거래 등에서의 소비자보호에 관한 법률」 제13조 제2항에 따른 계약내용에 관한 서면을 받은 날(그 서면을 받은 때보다 재화 등의 공급이 늦게 이루어진 경우에는 재화 등을 공급받거나 재화 등의 공급이 시작된 날을 말합니다)부터 7일 이내에는 청약의 철회를 할 수 있습니다. 다만, 청약철회에 관하여 「전자상거래 등에서의 소비자보호에 관한 법률」에 달리 정함이 있는 경우에는 동 법 규정에 따릅니다.<br />
② 이용자는 재화 등을 배송 받은 경우 다음 각 호의 1에 해당하는 경우에는 반품 및 교환을 할 수 없습니다.<br />
③ 제2항 제2호 내지 제4호의 경우에 ‘몰’이 사전에 청약철회 등이 제한되는 사실을 소비자가 쉽게 알 수 있는 곳에 명기하거나 시용상품을 제공하는 등의 조치를 하지 않았다면 이용자의 청약철회 등이 제한되지 않습니다.<br />
④ 이용자는 제1항 및 제2항의 규정에 불구하고 재화 등의 내용이 표시・광고 내용과 다르거나 계약내용과 다르게 이행된 때에는 당해 재화 등을 공급받은 날부터 3월 이내, 그 사실을 안 날 또는 알 수 있었던 날부터 30일 이내에 청약철회 등을 할 수 있습니다.<br />

제17조 청약철회 등의 효과<br />
① ‘몰’은 이용자로부터 재화 등을 반환받은 경우 3영업일 이내에 이미 지급받은 재화 등의 대금을 환급합니다. 이 경우 ‘몰’이 이용자에게 재화 등의 환급을 지연한때에는 그 지연기간에 대하여 「전자상거래 등에서의 소비자보호에 관한 법률 시행령」제21조의2에서 정하는 지연이자율을 곱하여 산정한 지연이자를 지급합니다.<br />
② ‘몰’은 위 대금을 환급함에 있어서 이용자가 신용카드 또는 전자화폐 등의 결제수단으로 재화 등의 대금을 지급한 때에는 지체 없이 당해 결제수단을 제공한 사업자로 하여금 재화 등의 대금의 청구를 정지 또는 취소하도록 요청합니다.<br />
③ 청약철회 등의 경우 공급받은 재화 등의 반환에 필요한 비용은 이용자가 부담합니다. ‘몰’은 이용자에게 청약철회 등을 이유로 위약금 또는 손해배상을 청구하지 않습니다. 다만 재화 등의 내용이 표시・광고 내용과 다르거나 계약내용과 다르게 이행되어 청약철회 등을 하는 경우 재화 등의 반환에 필요한 비용은 ‘몰’이 부담합니다.<br />
⑤ 이용자가 재화 등을 제공받을 때 발송비를 부담한 경우에 ‘몰’은 청약철회 시 그 비용을  누가 부담하는지를 이용자가 알기 쉽도록 명확하게 표시합니다.<br />

제18조 개인정보보호<br />
① ‘몰’은 이용자의 개인정보 수집 시 서비스제공을 위하여 필요한 범위에서 최소한의 개인정보를 수집합니다. <br />
② ‘몰’은 이용자의 개인식별이 가능한 개인정보를 수집할 때에는 반드시 당해 이용자의 동의를 받습니다.<br />
③ 제공된 개인정보는 당해 이용자의 동의 없이 목적 외의 이용이나 제3자에게 제공할 수 없으며, 이에 대한 모든 책임은 ‘몰’이 집니다. 다만, 다음의 경우에는 예외로 합니다.<br />
1. 배송업무상 배송업체에게 배송에 필요한 최소한의 이용자의 정보(성명, 주소, 전화번호)를 알려주는 경우<br />
2. 통계작성, 학술연구 또는 시장조사를 위하여 필요한 경우로서 특정 개인을 식별할 수 없는 형태로 제공하는 경우<br />
3. 재화 등의 거래에 따른 대금정산을 위하여 필요한 경우<br />
4. 도용방지를 위하여 본인확인에 필요한 경우<br />
5. 법률의 규정 또는 법률에 필요한 불가피한 사유가 있는 경우<br />
④ ‘몰’이 제2항과 제3항에 의해 이용자의 동의를 받아야 하는 경우에는 개인정보관리 책임자의 신원(소속, 성명 및 전화번호, 기타 연락처), 정보의 수집목적 및 이용목적, 제3자에 대한 정보제공 관련사항(제공받은 자, 제공목적 및 제공할 정보의 내용) 등 정보통신망 이용촉진 등에 관한 법률 제22조제2항이 규정한 사항을 미리 명시하거나 고지해야 하며 이용자는 언제든지 이 동의를 철회할 수 있습니다.<br />
⑤ 이용자는 언제든지 ‘몰’이 가지고 있는 자신의 개인정보에 대해 열람 및 오류정정을 요구할 수 있으며 ‘몰’은 이에 대해 지체 없이 필요한 조치를 취할 의무를 집니다. 이용자가 오류의 정정을 요구한 경우에는 “몰”은 그 오류를 정정할 때까지 당해 개인정보를 이용하지 않습니다.<br />
⑥ ‘몰’은 개인정보 보호를 위하여 관리자를 한정하여 그 수를 최소화하며 신용카드, 은행계좌 등을 포함한 이용자의 개인정보의 분실, 도난, 유출, 변조 등으로 인한 이용자의 손해에 대하여 모든 책임을 집니다.<br />
⑦ ‘몰’ 또는 그로부터 개인정보를 제공받은 제3자는 개인정보의 수집목적 또는 제공받은 목적을 달성한 때에는 당해 개인정보를 지체 없이 파기합니다.<br />

제19조 ‘몰’의 의무<br />
① ‘몰’은 법령과 이 약관이 금지하거나 공서양속에 반하는 행위를 하지 않으며 이 약관이 정하는 바에 따라 지속적이고, 안정적으로 재화?용역을 제공하는데 최선을 다하여야 합니다.<br />
② ‘몰’은 이용자가 안전하게 인터넷 서비스를 이용할 수 있도록 이용자의 개인정보(신용정보 포함)보호를 위한 보안 시스템을 갖추어야 합니다.<br />
③ ‘몰’이 상품이나 용역에 대하여 「표시?광고의 공정화에 관한 법률」 제3조 소정의 부당한 표시?광고행위를 함으로써 이용자가 손해를 입은 때에는 이를 배상할 책임을 집니다.<br />
⑧ ‘몰’은 이용자가 원하지 않는 영리목적의 광고성 전자우편을 발송하지 않습니다.<br />

제20조 회원의 ID 및 비밀번호에 대한 의무<br />
① 제17조의 경우를 제외한 ID와 비밀번호에 관한 관리책임은 회원에게 있습니다.<br />
② 회원은 자신의 ID 및 비밀번호를 제3자에게 이용하게 해서는 안 됩니다.<br />
③ 회원이 자신의 ID 및 비밀번호를 도난당하거나 제3자가 사용하고 있음을 인지한 경우에는 바로 ‘몰’에 통보하고 ‘몰’의 안내가 있는 경우에는 그에 따라야 합니다.<br />

제21조 이용자의 의무<br />
이용자는 다음 행위를 하여서는 안 됩니다.<br />
1. 신청 또는 변경시 허위 내용의 등록<br />
2. 타인의 정보 도용<br />
3. ‘몰’에 게시된 정보의 변경<br />
4. ‘몰’이 정한 정보 이외의 정보(컴퓨터 프로그램 등) 등의 송신 또는 게시<br />
5. ‘몰’ 기타 제3자의 저작권 등 지적재산권에 대한 침해<br />
6. ‘몰’ 기타 제3자의 명예를 손상시키거나 업무를 방해하는 행위<br />
7. 외설 또는 폭력적인 메시지, 화상, 음성, 기타 공서양속에 반하는 정보를 몰에 공개 또는 게시하는 행위<br />

제22조 연결 ‘몰’과 피연결 ‘몰’간의 관계<br />
① ‘몰’은 다른 사이트를 하이퍼링크(하이퍼링크의 대상에는 문자, 그림 및 동영상 등이 포함)방식 등에 의해 연결시킬 수 있습니다.<br />
② ‘몰’은 이용자가 해당 연결된 다른 사이트와 독자적으로 상품 또는 용역을 거래한 행위에 대하여는 어떠한 책임도 부담하지 않습니다.<br />

제23조 저작권의 귀속 및 이용제한<br />
① ‘몰’이 작성한 저작물에 대한 저작권 기타 지적재산권은 ‘몰’에 귀속합니다.<br />
② 이용자는 ‘몰’을 이용함으로써 얻은 정보 중 ‘몰’에게 지적재산권이 귀속된 정보를 ‘몰’의 사전 승낙 없이 복제, 송신, 출판, 배포, 방송 기타 방법에 의하여 영리목적으로 이용하거나 제3자에게 이용하게 하여서는 안 됩니다.<br />
③ ‘몰’은 약정에 따라 이용자에게 귀속된 저작권을 사용하는 경우 당해 이용자에게 통보하여야 합니다.<br />

제24조 분쟁해결<br />
① ‘몰’은 이용자가 제기하는 정당한 의견이나 불만을 반영하고 그 피해를 보상처리하기 위하여 피해보상처리기구를 설치・운영합니다.<br />
② ‘몰’은 이용자로부터 제출되는 불만사항 및 의견은 우선적으로 그 사항을 처리합니다. 다만, 신속한 처리가 곤란한 경우에는 이용자에게 그 사유와 처리일정을 즉시 통보해 드립니다.<br />
③ ‘몰’과 이용자간에 발생한 전자상거래 분쟁과 관련하여 이용자의 피해구제신청이 있는 경우에는 공정거래위원회 또는 시ㆍ도지사가 의뢰하는 분쟁조정기관의 조정에 따를 수 있습니다.<br />

제25조 재판권 및 준거법<br />
① ‘몰’과 이용자 간에 발생한 전자상거래 분쟁에 관한 소송은 서울중앙지방법원을 관할법원으로 합니다.<br />
② ‘몰’과 이용자 간에 제기된 전자상거래 소송에는&nbsp;대한민국&nbsp;법을&nbsp;적용합니다.</div>
</div>
</div>

<div class="boxBasic">
<div class="accordion">
<div class="title">
<a href="javascript:viewCont_es('2');" class="view"><strong>개인정보 수집 · 이용 동의</strong></a>
<div class="inputStyle_ri">
<span class="btn_check">
<label for="safeAgree_35" style="cursor:pointer;">동의</label>
<input type="checkbox" name="safeAgree_35" id="safeAgree_35" class="ipt_check" value="1">
</span>
</div>
<span class="cellBtn2"><div class="btninfo_green"><a href="http://www.eatsslim.com/terms/privacy.jsp" target="_blank" title="새창" class="infomation">개인정보취급(처리)방침 전문보기</a></div></span>
</div>
<div class="title2" id="drop_cont2"><p>풀무원건강생활(주)는 (이하 “회사”라 함) 회원님의 개인정보를 개인정보보호법, 정보통신망 이용촉진 및 정보보호 등에 관한 법률(이하 ‘정보통신...<span><a href="javascript:viewCont('2');" class="view">[더보기]</a></span></p></div>
<div class="agree_cont" tabindex="0" id="agree_cont2">풀무원건강생활(주)는 (이하 “회사”라 함) 회원님의 개인정보를 개인정보보호법, 정보통신망 이용촉진 및 정보보호 등에 관한 법률(이하 ‘정보통신망법’이라함) 등 관련법령(이하 ‘관련법령’이라 함)에 근거하여 수집 ・ 보유 및 처리되고 있습니다.<br />

1. 개인정보 수집 및 이용목적<br />

① 회사는 개인정보를 다음 목적을 위해 수집 및 처리합니다.<br />
가. 서비스 제공 계약의 성립 및 유지 종료를 위한 본인 식별, 가입의사 확인, 회원에 대한 고지사항전달, 고객정보분석 및 분석정보의 통계적 활용, 불량회원 부정이용방지 및 비인가 사용방지, 서비스 개발을 위한 연구/조사, 불만처리 등 원활한 의사소통 경로의 확보, 회원에 대한 고지사항 전달<br />
 나. 상품 및 서비스의 구매에 대한 결제와 공급 및 배송<br />
② 수집한 개인정보는 상기의 목적 이외의 용도로는 사용되지 않으며 보다 나은 서비스 혜택 제공을 위해 다양한 방법(전화, SMS, 우편 등)을 통해 서비스 관련 정보를 회원에게 제공할 수 있습니다.단, 회원이 서비스 혜택 정보 제공을 원치 않는다는 의사를 명확히 밝히는 경우 정보제공을 하지 않으며 이 경우 회원에게 정보 미 제공으로 인한 불이익이 발생하더라도 회사가 책임지지 않습니다. 또한, 이용 목적이 변경될 시에는 사전 동의를 구할 예정입니다. <br />
③ 이용자는 회사가 회원이 개인정보를 수집할 때 이를 거부할 수 있습니다. 다만, 필수동의 관련 제공을 거부하는 경우에는 서비스 제공 불가 또는 제한의 불이익을 받을 수 있습니다.<br />

회사는 회원에게 다양한 서비스 제공 위해 다음과 같은 개인정보를 수집하고 있습니다. 단, 이용자의 기본적 인권 침해의 우려가 있는 민감한 개인정보(인종 및 민족, 사상 및 신조, 출신지 및 본적지, 정치적 성향 및 범죄기록, 건강상태 및 성생활 등)와 주민등록번호는 수집하지 않습니다.<br />

가. 풀무원회원 가입시<br />
① 필수입력사항 : 이름, 비밀번호, 우편물수령지 주소 및 전화번호(직장 또는 자택), 휴대전화번호, 이메일주소, 본인확인기관을 통해 받는 결과값(CI), 만 14세 미만 회원의 법정대리인 이름 및 본인확인기관을 통해 받는 결과값(CI), 외국인등록번호<br />
- 단, 일부 필수입력사항(우편물수령지 주소 및 전화번호(직장 또는 자택) 등)은 회원 가입 채널에 따라 수집 시점이 달라질 수 있습니다.<br />
- 단, 풀무원회원 서비스는 이메일 주소 및 핸드폰번호가 ID역활을 합니다.<br />
② 선택입력사항 : 주소 및 전화번호(직장 또는 자택), 생년월일, 성별, 결혼여부, 결혼기념일, 기타 기념일, 멤버십 카드번호 등 개인별 서비스 제공을 위해 필요한 항목 및 추가 입력 사항<br />
- 단, 일부 선택입력사항(주소 및 전화번호(직장 또는 자택) 등)은 회원 가입 채널에 따라 수집 시점이 달라질 수 있습니다.<br />
③ 서비스 이용 또는 사업처리 과정에서 생성 수집되는 각종 거래 및 개인 성향 정보 : 서비스 이용기록(이용기간, 이용매장, 포인트, 상품 또는 서비스 구매내역), 접속 로그, 쿠키, 접속IP정보, 결제기록 등<br />
④ 모바일 서비스 이용 시 단말기에 관한 정보 : 단말기 모델명, 이동통신사 정보, 하드웨어 ID<br />
 ※ 상기 단말기에 관한 정보는 개인을 식별할 수 없는 형태이며 풀무원회원은 수집된 정보를 바탕으로 개인을 식별하는 일체의 활동을 하지 않습니다.<br />

나. 간편회원 가입시 <br />
① 필수입력사항 : 이름, 휴대전화번호, 이메일주소<br />
- 단, 일부 필수입력사항(우편물수령지 주소 및 전화번호(직장 또는 자택) 등)은 회원 가입 채널에 따라 수집 시점이 달라질 수 있습니다.<br />
② 선택입력사항 : 주소 및 전화번호(직장 또는 자택), 생년월일, 성별, 결혼여부, 결혼기념일, 기타 기념일, 멤버십 카드번호 등 개인별 서비스 제공을 위해 필요한 항목 및 추가 입력 사항<br />
- 단, 일부 선택입력사항(주소 및 전화번호(직장 또는 자택) 등)은 회원 가입 채널에 따라 수집 시점이 달라질 수 있습니다.<br />
③ 서비스 이용 또는 사업처리 과정에서 생성 수집되는 각종 거래 및 개인 성향 정보 : 서비스 이용기록(이용기간, 이용매장, 포인트, 상품 또는 서비스 구매내역), 접속 로그, 쿠키, 접속IP정보, 결제기록 등<br />

3. 개인정보의 보유 및 이용기간<br />

① 이용자 개인정보는 원칙적으로 개인정보의 처리목적이 달성될 때까지 보관되며 처리목적이 달성되면 지체 없이 파기합니다.<br />
② 단, 다음의 정보에 대하여는 아래의 사유로 명시한 기간 동안 보존합니다.<br />
가. 개인정보 파일명 : 계약 또는 청약철회 등에 관한 기록<br />
 보유기간: 5년<br />
 보유근거: 전자상거래 등에서의 소비자보호에 관한 법률<br />
 나. 개인정보 파일명 : 대금결제 및 재화 등의 공급에 관한 기록<br />
 보유기간: 5년<br />
 보유근거: 전자상거래 등에서의 소비자보호에 관한 법률<br />
 다. 개인정보 파일명 : 소비자의 불만 또는 분쟁처리에 관한 기록<br />
 보유기간: 3년<br />
 보유근거: 전자상거래 등에서의 소비자보호에 관한 법률<br />
 라. 개인정보 파일명: 본인확인에 관한 기록<br />
 보유기간: 6개월<br />
 보유근거: 정보통신망 이용촉진 및 정보보호 등에 관한 법률<br />
 마. 개인정보 파일명: 방문에 관한 기록<br />
 보유기간: 3개월<br />
 보유근거: 통신비밀보호법 </div>
</div>
</div>

<div class="boxBasic mb5">
<div class="accordion_v"><div class="title"><b>마케팅 수신 동의</b></div><div class="agree_cont" tabindex="0">회사는 서비스 혜택 제공을 위해 다양한 방법(전화, SMS, 우편 등)을 통해 서비스 관련 정보를 회원에게 제공할 수 있습니다.<br> 단, 회원이 서비스 혜택 정보 제공을 원치 않는다는 의사를 명확히 밝히는 경우 정보제공을 하지 않으며 이 경우 회원에게 정보 미 제공으로 인한 불이익이 발생하더라도 회사가 책임지지 않습니다. 또한, 이용 목적이 변경될 시에는 사전 동의를 구할 예정입니다.<br><br>- 이벤트 및 마케팅 기획, 서비스 개발을 위한 연구/조사, 서비스 관련 각종 이벤트 및 행사 관련 정보 안내를 위한 이메일, SMS 발송, 사은행사 안내, 이벤트/경품 당첨 결과 안내 및 상품배송</div></div>

</div><div class="boxBasic"><div class="inputStyleWrap"><div class="inputStyle_ce"><span class="btn_check plr5"><input type="checkbox" class="ipt_check" name="smsYN" id="smsYN" value="Y"> <span><label for="smsYN">SMS 수신 동의</label></span></span><span class="btn_check plr5"><input type="checkbox" class="ipt_check" name="emailYN" id="emailYN" value="Y"> <span><label for="emailYN">E-mail 수신 동의</label></span></span></div></div></div>
<!-- 약관 출력 end -->


<div class="boxBasic">

	<div class="accordion">
		<div class="title">
		<a href="#" class="view"><strong>개인정보 입력</strong></a>
		</div>
		<div class="title2"><p>잇슬림은 정확한 배송을 위하여 최소한의 정보를 수집하고 있으며, 휴대폰을 
		통한 배송 알림 서비스를 제공하고 있습니다.</p>
		</div>
	</div>
</div>


				<div id="hpConfirmLayer" style="display:;">
				
				
				<!-- boxBasic -->
				<div class="boxBasic">
					<!-- boxContents -->
					<table class="formBasic">
						<caption>기본정보 입력</caption>
						<colgroup>
						</colgroup>
						<tbody>
						<tr>
							<td>
								<p><label for="userName">이름</label><span class="font_red"> ( * 필수)</span></p>
								<!-- input -->
							<div class="inputInfo">
									<div class="inner_g">
										<input name="userName" id="userName" title="이름" class="tf_g ww" type="text" style="ime-mode:deactivated;" maxlength="20">
									</div>
								</div>
								<!-- //input -->
							</td>
						</tr>
						<tr>
							<td>
								<p>휴대폰번호<span class="font_red"> ( * 필수)</span></span></p>
								<!-- input -->
								<span class="cellFirst">
									<span class="cellw1">
										<div class="inputInfo">
										<select class="selectBox" name="htel1" id="htel1" title="핸드폰 앞자리 숫자" >
											<option value="010" >010</option>
											<option value="011" >011</option>
											<option value="016" >016</option>
											<option value="017" >017</option>
											<option value="018" >018</option>
											<option value="019" >019</option>
										</select>
										</div>
      								</span>
									<span class="cellDesh">-</span>	
									<span class="cellw2">
										<div class="inputInfo">
											<div class="inner_g">
												<input type="tel" name="htel2" id="htel2" title="핸드폰 가운데 숫자" numberOnly="true" class="tf_g ww" maxlength="4">
											</div>
										</div>
      								</span>
									<span class="cellDesh">-</span>
									<span class="cellw2">
										<div class="inputInfo">
											<div class="inner_g">
												<input type="tel" name="htel3" id="htel3" title="핸드폰 끝자리" numberOnly="true" class="tf_g ww" maxlength="4">
											</div>
										</div>
      								</span>
				
								</span>
								<!-- //input -->
							</td>
						</tr>
						<tr>
							<td>
								<p>E-mail</p>
								<!-- input -->
								<span class="cellFirst">
									<span class="cellw1">
										<div class="inputInfo">
											<div class="inner_g">
												<input type="tel" name="email1" id="email1" title="이메일"  class="tf_g ww" maxlength="30">
											</div>
										</div>
      								</span>
									<span class="cellDesh">@</span>
									<span class="cellw1">
										<div class="inputInfo">
											<div class="inner_g">
												<input type="tel" name="email2" id="email2" title="이메일도메인"  class="tf_g ww" maxlength="30">
											</div>
										</div>
      								</span>

									<select class="selectBox2" name="sel_email" id="sel_email" >
									<option value="" selected="selected">- 이메일 선택 -</option>
									<option value="naver.com">naver.com</option>
									<option value="daum.net">daum.net</option>
									<option value="nate.com">nate.com</option>
									<option value="hotmail.com">hotmail.com</option>
									<option value="yahoo.com">yahoo.com</option>
									<option value="empas.com">empas.com</option>
									<option value="korea.com">korea.com</option>
									<option value="dreamwiz.com">dreamwiz.com</option>
									<option value="gmail.com">gmail.com</option>
									<option value="etc">직접입력</option>
									</select>
								</span>
							</td>
						</tr>

						</tbody>
					</table>					
					<!-- //boxContents -->
					<div id="lastPostsLoader" style="display:none;position:relative;bottom:110px;width:0px;height:0px;" class="loading"><img src="https://member.pulmuone.co.kr/images/common/loading_txt.gif" alt="loading" /></div>
				</div>					
				<!-- //boxBasic -->
				
				  
				</div>
				<div id="emailConfirmLayer" style="display:none;"></div>
				<!-- button -->
				<div class="btnBasic_green">
					<a href="javascript:go_es_nextpage(this);">가입완료</a>	
				</div>	
				<!-- //button -->				
			</div>
			</form>

		</div>
		<!-- //content -->
	</div>
</div>
</body>
</html>

<script type="text/javascript">

function go_es_nextpage() {
	var agreeBoolean = goAgree2();
	var user_name = $.trim($("#userName").val());

	if (agreeBoolean) {
		if (user_name == "") {
			alert("이름을 입력 하십시오.");
			$("#userName").focus();
			return;
		}
		if(!isHanEng_es(user_name)){
			alert("한글과 영문만 입력 가능합니다.\n(공백 및 특수문자 입력 불가)");
			user_name = user_name.replace(/ /gi, '');
			$("#userName").val(user_name);
			$("#userName").focus();
			return;			
		}
		if ($("#htel1").val() == "") {
			alert("휴대폰번호를 입력하여 주세요.");
			$("#htel1").focus();
			return;
		}
		if ($("#htel2").val() == "") {
			alert("휴대폰번호를 입력하여 주세요.");
			$("#htel2").focus();
			return;
		} else if ($("#htel3").val() == "") {
			alert("휴대폰번호를 입력하여 주세요.");
			$("#htel3").focus();
			return;
		}

		var tmpTel = $("#htel1").val() + "-" +  $("#htel2").val() + "-" +  $("#htel3").val();
		regexp = /\d{3}-\d{3,4}-\d{4}/;
		if( tmpTel.replace(/[^\d]/, "") != "" && !regexp.test(tmpTel) ) {
			alert("올바르지 않은 휴대폰 번호입니다.");
			return;
		}

		var ck_num1 = $("#htel1").val();
		var ck_num2 = $("#htel2").val();
		var ck_num3 = $("#htel3").val();
		if( !isNum_es(ck_num1) || !isNum_es(ck_num2) || !isNum_es(ck_num3) ){
			alert("올바르지 않은 휴대폰 번호입니다.");
			return;
		}
	

		var ck_email1 = $("#email1").val();
		var ck_email2 = $("#email2").val();
		if ($("#email1").val() == "" || $("#email2").val() == "") {
			//alert("이메일을 입력해 주세요.");
			//return;
			$("#memEmail").val("");
			$("#emailMod").val("N");
		}else{
			$("#memEmail").val(ck_email1+"@"+ck_email2);
			$("#emailMod").val("Y");
		}
			
		
		if( $("input:checkbox[name=emailYN]:checked").val() == "Y" ){
			$("#memEmailYn").val("Y");
		}
		if( $("input:checkbox[name=smsYN]:checked").val() == "Y" ){
			$("#memSmsYn").val("Y");
		}
		$("#memName").val(user_name);
		$("#memHp").val(tmpTel);

		var ch_yn1 = $("input:checkbox[name=smsYN]:checked").val();
		var ch_yn2 = $("input:checkbox[name=emailYN]:checked").val();
		if(ch_yn1 == "Y"){  
			$("#memSmsYn").val("Y");
		}else{
			$("#memSmsYn").val("N");
		}
		if(ch_yn2 == "Y"){  
			$("#memEmailYn").val("Y");
		}else{
			$("#memEmailYn").val("N");
		}


		$("#registerForm").submit();
	}
}


function isHanEng_es(s) {
	var regExp = /^[가-힣a-zA-Z\s]+$/;
	
	if (!regExp.test(s)) {
		return false;
	} else {
		return true;
	}	
}

function isNum_es(s) {
	var regExp = /^[0-9]+$/;
	
	if (!regExp.test(s)) {
		return false;
	} else {
		return true;
	}	
}


var elmSelect = $('#sel_email');
var elmTarget = $('#email2');

elmSelect.bind('change', null, function() {
	var host = this.value;
	if (host != 'etc' && host != '') {
		elmTarget.attr('readonly', true);
		elmTarget.val(host).change();
	} else if (host == 'etc') {
		elmTarget.attr('readonly', false);
		elmTarget.val('').change();
		elmTarget.focus();
	} else {
		elmTarget.attr('readonly', true);
		elmTarget.val('').change();
	}
});


function viewCont(s) {
	$("#agree_cont"+s).show();
	$("#drop_cont"+s).hide();
}

function viewCont_es(s) {
	$("#drop_cont"+s).show();
	$("#agree_cont"+s).hide();
}

</script>
