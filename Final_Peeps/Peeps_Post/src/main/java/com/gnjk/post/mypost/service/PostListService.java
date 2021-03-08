package com.gnjk.post.mypost.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.post.mypost.dao.FileDao;
import com.gnjk.post.mypost.dao.LikeDao;
import com.gnjk.post.mypost.dao.PostDao;
import com.gnjk.post.mypost.domain.Post;
import com.gnjk.post.mypost.domain.PostFile;
import com.gnjk.post.mypost.domain.PostListView;

@Service
public class PostListService {
	
	private PostDao dao;
	private FileDao fDao;
	private LikeDao lDao;
	
	@Autowired
	private SqlSessionTemplate template;
	
	// 게시글 전체 리스트 불러오기
	public PostListView getPostListView(int pageNumber, HttpServletRequest request, int mIdx) {
		// 로그인 세션 가져오기
//		HttpSession session = request.getSession();
//		Peeps loginInfo = (Peeps) session.getAttribute("peeps");
//		System.out.println("로그인 인포 세션 : "+loginInfo);
		
		// 세션 멤버 idx 
//		int member_idx = loginInfo.getM_idx();
		int member_idx = mIdx;
		
		PostListView listView = null;
		
		try {
			// PostDao 구현체 생성
			dao = template.getMapper(PostDao.class);
			
			// 멤버 id 로 멤버 idx 찾기
//			int pathMemberidx = dao.selectMemberidx(memberid);
			
			System.out.println("pageNumber : " + pageNumber);
			
			int cntPerPage = 9;
			
			int startRow = (pageNumber-1)*cntPerPage;
			int endRow = startRow+cntPerPage-1;
			
			int totalPostCount = dao.selectTotalPostCount(mIdx);
			
			System.out.println("postTotalCount : "+ totalPostCount);
			
			List<Post> postList = dao.selectPostList(mIdx, startRow, cntPerPage);
			System.out.println(postList);
			
			listView = new PostListView(pageNumber, totalPostCount, cntPerPage, postList, startRow, endRow);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return listView;
	}
	
	// 게시글 하나 내용 불러오기
	public Post getDetail(int idx) {
		
		dao = template.getMapper(PostDao.class);
		
		return dao.selectPostDetail(idx);
	}
	
	// 게시글 하나 이미지 불러오기
	public List<PostFile> getDetailImgs(int idx){
		fDao = template.getMapper(FileDao.class);
		return fDao.selectPostImgs(idx);
	}
	
	// 위치 가져오기
	public List<Post> getMapListView(int mIdx) {
		
		List<Post> postList = null;
		
		try {
			dao = template.getMapper(PostDao.class);
			
			// 멤버 id 로 멤버 idx 찾기
//			int pathMemberidx = dao.selectMemberidx(memberid);
			
			postList = dao.selectPostMapList(mIdx);
			
			System.out.println("지도 포스트 리스트 조회 : "+postList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return postList;
	}
	
	// 주소로 게시글 가져오기
	public PostListView getPostListByMapView(int mIdx, String pAddr) {
		
		PostListView listView = null;
		
		try {
			// PostDao 구현체 생성
			dao = template.getMapper(PostDao.class);
			
			// 멤버 id로 멤버 idx 가져오기
//			int mIdx = dao.selectMemberidx(pathmId);
			
			List<Post> postList = dao.selectPostByAddrList(pAddr, mIdx);
			System.out.println("포스트리스트 :"+postList);
			
//			listView = new PostListView(pageNumber, totalPostCount, cntPerPage, postList, startRow, endRow);
			listView = new PostListView(1, 1, 1, postList, 1, 1);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return listView;
	}
	
	// 좋아요 여부
	public Post getLikes(int pIdx, HttpServletRequest request) {
		
//		HttpSession session = request.getSession();
//		Peeps loginInfo = (Peeps) session.getAttribute("peeps");
//		System.out.println("로그인 인포 세션1 : "+loginInfo);
		int mIdx = Integer.parseInt(request.getParameter("mIdx"));
		System.out.println("좋아요누른 멤버 인덱스! : "+mIdx);
		
		int result = 0;
		
		Post post = null;
		
		try{
			// 해당 게시글 정보 post에 바인딩
			dao = template.getMapper(PostDao.class);
			post = dao.selectPostDetail(pIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// test loginInfo null인 경우 interceptor 처리
//		if(loginInfo == null) { // 로그인이 안된 경우
//			
//			// test 로그인 정보 세션 생성
//			/* loginInfo = new LoginInfo(1, "hy", "hyS2", "profile.png", 0); */
////			loginInfo = new Peeps(1, "jh@gmail.com", "1111", "jh", "jhS2", "profile.png", "안녕하세요", "1", 'Y', "email");
////			session.setAttribute("peeps", loginInfo);
//			System.out.println("로그인 인포 세션2 : "+loginInfo);
//			post.setLikeChk(0);
//			System.out.println("로그인 안된 경우 post : "+post);
//			return post;
//			
//		} else {	// 로그인 된 경우
//			System.out.println("로그인 인포 세션3 : "+loginInfo);
//			int mIdx = loginInfo.getM_idx();
			
			try {
				System.out.println("try구문 진입");
				lDao = template.getMapper(LikeDao.class);
				
				int likeChk = lDao.selectLike(pIdx, mIdx);
				
				if(likeChk == 0) {
					// 좋아요 한번도 누른적 없는 경우
					post.setLikeChk(0);
				} else {
					// 좋아요 누른적 있는 경우
					likeChk = lDao.selectLikeChk(pIdx, mIdx);
					post.setLikeChk(likeChk);
				}
				
//				int likeCheck = lDao.selectLikeChk(pIdx, mIdx);
				
//				post.setLikeChk(likeCheck);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
//		}
		return post;
	}
	
	// 좋아요 
	public Post updateLikes(int pIdx, int mIdx) {
		
//		HttpSession session = request.getSession();
//		/* LoginInfo loginInfo = (LoginInfo) session.getAttribute("peeps"); */
//		Peeps loginInfo = (Peeps) session.getAttribute("peeps");
//		System.out.println("로그인 인포 세션 : "+loginInfo);
		
		int result = 0;
		
		Post post = null;
		
		try{
			// 해당 게시글 정보 post에 바인딩
			dao = template.getMapper(PostDao.class);
			post = dao.selectPostDetail(pIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// test loginInfo null인 경우 interceptor 처리
//		if(loginInfo == null) { // 로그인이 안된 경우
//			
//			// test 로그인 정보 세션 생성
//			/* loginInfo = new LoginInfo(1, "hy", "hyS2", "profile.png", 0); */
////			loginInfo = new Peeps(1, "jh@gmail.com", "1111", "jh", "jhS2", "profile.png", "안녕하세요", "1", 'Y', "email");
////			session.setAttribute("peeps", loginInfo);
//			System.out.println("로그인 인포 세션2 : "+loginInfo);
//			post.setLikeChk(0);
//			System.out.println("로그인 안된 경우 post : "+post);
//			return post;
//			
//		} else {	// 로그인 된 경우
//			System.out.println("로그인 인포 세션3 : "+loginInfo);
//			int mIdx = loginInfo.getM_idx();
			
			try {
				System.out.println("try구문 진입");
//				dao = template.getMapper(PostDao.class);
				lDao = template.getMapper(LikeDao.class);
				
				result = lDao.selectLike(pIdx, mIdx);
				// 없으면 0 있으면 1
				System.out.println("좋아요 조회 결과 : "+result); 
				
				// 좋아요 행 없는 경우(최초 좋아요 클릭) -> insert (chk = 1)
				if(result == 0) {
					System.out.println("result가 null인 경우");
					result = lDao.insertLike(pIdx, mIdx, 1);
					System.out.println("insert result(최초): "+result);
				} else {
				// 좋아요 행 있는 경우 -> chk 값 바꿔주기	
					int likeChk = lDao.selectLikeChk(pIdx, mIdx);
					
					if(likeChk == 0) {
						result = lDao.updateLike(pIdx, mIdx, 1);
						System.out.println("좋아요 chk 0 -> 1"+result);
					} else {
						result = lDao.updateLike(pIdx, mIdx, 0);
						System.out.println("좋아요 chk 1 -> 0"+result);
					}
					
				}
				
				// 게시글의 좋아요 수 업데이트 과정 시작
				int likeCheck = 0;
				likeCheck = lDao.selectLikeChk(pIdx, mIdx);
				System.out.println("좋아요 여부(0or1) 확인: "+likeCheck);
				
				if(likeCheck == 1) {
					// 좋아요 1로 바꼈으면 -> 게시글 좋아요 개수 +1 
					dao.updatePostLikes(pIdx, 1);
					post = dao.selectPostDetail(pIdx);
					post.setLikeChk(likeCheck);
					System.out.println("게시글 좋아요 개수 +1 : "+post);
				} else {
					// 좋아요 0으로 바꼈으면 -> 게시글 좋아요 개수 -1
					dao.updatePostLikes(pIdx, -1);
					post = dao.selectPostDetail(pIdx);
					post.setLikeChk(likeCheck);
					System.out.println("게시글 좋아요 개수 -1 : "+post);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
//		} 
		return post;
	}
	

	
	
	
	

}
