package com.gnjk.peeps.guestbook;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ViewController {
	
	// 방명록 수정  폼 2021.2.19 남서아 수정  
		@PostMapping("main/edit")
		public String editForm(@RequestParam("gidx") int gidx) {
			return "menu/editForm";
		}

}
