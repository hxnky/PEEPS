package com.gnjk.peeps.guestbook;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.gnjk.peeps.guestbook.domain.Guestbook;
import com.gnjk.peeps.guestbook.service.GuestbookListService;
import com.gnjk.peeps.guestbook.service.GuestbookRestService;

@RestController
@RequestMapping("/rest/guestbook")
public class GuestbookRestApiController {
	@Autowired
	private GuestbookRestService restService;
	@Autowired
	private GuestbookListService listService;
	
	/* 게스트북 리스트 출력 */
	@GetMapping
	public List<Guestbook> getGuestbookList(){	
		return listService.getGbookList();
	}

	/* 게스트북 idx뽑기 */
	@GetMapping("/{gidx}")
	public Guestbook getGuestbookInfo(@PathVariable("gidx") int gidx) {
		return restService.getGuestbook(gidx);
		
	}
	
	
}
