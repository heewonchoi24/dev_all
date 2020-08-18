package org.ssis.pss.dashboard.web;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.ssis.pss.dashboard.service.DashboardService;

@Controller
public class DashboardController {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	protected Logger logger = LogManager.getLogger(this.getClass()); 
	
	@Autowired
	private DashboardService dashboardService;
	
	// 대시보드 교육일정
	@RequestMapping("/admin/contact/dashboardSchedule.do")
    public String dashboardSchedule(ModelMap model){
	    model.addAttribute("pageLevel1", "contact");
		model.addAttribute("pageLevel2", "9");
		model.addAttribute("pageName", "대시보드 교육일정");
		
		return "contact/dashboardSchedule";
	}
	
	// 대시보드 교육일정 수정(상세)
	@RequestMapping("/admin/contact/dashboardScheduleWrite.do")
    public String dashboardScheduleWrite(ModelMap model){
		model.addAttribute("pageLevel1", "contact");
		model.addAttribute("pageLevel2", "9");
		model.addAttribute("pageName", "대시보드 교육일정");
	    
		return "contact/dashboardScheduleWrite";
	}
	
	// 대시보드 속도관리
	@RequestMapping("/admin/contact/dashboardSetting.do")
    public String dashboardSetting(ModelMap model){
		model.addAttribute("pageLevel1", "contact");
		model.addAttribute("pageLevel2", "8");
		model.addAttribute("pageName", "대시보드 속도관리");
	    
		return "contact/dashboardSetting";
	}
}