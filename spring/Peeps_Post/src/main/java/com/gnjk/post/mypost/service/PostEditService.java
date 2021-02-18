package com.gnjk.post.mypost.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.gnjk.post.mypost.dao.FileDao;
import com.gnjk.post.mypost.dao.PostDao;
import com.gnjk.post.mypost.domain.Post;
import com.gnjk.post.mypost.domain.PostEditRequest;
import com.gnjk.post.mypost.domain.PostFile;
import com.gnjk.post.mypost.domain.PostReadView;

@Service
public class PostEditService {
	
	private PostDao dao;
	private FileDao fDao;
	
	@Autowired
	private SqlSessionTemplate template;
	
	public int editPost(
			PostEditRequest editRequest,
			HttpServletRequest request,
			Model model
			) {
		int postEditResult = 0;
		
		MultipartFile[] files = editRequest.getPostformfile();
		
		// DTO에 수정한 게시글 정보 저장
		Post post = editRequest.toPost();
		dao = template.getMapper(PostDao.class);
		postEditResult = dao.updatePost(post);
		
		
		
		return postEditResult;
	}

//	public PostReadView getPost(int pidx) {
//		
//		PostReadView editView = null;
//		
//		try {
//			// PostDao 구현체 생성
//			dao = template.getMapper(PostDao.class);
//			
//			System.out.println("게시글 번호: "+pidx);
//			
//			// 게시글 조회
//			Post postselectResult = dao.selectPostDetail(pidx);
//			System.out.println("게시글 조회 결과: "+postselectResult);
//			
//			// 게시글 파일 조회
//			List<PostFile> postfileList = dao.selectPostFileList(pidx);
//			System.out.println("게시글 파일 조회 결과 : "+postfileList);
//			
//			editView = new PostReadView(postselectResult, postfileList);
//					
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		
//		return editView;
//	}

	
	
}
