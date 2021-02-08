package com.gnjk.chat.service;

import javax.servlet.http.HttpServletRequest;

public interface IMessageService {

	// 메세지를 저장하는 메소드
	// HttpServletRequest 객체가 파라미터가 되어
	// 메세지, 채팅 시간 등의 데이터를 컨트롤러로 보냈을 때
	// HttpServletRequest 객체 안에 모든 데이터들이 들어가게 된다.
	public void save(HttpServletRequest request);
	
}