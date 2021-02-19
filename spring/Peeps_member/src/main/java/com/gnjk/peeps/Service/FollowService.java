package com.gnjk.peeps.Service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.peeps.dao.FollowDao;
import com.gnjk.peeps.domain.Peeps;

@Service
public class FollowService {

	@Autowired
	private SqlSessionTemplate template;

	private FollowDao dao;

	public int follow(int m_idx, int y_idx, HttpSession session) {

		int f_result = 0;

		dao = template.getMapper(FollowDao.class);

		f_result = dao.insertFollow(m_idx, y_idx);

		List<Peeps> peepslist = (List<Peeps>) session.getAttribute("peepslist");

		for (int i = 0; i < peepslist.size(); i++) {

			int follow_idx = peepslist.get(i).getM_idx();

			if (follow_idx == y_idx) {
				peepslist.get(i).setChk_result(f_result);
				System.out.println("result 바꾸기 성공");
			} else {
				System.out.println("해당 인덱스가 아님");
			}

		}

		System.out.println("리스트 불러오기 : " + peepslist);

		return f_result;
	}

	public int unfollow(int m_idx, int y_idx, HttpSession session) {

		int u_result = 0;

		dao = template.getMapper(FollowDao.class);

		u_result = dao.deleteFollow(m_idx, y_idx);
		
		List<Peeps> peepslist = (List<Peeps>) session.getAttribute("peepslist");
		
		for(int i = 0; i<peepslist.size(); i++) {
			
			int follow_idx = peepslist.get(i).getM_idx();
			
			if(follow_idx == y_idx) {
				if(u_result == 1) {
					peepslist.get(i).setChk_result(0);
				} else {
					peepslist.get(i).setChk_result(1);
				}
				
			} else {
				System.out.println("해당 인덱스가 아님");
			}
			
			
		}

		return u_result;
	}

}
