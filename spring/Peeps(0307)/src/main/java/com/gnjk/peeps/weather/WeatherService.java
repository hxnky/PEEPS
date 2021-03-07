package com.gnjk.peeps.weather;

import java.io.IOException;
import java.util.List;

import org.json.simple.parser.ParseException;

public interface WeatherService {

   public  List<WeatherVo> getWeatherVo() throws IOException, ParseException;
   
}