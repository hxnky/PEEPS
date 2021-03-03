package com.gnjk.post.guestbook.service;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.post.guestbook.dao.GuestbookDao;
import com.gnjk.post.guestbook.domain.GuestbookComment;
import com.gnjk.post.guestbook.domain.GuestbookCommentRequest;
@Service
public class GuestbookCommentService {
	
	public GuestbookDao dao;
	
	@Autowired
	private SqlSessionTemplate template;

	
	// 댓글 작성
		public int cmtInsert(GuestbookCommentRequest crequest) {

			dao = template.getMapper(GuestbookDao.class);

			int result = 0;

			GuestbookComment comment = crequest.GetCmt();

			result = dao.insertCmt(comment);

			return result;
		}
    //댓글 리스트 
		
		

}
