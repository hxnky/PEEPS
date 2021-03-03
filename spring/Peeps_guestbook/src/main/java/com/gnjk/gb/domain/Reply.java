package com.gnjk.gb.domain;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
@Getter
@Setter
public class Reply {

	private int ridx;
	private int g_idx;
	private int midx;
	private String gwriter; 
	private String rmsg;
	private Timestamp rdate;
	
	
	@Override
	public String toString() {
		return "reply [ridx=" + ridx + ", gidx=" + g_idx + ", midx=" + midx + ", gwriter=" + gwriter + ", rmsg=" + rmsg
				+ ", rdate=" + rdate + "]";
	}
	
	
}
