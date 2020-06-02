package com.example.controller;

import java.util.List;

import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.test.annotation.Repeat;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.dao.CustomDAO;
import com.example.dto.GoodsVO;
import com.example.dto.ResellerVO;
import com.example.dto.UserVO;
import com.example.service.CustomService;
import com.example.service.Paging;
import com.example.service.ResellerService;
import com.example.service.UserService;

import net.sf.json.JSONObject;

@Controller
public class ResellerController {

	 @Autowired
	ResellerService r_service;
	 
	 @Autowired
	 CustomService service;
	 
		
		@RequestMapping(value="/reseller", method= {RequestMethod.GET, RequestMethod.POST})
		public String Reseller(Model model,
				HttpSession session,
				  @RequestParam Map map,
		          @RequestParam(value = "pageNo", required = false) Integer pageNo,
		            @RequestParam(value = "pageView", required = false) Integer pageView,
		            @RequestParam(value = "seller_nm", required = false) String seller_nm
				) throws Exception {
			
			   if(session.getAttribute("user_id") ==null) {
				   return "redirect:/";
			   }if (pageNo == null || "".equals(pageNo)) {
		            pageNo = 1;
		         }if (pageView == null || "".equals(pageView)) {
		            pageView = 10;
		         }
		         
		         int count = r_service.PagingCountReseller(map);
			     Paging pageInfo = new Paging(count, pageNo, pageView);
			     model.addAttribute("pageInfo", pageInfo);
	    
	     		 map.put("pageNo", pageNo);
			     map.put("pageView", pageView);
			     map.put("offSet", (pageNo - 1) * pageView);
		         
			List<UserVO> resellerList = r_service.selectReseller(map);
			model.addAttribute("resellerList", resellerList);
			
			return "/reseller";
		}
		
		//리셀러 등록 
		  @RequestMapping(value = "/resellerInsert", method = { RequestMethod.GET, RequestMethod.POST })
		   public void resellerInsert(
		         HttpServletRequest req,
		         HttpServletResponse res,         
		         @RequestParam Map map)  throws Exception  {
		      
		      JSONObject jsob = new JSONObject();
		      
		      try {
		         int count = r_service.InsertReseller(map);
		         
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
		  @RequestMapping(value = "/resellerUpdate", method = { RequestMethod.GET, RequestMethod.POST })
		   public void updateReseller(
		         HttpServletRequest req,
		         HttpServletResponse res,         
		         @RequestParam Map map)  throws Exception  {
			   
			   JSONObject jsob = new JSONObject();
			      
			      try {
			         int count = r_service.updateReseller(map);
			         
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
		  
		  @RequestMapping(value="/resellerDetail/{office_id}", method={RequestMethod.GET, RequestMethod.POST})
			public String resellerDetail(Model model,
					   HttpSession session,
			           @RequestParam Map map,
			           @PathVariable String office_id) {
				
				 if(session.getAttribute("user_id") ==null) {
					   return "redirect:/";
				   }
				
				 // select Issue
					 UserVO reseller = r_service.resellerDetail(office_id);
					  model.addAttribute("reseller", reseller);

					  return "/reseller_detail";
			}
		  
		  @RequestMapping(value = "/resellerExcel")
		   public void resellerExcel(HttpServletResponse response,
		   		@RequestParam Map map
		   		) throws Exception {
			   
			  List<UserVO> resellerList = r_service.selectReseller(map);
			  r_service.resellerExcel(response, resellerList); 
		   	}
		  
		  
}
