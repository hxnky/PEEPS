package com.gnjk.gb.service;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.gb.dao.GuestbookDao;
import com.gnjk.gb.domain.Guestbook;
import com.gnjk.gb.domain.GuestbookEditRequest;

@Service
public class GuestbookEditService {

	private GuestbookDao dao;

	@Autowired
	private SqlSessionTemplate template;

	/*
	 * public Guestbook getMsg(int gidx) {
	 * 
	 * dao = template.getMapper(GuestbookDao.class); return
	 * dao.selectGuestbookIdx(gidx);
	 * 
	 * }
	 */

	public int editGuestbook(GuestbookEditRequest grequest, HttpServletRequest request) {

		int gbresult = 0;

		// 웹 경로
		String uploadPath = "/fileupload/guestbook";
		// 시스템의 실제 경로
		String saveDirPath = request.getSession().getServletContext().getRealPath(uploadPath);

		String newFileName = null;
		File newFile = null;

		// 1. 파일 처리 : 업로드할 새로운 파일이 존재하면
		if (!grequest.getGphoto().isEmpty()) {
			// 새로운 파일 이름
			newFileName = grequest.getGwriter() + System.currentTimeMillis();
			newFile = new File(saveDirPath, newFileName);
			// 파일 저장
			try {
				grequest.getGphoto().transferTo(newFile);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		// 수정할 데이터를 가지는 guestbook -> guestbook 
		Guestbook guestbook = grequest.toGuestbook();

		// 수정할 파일 이름 설정
		if (newFileName == null) {
			guestbook.setGphoto(grequest.getOldgphoto());
		} else {
			guestbook.setGphoto(newFileName);
		}

		try {
			// 2. DB : update
			dao = template.getMapper(GuestbookDao.class);
			
			System.out.println(guestbook);
			gbresult = dao.updateGuestbook(guestbook);
			
			System.out.println("수정될값"+gbresult);
			
			} catch (Exception e) {
				e.printStackTrace();
				
				// 저장된 파일을 삭제
				if(newFile !=null && newFile.exists()) {
					newFile.delete();
				}
			}
			
			if(newFile != null) {
				new File(saveDirPath,grequest.getOldgphoto()).delete();
			}
		return gbresult;

	}

}
