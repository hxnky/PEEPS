package com.gnjk.chat.weather;

import java.io.IOException;
import java.util.List;

import org.json.simple.parser.ParseException;

public interface WeatherService {

   public  List<WeatherVo> getWeatherVo() throws IOException, ParseException;
   
}