
  package com.gnjk.gb.service;
  
  import org.mybatis.spring.SqlSessionTemplate;
import
  org.springframework.beans.factory.annotation.Autowired;
import
  org.springframework.stereotype.Service;

import com.gnjk.gb.dao.GuestbookDao;
import com.gnjk.gb.domain.Guestbook;
  

 
  @Service public class GuestbookRestService {
  
  private GuestbookDao dao;
  
  @Autowired private SqlSessionTemplate template;
  
  public Guestbook getGuestbook(int gidx) {
  dao=template.getMapper(GuestbookDao.class); return
  dao.selectGuestbookIdx(gidx); }
  
  }
 