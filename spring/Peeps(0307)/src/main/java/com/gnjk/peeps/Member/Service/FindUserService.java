package com.gnjk.peeps.Member.Service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.peeps.Member.dao.MemberDao;
import com.gnjk.peeps.Member.domain.Peeps;

@Service
public class FindUserService {

	private MemberDao dao;

	@Autowired
	private SqlSessionTemplate template;

	public List<Peeps> SearchPeeps(String keyword, int m_idx) {

		dao = template.getMapper(MemberDao.class);

		List<Peeps> peepslist = dao.searchMember(keyword);

		for (int i = 0; i < peepslist.size(); i++) {

			int follow_idx = peepslist.get(i).getM_idx();

			int chk_result = dao.CheckFollow(m_idx, follow_idx);

			peepslist.get(i).setChk_result(chk_result);
		}

		return peepslist;
	}

	// 21.02.25 멤버 id로 idx 찾기 추가 (정현)
	public List<Peeps> getMemberidx(String memberid) {

		List<Peeps> midxList = null;

		dao = template.getMapper(MemberDao.class);

		midxList = dao.selectMemberlistById(memberid);

		return midxList;
	}

	// 21.02.25 멤버 idx로 id 찾기 추가 (정현)
	public List<Peeps> getMemberid(int memberidx) {

		List<Peeps> midList = null;

		dao = template.getMapper(MemberDao.class);

		midList = dao.selectMemberlistByIdx(memberidx);

		return midList;
	}

	// 21.02.26 회원정보 조회 (정현)
	public List<Peeps> getMemberInfo() {
		List<Peeps> midList = null;

		dao = template.getMapper(MemberDao.class);

		midList = dao.selectMemberlist();

		System.out.println("getMemberInfo 속 midList !" + midList);

		return midList;
	}

	// 21.03.04 아이디, 프로필 사진 조회 (효영)
	// 21.03.05 로그인타입 추가
	public List<Peeps> getChat(int m_idx) {
		List<Peeps> list = null;

		dao = template.getMapper(MemberDao.class);

		list = dao.selectChat(m_idx);

		return list;
	}

}
