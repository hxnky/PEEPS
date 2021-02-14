package com.gnjk.peeps.guestbook.dao;




import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.gnjk.peeps.guestbook.domain.Guestbook;
import com.gnjk.peeps.guestbook.domain.LoginInfo;
import com.gnjk.peeps.guestbook.domain.SearchParam;


@Repository
public interface GuestbookDao {
    
	
	
	
	
	//방명록 작성 
	int insertGbook(Guestbook gbook);
	
	//방명록의 총 수 
	int selectTotalCount();
	//방명록 리스트(페이지 번호에 맞는 )
	List<Guestbook> selectGbookList(Map<String , Object> param);
	//검색한 방명록 수 
	int selectSearchGbookCount(Map<String, Object> listMap);
	
	
	int deletGbook();
	
	int editGbook();
	
	LoginInfo selectById();

}
