package com.example.dto;

import java.sql.Date;
import java.sql.Timestamp;

public class ReplyVO {
	
	private int reply_no;
	private int reply_reg_id;
	private String reply_content;
	private int parent;
	private int reply_depth;
	private Timestamp reply_dt;
	private int issue_no;
	private String parent_tag_id;
	private int del;
	
	
	
	
	
	public int getReply_no() {
		return reply_no;
	}
	public void setReply_no(int reply_no) {
		this.reply_no = reply_no;
	}
	public int getReply_reg_id() {
		return reply_reg_id;
	}
	public void setReply_reg_id(int reply_reg_id) {
		this.reply_reg_id = reply_reg_id;
	}
	public String getReply_content() {
		return reply_content;
	}
	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}
	public int getParent() {
		return parent;
	}
	public void setParent(int parent) {
		this.parent = parent;
	}
	public int getReply_depth() {
		return reply_depth;
	}
	public void setReply_depth(int reply_depth) {
		this.reply_depth = reply_depth;
	}
	public Timestamp getReply_dt() {
		return reply_dt;
	}
	public void setReply_dt(Timestamp reply_dt) {
		this.reply_dt = reply_dt;
	}
	public int getIssue_no() {
		return issue_no;
	}
	public void setIssue_no(int issue_no) {
		this.issue_no = issue_no;
	}
	public String getParent_tag_id() {
		return parent_tag_id;
	}
	public void setParent_tag_id(String parent_tag_id) {
		this.parent_tag_id = parent_tag_id;
	}
	public int getDel() {
		return del;
	}
	public void setDel(int del) {
		this.del = del;
	}
	
	
}
