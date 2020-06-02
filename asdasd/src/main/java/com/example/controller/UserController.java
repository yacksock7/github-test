package com.example.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;

import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.dto.UserVO;
import com.example.service.UserService;
import com.mysql.cj.api.Session;

import net.sf.json.JSONObject;

@Controller
public class UserController {
	@Autowired
	UserService u_service;
	
	//home
	@RequestMapping(value="/", method= {RequestMethod.GET })
	public String home() {
		return "/login";
	}
	
	
	@RequestMapping(value="/logout", method= RequestMethod.GET)
	public String home(HttpSession session, HttpServletResponse res) {
		
		Cookie cookie = new Cookie("userCook", null);
		cookie.setMaxAge(0);
		res.addCookie(cookie);
		
		session.invalidate();
		
		return "/login";
	}
	
	@RequestMapping(value="/join", method= RequestMethod.GET)
	public String join(HttpSession session, HttpServletResponse res) {
		return "/join";
	}
	
	//login
	  @RequestMapping(value = "/userCheck", method = { RequestMethod.GET, RequestMethod.POST })
	   public void updateUser(
			   Model model,
			   HttpSession session,
	         HttpServletRequest req,
	         HttpServletResponse res,         
	         @RequestParam Map map)  throws Exception  {
		   
		   JSONObject jsob = new JSONObject();
		      
		      try {
		//
		          UserVO user = u_service.loginUser(map);
	  				int count = 1;   
	  				map.put("user_group", user.getUser_group());
		         
		  		if(user==null) {
		  			map.put("errCd", "-1");
			         map.put("errMsg", "존재하지 않는 아이디입니다.");
		  		}else {
		  			//4. null이 아닌 경우 다시 pw와 객체의 pw비교
		  			if(map.get("pw").equals(user.getPw())) {
		  				//쿠키설정, count 1 
		  				Cookie cookie = new Cookie("userCook", user.getManager()); // 쿠키 이름을 name으로 생성
		  				cookie.setMaxAge(60*60*24); 
		  				res.addCookie(cookie);
		  				
		  				session.setAttribute("user_nm", user.getManager());
		  				session.setAttribute("user_id", user.getOffice_id());
		  				session.setAttribute("user_group", user.getUser_group());
		  					
				         map.put("errCd", "1");
//				         map.put("errMsg", "로그인에 성공하였습니다.");
		  			}else {
		  				 map.put("errCd", "-1");
				         map.put("errMsg", "비밀번호가 틀렸습니다.");
		  			}
		      } 
		      }catch (Exception e) {
		         System.out.println(e);

		         map.put("errCd", "-1"); // 
		         map.put("errMsg", "An error occurred during processing.");

		      } finally {

		         jsob = JSONObject.fromObject(map);
		         res.setContentType("text/html;charset=UTF-8");
		         res.getWriter().print(jsob);
		      }
	   }
	  
	  
	  @RequestMapping(value = "/insertUser", method = { RequestMethod.GET, RequestMethod.POST })
	   public void insertUser(
	         HttpServletRequest req,
	         HttpServletResponse res,         
	         @RequestParam Map map)  throws Exception  {
	      
	      JSONObject jsob = new JSONObject();
	      
	      try {
	    	  
	    	  UserVO user = u_service.loginUser(map);
	    	  if(user!=null) {
		  			map.put("errCd", "-1");
			         map.put("errMsg", "이미 존재하는 아이디입니다.");
	    	  }else {
	         int count = u_service.insertUser(map);
	         
	         map.put("errCd", count);
	         map.put("errMsg", "등록에 성공하였습니다.");
	      }              

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

//	 MY Page ------------------------------------------------------------------------
		
		@RequestMapping(value="/mypage", method= {RequestMethod.GET, RequestMethod.POST })
		public String mypage( @RequestParam Map map,
				Model model,
				HttpSession session
			 ) {
			map.put("office_id", session.getAttribute("user_id"));
			 UserVO my_info = u_service.loginUser(map);
			 model.addAttribute("my_info", my_info);
			return "/mypage";
		}
		
		
		  @RequestMapping(value = "/updateUser", method = { RequestMethod.GET, RequestMethod.POST })
		   public void updateUser(HttpSession session,         
		         HttpServletRequest req,
		         HttpServletResponse res,  
		         @RequestParam Map map
				   )  throws Exception  {
			   
			   JSONObject jsob = new JSONObject();
			      
			      try {
			    	  
			    	 map.put("office_id", session.getAttribute("user_id"));
			         int count = u_service.updateUser(map);
			         
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
