package com.gnjk.peeps.domain;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EditRequest {

	private String email;
	private String id;
	private String name;
	private String bio;
	private String password;
	private String oldPhoto;
	private MultipartFile m_photo;

	@Override
	public String toString() {
		return "EditRequest [email=" + email + ", id=" + id + ", name=" + name + ", bio=" + bio + ", password="
				+ password + ", oldPhoto=" + oldPhoto + ", m_photo=" + m_photo.getOriginalFilename() + "]";
	}

	public Peeps getToPeeps() {
		
		Peeps peeps = new Peeps();
		
		peeps.setEmail(email);
		peeps.setBio(bio);
		peeps.setId(id);
		peeps.setName(name);
		peeps.setPassword(password);
		
		return peeps;
	}
}