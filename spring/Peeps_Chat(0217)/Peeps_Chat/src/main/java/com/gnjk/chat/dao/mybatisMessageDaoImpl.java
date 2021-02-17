package com.gnjk.chat.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.gnjk.chat.domain.Message;

@Repository
public class mybatisMessageDaoImpl implements mybatisMessageDao {

	@Inject
	private SqlSession sqlSession;
	private static String namespace = "com.gnjk.dao.mapper.mybatisMessageDao";
	
	public void insertMessage(Message mes) throws Exception {
		
		sqlSession.insert(namespace + ".insertMessage", mes);
	}
	
}