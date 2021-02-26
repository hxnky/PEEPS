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

	public List<Peeps> SearchPeeps(String keyword, int m_idx, HttpSession session) {

		dao = template.getMapper(MemberDao.class);

		session.setAttribute("keyword", keyword);

		List<Peeps> peepslist = dao.searchMember(keyword);
		int peepsCnt = dao.searchMemberCnt(keyword);

		session.setAttribute("peepsCnt", peepsCnt);
		
		for (int i = 0; i < peepslist.size(); i++) {
			
			int follow_idx = peepslist.get(i).getM_idx();

			int chk_result = dao.CheckFollow(m_idx, follow_idx);
				
			peepslist.get(i).setChk_result(chk_result);
		}
		
		return peepslist;
	}

}
