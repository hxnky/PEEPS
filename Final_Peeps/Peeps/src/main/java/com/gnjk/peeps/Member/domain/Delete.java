package com.gnjk.peeps.Member.domain;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Delete {

	private int w_idx;
	private String email;
	private String reason;
	private Timestamp w_data;

	@Override
	public String toString() {
		return "DeleteRequest [w_idx=" + w_idx + ", email=" + email + ", reason=" + reason + ", w_data=" + w_data + "]";
	}

	public Delete(int w_idx, String email, String reason, Timestamp w_data) {
		super();
		this.w_idx = w_idx;
		this.email = email;
		this.reason = reason;
		this.w_data = w_data;
	}

}
