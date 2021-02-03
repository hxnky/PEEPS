package com.gnjk.post.mypost.service;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.post.mypost.dao.PostDao;
import com.gnjk.post.mypost.domain.Post;
import com.gnjk.post.mypost.domain.PostWriteRequest;

@Service
public class PostWriteService {

	private PostDao dao;
	
	@Autowired
	private SqlSessionTemplate template;
	
	// 데이터베이스 저장
	// ##파일 업로드 미구현
	public int postWrite(PostWriteRequest writeRequest, HttpServletRequest request) {
		
		int result = 0;
		
		Post post = writeRequest.toPost();
		
		try {
		// 데이터베이스 입력
		dao = template.getMapper(PostDao.class);
		
		// 게시글 DB insert
		result = dao.insertPost(post);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("!!! 데이터베이스 연결 에러 !!!");
		}
		
		return result;
	}
	
}
