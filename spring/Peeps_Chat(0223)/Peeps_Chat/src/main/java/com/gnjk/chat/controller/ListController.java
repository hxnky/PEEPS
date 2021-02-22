package com.gnjk.chat.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gnjk.chat.domain.Message;
import com.gnjk.chat.service.MesListService;

@Controller
@RequestMapping(value = "/mes/select")
public class ListController {
	
	@Autowired
	private MesListService service;
	
	@GetMapping
	@ResponseBody
	public List<Message> mesList(Message mes, HttpSession session) throws Exception{
		
		session.setAttribute("list",  service.mesList(mes));
		
		System.out.println("채팅 리스트 컨트롤러!");
		System.out.println(service.mesList(mes));
		
		return service.mesList(mes);
		
	}
}