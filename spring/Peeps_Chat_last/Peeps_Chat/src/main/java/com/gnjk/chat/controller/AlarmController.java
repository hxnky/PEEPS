package com.gnjk.chat.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.gnjk.chat.domain.Alarm;
import com.gnjk.chat.service.AlarmService;

@RestController
@RequestMapping(value = "http://localhost:8081/chat/alarm/select")
public class AlarmController {

	@Autowired
	private AlarmService service;

	/*
	@GetMapping("/alarm/insert")
	@ResponseBody
	public void saveAlarm(Alarm alarmdata) throws Exception {

		service. insertAlarm(alarmdata);

	}
	 */
	
	@GetMapping
	@ResponseBody
	public List<Alarm> alarmList(Alarm alarm, HttpSession session) throws Exception{

		session.setAttribute("list", service.alarmList(alarm));

		System.out.println("알람 컨트롤러…");

		System.out.println(service.alarmList(alarm));

		return  service.alarmList(alarm);

	}
}