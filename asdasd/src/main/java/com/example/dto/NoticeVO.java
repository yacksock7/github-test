package com.example.dto;

import java.sql.Date;

public class NoticeVO {
	
	private int notice_no;
	private String notice_title;
	private String notice_content;
	private Date notice_dt;
	private String manager_nm;
	
	
	public int getNotice_no() {
		return notice_no;
	}
	public void setNotice_no(int notice_no) {
		this.notice_no = notice_no;
	}
	public String getNotice_title() {
		return notice_title;
	}
	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}
	public String getNotice_content() {
		return notice_content;
	}
	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}
	public Date getNotice_dt() {
		return notice_dt;
	}
	public void setNotice_dt(Date notice_dt) {
		this.notice_dt = notice_dt;
	}
	public String getManager_nm() {
		return manager_nm;
	}
	public void setManager_nm(String manager_nm) {
		this.manager_nm = manager_nm;
	}

}
