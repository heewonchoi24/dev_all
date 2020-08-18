<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=10.000">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width">
	<title>풀무원 회원관리 서비스 회원탈퇴</title>
	<!--link rel="stylesheet" href="/style/common.css"-->
	
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
body{position:relative;width:100%;height:100%;font-family:'dotum';font-size:12px;color:#999;background:#fff;line-height:1.3}
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
#header {position:relative;margin:0px auto;color:#095e37;height:50px;background:#fff;z-index:10}
#header h1 {height:40px;font:bold 18px 'dotum';text-align:center;padding-top:10px;line-height:40px;}
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
h2 {display:inline-block;color:#283e29;font-size:18px;line-height:30px;font-family:'dotum';font-weight:bold;letter-spacing:-1px;margin-bottom:5px}
.textH2 {color:#28323e;font-size:16px;font-family:'dotum';}

/* gnb */
.gnb {width:100%;height:66px;z-index:10}
.gnb li{float:left;height:64px;border-bottom:2px solid #52884e;border-top:2px solid #52884e}
.gnb li a {display:block;height:64px;line-height:64px;background:#fff;color:#585858;font-size:15px;font-family:'dotum';text-align:center;font-weight:bold;letter-spacing:-1px}
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
.gnbDiv3 li {width:50%}
.gnbDiv3 li:first-child {width:50%}
.gnbDiv4 li {width:50%}

/** contentWrap **/
.contentWrap {padding:18px 15px 80px}
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
.boxBasic .btnjoin{position:relative; display: inline-block; width: 95%; font-family: 'dotum'; font-size: 14px; font-weight: bold; letter-spacing: -0.5px;  padding:12px 10px 12px;min-height:24px; background: url(../images/common/arrow.png) no-repeat right;}
.boxBasic .btnjoin a{display: block; font-weight: bold; color:#4c4c4c;}
.boxBasic .btnjoin .green1,.boxBasic .btnjoin .green2{display: inline-block; width: 120px; padding:15px 10px; margin-right:5px; border-radius: 6px; color:#fff; text-align: center;}
.boxBasic .btnjoin .green1{background-color: #b0cc5a; }
.boxBasic .btnjoin .green2{background-color: #52884e; min-height: 80px; }
.boxBasic .btnjoin .green2 img{margin:5px 0px}
.boxBasic .btnjoin .leftBox{float:left; display: inline-block;}
.boxBasic .btnjoin .rightTxt{display: inline-block; vertical-align: middle; min-height: 110px; line-height: 110px;}

/** boxInfo **/
.boxInfo {border:2px solid #e0e0e0;background:#f6f6f6;margin-bottom:10px}
.boxInfo .guide {position:relative;width:100%}
.boxInfo .tl {display:block;position:absolute;top:-2px;left:-2px;width:12px;height:12px;background:url(../images/common/bg_round_corner_info.gif) no-repeat;font-size:0;z-index:1}
.boxInfo .tr {display:block;position:absolute;top:-2px;left:-10px;width:12px;height:12px;margin-left:100%;background:url(../images/common/bg_round_corner_info.gif) 100% 0 no-repeat;font-size:0;z-index:1}
.boxInfo .lb {display:block;position:absolute;top:-10px;left:-2px;width:12px;height:12px;background:url(../images/common/bg_round_corner_info.gif) 0 100% no-repeat;font-size:0}
.boxInfo .rb {display:block;position:absolute;top:-10px;left:-10px;width:12px;height:12px;margin-left:100%;background:url(../images/common/bg_round_corner_info.gif) 100% 100% no-repeat;font-size:0}
.boxInfo .cont_ce {position:relative;color:#333;text-align:center;font-size:15px;padding:34px 0}
.boxInfo .cont_ce span {color:#884501;font-weight:bold}

/* accordion - list */
.accordion {position:relative}
.accordion .title {position:relative;padding:15px;font:normal 15px 'dotum'}
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
.accordion_v .title {position:relative;padding:15px;font:normal 15px 'dotum';color:#333}
.accordion_v .agree_cont {overflow-y:scroll;height:150px;padding:15px;border-top:2px solid #e0e0e0}
.accordion_v .agree_cont strong {display:block;font-weight:bold;font-size:13px;color:#666;margin-bottom:5px}
.accordion_v .agree_cont p {font-weight:normal;font-size:13px;color:#666;margin-bottom:20px}

/* formBasic */
.formBasic {width:100%;table-layout:fixed}
.formBasic th {padding:5px 0px 5px 10px;text-align:left;color:#333;font-weight:normal;border-bottom:2px solid #e0e0e0}
.formBasic td {padding:5px 10px 5px 10px;border-bottom:2px solid #e0e0e0;-ms-word-break:break-all}
.formBasic td p {color:#333;font:normal 15px 'dotum';line-height:24px}
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
.formBasic_in td p {color:#333;font:normal 15px 'dotum';line-height:24px}
.formBasic_in th.none {padding-bottom:0;border-bottom:none}
.formBasic_in td.none {padding-bottom:0;border-bottom:none}
.formBasic_in th.nonepb5 {padding-bottom:5px;border-bottom:none}
.formBasic_in td.nonepb5 {padding-bottom:5px;border-bottom:none}
.formBasic_in tr:last-child td {border-bottom:0}
.formBasic_in tr:last-child th {border-bottom:0}

/* inputStyle */
.inputStyleWrap {position:relative}
.inputStyle_ce {position:relative;text-align:center;font:normal 15px 'dotum';padding:14px 0 12px;min-height:24px}
.inputStyle_ri {position:relative;float:right}
.inputStyle_ce a, .inputStyle_ri a {overflow:hidden}
.btn_check, .btn_radio {color:#4c4c4c;font:normal 15px 'dotum';letter-spacing:-1px}
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
.tbBasic {width:100%;border-top:2px solid #52884e;font:normal 13px 'dotum'}
.tbBasic th {height:44px;/*padding:13px 0;*/vertical-align:middle;background:#eef5ec;color:#283e29;text-align:center;font-weight:normal}
.tbBasic td {height:44px;color:#666;font-size:100%;text-align:center}
.tbBasic td.textL {padding:0 15px;text-align:left}
.tbBasic td.styleBg {background:#f8f8f8;color:#283e29}
.tbBasic th, .tbBasic td {border-right:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0}
.tbBasic th.last, .tbBasic td.last {border-right:0}

/* infoBasic */
.infoBasic {margin-bottom:5px}
.infoBasic li {padding:0 0 8px 10px;background:url('../images/common/bullet_01.png') no-repeat 0 4px;background-size:5px 5px;color:#666;font:normal 13px 'dotum';line-height:100%}

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

.inputInfo {position:relative;display:block;background:url(../images/common/bg_form.png) no-repeat left -98px}
.inputInfo .inner_g {height:36px;border:2px solid #e0e0e0;padding:8px 10px 0px 5px;margin-left:5px}
.inputInfo_id {position:relative;display:block;border:2px solid #e0e0e0;}
.inputInfo_id .inner_g_id {height:36px;border:2px solid #e0e0e0; padding:8px 10px 0px 0px;margin-left:65px}
.inputInfo_pw {position:relative;display:block;background:url(../images/common/bg_form.png) no-repeat left -245px}
.inputInfo_pw .inner_g_pw {height:36px;background:url(../images/common/bg_form.png) no-repeat 100% -147px;padding:8px 10px 0px 0px;margin-left:65px}
.tf_g {position:relative;display:inline-block;height:27px;border:0;padding:0px;border:0px currentColor;color:#666;font:bold 15px 'dotum';z-index:5}

.inputDisable_h {height:auto}
.inputDisable {background:#cacaca no-repeat left 0}
.inputDisable span {display:block;height:44px;color:#666;font:bold 15px 'dotum';line-height:44px;border:2px solid #e0e0e0;padding-left:10px}

/* select box */
.selectBox {display:block;width:100%;height:44px !important;border:2px solid #dadada;border-radius:5px;background:#fff;line-height:44px;font:bold 15px 'dotum';color:#666;padding-left:6px}
.select {display:inline-block;*display:inline;position:relative;width:100%;background:#fff;line-height:normal;vertical-align:middle;*zoom:1}
.select *{margin:0;padding:0;font:bold 15px 'dotum';cursor:pointer}
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
.textarea .tf_inner {width:100%;height:150px;padding:11px 0 11px 8px;border:2px solid #dadada;color:#666;font:bold 15px 'dotum'}
.ipt_check {border: 0px currentColor;width:18px;height:18px}
.ipt_radio {border: 0px currentColor;width:19px;height:19px}

.addressBox {display:block;border:2px solid #dadada;border-radius:5px;background:#fff;margin-top:5px}
.addressBox ul {padding:5px 0 5px 5px}
.addressBox ul li {font:normal 12px 'dotum';margin-bottom:1px;background:none;line-height:17px;color:#4c4c4c}
.addressBox ul li a {color:#4c4c4c;padding;display:block;padding:5px 6px}
.addressBox ul li a:hover {background:#ebebeb;color:#333}
.addressBox ul li a.on {background:#AEAEAE;color:#fff}



/********************************************************************************************************************************************************
	btn, icon 공통작업
*********************************************************************************************************************************************************/
.btnBasic_green {margin:10px 0 0;background:#006600 no-repeat left 0;text-align:center}
.btnBasic_green a {display:block;height:54px;color:#fff;font:bold 18px 'dotum';line-height:54px;background:#006600 no-repeat right -74px}
.btnBasic_gray {background:#cacaca no-repeat left -148px;text-align:center}
.btnBasic_gray a {display:block;height:44px;color:#4c4c4c;font:normal 12px 'dotum';line-height:44px;background:#cacaca no-repeat right -212px}
.btnBasic_grayDisable {background:#cacaca no-repeat left -404px;text-align:center}
.btnBasic_grayDisable span {display:block;height:44px;color:#888;font:normal 12px 'dotum';line-height:44px;background:#cacaca no-repeat right -468px}


.btnIconWrap {margin:5px 0 0 0;text-align:center}
.btnIconWrap li {float:left;width:34.5%}
.btnIconWrap li:first-child {width:31%}
.btnIconWrap li:first-child .btnIcon_gray {margin-left:0}
.btnIcon_gray {position:relative;background:#cacaca no-repeat left -276px;margin-top:5px;text-align:center}
.btnIcon_gray a {display:block;height:44px;color:#4c4c4c;font:normal 15px 'dotum';background:#cacaca no-repeat right -340px}
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
.inputDisable {background:url(../images/common/bg_form.png) no-repeat left 0;}
.inputDisable span {display:block;height:44px;color:#666;font:bold 15px 'dotum';line-height:44px;background:url(../images/common/bg_form.png) no-repeat right -49px}
/*라디오버튼 줄바꿈시 추가*/
.cell_radio2 {height: 24px; padding-top: 10px;text-align:center;}

/* 20150824 추가 */
.cellBtn2 {width: 178px;text-align: right;display: block;padding-left: 0px;padding-top: 5px;letter-spacing: -1px;}
.btninfo_green {color:#ffffff; background:url(../images/btn/btn_info_bg.gif) no-repeat left 0;text-align:center}
.btninfo_green a {display:block;height:15px;color:#ffffff;font:normal 12px 'dotum';line-height:15px;background:url(../images/btn/btn_info_bg.gif) no-repeat}
.accordion .title a.infomation {color:#fff}

/* 레이어팝업 */
	/* UI Object */
	.mw_login{display:none;position:fixed;_position:absolute;top:0;left:0;z-index:10000;width:100%;height:100%}
	.mw_login.open{display:block}
	.mw_login .bg{position:absolute;top:0;left:0;width:100%;height:100%;background:#000;opacity:.5;filter:alpha(opacity=50)}
	.modal{position:absolute;top:50%;left:50%;width:300px;margin:-120px 0 0 -180px;padding:28px 28px 0 28px;border:2px solid #555;background:#fff;font-size:12px;font-family:Tahoma, Geneva, sans-serif;color:#767676;line-height:normal;white-space:normal}
	.modal .btn_login{margin:0 4px 0 0;background-position:left top}
	.modal .close{overflow:visible;position:absolute;top:0;right:0;width:25px;height:25px;padding:0;border:0;background:transparent;font:11px/25px Verdana, Geneva, sans-serif;color:#ccc;text-align:center;text-decoration:none !important;cursor:pointer}
	.modal{border: 2px solid #555555;}
	.modal p{text-align: center;}
	.btn_box{text-align: center; margin-bottom:30px; margin-top:20px;}
	.yes,.no{display: inline-block; border-radius: 3px; height:26px; width: 95px; padding-top:8px; }
	.yes a,.no a{display: block; font-size:14px; font-weight:bold; color:#fff; text-decoration:none;}
	.yes{background-color: #408b38;  border:1px solid #306e29;}
	.no{background-color: #606060;  border:1px solid #306e29;}
	/* //UI Object */
		
	@media all and (min-width:600px){
		.modal{position:absolute;top:50%;left:50%;width:500px;margin:-150px 0 0 -280px;padding:28px 28px 0 28px;border:2px solid #555;background:#fff;font-size:16px;}
		.btn_box{text-align: center; margin-bottom:50px; margin-top:30px;}
		.yes,.no{height:30px; width:120px; padding-top:8px;}
		.yes a,.no a{font-size:16x; font-weight:bold; color:#fff; text-decoration:none;}
		.modal .close{font-size:16px; top:10px; right:10px; }
	}

/*마케팅 재동의 버튼 16-12-22*/
.m_table {margin:5px !important}
/*마케팅 재동의 버튼 16-12-22*/
.btnBasic_gray_in {background:url(/images/btn/btn_bg.gif) no-repeat left -562px;text-align:center}
.btnBasic_gray_in a {display:block;height:30px;color:#4c4c4c;font:normal 12px 'dotum';line-height:30px;background:url(/images/btn/btn_bg.gif) no-repeat right -612px}

/*공지사항 페이지*/
.preparation_wrap {position:relative;width:100%;height:300px;vertical-align:middle;margin:0 auto}
.preparation_box {position:absolute;display:inline-block;left:50%;top:50%; width:300px;height:200px;margin-top:-100px;margin-left:-150px}
.ico_preparation {display:block;height:80px;background:url('../images/ico/ico_working.png') no-repeat center 0;vertical-align:middle;text-indent:-9999px}
.preparation_box p {padding-top:15px;color:#999;font-size:20px;line-height:36px;text-align:center;letter-spacing:-1px}
.preparation_box p span {display:block;font-size:17px;letter-spacing:0}
</style>
	<script src="/js/jquery-1.11.0.min.js"></script>
	<script src="/js/pmo_common.js"></script>
	  	
	<!-- selectBox -->	 
	<script src="/js/selectBox.js"></script>
	<script src="/js/jquery-latest.js"></script>
	<!-- 구글 스크립트 외 공통 스크립트 -->		
	

<script type="text/javascript">
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
	
	ga('create', 'UA-61938491-1', 'auto',{
		'allowLinker':true
	});

	ga('require','linker');
	ga('linker:autoLink',['pulmuoneshop.co.kr','orga.co.kr','pulmuoneamio.co.kr','eatsslim.co.kr','babymeal.co.kr','greenjuice.co.kr','pulmuoneha.com']);
	ga('set', 'dimension1', '0002400000');
	ga('set', 'dimension2', 'https://member.pulmuone.co.kr/customer/custModify_R1.jsp?siteno=0002400000&_ga=2.173170278.473100592.1514941314-192977463.1504158895');	
	ga('send', 'pageview', 'custSecede_R1.jsp');
</script>
	<script type="text/javascript">
	<!--
		$(function(){
			$("#mh7").attr('class', 'on');	
		});
	-->
	</script>

	<script type="text/javascript">
	<!--
	
		function secedeFnc()
		{
			if(confirm('정말로 탈퇴하시겠습니까?'))
			{
				$("#registerForm").submit();
			}
		}
		

		function secedeType1(cod)
		{
			$("#secedeType").val(cod);
		}
		
	-->
	</script>
	

<script type="text/javascript">
//$(document).ready(function() {
$(window).load(function() {
		$.ajax({
			url : "/customer/loginCheck_Ajax.jsp",
			type : "POST",
			data : "",
			contentType : "application/xml; charset=utf-8",
			dataType : "xml",
			async : false,
			beforeSend : function() {			
			},
			success : function(object) {
				var item 	= object.getElementsByTagName("data")[0];
				var status 	= item.getElementsByTagName('status')[0].firstChild.nodeValue;	
				
				if(status == 500)
				{
					alert('로그인 정보가 없습니다.\n확인 후 다시 시도하십시오.');
					location.href='/customer/login_R1.jsp?siteno=0002400000';
					return;
				}
			},
			error : function(request, status, error) {
				return "505";
			},
			complete : function() {			
			}
		});
});
</script><!-- 로그인 체크 -->
</head>

<body>
<div id="wrap">
	<div id="container_web">
		<!-- header -->

		<!-- skipnavigation -->
		<div id="skipnavigation">
			<h3>메뉴 건너뛰기</h3>
			<a href="#skip_content">본문으로 바로가기</a>
		</div>
		<!-- //skipnavigation -->

		<!-- header -->
		<div id="header">
			<h1>잇슬림 회원관리 서비스</h1>
		</div>
		<!-- //header -->

		<!-- gnb -->
		<div class="gnb gnbDiv3">
			<ul class="clfix">
				<li id="mh5"><a href="/customer/custModify.jsp?siteno=0002400000">정보수정</a></li>
				<li class="on" id="mh7"><a href="/customer/custSecede.jsp?siteno=0002400000">잇슬림 회원 탈퇴</a></li>
			</ul>
		</div>
		<!-- //gnb -->		

	    <!-- //header -->


		<!-- content -->
		<div id="content">
			<a href="#none" id="skip_content"></a>
<div id="lastPostsLoader" style="display:none;" class="loading"><p style="position:absolute; left:45%; top:45%; margin:-25px 0 0 -25px;"><img src="/images/common/loading_txt.gif" alt="loading" /></p></div>
<form name="registerForm" id="registerForm" method="post" action="/customer/custSecede_Proc.jsp">
<input type="hidden" name="siteno" id="siteno" value="0002400000">			
<input type="hidden" name="secedeType" id="secedeType" value="88">
			<div class="contentWrap">
				<!-- boxBasic -->
				<div class="boxBasic">
					<div class="guide"><span class="tl"></span><span class="tr"></span></div>
					<!-- boxContents -->
					<table class="formBasic">
						<caption>기본정보 입력</caption>
						<colgroup>
						</colgroup>
						<tbody>

						<tr>
							<td>
								<p>탈퇴사유</p>
								<!-- select -->
								<div class="select">
									<span class="ctrl"><span class="arrow"></span></span>
									<button type="button" class="my_value" id="deregSe">선 택</button>
									<ul class="a_list">
									<li><a href="#none" onclick="secedeType1('88');">선 택</a></li>
									<li><a href="#none" onclick="secedeType1('01');">상품 불만족</a></li>
									<li><a href="#none" onclick="secedeType1('02');">실질적 혜택 부족</a></li>
									<li><a href="#none" onclick="secedeType1('03');">배송 불만족</a></li>
									<li><a href="#none" onclick="secedeType1('04');">개인정보 유출 우려</a></li>
									<li><a href="#none" onclick="secedeType1('05');">교환/반품/환불 불만</a></li>
									<li><a href="#none" onclick="secedeType1('06');">불친절(고객응대)</a></li>
									<li><a href="#none" onclick="secedeType1('07');">기타</a></li>
									</ul>									
								</div>
								
								<!-- //select -->
							</td>
						</tr>
						<tr>
							<td>
								<p>기타사유</p>
								<!-- textarea -->
								<div class="textarea">								
									<textarea name="etcSecede" id="etcSecede" required="" placeholder="내용을 입력하세요." cols="90" rows="5" class="tf_inner"></textarea>
								</div>
								<!-- //textarea -->
							</td>
						</tr>
						</tbody>
					</table>
					<!-- //boxContents -->
					<div class="guide"><span class="lb"></span><span class="rb"></span></div>
				</div>
				<!-- //boxBasic -->

				<!-- button -->
				<div class="btnBasic_green">
					<a href="#none" onClick="secedeFnc(this);">탈퇴</a>	
				</div>	
				<!-- //button -->
			</div>
</form>
			<!-- footer -->

			<div id="footer" >    
				<!-- // 퀵메뉴 끝 -->
				<!--div class="link">
					<a href="/customer/sec_R1.jsp?siteno=0002400000">회원이용약관</a>
					<span>|</span>
					<a href="/customer/sec_R2.jsp?siteno=0002400000">개인정보취급(처리)방침</a>
				</div-->
				<address>
					<p><strong>주소</strong> 서울 강남구 수서동 724</p>
					<p><strong>고객기쁨센터</strong><a href="tel:080-022-0085" onclick="javascript:scardm.ad.cresendo.fire('12');">080-800-0434</a></p>
					<p class="copyright">Copyright ⓒ Pulmuone. All Rights Reserved.</p>
				</address>
				<a href="javascript:window.scrollTo(0,0);" class="top"><img src="../images/btn/top.png" alt="페이지위로" style="width:65px"></a>
			</div>	
			<!-- //footer -->	
		</div>
		<!-- //content -->
	</div>
</div>


</body>
</html>