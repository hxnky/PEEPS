package com.gnjk.gb.service;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gnjk.gb.dao.GuestbookDao;
import com.gnjk.gb.domain.Guestbook;
import com.gnjk.gb.domain.GuestbookRequest;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class GuestbookInsertService {

	@Autowired
	private GuestbookDao dao;
	
	@Autowired
	private SqlSessionTemplate template;

	// 파일을 업로드, 데이터베이스 저장
	@Transactional
	public int guestbook(GuestbookRequest grequest, HttpServletRequest request)//HttpServletRequest request 경로
	{   
		
		
		
		// test글저장
		int gbResult = 0;
		
		
		File newFile = null;
		String newFileName = null;
		
		System.out.println(grequest.getGmessage());
		
		
		if(!grequest.getGphoto().isEmpty()) {
		
			// 웹 경로
			String uploadPath = "/resources/fileupload/guestbook";
			
			// 시스템의 실제 경로
			String saveDirPath = request.getSession().getServletContext().getRealPath(uploadPath);
			
			// 새로운 파일 이름
			newFileName = grequest.getGwriter() + System.currentTimeMillis();//중복방지  
			newFile = new File(saveDirPath, newFileName);
			
			/* 파일 저장  하다가 생길 db오류 catch*/
			try {
				grequest.getGphoto().transferTo(newFile);//파일이 있다면 지워진다
			
			
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}

		}

		Guestbook guestbook = grequest.toGuestbook();//사진이름은 새로 만들었기 때문에 서비스에서 넣어준다.
		if(newFileName != null) {
			guestbook.setGphoto(newFileName);
		}

		try {
			// 데이터 베이스 입력
  		dao = template.getMapper(GuestbookDao.class);//dao에입력
		gbResult = dao.insertGbook(guestbook);
			
		
			
			
		
		
			
		} catch (Exception e) {
			log.error(e.getMessage(),e);
			e.printStackTrace();
			// 현재 저장한 파일이 있다면??!! -> 삭제
			if (newFile != null && newFile.exists()) {
				newFile.delete();
			}

		}

		return gbResult;
	}

}
