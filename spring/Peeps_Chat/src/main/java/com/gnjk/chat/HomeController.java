package com.gnjk.chat;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		// logger.info("Welcome home! The client locale is {}.", locale);
		
		/*
		 * Date date = new Date(); DateFormat dateFormat =
		 * DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.SHORT);
		 * 
		 * String formattedDate = dateFormat.format(date);
		 */
		
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
	
		
		/*
		DateTimeFormatter time = DateTimeFormatter.ofPattern("yyyy.MM.dd hh:mm:ss");
		LocalDateTime dateTime = LocalDateTime.parse(dateAsString, time);
		String dateAsString = dateTime.format(time);
		LocalDateTime now = LocalDateTime.now();
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPatter("yyyy년 M월 d일 a h시 m분");
		String nowSTring = now.format(dateTimeFormatter);
		model.addAttribute("serverTime", dateAsString);
		*/
		
		return "home";
	}
	
}
