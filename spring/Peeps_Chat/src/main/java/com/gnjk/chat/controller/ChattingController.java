package com.gnjk.chat.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ChattingController { // 채팅 화면 (*수정 중)  

	@RequestMapping(value = "/chatting", method = RequestMethod.GET)
	public ModelAndView chat(ModelAndView mav, 
			// @RequestParam("가져올 데이터 이름")[데이터타입][가져온 데이터 담을 변수]
			@RequestParam("m_idx") String m_idx,
			@RequestParam("rm_idx") String rm_idx,
			@RequestParam("ch_ms") String ch_ms,
			@RequestParam("ch_time") String ch_time,
			HttpSession session) {

		mav.setViewName("chatting"); //jsp 파일
		mav.addObject("user", m_idx);
		mav.addObject("to", rm_idx);
		mav.addObject("message", ch_ms);
		mav.addObject("time", ch_time);
		session.setAttribute("user", m_idx);
		session.setAttribute("to", rm_idx);
		session.setAttribute("message", ch_ms);
		session.setAttribute("time", ch_time);
		
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