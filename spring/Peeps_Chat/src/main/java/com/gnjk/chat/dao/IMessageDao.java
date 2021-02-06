package com.gnjk.chat.dao;

import com.gnjk.chat.domain.Message;

public interface IMessageDao {

	/*
	// public abstract
		// 회원 등록
		int insertMember(Member member);

		// 전체 회원의 수
		int memberCountUpdate();

		// 로그인
		Member selectLogin(String id, String pw);

		// 회원의 총 수
		int selectTotalCount();

		// 회원 리스트(페이지 번호에 맞는)
		//List<Member> selectMemberList(int startRow, int cntPerPage);
		List<Member> selectMemberList(Map<String , Object> param);

		// 2021.01.28 : Rest API : GET
		List<Member> selectAllMemberList();
	*/
	
	// 메세지 등록
	int insertMessage(Message message);
	
	// 메세지 리스트
}