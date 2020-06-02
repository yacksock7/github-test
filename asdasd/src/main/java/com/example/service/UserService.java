package com.example.service;

import java.util.List;

import java.util.Map;

import com.example.dto.UserVO;

public interface UserService {

	UserVO loginUser(Map map);
	int insertUser(Map map);
	int updateUser(Map map);

}
