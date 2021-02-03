package com.gnjk.peeps.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RegRequest {

	private String email;
	private String id;
	private String name;
	private String password;
	
	@Override
	public String toString() {
		return "RegRequest [email=" + email + ", id=" + id + ", name=" + name + "]";
	}

	public RegRequest(String email, String id, String name) {
		super();
		this.email = email;
		this.id = id;
		this.name = name;
	}

	public Peeps toPeeps() {
		
		Peeps peeps = new Peeps();
		
		peeps.setEmail(email);
		peeps.setId(id);
		peeps.setName(name);
		peeps.setPassword(password);
		
		return peeps;
	}
	
public Peeps toGPeeps() {
		
		Peeps peeps = new Peeps();
		
		peeps.setEmail(email);
		peeps.setId(id);
		peeps.setName(name);
		
		return peeps;
	}
}
