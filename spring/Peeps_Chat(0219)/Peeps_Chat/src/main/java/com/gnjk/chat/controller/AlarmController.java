package com.gnjk.chat.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
	
	@RequestMapping(value = "/alarm/select", method = RequestMethod.GET)
	public void listAll(Model model) throws Exception {
		
		model.addAttribute("tosokcet", service.listNav());
		
	}
	
	

}