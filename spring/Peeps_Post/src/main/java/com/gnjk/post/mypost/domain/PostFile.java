package com.gnjk.post.mypost.domain;

public class PostFile {
	
	private int f_idx;
	private String f_name;
	private String f_path;
	private String f_type;
	private String f_size;
	private int post_idx;
	
	public int getF_idx() {
		return f_idx;
	}
	public void setF_idx(int f_idx) {
		this.f_idx = f_idx;
	}
	public String getF_name() {
		return f_name;
	}
	public void setF_name(String f_name) {
		this.f_name = f_name;
	}
	public String getF_path() {
		return f_path;
	}
	public void setF_path(String f_path) {
		this.f_path = f_path;
	}
	public int getPost_idx() {
		return post_idx;
	}
	public void setPost_idx(int post_idx) {
		this.post_idx = post_idx;
	}
	public String getF_type() {
		return f_type;
	}
	public void setF_type(String f_type) {
		this.f_type = f_type;
	}
	public String getF_size() {
		return f_size;
	}
	public void setF_size(String f_size) {
		this.f_size = f_size;
	}
	
	@Override
	public String toString() {
		return "File [f_idx=" + f_idx + ", f_name=" + f_name + ", f_path=" + f_path + ", f_type=" + f_type + ", f_size="
				+ f_size + ", post_idx=" + post_idx + "]";
	}
	
	
	
	
	

}
