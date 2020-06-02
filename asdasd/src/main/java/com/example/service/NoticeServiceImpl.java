package com.example.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.example.dao.NoticeDAO;
import com.example.dao.UserDAO;
import com.example.dto.NoticeVO;

@Service
public class NoticeServiceImpl implements NoticeService{
	
	@Inject
	NoticeDAO n_dao;

	@Override
	public List<NoticeVO> selectNotice(Map map) throws Exception {
		return n_dao.selectNotice(map);
	}

	@Override
	public int InsertNotice(Map map) {
		return n_dao.insertNotice(map);
	}

	@Override
	public int updateNotice(Map map) {
		return n_dao.updateNotice(map);
	}

	@Override
	public int PagingCountNotice(Map map) {
		// TODO Auto-generated method stub
		return n_dao.PagingCountNotice(map);
	}

}
