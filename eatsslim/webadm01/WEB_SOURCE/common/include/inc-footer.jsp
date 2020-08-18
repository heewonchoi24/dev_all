<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%
String query5			= "";
String query6			= "";
String query7			= "";
int footerNoticeId		= 0;
String footerTopYn		= "";
String footerContent	= "";
String footerTitle		= "";
Statement stmt5			= null;
ResultSet rs5			= null;
Statement stmt6			= null;
ResultSet rs6			= null;
Statement stmt7			= null;
ResultSet rs7			= null;


/* 공지사항 */
query6		= "SELECT ID, TOP_YN, TITLE, CONTENT, LIST_IMG, DATE_FORMAT(INST_DATE, '%Y.%m.%d') WDATE";
query6		+= " FROM ESL_NOTICE WHERE 1=1";
query6		+= " ORDER BY TOP_YN DESC, ID DESC";
query6		+= " LIMIT 4";
pstmt		= conn.prepareStatement(query6);

rs6			= pstmt.executeQuery();
/* 공지사항 갯수 */
query7		= "SELECT COUNT(*)";
query7		+= " FROM ESL_NOTICE";
pstmt		= conn.prepareStatement(query7);

rs7			= pstmt.executeQuery();
int noticeCnt 	= 0;
if(rs7.next()){
	noticeCnt = rs7.getInt(1);
}

// left banner
String query10                 = "";
String leftFirstImgFile        = "";
String leftFirstUrl            = "";
String leftSecondImgFile       = "";
String leftSecondUrl           = "";
String leftThirdImgFile        = "";
String leftThirdUrl            = "";
String leftBannerOpenYn        = "";
String leftBannerType          = "";

query10         = "SELECT LEFT_FIRST_IMGFILE, LEFT_FIRST_URL, LEFT_SECOND_IMGFILE, LEFT_SECOND_URL, LEFT_THIRD_IMGFILE, LEFT_THIRD_URL, LEFT_BANNER_OPEN_YN, LEFT_BANNER_TYPE ";
query10        += " FROM ESL_MAIN_BANNER ";
query10        += " WHERE ID = 1";
pstmt           = conn.prepareStatement(query10);
rs              = pstmt.executeQuery();

if (rs.next()) {
    leftFirstImgFile     = (rs.getString("LEFT_FIRST_IMGFILE") == null)? "" : rs.getString("LEFT_FIRST_IMGFILE");
    leftFirstUrl         = (rs.getString("LEFT_FIRST_URL") == null)? "" : rs.getString("LEFT_FIRST_URL");
    leftSecondImgFile    = (rs.getString("LEFT_SECOND_IMGFILE") == null)? "" : rs.getString("LEFT_SECOND_IMGFILE");
    leftSecondUrl        = (rs.getString("LEFT_SECOND_URL") == null)? "" : rs.getString("LEFT_SECOND_URL");
    leftThirdImgFile     = (rs.getString("LEFT_THIRD_IMGFILE") == null)? "" : rs.getString("LEFT_THIRD_IMGFILE");
    leftThirdUrl         = (rs.getString("LEFT_THIRD_URL") == null)? "" : rs.getString("LEFT_THIRD_URL");
	leftBannerOpenYn     = (rs.getString("LEFT_BANNER_OPEN_YN") == null)? "" : rs.getString("LEFT_BANNER_OPEN_YN");
    leftBannerType       = (rs.getString("LEFT_BANNER_TYPE") == null)? "" : rs.getString("LEFT_BANNER_TYPE");
}

%>

		<!-- Footer Include -->
		<div class="simply_board ff_noto">
			<div class="footer_inner">
				<div class="board_article article_notice">
					<h2>공지사항</h2>
					<ul>
					<%
						if(noticeCnt > 0){
							while(rs6.next()){
								footerNoticeId	= rs6.getInt("ID");
								footerTitle		= rs6.getString("TITLE");

								%>
									<li><a href="/customer/noticeView.jsp?id=<%=footerNoticeId%>" title="<%=footerTitle%>"><%=footerTitle%></a></li>
								<%
							}
						}else{
							%>
							<li><a href="javascript:void(0);">공지사항이 없습니다.</a></li>
							<%
						}
					%>
					</ul>
					<a href="/customer/notice.jsp" class="btn_more">+ more</a>
				</div>
				<div class="board_article article_guide">
					<!-- <h2>잇슬림 가이드</h2> -->
					<ul>
						<li>
						<a href="/customer/faq.jsp">
							<div class="circle"><img src="/dist/images/common/ico_fguide_faq.png" alt="" /></div>
							<p>FAQ</p>
						</a>
						</li>
						<li>
						<a href="/customer/indiqna.jsp">
							<div class="circle"><img src="/dist/images/common/ico_fguide_mantoman.png" alt="" /></div>
							<p>1:1 문의</p>
						</a>
						</li>
						<li>
						<!-- <a href="/shop/popup/AddressSearchJiPop.jsp?ztype=0003&lightbox[width]=808&lightbox[height]=740" class="lightbox">
							<div class="circle"><img src="/dist/images/common/ico_fguide_sdelivery.png" alt="" /></div>
							<p>배달지역 검색</p>
						</a> -->
						<a href="javascript:void(0);" onclick="window.open('/shop/popup/AddressSearchJiPop.jsp?ztype=0003','chk_zipcode','width=800,height=650,top=50,left=100,scrollbars=yes,resizable=no,toolbar=no,status=no,menubar=no');">
							<div class="circle"><img src="/dist/images/common/ico_fguide_sdelivery.png" alt="" /></div>
							<p>배달지역 검색</p>
						</a>
						</li>
					</ul>
				</div>
				<div class="board_article article_cc">
					<h2>고객기쁨센터</h2>
					<div class="phonenum">080.800.0434</div>
					<h3>기쁨센터 업무시간</h3>
					<p>평일 09:00 ~ 18:00 (토/일/공휴일 휴무)<br>카카오톡 Yellow ID : 풀무원잇슬림</p>
				</div>
			</div>
		</div>
		<div class="main_footer ff_noto">
			<div class="footer_inner">
				<div class="foot_logo"><img src="/dist/images/common/f_logo.png" alt="풀무원건강생활" /></div>
				<div class="foot_content">
					<div class="foot_nav">
						<ul>
							<li><a href="http://www.pulmuonelohas.co.kr/brand/eatsslim">회사소개</a></li>
							<li><a href="/customer/service_partnership.jsp">제휴문의</a></li>
							<!--<li><a href="http://www.pulmuonelohas.co.kr/lohas-life-companies/sustainable-business/consumer-oriented-management/ccm">CCM</a></li>-->
							<li><a href="http://www.ftc.go.kr/info/bizinfo/communicationViewPopup.jsp?wrkr_no=3018198406&lightbox[width]=808&lightbox[height]=740&lightbox[iframe]=true" class="lightbox">사업자정보확인</a></li>
							<li><a href="/terms/terms.jsp">이용약관</a></li>
							<li><a href="/customer/notice.jsp">고객센터</a></li>
							<li><a href="/terms/privacy.jsp"><span>개인정보처리방침</span></a></li>
						</ul>
					</div>
					<div class="foot_address">
						<address>㈜풀무원녹즙 : 충청북도 증평군 도안면 원명로 35<span></span>대표이사 : 김기석<span></span>사업자등록번호 : 301-81-98406<br>통신판매업 신고 : 충북증평 00045<span></span>개인정보관리책임자 : 장종의 담당<span></span>개인정보 보유기간 : 회원탈퇴시까지</address>
						<p class="copyright">Copyright&copy; Pulmuone Health&Living Co.Ltd. All rights reserved.</p>
					</div>
				</div>
				<div class="foot_right">
					<div class="familysite">
						<button type="button" class="fs_selector">패밀리사이트<img src="/dist/images/common/ico_familysite.png" alt=""></button>
						<div class="site_list">
							<p><a href="http://www.pulmuone.co.kr/" target="_blank">풀무원</a></p>
							<p><a href="http://www.pulmuoneshop.co.kr/" target="_blank">풀무원샵</a></p>
							<p><a href="http://www.pulmuonelohas.co.kr" target="_blank">풀무원건강생활</a></p>
							<p><a href="http://www.pulmuone-lohas.com" target="_blank">풀무원로하스</a></p>
							<p><a href="http://www.babymeal.co.kr/" target="_blank">풀무원베이비밀</a></p>
							<p><a href="http://www.pulmuonewater.com" target="_blank">풀무원샘물</a></p>
							<p><a href="http://www.greenjuice.co.kr" target="_blank">풀무원녹즙</a></p>
							<p><a href="http://www.orga.co.kr" target="_blank">올가홀푸드</a></p>
							<p><a href="http://www.foodmerce.co.kr" target="_blank">푸드머스</a></p>
							<p><a href="http://www.bruschetta.co.kr" target="_blank">브루스케타</a></p>
							<p><a href="http://www.kimchimuseum.co.kr" target="_blank">김치박물관</a></p>
							<p><a href="http://www.pungkyungmaru.co.kr" target="_blank">풍경마루</a></p>
							<p><a href="http://www.pulmuoneduskin.co.kr" target="_blank">풀무원더스킨</a></p>
							<p><a href="http://www.pulmuoneamio.com" target="_blank">풀무원아미오</a></p>
						</div>
					</div>
					<div class="foot_certificate">
						<img src="/dist/images/common/ico_footer_certify.png" alt="" />
					</div>
				</div>
			</div>
		</div>
				<!-- End footer_column -->
		<!-- End footer Include -->
    <div class="mobile-btn">
      <a href="/mobile/index.jsp">모바일 버전으로 보기<span class="arrow-return"></span></a>
    </div>

<script language="JavaScript">
function onopen()
{
	var url = "http://www.ftc.go.kr/info/bizinfo/communicationViewPopup.jsp?wrkr_no=3018198406";
	window.open(url, "communicationViewPopup", "width=750, height=700;");
}

function catToggle(t){
	var _this = $(t);
	categoryFn.onToggle('cat_sub', _this);
}
$(".cat_sub").on("mouseleave",function(){

	$(".cat_sub").removeClass("hasActived");
	$(".btn_category").removeClass("on");
});

$(".lnb button").on("mouseover",function(){
	lnbToggle(this, $(this).attr("class"));
});


<%-- <%if (eslMemberId.equals("")) {%>
<%}else{%>
<%}%> --%>

/* $(window).load(function(){
	$.lightbox("/shop/popup/loginCheck2.jsp", {
        'width'       : 376,
        'height'      : 520,
        'autoresize'  : false
      });
      return false;
}); */

 </script>

<!-- 공통 적용 스크립트 , 모든 페이지에 노출되도록 설치. 단 전환페이지 설정값보다 항상 하단에 위치해야함 -->
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"> </script>
<script type="text/javascript">
if (!wcs_add) var wcs_add={};
wcs_add["wa"] = "s_b09eedbeec1";
if (!_nasa) var _nasa={};
wcs.inflow();
wcs_do(_nasa);
</script>


<!-- AceCounter Log Gathering Script V.72.2013010701 -->
<script language='javascript'>
if(typeof _GUL == 'undefined'){
var _GUL = 'gtp16.acecounter.com';var _GPT='8080'; var _AIMG = new Image(); var _bn=navigator.appName; var _PR = location.protocol=="https:"?"https://"+_GUL:"http://"+_GUL+":"+_GPT;if( _bn.indexOf("Netscape") > -1 || _bn=="Mozilla"){ setTimeout("_AIMG.src = _PR+'/?cookie';",1); } else{ _AIMG.src = _PR+'/?cookie'; };
document.writeln("<scr"+"ipt language='javascript' src='/acecounter/acecounter_V70.js'></scr"+"ipt>");
}


</script>
<noscript><img src='http://gtp16.acecounter.com:8080/?uid=AM6A37517551695&je=n&' border=0 width=0 height=0></noscript>
<%
int mr_ag		= 0;
String mr_gd	= "";
if (!eslMemberId.equals("") && eslMemberId != null) {
	String sql	= "";
	sql		= "SELECT SEX, YEAR(CURDATE())-YEAR(BIRTH_DATE) AS AGE FROM ESL_MEMBER";
	sql		+= " WHERE MEM_ID = '"+ eslMemberId +"'";
	try {
		rs	= stmt.executeQuery(sql);
	} catch(Exception e) {
		out.println(e+"=>"+sql);
		if(true)return;
	}

	if (rs.next()) {
		mr_ag		= rs.getInt("AGE");
		mr_gd		= (rs.getString("SEX").equals("M"))? "man" : "woman";
	}
}
%>
<!-- AceCounter Log Gathering Script End -->
<script language='javascript' type='text/javascript'>
var mr_id = 'member';	// 로그인 회원판단( 'member' 고정값)
var mr_ag = <%=mr_ag%> ; 		// 로그인사용자 나이 (회원의 연령대 분석)
var mr_gd = '<%=mr_gd%>'; 		// 로그인사용자 성별 ('man' , 'woman')
</script>
<!-- AceClick WebSite Gathering Script V0.9.20131114 -->
<script type="text/Javascript">
if(typeof(AMRS_GC)=='undefined'){
 var AMRS_O=[];var AMRS_CK = new Image();var AMRS_GC='AG5A385344242';var AMRS_GD='mrsg.aceclick.co.kr';var AMRS_GP='80';var AMRS_TI=(new Date()).getTime();
 var AMRS_PR = location.protocol=="https:"?"https://"+AMRS_GD:"http://"+AMRS_GD+":"+AMRS_GP; AMRS_CK.src = AMRS_PR+'/?cookie';
 if(typeof(Array.prototype.push)!='undefined'){ AMRS_O.push(AMRS_CK);}
 document.writeln("<scr"+"ipt type='text/Javascript' src='"+location.protocol+"//mrss.aceclick.co.kr/aceclick.js?rt="+AMRS_TI+"'></scr"+"ipt>");
}
</script>
<!-- AceClick WebSite Gathering Script End V0.9.20131114 -->
<!-- ADWorks Common Script START --><script language="javascript">try{var _adws_un='1813';_adws_ckDmYn='Y';_adws_ver='22';_adws_src=location.protocol=="https:"?"https://"+"adws2.opms.co.kr/":"http://"+"js.adws.opms.co.kr/";_adws_src+="script/"+_adws_ver+"/"+"adworks.js";if((typeof _ADWS_CNT_)!='number'){var _ADWS_CNT_=0;};if(_ADWS_CNT_==0){_ADWS_CNT_++;eval("try{_vu=top.document.location.href;}catch(_e){_vu ='';};");eval("try{_svu=self.document.location.href;}catch(_e){_svu ='';};");if((_vu.indexOf("_OPMS_CK=")>-1&&_vu.indexOf("_OPMS_VID=")>-1&&_vu==_svu)||((typeof _OPMS_AN)!="undefined"&&_OPMS_AN!=""&&(typeof _OPMS_PN)!="undefined"&&_OPMS_PN!=""&&document.cookie.indexOf("_OPMS_LD_TID===")>-1)||((typeof _adws_dcTgYn)!="undefined"||_adws_dcTgYn!="")){document.write('<scr'+'ipt language="javascript" src="'+_adws_src+'"></scr'+'ipt>');};};}catch(e){}</script><!-- ADWorks Common Script END -->
<!-- AceCounter Log Gathering Script V.70.2012031601 -->
<script language='javascript'>
if( typeof HL_GUL == 'undefined' ){

var HL_GUL = 'ngc10.nsm-corp.com';var HL_GPT='80'; var _AIMG = new Image(); var _bn=navigator.appName; var _PR = location.protocol=="https:"?"https://"+HL_GUL:"http://"+HL_GUL+":"+HL_GPT;if( _bn.indexOf("Netscape") > -1 || _bn=="Mozilla"){ setTimeout("_AIMG.src = _PR+'/?cookie';",1); } else{ _AIMG.src = _PR+'/?cookie'; };
var _JV="AMZ2014031401";//script Version
var HL_GCD = 'CS4B39476115889'; // gcode
var _UD='undefined';var _UN='unknown';
function _IX(s,t){return s.indexOf(t)}
function _GV(b,a,c,d){ var f = b.split(c);for(var i=0;i<f.length; i++){ if( _IX(f[i],(a+d))==0) return f[i].substring(_IX(f[i],(a+d))+(a.length+d.length),f[i].length); }	return ''; }
function _XV(b,a,c,d,e){ var f = b.split(c);var g='';for(var i=0;i<f.length; i++){ if( _IX(f[i],(a+d))==0){ try{eval(e+"=f[i].substring(_IX(f[i],(a+d))+(a.length+d.length),f[i].length);");}catch(_e){}; continue;}else{ if(g) g+= '&'; g+= f[i];}; } return g;};
function _NOB(a){return (a!=_UD&&a>0)?new Object(a):new Object()}
function _NIM(){return new Image()}
function _IL(a){return a!=_UD?a.length:0}
function _ILF(a){ var b = 0; try{eval("b = a.length");}catch(_e){b=0;}; return b; }
function _VF(a,b){return a!=_UD&&(typeof a==b)?1:0}
function _LST(a,b){if(_IX(a,b)>0){ a=a.substring(0,_IX(a,b));}; return a;}
function _CST(a,b){if(_IX(a,b)>0) a=a.substring(_IX(a,b)+_IL(b),_IL(a));return a}
function _UL(a){a=_LST(a,'#');a=_CST(a,'://');return a}
function _AA(a){return new Array(a?a:0)}
function _IDV(a){return (typeof a!=_UD)?1:0}
if(!_IDV(HL_GUL)) var HL_GUL ='ngc10.nsm-corp.com';
if(!_IDV(HL_GPT)) var HL_GPT ='80';
_DC = document.cookie ;
function _AGC(nm) { var cn = nm + "="; var nl = cn.length; var cl = _DC.length; var i = 0; while ( i < cl ) { var j = i + nl; if ( _DC.substring( i, j ) == cn ){ var val = _DC.indexOf(";", j ); if ( val == -1 ) val = _DC.length; return unescape(_DC.substring(j, val)); }; i = _DC.indexOf(" ", i ) + 1; if ( i == 0 ) break; } return ''; }
function _ASC( nm, val, exp ){var expd = new Date(); if ( exp ){ expd.setTime( expd.getTime() + ( exp * 1000 )); document.cookie = nm+"="+ escape(val) + "; expires="+ expd.toGMTString() +"; path="; }else{ document.cookie = nm + "=" + escape(val);};}
function SetUID() {     var newid = ''; var d = new Date(); var t = Math.floor(d.getTime()/1000); newid = 'UID-' + t.toString(16).toUpperCase(); for ( var i = 0; i < 16; i++ ){ var n = Math.floor(Math.random() * 16).toString(16).toUpperCase(); newid += n; }       return newid; }
var _FCV = _AGC("ACEFCID"); if ( !_FCV ) { _FCV = SetUID(); _ASC( "ACEFCID", _FCV , 86400 * 30 * 12 ); _FCV=_AGC("ACEFCID");}
var _AIO = _NIM(); var _AIU = _NIM();  var _AIW = _NIM();  var _AIX = _NIM();  var _AIB = _NIM();  var __hdki_xit = _NIM();
var _gX='/?xuid='+HL_GCD+'&sv='+_JV,_gF='/?fuid='+HL_GCD+'&sv='+_JV,_gU='/?uid='+HL_GCD+'&sv='+_JV+"&FCV="+_FCV,_gE='/?euid='+HL_GCD+'&sv='+_JV,_gW='/?wuid='+HL_GCD+'&sv='+_JV,_gO='/?ouid='+HL_GCD+'&sv='+_JV,_gB='/?buid='+HL_GCD+'&sv='+_JV;

var _d=_rf=_end=_fwd=_arg=_xrg=_av=_bv=_rl=_ak=_xrl=_cd=_cu=_bz='',_sv=11,_tz=20,_ja=_sc=_ul=_ua=_UA=_os=_vs=_UN,_je='n',_bR='blockedReferrer';
if(!_IDV(_CODE)) var _CODE = '' ;
_tz = Math.floor((new Date()).getTimezoneOffset()/60) + 29 ;if( _tz > 24 ) _tz = _tz - 24 ;
// Javascript Variables
if(!_IDV(_amt)) var _amt=0 ;if(!_IDV(_pk)) var _pk='' ;if(!_IDV(_pd)) var _pd='';if(!_IDV(_ct)) var _ct='';
if(!_IDV(_ll)) var _ll='';if(!_IDV(_ag)) var _ag=0;	if(!_IDV(_id)) var _id='' ;if(!_IDV(_mr)) var _mr = _UN;
if(!_IDV(_gd)) var _gd=_UN;if(!_IDV(_jn)) var _jn='';if(!_IDV(_jid)) var _jid='';if(!_IDV(_skey)) var _skey='';
if(!_IDV(_ud1)) var _ud1='';if(!_IDV(_ud2)) var _ud2='';if(!_IDV(_ud3)) var _ud3='';
if( !_ag ){ _ag = 0 ; }else{ _ag = parseInt(_ag); }
if( _ag < 0 || _ag > 150 ){ _ag = 0; }
if( _gd != 'man' && _gd != 'woman' ){ _gd =_UN;};if( _mr != 'married' && _mr != 'single' ){ _mr =_UN;};if( _jn != 'join' && _jn != 'withdraw' ){ _jn ='';};
if( _ag > 0 || _gd == 'man' || _gd == 'woman'){ _id = 'undefined_member';}
if( _jid != '' ){ _jid = 'undefined_member'; }
_je = (navigator.javaEnabled()==true)?'1':'0';_bn=navigator.appName;
if(_bn.substring(0,9)=="Microsoft") _bn="MSIE";
_bN=(_bn=="Netscape"),_bI=(_bn=="MSIE"),_bO=(_IX(navigator.userAgent,"Opera")>-1);if(_bO)_bI='';
_bz=navigator.appName; _pf=navigator.platform; _av=navigator.appVersion; _bv=parseFloat(_av) ;
if(_bI){_cu=navigator.cpuClass;}else{_cu=navigator.oscpu;};
if((_bn=="MSIE")&&(parseInt(_bv)==2)) _bv=3.01;_rf=document.referrer;var _prl='';var _frm=false;
function _WO(a,b,c){window.open(a,b,c)}
function ACEF_Tracking(a,b,c,d,e,f){ if(!_IDV(b)){var b = 'FLASH';}; if(!_IDV(e)){ var e = '0';};if(!_IDV(c)){ var c = '';};if(!_IDV(d)){ var d = '';}; var a_org=a; b = b.toUpperCase(); var b_org=b;	if(b_org=='FLASH_S'){ b='FLASH'; }; if( typeof CU_rl == 'undefined' ) var CU_rl = _PT(); if(_IDV(HL_GCD)){ var _AF_rl = document.URL; if(a.indexOf('://') < 0  && b_org != 'FLASH_S' ){ var _AT_rl  = ''; if( _AF_rl.indexOf('?') > 0 ){ _AF_rl = _AF_rl.substring(0,_AF_rl.indexOf('?'));}; var spurl = _AF_rl.split('/') ;	for(var ti=0;ti < spurl.length ; ti ++ ){ if( ti == spurl.length-1 ){ break ;}; if( _AT_rl  == '' ){ _AT_rl  = spurl[ti]; }else{ _AT_rl  += '/'+spurl[ti];}; }; var _AU_arg = ''; if( a.indexOf('?') > 0 ){ _AU_arg = a.substring(a.indexOf('?'),a.length); a = a.substring(0,a.indexOf('?')); }; var spurlt = a.split('/') ; if( spurlt.length > 0 ){ a = spurlt[spurlt.length-1];}; a = _AT_rl +'/'+a+_AU_arg;	_AF_rl=document.URL;}; _AF_rl = _AF_rl.substring(_AF_rl.indexOf('//')+2,_AF_rl.length); if( typeof f == 'undefined' ){ var f = a }else{f='http://'+_AF_rl.substring(0,_AF_rl.indexOf('/')+1)+f}; var _AS_rl = CU_rl+'/?xuid='+HL_GCD+'&url='+escape(_AF_rl)+'&xlnk='+escape(f)+'&fdv='+b+'&idx='+e+'&'; var _AF_img = new Image(); _AF_img.src = _AS_rl; if( b_org == 'FLASH' && a_org != '' ){ if(c==''){ window.location.href = a_org; }else{ if(d==''){ window.open(a_org,c);}else{ window.open(a_org,c,d); };};	};} ; }
function _PT(){return location.protocol=="https:"?"https://"+HL_GUL:"http://"+HL_GUL+":"+HL_GPT}
function _EL(a,b,c){if(a.addEventListener){a.addEventListener(b,c,false)}else if(a.attachEvent){a.attachEvent("on"+b,c)} }
function _NA(a){return new Array(a?a:0)}
function HL_ER(a,b,c,d){_xrg=_PT()+_gW+"&url="+escape(_UL(document.URL))+"&err="+((typeof a=="string")?a:"Unknown")+"&ern="+c+"&bz="+_bz+"&bv="+_vs+"&RID="+Math.random()+"&";
if(_IX(_bn,"Netscape") > -1 || _bn == "Mozilla"){ setTimeout("_AIW.src=_xrg;",1); } else{ _AIW.src=_xrg; } }
function HL_PL(a){if(!_IL(a))a=_UL(document.URL);
_arg = _PT()+_gU;
if( typeof HL_ERR !=_UD && HL_ERR == 'err'){ _arg = _PT()+_gE;};
if( _ll.length > 0 ) _arg += "&md=b";
_AIU.src = _arg+"&url="+escape(a)+"&ref="+escape(_rf)+"&cpu="+_cu+"&bz="+_bz+"&bv="+_vs+"&os="+_os+"&dim="+_d+"&cd="+_cd+"&je="+_je+"&jv="+_sv+"&tz="+_tz+"&ul="+_ul+"&ad_key="+escape(_ak)+"&skey="+escape(_skey)+"&age="+_ag+"&gender="+_gd+"&marry="+_mr+"&join="+_jn+"&member_key="+_id+"&jid="+_jid+"&udf1="+_ud1+"&udf2="+_ud2+"&udf3="+_ud3+"&amt="+_amt+"&frwd="+_fwd+"&pd="+escape(_pd)+"&ct="+escape(_ct)+"&ll="+escape(_ll)+"&RID="+Math.random()+"&";
setTimeout("",300);
}
_EL(window,"error",HL_ER); //window Error
if( typeof window.screen == 'object'){_sv=12;_d=screen.width+'*'+screen.height;_sc=_bI?screen.colorDepth:screen.pixelDepth;if(_sc==_UD)_sc=_UN;}
_ro=_NA();if(_ro.toSource||(_bI&&_ro.shift))_sv=13;
if( top && typeof top == 'object' &&_ILF(top.frames)){eval("try{_rl=top.document.URL;}catch(_e){_rl='';};"); if( _rl != document.URL ) _frm = true;};
if(_frm){ eval("try{_prl = top.document.URL;}catch(_e){_prl=_bR;};"); if(_prl == '') eval("try{_prl=parent.document.URL;}catch(_e){_prl='';};");
if( _IX(_prl,'#') > 0 ) _prl=_prl.substring(0,_IX(_prl,'#'));
_prl=_LST(_prl,'#');
if( _IX(_rf,'#') > 0 ) _rf=_rf.substring(0,_IX(_rf,'#'));
if( _IX(_prl,'/') > 0 && _prl.substring(_prl.length-1,1) == '/' ) _prl =_prl.substring(0,_prl.length-1);
if( _IX(_rf,'/') > 0 && _rf.substring(_rf.length-1,1) == '/' ) _rf =_rf.substring(0,_rf.length-1);
if( _rf == '' ) eval("try{_rf=parent.document.URL;}catch(_e){_rf=_bR;}");
if(_rf==_bR||_prl==_bR){ _rf='',_prl='';}; if( _rf == _prl ){ eval("try{_rf=top.document.referrer;}catch(_e){_rf='';}");
if( _rf == ''){ _rf = 'bookmark';};if( _IX(document.cookie,'ACEN_CK='+escape(_rf)) > -1 ){ _rf = _prl;}
else{
if(_IX(_prl,'?') > 0){ _ak = _prl.substring(_IX(_prl,'?')+1,_prl.length); _prl = _ak; }
if( _IX(_prl.toUpperCase(),'OVRAW=') >= 0 ){ _ak = 'src=overture&kw='+_GV(_prl.toUpperCase(),'OVRAW','&','=')+'&OVRAW='+_GV(_prl.toUpperCase(),'OVRAW','&','=')+'&OVKEY='+_GV(_prl.toUpperCase(),'OVKEY','&','=')+'&OVMTC='+_GV(_prl.toUpperCase(),'OVMTC','&','=').toLowerCase() };
if(_IX(_prl,'gclid=') >= 0 ){ _ak='src=adwords'; }; if(_IX(_prl,'DWIT=') >= 0 ){_ak='src=dnet_cb';};
if( _IX(_prl,"rcsite=") >= 0 &&  _IX(_prl,"rctype=") >= 0){ _prl += '&'; _ak = _prl.substring(_IX(_prl,'rcsite='),_prl.indexOf('&',_IX(_prl,'rcsite=')+7))+'-'+_prl.substring(_IX(_prl,'rctype=')+7,_prl.indexOf('&',_IX(_prl,'rctype=')+7))+'&'; };
if( _GV(_prl,'src','&','=') ) _ak += '&src='+_GV(_prl,'src','&','='); if( _GV(_prl,'kw','&','=') ) _ak += '&kw='+_GV(_prl,'kw','&','=');
if( _IX(_prl, 'FWDRL')> 0 ){ _prl = _XV(_prl,'FWDRL','&','=','_rf'); _rf = unescape(_rf); }; if( _IX(_ak,'FWDRL') > 0 ){_ak = _XV(_ak,'FWDRL','&','=','_prl');}; if( typeof FD_ref=='string' && FD_ref != '' ) _rf = FD_ref; _fwd = _GV(_prl,'FWDIDX','&','=');
document.cookie='ACEN_CK='+escape(_rf)+';path=/;';
};
if(document.URL.indexOf('?')>0 && ( _IX(_ak,'rcsite=') < 0 && _IX(_ak,'NVAR=') < 0 && _IX(_ak,'src=') < 0 && _IX(_ak,'source=') < 0 && _IX(_ak,'DMCOL=') < 0 ) ) _ak =document.URL.substring(document.URL.indexOf('?')+1,document.URL.length); };
}
else{
_rf=_LST(_rf,'#');_ak=_CST(document.URL,'?');
if( _IX(_ak,"rcsite=") > 0 &&  _IX(_ak,"rctype=") > 0){
    _ak += '&';
    _ak = _ak.substring(_IX(_ak,'rcsite='),_ak.indexOf('&',_IX(_ak,'rcsite=')+7))+'-'+_ak.substring(_IX(_ak,'rctype=')+7,_ak.indexOf('&',_IX(_ak,'rctype=')+7))+'&';
}
}
_rl=document.URL;
var _trl = _rl.split('?'); if(_trl.length>1){ if( _IX(_trl[1],'FWDRL') > 0 ){ _trl[1] = _XV(_trl[1],'FWDRL','&','=','_rf'); _rf = unescape(_rf); _fwd = _GV(_trl[1],'FWDIDX','&','='); _rl=_trl.join('?'); };  if( _IX(_ak,'FWDRL') > 0 ){ _ak = _XV(_ak,'FWDRL','&','=','_prl');}; }; if( typeof FD_ref=='string' && FD_ref != '' ) _rf = FD_ref;
if( _rf.indexOf('googlesyndication.com') > 0 ){
var _rf_idx = _rf.indexOf('&url=');  if( _rf_idx > 0 ){ var _rf_t = unescape(_rf.substring(_rf_idx+5,_rf.indexOf('&',_rf_idx+5)));  if( _rf_t.length > 0 ){ _rf = _rf_t ;};  };  };
_rl = _UL(_rl); _rf = _UL(_rf);

if( typeof _rf_t != 'undefined' && _rf_t != '' ) _rf = _rf_t ;
if( typeof _ak_t != 'undefined' && _ak_t != '' ) _ak = _ak_t ;

if( typeof _rf==_UD||( _rf == '' )) _rf = 'bookmark' ;_cd=(_bI)?screen.colorDepth:screen.pixelDepth;
_UA = navigator.userAgent;_ua = navigator.userAgent.toLowerCase();
if (navigator.language){  _ul = navigator.language.toLowerCase();}else if(navigator.userLanguage){  _ul = navigator.userLanguage.toLowerCase();};

_st = _IX(_UA,'(') + 1;_end = _IX(_UA,')');_str = _UA.substring(_st, _end);_if = _str.split('; ');_cmp = _UN ;

if(_bI){ _cmp = navigator.appName; _str = _if[1].substring(5, _if[1].length); _vs = (parseFloat(_str)).toString();}
else if ( (_st = _IX(_ua,"opera")) > 0){ _cmp = "Opera" ;_vs = _ua.substring(_st+6, _ua.indexOf('.',_st+6)); }
else if ((_st = _IX(_ua,"firefox")) > 0){_cmp = "Firefox"; _vs = _ua.substring(_st+8, _ua.indexOf('.',_st+8)); }
else if ((_st = _IX(_ua,"netscape6")) > 0){ _cmp = "Netscape"; _vs = _ua.substring(_st+10, _ua.length);
if ((_st = _IX(_vs,"b")) > 0 ) { _str = _vs.substring(0,_IX(_vs,"b")); _vs = _str ;  };}
else if ((_st = _IX(_ua,"netscape/7")) > 0){  _cmp = "Netscape";  _vs = _ua.substring(_st+9, _ua.length);  if ((_st = _IX(_vs,"b")) > 0 ){ _str = _vs.substring(0,_IX(_vs,"b")); _vs = _str;};
}
else{
if (_IX(_ua,"gecko") > 0){ if(_IX(_ua,"safari")>0){ _cmp = "Safari";_ut = _ua.split('/');for( var ii=0;ii<_ut.length;ii++) if(_IX(_ut[ii],'safari')>0){ _vst = _ut[ii].split(' '); _vs = _vst[0];} }else{ _cmp = navigator.vendor;  } } else if (_IX(_ua,"nav") > 0){ _cmp = "Netscape Navigator";}else{ _cmp = navigator.appName;}; _av = _UA ;
}
if (_IX(_vs,'.')<0){  _vs = _vs + '.0'}
_bz = _cmp;


var nhn_ssn={uid:HL_GCD,g:HL_GUL,p:HL_GPT,s:_JV,rl:_rl,m:[],run:nhn_ssn?nhn_ssn.uid:this.uid};
function CS4B39476115889(){var f={e:function(s,t){return s.indexOf(t);},d:function(s){var r=String(s); return r.toUpperCase();},f:function(o){var a;a=o;if(f.d(a.tagName)=='A' || f.d(a.tagName)=='AREA'){return a;}else if(f.d(a.tagName)=='BODY'){return 0;}else{return f.f(a.parentNode);} },n:function(s){var str=s+"";var ret="";for(i = 0; i < str.length; i++){	var at = str.charCodeAt(i);var ch=String. fromCharCode(at);	if(at==10 || at==32){ret+=''+ch.replace(ch,'');}else if (at==34||at==39|at==35){ret+=''+ch.replace(ch,' ');	}else{ret+=''+ch;}  } return ret;},ea:function(c,f){var wd;if(c=='click'){wd=window.document;}else{wd=window;}if(wd.addEventListener){wd.addEventListener(c,f,false)}else if(wd.attachEvent){wd.attachEvent("on"+c,f)} } };
var p={h:location.host,p:(location.protocol=='https:')?"https://"+nhn_ssn.g:"http://"+nhn_ssn.g+":"+nhn_ssn.p,s:'/?xuid='+nhn_ssn.uid+'&sv='+nhn_ssn.s,u:function(){var r='';r=String(nhn_ssn.rl);var sh=r.indexOf('#'); if(sh!=-1){r=r.substring(0,sh);}return r+'';},ol:new Image(0,0),xL:function(x){if(typeof(Amz_T_e)==s.u){ p.ol.src=p.p+p.s+'&url='+escape(p.u())+'&xlnk='+escape(x)+'&xidx=0'+'&crn='+Math.random()+'&';nhn_ssn.m.push(p.ol);} } };
var s={Lp:'a.tagName=="B" || a.tagName=="I" || a.tagName== "U" || a.tagName== "FONT" || a.tagName=="I" || a.tagName=="STRONG"'  ,f:'function',	j:'javascript:',u:'undefined'};var c={Run:function(){f.ea('click',this.ec);},ec:function(e){var ok='';var m = document.all ? event.srcElement : e.target;var a=m;var o=m.tagName;if(o=="A" || o=="AREA" || o=="IMG" || eval(s.Lp)){ok=c.lc(m);if(ok.length != 0){p.xL(unescape(ok));};	};},lc:function(o){ try{var ar='';var obj;obj=f.f(o);if(typeof obj==s.u){return '';};if(typeof(obj.href)==s.u){return '';};ar = String(obj.href);if(ar.length == 0){return '';};ar=f.n(ar);if(f.e(ar,'void(') == -1 && f.e(ar,'void0') == -1){	return ar;}else{return s.j + 'void(0)';};return '';}catch(er){return '';} } };
if(p.u().charAt(1) != ':'){if(nhn_ssn.uid!=nhn_ssn.run){c.Run(); } };
};eval(nhn_ssn.uid + '();');


if( _IX(_pf,_UD) >= 0 || _pf ==  '' ){ _os = _UN ;}else{ _os = _pf ; };
if( _IX(_os,'Win32') >= 0 ){if( _IX(_av,'98')>=0){ _os = 'Windows 98';}else if( _IX(_av,'95')>=0 ){ _os = 'Windows 95';}else if( _IX(_av,'Me')>=0 ){ _os = 'Windows Me';}else if( _IX(_av,'NT')>=0 ){ _os = 'Windows NT';}else{ _os = 'Windows';};if( _IX(_ua,'nt 5.0')>=0){ _os = 'Windows 2000';};if( _IX(_ua,'nt 5.1')>=0){_os = 'Windows XP';if( _IX(_ua,'sv1') > 0 ){_os = 'Windows XP SP2';};};if( _IX(_ua,'nt 5.2')>=0){_os ='Windows Server 2003';};if( _IX(_ua,'nt 6.0')>=0){_os ='Windows Vista';};if( _IX(_ua,'nt 6.1')>=0){_os ='Windows 7';};};
_pf_s = _pf.substring(0,4);if( _pf_s == 'Wind'){if( _pf_s == 'Win1'){_os = 'Windows 3.1';}else if( _pf_s == 'Mac6' ){ _os = 'Mac';}else if( _pf_s == 'MacO' ){ _os ='Mac';}else if( _pf_s == 'MacP' ){_os='Mac';}else if(_pf_s == 'Linu'){_os='Linux';}else if( _pf_s == 'WebT' ){ _os='WebTV';}else if(  _pf_s =='OSF1' ){ _os ='Compaq Open VMS';}else if(_pf_s == 'HP-U' ){ _os='HP Unix';}else if(  _pf_s == 'OS/2' ){ _os = 'OS/2' ;}else if( _pf_s == 'AIX4' ){ _os = 'AIX';}else if( _pf_s == 'Free' ){ _os = 'FreeBSD';}else if( _pf_s == 'SunO' ){ _os = 'SunO';}else if( _pf_s == 'Drea' ){ _os = 'Drea'; }else if( _pf_s == 'Plan' ){ _os = 'Plan'; }else{ _os = _UN; };};
if( _cu == 'x86' ){ _cu = 'Intel x86';}else if( _cu == 'PPC' ){ _cu = 'Power PC';}else if( _cu == '68k' ){ _cu = 'Motorola 680x';}else if( _cu == 'Alpha' ){ _cu = 'Compaq Alpa';}else if( _cu == 'Arm' ){ _cu = 'ARM';}else{ _cu = _UN;};if( _d == '' || typeof _d==_UD ){ _d = '0*0';}

HL_PL(_rl); // Site Logging
}
</script>
<!-- AceCounter Log Gathering Script End -->

<!-- Withpang Tracker v2.0 start -->
<script type="text/javascript">
<!--
	(function (w, d, i) {
		w[i]={
			sc : (encodeURIComponent("")),
			form : (encodeURIComponent(d.referrer)),
			url : (encodeURIComponent(w.location.href))
		};

		if(w[i]) {
			var _ar = _ar || [];
			var _s = "log.dreamsearch.or.kr/servlet/rf";
			for(x in w[i]) _ar.push(x + "=" + w[i][x]);
			(new Image).src = d.location.protocol +"//"+ _s +"?"+ _ar.join("&");
		}
	})(window, document, "wp_rf");
//-->
</script>
<!-- Withpang Tracker v2.0 end -->

<!-- WIDERPLANET  SCRIPT START 2015.12.22 -->
<div id="wp_tg_cts" style="display:none;"></div>
<script type="text/javascript">
var wptg_tagscript_vars = wptg_tagscript_vars || [];
wptg_tagscript_vars.push(
(function() {
	return {
		wp_hcuid:"",   /*Cross device targeting을 원하는 광고주는 로그인한 사용자의 Unique ID (ex. 로그인 ID, 고객넘버 등)를 암호화하여 대입.
				*주의: 로그인 하지 않은 사용자는 어떠한 값도 대입하지 않습니다.*/
		ti:"25218",	/*광고주 코드*/
		ty:"Home",	/*트래킹태그 타입*/
		device:"web"	/*디바이스 종류 (web 또는 mobile)*/

	};
}));
</script>
<script type="text/javascript" async src="//astg.widerplanet.com/js/wp_astg_4.0.js"></script>
<!-- // WIDERPLANET  SCRIPT END 2015.12.22 -->

<!-- 미디어큐브 스크립트 2016-03-07 -->
<script language='JavaScript1.1' src='//pixel.mathtag.com/event/js?mt_id=934429&mt_adid=158356&v1=&v2=&v3=&s1=&s2=&s3='></script>

<!-- N2S 스크립트 광고  수집용 Start 2016.06.24 -->
<script language="javascript" src="//web.n2s.co.kr/js/_n2s_sp_log_ecmdmkt.js"></script>
<!-- N2S 스크립트 광고  수집용 End -->

<!-- LEFT BANNER Start 2018.11.12 -->
<div id="left_banner">
	<div class="inner">
		<ul class="banner_list">
			<!--  
			<li class="li0">
				<a href="javascript:void(0);" onclick="event_personal_pop();"><img src="/images/promotion/left_banner_01.jpg"></a>
			</li>
			-->
			<li class="li1" style="display:none;">
				<% if(!"".equals(leftFirstImgFile)) { %>
				<a href="<%=leftFirstUrl%>"><img src="/data/promotion/<%=leftFirstImgFile%>"></a>
				<% } %>
			</li>
			<li class="li2" style="display:none;">
				<% if(!"".equals(leftSecondImgFile)) { %>
				<a href="<%=leftSecondUrl%>"><img src="/data/promotion/<%=leftSecondImgFile%>"></a>
				<% } %>
			</li>
			<li class="li3" style="display:none;">
				<% if(!"".equals(leftThirdImgFile)) { %>
				<a href="<%=leftThirdUrl%>"><img src="/data/promotion/<%=leftThirdImgFile%>"></a>
				<% } %>
			</li>
		</ul>
	</div>
</div>
<script type="text/javascript">
var leftFirstImgFile = "<%=leftFirstImgFile%>";
var leftSecondImgFile = "<%=leftSecondImgFile%>";
var leftThirdImgFile = "<%=leftThirdImgFile%>";
var leftBannerOpenYn = "<%=leftBannerOpenYn%>";
var leftBannerType = "<%=leftBannerType%>";
if(leftBannerOpenYn == "N"){
	$("#left_banner").hide();
}else{
	if(leftBannerType == "left_type1"){
		if(leftFirstImgFile.length > 0){
			$(".li1").show();
		}
	}
	if(leftBannerType == "left_type2"){
		if(leftFirstImgFile.length > 0 && leftSecondImgFile.length > 0){
			$(".li1").show();
			$(".li2").show();
		}
	}
	if(leftBannerType == "left_type3"){
		if(leftFirstImgFile.length > 0 && leftSecondImgFile.length > 0 && leftThirdImgFile.length > 0){
			$(".li1").show();
			$(".li2").show();
			$(".li3").show();
		}
	}
}
function event_personal_pop() {
	window.open('/promotion/personal.jsp', 'event_personal_pop', 'width=480, height=760, scrollbars=yes, toolbar=0, menubar=no');
}

function eventCallBack(){
   var url = "/shop/popup/loginCheck.jsp";
	   $.lightbox(url, {
		width  : 640,
		height : 740
	});
}
</script>
<!-- LEFT BANNER End 2018.11.12 -->

<!-- Google 리마케팅 태그 코드 -->
<script type="text/javascript">
/* <![CDATA[ */
var google_conversion_id = 850532697;
var google_custom_params = window.google_tag_params;
var google_remarketing_only = true;
/* ]]> */
</script>

<!-- Enliple Common Tracker v3.5 [공용] start 2019-01-02 -->
<script type="text/javascript">
<!--
    function mobRf(){
        var rf = new EN();
		rf.setData("userid", "eatsslim");
        rf.setSSL(true);
        rf.sendRf();
    }
//-->
</script>
<script src="https://cdn.megadata.co.kr/js/en_script/3.5/enliple_sns_min3.5.js" defer="defer" onload="mobRf()"></script>
<!-- Enliple Common Tracker v3.5 [공용] end -->

<script type="text/javascript" src="//www.googleadservices.com/pagead/conversion.js">
</script>
<noscript>
<div style="display:inline;">
<img height="1" width="1" style="border-style:none;" alt="" src="//googleads.g.doubleclick.net/pagead/viewthroughconversion/850532697/?guid=ON&amp;script=0"/>
</div>
</noscript>

<script type="text/javascript">
(function(w, d, a){
	w.__beusablerumclient__ = {
		load : function(src){
			var b = d.createElement("script");
			b.src = src; b.async=true; b.type = "text/javascript";
			d.getElementsByTagName("head")[0].appendChild(b);
		}
	};w.__beusablerumclient__.load(a);
})(window, document, '//rum.beusable.net/script/b170626e173427u675/447930cbb8');
</script>

<script type="text/javascript" src="//static.tagmanager.toast.com/tag/view/880"></script>
<script type="text/javascript">
 window.ne_tgm_q = window.ne_tgm_q || [];
 window.ne_tgm_q.push(
 {
 	tagType: 'visit',
 	device:'web'/*web, mobile, tablet*/,
 	uniqValue:'',
 	pageEncoding:'utf-8'
 });
 </script>