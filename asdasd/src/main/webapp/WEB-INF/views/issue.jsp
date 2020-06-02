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
     
     	/* issue 카테고리 css */
		.switch-contents {
		  padding: 1em;
		  text-align: right;
		}
		input[name="category0"] {
		    display: none;  
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
$(document).ready(function() {
    $("#s_id6").addClass("active");
    
    var category = ${category}
    console.log("category : "+ category );
    $("input[name=category0][value="+category+"]").prop("checked", true);   
    
	/* 해시 태그 */ 
    var tag = {};
    var counter = 0;

    // 태그를 추가한다.
    function addTag (value) {
        tag[counter] = value; // 태그를 Object 안에 추가
        counter++; // counter 증가 삭제를 위한 del-btn 의 고유 id 가 된다.
    }

    // 최종적으로 서버에 넘길때 tag 안에 있는 값을 array type 으로 만들어서 넘긴다.
    function marginTag () {
        return Object.values(tag).filter(function (word) {
            return word != "";
        });
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
    /* ------------------------------------------------------------------------ */
	   
    /* 자동완성 - 제목 */
  	var availableTags = new Array(); 
 		<c:forEach items="${issueList}" var="item">
 			availableTags.push("${item.issue_title}");
 	    </c:forEach>
 	      
 	 $jqy("#issue_title").autocomplete(availableTags,{ 
	        matchContains: true,
	        selectFirst: false
	    });   
 	 
 	 /* 자동완성 - 태그 */
 	 var availableTags = new Array(); 
  	<c:forEach items="${issueTagList}" var="item">
		availableTags.push("${item.issue_tag}");
 	</c:forEach>
   
	$jqy("#issue_tag").autocomplete(availableTags,{ 
    matchContains: true,
    selectFirst: false
	});    
 });
 
 /* ------------------------------------------------------------- */
function doSearch(){
	 var category = $("input[name='category0']:checked").val();
	$("#category").val(category); 
   	window.form1.target = "";
   	window.form1.action = "/issue";
   	window.form1.submit();
}

//enter 시 조회
$("#issue_title").on("keypress", function (e) {  
	alert("123");
	if (e.key == "Enter"){
		doSearch();
		}
  });

//저장
function doSave(){
	 if($("#issue_title3").val()=="") {
		 alert("제목을 입력해주세요.");
		 return;
	 }if($("#issue_content3").val()=="") {
		 alert("기술내용을 입력해주세요.");
		 return;
	 }
   
	// new    
  	var dataArr = new Array();   
   	var ele = document.getElementById('tag-list');
	var eleCount = ele.childElementCount;
	
   	$("#tag-list li").each( function (index) {
	alert(index);
    var aJson = new Object();
    var ul = $("#tag-list");
    var li = ul.children();
 	
		 var issue_tag = li.eq(index).text().slice(0,-1);
		 aJson.issue_tag = issue_tag;
		 dataArr.push(aJson); 
    });

   var data = {
 		 "reg_id": $("#reg_id4").val()
         ,"customer_id": $("#customer_id3").val() 
         ,"issue_title": $("#issue_title3").val()
         ,"issue_msg": $("#issue_msg3").val()
         ,"issue_category": $("input[id='issue_category']:checked").val()
      	,"issueTagList" : dataArr
   }

// alert(JSON.stringify(data));
   $.ajax({
 	   type : 'POST',
       url: '/issueInsert',
       data : JSON.stringify(data),
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
//------------------------------------------------------------------
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

 function sellerChange(){
	 doSearch();
	}
</script>
<html>
<body>
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
            <span class="fa fa-windows"></span>기술지원</h2> 
				<div class="switch-contents">
				  <input id="layout-all" type="radio" name="category0" value="" checked><label for="layout-all">All</label>
				  <input id="layout-server" type="radio" name="category0" value="1"><label for="layout-server">Server</label>
				  <input id="layout-incoder" type="radio" name="category0" value="2"><label for="layout-incoder">incoder</label>
				  <input id="layout-cam" type="radio" name="category0" value="3"><label for="layout-cam">cam</label>
				</div>         
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
                           <input type="hidden" id="category" name="category" value="${category} "/>

                     <div class="panel-body">
                        <div class="row">
                        			<div class="col-md-6">
										<div class="form-group form-search">
											<label class="col-md-2 col-sm-2 col-xs-2 control-label">제목</label>
											<div class="col-md-10 col-sm-10 col-xs-10">
												<div class="input-group keyword">
													<input type="text" id="issue_title" name="issue_title" value="${issue_title}" placeholder="enter title" class="form-control"/>
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
							<c:if test="${user_group == 1}">
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
                         </c:if>
                          <div class="col-md-6">
										<div class="form-group form-search">
											<label class="col-md-2 col-sm-2 col-xs-2 control-label">태그</label>
											<div class="col-md-10 col-sm-10 col-xs-10">
												<div class="input-group keyword">
													<input type="text" id="issue_tag" name="issue_tag" value="${issue_tag}" placeholder="enter tag" class="form-control"/>
												</div>
											</div>
										</div>
									</div>
                        </div>
						
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
                     <div class="panel_total">기술지원 요구사항 </div>
                  </div>

                  <form name="form2">
                     <div class="panel-body">
                        <div class="table-responsive">
                           <table id="deal_table" name="deal_table" class="table table-bordered table-striped">
                              <thead>
                                 <tr>
                                    <th>이슈번호</th>
                                    <th>작성자</th>
                                    <th>고객명</th>
                                    <th>제목</th>
                                    <th style="display: none;">내용</th>
                                    <th>게시일</th>
                                 </tr>
                              </thead>
                              <tbody>
                                       
                                  <c:forEach items="${issueList}" var="list">
                                    <tr>
                                       <td>${list.issue_no}</td>
                                       <td style="display: none;">${list.reg_id}</td>
                                       <td>${list.reg_nm}</td>
                                       <td style="display: none;">${list.customer_id}</td>
                                       <td>${list.customer_nm}</td>
                                       <td><a href="/issueDetail/${list.issue_no}">${list.issue_title}</a></td>
                                       <td style="display: none;">${list.issue_msg}</td>
                                       <td>${list.issue_dt}</td>
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
                              <h2 class="panel-title">요구사항 등록</h2>
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
                                 <label class="col-md-2 col-sm-2 control-label">작성자</label>
                                 <div class="col-md-8 col-sm-8">
                                  	<p id="reg_id3" name="" class="form-control" style="text-align:left">${cookie.userCook.value }</p>
									<input type="hidden" id="reg_id4" name="reg_id" class="form-control" value="<%=(String) request.getSession().getAttribute("user_id")%>">
                                 </div>
                              </div>
                              
                                <div class="form-group">
                                       <label class="col-md-2 col-sm-2 control-label">구매고객</label>
                                       <div class="col-md-8 col-sm-8">
                                          <select id="customer_id3" name="customer_id"  onchange=""
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
                                 <label class="col-md-2 col-sm-2 control-label">제목</label>
                                 <div class="col-md-8 col-sm-8">
                                 	<input type="text" id="issue_title3" name="issue_title" class="form-control">
                                 </div>
                              </div>
                              
                              <div class="form-group">
                                 <label class="col-md-2 col-sm-2 control-label">오류현상</label>
                                 <div class="col-md-8 col-sm-8">
                                 	<textarea id="issue_msg3" name="issue_msg" class="form-control"
                                 	style = "height:300px;"></textarea> 
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
						        	</ul>
                                 </div>
                              </div>
                              
                               <div class="form-group">
                                 <label class="col-md-2 col-sm-2 control-label">카테고리</label>
                                 <div class="col-md-8 col-sm-8">
									<label class="check"><input type="radio" class="iradio" name="issue_category" id="issue_category" value="1" checked/> Server  </label> &nbsp;
									<label class="check"><input type="radio" class="iradio" name="issue_category" id="issue_category" value="2" /> incoder  </label> &nbsp; 
									<label class="check"><input type="radio" class="iradio" name="issue_category" id="issue_category" value="3" /> cam  </label> &nbsp;      
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
 //거래일자 조회
   $("#fr_wb_dt").change(function(){
   	var fr_wb_dt = $("#fr_wb_dt").val();
   	$("#to_wb_dt").val(fr_wb_dt);
   });

   $("input[name=category0]").change(function() {
   	 doSearch();
   });
  
</script>