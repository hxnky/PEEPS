package com.gnjk.peeps.Member.Service;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.peeps.Member.dao.MemberDao;
import com.gnjk.peeps.Member.domain.EditRequest;
import com.gnjk.peeps.Member.domain.Peeps;

@Service
public class EditInfoService {

	private MemberDao dao;

	@Autowired
	private SqlSessionTemplate template;

	public int getPeeps(String email, HttpSession session) {

		dao = template.getMapper(MemberDao.class);
		int result = 0;

		Peeps peeps = dao.selectMemberByEmail(email);
		System.out.println("프로필 편집 페이지");
		System.out.println(peeps);

		if(peeps != null) {
			session.setAttribute("peeps", peeps);	
			result = 1;
		}

		return result;
	}

	public int editPeeps(EditRequest editRequest, HttpServletRequest request, HttpSession session) {

		int result = 0;

		String uploadPath = "/fileupload";

		String saveDirPath = request.getSession().getServletContext().getRealPath(uploadPath);

		String newFileName = null;
		File newFile = null;

		if (!editRequest.getM_photo().isEmpty()) {

			newFileName = editRequest.getId() + System.currentTimeMillis();
			newFile = new File(saveDirPath, newFileName);

			try {
				editRequest.getM_photo().transferTo(newFile);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		Peeps peeps = editRequest.getToPeeps();

		System.out.println(editRequest);
		System.out.println(peeps);
		System.out.println(editRequest.getOldPhoto());

		if (newFileName == null) {
			peeps.setM_photo(editRequest.getOldPhoto());
		} else {
			peeps.setM_photo(newFileName);
		}

		try {
			dao = template.getMapper(MemberDao.class);

			result = dao.updateMemberInfo(peeps);

		} catch (Exception e) {
			e.printStackTrace();

			if (newFile != null && newFile.exists()) {
				newFile.delete();
			}
		}

		if (newFile != null && !editRequest.getOldPhoto().equals("profile.png")) {
			new File(saveDirPath, editRequest.getOldPhoto()).delete();
		}

		// 수정 후 세션 다시 저장
		session.setAttribute("peeps", peeps);

		return result;
	}
}
