package com.example.dto;

import java.sql.Date;

public class ScheduleVO {
	private String schedule_no;
	private String reseller_id;
	private String reseller_nm;
	private String customer_id;
	private String customer_nm;
	private int goods_no;
	private int goods_nm;
	private int goods_qty;
	private Date schedule_dt;
	private String memo;
	private String status;
	private int total_qty;
	private int total_price;
	
	public String getSchedule_no() {
		return schedule_no;
	}
	public void setSchedule_no(String schedule_no) {
		this.schedule_no = schedule_no;
	}
	public String getReseller_id() {
		return reseller_id;
	}
	public void setReseller_id(String reseller_id) {
		this.reseller_id = reseller_id;
	}
	public String getReseller_nm() {
		return reseller_nm;
	}
	public void setReseller_nm(String reseller_nm) {
		this.reseller_nm = reseller_nm;
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
	public int getGoods_no() {
		return goods_no;
	}
	public void setGoods_no(int goods_no) {
		this.goods_no = goods_no;
	}
	public int getGoods_nm() {
		return goods_nm;
	}
	public void setGoods_nm(int goods_nm) {
		this.goods_nm = goods_nm;
	}
	public int getGoods_qty() {
		return goods_qty;
	}
	public void setGoods_qty(int goods_qty) {
		this.goods_qty = goods_qty;
	}
	public Date getSchedule_dt() {
		return schedule_dt;
	}
	public void setSchedule_dt(Date schedule_dt) {
		this.schedule_dt = schedule_dt;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getTotal_qty() {
		return total_qty;
	}
	public void setTotal_qty(int total_qty) {
		this.total_qty = total_qty;
	}
	public int getTotal_price() {
		return total_price;
	}
	public void setTotal_price(int total_price) {
		this.total_price = total_price;
	}

}
