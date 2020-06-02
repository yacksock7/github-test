package com.example.service;

import java.util.List;

import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.example.dao.UserDAO;
import com.example.dto.UserVO;

@Service
public class UserServiceImpl implements UserService{

	@Inject
	UserDAO u_dao;
	
	@Override
	public UserVO loginUser(Map map) {
		return u_dao.loginUser(map);
	}

	@Override
	public int insertUser(Map map) {
		return u_dao.insertUser(map);
	}

	@Override
	public int updateUser(Map map) {
		// TODO Auto-generated method stub
		return u_dao.updateUser(map);
	}

}
