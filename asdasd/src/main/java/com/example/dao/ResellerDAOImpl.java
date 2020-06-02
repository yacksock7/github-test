package com.example.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.example.dto.CustomVO;
import com.example.dto.ResellerVO;
import com.example.dto.UserVO;

@Service
public class ResellerDAOImpl implements ResellerDAO{
	
	@Inject
    private SqlSession sqlSession;
    
    private static final String Namespace = "com.example.mapper.memberMapper";

    @Override
	public List<UserVO> selectReseller(Map map) throws Exception {
		// TODO Auto-generated method stub
		 return sqlSession.selectList(Namespace+".selectReseller", map);
	}

	@Override
	public int insertReseller(Map map) {
		return sqlSession.insert(Namespace + ".insertReseller", map);
	}

	@Override
	public int updateReseller(Map map) {

		return sqlSession.update(Namespace + ".updateReseller", map);
	}

	@Override
	public UserVO resellerDetail(String office_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(Namespace+".selectOneReseller", office_id);	
		}

	@Override
	public int PagingCountReseller(Map map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(Namespace+".PagingCountReseller", map);	
	}


	}

