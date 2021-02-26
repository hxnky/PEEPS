package com.gnjk.peeps.Member.Service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.peeps.Member.dao.MemberDao;
import com.gnjk.peeps.Member.domain.FollowRequest;

@Service
public class TimeLineService {

	private MemberDao dao;

	@Autowired
	private SqlSessionTemplate template;

	public List<Integer> FollowingList(int m_idx) {
		
		dao = template.getMapper(MemberDao.class);
		
		List<Integer> FollowingList = dao.followingList(m_idx);
		
		return FollowingList;
	}

	public List<FollowRequest> FollowingInfo(int m_idx) {
		
		dao = template.getMapper(MemberDao.class);
		
		return dao.selectMemberByIdx(m_idx);
	}

}
