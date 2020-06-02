package com.example.dao;

import java.util.List;
import java.util.Map;

import com.example.dto.ITVO;
import com.example.dto.IssueTagVO.IssueTagList;
import com.example.dto.IssueVO;
import com.example.dto.ReplyVO;

public interface IssueDAO {
	List<IssueVO> selectIssue = null;

	List<IssueVO> selectIssue(Map map);
	int insertIssue(Map map);
	IssueVO issueDetail(Map map);
	int updateIssue(Map map);
	
	
	int insertIssueTag(Map map);
	List<ITVO> selectIssueTag(Map map);
	int updateIssueTag(Map map);
	
	List<ReplyVO> selectReply(Map map);
	int insertReply(Map map);
	int updateReply(Map map);
	int PagingCountIssue(Map map);

}
