package com.example.dto;

import java.sql.Date;

public class IssueVO {

		private int issue_no;
		private String reg_id;
		private String reg_nm;
		private String customer_id;
		private String customer_nm;
		private String issue_title;
		private String issue_msg;
		private String issue_feedback;
		private String issue_category;
		private Date issue_dt;
		
		
		public int getIssue_no() {
			return issue_no;
		}
		public void setIssue_no(int issue_no) {
			this.issue_no = issue_no;
		}
		public String getReg_id() {
			return reg_id;
		}
		public void setReg_id(String reg_id) {
			this.reg_id = reg_id;
		}
		public String getReg_nm() {
			return reg_nm;
		}
		public void setReg_nm(String reg_nm) {
			this.reg_nm = reg_nm;
		}
		public String getCustomer_id() {
			return customer_id;
		}
		public void setCustomer_id(String customer_id) {
			this.customer_id = customer_id;
		}
		public String getCustomer_nm() {
			return customer_nm;
		}
		public void setCustomer_nm(String customer_nm) {
			this.customer_nm = customer_nm;
		}
		public String getIssue_title() {
			return issue_title;
		}
		public void setIssue_title(String issue_title) {
			this.issue_title = issue_title;
		}
		public String getIssue_msg() {
			return issue_msg;
		}
		public void setIssue_msg(String issue_msg) {
			this.issue_msg = issue_msg;
		}
		public String getIssue_feedback() {
			return issue_feedback;
		}
		public void setIssue_feedback(String issue_feedback) {
			this.issue_feedback = issue_feedback;
		}
		public String getIssue_category() {
			return issue_category;
		}
		public void setIssue_category(String issue_category) {
			this.issue_category = issue_category;
		}
		public Date getIssue_dt() {
			return issue_dt;
		}
		public void setIssue_dt(Date issue_dt) {
			this.issue_dt = issue_dt;
		}
		
		
		
		
		
}
