package com.gnjk.peeps.Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.gnjk.peeps.Service.EditInfoService;
import com.gnjk.peeps.domain.EditRequest;

@Controller
public class EditnfoController {

	final String URI = "/fileupload/member";

	@Autowired
	private EditInfoService editService;

	@RequestMapping(value = "/profile/Info", method = RequestMethod.GET)
	public String editUserInfoPage(@RequestParam("email") String email, Model model, HttpSession session) {

		int result = 2;
		
		model.addAttribute("peeps", editService.getPeeps(email, session));
		model.addAttribute("result", result);

		return "member/profile_edit";
	}

	@RequestMapping(value = "/profile/Info", method = RequestMethod.POST)
	public String editUserInfo(EditRequest editRequest, HttpServletRequest request, Model model) {

		model.addAttribute("result", editService.editPeeps(editRequest, request));

		return "member/profile_edit";

	}

}
