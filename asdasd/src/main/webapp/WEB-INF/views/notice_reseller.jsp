<!-- header -->
<%@ include file="/WEB-INF/views/ws/header3.jsp"%>
<!-- //header -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- //header -->

<script type="text/javascript">

	// 2. 조회
	function doSearch(){
		window.form1.target = "";
		window.form1.action = "/notice";
		window.form1.submit();
	}
	
	// enter 시 조회
	$("#form1").find("input").on("keypress", function (e) {  
		if (e.key == "Enter"){
			doSearch();
			}
	  });
	
	// 저장
	function doSave(){
		if($("#notice_title3").val()=="")
		{
			alert("제목을 입력하세요.");
			$("#notice_title3").focus();
			return;
		}
		if($("#notice_content3").val()=="")
		{
			alert("공지내용을 입력하세요.");
			$("#notice_content3").focus();
			return;
		}

/*		var form = new FormData(document.form3);
 	    $.ajax({
	         url: "/noticeInsert", //컨트롤러 URL
	         data: form,
	         dataType: 'json',
	         processData: false,
	         contentType: false,
	         type: 'POST',
	         success: function(result) {
	        	 insert_callback(result);
	         }
	       }); */
		ajaxPostSend("/noticeInsert", "post", "json", "insert_callback","form3");
	}
	function  insert_callback(rslt){
		doSearch();
	    var result = eval('('+rslt+')');//	이게 왜 실행이 안되냐....???
	
		if(result.errCd == "1"){
			// 추후 제품 이미지 추가 입력,수정시 
			// window.form3.target = "";
			//document.form3.num.value=result.num; // 새로 생성된 제품번호 넘겨 받음 ,
			//$("#form3").attr("action","goodsFileInsert.do");	// 상품 이미지 등록 관련 
			//$("#form3").submit();
			alert(result.errMsg);
			/* doSearch(); */
		}else{
			alert(result.errMsg);
		} 
	}
	
	// 수정,삭제
	function doModify(ud_flag){	

		var msg = "update";
		if(ud_flag=="D") msg = "delete";
		if (!confirm(msg+" 하시겠습니까 ?")) {
			return;
		}
		$("#ud_flag").val(ud_flag);
		
	 /*    $.ajax({
	         url: "/goodsUpdate", //컨트롤러 URL
	         data: form,
	         dataType: 'json',
	         processData: false,
	         contentType: false,
	         type: 'POST',
	         success: function(result) {
	        	 update_callback(result);
	         }
	       }); */
		
		ajaxPostSend("/noticeUpdate", "post", "json", "update_callback","form3");
	}
	function  update_callback(rslt){
	    var result = eval('('+rslt+')');
	    alert(result.errMsg);
		if(result.errCd == "1"){
			doSearch();
		}
	}

	// enter 시 조회
/* 	$(function() {
		$(window).keydown(function(e) {
			var keyCode = (window.Event) ? e.which : e.keyCode;
			if (keyCode == 13) {
				doSearch();
			}
		})
	}); */
	
	function doReset(){  
		var endDate  = Date.today();
	     endDate = endDate.toString("yyyy-MM-dd");
		
		 var divList = document.getElementById("divList");
		 var d_div = document.getElementById("d_div"); 
		 var ud_div = document.getElementById("ud_div");
		 /* 		 
			$("#notice_no3").val('');
			$("#notice_title3").val('');
			$("#notice_content3").val('');
			$("#notice_dt3").val(endDate);
			$("#manager_nm3").val($("#manager").val());

			$('#r_div').hide();*/
		 ud_div.style.display = 	"none";
		 d_div.style.display = 	"none";
		 divList.style.display =  "block"; 
		}
	 
	 function goTop(){
			$('html').scrollTop(0);
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
				<span class="fa fa-windows"></span>공지 사항
			</h2>
		</div>

		<!-- END PAGE TITLE -->

		<!-- PAGE CONTENT WRAPPER -->
		<div class="page-content-wrap">

			<div class="row">
				<div class="col-md-12">

					<div class="panel panel-default panel-search panel-success">
						
						<form id="form1" method="POST" class="form-horizontal">
	    					<input type="hidden" id="pageNo" name="pageNo" />

							<div class="panel-body">
							     <div class="row">
                       				<div class="col-md-6">
										<div class="form-group form-search">
											<label class="col-md-2 col-sm-2 col-xs-2 control-label">제목</label>
											<div class="col-md-10 col-sm-10 col-xs-10">
												<div class="input-group keyword">
													<input type="text" id="notice_title" name="notice_title" placeholder="enter title" class="form-control"
														onfocus="this.select();" />
												</div>
											</div>
										</div>
									</div>
									
			                        <div class="col-md-6">
			                              <div class="form-group form-search">
			                                 <label class="col-md-2 col-sm-2 col-xs-2 control-label">거래일자</label>
			                                 <div class="col-md-10 col-sm-10 col-xs-10">
			                                    <div class="input-group ">
			                                       <input type="date" class="df-input input-date" id="fr_wb_dt" name="fr_wb_dt" value="${fr_wb_dt}"> 
			                                       <span> - </span> <input type="date" class="df-input input-date" id="to_wb_dt" name="to_wb_dt" value="${to_wb_dt}"> 
			                                    </div>
			                                 </div>
			                              </div>
			                           </div>
									</div>
									
							<div class="row">
							 <div class="col-md-6">
                          	 </div>
                           
                           <div class="col-md-6">
                              <div class="form-group form-search">
                                 <label class="col-md-2 col-sm-2 col-xs-2 control-label">페이지</label>
                                 <div class="col-md-10 col-sm-10 col-xs-10">
                                    <div class="input-group field">
                                       <select class="form-control select"
                                          name="pageView" id="pageView" onchange="doSearch();">
                                          <option value="10"
                                             <c:if test="${pageView == '10' }">selected="selected"</c:if>>10개씩</option>
                                          <option value="20"
                                             <c:if test="${pageView == '20' }">selected="selected"</c:if>>20개씩</option>
                                          <option value="50"
                                             <c:if test="${pageView == '50' }">selected="selected"</c:if>>50개씩</option>
                                          <option value="100"
                                             <c:if test="${pageView == '100' }">selected="selected"</c:if>>100개씩</option>
                                       </select>
                                    </div>
                                    <div class="input-group">
                                       <button type="button" class="btn btn-success" onClick="javascript:doSearch();">Search</button>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
							</div>
						</form>
					</div>
					<!--           제품 리스트 				 -->


			<div  class="row" > 
                        
               <!-- 공지 사항 상세 -->
               
                     <div class="col-md-12">
                        
                        <form id="form3" name="form3" method="POST" target="sysfrm" class="form-horizontal" enctype="multipart/form-data">
								<input type="hidden" id="manager" name="manager"value="${cookie.userCook.value }"/>
	      						<input type="hidden" id="pageNo" name="pageNo" />									
	      						<input type="hidden" id="office_id" name="office_id" value="<%= request.getSession().getAttribute("user_id")%>"/>

                        <div class="panel panel-default">
									<div class="panel-heading">
										<h2 class="panel-title">공지사항 상세</h2>
										<div id = "ud_div" style="display: none;">
											<div class="btn-group pull-right">
                                    			<button type="button" onclick="doReset();" class="btn btn-success">공지목록</button>
                              			  	</div>
										</div>
									</div>
									
									
									
							<div class="panel-body"  id="divList">
								<div class="table-responsive">
									<table id="product_table" name="product_table" class="table table-bordered table-striped">
										<thead>
											<tr>
												<th>공지번호</th>
												<th>제목</th>
												<th style="display: none;">내용</th>
												<th>작성일</th>
												<th>작성자</th>
											</tr>
										</thead>
										<tbody>
 											<c:forEach items="${noticeList}" var="list">
												<tr>
													<td>${list.notice_no}</td>
													<td>${list.notice_title}</td>
													<td style="display: none;">${list.notice_content}</td>
													<td>${list.notice_dt}</td>
													<td>${list.manager_nm}</td>
												</tr>
											</c:forEach>  
										</tbody>
									</table>
								</div>
							<ul class="pagination">
								<li>
									<!-- paging --> <jsp:include
										page="/WEB-INF/views/common/navigation.jsp">
										<jsp:param value="form1" name="formName" />
									</jsp:include> <!-- //paging -->
								</li>
							</ul>
							<!-- / pagenation -->
						</div>
									
									
									
									
									<div class="panel-body" style = "display: none;" id="d_div">
									<div class="form-group">
											<label class="col-md-2 col-sm-2 control-label">번호</label>
											<div class="col-md-8 col-sm-8"><p id="notice_no3" name="notice_no" class="form-control" style="text-align:left"></p></div>
										</div>
										<div class="form-group">
											<label class="col-md-2 col-sm-2 control-label">제목</label>
											<div class="col-md-8 col-sm-8"><p id="notice_title3" name="notice_title" class="form-control" style="text-align:left"></p></div>
										</div>
										<div class="form-group">
											<label class="col-md-2 col-sm-2 control-label">내용</label>
											<div class="col-md-8 col-sm-8">
											<P id="notice_content3" name="notice_content" class="form-control"
												style = "height:350px;"></P>
											</div>
										</div>
										<div class="form-group">
											<label class="col-md-2 col-sm-2 control-label" >작성자</label>
											<div class="col-md-2 col-sm-2 control-label"><p id="manager_nm3" name="manager_nm" class="form-control" style="text-align:center;"><p></div>
											
											<label class="col-md-2 col-sm-2 control-label">작성일</label>
                                 				<div class="col-md-2 col-sm-2 control-label8">
                                   					<input type="date" class="df-input input-date" id="notice_dt3" name="notice_dt" disabled/> 		
                                 				</div>	
											</div>
										
										 <div>
			             				  	<button type="button" onclick="goTop()" class="btn btn-info pull-right">맨 위로 ↑</button>
			            				 </div>
			                          
									</div>
									
								</div>
                        </form>
                     </div>
               <!-- 공지상세  -->   
         </div>


</div>
<!-- END PAGE CONTENT -->
</div>
<!-- END PAGE CONTAINER -->

</body>
</html>

<script>
$(document).ready(function() {
    $("#s_id7").addClass("active");
    getdate();
    
    /* 자동완성 */
    var availableTags = new Array(); 
		<c:forEach items="${noticeList}" var="list">
			availableTags.push("${list.notice_title}");
	    </c:forEach>
	      
	    $jqy("#notice_title").autocomplete(availableTags,{ 
        matchContains: true,
        selectFirst: false
    }); 
 });

function  getdate(){
    var fromDate = Date.today().addMonths(-1);
    var endDate  = Date.today();

    fromDate = fromDate.toString("yyyy-MM-dd");
    endDate = endDate.toString("yyyy-MM-dd");

    $("#notice_dt3").val(endDate);
    
}

// 3. 제품리스트 클릭시 값 가져오기
$("#product_table tr").click(function(){ 	

	var str = ""
	var tdArr = new Array();	// 배열 선언
	
	// 현재 클릭된 Row(<tr>)
	var tr = $(this);
	var td = tr.children();
	
	// tr.text()는 클릭된 Row 즉 tr에 있는 모든 값을 가져온다.
	// td.eq(index)를 통해 값을 가져올 수도 있다.
	document.getElementById('notice_no3').innerHTML = td.eq(0).text();
	document.getElementById('notice_title3').innerHTML = td.eq(1).text();
	document.getElementById('notice_content3').innerHTML = td.eq(2).text();
	$("#notice_dt3").val(td.eq(3).text());
	document.getElementById('manager_nm3').innerHTML = td.eq(4).text();

	$('#ud_div').show();
	$('#d_div').show();
	$('#divList').hide();
	
	/*  location.href = "#form3"; */

});

//거래일자 조회
$("#fr_wb_dt").change(function(){
	var fr_wb_dt = $("#fr_wb_dt").val();
	$("#to_wb_dt").val(fr_wb_dt);
});
		
</script>