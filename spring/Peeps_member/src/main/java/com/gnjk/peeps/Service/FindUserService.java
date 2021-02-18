package com.gnjk.peeps.Service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.peeps.dao.FollowDao;
import com.gnjk.peeps.dao.PeepsDao;
import com.gnjk.peeps.domain.Peeps;

@Service
public class FindUserService {

	private PeepsDao dao;
	private FollowDao f_dao;

	@Autowired
	private SqlSessionTemplate template;

	public List<Peeps> SearchPeeps(String keyword, int m_idx, HttpSession session) {

		dao = template.getMapper(PeepsDao.class);
		f_dao = template.getMapper(FollowDao.class);

		System.out.println("키워드" + keyword);
		session.setAttribute("keyword", keyword);

		List<Peeps> peepslist = dao.searchMember(keyword);
		int peepsCnt = dao.searchMemberCnt(keyword);

		session.setAttribute("peepsCnt", peepsCnt);
		
		for (int i = 0; i < peepslist.size(); i++) {
			
			int follow_idx = Integer.parseInt(peepslist.get(i).getM_idx());
			
			System.out.println("아이디 검색 인덱스");
			System.out.println(follow_idx);
			
			System.out.println(m_idx);
			
			int chk_result = f_dao.CheckFollow(m_idx, follow_idx);
			
			System.out.println(chk_result);
			
			//peepslist.get(i).setChkfollow(f_dao.CheckFollow(m_idx, follow_idx));
			
			peepslist.get(i).setChk_result(chk_result);
		}

		System.out.println(peepslist);

		// session.setAttribute("peepslist", peepslist);

		return peepslist;
	}

}
