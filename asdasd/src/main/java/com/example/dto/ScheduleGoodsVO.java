package com.example.dto;

import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor 
@ToString
public class ScheduleGoodsVO {
		private String schedule_no;   
		private String reseller_id;
		private String customer_id;
		private String schedule_dt;   
		private String memo;
		private String ud_flag;
		private String status;
		private String bef_status;
		

		private List<ScheduleGoodsList> scheduleGoodsList;

		@Data 
	    @NoArgsConstructor 
	    @ToString 
	    public static class ScheduleGoodsList 
	      { 
	    	  private String schedule_no;
	          private String goods_no;
	          private String goods_nm;
	          private String goods_qty;
	          private String goods_price;
	          private String legacy_qty;
	      }
	     
}
