package com.example.dto;

import java.io.File;
import java.sql.Date;

public class GoodsVO {

	//상품 DB
	private int goods_no;		 
    private String goods_nm;	 
    private int unit_price;	  
    private int sale_price;
    private int goods_qty;	
    private String make_company;
    private String reg_id;
    private Date reg_dt;
    private String img_path;
    private String goods_status;
    private String goods_spac;
    private String goods_URL;
    
    private int t_qty;
	private int t_price;
    private int t_margin;
    
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
	public int getUnit_price() {
		return unit_price;
	}
	public void setUnit_price(int unit_price) {
		this.unit_price = unit_price;
	}
	public int getSale_price() {
		return sale_price;
	}
	public void setSale_price(int sale_price) {
		this.sale_price = sale_price;
	}
	public int getGoods_qty() {
		return goods_qty;
	}
	public void setGoods_qty(int goods_qty) {
		this.goods_qty = goods_qty;
	}
	public String getMake_company() {
		return make_company;
	}
	public void setMake_company(String make_company) {
		this.make_company = make_company;
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
	public String getGoods_status() {
		return goods_status;
	}
	public void setGoods_status(String goods_status) {
		this.goods_status = goods_status;
	}
	public String getImg_path() {
		return img_path;
	}
	public void setImg_path(String img_path) {
		this.img_path = img_path;
	}
	public String getGoods_spac() {
		return goods_spac;
	}
	public void setGoods_spac(String goods_spac) {
		this.goods_spac = goods_spac;
	}
	public String getgoods_URL() {
		return goods_URL;
	}
	public void setgoods_URL(String goods_URL) {
		this.goods_URL = goods_URL;
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
