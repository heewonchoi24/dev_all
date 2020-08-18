<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%
if (eslMemberId == null || eslMemberId.equals("")) {
	ut.jsAlert(out, "로그인을 먼저 하시기 바랍니다.");
	
	out.println("<script>opener.parent.eventCallBack();</script>");
	out.println("<script>self.close();</script>");
}
%>
<%
Calendar cal		= Calendar.getInstance();
int nowYear			= cal.get(Calendar.YEAR);
int nowMonth		= cal.get(Calendar.MONTH)+1;
int nowDay			= cal.get(Calendar.DAY_OF_MONTH);
int i = 0;
%>
</head>
<body>
	<div class="pop-wrap" id="event_personal">
		<div class="inner">
			<div class="top_visual">
				적정 섭취열량 제시 및<br/>
				<span>나에게 맞는 <strong>잇슬림 퍼스널 코칭프로그램</strong></span>을
				추천해드립니다.
			</div>
			<form name="frm_write" id="frm_write" method="post" action="cal_bmi_db.jsp">
				<input type="hidden" id="bmi" name="bmi" />
				<input type="hidden" id="bmr" name="bmr" />
				<input type="hidden" id="email_yn" name="email_yn" value="N" />
				<input type="hidden" id="sms_yn" name="sms_yn" value="N" />
				<input type="hidden" id="rec_kcal" name="rec_kcal" />
				<div class="select_gender">
					<input type="radio" name="gender" value="F" id="gender_w" />
					<label for="gender_w" class="gender_w">여자</label>
					<input type="radio" name="gender" value="M" id="gender_m" />
					<label for="gender_m" class="gender_m">남자</label>
				</div>
				<ul class="input_list">
					<li class="birth">
						<div class="tit">생년월일</div>
						<div class="ipt_field" data-label="년">
							<select class="not" name="year" id="sb_year" onChange='dateSelect(this.form,this.form.month.selectedIndex);'>
							<%
							for(i=nowYear;i>nowYear-100;i--){
							%>
								<option value="<%=i %>" selected><%=i %></option>
							<%
							}
							%>
							</select>
						</div>
						<div class="ipt_field" data-label="월">
							<select class="not" name="month" id="sb_month" onChange='dateSelect(this.form,this.selectedIndex);'>
							<%
							for(i=1;i<=12;i++){
								if(i<10){
								%>
									<option value="0<%=i %>">0<%=i %></option>
								<%
								}else{
								%>
									<option value="<%=i %>"><%=i %></option>
								<%
								}
							}
							%>
							</select>
						</div>
						<div class="ipt_field" data-label="일">
							<select class="not" name="day" id="sb_day">
								 <%
								 for(i=1;i<=31;i++){
									if(i<10){
									%>
										<option value="0<%=i %>">0<%=i %></option>
									<%
									}else{
									%>
										<option value="<%=i %>"><%=i %></option>
									<%
									}
								}
								%>
							</select>
						</div>
					</li>
					<li>
						<div class="tit">체중</div>
						<div class="ipt_field" data-label="kg">
							<input type="number"  min="0" max="999" id="weight" name="weight" placeholder="체중을 입력해주세요" max="9999" maxlength="3" oninput="maxLengthCheck(this)" />
						</div>
					</li>
					<li>
						<div class="tit">키</div>
						<div class="ipt_field" data-label="cm">
							<input type="number" id="height" name="height" placeholder="키를 입력해주세요" max="999" maxlength="3" oninput="maxLengthCheck(this)"/>
						</div>
					</li>
				</ul>
				<div class="agree_setion">
					<p class="section_tit">제품추천 서비스를 신청합니다.</p>
					<div class="agree_tit">
						개인정보 수집·이용 동의(필수)<a href="javascript:void(0);" onclick="agree_cont('#agree_cont1');">내용보기</a>
						<div class="switch">
							<label>
								<input type="checkbox" id="agree_privacy" >
								<span class="lever" value="off"></span>
							</label>
						</div>
					</div>
					<div class="agree_cont" id="agree_cont1">
						<div class="tit">제품추천을 위한 개인정보 수집 및 이용동의 (필수)</div>
						<div class="txt">
							<p>1. 개인정보의 수집 및 이용목적 : 고객별 맞춤 제품 추천, 영양상담 서비스 제공</p>
							<p>2. 수집하는 개인정보의 항목 : 성별, 생년월일, 체중, 키</p>
							<p>3. 보유 및 이용기간 : 회원탈퇴 시 즉시 소멸</p>
							<p>4. 귀하는 본 수집 및 이용동의를 거부할 권리가 있으며, 거부 시 본 서비스 (제품추천, 영양상담)를 이용하실 수 없습니다.</p>
						</div>
					</div>
					<div class="agree_tit">
						마케팅 정보 수신 동의(선택)<a href="javascript:void(0);" onclick="agree_cont('#agree_cont2');">내용보기</a>
						<div class="switch">
							<label>
								<input type="checkbox" id="agree_marketing" onchange="agreeMarketing();">
								<span class="lever"></span>
							</label>
						</div>
					</div>
					<div class="agree_cont" id="agree_cont2">
						<div class="tit">마케팅 정보 수신 동의 (선택)</div>
						<div class="txt">
							회사는 서비스 혜택 제공을 위해 다양한 방법(전화, SMS, 우편 등)을 통해 서비스 관련 정보를 회원에게 제공할 수 있습니다.<br/>
							단, 회원이 서비스 혜택 정보 제공을 원치 않는다는 의사를 명확히 밝히는 경우 정보제공을 하지 않으며, 이 경우 회원에게 정보 미 제공으로 인한 불이익이 발생하더라도 회사가 책임지지 않습니다. 또한, 이용목적이 변경될 시에는 사전 동의를 구할 예정입니다.<br/>
							기존 마케팅 수신동의 정보를 현재 기준으로 업데이트 합니다.
							<ul class="chk_list">
								<li>
									문자(SMS)
									<div class="switch">
										<label>
											<input type="checkbox" id="agree_marketing1">
											<span class="lever"></span>
										</label>
									</div>
								</li>
								<li>
									E-mail
									<div class="switch">
										<label>
											<input type="checkbox" id="agree_marketing2">
											<span class="lever"></span>
										</label>
									</div>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</form>
			<div class="btns">
				<a href="javascript:calSubmit();">확인</a>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		//maxlength 체크
		  function maxLengthCheck(object){
		   if (object.value.length > object.maxLength){
			object.value = object.value.slice(0, object.maxLength);
		   }   
		  }

		$('#agree_marketing').change(function(e) {
			if($(this).is(':checked')){
				$('#agree_marketing1, #agree_marketing2').prop('checked', true);
				$("#email_yn").val('Y');
				$("#sms_yn").val('Y');		
			}else{
				$('#agree_marketing1, #agree_marketing2').prop('checked', false);
				$("#email_yn").val('N');
				$("#sms_yn").val('N');	
			}
		});


		$('#agree_marketing1').change(function(e) {
			if(!$(this).is(':checked')){
				$('#agree_marketing').prop('checked', false);
				$("#sms_yn").val('N');
			}
			if($(this).is(':checked')){
				$("#sms_yn").val('Y');
			}
			if($('#agree_marketing1').is(':checked') && $('#agree_marketing2').is(':checked')){
				$('#agree_marketing').prop('checked', true);
				$("#email_yn").val('Y');
				$("#sms_yn").val('Y');	
			}
		});

		$('#agree_marketing2').change(function(e) {
			if(!$(this).is(':checked')){
				$('#agree_marketing').prop('checked', false);
				$("#email_yn").val('N');
			}
			if($(this).is(':checked')){
				$("#email_yn").val('Y');
			}
			if($('#agree_marketing1').is(':checked') && $('#agree_marketing2').is(':checked')){
				$('#agree_marketing').prop('checked', true);
				$("#email_yn").val('Y');
				$("#sms_yn").val('Y');	
			}
		});

		function agree_cont(t) {
			if(!$(t).hasClass('active')){
				$(t).addClass('active').slideDown('400');
			}else{
				$(t).removeClass('active').slideUp('400');
			}
		}
	</script>

<script type="text/javascript">
var weight = 0;	// 몸무게
var height = 0;	// 키
var bmi = 0;	// bmi 수치
var mHeight = 0;	// 키(m) 담은 변수
var gender = "";	// 성별(남,여)
var stWeight = 0;	//	표준체중(kg)
var bmr = 0;	// 1일 필요열량(kcal) = 기초대사량
var kcal = 0;	// 1일 처방열량
var recKcal;	// 추천 칼로리

var this_year = 0;
var this_month = 0;
var this_day = 0;

$(document).ready(function() {
   Today('null','null','null');
});

function Today(year,mon,day){
     if(year == "null" && mon == "null" && day == "null"){
		 today = new Date();
		 this_year=today.getFullYear();
		 this_month=today.getMonth();
		 this_month+=1;
		 if(this_month <10) this_month="0" + this_month;

		 this_day=today.getDate();
		 if(this_day<10) this_day="0" + this_day;
	 }
	 else{
		 this_year = eval(year);
		 this_month = eval(mon);
		 this_day = eval(day);
	 }

	  montharray=new Array(31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
	  maxdays = montharray[this_month-1];

	  // 윤달을 구하는 것
	  if (this_month==2) {
		  if ((this_year/4)!=parseInt(this_year/4)) maxdays=28;
		  else maxdays=29;
	  }

	  $("#sb_year").val(this_year).attr('selected',true);
	  $("#sb_month").val(this_month).attr('selected',true);
      $("#sb_day").val(this_day).attr('selected',true);
}

// 월, 일 리스트 뿌려주기
function dateSelect(docForm,selectIndex) {

	watch = new Date(docForm.year.options[docForm.year.selectedIndex].text, docForm.month.options[docForm.month.selectedIndex].value,1);
	hourDiffer = watch - 86400000;
	calendar = new Date(hourDiffer);

	var daysInMonth = calendar.getDate();
	for (var i = 0; i < docForm.day.length; i++) {
		docForm.day.options[i] = null;
	}
	var k = 0;
	for (var i = 0; i < daysInMonth; i++) {

		if(i<=9 && k<9){
			k = i+1;
			docForm.day.options[i] = new Option('0'+k);
		}else{
			k = i+1;
			docForm.day.options[i] = new Option(k);
		}
	}
}

function calSubmit(){

	// valition 처리
	if( $(':radio[name="gender"]:checked').length < 1 ){
		alert("성별을 선택해주세요.");
		return;
	}

	if( $('#weight').val() == ""){
		alert("체중을 입력해주세요.");
		$('#weight').focus();
		return;
	}

	if( $('#height').val() == ""){
		alert("키를 입력해주세요.");
		$('#height').focus();
		return;
	}

	if( $('#height').val() == ""){
		alert("키를 입력해주세요.");
		$('#height').focus();
		return;
	}

	agreePrivacyVal = $("input[id=agree_privacy]:checked").val();
	if(!agreePrivacyVal){
		alert("개인정보 수집·이용에 동의 해주세요.");
		return;
	}

	calBmi();
}

/*
BMI(kg/m2)= 체중÷키(m)÷키(m)
	정상 :   BMI 18.5~22.9
	과체중:   BMI 23~24.9
	비만 :   BMI 25 이상
	고도비만:  BMI 30 이상
*/
function calBmi(){
	weight = $("#weight").val();
	height = $("#height").val();
	mHeight = height*0.01;	// cm > m로 변환
	bmi = weight / ( mHeight * mHeight );
	bmi = Math.floor(bmi*10)/10.0;	// 소수점 둘째자리 

	if (isNaN(bmi)) bmi = 0;

	calStandardWeight();
}

/*
남여에 따라 표준 체중 구하는 계산식
	남자: 표준체중(kg)= 키(m)X키(m)X22
	여자: 표준체중(kg)= 키(m)X키(m)X21
*/
function calStandardWeight(){
	$("input[name=gender]:checked").each(function() {
		gender = $(this).attr("id");
	});

	if(gender == "gender_m"){	// 남자일 경우
		//stWeight = Math.round(mHeight * mHeight * 22);
		stWeight = mHeight * mHeight * 22;
	}
	if(gender == "gender_w"){	// 여자일 경우
		//stWeight =  Math.round(mHeight * mHeight * 21);
		stWeight = mHeight * mHeight * 21;
	}
	//console.log("stWeight: " + stWeight);
	calBmr();
}

/*
bmr = kcal
1일 필요열량(kcal) 구하는 계산식 = 기초대사량
	1일 필요열량(kcal) = 표준체중(kg) X 25kcal/kg (*가벼운 활동 시 열량 요구량)
*/
function calBmr(){
	bmr = Math.floor(stWeight * 25);	// 기초대사량(1일 필요열량)
	//console.log("bmr: " + bmr);
	totalComma(bmr);

	$("#bmi").val(bmi);
	$("#bmr").val(bmr);

	recProgram();
}

//콤마 가격 붙여주기
function totalComma(total){
	total = total + "";
	point = total.length % 3 ;
	len = total.length;
	bmr = total.substring(0, point);
	while (point < len) {
		if (bmr != "") bmr += ",";
		bmr += total.substring(point, point + 3);
		point += 3;
	}
	return bmr;
}

// 추천 칼로리 계산
function recProgram(){

	 if(bmr.indexOf(',')){
		bmr = bmr.replace(",", "");
	 }

	 if (bmi < 18.5){	// 저체중
		 kcal = bmr;
	 }
	 if (bmi >= 18.5 && bmi < 23){	// 정상
		 kcal = bmr * 0.9;
	 }
	 else if (bmi >= 23 && bmi < 25){	// 과체중
		 kcal = bmr * 0.8;
	 }
	 else if (bmi >= 25){	// 비만
		 kcal = bmr * 0.7;
	 }

	if(kcal >= 1400){
		recKcal = '1,500';
		$("#rec_kcal").val(recKcal);
	}
	if(kcal >= 1100 && kcal < 1400){
		recKcal = '1,200';
		$("#rec_kcal").val(recKcal);
	}
	if(kcal >= 800 && kcal < 1100){
		recKcal = '800';
		$("#rec_kcal").val(recKcal);
	}

	document.frm_write.submit();
}
</script>
</body>
</html>