package com.gnjk.peeps.Member.domain;

import lombok.Data;

@Data
public class GoogleResponse {

	private String accessToken;
	private String expiresIn;
	private String refreshToken;
	private String scope;
	private String tokenType;
	private String idToken;
	
	
}
