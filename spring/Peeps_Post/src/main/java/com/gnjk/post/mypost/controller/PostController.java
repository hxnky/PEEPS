package com.gnjk.post.mypost.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gnjk.post.mypost.domain.Comment;
import com.gnjk.post.mypost.domain.CommentRequest;
import com.gnjk.post.mypost.domain.PostWriteRequest;
import com.gnjk.post.mypost.domain.Reply;
import com.gnjk.post.mypost.domain.ReplyRequest;
import com.gnjk.post.mypost.service.CommentService;
import com.gnjk.post.mypost.service.PostDeleteService;
import com.gnjk.post.mypost.service.PostEditService;
import com.gnjk.post.mypost.service.PostListService;
import com.gnjk.post.mypost.service.PostReadService;
import com.gnjk.post.mypost.service.PostWriteService;
import com.gnjk.post.mypost.service.ReplyService;

@Controller
@RequestMapping("/post")
public class PostController {

	@Autowired
	private PostWriteService writeService;

	@Autowired
	private PostListService listService;

	@Autowired
	private PostReadService readService;

	@Autowired
	private PostDeleteService deleteService;

	@Autowired
	private PostEditService editService;

	@Autowired
	private CommentService commentService;

	@Autowired
	private ReplyService replyService;

	// 테스트 페이지
	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public String testtPage() {
		return "/mypost/test";
	}

	// 게시글 페이지
	@RequestMapping(method = RequestMethod.GET)
	public String postPage() {
		return "/mypost/mypostpage";
	}

	// 게시글 작성 페이지
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public String postWriteGET(HttpSession session) {

		session.setAttribute("m_idx", 155);

		return "/mypost/postWriteForm";
	}

	// 게시글 등록 처리
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String postWritePOST(@ModelAttribute("writeData") PostWriteRequest writeRequest,
//			HttpServletRequest request,
			MultipartHttpServletRequest request, Model model) {

		System.out.println(writeRequest);
		int result = writeService.postWrite(writeRequest, request);

		model.addAttribute("result", result);

		/* return "/mypost/postWriteView"; */
		return "redirect:/post/list";
	}

	// 게시글 목록페이지
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String postList(@RequestParam(value = "p", defaultValue = "1") int page, Model model, HttpSession session) {

		model.addAttribute("listView", listService.getPostListView(page, session));

		return "/mypost/postList";
	}

	// TEST게시글 보기 페이지
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public String postRead() {

		return "/mypost/postRead";
	}

	// 게시글 조회
	@RequestMapping(value = "/postNO={p_idx}", method = RequestMethod.GET)
	public String postReadGET(@PathVariable("p_idx") int postidx, Model model) {
//		System.out.println("글 번호 : "+postidx);

		// 21.02.17 한경 댓글 수 조회 추가
		model.addAttribute("CountCmt", commentService.CountCmt(postidx));

		model.addAttribute("readView", readService.getPostReadView(postidx));

		return "/mypost/postRead";
	}

	// 게시글 수정페이지
	@RequestMapping(value = "/editPNO={p_idx}", method = RequestMethod.GET)
	public String postEditForm(@PathVariable("p_idx") int pidx, Model model) {

		model.addAttribute("editView", editService.getPost(pidx));

		return "/mypost/postEditForm";
	}

	// 게시글 수정처리

	// 게시글 삭제처리
	@RequestMapping(value = "/deletePNO={pidx}", method = RequestMethod.GET)
	public String deletePost(@PathVariable("pidx") int pidx, Model model) {
//		System.out.println("글 번호 : "+pidx);

		model.addAttribute("result", deleteService.deletePost(pidx));

		return "redirect:/post/list";
	}

	// 21.02.17 한경 댓글 관련 컨트롤러 추가
	// 댓글 목록 조회
	@GetMapping(value = "/cmt/select")
	@ResponseBody
	public List<Comment> cmtList(int post_idx) {

		System.out.println("댓글 리스트 출력");

		return commentService.cmtSelect(post_idx);
	}

	// 댓글 달기
	@PostMapping(value = "/cmt/insert")
	@ResponseBody
	public int cmtInsert(@ModelAttribute("cmtData") CommentRequest request) {

		System.out.println("댓글 작성 진입");

		return commentService.cmtInsert(request);
	}

	// 댓글 수정
	@PostMapping(value = "/cmt/edit")
	@ResponseBody
	public int cmtEdit(int post_idx, int idx, String cmt_content) {

		System.out.println("댓글 수정 진입");

		return commentService.cmtEdit(post_idx, idx, cmt_content);
	}

	// 댓글 삭제
	@PostMapping(value = "/cmt/del")
	@ResponseBody
	public int cmtDel(int post_idx, int idx) {

		System.out.println("댓글 삭제 진입");

		return commentService.cmtDel(idx, post_idx);
	}

	// 대댓글 조회
	@GetMapping(value = "/reply/select")
	@ResponseBody
	public List<Reply> reList(int cmt_idx) {

		System.out.println("대댓글 리스트 출력");

		return replyService.selectReList(cmt_idx);
	}
	
	// cmt_idx 찾기
	@PostMapping(value="/find/idx")
	@ResponseBody
	public int findIdx(int post_idx, int idx, Model model) {
		
		System.out.println("cmt_idx 찾기");
		
		int cmt_idx = commentService.findCmt_idx(post_idx, idx);
		
		model.addAttribute("cmtIdx", cmt_idx);
		
		return cmt_idx;
	}

	// 대댓글 달기
	@PostMapping(value = "/reply/insert")
	@ResponseBody
	public int cmtInsert(@ModelAttribute("reData") ReplyRequest request) {

		System.out.println("대댓글 작성 진입");
		
		return replyService.InsertReply(request);
	}

	// 댓글 수정
	@PostMapping(value = "/reply/edit")
	@ResponseBody
	public int EditReply(int comment_idx, int idx, String re_content) {

		System.out.println("대댓글 수정 진입");

		return replyService.EditReply(comment_idx, idx, re_content);
	}

	// 댓글 삭제
	@PostMapping(value = "/reply/del")
	@ResponseBody
	public int DelReply(int comment_idx, int idx) {

		System.out.println("대댓글 삭제 진입");

		return replyService.DelReply(idx, comment_idx);
	}

}
