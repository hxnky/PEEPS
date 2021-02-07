package com.gnjk.peeps.guestbook.service;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.gnjk.peeps.guestbook.domain.GuestbookRequest;

@Service
public class GuestbookInsertService {

	// private GuestbookDao dao;

	// 파일 업로드 db저장

	public int guestbook(GuestbookRequest grequest, HttpServletRequest request)// 경로
	{   
		//웹경로
		String uploadPath = "/fileipload/guest";
		//시스템의 실제 경로 
        String saveDirPath = request.getSession().getServletContext().getRealPath(uploadPath);
		//새로운 파일이름 //currentTimeMillis()=1970.1.1일 기준으로 현재사건 미릴초단위로 표시 long 타입
        String newFileName = grequest.getGmessage()+System.currentTimeMillis();
        File newFile =new File(saveDirPath,newFileName);
        
        //파일저장 
        
        
        try {//db처리가 안될때 
			grequest.getGphoto().transferTo(new File(saveDirPath,newFileName));
		
        } catch (IllegalStateException e) {
			//예외시파일에 오류가 있는지 없는지 보고 파일을 지어준다 
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        
        return 0;

	}
}