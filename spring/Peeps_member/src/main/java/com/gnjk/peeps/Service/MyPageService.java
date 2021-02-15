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

	public Peeps getPeeps(String email, HttpSession session) {

		dao = template.getMapper(PeepsDao.class);

		Peeps peeps = dao.selectMemberByEmail(email);
		session.setAttribute("peeps", peeps);
		session.setAttribute("m_idx", new Integer(peeps.getM_idx()));
		session.setAttribute("email", peeps.getEmail());
		session.setAttribute("id", peeps.getId());
		session.setAttribute("loginType", peeps.getLoginType());
		session.setAttribute("name", peeps.getName());

		return peeps;
	}

	public int getFollower(int m_idx, HttpSession session) {

		f_dao = template.getMapper(FollowDao.class);

		int follower = f_dao.FollowerCnt(m_idx);

		session.setAttribute("follower", follower);

		System.out.println(follower);

		return follower;

	}

	public int getFollowing(int m_idx, HttpSession session) {

		f_dao = template.getMapper(FollowDao.class);

		int following = f_dao.FollowingCnt(m_idx);

		System.out.println(following);

		session.setAttribute("following", following);

		return following;

	}

	// 팔로워 인덱스 가져와서 ListPeeps 하기
	public List<Peeps> getFollowingList(int m_idx) {

		f_dao = template.getMapper(FollowDao.class);
		dao = template.getMapper(PeepsDao.class);

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
	public List<Peeps> getFollowerList(int m_idx) {

		f_dao = template.getMapper(FollowDao.class);
		dao = template.getMapper(PeepsDao.class);

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

	// 팔로우
	public int My_follow(int m_idx, int y_idx, HttpSession session) {

		int f_result = 0;

		f_dao = template.getMapper(FollowDao.class);

		f_result = f_dao.insertFollow(m_idx, y_idx);

		List<Peeps> followerList = (List<Peeps>) session.getAttribute("FollowerList");

		for (int i = 0; i < followerList.size(); i++) {

			int follow_idx = Integer.parseInt(followerList.get(i).getM_idx());

			if (follow_idx == y_idx) {
				followerList.get(i).setChk_result(f_result);
				System.out.println("result 바꾸기 성공");
			} else {
				System.out.println("해당 인덱스가 아님");
			}

		}

		System.out.println("팔로잉 리스트 수정됨 : " + followerList);

		return f_result;
	}
	
	// 언팔로우
	public int My_unfollow(int m_idx, int y_idx, HttpSession session) {

		int u_result = 0;

		f_dao = template.getMapper(FollowDao.class);

		u_result = f_dao.deleteFollow(m_idx, y_idx);
		
		List<Peeps> followingList = (List<Peeps>) session.getAttribute("FollowingList");
		
		for(int i = 0; i<followingList.size(); i++) {
			
			int follow_idx = Integer.parseInt(followingList.get(i).getM_idx());
			
			if(follow_idx == y_idx) {
				if(u_result == 1) {
					followingList.get(i).setChk_result(0);
				} else {
					followingList.get(i).setChk_result(1);
				}
				
				
				
			} else {
				System.out.println("해당 인덱스가 아님");
			}
			
			System.out.println("팔로워 수정됨 : " + followingList);
		}

		return u_result;
	}

	
	
	
	
}
