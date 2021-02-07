package com.gnjk.peeps.Controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.gnjk.peeps.Service.EditInfoService;
import com.gnjk.peeps.domain.EditRequest;

@Controller
@RequestMapping("/profile/Info")
public class EditnfoController {

	@Autowired
	private EditInfoService editService;

	@RequestMapping(method = RequestMethod.GET)
	public String editUserInfoPage(@RequestParam("email") String email, Model model) {

		model.addAttribute("peeps", editService.getPeeps(email));

		return "member/profile_edit";
	}

	@RequestMapping(method = RequestMethod.POST)
	public String editUserInfo(EditRequest editRequest, HttpServletRequest request, Model model,
			HttpServletResponse response) throws IOException {

		PrintWriter out = response.getWriter();

		model.addAttribute("result", editService.editPeeps(editRequest, request));

		out.print("정보가 수정되었습니다.");

		return "member/TimeLine";

	}

}
