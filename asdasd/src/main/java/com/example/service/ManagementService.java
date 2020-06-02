package com.example.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.example.dto.CustomVO;
import com.example.dto.GoodsVO;
import com.example.dto.ManagementVO;
import com.example.dto.UserVO;

public interface ManagementService {

	List<ManagementVO> selectManagement(Map map);

	List<UserVO> selectMngReseller(Map map);

	List<CustomVO> selectMngCustomer(Map map);

	List<GoodsVO> selectMngGoods(Map map);

	void goods_managementExcel(HttpServletResponse response, List<GoodsVO> t_GoodsList) throws IOException;

	void reseller_managementExcel(HttpServletResponse response, List<UserVO> t_RsellerList) throws IOException;

	void custom_managementExcel(HttpServletResponse response, List<CustomVO> t_CustomerList) throws IOException;

	int r_PagingCountMng(Map map);

	int c_PagingCountMng(Map map);

	int g_PagingCountMng(Map map);


	
	
	
}
