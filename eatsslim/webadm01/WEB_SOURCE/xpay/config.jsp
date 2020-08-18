<%//@ page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
    /*
     * [상점결제 환경 설정]
     */
	long currentTime = System.currentTimeMillis();
	SimpleDateFormat simDf = new SimpleDateFormat("yyyyMMddHHmmss");
	String TIMESTAMP=simDf.format(new Date(currentTime));
     
    /*
     * 1. 기본결제정보 변경
     *
     * 결제기본정보를 변경하여 주시기 바랍니다. 
     */
    String platform             = "service";                         //LG유플러스 결제서비스 선택(test:테스트, service:서비스)                                              
	//String platform             = "test";                         //LG유플러스 결제서비스 선택(test:테스트, service:서비스)                                              
	String CST_MID              = "eatsslim1";                          //LG유플러스으로 부터 발급받으신 상점아이디를 입력하세요. 
                                                                                            //테스트 아이디는 't'를 제외하고 입력하세요.
    String LGD_MID              = ("test".equals(platform)?"t":"")+CST_MID;                     //상점아이디(자동생성)   
    String LGD_OID              = "";                          //주문번호(상점정의 유니크한 주문번호를 입력하세요)
    String LGD_AMOUNT           = "";                       //결제금액("," 를 제외한 결제금액을 입력하세요)
    String LGD_MERTKEY          = "d8cab7aedcf65d8a5722b0620aab9894";                      //상점MertKey(mertkey는 상점관리자 -> 계약정보 -> 상점정보관리에서 확인하실수 있습니다)

	
    String LGD_TIMESTAMP        = TIMESTAMP;                    //타임스탬프(현재시간 예)20090226110637
    
    /*
     * 2. 결제결과 DB처리 페이지 링크 변경
     *
     * LGD_NOTEURL : 상점결제결과 처리(DB) 페이지 URL을 넘겨주세요.
     * LGD_CASNOTEURL : 가상계좌(무통장) 결제 연동을 하시는 경우 아래 LGD_CASNOTEURL 을 설정하여 주시기 바랍니다.
     */
    String LGD_NOTEURL      	= "";                      //URL을 변경해 주세요
 	String LGD_CASNOTEURL		= ""; //아래에서 기입

	//========================취소처리용
	String CST_PLATFORM         = platform;
	String configPath 			= "C:/lgdacom";  //LG유플러스에서 제공한 환경파일("/conf/lgdacom.conf") 위치 지정.

	configPath="/home/webadm01/WEB_SOURCE/esl_admin/lgdacom";
	LGD_NOTEURL      	= "http://www.eatsslim.co.kr/xpay/note_url.jsp";
	LGD_CASNOTEURL		= "http://www.eatsslim.co.kr/xpay/cas_noteurl.jsp";



	String PortNum=("test".equals(CST_PLATFORM.trim())?":7085":""); //포트번호
	//==================================
%>