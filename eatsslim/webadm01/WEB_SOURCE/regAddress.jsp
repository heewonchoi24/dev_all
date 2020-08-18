<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!-- 배송지주소검색 팝업 -->
<html>
<head>
    <title>배송지주소검색팝업</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="Pragma" content="no-cache">
	
 
	 
	
		
	


<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" >
<meta http-equiv="X-UA-Compatible" content="IE=8"/>
<!-- <meta http-equiv="X-UA-Compatible" content="IE=edge"> -->
 
<!-- ActiveWidgets Module - START -->

	<link rel="stylesheet" type="text/css" href="/scripts/theme/blue/styles/aw.css" ></link>
	<script type="text/javascript" src="/scripts/aw/runtime/lib/aw.js" ></script>
	<script type="text/javascript" src="/scripts/aw/awConfig.js" ></script>
	
<!-- ActiveWidgets Module - END -->

<!-- Common Service - START -->

	<script type="text/javascript" src="/scripts/baseScript.js"></script>
	<script type="text/javascript" src="/scripts/basePopup.js"></script>
	<script type="text/javascript" src="/scripts/commonScript.js"></script>
	<script type="text/javascript" src="/scripts/date.js"></script>
	<script type="text/javascript" src="/scripts/expiredSessionCheck.js"></script>
	
<!-- Common Service - END -->


<!-- YUI Module - START -->

	<!-- Loading Message Display & Panel - START -->
	<link rel="stylesheet" type="text/css" href="/scripts/yui/build/fonts/fonts-min.css" />
	<link rel="stylesheet" type="text/css" href="/scripts/yui/build/container/assets/skins/sam/container.css" />
	<script type="text/javascript" src="/scripts/yui/build/utilities/utilities.js"></script>
	<script type="text/javascript" src="/scripts/yui/build/container/container-min.js"></script>
	<!-- Loading Message Display & Panel - END -->
	
	
    <!-- Tab - START -->
	<link rel="stylesheet" type="text/css" href="/scripts/theme/blue/scripts/yui/build/tabview/assets/skins/sam/tabview.css" />
	<script type="text/javascript" src="/scripts/yui/build/yahoo-dom-event/yahoo-dom-event.js"></script>
	<!-- v2.6 --> 
	<script type="text/javascript" src="/scripts/yui/build/element/element-beta-min.js"></script>
	<!-- v2.7 <script type="text/javascript" src="/scripts/yui/build/element/element-min.js"></script> -->
	<script type="text/javascript" src="/scripts/yui/build/tabview/tabview-min.js"></script>
	<!-- Tab - END -->
	
	<!-- Uploader - START, 2009-05-22 -->
	<!-- v2.6 -->
	<script type="text/javascript" src="/scripts/yui/build/uploader/uploader-experimental.js"></script>
	
	<!-- v2.7 <script type="text/javascript" src="/scripts/yui/build/uploader/uploader.js"></script> -->
	
<!-- YUI Module - END -->

<!-- jQuery - START -->

	<script type="text/javascript" src="/scripts/jquery/jquery-1.8.2.min.js"></script>
	<script type="text/javascript" src="/scripts/jquery/jquery.alphanumeric.js"></script>
	
	<!-- link rel="stylesheet" type="text/css" href="/scripts/jquery/lightbox/css/style-projects-jquery.css" /-->
    <script type="text/javascript" src="/scripts/jquery/lightbox/js/jquery.lightbox-0.5.js"></script>
    <link rel="stylesheet" type="text/css" href="/scripts/jquery/lightbox/css/jquery.lightbox-0.5.css" media="screen" />	
	
	
<!-- jQuery - END -->

<!-- applet - START -->
	<script type="text/javascript" src="/scripts/applet.js"></script>
<!-- applet - END -->

<!-- Program Common Module - START -->

	<link rel="stylesheet" type="text/css" href="/scripts/theme/blue/theme.css" ></link>
	<script type="text/javascript" src="/scripts/formatter.js"></script>
	<script type="text/javascript" src="/scripts/basePopup.js"></script>
	
<!-- Program Common Module - END -->

<!--  FusionCharts - START -->
	<script type="text/javascript" src="/scripts/FusionCharts.js"></script>
<!--  FusionCharts - END -->

<!--  FusionCharts - START -->
	<link rel="stylesheet" type="text/css" href="/scripts/calendar2_ps.css">
<!--  FusionCharts - END -->

<script type="text/javascript">

	
		try{parent.menuTreeToggle();}catch(e){}
	
	try{parent.InitSessionTimer();}catch(e){}
	
	var _contextPath = "";
	
	var partnerDivCD_S = "HQ";
	var salOrgCD_S = "undefined";
	var salOffCD_S = "";
	var prtnrID_S = "";
	var prtnrNm_S = "";
	
	$(function() {
		try{$("form").css("display","inline");}catch(e){}
		
		try{$("#prtnrID").alphanumeric();}catch(e){}
		try{$("#empID").alphanumeric();}catch(e){}
		try{$("#dateFrom").numeric();}catch(e){}
		try{$("#dateTo").numeric();}catch(e){}
		try{$("#faxNo").numeric();}catch(e){}
		try{$("#hpNo").numeric();}catch(e){}
		try{$("#telNo").numeric();}catch(e){}

		try{$("#prtnrID").attr("maxlength","20");}catch(e){}
		try{$("#empID").attr("maxlength","20");}catch(e){}
		try{$("#emailAddr").attr("maxlength","40");}catch(e){}
		try{$("#dateFrom").attr("maxlength","8");}catch(e){}
		try{$("#dateTo").attr("maxlength","8");}catch(e){}
		try{$("#faxNo").attr("maxlength","11");}catch(e){}
		try{$("#hpNo").attr("maxlength","11");}catch(e){}
		try{$("#telNo").attr("maxlength","11");}catch(e){}

		//try{$("#salOffCD").val("");}catch(e){}
		try{$("#prtnrID").val("");}catch(e){}
		try{$("#prtnrNm").val("");}catch(e){}
		
		try{
			if ($("#prtnrID").val() == "") {
				$("#prtnrID").focus();
			}
		}catch(e){}
		
		try {
			if (partnerDivCD_S == 'AC') {
				//try{$("#salOffCD").attr("disabled",true)}catch(e){}
				try{$("#prtnrID").attr("readonly",true)}catch(e){}
				try{$("#prtnrID").addClass("input-readonly")}catch(e){}
				try{$("#prtnrID_popup").hide()}catch(e){}
				try{$("#prtnrID_clear").hide()}catch(e){}
			}else if(partnerDivCD_S == 'BR'){
				//try{$("#salOffCD").attr("disabled",true)}catch(e){}
			}
		}catch(e){}
	});

	document.onkeydown = mykeyhandler;
	function mykeyhandler() {
		//if ((window.event && window.event.keyCode == 123) //F12
		//	|| 
		if ((window.event.srcElement.readOnly && window.event && window.event.keyCode == 8)) { //readonly & backspac
			window.event.cancelBubble = true;
			window.event.returnValue = false;
			return false;
		}
	};
</script>

<!-- DHTML Module - START -->

    <script type="text/javascript" src="/scripts/theme/blue/scripts/dhtml/js/separateFiles/dhtmlSuite-common.js-uncompressed.js"></script>
    <script type="text/javascript" src="/scripts/yui/yui.js"></script>

<!-- DHTML Module - END -->



</head>

    <body class="yui-skin-sam" oncontextmenu='return true'; ondragstart='return true'; onselectstart='return true';>
    	<div id="wrapDiv" class="pd">
    		<div id="formDiv">
				<form name="form" method="post">
		            <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
		                <tr>
		                    <td height="1">
								<!-- Standard Parameter - START -->
								<input type="hidden" id="mnuGrpID" name="mnuGrpID" value="ORD">
								<input type="hidden" id="pgmID" name="pgmID" value="UMSO001">
								<input type="hidden" id="viewID" name="viewID" value="UMSD002A">
								<input type="hidden" id="gmNo"  style="width:100px;">
								<input type="hidden" id="postcode"  style="width:100px;">
								<input type="hidden" id="oldPostcode"  style="width:100px;">
								<input type="hidden" id="address"  style="width:100px;">
								<input type="hidden" id="jibunAddress"  style="width:100px;">
								<input type="hidden" id="data"  style="width:100px;">

								<!-- Standard Information - END -->

								<!-- 베이비밀 SMS 전송 파라미터 -->
								<input type="hidden" id="msgType" name="msgType" style="width: 100px; text-align: center;" value="0"/>
                				<input type="hidden" id="sendPhone" name="sendPhone" style="width: 100px; text-align: center;" value="02-6411-8321"/>
		                		

<div id="btn" style="width:100%;">
	<div id="tit">
		<table class="functionbar-title" width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top" class="tit_text" style="height:30px; width:300px; vertical-align:middle;">
					<img src="/scripts/theme/blue/images/common/tit_point.gif"> 
					
	                    
	                    
	                        배송지주소검색팝업
	                    
	                
                </td>
				<td class="tit_text01" style="text-align:right; padding-right:30px;" id="messagebar">
				</td>
			</tr>
		</table>
	</div>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td style="height:8px;"></td>
		</tr>
		<tr>
			<td align="right">
				
					<script type="text/javascript">
				  	var btnChoice = new AW.UI.Button;
					//btnChoice.setId("Choice");
					btnChoice.setControlText("선택");
					btnChoice.setControlImage("Choice");
					document.write(btnChoice);
					
					btnChoice.onControlClicked = function(event){
						
							
							
								Choice();
							
						
						try{parent.InitSessionTimer();}catch(e){}						
					}
					</script>
				
			</td>
		</tr>
		<tr>
			<td height="2"></td>
		</tr>
	</table>
</div>
		                    </td>
		                </tr>
		                <tr>
							<td height="1">
		                        <table border="0" cellspacing="0" cellpadding="0" width="100%" >
		                            <tr>
		                        	    <td class="group-title" style="font-size: 15px;">
							    			
											
												잇슬림
											
											
						    			</td>
		                        	</tr>
		                    		<tr>
		                    			<td class="tb-border">
		                    			<div id="babymeaml">
											<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
		                                        <tr style="height:30px;">
													<td class="td-cond" width="80">우편번호</td>
													<td class="td-input" width="*" colspan="3">
														<input type="text" id="bmPostcode" style="width:140px; height:25px; font-size:15px;" class="input-readonly" readonly="readonly" onfocus="this.blur()" />
					                                </td>
					                            </tr>
					                            <tr style="height:30px;">
													<td class="td-cond">주소</td>
													<td class="td-input" colspan="3">
				                            			<input type="text" id="bmAddress" style="width:440px; height:25px; font-size:15px;" class="input-readonly" readonly="readonly" onfocus="this.blur()" />
				                                    </td>
					                            </tr>
					                            <tr style="height:30px;">
													<td class="td-cond">상세주소</td>
													<td class="td-input" colspan="3">
				                            			<input type="text" id="bmAddressDt" style="width:440px; height:25px; font-size:15px;">
				                                    </td>
					                            </tr>
					                             <tr style="height:30px;">
		                                            <td class="td-cond"> 패턴 </td>
		                                        	<td class="td-input" >
													   	<input type="text" id="bmSaturdayYn"  name="bmSaturdayYn" class="input-readonly" readonly="readonly"  style="width:140px; height:25px; font-size:15px;" onfocus="this.blur()" />
													   	<input type="hidden" id="bmJisaCd"  name="bmJisaCd" class="input-readonly" readonly="readonly"  style="width:50px; height:25px; font-size:15px;" onfocus="this.blur()"/>
		                                        	</td>
		                                        	 <td class="td-cond"> 배송가능여부 </td>
		                                        	<td class="td-input" >
													   	<input type="text" id="bmDeliveryYn" name="bmDeliveryYn" class="input-readonly" readonly="readonly" style="width:140px; height:25px; font-size:15px;" onfocus="this.blur()" />
													   	<input type="hidden" id="bmJisaNm"  name="bmJisaNm" class="input-readonly" readonly="readonly"  style="width:50px; height:25px; font-size:15px;" onfocus="this.blur()"/>
		                                        	</td>
		                                        </tr>
					                        </table>
					                        </div>

					                        <div id="eatslim">
											<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
		                                       	<tr style="height:30px;">
													<td class="td-cond" width="80">우편번호</td>
													<td class="td-input" width="*" colspan="3">
														<input type="text" id="esPostcode" class="input-readonly" readonly="readonly" style="width:140px; height:25px; font-size:15px;" onfocus="this.blur()" />
					                                </td>
					                            </tr>
					                            <tr style="height:30px;">
													<td class="td-cond" rowspan="2">주소</td>
													<td class="td-input" colspan="3">
				                            			<input type="text" id="esAddress" class="input-readonly" readonly="readonly" style="width:440px; height:25px; font-size:15px;" onfocus="this.blur()" />
				                                    </td>
					                            </tr>
					                            <tr style="height:30px;">
													<td class="td-input" colspan="3">
				                            			<input type="text" id="esAddressDt" style="width:440px; height:25px; font-size:15px;">
				                                    </td>
					                            </tr>
					                            <tr style="height:30px;">
		                                            <td class="td-cond"> 패턴 </td>
		                                        	<td class="td-input" >
													   	<input type="text" id="esSaturdayYn"  name="esSaturdayYn" class="input-readonly" readonly="readonly"  style="width:140px; height:25px; font-size:15px;" onfocus="this.blur()" />
		                                        	</td>
		                                        	 <td class="td-cond"> 배송가능여부 </td>
		                                        	<td class="td-input" >
													   	<input type="text" id="esDeliveryYn" name="esDeliveryYn" class="input-readonly" readonly="readonly" style="width:140px; height:25px; font-size:15px;" onfocus="this.blur()" />
													   	<input type="hidden" id="esJisaCd"  name="esJisaCd" class="input-readonly" readonly="readonly"  style="width:50px; height:25px; font-size:15px;" onfocus="this.blur()"/>
													   	<input type="hidden" id="esJisaNm"  name="esJisaNm" class="input-readonly" readonly="readonly"  style="width:50px; height:25px; font-size:15px;" onfocus="this.blur()"/>
<!-- 														<span id="btneChoice"></span>    -->
		                                        	</td>
		                                        </tr>
					                        </table>
					                        </div>

					                        <div id="fd">
											<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
						                            <colgroup>
														<col style="width:120px"></col>
														<col style="width:230px"></col>
														<col></col>
													</colgroup>
			                                        <tr style="height:30px;">
														<td class="td-cond-cent" >가맹점</td>
														<td class="td-cond-cent" >가맹점주소</td>
														<td class="td-cond-cent" >연락처</td>
						                            </tr>
						                            <tr style="height:30px;">
														<td class="td-input">
					                            			<input type="text" id="fdHomeFranch"  class="input-readonly" readonly="readonly"  style="width:110px; height:25px; font-size:15px;" onfocus="this.blur()" />
					                                    </td>
					                                    <td class="td-input">
					                            			<input type="text" id="fdHomeAddr"  class="input-readonly" readonly="readonly"  style="width:220px; height:25px; font-size:15px;" onfocus="this.blur()" />
					                                    </td>
					                                    <td class="td-input">
					                            			<input type="text" id="fdHomeTel"  class="input-readonly" readonly="readonly"  style="width:170px; height:25px; font-size:15px;" onfocus="this.blur()" />
					                                    </td>
						                            </tr>
						                    </table>
						                    <div class="group-title">
												
						    				</div>
						                    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:#e1dcbe solid 1px; table-layout:fixed;">
						                            <colgroup>
														<col style="width:120px"></col>
														<col style="width:230px"></col>
														<col></col>
													</colgroup>
			                                        <tr style="height:30px;">
														<td class="td-cond-cent" >가맹점</td>
														<td class="td-cond-cent" >가맹점주소</td>
														<td class="td-cond-cent" >연락처</td>
						                            </tr>
						                            <tr style="height:30px;">
														<td class="td-input">
					                            			<input type="text" id="fdOffFranch"  class="input-readonly" readonly="readonly"  style="width:110px; height:25px; font-size:15px;">
					                                    </td>
					                                    <td class="td-input">
					                            			<input type="text" id="fdOffAddr"  class="input-readonly" readonly="readonly"  style="width:220px; height:25px; font-size:15px;">
					                                    </td>
					                                    <td class="td-input">
					                            			<input type="text" id="fdOffTel"  class="input-readonly" readonly="readonly" style="width:170px; height:25px; font-size:15px;">
					                                    </td>
						                            </tr>
						                    </table>
					                        </div>
		                    			</td>
		                   			</tr>

		                   			<tr>
		                   				<td>
			                   				<div id="wrap" style="display:none;border:1px solid;width:540px;height:480px;margin:5px 0;position:relative">
		<!-- 									img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼" -->
											</div>
		                   				</td>
		                   			</tr>
		                   			<tr>
		                   				<td align="right">
				                        		<input type="button" id="dffSearchPost"  style="width:130px; height:25px; font-size:15px;" onfocus="this.blur()" value="장애시 주소검색">
	                                    </td>
					                </tr>
								</table>
		                    </td>
		                </tr>
						<tr>
						    <td class="pd" height="*">
		                    </td>
		                </tr>
		                <tr>
		                    <td height="5">
								<!-- Action Parameter - START -->
								<input type="hidden" name="initAction">
								<!-- Action Parameter - END -->
		                    </td>
		                </tr>
		            </table>
		        </form>
	      	</div>
	    </div>
    </body>
</html>

<!-- grid format -->
<style>
	.aw-grid-control {height: 100%; width: 100%; margin: 0px;}
	.aw-row-selector {text-align: center}

	.aw-column-0 {width: 80px; text-align: center;}
	.aw-column-1 {width: 140px; }
	.aw-column-2 {width: 150px; }
	.aw-column-3 {width: 140px; }

	.aw-grid-cell {border-right: 1px solid threedlightshadow;}
	.aw-grid-row {border-bottom: 1px solid threedlightshadow;}
</style>

<script type="text/javascript">

	// Only ModalDialog
	

	/****************************************
	* Variable
	****************************************/
	var param;

	/****************************************
	* Function
	****************************************/
	$(document).ready(function() {

		window.onload = function() {
			
			Search();

			//var param = "FD";
			param ="ES";

			if(param =="BM"){
				$("#babymeaml").show();
				$("#eatslim").hide();
				$("#fd").hide();
			}else if(param =="ES"){
				$("#babymeaml").hide();
				$("#eatslim").show();
				$("#fd").hide();
			}else if(param =="FD"){
				$("#babymeaml").hide();
				$("#eatslim").hide();
				$("#fd").show();
				$("#wrap").height(470);
			}

		};

		appletDiv_init();

		//배송지 팝업
	    $("#dffSearchPost").click(function(){
	    	openDffPostSearchPopup("closeDffSearchPost");
		});



	});



	/****************************************
	* Button Action
	****************************************/

	//----------- 선택 ------------
	function Choice() {
		
		if(param =="BM"){
			if($("#bmAddressDt").val() == ""){
				alert("상세주소를 입력하십시오.");
				$("#bmAddressDt").focus();
				return;
			}
			
			if($("#bmDeliveryYn").val() == "" || $("#bmDeliveryYn").val() == null){
				alert("가맹점정보가 없습니다. \n관리자에게 문의하십시오. (02-2186-8689)");
				var hp = "010-7206-6245";
				var message = "우편번호 추가 필요건\n";
				message += $("#postcode").val() + " (" +$("#oldPostcode").val() + ")\n";			// 우편번호
				message += $("#address").val() + "\n";			// 주소
				message += "GMNO : " + $("#gmNo").val() + "\n";				// GMNO
				message += "가맹점정보가 없습니다. 등록하시기 바랍니다.";
				$.ajax({
			  		type: "POST",
			  		url: "/service/simpleRest/simpleSerch",
			  		dataType: "json",
			  		data: {
			  			siteCd : "BM",
		      			serviceCd : "SendSMS",
		      			msgType : $("#msgType").val(),			// 메세지 타입
		      			hp : hp,										// 수신 휴대폰번호
		      			msgBody : message,						// 내용
		      			sendPhone : $("#sendPhone").val(),		// 발신 전화번호
		      			sendName : "육성민",	// 발신자 이름
		      			subject : "우편번호",						// 테스트 구분
		      			orderNo : "9999999999999"			// 추가건이기에 로그 필요없음
			  		},

			  		success: function(json) {

			  			var server = json.BM;

			  			$.each(server, function(key){
			  				var info = server[key].info;
			  				$.each(info, function(index){
			  					if(info[0].resultStatus = "SUCCESS"){

			  					}
			  				});
			  			});

			  		},
			  		error: function(e) {

			  			alert('서버와 통신에 실패했습니다.');
			  		}
			  	});
				return;
			}else if($("#bmDeliveryYn").val() == "불가능"){
				alert("배송할 수 없는 지역입니다. 배송지를 변경해주십시오.");
				return;
			}
		}else if(param =="ES"){
			if($("#esAddressDt").val() == ""){
				alert("상세주소를 입력하십시오.");
				$("#esAddressDt").focus();
				return;
			}
			
			if($("#esDeliveryYn").val() == "" || $("#esDeliveryYn").val() == null){
				alert("가맹점정보가 없습니다. \n관리자에게 문의하십시오. (02-2186-8689)");
				return;
				/* var hp = "010-7206-6245";
				var message = "우편번호 추가 필요건\n";
				message += $("#postcode").val() + " (" +$("#oldPostcode").val() + ")\n";			// 우편번호
				message += $("#address").val() + "\n";			// 주소
				message += "GMNO : " + $("#gmNo").val() + "\n";				// GMNO
				message += "가맹점정보가 없습니다. 등록하시기 바랍니다.";
				$.ajax({
			  		type: "POST",
			  		url: "/service/simpleRest/simpleSerch",
			  		dataType: "json",
			  		data: {
			  			siteCd : "BM",
		      			serviceCd : "SendSMS",
		      			msgType : $("#msgType").val(),			// 메세지 타입
		      			hp : "010-7206-6245",					// 수신 휴대폰번호
		      			msgBody : message,						// 내용
		      			sendPhone : $("#sendPhone").val(),		// 발신 전화번호
		      			sendName : "육성민",	// 발신자 이름
		      			subject : "우편번호",						// 테스트 구분
		      			orderNo : "9999999999999"			// 추가건이기에 로그 필요없음
			  		},

			  		success: function(json) {

			  			var server = json.BM;

			  			$.each(server, function(key){
			  				var info = server[key].info;
			  				$.each(info, function(index){
			  					if(info[0].resultStatus = "SUCCESS"){

			  					}
			  				});
			  			});

			  		},
			  		error: function(e) {

			  			alert('서버와 통신에 실패했습니다.');
			  		}
			  	});
				return; */
			}else if($("#esDeliveryYn").val() == "불가능"){
				alert("배송할 수 없는 지역입니다. 배송지를 변경해주십시오.");
				return;
			}
		}
		
		var addressDt = "";
		var bmJisaCd ="";
		var bmJisaNm = "";
		var esJisaCd ="";
		var esJisaNm ="";
			
		if(param =="BM"){
			addressDt = $("#bmAddressDt").val();
			bmJisaCd = $("#bmJisaCd").val();
			bmJisaNm = $("#bmJisaNm").val();
		}else if(param =="ES"){
			addressDt = $("#esAddressDt").val();
			esJisaCd = $("#esJisaCd").val();
			esJisaNm = $("#esJisaNm").val();
		}
				
		var data = {
			"postcode":$("#postcode").val(),
			"oldPostcode":$("#oldPostcode").val(),
			"address":$("#address").val(),
			"jibunAddress":$("#jibunAddress").val(),
			"addressDt": addressDt,
			"bmJisaCd": bmJisaCd,
			"bmJisaNm": bmJisaNm,
     		"esJisaCd": esJisaCd,
			"esJisaNm": esJisaNm, 
			"checkData": $("#data").val()
		};
		
		window.close();

		
			opener.closeRecvZipCDPopup(data);
		

	}

	function closeDffSearchPost(data){

		  document.getElementById('gmNo').value = data.buildingCode;		   //빌딩코드
          document.getElementById('postcode').value = data.zonecode; //5자리 새우편번호 사용
          document.getElementById('oldPostcode').value = data.oldPostcode; //6자리 구우편번호 사용
          document.getElementById('address').value = data.fullAddr;
          document.getElementById('jibunAddress').value = data.jibunAddress;

          //베이비밀
          document.getElementById('bmPostcode').value = data.zonecode; //5자리 새우편번호 사용
          document.getElementById('bmAddress').value = data.fullAddr;
          //잇슬림
          document.getElementById('esPostcode').value = data.zonecode; //5자리 새우편번호 사용
          document.getElementById('esAddress').value = data.fullAddr;

	      //패턴 및 가맹점 조회
	      searchDetail();
	}

	//----------- 조회  ------------
	function Search() {
		sample3_execDaumPostcode();
	}

	//----------- 닫기 ------------
	function Close() {
		window.close();
	}

	function searchDetail(){

		var url;
		var callbk ="json_parse_";
		var data;

		if(param =="BM"){	//베이비밀 패턴 조회
			url = "/service/simpleRest/simpleSerch";
			callbk = callbk+"bm";

			data = {
					siteCd : "BM",
					serviceCd : "SearchDelvAddr",
					gmNo : $('#gmNo').val()
			};

		}else if(param =="ES"){ //잇슬림 패턴 조회

			url = "/service/simpleRest/simpleSerch";
			callbk = callbk+"es";

			data = {
					serviceCd : "SearchEsAddrPrtn",
	      			mode:"R",
	      			modeSeq:"05",
	      			schGmNo : $('#gmNo').val()
			};

		}else if(param =="FD"){	//녹즙 가맹점 조회

			url = "/service/simpleRest/simpleSerch";
			callbk = callbk+"fd";

			data = {
					serviceCd : "SearchAddrPrtn",
	      			mode:"R",
	      			modeSeq:"03",
	      			postNo : $('#postcode').val()
			};
		}

		//Ajax 호출
		doAjax(data, url, callbk);
	}

	//Ajax 호출
	function doAjax(data, url, callbk){

		$.ajax({
			type: "POST",
		  	url: url,
		  	dataType: "json",
		  	data: data,
	  		success: function(json) {

	  			eval(callbk+"(json)");
	  		},
	  		error: function(e) {
	  			alert('서버와 통신에 실패했습니다.');
	  		}
	  	});
	}

	//베이비밀 ajax success 콜백
	function json_parse_bm(json){

		var server = json.BM;
		$.each(server, function(key){
			var item = server[key].items;
			var info = server[key].info;
			var totalCount = info[0].count;
			if(totalCount> 0) {
				$.each(item, function(index){
					$("#bmSaturdayYn").val(item[index].saturDayYnTxt);
					$//("#bmDeliveryYn").val(item[index].deliveryYnTxt);
					if(item[index].deliveryYnTxt=="가능" && item[index].jisaNm != null){		//배달가능여부 가능일시 가맹점명 표시
						$("#bmDeliveryYn").val(item[index].jisaNm);
					}else{
						$("#bmDeliveryYn").val(item[index].deliveryYnTxt);
					}
					$("#bmJisaCd").val(item[index].jisaCd);
					$("#bmJisaNm").val(item[index].jisaNm);
				});
			}else{
		   		$("#bmSaturdayYn").val("");
		  		$("#bmDeliveryYn").val("");
		  		$("#bmJisaCd").val("");
				$("#bmJisaNm").val("");
		   	}
		});
	}

	//잇슬림 ajax success 콜백
	function json_parse_es(json){

		var devltype = "";
		var devlPtnCd = "";
		var devltype1 = "";
		var devltype2 = "";
		var data = new Array();
	   	var json = json.UM;
			var totalCount = json[0].info[0].count;

		var checkData = "";
	   	if(totalCount > 0) {
			$.each(json, function(key){
				var jsonVal = json[key].items;
				$.each( jsonVal , function(index) {

			            devltype = jsonVal[index].deliveryYn;
			            devlPtnCd = jsonVal[index].saturdayYn;

			            if (devltype =="Y") {

			   			   if ( devlPtnCd =="Y" ) {
			   				  devltype1	= "O";
			   				  devltype2	= "O";
			   			   } else {
			   				  devltype1	= "X";
			   				  devltype2	= "O";
			   			   }
			   		    } else {
			   			   devltype1	= "X";
			   			   devltype2	= "X";
			   		    }


			            checkData = jsonVal[index].zipCd +  "|" +
			                        jsonVal[index].sidoNm + "|" +
			                        jsonVal[index].sigunguNm + "|" +
			                        jsonVal[index].gmBonNo + "|" +
			                        jsonVal[index].gmBuNo + "|" +
			                        jsonVal[index].gbBonNo + "|" +
			                        jsonVal[index].gbBuNo + "|" +
			                        jsonVal[index].doseNm + "|" +
			                        jsonVal[index].gmNm + "|" +
			                        jsonVal[index].doroNm + "|" +
			                        jsonVal[index].omdNm + "|" +
			                        jsonVal[index].riNm + "|" +
			                        jsonVal[index].addr + "|" +
			                        devltype1 + "|" + devltype2 + "|" + jsonVal[index].jisaCd;

			            $("#data").val(checkData);
		          		$("#esSaturdayYn").val(codeConverter("saturdayYn", jsonVal[index].saturdayYn));
		          		if(codeConverter("deliveryYn", jsonVal[index].deliveryYn) == "가능" && jsonVal[index].deliveryYn != null){		//배달가능여부 가능일시 가맹점명 표시
							$("#esDeliveryYn").val(jsonVal[index].jisaNm);
						}else{
							$("#esDeliveryYn").val(codeConverter("deliveryYn", jsonVal[index].deliveryYn));
						}
		          		$("#esJisaCd").val(jsonVal[index].jisaCd);
		          		$("#esJisaNm").val(jsonVal[index].jisaNm);

		        	});

			});
	   	}else{
	   		$("#esSaturdayYn").val("");
	  		$("#esDeliveryYn").val("");
	   	}
	}

	//녹즙 ajax success 콜백
	function json_parse_fd(json){

		var data = new Array();
	   	var json = json.UM;
	   	var totalCount = json[0].info[0].totalCount;

		//홈가맹점
		$("#fdHomeFranch").val("");
		$("#fdHomeAddr").val("");
       	$("#fdHomeTel").val("");
       	//오피스가맹점
       	$("#fdOffFranch").val("");
       	$("#fdOffAddr").val("");
       	$("#fdOffTel").val("");

	   	if(totalCount > 0) {
			$.each(json, function(key){
				var jsonVal = json[key].items;

				//홈가맹점
				$("#fdHomeFranch").val(jsonVal[0].prtnName);
				$("#fdHomeAddr").val(jsonVal[0].prtnAddr1+" "+jsonVal[0].prtnAddr2);
	           	$("#fdHomeTel").val(jsonVal[0].buTelno+" / "+jsonVal[0].prtnChfCphnno);
	           	//오피스가맹점
	           	$("#fdOffFranch").val(jsonVal[1].prtnName);
	           	$("#fdOffAddr").val(jsonVal[1].prtnAddr1+" "+jsonVal[1].prtnAddr2);
	           	$("#fdOffTel").val(jsonVal[1].buTelno+" / "+jsonVal[1].prtnChfCphnno);
			});
	   	}
	}

	//코드값 -> 코드명 변환
	function codeConverter(type, code){

		if(type == "saturdayYn"){		//패턴
			if(code == "Y"){
				return "매일 직배";
			}else{
				return "택배";
			}
		}else if(type == "deliveryYn"){	//배달가능여부
			if(code == "Y"){
				return "가능";
			}else{
				return "불가능";
			}
		}
	}


</script>

<script type="text/javascript">

	//<span id=“Add”></span> 태그 이용
	var btnbChoice = new AW.UI.Button;
	btnbChoice.setId("btnbChoice");
	btnbChoice.setControlText("선택");
	//btnChoice.setControlImage("btnChoice");	       // aw.css 에 내장 이미지로 지정되어 있을 경우만 표시 가능
	btnbChoice.refresh();

	btnbChoice.onControlClicked = function(event){
		Choice();
	}

	//<span id=“Add”></span> 태그 이용
	var btneChoice = new AW.UI.Button;
	btneChoice.setId("btneChoice");
	btneChoice.setControlText("선택");
	//btnChoice.setControlImage("btnChoice");	       // aw.css 에 내장 이미지로 지정되어 있을 경우만 표시 가능
	btneChoice.refresh();

	btneChoice.onControlClicked = function(event){
		Choice();
	}

	//<span id=“Add”></span> 태그 이용
	var btnfChoice = new AW.UI.Button;
	btnfChoice.setId("btnfChoice");
	btnfChoice.setControlText("선택");
	//btnChoice.setControlImage("btnChoice");	       // aw.css 에 내장 이미지로 지정되어 있을 경우만 표시 가능
	btnfChoice.refresh();

	btnfChoice.onControlClicked = function(event){
		Choice();
	}
</script>


<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>

// 우편번호 찾기 찾기 화면을 넣을 element
var element_wrap = document.getElementById('wrap');

function foldDaumPostcode() {
    // iframe을 넣은 element를 안보이게 한다.
    element_wrap.style.display = 'none';
}

/*
 * 우편번호 조회 Daum api setting
 */
function sample3_execDaumPostcode() {
    // 현재 scroll 위치를 저장해놓는다.
    var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
    new daum.Postcode({
        oncomplete: function(data) {
            // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var fullAddr = data.address; // 최종 주소 변수
            var extraAddr = ''; // 조합형 주소 변수

            // 기본 주소가 도로명 타입일때 조합한다.
            if(data.addressType === 'R'){
                //법정동명이 있을 경우 추가한다.
                if(data.bname !== ''){
                    extraAddr += data.bname;
                }
                // 건물명이 있을 경우 추가한다.
                if(data.buildingName !== ''){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('gmNo').value = data.buildingCode;		   //빌딩코드
            document.getElementById('postcode').value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById('oldPostcode').value = data.postcode; //6자리 구우편번호 사용
            document.getElementById('address').value = fullAddr;
            if(data.jibunAddress == ""){
            	document.getElementById('jibunAddress').value = data.autoJibunAddress;
            }else {
            	document.getElementById('jibunAddress').value = data.jibunAddress;
            }
            //베이비밀
            document.getElementById('bmPostcode').value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById('bmAddress').value = fullAddr;
            //잇슬림
            document.getElementById('esPostcode').value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById('esAddress').value = fullAddr;

            // iframe을 넣은 element를 안보이게 한다.
            // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
            //element_wrap.style.display = 'none';

            // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
            document.body.scrollTop = currentScroll;
            //패턴 및 가맹점 조회
            searchDetail();
        },
        // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
        onresize : function(size) {
            //element_wrap.style.height = size.height+'px';
        },
        width : '100%',
        height : '100%'
    }).embed(element_wrap,{autoClose: false});

    // iframe을 넣은 element를 보이게 한다.
    element_wrap.style.display = 'block';
}

</script>