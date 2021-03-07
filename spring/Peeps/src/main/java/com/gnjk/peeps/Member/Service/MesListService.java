package com.gnjk.peeps.Member.Service;


import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gnjk.peeps.Member.dao.MesListDao;
import com.gnjk.peeps.Member.domain.Message;

@Service
public class MesListService {

	private MesListDao dao;

	@Autowired
	private SqlSessionTemplate template;

	// 상대방과 이전 채팅
	public List<Message> mesList(int rm_idx, int me_idx) throws Exception {

		dao = template.getMapper(MesListDao.class);
		
		return dao.mesList(rm_idx, me_idx);
	}

	// 왼쪽 채팅방
	public List<Message> roomList(int me_idx) throws Exception {

		dao = template.getMapper(MesListDao.class);
		
		int rm_idx = 0;
		List<Integer> roomIdx = new ArrayList<Integer>();
		List<Message> roomList = new ArrayList<Message>();
		roomIdx = dao.roomIdxList(me_idx);
		
		System.out.println(roomIdx);
		
		for(int i = 0; i<roomIdx.size(); i++) {
			
			rm_idx = roomIdx.get(i);
			System.out.println("인덱스 확인 : " + rm_idx);
			roomList.addAll(dao.roomList(rm_idx, me_idx));
		}
		
		System.out.println(roomList);
		
		return roomList;

	}

}