package com.example.controller;

import java.util.HashMap;
import java.util.List;

import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.dto.CustomVO;
import com.example.dto.ITVO;
import com.example.dto.IssueTagVO;
import com.example.dto.IssueTagVO.IssueTagList;
import com.example.dto.IssueVO;
import com.example.dto.ReplyVO;
import com.example.dto.ScheduleGoodsVO;
import com.example.dto.UserVO;
import com.example.dto.ScheduleGoodsVO.ScheduleGoodsList;
import com.example.service.CustomService;
import com.example.service.IssueService;
import com.example.service.Paging;
import com.example.service.ResellerService;

import net.sf.json.JSONObject;

@Controller
public class IssueController {
	
	   @Autowired
	    IssueService i_service;
	   
	   @Autowired
	    CustomService c_service;
	   
	   @Autowired
		ResellerService r_service;
	   
	   @RequestMapping(value="/test", method= {RequestMethod.POST,RequestMethod.GET})
	   public String test(Model model,
	           @RequestParam Map map
			   ) throws Exception {
	     
		   // select Issue
	         List<IssueVO> issueList = i_service.selectIssue(map);
	         model.addAttribute("issueList", issueList);
	         
	         // select customer
	         List<CustomVO> customList = c_service.selectCustomer(map);
	         model.addAttribute("customList", customList);
	         
	         // select reseller
			 List<UserVO> resellerList = r_service.selectReseller(map);
			 model.addAttribute("resellerList", resellerList);
		   
	         return "/test";
	      }
	   
		@RequestMapping(value="/issue/{issue_tag_D}", method= {RequestMethod.GET, RequestMethod.POST})
		public String issue(Model model,
				   HttpSession session,
		           @RequestParam Map map,
		           @RequestParam(value = "pageNo", required = false) Integer pageNo,
		            @RequestParam(value = "pageView", required = false) Integer pageView,
		            @RequestParam(value = "issue_title", required = false) String issue_title,
		            @RequestParam(value = "customer_id", required = false) String customer_id,
		            @RequestParam(value = "seller_id", required = false) String seller_id,
		            @RequestParam(value = "issue_tag", required = false) String issue_tag,
		            @PathVariable String issue_tag_D
					) throws Exception {
						 if(session.getAttribute("user_id") ==null) {
							   return "redirect:/";
						 }
						 
		         if(!issue_tag_D.equals("")) {
		        	 map.put("issue_tag", issue_tag_D);
		         }
		         // select Issue
		         List<IssueVO> issueList = i_service.selectIssue(map);
		         model.addAttribute("issueList", issueList);
		         
		         // select customer
		         List<CustomVO> customList = c_service.selectCustomer(map);
		         model.addAttribute("customList", customList);
		         
		         // select reseller
				 List<UserVO> resellerList = r_service.selectReseller(map);
				 model.addAttribute("resellerList", resellerList);
		        
		         // 조건 issue 결과 값 
		         model.addAttribute("issue_tag", issue_tag_D);
			 
			 return "/issue";
		}
	   
	
	@RequestMapping(value="/issue", method= {RequestMethod.GET, RequestMethod.POST})
	public String issue2(Model model,
			   HttpSession session,
	           @RequestParam Map map,
	           @RequestParam(value = "pageNo", required = false) Integer pageNo,
	            @RequestParam(value = "pageView", required = false) Integer pageView,
	            @RequestParam(value = "issue_title", required = false) String issue_title,
	            @RequestParam(value = "customer_id", required = false) String customer_id,
	            @RequestParam(value = "seller_id", required = false) String seller_id,
	            @RequestParam(value = "category", required = false) String category,
	            @RequestParam(value = "issue_tag", required = false) String issue_tag
			) throws Exception {
	
			
			 if(session.getAttribute("user_id") ==null) {
				   return "redirect:/";
			 }if (pageNo == null || "".equals(pageNo)) {
		         pageNo = 1;
	         }if (pageView == null || "".equals(pageView)) {
	            pageView = 10;
	         }
		         
			     int count = i_service.PagingCountIssue(map);
			     Paging pageInfo = new Paging(count, pageNo, pageView);
			     model.addAttribute("pageInfo", pageInfo);
	    
	     		 map.put("pageNo", pageNo);
			     map.put("pageView", pageView);
			     map.put("offSet", (pageNo - 1) * pageView);
			     map.put("location_id",session.getAttribute("user_id"));	
		         if( session.getAttribute("user_group").equals("2")) {
		        	 map.put("user_id", session.getAttribute("user_id"));
		        	 map.put("reg_id", session.getAttribute("user_id"));
			         map.put("user_nm", session.getAttribute("user_nm"));
		         }
		         
		         // select Issue
		         List<IssueVO> issueList = i_service.selectIssue(map);
		         model.addAttribute("issueList", issueList);
	         
	         // select Issue_tag
			 List<ITVO> issueTagList = i_service.selectIssueTag(map);
			 model.addAttribute("issueTagList", issueTagList);
	         
	         // select customer
	         List<CustomVO> customList = c_service.selectCustomer(map);
	         model.addAttribute("customList", customList);
	         
	         // select reseller
			 List<UserVO> resellerList = r_service.selectReseller(map);
			 model.addAttribute("resellerList", resellerList);
	        
	         // 조건 issue 결과 값 
	         model.addAttribute("fr_wb_dt", (String) map.get("fr_wb_dt"));
	         model.addAttribute("to_wb_dt", (String) map.get("to_wb_dt"));
	         model.addAttribute("issue_title", issue_title);
	         model.addAttribute("customer_id", customer_id);
	         model.addAttribute("seller_id", seller_id);
	         model.addAttribute("issue_tag", issue_tag);
	         model.addAttribute("category", category);
	         model.addAttribute("pageView", pageView);
	         model.addAttribute("pageNo", pageNo);
		 
		 return "/issue";
	}

	//공지사항 등록 
	  @RequestMapping(value = "/issueInsert", method = { RequestMethod.GET, RequestMethod.POST })
	   public void issueInsert(HttpSession session,
			      HttpServletRequest req,
			      HttpServletResponse res,  
			      @RequestBody IssueTagVO issueTag
			   )  throws Exception  {
	      JSONObject jsob = new JSONObject();	   
		   Map<String, Object> map = new HashMap<String, Object>();

		   try {
			   map.put("reg_id", issueTag.getReg_id());
			   map.put("customer_id", issueTag.getCustomer_id());
			   map.put("issue_title", issueTag.getIssue_title());
			   map.put("issue_msg", issueTag.getIssue_msg());
			   map.put("issue_category", issueTag.getIssue_category());
	         int count = i_service.insertIssue(map);
	         
	         for( int i=0; i< issueTag.getIssueTagList().size(); i++ ) {
	        	 IssueTagList issueTagList = issueTag.getIssueTagList().get(i);
	               map.put("issue_tag", issueTagList.getIssue_tag());
	               count = i_service.insertIssueTag(map);
	         }
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
	
	
	@RequestMapping(value="/issueDetail/{issue_no}", method={RequestMethod.GET, RequestMethod.POST})
	public String issueDetail(Model model,
			   HttpSession session,
	           @RequestParam Map map,
	           @PathVariable int issue_no) {
		
		 if(session.getAttribute("user_id") ==null) {
			   return "redirect:/";
		   }
		 
		 	map.put("issue_no", issue_no);
			// select Issue_tag
			  List<ITVO> issueTagList = i_service.selectIssueTag(map);
			  model.addAttribute("issueTagList", issueTagList);
			 
			// select Issue
			  IssueVO issue = i_service.issueDetail(map);
			  model.addAttribute("issue", issue);
			  
			//select reply
			  List<ReplyVO> replyList = i_service.selectReply(map);
			  model.addAttribute("replyList", replyList);
	        
		 return "/issue_detail";
	}
	
	
	//수정 삭제 
	  @RequestMapping(value = "/issueUpdate", method = { RequestMethod.GET, RequestMethod.POST })
	   public void issueUpdate(
			   Model model,
			   HttpSession session,
	         HttpServletRequest req,
	         HttpServletResponse res,    
	         @RequestBody IssueTagVO issueTag)  throws Exception  {
		   
		   JSONObject jsob = new JSONObject();	   
		   Map<String, Object> map = new HashMap<String, Object>();
		      
		      try {
		    	  map.put("user_id", session.getAttribute("user_id"));
		    	  map.put("issue_no", issueTag.getIssue_no());
		    	  map.put("issue_title", issueTag.getIssue_title());
				  map.put("issue_msg", issueTag.getIssue_msg());
				  map.put("issue_feedback", issueTag.getIssue_feedback());
				  map.put("ud_flag", issueTag.getUd_flag());

				  int count = i_service.updateIssue(map);
				  count = i_service.updateIssueTag(map);
		         
		         for( int i=0; i< issueTag.getIssueTagList().size(); i++ ) {
		        	 IssueTagList issueTagList = issueTag.getIssueTagList().get(i);
		               map.put("issue_tag", issueTagList.getIssue_tag());
		               count = i_service.insertIssueTag(map);
		         }
		 
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
	  
	  @RequestMapping(value = "/issueTagInsert", method = { RequestMethod.GET, RequestMethod.POST })
	   public void issueTagInsert(
	         HttpServletRequest req,
	         HttpServletResponse res,         
	         @RequestParam Map map)  throws Exception  {
	      
	      JSONObject jsob = new JSONObject();	      
	      try {
	         int count = i_service.insertIssue(map);

	         
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

	  @RequestMapping(value = "/insertReply", method = { RequestMethod.GET, RequestMethod.POST })
	   public void insertReply(
	         HttpServletRequest req,
	         HttpServletResponse res,         
	         @RequestParam Map map)  throws Exception  {
		  
    	  
    	  if(map.get("reply_depth") == "") {
    		  map.put("reply_depth", "0" );
    	  }if(!map.get("reply_depth").equals("3")) {
    		  int reply_depth = 1 + Integer.parseInt((String) map.get("reply_depth"));
    		  map.put("reply_depth", reply_depth );
    	  }
    	  
	      JSONObject jsob = new JSONObject();	      
	      try {
	         int count = i_service.insertReply(map);
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
	  @RequestMapping(value = "/updateReply", method = { RequestMethod.GET, RequestMethod.POST })
	   public void updateReply(
	         HttpServletRequest req,
	         HttpServletResponse res,         
	         @RequestParam Map map)  throws Exception  {
		   
		   JSONObject jsob = new JSONObject();
		      
		      try {
			     int count = i_service.updateReply(map);

		         
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
