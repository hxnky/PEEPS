package com.gnjk.peeps.weather;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class WeatherServiceImpl implements WeatherService {

   public  List<WeatherVo> getWeatherVo()  throws IOException, ParseException {
      
      Date nowDate = new Date();

      Calendar cal = Calendar.getInstance();
      cal.setTime(nowDate); // 10분 더하기 cal.add(Calendar.MINUTE, 10);
      
      if(cal.HOUR < 60) {   // 오전 5시부터 날씨 api 가능 => 자정~오전5시 : 하루 전
         Date yesterday = new Date(nowDate.getTime ( ) - (long) ( 1000 * 60 * 60 * 5));
         nowDate = yesterday;
      }
      
      DateFormat sdFormat = new SimpleDateFormat("yyyyMMdd");
      String tempDate = sdFormat.format(nowDate);
      
      String apiUrl = "http://apis.data.go.kr/1360000/VilageFcstInfoService/getVilageFcst";
      
      String serviceKey = "CyU7GKW405FaYFWwbOVK8LkVHHXf3Nyv%2FchLLVJu52OyDB%2BpWDij0tEDQLjk8%2BMpOYkiw3TSwWrNEXMXls%2BiOQ%3D%3D";
      String pageNo = "1";
      String numOfRows = "225";
      String data_type = "JSON";
      String baseDate = tempDate; 
      String baseTime = "0500";
      String nx = "60";
      String ny = "127";
      
      StringBuilder urlBuilder = new StringBuilder(apiUrl);
      urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=" + serviceKey);
      urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "="+ URLEncoder.encode(numOfRows, "UTF-8")); // 한 페이지 결과 수
      urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode(pageNo, "UTF-8")); // 페이지 번호 
      urlBuilder.append("&" + URLEncoder.encode("dataType", "UTF-8") + "=" + URLEncoder.encode(data_type, "UTF-8")); // 타입 
      urlBuilder.append("&" + URLEncoder.encode("base_date", "UTF-8") + "="+ URLEncoder.encode(baseDate, "UTF-8")); // 조회하고싶은 날짜 
      urlBuilder.append("&" + URLEncoder.encode("base_time", "UTF-8") + "="+ URLEncoder.encode(baseTime, "UTF-8")); // 조회하고싶은 시간 AM 02시부터 3시간 단위  
      urlBuilder.append("&" + URLEncoder.encode("nx", "UTF-8") + "=" + URLEncoder.encode(nx, "UTF-8")); // 경도
      urlBuilder.append("&" + URLEncoder.encode("ny", "UTF-8") + "=" + URLEncoder.encode(ny, "UTF-8")+"&"); // 위도

      // GET방식으로 전송해서 파라미터 받아오기 
      URL url = new URL(urlBuilder.toString());
      
      HttpURLConnection conn = (HttpURLConnection) url.openConnection();
      conn.setRequestMethod("GET");
      conn.setRequestProperty("Content-type", "application/json");
      System.out.println("Response code: " + conn.getResponseCode());
      BufferedReader rd;
      System.out.println("1 날씨 서비스Impl");
      if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
         rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
      } else {
         rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
      }
      System.out.println("2 날씨 서비스Impl");
      StringBuilder sb = new StringBuilder();
      String line;
      
      while ((line = rd.readLine()) != null) {
         sb.append(line);
      }
      System.out.println("3 날씨 서비스Impl");
      rd.close();
      conn.disconnect();
      String result = sb.toString();
      System.out.println("4 날씨 서비스Impl");
      
      // 문자열을 JSON으로 파싱
      JSONParser jsonParser = new JSONParser();
      JSONObject jsonObj = (JSONObject) jsonParser.parse(result);
      JSONObject parse_response = (JSONObject) jsonObj.get("response");
      JSONObject parse_body = (JSONObject) parse_response.get("body"); // response 로 부터 body 찾아오기
      JSONObject parse_items = (JSONObject) parse_body.get("items"); // body 로 부터 items 받아오기
      // items로 부터 itemlist 를 받아오기
      // itemlist : 뒤에 [ 로 시작하므로 JSONArray
      JSONArray parse_item = (JSONArray) parse_items.get("item");

      JSONObject obj;
      String category; // WeatherVo 객체에 날짜,시간 저장

      String day = "";
      String time = "";
      
      List<WeatherVo> datalist = new ArrayList<WeatherVo>();
      
      for (int i = 0; i < parse_item.size(); i++) {
         obj = (JSONObject) parse_item.get(i);

         Object fcstValue = obj.get("fcstValue");
         Object fcstDate = obj.get("fcstDate");
         Object fcstTime = obj.get("fcstTime");
         category = (String) obj.get("category"); // item에서 카테고리 검색
         // 검색한 카테고리와 일치하는 변수에 문자형으로 데이터 저장
         // 데이터들이 형태가 달라 문자열로 저장 -> 꺼내서 사용할때 다시 변환
         
         WeatherVo vl = new WeatherVo();
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
         }      

         vl.baseDate = (obj.get("fcstDate")).toString();
         vl.baseTime = (obj.get("fcstTime")).toString();

         WeatherVo test = new WeatherVo();
         test.setSKY(vl.getSKY());
         test.setPTY(vl.getPTY());
         test.setT3H(vl.getT3H());
         test.setBaseDate(vl.getBaseDate());
         test.setBaseTime(vl.getBaseTime());
         
         if(category.equals("SKY")) {
            datalist.add(test);
         } else if(category.equals("PTY")) {
            datalist.add(test);
         } else if(category.equals("T3H")) {
            datalist.add(test);
         }
         else {
         }
      }   

      ObjectMapper mapper = new ObjectMapper();
      String jsonStr = mapper.writeValueAsString(datalist); 
      
      return datalist; // ArrayList<WeatherVo>()
   }
   

}