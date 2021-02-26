
  package com.gnjk.post.guestbook.service;
  
  import org.mybatis.spring.SqlSessionTemplate;
import
  org.springframework.beans.factory.annotation.Autowired;
import
  org.springframework.stereotype.Service;

import com.gnjk.post.guestbook.dao.GuestbookDao;
import com.gnjk.post.guestbook.domain.Guestbook;
  

  @Service public class GuestbookRestService {
  
  private GuestbookDao dao;
  
  @Autowired private SqlSessionTemplate template;
  
  public Guestbook getGuestbook(int gidx) {
  dao=template.getMapper(GuestbookDao.class); return
  dao.selectGuestbookIdx(gidx); }
  
  }
 