<!-- header -->
<%@ include file="/WEB-INF/views/ws/header3.jsp"%>
<!-- //header -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!-- //header -->
<style>
 ul li {
        display: inline-block;
        margin: 0 5px;
        font-size: 14px;
        letter-spacing: -.5px;
    }
 

    .del-btn {
        font-size: 12px;
        font-weight: bold;
        cursor: pointer;
        margin-left: 8px;
    }
      ul li.tag-item {
        padding: 4px 8px;
        color: #000;
    }

    .tag-item:hover {
        background-color: #262626;
        color: #fff;    
    }
    input[type="text"]:disabled { background: white; color: gray; }
    
     
</style>
<script type="text/javascript">
 
function doSearch(){
	var issue_no = $("#issue_no4").val();
	window.location.href="/issueDetail/"+issue_no;
	 if(ud_flag=="D"){
		 window.location.href="/issue";
	 }
}

//수정,삭제
function doModify(ud_flag){  
	var user_id = <%=(String) request.getSession().getAttribute("user_id")%>;
	
	 if($("#reg_id4").val() != user_id &&  $("#user_group").val() != "1" ) {
		 alert("게시자만 수정 삭제가 가능합니다. ");
		 return;
	 }
	 if($("#issue_title3").val()=="") {
		 alert("제목을 입력해주세요.");
		 return;
	 }if($("#issue_content3").val()=="") {
		 alert("기술내용을 입력해주세요.");
		 return;
	 }
       
   var msg = "update";
   if(ud_flag=="D") msg = "delete";
   if (!confirm(msg+" 하시겠습니까 ?")) {
      return;
   }
   $("#ud_flag").val(ud_flag);
   
   var dataArr = new Array();   
   var ele = document.getElementById('tag-list');
	var eleCount = ele.childElementCount;
	
   $("#tag-list li").each( function (index) {
//	   alert(index);
      var aJson = new Object();
      var ul = $("#tag-list");
      var li = ul.children();

		 var issue_tag = li.eq(index).text().slice(0,-1);
		 aJson.issue_tag = issue_tag;
		 dataArr.push(aJson); 
//		 alert(issue_tag);
   });

   var data = {
 		 "issue_no": $("#issue_no4").val()
 		 ,"reg_id": $("#reg_id4").val()
         ,"customer_id": $("#customer_id3").val() 
         ,"issue_title": $("#issue_title3").val()
         ,"issue_msg": $("#issue_msg3").val()
         ,"issue_feedback": $("#issue_feedback3").val()
         ,"ud_flag": $("#ud_flag").val()
      	,"issueTagList" : dataArr
   }
   alert(JSON.stringify(data));

   $.ajax({
 	  type : 'POST',
       url: '/issueUpdate',
       data : JSON.stringify(data),
        contentType: 'application/json; charset=utf-8',
       
      success : function(rslt) {
    	  update_callback(rslt);
      },
      error : function(error){
     	 console.log('error');
     	 console.log(error);
    	 } 
   });
//   ajaxPostSend("/issueUpdate", "post", "json", "update_callback","form3");
}

function  update_callback(rslt){
    var result = eval('('+rslt+')');
    alert(result.errMsg);

    if(result.errCd == "1"){
	   var issue_no = $("#issue_no4").val();
		 if($("#ud_flag").val()=="D") window.location.href="/issue";
		 else window.location.href="/issueDetail/"+issue_no;
   }
}

//Reply저장
function doSaveReply(){
	
	
	if($("#reply_content").val()=="")
	{
		alert("댓글을 입력하세요.");
		$("#reply_content").focus();
		return;
	}
	ajaxPostSend("/insertReply", "post", "json", "insert_callback","form4");
}
function  insert_callback(rslt){
    var result = eval('('+rslt+')');

	alert(result.errMsg);
	
	if(result.errCd == "1"){
		doSearch();
	}
}


 function goTop(){
		$('html').scrollTop(0);
	}
 
 function ModifyReply(status){
	 $("#reply_content").prop("disabled", true);
	 $("#divAll").find("textarea").prop("disabled", true);
	 $("#div_"+status+"").find("textarea").prop("disabled", false);
	 $("#reply_content_"+status+"").focus().setCursorPosition(
			 $("#reply_content_"+status+"").val().length);
	 
//	  $("#"+status+"").attr("disabled", false);
	  $("#ud_"+status+"").hide();
		$("#u_"+status+"").show();
	}
 function doReset(status){  
	 $("#reply_content").prop("disabled", false);
	 $("#div_"+status+"").find("textarea").prop("disabled", true);
	 $("#reply_content_"+status+"").val( $("#backup_"+status+"").val()); 
	 $("#ud_"+status+"").show();
	 $("#u_"+status+"").hide();
	}

 /* 댓글 수정시 커서 위치  */
 $.fn.setCursorPosition = function( pos )
 {
     this.each( function( index, elem ) {
         if( elem.setSelectionRange ) {
             elem.setSelectionRange(pos, pos);
         } else if( elem.createTextRange ) {
             var range = elem.createTextRange();
             range.collapse(true);
             range.moveEnd('character', pos);
             range.moveStart('character', pos);
             range.select();
         }
     });
     
     return this;
 };

//Reply수정
 function doModifyReply(ud_flag, status){
	
	
	 $("#reply_content_modi").val($("#reply_content_"+status+"").val());
	 $("#reply_no").val($("#reply_no_"+status+"").val())

 	if($("#reply_content"+status+"").val()==""){
 		alert("댓글을 입력하세요.");
 		$("#reply_content"+status+"").focus();
 		return;
 	}
 	if($("#reply_content_"+status+"").val() ==  $("#backup_"+status+"").val() &&  ud_flag=="U"){
 		alert($("#reply_no").val());
 		alert($("#reply_content_modi").val());
 		doSearch();
 		return;
 	}
 	
 var msg = "update";
    if(ud_flag=="D") msg = "delete";
    if (!confirm(msg+" 하시겠습니까 ?")) {
       return;
    }
 	
    $("#ud_flag2").val(ud_flag);

    ajaxPostSend("/updateReply", "post", "json", "updateReply_callback","form4");
 }
 function  updateReply_callback(rslt){
     var result = eval('('+rslt+')');

 	alert(result.errMsg);
 	if(result.errCd == "1"){
 		doSearch();
 	}
 }
 
 function  doReReply(status){
	 if($("#parent_"+status+"").val() == 0){
		 $("#parent").val($("#reply_no_"+status+"").val());
	 }else{
		 $("#parent").val($("#parent_"+status+"").val());
	 }
		 
 	 $("#parent_view").text($("#reply_reg_id_"+status+"").val());
	 $("#parent_tag_id").val($("#reply_reg_id_"+status+"").val())
	 $("#reply_depth").val($("#reply_depth_"+status+"").val())
 		 $("#reply_content").focus();
 
 } 
 
 function  doReReply_cancel(){
	 $("#parent").val('');
 	 $("#parent_view").text('');
 	 $("#reply_content").val('');
	 $("#parent_tag_id").val('');
	 $("#reply_depth").val(''); 
 } 
 
 
</script>

<!-- START BREADCRUMB -->
<!-- START PAGE CONTAINER -->
<div class="page-container">

   <!-- START PAGE SIDEBAR -->
   <div class="page-sidebar"></div>
   <!-- END PAGE SIDEBAR -->

   <div class="page-content">
      <!-- END BREADCRUMB -->

      <!-- PAGE TITLE -->
      <div class="page-title">
         <h2>
            <span class="fa fa-windows"></span>기술지원 
         </h2>
         <!-- <ul class="panel-controls">
      <li><a href="../main/index.jsp"><span class="fa fa-home"></span></a></li>
      <li><a href="javascript:location.reload();"><span class="fa fa-refresh"></span></a></li>
   </ul>  -->
      </div>

      <!-- END PAGE TITLE -->
      <!-- PAGE CONTENT WRAPPER -->
      <div class="page-content-wrap">

         <div class="row">
            <div class="col-md-12">
           		<div id="divList" class="row"> 
                        
               <!-- 거래 내역 상세 -->
               
                     <div class="col-md-12">
                        
                        <form id="form3" name="form3" method="POST" target="sysfrm" class="form-horizontal" enctype="multipart/form-data">
                        <input type="hidden" id="pageNo" name="pageNo" />
                           <input type="hidden" id="ud_flag" name="ud_flag" />
                           <input type="hidden" id="user_group" name="user_group" value="${user_group}" />
                           


                        <div class="panel panel-default">
                           <div class="panel-heading">
                              <h2 class="panel-title">기술지원 상세</h2>
                              
                              <div id = "ud_div">
                              	<div class="btn-group pull-right">
                                    <button type="button" onclick="doReset();" class="btn btn-success">X</button>
                                </div>
                                 <div class="btn-group pull-right">
                                    <button type="button" onclick="doModify('D');" class="btn btn-danger pull-right">삭제하기</button>
                                 </div>
                                 <div class="btn-group pull-right">
                                    <button type="button" onclick="doModify('U');" class="btn btn-info pull-right">수정하기</button>
                                 </div>
                              </div>
                           </div>
                           <div class="panel-body"> 
                           <div class="form-group">
                                 <label class="col-md-2 col-sm-2 control-label">게시번호</label>
                                 <div class="col-md-8 col-sm-8">
                                  	<p id="issue_no3" name="" class="form-control" style="text-align:left">${issue.issue_no} </p>
                                  <%-- 	<input type="text" id="issue_no3" name="" class="form-control" value="${issue.issue_no}" readonly="readonly"> --%>
                                  	<input type="hidden" id="issue_no4" name="issue_no" class="form-control" value="${issue.issue_no}">
                                 </div>
                              </div>
                              <div class="form-group">
                                 <label class="col-md-2 col-sm-2 control-label">작성자</label>
                                 <div class="col-md-8 col-sm-8">
                                  	<p id="reg_id3" name="" class="form-control" style="text-align:left">${issue.reg_id} </p>
                                  	<%-- <input type="text" id="reg_id3" name="" class="form-control" value="${issue.reg_id}" readonly="readonly"> --%>
                                  	<input type="hidden" id="reg_id4" name="reg_id" class="form-control" value="${issue.reg_id}">
                                 </div>
                              </div>
                              
                              <div class="form-group">
                                 <label class="col-md-2 col-sm-2 control-label">고객 </label>
                                 <div class="col-md-8 col-sm-8">
                               		  <p id="customer_id3" name="" class="form-control" style="text-align:left">${issue.customer_id} </p>
                               		  	<%-- <input type="text" id="customer_id3" name="" class="form-control" value="${issue.customer_id}" readonly="readonly"> --%>
                                 	<input type="hidden" id="customer_id4" name="customer_id" class="form-control" value="${issue.customer_id}">
                                 </div>
                               </div> 
                              <div class="form-group">
                                 <label class="col-md-2 col-sm-2 control-label">제목</label>
                                 <div class="col-md-8 col-sm-8">
                                 	<input type="text" id="issue_title3" name="issue_title" class="form-control" value="${issue.issue_title}">
                                 </div>
                              </div>
                              
                              <div class="form-group">
                                 <label class="col-md-2 col-sm-2 control-label">오류현상</label>
                                 <div class="col-md-8 col-sm-8">
                                 	<textarea id="issue_msg3" name="issue_msg" class="form-control" 
                                 	style = "height:150px;">${issue.issue_msg}</textarea> 
                                 </div>
                              </div>
                         	  <div class="form-group">
                                 <label class="col-md-2 col-sm-2 control-label">대처방법</label>
                                 <div class="col-md-8 col-sm-8">
                                 	<textarea id="issue_feedback3" name="issue_feedback" class="form-control"
                                 	style = "height:150px;" >${issue.issue_feedback}</textarea>
                                 </div>
                              </div>
                              
                              
                              <div class="form-group">
                                 <label class="col-md-2 col-sm-2 control-label">게시일</label>
                                 <div class="col-md-8 col-sm-8">
                                   <p id="issue_dt3" name="" class="form-control" style="text-align:left">${issue.issue_dt} </p>
                                 	<input type="hidden" id="issue_dt4" name="issue_dt" class="df-input input-date" value="${issue.issue_dt}">
                                 </div>
                              </div>
                              
                            <div class="form-group">
                                 <label class="col-md-2 col-sm-2 control-label">tag</label>
                                  <input type="hidden" value="" name="tag" id="rdTag" />
                                 <div class="col-md-8 col-sm-8">
                                 	<input type="text" id="tag" name="" class="form-control"> 
                                 </div>
                             </div>
                                 
                             <div class="form-group" >
                                <label class="col-md-2 col-sm-2 control-label">#</label>
                                  <div class="col-md-8 col-sm-8">
                                  	<ul id="tag-list" class="tag-list" align='left'>
                                  	<c:forEach items="${issueTagList}" var="list" varStatus="status">
						        	<li class='tag-item'><a href="/issue/${list.issue_tag}">${list.issue_tag}</a><span class='del-btn' idx="${status.index}">X</span></li>
						        	</c:forEach>
						        	</ul>
                                 </div>
                              </div>
                            <div>
                        	<button type="button" onclick="goTop()" class="btn btn-info pull-right">맨 위로 ↑</button>
                              </div>
                           </div>
                        </div>
                        </form>
                     </div>
               <!-- 거래상세  --> 
               
				<div class="col-md-12">
							
							<form id="form4" name="form4" method="POST" target="sysfrm" class="form-horizontal" enctype="multipart/form-data">
	      						<input type="hidden" id="pageNo" name="pageNo" />
	      						<input type="hidden" id="ud_flag2" name="ud_flag" />
	      						<input type="hidden" id="parent" name="parent" class="form-control" value="">
	      						<input type="hidden" id="reply_reg_id" name="reply_reg_id" class="form-control" value="<%=(String) request.getSession().getAttribute("user_id")%>">
								<input type="hidden" id="issue_no" name="issue_no" class="form-control" value="${issue.issue_no}">
								<input type="hidden" name= "reply_no" id = "reply_no">
								<input type="hidden" name="reply_content_modi" id="reply_content_modi">
								<input type="hidden" name="reply_depth" id="reply_depth">
								<input type="hidden" name="parent_tag_id" id="parent_tag_id">
	      						
								<div class="panel panel-default">
									<div class="panel-heading">
										<h2 class="panel-title">engineer comment</h2>
										
										
									</div>
									
									
									<div class="panel-body" id="divAll">
									 							
										
										<!-- 이슈넘버, reply내용 -->
										<c:forEach items="${replyList}" var="list" varStatus="status">
										<c:if test="${list.parent != 0}">
										<label class="col-md-2 col-sm-2 control-label" style= " width : 100px; "> ㄴ </label>
										</c:if>
										<c:if test="${list.del == 1}">
										<div class="form-group">
										<label class="col-md-2 col-sm-2 control-label" style= "" > 
										삭제된 개시물입니다.
										</label>
										</div>
										</c:if>
										<c:if test="${list.del != 1}">
										<div class="form-group" id="div_${status.count}" >
										<input type="hidden" id= "reply_no_${status.count}" value="${list.reply_no }" >
										<input type="hidden" id= "reply_reg_id_${status.count}" value="${list.reply_reg_id }" >
										<input type="hidden" id= "reply_depth_${status.count}" value="${list.reply_depth }" >
										<input type="hidden" id= "parent_${status.count}" value="${list.parent }" >
											
											<label class="col-md-2 col-sm-2 control-label" style= " width : 50px; ">${list.reply_reg_id }</label>
											<c:if test="${list.reply_depth == 3}">
											<label class="col-md-2 col-sm-2 control-label" style= " width : 50px; ">@${list.parent_tag_id }</label>
											</c:if>
											
											<div class="col-md-8 col-sm-8">
												<textarea class="form-control" id="reply_content_${status.count}" style="background: white; color: gray; border: none" disabled="disabled">${list.reply_content }</textarea>
												<input type="hidden" class="form-control" id="backup_${status.count}"  value= "${list.reply_content }" >
											</div>
											<div id ="ud_${status.count}" align = "right"  class="btn-group pull-right">

															<a href="javascript:doReReply(${ status.count});">댓글쓰기</a> 
															<c:if test="${user_id eq list.reply_reg_id}">
															|<a href="javascript:ModifyReply(${ status.count});">수정</a>  
															|<a href="javascript:doModifyReply('D',${status.count})">삭제</a>
															</c:if>
															<div align = "right">
																<label>${list.reply_dt }</label>
															</div>
											</div>
											<div id ="u_${status.count}" align = "right" style="display : none;" class="btn-group pull-right" >
																<c:if test="${user_id eq list.reply_reg_id}">
																<a href="javascript:doModifyReply('U', ${status.count})">수정완료</a>| 
																<a href="javascript:doReset(${ status.count});">취소</a>
																</c:if>
																<div align = "right">
																<label>${list.reply_dt }</label>
																</div>
											</div>
											
											
														
										</div>
										
										</c:if>
										
										<hr>
										</c:forEach>
                              			
                              			<div class="form-group" >
											<label class="col-md-2 col-sm-2 control-label" >@</label>
											<div class="col-md-8 col-sm-8" >
												<p id="parent_view" align="left" style="padding-top: 7px;"></p>
											</div>
										</div>
										
                              			<div class="form-group" >
											<label class="col-md-2 col-sm-2 control-label" >${user_id}</label>
											
											<div class="col-md-8 col-sm-8" >
												<textarea rows="" cols="" id="reply_content" name="reply_content" class="form-control"></textarea>
											</div>
											<div class="btn-group pull-right">
												<button type="button" onclick="javascript:doReReply_cancel();" class="btn btn-success">X</button>
											</div>
											<div class="btn-group pull-right">
												<button type="button" onclick="doSaveReply();" class="btn btn-info pull-right">등록하기</button>
 											</div>
 
											
										</div>

										<hr>
                              			<div class="form-group">
											<div>
	                        					<button type="button" onclick="goTop()" class="btn btn-info pull-right">맨 위로 ↑</button>
	                              			</div>
										</div>
									</div>
									
								</div>
								</form>
							</div>
							
							
	            </div>
      </div>   
</div>
<!-- END PAGE CONTENT -->
</div>
<!-- END PAGE CONTAINER -->

</body>
</html>

<script>
   $(document).ready(function() {
      $("#s_id6").addClass("active");
      getdate();
   
      /* 해시 태그 */ 
      var tag = {};
      var counter = 0;

      // 태그를 추가한다.
      function addTag (value) {
          tag[counter] = value; // 태그를 Object 안에 추가
          counter++; // counter 증가 삭제를 위한 del-btn 의 고유 id 가 된다.
      }

      $("#tag").on("keypress", function (e) {
          var self = $(this);

          // input 에 focus 되있을 때 엔터 및 스페이스바 입력시 구동
          if (e.key == "Enter" || e.keyCode == 32 || e.keyCode == 44) {

              var tagValue = self.val(); // 값 가져오기

              // 값이 없으면 동작 ㄴㄴ
              if (tagValue !== "") {
                  // 같은 태그가 있는지 검사한다. 있다면 해당값이 array 로 return 된다.
                  var result = Object.values(tag).filter(function (word) {
                    	return word == tagValue;
                  })
                  
                  $("#tag-list li").each( function (index) {
	               	 var ul = $("#tag-list");
                     var li = ul.children();

               		 var issue_tag = li.eq(index).text().slice(0,-1);
               			
               		if (tagValue == issue_tag){     	
               			result = 1;
               		}
                  });
                  
                  // 태그 중복 검사
                  if (result.length == 0) { 
                      $("#tag-list").append("<li class='tag-item'>"+tagValue+"<span class='del-btn' idx='"+counter+"'>X</span></li>");
                      addTag(tagValue);
                      self.val("");
                  } else {
                      alert("태그값이 중복됩니다.");
                  }
              }
              e.preventDefault(); // SpaceBar 시 빈공간이 생기지 않도록 방지
          }
      });
   
      // 삭제 버튼 
      // 삭제 버튼은 비동기적 생성이므로 document 최초 생성시가 아닌 검색을 통해 이벤트를 구현시킨다.
      $(document).on("click", ".del-btn", function (e) {
    	  
          var index = $(this).attr("idx");
          tag[index] = "";
          $(this).parent().remove();
      }); 
   });
   
   function  getdate(){
       var fromDate = Date.today().addMonths(-1);
       var endDate  = Date.today();
   
       fromDate = fromDate.toString("yyyy-MM-dd");
       endDate = endDate.toString("yyyy-MM-dd");

       $("#deal_dt3").val(endDate);
   }
 
//거래수량 numberOnly
	$("input:text[name=deal_qty]").on("keyup", function() {
	    $(this).val($(this).val().replace(/[^0-9]/g,""));
	});
 
      
</script>