package com.example.dto;
import lombok.Data;
import java.sql.Date;

@Data
public class DealVO {

	private int deal_no;	 
    private String customer_id;
    private String customer_nm;
    private int seller_id;
    private String seller_nm;
    private int goods_no;	
    private String goods_nm;
    private int deal_qty;	
    private int deal_price;	 
    private Date deal_dt;
    private String memo;
    private String reg_id;
    private Date reg_dt;
    private String mod_id;
    private Date mod_dt;
    private String status;
    private String deal_status;
    
    
	
	public int getDeal_no() {
		return deal_no;
	}
	public void setDeal_no(int deal_no) {
		this.deal_no = deal_no;
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
	public int getGoods_no() {
		return goods_no;
	}
	public void setGoods_no(int goods_no) {
		this.goods_no = goods_no;
	}
	public String getGoods_nm() {
		return goods_nm;
	}
	public void setGoods_nm(String goods_nm) {
		this.goods_nm = goods_nm;
	}
	public int getDeal_qty() {
		return deal_qty;
	}
	public void setDeal_qty(int deal_qty) {
		this.deal_qty = deal_qty;
	}
	public int getDeal_price() {
		return deal_price;
	}
	public void setDeal_price(int deal_price) {
		this.deal_price = deal_price;
	}
	public Date getDeal_dt() {
		return deal_dt;
	}
	public void setDeal_dt(Date deal_dt) {
		this.deal_dt = deal_dt;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
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
	public String getMod_id() {
		return mod_id;
	}
	public void setMod_id(String mod_id) {
		this.mod_id = mod_id;
	}
	public Date getMod_dt() {
		return mod_dt;
	}
	public void setMod_dt(Date mod_dt) {
		this.mod_dt = mod_dt;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getDeal_status() {
		return deal_status;
	}
	public void setDeal_status(String deal_status) {
		this.deal_status = deal_status;
	}
   
	
    
    
}
