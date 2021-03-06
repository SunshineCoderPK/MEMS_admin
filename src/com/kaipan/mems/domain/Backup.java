package com.kaipan.mems.domain;
// Generated 2017-4-27 21:51:34 by Hibernate Tools 4.0.1.Final

import java.util.Date;

/**
 * Backup generated by hbm2java
 */
public class Backup implements java.io.Serializable {

	private String backupId;
	private Admininfo admininfo;
	private String backupContent;
	private String backupExplain;
	private Date bcakupTime;
	private Boolean isDelete;

	public Backup() {
	}

	public Backup(String backupId) {
		this.backupId = backupId;
	}

	public Backup(String backupId, Admininfo admininfo, String backupContent, String backupExplain, Date bcakupTime,Boolean isDelete) {
		this.backupId = backupId;
		this.admininfo = admininfo;
		this.backupContent = backupContent;
		this.backupExplain = backupExplain;
		this.bcakupTime = bcakupTime;
		this.isDelete=isDelete;
	}

	public String getBackupId() {
		return this.backupId;
	}

	public void setBackupId(String backupId) {
		this.backupId = backupId;
	}

	public Admininfo getAdmininfo() {
		return this.admininfo;
	}

	public void setAdmininfo(Admininfo admininfo) {
		this.admininfo = admininfo;
	}

	public String getBackupContent() {
		return this.backupContent;
	}

	public void setBackupContent(String backupContent) {
		this.backupContent = backupContent;
	}

	public String getBackupExplain() {
		return this.backupExplain;
	}

	public void setBackupExplain(String backupExplain) {
		this.backupExplain = backupExplain;
	}

	public Date getBcakupTime() {
		return this.bcakupTime;
	}

	public void setBcakupTime(Date bcakupTime) {
		this.bcakupTime = bcakupTime;
	}
	
	public Boolean getIsDelete() {
		return isDelete;
	}
	
	public void setIsDelete(Boolean isDelete) {
		this.isDelete = isDelete;
	}

}
