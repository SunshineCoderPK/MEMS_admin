package com.kaipan.mems.domain;
// Generated 2017-4-27 21:51:34 by Hibernate Tools 4.0.1.Final

import java.util.HashSet;
import java.util.Set;

/**
 * Hospital generated by hbm2java
 */
public class Hospital implements java.io.Serializable {

	private String hospId;
	private String hospName;
	private int hospTyp;
	private Boolean isDelete;
	private String imgsrc;
//	private Set expenses = new HashSet(0);

	public Hospital() {
	}

	public Hospital(String hospId, String hospName, int hospTyp) {
		this.hospId = hospId;
		this.hospName = hospName;
		this.hospTyp = hospTyp;
	}	

	public Hospital(String hospId, String hospName, int hospTyp, Boolean isDelete, String imgsrc) {
		this.hospId = hospId;
		this.hospName = hospName;
		this.hospTyp = hospTyp;
		this.isDelete=isDelete;
		this.imgsrc=imgsrc;
//		this.expenses = expenses;
	}

	public String getHospId() {
		return this.hospId;
	}

	public void setHospId(String hospId) {
		this.hospId = hospId;
	}

	public String getHospName() {
		return this.hospName;
	}

	public void setHospName(String hospName) {
		this.hospName = hospName;
	}

	public int getHospTyp() {
		return this.hospTyp;
	}

	public void setHospTyp(int hospTyp) {
		this.hospTyp = hospTyp;
	}
	
	public Boolean getIsDelete() {
		return isDelete;
	}
	
	public void setIsDelete(Boolean isDelete) {
		this.isDelete = isDelete;
	}
	
	public String getImgsrc() {
		return imgsrc;
	}
	
	public void setImgsrc(String imgsrc) {
		this.imgsrc = imgsrc;
	}

//	public Set getExpenses() {
//		return this.expenses;
//	}
//
//	public void setExpenses(Set expenses) {
//		this.expenses = expenses;
//	}

}
