package com.gnjk.post.mypost.domain;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class PostWriteRequest {
	
	private int userIdx;	// 회원 idx
	private String ptitle;	// 게시글 제목
	private String pcontent;	// 게시글 내용
	private String ploc;	// 게시글 위치정보
	private String pthumbnail; // 썸네일
	private MultipartFile postformfile[];	// 게시글 이미지
	
	public int getUserIdx() {
		return userIdx;
	}
	public void setUserIdx(int userIdx) {
		this.userIdx = userIdx;
	}
	public String getPtitle() {
		return ptitle;
	}
	public void setPtitle(String ptitle) {
		this.ptitle = ptitle;
	}
	public String getPcontent() {
		return pcontent;
	}
	public void setPcontent(String pcontent) {
		this.pcontent = pcontent;
	}
	public String getPloc() {
		return ploc;
	}
	public void setPloc(String ploc) {
		this.ploc = ploc;
	}
	public String getPthumbnail() {
		return pthumbnail;
	}
	public void setPthumbnail(String pthumbnail) {
		this.pthumbnail = pthumbnail;
	}
	public MultipartFile[] getPostformfile() {
		return postformfile;
	}
	public void setPostformfile(MultipartFile[] postformfile) {
		this.postformfile = postformfile;
	}
	// 게시글 저장 
	public Post toPost() {
		Post post = new Post();
		post.setMember_idx(userIdx);
		post.setP_title(ptitle);
		post.setP_content(pcontent);
		post.setP_loc(ploc);
		return post;
	}


}
