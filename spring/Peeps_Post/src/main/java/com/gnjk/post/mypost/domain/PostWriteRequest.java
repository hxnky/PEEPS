package com.gnjk.post.mypost.domain;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

public class PostWriteRequest {
	
	private int userIdx;
	private String ptitle;
//	private MultipartFile file[];
	private String pcontent;
	private String ploc;
	
	public int getUser_idx() {
		return userIdx;
	}
	
	public void setuserIdx(int userIdx) { 
		this.userIdx = userIdx; 
	}
	
	public String getPtitle() {
		return ptitle;
	}
	public void setPtitle(String ptitle) {
		this.ptitle = ptitle;
	}
//	public MultipartFile[] getFile() {
//		return file;
//	}
//	public void setFile(MultipartFile[] file) {
//		this.file = file;
//	}
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
	
	public Post toPost() {
		Post post = new Post();
		post.setMember_idx(userIdx);
		post.setP_title(ptitle);
		post.setP_content(pcontent);
//		post.setP_loc(ploc);
//		썸네일 선택시 set 필요
		
		return post;
	}
	

	
//	게시물 사진 파일 set
//	public File toFile() {
//		File file = new File();
//		file.set
//	}
	
	
	
	

}
