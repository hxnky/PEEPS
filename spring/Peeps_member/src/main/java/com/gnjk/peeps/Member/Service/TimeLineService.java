package com.gnjk.peeps.Member.Service;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.peeps.Member.dao.MemberDao;
import com.gnjk.peeps.Member.domain.Comment;
import com.gnjk.peeps.Member.domain.Post;

@Service
public class TimeLineService {

	private MemberDao dao;
	
	@Autowired
	private SqlSessionTemplate template;
	
	public List<Post> TimeLineList(int m_idx) {
		
		dao = template.getMapper(MemberDao.class);
		
		//1. 팔로잉 리스트 받기
		List<Integer> followList = dao.followingList(m_idx);
		
		List<Post> PostList = new ArrayList<>();
		
		for(int i = 0; i<followList.size(); i++) {
			// 포스트 리스트 받기
			PostList.addAll(dao.selectPostList(followList.get(i)));
		}
		
		return PostList;
	}

	// 댓글 상위 3개만 뽑아오기
	public List<Comment> CmtList(int post_idx) {
		
		dao = template.getMapper(MemberDao.class);
		
		List<Comment> cmtList = dao.selectCmtList(post_idx);
		
		return cmtList;
	}
	
}
