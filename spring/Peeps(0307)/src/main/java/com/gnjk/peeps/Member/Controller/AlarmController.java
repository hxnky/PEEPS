package com.gnjk.peeps.Member.Controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.gnjk.peeps.Member.Service.AlarmListService;
import com.gnjk.peeps.Member.Service.DeleteService;
import com.gnjk.peeps.Member.domain.Alarm;

@RestController
@CrossOrigin("*")
public class AlarmController {

	@Autowired
	private AlarmListService service;

	@Autowired
	private DeleteService dservice;

	@RequestMapping(value = "/alarm/select")
	public List<Alarm> alarmList(Alarm alarm, HttpSession session) throws Exception{
		session.setAttribute("list", service.alarmList(alarm));

		System.out.println("알람 컨트롤러…");

		System.out.println(service.alarmList(alarm));

		return  service.alarmList(alarm);
		
	}

	@RequestMapping(value = "/alarm/delete")
	public int deleteAl(@RequestParam("me_idx")int me_idx, Alarm alarm, HttpSession session) throws Exception {

		session.setAttribute("delAl", dservice.deleteAlarm(alarm.getAl_idx()));

		System.out.println("알람 삭제 컨트롤러.....");

		return dservice.deleteAlarm(alarm.getAl_idx());

	}
}