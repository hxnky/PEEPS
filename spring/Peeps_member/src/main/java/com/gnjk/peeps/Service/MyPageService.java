package com.gnjk.peeps.Service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.peeps.dao.FollowDao;
import com.gnjk.peeps.dao.PeepsDao;
import com.gnjk.peeps.domain.Peeps;

@Service
public class MyPageService {

	private PeepsDao dao;
	private FollowDao f_dao;

	@Autowired
	private SqlSessionTemplate template;

	// idx 로 바꾸기
	public Peeps getPeeps(int m_idx, HttpSession session) {

		dao = template.getMapper(PeepsDao.class);

		Peeps peeps = dao.selectMemberByIdx(m_idx);
		
		session.setAttribute("page_peeps", peeps);

		return peeps;
	}

	public boolean chk_follow(int idx, int m_idx) {
		
		f_dao = template.getMapper(FollowDao.class);
		
		boolean follow_chk = false;
		
		if(f_dao.CheckFollow(m_idx, idx)==1) {
			follow_chk = true;
		}
			
		return follow_chk;
	}
	
	// 팔로워 수
	public int getFollower(int m_idx, HttpSession session) {

		f_dao = template.getMapper(FollowDao.class);

		int follower = f_dao.FollowerCnt(m_idx);

		session.setAttribute("follower", follower);

		System.out.println(follower);

		return follower;

	}

	// 팔로잉 수
	public int getFollowing(int m_idx, HttpSession session) {

		f_dao = template.getMapper(FollowDao.class);

		int following = f_dao.FollowingCnt(m_idx);

		System.out.println(following);

		session.setAttribute("following", following);

		return following;

	}
	
	// 팔로우
	public int Follow(int m_idx, int y_idx) {
		
		f_dao = template.getMapper(FollowDao.class);
		
		return f_dao.insertFollow(m_idx, y_idx);
	}
	
	// 언팔로우
	public int unFollow(int m_idx, int y_idx) {
		
		f_dao = template.getMapper(FollowDao.class);
		
		return f_dao.deleteFollow(m_idx, y_idx);
	}


	// 팔로워 인덱스 가져와서 ListPeeps 하기
	public List<Peeps> getFollowingList(int m_idx, HttpSession session) {

		f_dao = template.getMapper(FollowDao.class);
		dao = template.getMapper(PeepsDao.class);
		
		int following = f_dao.FollowingCnt(m_idx);

		session.setAttribute("following", following);
		
		// 인덱스 가져오기
		List<Integer> following_peeps = f_dao.followingList(m_idx);

		List<Peeps> followingList = new ArrayList<Peeps>();

		System.out.println(following_peeps);

		System.out.println(following_peeps.size());

		for (int i = 0; i < following_peeps.size(); i++) {

			int f_idx = following_peeps.get(i);

			System.out.println(f_idx);

			followingList.add(dao.selectMemberByIdx(f_idx));

			int chk_result = f_dao.CheckFollow(m_idx, f_idx);

			followingList.get(i).setChk_result(chk_result);

			System.out.println(followingList);
		}

		System.out.println("팔로잉 목록 : " + followingList);

		return followingList;
	}

	// 팔로우 인덱스 가져와서 ListPeeps 하기
	public List<Peeps> getFollowerList(int m_idx, HttpSession session) {

		f_dao = template.getMapper(FollowDao.class);
		dao = template.getMapper(PeepsDao.class);
		
		int follower = f_dao.FollowerCnt(m_idx);
		session.setAttribute("follower", follower);
		
		List<Integer> follower_peeps = f_dao.followerList(m_idx);
		List<Peeps> followerList = new ArrayList<Peeps>();

		System.out.println(follower_peeps);

		for (int i = 0; i < follower_peeps.size(); i++) {

			int f_idx = follower_peeps.get(i);

			System.out.println(f_idx);

			followerList.add(dao.selectMemberByIdx(f_idx));
			
			int chk_result = f_dao.CheckFollow(m_idx, f_idx);

			followerList.get(i).setChk_result(chk_result);

			System.out.println("팔로워 목록 : " + followerList);

		}

		return followerList;
	}
	
	
	
	
}
