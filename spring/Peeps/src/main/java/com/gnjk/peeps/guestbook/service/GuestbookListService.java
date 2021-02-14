package com.gnjk.peeps.guestbook.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.peeps.guestbook.dao.GuestbookDao;
import com.gnjk.peeps.guestbook.domain.Guestbook;
import com.gnjk.peeps.guestbook.domain.GuestbookListView;
import com.gnjk.peeps.guestbook.domain.SearchParam;

@Service
public class GuestbookListService {

	private GuestbookDao dao;

	@Autowired
	private SqlSessionTemplate template;

	public GuestbookListView getListView(SearchParam param) {
		GuestbookListView listView = null;
		try {
			// GuestbookDao 구현체 생성
			dao = template.getMapper(GuestbookDao.class);
			System.out.println("현재 페이지 번호 :" + param.getP());
			

			int cntPerPage = 10; // 한 페이지에 노출할 방명록의 개수
			int startRow = (param.getP() - 1) * cntPerPage;
			int endRow = startRow + cntPerPage - 1;
			
			Map<String,Object> listMap =new HashMap<String, Object>();
			listMap.put("startRow", startRow);
			listMap.put("cntperPage", cntPerPage);
			listMap.put("searchParam ", param );
			
			int totalGbCount = dao.selectSearchGbookCount(listMap);
			System.out.println("전체 방명록의 개수  :" + totalGbCount);
			
			List<Guestbook> gbList = dao.selectGbookList(listMap); // 범위에 대한 리스트
			System.out.println(gbList);
			
			listView =new GuestbookListView(param.getP(), totalGbCount, cntPerPage, gbList, startRow, endRow);
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listView;
	}

}
