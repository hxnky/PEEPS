package com.gnjk.post.mypost.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.gnjk.post.mypost.domain.Comment;
import com.gnjk.post.mypost.domain.CommentListView;
import com.gnjk.post.mypost.domain.CommentRequest;
import com.gnjk.post.mypost.domain.Reply;
import com.gnjk.post.mypost.domain.ReplyRequest;
import com.gnjk.post.mypost.service.CommentService;
import com.gnjk.post.mypost.service.PostListService;
import com.gnjk.post.mypost.service.ReplyService;

@RestController
@RequestMapping("rest/cmt")
@CrossOrigin
public class CommentController {
	
	@Autowired
	private CommentService commentService;
	@Autowired
	private ReplyService replyService;
	
	@Autowired
	private PostListService listService;
	
	// 21.02.17 한경 댓글 관련 컨트롤러 추가
	// 21.02.24 정현 댓글 관련 컨트롤러 수정
//	// 댓글 목록 조회
//	@GetMapping(value = "/select")
//	public List<Comment> cmtList(int postIdx) {
//
//		System.out.println("댓글 리스트 출력");
//		System.out.println(postIdx);
//
//		return commentService.cmtSelect(postIdx);
//	}
	
	// 댓글 목록 조회
	@GetMapping(value = "/select")
	public CommentListView cmtList(int postIdx) {

		System.out.println("댓글 리스트 출력");
		System.out.println(postIdx);

		return commentService.cmtSelect(postIdx);
	}
	
	// 댓글 달기
	@PostMapping(value = "/insert")
	public int cmtInsert(@ModelAttribute("cmtData") CommentRequest request) {

		System.out.println("댓글 작성 진입");

		return commentService.cmtInsert(request);
	}

	// 댓글 수정
	@PostMapping(value = "/edit")
	public int cmtEdit(int cmt_idx, String cmt_content) {

		System.out.println("댓글 수정 진입");

		return commentService.cmtEdit(cmt_idx, cmt_content);
	}

	// 댓글 삭제
	@PostMapping(value = "/del")
	public int cmtDel(int cmt_idx) {

		System.out.println("댓글 삭제 진입");

		return commentService.cmtDel(cmt_idx);
	}

	// 대댓글 조회
	@GetMapping(value = "/reply/select")
	public List<Reply> reList(int cmt_idx) {

		System.out.println("대댓글 리스트 출력");

		return replyService.selectReList(cmt_idx);
	}
	
	// 대댓글 달기
	@PostMapping(value = "/reply/insert")
	public int cmtInsert(@ModelAttribute("reData") ReplyRequest request) {

		System.out.println("대댓글 작성 진입");
		
		return replyService.InsertReply(request);
	}

	// 대댓글 수정
	@PostMapping(value = "/reply/edit")
	public int EditReply(int re_idx, String re_content) {

		System.out.println("대댓글 수정 진입");

		return replyService.EditReply(re_idx, re_content);
	}

	// 대댓글 삭제
	@PostMapping(value = "/reply/del")
	public int DelReply(int re_idx) {

		System.out.println("대댓글 삭제 진입");

		return replyService.DelReply(re_idx);
	}
	
	
	

}
