////////////////////////////////////////////////////////////////////////
function input_usePoint(){ //����Ʈ �ݾ� �Է�
	var f=document.frmOrder;	
	var p=0;	
	var SETTLE_AMT=eval(f.pay_price.value);
	var REMAIN_POINT=eval(f.REMAIN_POINT.value);
	var MAX_POINT=eval(f.MAX_POINT.value);
	var usePoint=eval(f.usePoint.value);

	if(usePoint==null)usePoint=0;

	if(f.REMAIN_POINT.value=="" || eval(f.REMAIN_POINT.value)==0){ alert("��� ������ ����Ʈ�� 0���Դϴ�.");init_usePoint();return;}
	f.usePoint.value=f.usePoint.value.replace(/[^0-9]/g,'');

	if(MAX_POINT>0 && usePoint>MAX_POINT){
		alert("�ִ� "+comma(MAX_POINT)+" P ���� ��� �����մϴ�.");init_usePoint();return;
	}
	
	if(usePoint>REMAIN_POINT){
		alert("��� ������ ����Ʈ�� �ʰ��Ͽ����ϴ�.");init_usePoint();return;
	}else{
		p = SETTLE_AMT - usePoint;
	}
	if(p<0){alert("����Ʈ�� ��ǰ�հ�ݾ׺��� ũ�� �Է��� �� �����ϴ�.");init_usePoint();return;}

	p = usePoint + eval(uncomma($("#dcCoupon2").text()));

	$("#dcPoint").html(comma(usePoint));
	$("#dcPrice2").html(comma(p));
	calcPrice();
}

function init_usePoint(){ //��������Ʈ �Է� �ʱ�ȭ
	var p=0;
	document.frmOrder.usePoint.value = "";
	$("#dcPoint").html("0"); 
	p=eval(uncomma($("#dcCoupon2").text()));
	$("#dcPrice2").html(comma(p));
	calcPrice();
}

function check_usePoint(){
	var obj=document.frmOrder.usePoint;	
	if(obj.value != ""){
		var p=eval(obj.value);
		if(p>0 && p<500){
			alert("����Ʈ ����� 500 P���� ��� �����մϴ�."); obj.focus(); return false;
		}else{
			if((p%100)>0){
				alert("����Ʈ ��� ������ 100������ ��밡���մϴ�."); obj.focus(); return false;
			}
		}
	}
	return true;
}


function selCoupon(no){ //�������� ����
	var f=document.frmOrder;
	var arr="",p=0,selCouponPrice=0,couponcd="";
	//var txt=$('#selBoxCPN'+no+' option:selected').val(); //couponcd | price
	var txt=$('#selCoupon'+no).val(); //couponcd | price

	if(txt){
		arr=txt.split("|");
		couponcd=arr[0];
		selCouponPrice=eval(arr[1]);
	}else{
		couponcd="";
		selCouponPrice=0;
	}
	
	//alert(txt);
	if(no=="1"){ //---------��ǰ��������
		p=selPRDCoupon();		
		$("#dcCoupon1").html(comma(p));

	}else if(no=="2"){ //---------�ֹ���������
		f.cpnOrdCD.value = couponcd;
		$("#dcCoupon2").html(comma(selCouponPrice));
		p=selCouponPrice + eval(uncomma($("#dcPoint").text()));

	}else{ //---------------------����������
		f.cpnDeliCD.value = couponcd;
		if(eval(f.deliveryDCAmount.value)>0){ //��������� �Ǿ� �ִٸ�
			if(eval(f.add_deliveryAmount.value) > 0){ //�߰���ۺ� �����Ѵٸ�
				p=eval(f.add_deliveryAmount.value) - eval(f.deliveryDCAmount.value);			
			}
		}else{
			if(selCouponPrice>0){ //--------������������ �����ߴٸ�
				if(eval(f.add_deliveryAmount.value) > 0){ //�߰���ۺ� �����Ѵٸ�
					p=eval(f.add_deliveryAmount.value) - eval(f.org_deliveryAmount.value);					
				}
				if(eval(f.org_deliveryAmount.value)>0){
					$("#dcCoupon3").html(comma(eval(f.org_deliveryAmount.value)));
				}else{
					$("#dcCoupon3").html("������");
				}

			}else{ //-----------------------------------------------
				if(eval(f.add_deliveryAmount.value) > 0){ //�߰���ۺ� �����Ѵٸ�
					p=eval(f.add_deliveryAmount.value);
				}else{
					p=eval(f.org_deliveryAmount.value);
				}
				$("#dcCoupon3").html(0);
				//$("#dcCoupon3").html("������.");
			}
		}			
		f.deliveryAmount.value=p;		
	}
	$("#dcPrice"+no).html(comma(p));	

	calcPrice();
}

function selPRDCoupon(){ //��ǰ�������� ���
	var f=document.frmOrder;
	var i=0,selCouponPrice=0;
	if(f.cpnPrdCD.length!=undefined){
		for(i=0;i<f.cpnPrdCD.length;i++){
			//alert(eval(f.cpnPrdPrice[i].value));
			if(eval(f.cpnPrdPrice[i].value)!=undefined){
				selCouponPrice+=eval(f.cpnPrdPrice[i].value);
			}
		}	
	}else{
		selCouponPrice=eval(f.cpnPrdPrice.value);
	}
	return selCouponPrice;
	
}

function coupon_pop(){
	var f=document.frmCoupon;
	var fo=document.frmOrder;
	var url="../popup/popup_couponview.jsp?mode="+f.mode.value+"&product_no="+f.product_no.value+"&category_no="+f.category_no.value+"&goodsprice="+f.goodsprice.value+"&pno="+f.pno.value+"&ea="+f.ea.value;
	url+="&cp2="+fo.cpnOrdCD.value+"&cp3="+fo.cpnDeliCD.value;
	popup(url,530,580,1,"couponview");
}

function AreaCheck(){ //������ ��ۺ� DB üũ
	document.getElementById("ifrmHidden").src="/shopping/AreaCheck.jsp?addr="+$("#addr").val();
}

function AreaCalc(addprice){ //������ ��ۺ� ��� (addprice�� 0���� ũ�� �߰����)
	var f=document.frmOrder;
	var DC=0;
	f.add_deliveryAmount.value=addprice;
	selCoupon(3);	
}


//====�����ݾ� ���
function calcPrice(){
	var f=document.frmOrder;
	var usePoint=eval(f.usePoint.value);
	if(usePoint==undefined)usePoint=0;
	f.cpnPrdAmount.value=uncomma($("#dcCoupon1").text());		
	f.cpnOrdAmount.value=uncomma($("#dcCoupon2").text());	

	//�����ݾ�=��ǰ�հ�ݾ�-��������-����Ʈ����-�ֹ�����+��ۺ�
	var sum=eval(f.goodsprice.value) - eval(f.cpnPrdAmount.value) - usePoint - eval(f.cpnOrdAmount.value) + eval(f.deliveryAmount.value);
	if(sum<0)sum=0;
	$("#P_AMT").html(comma(sum));
	f.pay_price.value=sum;
	if(eval(f.point_order_rate.value)>0){ //�����ݰ��
		var pt = sum * (eval(f.point_order_rate.value)/100);
		$("#AddPoint").html(comma(pt));	
		f.add_point.value=pt;
	}
}



////////////////////////////////////////////////////////////////////////

function ckForm(mode){	
	var f=document.frmOrder;
	var frmLG=document.LGD_PAYINFO;
	var pay_type="";
	if(f.goods_price.value==0){
		alert("�ֹ��� ��ǰ�� �������� �ʽ��ϴ�.");return;
	}
	//var ret=check_usePoint();
	//if(!ret) return;
	if (!checkForm(f)){
		return;
	}else{
		frmLG.LGD_BUYER.value=f.name.value;	
		frmLG.LGD_AMOUNT.value=f.pay_price.value;
		frmLG.LGD_BUYEREMAIL.value=f.email.value;
		pay_type=$('input:radio[name=pay_type]:checked').val();
		if(pay_type=="10")
			frmLG.LGD_CUSTOM_FIRSTPAY.value="SC0010";
		else if(pay_type=="20")
			frmLG.LGD_CUSTOM_FIRSTPAY.value="SC0030";
		else if(pay_type=="30")
			frmLG.LGD_CUSTOM_FIRSTPAY.value="SC0040";

		if(document.getElementById('payBtn'))document.getElementById('payBtn').style.display="none";
		if(document.getElementById('pay_ing'))document.getElementById('pay_ing').style.display="";
		

		/*if(mode=="mobile"){
			frmLG.submit();
		}else{
			f.action="/proc/order_temp_proc.jsp?payMode="+mode;
			f.target="ifrmHidden";
			f.submit();
		}*/

				
		if(mode=="mobile"){
			f.action="/proc/order_temp_proc.jsp?payMode="+mode;
			f.target="_new";
			f.submit();
		}else{
			f.action="/proc/order_temp_proc.jsp?payMode="+mode;
			f.target="ifrmHidden";
			f.submit();
		}


		/*if(mode=="test"){
			f.test.value="test";
			f.action="/proc/order_proc.jsp";
			f.target="ifrmHidden";
			f.submit();			
		}else if(mode=="mobile"){			
			frmLG.submit();
		}else{			
			f.action="/xpay/getPayInfo.jsp?LGD_OID="+f.order_num.value+"&LGD_AMOUNT="+f.pay_price.value+"";			
			f.target="ifrmHidden";
			f.submit();
		}*/

	}
}

function pay() {
	f.action="/proc/order_proc.jsp";
	f.target="ifrmHidden";
}

function paySubmit(mode){	
	var f=document.frmOrder;
	var frmLG=document.LGD_PAYINFO;
	if(mode=="mobile"){			
		frmLG.submit();
	}else{			
		f.action="/xpay/getPayInfo.jsp?LGD_OID="+f.order_num.value+"&LGD_AMOUNT="+f.pay_price.value+"&LGD_CLOSEDATE="+f.LGD_CLOSEDATE.value+"";			
		f.target="ifrmHidden";
		f.submit();
	}
}

function payMobileComplete(orderNum){
	var f1=document.frmOrder;
	var f2=document.frmMobileComplete;
	f2.LGD_TID.value = f1.LGD_TID.value;
	f2.LGD_CARDNUM.value = f1.LGD_CARDNUM.value;
	f2.LGD_FINANCECODE.value = f1.LGD_FINANCECODE.value;
	f2.LGD_FINANCENAME.value = f1.LGD_FINANCENAME.value;
	f2.LGD_ACCOUNTNUM.value = f1.LGD_ACCOUNTNUM.value;
	f2.LGD_FINANCEAUTHNUM.value = f1.LGD_FINANCEAUTHNUM.value;
	for(var i=0;i<f1.pay_type.length;i++){
		if(f1.pay_type[i].checked == true){
			f2.pay_type.value=f1.pay_type[i].value;
		}
	}
	f2.submit();
}

function displayResult() {
		if (httpRequest.readyState == 4) {
			if (httpRequest.status == 200) {
				var resultText = httpRequest.responseText;
				alert(resultText);
				frmLG.LGD_HASHDATA.value=resultText;
			} else {
				alert("���� �߻�: "+httpRequest.status);
			}
		}
}

