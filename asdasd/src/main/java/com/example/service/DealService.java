package com.example.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import com.example.dao.ResellerDAO;
import com.example.dto.DealVO;
import com.example.dto.ResellerVO;

public interface DealService {

	List<DealVO> selectDeal(Map map) throws Exception;
	int InsertDeal(Map map);
	int updateDeal(Map map);
	void excelDeal(HttpServletResponse response, List<DealVO> list)  throws IOException ;
	
	

	//Stock
	int updateStock(Map map);
}
	
