
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
  ### - 회원
  + 회원가입
  ![리드미용_서아-008](https://user-images.githubusercontent.com/71997900/110235350-ec285e80-7f72-11eb-8845-0ea63339245d.png)

  + 로그인
  ![리드미용_서아-009](https://user-images.githubusercontent.com/71997900/110235353-ef234f00-7f72-11eb-8fc8-074036196264.png)
  
  ### - 타임라인
  ![리드미용_서아-010](https://user-images.githubusercontent.com/71997900/110235385-10843b00-7f73-11eb-85b1-04a56a373b61.png)
  + 유저검색
  ![리드미용_서아-011](https://user-images.githubusercontent.com/71997900/110235397-1ed25700-7f73-11eb-9803-87008d34fb9f.png)
  + 게시글 검색
  ![리드미용_서아-012](https://user-images.githubusercontent.com/71997900/110235409-2691fb80-7f73-11eb-87fe-f1429ed1e9ec.png)

  ### - 마이페이지
  ![리드미용_서아-013](https://user-images.githubusercontent.com/71997900/110235420-30b3fa00-7f73-11eb-88a9-b03c0d989578.png)
  
  ![리드미용_서아-014](https://user-images.githubusercontent.com/71997900/110235430-3d385280-7f73-11eb-824f-88d5a91a6210.png)
  
  ![리드미용_서아-015](https://user-images.githubusercontent.com/71997900/110235434-41fd0680-7f73-11eb-9815-dadd0f24628e.png)

  
  ### - 채팅
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


  
 
