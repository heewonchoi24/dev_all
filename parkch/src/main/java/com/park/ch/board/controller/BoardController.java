package com.park.ch.board.controller;


import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.park.ch.board.service.BoardService;
import com.park.ch.cmn.LoginVO;
import com.park.ch.cmn.SessionVO;
import com.park.ch.cmn.contoller.Pagination;
import com.park.ch.cmn.dao.CmnSupportDAO;
import com.park.ch.cmn.util.UploadFileUtils;

@RequestMapping(value = "/board")
@Controller
public class BoardController extends CmnSupportDAO {

	@Autowired
	BoardService BoardService;

	@RequestMapping(value = "/boardList.do", method = RequestMethod.GET)
	public ModelAndView boardList(@RequestParam Map<String, String> param, @RequestParam(required = false, defaultValue = "1") int page
			,@RequestParam(required = false, defaultValue = "1") int range) throws Exception {

		ModelAndView mv = new ModelAndView();

		try {
			//전체 게시글 개수
			int listCnt = BoardService.getBoardListCnt();

			//Pagination
			Pagination pagination = new Pagination();
			pagination.pageInfo(page, range, listCnt);

			mv.addObject("pagination", pagination);
			mv.addObject("list", BoardService.boardList(pagination));
			mv.setViewName( "boardList" );

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mv;
	}

	@RequestMapping(value = "/boardDetail.do", method = RequestMethod.GET)
	public ModelAndView boardDetail(@RequestParam Map<String, String> param) throws Exception {

		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		ModelAndView mv = new ModelAndView();

		try {
			
			BoardService.boardViewCntIncrease(param);
			returnMap = BoardService.boardDetail(param);

			mv.addObject("list", returnMap);
			mv.setViewName( "boardDetail" );

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mv;
	}	

	@RequestMapping(value = "/boardWrite.do")
	public ModelAndView boardWrite(@RequestParam Map<String, String> param, HttpServletRequest req) throws Exception {

		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		ModelAndView mv = new ModelAndView();

		// URL 직접 입력시 로그인 페이지로 이동
		String referer = req.getHeader("REFERER");
		if (referer == null || "".equals(referer)) {
			mv.setViewName( "index" );
			return mv;
		}

		if(param.get("idx") != null || param.get("idx") != "") {
			returnMap = BoardService.boardDetail(param);
			mv.addObject("list", returnMap);
		}

		mv.setViewName( "boardWrite" );

		return mv;
	}	

	@ResponseBody
	@RequestMapping(value = "/insertBoard.do")
	public HashMap<String, Object> insertBoard(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest req, @RequestParam Map<String, String> param) throws Exception {

		HashMap<String, Object> returnMap = new HashMap<String, Object>();

		try {
			HttpSession session = req.getSession();
			SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
			String userId = userInfo.getUserId();

			param.put("regist_id", userId);

			BoardService.insertBoard(param);

			returnMap.put("messageCd",  "Y");
			returnMap.put("message",    "등록되었습니다.");
			returnMap.put("messageUrl", "/board/boardList.do");

		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnMap;
	}	

	@ResponseBody
	@RequestMapping(value = "/updateBoard.do")
	public HashMap<String, Object> updateBoard(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest req, @RequestParam Map<String, String> param) throws Exception {

		HashMap<String, Object> returnMap = new HashMap<String, Object>();

		try {
			HttpSession session = req.getSession();
			SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
			String userId = userInfo.getUserId();

			param.put("upd_id", userId);

			BoardService.updateBoard(param);

			returnMap.put("messageCd",  "Y");
			returnMap.put("message",    "등록되었습니다.");
			returnMap.put("messageUrl", "/board/boardList.do");

		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnMap;
	}		

	@ResponseBody
	@RequestMapping(value = "/deleteBoard.do")
	public HashMap<String, Object> deleteBoard(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest req, @RequestParam Map<String, String> param) throws Exception {

		HashMap<String, Object> returnMap = new HashMap<String, Object>();

		try {
			BoardService.deleteBoard(param);

			returnMap.put("messageCd",  "Y");
			returnMap.put("message",    "삭제되었습니다.");
			returnMap.put("messageUrl", "/board/boardList.do");

		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnMap;
	}	

	@RequestMapping(value="/imageUpload.do")
	public void imageUpload(Model model, HttpServletRequest req,HttpServletResponse res, @RequestParam MultipartFile upload, @RequestParam(value="CKEditorFuncNum", required=false) String CKEditorFuncNum) {

	    // 랜덤 문자 생성
        UUID uid = UUID.randomUUID();
        
        OutputStream out = null;
        PrintWriter printWriter = null;
        
        //인코딩
        res.setCharacterEncoding("utf-8");
        res.setContentType("text/html;charset=utf-8");
        
		try {
	        //파일 이름 가져오기
            String fileName = upload.getOriginalFilename();
            byte[] bytes = upload.getBytes();
            
            HttpSession session = req.getSession();
    		String rootPath = session.getServletContext().getRealPath("/");
            
            //이미지 경로 생성
            String path = "/Users/choiheewon/git/parkch/parkch/src/main/webapp/resources/upload/";
    		//String path = "/data/www/resources/upload";
    		String path_url = "/resources/upload";
    		String savedPath = UploadFileUtils.calcPath(path);
            String ckUploadPath = path + savedPath + "/"+ uid + "_" + fileName;
            String imgPath = path_url + savedPath + "/"+ uid + "_" + fileName;
            
            File folder = new File(path + savedPath);
            
            //해당 디렉토리 확인
            if(!folder.exists()){
                try{
                    folder.mkdirs(); // 폴더 생성
                }catch(Exception e){
                    e.getStackTrace();
                }
            }
            
            out = new FileOutputStream(new File(ckUploadPath));
            out.write(bytes);
            out.flush(); // outputStram에 저장된 데이터를 전송하고 초기화
            
            String callback = req.getParameter("CKEditorFuncNum");
            printWriter = res.getWriter();
            String fileUrl = ckUploadPath;  // 작성화면
            
	        // 업로드시 메시지 출력
            printWriter.println("{\"filename\" : \""+fileName+"\", \"uploaded\" : 1, \"url\":\""+imgPath+"\"}");
            printWriter.flush();
            
            System.out.println("imgPath : " +  imgPath);

		} catch (IOException e) {
			e.printStackTrace();

		} finally {
			try {
				if ( out != null) {
					out.close();
				}
				if (printWriter != null) {
					printWriter.close();
				}
			}catch(IOException e) {
				e.printStackTrace();
			}

		}
		return;

	}


}
