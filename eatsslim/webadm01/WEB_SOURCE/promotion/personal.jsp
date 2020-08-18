<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%
if (eslMemberId == null || eslMemberId.equals("")) {
	ut.jsAlert(out, "�α����� ���� �Ͻñ� �ٶ��ϴ�.");
	
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
				���� ���뿭�� ���� ��<br/>
				<span>������ �´� <strong>�ս��� �۽��� ��Ī���α׷�</strong></span>��
				��õ�ص帳�ϴ�.
			</div>
			<form name="frm_write" id="frm_write" method="post" action="cal_bmi_db.jsp">
				<input type="hidden" id="bmi" name="bmi" />
				<input type="hidden" id="bmr" name="bmr" />
				<input type="hidden" id="email_yn" name="email_yn" value="N" />
				<input type="hidden" id="sms_yn" name="sms_yn" value="N" />
				<input type="hidden" id="rec_kcal" name="rec_kcal" />
				<div class="select_gender">
					<input type="radio" name="gender" value="F" id="gender_w" />
					<label for="gender_w" class="gender_w">����</label>
					<input type="radio" name="gender" value="M" id="gender_m" />
					<label for="gender_m" class="gender_m">����</label>
				</div>
				<ul class="input_list">
					<li class="birth">
						<div class="tit">�������</div>
						<div class="ipt_field" data-label="��">
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
						<div class="ipt_field" data-label="��">
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
						<div class="ipt_field" data-label="��">
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
						<div class="tit">ü��</div>
						<div class="ipt_field" data-label="kg">
							<input type="number"  min="0" max="999" id="weight" name="weight" placeholder="ü���� �Է����ּ���" max="9999" maxlength="3" oninput="maxLengthCheck(this)" />
						</div>
					</li>
					<li>
						<div class="tit">Ű</div>
						<div class="ipt_field" data-label="cm">
							<input type="number" id="height" name="height" placeholder="Ű�� �Է����ּ���" max="999" maxlength="3" oninput="maxLengthCheck(this)"/>
						</div>
					</li>
				</ul>
				<div class="agree_setion">
					<p class="section_tit">��ǰ��õ ���񽺸� ��û�մϴ�.</p>
					<div class="agree_tit">
						�������� �������̿� ����(�ʼ�)<a href="javascript:void(0);" onclick="agree_cont('#agree_cont1');">���뺸��</a>
						<div class="switch">
							<label>
								<input type="checkbox" id="agree_privacy" >
								<span class="lever" value="off"></span>
							</label>
						</div>
					</div>
					<div class="agree_cont" id="agree_cont1">
						<div class="tit">��ǰ��õ�� ���� �������� ���� �� �̿뵿�� (�ʼ�)</div>
						<div class="txt">
							<p>1. ���������� ���� �� �̿���� : ���� ���� ��ǰ ��õ, ������ ���� ����</p>
							<p>2. �����ϴ� ���������� �׸� : ����, �������, ü��, Ű</p>
							<p>3. ���� �� �̿�Ⱓ : ȸ��Ż�� �� ��� �Ҹ�</p>
							<p>4. ���ϴ� �� ���� �� �̿뵿�Ǹ� �ź��� �Ǹ��� ������, �ź� �� �� ���� (��ǰ��õ, ������)�� �̿��Ͻ� �� �����ϴ�.</p>
						</div>
					</div>
					<div class="agree_tit">
						������ ���� ���� ����(����)<a href="javascript:void(0);" onclick="agree_cont('#agree_cont2');">���뺸��</a>
						<div class="switch">
							<label>
								<input type="checkbox" id="agree_marketing" onchange="agreeMarketing();">
								<span class="lever"></span>
							</label>
						</div>
					</div>
					<div class="agree_cont" id="agree_cont2">
						<div class="tit">������ ���� ���� ���� (����)</div>
						<div class="txt">
							ȸ��� ���� ���� ������ ���� �پ��� ���(��ȭ, SMS, ���� ��)�� ���� ���� ���� ������ ȸ������ ������ �� �ֽ��ϴ�.<br/>
							��, ȸ���� ���� ���� ���� ������ ��ġ �ʴ´ٴ� �ǻ縦 ��Ȯ�� ������ ��� ���������� ���� ������, �� ��� ȸ������ ���� �� �������� ���� �������� �߻��ϴ��� ȸ�簡 å������ �ʽ��ϴ�. ����, �̿������ ����� �ÿ��� ���� ���Ǹ� ���� �����Դϴ�.<br/>
							���� ������ ���ŵ��� ������ ���� �������� ������Ʈ �մϴ�.
							<ul class="chk_list">
								<li>
									����(SMS)
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
				<a href="javascript:calSubmit();">Ȯ��</a>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		//maxlength üũ
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
var weight = 0;	// ������
var height = 0;	// Ű
var bmi = 0;	// bmi ��ġ
var mHeight = 0;	// Ű(m) ���� ����
var gender = "";	// ����(��,��)
var stWeight = 0;	//	ǥ��ü��(kg)
var bmr = 0;	// 1�� �ʿ俭��(kcal) = ���ʴ�緮
var kcal = 0;	// 1�� ó�濭��
var recKcal;	// ��õ Į�θ�

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

	  // ������ ���ϴ� ��
	  if (this_month==2) {
		  if ((this_year/4)!=parseInt(this_year/4)) maxdays=28;
		  else maxdays=29;
	  }

	  $("#sb_year").val(this_year).attr('selected',true);
	  $("#sb_month").val(this_month).attr('selected',true);
      $("#sb_day").val(this_day).attr('selected',true);
}

// ��, �� ����Ʈ �ѷ��ֱ�
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

	// valition ó��
	if( $(':radio[name="gender"]:checked').length < 1 ){
		alert("������ �������ּ���.");
		return;
	}

	if( $('#weight').val() == ""){
		alert("ü���� �Է����ּ���.");
		$('#weight').focus();
		return;
	}

	if( $('#height').val() == ""){
		alert("Ű�� �Է����ּ���.");
		$('#height').focus();
		return;
	}

	if( $('#height').val() == ""){
		alert("Ű�� �Է����ּ���.");
		$('#height').focus();
		return;
	}

	agreePrivacyVal = $("input[id=agree_privacy]:checked").val();
	if(!agreePrivacyVal){
		alert("�������� �������̿뿡 ���� ���ּ���.");
		return;
	}

	calBmi();
}

/*
BMI(kg/m2)= ü�ߡ�Ű(m)��Ű(m)
	���� :   BMI 18.5~22.9
	��ü��:   BMI 23~24.9
	�� :   BMI 25 �̻�
	����:  BMI 30 �̻�
*/
function calBmi(){
	weight = $("#weight").val();
	height = $("#height").val();
	mHeight = height*0.01;	// cm > m�� ��ȯ
	bmi = weight / ( mHeight * mHeight );
	bmi = Math.floor(bmi*10)/10.0;	// �Ҽ��� ��°�ڸ� 

	if (isNaN(bmi)) bmi = 0;

	calStandardWeight();
}

/*
������ ���� ǥ�� ü�� ���ϴ� ����
	����: ǥ��ü��(kg)= Ű(m)XŰ(m)X22
	����: ǥ��ü��(kg)= Ű(m)XŰ(m)X21
*/
function calStandardWeight(){
	$("input[name=gender]:checked").each(function() {
		gender = $(this).attr("id");
	});

	if(gender == "gender_m"){	// ������ ���
		//stWeight = Math.round(mHeight * mHeight * 22);
		stWeight = mHeight * mHeight * 22;
	}
	if(gender == "gender_w"){	// ������ ���
		//stWeight =  Math.round(mHeight * mHeight * 21);
		stWeight = mHeight * mHeight * 21;
	}
	//console.log("stWeight: " + stWeight);
	calBmr();
}

/*
bmr = kcal
1�� �ʿ俭��(kcal) ���ϴ� ���� = ���ʴ�緮
	1�� �ʿ俭��(kcal) = ǥ��ü��(kg) X 25kcal/kg (*������ Ȱ�� �� ���� �䱸��)
*/
function calBmr(){
	bmr = Math.floor(stWeight * 25);	// ���ʴ�緮(1�� �ʿ俭��)
	//console.log("bmr: " + bmr);
	totalComma(bmr);

	$("#bmi").val(bmi);
	$("#bmr").val(bmr);

	recProgram();
}

//�޸� ���� �ٿ��ֱ�
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

// ��õ Į�θ� ���
function recProgram(){

	 if(bmr.indexOf(',')){
		bmr = bmr.replace(",", "");
	 }

	 if (bmi < 18.5){	// ��ü��
		 kcal = bmr;
	 }
	 if (bmi >= 18.5 && bmi < 23){	// ����
		 kcal = bmr * 0.9;
	 }
	 else if (bmi >= 23 && bmi < 25){	// ��ü��
		 kcal = bmr * 0.8;
	 }
	 else if (bmi >= 25){	// ��
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