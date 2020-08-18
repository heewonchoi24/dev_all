package org.ssis.pss.index.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.antlr.grammar.v3.ANTLRParser.throwsSpec_return;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.index.dao.IndexDao;
import org.ssis.pss.index.service.IndexService;

import egovframework.com.cmm.SessionVO;

@Service
public class IndexServiceImpl implements IndexService  {
	
	
	protected Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired 
	private IndexDao indexDao;
	
	@Override
	public List<ZValue> selectCheckItemSctnScoreList(ZValue zvl) throws Exception {
		return indexDao.selectCheckItemSctnScoreList(zvl);
	}
	
	@Override
	public List<ZValue> selectCheckItemScoreSeList(ZValue zvl) throws Exception {
		return indexDao.selectCheckItemScoreSeList(zvl);
	}
	
	@Override
	public void deleteCheckItemScore(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		indexDao.deleteCheckItemScoreSe(zvl);
		
		indexDao.deleteCheckItemSctnScore(zvl);
		
		String orderNo = zvl.getValue("orderNo");
		String mngLevelCd = zvl.getValue("mngLevelCd");
		String scoreSe = zvl.getValue("scoreSe");
		
		ZValue iZvl = new ZValue();
		
		iZvl.put("orderNo", orderNo);
		iZvl.put("mngLevelCd", mngLevelCd);
		iZvl.put("registId", userInfo.getUserId());
		iZvl.put("scoreSe", scoreSe);
		
		indexDao.insertCheckItemScoreSe(iZvl);
	}
	
	@Override
	public void updateCheckItemScore(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		String orderNo = zvl.getValue("orderNo");
		String mngLevelCd = zvl.getValue("mngLevelCd");
		String scoreSe = zvl.getValue("scoreSe");
		
		indexDao.deleteCheckItemScoreSe(zvl);
		
		indexDao.deleteCheckItemSctnScore(zvl);
		
		ArrayList scoreSeNmList = zvl.getArrayList("scoreSeNm[]");
		ArrayList scoreList = zvl.getArrayList("score[]");
		ArrayList sctnScoreList = zvl.getArrayList("sctnScore[]");
		ArrayList sctnNmList = zvl.getArrayList("sctnNm[]");
		
		for(int i=0; i < scoreSeNmList.size(); i++) {
			
			String scoreSeNm = scoreSeNmList.get(i).toString();
			String score = scoreList.get(i).toString();
			
			ZValue iZvl = new ZValue();
			
			iZvl.put("orderNo", orderNo);
			iZvl.put("mngLevelCd", mngLevelCd);
			iZvl.put("registId", userInfo.getUserId());
			
			iZvl.put("scoreSeNm", scoreSeNm);
			iZvl.put("score", score);
			iZvl.put("scoreSe", scoreSe);
			
			iZvl.put("outputOrdr", i+1);
			
			indexDao.insertCheckItemScoreSe(iZvl);
		}
		
		for(int i=0; i < sctnScoreList.size(); i++) {
			
			String sctnScore = sctnScoreList.get(i).toString();
			String sctnNm = sctnNmList.get(i).toString();
			
			ZValue iZvl = new ZValue();
			
			iZvl.put("orderNo", orderNo);
			iZvl.put("mngLevelCd", mngLevelCd);
			iZvl.put("registId", userInfo.getUserId());
			
			iZvl.put("sctnScore", sctnScore);
			iZvl.put("sctnNm", sctnNm);
			
			indexDao.insertCheckItemSctnScore(iZvl);
		}
	}
	
	@Override
	public List<ZValue> selectMngLevelIndexList(ZValue zvl) throws Exception {
		return indexDao.selectMngLevelIndexList(zvl);
	}
	
	@Override
	public void createMngLevelIndex(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		ArrayList lclasList = zvl.getArrayList("lclas[]");
		ArrayList mlsfcList = zvl.getArrayList("mlsfc[]");
		ArrayList checkItemList = zvl.getArrayList("checkItem[]");
		ArrayList excpPermYnList = zvl.getArrayList("excpPermYn[]");
		ArrayList helpCommentList = zvl.getArrayList("helpComment[]");
		String resultSeList = zvl.getValue("resultSe");
		String tmpLclas = "";
		String tmpMlsfc = "";
		int lOrder = indexDao.selectMngLclasOrderCnt();
		int mOrder = 1;
		int sOrder = 1;
		
		for(int i=0; i < lclasList.size(); i++) {
			
			String lclas = lclasList.get(i).toString();
			String mlsfc = mlsfcList.get(i).toString();
			String checkItem = checkItemList.get(i).toString();
			String excpPermYn = excpPermYnList.get(i).toString();
			String helpComment = helpCommentList.get(i).toString();
			
			ZValue iZvl = new ZValue();
			// 차수 추가 시
			iZvl.put("orderNo", zvl.getValue("orderNo"));
			iZvl.put("registId", userInfo.getUserId());
			
			
			iZvl.put("lclas", lclas);
			iZvl.put("mlsfc", mlsfc);
			iZvl.put("checkItem", checkItem);
			iZvl.put("excpPermYn", excpPermYn);
			iZvl.put("helpComment", helpComment);
			iZvl.put("resultSeList", resultSeList);
			
			if(0 ==i) {
				tmpLclas = lclas;
				tmpMlsfc = mlsfc;
				iZvl.put("lclasOrder", lOrder);
				iZvl.put("mlsfcOrder", mOrder);
				iZvl.put("checkItemOrder", sOrder);
			} else {
				if(lclas.equals(tmpLclas)) {
					iZvl.put("lclasOrder", lOrder);
					if(mlsfc.equals(tmpMlsfc)) {
						iZvl.put("mlsfcOrder", mOrder);	
						sOrder++;
						iZvl.put("checkItemOrder", sOrder);
					} else {
						mOrder++;
						iZvl.put("mlsfcOrder", mOrder);
						sOrder = 1;
						iZvl.put("checkItemOrder", sOrder);
					}
				} else {
					lOrder++;
					mOrder = 1;
					sOrder = 1;
					iZvl.put("lclasOrder", lOrder);
					iZvl.put("mlsfcOrder", mOrder);
					iZvl.put("checkItemOrder", sOrder);
				}
				tmpLclas = lclas;
				tmpMlsfc = mlsfc;
			}
			
			indexDao.insertMngLevelIndex(iZvl);
		}
	}
	
	@Override
	public void updateMngLevelIndex(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		String lclasOrder = zvl.getValue("lclasOrder");
		
		indexDao.deleteMngLevelIndex(zvl);
		
		ArrayList lclasList = zvl.getArrayList("lclas[]");
		ArrayList mlsfcList = zvl.getArrayList("mlsfc[]");
		ArrayList checkItemList = zvl.getArrayList("checkItem[]");
		ArrayList excpPermYnList = zvl.getArrayList("excpPermYn[]");
		ArrayList helpCommentList = zvl.getArrayList("helpComment[]");
		String resultSeList = zvl.getValue("resultSe");
		String tmpLclas = "";
		String tmpMlsfcOrder = "";
		int lOrder = Integer.parseInt(lclasOrder);
		int mOrder = 1;
		int sOrder = 1;
		
		for(int i=0; i < lclasList.size(); i++) {
			
			String lclas = lclasList.get(i).toString();
			String mlsfc = mlsfcList.get(i).toString();
			String checkItem = checkItemList.get(i).toString();
			String excpPermYn = excpPermYnList.get(i).toString();
			String helpComment = helpCommentList.get(i).toString();
			
			ZValue iZvl = new ZValue();
			// 차수 추가 시
			iZvl.put("orderNo", zvl.getValue("orderNo"));
			iZvl.put("registId", userInfo.getUserId());
			
			
			iZvl.put("lclas", lclas);
			iZvl.put("mlsfc", mlsfc);
			iZvl.put("checkItem", checkItem);
			iZvl.put("excpPermYn", excpPermYn);
			iZvl.put("helpComment", helpComment);
			iZvl.put("resultSeList", resultSeList);
			
			if(0 ==i) {
				tmpLclas = lclas;
				tmpMlsfcOrder = mlsfc;
				iZvl.put("lclasOrder", lOrder);
				iZvl.put("mlsfcOrder", mOrder);
				iZvl.put("checkItemOrder", sOrder);
			} else {
				if(lclas.equals(tmpLclas)) {
					iZvl.put("lclasOrder", lOrder);
					if(mlsfc.equals(tmpMlsfcOrder)) {
						iZvl.put("mlsfcOrder", mOrder);	
						sOrder++;
						iZvl.put("checkItemOrder", sOrder);
					} else {
						mOrder++;
						sOrder = 1;
						iZvl.put("mlsfcOrder", mOrder);
						iZvl.put("checkItemOrder", sOrder);
					}
				} else {
					lOrder++;
					mOrder = 1;
					sOrder = 1;
					iZvl.put("lclasOrder", lOrder);
					iZvl.put("mlsfcOrder", mOrder);
					iZvl.put("checkItemOrder", sOrder);
				}
				tmpLclas = lclas;
				tmpMlsfcOrder = mlsfc;
			}
			
			indexDao.insertMngLevelIndex(iZvl);
		}
	}
	
	@Override
	public void deleteMngLevelIndex(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		indexDao.deleteMngLevelIndex(zvl);
	}
	
	@Override
	public List<ZValue> selectStatusExaminIndexList(ZValue zvl) throws Exception {
		return indexDao.selectStatusExaminIndexList(zvl);
	}
	
	@Override
	public List<ZValue> selectMngLevelIndexSeqList(ZValue zvl) throws Exception {
		return indexDao.selectMngLevelIndexSeqList(zvl);
	}
	
	@Override
	public void createStatusExaminIndex(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		ArrayList lclasList = zvl.getArrayList("lclas[]");
		ArrayList mlsfcList = zvl.getArrayList("mlsfc[]");
		ArrayList sclasList = zvl.getArrayList("sclas[]");
		ArrayList checkItemList = zvl.getArrayList("checkItem[]");
		ArrayList excpPermYnList = zvl.getArrayList("excpPermYn[]");
		ArrayList helpCommentList = zvl.getArrayList("helpComment[]");
		ArrayList mngLevelIndexSeqList = zvl.getArrayList("mngLevelIndexSeq[]");
		
		String resultSe = zvl.getValue("resultSe");
		String tmpLclas = "";
		String tmpMlsfc = "";
		String tmpSclas = "";
		String tmpCheckItem = "";
		int lOrder = indexDao.selectStatusLclasOrderCnt(zvl);
		int mOrder = 1;
		int sOrder = 1;
		int dOrder = 1;
		
		for(int i=0; i < lclasList.size(); i++) {
			
			String lclas = lclasList.get(i).toString();
			String mlsfc = mlsfcList.get(i).toString();
			String sclas = sclasList.get(i).toString();
			String checkItem = checkItemList.get(i).toString();
			String excpPermYn = excpPermYnList.get(i).toString();
			String helpComment = helpCommentList.get(i).toString();
			String mngLevelIndexSeq = mngLevelIndexSeqList.get(i).toString();
			
			ZValue iZvl = new ZValue();
			// 차수 추가 시
			iZvl.put("orderNo", zvl.getValue("orderNo"));
			iZvl.put("registId", userInfo.getUserId());
			
			iZvl.put("lclas", lclas);
			iZvl.put("mlsfc", mlsfc);
			iZvl.put("sclas", sclas);
			iZvl.put("checkItem", checkItem);
			iZvl.put("excpPermYn", excpPermYn);
			iZvl.put("helpComment", helpComment);
			iZvl.put("mngLevelIndexSeq", mngLevelIndexSeq);
			iZvl.put("resultSe", resultSe);
			
			// for문 처음
			if(0 == i) {
				tmpLclas = lclas;
				tmpMlsfc = mlsfc;
				tmpSclas = sclas;
				tmpCheckItem = checkItem;
				iZvl.put("lclasOrder", lOrder);
				iZvl.put("mlsfcOrder", mOrder);
				iZvl.put("sclasOrder", sOrder);
				iZvl.put("checkItemOrder", dOrder);
			} else {
				// 대, 중, 소, 세 같은 경우 skip
				if(tmpLclas.equals(lclas) && tmpMlsfc.equals(mlsfc) && tmpSclas.equals(sclas)
						&& tmpCheckItem.equals(checkItem)) {
					continue;
				} else {
					// 대분류가 같은경우
					if(lclas.equals(tmpLclas)) {
						iZvl.put("lclasOrder", lOrder);
						// 중분류가 같은경우
						if(mlsfc.equals(tmpMlsfc)) {
							iZvl.put("mlsfcOrder", mOrder);
							// 소분류가 같은경우
							if(sclas.equals(tmpSclas)) {
								dOrder++;
								iZvl.put("sclasOrder", sOrder);
								iZvl.put("checkItemOrder", dOrder);
							} else {
								sOrder++;
								dOrder = 1;
								iZvl.put("sclasOrder", sOrder);
								iZvl.put("checkItemOrder", dOrder);
							}
						} else {
							mOrder++;
							sOrder = 1;
							dOrder = 1;
							iZvl.put("mlsfcOrder", mOrder);
							iZvl.put("sclasOrder", sOrder);
							iZvl.put("checkItemOrder", dOrder);
						}
					} else {
						lOrder++;
						mOrder = 1;
						sOrder = 1;
						dOrder = 1;
						iZvl.put("lclasOrder", lOrder);
						iZvl.put("mlsfcOrder", mOrder);
						iZvl.put("sclasOrder", sOrder);
						iZvl.put("checkItemOrder", dOrder);
					}
					tmpLclas = lclas;
					tmpMlsfc = mlsfc;
					tmpSclas = sclas;
					tmpCheckItem = checkItem;
				}
			}
			
			// 관리수준 현황조사 등록
			indexDao.insertStatusExaminIdx(iZvl);
			
			// 관리수준 현황조사 상세 등록
			createStatusExaminIdxDtl(zvl, iZvl);
		}
	}
	
	public void createStatusExaminIdxDtl(ZValue zvl, ZValue iZvl) throws Exception {
		
		ArrayList lclasList = zvl.getArrayList("lclas[]");
		ArrayList mlsfcList = zvl.getArrayList("mlsfc[]");
		ArrayList sclasList = zvl.getArrayList("sclas[]");
		ArrayList checkItemList = zvl.getArrayList("checkItem[]");
		ArrayList dtlCheckItemList = zvl.getArrayList("dtlCheckItem[]");
		
		for(int i=0; i < dtlCheckItemList.size(); i++) {
			
			String lclasTmp = lclasList.get(i).toString();
			String mlsfcTmp = mlsfcList.get(i).toString();
			String sclasTmp = sclasList.get(i).toString();
			String checkItemTmp = checkItemList.get(i).toString();
			String dtlCheckItem = dtlCheckItemList.get(i).toString();
			
			String lclas = iZvl.getValue("lclas");
			String mlsfc = iZvl.getValue("mlsfc");
			String sclas = iZvl.getValue("sclas");
			String checkItem = iZvl.getValue("checkItem");
			
			if(lclasTmp.equals(lclas) && mlsfcTmp.equals(mlsfc) && sclasTmp.equals(sclas)
					&& checkItemTmp.equals(checkItem)) {
				ZValue dtlZvl = new ZValue();
				// 차수 추가 시
				dtlZvl.put("indexSeq", iZvl.getValue("indexSeq"));
				dtlZvl.put("registId", iZvl.getValue("registId"));
				dtlZvl.put("checkItem", dtlCheckItem);
				
				indexDao.insertStatusExaminIdxDetail(dtlZvl);
			}
		}
	}
	
	@Override
	public List<ZValue> selectStatusExaminIndexDtlList(ZValue zvl) throws Exception {
		return indexDao.selectStatusExaminIndexDtlList(zvl);
	}
	
	@Override
	public void updateStatusExaminIndex(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		String lclasOrder = zvl.getValue("lclasOrder");
		
		// 관리수준 현황조사 상세 삭제
		indexDao.deleteStatusExaminIdxDetail(zvl);
		// 관리수준 현황조사 삭제
		indexDao.deleteStatusExaminIdx(zvl);
		
		ArrayList lclasList = zvl.getArrayList("lclas[]");
		ArrayList mlsfcList = zvl.getArrayList("mlsfc[]");
		ArrayList sclasList = zvl.getArrayList("sclas[]");
		ArrayList checkItemList = zvl.getArrayList("checkItem[]");
		ArrayList excpPermYnList = zvl.getArrayList("excpPermYn[]");
		ArrayList helpCommentList = zvl.getArrayList("helpComment[]");
		ArrayList mngLevelIndexSeqList = zvl.getArrayList("mngLevelIndexSeq[]");
		
		String resultSe = zvl.getValue("resultSe");
		String tmpLclas = "";
		String tmpMlsfc = "";
		String tmpSclas = "";
		String tmpCheckItem = "";
		int lOrder = Integer.parseInt(lclasOrder);
		int mOrder = 1;
		int sOrder = 1;
		int dOrder = 1;
		
		for(int i=0; i < lclasList.size(); i++) {
			
			String lclas = lclasList.get(i).toString();
			String mlsfc = mlsfcList.get(i).toString();
			String sclas = sclasList.get(i).toString();
			String checkItem = checkItemList.get(i).toString();
			String excpPermYn = excpPermYnList.get(i).toString();
			String helpComment = helpCommentList.get(i).toString();
			String mngLevelIndexSeq = mngLevelIndexSeqList.get(i).toString();
			
			ZValue iZvl = new ZValue();
			// 차수 추가 시
			iZvl.put("orderNo", zvl.getValue("orderNo"));
			iZvl.put("registId", userInfo.getUserId());
			
			iZvl.put("lclas", lclas);
			iZvl.put("mlsfc", mlsfc);
			iZvl.put("sclas", sclas);
			iZvl.put("checkItem", checkItem);
			iZvl.put("excpPermYn", excpPermYn);
			iZvl.put("helpComment", helpComment);
			iZvl.put("mngLevelIndexSeq", mngLevelIndexSeq);
			iZvl.put("resultSe", resultSe);
			
			// for문 처음
			if(0 == i) {
				tmpLclas = lclas;
				tmpMlsfc = mlsfc;
				tmpSclas = sclas;
				tmpCheckItem = checkItem;
				iZvl.put("lclasOrder", lOrder);
				iZvl.put("mlsfcOrder", mOrder);
				iZvl.put("sclasOrder", sOrder);
				iZvl.put("checkItemOrder", dOrder);
			} else {
				// 대, 중, 소, 세 같은 경우 skip
				if(tmpLclas.equals(lclas) && tmpMlsfc.equals(mlsfc) && tmpSclas.equals(sclas)
						&& tmpCheckItem.equals(checkItem)) {
					continue;
				} else {
					// 대분류가 같은경우
					if(lclas.equals(tmpLclas)) {
						iZvl.put("lclasOrder", lOrder);
						// 중분류가 같은경우
						if(mlsfc.equals(tmpMlsfc)) {
							iZvl.put("mlsfcOrder", mOrder);
							// 소분류가 같은경우
							if(sclas.equals(tmpSclas)) {
								dOrder++;
								iZvl.put("sclasOrder", sOrder);
								iZvl.put("checkItemOrder", dOrder);
							} else {
								sOrder++;
								dOrder = 1;
								iZvl.put("sclasOrder", sOrder);
								iZvl.put("checkItemOrder", dOrder);
							}
						} else {
							mOrder++;
							sOrder = 1;
							dOrder = 1;
							iZvl.put("mlsfcOrder", mOrder);
							iZvl.put("sclasOrder", sOrder);
							iZvl.put("checkItemOrder", dOrder);
						}
					} else {
						lOrder++;
						mOrder = 1;
						sOrder = 1;
						dOrder = 1;
						iZvl.put("lclasOrder", lOrder);
						iZvl.put("mlsfcOrder", mOrder);
						iZvl.put("sclasOrder", sOrder);
						iZvl.put("checkItemOrder", dOrder);
					}
					tmpLclas = lclas;
					tmpMlsfc = mlsfc;
					tmpSclas = sclas;
					tmpCheckItem = checkItem;
				}
			}
			
			// 관리수준 현황조사 등록
			indexDao.insertStatusExaminIdx(iZvl);
			
			// 관리수준 현황조사 상세 등록
			createStatusExaminIdxDtl(zvl, iZvl);
		}
	}
	
	@Override
	public void deleteStatusExaminIndex(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		indexDao.deleteStatusExaminIdxDetail(zvl);
		
		indexDao.deleteStatusExaminIdx(zvl);
	}
	
	@Override
	public ZValue mIndexExcelUpload(ZValue zvl) throws Exception {
		
		indexDao.deleteMngLevelIndex(zvl);
		
		File excelTempFile = new File(zvl.getString("tempExcelFilePath"));
		FileInputStream excelFileInputStream = new FileInputStream(excelTempFile);
		XSSFWorkbook workbook = new XSSFWorkbook(excelFileInputStream);
		int rowindex = 0;
		int columnindex = 0;
		
		String tmpLclas = "";
		String tmpMlsfc = "";
		int lOrder = 1;
		int mOrder = 1;
		int sOrder = 1;
		ArrayList<String> rowArr = new ArrayList<String>();
		XSSFSheet sheet = workbook.getSheetAt(0);
		
		int rows = sheet.getPhysicalNumberOfRows();
		for(rowindex=1;rowindex<rows;rowindex++){
			XSSFRow row = sheet.getRow(rowindex);
			
			if(row != null){	
				int cells = row.getPhysicalNumberOfCells();
				ZValue insZvl = new ZValue();
				for(columnindex=0;columnindex<=cells;columnindex++){
					XSSFCell cell = row.getCell(columnindex);
					String value = null;
					
					if(cell==null){
						continue;
					}else{
						switch (cell.getCellType()){
							case XSSFCell.CELL_TYPE_FORMULA:
								value = cell.getCellFormula();
								break;
							case XSSFCell.CELL_TYPE_NUMERIC:
								value = (int)cell.getNumericCellValue() + "";
								break;
							case XSSFCell.CELL_TYPE_STRING:
								value = cell.getStringCellValue() + "";
								break;
							case XSSFCell.CELL_TYPE_BLANK:
								value = cell.getBooleanCellValue() + "";
								break;
							case XSSFCell.CELL_TYPE_ERROR:
								value = cell.getErrorCellValue() + "";
								break;
						}
						rowArr.add(value);
					}
					logger.debug("셀 좌표 : [" + rowindex + "][" + columnindex + "], 셀 내용 : " + value);
				}
				/*
				if(!zvl.getValue("orderNo").equals(rowArr.get(0))) {
					throw new Exception();
				}
				
				insZvl.put("orderNo", rowArr.get(0));
				*/
				
				insZvl.put("orderNo", zvl.getValue("orderNo"));
				insZvl.put("lclas", rowArr.get(1));
				insZvl.put("mlsfc", rowArr.get(2));
				insZvl.put("checkItem", rowArr.get(3));
				insZvl.put("excpPermYn", rowArr.get(4));
				insZvl.put("registId", zvl.getValue("registId"));
				
				if(1 == rowindex) {
					ZValue delZvl = new ZValue();
					delZvl.put("orderNo", insZvl.getValue("orderNo"));
					indexDao.deleteMngLevelIndex(zvl);
					
					tmpLclas = insZvl.getValue("lclas");
					tmpMlsfc = insZvl.getValue("mlsfc");
					insZvl.put("lclasOrder", lOrder);
					insZvl.put("mlsfcOrder", mOrder);
					insZvl.put("checkItemOrder", sOrder);
				} else {
					if(tmpLclas.equals(insZvl.getValue("lclas"))) {
						insZvl.put("lclasOrder", lOrder);
						if(tmpMlsfc.equals(insZvl.getValue("mlsfc"))) {
							insZvl.put("mlsfcOrder", mOrder);	
							sOrder++;
							insZvl.put("checkItemOrder", sOrder);
						} else {
							mOrder++;
							insZvl.put("mlsfcOrder", mOrder);
							sOrder = 1;
							insZvl.put("checkItemOrder", sOrder);
						}
					} else {
						lOrder++;
						mOrder = 1;
						sOrder = 1;
						insZvl.put("lclasOrder", lOrder);
						insZvl.put("mlsfcOrder", mOrder);
						insZvl.put("checkItemOrder", sOrder);
					}
					tmpLclas = insZvl.getValue("lclas");
					tmpMlsfc = insZvl.getValue("mlsfc");
				}
				
				indexDao.insertMngLevelIndex(insZvl);
				
				rowArr.clear();
			}
		}
		return zvl;
	}
	
	@Override
	public ZValue sIndexExcelUpload(ZValue zvl) throws Exception {
		
		// 관리수준 현황조사 상세 삭제
		indexDao.deleteStatusExaminIdxDetail(zvl);
		// 관리수준 현황조사 삭제
		indexDao.deleteStatusExaminIdx(zvl);
		
		File excelTempFile = new File(zvl.getString("tempExcelFilePath"));
		FileInputStream excelFileInputStream = new FileInputStream(excelTempFile);
		XSSFWorkbook workbook = new XSSFWorkbook(excelFileInputStream);
		int rowindex = 0;
		int columnindex = 0;
		
		String tmpLclas = "";
		String tmpMlsfc = "";
		String tmpSclas = "";
		String tmpCheckItem = "";
		String indexSeq = "";
		
		int lOrder = 1;
		int mOrder = 1;
		int sOrder = 1;
		int dOrder = 1;
		ArrayList<String> rowArr = new ArrayList<String>();
		XSSFSheet sheet = workbook.getSheetAt(0);
		
		int rows = sheet.getPhysicalNumberOfRows();
		for(rowindex=1;rowindex<rows;rowindex++){
			XSSFRow row = sheet.getRow(rowindex);
			
			if(row != null){	
				int cells = row.getPhysicalNumberOfCells();
				ZValue insZvl = new ZValue();
				ZValue dtlInsZvl = new ZValue();
				for(columnindex=0;columnindex<=cells;columnindex++){
					XSSFCell cell = row.getCell(columnindex);
					String value = null;
					
					if(cell==null){
						continue;
					}else{
						switch (cell.getCellType()){
							case XSSFCell.CELL_TYPE_FORMULA:
								value = cell.getCellFormula();
								break;
							case XSSFCell.CELL_TYPE_NUMERIC:
								value = (int)cell.getNumericCellValue() + "";
								break;
							case XSSFCell.CELL_TYPE_STRING:
								value = cell.getStringCellValue() + "";
								break;
							case XSSFCell.CELL_TYPE_BLANK:
								value = cell.getBooleanCellValue() + "";
								break;
							case XSSFCell.CELL_TYPE_ERROR:
								value = cell.getErrorCellValue() + "";
								break;
						}
						rowArr.add(value);
					}
					logger.debug("셀 좌표 : [" + rowindex + "][" + columnindex + "], 셀 내용 : " + value);
				}
				/*
				if(!zvl.getValue("orderNo").equals(rowArr.get(0))) {
					throw new Exception();
				}
				
				insZvl.put("orderNo", rowArr.get(0));
				*/
				insZvl.put("orderNo", zvl.getValue("orderNo"));
				insZvl.put("lclas", rowArr.get(1));
				insZvl.put("mlsfc", rowArr.get(2));
				insZvl.put("sclas", rowArr.get(3));
				insZvl.put("checkItem", rowArr.get(4));
				insZvl.put("excpPermYn", rowArr.get(6));
				insZvl.put("registId", zvl.getValue("registId"));
				
				dtlInsZvl.put("checkItem", rowArr.get(5));
				dtlInsZvl.put("registId", zvl.getValue("registId"));
				
				if(1 == rowindex) {
					tmpLclas = rowArr.get(1);
					tmpMlsfc = rowArr.get(2);
					tmpSclas = rowArr.get(3);
					tmpCheckItem = rowArr.get(4);
					
					lOrder = 1;
					mOrder = 1;
					sOrder = 1;
					dOrder = 1;
					insZvl.put("lclasOrder", lOrder);
					insZvl.put("mlsfcOrder", mOrder);
					insZvl.put("sclasOrder", sOrder);
					insZvl.put("checkItemOrder", dOrder);
					
					// 관리수준 현황조사 등록
					indexDao.insertStatusExaminIdx(insZvl);
					
					indexSeq = insZvl.getValue("indexSeq");
					dtlInsZvl.put("indexSeq", indexSeq);
					indexDao.insertStatusExaminIdxDetail(dtlInsZvl);
				} else {
					// 대, 중, 소, 세 같은 경우 skip
					if(tmpLclas.equals(rowArr.get(1)) && tmpMlsfc.equals(rowArr.get(2)) && tmpSclas.equals(rowArr.get(3))
							&& tmpCheckItem.equals(rowArr.get(4))) {
						dtlInsZvl.put("indexSeq", indexSeq);
						indexDao.insertStatusExaminIdxDetail(dtlInsZvl);
					} else {
						// 대분류가 같은경우
						if(rowArr.get(1).equals(tmpLclas)) {
							insZvl.put("lclasOrder", lOrder);
							// 중분류가 같은경우
							if(rowArr.get(2).equals(tmpMlsfc)) {
								insZvl.put("mlsfcOrder", mOrder);
								// 소분류가 같은경우
								if(rowArr.get(3).equals(tmpSclas)) {
									dOrder++;
									insZvl.put("sclasOrder", sOrder);
									insZvl.put("checkItemOrder", dOrder);
								} else {
									sOrder++;
									dOrder = 1;
									insZvl.put("sclasOrder", sOrder);
									insZvl.put("checkItemOrder", dOrder);
								}
							} else {
								mOrder++;
								sOrder = 1;
								dOrder = 1;
								insZvl.put("mlsfcOrder", mOrder);
								insZvl.put("sclasOrder", sOrder);
								insZvl.put("checkItemOrder", dOrder);
							}
						} else {
							lOrder++;
							mOrder = 1;
							sOrder = 1;
							dOrder = 1;
							insZvl.put("lclasOrder", lOrder);
							insZvl.put("mlsfcOrder", mOrder);
							insZvl.put("sclasOrder", sOrder);
							insZvl.put("checkItemOrder", dOrder);
						}
						tmpLclas = rowArr.get(1);
						tmpMlsfc = rowArr.get(2);
						tmpSclas = rowArr.get(3);
						tmpCheckItem = rowArr.get(4);
						
						// 관리수준 현황조사 등록
						indexDao.insertStatusExaminIdx(insZvl);
						
						indexSeq = insZvl.getValue("indexSeq");
						dtlInsZvl.put("indexSeq", indexSeq);
						indexDao.insertStatusExaminIdxDetail(dtlInsZvl);
					}
				}
				rowArr.clear();
			}
		}
		return zvl;
	}
	
	@Override
	public int selectMngLevelReqstCnt(ZValue zvl) throws Exception {
		return indexDao.selectMngLevelReqstCnt(zvl);
	}
	
	@Override
	public int selectStatusExaminEvalCnt(ZValue zvl) throws Exception {
		return indexDao.selectStatusExaminEvalCnt(zvl);
	}
}