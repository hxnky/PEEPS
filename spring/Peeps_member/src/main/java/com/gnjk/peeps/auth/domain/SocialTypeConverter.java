package com.gnjk.peeps.auth.domain;

import org.springframework.context.annotation.Configuration;
import org.springframework.core.convert.converter.Converter;

@Configuration
public class SocialTypeConverter implements Converter<String, SocialType> {
	@Override
	public SocialType convert(String str) {
		
		return SocialType.valueOf(str.toUpperCase());
	}
}