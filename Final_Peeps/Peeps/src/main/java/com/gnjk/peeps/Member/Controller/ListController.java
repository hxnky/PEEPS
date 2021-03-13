package com.gnjk.peeps.Member.Controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.gnjk.peeps.Member.Service.MesListService;
import com.gnjk.peeps.Member.domain.Message;

@RestController
@CrossOrigin("*")
public class ListController {
	
	@Autowired
	private MesListService service;
	
	// 채팅방 메세지 리스트 
	@RequestMapping(value = "/mes/select")
	public List<Message> mesList(int rm_idx, int me_idx, HttpSession session) throws Exception{
		
		//session.setAttribute("list",  service.mesList(rm_idx, me_idx));
		
		System.out.println("mesList~~컨트롤러!");
		System.out.println(service.mesList(rm_idx, me_idx));
		
		return service.mesList(rm_idx, me_idx);
		
	}
	
	// 회원별 채팅  
	@RequestMapping(value = "/room/select")
	public List<Message> roomList(int me_idx, HttpSession session) throws Exception{
		
		//session.setAttribute("list",  service.roomList(me_idx));
		
		System.out.println("roomList~~컨트롤러!");
		System.out.println(service.roomList(me_idx));
		
		return service.roomList(me_idx);
		
	}
	
}