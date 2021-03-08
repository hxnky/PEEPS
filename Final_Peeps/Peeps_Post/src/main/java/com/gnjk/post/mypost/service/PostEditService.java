package com.gnjk.post.mypost.service;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.gnjk.post.mypost.dao.FileDao;
import com.gnjk.post.mypost.dao.PostDao;
import com.gnjk.post.mypost.domain.Post;
import com.gnjk.post.mypost.domain.PostEditRequest;
import com.gnjk.post.mypost.domain.PostFile;

@Service
public class PostEditService {

	private PostDao dao;
	private FileDao fDao;

	@Autowired
	private SqlSessionTemplate template;

	public int editPost(PostEditRequest editRequest, HttpServletRequest request) {
		int postEditResult = 0;

		MultipartFile[] files = editRequest.getPostformfile();
		System.out.println("file[0]크기 : "+files[0].getSize());

		// 웹 경로
		String uploadPath = "/resources/fileupload/postfile";
		// 실제 경로
		String saveDirPath = request.getSession().getServletContext().getRealPath(uploadPath);
		String fileName = "";
		String newFileName = "";
		File newFile = null;

		// DTO에 수정한 게시글 정보 저장
		Post post = editRequest.toPost();
		dao = template.getMapper(PostDao.class);
		postEditResult = dao.updatePost(post);

		// 속성에 저장 -> 나중에 확인해서 출력
//		model.addAttribute("result", postEditResult);

		// test 게시글 idx 확인
		int postidx = post.getP_idx();
		System.out.println("게시글의 idx : " + postidx);
		
		fDao = template.getMapper(FileDao.class);
		
		// 기존 이미지 삭제
		if (postEditResult > 0 && editRequest.getDeleteImage() != null) {
			System.out.println("기존 이미지 삭제 진입");

			for (int i = 0; i < editRequest.getDeleteImage().length; i++) {

				// DB 파일 테이블에서 삭제한 파일명과 같은 행 삭제처리
				fDao.deleteBeforeImage(editRequest.getDeleteImage()[i]);
				// 디렉토리에서 삭제
				new File(saveDirPath, editRequest.getDeleteImage()[i]).delete();
			}
		} // 기존 이미지 삭제 끝

		// 수정하면서 추가된 이미지 저장
		if (postEditResult > 0 && files[0].getSize() > 0) {
			
			System.out.println("추가된 이미지 저장 진입");
			
			// 파일 배열에서 꺼내서 경로에 저장
			for (MultipartFile mf : files) {
//				fileName = mf.getOriginalFilename(); // 파일 이름
				fileName = "postidx"+post.getP_idx();
				// System.out.println("fileName : " + fileName);
				newFileName = System.currentTimeMillis() + fileName;
				
				try {

					// 디렉토리에 저장
					mf.transferTo(newFile = new File(saveDirPath, newFileName));

					PostFile postFile = new PostFile();
					postFile.setF_name(newFileName);
					postFile.setPost_idx(post.getP_idx());
					// 21.03.02 파일 (실제)경로 설정
					postFile.setF_path(saveDirPath);

					System.out.println("!!!postFile : " + postFile);

					// 파일 DB insert
					fDao = template.getMapper(FileDao.class);
					int postFileResult = fDao.insertFiles(postFile);
					System.out.println("!!postFileResult : " + postFileResult);

				} catch (Exception e) {
					e.printStackTrace();
					// 현재 저장된 파일 있을 경우 삭제
					if (newFile != null && newFile.exists()) {
						newFile.delete();
					}

				} // catch 끝
			} // for 끝
			
		} // 파일 저장 if 끝
		
		List<PostFile> newImgList = fDao.selectPostImgs(post.getP_idx());
		System.out.println("저장된 이미지 리스트 : "+newImgList);
		if(newImgList.size() != 0) {
			// 썸네일 update
			String pthumb = newImgList.get(0).getF_name();
			dao.updatePostThumbnail(post.getP_idx(), pthumb);
		} else {
			String pthumb = "default.jpg";
			dao.updatePostThumbnail(post.getP_idx(), pthumb);
		}
		
		

		return postEditResult;
	}


}
