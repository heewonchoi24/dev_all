var chkSubmit = "N";
(function($){

	$.validator = function() {
		this.form = null;
		this.error = {result:false,type:'alert',msg:null}

	};

	$.extend($.validator, {

		//===========================================================================
		// Prototype
		//===========================================================================
		prototype:{

			validCheck:function(f){
				this.form = f;
				var validator = this;
				var ele = f.elements;
				for(var i=0;i<ele.length;i++){
					ele[i].value = $.validator.bothTrim(ele[i].value);
					if(!validator.valid(ele[i])){ return false; }
				}
				return true;
			},

			valid:function(ele){
				var validator = this;
				var pattern = /({.+?}$)/;
				var cvalue = $(ele).attr('class');
				try{
					var cls = cvalue.match(pattern);
					if(cls != null){
						cls = cls[0];
						try{
							var orule = eval('(' + cls + ')');
						}catch(e){
							this.error.result = false;
							this.error.type = 'alert';
							this.error.msg = '[' + $(ele).attr('name') + '] 필드내의 class 안에 표현식이 잘못된것 같습니다\n다시 확인해 주세요';
							this.invalidProcess(ele, orule);
							return false;
						}
						//클래스안의 룰 개수만큼 루프
						for(var key in orule){
							if(key=='label') continue;
							if(!orule.required && $(ele).val()=='') continue;
							var mtdname = 'val' + $.validator.ucfirst(key);
							var existMethod = this.hasMethod(mtdname);
							if(existMethod==undefined){
								this.error.result = false;
								this.error.msg = 'class 속성 안에 존재하지 않는 메소드를 호출하였습니다 [' + key + ']';
							}else{
								validator[mtdname](ele, orule);
							}
	
							if(this.error.result){
								this.invalidProcess(ele, orule);
								return false;
							}
						}
					}
					return true;
				}
				catch(err){
					return true;
				}
			},

			hasMethod:function(methodname){
				return this && this[methodname] && this[methodname] instanceof Function;
			},

			invalidProcess:function(ele, o){
				$('.es_error').remove();
				if(this.error.type == 'print'){
					$(ele.parentNode).append("<span class='es_error' style='color:blue;font-weight:bold'>" + this.error.msg + "</span>");
					$(ele).focus();
				}else{
					alert(this.error.msg);
					$(ele).focus();
				}
				this.initError();
			},

			initError:function(){
				this.error.result = false;
				this.error.type = 'alert';
				this.error.msg = null;
			},

			valRequired:function(ele, o){
				if(!o.required) return;

				if($(ele).attr('type')=='checkbox' || $(ele).attr('type')=='radio'){
					if(!ele.checked){
						this.error.result = true;
						this.error.type = 'alert';
						this.error.msg = '[' + o.label + '] 필수 체크 항목입니다';
					}
				}
				if($(ele).attr('type')=='file'){
					if($(ele).val()==''){
						this.error.result = true;
						this.error.type = 'alert';
						this.error.msg = '[' + o.label + '] 파일을 선택하세요';
					}
					else{
						var ext = $(ele).attr('ext');
						try{
							if(ext != "" && ext != undefined){
								if(!eval("/"+ext+"/").test($(ele).val().toLocaleLowerCase()) ){
									while(ext.indexOf("|") != -1){
										ext = ext.replace("|",", ");
									}
									this.error.result = true;
									this.error.type = 'alert';
									this.error.msg = '[' + o.label + '] 확장자는 (' + ext + ') 확장자만 저장할 수 있습니다';
								}
							}
						}
						catch(err){
						}
					}
					
				}else{
					if($(ele).val()==''){
						this.error.result = true;
						this.error.type = 'alert';
						this.error.msg = '[' + o.label + '] 필수 항목입니다';
					}
				}
			},

			valEqual:function(ele, o){
				if($(ele).val() != $(this.form[o.equal]).val()){
					this.error.result = true;
					this.error.type = 'alert';
					this.error.msg = '[' + o.label + '] 값이 일치하지 않습니다';
				}
			},

			valMinlength:function(ele, o){
				if ($(ele).val().length < o.minlength){
					this.error.result = true;
					this.error.type = 'alert';
					this.error.msg = '[' + o.label + '] 최소 ' + o.minlength + '자 이상 입력하세요.';
				}
			},

			valMaxlength:function(ele, o){
				if ($(ele).val().length > o.maxlength){
					this.error.result = true;
					this.error.type = 'alert';
					this.error.msg = '[' + o.label + '] 최대 ' + o.maxlength + '자 이하로 입력하세요.';
				}
			},

			valEmail:function(ele, o){
				if(!o.email) return;
				var pattern = /([0-9a-zA-Z_-]+)@([0-9a-zA-Z_-]+)\.([0-9a-zA-Z_-]+)/;
				if (!pattern.test($(ele).val())){
					this.error.result = true;
					this.error.type = 'alert';
					this.error.msg = '[' + o.label + '] 잘못된 이메일로 추정됩니다.';
				}
			},

			valHangul:function(ele, o){
				if(!o.hangul) return;
				var pattern = /[^가-힣]/;
				if(pattern.test($(ele).val())){
					this.error.result = true;
					this.error.type = 'alert';
					this.error.msg = '[' + o.label + '] 한글만 입력 가능합니다';
				}
			},

			valHangul2:function(ele, o){
				if(!o.hangul2) return;
				var pattern = /[^가-힣ㄱ-ㅎㅏ-ㅣ]/;
				if(pattern.test($(ele).val())){
					this.error.result = true;
					this.error.type = 'alert';
					this.error.msg = '[' + o.label + '] 한글만 입력 가능합니다';
				}
			},

			valMemberid:function(ele, o){
				if(!o.memberid) return;
				var pattern = /^[^a-z0-9]|[^a-z0-9_]/;
				if (pattern.test($(ele).val())){
					this.error.result = true;
					this.error.type = 'alert';
					this.error.msg = '[' + o.label +
						'] 회원아이디 형식이 아닙니다\n\n' +
						'(알파벳소문자, 숫자, \'_\' 만 가능합니다. 첫글자 영문자,숫자)';
				}
			},

			valNospace:function(ele, o){
				if(!o.nospace) return;
				var pattern = /(\s)/g;
				if(pattern.test($(ele).val())){
					this.error.result = true;
					this.error.msg = '[' + o.label + '] 공백문자는 입력할 수 없습니다';
				}

			},

			valNumeric:function(ele, o){
				if(!o.numeric) return;
				var pattern = /^[0-9]+$/;
				if(!pattern.test($(ele).val())){
					this.error.result = true;
					this.error.type = 'alert';
					this.error.msg = '[' + o.label + '] 숫자만 입력할 수 있습니다';
				}

			},

			valNumericdot:function(ele, o){
				if(!o.numericdot) return;
				var pattern = /^[0-9]+[.]{0,1}[0-9]+$/;
				if(!pattern.test($(ele).val())){
					this.error.result = true;
					this.error.type = 'alert';
					this.error.msg = '[' + o.label + '] 형식이 다르거나 숫자 와 점(.)만 입력할 수 있습니다';
				}

			},

			valAlpha:function(ele, o){
				if(!o.alpha) return;
				var pattern = /[^a-z]/i;
				if(pattern.test($(ele).val())){
					this.error.result = true;
					this.error.type = 'alert';
					this.error.msg = '[' + o.label + '] 영문자만 입력할 수 있습니다';
				}
			},

			valAlphanumeric:function(ele, o){
				if(!o.alphanumeric) return;
				var pattern = /[^a-z0-9]/i;
				if(pattern.test($(ele).val())){
					this.error.result = true;
					this.error.type = 'alert';
					this.error.msg = '[' + o.label + '] 영문자와 숫자만 입력할 수 있습니다';
				}
			},

			valAlphanumeric_:function(ele, o){
				if(!o.alphanumeric) return;
				var pattern = /[^a-z0-9_]/i;
				if(pattern.test($(ele).val())){
					this.error.result = true;
					this.error.type = 'alert';
					this.error.msg = '[' + o.label + '] 영문자, 숫자, \'-\' 만 입력할 수 있습니다';
				}
			},

			valCkdate:function(ele, o){
				if(!o.ckdate) return;
				var pattern = /^[0-9]{4}-[0-9]{2}-[0-9]{2}$/;
				if(!pattern.test($(ele).val())){
					this.error.result = true;
					this.error.type = 'alert';
					this.error.msg = '[' + o.label + '] 잘못된 날자 입니다.';
				}
			},

			valPhonenumber:function(ele, o){
				if(!o.phonenumber) return;
				var pattern = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$/;
				if(!pattern.test($(ele).val())){
					this.error.result = true;
					this.error.type = 'alert';
					this.error.msg = '[' + o.label + '] 잘못된 번호 같습니다';
				}
			},

			valHangulalphanumeric:function(ele, o){
				if(!o.hangulalphanumeric) return;
				var pattern = /[^가-힣a-z0-9]/i;
				if(pattern.test($(ele).val())){
					this.error.result = true;
					this.error.type = 'alert';
					this.error.msg = '[' + o.label + '] 한글, 영문, 숫자만 입력할 수 있습니다';
				}
			},

			valJumin:function(ele, o){
				if(!o.jumin) return;
				var value = $(ele).val().replace(/[^\d]/g, '');
				var pattern = /\d{13}/;
				if (!pattern.test(value)) {
					this.error.result = true;
					this.error.type = 'alert';
					this.error.msg = '[' + o.label + '] 주민번호 13자리를 입력해 주세요';
				}else{
					var sum_1 = 0;
					var sum_2 = 0;
					var at=0;
					var juminno = value;
					sum_1 = (juminno.charAt(0)*2)+
						(juminno.charAt(1)*3)+
						(juminno.charAt(2)*4)+
						(juminno.charAt(3)*5)+
						(juminno.charAt(4)*6)+
						(juminno.charAt(5)*7)+
						(juminno.charAt(6)*8)+
						(juminno.charAt(7)*9)+
						(juminno.charAt(8)*2)+
						(juminno.charAt(9)*3)+
						(juminno.charAt(10)*4)+
						(juminno.charAt(11)*5);
					sum_2=sum_1 % 11;

					if (sum_2 == 0)
						at = 10;
					else
					{
						if (sum_2 == 1) at = 11;
						else at = sum_2;
					}
					att = 11 - at;
					if (juminno.charAt(12) != att ||
						juminno.substr(2,2) < '01' ||
						juminno.substr(2,2) > '12' ||
						juminno.substr(4,2) < '01' ||
						juminno.substr(4,2) > '31' ||
						juminno.charAt(6) > 4){
						this.error.result = true;
						this.error.type = 'alert';
						this.error.msg = '[' + o.label + '] 올바른 주민등록번호가 아닙니다';
					}
				}
			},

			valTaxno:function(ele, o){
				if(!o.taxno) return;
				var value = $(ele).val().replace(/[^\d]/g, '');
				var sum = 0;
				var getlist = new Array(10);
				var chkvalue = new Array('1','3','7','1','3','7','1','3','5');
				for(var i=0; i<10; i++) { getlist[i] = value.substring(i, i+1); }
				for(var i=0; i<9; i++) { sum += getlist[i]*chkvalue[i]; }
				sum = sum + parseInt((getlist[8]*5)/10);
				sidliy = sum % 10;
				sidchk = 0;
				if(sidliy != 0) { sidchk = 10 - sidliy; }
				else { sidchk = 0; }
				if(sidchk != getlist[9]){
					this.error.result = true;
					this.error.type = 'alert';
					this.error.msg = '[' + o.label + '] 잘못된 사업자등록번호입니다';
				}
			},

			valGroupcheck:function(ele, o){
				if(!o.groupcheck) return;
				var flag = false;
				ele = document.getElementsByName(ele.name);
				for(i=0;i<ele.length;i++) if(ele[i].checked) flag = true;

				if(!flag){
					this.error.result = true;
					this.error.type = 'alert';
					this.error.msg = '[' + o.label + '] 최소한 하나이상 체크하셔야 합니다';
				}
			},

			valZipcode:function(ele, o){
				if(!o.zipcode) return;
				var pattern = /^\d{3}-?\d{3}($)/;
				if(!pattern.test($(ele).val())){
					this.error.result = true;
					this.error.type = 'alert';
					this.error.msg = '[' + o.label + '] 우편번호가 잘못된것 같습니다';
				}
			},

			valUniq:function(ele, o){
				var validator = this;
				var data = {};
				data[$(ele).attr('name')] = encodeURIComponent($(ele).val());
				o.uniq = o.uniq;
				$.ajax({type:'post', async:false, url:o.uniq, data:data, success:function(data){
					if(data=='false'){
						validator.error.result = true;
						validator.error.type = 'print';
						validator.error.msg = '이미 사용중입니다';
					}
				}});
			}
		},

		//===========================================================================
		// Static 메쏘드
		//===========================================================================
		setResult:function(){
			var obj = {};
			obj.result = true;
			obj.msg = msg;
		},

		bothTrim:function(value){
			var pattern = /(^\s*)|(\s*$)/g;
			return value.replace(pattern, '');
		},

		ucfirst:function(value){
			str = value.toString();
			var x = str.split(/\s+/g);
			for (var i = 0; i < x.length; i++) {
				var parts = x[i].match(/(\w)(\w*)/);
				x[i] = parts[1].toUpperCase() + parts[2].toLowerCase();
			}
			return x.join(' ');
		}
	});
	$.extend({
		validate:function(){
			v = new $.validator();

			$(document.forms).each(function(){
				ref = this;
				$(this).submit(function(){
					return v.validCheck(ref);
				});
			});
		}
	});
})(jQuery);

function chkDefaultForm(f){
	v = new $.validator();
	return v.validCheck(f);
}

function chkChekboxEtc(el,v,etc, etcText){
	var chk = $("input[name='"+el+"']");
	var i = 0;
	var is_true = false;
	$("input[name='"+el+"']").each(
		function(){
			if(this.checked){
				if(chk[i].value == v){
					is_true = true;
				}
			}
			i++;
		}
	);
	if(is_true){
		$("#"+etc).show(); 
		$("#"+etc).addClass("{label:'"+etcText+"',required:true}"); 
	}
	else{
		$("#"+etc).hide(); 
		$("#"+etc).removeClass("{label:'"+etcText+"',required:true}"); 
	}

}