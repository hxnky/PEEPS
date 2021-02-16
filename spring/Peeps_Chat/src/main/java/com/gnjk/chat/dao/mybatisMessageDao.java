package com.gnjk.chat.dao;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.web.socket.TextMessage;

import com.gnjk.chat.domain.Message;

@Repository
public interface mybatisMessageDao {
	
	String nameSpace = "com.gnjk.chat.dao.mybatisMessageDao";
	
	public static JdbcTemplate template = new JdbcTemplate();
	

	public default  int insertMessage(TextMessage message) {
		return template.update(nameSpace+".insertMessage", message);
	}


}
