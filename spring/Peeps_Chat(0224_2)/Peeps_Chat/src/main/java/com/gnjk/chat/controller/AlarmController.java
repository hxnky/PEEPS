package com.gnjk.chat.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.gnjk.chat.domain.Alarm;
import com.gnjk.chat.service.AlarmService;
import com.gnjk.chat.service.DeleteService;

@RestController
public class AlarmController {

	@Autowired
	private AlarmService service;
	
	@Autowired
	private DeleteService dservice;
	
	/*
	 * @RequestMapping(value = "/alarm/insert") public int saveAlarm(Alarm
	 * alarmdata) throws Exception {
	 * 
	 * System.out.println("알람 저장 컨트롤러…");
	 * 
	 * return service. insertAlarm(alarmdata);
	 * 
	 * }
	 */
	
	@RequestMapping(value = "/alarm/select")
	public List<Alarm> alarmList(Alarm alarm, HttpSession session) throws Exception{

		session.setAttribute("list", service.alarmList(alarm));

		System.out.println("알람 컨트롤러…");

		System.out.println(service.alarmList(alarm));

		return  service.alarmList(alarm);

	}
	
	@RequestMapping(value = "/alarm/delete")
	public int deleteAl(Alarm alarm, HttpSession session) throws Exception {
		
		session.setAttribute("delAl", dservice.deleteAlarm(alarm.getAl_idx()));
		
		System.out.println("알람 삭제 컨트롤러.....");
		
		return dservice.deleteAlarm(alarm.getAl_idx());
		
	}
}