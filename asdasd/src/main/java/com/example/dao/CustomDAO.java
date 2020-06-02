package com.example.dao;

import java.util.List;
import java.util.Map;

import com.example.dto.CustomVO;

public interface CustomDAO {

	
	List<CustomVO> selectCustomer(Map map) throws Exception;
	int insertCustomer(Map map);
	int updateCustomer(Map map);
	int PagingCountCustom(Map map); 
	
}
