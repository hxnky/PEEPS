package com.gnjk.post.mypost.service;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.post.mypost.dao.CommentDao;
import com.gnjk.post.mypost.dao.PostDao;
import com.gnjk.post.mypost.domain.Comment;
import com.gnjk.post.mypost.domain.Post;

@Service
public class TimeLineService {
   
   private PostDao dao;
   private CommentDao c_dao;
   
   @Autowired
   private SqlSessionTemplate template;
   
   public List<Post> PostList(int member_idx){
      
      dao = template.getMapper(PostDao.class);
      
      System.out.println(member_idx);
      
      List<Post> PostList = new ArrayList<>(); 
      PostList =dao.selectPostByM_idx(member_idx);
      
      System.out.println(PostList);
      
      return PostList;
   }

   public List<Comment> CmtList(int post_idx) {

      c_dao = template.getMapper(CommentDao.class);
      System.out.println(post_idx);
      
      List<Comment> CmtList = new ArrayList<>();
      CmtList = c_dao.selectCmtListLimit(post_idx);
      
      System.out.println(CmtList);
      return CmtList;
   }

   
   public List<Post> PostListByK(String keyword) {
      dao = template.getMapper(PostDao.class);
      
      System.out.println(keyword);
      
      List<Post> PostList = dao.selectPostByKeyword(keyword);
      
      return PostList;
   }

   // 게시물 수 검색
   public int PostCnt(int m_idx) {
      
      dao = template.getMapper(PostDao.class);

      return dao.selectTotalPostCount(m_idx);
   }

}