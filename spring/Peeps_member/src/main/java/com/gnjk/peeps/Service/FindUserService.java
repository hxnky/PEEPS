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

		List<Peeps> peepslist = dao.searchMember(keyword);

		System.out.println(peepslist);

		//session.setAttribute("peepslist", peepslist);

		return peepslist;
	}

}
