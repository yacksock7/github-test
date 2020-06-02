package com.example.dao;

import java.util.List;
import java.util.Map;

import com.example.dto.CustomVO;
import com.example.dto.ResellerVO;
import com.example.dto.UserVO;

public interface ResellerDAO {

	List<UserVO> selectReseller(Map map) throws Exception;
	int insertReseller(Map map);
	int updateReseller(Map map);
	UserVO  resellerDetail(String office_id);
	int PagingCountReseller(Map map);

 
}
