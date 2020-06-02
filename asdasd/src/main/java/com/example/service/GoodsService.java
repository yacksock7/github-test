package com.example.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.dto.GoodsVO;

public interface GoodsService {

	List<GoodsVO> selectGoods(Map map) throws Exception;
	int InsertGoods(Map map);
	int updateGoods(Map map);
	void goodsExcel(HttpServletResponse response, List<GoodsVO> goodsList) throws IOException ;
	int PagingCountGoods(Map map);

}
