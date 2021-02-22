package com.gnjk.chat.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gnjk.chat.domain.Alarm;
import com.gnjk.chat.service.AlarmService;

@Controller
public class AlarmController {
	
	@Autowired
	private AlarmService service;
	
	@GetMapping("/alarm/insert")
	@ResponseBody
	public void saveAlarm(Alarm alarmdata) {
		try {
			service. insertAlarm(alarmdata);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	

}