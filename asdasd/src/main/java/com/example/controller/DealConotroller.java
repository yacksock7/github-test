package com.example.controller;

import java.util.List;

import java.util.Map;

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
import com.example.dto.DealVO;
import com.example.dto.GoodsVO;
import com.example.dto.ResellerVO;
import com.example.dto.UserVO;
import com.example.service.CustomService;
import com.example.service.DealService;
import com.example.service.GoodsService;
import com.example.service.ResellerService;

import net.sf.json.JSONObject;

@Controller
public class DealConotroller {

    @Autowired
    CustomService service;
    
    @Autowired
    ResellerService r_service;
    
    @Autowired
    DealService d_service;
    
	@Autowired
	GoodsService g_service;
	 
/////////////////////////////////////////
   @RequestMapping(value="/deal", method= {RequestMethod.POST,RequestMethod.GET})
   public String Deal(Model model,
		   HttpSession session,
           @RequestParam Map map,
           @RequestParam(value = "pageNo", required = false) Integer pageNo,
           @RequestParam(value = "pageView", required = false) Integer pageView,
           @RequestParam(value = "seller_id", required = false) String seller_id,
           @RequestParam(value = "customer_id", required = false) String customer_id,
           @RequestParam(value = "goods_nm", required = false) String goods_nm) throws Exception {
   
	   	if(session.getAttribute("user_id") ==null) {
		   return "redirect:/";
	   	}
   
        if (pageNo == null || "".equals(pageNo)) {
           pageNo = 1;
        }
        if (pageView == null || "".equals(pageView)) {
           pageView = 100;
        }

        // select reseller
		List<UserVO> resellerList = r_service.selectReseller(map);
		model.addAttribute("resellerList", resellerList);
        
		String user_nm = (String) session.getAttribute("user_nm");
        // select customer
        List<CustomVO> customList = service.selectCustomer(map);
        model.addAttribute("customList", customList);

        // select goods
        List<GoodsVO> goodsList = g_service.selectGoods(map);
        model.addAttribute("goodsList", goodsList);
        
        model.addAttribute("fr_wb_dt", (String) map.get("fr_wb_dt"));
        model.addAttribute("to_wb_dt", (String) map.get("to_wb_dt"));

        String fr_wb_dt = (String) map.get("fr_wb_dt");
        String to_wb_dt = (String) map.get("to_wb_dt");

        map.put("fr_wb_dt", fr_wb_dt);
        map.put("to_wb_dt", to_wb_dt);
        map.put("pageView", pageView);
        map.put("offSet", (pageNo-1) * pageView);
        
        // select deal
        List<DealVO> dealList = d_service.selectDeal(map);
        model.addAttribute("dealList", dealList);
        
        // 조건 deal 결과 값 
        model.addAttribute("seller_id", seller_id);
        model.addAttribute("customer_id", customer_id);
        model.addAttribute("goods_nm", goods_nm);
        model.addAttribute("pageView", pageView);
        model.addAttribute("pageNo", pageNo);
        
        
         return "/deal";
      }
   
/////////////////////////////////////////insert
   @RequestMapping(value = "dealInsert", method = { RequestMethod.GET, RequestMethod.POST })
   public void ProductInsert(
		 HttpSession session,
         HttpServletRequest req,
         HttpServletResponse res,         
         @RequestParam Map map)  throws Exception  {
      
	   JSONObject jsob = new JSONObject();
      
	   try {
		   
		   String[] arr = req.getParameterValues("deal_status");
		   for(int i = 0; i < arr.length ; i++) {
			   map.put("deal_status", arr[i]);
		   }
		   
		   int count = d_service.InsertDeal(map);//1
         
         //////////////////////////////////////////////////////////////
//         int qty = Integer.parseInt((String)map.get("deal_qty"));
         // status 
         // 2 step 
         
         if ( map.get("status").equals("2")) {						//2단계 Insert
        	 
        	map.put("goods_qty", map.get("deal_qty")); 
        	map.put("office_id", map.get("seller_id"));
        	count = d_service.updateStock(map);						//seller_id (location_id) 
			
        	map.put("goods_qty", "-"+map.get("deal_qty")); 	
        	map.put("office_id", session.getAttribute("user_id")); 	//user_id (location_id) office
        	count = d_service.updateStock(map); 
        	
         } else {													//3단계 Insert	
        	 
     		map.put("goods_qty", map.get("deal_qty")); 
 			map.put("office_id", map.get("customer_id"));
 			count = d_service.updateStock(map);						//customer_id (location_id) 

 			map.put("goods_qty", "-"+map.get("deal_qty")); 
     		map.put("office_id", session.getAttribute("user_id"));
     		count = d_service.updateStock(map);						//user_id (location_id) office
         }

         //////////////////////////////////////////////////////////////
         
         map.put("errCd", "1");
         map.put("errMsg", "insert succeed");

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
   
   /////////////////////////////////////update
   @RequestMapping(value = "dealUpdate", method = { RequestMethod.GET, RequestMethod.POST })
   public void updateDeal(
		   HttpSession session,
		   HttpServletRequest req,
		   HttpServletResponse res,         
		   @RequestParam Map map)  throws Exception  {
	   
	   	JSONObject jsob = new JSONObject();
	      
	      try {
	//
	         int count = d_service.updateDeal(map);
	         
	         ////////////////////////////////////////////////
	         
	         int d_qty = Integer.parseInt((String)map.get("deal_qty"));
        	 int l_qty = Integer.parseInt((String)map.get("legacy_qty"));
        	 int a_qty = l_qty - d_qty;
        	 int b_qty = d_qty - l_qty;
        	 String ud_flag = (String)map.get("ud_flag");
        	 
//        	 System.out.println("d_qty"+d_qty);
//        	 System.out.println("l_qty"+l_qty);
//        	 System.out.println("status"+map.get("status"));
//        	 System.out.println("customer_id"+map.get("customer_id"));
        	 
        	 if(a_qty != 0 && ud_flag.equals("U")) {
        	 if(map.get("bef_status").equals("2") && map.get("status").equals("3")) { //2->3단계 Update
        		 
        		map.put("goods_qty", a_qty); 
        		map.put("office_id", session.getAttribute("user_id"));
        		count = d_service.updateStock(map);				//user_id (location_id) office
        		 
           		map.put("goods_qty", "-"+l_qty); 
       			map.put("office_id", map.get("seller_id"));
       			count = d_service.updateStock(map);				//seller_id (location_id) 
       			
               	map.put("goods_qty", d_qty); 	
               	map.put("office_id", map.get("customer_id")); 	//customer_id (location_id) 
               	count = d_service.updateStock(map); 
               	
        	 } else if ( map.get("status").equals("2")) {		//2단계	Update
        		 
          		map.put("goods_qty", b_qty); 
      			map.put("office_id", map.get("seller_id"));
      			count = d_service.updateStock(map);				//seller_id (location_id) 
      			
              	map.put("goods_qty", a_qty); 	
              	map.put("office_id", session.getAttribute("user_id"));  
              	count = d_service.updateStock(map); 			//user_id (location_id) office
       	        
             }else {											//3단계	Update
            	 
              	 map.put("goods_qty", b_qty); 
              	 map.put("office_id", map.get("customer_id"));
       			 count = d_service.updateStock(map);			//customer_id (location_id)

       			 map.put("goods_qty", a_qty); 
       			 map.put("office_id", map.get("seller_id"));
       			 count = d_service.updateStock(map);			//seller_id (location_id) 
               }	
	         ////////////////////////////////////////////////
        	 
        	 }else if(a_qty == 0 && ud_flag.equals("D")) {
        		 if(map.get("bef_status").equals("2") && map.get("status").equals("3")) { //2->3단계 Delete
        			 
        			map.put("goods_qty", "-"+l_qty); 
                    map.put("office_id", map.get("seller_id"));
              		count = d_service.updateStock(map);			//seller_id (location_id) 

              		map.put("goods_qty", l_qty); 
              		map.put("office_id", session.getAttribute("user_id"));
              		count = d_service.updateStock(map);			//user_id (location_id) office
              		
        		 }else if(map.get("status").equals("2")) {		//2단계 Delete
        			 
        			map.put("goods_qty", "-"+l_qty); 
                    map.put("office_id", map.get("seller_id"));
             		count = d_service.updateStock(map);			//seller_id (location_id)

             		map.put("goods_qty", l_qty); 
             		map.put("office_id", session.getAttribute("user_id"));
             		count = d_service.updateStock(map);			//user_id (location_id) office
             		
             	 }else {										//3단계 Delete
             		 
                   	map.put("goods_qty", "-"+l_qty); 
                   	map.put("office_id", map.get("customer_id"));
            		count = d_service.updateStock(map);			//customer_id (location_id) 

            		map.put("goods_qty", l_qty); 
            		map.put("office_id", session.getAttribute("user_id"));
            		count = d_service.updateStock(map);			//user_id (location_id) office
                    }	
        	 }
        	   	map.put("errCd", "1");	
        	   	
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

   
   @RequestMapping(value = "/dealExcel")
   public void excelDeal(HttpServletResponse response,
   		@RequestParam Map map
   		) throws Exception {
	   
	   List<DealVO> list = d_service.selectDeal(map);
	   d_service.excelDeal(response, list);
   	}

}
   
   
   
