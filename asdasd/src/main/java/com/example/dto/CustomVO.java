package com.example.dto;

import java.sql.Date;

public class CustomVO {
	//고객 DB 

	
	private int customer_id;
    private String customer_nm;
	private String tel_no; 
    private String email;
    private String manager_id;
	private String manager_nm;
    private String reg_id;
    private Date reg_dt;//담당자 
	

    private int t_qty;
	private int t_price;
    private int t_margin;
	
   
	public int getCustomer_id() {
		return customer_id;
	}
	public void setCustomer_id(int customer_id) {
		this.customer_id = customer_id;
	}
	public String getCustomer_nm() {
		return customer_nm;
	}
	public void setCustomer_nm(String customer_nm) {
		this.customer_nm = customer_nm;
	}
	public String getTel_no() {
		return tel_no;
	}
	public void setTel_no(String tel_no) {
		this.tel_no = tel_no;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getManager_id() {
		return manager_id;
	}
	public void setManager_id(String manager_id) {
		this.manager_id = manager_id;
	}
	public String getManager_nm() {
		return manager_nm;
	}
	public void setManager_nm(String manager_nm) {
		this.manager_nm = manager_nm;
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
