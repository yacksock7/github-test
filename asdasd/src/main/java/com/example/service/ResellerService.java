package com.example.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.example.dto.CustomVO;
import com.example.dto.ResellerVO;
import com.example.dto.UserVO;

public interface ResellerService {

  	List<UserVO> selectReseller(Map map) throws Exception;
	int InsertReseller(Map map);
	int updateReseller(Map map);
	UserVO resellerDetail(String office_id);
	void resellerExcel(HttpServletResponse response, List<UserVO> resellerList) throws IOException;
	int PagingCountReseller(Map map);
	 
}
