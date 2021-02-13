package com.gnjk.peeps.guestbook.dao;




import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.gnjk.peeps.guestbook.domain.Guestbook;
import com.gnjk.peeps.guestbook.domain.LoginInfo;


@Repository
public interface GuestbookDao {
    
	
	
	List<Guestbook> selectGbookList();
	
	
	int insertGbook(Guestbook gbook);
	
	int deletGbook();
	
	int editGbook();
	
	LoginInfo selectById();

}
