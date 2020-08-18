<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
		<meta charset="utf-8">
		<meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no, width=device-width">
		<meta name="author" content="oparts">
		<meta name="title" content="STARGRAM ADMIN">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<title>${pageName} | 보건복지 개인정보보호 지원 시스템 Administrator Mode</title>
		<link rel="shortcut icon" href="/images/common/favicon.ico" />
		<link rel="stylesheet" href="/resources/admin/css/kendoUI/kendo.default.min.css" />
		<link rel="stylesheet" href="/resources/admin/css/common.css" />
		<link rel="stylesheet" href="/resources/admin/css/layout.css" />
		<link rel="stylesheet" href="/resources/admin/css/content.css" />
		<link rel="stylesheet" href="/resources/admin/css/bootstrap-datetimepicker.css" type="text/css">
		<link rel="stylesheet" href="/resources/admin/css/content_ys.css" />

		<script src="/resources/admin/js/jquery-1.12.3.min.js"></script>
		<script src="/resources/admin/js/icheck.js"></script>
		<script src="/resources/admin/js/jquery.chkform.js"></script>
		<script src="/resources/admin/js/common.js"></script>
		<script type="text/javascript" src="/resources/admin/js/bootstrap-datetimepicker.min.js"></script>
		<script type="text/javascript" src="/html/egovframework/com/cmm/utl/ckeditor/ckeditor.js"></script>
		<script type="text/javascript" src="/html/egovframework/com/cmm/utl/ckeditor/config.js"></script>
		<script type="text/javascript" src="/smarteditor2-2.10.0/js/service/HuskyEZCreator.js" charset="utf-8"></script>
		<script type="text/javascript" src="/resources/admin/js/ajaxupload.js"></script>
		<script src="/resources/admin/js/kendo.all.min.js"></script>
		<script src="/js/ccmsvc.cmd.js" type="text/javascript"></script>
		<script src="/resources/front/js/jquery.form.min.js" ype="text/javascript"></script>
		<script>
			function fn_util_setTextType(){
			    $('.moneyType').each(function(){
			        if($(this).text().isBlank()){
			            $(this).val($(this).val().money());
			        }else{
			            $(this).text($(this).text().money());
			        }
			    });
			}
		</script>
		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
		<!--[if lt IE 9]>
		<script type='text/javascript' src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
		<script type='text/javascript' src="http://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.js"></script>
		<![endif]-->
    </head>
<body>

<div id="wrap">