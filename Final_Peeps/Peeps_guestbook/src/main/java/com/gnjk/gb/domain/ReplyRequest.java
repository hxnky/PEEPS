package com.gnjk.gb.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReplyRequest {


	private int g_idx;
	private int midx;
	private String gwriter; 
	private String rmsg;
	
	
	
	public Reply toReply() {

		Reply reply = new Reply();
		reply.setG_idx(g_idx);
		reply.setGwriter(gwriter);
		reply.setMidx(midx);
		reply.setRmsg(rmsg);
		return reply;

	}
	
	@Override
	public String toString() {
		return "replyRequest [gidx=" + g_idx + ", midx=" + midx + ", gwriter=" + gwriter + ", rmsg=" + rmsg + "]";
	}
	
	
}
