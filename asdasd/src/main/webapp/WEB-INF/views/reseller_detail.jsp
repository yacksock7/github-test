<!-- header -->
<%@ include file="/WEB-INF/views/ws/header3.jsp"%>
<!-- //header -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!-- //header -->

<script type="text/javascript">
function doSearch(){
	var issue_no = $("#issue_no4").val();
	window.location.href="/issueDetail/"+issue_no;
	 if(ud_flag=="D"){
		 window.location.href="/issue";
	 }
}

function doReset(){  
	 window.location.href="/reseller";
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
            <span class="fa fa-windows">기술지원 </span>
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
                           <input type="hidden" id="bef_status" name="bef_status" />
                           <input type="hidden" id="status" name="status" />

                        <div class="panel panel-default">
                           <div class="panel-heading">
                              <h2 class="panel-title">기술지원 상세</h2>
                              
                              <div id = "ud_div">
                              	<div class="btn-group pull-right">
                                    <button type="button" onclick="doReset();" class="btn btn-success">이전으로</button>
                                </div>
                                 <div class="btn-group pull-right">
                                    <button type="button" onclick="" class="btn btn-danger pull-right">담당고객</button>
                                 </div>
                                 <div class="btn-group pull-right">
                                    <button type="button" onclick="" class="btn btn-info pull-right">거래내역</button>
                                 </div>
                              </div>
                           </div>
    
                           	<div class="panel-body"> 
										<div class="form-group">
										<label class="col-md-2 col-sm-2 control-label">ID</label>
											<div class="col-md-8 col-sm-8"><input type="text" id="office_id3" name="office_id" class="form-control" value="${reseller.office_id }"></div>
										</div>
										<div class="form-group">
											<label class="col-md-2 col-sm-2 control-label">리셀러명</label>
											<div class="col-md-8 col-sm-8"><input type="text" id="manager3" name="manager" class="form-control" value="${reseller.manager }"></div>
										</div>
										<div class="form-group">
											<label class="col-md-2 col-sm-2 control-label">핸드폰번호</label>
											<div class="col-md-8 col-sm-8"><input type="text" id="phone3" name="phone" class="form-control" value="${reseller.phone }" numberOnly></div>
										</div>
										<div class="form-group">
											<label class="col-md-2 col-sm-2 control-label">이메일</label>
											<div class="col-md-8 col-sm-8"><input type="text" id="email3" name="email" class="form-control" value="${reseller.email }"></div>
										</div>
										<div class="form-group">
											<label class="col-md-2 col-sm-2 control-label">회사이름</label>
											<div class="col-md-8 col-sm-8"><input type="text" id="company_nm3" name="company_nm" class="form-control"value="" ></div>
										</div>
									 	<!-- <div class="form-group">
											<label class="col-md-2 col-sm-2 control-label">근무형태</label>
											<div class="col-md-8 col-sm-8">
												<label class="check"><input type="radio" class="iradio" id="use_yn" name="use_yn" value="y" checked> Use </label> &nbsp;
												<label class="check"><input type="radio" class="iradio" id="use_yn" name="use_yn" value="n" > Not Use </label> &nbsp; 
											</div>
										</div>  -->
										
                             			<div>
                        					<button type="button" onclick="goTop()" class="btn btn-info pull-right">맨 위로 ↑</button>
                              			</div>
									</div>
                        </div>
                        </form>
                     </div>
               <!-- 거래상세  --> 
               </div>
      </div>   
</div>
<!-- END PAGE CONTENT -->
</div>
<!-- END PAGE CONTAINER -->

<script>
   $(document).ready(function() {
      $("#s_id2").addClass("active");
   });
 
//거래수량 numberOnly
	$("input:text[name=phone3]").on("keyup", function() {
	    $(this).val($(this).val().replace(/[^0-9]/g,""));
	});
 
      
</script>