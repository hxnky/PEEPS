package com.gnjk.peeps.Member.Service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.peeps.Member.dao.MemberDao;
import com.gnjk.peeps.Member.domain.FollowRequest;

@Service
public class MyPageService {

	private MemberDao dao;

	@Autowired
	private SqlSessionTemplate template;

	// 아이디로 유저 정보 얻기
	public List<FollowRequest> getPeeps(String id, int m_idx) {

		dao = template.getMapper(MemberDao.class);

		List<FollowRequest> peeps = dao.selectMemberById(id);

		for (int i = 0; i < peeps.size(); i++) {
			if (m_idx != peeps.get(i).getM_idx()) {
				
				peeps.get(i).setChk_result(dao.CheckFollow(m_idx, peeps.get(i).getM_idx()));
				peeps.get(i).setFollowerCnt(dao.FollowerCnt(peeps.get(i).getM_idx()));
				peeps.get(i).setFollowingCnt(dao.FollowingCnt(peeps.get(i).getM_idx()));
			} else {
				peeps.get(i).setFollowerCnt(dao.FollowerCnt(peeps.get(i).getM_idx()));
				peeps.get(i).setFollowingCnt(dao.FollowingCnt(peeps.get(i).getM_idx()));
			}
		}
		System.out.println(peeps);
		
		return peeps;
	}

//	public boolean chk_follow(int idx, int m_idx) {
//		
//		dao = template.getMapper(MemberDao.class);
//		
//		boolean follow_chk = false;
//		
//		if(dao.CheckFollow(m_idx, idx)==1) {
//			follow_chk = true;
//		}
//			
//		return follow_chk;
//	}

	// 팔로워 수
	public int getFollower(int m_idx, HttpSession session) {

		dao = template.getMapper(MemberDao.class);

		int follower = dao.FollowerCnt(m_idx);

		session.setAttribute("follower", follower);

		System.out.println(follower);

		return follower;

	}

	// 팔로잉 수
	public int getFollowing(int m_idx, HttpSession session) {

		dao = template.getMapper(MemberDao.class);

		int following = dao.FollowingCnt(m_idx);

		System.out.println(following);

		session.setAttribute("following", following);

		return following;

	}

	// 팔로우
	public int Follow(int m_idx, int y_idx) {

		dao = template.getMapper(MemberDao.class);

		return dao.insertFollow(m_idx, y_idx);
	}

	// 언팔로우
	public int unFollow(int m_idx, int y_idx) {

		dao = template.getMapper(MemberDao.class);

		return dao.deleteFollow(m_idx, y_idx);
	}

	// 팔로잉 인덱스 가져와서 ListPeeps 하기
	public List<FollowRequest> getFollowingList(int m_idx) {

		dao = template.getMapper(MemberDao.class);

		// 인덱스 가져오기
		List<Integer> following_peeps = dao.followingList(m_idx);

		List<FollowRequest> followingList = new ArrayList<FollowRequest>();

		for (int i = 0; i < following_peeps.size(); i++) {

			int f_idx = following_peeps.get(i);

			System.out.println(f_idx);

			followingList.addAll(dao.selectMemberByIdx(f_idx));
			System.out.println("팔로잉 리스트 생성 완료");
			if(followingList.size() > 0) {
				System.out.println("팔로잉이 한 명 이상");
				followingList.get(i).setChk_result(dao.CheckFollow(m_idx, f_idx));
			}
			
		}

		System.out.println(followingList);
		
		return followingList;
	}

	// 팔로워 인덱스 가져와서 ListPeeps 하기
	public List<FollowRequest> getFollowerList(int m_idx) {

		dao = template.getMapper(MemberDao.class);

		List<Integer> follower_peeps = dao.followerList(m_idx);
		List<FollowRequest> followerList = new ArrayList<FollowRequest>();

		for (int i = 0; i < follower_peeps.size(); i++) {

			int f_idx = follower_peeps.get(i);

			followerList.addAll(dao.selectMemberByIdx(f_idx));
			if(followerList.size()>0) {
				followerList.get(i).setChk_result(dao.CheckFollow(m_idx, f_idx));
			}
			

		}
		
		System.out.println("팔로워 리스트");

		return followerList;
	}

	public String selectId(int m_idx) {

		dao = template.getMapper(MemberDao.class);

		return dao.selectId(m_idx);
	}

}
