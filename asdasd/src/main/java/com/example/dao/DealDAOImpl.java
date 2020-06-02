package com.example.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.dto.CustomVO;
import com.example.dto.DealVO;

@Repository
public class DealDAOImpl implements DealDAO{

	
	@Inject
    private SqlSession sqlSession;
    
    private static final String Namespace = "com.example.mapper.memberMapper";
    
    @Override
	public List<DealVO> selectDeal(Map map) throws Exception {

		return sqlSession.selectList(Namespace + ".checkDeal", map);
	}

	@Override
	public int insertDeal(Map map) {
	return sqlSession.insert(Namespace + ".insertDeal", map);
	}
	
	@Override
	public int updateDeal(Map map) {
	return sqlSession.update(Namespace + ".updateDeal", map);
	}

	@Override
		public int updateStock(Map map) {

   	 System.out.println("5555");
		return sqlSession.update(Namespace + ".updateStock", map);
	}
	
}
