package com.gnjk.peeps.Member.Service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.gnjk.peeps.Member.domain.Peeps;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Service
public class KakaoService {

	public String getAccessToken(String authorize_code) {

		String access_Token = "";
		String refresh_Token = "";
		String reqURL = "https://kauth.kakao.com/oauth/token";

		try {

			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			// POST 요청을 위해 기본값이 false인 setDoOutput을 true로 설정한다.
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);

			// POST 요청에 필요한 파라미터를 스트림을 통해 전송한다.
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=c2617392eaee575ec9e742581b354a62");
			sb.append("&redirect_uri=http://localhost:8080/peeps/login");
			sb.append("&code=" + authorize_code);
			bw.write(sb.toString());
			bw.flush();

			// 결과 코드가 200이면 성공
			int responseCode = conn.getResponseCode();
			System.out.println("결과 코드 : " + responseCode);

			// 요청을 통해 얻은 JSON타입의 Response를 읽어온다.
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}

			System.out.println("response body : " + result);

			// GSON 라이브러리에 포함된 클래스로 JSON파싱 객체를 생성한다.
			// GSON 라이브러리는 JSON 객체 파싱에 유용 !
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);

			access_Token = element.getAsJsonObject().get("access_token").getAsString();
			refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

			System.out.println("access_token : " + access_Token);
			System.out.println("refresh_token : " + refresh_Token);

			br.close();
			bw.close();

		} catch (IOException e) {

			e.printStackTrace();
		}

		return access_Token;

	}

	public HashMap<String, Object> getUserInfo(String access_Token, HttpSession session) {
		
		// 요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
		HashMap<String, Object> userInfo = new HashMap<>();
		String reqURL = "https://kapi.kakao.com/v2/user/me";

		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");

			// 요청에 필요한 Header에 포함될 내용
			conn.setRequestProperty("Authorization", "Bearer " + access_Token);

			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

			String line = "";
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);

			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);

			JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
			JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();

			String name = properties.getAsJsonObject().get("nickname").getAsString();
			String email = kakao_account.getAsJsonObject().get("email").getAsString();
			String m_photo = properties.getAsJsonObject().get("profile_image").getAsString();

			Peeps peeps = new Peeps();
			
			peeps.setEmail(email);
			peeps.setName(name);
			peeps.setM_photo(m_photo);
			peeps.setLoginType("kakao");
			
			System.out.println(peeps);
			
			session.setAttribute("peeps", peeps);
			

			userInfo.put("name", name);
			userInfo.put("email", email);
			userInfo.put("m_photo", m_photo);
			session.setAttribute("loginInfo", userInfo);

		} catch (IOException e) {
			e.printStackTrace();
		}

		return userInfo;
	}

	public void kakaoLogout(String access_Token) {
		String reqURL = "https://kapi.kakao.com/v1/user/logout";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization", "Bearer " + access_Token);

			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

			String result = "";
			String line = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println(result);

		} catch (IOException e) {

			e.printStackTrace();
		}
	}

}
