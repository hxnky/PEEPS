package com.gnjk.chat.controller;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.gnjk.chat.dao.MessageDao;
import com.gnjk.chat.domain.Message;

@Controller
public class ChattingController { // 채팅 화면 (*수정 중)  

	@Inject
	private MessageDao dao;
	
	// RequestMapping : 전송방식 지정 (method 정의 시, 그 방식으로만 접근할 수 있음)
	// view의 요청 경로
	// @RequestMapping("/chatting")
	@RequestMapping(value = "/chatting", method = RequestMethod.GET)
	public ModelAndView chat(ModelAndView mav, 
			// @RequestParam("가져올 데이터 이름")[데이터타입][가져온 데이터 담을 변수]
			@RequestParam("m_idx") String m_idx,
			@RequestParam("rm_idx") String rm_idx,
			@RequestParam("ch_ms") String ch_ms,
			@RequestParam("ch_time") String ch_time,
			HttpSession session) {

		//jsp 파일, view 지정(어떤 페이지를 보여줄 것인지)
		mav.setViewName("chatting");

		// key와 value를 담아 보낼 수 있는 메서드
		// addObject("변수 이름", "데이터 값");
		mav.addObject("m_idx", m_idx);
		mav.addObject("rm_idx", rm_idx);
		mav.addObject("ch_ms", ch_ms);
		mav.addObject("ch_time", ch_time);

		// setAttribute(String name, Object value) => 이름이 name인 속성 값을 value로 지정
		session.setAttribute("m_idx", m_idx);
		session.setAttribute("rm_idx", rm_idx);
		session.setAttribute("ch_ms", ch_ms);
		session.setAttribute("ch_time", new java.util.Date());

		return mav;
	}
	
	/*
	@Autowired
	private MessageService messageService;

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public String save(ModelAndView mav, HttpServletRequest request) {

		// 서비스 메소드 호출
		try {
			messageService.save(request);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "redirect:list";
	}
	 */

}