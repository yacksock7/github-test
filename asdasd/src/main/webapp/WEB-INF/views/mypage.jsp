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
		window.form1.action = "/mypage";
		window.form1.submit();
	}
	+" 하시겠습니까 ?"
	// 수정,삭제
	function doModify(ud_flag){	
		var msg = "수정하시겠습니까?";
		if(ud_flag=="D") msg = "회원탈퇴 하시겠습니까?\n"
							  +"\n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
							  +"\n회원탈퇴를 진행하시면 절대 되돌릴 수 없습니다."
							  +"\n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@";
		if (!confirm(msg)) {
			return;
		}
		 
		if($("#page").val() == "1" && $("#pw").val()=="" ){
			alert("비밀번호를 입력하세요.");
			$("#pw").focus();
			return;
			 
		 }else if($("#page").val() == "1" && $("#pw").val()!=$("#l_pw").val()){
			 alert("비밀번호가 틀렸습니다.");
				$("#pw").focus();
				return;
		 }else if($("#page").val() == "2" && $("#pw2").val()==""){
			 alert("비밀번호를 입력하세요.");
				$("#pw2").focus();
				return;
		 }else if($("#page").val() == "2" && $("#pw2").val()!=$("#l_pw").val()){
			 alert("비밀번호가 틀렸습니다.");
				$("#pw2").focus();
				return;
		 }else if($("#page").val() == "2" && $("#m_pw").val()=="" ){
			 alert("변경할 비밀번호를 입력하세요.");
				$("#m_pw").focus();
				return;
		 }else if($("#page").val() == "2" && $("#m_pw").val()!=$("#m_pw2").val()){
			 alert("수정할 비밀번호가 일치하지 않습니다.");
				$("#m_pw").focus();
				return;
		 }
		
		
		
		$("#ud_flag").val(ud_flag);
		
		ajaxPostSend("/updateUser", "post", "json", "update_callback","form3");
	}
	function  update_callback(rslt){
	    var result = eval('('+rslt+')');
	    alert(result.errMsg);
		if(result.errCd == "1"){
			doSearch();
		}
	}

	

	function pwView(){ 
		 var pwModify = document.getElementById("pwModify"); 
		 var divList = document.getElementById("divList"); 
		 $("#page").val('2');
		 $("#pw").val('');
			$("#manager").val( $("#l_manager").val());
			$("#phone").val( $("#l_phone").val());
			$("#email").val( $("#l_email").val());
			$('#r_div').show();
			$('#ud_div').hide();
		 pwModify.style.display = "block";  
		 divList.style.display = "none";  
		}
	function pwView2(){ 
		var pwModify = document.getElementById("pwModify"); 
		 var divList = document.getElementById("divList"); 
		 $("#page").val('1');
		 $("#pw").val('');
		 $("#pw2").val('');
		 $("#m_pw").val('');
		 $("#m_pw2").val(''); 
		 
		 $('#ud_div').show();
		 $('#r_div').hide();
		 pwModify.style.display = "none";  
		 divList.style.display = "block"; 
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
				<span class="fa fa-windows"> My Page</span>
			</h2>
		</div>
					
					<div  class="row" > 
								
					<!-- 리셀러 상세 -->
					
							<div class="col-md-12">
								
							<form id="form3" name="form3" method="POST" target="sysfrm" class="form-horizontal" enctype="multipart/form-data">
	      						<input type="hidden" id="ud_flag" name="ud_flag" />
	      						<input type="hidden" id="page" name="page" value="1" />
								<div class="panel panel-default">
									<div class="panel-heading">
										<h2 class="panel-title">개인정보 상세</h2>
									</div>
									<div class="panel-body" id="divList"> 
										<div class="form-group">
											<label class="col-md-2 col-sm-2 control-label">아이디 </label>
											<div class="col-md-8 col-sm-8">
											<%-- <input type="text" id="office_id" name="office_id" class="form-control" value="${my_info.office_id}" disabled /> --%>
											<p class= "form-control" style="text-align: left;">${my_info.office_id}</p>
											</div>
										</div>
										
										<div class="form-group">
											<label class="col-md-2 col-sm-2 control-label"> 비밀번호 </label>
											<div class="col-md-8 col-sm-8">
											
											<input type="password" id="pw" name="pw" class="form-control">
											<input type="button" onclick="javascript:pwView();" class="btn btn-info pull-right" value="비밀번호 변경하기">
											<input type="hidden" id="l_pw" name="l_pw" class="form-control" value="${my_info.pw}">
											
											</div>
										</div>
										
										<div class="form-group">
											<label class="col-md-2 col-sm-2 control-label">이름 </label>
											<div class="col-md-8 col-sm-8">
												<p class= "form-control" style="text-align: left;">${my_info.manager}</p>
												<input type="hidden" id="l_manager" name="l_manager" class="form-control" value="${my_info.manager}">
											</div>
										</div>
										
										<div class="form-group">
											<label class="col-md-2 col-sm-2 control-label">연락처 </label>
											<div class="col-md-8 col-sm-8">
												<input type="text" id="phone" name="phone" class="form-control" value="${my_info.phone}" numberOnly>
												<input type="hidden" id="l_phone" name="l_phone" class="form-control" value="${my_info.phone}">
											</div>
										</div>
										
										<div class="form-group">
											<label class="col-md-2 col-sm-2 control-label">이메일 </label>
											<div class="col-md-8 col-sm-8">
												<input type="text" id="email" name="email" class="form-control" value="${my_info.email}">
												<input type="hidden" id="l_email" name="l_email" class="form-control" value="${my_info.email}">
											</div>
										</div>
									</div>
									
										<div class="panel-body" id="pwModify" style="display: none;"> 
									<div class="form-group">
											<label class="col-md-2 col-sm-2 control-label">현재 비밀번호 </label>
											<div class="col-md-2 col-sm-2"><input type="password" id="pw2" name="pw2" class="form-control" value=""></div>
										</div>
										<div class="form-group">
											<label class="col-md-2 col-sm-2 control-label">변경할 비밀번호</label>
											<div class="col-md-2 col-sm-2"><input type="password" id="m_pw" name="m_pw" class="form-control" value=""></div>
										</div>
										
										<div class="form-group">
											<label class="col-md-2 col-sm-2 control-label">변경할 비밀번호 확인  </label>
											<div class="col-md-2 col-sm-2"><input type="password" id="m_pw2" name="m_pw2" class="form-control" value=""></div>
										</div>
									</div>
									
									
									<div class="panel-heading">
										<div id = "ud_div">
											<div class="btn-group pull-right">
												 <button type="button" onclick="doModify('D');" class="btn btn-danger pull-right">탈퇴하기</button> 
											</div>
											<div class="btn-group pull-right">
												<button type="button" onclick="doModify('U');" class="btn btn-info pull-right">수정하기</button>
											</div>
										</div>
										
										<div id = "r_div" style="display: none; "> 
											<div class="btn-group pull-right">
                                    			<button type="button" onclick="javascript:pwView2();" class="btn btn-success">X</button>
                              			  	</div>  
											<div class="btn-group pull-right">
												<button type="button" onclick="doModify('U');" class="btn btn-info pull-right">수정하기</button>
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

// 3. 리셀러리스트 클릭시 값 가져오기
$("#reseller_table tr").click(function(){ 	

	var str = ""
	var tdArr = new Array();	// 배열 선언
	
	// 현재 클릭된 Row(<tr>)
	var tr = $(this);
	var td = tr.children();
	
	// tr.text()는 클릭된 Row 즉 tr에 있는 모든 값을 가져온다.
	// td.eq(index)를 통해 값을 가져올 수도 있다.
	
	$("#seller_id3").val(td.eq(0).text());
	$("#seller_nm3").val(td.eq(1).text());
	$("#phone_no3").val(td.eq(2).text());
	$("#email3").val(td.eq(3).text());
	$("#company_nm3").val(td.eq(4).text());
	
	$('#ud_div').show();
	$('#r_div').hide();

	 location.href = "#form3";
});

$("input:text[numberOnly]").on("keyup", function() {
    $(this).val($(this).val().replace(/[^0-9]/g,""));
});

		
</script>

