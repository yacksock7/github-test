package com.example.service;

import java.util.List
;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.example.dao.IssueDAO;
import com.example.dto.ITVO;
import com.example.dto.IssueTagVO;
import com.example.dto.IssueTagVO.IssueTagList;
import com.example.dto.IssueVO;
import com.example.dto.ReplyVO;

@Service
public class IssueServiceImpl implements IssueService{

	@Inject
	private IssueDAO i_dao;

	@Override
	public List<IssueVO> selectIssue(Map map) {
		// TODO Auto-generated method stub
		return i_dao.selectIssue(map);
	}

	@Override
	public int insertIssue(Map map) {
		// TODO Auto-generated method stub
		return i_dao.insertIssue(map);
	}

	@Override
	public IssueVO issueDetail(Map map) {
		// TODO Auto-generated method stub
		return i_dao.issueDetail(map);
	}

	@Override
	public int updateIssue(Map map) {
		// TODO Auto-generated method stub
		return i_dao.updateIssue(map);
	}

	@Override
	public int insertIssueTag(Map map) {
		// TODO Auto-generated method stub
		return i_dao.insertIssueTag(map);
	}

	@Override
	public List<ITVO> selectIssueTag(Map map) {
		// TODO Auto-generated method stub
		return i_dao.selectIssueTag(map);
	}

	@Override
	public int updateIssueTag(Map map) {
		// TODO Auto-generated method stub
		return i_dao.updateIssueTag(map);
	}

	@Override
	public List<ReplyVO> selectReply(Map map) {
		// TODO Auto-generated method stub
		return i_dao.selectReply(map);

	}

	@Override
	public int insertReply(Map map) {
		// TODO Auto-generated method stub
		return i_dao.insertReply(map);
	}

	@Override
	public int updateReply(Map map) {
		// TODO Auto-generated method stub
		return i_dao.updateReply(map);

	}

	@Override
	public int PagingCountIssue(Map map) {
		// TODO Auto-generated method stub
		return i_dao.PagingCountIssue(map);

	}
	
	
}
