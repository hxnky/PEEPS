package com.gnjk.post.mypost.domain;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class PostWriteRequest {
	
	private int userIdx;
	private String ptitle;
	private String pcontent;
	private String ploc;
	private String pthumbnail;
	
	private List<MultipartFile> postfiles;
	
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
	
	public List<MultipartFile> getPostfiles() {
		return postfiles;
	}
	public void setPostfiles(List<MultipartFile> postfiles) {
		this.postfiles = postfiles;
	}
	
	public String getPthumbnail() {
		return pthumbnail;
	}
	public void setPthumbnail(String pthumbnail) {
		this.pthumbnail = pthumbnail;
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
