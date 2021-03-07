package com.gnjk.peeps.Member.domain;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class GoogleRequest {

	private String clientId;
	private String clientSecret;
	private String redirectUri;
	private String grantType;
	private String code;
	private String email;
	private String picture;
	private String name;

}
