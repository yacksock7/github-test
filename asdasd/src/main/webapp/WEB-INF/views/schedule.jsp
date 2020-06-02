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
      window.form1.action = "/schedule";
      window.form1.submit();
   }
    
   //  - 디테일
   function doDetail(){
      window.form3.target = "";
      window.form3.action = "/schedule_Dtl";
      window.form3.submit();
   }
  
   // 저장
   function doSave(){
      if($("#customer_id3").val()=="")
      {
         alert("고객을 선택하세요 .");
         $("#customer_id3").focus(); 
         return;
      }
      
   // new    
      var dataArr = new Array();   
      
      // $('#order_table tr').each(function() {
      $("#schedule_goods_table tr").each( function (index) {
         var aJson = new Object();
         var tr = $(this);
         var td = tr.children();

         if (index == 0)
            return;
         
         var schedule_no = td.eq(0).text();
         var goods_no = td.eq(1).text();
         var goods_qty = $('#schedule_goods_table tr').eq(index).find('input[name="goods_qty"]').val(); 
         var goods_price = $('#schedule_goods_table tr').eq(index).find('input[name="goods_price"]').val();         

         aJson.goods_no = goods_no;
         aJson.goods_qty = goods_qty;
         aJson.goods_price = goods_price;
         dataArr.push(aJson); 
   
       });

      var data = {
    		 "reseller_id": $("#reseller_id4").val()
            ,"customer_id": $("#customer_id3").val() 
            ,"schedule_dt": $("#schedule_dt3").val()
            ,"memo": $("#memo3").val()
            ,"status": $("input[id='status3']:checked").val()
         	,"scheduleGoodsList" : dataArr
      }

      if (dataArr.length < 1) {
         alert("거래상품이 존재하지 않습니다.");
         return;
      }
      if (!confirm("등록하시겠습니까 ?")) {
         return;
      }

//      alert(JSON.stringify(data));
      
      $.ajax({
    	  type : 'POST',
          url: '/scheduleInsert',
          data : JSON.stringify(data),
//          	dataType: 'text',
           contentType: 'application/json; charset=utf-8',
          
          
         success : function(rslt) {
            insert_callback(rslt);
         },
         error : function(error){
        	 console.log('error');
        	 console.log(error);
       	 } 
      });
          
      // ajaxPostSend("/scheduleInsert", "post", "json", "insert_callback","form3");
   }//------------------------------------------------------------------
       
  
   function  insert_callback(rslt){
       var result = eval('('+rslt+')');
   
      alert(result.errMsg);
      
      if(result.errCd == "1"){
         doSearch();
      }
   }
   
    // 수정,삭제
   function doModify(ud_flag){    
	 
	   if($("#customer_id3").val()=="")
	      {
	         alert("고객을 선택하세요 .");
	         $("#customer_id3").focus(); 
	         return;
	      }
	   if($("#bef_status").val()=="3")
	      {
	         alert("판매 완료된 거래는 수정 삭제가 불가합니다.");
	         return;
	      }
	   var msg = "update";
	      if(ud_flag=="D") msg = "delete";
	      if (!confirm(msg+" 하시겠습니까 ?")) {
	         return;
	      }
	      $("#ud_flag").val(ud_flag);
	   // new    
	      var dataArr = new Array();   
	   
	      // $('#order_table tr').each(function() {
	      $("#schedule_goods_table tr").each( function (index) {
	         var aJson = new Object();
	         var tr = $(this);
	         var td = tr.children();

	         if (index == 0)
	            return;
	         
	         var schedule_no = td.eq(0).text();
	         var goods_no = td.eq(1).text();
	         var goods_qty = $('#schedule_goods_table tr').eq(index).find('input[name="goods_qty"]').val(); 
	         var goods_price = $('#schedule_goods_table tr').eq(index).find('input[name="goods_price"]').val();   
	         var legacy_qty = $('#schedule_goods_table tr').eq(index).find('input[name="legacy_qty"]').val();        

	         aJson.schedule_no = schedule_no;
	         aJson.goods_no = goods_no;
	         aJson.goods_qty = goods_qty;
	         aJson.goods_price = goods_price;
	         aJson.legacy_qty = legacy_qty;
	         dataArr.push(aJson); 
	       });
	      $("#ud_flag").val(ud_flag);
	      var data = {
	    		 "schedule_no": $("#schedule_no3").val()
	            ,"reseller_id": $("#reseller_id4").val()
	            ,"customer_id": $("#customer_id3").val() 
	            ,"schedule_dt": $("#schedule_dt3").val()
	            ,"memo": $("#memo3").val()
	            ,"status": $("input[id='status3']:checked").val()
	            ,"ud_flag": $("#ud_flag").val()
	            ,"bef_status" : $("#bef_status").val()
	         	,"scheduleGoodsList" : dataArr
	      }
	      
	      if (dataArr.length < 1) {
	         alert("거래상품이 존재하지 않습니다.");
	         return;
	      }

	      alert(JSON.stringify(data));
	   
	      $.ajax({
	    	  type : 'POST',
	          url: '/scheduleUpdate',
	          data : JSON.stringify(data),
//	          	dataType: 'text',
	           contentType: 'application/json; charset=utf-8',
	          
	          
	         success : function(rslt) {
	            insert_callback(rslt);
	         },
	         error : function(error){
	        	 console.log('error');
	        	 console.log(error);
	       	 } 
	      });
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
    	   var ud_div = document.getElementById("ud_div");
       	var r_div = document.getElementById("r_div");

         $("#customer_id3").val('');
         $("#deal_qty3").val('');
         $("#goods_no3").val('');
          $("#goods_qty3").val('');
          $("#schedule_dt3").val(endDate);
          $("#memo3").val('');
          
       r_div.style.display = "block"; 
       ud_div.style.display = "none"; 
      } 
    function goTop(){
         $('html').scrollTop(0);
      }
 
    
    
    // 거래상품 선택시 상품테이블에 추가 
    function schedule_goods_add(){
      if( $("#goods_no3").val() =='') return;
      
      var schedule_no = $("#schedule_no3").val();
      var goods_no =  $("#goods_no3").val();
      var goods_nm =  $("#goods_no3").find(":selected").text();

      var cellsOfRow = "<tr>";
      cellsOfRow += "<td  style='display:none;' >" + schedule_no + "</td>";
      cellsOfRow += "   <td>" + goods_no + "</td>";
      cellsOfRow += "   <td>"+goods_nm+"</td>";
      cellsOfRow += "   <td><input  style='color:red' type='number' value=''";
      cellsOfRow += "      class='df-input-desc' id='goods_qty' name='goods_qty'></td>";   
      cellsOfRow += "   <td><input  style='color:red' type='text' value=''";
      cellsOfRow += "      class='df-input-desc' id='goods_price' name='goods_price'></td>";
      cellsOfRow += "   <td> <button type='button' class='btn btn-danger'> <i class='fa fa-minus'>DEL</i> </button></td>";
      cellsOfRow += "</tr>";                                                  

      $("#schedule_goods_table").append(cellsOfRow);
    }
    
    function sellerChange(){
   	 doSearch();
   	}
    
	 function downLoadExcelForm(){
		   window.form1.target = "";
		   //window.form1.isExcel.value = "Y";
		   window.form1.action = "/scheduleExcel";
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
            <span class="fa fa-windows"></span>영업 관리
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
						<c:if test="${user_group == 1}">
							<div class="row">
							 <div class="col-md-6">
                              <div class="form-group form-search">
                                 <label class="col-md-2 col-sm-2 col-xs-2 control-label">리셀러</label>
                                 <div class="col-md-5 col-sm-5 col-xs-5">
                                    <div class="input-group keyword">
                                       <select name="seller_id" id="seller_id" class="form-control"  onchange="sellerChange();">
                                       <option value="" <c:if test="${seller_id == '' }">selected="selected"</c:if>>-ALL-</option>
                                       <c:forEach items="${resellerList}" var="resellerList">
                                          <option value="${resellerList.office_id}" <c:if test="${resellerList.office_id == seller_id }">selected="selected"</c:if>>${resellerList.manager }</option>
                                       </c:forEach>
                                       
                                    </select>
                                    </div>
                                 </div>
                              </div>
                           </div>
                          <div class="col-md-6">
                            </div>
                        </div>
                        </c:if>



                        <div class="row">
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
		                                 <label class="col-md-2 col-sm-2 col-xs-2 control-label">스케쥴상태</label>
											 <div style=" float: left; padding-left : 10px;">
											 <label class="check"><input type="radio" class="iradio" id="s_status" name="s_status" value="" checked> 전체 </label> &nbsp;
		                                    <label class="check"><input type="radio" class="iradio" id="s_status" name="s_status" value="1" > 미팅 </label> &nbsp;
		                                    <label class="check"><input type="radio" class="iradio" id="s_status" name="s_status" value="2" > 제품계약 </label> &nbsp; 
		                                    <label class="check"><input type="radio" class="iradio" id="s_status" name="s_status" value="3" > 판매 </label> &nbsp; 
		                              </div> 
		                              </div>
                           </div>
                           <div class="col-md-6">
                              <div class="form-group form-search">
                                 <label class="col-md-2 col-sm-2 col-xs-2 control-label">페이지</label>
                                 <div class="col-md-10 col-sm-10 col-xs-10">
                                    <div class="input-group field">
                                       <select class="form-control select" name="pageView"
                                          id="pageView" onchange="doSearch();">
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
                                       <button type="button" class="btn btn-success"
                                          onClick="javascript:doSearch();">Search</button>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                  </form>
               </div>


               <!--           리셀러 리스트              -->

               <div class="panel panel-default">
                 			<div class="panel-heading">
		                     <div class="panel_total">영업 schedule ${count}  </div>
		                     <div class="pull-right">
		                     <button type="button" class="btn btn-green float-right" onClick="javascript:downLoadExcelForm();"> EXCEL </button>
		                     </div>
                 		 </div>

                  <form name="form2">

                     <div class="panel-body">
                        <div class="table-responsive">
                           <table id="schedule_table" 
                              class="table table-bordered table-striped">
                              <thead>
                                 <tr>
                                    <th>스케쥴 번호</th>
                                    <th	style="display: none;">리셀러 ID</th>
                                    <th>리셀러명</th>
                                    <th style="display: none;">고객ID</th>
                                    <th>고객명</th>
                                    <th>미팅날짜</th>
                                    <th>메모</th>
                                    <th>상태</th>
                                    <th>제품수량</th>
                                    <th>판매금액</th>

                                 </tr>
                              </thead>
                              <tbody>

                                 <c:forEach items="${scheduleList}" var="list">
                                    <tr>
                                       <td>${list.schedule_no}</td>
                                       <td style="display: none;">${list.reseller_id}</td>
                                       <td> ${list.reseller_nm}</td>
                                       <td style="display: none;">${list.customer_id}</td>
                                       <td> ${list.customer_nm} </td>
                                       <td>${list.schedule_dt}</td>
                                       <td>${list.memo}</td>
                                       <td>
                                       <c:if test="${list.status == 1 }"> 미팅</c:if>
                                       <c:if test="${list.status == 2 }"> 제품관리</c:if>
                                       <c:if test="${list.status == 3 }"> 판매</c:if>
                                       </td> 
                                       <td>${list.total_qty}</td>
                                       <td>${list.total_price}</td> 
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

                  <!-- 리셀러 상세 -->
                  <div class="col-md-12">

                     <form id="form3" name="form3" method="POST" target="sysfrm"
                        class="form-horizontal" enctype="multipart/form-data">
                        <input type="hidden" id="pageNo" name="pageNo" /> 
                        <input type="hidden" id="ud_flag" name="ud_flag" /> 
                        <input type="hidden" id="schedule_no3" name="schedule_no" value="${scheduleOne.schedule_no}"/>
                        <input type="hidden" id="bef_status" name="bef_status" value="${scheduleOne.status}" />
                           
                        <div class="panel panel-default">
                           <div class="panel-heading">
                              <h2 class="panel-title">리셀러 상세</h2>

                              <div id="r_div">
                                 <div class="btn-group pull-right">
                                    <button type="button" onclick="doSave();"
                                       class="btn btn-info pull-right">등록하기</button>
                                 </div>
                              </div>
                              <div style="display: none" id="ud_div">
                                 <div class="btn-group pull-right">
                                    <button type="button" onclick="doReset();"
                                       class="btn btn-success">X</button>
                                 </div>
                                  <div class="btn-group pull-right">
                                    <button type="button" onclick="doModify('D');"
                                       class="btn btn-danger pull-right">삭제하기</button>
                                 </div> 
                                 <div class="btn-group pull-right">
                                    <button type="button" onclick="doModify('U');"
                                       class="btn btn-info pull-right">수정하기</button>
                                 </div>
                              </div>
                           </div>

                           <div class="panel-body">
                              <div id="divList" class="row">
                                 <div class="col-md-6">
                                    <div class="form-group">
                                       <label class="col-md-2 col-sm-2 control-label">리셀러명</label>
                                       <div class="col-md-8 col-sm-8">
                                          <p id="reseller_id3" name="" class="form-control"
                                             style="text-align: left">${cookie.userCook.value }</p> 
                                          <input type="hidden" id="reseller_id4" name="reseller_id"
                                             class="form-control" value="${reseller_id}">
                                       </div>
                                    </div>

                                    <div class="form-group">
                                       <label class="col-md-2 col-sm-2 control-label">구매고객</label>
                                       <div class="col-md-8 col-sm-8">
                                          <select name="customer_id" id="customer_id3" onchange=""
                                             class="form-control">
                                             <option value=""
                                                <c:if test="${customer_nm == '' }">selected="selected"</c:if>>-SELECT-</option>
                                             <c:forEach items="${customList}" var="customList">
                                                <option value="${customList.customer_id}"
                                                   <c:if test="${customList.customer_id == scheduleOne.customer_id }">selected="selected"</c:if>>${customList.customer_nm }</option>
                                             </c:forEach>
                                          </select> <span class="caret"
                                             style="position: absolute; top: 50%; right: 12px; margin-top: -2px; vertical-align: middle;"></span>
                                       </div>
                                    </div>

                                    <div class="form-group">
                                       <label class="col-md-2 col-sm-2 control-label">미팅날짜</label>
                                       <div class="col-md-8 col-sm-8">
                                          <input type="date" id="schedule_dt3" name="schedule_dt"  value="${scheduleOne.schedule_dt}"
                                             class="df-input input-date">
                                       </div>
                                    </div>
                                    <div class="form-group">
                                       <label class="col-md-2 col-sm-2 control-label">메모</label>
                                       <div class="col-md-8 col-sm-8">
                                          <textarea id="memo3" name="memo"
                                          class="form-control">${scheduleOne.memo}</textarea>
                                       </div>
                                    </div>
                                    <div class="form-group">
		                                 <label class="col-md-2 col-sm-2 control-label">스케쥴상태</label>
		                                 <div class="col-md-8 col-sm-8">
		                                    <label class="check"><input type="radio" class="iradio" id="status3" name="status" value="1" checked> 미팅 </label> &nbsp;
		                                    <label class="check"><input type="radio" class="iradio" id="status3" name="status" value="2" > 제품계약 </label> &nbsp; 
		                                    <label class="check"><input type="radio" class="iradio" id="status3" name="status" value="3" > 판매 </label> &nbsp; 
		                                 </div>
		                              </div> 
                                 </div>

                                 <div class="col-md-6">
                                 <div class="form-group">
                                       <label class="col-md-2 col-sm-2 control-label">거래상품</label>
                                       <div class="col-md-8 col-sm-8">
                                          <select name="goods_no" id="goods_no3" onchange="schedule_goods_add();"
                                             class="form-control">
                                             
                                             <option value=""
                                                <c:if test="${goods_nm == '' }">selected="selected"</c:if>>-SELECT-</option>
                                             <c:forEach items="${goodsList}" var="goodsList">
                                                <option value="${goodsList.goods_no}"
                                                   <c:if test="${goodsList.goods_no == goods_no }">selected="selected"</c:if>>${goodsList.goods_nm }</option>
                                               
                                             </c:forEach>
                                          </select> <span class="caret"
                                             style="position: absolute; top: 50%; right: 12px; margin-top: -2px; vertical-align: middle;"></span>
                                       </div>
                                    </div>
                                    
                                 
                                       <div class="panel-body">
                                          <div class="table-responsive">
                                             <table id="schedule_goods_table" name="schedule_goods_table"
                                                class="table table-bordered table-striped">
                                                <thead>
                                                   <tr>
                                                      <th style="display: none;">스케쥴번호</th>
                                                      <th>상품cd</th>
                                                      <th>상품nm</th>
                                                      <th>예상수량</th>
                                                      <th>금액</th>
                                                      <th>DEL</th>
                                                   </tr>
                                                </thead>
                                                <tbody id="factory_tbody">
                                                <c:forEach items="${scheduleGoodsList}" var="list">
                                                   <tr>
                                                      <td style="display: none;">${list.schedule_no}</td>
                                                      <td>${list.goods_no}</td>
                                                      <td>${list.goods_nm}</td>
                                                      <td><input style="color:red" type="text" class="df-input-desc" id="goods_qty" name="goods_qty" value="${list.goods_qty}"></td>   
                                                      <td><input style="color:red" type="text" class="df-input-desc" id="goods_price" name="goods_price"  value="${list.goods_price}"></td>   
                                                      <td> <button type='button' class='btn btn-danger'> <i class='fa fa-minus'>DEL</i></button></td>
													  <td style="display: none;">
													  		<input type="hidden" id="legacy_qty" name="legacy_qty"  value="${list.goods_qty}"/>
													  </td>
                                                   </tr>
                                                </c:forEach>

                                                </tbody>
                                             </table>

                                          </div>
                                 </div>
                                  </form>
                              </div>

                              <div>
                                 <button type="button" onclick="goTop()"
                                    class="btn btn-info pull-right">맨 위로 ↑</button>
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

         </body>
         </html>

         <script>
 $(document).ready(function() {
    $("#s_id5").addClass("active");
    getdate();
     
    
    var map = new Map();
    var schedule = ${scheduleOne.schedule_no}
    
    console.log(schedule);

    if(schedule!=null){
		  $('#ud_div').show();
			$('#r_div').hide();
	
    	 location.href = "#memo3";
    }   
    
    var status3 = ${scheduleOne.status}
    $("input[id=status3][value="+status3+"]").prop("checked",true); 
    var s_status = ${s_status}
    $("input[id=s_status][value="+s_status+"]").prop("checked",true); 
    
 });

function  getdate(){
    var fromDate = Date.today().addMonths(-1);
    var endDate  = Date.today();

    fromDate = fromDate.toString("yyyy-MM-dd");
    endDate = endDate.toString("yyyy-MM-dd");
    
    $("#schedule_dt3").val(endDate);
    
}

$("#schedule_table tr").click(function(){    
    var str = ""
    var tdArr = new Array();   // 배열 선언
    
    // 현재 클릭된 Row(<tr>)
    var tr = $(this);
    var td = tr.children();
    
    // tr.text()는 클릭된 Row 즉 tr에 있는 모든 값을 가져온다.
    // td.eq(index)를 통해 값을 가져올 수도 있다.schedule_no
   $("#schedule_no3").val(td.eq(0).text()); 
    $("#reseller_id4").val(td.eq(1).text());
    $("#customer_id3").val(td.eq(2).text()).prop("selected", true);
    $("#goods_no3").val(td.eq(3).text()).prop("selected", true);
    $("#goods_qty3").val(td.eq(4).text());
    $("#schedule_dt3").val(td.eq(5).text());
    $("#memo3").val(td.eq(6).text());
    
   	doDetail();

});

// DEL 선택시 제품 제거 
$('#factory_tbody').on("click", "button", function() {
   $(this).closest("tr").remove();
});


//거래일자 조회
$("#fr_wb_dt").change(function(){
	var fr_wb_dt = $("#fr_wb_dt").val();
	$("#to_wb_dt").val(fr_wb_dt);
}); 

      
</script>