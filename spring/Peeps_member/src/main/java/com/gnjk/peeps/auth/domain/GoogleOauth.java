package com.gnjk.peeps.auth.domain;

import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Component;

import com.gnjk.peeps.auth.dao.SocialDao;

@Component
public class GoogleOauth implements SocialDao {

	// @Value("${sns.google.url}")
	private String GOOGLE_SNS_BASE_URL = "https://accounts.google.com/o/oauth2/v2/auth";
	// @Value("${sns.google.client.id}")
	private String GOOGLE_SNS_CLIENT_ID = "932809958130-576t52vbv3m0dq8ei051noieo4lhauc1.apps.googleusercontent.com";
	// @Value("${sns.google.callback.url}")
	private String GOOGLE_SNS_CALLBACK_URL = "http://localhost:8080/peeps/auth/google/callback";
	// @Value("${sns.google.client.secret}")
	private String GOOGLE_SNS_CLIENT_SECRET = "7wyexcIGQj61JPsW2xNG5mXo";

	@Override
	public String getOauthRedirectURL() {

		Map<String, Object> params = new HashMap<>();

		params.put("scope", "profile");
		params.put("response_type", "code");
		params.put("client_id", GOOGLE_SNS_CLIENT_ID);
		params.put("redirect_uri", GOOGLE_SNS_CALLBACK_URL);

		String parameterString = params.entrySet().stream().map(x -> x.getKey() + "=" + x.getValue())
				.collect(Collectors.joining("&"));

		return GOOGLE_SNS_BASE_URL + "?" + parameterString;
	}

}
