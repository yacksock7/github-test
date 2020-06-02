package com.example.dao;

import java.util.List;
import java.util.Map;

import com.example.dto.GoodsVO;
import com.example.dto.NoticeVO;

public interface NoticeDAO {
	

	List<NoticeVO> selectNotice(Map map) throws Exception;
	int insertNotice(Map map);
	int updateNotice(Map map);
	int PagingCountNotice(Map map);

}
