package com.gnjk.peeps.Member.Controller;

import java.io.File;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.gnjk.peeps.Member.Service.EditInfoService;
import com.gnjk.peeps.Member.Service.S3Util;
import com.gnjk.peeps.Member.Service.UploadFileUtils;
import com.gnjk.peeps.Member.domain.EditRequest;

@Controller
public class UploadObjectController {

	S3Util s3 = new S3Util();
	String bucketName = "peepsmember";

	@Inject
	private EditInfoService editService;

	// 프로필 이미지 업로드/ DB 수정
	@ResponseBody
	@RequestMapping(value = "/profile/edit", method = RequestMethod.POST, produces = "application/json")
	public int uploadAjax(EditRequest editRequest, HttpSession session, HttpServletRequest request) throws Exception {

		System.out.println("프로필 편집 s3,,,");
		System.out.println(editRequest);

		// 프로필 이미지의 추가경로
		String uploadpath = "peeps/profile";
		MultipartFile m_photo = editRequest.getM_photo();
		String fileName = editRequest.getOldPhoto();

		System.out.println("원래 사진 이름 : " + fileName);
		int result = 0;

		if (m_photo.isEmpty()) {
			String user_imgPath = editRequest.getOldPhoto();

			result = editService.editPeeps(editRequest, request, session, user_imgPath);
			System.out.println("정보만 변경");

		} else {

			ResponseEntity<String> img_path = new ResponseEntity<>(
					UploadFileUtils.uploadFile(uploadpath, m_photo.getOriginalFilename(), m_photo.getBytes()),
					HttpStatus.CREATED);

			String user_imgPath = (String) img_path.getBody();

			System.out.println(user_imgPath);

			result = editService.editPeeps(editRequest, request, session, user_imgPath);
			System.out.println("사진 변경");
			System.out.println("원래 사진 이름 : " + fileName);
			// S3에 있는 원래 사진 삭제
			if (fileName.equals("/profile.png")) {
				System.out.println("프로필사진임");
			} else {
				try {
					s3.fileDelete(bucketName, uploadpath + fileName);
				} catch (Exception e) {
					e.printStackTrace();
				}

				new File(uploadpath + fileName.replace('/', File.separatorChar)).delete();
				System.out.println("원래 사진 삭제");
			}
		}

		return result;
	}

}
