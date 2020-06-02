<!-- header -->
<%@ include file="/WEB-INF/views/ws/header3.jsp"%>
<!-- //header -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!-- //header -->

<style>
	/* issue 카테고리 css */
		.switch-contents {
		  padding: 1em;
		  text-align: right;
		}
		input[name="category0"] {
		 /*   display: none;  */
		}
		.switch-contents label {
		  display: inline-block;
		  margin: 0 0.5em;
		  font-size: 1.2rem;
		  font-family: 'Open Sans', sans-serif;
		  font-weight: 300;
		  cursor: pointer;
		}
		.switch-contents label:hover {
		  border-bottom: 2px solid #000;
		}
		input[name="category0"]:checked + label { 
		  border-bottom: 2px solid #3498db;
		  cursor: default;
		}
</style>

<script type="text/javascript">
     
   // 2. 조회
   function doSearch(){
		var category = $("input[name='category0']:checked").val();
		$("#category").val(category);
	   
      window.form1.target = "";
      window.form1.action = "/management";
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
    
    function downLoadExcelForm(num){
    	if(num=="1"){ //리셀러별 
    		window.form1.target = "";
 		   //window.form1.isExcel.value = "Y";
 		   window.form1.action = "/reseller_managementExcel";
 		   window.form1.submit();
    	}else if(num=="2"){ //고객별
    		window.form1.target = "";
 		   //window.form1.isExcel.value = "Y";
 		   window.form1.action = "/custom_managementExcel";
 		   window.form1.submit();
    	}else{ //제품별
        		window.form1.target = "";
     		   //window.form1.isExcel.value = "Y";
     		   window.form1.action = "/goods_managementExcel";
     		   window.form1.submit();
        	}
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
            <span class="fa fa-windows"></span>재고 및 매출
            
          <%--   <c:if test="${user_group == 2}">
            <c:forEach items="${T_RsellerList}" var="list">
            <c:if test="${list.t_qty != 0}">
            <p>${list.manager} 님의 재고 및 매출</p>
			<a>// 판매량 : ${list.t_qty} 개</a>
			<a>// 매출 : ${list.t_price} 원</a>
			<a>// 순수익 : ${list.t_margin} 원</a>
			</c:if>
			</c:forEach>
			</c:if> --%>
         </h2>
         
         <div class="switch-contents">
          	<c:if test="${user_group == 1}">
			<input id="layout-all" type="radio" name="category0" value="" checked><label for="layout-all">All</label>
			<input id="layout-single" type="radio" name="category0" value="1" ><label for="layout-single">Reseller</label>
			</c:if>
			<input id="layout-column" type="radio" name="category0" value="2"><label for="layout-column">Customer</label>
			<input id="layout-card" type="radio" name="category0" value="3"><label for="layout-card">Goods</label>
		</div> 
      </div>

      <!-- END PAGE TITLE -->

      <!-- PAGE CONTENT WRAPPER -->
      <div class="page-content-wrap">

         <div class="row">
            <div class="col-md-12">

               <div class="panel panel-default panel-search panel-success">
					<div class="panel-heading">
                     <div class="panel_total">이번달 현황 </div>
                  	</div>

                  <form id="form1" name="form1" method="POST" class="form-horizontal">
                     <input type="hidden" id="r_pageNo" name="r_pageNo" />
                     <input type="hidden" id="c_pageNo" name="c_pageNo" />
                     <input type="hidden" id="g_pageNo" name="g_pageNo" />
					 <input type="hidden" id="category" name="category" value="${category} "/>
					 
                     <div class="panel-body">
						<c:if test="${user_group == 1}">
							<div class="row">
							 <div class="col-md-6">
                              <div class="form-group form-search">
                                 <label class="col-md-2 col-sm-2 col-xs-2 control-label">리셀러</label>
                                 <div class="col-md-5 col-sm-5 col-xs-5">
                                    <div class="input-group keyword">
                                       <select name="seller_id" id="seller_id" class="form-control"  onchange="doSearch();">
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
                                       <select name="customer_id" id="customer_id" class="form-control" onchange="doSearch();">
                                    
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

<!-- -------------------------------------------------------------------------------------------------------------------------------------- -->
<!-- 리셀러별 조회  -->
 <c:if test="${user_group == 1}">
               <div class="panel panel-default" id ="reseller_div">
                 	<div class="panel-heading">
		                     <div class="panel_total">리셀러별 조회 </div>
		                     <div class="pull-right">
		                     <button type="button" class="btn btn-green float-right" onClick="javascript:downLoadExcelForm('1');"> EXCEL </button>
		                     </div>
                 	</div>

                   <form id="form2" name="form2" method="POST" class="form-horizontal">

                     <div class="panel-body">
                        <div class="table-responsive">
                           <table id="schedule_table" 
                              class="table table-bordered table-striped">
                              <thead>
                                 <tr>
                                    <th>ID</th>
                                    <th>리셀러</th>
                                    <th>판매량</th>
                                    <th>매출</th>
                                    <th>마진</th>
                                 </tr>
                              </thead>
                              <tbody>
                                <c:forEach items="${T_RsellerList}" var="list">
                                    <tr>
                                       <td>${list.office_id}</td>
                                       <td>${list.manager}</td>
                                       <td>${list.t_qty}</td>
                                       <td> ${list.t_price}</td>
                                       <td>${list.t_margin}</td> 
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
     </c:if>          
<!-- -------------------------------------------------------------------------------------------------------------------------------------- -->
<!-- 고객별 조회  -->
               <div class="panel panel-default" id ="customer_div">
                  <div class="panel-heading">
		                     <div class="panel_total">고객별 조회 </div>
		                     <div class="pull-right">
		                     <button type="button" class="btn btn-green float-right" onClick="javascript:downLoadExcelForm('2');"> EXCEL </button>
		                     </div>
                 	</div>

                   <form id="form3" name="form3" method="POST" class="form-horizontal">

                     <div class="panel-body">
                        <div class="table-responsive">
                           <table id="schedule_table" 
                              class="table table-bordered table-striped">
                              <thead>
                                 <tr>
                                    <th>고객번호</th>
                                    <th>고객</th>
                                    <th>판매량</th>
                                    <th>매출</th>
                                    <th>마진</th>
                                    <th>담당자</th>
                                </tr>
                              </thead>
                              <tbody>
                                 <c:forEach items="${T_CustomerList}" var="list">
                                    <tr>
                                       <td>${list.customer_id}</td>
                                       <td>${list.customer_nm}</td>
                                       <td>${list.t_qty}</td>
                                       <td> ${list.t_price}</td>
                                       <td>${list.t_margin}</td>
                                       <td>${list.manager_nm}</td>
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
<!-- -------------------------------------------------------------------------------------------------------------------------------------- -->
<!-- 상품별 조회  -->

               <div class="panel panel-default" id = "goods_div">
                  <div class="panel-heading">
		                     <div class="panel_total">제품별 조회 </div>
		                     <div class="pull-right">
		                     <button type="button" class="btn btn-green float-right" onClick="javascript:downLoadExcelForm('3');"> EXCEL </button>
		                     </div>
                 	</div> 

                   <form id="form4" name="form4" method="POST" class="form-horizontal">

                     <div class="panel-body">
                        <div class="table-responsive">
                           <table id="schedule_table" 
                              class="table table-bordered table-striped">
                              <thead>
                                 <tr>
                                 	<th>상품번호</th>
                                    <th>상품</th>
                                    <th>판매량</th>
                                    <th>매출</th>
                                    <th>마진</th>
                                 </tr>
                              </thead>
                              <tbody>
                                 <c:forEach items="${T_GoodsList}" var="list">
                                    <tr>
                                       <td>${list.goods_no}</td>
                                       <td>${list.goods_nm}</td>
                                       <td>${list.t_qty}</td>
                                       <td>${list.t_price}</td>
                                       <td>${list.t_margin}</td>
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
<!-- -------------------------------------------------------------------------------------------------------------------------------------- -->
            </div>
            <!-- END PAGE CONTENT -->
         </div>
         </div>
         </div>
         <!-- END PAGE CONTAINER -->
</div>
         </body>
         </html>

         <script>
 $(document).ready(function() {
	 
    $("#s_id8").addClass("active");
    
    var category = ${category}
    console.log("category : "+ category );
    $("input[name=category0][value="+category+"]").prop("checked", true);  
     
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

$("#reseller_table tr").click(function(){    
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



//거래일자 조회
$("#fr_wb_dt").change(function(){
	var fr_wb_dt = $("#fr_wb_dt").val();
	$("#to_wb_dt").val(fr_wb_dt);
}); 

$("input[name=category0]").change(function() {
  	 doSearch();
  });
      
</script>