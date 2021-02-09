package com.gnjk.peeps.guestbook.service;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gnjk.peeps.guestbook.dao.GuestbookDao;
import com.gnjk.peeps.guestbook.domain.Guestbook;
import com.gnjk.peeps.guestbook.domain.GuestbookRequest;

@Service
public class GuestbookInsertService {

	private GuestbookDao dao;
	
	@Autowired
	private SqlSessionTemplate template;

	// 파일 업로드 db저장
	@Transactional
	public int guestbook(GuestbookRequest grequest, HttpServletRequest request)// 경로
	{   
		
		
		
		// test글저장
		int gbResult = 0;
		
		
		File newFile = null;
		String newFileName = null;
		
		//session.setAttribute("gwriter", grequest);
		
		if(!grequest.getGphoto().isEmpty()) {
			// 웹 경로
			String uploadPath = "/fileupload/guestbook";
			// 시스템의 실제 경로
			String saveDirPath = request.getSession().getServletContext().getRealPath(uploadPath);
			// 새로운 파일 이름
			newFileName = grequest.getGwriter() + System.currentTimeMillis();
			newFile = new File(saveDirPath, newFileName);
			
			/* 파일 저장 */
			try {
				grequest.getGphoto().transferTo(newFile);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}

		}

		Guestbook guestbook = grequest.toGuestbook();
		if(newFileName != null) {
			guestbook.setGphoto(newFileName);
		}

		try {
			// 데이터 베이스 입력
			dao = template.getMapper(GuestbookDao.class);
			gbResult = dao.insertGbook(guestbook);
			
			
			
		
		
			
		} catch (Exception e) {
			e.printStackTrace();
			// 현재 저장한 파일이 있다면??!! -> 삭제
			if (newFile != null && newFile.exists()) {
				newFile.delete();
			}

		}

		return gbResult;
	}

}
