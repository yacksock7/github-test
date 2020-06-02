package com.example.dao;

import java.util.List;
import java.util.Map;

import com.example.dto.GoodsVO;

public interface GoodsDAO {

	List<GoodsVO> selectGoods(Map map) throws Exception;
	int insertGoods(Map map);
	int updateGoods(Map map);
	int PagingCountGoods(Map map); 

}
