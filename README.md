
# BITACADEMY 

## 1.소개

![1_peeps_intro](https://user-images.githubusercontent.com/71624723/110078703-7b930d80-7dcb-11eb-98ab-476979fb197d.png)

## 2.구조 
 * MSA아키텍처  RESRFUL
  ![제목 없는 프레젠테이션 (1)](https://user-images.githubusercontent.com/71998081/110272493-aff60c00-800d-11eb-872f-57b80cd722d8.jpg)

 

      
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
  + 프로필
  ![정현-010](https://user-images.githubusercontent.com/71624723/110286120-b72a1380-8027-11eb-999f-e9d4a2e962f3.png)
  + 게시글 작성
  ![정현-011](https://user-images.githubusercontent.com/71624723/110286122-b8f3d700-8027-11eb-807b-87f6172d60b1.png)
  + 게시글 리스트
  ![정현-012](https://user-images.githubusercontent.com/71624723/110286134-bf824e80-8027-11eb-85a3-aaf93321ae3c.png)
  + 게시글 상세보기
  ![정현-013](https://user-images.githubusercontent.com/71624723/110286144-c3ae6c00-8027-11eb-9b54-eb98a351a6c8.png)
  + 지도
  ![정현-014](https://user-images.githubusercontent.com/71624723/110286146-c5782f80-8027-11eb-8934-8ce02a895d57.png)
  + 방명록 리스트
  ![리드미-명지-016](https://user-images.githubusercontent.com/71998081/110289261-87313f00-802c-11eb-9642-25844399f6f3.jpg)
  + 방명록 CRUD
  ![리드미-명지-017](https://user-images.githubusercontent.com/71998081/110289455-cbbcda80-802c-11eb-82d9-336fe88e9980.jpg)


  ### - 채팅
  + WebSocket을 이용한 1:1 채팅
  ![리드미용_서아-016](https://user-images.githubusercontent.com/71997900/110496011-6a822d80-8138-11eb-9c57-6cd56ec4ecd8.png)
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
   }
  ```
  ![리드미용_서아-017](https://user-images.githubusercontent.com/71997900/110497018-6c98bc00-8139-11eb-9f1b-38b4aa57751e.png)
  + 회원 검색
  ![리드미용_서아-018](https://user-images.githubusercontent.com/71997900/110496119-85ed3880-8138-11eb-9f2b-5078a0703ca1.png)
  + 날씨 API
  ![리드미용_서아-019](https://user-images.githubusercontent.com/71997900/110496180-956c8180-8138-11eb-84d7-79d12a67c18b.png)
  + 메세지 전송
  ![리드미용_서아-020](https://user-images.githubusercontent.com/71997900/110496283-ac12d880-8138-11eb-9422-84d3d8082ca2.png)
 
  ### - 알람
  + Alarm
  ![리드미용_서아-021](https://user-images.githubusercontent.com/71997900/110496431-cea4f180-8138-11eb-84b6-ca255465c054.png)
  + 실시간 알람
  ![리드미용_서아-022](https://user-images.githubusercontent.com/71997900/110496482-dbc1e080-8138-11eb-8716-af5253c1fd98.png)
  + 알람 아이콘
  ![리드미용_서아-023](https://user-images.githubusercontent.com/71997900/110496515-e54b4880-8138-11eb-894f-868253107401.png)



## 5. 배포주소
[PEEPS 홈페이지🐥](http://52.79.227.12:8080/peeps/)

[시연영상🎬](https://youtu.be/gkNfDAoEMOA)

## 6. 어려웠던점과 해결방법
  
  * 채팅 배포
        로컬 호스트에서는 잘 돌아가는 채팅 프로젝트가 클라이언트에 연결하자 크로스 오리진이 발생하였다. 따라서 클라이언트와 채팅을 합치기로 하였는데, 합친 후 크로스 오리진은 발생하지 않았지	         만 핸드셰이크 500 에러가 발생하였다.
	확인 해 본 결과 소켓 자체는 열렸는데 서버에서 소켓을 업그레이드 하는 과정에서 오류가 생긴 것 같았다. 로컬호스트의 톰캣의 경우 8.5버전을 사용하였는데 ec2 터미널의 톰캣 서버를 확인해보	   니 7.6 버전이었다. 따라서 ec2의 톰캣 또한 8.5버전으로 업그레이드 하였고 채팅 배포를 성공할 수 있었다.
	
 * REST API
      프로젝트 초반에  모든 데이터들을 controller에서 model으로 전달해 줬었다. 그러나 우리는 서버와 클라이언트 통신을 위해 rest인터페이스를 구현하는 방식으로 개발을 해야했다. 
      그래서 동기통신에서 비동기통신으로 바꿔야 했고 그 과정에서 많은 공부와 프로젝트의 이해가 필요했다.  모든 기능을  ajax로 바꾸고 json으로 파싱해주었고, MSA방식의 구조를 이해하고 순조롭게       프로젝트를 이어갈 수 있었다
 
