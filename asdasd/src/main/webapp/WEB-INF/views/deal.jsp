<!-- header -->
<%@ include file="/WEB-INF/views/ws/header3.jsp"%>
<!-- //header -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!-- //header -->

<script type="text/javascript">

 
function doSearch(){
   window.form1.target = "";
   window.form1.action = "/deal";
   window.form1.submit();
}

function downLoadExcelForm(){
   window.form1.target = "";
   //window.form1.isExcel.value = "Y";
   window.form1.action = "/dealExcel";
   window.form1.submit();
}

function doSave(){
	 if($("#customer_id3").val()=="") 
         $("#status").val("2");
      else
         $("#status").val("3");  
/* 
     alert($("#seller_id3").val());
 	alert($("#deal_status").val());
     alert($("#status").val());
      */
   // 선택 ,입력 여부 체크    
   // 저장 
   ajaxPostSend("/dealInsert", "post", "json", "insert_callback","form3");
}

function  insert_callback(rslt){
    var result = eval('('+rslt+')');
    alert(result.errMsg);
   if(result.errCd == "1"){
       doSearch();
   }
}

//수정,삭제
function doModify(ud_flag){  
	
	  if($("#customer_id3").val()=="") 
          $("#status").val("2");
       else
          $("#status").val("3");  
       
       /* alert($("#bef_status").val());
       alert($("#status").val()); */
       
   var msg = "update";
   if(ud_flag=="D") msg = "delete";
   if (!confirm(msg+" 하시겠습니까 ?")) {
      return;
   }
   $("#ud_flag").val(ud_flag);
   
   ajaxPostSend("/dealUpdate", "post", "json", "update_callback","form3");
}
function  update_callback(rslt){
    var result = eval('('+rslt+')');
    alert(result.errMsg);
   if(result.errCd == "1"){
      doSearch();
   }
}

function doReset(){  
	 var endDate  = Date.today();
     endDate = endDate.toString("yyyy-MM-dd");
     $("#deal_dt3").val(endDate);
	 var ud_div = document.getElementById("ud_div");
	 var r_div = document.getElementById("r_div");
		$("#deal_qty3").val('');
		$("#deal_price3").val('');
		$("#deal_dt3").val(endDate);
       	$("#customer_id3").val('').prop("selected", true);
       	$("#seller_id3").val('').prop("selected", true);
       	$("#goods_no3").val('').prop("selected", true);
       	$("input[name=deal_status][value=거래예약]").prop("checked",true);

	 r_div.style.display = "block";
	 ud_div.style.display = "none"; 
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
            <span class="fa fa-windows"></span>거래내역 관리
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

               <div class="panel panel-default panel-search panel-success">
            
                  <form id="form1" method="POST" class="form-horizontal">
                         <input type="hidden" id="n_id" name="n_id" value="${n_id}" />
                           <input type="hidden" id="s_id" name="s_id" value="${s_id}" />
                           <input type="hidden" id="pageNo" name="pageNo" />

                     <div class="panel-body">
                     
                     
                     <div class="row">
                        
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
                              <div class="form-group form-search">
                                 <label class="col-md-2 col-sm-2 col-xs-2 control-label">리셀러</label>
                                 <div class="col-md-5 col-sm-5 col-xs-5">
                                    
                                    <select name="seller_id" id="seller_id" class="form-control">
                                    
                                       <option value="" <c:if test="${seller_id == '' }">selected="selected"</c:if>>-ALL-</option>
                                       <c:forEach items="${resellerList}" var="resellerList">
                                          <option value="${resellerList.office_id}" <c:if test="${resellerList.office_id == seller_id }">selected="selected"</c:if>>${resellerList.manager }</option>
                                       </c:forEach>
                                       
                                    </select>
                                    
                                 </div>
                              </div>
                           </div>
                           
                           <div class="col-md-6">
                              <div class="form-group form-search">
                                 <label class="col-md-2 col-sm-2 col-xs-2 control-label">고객</label>
                                 <div class="col-md-5 col-sm-5 col-xs-5">
                                    <div class="input-group keyword">
                                       <select name="customer_id" id="customer_id" class="form-control">
                                    
                                       <option value="" <c:if test="${customer_id == '' }">selected="selected"</c:if>>-ALL-</option>
                                       <c:forEach items="${customList}" var="customList">
                                          <option value="${customList.customer_id}" <c:if test="${customList.customer_id == customer_id }">selected="selected"</c:if>>${customList.customer_nm }</option>
                                       </c:forEach>
                                       
                                    </select>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                        
                        <div class="row">
                        <div class="col-md-6">
                              <div class="form-group form-search">
                                 <label class="col-md-2 col-sm-2 col-xs-2 control-label">제품명</label>
                                 <div class="col-md-5 col-sm-5 col-xs-5">
                                    <div class="input-group keyword">
                                       <input type="text" id="goods_nm" name="goods_nm" value="${goods_nm}" placeholder="" class="form-control"
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

               <!--           거래 리스트              -->
               <div class="panel panel-default">
                  <div class="panel-heading">
                     <div class="panel_total">거래건수 ${count}  </div>
                     <div class="pull-right">
                     <button type="button" class="btn btn-green float-right" onClick="javascript:downLoadExcelForm();"> EXCEL </button>
                     </div>
                  </div>

                  <form name="form2">
                     <div class="panel-body">
                        <div class="table-responsive">
                           <table id="deal_table" name="deal_table" class="table table-bordered table-striped">
                              <thead>
                                 <tr>
                                    <th>거래번호</th>
                                    <th>고객명</th>
                                    <th>리셀러명</th>
                                    <th>제품명</th>
                                    <th>제품수량</th>
                                    <th>개당거래가격</th>
                                    <th>거래날짜</th>
                                    <th style="display:none;">고객id</th>
                                    <th style="display:none;">리셀id</th>
                                    <th style="display:none;">상품no</th>
                                    <th style="display:none;">단계</th>
                                    <th>진행상</th>
                                    
                                    
                                 </tr>
                              </thead>
                              <tbody>
                                       
                              
                                  <c:forEach items="${dealList}" var="list">
                                    <tr>
                                       <td>${list.deal_no}</td>
                                       <td>${list.customer_nm}</td>
                                       <td>${list.seller_nm}</td>
                                       <td>${list.goods_nm}</td>
                                       <td>${list.deal_qty}</td>
                                       <td>${list.deal_price}</td>
                                       <td>${list.deal_dt}</td>
                                       <td style="display:none;">${list.customer_id}</td>
                                       <td style="display:none;">${list.seller_id}</td>
                                       <td style="display:none;">${list.goods_no}</td>
                                       <td style="display:none;">${list.status}</td>
                                       <td>${list.deal_status}</td>
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
                        
               <!-- 거래 내역 상세 -->
               
                     <div class="col-md-12">
                        
                        <form id="form3" name="form3" method="POST" target="sysfrm" class="form-horizontal" enctype="multipart/form-data">
                        <input type="hidden" id="pageNo" name="pageNo" />
                           <input type="hidden" id="ud_flag" name="ud_flag" />
                           <input type="hidden" id="deal_no" name="deal_no" />
                           <input type="hidden" id="bef_status" name="bef_status" />
                           <input type="hidden" id="status" name="status" />
                           <input type="hidden" id="legacy_qty" name="legacy_qty" />

                        <div class="panel panel-default">
                           <div class="panel-heading">
                              <h2 class="panel-title">거래 상세</h2>
                              
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
                                 <label class="col-md-2 col-sm-2 control-label">거래상품</label>
                                 <div class="col-md-8 col-sm-8">
                                    <select name="goods_no" id="goods_no3" onchange="" class="form-control">
                                       <option value="" <c:if test="${goods_nm == '' }">selected="selected"</c:if>>-SELECT-</option>
                                       <c:forEach items="${goodsList}" var="goodsList">
                                          <option value="${goodsList.goods_no}" <c:if test="${goodsList.goods_no == goods_no }">selected="selected"</c:if>>${goodsList.goods_nm }</option>
                                      	 <!--   <input type="hidden" id="sale_price" name="sale_price" value="${goodsList.sale_price}"/>-->
                                       </c:forEach>
                                    </select>
                                    <span class="caret" style="
                                     position: absolute;
                                     top: 50%;
                                     right: 12px;
                                     margin-top: -2px;
                                     vertical-align: middle;
                                 "></span>
                                 </div>
                              </div>


                              <div class="form-group">
                                    <label class="col-md-2 col-sm-2 control-label">담당리셀러</label>
                                    <div class="col-md-8 col-sm-8">
                                       <select name="seller_id" id="seller_id3" onchange="" class="form-control">
                                          <option value="" <c:if test="${manager == '' }">selected="selected"</c:if>>-SELECT-</option>
                                          <c:forEach items="${resellerList}" var="resellerList">
                                             <option value="${resellerList.office_id}" <c:if test="${resellerList.office_id == office_id }">selected="selected"</c:if>>${resellerList.manager }</option>
                                          </c:forEach>
                                       </select>
                                       <span class="caret" style="
                                     position: absolute;
                                     top: 50%;
                                     right: 12px;
                                     margin-top: -2px;
                                     vertical-align: middle;
                                 "></span>
                                 </div>
                              </div>
                              
                              <div class="form-group">
                                    <label class="col-md-2 col-sm-2 control-label">구매고객</label>
                                    <div class="col-md-8 col-sm-8">
                                       <select name="customer_id" id="customer_id3" onchange="" class="form-control">
                                          <option value="" <c:if test="${customer_nm == '' }">selected="selected"</c:if>>-SELECT-</option>
                                          <c:forEach items="${customList}" var="customList">
                                             <option value="${customList.customer_id}" <c:if test="${customList.customer_id == customer_id }">selected="selected"</c:if>>${customList.customer_nm }</option>
                                          </c:forEach>
                                       </select>
                                       <span class="caret" style="
                                        position: absolute;
                                        top: 50%;
                                        right: 12px;
                                        margin-top: -2px;
                                        vertical-align: middle;
                                    "></span>
                                 </div>
                              </div>
                              
                              <div class="form-group">
                                 <label class="col-md-2 col-sm-2 control-label">거래수량</label>
                                 <div class="col-md-8 col-sm-8"><input type="number" id="deal_qty3" name="deal_qty" class="form-control"></div>
                              </div>
                              
                              <div class="form-group">
                                 <label class="col-md-2 col-sm-2 control-label">개당거래가격</label>
                                 <div class="col-md-8 col-sm-8"><input type="text" id="deal_price3" name="deal_price" class="form-control" numberOnly> </div>
                              </div>
                              
                              <div class="form-group">
                                 <label class="col-md-2 col-sm-2 control-label">거래날짜</label>
                                 <div class="col-md-8 col-sm-8">
                                    <input type="date" class="df-input input-date" id="deal_dt3" name="deal_dt"> 
                                 </div>
                              </div>
                              
                              <div class="form-group">
                                 <label class="col-md-2 col-sm-2 control-label">거래상태</label>
                                 <div class="col-md-8 col-sm-8">
                                    <label class="check"><input type="radio" class="iradio" id="deal_status" name="deal_status" value="거래예약" checked> 거래예약 </label> &nbsp;
                                    <label class="check"><input type="radio" class="iradio" id="deal_status" name="deal_status" value="거래완료" > 거래완료 </label> &nbsp; 
                                    <label class="check"><input type="radio" class="iradio" id="deal_status" name="deal_status" value="정산완료" > 정산완료 </label> &nbsp; 
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
      $("#s_id4").addClass("active");
      getdate();
   
   });
   
   $(function() {
      $(window).keydown(function(e) {
         var keyCode = (window.Event) ? e.which : e.keyCode;
         if (keyCode == 13) {
            doSearch();
         }
      })
   });
   
   function  getdate(){
       var fromDate = Date.today().addMonths(-1);
       var endDate  = Date.today();
   
       fromDate = fromDate.toString("yyyy-MM-dd");
       endDate = endDate.toString("yyyy-MM-dd");

      /*  <c:if test="${fr_wb_dt eq NULL}">
          $("#fr_wb_dt").val(endDate);
       </c:if>
       <c:if test="${to_wb_dt eq NULL}">
          $("#to_wb_dt").val(endDate);
       </c:if> */
       
       $("#deal_dt3").val(endDate);
       
   }
   
   // 거래결과 리스트 클릭시 상세 화면 표시하기
   $("#deal_table tr").click(function(){    
	   

	    var tr = $(this);
	    var td = tr.children();
	   
       $("#deal_no").val(td.eq(0).text());
  		 $("#legacy_qty").val(td.eq(4).text());
  		 $("#deal_qty3").val(td.eq(4).text());
  		 $("#deal_price3").val(td.eq(5).text());
         $("#deal_dt3").val(td.eq(6).text());
          $("#customer_id3").val(td.eq(7).text()).prop("selected", true); 
         $("#seller_id3").val(td.eq(8).text()).prop("selected", true); 
         $("#goods_no3").val(td.eq(9).text()).prop("selected", true);
         
         $("#bef_status").val(td.eq(10).text());      
         $("input[name=deal_status][value="+td.eq(11).text()+"]").prop("checked",true);  

      // 추후 재구성 해주겠습니다.
      $('#ud_div').show();
      $('#r_div').hide();
      
      location.href = "#form3";
   });
  
 //거래일자 조회
 $("#fr_wb_dt").change(function(){
 	var fr_wb_dt = $("#fr_wb_dt").val();
 	$("#to_wb_dt").val(fr_wb_dt);
 });

/*    
   $("#deal_table tr").click(function(){    


    // 추후 재구성 해주겠습니다.
    $('#ud_div').show();
    $('#r_div').hide();
    
    location.href = "#form3";
 });
   
    */
  /* 
    function getComboA(selectObject) {
    	  var value = selectObject.value; 
    	  alert(value);
    	  $("#deal_price").val(value); 
    	} */
 /*    	
    	$("#goods_no3").change(function(){
    		alert($(this).val());
	alert($(this).childern("#sale_price").text());
})  
 */
 
 
 
 
 
 /*
//거래수량 numberOnly
	$("input:text[name=deal_qty]").on("keyup", function() {
	    $(this).val($(this).val().replace(/[^0-9]/g,""));
	});
 */












   
      
</script>