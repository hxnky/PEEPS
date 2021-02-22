package com.gnjk.chat.weather;

import java.io.IOException;

import java.util.List;

import org.json.simple.parser.ParseException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/chattingData")
public class WeatherController {
   
   @Autowired
   WeatherService dao;
   
   @GetMapping
   @ResponseBody
   public List<WeatherVo> getWeatherVo() throws IOException, ParseException {
      
      return dao.getWeatherVo();
   }
   
}