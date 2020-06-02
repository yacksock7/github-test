package com.example.dto;

public class UserVO {

	private String office_id;
	private String pw;
	private String manager;
	private String phone;
	private String email;
	private String user_group;
	
	private int t_qty;
	private int t_price;
    private int t_margin;
	
	
	public String getOffice_id() {
		return office_id;
	}
	public void setOffice_id(String office_id) {
		this.office_id = office_id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getManager() {
		return manager;
	}
	public void setManager(String manager) {
		this.manager = manager;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getUser_group() {
		return user_group;
	}
	public void setUser_group(String user_group) {
		this.user_group = user_group;
	}
	

	public int getT_qty() {
		return t_qty;
	}
	public void setT_qty(int t_qty) {
		this.t_qty = t_qty;
	}
	public int getT_price() {
		return t_price;
	}
	public void setT_price(int t_price) {
		this.t_price = t_price;
	}
	public int getT_margin() {
		return t_margin;
	}
	public void setT_margin(int t_margin) {
		this.t_margin = t_margin;
	}
	
	
	
	
}
