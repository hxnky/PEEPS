package com.gnjk.gb.domain;

import java.sql.Timestamp;


import lombok.Getter;
import lombok.Setter;






@Getter
@Setter

public class Guestbook {
	
	private int gidx;
	private String gwriter; 
	private Timestamp gdate;
	private String gmessage;
	private  String gphoto;
	private int midx;
	private String etype;
	private String mphoto;
	private int myP_midx;
	
	
	@Override
	public String toString() {
		return "Guestbook [gidx=" + gidx + ", gwriter=" + gwriter + ", gdate=" + gdate + ", gmessage=" + gmessage
				+ ", gphoto=" + gphoto + ", midx=" + midx + ", etype=" + etype + ", mphoto=" + mphoto + ", myP_midx="
				+ myP_midx + "]";
	}
	
	
	
	
	
	
	



}
