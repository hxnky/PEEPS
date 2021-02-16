package com.gnjk.chat.weather;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;

@RestController
public class Weather {

	// List<WeatherVo> getWeatherVo()
	
	//List<WeatherVo> datalist = new ArrayList<WeatherVo>();
	@PostMapping(value="/requestObject")
	public  List<WeatherVo> getWeatherVo() throws IOException, ParseException {
		DateFormat sdFormat = new SimpleDateFormat("yyyyMMdd");
		Date nowDate = new Date();
		String tempDate = sdFormat.format(nowDate);

		// JSON데이터를 요청하는 URLstr을 만듭니다.
		String apiUrl = "http://apis.data.go.kr/1360000/VilageFcstInfoService/getVilageFcst";
		// 홈페이지에서 받은 키
		String serviceKey = "CyU7GKW405FaYFWwbOVK8LkVHHXf3Nyv%2FchLLVJu52OyDB%2BpWDij0tEDQLjk8%2BMpOYkiw3TSwWrNEXMXls%2BiOQ%3D%3D";
		String pageNo = "1";
		String numOfRows = "225"; // 한 페이지 결과 수
		String data_type = "JSON"; // 타입 xml, json 등등 ..
		String baseDate = "20210216"; // "20200821"이런식으로 api에서 제공하는 형식 그대로 적으시면 됩니당.
		String baseTime = "0500"; // API 제공 시간을 입력하면 됨
		String nx = "60"; // 위도
		String ny = "127"; // 경도

		// 전날 23시 부터 153개의 데이터를 조회하면 오늘과 내일의 날씨를 알 수 있음
		WeatherVo vl = new WeatherVo();
		StringBuilder urlBuilder = new StringBuilder(apiUrl);
		urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=" + serviceKey);
		urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "="+ URLEncoder.encode(numOfRows, "UTF-8")); /* 한 페이지 결과 수 */
		urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode(pageNo, "UTF-8"));
		urlBuilder.append("&" + URLEncoder.encode("dataType", "UTF-8") + "=" + URLEncoder.encode(data_type, "UTF-8")); /* 타입 */	
		urlBuilder.append("&" + URLEncoder.encode("base_date", "UTF-8") + "="+ URLEncoder.encode(baseDate, "UTF-8")); /* 조회하고싶은 날짜 */
		urlBuilder.append("&" + URLEncoder.encode("base_time", "UTF-8") + "="+ URLEncoder.encode(baseTime, "UTF-8")); /* 조회하고싶은 시간 AM 02시부터 3시간 단위 */
		urlBuilder.append("&" + URLEncoder.encode("nx", "UTF-8") + "=" + URLEncoder.encode(nx, "UTF-8")); // 경도
		urlBuilder.append("&" + URLEncoder.encode("ny", "UTF-8") + "=" + URLEncoder.encode(ny, "UTF-8")+"&"); // 위도


		/* GET방식으로 전송해서 파라미터 받아오기*/
		URL url = new URL(urlBuilder.toString());
		// 어떻게 넘어가는지 확인하고 싶으면 아래 출력분 주석 해제
		System.out.println(url);

		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json");
		System.out.println("Response code: " + conn.getResponseCode());
		BufferedReader rd;
		if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		rd.close();
		conn.disconnect();
		String result = sb.toString();
		System.out.println("결과: " + result);
		// 문자열을 JSON으로 파싱
		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObj = (JSONObject) jsonParser.parse(result);
		JSONObject parse_response = (JSONObject) jsonObj.get("response");
		JSONObject parse_body = (JSONObject) parse_response.get("body");// response 로 부터 body 찾아오기
		JSONObject parse_items = (JSONObject) parse_body.get("items");// body 로 부터 items 받아오기
		// items로 부터 itemlist 를 받아오기
		// itemlist : 뒤에 [ 로 시작하므로 jsonarray
		JSONArray parse_item = (JSONArray) parse_items.get("item");

		JSONObject obj;
		String category; // 기준 날짜와 기준시간을 WeatherVo 객체에 저장

		String day = "";
		String time = "";

		List<WeatherVo> datalist = new ArrayList<WeatherVo>();
		for (int i = 0; i < parse_item.size(); i++) {
			obj = (JSONObject) parse_item.get(i); // 해당 item을 가져옵니다.

			Object fcstValue = obj.get("fcstValue");
			Object fcstDate = obj.get("fcstDate");
			Object fcstTime = obj.get("fcstTime");
			category = (String) obj.get("category"); // item에서 카테고리를 검색
			// 검색한 카테고리와 일치하는 변수에 문자형으로 데이터를 저장
			// 데이터들이 형태가 달라 문자열로 통일해서 저장 -> 꺼내서 사용할때 다시 변환

			switch (category) {
			case "SKY":
				vl.SKY = (obj.get("fcstValue")).toString();
				break;
			case "PTY ":
				vl.PTY = (obj.get("fcstValue")).toString();
				break;
			case "T3H":
				vl.T3H = (obj.get("fcstValue")).toString();
				break;
			}
			if (!day.equals(fcstDate.toString())) {
				day = fcstDate.toString();
			}
			if (!time.equals(fcstTime.toString())) {
				time = fcstTime.toString();
				System.out.println("데이: "+ day + "  " +"타임: "+ time);
			}		

			vl.baseDate = (obj.get("fcstDate")).toString();
			vl.baseTime = (obj.get("fcstTime")).toString();

			WeatherVo test = new WeatherVo();
			test.setSKY(vl.getSKY());
			test.setPTY(vl.getPTY());
			test.setT3H(vl.getT3H());
			test.setBaseDate(vl.getBaseDate());
			test.setBaseTime(vl.getBaseTime());
			
			System.out.print("\tcategory : " + category);
			System.out.print(", fcst_Value : " + fcstValue);
			System.out.print(", fcstDate : " + vl.baseDate);
			System.out.println(", fcstTime : " + vl.baseTime);		

			//test = vl;
			if(category.equals("SKY")) {
				System.out.println("HAHA!");
				datalist.add(test);
			} else if(category.equals("PTY")) {
				System.out.println("HAHA!");
				datalist.add(test);
			} else if(category.equals("T3H")) {
				System.out.println("HAHA!");
				datalist.add(test);
			}
			else {
				System.out.println(":(");
			}

		}	

		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(datalist);		// Serialization : Object -> Json(String)
		System.out.println(jsonStr);	// jsonStr :  Json(String)
		
		System.out.println(datalist);	
		
		return datalist;		// ArrayList<WeatherVo>()
	}
	
}