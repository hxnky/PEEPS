package com.gnjk.peeps.guestbook;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.gnjk.peeps.guestbook.domain.GuestbookListView;
import com.gnjk.peeps.guestbook.domain.SearchParam;
import com.gnjk.peeps.guestbook.service.GuestbookListService;

@Controller
public class GuestbookListController {

	@Autowired
	private GuestbookListService listService;
	
	@RequestMapping("guestbook/list")
	public String guestbookList(SearchParam param,Model model) {
	
		System.out.println("검색 :"+param);
		//GuestbookListView listView =listService.getListView(page);
		//System.out.println(listView);
		model.addAttribute("listView",listService.getListView(param));
		return "/menu/list";
	}
}

