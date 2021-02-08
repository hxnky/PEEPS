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

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.gnjk.chat.service.MessageService;

@Controller
public class ChattingController { // 채팅 화면 (*수정 중)  

	@RequestMapping(value = "/chatting", method = RequestMethod.GET)
	public ModelAndView chat(ModelAndView mav, 
			@RequestParam("userid")String userid,
			HttpSession session) {

		mav.setViewName("chatting"); //jsp 파일
		mav.addObject("user", userid);

		session.setAttribute("user", userid);

		return mav;
	}
	
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
	
	
	
	
	
}
