package com.example.dao;

import java.util.List;
import java.util.Map;

import com.example.dto.SGVO;
import com.example.dto.ScheduleGoodsVO;
import com.example.dto.ScheduleGoodsVO.ScheduleGoodsList;
import com.example.dto.ScheduleVO;

public interface ScheduleDAO {

	List<ScheduleVO> selectSchedule(Map map);
	int insertSchedule(Map map);
	int updateSchedule(Map map);
	int insertScheduleGoods(Map map);
	ScheduleVO selectOneSchedule(Map map);
	List<SGVO> selectScheduleGoods(Map map);
	int updateScheduleGoods(Map map);
	int PagingCountSchedule(Map map);

}
