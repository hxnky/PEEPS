package com.gnjk.peeps.Service;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.gnjk.peeps.dao.PeepsDao;
import com.gnjk.peeps.domain.EditRequest;
import com.gnjk.peeps.domain.Peeps;

@Service
public class EditInfoService {

	private PeepsDao dao;

	@Autowired
	private SqlSessionTemplate template;

	public Peeps getPeeps(@RequestParam("email") String email, HttpSession session) {

		dao = template.getMapper(PeepsDao.class);

		Peeps peeps = dao.selectMemberByEmail(email);
		
		session.setAttribute("peeps", peeps);
		session.setAttribute("m_idx", peeps.getM_idx());
		session.setAttribute("email", peeps.getEmail());
		session.setAttribute("id", peeps.getId());
		session.setAttribute("loginType", peeps.getLoginType());
		
		return peeps;
	}

	public int editPeeps(EditRequest editRequest, HttpServletRequest request) {

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


		if (newFileName == null) {
			peeps.setM_photo(editRequest.getOldPhoto());
		} else {
			peeps.setM_photo(newFileName);
		}

		try {
			dao = template.getMapper(PeepsDao.class);

			result = dao.updateMemberInfo(peeps);

		} catch (Exception e) {
			e.printStackTrace();


			if (newFile != null && newFile.exists()) {
				newFile.delete();
			}
		}

//		if (newFile != null && !editRequest.getOldPhoto().equals("profile.png")) {
//			new File(saveDirPath, editRequest.getOldPhoto()).delete();
//		}

		return result;
	}
}
