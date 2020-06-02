package com.example.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.example.dto.SGVO;
import com.example.dto.ScheduleGoodsVO;
import com.example.dto.ScheduleGoodsVO.ScheduleGoodsList;
import com.example.dto.ScheduleVO;

@Service
public class ScheduleDAOImpl implements ScheduleDAO{

	@Inject
    private SqlSession sqlSession;
    private static final String Namespace = "com.example.mapper.memberMapper";

    
	@Override
	public ScheduleVO selectOneSchedule(Map map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(Namespace+".selectOneSchedule", map);
	}

    @Override
	public List<ScheduleVO> selectSchedule(Map map) {
    	 return sqlSession.selectList(Namespace+".selectSchedule", map);
	}

	@Override
	public int insertSchedule(Map map) {
		return sqlSession.insert(Namespace+".insertSchedule", map);
	}

	@Override
	public int updateSchedule(Map map) {
		return sqlSession.update(Namespace+".updateSchedule", map);
	}

	@Override
	public List<SGVO> selectScheduleGoods(Map map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList(Namespace+".selectScheduleGoods", map);
	}
	
	@Override
	public int insertScheduleGoods(Map map) {
		// TODO Auto-generated method stub
		return sqlSession.insert(Namespace+".insertScheduleGoods", map);
	}
	
	@Override
	public int updateScheduleGoods(Map map) {
		// TODO Auto-generated method stub
		return sqlSession.update(Namespace+".updateScheduleGoods", map);
	}

	@Override
	public int PagingCountSchedule(Map map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(Namespace+".PagingCountSchedule", map);
	}


}
