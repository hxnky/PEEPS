package com.gnjk.peeps.Member.Service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.peeps.Member.dao.MemberDao;

@Service
public class FollowService {

	@Autowired
	private SqlSessionTemplate template;

	private MemberDao dao;

	public int follow(int m_idx, int y_idx) {

		int f_result = 0;

		dao = template.getMapper(MemberDao.class);

		f_result = dao.insertFollow(m_idx, y_idx);

		return f_result;
	}

	public int unfollow(int m_idx, int y_idx) {

		int u_result = 0;

		dao = template.getMapper(MemberDao.class);

		u_result = dao.deleteFollow(m_idx, y_idx);

		return u_result;
	}

}
