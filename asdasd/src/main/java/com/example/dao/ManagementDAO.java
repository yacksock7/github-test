package com.example.dao;

import java.util.List;
import java.util.Map;

import com.example.dto.CustomVO;
import com.example.dto.GoodsVO;
import com.example.dto.ManagementVO;
import com.example.dto.UserVO;

public interface ManagementDAO {

	List<ManagementVO> selectManagement(Map map);
	List<UserVO> selectMngReseller(Map map);
	List<CustomVO> selectMngCustomer(Map map);
	List<GoodsVO> selectMngGoods(Map map);
	int r_PagingCountMng(Map map);
	int c_PagingCountMng(Map map);
	int g_PagingCountMng(Map map);
	

}
