package com.gnjk.gb.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.gb.dao.GuestbookDao;
import com.gnjk.gb.domain.Reply;
import com.gnjk.gb.domain.ReplyRequest;

@Service
public class ReplyService {
	
	@Autowired
	private GuestbookDao dao;
	
	@Autowired
	private SqlSessionTemplate template;
	
	public int insertReply(ReplyRequest rRequest) {
		// test글저장
		int rResult = 0;
		
		dao = template.getMapper(GuestbookDao.class);//dao에입력
		Reply reply=rRequest.toReply();
		
		rResult = dao.insertReply(reply);
		
	 System.out.println("댓글입력" +rResult);
	 System.out.println(rRequest.getRmsg());
		
		return rResult;
	}

}
