package com.gnjk.peeps.Chat.handler;


import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.gnjk.peeps.Member.dao.MessageDao;
import com.gnjk.peeps.Member.domain.Message;
import com.google.gson.Gson;

@CrossOrigin("*")
public class ChattingHandler extends TextWebSocketHandler {

	private void log(String logmsg) {
		System.out.println(new Date() + " : " +logmsg);
	}

	private static final Logger logger = LoggerFactory.getLogger(ChattingHandler.class);

	private List<WebSocketSession> connectedSessionList;
	public ChattingHandler() {
		connectedSessionList = new ArrayList<WebSocketSession>();
	}

	private Map<String, WebSocketSession> users = new HashMap<String, WebSocketSession>();
	private List<HashMap<String, Object>> hash = new ArrayList<>(); // 웹소켓 세션을 담아둘 리스트 


	/*
	 * // 파일 업로드 private static final String FILE_UPLOAD_PATH =
	 * "/Users/seoa/Documents/websocket/"; // 파일 저장 경로 static int fileUploadIdx = 0;
	 * static String fileUploadSession = "";
	 */ 
	@Autowired
	private MessageDao dao;



	// =============================================================
	// 클라이언트 입장 
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {

		String sessionId  = (String) session.getId();

		users.put(sessionId , session);
		connectedSessionList.add(session);

		// 메세지 전송을 위한 세션 
		//HashMap<String, Object> map = new HashMap<String, Object>();
		//map.put(session.getId(), session);
		//hash.add(map);

		logger.info("{} 연결되었습니다.", session.getId()+":"+ sessionId);

		log(session.getId() + " getId() 연결 성공 ");

	}


	// =============================================================

	@Override
	protected void handleTextMessage (WebSocketSession session, TextMessage message) throws Exception {          

		String sessionId  = (String) session.getId();

		logger.info("{}로 부터 {}를 전달 받았습니다.", sessionId , message.getPayload());

		Gson gson = new Gson();
		Message mes = gson.fromJson(message.getPayload(), Message.class);

		TextMessage sendmes = new TextMessage(gson.toJson(mes));

		System.out.println("sendmes : " + sendmes);

		// 웹소켓 연결됐을 때
		for(WebSocketSession sockSession : connectedSessionList) {	 
			sockSession.sendMessage(sendmes);
		}

		dao.insertMessage(mes);

	}


	// =============================================================
	// 파일 저장을 위한 함수 
	//  BhandleBinaryMessage 메소드가 추가
	// 매개변수 BinaryMessage의 데이터를 ByteBuffer로 받아서 파일을 저장하고
	// 현재 방에 존재하는 세션에게만 ByteBuffer데이터를 전송

	/*
	 * @Override public void handleBinaryMessage(WebSocketSession session,
	 * BinaryMessage message) {
	 * 
	 * // 바이너리 메세지 전송 ByteBuffer byteBuffer = message.getPayload(); String fileName
	 * = "temp.jsp"; File dir = new File(FILE_UPLOAD_PATH);
	 * 
	 * if(!dir.exists()) { dir.mkdirs(); }
	 * 
	 * File file = new File(FILE_UPLOAD_PATH, fileName); FileOutputStream out =
	 * null; FileChannel outChannel = null;
	 * 
	 * try { byteBuffer.flip(); // byteBuffer를 읽기 위해 세팅함 out = new
	 * FileOutputStream(file, true);// 생성을 위해 OutputStream을 염 outChannel =
	 * out.getChannel(); // 채널을 열고 byteBuffer.compact() ; // 파일을 복사
	 * outChannel.write(byteBuffer); // 파일 씀
	 * 
	 * logger.info("outChannel.wrte() 까지 실행 완료 ");
	 * 
	 * }catch (Exception e) { e.printStackTrace(); }finally { try { if(out != null)
	 * { out.close(); } if (outChannel != null) { outChannel.close(); } } catch
	 * (Exception e) { e.printStackTrace(); } }
	 * 
	 * byteBuffer.position(0); // 파일을 저장하면서 position값이 변경되었으므로 0으로 초기화
	 * 
	 * // 파일 쓰기 완료 후 이미지 발송 HashMap<String, Object> temp = hash.get(fileUploadIdx);
	 * for(String k : temp.keySet()) { //if(k.equals("roomNumber")) { // continue;
	 * //} WebSocketSession wss = (WebSocketSession) temp.get(k); try {
	 * wss.sendMessage(new BinaryMessage(byteBuffer)); //초기화된 버퍼를 발송한다. } catch
	 * (IOException e) { e.printStackTrace(); } } }
	 */


	// =============================================================
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {

		String sessionId  = (String) session.getId();   // "m_idx"
		log(session.getId() + " 연결 종료 " + sessionId );

		connectedSessionList.remove(session);
		users.remove(session.getId());

		logger.info("{} 연결이 끊김", session.getId()+ sessionId );
		System.out.println("채팅 퇴장 : " + sessionId );
	}

	@Override
	public void handleTransportError (WebSocketSession session, Throwable exception) throws Exception {

		log(session.getId() + "exception 발생 : " + exception.getMessage());

	}


}