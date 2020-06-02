package com.example.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.example.dto.SGVO;
import com.example.dto.ScheduleGoodsVO;
import com.example.dto.ScheduleGoodsVO.ScheduleGoodsList;
import com.example.dto.ScheduleVO;

public interface ScheduleService {

	ScheduleVO selectOneSchedule(Map map);
	List<ScheduleVO> selectSchedule(Map map);
	int insertSchedule(Map map);
	int updateSchedule(Map map);
	
	
	
	
	int insertScheduleGoods(Map map);
	List<SGVO> selectScheduleGoods(Map map);
	int updateScheduleGoods(Map map);
	void scheduleExcel(HttpServletResponse response, List<ScheduleVO> scheduleList) throws IOException;
	int PagingCountSchedule(Map map);

}
