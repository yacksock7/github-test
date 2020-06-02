<!-- header -->
<%@ include file="/WEB-INF/views/ws/header3.jsp"%>
<!-- //header -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- //header -->
<script type="text/javascript">

  	// 1. 페이지 열릴때 
	$(document).ready(function() {
		$("#s_id2").addClass("active");
		
		/* 자동완성 */
	 	var availableTags = new Array(); 
	 		<c:forEach items="${resellerList}" var="list">
	 			availableTags.push("${list.manager}");
	 	    </c:forEach>
	 	      
		    $jqy("#seller_nm").autocomplete(availableTags,{ 
		        matchContains: true,
		        selectFirst: false
		    }); 
	});
  	
	// 2. 조회
	function doSearch(){
		window.form1.target = "";
		window.form1.action = "/reseller";
		window.form1.submit();
	}

	// enter 시 조회
	$("#form1").find("input").on("keypress", function (e) {  
		if (e.key == "Enter"){
			doSearch();
			}
	  });
	 
	 function goTop(){
			$('html').scrollTop(0);
		}
	 
	 function downLoadExcelForm(){
		   window.form1.target = "";
		   //window.form1.isExcel.value = "Y";
		   window.form1.action = "/resellerExcel";
		   window.form1.submit();
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
				<span class="fa fa-windows"></span>리셀러 관리
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
											<label class="col-md-2 col-sm-2 col-xs-2 control-label">리셀러명</label>
											<div class="col-md-10 col-sm-10 col-xs-10">
												<div class="input-group keyword">
													<input type="text" id="seller_nm" name="seller_nm" value="${seller_nm}" placeholder="enter name" class="form-control"
														onfocus="this.select();" />
												</div>
											</div>
										</div>
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

					<!--           리셀러 리스트 		 -->
					<div class="panel panel-default">
						<div class="panel-heading">
		                     <div class="panel_total">리셀러 List ${count}  </div>
		                     <div class="pull-right">
		                     <button type="button" class="btn btn-green float-right" onClick="javascript:downLoadExcelForm();"> EXCEL </button>
		                     </div>
                 		 </div>

						<form name="form2">
							<div class="panel-body">
								<div class="table-responsive">
									<table id="reseller_table" name="reseller_table" class="table table-bordered table-striped">
										<thead>
											<tr>
												<th>아이디</th>
												<th>이름</th>
												<th>핸드폰</th>
												<th>이메일</th>
											</tr>
										</thead>
										<tbody>
 											<c:forEach items="${resellerList}" var="list">
												<tr>
													<td>${list.office_id}</td>
													<td><a href="/resellerDetail/${list.office_id}">${list.manager}</a></td>
													<td>${list.phone}</td>
													<td>${list.email}</td>
												</tr>
											</c:forEach>  
										</tbody>
									</table>
								</div>
						</form>
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
</div>
<!-- END PAGE CONTENT -->
</div>
<!-- END PAGE CONTAINER -->


<script>

$("input:text[numberOnly]").on("keyup", function() {
    $(this).val($(this).val().replace(/[^0-9]/g,""));
});

		
</script>

