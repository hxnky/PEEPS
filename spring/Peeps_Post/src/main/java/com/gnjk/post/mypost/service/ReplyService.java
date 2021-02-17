package com.gnjk.post.mypost.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.post.mypost.dao.PostDao;
import com.gnjk.post.mypost.domain.Reply;
import com.gnjk.post.mypost.domain.ReplyRequest;

@Service
public class ReplyService {

	private PostDao dao;

	@Autowired
	private SqlSessionTemplate template;

	// 대댓글 조회
	// 인덱스로 아이디 검사해서 list.add
	public List<Reply> selectReList(int cmt_idx) {

		dao = template.getMapper(PostDao.class);

		return dao.selectReList(cmt_idx);
	}

	// 대댓글 작성
	public int InsertReply(ReplyRequest request) {

		dao = template.getMapper(PostDao.class);

		int result = 0;

		Reply reply = request.GetRe();

		result = dao.insertReply(reply);

		return result;
	}

	// 대댓글 수정
	public int EditReply(int cmt_idx, int idx, String re_content) {

		dao = template.getMapper(PostDao.class);

		int result = 0;

		List<Reply> reply = dao.selectReList(cmt_idx);

		int re_idx = reply.get(idx).getRe_idx();

		System.out.println("댓글 수정 : " + re_content);

		result = dao.updateReply(re_idx, re_content);

		return result;
	}

	// 대댓글 삭제
	public int DelReply(int idx, int cmt_idx) {

		dao = template.getMapper(PostDao.class);

		int result = 0;

		List<Reply> reply = dao.selectReList(cmt_idx);


		int re_idx = reply.get(idx).getRe_idx();

		result = dao.deleteReply(re_idx);

		return result;
	}

}
