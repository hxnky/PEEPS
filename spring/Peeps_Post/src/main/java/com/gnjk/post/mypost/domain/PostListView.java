package com.gnjk.post.mypost.domain;

import java.util.List;

public class PostListView {
	
	private List<Post> postList; // 한 페이지에 노출할 게시글 정보 리스트
	private int pageNumber; // 현재 페이지 번호
	private int totalPostCount; // 전체 게시물의 개수
	private int cntPerPage; // 한 페이지에 노출할 게시물의 개수
	private int startRow;
	private int endRow;
	private int totalPageCount; // 전체 페이지의 개수
	
	public PostListView(int pageNumber, int totalPostCount, int cntPerPage, List<Post> postList, int startRow,
			int endRow) {
		this.pageNumber = pageNumber;
		this.totalPostCount = totalPostCount;
		this.cntPerPage = cntPerPage;
		this.postList = postList;
		this.startRow = startRow;
		this.endRow = endRow;
		calTotalPageCount();
		
	}
	
	private void calTotalPageCount() {
		totalPageCount = totalPostCount/cntPerPage;
		if(totalPostCount%cntPerPage>0) {
			totalPageCount++;
		}
	}
	
	//getter
	public int getPageNumber() {
		return pageNumber;
	}
	public int getTotalPostCount() {
		return totalPostCount;
	}
	public int getCntPerPage() {
		return cntPerPage;
	}
	public List<Post> getPostList() {
		return postList;
	}
	public int getStartRow() {
		return startRow;
	}
	public int getEndRow() {
		return endRow;
	}
	public int getTotalPageCount() {
		return totalPageCount;
	}

	@Override
	public String toString() {
		return "PostListView [pageNumber=" + pageNumber + ", totalPostCount=" + totalPostCount + ", cntPerPage="
				+ cntPerPage + ", postList=" + postList + ", startRow=" + startRow + ", endRow=" + endRow
				+ ", totalPageCount=" + totalPageCount + "]";
	}	
	

	
	
}
