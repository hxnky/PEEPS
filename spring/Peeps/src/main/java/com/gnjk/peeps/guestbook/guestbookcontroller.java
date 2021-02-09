package com.gnjk.peeps.guestbook;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gnjk.peeps.guestbook.domain.Guestbook;
import com.gnjk.peeps.guestbook.domain.GuestbookRequest;
import com.gnjk.peeps.guestbook.service.GuestbookInsertService;

@Controller
@RequestMapping("/guestbook")
public class guestbookcontroller {

	@Autowired
	private GuestbookInsertService insertService;

	@RequestMapping(method = RequestMethod.GET)
	public String guestbookForm() {

		return "/menu/guestbookForm";

	}


	@RequestMapping(method = RequestMethod.POST)
	public String guestbookComplete(@ModelAttribute("insertdata") GuestbookRequest gRequest, HttpServletRequest request,
			Model model) throws IllegalStateException, IOException {

		System.out.println("확인용" + gRequest);
		

		
		
	
		
      //session.setAttribute("gwriter", gRequest);
       
       
       int result = insertService.guestbook(gRequest, request);
       
       
       
		 model.addAttribute("result", result);

		

		


		return "/menu/guestbookForm";
	}

	
	

}
