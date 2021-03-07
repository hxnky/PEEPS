
# BITACADEMY 

## 1.소개

![1_peeps_intro](https://user-images.githubusercontent.com/71624723/110078703-7b930d80-7dcb-11eb-98ab-476979fb197d.png)

## 2.구조 
      * MSA아키텍처  RESRFUL
      
## 3.개발환경
  
  * 웹 표준 및 프론트앤드 
   
    *  HTML 5
    *  CSS3
    * JavaScript
    * jQuery
    * JSON
    * JSP
    * Bootstrap
    
  * 백앤드
    * Spring FrameWork
    * Java
    * Python
    *  JSP, EL
    *  EC2
    *  S3
    *  mybatis
    *  junit
  
  * WAS
    * Appache Tomcat
  
  * DBMS
    * mysql
    
  * 구현도구
    * Eclipse 
    * SPRING TOOL SUITE 
    * Maven
    * visual studio
    * github
    * putty
    * exerd
  
  * API
    * KAKAO LOGIN API
    * KAKAO MAP API
    * GOOGLE LOGIN API 
    * 공공데이터포털 동네 날씨 예보 API
   
  * AWS배포: 
    
    * EC2
    * RDS
    * S3 
    * FileZila를 이용한 FTP 업로드
    * Putty를 이용한 SSH 접속

  ## 4. 주요기능
  ### +회원
  ![4_member_main_function](https://user-images.githubusercontent.com/71624723/110081257-01fd1e80-7dcf-11eb-91db-2d8dd63eb037.png)
  
  
  ### +채팅
  ![리드미용_서아_016](https://user-images.githubusercontent.com/71997900/110234427-bf257d00-7f6d-11eb-9a21-794f15caf856.png)
  + WebSocket을 이용한 1:1 채팅 
  ```c
  public class ChattingHandler extends TextWebSocketHandler {
  
     private Map<String, WebSocketSession> users = new HashMap<String, WebSocketSession>();
  
  @Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
          String sessionId  = (String) session.getId();

		users.put(sessionId , session);
      }
      
  @Override
	protected void handleTextMessage (WebSocketSession session, TextMessage message) throws Exception { 
     
          String sessionId  = (String) session.getId();
          
          Gson gson = new Gson();
		Message mes = gson.fromJson(message.getPayload(), Message.class);

		TextMessage sendmes = new TextMessage(gson.toJson(mes));
     }
     
     @Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
     
          String sessionId  = (String) session.getId(); 
          users.remove(session.getId());
     }
  ```

  ![리드미용_서아-017](https://user-images.githubusercontent.com/71997900/110233973-2261e000-7f6b-11eb-822b-ed38fd7de860.png)


  
 
