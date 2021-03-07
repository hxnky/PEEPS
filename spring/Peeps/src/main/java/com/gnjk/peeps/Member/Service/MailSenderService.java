package com.gnjk.peeps.Member.Service;

import java.io.UnsupportedEncodingException;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.gnjk.peeps.Member.domain.Peeps;

@Service
public class MailSenderService {

	@Autowired
	private JavaMailSender sender;

	public int RegSend(Peeps peeps) {

		int result = 1;

		MimeMessage message = sender.createMimeMessage();

		try {

			// 메일 제목
			message.setSubject("[PEEPS] 회원가입을 축하합니다.", "UTF-8");

			// 메일 내용 컨텐츠 html
			String html = "<h1>회원가입을 축하합니다! (●'◡'●) </h1>";
			html += "<h3>인증을 위해 아래 링크를 클릭해주세요</h3>";
			html += "<a href=\"http://52.79.227.12:8080/peeps/member/verify?m_idx=" + peeps.getM_idx() + "&code="
					+ peeps.getCode() + "\">인증하기</a>";

			// message에 내용 적용
			message.setText(html, "utf-8", "html");

			// from 설정
			message.setFrom(new InternetAddress("peeps0309@gmail.com"));

			// to 설정
			message.addRecipient(RecipientType.TO,
					new InternetAddress(peeps.getEmail(), peeps.getName() + " 님 💛", "UTF-8"));

			// 메일 발송
			sender.send(message);

		} catch (MessagingException e) {
			result = 0;
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			result = 0;
			e.printStackTrace();
		}
		return result;
	}

	public int PwSend(Peeps peeps) {
		
		int result = 1;

		MimeMessage message = sender.createMimeMessage();

		try {

			// 메일 제목
			message.setSubject("[PEEPS] 임시 비밀번호입니다.", "UTF-8");

			// 메일 내용 컨텐츠 html
			String html = "<h3>"+peeps.getId()+"</h3>";
			html += " <h1>님! PEEPS 입니다.</h1>";
			html += "<h3>아래 비밀번호는 임시 비밀번호입니다. 접속 후 비밀번호를 변경해주세요!</h3>";
			html += "<h3>"+peeps.getPassword()+"</h3>";

			// message에 내용 적용
			message.setText(html, "utf-8", "html");

			// from 설정
			message.setFrom(new InternetAddress("peeps0309@gmail.com"));

			// to 설정
			message.addRecipient(RecipientType.TO,
					new InternetAddress(peeps.getEmail(), peeps.getId() + " 님 💛", "UTF-8"));

			// 메일 발송
			sender.send(message);

		} catch (MessagingException e) {
			result = 0;
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			result = 0;
			e.printStackTrace();
		}
		return result;

	}

}
