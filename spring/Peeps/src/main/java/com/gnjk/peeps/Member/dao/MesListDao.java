package com.gnjk.peeps.Member.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.gnjk.peeps.Member.domain.Message;

public interface MesListDao {
		
		public List<Message> mesList(@Param("rm_idx") int rm_idx, @Param("me_idx") int me_idx) throws Exception;
		
		public List<Message> roomList(@Param("rm_idx") int rm_idx, @Param("me_idx") int me_idx) throws Exception;
		
		// 21.03.07 한경 추가
		public List<Integer> roomIdxList(int me_idx) throws Exception;
		
}