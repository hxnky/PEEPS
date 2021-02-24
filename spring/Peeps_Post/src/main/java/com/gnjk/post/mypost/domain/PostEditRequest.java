package com.gnjk.post.mypost.domain;

import java.util.Arrays;

import org.springframework.web.multipart.MultipartFile;

public class PostEditRequest {
	
	private int userIdx;	// 회원idx
	private int postIdx;	// 게시글idx
	private String ptitle;	// 게시글 제목
	private String pcontent;	// 게시글 내용
	private String ploc;	// 게시글 위치정보
	private MultipartFile postformfile[];	// 게시글 이미지
	private String deleteImage[];  // 삭제할 기존 이미지
	private String oldImage[]; // 기존 원본 이미지 
	
	public int getUserIdx() {
		return userIdx;
	}
	public void setUserIdx(int userIdx) {
		this.userIdx = userIdx;
	}
	public int getPostIdx() {
		return postIdx;
	}
	public void setPostIdx(int postIdx) {
		this.postIdx = postIdx;
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
	public MultipartFile[] getPostformfile() {
		return postformfile;
	}
	public void setPostformfile(MultipartFile[] postformfile) {
		this.postformfile = postformfile;
	}
	public String[] getDeleteImage() {
		return deleteImage;
	}
	public void setDeleteImage(String[] deleteImage) {
		this.deleteImage = deleteImage;
	}
	public String[] getOldImage() {
		return oldImage;
	}
	public void setOsldImage(String[] oldImage) {
		this.oldImage = oldImage;
	}
	// editRequest -> post
	public Post toPost() {
		Post post = new Post();
		post.setMember_idx(userIdx);
		post.setP_idx(postIdx);
		post.setP_title(ptitle);
		post.setP_content(pcontent);
		post.setP_loc(ploc);
		
		return post;
	}
	
	@Override
	public String toString() {
		return "PostEditRequest [userIdx=" + userIdx + ", postIdx=" + postIdx + ", ptitle=" + ptitle + ", pcontent="
				+ pcontent + ", ploc=" + ploc + ", postformfile=" + Arrays.toString(postformfile) + ", deleteImage="
				+ Arrays.toString(deleteImage) + "]";
	}
	
	

}
