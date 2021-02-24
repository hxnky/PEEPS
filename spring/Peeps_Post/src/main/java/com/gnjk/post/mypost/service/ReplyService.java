package com.gnjk.post.mypost.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.post.mypost.dao.CommentDao;
import com.gnjk.post.mypost.dao.PostDao;
import com.gnjk.post.mypost.domain.Reply;
import com.gnjk.post.mypost.domain.ReplyRequest;

@Service
public class ReplyService {

	private CommentDao dao;

	@Autowired
	private SqlSessionTemplate template;

	// 대댓글 조회
	// 인덱스로 아이디 검사해서 list.add
	public List<Reply> selectReList(int cmt_idx) {

		dao = template.getMapper(CommentDao.class);

		return dao.selectReList(cmt_idx);
	}

	// 대댓글 작성
	public int InsertReply(ReplyRequest request) {

		dao = template.getMapper(CommentDao.class);

		int result = 0;

		Reply reply = request.GetRe();

		result = dao.insertReply(reply);

		return result;
	}

	// 대댓글 수정
	public int EditReply(int re_idx, String re_content) {

		dao = template.getMapper(CommentDao.class);
		
		int result = 0;
		
		System.out.println(re_idx);

		System.out.println("댓글 수정 : " + re_content);

		result = dao.updateReply(re_idx, re_content);

		return result;
	}

	// 대댓글 삭제
	public int DelReply(int re_idx) {

		dao = template.getMapper(CommentDao.class);

		int result = 0;

		result = dao.deleteReply(re_idx);

		return result;
	}

}
