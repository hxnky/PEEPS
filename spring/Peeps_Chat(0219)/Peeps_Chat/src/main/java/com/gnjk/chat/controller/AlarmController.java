package com.gnjk.chat.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gnjk.chat.domain.Alarm;
import com.gnjk.chat.service.AlarmService;

@Controller
public class AlarmController {

	@Autowired
	private AlarmService service;

	@GetMapping("/alarm/insert")
	@ResponseBody
	public void saveAlarm(Alarm alarmdata) throws Exception {

		service. insertAlarm(alarmdata);

	}
	
	@GetMapping(value = "/select")
	   @ResponseBody
	public void alarmList(Alarm alarm, Model model) throws Exception{

		List<Alarm> list = service.alarmList(alarm);
		model.addAttribute("list", list);

		System.out.println("알람 컨트롤러…");

	}
}