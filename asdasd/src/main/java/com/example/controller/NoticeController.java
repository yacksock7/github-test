package com.example.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.dto.CustomVO;
import com.example.dto.NoticeVO;
import com.example.service.CustomService;
import com.example.service.NoticeService;
import com.example.service.Paging;

import net.sf.json.JSONObject;

@Controller
public class NoticeController {
	
	 @Autowired
	 NoticeService n_service;
	
	@RequestMapping(value="/notice", method={ RequestMethod.GET, RequestMethod.POST })
	public String notice(Model model,
			   HttpSession session,
	           @RequestParam Map map,
	           @RequestParam(value = "pageNo", required = false) Integer pageNo,
	           @RequestParam(value = "pageView", required = false) Integer pageView,
	           @RequestParam(value = "notice_title", required = false) String notice_title
			) throws Exception {
		
		 if(session.getAttribute("user_id") ==null) {
			   return "redirect:/";
		   }
		 if (pageNo == null || "".equals(pageNo)) {
	            pageNo = 1;
	         }
	         if (pageView == null || "".equals(pageView)) {
	            pageView = 10;
	         }
	         /* paging */
	         int count = n_service.PagingCountNotice(map);
		     Paging pageInfo = new Paging(count, pageNo, pageView);
		     model.addAttribute("pageInfo", pageInfo);
  
		     map.put("pageNo", pageNo);
		     map.put("pageView", pageView);
		     map.put("offSet", (pageNo - 1) * pageView);
	         
	         // select 
		        List<NoticeVO> noticeList = n_service.selectNotice(map);
		        model.addAttribute("noticeList", noticeList);

		        model.addAttribute("pageView", pageView);
		        model.addAttribute("pageNo", pageNo);
		        
		        model.addAttribute("fr_wb_dt", (String) map.get("fr_wb_dt"));
		        model.addAttribute("to_wb_dt", (String) map.get("to_wb_dt"));
		        model.addAttribute("notice_title", (String) map.get("notice_title"));

//		        
		        if(session.getAttribute("user_group").equals("1")) {
		        	return "/notice_admin";
		        }else {
		        	return "/notice_reseller";
		        }
	}
	
	
	//공지사항 등록 
	  @RequestMapping(value = "/noticeInsert", method = { RequestMethod.GET, RequestMethod.POST })
	   public void noticeInsert(
	         HttpServletRequest req,
	         HttpServletResponse res,         
	         @RequestParam Map map)  throws Exception  {
	      
	      JSONObject jsob = new JSONObject();
	      
	      try {
	         int count = n_service.InsertNotice(map);

	         
	         map.put("errCd", count);
	         map.put("errMsg", "등록에 성공하였습니다.");
	                         

	      } catch (Exception e) {
	         System.out.println(e);

	         map.put("errCd", "-1"); // 
	         map.put("errMsg", "등록에 실패하였습니다.");

	      } finally {

	         jsob = JSONObject.fromObject(map);
	         res.setContentType("text/html;charset=UTF-8");
	         res.getWriter().print(jsob);
	      }
	   }
	  
	  
	//수정 삭제 
	  @RequestMapping(value = "/noticeUpdate", method = { RequestMethod.GET, RequestMethod.POST })
	   public void updateNotice(
	         HttpServletRequest req,
	         HttpServletResponse res,         
	         @RequestParam Map map)  throws Exception  {
		   
		   JSONObject jsob = new JSONObject();
		      
		      try {
		//
		         int count = n_service.updateNotice(map);
		         
		         map.put("errCd", count);
		         String ud_flag = (String)map.get("ud_flag");
		         
		         if(ud_flag.equals("D")) map.put("errMsg", "삭제되었습니다.");
		         else map.put("errMsg", "수정되었습니다.");
		                         

		      } catch (Exception e) {
		         System.out.println(e);

		         map.put("errCd", "-1"); // 
		         map.put("errMsg", "An error occurred during processing.");

		      } finally {

		         jsob = JSONObject.fromObject(map);
		         res.setContentType("text/html;charset=UTF-8");
		         res.getWriter().print(jsob);
		      }
	   }

	
	
	

}
