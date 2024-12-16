package com.cl.cruella.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class CommentDao {

	private final SqlSessionTemplate sqlSession;
	
	
}
