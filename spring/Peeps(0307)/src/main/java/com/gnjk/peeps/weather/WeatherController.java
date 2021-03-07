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

@Controller

@RequestMapping("/chattingData")
public class WeatherController {
   
   @Autowired
   WeatherService service;
   
   @GetMapping
   @ResponseBody
   public List<WeatherVo> getWeatherVo() throws IOException, ParseException {
      System.out.println("날씨 컨트롤러 거쳐지나요???");
      return service.getWeatherVo();
   }
   
}