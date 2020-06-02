package com.example.controller;

import java.util.List;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.dto.CustomVO;
import com.example.dto.GoodsVO;
import com.example.dto.IssueVO;
import com.example.dto.ManagementVO;
import com.example.dto.SGVO;
import com.example.dto.UserVO;
import com.example.service.CustomService;
import com.example.service.GoodsService;
import com.example.service.ManagementService;
import com.example.service.Paging;
import com.example.service.ResellerService;
import com.example.service.UserService;

@Controller
public class ManagementController {
	
		@Autowired
		GoodsService g_service;
	
	   @Autowired
	    CustomService c_service;
	   
	   @Autowired
		ResellerService r_service;
	   
	   @Autowired
		ManagementService m_service;
	   
		@Autowired
		UserService u_service;
	
	@RequestMapping(value="/management2", method= {RequestMethod.GET, RequestMethod.POST})
	public String management(Model model,
			   HttpSession session,
	           @RequestParam Map map,
	           @RequestParam(value = "pageNo", required = false) Integer pageNo,
	            @RequestParam(value = "pageView", required = false) Integer pageView,
	            @RequestParam(value = "goods_nm", required = false) String goods_nm,
	            @RequestParam(value = "customer_id", required = false) String customer_id,
	            @RequestParam(value = "seller_id", required = false) String seller_id,
	            @RequestParam(value = "category", required = false) String category,
	            @RequestParam(value = "category", required = false) String category2
			) throws Exception {
		
		 if(session.getAttribute("user_id") ==null) {
			   return "redirect:/";
		   }
		 if(category ==null) {
			 category = "0";
		   }
		 if (pageNo == null || "".equals(pageNo)) {
	            pageNo = 1;
	         }
	         if (pageView == null || "".equals(pageView)) {
	            pageView = 10;
	         }
	         
	         
		     map.put("pageNo", pageNo);
		     map.put("pageView", pageView);
		     map.put("offSet", (pageNo - 1) * pageView);
		     
		     
	         if( session.getAttribute("user_group").equals("2")) {
	        	 map.put("user_id", session.getAttribute("user_id"));
	        	 map.put("reg_id", session.getAttribute("user_id"));
		         map.put("user_nm", session.getAttribute("user_nm"));
	         }
	         
	         

	      // select goods
	         List<GoodsVO> goodsList = g_service.selectGoods(map);
	         model.addAttribute("goodsList", goodsList);
	         
	         // select customer
	         List<CustomVO> customList = c_service.selectCustomer(map);
	         model.addAttribute("customList", customList);
	         
	         // select reseller
			 List<UserVO> resellerList = r_service.selectReseller(map);
			 model.addAttribute("resellerList", resellerList);
			 
			 // select M_reseller
				List<UserVO> T_RsellerList = m_service.selectMngReseller(map);
				for(int i = 0 ; i < T_RsellerList.size() ; i++) {
				int qty = 0;
				 int sale_price = 0;
				 int unit_price = 0;
				 int margin = 0;
				 int t_qty = 0;
				 int t_price = 0;
				 int t_margin = 0;
				 
				 map.put("seller_id", T_RsellerList.get(i).getOffice_id());
				 List<ManagementVO> r_managementList = m_service.selectManagement(map);

				 
				  for(int j = 0 ; j < r_managementList.size() ; j++) {
						 	 qty = r_managementList.get(j).getGoods_qty();
							 sale_price = r_managementList.get(j).getGoods_price();
							 unit_price= r_managementList.get(j).getUnit_price();
							 
							 t_qty += qty;
							 t_price += sale_price;
							 t_margin += sale_price - unit_price;
		    	 }
				  T_RsellerList.get(i).setT_qty(t_qty);
				  T_RsellerList.get(i).setT_price(t_price);
				  T_RsellerList.get(i).setT_margin(t_margin);
				  model.addAttribute("T_Rseller", T_RsellerList.get(i));
		     }
				
				
			 model.addAttribute("T_RsellerList", T_RsellerList);
			 map.put("seller_id", seller_id);
			 
			 
			 // select M_custumer
				List<CustomVO> T_CustomerList = m_service.selectMngCustomer(map);
				for(int i = 0 ; i < T_CustomerList.size() ; i++) {
					int qty = 0;
					 int sale_price = 0;
					 int unit_price = 0;
					 int t_qty = 0;
					 int t_price = 0;
					 int t_margin = 0;
					 
					 map.put("customer_id", T_CustomerList.get(i).getCustomer_id());
					 List<ManagementVO> c_managementList = m_service.selectManagement(map);

					 
					  for(int j = 0 ; j < c_managementList.size() ; j++) {
						  
							 	 qty = c_managementList.get(j).getGoods_qty();
								 sale_price = c_managementList.get(j).getGoods_price();
								 unit_price= c_managementList.get(j).getUnit_price();
								 
								 t_qty += qty;
								 t_price += sale_price;
								 t_margin += sale_price - unit_price;
			    	 }
					  T_CustomerList.get(i).setT_qty(t_qty);
					  T_CustomerList.get(i).setT_price(t_price);
					  T_CustomerList.get(i).setT_margin(t_margin);
			     }
				 model.addAttribute("T_CustomerList", T_CustomerList);
				 map.put("customer_id", customer_id);
			 
				 
				 
				 
			 // select M_goods
				List<GoodsVO> T_GoodsList = m_service.selectMngGoods(map);
				for(int i = 0 ; i < T_GoodsList.size() ; i++) {
				int qty = 0;
				 int sale_price = 0;
				 int unit_price = 0;
				 int margin = 0;
				 int t_qty = 0;
				 int t_price = 0;
				 int t_margin = 0;
				 
				 map.put("goods_nm", T_GoodsList.get(i).getGoods_nm());
				 List<ManagementVO> g_managementList = m_service.selectManagement(map);

				 
				  for(int j = 0 ; j < g_managementList.size() ; j++) {
						 	 qty = g_managementList.get(j).getGoods_qty();
							 sale_price = g_managementList.get(j).getGoods_price();
							 unit_price= g_managementList.get(j).getUnit_price();
							 
							 t_qty += qty;
							 t_price += sale_price;
							 t_margin += sale_price - unit_price;
		    	 }
				  T_GoodsList.get(i).setT_qty(t_qty);
				  T_GoodsList.get(i).setT_price(t_price);
				  T_GoodsList.get(i).setT_margin(t_margin);
		     }
			 model.addAttribute("T_GoodsList", T_GoodsList);
			 
		   // 조건 issue 결과 값 
	         model.addAttribute("fr_wb_dt", (String) map.get("fr_wb_dt"));
	         model.addAttribute("to_wb_dt", (String) map.get("to_wb_dt"));
	         model.addAttribute("goods_nm", goods_nm);
	         model.addAttribute("customer_id", customer_id);
	         model.addAttribute("seller_id", seller_id);
	         model.addAttribute("pageView", pageView);
	         model.addAttribute("pageNo", pageNo);
	         model.addAttribute("category", category);
		 
	  
	    	 return "/management";
	     
	}
	
	  
	   
	   
	
	}
	

