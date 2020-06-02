package com.example.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.example.dto.CustomVO;


public interface CustomService {
	
	List<CustomVO> selectCustomer(Map map) throws Exception;
	int InsertCustomer(Map map);
	int updateCustomer(Map map);
	void customExcel(HttpServletResponse response, List<CustomVO> customList) throws IOException;
	int PagingCountCustom(Map map);

}
