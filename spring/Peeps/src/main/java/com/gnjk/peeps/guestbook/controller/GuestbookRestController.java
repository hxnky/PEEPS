package com.gnjk.peeps.guestbook.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.gnjk.peeps.guestbook.domain.Guestbook;
import com.gnjk.peeps.guestbook.domain.GuestbookCommentRequest;
import com.gnjk.peeps.guestbook.domain.GuestbookEditRequest;
import com.gnjk.peeps.guestbook.domain.GuestbookListView;
import com.gnjk.peeps.guestbook.domain.GuestbookRequest;
import com.gnjk.peeps.guestbook.service.GuestbookCommentService;
import com.gnjk.peeps.guestbook.service.GuestbookDeleteService;
import com.gnjk.peeps.guestbook.service.GuestbookEditService;
import com.gnjk.peeps.guestbook.service.GuestbookInsertService;
import com.gnjk.peeps.guestbook.service.GuestbookListService;
import com.gnjk.peeps.guestbook.service.GuestbookRestService;

@RestController
@RequestMapping("/rest/guestbook")
public class GuestbookRestController {
	
	@Autowired
	private GuestbookRestService restService;
	@Autowired
	private GuestbookListService listService;
	@Autowired
	private GuestbookInsertService insertService;
	@Autowired
	private GuestbookDeleteService deleteService;
	@Autowired
	private GuestbookEditService editService;
	@Autowired
	private GuestbookCommentService commentService;
	
	
	

	
	
	// LIST
	@GetMapping
	public GuestbookListView getlistview(@RequestParam(value = "p",defaultValue ="1")int page,Model model){
		return listService.getListView(page);
	}
	
	// 1개의 방명록 정보
	@GetMapping("/{gidx}")
	public Guestbook getGuestbookInfo(@PathVariable("gidx") int gidx) {
		return restService.getGuestbook(gidx);
	}
	
	//방명록 정보 저장 
		@PostMapping("/upload")
		@ResponseBody
		public int guestbookComplete( GuestbookRequest gRequest, HttpServletRequest request,
				Model model) {
			
			return insertService.guestbook(gRequest, request);
		}
	
    //방명록 수정 업데이트
	
		@PostMapping("/edit")
		@ResponseBody
		public int updateGuestbook(GuestbookEditRequest editRequest, HttpServletRequest request) {	
		
			return editService.editGuestbook(editRequest, request) ;
		}
		
	
	//방명록 삭제
	/* guestbook 삭제서비스 */
	@RequestMapping("/delete")
	@ResponseBody
	public int deleteMsg(@RequestParam("gidx") int gidx) {
					
			return deleteService.deleteMsg(gidx);
		}
	
	
	 //댓글 달기
	
	 @PostMapping(value = "/cmt/insert")
	  @ResponseBody public int cmtInsert(@ModelAttribute("cmtData")
	  GuestbookCommentRequest request) {
	  
	  System.out.println("댓글 작성 진입");
	  
	  return commentService.cmtInsert(request); }
	 
	
	
	
	
	

	}
