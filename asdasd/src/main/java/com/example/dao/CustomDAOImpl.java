package com.example.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.dto.CustomVO;

@Repository
public class CustomDAOImpl implements CustomDAO{
	
	@Inject
    private SqlSession sqlSession;
    
    private static final String Namespace = "com.example.mapper.memberMapper";

	@Override
	public List<CustomVO> selectCustomer(Map map) throws Exception {
		 return sqlSession.selectList(Namespace+".selectCustomer", map);
	}

	@Override
	public int insertCustomer(Map map) {
		return sqlSession.insert(Namespace + ".insertCustomer", map);
	}

	@Override
	public int updateCustomer(Map map) {
		return sqlSession.update(Namespace + ".updateCustomer", map);
	}

	@Override
	public int PagingCountCustom(Map map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(Namespace + ".PagingCountCustom", map);
	}
}
