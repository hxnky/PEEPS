package com.gnjk.peeps.Member.Service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.peeps.Member.dao.MemberDao;
import com.gnjk.peeps.Member.domain.CommentRequest;
import com.gnjk.peeps.Member.domain.PostRequest;

@Service
public class TimeLineService {

	private MemberDao dao;

	@Autowired
	private SqlSessionTemplate template;

	public List<PostRequest> TimeLineList(int m_idx) {

		dao = template.getMapper(MemberDao.class);

		// 1. 팔로잉 리스트 받기
		List<Integer> followList = dao.followingList(m_idx);

		List<PostRequest> PostList = new ArrayList<>();
		List<PostRequest> UserList = new ArrayList<>();
		
		// 포스트 리스트 받기
		for (int i = 0; i < followList.size(); i++) {
			
			PostList.addAll(dao.selectPostList(followList.get(i)));
			
		}

		// 포스트 리스트에 회원 사진과 로그인 타입 추가
		for (int i = 0; i < PostList.size(); i++) {
			
			int u_idx = PostList.get(i).getMember_idx();
			
			System.out.println(u_idx);
			UserList.addAll(dao.selectPostUserList(u_idx));

			PostList.get(i).setM_photo(UserList.get(i).getM_photo());
			PostList.get(i).setLoginType(UserList.get(i).getLoginType());
			PostList.get(i).setId(UserList.get(i).getId());
		}
		
		System.out.println(PostList);

		return PostList;
	}

	// 댓글 상위 3개만 뽑아오기
	public List<CommentRequest> CmtList(int post_idx) {

		dao = template.getMapper(MemberDao.class);
		
		List<CommentRequest> cmtList = dao.selectCmtList(post_idx);
		List<CommentRequest> UserList = new ArrayList<>();

		// 댓글
		for(int i = 0; i<cmtList.size(); i++) {
			
			int u_idx = cmtList.get(i).getMember_idx();
			
			UserList.addAll(dao.selectCmtUserList(u_idx));
			
			cmtList.get(i).setM_photo(UserList.get(i).getM_photo());
			cmtList.get(i).setLoginType(UserList.get(i).getLoginType());
			cmtList.get(i).setId(UserList.get(i).getId());
			
		}
		
		System.out.println(cmtList);
		
		
		return cmtList;
	}

	// 게시물 검색
	public List<PostRequest> PostList(String keyword) {
		
		dao = template.getMapper(MemberDao.class);
		
		List<PostRequest> PostList = dao.FindPostList(keyword);
		List<PostRequest> UserList = new ArrayList<>();
		
		for(int i = 0; i<PostList.size(); i++) {
			int u_idx = PostList.get(i).getMember_idx();
			
			System.out.println(u_idx);
			UserList.addAll(dao.selectPostUserList(u_idx));

			PostList.get(i).setM_photo(UserList.get(i).getM_photo());
			PostList.get(i).setLoginType(UserList.get(i).getLoginType());
			PostList.get(i).setId(UserList.get(i).getId());
		}
		
		System.out.println(PostList);
		
		return PostList;
	}

}
