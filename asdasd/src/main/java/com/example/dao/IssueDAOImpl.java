package com.example.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.example.dto.ITVO;
import com.example.dto.IssueTagVO.IssueTagList;
import com.example.dto.IssueVO;
import com.example.dto.ReplyVO;
import com.example.dto.ScheduleVO;

@Service
public class IssueDAOImpl implements IssueDAO{

	@Inject
    private SqlSession sqlSession;
    private static final String Namespace = "com.example.mapper.memberMapper";

    @Override
  	public List<IssueVO> selectIssue(Map map) {
      	 return sqlSession.selectList(Namespace+".selectIssue", map);
  	}

	@Override
	public int insertIssue(Map map) {
		// TODO Auto-generated method stub
		 return sqlSession.insert(Namespace+".insertIssue", map);
  	}

	@Override
	public IssueVO issueDetail(Map map) {
		// TODO Auto-generated method stub
		 return sqlSession.selectOne(Namespace+".selectOneIssue", map);
	}

	@Override
	public int updateIssue(Map map) {
		// TODO Auto-generated method stub
		return sqlSession.update(Namespace+".updateIssue", map);
	}

	@Override
	public int insertIssueTag(Map map) {
		// TODO Auto-generated method stub
		return sqlSession.insert(Namespace+".insertIssueTag", map);
	}

	@Override
	public List<ITVO> selectIssueTag(Map map) {
		// TODO Auto-generated method stub
	   	 return sqlSession.selectList(Namespace+".selectIssueTag", map);
	}

	@Override
	public int updateIssueTag(Map map) {
		// TODO Auto-generated method stub
		return sqlSession.update(Namespace+".updateIssueTag", map);
	}

	@Override
	public List<ReplyVO> selectReply(Map map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList(Namespace+".selectReply", map);
	}

	@Override
	public int insertReply(Map map) {
		// TODO Auto-generated method stub
		return sqlSession.insert(Namespace+".insertReply", map);
	}

	@Override
	public int updateReply(Map map) {
		// TODO Auto-generated method stub
		return sqlSession.update(Namespace+".updateReply", map);
	}

	@Override
	public int PagingCountIssue(Map map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(Namespace+".PagingCountIssue", map);
	}
	
	
    
}
