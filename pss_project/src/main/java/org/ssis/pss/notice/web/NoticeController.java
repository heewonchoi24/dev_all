package org.ssis.pss.notice.web;

import java.io.File;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.cmn.service.CmnService;
import org.ssis.pss.cmn.util.WebFactoryUtil;
import org.ssis.pss.connect.web.servie.ConnectService;
import org.ssis.pss.notice.service.NoticeService;
import org.ssis.pss.user.service.UserService;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.service.Globals;
import egovframework.com.cmm.util.LogCrud;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class NoticeController {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	protected Logger logger = LogManager.getLogger(this.getClass()); 
	
	@Autowired
	private EgovMessageSource egovMessageSource;
	
	@Autowired
	private NoticeService noticeService;
	
	@Autowired
	private CmnService cmnService; 
	
	@Autowired
	private UserService UserService;	
	
	@Autowired
	private ConnectService connectService;

	/**
	 * 시스템관리 - 게시판 관리
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/notice/mngNoticeList.do")
	public ModelAndView mngNoticeList(HttpServletRequest request, HttpServletResponse response
										) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		List<ZValue> resultList = null;
		
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		resultList = noticeService.noticeBbsList(zvl);
		
		modelAndView.addObject("noticeBbsList", resultList);
		modelAndView.setViewName("notice/noticeList");
			
		return modelAndView;
	}
	
	/**
	 * 시스템관리 - 게시판 관리 - 게시판 사용여부 업데이트 AJAX(미사용)
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/notice/updateBbsStatus.do")
	public ModelAndView updateBbsStatus(HttpServletRequest request, HttpServletResponse response
										) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");

		zvl.put("adminId", userInfo.getUserId());
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		noticeService.updateBbsStatus(zvl);		
			
		modelAndView.addObject("message", egovMessageSource.getMessage("success.common.update"));
		modelAndView.setViewName( "jsonView" );
		
		return modelAndView;
	}
	
	/**
	 * 시스템 관리 - 게시판 관리 - 게시판별 글목록
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/notice/mngNoticeDtlList.do")
	public ModelAndView mngNoticeDtlList(HttpServletRequest request, HttpServletResponse response
											) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		ZValue result = null;
		List<ZValue> resultList = null;
		int bbsTotalCnt = 0; 
		int totalPageCnt = 0;
		String pageLevel2, pageName  = "";
		
		//페이징 처리 변수 추후 property 방식으로 변경가능
    	if(!zvl.containsKey("pageIndex")) 
    		zvl.put("pageIndex", 1);
    	zvl.put("pageUnit", 10);
    	zvl.put("pageSize", 10);
    	
    	PaginationInfo paginationInfo = new PaginationInfo();
    	
		paginationInfo.setCurrentPageNo(zvl.getInt("pageIndex"));
		paginationInfo.setRecordCountPerPage(zvl.getInt("pageUnit"));
		paginationInfo.setPageSize(zvl.getInt("pageSize"));
		
		zvl.put("firstIndex", paginationInfo.getFirstRecordIndex());
		zvl.put("lastIndex", paginationInfo.getLastRecordIndex());
		zvl.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		try{
			result = noticeService.bbsNm(zvl);
			modelAndView.addAllObjects(result);
			
			resultList = noticeService.bbsList(zvl);
			modelAndView.addObject("bbsList", resultList);

			resultList = noticeService.bbsAttachFileList(zvl);
			modelAndView.addObject("bbsAttachFileList", resultList);
			
			bbsTotalCnt = noticeService.bbsListCnt(zvl);
			totalPageCnt = (int) Math.ceil((double)bbsTotalCnt/(double)10);
			
			logger.debug("############## zvl ##############");
			logger.debug(totalPageCnt);
			logger.debug("############## zvl ##############");
			
			modelAndView.addObject("bbsTotalCnt", bbsTotalCnt);
			modelAndView.addObject("totalPageCnt", totalPageCnt);
			
			paginationInfo.setTotalRecordCount(bbsTotalCnt);
			
			modelAndView.addAllObjects(zvl);
			modelAndView.addObject("paginationInfo", paginationInfo);
			modelAndView.setViewName( "notice/noticeDtList" );
			
			/* jsp화면 Sidebar 정보 */
			if (zvl.get("bbsCd").equals("BN01")){
				pageLevel2 = "1"; 	pageName = "공지사항";
			} else if (zvl.get("bbsCd").equals("BN02")){
				pageLevel2 = "2";	pageName = "자주하는 질문";
			} else if (zvl.get("bbsCd").equals("BN03")){
				pageLevel2 = "3";	pageName = "질의응답";
			} else if (zvl.get("bbsCd").equals("BN04")){
				pageLevel2 = "4";	pageName = "자료실";
			} else if (zvl.get("bbsCd").equals("BN05")){
				pageLevel2 = "5";	pageName = "개인정보동향";
			} else if (zvl.get("bbsCd").equals("BN06")){
				pageLevel2 = "6";	pageName = "우수사례자료실";
			} else {
				pageLevel2 = "7";	pageName = "개인정보법령";
			} 
			modelAndView.addObject("pageLevel1", "board");
			modelAndView.addObject("pageLevel2", pageLevel2);
			modelAndView.addObject("pageName", pageName);
			
		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		return modelAndView;
	}
	
	/**
	 * 시스템 관리 - 게시판 관리 - 게시판별 글 삭제 AJAX
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/notice/deleteThread.do")
	public ModelAndView deleteThread(HttpServletRequest request, HttpServletResponse response
										) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");

		zvl.put("adminId", userInfo.getUserId());
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		noticeService.deleteThread(zvl);		
			
		modelAndView.addObject("message", egovMessageSource.getMessage("success.common.update"));
		modelAndView.setViewName( "jsonView" );	
		
		// 로그 이력 저장
		String arr[] = zvl.getString("delSeq").split(",");
		for(int i = 0; i <  arr.length; i++){
			String menu_id = null;
			String url = "/admin/notice/mngNoticeDtlList.do?bbsCd=" + zvl.get("bbsCd");
			zvl.put("url", url);
			menu_id = connectService.getConnectHistDataAdminMenuId(zvl);	
			zvl.put("parameter",  zvl.toString());
			zvl.put("crud",       LogCrud.DELETE);
			zvl.put("menu_id",    menu_id);
			zvl.put("bbs_cd",     zvl.get("bbsCd"));
			zvl.put("session_id", request.getRequestedSessionId());
			zvl.put("view_seq",   arr[i]);
			UserService.connectHistoryInsert(zvl, request);			
		}
		
		return modelAndView;
	}
	
	/**
	 * 시스템 관리 - 게시판 관리 - 게시판별 글 삭제취소 AJAX
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/notice/rollbackThread.do")
	public ModelAndView rollbackThread(HttpServletRequest request, HttpServletResponse response
										) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");

		zvl.put("adminId", userInfo.getUserId());
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		noticeService.rollbackThread(zvl);		
		
		modelAndView.addObject("message", egovMessageSource.getMessage("success.common.update"));
		modelAndView.setViewName( "jsonView" );
		
		return modelAndView;
	}
	
	
	/**
	 * 게시판 글쓰기 페이지
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/admin/notice/noticeWrite.do")
	public ModelAndView noticeWrite(HttpServletRequest request,
					      HttpServletResponse response
					      ) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		ZValue result = null;
		List<ZValue> resultList = null;
		String pageLevel2, pageName  = "";
		String seq = zvl.getString("bbsSeq");
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		
		result = noticeService.bbsNm(zvl);
		modelAndView.addAllObjects(result);
		
		result = noticeService.bbsImgList(zvl);
		modelAndView.addObject("imgList", result);
		
		zvl.put("uppercode", "CT00");
		resultList = cmnService.retrieveCommCdList(zvl);
		modelAndView.addObject("resourceBbsCategoryList", resultList);

		if(seq != null && !seq.isEmpty()){
			result = noticeService.bbsView(zvl);
			modelAndView.addObject("bbsView", result);
			
			resultList = noticeService.bbsAttachFileList(zvl);
			modelAndView.addObject("bbsAttachFileList", resultList);
		}
			
		modelAndView.addAllObjects(zvl);
		modelAndView.setViewName( "notice/noticeWrite" );
		
		/* jsp화면 Sidebar 정보 */
		if (zvl.get("bbsCd").equals("BN01")){
			pageLevel2 = "1"; 	pageName = "공지사항";
		} else if (zvl.get("bbsCd").equals("BN02")){
			pageLevel2 = "2";	pageName = "자주하는 질문";
		} else if (zvl.get("bbsCd").equals("BN03")){
			pageLevel2 = "3";	pageName = "질의응답";
		} else if (zvl.get("bbsCd").equals("BN04")){
			pageLevel2 = "4";	pageName = "자료실";
		} else if (zvl.get("bbsCd").equals("BN05")){
			pageLevel2 = "5";	pageName = "개인정보동향";
		} else if (zvl.get("bbsCd").equals("BN06")){
			pageLevel2 = "6";	pageName = "우수사례자료실";
		} else {
			pageLevel2 = "0";	pageName = "개인정보법령";
		} 
		modelAndView.addObject("pageLevel1", "board");
		modelAndView.addObject("pageLevel2", pageLevel2);
		modelAndView.addObject("pageName", pageName);	
		
		// connectHistoryInsert For Admin Notice
		String menu_id = null;
		String url = "/admin/notice/mngNoticeDtlList.do?bbsCd=" + zvl.get("bbsCd");
		zvl.put("url", url);
		menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
		zvl.put("parameter",  zvl.toString());
		zvl.put("crud",       "R");
		zvl.put("menu_id",    menu_id);
		zvl.put("bbs_cd",     zvl.get("bbsCd"));
		zvl.put("session_id", request.getRequestedSessionId());
		zvl.put("view_seq",   zvl.getString("bbsSeq"));
		UserService.connectHistoryInsert(zvl, request);			
		
		return modelAndView;
	}
	
	/** 게시판 파일 첨부
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/notice/noticeFileInsert.do")
	public ModelAndView bbsFileInsert(
								HttpServletRequest request, 
								HttpServletResponse response,
								ModelMap model
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try{
			zvl = noticeService.bbsThreadInsert(zvl, request);
			
			logger.debug("############## zvl ##############");
			logger.debug(zvl);
			logger.debug("############## zvl ##############");
			
			modelAndView.addObject("message", egovMessageSource.getMessage("success.common.insert"));
			modelAndView.addAllObjects(zvl);
			modelAndView.setViewName( "jsonView" );
		}catch(Exception e){
			modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.insert"));
			logger.error( e );
			e.printStackTrace();
		}
		
		return modelAndView;	
	}
	
	/**
	 * 게시판 파일 갱신
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/notice/noticeFileUpdate.do")
	public ModelAndView bbsFileUpdate(
								HttpServletRequest request, 
								HttpServletResponse response,
								ModelMap model
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		try{
			noticeService.bbsThreadUpdate(zvl, request);
			
			modelAndView.addObject("message", egovMessageSource.getMessage("success.common.insert"));
			modelAndView.addAllObjects(zvl);
			modelAndView.setViewName( "jsonView" );
		}catch(Exception e){
			modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.insert"));
			logger.error( e );
			e.printStackTrace();
		}
		
		return modelAndView;	
	}
	
	/**
	 * 게시판 파일 삭제
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/notice/noticeFileDelete.do")
	public ModelAndView bbsFileDelete(
								HttpServletRequest request, 
								HttpServletResponse response,
								ModelMap model
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		try{
			noticeService.bbsFileDelete(zvl, request);
			
			modelAndView.addObject("message", egovMessageSource.getMessage("success.common.delete"));
			modelAndView.addAllObjects(zvl);
			modelAndView.setViewName( "jsonView" );
		}catch(Exception e){
			modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.delete"));
			logger.error( e );
			e.printStackTrace();
		}
		
		return modelAndView;	
	}
	
	/**
	 * 게시판 글쓰기
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/admin/notice/noticeRegistThread.do")
	public ModelAndView bbsWriteThread(HttpServletRequest request,
					      HttpServletResponse response
					      ) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		/* XSS 제목 부분 조치 */
		zvl.put("subject", zvl.get("subject").toString()
				.replace("<", "&amp;lt").replace(">", "&amp;gt").replace("\"", "&amp;quot"));
		zvl.put("subject", zvl.get("subject").toString().replace("&amp;quot", "\""));
		
		/* 웹 취약점 점검 XSS 크로스사이트 스크립팅 조치 
		 *  꺽쇠부호 치환 (2019-10-30) 							
		zvl.put("contents", zvl.get("contents").toString()
				.replace("<", "&amp;lt").replace(">", "&amp;gt").replace("\"", "&amp;quot")); */
		/* 허용태그 설정 
		zvl.put("contents", zvl.get("contents").toString()
				.replace("&amp;ltp&amp;gt", "<p>").replace("&amp;ltp", "<p").replace("&amp;lt/p&amp;gt", "</p>")
				.replace("&amp;ltbr&amp;gt", "<br>").replace("&amp;quot", "\"")
				.replace("&amp;ltb&amp;gt", "<b>").replace("&amp;lt/b&amp;gt", "</b>")
				.replace("&amp;ltspan&amp;gt", "<span>").replace("&amp;ltspan", "<span").replace("&amp;lt/span&amp;gt", "</span>"));
		* 스마트에디터로 에디터 변경 후 xss 조치 확인 필요
		*/

		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		noticeService.bbsRegistThread(zvl, request);
		
		modelAndView.addAllObjects(zvl);
		modelAndView.setViewName( "jsonView" );
		
		return modelAndView;
	}
	
	/**
	 * 게시판 질의응답 답변하기
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/notice/noticeRegistThreadAnswer.do")
	public ModelAndView bbsRegistThreadAnswer(HttpServletRequest request,
					      HttpServletResponse response
					      ) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		noticeService.bbsRegistThreadAnswer(zvl, request);
		
		modelAndView.addAllObjects(zvl);
		modelAndView.setViewName( "jsonView" );
	
		return modelAndView;
	}
	
	/**
	 * 게시판 상세보기
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/notice/noticeView.do")
	public ModelAndView bbsView(
						HttpServletRequest request,
						HttpServletResponse response
					      ) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		ZValue result = null;
		List<ZValue> resultList = null;
		String seq = zvl.getString("seq");
		
		if(!zvl.containsKey("pageIndex")) 
    		zvl.put("pageIndex", 1);
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		try{
			result = noticeService.bbsView(zvl);
			modelAndView.addObject("bbsView", result);
			
			resultList = noticeService.bbsAttachFileList(zvl);
			modelAndView.addObject("bbsAttachFileList", resultList);
			
			modelAndView.addAllObjects(zvl);
			modelAndView.setViewName( "bbs/bbsView" );
			
		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		
		return modelAndView;
	}
	
	/**
	 * 게시판 관리 - 게시판 type 변경 AJAX
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/notice/typeUpdate.do")
	public ModelAndView typeUpdateThread(HttpServletRequest request, HttpServletResponse response) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");

		zvl.put("updtId", userInfo.getUserId());
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		noticeService.bbsTypeUpdateThread(zvl);		
		
		modelAndView.addObject("message", egovMessageSource.getMessage("success.common.update"));
		modelAndView.setViewName( "jsonView" );
		
		return modelAndView;
	}
	
	/**
	 * 게시판 관리 - 게시판 목록 이미지 생성
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/admin/notice/listImgInsert.do")
	public ModelAndView listImgInsertThread(MultipartHttpServletRequest request, HttpServletResponse response) throws Exception {
		
		log.debug( "listImgInsert@@@@@ fileUpload :: Start..." );
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);

		try{
			String uploadPath = Globals.CROSSUPLOADER_FILE_PATH;
			
			// 경로에 폴더를 지정
			String saveDirPath = uploadPath + "bbsImg/";
			
			Iterator<String> iterator = request.getFileNames(); 

			File file = File.createTempFile("temp_image-", ".jpg");
			File folder = new File(saveDirPath);
			
			MultipartFile multipartFile = null; 
			String originalFileName = null; 
			String originalFileExtension = null; 
			String storedFileName = null;

			if( !folder.exists() ){ 
				try { folder.mkdirs(); } catch(Exception e){ e.printStackTrace();}
			}
			
			while(iterator.hasNext()){ 
				multipartFile = request.getFile(iterator.next()); 
				
				if(multipartFile.isEmpty() == false){ 
	        		originalFileName = multipartFile.getOriginalFilename();
	        		originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
	        		storedFileName = UUID.randomUUID().toString() + originalFileExtension;
	        		
	        		file = new File(saveDirPath + storedFileName);
	        		multipartFile.transferTo(file);
	        		zvl.put("img_nm", storedFileName);
	        		zvl.put("img_ori_nm", originalFileName);
	        		zvl.put("img_path", saveDirPath);
				} 
			}	
			log.debug( "listImgInsert@@@@@ fileUpload :: Done..." );
			
			int cnt = 0;
			cnt = noticeService.bbsImgCnt(zvl);
			if(cnt > 0){
				noticeService.bbsImgUpdate(zvl);
			} else {
				noticeService.bbsListImgInsertThread(zvl, request);
			}
			modelAndView.addObject("message", egovMessageSource.getMessage("success.common.insert"));
			modelAndView.addAllObjects(zvl);
			modelAndView.setViewName( "jsonView" );
			
		}catch(Exception e){
			modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.insert"));
			logger.error( e );
			e.printStackTrace();
		}	

		return modelAndView;
	}
	
	/**
	 * 게시판 이미지 파일 삭제
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/admin/notice/bbsImgFileDelete.do")
	public ModelAndView bbsImgFileDelete( HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		try{
			noticeService.bbsImgdelete(zvl);
			
			modelAndView.addObject("message", egovMessageSource.getMessage("success.common.delete"));
			modelAndView.addAllObjects(zvl);
			modelAndView.setViewName( "jsonView" );
		}catch(Exception e){
			modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.delete"));
			logger.error( e );
			e.printStackTrace();
		}
		
		return modelAndView;	
	}
	
}
