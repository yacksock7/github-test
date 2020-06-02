<!-- header -->
<%@ include file="/WEB-INF/views/ws/header3.jsp"%>
<!-- //header -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- //header -->

<script type="text/javascript">

  	// 1. 페이지 열릴때 
	$(document).ready(function() {
		$("#s_id3").addClass("active");
		
		/* 자동완성 */
	 	var availableTags = new Array(); 
	 		<c:forEach items="${customList}" var="list">
	 			availableTags.push("${list.customer_nm}");
	 	    </c:forEach>
	 	      
	 	   $jqy("#customer_nm").autocomplete(availableTags,{ 
		        matchContains: true,
		        selectFirst: false
		    }); 
	});
  	
	// 2. 조회
	function doSearch(){
		window.form1.target = "";
		window.form1.action = "/custom";
		window.form1.submit();
	}
	
	// 저장
	function doSave(){
		if($("#customer_nm3").val()=="")
		{
			alert("고객명을 입력하세요.");
			$("#customer_nm3").focus();
			return;
		}
	
		ajaxPostSend("/customerInsert", "post", "json", "insert_callback","form3");
	}
	function  insert_callback(rslt){
	    var result = eval('('+rslt+')');
	
		alert(result.errMsg);
		
		if(result.errCd == "1"){
			doSearch();
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
		
		ajaxPostSend("/customerUpdate", "post", "json", "update_callback","form3");
	}
	function  update_callback(rslt){
	    var result = eval('('+rslt+')');
	    alert(result.errMsg);
		if(result.errCd == "1"){
			doSearch();
		}
	}

	// enter 시 조회
	$("#form1").find("input").on("keypress", function (e) {  
		if (e.key == "Enter"){
			doSearch();
			}
	  });
	
	function doReset(){  
		 var ud_div = document.getElementById("ud_div");
		 var r_div = document.getElementById("r_div");
			$("#customer_nm3").val('');
			$("#tel_no3").val('');
	       	$("#email3").val('');
		 r_div.style.display = "block";
		 ud_div.style.display = "none"; 
		}
	 
	 function goTop(){
			$('html').scrollTop(0);
		}

	 function downLoadExcelForm(){
		   window.form1.target = "";
		   //window.form1.isExcel.value = "Y";
		   window.form1.action = "/customExcel";
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
				<span class="fa fa-windows"></span>고객 관리
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
											<label class="col-md-2 col-sm-2 col-xs-2 control-label">고객명</label>
											<div class="col-md-10 col-sm-10 col-xs-10">
												<div class="input-group keyword">
													<input type="text" id="customer_nm" name="customer_nm" value="${customer_nm}" placeholder="enter name" class="form-control"
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

					<!--           고객 리스트 				 -->
					<div class="panel panel-default">
						<div class="panel-heading">
		                     <div class="panel_total">고객 List ${count}  </div>
		                     <div class="pull-right">
		                     <button type="button" class="btn btn-green float-right" onClick="javascript:downLoadExcelForm();"> EXCEL </button>
		                     </div>
                 		 </div>

						<form name="form2">
							<div class="panel-body">
								<div class="table-responsive">
									<table id="customer_table" class="table table-bordered table-striped">
										<thead>
											<tr>
												<th>고객번호</th>
												<th>고객명</th>
												<th>핸드폰</th>
												<th>이메일</th>
												<th>담당자</th>
												<th>생성일</th>
											</tr>
										</thead>
										<tbody>
										
 											<c:forEach items="${customList}" var="list">
												<tr>
													<td>${list.customer_id}</td>
													<td>${list.customer_nm}</td>
													<td>${list.tel_no}</td>
													<td>${list.email}</td>
													<%-- <td>${list.manager_id}</td> --%>
													<td>${list.manager_nm}</td>
													<td>${list.reg_dt}</td>
												</tr>
											</c:forEach>  
										</tbody>
									</table>
									</div>
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
					
					<div id="divList" class="row"> 
					<!-- 고객 상세 -->
						<div class="col-md-12">
							<form id="form3" name="form3" method="POST" target="sysfrm" class="form-horizontal" enctype="multipart/form-data">
	      						<input type="hidden" id="pageNo" name="pageNo" />
	      						<input type="hidden" id="ud_flag" name="ud_flag" />
	      						<input type="hidden" id="customer_id3" name="customer_id" />
								<div class="panel panel-default">
									<div class="panel-heading">
										<h2 class="panel-title">고객 상세</h2>

										<div id = "r_div">
											<div class="btn-group pull-right">
												<button type="button" onclick="doSave();" class="btn btn-info pull-right">등록하기</button>
											</div>
										</div>
										
										<div style="display:none" id = "ud_div">
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
											<label class="col-md-2 col-sm-2 control-label">고객명</label>
											<div class="col-md-8 col-sm-8"><input type="text" id="customer_nm3" name="customer_nm" class="form-control"></div>
										</div>
										
										<div class="form-group">
											<label class="col-md-2 col-sm-2 control-label">핸드폰번호</label>
											<div class="col-md-8 col-sm-8"><input type="text" id="tel_no3" name="tel_no" class="form-control" numberOnly></div>
										</div>
										
										<div class="form-group">
											<label class="col-md-2 col-sm-2 control-label">이메일</label>
											<div class="col-md-8 col-sm-8"><input type="text" id="email3" name="email" class="form-control"></div>
										</div>
										
										<div class="form-group">
											<label class="col-md-2 col-sm-2 control-label">담당자</label>
											<div class="col-md-8 col-sm-8">
											<p id="manager_nm3" name="" class="form-control" style="text-align:left">${cookie.userCook.value }</p>
											<input type="hidden" id="manager_id" name="manager_id" class="form-control" value="<%=(String) request.getSession().getAttribute("user_id")%>"></div>
										</div>
										
									<!-- 	<div class="form-group">
											<label class="col-md-2 col-sm-2 control-label">근무형태</label>
											<div class="col-md-8 col-sm-8">
												<label class="check"><input type="radio" class="iradio" id="use_yn" name="use_yn" value="y" checked> Use </label> &nbsp;
												<label class="check"><input type="radio" class="iradio" id="use_yn" name="use_yn" value="n" > Not Use </label> &nbsp; 
											</div>
										</div> -->
										<div>
                        					<button type="button" onclick="goTop()" class="btn btn-info pull-right">맨 위로 ↑</button>
                              			</div>
									</div>
								</div>
								</form>
							</div>
				</div>	
</div>
<!-- END PAGE CONTENT -->
</div>
<!-- END PAGE CONTAINER -->

<script>
// 3. 고객리스트 클릭시 값 가져오기
$("#customer_table tr").click(function(){ 	

	var str = ""
	var tdArr = new Array();	// 배열 선언
	
	// 현재 클릭된 Row(<tr>)
	var tr = $(this);
	var td = tr.children();
	
	// tr.text()는 클릭된 Row 즉 tr에 있는 모든 값을 가져온다.
	// td.eq(index)를 통해 값을 가져올 수도 있다.
	$("#customer_id3").val(td.eq(0).text());
	$("#customer_nm3").val(td.eq(1).text());
	$("#tel_no3").val(td.eq(2).text());
	$("#email3").val(td.eq(3).text());
	$("#manager_nm3").val(td.eq(4).text());
	$("#manager_nm4").val(td.eq(4).text());
	
	$('#ud_div').show();
	$('#r_div').hide();
	 location.href = "#form3";
});

$("input:text[numberOnly]").on("keyup", function() {
    $(this).val($(this).val().replace(/[^0-9]/g,""));
});
		
</script>

