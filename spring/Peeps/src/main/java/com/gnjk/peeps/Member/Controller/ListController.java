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
	
	@RequestMapping(value = "/mes/select")
	public List<Message> mesList(Message mes, HttpSession session) throws Exception{
		
		session.setAttribute("list",  service.mesList(mes));
		
		System.out.println("mesList~~컨트롤러!");
		System.out.println(service.mesList(mes));
		
		return service.mesList(mes);
		
	}
	

	@RequestMapping(value = "/room/select")
	public List<Message> roomList(Message mes, HttpSession session) throws Exception{
		
		session.setAttribute("list",  service.roomList(mes));
		
		System.out.println("roomList~~컨트롤러!");
		System.out.println(service.roomList(mes));
		
		return service.roomList(mes);
		
	}
	
}