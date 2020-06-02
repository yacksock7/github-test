<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  

<html>
<head>
  <meta charset="UTF-8">
  <title>리셀러 관리 시스템</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  <!-- 자동완성 기능  -->
  	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">	
<!-- 	<script src="http://docs.oracle.com/javaee/5/jstl/1.1/docs/tlddocs/fn/tld-summary.html"></script>
 -->	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  
 <!--  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script> -->
  <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>


 <!-- CSS INCLUDE -->    
  	<script type="text/javascript" src="./../resources/common/js/myjs.js"></script>
    <link rel="stylesheet" href="./../resources/common/css/style.css">
    <link rel="stylesheet" href="./../resources/common/css/admin.css">
    <link rel="stylesheet" href="./../resources/common/css/theme-default.css">
    
<!-- EOF CSS INCLUDE -->    
		<script type="text/javascript" src="./../resources/common/js/date.js"></script><!--  날짜  -->

		<!-- START PLUGINS -->
        <!-- <script type="text/javascript" src="./../resources/common/js/jquery.min.js"></script> -->
        <!-- <script type="text/javascript" src="./../resources/common/js/jquery-ui.min.js"></script> -->
        <script type="text/javascript" src="./../resources/common/js/bootstrap.min.js"></script>        
		<!-- <script type='text/javascript' src='./../resources/common/js/icheck.min.js'></script> -->
		<!-- <script type='text/javascript' src='./../resources/common/js/plugins.js'></script> -->
		<script type='text/javascript' src='./../resources/common/js/actions.js'> </script>
		
        <!-- END PLUGINS -->
		
		<!-- <script language="javascript" type="text/javascript" src="./../resources/common/js/ckeditor.js"></script> -->
		<!-- <script language="javascript" type="text/javascript" src="./../resources/common/js/bootstrap-datepicker.js"></script> -->
		<!-- <script language="javascript" type="text/javascript" src="./../resources/common/js/validate.js"></script> -->
		<!-- <script language="javascript" type="text/javascript" src="./../resources/common/js/admin_func.js"></script> -->



<!-- 자동완성  --> 
<script type="text/javascript" src="./../resources/jquery/lib/jquery.js">  </script>
<script type="text/javascript">
	var $jqy = $.noConflict();
</script>
<script type='text/javascript' src='./../resources/jquery/lib/jquery.bgiframe.min.js'></script>
<script type='text/javascript' src='./../resources/jquery/lib/jquery.ajaxQueue.js'></script>
<script type='text/javascript' src='./../resources/jquery/jquery.autocomplete.js'></script>
<link rel="stylesheet" type="text/css" href="./../resources/jquery/jquery.autocomplete.css" /> 
</head>

<body>
  <header class="header">
    <!-- <div class="header-logo">LOGO</div> -->
    <ul class="header-info">
      <li><span class="header-user-name">${cookie.userCook.value }</span></li>
      <li><button type="button" class="btn" onclick="location.href='/logout'" >Log out</button></li>
<!--       <li><button type="button" class="btn">Properties</button></li> -->
      
      
      
    </ul>
    <div class="header-company-logo float-right" style="
    font-weight: 600;"><a href="/mypage">My Page</a>&nbsp;&nbsp;</div>
    
  </header>
  <!-- /header -->
  
  <style type = "text/css"> <!-- 로딩바스타일 -->
  	.content-main-nav a{
	   color: #3fbae4;
	}		
  	a:hover {
    	color: #3fbae4;
    	text-decoration:none;
	}
	
	body
	{
	 text-align: center;
	 margin: 0 auto;
	}
	#Progress_Loading
	{
	 position: absolute;
	 left: 50%;
	 top: 50%;
	 transform: translate(-50%, -50%);
	 z-index : 999;
	}
	</style>	

    <div  id="menu-box" class="content-main-nav" style="OVERFLOW-Y:auto; height:150px; padding-bottom: 300px;">
    
	  	<!--  left menu 구성  -->
	    <div class="content-main-nav">
	    <c:if test="${user_group == 1}">
	      <a id="s_id1" class="main-nav" href="/goods.do">제품관리 <span class="icon-arrow1"></span></a>
	      <a id="s_id2" class="main-nav" href="/reseller.do">리셀러관리 <span class="icon-arrow1"></span></a>
	      <!-- <a id="s_id4" class="main-nav" href="/deal.do">거래내역관리 <span class="icon-arrow"></span></a> -->
	     </c:if>
	      
	      <a id="s_id3" class="main-nav" href="/custom.do">고객관리 <span class="icon-arrow"></span></a>
	      <a id="s_id5" class="main-nav" href="/schedule.do">영업관리 <span class="icon-arrow1"></span></a>
	      <a id="s_id6" class="main-nav" href="/issue.do">기술지원 <span class="icon-arrow"></span></a>
	      <a id="s_id7" class="main-nav" href="/notice.do">공지사항 <span class="icon-arrow"></span></a>
	      <a id="s_id8" class="main-nav" href="/management2.do"> 재고 및 매출 <span class="icon-arrow"></span></a>
    	</div>	   
		<!--  left menu 구성  -->   
		
     </div>
<!--   
   <script>
    function ajaxStart(){
		$('#Progress_Loading').show(); //ajax실행시 로딩바를 보여준다.
	}
	function ajaxStop(){
		$('#Progress_Loading').hide(); //ajax종료시 로딩바를 숨겨준다.
	}
  </script>
   -->
<div style="display:none" id = "Progress_Loading"><!-- 로딩바 -->
	<!-- <img src="./../resources/common/images/Progress_Loading.gif"/> -->
</div>
