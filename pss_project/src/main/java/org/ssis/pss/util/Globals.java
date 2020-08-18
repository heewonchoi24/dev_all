package org.ssis.pss.util;


public class Globals {

	/* 코드 대분류 */
    public static final String INSTT_UPPER_CD = "IC00";					// 기관상위코드
    public static final String EVAL_STATUS_UPPER_CD = "ES00";	// 평가상태상위코드
    public static final String MNG_LEVEL_UPPER_CD = "ML00";		// 관리수준 구분 상위코드
    
    /* 코드 */
    public static final String MNG_LEVEL_CD = "ML01";					// 관리수준 구분 코드
    public static final String STATUS_EXAMIN_CD = "ML02";			// 관리수준 구분 코드
    public static final String PINN_CD = "ML03";								// 관리수준 구분 코드
    
    /* 관리수준 진단, 현황조사 기간 설정 */
    public static final String MNG_LEVEL_INS = "A";							// 실적등록
    public static final String MNG_LEVEL_EVAL_MID = "B";				// 서면평가(중간)
    public static final String MNG_LEVEL_EVAL_FOBJCT = "C";			// 서면평가(이의신청)
    public static final String MNG_LEVEL_EVAL_FIN = "D";					// 서면평가(최종)
    public static final String STATUS_EXAMIN_EVAL_MID = "E";		// 현장점검(중간)
    public static final String STATUS_EXAMIN_EVAL_FOBJCT = "F";	// 현장점검(이의신청)
    public static final String STATUS_EXAMIN_EVAL_FIN = "G";		// 현장점검(최종)
    
    /* 평가 타입 */
    public static final String EVAL_TYPE_SCORE = "A";						// 점수
    public static final String EVAL_TYPE_SCORE_SE = "B";					// 수준
}
