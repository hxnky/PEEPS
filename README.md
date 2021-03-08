
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

## 5. 배포주소
http://52.79.227.12:8080/peeps/

## 6. 어려웠던점과 해결방법
  
  * 채팅 배포
        로컬 호스트에서는 잘 돌아가는 채팅 프로젝트가 클라이언트에 연결하자 크로스 오리진이 발생하였다. 따라서 클라이언트와 채팅을 합치기로 하였는데, 합친 후 크로스 오리진은 발생하지 않았지	         만 핸드셰이크 500 에러가 발생하였다.
	확인 해 본 결과 소켓 자체는 열렸는데 서버에서 소켓을 업그레이드 하는 과정에서 오류가 생긴 것 같았다. 로컬호스트의 톰캣의 경우 8.5버전을 사용하였는데 ec2 터미널의 톰캣 서버를 확인해보	   니 7.6 버전이었다. 따라서 ec2의 톰캣 또한 8.5버전으로 업그레이드 하였고 채팅 배포를 성공할 수 있었다.
	
 *REST API
      프로젝트 초반에  모든 데이터들을 controller에서 model으로 전달해 줬었다. 그러나 우리는 서버와 클라이언트 통신을 위해 rest인터페이스를 구현하는 방식으로 개발을 해야했다. 
      그래서 동기통신에서 비동기통신으로 바꿔야 했고 그 과정에서 많은 공부와 프로젝트의 이해가 필요했다.  모든 기능을  ajax로 바꾸고 json으로 파싱해주었고, MSA방식의 구조를 이해 할 수 있었다. 
 
