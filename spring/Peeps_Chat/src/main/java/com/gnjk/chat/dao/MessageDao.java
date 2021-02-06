package com.gnjk.chat.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gnjk.chat.domain.Message;

//객체를 자동 생성하고 데이터베이스 예외를 스프링 예외로 변환해서 출력하도록 하는 어노테이션
@Repository
public class MessageDao implements IMessageDao {
	
	
	// SqlSession 객체를 자동으로 대입받는 어노테이션
		@Autowired
		private SqlSession sqlSession;
		// 동일한 문자열을 저장하기 위한 변수
		// final : 상수(값을 변경할 수 없는 값)를 만들어주는 예약어
		// 상수는 대문자로 이름을 만들기
		private static final String NAMESPACE = "message";

		@Override
		public void send(Message vo) {
			sqlSession.insert(NAMESPACE + ".send",vo);
		}
		
}