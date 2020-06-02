package com.example.service;

import java.util.List;
import java.util.Map;

import com.example.dto.GoodsVO;
import com.example.dto.NoticeVO;

public interface NoticeService {
	
	List<NoticeVO> selectNotice(Map map) throws Exception;
	int InsertNotice(Map map);
	int updateNotice(Map map);
	int PagingCountNotice(Map map);

}
