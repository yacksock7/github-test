package com.example.controller;

import java.util.HashMap;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.example.dto.CustomVO;
import com.example.dto.GoodsVO;
import com.example.dto.SGVO;
import com.example.dto.ScheduleVO;
import com.example.dto.UserVO;
import com.example.dto.ScheduleGoodsVO;
import com.example.dto.ScheduleGoodsVO.ScheduleGoodsList;
import com.example.service.CustomService;
import com.example.service.DealService;
import com.example.service.GoodsService;
import com.example.service.Paging;
import com.example.service.ResellerService;
import com.example.service.ScheduleService;

import net.sf.json.JSONObject;


@RestController
public class ScheduleController {
	
	 @Autowired
	 ScheduleService s_service;
	
	    @Autowired
	    CustomService c_service;
	    
	    @Autowired
	    DealService d_service;
	    
		@Autowired
		GoodsService g_service;
		
		@Autowired
		ResellerService r_service;		
	
	@RequestMapping(value="/schedule", method={ RequestMethod.GET, RequestMethod.POST })
	public ModelAndView schedule(Model model,
			   HttpSession session,
	           @RequestParam Map map,
	           @RequestParam(value = "pageNo", required = false) Integer pageNo,
	            @RequestParam(value = "pageView", required = false) Integer pageView,
	            @RequestParam(value = "customer_id", required = false) Integer customer_id,
	            @RequestParam(value = "seller_id", required = false) String seller_id,
	            @RequestParam(value = "s_status", required = false) Integer s_status
	            ) throws Exception{
			ModelAndView mav = new ModelAndView();
			
			if (pageNo == null || "".equals(pageNo)) {
	            pageNo = 1;
	         }
	         if (pageView == null || "".equals(pageView)) {
	            pageView = 10;
	         }
	         
	         if( session.getAttribute("user_group").equals("2")) {
	        	 map.put("user_id", session.getAttribute("user_id"));
	        	 map.put("user_nm", session.getAttribute("user_nm"));
	         }
	         
	         /* paging */
	         int count = s_service.PagingCountSchedule(map);
		     Paging pageInfo = new Paging(count, pageNo, pageView);
		     model.addAttribute("pageInfo", pageInfo);
  
		     map.put("pageNo", pageNo);
		     map.put("pageView", pageView);
		     map.put("offSet", (pageNo - 1) * pageView);
	         
	         // select customer
	         List<CustomVO> customList = c_service.selectCustomer(map);
	         mav.addObject("customList", customList);

	         // select goods
	         List<GoodsVO> goodsList = g_service.selectGoods(map);
	         mav.addObject("goodsList", goodsList);
	         
	         // select reseller
			 List<UserVO> resellerList = r_service.selectReseller(map);
			 model.addAttribute("resellerList", resellerList);
	         
	         // select ******************
		     List<ScheduleVO> scheduleList = s_service.selectSchedule(map);
		   
		     for(int i = 0 ; i < scheduleList.size() ; i++) {
		    	 int qty = 0;
				 int price = 0;
		    	 int total_qty = 0;
				 int total_price = 0;
				 
				 map.put("schedule_no", scheduleList.get(i).getSchedule_no());
				 List<SGVO> scheduleGoodsList = s_service.selectScheduleGoods(map);
				 
				  for(int j = 0 ; j < scheduleGoodsList.size() ; j++) {
					  int schedule01 =Integer.parseInt(scheduleList.get(i).getSchedule_no());
					  int schedule02 =Integer.parseInt(scheduleGoodsList.get(j).getSchedule_no());
					  if(schedule01 == schedule02) {
						  qty = scheduleGoodsList.get(j).getGoods_qty();
						  price = scheduleGoodsList.get(j).getGoods_price();
						  total_qty +=qty;
						  total_price += qty * price;
					  }
		    	 }
				  scheduleList.get(i).setTotal_qty(total_qty);
				  scheduleList.get(i).setTotal_price(total_price);
		     }
		     mav.addObject("scheduleList", scheduleList);


		        
		     //조회 값
		     mav.addObject("reseller_id", session.getAttribute("user_id"));
		     mav.addObject("pageView", pageView);
		     mav.addObject("pageNo", pageNo);
		
		     mav.addObject("fr_wb_dt", (String) map.get("fr_wb_dt"));
		     mav.addObject("to_wb_dt", (String) map.get("to_wb_dt"));
		     mav.addObject("customer_id", customer_id);
		     mav.addObject("seller_id", seller_id);
		     mav.addObject("s_status", s_status);
		  	 mav.setViewName("/schedule");
		         return mav;
	}
	
	@RequestMapping(value="/schedule_Dtl", method={ RequestMethod.GET, RequestMethod.POST })
	public ModelAndView schedule_Dtl(Model model,
			   HttpSession session,
	           @RequestParam Map map,
	           @RequestParam(value = "pageNo", required = false) Integer pageNo,
	            @RequestParam(value = "pageView", required = false) Integer pageView,
	            @RequestParam(value = "customer_id", required = false) Integer customer_id
	            ) throws Exception{
			ModelAndView mav = new ModelAndView();
//		 if(session.getAttribute("user_id") ==null) {
//			   return "redirect:/";
//		   }
		 if (pageNo == null || "".equals(pageNo)) {
	            pageNo = 1;
	         }
	         if (pageView == null || "".equals(pageView)) {
	            pageView = 100;
	         }
	         
	         if( session.getAttribute("user_group").equals("2")) {
	        	 map.put("user_id", session.getAttribute("user_id"));
				map.put("user_nm", session.getAttribute("user_nm"));
	         }
	         // select reseller
			 List<UserVO> resellerList = r_service.selectReseller(map);
			 model.addAttribute("resellerList", resellerList);
			 
	         // select customer
	         List<CustomVO> customList = c_service.selectCustomer(map);
	         mav.addObject("customList", customList);

	         // select goods
	         List<GoodsVO> goodsList = g_service.selectGoods(map);
	         mav.addObject("goodsList", goodsList);
	         
		     // 1. schedule_no에 해당하는 schedule tb 1
		     ScheduleVO scheduleOne = s_service.selectOneSchedule(map);
		     mav.addObject("scheduleOne", scheduleOne);
		     
		     // 2.schedule_no에 해당하는 schedule_goods tb n개
		     List<SGVO> scheduleGoodsList = s_service.selectScheduleGoods(map);
		     mav.addObject("scheduleGoodsList", scheduleGoodsList);
		     
		     // select schedule
		     List<ScheduleVO> scheduleList = s_service.selectSchedule(map);
		     for(int i = 0 ; i < scheduleList.size() ; i++) {
		    	 int qty = 0;
				 int price = 0;
		    	 int total_qty = 0;
				 int total_price = 0;
				 
				 map.put("schedule_no", scheduleList.get(i).getSchedule_no());
				 List<SGVO> scheduleQtyPrice = s_service.selectScheduleGoods(map);
				 
				  for(int j = 0 ; j < scheduleQtyPrice.size() ; j++) {
					  int schedule01 =Integer.parseInt(scheduleList.get(i).getSchedule_no());
					  int schedule02 =Integer.parseInt(scheduleQtyPrice.get(j).getSchedule_no());
					  if(schedule01 == schedule02) {
						  qty = scheduleQtyPrice.get(j).getGoods_qty();
						  price = scheduleQtyPrice.get(j).getGoods_price();
						  total_qty +=qty;
						  total_price += qty * price;
					  }
		    	 }
				  scheduleList.get(i).setTotal_qty(total_qty);
				  scheduleList.get(i).setTotal_price(total_price);
		     }
		     mav.addObject("scheduleList", scheduleList);
		     
		     
		     
		     mav.addObject("schedule_no", scheduleOne.getSchedule_no());
		     mav.addObject("reseller_id", session.getAttribute("user_id"));
		     mav.addObject("pageView", pageView);
		     mav.addObject("pageNo", pageNo);
		
		 	mav.addObject("customer_id", customer_id);
			mav.setViewName("/schedule");
		         return mav;
	}
	
	
	
	
@RequestMapping(value = "scheduleInsert", method = { RequestMethod.GET, RequestMethod.POST })
public void scheduleInsert(HttpSession session,
					      HttpServletRequest req,
					      HttpServletResponse res,  
					      @RequestBody ScheduleGoodsVO scheduleGood
		)  throws Exception  {
	
	   JSONObject jsob = new JSONObject();
	   Map<String, Object> map = new HashMap<String, Object>();
	  
	   try {
		   map.put("reseller_id", scheduleGood.getReseller_id());
		   map.put("customer_id", scheduleGood.getCustomer_id());
		   map.put("schedule_dt", scheduleGood.getSchedule_dt());
		   map.put("memo", scheduleGood.getMemo());
		   map.put("status", scheduleGood.getStatus());
		   
		   int count = s_service.insertSchedule(map);//1 ******************
		   
		   for( int i=0; i< scheduleGood.getScheduleGoodsList().size(); i++ ) {
			   ScheduleGoodsList scheduleGoodsList = scheduleGood.getScheduleGoodsList().get(i);
               map.put("goods_no", scheduleGoodsList.getGoods_no());
               map.put("goods_qty", scheduleGoodsList.getGoods_qty());
               map.put("goods_price", scheduleGoodsList.getGoods_price());
               count = s_service.insertScheduleGoods(map);
               
            if(!map.get("status").equals("1")) {
               if ( map.get("status").equals("2")) {						//2단계 Insert
              	 
            	map.put("goods_qty", scheduleGoodsList.getGoods_qty());
              	map.put("office_id", map.get("reseller_id"));
              	count = d_service.updateStock(map);						//seller_id (location_id) 
      			
              	map.put("goods_qty", "-"+scheduleGoodsList.getGoods_qty()); 	
              	map.put("office_id", "1535"); 	//user_id (location_id) office
              	count = d_service.updateStock(map); 
              	
               } else {													//3단계 Insert	
              	 
               	map.put("goods_qty", scheduleGoodsList.getGoods_qty());
       			map.put("office_id", map.get("customer_id"));
       			count = d_service.updateStock(map);						//customer_id (location_id) 

              	map.put("goods_qty", "-"+scheduleGoodsList.getGoods_qty()); 	
           		map.put("office_id", "1535");
           		count = d_service.updateStock(map);						//user_id (location_id) office
               }
               
            }
		   }
      //////////////////////////////////////////////////////////////
      
      map.put("errCd", "1");
      map.put("errMsg", "등록되였습니다.");

   } catch (Exception e) {
      System.out.println(e);
      map.put("errCd", "-1"); // 
      map.put("errMsg", "오류가 발생하였습니다 관리자에게 문의하세요.");

   } finally {
      jsob = JSONObject.fromObject(map);
      res.setContentType("text/html;charset=UTF-8");
      res.getWriter().print(jsob);
   }
}

/////////////////////////////////////update

@RequestMapping(value = "scheduleUpdate", method = { RequestMethod.GET, RequestMethod.POST })
public void scheduleUpdate(HttpSession session,
					      HttpServletRequest req,
					      HttpServletResponse res, 
					      @RequestBody ScheduleGoodsVO scheduleGood
					      
		)  throws Exception  {
   
	   JSONObject jsob = new JSONObject();
	   Map<String, Object> map = new HashMap<String, Object>();
	  
	   try {
		   map.put("schedule_no", scheduleGood.getSchedule_no());
		   map.put("ud_flag", "D");
		   int count = s_service.updateScheduleGoods(map);
		   
		   
		   map.put("reseller_id", scheduleGood.getReseller_id());
		   map.put("customer_id", scheduleGood.getCustomer_id());
		   map.put("schedule_dt", scheduleGood.getSchedule_dt());
		   map.put("memo", scheduleGood.getMemo());
		   map.put("ud_flag", scheduleGood.getUd_flag());
		   map.put("status", scheduleGood.getStatus());
		   map.put("bef_status", scheduleGood.getBef_status());
		   
		    count = s_service.updateSchedule(map);
	         
	         ////////////////////////////////////////////////
		   
		   
		   
		   String ud_flag = (String)map.get("ud_flag");
		   for( int i=0; i< scheduleGood.getScheduleGoodsList().size(); i++ ) {
			   ScheduleGoodsList scheduleGoodsList = scheduleGood.getScheduleGoodsList().get(i);
               map.put("goods_no", scheduleGoodsList.getGoods_no());
               map.put("goods_qty", scheduleGoodsList.getGoods_qty());
               map.put("goods_price", scheduleGoodsList.getGoods_price());
               count = s_service.insertScheduleGoods(map);
               
             int p_qty = Integer.parseInt(scheduleGoodsList.getGoods_qty());
          	 int l_qty = Integer.parseInt(scheduleGoodsList.getLegacy_qty());
          	 int a_qty = l_qty - p_qty;
          	 int b_qty = p_qty - l_qty;
          	 
          	  
//          	 System.out.println("d_qty"+d_qty);
//          	 System.out.println("l_qty"+l_qty);
//          	 System.out.println("status"+map.get("status"));
//          	 System.out.println("customer_id"+map.get("customer_id"));
          	 
          	 
        	 if(ud_flag.equals("U")) {
        		 if(map.get("bef_status").equals("1") && map.get("status").equals("2")) {
                  	 System.out.println("여기여기여기여기 1->2");

        			map.put("goods_qty", "-"+p_qty); 
 	          		map.put("office_id", "1535");
 	          		count = d_service.updateStock(map);				//user_id (location_id) office
           		 
              		map.put("goods_qty", p_qty); 
          			map.put("office_id", map.get("reseller_id"));
          			count = d_service.updateStock(map);				//seller_id (location_id) 
        		 
        		 }else if(map.get("bef_status").equals("1") && map.get("status").equals("3")) {
                  	 System.out.println("여기여기여기여기 1->3");

        				map.put("goods_qty", "-"+p_qty); 
     	          		map.put("office_id", "1535");
     	          		count = d_service.updateStock(map);				//user_id (location_id) office
               		 
                  		map.put("goods_qty", p_qty); 
              			map.put("office_id", map.get("customer_id"));
              			count = d_service.updateStock(map);				//customer_id (location_id) 
              			
        		 }else if(map.get("bef_status").equals("2") && map.get("status").equals("3")) {
        			 System.out.println("여기여기여기여기 2->3");
     				map.put("goods_qty", "-"+l_qty); 
     				map.put("office_id", map.get("reseller_id"));
 	          		count = d_service.updateStock(map);				//user_id (location_id) office
           		 
              		map.put("goods_qty", p_qty); 
          			map.put("office_id", map.get("customer_id"));
          			count = d_service.updateStock(map);				//seller_id (location_id) 
          			
          			if(a_qty != 0) {
          			map.put("goods_qty", a_qty); 
          			map.put("office_id", "1535");
          			count = d_service.updateStock(map);				//seller_id (location_id) 
          			}
        		 }else if(map.get("bef_status").equals("3") && map.get("status").equals("2")) {
        			 System.out.println("여기여기여기여기 3->2");
     				map.put("goods_qty", p_qty); 
 	          		map.put("office_id",  map.get("reseller_id"));
 	          		count = d_service.updateStock(map);				//user_id (location_id) office
           		 
              		map.put("goods_qty", "-"+l_qty); 
          			map.put("office_id", map.get("customer_id"));
          			count = d_service.updateStock(map);				//seller_id (location_id) 
          			
          			if(a_qty != 0) {
          			map.put("goods_qty", a_qty); 
          			map.put("office_id", "1535");
          			count = d_service.updateStock(map);				//seller_id (location_id) 
          			}
          			
        		 }else if(map.get("bef_status").equals("3") && map.get("status").equals("1")) {
        			 System.out.println("여기여기여기여기 3->1");
     				map.put("goods_qty", "-"+l_qty); 
 	          		map.put("office_id", map.get("customer_id"));
 	          		count = d_service.updateStock(map);				//user_id (location_id) office
           		 
          			map.put("goods_qty", l_qty); 
          			map.put("office_id", "1535");
          			count = d_service.updateStock(map);				//seller_id (location_id) 
    		 
        		 }else if(map.get("bef_status").equals("2") && map.get("status").equals("1")) {
        			 System.out.println("여기여기여기여기 2->1");
     				map.put("goods_qty", "-"+l_qty); 
 	          		map.put("office_id", map.get("reseller_id"));
 	          		count = d_service.updateStock(map);				//user_id (location_id) office
           		 
          			map.put("goods_qty", l_qty); 
          			map.put("office_id", "1535");
          			count = d_service.updateStock(map);				//seller_id (location_id) 
    		 
        		 }
        	 }
        	 
        	 System.out.println("bef_status : " + map.get("bef_status"));
        	 System.out.println("status : " + map.get("status"));
        	 
          	 }
		   
	   	   	map.put("errCd", "1");	
	   	   	
	   	   	if(ud_flag.equals("D")) map.put("errMsg", "삭제되었습니다.");
	   	   	else map.put("errMsg", "수정되었습니다.");

	   } catch (Exception e) {
	      System.out.println(e);
	      map.put("errCd", "-1"); // 
	      map.put("errMsg", "오류가 발생하였습니다 관리자에게 문의하세요.");
	
	   } finally {
	      jsob = JSONObject.fromObject(map);
	      res.setContentType("text/html;charset=UTF-8");
	      res.getWriter().print(jsob);
	   }
	}


		@RequestMapping(value = "/scheduleExcel")
		public void scheduleExcel(
				HttpServletResponse response,
				@RequestParam Map map
				) throws Exception {
			     
		     List<ScheduleVO> scheduleList = s_service.selectSchedule(map);

		     for(int i = 0 ; i < scheduleList.size() ; i++) {
		    	 int qty = 0;
				 int price = 0;
		    	 int total_qty = 0;
				 int total_price = 0;
				 
				 map.put("schedule_no", scheduleList.get(i).getSchedule_no());
				 List<SGVO> scheduleGoodsList = s_service.selectScheduleGoods(map);
				 
				  for(int j = 0 ; j < scheduleGoodsList.size() ; j++) {
					  int schedule01 =Integer.parseInt(scheduleList.get(i).getSchedule_no());
					  int schedule02 =Integer.parseInt(scheduleGoodsList.get(j).getSchedule_no());
					  if(schedule01 == schedule02) {
						  qty = scheduleGoodsList.get(j).getGoods_qty();
						  price = scheduleGoodsList.get(j).getGoods_price();
						  total_qty +=qty;
						  total_price += qty * price;
					  }
		    	 }
				  scheduleList.get(i).setTotal_qty(total_qty);
				  scheduleList.get(i).setTotal_price(total_price);
		     }
		     
		     s_service.scheduleExcel(response, scheduleList); 
		     
		}



}
//
//public String hello(@CookieValue("foo") String fooCookie) {
//    // ..
