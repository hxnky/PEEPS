package com.gnjk.peeps.Service;

import java.util.List;

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

	public List<Peeps> SearchPeeps(String keyword) {

		dao = template.getMapper(PeepsDao.class);
		
		System.out.println("키워드"+keyword);

		List<Peeps> peepslist = dao.searchMember(keyword);
		
		System.out.println(peepslist);
		
		
//		model.addAttribute("s_m_photo", peeps.getM_photo());
//		model.addAttribute("s_id", peeps.getId());
//		model.addAttribute("s_name", peeps.getName());
//		model.addAttribute("s_loginType", peeps.getLoginType());

		return peepslist;
	}

}
