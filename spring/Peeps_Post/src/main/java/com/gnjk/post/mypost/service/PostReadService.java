package com.gnjk.post.mypost.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.post.mypost.dao.PostDao;
import com.gnjk.post.mypost.domain.Post;
import com.gnjk.post.mypost.domain.PostFile;
import com.gnjk.post.mypost.domain.PostReadView;

@Service
public class PostReadService {
	
	private PostDao dao;
	
	@Autowired
	private SqlSessionTemplate template;
	
	public PostReadView getPostReadView(int p_idx) {
		
		PostReadView readView = null;
		
		try {
			// PostDao 구현체 생성
			dao = template.getMapper(PostDao.class);
			
			System.out.println("게시글 번호: "+p_idx);
			
			// 게시글 조회
			Post postselectResult = dao.selectPostDetail(p_idx);
			System.out.println("게시글 조회 결과: "+postselectResult);
			
			// 게시글 파일 조회
			List<PostFile> postfileList = dao.selectPostFileList(p_idx);
			System.out.println("게시글 파일 조회 결과 : "+postfileList);
			
			readView = new PostReadView(postselectResult, postfileList);
					
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return readView;
	}

}
