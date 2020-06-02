package com.example.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.example.dto.NoticeVO;

@Service
public class NoticeDAOImpl implements NoticeDAO{
	
	@Inject
    private SqlSession sqlSession;
    
    private static final String Namespace = "com.example.mapper.memberMapper";

    
	@Override
	public List<NoticeVO> selectNotice(Map map) throws Exception {
			return sqlSession.selectList(Namespace + ".selectNotice", map);
	}


	@Override
	public int insertNotice(Map map) {
		return sqlSession.insert(Namespace + ".insertNotice", map);
	}


	@Override
	public int updateNotice(Map map) {
		return sqlSession.update(Namespace + ".updateNotice", map);
	}


	@Override
	public int PagingCountNotice(Map map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(Namespace + ".PagingCountNotice", map);
	}
    

}
