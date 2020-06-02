package com.example.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.example.dto.CustomVO;
import com.example.dto.GoodsVO;
import com.example.dto.ManagementVO;
import com.example.dto.UserVO;

@Service
public class ManagementDAOImpl implements ManagementDAO{

	@Inject
    private SqlSession sqlSession;
    
    private static final String Namespace = "com.example.mapper.memberMapper";

	
	@Override
	public List<ManagementVO> selectManagement(Map map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList(Namespace + ".selectManagement", map);
	}


	@Override
	public List<UserVO> selectMngReseller(Map map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList(Namespace + ".selectMngReseller", map);
	}


	@Override
	public List<CustomVO> selectMngCustomer(Map map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList(Namespace + ".selectMngCustomer", map);
	}


	@Override
	public List<GoodsVO> selectMngGoods(Map map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList(Namespace + ".selectMngGoods", map);
	}


	@Override
	public int r_PagingCountMng(Map map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(Namespace + ".r_PagingCountMng", map);
	}


	@Override
	public int c_PagingCountMng(Map map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(Namespace + ".c_PagingCountMng", map);
	}


	@Override
	public int g_PagingCountMng(Map map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(Namespace + ".c_PagingCountMng", map);
	}
	
}
