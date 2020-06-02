package com.example.dao;

import java.util.List;
import java.util.Map;

import com.example.dto.CustomVO;
import com.example.dto.DealVO;

public interface DealDAO {
	
	
	List<DealVO> selectDeal(Map map) throws Exception;
	int insertDeal(Map map);
	int updateDeal(Map map);
	
	
	//Stock
	int updateStock(Map map);
}
