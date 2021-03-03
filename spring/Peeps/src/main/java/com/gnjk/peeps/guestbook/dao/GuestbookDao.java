package com.gnjk.peeps.guestbook.dao;




import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.gnjk.peeps.guestbook.domain.Guestbook;
import com.gnjk.peeps.guestbook.domain.GuestbookComment;
import com.gnjk.peeps.guestbook.domain.LoginInfo;


@Repository
public interface GuestbookDao {
    
	
	
	
	
	//방명록 작성 
	int insertGbook(Guestbook gbook);
	
	//방명록의 총 수 
	int selectTotalCount();
	//방명록 리스트(페이지 번호에 맞는 )
	List<Guestbook> selectGbookList(int startRow, int cntPerPage);
	//방명록 리스트 json
	List<Guestbook> selectGbookList2();
    //방명록삭제 
	int deleteGuestbookIdx(int gidx);
    //방명록 정보 조회: gidx로 조회
	Guestbook selectGuestbookIdx(int gidx);
    //방명록 정보 업데이트
	int updateGuestbook(Guestbook guestbook);
    //댓글등록
	int insertCmt(GuestbookComment comment);
	

}
