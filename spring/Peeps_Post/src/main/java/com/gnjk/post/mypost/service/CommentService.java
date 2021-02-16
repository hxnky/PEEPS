package com.gnjk.post.mypost.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.post.mypost.dao.PostDao;
import com.gnjk.post.mypost.domain.Comment;
import com.gnjk.post.mypost.domain.CommentRequest;

@Service
public class CommentService {
	
	private PostDao dao;
	
	@Autowired
	private SqlSessionTemplate template;
	
	public List<Comment> cmtSelect(int post_idx){
		
		dao = template.getMapper(PostDao.class);
		
		return dao.selectCmtList(post_idx);
	}

	public int cmtInsert(CommentRequest request) {
		
		dao = template.getMapper(PostDao.class);
		
		int result = 0;
		
		Comment comment = request.GetCmt();
		
		result = dao.insertCmt(comment);
		
		int post_idx = comment.getPost_idx();
		
		return result;
	}

	public int cmtEdit(int cmt_idx, String cmt_content) {
		
		dao = template.getMapper(PostDao.class);
		
		int result = 0;
		
		result = dao.updateCmt(cmt_idx, cmt_content);
		
		return result;
	}
	
}
