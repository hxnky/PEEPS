package com.gnjk.gb.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.gb.dao.GuestbookDao;
import com.gnjk.gb.domain.Guestbook;
import com.gnjk.gb.domain.GuestbookListView;



@Service
public class GuestbookListService {

	private GuestbookDao dao;

	@Autowired
	private SqlSessionTemplate template;

	public GuestbookListView getListView(int pageNumber) {
		GuestbookListView listView = null;
		try {
			// GuestbookDao 구현체 생성
			dao = template.getMapper(GuestbookDao.class);
			System.out.println("현재 페이지 번호 :" + pageNumber);
			int totalGbCount = dao.selectTotalCount();
			System.out.println("전체 방명록의 개수  :" + totalGbCount);

			int cntPerPage = 10; // 한 페이지에 노출할 게시물의 개수
			int startRow = (pageNumber - 1) * cntPerPage;
			int endRow = startRow + cntPerPage - 1;
			

			List<Guestbook> gbList = dao.selectGbookList(startRow, cntPerPage); // 범위에 대한 리스트
			System.out.println(gbList);
			
			listView =new GuestbookListView(pageNumber, totalGbCount, cntPerPage, gbList, startRow, endRow);
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listView;
		
		
	}
	
	public List<Guestbook> getGbookList(){
		dao=template.getMapper(GuestbookDao.class);
		return dao.selectGbookList2();
		
	}
}
