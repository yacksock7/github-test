<!-- header -->
<%@ include file="/WEB-INF/views/ws/header3.jsp"%>
<!-- //header -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- //header -->
<style>


	 /* The Modal (background) */
        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }
    
        /* Modal Content/Box */
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto; /* 15% from the top and centered */
            padding: 20px;
            border: 1px solid #888;
            width: 50%; /* Could be more or less, depending on screen size */      
        }
        
        .modal-content p{ 
       	  	display : inline; 
       	  	word-break:normal;     
        } 
        
        /* The Close Button */
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        
/* 
========================
      BUTTON ONE
========================
*/
div[class*=box] {
 	background-color: #FF6766;
    height: 45px;
    width: 120px; 
    margin: 0 auto;
  display: flex;
  justify-content: center;
  align-items: center;
}
.btn-modal {
    line-height: 35px;
    height: 35px;
    text-align: center;
    width: 120px;
    cursor: pointer;
}

.btn-one {
    color: #FFF;
    transition: all 0.3s;
    position: relative;
}
.btn-one span {
    transition: all 0.3s;
}
.btn-one::before {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: 1;
    opacity: 0;
    transition: all 0.3s;
    border-top-width: 1px;
    border-bottom-width: 1px;
    border-top-style: solid;
    border-bottom-style: solid;
    border-top-color: rgba(255,255,255,0.5);
    border-bottom-color: rgba(255,255,255,0.5);
    transform: scale(0.1, 1);
}
.btn-one:hover span {

height: 90%;
width: 90%;
    letter-spacing: 2px;
}
.btn-one:hover::before {
    opacity: 1; 
    transform: scale(1, 1); 
}
.btn-one::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: 1;
    transition: all 0.3s;
    background-color: rgba(255,255,255,0.1);
}
.btn-one:hover::after {
    opacity: 0; 
    transform: scale(0.1, 1);
}





</style>
<script type="text/javascript">
  	// 1. 페이지 열릴때 
	$(document).ready(function() {
		$("#s_id1").addClass("active");
		
		/* 자동완성 */
	 	var availableTags = new Array(); 
	 		<c:forEach items="${goodsList}" var="list">
	 			availableTags.push("${list.goods_nm}");
	 	    </c:forEach>
	 	      
	 	   $jqy("#goods_nm").autocomplete(availableTags,{ 
		        matchContains: true,
		        selectFirst: false
		    }); 
	});
  	
	// 2. 조회
	function doSearch(){
		window.form1.target = "";
		window.form1.action = "/goods";
		window.form1.submit();
	}
	
	// 저장
	function doSave(){
		if($("#goods_nm3").val()==""){
			alert("제품명을 입력하세요.");
			$("#goods_nm3").focus();
			return;
		}if($("#goods_qty3").val()==""){
			alert("재고수량을 입력하세요.");
			$("#goods_qty3").focus();
			return;
		}

		var form = new FormData(document.form3);
	    $.ajax({
	         url: "/goodsInsert", //컨트롤러 URL
	         data: form,
	         dataType: 'json',
	         processData: false,
	         contentType: false,
	         type: 'POST',
	         success: function(result) {
	        	 insert_callback(result);
	         }
	       });
//		ajaxPostSend("/goodsInsert", "post", "json", "insert_callback","form3");
	}
	
	function  insert_callback(rslt){
		doSearch();
	    var result = eval('('+rslt+')');//	이게 왜 실행이 안되냐....???
		if(result.errCd == "1"){
			alert(result.errMsg);
			/* doSearch(); */
		}else{
			alert(result.errMsg);
		} doSearch();
	}
	
	// 수정,삭제
	function doModify(ud_flag){	
		var msg = "update";
		if(ud_flag=="D") msg = "delete";
		if (!confirm(msg+" 하시겠습니까 ?")) {
			return;
		}
		$("#ud_flag").val(ud_flag);
		
		var form = new FormData(document.form3);
	 	    $.ajax({
	         url: "/goodsUpdate", //컨트롤러 URL
	         data: form,
	         dataType: 'json',
	         processData: false,
	         contentType: false,
	         type: 'POST',
	         success: function(result) {
	        	 update_callback(result);
	         }
	       }); 
//		ajaxPostSend("/goodsUpdate", "post", "json", "update_callback","form3");
	}
	
	function  update_callback(rslt){
		doSearch();
	    alert(result.errMsg);
	    var result = eval('('+rslt+')');
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
		 
			$("#goods_nm3").val('');
			$("#unit_price3").val('');
			$("#sale_price3").val('');
	       	$("#make_company3").val('');
	       	$("#cur_qty3").val('');
	       	$("#goods_qty3").val('');
	       	$('#goods_img').attr("src", "./../resources/noimage.gif");
	       	
	      //spac madal 
	    	$("#goods_spac_nm").text('');
	    	$("#goods_spac").text('');
	    	$("#goods_URL").text('');/* 
	    	$("#goods_spac_insert").text('');
	    	$("#goods_URL_insert").text(''); */
	    	
	    	$('#modal_content_insert').show();
	    	$('#modal_content_view').hide();
	    	
		 r_div.style.display = "block";
		 ud_div.style.display = "none"; 
		}
	 
	 function goTop(){
			$('html').scrollTop(0);
		}

	 function changeImg(){
		 var input = document.form3.img_path;
		 var fReader = new FileReader();
		 fReader.readAsDataURL(input.files[0]);
		 fReader.onloadend = function(event){
			 $('#goods_img').attr("src", event.target.result);
		 }
		}

	 function downLoadExcelForm(){
		   window.form1.target = "";
		   //window.form1.isExcel.value = "Y";
		   window.form1.action = "/goodsExcel";
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
				<span class="fa fa-windows"></span>제품관리
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
											<label class="col-md-2 col-sm-2 col-xs-2 control-label">제품명</label>
											<div class="col-md-10 col-sm-10 col-xs-10">
												<div class="input-group keyword">
													<input type="text" id="goods_nm" name="goods_nm" value="${goods_nm}" placeholder="enter name" class="form-control"
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
													<button type="button" class="btn btn-success" onClick="javascript:doSearch();">조회</button>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</form>
					</div>

					
					<!--           제품 리스트 				 -->
					<div class="panel panel-default">
						<div class="panel-heading">
		                     <div class="panel_total">제품 List ${count}  </div>
		                     <div class="pull-right">
		                     <button type="button" class="btn btn-green float-right" onClick="javascript:downLoadExcelForm();"> EXCEL </button>
		                     </div>
                 		 </div>
						<form name="form2">
							<div class="panel-body">
								<div class="table-responsive">
									<table id="product_table" class="table table-bordered table-striped">
										<thead>
											<tr>
												<th>제품번호</th>
												<th>제품명</th>
												<th>소비자가격</th>
												<th>거래가격</th>
												<th>생산회사</th>
												<th>재고수</th>
												<th style="display: none;">img</th>
												<th style="display: none;">status</th>
												<th style="display: none;">spac</th>
												<th style="display: none;">site</th>
											</tr>
										</thead>
										<tbody>
									
										
 											<c:forEach items="${goodsList}" var="list">
												<tr>
													<td>${list.goods_no}</td>
													<td>${list.goods_nm}</td>
													<td>${list.unit_price}</td>
													<td>${list.sale_price}</td>
													<td>${list.make_company}</td>
													<td>${list.goods_qty}</td>
													<td style="display: none;">${list.img_path}</td>
													<td style="display: none;">${list.goods_status}</td>
													<td style="display: none;">${list.goods_spac}</td>
													<td style="display: none;">${list.goods_URL}</td>
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
					
					
					<div id="divList" class="row" > 
						<div class="col-md-4">
							<div class="panel panel-default">
							<div class="panel-body"> 
								<img src="./../resources/noimage.gif" id="goods_img" style="display: block; margin: 0 auto;  width:100%;  height:350px;"/>
							</div>
							</div>
						</div>
						
						
						<div class="col-md-8">
							
					<!-- 제품 상세 -->
					
							<div class="col-md-12">
								
								<form id="form3" name="form3" method="POST" target="sysfrm" class="form-horizontal" enctype="multipart/form-data">
								<input type="hidden" name="forder" value="/bone_data" />
								<input type="hidden" name="toPage" value="/goods.do"/>
								<input type="hidden" id="goods_no3" name="goods_no" />	
								<input type="hidden" id="ud_flag" name="ud_flag"  />							
	                            <input type="hidden" id="legacy_qty" name="legacy_qty" />								
	      						<input type="hidden" id="office_id" name="office_id" value="<%= request.getSession().getAttribute("user_id")%>"/>
	      						
								<div class="panel panel-default">
									<div class="panel-heading">
										<h2 class="panel-title">제품내역</h2>
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
											<label class="col-md-2 col-sm-2 control-label">제품명</label>
											<div class="col-md-8 col-sm-8"><input type="text" id="goods_nm3" name="goods_nm" class="form-control"></div>
											<div class="btn-group pull-right">
                                    			<button type="button" class="btn btn-success" id="spac_modal" >스팩</button>
                              			  	</div>
										</div>
										
										<div class="form-group">
											<label class="col-md-2 col-sm-2 control-label">소비자가격</label>
											<div class="col-md-8 col-sm-8"><input type="text" id="unit_price3" name="unit_price" class="form-control" numberOnly></div>
										</div>
										
										<div class="form-group">
											<label class="col-md-2 col-sm-2 control-label">거래가격</label>
											<div class="col-md-8 col-sm-8"><input type="text" id="sale_price3" name="sale_price" class="form-control"numberOnly></div>
										</div>
										
										<div class="form-group">
											<label class="col-md-2 col-sm-2 control-label">생산회사</label>
											<div class="col-md-8 col-sm-8"><input type="text" id="make_company3" name="make_company" class="form-control"></div>
										</div>
										
										<div class="form-group">
											<label class="col-md-2 col-sm-2 control-label">현재수량</label>
											<div class="col-md-8 col-sm-8"><input type="number" id="cur_qty3" name="cur_qty" class="form-control" disabled></div>
										</div>
										 
										<div class="form-group">
											<label class="col-md-2 col-sm-2 control-label">변동수량</label>
											<div class="col-md-8 col-sm-8"><input type="number" id="goods_qty3" name="goods_qty" class="form-control"  ></div>
										</div>

										<div class="form-group">
											<label class="col-md-2 col-sm-2 control-label">제품사진</label> 
											<div class="col-md-7 col-sm-7">   
												<div class="col-md-8 col-sm-8"><input type="file" id="img_path3" name="img_path" class="form-control" onchange="changeImg();"></div>
											</div>											
										</div>															

										<div class="form-group">
											<label class="col-md-2 col-sm-2 control-label">제품상태</label>
											<div class="col-md-8 col-sm-8">
												<label class="check"><input type="radio" class="iradio" id="goods_status" name="goods_status" value="1" checked/> 정상거래 </label> &nbsp;
												<label class="check"><input type="radio" class="iradio" id="goods_status" name="goods_status" value="2" /> 거래안함 </label> &nbsp; 
												<label class="check"><input type="radio" class="iradio" id="goods_status" name="goods_status" value="3" /> 재고없음   </label> &nbsp;      
											</div>
										</div>
													
			                           <div>
			                        	<button type="button" onclick="goTop()" class="btn btn-info pull-right">맨 위로 ↑</button>
			                           </div>
									</div>
								</div>
								
								<!-- goods_spac_modal -->
								<div id="myModal" class="modal">
							     
							      <!-- Modal content(1) -->
							      <div class="modal-content" id="modal_content_view" style="display: none;">
							        <span class="close">&times;</span> 
							         <p><label>제품 스팩 확인</label></p><br><br>
							         
							        <label class="col-md-2 col-sm-2 control-label" >제품	 : </label>
							        <input type="text" id="goods_spac_nm" class="form-control" style="width : 75%; background: white; color: gray; border: none" disabled="disabled"><br>
							         
							        <label class="col-md-2 col-sm-2 control-label" >제품스팩 : </label>
							        <textarea id="goods_spac" class="form-control" style="width : 75%; height: 200px; background: white; color: gray; border: none" disabled="disabled"></textarea><br><br>
							        
							        <p id="goods_spac"></p><br><br>
							       <!--  <p>URL : </p> -->
							        <p id="goods_URL" style="display: none;"></p><br><br>
							        
							        <!-- Hover #1 -->
							        <div class="modal02">
									<div class="box-1">
									  <div class="btn-modal btn-one" id="read_more">
									    <span>read more</span>
									  </div>
									</div>
									</div>
									
									<br><a href="javascript:Modi_goods_spac();">수정하기</a>
									</div>
							        
							     <!--  Modal content(2) -->
							      <div class="modal-content" id="modal_content_insert">
							        <span class="close">&times;</span> 
							        <p><label>제품 스팩 등록</label></p><br><br>
							        <!-- <p>제품 이름 :</p> <p>제품명</p><br><br> -->
							       
									       	<label class="col-md-2 col-sm-2 control-label">URL : </label>
							       			<input type="text" id="goods_URL_insert" name="goods_URL" class="form-control"  placeholder="enter URL" style="width : 75%;"><br>
							        
											<label class="col-md-2 col-sm-2 control-label" >제품스팩 : </label>
											<textarea id="goods_spac_insert" name="goods_spac" class="form-control" placeholder="enter spac" style="width : 75%; height:100px;"></textarea><br><br>
										
							       <!--  Hover #1 -->
							        <div class="modal02">
									<div class="box-1">
									  <div class="btn-modal btn-one" id="spac_submit">
									    <span>확인</span>
									  </div>
									</div>
									</div>
									
									<br><a href="javascript:Reset_goods_spac();">초기화</a>
							        </div>
							    </div> 
								</form>
							</div>
					<!-- 제품 상세  -->	
			</div>
		</div>	
</div>
<!-- END PAGE CONTENT -->
</div>
<!-- END PAGE CONTAINER -->


</body>
</html>

<script>

// 3. 제품리스트 클릭시 값 가져오기
$("#product_table tr").click(function(){ 	

	var str = ""
	var tdArr = new Array();	// 배열 선언
	
	// 현재 클릭된 Row(<tr>)
	var tr = $(this);
	var td = tr.children();
	
	// tr.text()는 클릭된 Row 즉 tr에 있는 모든 값을 가져온다.
	// td.eq(index)를 통해 값을 가져올 수도 있다.
	$("#goods_no3").val(td.eq(0).text());
	$("#goods_nm3").val(td.eq(1).text());
	$("#unit_price3").val(td.eq(2).text());
	$("#sale_price3").val(td.eq(3).text());
	$("#make_company3").val(td.eq(4).text());
	$("#cur_qty3").val(td.eq(5).text());
	$("#legacy_qty").val(td.eq(5).text());
	$("input[id=goods_status][value="+td.eq(7).text()+"]").prop("checked", true);   
	
	//spac madal 
	$("#goods_spac_nm").val(td.eq(1).text());
	$("#goods_URL").text(td.eq(9).text());
	$("#goods_URL_insert").val(td.eq(9).text());
	if(td.eq(8).text() ==""){
		$("#goods_spac").text("등록된 제품 스팩이 없습니다.");
	}else{
		$("#goods_spac").text(td.eq(8).text());
		$("#goods_spac_insert").text(td.eq(8).text());
	}
	
	$('#modal_content_insert').hide();
	$('#modal_content_view').show();
	
	if(td.eq(6).text() == "" || td.eq(6).text() == "/temp/" ){
		$('#goods_img').attr("src", "./../resources/noimage.gif");
	}else{
		$('#goods_img').attr("src", "/temp/"+td.eq(6).text());
	}
	$('#ud_div').show();
	$('#r_div').hide();
	 location.href = "#form3";
});

$("input:text[numberOnly]").on("keyup", function() {
    $(this).val($(this).val().replace(/[^0-9]/g,""));
});

$("#spac_modal").click(function(){ 	
	 var modal = document.getElementById('myModal');
	 modal.style.display = "block"; 
});

$(".close").click(function(){ 
	 var modal = document.getElementById('myModal');
	 modal.style.display = "none";
	 if($("#goods_spac").text() != ""){
		 $("#goods_spac").text($("#goods_spac_insert").val());
		 $("#goods_URL").text($("#goods_URL_insert").val());
		 $('#modal_content_insert').hide();
		 $('#modal_content_view').show();
	 }
}); 

$("#spac_submit").click(function(){ 
	 var modal = document.getElementById('myModal');
	 modal.style.display = "none";
	 if($("#goods_spac").text() != ""){
		 $("#goods_spac").text($("#goods_spac_insert").val());
		 $("#goods_URL").text($("#goods_URL_insert").val());
		 $('#modal_content_insert').hide();
		 $('#modal_content_view').show();
	 }
}); 

$("#read_more").click(function(){ 
	if($("#goods_URL").text() ==""){
		alert("관련 URL을 설정하세요.\n\n(* 잠시후 Aether 웹사이트가 실행됩니다.)");
		setTimeout(function() {
			var newWindow = window.open("about:blank");
			newWindow.location.href="http://www.aetherit.io";
		}, 3000);
		return;
		}
		var newWindow = window.open("about:blank");
		newWindow.location.href=""+$("#goods_URL").text()+""; 
}); 

function Modi_goods_spac() {
	$('#modal_content_insert').show();
	$('#modal_content_view').hide();
}

function Reset_goods_spac() {
	$("#goods_spac_insert").val('');
	$("#goods_URL_insert").val('');
}
		
</script>

