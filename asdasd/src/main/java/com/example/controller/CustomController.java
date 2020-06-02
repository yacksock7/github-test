package com.example.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.HttpSessionRequiredException;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.example.dto.CustomVO;
import com.example.dto.GoodsVO;
import com.example.dto.ResellerVO;
import com.example.service.CustomService;
import com.example.service.Paging;
import com.example.service.ResellerService;
import com.mysql.cj.api.Session;

import net.sf.json.JSONObject;

@Controller
public class CustomController {
	
	 @Autowired
	 CustomService service;
	 
	 @Autowired
	ResellerService r_service;
	 
		   @RequestMapping(value="/custom", method= {RequestMethod.POST,RequestMethod.GET})
		   public String Custom(Model model,
				   HttpSession session,
		           @RequestParam Map map,
		           @RequestParam(value = "pageNo", required = false) Integer pageNo,
		            @RequestParam(value = "pageView", required = false) Integer pageView
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
		         int count = service.PagingCountCustom(map);
			     Paging pageInfo = new Paging(count, pageNo, pageView);
			     model.addAttribute("pageInfo", pageInfo);
	  
			     map.put("pageNo", pageNo);
			     map.put("pageView", pageView);
			     map.put("offSet", (pageNo - 1) * pageView);
		         
		         if( session.getAttribute("user_group").equals("2")) {
		        	 map.put("user_id", session.getAttribute("user_id"));
		        	 map.put("user_nm", session.getAttribute("user_nm"));
		         }

		         // select 
		        List<CustomVO> customList = service.selectCustomer(map);
		        model.addAttribute("customList", customList);
		        
		         return "/custom";
		      }
		   
		   //커스터 등록 
			  @RequestMapping(value = "/customerInsert", method = { RequestMethod.GET, RequestMethod.POST })
			   public void customerInsert(
			         HttpServletRequest req,
			         HttpServletResponse res,         
			         @RequestParam Map map)  throws Exception  {
			      
			      JSONObject jsob = new JSONObject();
			      
			      try {
			         int count = service.InsertCustomer(map);

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
			  @RequestMapping(value = "/customerUpdate", method = { RequestMethod.GET, RequestMethod.POST })
			   public void updateCustomer(
			         HttpServletRequest req,
			         HttpServletResponse res,         
			         @RequestParam Map map)  throws Exception  {
				   
				   JSONObject jsob = new JSONObject();
				      
				      try {
				//
				         int count = service.updateCustomer(map);
				         
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

			  @RequestMapping(value = "/customExcel")
			   public void customExcel(HttpServletResponse response,
			   		@RequestParam Map map
			   		) throws Exception {
				   
				  List<CustomVO> customList = service.selectCustomer(map);
				  service.customExcel(response, customList);
				  
			   	}
			  
}
