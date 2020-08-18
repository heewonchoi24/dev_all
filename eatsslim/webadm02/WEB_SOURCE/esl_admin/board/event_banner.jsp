<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%viewPage    = true;%>
<%@ taglib uri="/WEB-INF/FCKeditor.tld" prefix="FCK" %>
<%@ include file="../include/inc-top.jsp"%>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <%@ include file="../include/inc-cal-script.jsp" %>
	<script type="text/javascript" src="../js/sub.js"></script>
	<script type="text/javascript" src="../js/left.js"></script>
    <script type="text/javascript">
    //<![CDATA[
    $(function(){
        $('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
        $('#lnb').menuModel2({hightLight:{level_1:7,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
		leftcon();
    })
    //]]>
    </script>
    <link rel="stylesheet" type="text/css" href="/common/js/_calendars/jquery.datepick.layer.css" />
    <script type="text/javascript" src="/common/js/_calendars/jquery.datepick.js"></script>
    <script type="text/javascript" src="/common/js/_calendars/jquery.datepick-ko.js"></script>

<%
request.setCharacterEncoding("euc-kr");

String query                = "";
String topImgFile            = "";
String topFirstUrl            = "";
String topFirstBgcolor        = "";
String topSecondUrl            = "";
String topSecondBgcolor        = "";

String leftFirstImgFile        = "";
String leftFirstUrl            = "";
String leftSecondImgFile    = "";
String leftSecondUrl        = "";
String leftThirdImgFile        = "";
String leftThirdUrl            = "";

String topBannerOpenYn        = "";
String leftBannerOpenYn        = "";

String topBannerType        = "";
String leftBannerType        = "";

query        = "SELECT TOP_IMGFILE, TOP_FIRST_URL, TOP_FIRST_BGCOLOR, TOP_SECOND_URL, TOP_SECOND_BGCOLOR, LEFT_FIRST_IMGFILE, LEFT_FIRST_URL, LEFT_SECOND_IMGFILE, LEFT_SECOND_URL, LEFT_THIRD_IMGFILE, LEFT_THIRD_URL, TOP_BANNER_OPEN_YN, LEFT_BANNER_OPEN_YN, TOP_BANNER_TYPE, LEFT_BANNER_TYPE ";
query        += " FROM ESL_MAIN_BANNER ";
query        += " WHERE ID = 1";
pstmt        = conn.prepareStatement(query);
rs            = pstmt.executeQuery();

if (rs.next()) {
    topImgFile            = (rs.getString("TOP_IMGFILE") == null)? "" : rs.getString("TOP_IMGFILE");
    topFirstUrl            = (rs.getString("TOP_FIRST_URL") == null)? "" : rs.getString("TOP_FIRST_URL");
    topFirstBgcolor        = (rs.getString("TOP_FIRST_BGCOLOR") == null)? "" : rs.getString("TOP_FIRST_BGCOLOR");
    topSecondUrl        = (rs.getString("TOP_SECOND_URL") == null)? "" : rs.getString("TOP_SECOND_URL");
    topSecondBgcolor    = (rs.getString("TOP_SECOND_BGCOLOR") == null)? "" : rs.getString("TOP_SECOND_BGCOLOR");
    leftFirstImgFile    = (rs.getString("LEFT_FIRST_IMGFILE") == null)? "" : rs.getString("LEFT_FIRST_IMGFILE");
    leftFirstUrl        = (rs.getString("LEFT_FIRST_URL") == null)? "" : rs.getString("LEFT_FIRST_URL");
    leftSecondImgFile    = (rs.getString("LEFT_SECOND_IMGFILE") == null)? "" : rs.getString("LEFT_SECOND_IMGFILE");
    leftSecondUrl        = (rs.getString("LEFT_SECOND_URL") == null)? "" : rs.getString("LEFT_SECOND_URL");
    leftThirdImgFile    = (rs.getString("LEFT_THIRD_IMGFILE") == null)? "" : rs.getString("LEFT_THIRD_IMGFILE");
    leftThirdUrl        = (rs.getString("LEFT_THIRD_URL") == null)? "" : rs.getString("LEFT_THIRD_URL");
    topBannerType        = (rs.getString("TOP_BANNER_TYPE") == null)? "" : rs.getString("TOP_BANNER_TYPE");
    leftBannerType        = (rs.getString("LEFT_BANNER_TYPE") == null)? "" : rs.getString("LEFT_BANNER_TYPE");
}
%>
</head>
<body>
<div style="display: none;">
    <img id="calImg" src="/images/calendar.png" alt="Popup" class="trigger" style="vertical-align:middle;" />
</div>
<!-- wrap -->
<div id="wrap">
    <%@ include file="../include/inc-header.jsp" %>
    <!-- container -->
    <div id="container" class="group">
        <%@ include file="../include/inc-sidebar-board.jsp" %>
        <!-- incon -->
        <div id="incon">
            <!-- location -->
            <div id="location">
                <div class="bgright_location"></div>
                <%@ include file="../include/inc-header-location.jsp" %>
                <p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 프로모션관리 &gt; <strong>고정배너관리</strong></p>
            </div>
            <!-- //location -->
            <!-- contents -->
            <form name="frm_write" id="frm_write" method="post" action="event_banner_db.jsp" enctype="multipart/form-data">
                <input type="hidden" name="mode" id="mode" value="upd"/>
                <input type="hidden" name="top_banner_open_yn" id="top_banner_open_yn" />
                <input type="hidden" name="left_banner_open_yn" id="left_banner_open_yn" />
                <div id="contents">
                    <div class="select_style">
                        <input type="radio" name="top_banner" id="top_type1" value="top_type1">
                        <label for="top_type1">상단 1단 배너</label>
                        <input type="radio" name="top_banner" id="top_type2" value="top_type2">
                        <label for="top_type2">상단 2단 배너</label>
                        <input type="radio" name="top_banner" id="top_type3" value="top_type3">
                        <label for="top_type3">상단 배너 없음</label>
                        <span class="text">규격사이즈: 1100 X 100px</span>
                    </div>
                    <div class="imgFileUpload wide">
                        <div class="button">
                            <div class="uploadBtn disabled">
                                <input type="file" id="top_imgFile" name="top_imgFile" value="<%=topImgFile%>" autocomplete="off" onchange="imgUpload.insertImg(this);" />
                                Browser
                            </div>
                            <button type="button" class="delBtn" onclick="imgUpload.deleteImg(1, 'top_imgFile', '<%=topImgFile%>');">Del</button>
                        </div>
                    </div>
                    <ul class="banner_link">
                        <li>
                            <span class="tit">URL : </span><input type="text" class="input1" style="width:400px;" name="top_first_url" id="top_first_url" value="<%=topFirstUrl%>" />
                            <span class="tit">BG COLOR : </span><input type="text" class="input1" style="width:100px;" name="top_first_bgcolor" id="top_first_bgcolor" value="<%=topFirstBgcolor%>" onchange="colorView(this);" />
                            <span class="colorLabel" style="background-color: <%=topFirstBgcolor%>;"></span>
                        </li>
                        <li>
                            <span class="tit">URL : </span><input type="text" class="input1" style="width:400px;" name="top_second_url" id="top_second_url" value="<%=topSecondUrl%>" disabled="" />
                            <span class="tit">BG COLOR : </span><input type="text" class="input1" style="width:100px;" name="top_second_bgcolor" id="top_second_bgcolor" value="<%=topSecondBgcolor%>" onchange="colorView(this);" disabled="" />
                            <span class="colorLabel" style="background-color: <%=topSecondBgcolor%>;"></span>
                        </li>
                    </ul>
                    <br/><br/><br/><br/><br/>
                    <div class="select_style">
                        <input type="radio" name="left_banner" id="left_type1" value="left_type1">
                        <label for="left_type1">좌측 배너 1개 활성화</label>
                        <input type="radio" name="left_banner" id="left_type2" value="left_type2">
                        <label for="left_type2">좌측 배너 2개 활성화</label>
                        <input type="radio" name="left_banner" id="left_type3" value="left_type3">
                        <label for="left_type3">좌측 배너 3개 활성화</label>
                        <input type="radio" name="left_banner" id="left_type4" value="left_type4">
                        <label for="left_type4">좌측 배너 없음</label>
                        <span class="text">규격사이즈: 100 X 175px</span>
                    </div>
                    <ul class="banner_list">
                        <li>
                            <div class="imgFileUpload normal normal1" >
                                <div class="button">
                                    <div class="uploadBtn">
                                        <input type="file" name="left_first_imgFile" id="left_first_imgFile" value="<%=leftFirstImgFile%>" autocomplete="off" onchange="imgUpload.insertImg(this);">
                                        Browser
                                    </div>
                                    <button type="button" class="delBtn" onclick="imgUpload.deleteImg(2, 'left_first_imgFile', '<%=leftFirstImgFile%>');">Del</button>
                                </div>
                            </div>
                            <input type="text" class="input1" style="width:100%;" name="left_first_url" id="left_first_url" value="<%=leftFirstUrl%>"  />
                        </li>
                        <li>
                            <div class="imgFileUpload normal normal2" >
                                <div class="button">
                                    <div class="uploadBtn disabled">
                                        <input type="file" name="left_second_imgFile" id="left_second_imgFile" value="<%=leftSecondImgFile%>" autocomplete="off" onchange="imgUpload.insertImg(this);" disabled="" />
                                        Browser
                                    </div>
                                    <button type="button" class="delBtn" onclick="imgUpload.deleteImg(3, 'left_second_imgFile', '<%=leftSecondImgFile%>');">Del</button>
                                </div>
                            </div>
                            <input type="text" class="input1" style="width:100%;" name="left_second_url" id="left_second_url" value="<%=leftSecondUrl%>" disabled="" />
                        </li>
                        <li>
                            <div class="imgFileUpload normal normal3" >
                                <div class="button">
                                    <div class="uploadBtn disabled">
                                        <input type="file" name="left_third_imgFile" id="left_third_imgFile" value="<%=leftThirdImgFile%>" autocomplete="off" onchange="imgUpload.insertImg(this);" disabled="" />
                                        Browser
                                    </div>
                                    <button type="button" class="delBtn" onclick="imgUpload.deleteImg(4, 'left_third_imgFile', '<%=leftThirdImgFile%>');">Del</button>
                                </div>
                            </div>
                            <input type="text" class="input1" style="width:100%;" name="left_third_url" id="left_third_url" value="<%=leftThirdUrl%>" disabled="" />
                        </li>
                    </ul>
                    <center><input style="margin-top:10px;" onclick="saveBanner();" type="button" value="저장"></center>
                </div>
                <!-- //contents -->
            </form>
        </div>
        <!-- //incon -->
    </div>
    <!-- //container -->
</div>
<!-- //wrap -->
<script type="text/javascript">
var topBannerType = "<%=topBannerType%>";
var leftBannerType = "<%=leftBannerType%>";
var topImgFile = "<%=topImgFile%>";
var leftFirstImgFile = "<%=leftFirstImgFile%>";
var leftSecondImgFile = "<%=leftSecondImgFile%>";
var leftThirdImgFile = "<%=leftThirdImgFile%>";
var topFirstBgcolor = "<%=topFirstBgcolor%>";
var topSecondBgcolor = "<%=topSecondBgcolor%>";

$(document).ready(function() {

    $("input[name=top_banner][value=" + topBannerType + "]").attr("checked", true);// 상단 배너 타입
    if(topBannerType == $("#top_type1").val()){// 상단 배너 타입에 따른 disabled 처리
        $('.banner_link li').eq(0).find('input').prop('disabled', false);
        $('.banner_link li').eq(1).find('input').prop('disabled', true);
		$('.wide').find('.button').find('.uploadBtn').removeClass('disabled');
		$('.wide').find('.button').find('.uploadBtn').find('input').prop('disabled', false);

    }else if(topBannerType == $("#top_type2").val()){
        $('.banner_link li').eq(0).find('input').prop('disabled', false);
        $('.banner_link li').eq(1).find('input').prop('disabled', false);
		$('.wide').find('.button').find('.uploadBtn').removeClass('disabled');
		$('.wide').find('.button').find('.uploadBtn').find('input').prop('disabled', false);

    }else if(topBannerType == $("#top_type3").val()){
        $('.banner_link li').eq(0).find('input').prop('disabled', true);
        $('.banner_link li').eq(1).find('input').prop('disabled', true);
		$('.wide').find('.button').find('.uploadBtn').addClass('disabled');
		$('.wide').find('.button').find('.uploadBtn').find('input').prop('disabled', true);
    }

    $("input[name=left_banner][value=" + leftBannerType + "]").attr("checked", true);// 좌측 배너 타입
    if(leftBannerType == $("#left_type1").val()){// 좌측 배너 타입에 따른 disabled 처리
        $('.banner_list li').eq(0).find('input').prop('disabled', false);
        $('.banner_list li').eq(1).find('input').prop('disabled', true);
        $('.banner_list li').eq(2).find('input').prop('disabled', true);
        $('.banner_list li').eq(0).find('.uploadBtn').removeClass('disabled');
        $('.banner_list li').eq(1).find('.uploadBtn').addClass('disabled');
        $('.banner_list li').eq(2).find('.uploadBtn').addClass('disabled');
    }else if(leftBannerType == $("#left_type2").val()){
        $('.banner_list li').eq(0).find('input').prop('disabled', false);
        $('.banner_list li').eq(1).find('input').prop('disabled', false);
        $('.banner_list li').eq(2).find('input').prop('disabled', true);
        $('.banner_list li').eq(0).find('.uploadBtn').removeClass('disabled');
        $('.banner_list li').eq(1).find('.uploadBtn').removeClass('disabled');
        $('.banner_list li').eq(2).find('.uploadBtn').addClass('disabled');
    }else if(leftBannerType == $("#left_type3").val()){
        $('.banner_list li').eq(0).find('input').prop('disabled', false);
        $('.banner_list li').eq(1).find('input').prop('disabled', false);
        $('.banner_list li').eq(2).find('input').prop('disabled', false);
        $('.banner_list li').eq(0).find('.uploadBtn').removeClass('disabled');
        $('.banner_list li').eq(1).find('.uploadBtn').removeClass('disabled');
        $('.banner_list li').eq(2).find('.uploadBtn').removeClass('disabled');
    }else if(leftBannerType == $("#left_type4").val()){
        $('.banner_list li').eq(0).find('input').prop('disabled', true);
        $('.banner_list li').eq(1).find('input').prop('disabled', true);
        $('.banner_list li').eq(2).find('input').prop('disabled', true);
        $('.banner_list li').eq(0).find('.uploadBtn').addClass('disabled');
        $('.banner_list li').eq(1).find('.uploadBtn').addClass('disabled');
        $('.banner_list li').eq(2).find('.uploadBtn').addClass('disabled');
    }

    if(topImgFile != ""){// 상당 배너 이미지 미리보기
       var img = '<div class="img"><img src=/data/promotion/'+ topImgFile+'></div>';
       $('.wide').prepend(img);
    }
    if(leftFirstImgFile != ""){//좌측 배너1 이미지 미리보기
       var img = '<div class="img"><img src=/data/promotion/'+ leftFirstImgFile+'></div>';
	   $(".normal1").prepend(img);
    }
    if(leftSecondImgFile != ""){// 상당 배너2 이미지 미리보기
       var img = '<div class="img"><img src=/data/promotion/'+ leftSecondImgFile+'></div>';
		$(".normal2").prepend(img);
    }
    if(leftThirdImgFile != ""){// 상당 배너3 이미지 미리보기
       var img = '<div class="img"><img src=/data/promotion/'+ leftThirdImgFile+'></div>';
		 $(".normal3").prepend(img);
    }
    if(topFirstBgcolor != ""){// 상당 BG COLOR1
		t = $('#top_first_bgcolor');
		colorView(t);
    }
    if(topSecondBgcolor != ""){// 상당 BG COLOR2
		t = $('#top_second_bgcolor');
		colorView(t);
    }


    $("input[name='top_banner']").change(function(e) {
        if($(this).is('#top_type1')){
            $('.banner_link li').eq(0).find('input').prop('disabled', false);
            $('.banner_link li').eq(1).find('input').prop('disabled', true);
			$('.wide').find('.button').find('.uploadBtn').removeClass('disabled');
			$('.wide').find('.button').find('.uploadBtn').find('input').prop('disabled', false);

        }else if($(this).is('#top_type2')){
            $('.banner_link li').eq(0).find('input').prop('disabled', false);
            $('.banner_link li').eq(1).find('input').prop('disabled', false);
			$('.wide').find('.button').find('.uploadBtn').removeClass('disabled');
			$('.wide').find('.button').find('.uploadBtn').find('input').prop('disabled', false);

        }else if($(this).is('#top_type3')){
            $('.banner_link li').eq(0).find('input').prop('disabled', true);
            $('.banner_link li').eq(1).find('input').prop('disabled', true);
			$('.wide').find('.button').find('.uploadBtn').addClass('disabled');
			$('.wide').find('.button').find('.uploadBtn').find('input').prop('disabled', true);

        }
    });

    $("input[name='left_banner']").change(function(e) {
        if($(this).is('#left_type1')){
            $('.banner_list li').eq(0).find('input').prop('disabled', false);
            $('.banner_list li').eq(1).find('input').prop('disabled', true);
            $('.banner_list li').eq(2).find('input').prop('disabled', true);
            $('.banner_list li').eq(0).find('.uploadBtn').removeClass('disabled');
            $('.banner_list li').eq(1).find('.uploadBtn').addClass('disabled');
            $('.banner_list li').eq(2).find('.uploadBtn').addClass('disabled');
        }else if($(this).is('#left_type2')){
            $('.banner_list li').eq(0).find('input').prop('disabled', false);
            $('.banner_list li').eq(1).find('input').prop('disabled', false);
            $('.banner_list li').eq(2).find('input').prop('disabled', true);
            $('.banner_list li').eq(0).find('.uploadBtn').removeClass('disabled');
            $('.banner_list li').eq(1).find('.uploadBtn').removeClass('disabled');
            $('.banner_list li').eq(2).find('.uploadBtn').addClass('disabled');
        }else if($(this).is('#left_type3')){
            $('.banner_list li').eq(0).find('input').prop('disabled', false);
            $('.banner_list li').eq(1).find('input').prop('disabled', false);
            $('.banner_list li').eq(2).find('input').prop('disabled', false);
            $('.banner_list li').eq(0).find('.uploadBtn').removeClass('disabled');
            $('.banner_list li').eq(1).find('.uploadBtn').removeClass('disabled');
            $('.banner_list li').eq(2).find('.uploadBtn').removeClass('disabled');
        }else if($(this).is('#left_type4')){
            $('.banner_list li').eq(0).find('input').prop('disabled', true);
            $('.banner_list li').eq(1).find('input').prop('disabled', true);
            $('.banner_list li').eq(2).find('input').prop('disabled', true);
            $('.banner_list li').eq(0).find('.uploadBtn').addClass('disabled');
            $('.banner_list li').eq(1).find('.uploadBtn').addClass('disabled');
            $('.banner_list li').eq(2).find('.uploadBtn').addClass('disabled');
        }
    });

});

var imgUpload = {
    insertImg: function(t) {
        if (t.files && t.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                var img = '<div class="img"><img src="'+e.target.result+'" /></div>';
                $(t).closest('.imgFileUpload').prepend(img);
            }
            reader.readAsDataURL(t.files[0]);
        }
    },
    deleteImg: function(t, imgFileId, imgFileName) {
		//console.log(t);
		//console.log(imgFileId);
		//console.log(imgFileName);
        var r = confirm("삭제 하시겠습니까?");
        if (r) {
			$.ajax({
				type : "POST", //전송방식을 지정한다 (POST,GET)
				url : "event_banner_ajax.jsp?mode=deleteImg&imgFileId="+imgFileId.toUpperCase(),
				error : function(e){
					alert("이미지 삭제실패.");
				},
				success : function(Parse_data){
					alert("이미지가 삭제되었습니다.");
					location.href = "event_banner.jsp";
				}
			});
        }
    }
}

function colorView(t) {
    var colorCode = $(t).val();
    $(t).next(".colorLabel").css({backgroundColor:colorCode})
}

function saveBanner() {// 저장 버튼 클릭 시

    if ($('#top_type3').attr("checked") == "checked") {// 상단 배너 없음 라디오 버튼 체크했을 경우
        $('input[id="top_banner_open_yn"]').val('N');
    }else{
        $('input[id="top_banner_open_yn"]').val('Y');
    }

    if ($('#left_type4').attr("checked") == "checked") {// 좌측 배너 없음 라디오 버튼 체크했을 경우
        $('input[id="left_banner_open_yn"]').val('N');
    }else{
        $('input[id="left_banner_open_yn"]').val('Y');
    }

	/* validation 처리 시작 */
    if ($('#top_type1').attr("checked") == "checked") {// 상단 1단 배너
		if(!$.trim($('#top_first_url').val())){
			alert("링크를 걸어주세요.");
			$('#top_first_url').focus();
			return false;
		}
		if(!$.trim($('#top_first_bgcolor').val())){
			alert("색상을 입력해주세요");
			$('#top_first_bgcolor').focus();
			return false;
		}
    }
    if ($('#top_type2').attr("checked") == "checked") {// 상단 2단 배너
		if(!$.trim($('#top_first_url').val())){
			alert("링크를 걸어주세요.");
			$('#top_first_url').focus();
			return false;
		}
		if(!$.trim($('#top_second_url').val())){
			alert("링크를 걸어주세요.");
			$('#top_second_url').focus();
			return false;
		}
		if(!$.trim($('#top_first_bgcolor').val())){
			alert("색상을 입력해주세요");
			$('#top_first_bgcolor').focus();
			return false;
		}
		if(!$.trim($('#top_second_bgcolor').val())){
			alert("색상을 입력해주세요");
			$('#top_second_bgcolor').focus();
			return false;
		}
    }
    if ($('#left_type1').attr("checked") == "checked") {// 좌측 배너 1개 활성화
		if(!$.trim($('#left_first_url').val())){
			alert("링크를 걸어주세요.");
			$('#left_first_url').focus();
			return false;
		}
    }
    if ($('#left_type2').attr("checked") == "checked") {// 좌측 배너 2개 활성화
		if(!$.trim($('#left_first_url').val())){
			alert("링크를 걸어주세요.");
			$('#left_first_url').focus();
			return false;
		}
		if(!$.trim($('#left_second_url').val())){
			alert("링크를 걸어주세요.");
			$('#left_second_url').focus();
			return false;
		}
    }
    if ($('#left_type3').attr("checked") == "checked") {// 좌측 배너 3개 활성화
		if(!$.trim($('#left_first_url').val())){
			alert("링크를 걸어주세요.");
			$('#left_first_url').focus();
			return false;
		}
		if(!$.trim($('#left_second_url').val())){
			alert("링크를 걸어주세요.");
			$('#left_second_url').focus();
			return false;
		}
		if(!$.trim($('#left_third_url').val())){
			alert("링크를 걸어주세요.");
			$('#left_third_url').focus();
			return false;
		}
    }

    var msg = "저장 하시겠습니까?"
    if(confirm(msg)){
        document.frm_write.submit();
    }
}
</script>

<style type="text/css">
.imgFileUpload { width: 100%; height: 0; padding-bottom: 10%; position: relative; box-sizing: border-box; }
.imgFileUpload:after { content: ''; position: absolute; top: 0; left: 0; z-index: 2; width: 100%; height: 100%; border: 1px solid #ccc; box-sizing: border-box; }
.imgFileUpload.wide { padding-bottom: 6.1%; }
.imgFileUpload.normal { max-width: 100px; padding-bottom: 175px; }
.imgFileUpload .img { width: 100%; height: 100%; position: absolute; z-index: 1; overflow: hidden; text-align: center; }
.imgFileUpload .img img { max-width: 100%; }
.imgFileUpload .img + .button .uploadBtn { display: none; }
.imgFileUpload .img + .button .delBtn { display: block; }
.imgFileUpload .button { position: absolute; bottom: 0; right: 0; z-index: 3; }
.imgFileUpload .uploadBtn { background-color: #333; color: #fff; padding: 0 10px; height: 30px; line-height: 30px; overflow: hidden; cursor: pointer; text-align: center; }
.imgFileUpload .uploadBtn.disabled { background-color: #ccc; }
.imgFileUpload .uploadBtn input { opacity: 0; position: absolute; bottom: 0; right: 0; z-index: 1; width: 100%; height: 100%; cursor: pointer; }
.imgFileUpload .delBtn {  background-color: #333; color: #fff; border: 0; width: 30px; height: 30px; text-align: center; display: none; cursor: pointer; }

.select_style { margin-bottom: 10px; position: relative; overflow: hidden; }
.select_style > * { vertical-align: middle; display: inline-block; }
.select_style  label + input { margin-left: 20px; }
.select_style .text { float: right; }

.banner_link { margin-top: 20px; overflow: hidden; }
.banner_link li { float: left; width: 50%; margin-bottom: 10px; box-sizing: border-box; }
.banner_link li > * { vertical-align: middle; display: inline-block; }
.banner_link .tit { line-height: 30px; margin-right: 10px; }
.banner_link input { padding: 0 10px; height: 30px; line-height: 30px; box-sizing: border-box; }
.banner_link input + .tit { margin-left: 20px; }
.banner_link .colorLabel { width: 30px; height: 30px; display: inline-block; border: 1px solid #ccc; box-sizing: border-box; }

.banner_list { overflow: hidden; margin: -10px; margin-top: 10px; }
.banner_list li { float: left; width: 33.333%; padding: 10px; margin-bottom: 10px; box-sizing: border-box; }
.banner_list input { padding: 0 10px; height: 30px; line-height: 30px; box-sizing: border-box; margin-top: 10px; }
input::-ms-input-placeholder { color: #ccc; }
input::placeholder { color: #ccc; }
</style>

</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>