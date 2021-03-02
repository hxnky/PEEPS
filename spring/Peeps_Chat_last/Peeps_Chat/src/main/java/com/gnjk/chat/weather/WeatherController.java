package com.gnjk.chat.weather;

import java.io.IOException;

import java.util.List;

import org.json.simple.parser.ParseException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;

import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class WeatherController {
   
   @Autowired
   WeatherService dao;
   
   @CrossOrigin
   @RequestMapping(value = "weather/data")
   public List<WeatherVo> getWeatherVo() throws IOException, ParseException {
      
      return dao.getWeatherVo();
   }
   
}