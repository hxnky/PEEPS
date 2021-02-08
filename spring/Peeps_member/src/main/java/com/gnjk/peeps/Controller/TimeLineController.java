package com.gnjk.peeps.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class TimeLineController {
	
	@RequestMapping(value = "/TimeLine", method = RequestMethod.GET)
	public String Timeline() {
		
		return "member/TimeLine";
	}

//	@RequestMapping(value = "/user/chk", method = RequestMethod.POST)
//	public String Timeline(HttpServletRequest request, Model model) {
//
//		String email = request.getParameter("email");
//		String name = request.getParameter("name");
//		String m_photo = request.getParameter("m_photo");
//
//		model.addAttribute("email", email);
//		model.addAttribute("name", name);
//		model.addAttribute("m_photo", m_photo);
//		
//		System.out.println("타임라인 컨트롤러");
//		System.out.println("이메일 : " + email);
//		System.out.println("이름 : " + name);
//		System.out.println("사진 : " + m_photo);
//
//		return "member/TimeLine";
//	}


}
