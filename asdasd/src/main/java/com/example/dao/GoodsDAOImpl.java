package com.example.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.example.dto.GoodsVO;

@Service
public class GoodsDAOImpl implements GoodsDAO{

	
	@Inject
    private SqlSession sqlSession;
    
    private static final String Namespace = "com.example.mapper.memberMapper";
    
    
	@Override
	public List<GoodsVO> selectGoods(Map map) throws Exception {
		return sqlSession.selectList(Namespace + ".selectGoods", map);
	}


	@Override
	public int insertGoods(Map map) {

		return sqlSession.insert(Namespace + ".insertGoods", map);
	}


	@Override
	public int updateGoods(Map map) {

		return sqlSession.update(Namespace + ".updateGoods", map);
	}


	@Override
	public int PagingCountGoods(Map map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(Namespace + ".PagingCountGoods", map);
	}

	
}
