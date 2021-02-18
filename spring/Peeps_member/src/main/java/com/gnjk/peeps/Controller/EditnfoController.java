package com.gnjk.peeps.Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gnjk.peeps.Service.EditInfoService;
import com.gnjk.peeps.domain.EditRequest;

@Controller
public class EditnfoController {

	@Autowired
	private EditInfoService editService;

	// 프로필 편집 진입 시 소셜회원의 정보도 얻기 위해
	@GetMapping("/profile/chk")
	@ResponseBody
	public int editUserInfoPage(String email, HttpSession session) {

		return editService.getPeeps(email, session);
	}

	// 프로필 편집 페이지
	@GetMapping("/profile/Info")
	public String EditPage() {

		return "/member/profile_edit";
	}

	// 프로필 편집
	@PostMapping("/profile/edit")
	@ResponseBody
	public int editUserInfo(EditRequest editRequest, HttpServletRequest request, HttpSession session) {

		System.out.println("프로필 편집");

		return editService.editPeeps(editRequest, request, session);

	}

	// 프로필 편집
//	@PostMapping("/profile/edit")
//	@ResponseBody
//	public int editUserInfo(String email, String id, String name, String bio, String m_photo, String oidPhoto) {
//
//		System.out.println("프로필 편집");
//
//		return 0;
//
//	}

}
