package com.gnjk.peeps.auth.Controller;

import java.io.IOException;
import java.net.URI;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.PropertyNamingStrategy;
import com.gnjk.peeps.auth.domain.GoogleRequest;
import com.gnjk.peeps.auth.domain.GoogleResponse;

@Controller
public class GoogleController {

	final static String GOOGLE_AUTH_BASE_URL = "https://accounts.google.com/o/oauth2/v2/auth";
	final static String GOOGLE_TOKEN_BASE_URL = "https://oauth2.googleapis.com/token";

	private String clientId = "932809958130-576t52vbv3m0dq8ei051noieo4lhauc1.apps.googleusercontent.com";
	private String clientSecret = "7wyexcIGQj61JPsW2xNG5mXo";

	@RequestMapping("/glogin")
	public String googleAuth(Model model, @RequestParam(value = "code") String authCode, HttpSession session)
			throws JsonProcessingException {

		int result = 2;

		// HTTP Request를 위한 RestTemplate
		RestTemplate restTemplate = new RestTemplate();

		// Google OAuth Access Token 요청을 위한 파라미터 세팅
		GoogleRequest googleOAuthRequestParam = GoogleRequest.builder().clientId(clientId).clientSecret(clientSecret)
				.code(authCode).redirectUri("http://localhost:8080/peeps/glogin").grantType("authorization_code")
				.build();

		// JSON 파싱을 위한 기본값 세팅
		// 요청시 파라미터는 스네이크 케이스로 세팅되므로 Object mapper에 미리 설정해준다.
		ObjectMapper mapper = new ObjectMapper();
		mapper.setPropertyNamingStrategy(PropertyNamingStrategy.SNAKE_CASE);
		mapper.setSerializationInclusion(Include.NON_NULL);

		// AccessToken 발급 요청
		ResponseEntity<String> resultEntity = restTemplate.postForEntity(GOOGLE_TOKEN_BASE_URL, googleOAuthRequestParam,
				String.class);

		// Token Request
		GoogleResponse Result = mapper.readValue(resultEntity.getBody(), new TypeReference<GoogleResponse>() {
		});

		// ID Token만 추출 (사용자의 정보는 jwt로 인코딩 되어있다)
		// resttemplate의 경우 String으로 값이 들어오면 알아서 encode를 해준다.
		String jwtToken = Result.getIdToken();
		String requestUrl = UriComponentsBuilder.fromHttpUrl("https://oauth2.googleapis.com/tokeninfo")
				.queryParam("id_token", jwtToken).toUriString();

		String resultJson = restTemplate.getForObject(requestUrl, String.class);

		Map<String, String> userInfo = mapper.readValue(resultJson, new TypeReference<Map<String, String>>() {
		});

		// 구글은 확장자 없어서 오류난다 --> <c:if>로 분기 만들어서 img 경로 다르게 사용하기
//		// 사진 주소
//		String m_photo = userInfo.get("picture");
//		URI uri = URI.create(m_photo);
//
//		// 사진 파일 다운로드
//		RestTemplate rt = new RestTemplate();
//		ResponseEntity<byte[]> res = rt.getForEntity(uri, byte[].class);
//		byte[] buffer = res.getBody();
//
//		// 로컬 서버에 저장
//		// String fileName = UUID.randomUUID().toString(); // 랜덤 이름!
//		String ext = "." + StringUtils.getFilenameExtension(m_photo); // 확장자 추출
//		Path target = Paths.get(
//				"C:\\Users\\hanky\\Desktop\\bit\\PEEPS\\peeps_spring\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\Peeps_member\\fileupload",
//				m_photo + ".jpg");
//
//		try {
//			FileCopyUtils.copy(buffer, target.toFile());
//		} catch (IOException e) {
//			e.printStackTrace();
//		}

		session.setAttribute("userInfo", userInfo);
		session.setAttribute("access_Token", Result.getAccessToken());
		
		model.addAttribute("loginType", "google");
		model.addAttribute("email", userInfo.get("email"));
		model.addAttribute("name", userInfo.get("name"));
		model.addAttribute("m_photo", userInfo.get("picture"));
		model.addAttribute("token", Result.getAccessToken());
		model.addAttribute("result", result);
		
		session.setAttribute("email", userInfo.get("email"));
		session.setAttribute("name", userInfo.get("name"));
		session.setAttribute("loginType","google");
		
		System.out.println(userInfo);
		System.out.println("이메일 : " + userInfo.get("email"));
		System.out.println("이름 : " + userInfo.get("name"));
		System.out.println("사진 URL : " + userInfo.get("picture"));

		return "member/SocialRegForm";

	}

}
