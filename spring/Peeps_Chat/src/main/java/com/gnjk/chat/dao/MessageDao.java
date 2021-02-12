package com.gnjk.chat.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gnjk.chat.domain.ChatRoom;
import com.gnjk.chat.domain.Message;

// @Repository : 스프링에서 DAO 인식
@Repository
public class MessageDao implements IMessageDao {

	// @Inject(JAVA제공), @Autowired(스프링제공) : 의존 관계 자동 연결
	@Autowired
	private SqlSession session;

	private static String namespace = "com.gnjk.chat.dao.mapper.ChatMapper";
	
	// 채팅방 select
	@Override
	public ChatRoom isRoom(ChatRoom vo) throws Exception {
		ChatRoom room = null;
		// sqlSession.selectOne(매퍼이름.id, 매개변수)
		//				insert, delete, update, selectList
		// insert, delete, update : 영향 받은 행의 개수 정수로 반환
		// selectOne : 설정한 resultType 객체 반환(메소드 결과가 2개이상이면 예외 발생)
		// selectList : 설정한 resultType의 List로 반환
		// Map으로 select 결과를 받으면 컬럼이름-키, 데이터-값
		room = session.selectOne(namespace + ".isRoom", vo);
		System.out.println("isRoom");

		return room;
	}
	
	// 채팅방 생성, 채팅방 insert
	@Override
	public void createRoom(ChatRoom vo) throws Exception {
		System.out.println("createRoom");
		session.insert(namespace + ".createRoom", vo);
	}

	// 메세지 insert
	@Override
	public void insertMessage(Message vo)throws Exception {
		session.insert(namespace + ".insertMessage", vo);
	}
	
	// 메세지 리스트 select
	@Override
	public List<Message> getMessageList(String str) throws Exception {

		return session.selectList(namespace+".getMessageList" , str);

	}
	
	// 채팅방 리스트 select
	@Override
	public List<ChatRoom> getRoomList(String str) throws Exception {

		return session.selectList(namespace+".getRoomList",str);
	}
	
	// 훔,,,
	@Override
	public List<ChatRoom> getRoomList2(String str) throws Exception {

		return session.selectList(namespace+".getRoomList2" , str);
	}
	
	// 최근 메세지 select
	@Override
	public Message getRecentMessage(String str) throws Exception {

		return session.selectOne(namespace+".getRecentMessage" , str);
	}
	
	// 메세지 읽은 시각
	@Override
	public void updateReadTime(int room_idx, String m_idx, String rm_idx) throws Exception {

		HashMap<String, Object> map = new HashMap<String, Object> ();

		map.put("room_idx", room_idx);
		map.put("m_idx", m_idx);
		map.put("rm_idx", rm_idx);

		session.update(namespace+".updateReadTime" , map);
	}
	
	// 읽지 않은 메세지 select => memberVO에 넣어야... 할 수도.....
	@Override
	public int getUnReadCount(int room_idx, String m_idx, String rm_idx)throws Exception {

		HashMap<String, Object> map = new HashMap<String, Object> ();

		map.put("room_idx", room_idx);
		map.put("m_idx", m_idx);
		map.put("rm_idx", rm_idx);

		// Map으로 select 구문의 결과를 받는 경우, 컬럼이름이 키, 데이터가 값
		return session.selectOne(namespace+".getUnReadCount" , map);

	}

	@Override
	public int getAllCount(String str) {

		HashMap<String, Object> map = new HashMap<String, Object> ();

		map.put("rm_idx", str);
		if(session.selectOne(namespace+".getAllCount" ,map) ==null) {
			return 0;
		}else {
			return session.selectOne(namespace+".getAllCount" ,map);
		}

	}


}