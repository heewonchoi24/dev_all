package org.ssis.pss.cmn.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.cmn.util.AbstractExcelPOIView;
import org.ssis.pss.cmn.util.WebFactoryUtil;
import org.ssis.pss.util.Globals;

import egovframework.com.cmm.SessionVO;

public class ExcelDownloadView extends AbstractExcelPOIView{
	
	@SuppressWarnings("unchecked")
    @Override
    protected void buildExcelDocument(Map<String, Object> model, Workbook workbook
            , HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String excelName = (String)model.get("downName");
		
		Sheet sheet = workbook.createSheet(excelName);
		
		if("mngLevelIndex".equals(excelName)) {
			mIndexExcelDownload(sheet, model, response);
		} else if("statusExaminIndex".equals(excelName)) {
			sIndexExcelDownload(sheet, model, response);
		} else if("mngLevelResult".equals(excelName)) {
			mResultExcelDownload(sheet, model, request, response);
		} else if("statusExaminResult".equals(excelName)) {
			sResultExcelDownload(sheet, model, response);
		} else if("statusExaminDtlResult".equals(excelName)) {
			sDtlResultExcelDownload(sheet, model, response);
		} else if("qestnarExcelDown".equals(excelName)) {
			qestnarExcelDown(sheet, model, response);
		} else if("userExcelDown".equals(excelName)) {
			userExcelDown(sheet, model, response);
		} else if("institutionUser".equals(excelName)) {
			institutionUser(sheet, model, response);
		} else if("insctrUser".equals(excelName)) {
			insctrUser(sheet, model, response);
		}
	}

    @Override
    protected Workbook createWorkbook() {
        return new XSSFWorkbook();
    }
    
    public void mIndexExcelDownload(Sheet sheet, Map<String, Object> model, HttpServletResponse response) {
		
		Row row = null;
		int rowCount = 0;
		int cellCount = 0;
		
		row = sheet.createRow(rowCount++);
		
		row.createCell(cellCount++).setCellValue("연도");
		row.createCell(cellCount++).setCellValue("대분류");
		row.createCell(cellCount++).setCellValue("중분류");
		row.createCell(cellCount++).setCellValue("점검항목");
		row.createCell(cellCount++).setCellValue("예외여부");
		
		List<ZValue> resultList = (List<ZValue>) model.get("resultList");
		
		logger.debug("########### PssBbsExcelDownloadView ###########");
		
		if(resultList.size() > 0) {
			for(ZValue result : resultList){
				row = sheet.createRow(rowCount++);
				cellCount = 0;
				row.createCell(cellCount++).setCellValue(result.getValue("orderNo"));
				row.createCell(cellCount++).setCellValue(result.getValue("lclas"));
				row.createCell(cellCount++).setCellValue(result.getValue("mlsfc"));
				row.createCell(cellCount++).setCellValue(result.getValue("checkItem"));
				row.createCell(cellCount++).setCellValue(result.getValue("excpPermYn"));
			}
		}
		
	    response.setContentType("Application/Msexcel");
	    response.setHeader("Content-Disposition", "ATTachment; Filename=mngLevelIndex.xlsx");
    }
    
    public void sIndexExcelDownload(Sheet sheet, Map<String, Object> model, HttpServletResponse response) {
		
		Row row = null;
		int rowCount = 0;
		int cellCount = 0;
		
		row = sheet.createRow(rowCount++);
		
		row.createCell(cellCount++).setCellValue("연도");
		row.createCell(cellCount++).setCellValue("대분류");
		row.createCell(cellCount++).setCellValue("중분류");
		row.createCell(cellCount++).setCellValue("소분류");
		row.createCell(cellCount++).setCellValue("점검항목");
		row.createCell(cellCount++).setCellValue("점검항목 상세");
		row.createCell(cellCount++).setCellValue("예외여부");
		
		List<ZValue> resultList = (List<ZValue>) model.get("resultList");
		
		logger.debug("########### PssBbsExcelDownloadView ###########");
		
		if(resultList.size() > 0) {
			for(ZValue result : resultList){
				row = sheet.createRow(rowCount++);
				cellCount = 0;
				row.createCell(cellCount++).setCellValue(result.getValue("orderNo"));
				row.createCell(cellCount++).setCellValue(result.getValue("lclas"));
				row.createCell(cellCount++).setCellValue(result.getValue("mlsfc"));
				row.createCell(cellCount++).setCellValue(result.getValue("sclas"));
				row.createCell(cellCount++).setCellValue(result.getValue("checkItem"));
				row.createCell(cellCount++).setCellValue(result.getValue("dtlCheckItem"));
				row.createCell(cellCount++).setCellValue(result.getValue("excpPermYn"));
			}
		}
		
	    response.setContentType("Application/Msexcel");
	    response.setHeader("Content-Disposition", "ATTachment; Filename=statusExaminIndex.xlsx");
    }
    
    public void mResultExcelDownload(Sheet sheet, Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) {
		
    	HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		    	
		Row row = null;
		int rowCount = 0;
		int cellCount = 0;
		
		ZValue result = (ZValue) model.get("result");
		List<ZValue> resultList = (List<ZValue>) model.get("resultList");
		
		// 1
		row = sheet.createRow(rowCount++);
		row.createCell(cellCount++).setCellValue("수준진단 결과("+result.getValue("insttNm")+")");
		rowCount++;
		
		// 3
		cellCount = 0;
		row = sheet.createRow(rowCount++);
		row.createCell(cellCount++).setCellValue("분류");
		row.createCell(cellCount++).setCellValue("지표명");
		row.createCell(cellCount++).setCellValue("중간평가점수");
		row.createCell(cellCount++).setCellValue("중간가중치환산점수");
		row.createCell(cellCount++).setCellValue("중간 검토의견");
		row.createCell(cellCount++).setCellValue("최종평가점수");
		row.createCell(cellCount++).setCellValue("최종가중치환산점수");
		row.createCell(cellCount++).setCellValue("최정평가의견");
		if(!"2".equals(userInfo.getAuthorId())){
			row.createCell(cellCount++).setCellValue("메모");
		}
		row.createCell(cellCount++).setCellValue("이의신청");
		
		logger.debug("########### PssBbsExcelDownloadView ###########");
		
		if(resultList.size() > 0) {
			
			row = sheet.createRow(rowCount++);
			cellCount = 0;
			row.createCell(cellCount++).setCellValue("");
			row.createCell(cellCount++).setCellValue("");
			row.createCell(cellCount++).setCellValue(result.getValue("totResultScore1"));
			row.createCell(cellCount++).setCellValue("");
			row.createCell(cellCount++).setCellValue(result.getValue("gnrlzEvl1"));
			row.createCell(cellCount++).setCellValue(result.getValue("totResultScore2"));
			row.createCell(cellCount++).setCellValue("");
			row.createCell(cellCount++).setCellValue(result.getValue("gnrlzEvl2"));
			if(!"2".equals(userInfo.getAuthorId())){
				row.createCell(cellCount++).setCellValue("");
			}
			row.createCell(cellCount++).setCellValue("");
			
			String tmpLclas = "";
			String tmpMlsfc = "";
			int cnt = 0;
			
			for(ZValue zVal : resultList){
				row = sheet.createRow(rowCount++);
				cellCount = 0;
				
				if(0 == cnt) {
					row.createCell(cellCount++).setCellValue(zVal.getValue("lclas"));
					row.createCell(cellCount++).setCellValue(zVal.getValue("mlsfc"));
					row.createCell(cellCount++).setCellValue(zVal.getValue("resultTotPer1"));
					row.createCell(cellCount++).setCellValue(zVal.getValue("resultTotScore1"));
					row.createCell(cellCount++).setCellValue("");
					row.createCell(cellCount++).setCellValue(zVal.getValue("resultTotPer2"));
					row.createCell(cellCount++).setCellValue(zVal.getValue("resultTotScore2"));
					row.createCell(cellCount++).setCellValue("");
					if(!"2".equals(userInfo.getAuthorId())){
						row.createCell(cellCount++).setCellValue("");
					}
					row.createCell(cellCount++).setCellValue("");
					cnt++;
					
					row = sheet.createRow(rowCount++);
					cellCount = 0;
					row.createCell(cellCount++).setCellValue("");
					row.createCell(cellCount++).setCellValue(zVal.getValue("checkItem"));
					row.createCell(cellCount++).setCellValue(zVal.getValue("resultScore1"));
					row.createCell(cellCount++).setCellValue("");
					row.createCell(cellCount++).setCellValue(zVal.getValue("evlOpinion1"));
					row.createCell(cellCount++).setCellValue(zVal.getValue("resultScore2"));
					row.createCell(cellCount++).setCellValue("");
					row.createCell(cellCount++).setCellValue(zVal.getValue("evlOpinion2"));
				} else {
					if(!tmpLclas.equals(zVal.getValue("lclas"))) {
						row.createCell(cellCount++).setCellValue(zVal.getValue("lclas"));
						row.createCell(cellCount++).setCellValue(zVal.getValue("mlsfc"));
						row.createCell(cellCount++).setCellValue(zVal.getValue("resultTotPer1"));
						row.createCell(cellCount++).setCellValue(zVal.getValue("resultTotScore1"));
						row.createCell(cellCount++).setCellValue("");
						row.createCell(cellCount++).setCellValue(zVal.getValue("resultTotPer2"));
						row.createCell(cellCount++).setCellValue(zVal.getValue("resultTotScore2"));
						row.createCell(cellCount++).setCellValue("");
						if(!"2".equals(userInfo.getAuthorId())){
							row.createCell(cellCount++).setCellValue("");
						}
						row.createCell(cellCount++).setCellValue("");
						
						row = sheet.createRow(rowCount++);
						cellCount = 0;
						row.createCell(cellCount++).setCellValue("");
						row.createCell(cellCount++).setCellValue(zVal.getValue("checkItem"));
						row.createCell(cellCount++).setCellValue(zVal.getValue("resultScore1"));
						row.createCell(cellCount++).setCellValue("");
						row.createCell(cellCount++).setCellValue(zVal.getValue("evlOpinion1"));
						row.createCell(cellCount++).setCellValue(zVal.getValue("resultScore2"));
						row.createCell(cellCount++).setCellValue("");
						row.createCell(cellCount++).setCellValue(zVal.getValue("evlOpinion2"));
					} else {
						if(!tmpMlsfc.equals(zVal.getValue("mlsfc"))) {
							row.createCell(cellCount++).setCellValue("");
							row.createCell(cellCount++).setCellValue(zVal.getValue("mlsfc"));
							row.createCell(cellCount++).setCellValue(zVal.getValue("resultTotPer1"));
							row.createCell(cellCount++).setCellValue(zVal.getValue("resultTotScore1"));
							row.createCell(cellCount++).setCellValue("");
							row.createCell(cellCount++).setCellValue(zVal.getValue("resultTotPer2"));
							row.createCell(cellCount++).setCellValue(zVal.getValue("resultTotScore2"));
							row.createCell(cellCount++).setCellValue("");
							if(!"2".equals(userInfo.getAuthorId())){
								row.createCell(cellCount++).setCellValue("");
							}
							row.createCell(cellCount++).setCellValue("");
							
							row = sheet.createRow(rowCount++);
							cellCount = 0;
							row.createCell(cellCount++).setCellValue("");
							row.createCell(cellCount++).setCellValue(zVal.getValue("checkItem"));
							row.createCell(cellCount++).setCellValue(zVal.getValue("resultScore1"));
							row.createCell(cellCount++).setCellValue("");
							row.createCell(cellCount++).setCellValue(zVal.getValue("evlOpinion1"));
							row.createCell(cellCount++).setCellValue(zVal.getValue("resultScore2"));
							row.createCell(cellCount++).setCellValue("");
							row.createCell(cellCount++).setCellValue(zVal.getValue("evlOpinion2"));
						} else {
							row.createCell(cellCount++).setCellValue("");
							row.createCell(cellCount++).setCellValue(zVal.getValue("checkItem"));
							row.createCell(cellCount++).setCellValue(zVal.getValue("resultScore1"));
							row.createCell(cellCount++).setCellValue("");
							row.createCell(cellCount++).setCellValue(zVal.getValue("evlOpinion1"));
							row.createCell(cellCount++).setCellValue(zVal.getValue("resultScore2"));
							row.createCell(cellCount++).setCellValue("");
							row.createCell(cellCount++).setCellValue(zVal.getValue("evlOpinion2"));
						}
					}
				}
				if(!"2".equals(userInfo.getAuthorId())){
					row.createCell(cellCount++).setCellValue(zVal.getValue("memo"));
				}
				row.createCell(cellCount++).setCellValue(zVal.getValue("fobjctResn"));
				
				tmpLclas = zVal.getValue("lclas");
				tmpMlsfc = zVal.getValue("mlsfc");
			}
		}
		
	    response.setContentType("Application/Msexcel");
	    response.setHeader("Content-Disposition", "ATTachment; Filename=mngLevelResult.xlsx");
    }
    
    public void sResultExcelDownload(Sheet sheet, Map<String, Object> model, HttpServletResponse response) {
		
		Row row = null;
		int rowCount = 0;
		int cellCount = 0;
		
		ZValue result = (ZValue) model.get("result");
		List<ZValue> resultList = (List<ZValue>) model.get("resultList");
		String evalType = (String)model.get("evalType");
		List<ZValue> sctnScoreList = (List<ZValue>) model.get("sctnScoreList");
		
		// 1
		row = sheet.createRow(rowCount++);
		row.createCell(cellCount++).setCellValue("수준진단 현황조사 결과");
		rowCount++;

		// 3
		cellCount = 0;
		row = sheet.createRow(rowCount++);
		row.createCell(cellCount++).setCellValue("종합평가");
		
		// 4
		cellCount = 0;
		row = sheet.createRow(rowCount++);
		row.createCell(cellCount++).setCellValue(result.getValue("gnrlzEvl2"));
		rowCount++;
		
		// 6
		cellCount = 0;
		row = sheet.createRow(rowCount++);
		row.createCell(cellCount++).setCellValue("대분류");
		row.createCell(cellCount++).setCellValue("중분류");
		row.createCell(cellCount++).setCellValue("소분류");
		row.createCell(cellCount++).setCellValue("점검항목");
		row.createCell(cellCount++).setCellValue("중간결과");
		row.createCell(cellCount++).setCellValue("최종결과");
		row.createCell(cellCount++).setCellValue("평가의견");
		
		logger.debug("########### PssBbsExcelDownloadView ###########");
		
		if(resultList.size() > 0) {
			
			String tmpLclas = "";
			String tmpMlsfc = "";
			String tmpSclas = "";
			int cnt = 0;
			
			for(ZValue zVal : resultList){
				row = sheet.createRow(rowCount++);
				cellCount = 0;
				
				if(0 == cnt) {
					row.createCell(cellCount++).setCellValue(zVal.getValue("lclas"));
					row.createCell(cellCount++).setCellValue(zVal.getValue("mlsfc"));
					row.createCell(cellCount++).setCellValue(zVal.getValue("sclas"));
					cnt++;
				} else {
					if(!tmpLclas.equals(zVal.getValue("lclas"))) {
						row.createCell(cellCount++).setCellValue(zVal.getValue("lclas"));
					} else {
						cellCount++;
					}
					if(!tmpMlsfc.equals(zVal.getValue("mlsfc"))) {
						row.createCell(cellCount++).setCellValue(zVal.getValue("mlsfc"));
					} else {
						cellCount++;
					}
					if(!tmpSclas.equals(zVal.getValue("sclas"))) {
						row.createCell(cellCount++).setCellValue(zVal.getValue("sclas"));
					} else {
						cellCount++;
					}
				}
				row.createCell(cellCount++).setCellValue(zVal.getValue("checkItem"));
				if(Globals.EVAL_TYPE_SCORE.equals(evalType)) {
					row.createCell(cellCount++).setCellValue(zVal.getValue("resultScore1"));
					row.createCell(cellCount++).setCellValue(zVal.getValue("resultScore2"));
				} else {
					int count = 0;
					for(ZValue sVal : sctnScoreList){
						if(StringUtils.isEmpty(zVal.getValue("resultScore1"))) {
							row.createCell(cellCount++).setCellValue(zVal.getValue("resultScore1"));
							count++;
							break;
						} else if (Float.parseFloat(sVal.getValue("sctnScore")) < Float.parseFloat(zVal.getValue("resultScore1"))) {
							row.createCell(cellCount++).setCellValue(sVal.getValue("sctnNm"));
							count++;
							break;
						}
					}
					if(count == 0) {
						row.createCell(cellCount++).setCellValue(sctnScoreList.get(sctnScoreList.size() -1).getValue("sctnNm"));
					}
					count = 0;
					for(ZValue sVal : sctnScoreList){
						if(StringUtils.isEmpty(zVal.getValue("resultScore2"))) {
							row.createCell(cellCount++).setCellValue(zVal.getValue("resultScore2"));
							count++;
							break;
						} else if (Float.parseFloat(sVal.getValue("sctnScore")) < Float.parseFloat(zVal.getValue("resultScore2"))) {
							row.createCell(cellCount++).setCellValue(sVal.getValue("sctnNm"));
							count++;
							break;
						}
					}
					if(count == 0) {
						row.createCell(cellCount++).setCellValue(sctnScoreList.get(sctnScoreList.size() -1).getValue("sctnNm"));
					}
				}
				row.createCell(cellCount++).setCellValue(zVal.getValue("evlOpinion"));
				
				tmpLclas = zVal.getValue("lclas");
				tmpMlsfc = zVal.getValue("mlsfc");
				tmpSclas = zVal.getValue("sclas");
			}
		}
		
	    response.setContentType("Application/Msexcel");
	    response.setHeader("Content-Disposition", "ATTachment; Filename=statusExaminResult.xlsx");
    }
    
    public void sDtlResultExcelDownload(Sheet sheet, Map<String, Object> model, HttpServletResponse response) {
		
    	Row row = null;
		int rowCount = 0;
		int cellCount = 0;
		
		ZValue result = (ZValue) model.get("result");
		List<ZValue> resultList = (List<ZValue>) model.get("resultList");
		String evalType = (String)model.get("evalType");
		List<ZValue> sctnScoreList = (List<ZValue>) model.get("sctnScoreList");
		
		// 1
		row = sheet.createRow(rowCount++);
		row.createCell(cellCount++).setCellValue("수준진단 현황조사 결과");
		rowCount++;

		// 3
		cellCount = 0;
		row = sheet.createRow(rowCount++);
		row.createCell(cellCount++).setCellValue("종합평가");
		
		// 4
		cellCount = 0;
		row = sheet.createRow(rowCount++);
		row.createCell(cellCount++).setCellValue(result.getValue("gnrlzEvl2"));
		rowCount++;
		
		// 6
		cellCount = 0;
		row = sheet.createRow(rowCount++);
		row.createCell(cellCount++).setCellValue("대분류");
		row.createCell(cellCount++).setCellValue("중분류");
		row.createCell(cellCount++).setCellValue("소분류");
		row.createCell(cellCount++).setCellValue("점검항목");
		row.createCell(cellCount++).setCellValue("중간결과");
		row.createCell(cellCount++).setCellValue("최종결과");
		row.createCell(cellCount++).setCellValue("평가의견");
		row.createCell(cellCount++).setCellValue("메모");
		row.createCell(cellCount++).setCellValue("점검항목상세");
		row.createCell(cellCount++).setCellValue("점검항목중간결과");
		row.createCell(cellCount++).setCellValue("점검항목최종결과");
		
		logger.debug("########### PssBbsExcelDownloadView ###########");
		
		if(resultList.size() > 0) {
			
			String tmpLclas = "";
			String tmpMlsfc = "";
			String tmpSclas = "";
			String tmpCheckItem = "";
			int cnt = 0;
			
			for(ZValue zVal : resultList){
				row = sheet.createRow(rowCount++);
				cellCount = 0;
				
				if(0 == cnt) {
					row.createCell(cellCount++).setCellValue(zVal.getValue("lclas"));
					row.createCell(cellCount++).setCellValue(zVal.getValue("mlsfc"));
					row.createCell(cellCount++).setCellValue(zVal.getValue("sclas"));
					row.createCell(cellCount++).setCellValue(zVal.getValue("checkItem"));
					row.createCell(cellCount++).setCellValue(zVal.getValue("resultScore1"));
					row.createCell(cellCount++).setCellValue(zVal.getValue("resultScore2"));
					row.createCell(cellCount++).setCellValue(zVal.getValue("evlOpinion"));
					row.createCell(cellCount++).setCellValue(zVal.getValue("memo"));
					cnt++;
				} else {
					if(!tmpLclas.equals(zVal.getValue("lclas"))) {
						row.createCell(cellCount++).setCellValue(zVal.getValue("lclas"));
					} else {
						cellCount++;
					}
					if(!tmpMlsfc.equals(zVal.getValue("mlsfc"))) {
						row.createCell(cellCount++).setCellValue(zVal.getValue("mlsfc"));
					} else {
						cellCount++;
					}
					if(!tmpSclas.equals(zVal.getValue("sclas"))) {
						row.createCell(cellCount++).setCellValue(zVal.getValue("sclas"));
					} else {
						cellCount++;
					}
					if(!tmpCheckItem.equals(zVal.getValue("checkItem"))) {
						row.createCell(cellCount++).setCellValue(zVal.getValue("checkItem"));
						row.createCell(cellCount++).setCellValue(zVal.getValue("resultScore1"));
						row.createCell(cellCount++).setCellValue(zVal.getValue("resultScore2"));
						row.createCell(cellCount++).setCellValue(zVal.getValue("evlOpinion"));
						row.createCell(cellCount++).setCellValue(zVal.getValue("memo"));
					} else {
						cellCount++;
						cellCount++;
						cellCount++;
						cellCount++;
						cellCount++;
					}
				}
				row.createCell(cellCount++).setCellValue(zVal.getValue("dtlCheckItem"));
				row.createCell(cellCount++).setCellValue(zVal.getValue("dtlResultScore1"));
				row.createCell(cellCount++).setCellValue(zVal.getValue("dtlResultScore2"));

				tmpLclas = zVal.getValue("lclas");
				tmpMlsfc = zVal.getValue("mlsfc");
				tmpSclas = zVal.getValue("sclas");
				tmpCheckItem = zVal.getValue("checkItem");	
			}
		}
		
	    response.setContentType("Application/Msexcel");
	    response.setHeader("Content-Disposition", "ATTachment; Filename=statusExaminResult.xlsx");
    }

    public void qestnarExcelDown(Sheet sheet, Map<String, Object> model, HttpServletResponse response) {
		
    	Row row = null;
		int rowCount = 0;
		int cellCount = 0;
		
		ZValue result = (ZValue) model.get("qestnarMastr");
		List<ZValue> resultList = (List<ZValue>) model.get("qestnarItemList");

		List<ZValue> detailList = (List<ZValue>) model.get("qestnarDetailList");
		
		// 1
		row = sheet.createRow(rowCount++);
		row.createCell(cellCount++).setCellValue("설문조사 결과");
		rowCount++;

		// 3
		cellCount = 0;
		row = sheet.createRow(rowCount++);
		row.createCell(cellCount++).setCellValue("기본정보");
		
		// 4
		cellCount = 0;
		row = sheet.createRow(rowCount++);
		row.createCell(cellCount++).setCellValue("설문제목");
		row.createCell(cellCount++).setCellValue(result.getValue("SUBJECT"));
		rowCount++;
		// 5
		cellCount = 0;
		row = sheet.createRow(rowCount++);
		row.createCell(cellCount++).setCellValue("설문기간");
		row.createCell(cellCount++).setCellValue(result.getValue("BEGIN_DT") + "~" + result.getValue("END_DT"));
		rowCount++;
		// 6
		cellCount = 0;
		row = sheet.createRow(rowCount++);
		row.createCell(cellCount++).setCellValue("참여현황");
		row.createCell(cellCount++).setCellValue("총 응답자");
		row.createCell(cellCount++).setCellValue(result.getValue("USER_CNT") + "명");

		rowCount++;
		
		// 7
		cellCount = 0;
		row = sheet.createRow(rowCount++);
		row.createCell(cellCount++).setCellValue("설문상세결과");
		
		logger.debug("########### qestnarExcelDownloadView ###########");
		
		if(resultList.size() > 0) {
			
			int tmpDetail = 0;

			int cnt = 0;
			
			for(ZValue zVal : resultList){
				row = sheet.createRow(rowCount++);
				cellCount = 0;
				
				if("QQ01".equals(zVal.getValue("QESITM_CD"))) {
					row.createCell(cellCount++).setCellValue("설문" + zVal.getValue("QESITM_NO"));
					row.createCell(cellCount++).setCellValue("설문내용" + zVal.getValue("QESITM_CN"));
					row = sheet.createRow(rowCount++);
					cellCount = 0;
					row.createCell(cellCount++).setCellValue("[객관식]");
					row.createCell(cellCount++).setCellValue("총응답자");
					row.createCell(cellCount++).setCellValue(zVal.getValue("RESULT_CNT") + "명");

					tmpDetail = zVal.getInt("SEQ");
					for(ZValue zVal2 : detailList){
						if(zVal2.getInt("QESITM_SEQ") == tmpDetail) {
							row = sheet.createRow(rowCount++);
							cellCount = 0;
							row.createCell(cellCount++).setCellValue("");
							row.createCell(cellCount++).setCellValue("응답결과");
							row.createCell(cellCount++).setCellValue(zVal2.getValue("QESITM_DETAIL_CN"));
							row.createCell(cellCount++).setCellValue(zVal2.getValue("DETAIL_CNT") + "명");
							row.createCell(cellCount++).setCellValue(zVal2.getValue("PERCENT") + "%");
						}
					}
				} else {
					row.createCell(cellCount++).setCellValue("설문" + zVal.getValue("QESITM_NO"));
					row.createCell(cellCount++).setCellValue("설문내용");
					row.createCell(cellCount++).setCellValue(zVal.getValue("QESITM_CN"));
					row = sheet.createRow(rowCount++);
					cellCount = 0;
					row.createCell(cellCount++).setCellValue("[주관식]");
					row.createCell(cellCount++).setCellValue("총응답자");
					row.createCell(cellCount++).setCellValue(zVal.getValue("RESULT_CNT") + "명");
				}
				
				
			}
		}
		
	    response.setContentType("Application/Msexcel");
	    response.setHeader("Content-Disposition", "ATTachment; Filename=qestnarExcelDown.xlsx");
    }

    public void userExcelDown(Sheet sheet, Map<String, Object> model, HttpServletResponse response) {
		
		Row row = null;
		int rowCount = 0;
		int cellCount = 0;
		
		row = sheet.createRow(rowCount++);
		
		row.createCell(cellCount++).setCellValue("아이디");
		row.createCell(cellCount++).setCellValue("이름");
		row.createCell(cellCount++).setCellValue("기관명");
		row.createCell(cellCount++).setCellValue("부서명");
		row.createCell(cellCount++).setCellValue("직급");
		row.createCell(cellCount++).setCellValue("직책");
		row.createCell(cellCount++).setCellValue("담당업무");
		row.createCell(cellCount++).setCellValue("연락처");
		row.createCell(cellCount++).setCellValue("휴대폰");
		row.createCell(cellCount++).setCellValue("내선번호");
		row.createCell(cellCount++).setCellValue("이메일");
		
		List<ZValue> resultList = (List<ZValue>) model.get("resultList");
		
		List<ZValue> chrgDutyList = (List<ZValue>) model.get("chrgDutyList");
		
		logger.debug("########### PssBbsExcelDownloadView ###########");
		
		if(resultList.size() > 0) {
			for(ZValue result : resultList){
				row = sheet.createRow(rowCount++);
				cellCount = 0;
				row.createCell(cellCount++).setCellValue(result.getValue("USER_ID"));
				row.createCell(cellCount++).setCellValue(result.getValue("USER_NM"));
				row.createCell(cellCount++).setCellValue(result.getValue("INSTT_NM"));
				row.createCell(cellCount++).setCellValue(result.getValue("DEPT"));
				row.createCell(cellCount++).setCellValue(result.getValue("CLSF"));
				row.createCell(cellCount++).setCellValue(result.getValue("RSPOFC"));
				
				String[] chrgDutyCd = result.getValue("CHRG_DUTY_CD").split(":");
				String chrgDutyNm = "";
				for(int i=0; i < chrgDutyCd.length; i++) {
					for(ZValue chrgDuty : chrgDutyList){
						if(chrgDutyCd[i].equals(chrgDuty.getValue("CODE"))) {
							if(i == 0) {
								chrgDutyNm = chrgDuty.getValue("CODE_NM");
							} else {
								chrgDutyNm = chrgDutyNm + "," + chrgDuty.getValue("CODE_NM");
							}
							break;
						}
					}
				}
				row.createCell(cellCount++).setCellValue(chrgDutyNm);
				row.createCell(cellCount++).setCellValue(result.getValue("TEL_NO"));
				row.createCell(cellCount++).setCellValue(result.getValue("MOBLPHON_NO"));
				row.createCell(cellCount++).setCellValue(result.getValue("LXTN_NO"));
				row.createCell(cellCount++).setCellValue(result.getValue("EMAIL"));
			}
		}
		
	    response.setContentType("Application/Msexcel");
	    response.setHeader("Content-Disposition", "ATTachment; Filename=userList.xlsx");
    }
    
    public void institutionUser(Sheet sheet, Map<String, Object> model, HttpServletResponse response) {
		
		Row row = null;
		int rowCount = 0;
		int cellCount = 0;
		
		row = sheet.createRow(rowCount++);
		
		row.createCell(cellCount++).setCellValue("기관명");
		row.createCell(cellCount++).setCellValue("임직원수");
		row.createCell(cellCount++).setCellValue("주소");
		row.createCell(cellCount++).setCellValue("사업내용");
		row.createCell(cellCount++).setCellValue("부서");
		row.createCell(cellCount++).setCellValue("직책");
		row.createCell(cellCount++).setCellValue("성명");
		row.createCell(cellCount++).setCellValue("연락처");
		row.createCell(cellCount++).setCellValue("이메일");
		
		List<ZValue> resultList = (List<ZValue>) model.get("resultList");
		
		String insttCd = "";
		
		if(resultList.size() > 0) {
			for(ZValue result : resultList){
				row = sheet.createRow(rowCount++);
				cellCount = 0;
				
				if(insttCd.equals(result.getValue("insttCd"))) {
					row.createCell(cellCount++).setCellValue("");
					row.createCell(cellCount++).setCellValue("");
					row.createCell(cellCount++).setCellValue("");
					row.createCell(cellCount++).setCellValue("");
				} else {
					row.createCell(cellCount++).setCellValue(result.getValue("insttNm"));
					row.createCell(cellCount++).setCellValue(result.getValue("empCo"));
					row.createCell(cellCount++).setCellValue(result.getValue("addr"));
					row.createCell(cellCount++).setCellValue(result.getValue("bsnsContents"));
				}
				
				row.createCell(cellCount++).setCellValue(result.getValue("dept"));
				row.createCell(cellCount++).setCellValue(result.getValue("rspofc"));
				row.createCell(cellCount++).setCellValue(result.getValue("userNm"));
				row.createCell(cellCount++).setCellValue(result.getValue("telNo"));
				row.createCell(cellCount++).setCellValue(result.getValue("email"));
				
				insttCd = result.getValue("insttCd");
			}
		}
		
	    response.setContentType("Application/Msexcel");
	    response.setHeader("Content-Disposition", "ATTachment; Filename=InsttUserList.xlsx");
    }
    
    public void insctrUser(Sheet sheet, Map<String, Object> model, HttpServletResponse response) {
		
		Row row = null;
		int rowCount = 0;
		int cellCount = 0;
		
		row = sheet.createRow(rowCount++);
		
		row.createCell(cellCount++).setCellValue("아이디");
		row.createCell(cellCount++).setCellValue("이름");
		row.createCell(cellCount++).setCellValue("관리수준 구분");
		row.createCell(cellCount++).setCellValue("점검기간");
		row.createCell(cellCount++).setCellValue("배정기관");
		
		List<ZValue> resultList = (List<ZValue>) model.get("resultList");
		
		String userId = "";
		
		if(resultList.size() > 0) {
			for(ZValue result : resultList){
				row = sheet.createRow(rowCount++);
				cellCount = 0;
				
				if(userId.equals(result.getValue("userId"))) {
					row.createCell(cellCount++).setCellValue("");
					row.createCell(cellCount++).setCellValue("");
					row.createCell(cellCount++).setCellValue("");
					row.createCell(cellCount++).setCellValue("");
				} else {
					row.createCell(cellCount++).setCellValue(result.getValue("userId"));
					row.createCell(cellCount++).setCellValue(result.getValue("userNm"));
					row.createCell(cellCount++).setCellValue(result.getValue("mngLevelNm"));
					row.createCell(cellCount++).setCellValue(result.getValue("insctrBgnde") + " ~ " + result.getValue("insctrEndde"));
				}
				row.createCell(cellCount++).setCellValue(result.getValue("insttNm"));
				userId = result.getValue("userId");
			}
		}
		
	    response.setContentType("Application/Msexcel");
	    response.setHeader("Content-Disposition", "ATTachment; Filename=InsctrUserList.xlsx");
    }
}