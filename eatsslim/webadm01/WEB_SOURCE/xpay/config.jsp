<%//@ page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
    /*
     * [�������� ȯ�� ����]
     */
	long currentTime = System.currentTimeMillis();
	SimpleDateFormat simDf = new SimpleDateFormat("yyyyMMddHHmmss");
	String TIMESTAMP=simDf.format(new Date(currentTime));
     
    /*
     * 1. �⺻�������� ����
     *
     * �����⺻������ �����Ͽ� �ֽñ� �ٶ��ϴ�. 
     */
    String platform             = "service";                         //LG���÷��� �������� ����(test:�׽�Ʈ, service:����)                                              
	//String platform             = "test";                         //LG���÷��� �������� ����(test:�׽�Ʈ, service:����)                                              
	String CST_MID              = "eatsslim1";                          //LG���÷������� ���� �߱޹����� �������̵� �Է��ϼ���. 
                                                                                            //�׽�Ʈ ���̵�� 't'�� �����ϰ� �Է��ϼ���.
    String LGD_MID              = ("test".equals(platform)?"t":"")+CST_MID;                     //�������̵�(�ڵ�����)   
    String LGD_OID              = "";                          //�ֹ���ȣ(�������� ����ũ�� �ֹ���ȣ�� �Է��ϼ���)
    String LGD_AMOUNT           = "";                       //�����ݾ�("," �� ������ �����ݾ��� �Է��ϼ���)
    String LGD_MERTKEY          = "d8cab7aedcf65d8a5722b0620aab9894";                      //����MertKey(mertkey�� ���������� -> ������� -> ���������������� Ȯ���ϽǼ� �ֽ��ϴ�)

	
    String LGD_TIMESTAMP        = TIMESTAMP;                    //Ÿ�ӽ�����(����ð� ��)20090226110637
    
    /*
     * 2. ������� DBó�� ������ ��ũ ����
     *
     * LGD_NOTEURL : ����������� ó��(DB) ������ URL�� �Ѱ��ּ���.
     * LGD_CASNOTEURL : �������(������) ���� ������ �Ͻô� ��� �Ʒ� LGD_CASNOTEURL �� �����Ͽ� �ֽñ� �ٶ��ϴ�.
     */
    String LGD_NOTEURL      	= "";                      //URL�� ������ �ּ���
 	String LGD_CASNOTEURL		= ""; //�Ʒ����� ����

	//========================���ó����
	String CST_PLATFORM         = platform;
	String configPath 			= "C:/lgdacom";  //LG���÷������� ������ ȯ������("/conf/lgdacom.conf") ��ġ ����.

	configPath="/home/webadm01/WEB_SOURCE/esl_admin/lgdacom";
	LGD_NOTEURL      	= "http://www.eatsslim.co.kr/xpay/note_url.jsp";
	LGD_CASNOTEURL		= "http://www.eatsslim.co.kr/xpay/cas_noteurl.jsp";



	String PortNum=("test".equals(CST_PLATFORM.trim())?":7085":""); //��Ʈ��ȣ
	//==================================
%>