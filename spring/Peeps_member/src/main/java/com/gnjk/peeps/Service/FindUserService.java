package com.gnjk.peeps.Service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.peeps.dao.PeepsDao;
import com.gnjk.peeps.domain.Peeps;

@Service
public class FindUserService {

	private PeepsDao dao;

	@Autowired
	private SqlSessionTemplate template;

	public List<Peeps> SearchPeeps(String keyword, HttpSession session) {

		dao = template.getMapper(PeepsDao.class);

		System.out.println("키워드" + keyword);

//		Map<String, Object> listMap = new HashMap<String, Object>();
//		listMap.put("keyword", keyword);

		List<Peeps> peepslist = dao.searchMember(keyword);
		int peepsCnt = dao.searchMemberCnt(keyword);

		System.out.println(peepsCnt);
		System.out.println(peepslist.size());
		
		session.setAttribute("peepsCnt", peepsCnt);

		for (int i = 0; i < peepslist.size(); i++) {
			String m = i + "번째 인덱스 : " + peepslist.get(i).getM_idx();
			System.out.println(m);
			System.out.println("----------------------------------");
			System.out.println(i + "번째 인덱스 : " + peepslist.get(i).getM_idx());
			session.setAttribute(i+"_m_idx", peepslist.get(i).getM_idx());
		}

		System.out.println(peepslist);

		// session.setAttribute("peepslist", peepslist);

		return peepslist;
	}

}
