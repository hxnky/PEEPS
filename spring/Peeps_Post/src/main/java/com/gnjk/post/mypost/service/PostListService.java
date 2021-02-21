package com.gnjk.post.mypost.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.post.mypost.dao.FileDao;
import com.gnjk.post.mypost.dao.PostDao;
import com.gnjk.post.mypost.domain.Post;
import com.gnjk.post.mypost.domain.PostFile;
import com.gnjk.post.mypost.domain.PostListView;

@Service
public class PostListService {
	
	private PostDao dao;
	private FileDao fDao;
	
	@Autowired
	private SqlSessionTemplate template;
	
	// 게시글 전체 리스트 불러오기
	public PostListView getPostListView(int pageNumber) {
		
		// test용 로그인 정보
		int member_idx = 1;
		
		PostListView listView = null;
		
		try {
			// PostDao 구현체 생성
			dao = template.getMapper(PostDao.class);
			
			System.out.println("pageNumber : " + pageNumber);
			
			int cntPerPage = 9;
			
			int startRow = (pageNumber-1)*cntPerPage;
			int endRow = startRow+cntPerPage-1;
			
			int totalPostCount = dao.selectTotalPostCount(member_idx);
			
			System.out.println("postTotalCount : "+ totalPostCount);
			
			List<Post> postList = dao.selectPostList(member_idx, startRow, cntPerPage);
			System.out.println(postList);
			
			listView = new PostListView(pageNumber, totalPostCount, cntPerPage, postList, startRow, endRow);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return listView;
	}
	
	// 게시글 하나 내용 불러오기
	public Post getDetail(int idx) {
		
		dao = template.getMapper(PostDao.class);
		
		return dao.selectPostDetail(idx);
	}
	
	// 게시글 하나 이미지 불러오기
	public List<PostFile> getDetailImgs(int idx){
		fDao = template.getMapper(FileDao.class);
		return fDao.selectPostImgs(idx);
	}

}
