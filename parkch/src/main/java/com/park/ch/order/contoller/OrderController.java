package com.park.ch.order.contoller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.park.ch.cmn.LoginVO;
import com.park.ch.cmn.SessionVO;
import com.park.ch.user.service.UserService;

@RequestMapping(value = "/pay")
@Controller
public class OrderController {
	
	@Autowired
	private UserService UserService;
	
	HashMap<String, Object> returnMap = new HashMap<String, Object>();
	
    @RequestMapping(value = "/order.do")
    public String test(@ModelAttribute("loginVO") LoginVO loginVO, Model model, HttpServletRequest req) throws Exception {
    	
		HttpSession session = req.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		
		loginVO.setUserId(userInfo.getUserId());
		LoginVO result = (LoginVO) UserService.userInfo(loginVO);
		
		model.addAttribute("userNm",    result.getUserNm());
		model.addAttribute("userTelno", result.getUserTelno());
		model.addAttribute("userEmail", result.getUserEmail());
		
        return "order";
    }

    @ResponseBody
    @RequestMapping(value = "/orderConfirm.do")
    public HashMap<String, Object> orderConfirm(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest req, Model model) throws Exception {
    	
    	HttpSession session = req.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		
		loginVO.setUserId(userInfo.getUserId());
		LoginVO resultVO = (LoginVO) UserService.userInfo(loginVO);
		
        String buyer_no    = resultVO.getUserNo();
        String buyer_name  = req.getParameter("buyer_name");
        String buyer_hp    = req.getParameter("buyer_hp");
        String buyer_email = req.getParameter("buyer_email");
        String buy_goods   = "연회비";
        String buy_total   = "10000";
        String order_num   = "";
        String is_reguler  = "N";
        String is_taxsave  = "N";
        String work_type   = "CERT";
        
        returnMap.put("buyer_no", buyer_no);
        returnMap.put("buyer_name", buyer_name);
        returnMap.put("buyer_hp", buyer_hp);
        returnMap.put("buyer_email", buyer_email);
        returnMap.put("buy_goods", buy_goods);
        returnMap.put("buy_total", buy_total);
        returnMap.put("order_num", order_num);
        returnMap.put("is_reguler", is_reguler);
        returnMap.put("pay_year", "");
        returnMap.put("pay_month", "");
        returnMap.put("is_taxsave", is_taxsave);
        returnMap.put("work_type", work_type);
        
        return returnMap;
    }

    @RequestMapping(value = "/orderResult.do")
    public String orderResult(@RequestParam Map<String, String> param, @ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest req) throws Exception {
    	
    	String result = "";
    	HttpSession session = req.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		
    	try {
			
			String PCD_PAY_RST = param.get("PCD_PAY_RST");
			if(PCD_PAY_RST == "success") {
				
				try {
					param.put("u_id", userInfo.getUserId());
					param.put("mem_yn", "Y");
					param.put("pay_date", "now()");
					
					UserService.updateUser(param);
					
				} catch (Exception e) {
					e.printStackTrace();
				}
				
				result = "orderResult";
				
			}else {
				result = "index";
			}
			
		} catch (Exception e){
			System.err.println(e.toString());
		}
		return result;
    }
}
