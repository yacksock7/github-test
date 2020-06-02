package com.example.dto;


import java.util.List;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;


@Data
@NoArgsConstructor 
@ToString
public class IssueTagVO {

		private String issue_no;
		private String reg_id;
		private String reg_nm;
		private String customer_id;
		private String customer_nm;
		private String issue_title;
		private String issue_msg;
		private String issue_feedback;
		private String issue_category;
		private String issue_dt;
		private String ud_flag;
		
		private List<IssueTagList> issueTagList;

		@Data 
	    @NoArgsConstructor 
	    @ToString 
	    public static class IssueTagList 
	      { 
	    	  private String issue_no;
	          private String issue_tag;
	      }
		
		
		
}
