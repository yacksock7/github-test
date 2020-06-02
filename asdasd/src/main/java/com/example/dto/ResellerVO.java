package com.example.dto;

import java.sql.Date;

public class ResellerVO {
	//리셀러 DB

	
	private int seller_id;
    private String seller_nm;
	private int phone_no; 
    private String email;
    private String company_nm;
    private String reg_id;
    private Date reg_dt;
    
    
	public int getSeller_id() {
		return seller_id;
	}
	public void setSeller_id(int seller_id) {
		this.seller_id = seller_id;
	}
	public String getSeller_nm() {
		return seller_nm;
	}
	public void setSeller_nm(String seller_nm) {
		this.seller_nm = seller_nm;
	}
	public int getPhone_no() {
		return phone_no;
	}
	public void setPhone_no(int phone_no) {
		this.phone_no = phone_no;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getCompany_nm() {
		return company_nm;
	}
	public void setCompany_nm(String company_nm) {
		this.company_nm = company_nm;
	}
	public String getReg_id() {
		return reg_id;
	}
	public void setReg_id(String reg_id) {
		this.reg_id = reg_id;
	}
	public Date getReg_dt() {
		return reg_dt;
	}
	public void setReg_dt(Date reg_dt) {
		this.reg_dt = reg_dt;
	}
		    

}
