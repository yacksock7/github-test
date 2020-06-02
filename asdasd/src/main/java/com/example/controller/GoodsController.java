package com.example.controller;

import java.io.File;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.javassist.compiler.ast.NewExpr;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.example.dto.DealVO;
import com.example.dto.GoodsVO;
import com.example.dto.ResellerVO;
import com.example.service.CustomService;
import com.example.service.DealService;
import com.example.service.GoodsService;
import com.example.service.Paging;
import com.example.service.ResellerService;
import com.example.service.UtilFile;

import net.sf.json.JSONObject;

@Controller
public class GoodsController {


	 @Autowired
	 GoodsService g_service;

	 @Autowired
	 DealService d_service;
	 
	@RequestMapping(value="/goods", method= {RequestMethod.GET, RequestMethod.POST})
	public String goods(Model model,
			HttpSession session,
			  @RequestParam Map map,
	          @RequestParam(value = "pageNo", required = false) Integer pageNo,
	            @RequestParam(value = "pageView", required = false) Integer pageView,
	            @RequestParam(value = "goods_nm", required = false) String goods_nm
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
//	         -----------------------------------------
		  /* paging */
	         int count = g_service.PagingCountGoods(map);
		     Paging pageInfo = new Paging(count, pageNo, pageView);
		     model.addAttribute("pageInfo", pageInfo);
  
		     map.put("pageNo", pageNo);
		     map.put("pageView", pageView);
		     map.put("offSet", (pageNo - 1) * pageView);
	         map.put("location_id",session.getAttribute("user_id"));
	         
			List<GoodsVO> goodsList = g_service.selectGoods(map);
			model.addAttribute("goodsList", goodsList);
		
		return "/goods";
	}
	
	//제품 등록 
	  @RequestMapping(value = "/goodsInsert", method = { RequestMethod.GET, RequestMethod.POST })
	   public void goodsInsert(
			   @RequestParam("img_path") MultipartFile img_path,
               MultipartHttpServletRequest request,
	         HttpServletRequest req,
	         HttpServletResponse res,         
	         @RequestParam Map map)  throws Exception  {
	      
	      JSONObject jsob = new JSONObject();
	      
	      try {
	    	 
//		      UtilFile 객체 생성
		      UtilFile utilFile = new UtilFile();
		       
//		      파일 업로드 결과값을 path로 받아온다(이미 fileUpload() 메소드에서 해당 경로에 업로드는 끝났음)
		      String uploadPath = utilFile.fileUpload(request, img_path);
//		      해당 경로만 받아 db에 저장
		      map.put("img_path", uploadPath);
		      
//		      Goods_insert
		      int count = g_service.InsertGoods(map);
		      
//		      Stock_insert
		      count =  d_service.updateStock(map);
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
	  @RequestMapping(value = "/goodsUpdate", method = { RequestMethod.GET, RequestMethod.POST })
	   public void updateGoods(
			   @RequestParam("img_path") MultipartFile img_path,
               MultipartHttpServletRequest request,
	         HttpServletRequest req,
	         HttpServletResponse res,         
	         @RequestParam Map map)  throws Exception  {
		  
		  String ud_flag = (String) map.get("ud_flag");
		  String goods_qty = (String) map.get("goods_qty");
		  
		   
		   JSONObject jsob = new JSONObject();
		   try {
//				      UtilFile 객체 생성
				     System.out.println(ud_flag);
				     System.out.println(goods_qty);
				     System.out.println(img_path);
			   
			   if(ud_flag.equals("U") && !img_path.equals("")) {
				   UtilFile utilFile = new UtilFile();
				       
//				      파일 업로드 결과값을 path로 받아온다(이미 fileUpload() 메소드에서 해당 경로에 업로드는 끝났음)
				      String uploadPath = utilFile.fileUpload(request, img_path);

//				      해당 경로만 받아 db에 저장
				      map.put("img_path", uploadPath);
			   }
			   
		         int count = g_service.updateGoods(map);
		         //  String goods_no = (String)map.get("goods_no");
		         // location_id, qty, goods_no 

		         if(ud_flag.equals("U") &&!goods_qty.equals("")) {
		        			 d_service.updateStock(map);
		        		 }
		         
		         map.put("errCd", count);
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
	  @RequestMapping(value = "/goodsExcel")
	   public void goodsExcel(HttpServletResponse response,
	   		@RequestParam Map map
	   		) throws Exception {
		   
		   List<GoodsVO> goodsList = g_service.selectGoods(map);
		   g_service.goodsExcel(response, goodsList); 
	   	}
	 


}

