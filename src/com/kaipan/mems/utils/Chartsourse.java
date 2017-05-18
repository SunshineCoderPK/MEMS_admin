package com.kaipan.mems.utils;

import java.util.List;

import org.eclipse.jdt.internal.compiler.util.Sorting;

public class Chartsourse {
	private String title;
	private String[] categories;
	private List rows;
	
	public String getTitle() {
		return title;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String[] getCategories() {
		return categories;
	}
	
    public void setCategories(String[] categories) {
		this.categories = categories;
	}
	
	public List getRows() {
		return rows;
	}
	
	public void setRows(List rows) {
		this.rows = rows;
	}
} 
