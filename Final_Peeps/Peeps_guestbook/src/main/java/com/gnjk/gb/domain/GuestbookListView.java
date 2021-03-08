package com.gnjk.gb.domain;


import java.util.List;

public class GuestbookListView {
	
	int pageNumber; //현재 페이지 번호
	int totalGbCount; // 전체 방명록의 개수 
	int cntPerPage;//한 페이지에 노출할 게시물의 개수
	List<Guestbook> gbList; //페이지에 노출할 회원의 정보를 담는 리스트
	int startRow; // startRow/endRow
	int endRow;
	private int totalPageCount; // 전체 페이지의 개수
	public GuestbookListView(int pageNumber, int totalGbCount, int cntPerPage, List<Guestbook> gbList, int startRow,
			int endRow) {
		
		this.pageNumber = pageNumber;
		this.totalGbCount = totalGbCount;
		this.cntPerPage = cntPerPage;
		this.gbList = gbList;
		this.startRow = startRow;
		this.endRow = endRow;
		calTotalPageCount();
	}
	
	private void calTotalPageCount() {
		
		totalPageCount = totalGbCount/cntPerPage;
		if(totalGbCount%cntPerPage>0) {
			totalPageCount++;
		}
		
	}

	public int getPageNumber() {
		return pageNumber;
	}

	public int getTotalGbCount() {
		return totalGbCount;
	}

	public int getCntPerPage() {
		return cntPerPage;
	}

	public List<Guestbook> getGbList() {
		return gbList;
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
		return "GuestbookListView [pageNumber=" + pageNumber + ", totalGbCount=" + totalGbCount + ", cntPerPage="
				+ cntPerPage + ", gbList=" + gbList + ", startRow=" + startRow + ", endRow=" + endRow
				+ ", totalPageCount=" + totalPageCount + "]";
	}
	
	
	
	
}
