package com.gnjk.peeps.weather;

import java.io.IOException;
import java.util.List;

import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

// 날씨 API
@Controller
@RequestMapping("/chattingData")
public class WeatherController {
   
   @Autowired
   WeatherService service;
   
   @GetMapping
   @ResponseBody
   public List<WeatherVo> getWeatherVo() throws IOException, ParseException {
	   
      return service.getWeatherVo();
      
   }
}