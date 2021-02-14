package com.gnjk.peeps.guestbook.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.gnjk.peeps.guestbook.dao.GuestbookDao;
import com.gnjk.peeps.guestbook.domain.Guestbook;

public class GuestbookselectListService {

	private GuestbookDao dao;

	SqlSessionTemplate template;
	
	public List<Guestbook> getGbookList(){
		
		dao= template.getMapper(GuestbookDao.class);
		
		return null;
	}

}
