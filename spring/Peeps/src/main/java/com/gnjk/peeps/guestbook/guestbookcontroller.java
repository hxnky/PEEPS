package com.gnjk.peeps.guestbook;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gnjk.peeps.guestbook.domain.GuestbookRequest;
import com.gnjk.peeps.guestbook.service.GuestbookInsertService;

@Controller
@RequestMapping("/guestbook")
public class guestbookcontroller {

	final String URI = "/guestbookfile";

	@Autowired
	private GuestbookInsertService insertService;

	@RequestMapping(method = RequestMethod.GET)
	public String guestbookForm() {

		return "/menu/guestbookForm";

	}

	/* HttpServletRequest request */
	@RequestMapping(method = RequestMethod.POST)
	public String guestbookComplete(@ModelAttribute("insertdata") GuestbookRequest gRequest, HttpServletRequest request,
			Model model) throws IllegalStateException, IOException {

		System.out.println("확인용" + gRequest);
		System.out.println("획인용2" + gRequest.getGphoto().getOriginalFilename());

		int result = insertService.guestbook(gRequest, request);

		model.addAttribute("result", result);
		// 사진도 받아서 출력하기
		model.addAttribute("reportFile", gRequest.getGphoto().getOriginalFilename());

		gRequest.getGphoto().transferTo(getFile(request, URI, gRequest.getGphoto().getOriginalFilename()));

		 insertService.guestbook(gRequest, request);

		return "/menu/guestbookComplete";
	}

	
	  // File uploadfile에 넣어줌 생성해서 반환
	  
	  private File getFile( HttpServletRequest request, String uri, String
	  fileName) {
	  
	  return new File(request.getSession().getServletContext().getRealPath(uri), fileName); }
	 

}
