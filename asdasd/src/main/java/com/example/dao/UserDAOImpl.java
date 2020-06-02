package com.example.dao;

import java.util.List;

import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.example.dto.UserVO;
@Service
public class UserDAOImpl implements UserDAO{
	
	@Inject
    private SqlSession sqlSession;
    
    private static final String Namespace = "com.example.mapper.memberMapper";
	
    @Override
	public UserVO loginUser(Map map) {
	return sqlSession.selectOne(Namespace+".selectUser", map);
	}

	@Override
	public int insertUser(Map map) {
		
		return sqlSession.insert(Namespace+".insertUser", map);
	}

	@Override
	public int updateUser(Map map) {
		// TODO Auto-generated method stub
		return sqlSession.update(Namespace+".updateUser", map);
	}

}
