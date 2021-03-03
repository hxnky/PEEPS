package com.gnjk.post.mypost.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.gnjk.post.mypost.domain.PostWriteRequest;
import com.gnjk.post.mypost.service.S3Util;
import com.gnjk.post.mypost.service.testPostUploadService;

@RestController
public class testController {
	
	S3Util s3 = new S3Util();
	String bucketName = "peepspost";
	
	@Autowired
	private testPostUploadService uploadService;
	
	// test ) s3 파일 업로드
	@PostMapping("/uploadTest")
	public int uploadPostTest(PostWriteRequest writeRequest, HttpServletRequest request) {
		System.out.println("테스트 컨트롤러 진입");
		return uploadService.uploadPost(writeRequest, request);
	}

}
