<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<html>

<head>
    <meta charset="UTF-8">
    <title>B.ONE Inventory Order Manager</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="./resources/common/css/style.css">
    <script type="text/javascript" src="./resources/common/js/common.js"></script>
	<script type="text/javascript" src="./resources/common/js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="./resources/common/js/myjs.js"></script>
</head>

<script type="text/javascript">

$(document).ready(function() {
	
	$("#pw").keydown(function(key) {
		if (key.keyCode == 13) {
			login();
		}
	});

});

function join() {
	if($("#office_id").val()==''){
		alert("아이디를 입력하세요.");
		$("#office_id").focus(); 
		return;
		}
	if($("#pw").val()==''){
		alert("비밀번호를 입력하세요.");
		$("#pw").focus();
		return;
	}
	if($("#pw").val()!=$("#pw2").val()){
		alert("비밀번호를 동일하게 입력하세요.");
		$("#pw2").focus();
		return;
	}
	
	alert( $("#admin").val());
	
	 if($("#user_group option:selected").val()== '1' && $("#admin").val()!= "dnflRlfl"){
		 $("#user_group option:selected").val()== '1' 
		alert("관리자 코드가 틀렸습니다.");
		$("#admin").focus();
		return;
	} 
	
	alert($("#user_group option:selected").val());
	
     ajaxPostSend("/insertUser", "post", "json", "join_callback","mainForm");  
}

	function  join_callback(rslt){
		
		var result = eval('('+rslt+')');
	
		if (result.errCd == '1' && result.user_group == '1') {
			alert(result.errMsg);
			location.href="/";
			
		}else{
	 		
	 		 alert(result.errMsg);
	 	}
	}
	
	function adminCheck(select) {
		  adminView.style.display = "block";
		  
	}
	
	/* ----------------------------------------------------------------------------------------- */

	</script>

<body>
    <div class="login-container">
        <div class="center box">
            <div class="login-title">
                <h3>회원가입 페이지</h3>
            </div>
            <form id="mainForm" method="post">
				<input type="hidden" id="flag" name="flag" value="" />
				<input type="hidden" id="UCP_CD" name="UCP_CD" value="01" /><!--  by lee -->

	            <div class="login-content">
	                <div class="input-group">
	                    	<label for="login-input-text">아이디 : 	</label>
	                   		<input type="text" class="df-input" id="office_id" name="office_id" value=""  placeholder="id">
	                </div>
	                <div class="input-group">
	                    <label for="login-input-text">비밀번호 : 	</label>
	                    <input type="password" class="df-input" id="pw" name="pw"  placeholder="password">					<!-- 비밀번호 -->
	                </div>
	                <div class="input-group">
	                    <label for="login-input-text">비밀번호 확인 : 	</label>
	                    <input type="password" class="df-input" id="pw2" name="pw2"  placeholder="password">				<!-- 비밀번호 확인 -->
	                </div>
	                <div class="input-group">
	                    <label for="login-input-text">이름 : 	</label>
	                    <input type="text" class="df-input" id="user_nm" name="user_nm"  placeholder="name">						<!-- 이름 -->
	                </div>
	                
	                <div class="input-group">
	                    <label for="login-input-text">연락처 : 	</label>
	                    <input type="text" class="df-input" id="phone" name="phone"  placeholder="phone" numberOnly/>		<!-- 휴대폰 번호 -->
	                </div>
	                <div class="input-group">
	                    <label for="login-input-text">이메일 : 	</label>
	                    <input type="text" class="df-input" id="email" name="email"  placeholder="email">					<!-- 이메일 -->
	                </div>
	                
	                 <div class="input-group" id="adminView" style="display: none">
	                    <label for="login-input-text">관리자 코드 : 	</label>
	                    <input type="password" class="df-input" id="admin" name="admin"  placeholder="admin code">				
	                </div>
	                
	                <div class="checkbox float-right">
	                    <label><input type="radio" name="user_group" id="user_group" value="2" checked> reseller </label>
	                    <label><input type="radio" name="user_group" id="user_group" value="1" onClick="javascript:adminCheck(this);"> admin </label>
	                    <label><input type="radio" name="user_group" id="user_group" value="3"> customer </label>
	                </div>
	               
	                <button type="button" class="btn df-btn" onClick="javascript:join();">가입</button>
	                <button type="button" class="btn df-btn" onclick="location.href='/'">취소</button>
	            </div>
            	<!-- /login-content  -->
            </form>
            <div class="login-notify">
                Administrator if account is lost,Please contact <br />
                Email : <a href="mailto:support@aetherit.io">support@aetherit.io</a>
            </div>
        </div>
        <!-- /center -->
    </div>
    <!-- /login-container -->
</body>

</html>