package com.gnjk.peeps.Controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gnjk.peeps.Service.DeleteService;
import com.gnjk.peeps.domain.Peeps;

@Controller
public class DeleteController {
	
	@Autowired
	private DeleteService deleteService;

	@GetMapping("/profile/delete")
	public String DeletePage(Model model) {
		
		int result = 2;
		
		model.addAttribute("result", result);
		
		return "member/profile_del";
	}
	
	@PostMapping("/user/del")
	@ResponseBody
	public int EditPwPost(HttpServletResponse response, String email, String password, int m_idx, HttpSession session) throws IOException{
		
		session.invalidate();
		
		return deleteService.Delete(email, password, m_idx);
	}
}
