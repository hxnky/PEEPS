package com.gnjk.chat.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.gnjk.chat.domain.Message;

@Repository
public class MessageDaoImpl implements MessageDao {

	@Inject
	private SqlSession session;
	private static String namespace = "com.gnjk.dao.mapper.mybatisMessageDao";

	@Override public void insertMessage(Message mes) throws Exception {

		session.insert(namespace + ".insertMessage", mes); 
	}

	/*
	 * @Override // selectList(): SELECT // 파라미터: SQL 맵퍼의 네임 스페이스 + SQL문
	 * ID(selectList) public List<Message> selectList(Message message, int rm_idx)
	 * throws Exception{
	 * 
	 * return session.selectList(namespace +".selectList", rm_idx); }
	 * 
	 * 
	 * 
	 * 
	 * 
	 * @Override public List<Message> getMessageData(String str) throws Exception {
	 * return session.selectList(namespace + ".getMessageData", str); }
	 */

}