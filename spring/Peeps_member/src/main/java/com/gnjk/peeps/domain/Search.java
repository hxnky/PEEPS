package com.gnjk.peeps.domain;

import java.util.List;

import lombok.Getter;

@Getter
public class Search {

	private List<Peeps> peepsList;

	@Override
	public String toString() {
		return "Search [peepsList=" + peepsList + "]";
	}

	public Search(List<Peeps> peepsList) {
		super();
		this.peepsList = peepsList;
	}
	
	
	
}
