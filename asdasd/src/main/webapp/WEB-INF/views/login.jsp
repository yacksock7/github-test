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
	
	getLoginId();
	
	$("#pw").keydown(function(key) {
		if (key.keyCode == 13) {
			login();
		}
	});

});

function login() {
	if($("#office_id").val()=='')
		{
		alert("Please enter your ID.");
		$("#office_id").focus();
		return;
		}
	if($("#pw").val()=='')
	{
		alert("Please enter a password.");
		$("#pw").focus();
		return;
	}
	
    $("#flag").val("LOGIN");
   
    if($('input:checkbox[name="idChk"]').is(":checked")==true) { 
        saveLogin($("#office_id").val()); 
    } else {
        saveLogin(""); 
    }
   
    ajaxPostSend("/userCheck", "post", "json", "login_callback","mainForm");
}

	function  login_callback(rslt){
		
		var result = eval('('+rslt+')');
	
		if (result.errCd == '1' && result.user_group == '1') {
			
			location.href="/goods";
			
	    } else if(result.errCd == '1' && result.user_group == '2'){
	    	
	    	 location.href="/notice";
	    	 
	 	} else{
	 		
	 		 alert(result.errMsg);
	 	}
	}

	function setsave(name, value, expiredays) {
	    var today = new Date();
	    today.setDate( today.getDate() + expiredays );
	    document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + today.toGMTString() + ";"
	}

	function saveLogin(loginId) {
	    if(loginId != "") {
	       
	        setsave("office_id", loginId, 7);
	    } else {
	        
	        setsave("office_id", loginId, -1);
	    }
	}
	function confirmSave(checkbox) {
		var isRemember;
	    if(checkbox.checked) {
	        isRemember = confirm("Save login information on this PC? Your privacy can be assured.");
	    }
	    if(!isRemember){
	        checkbox.checked = false;
	    }
	}
	function getLoginId() {
	    
	    var frm = document.mainForm;
	
	    var cook = document.cookie + ";";
	    var idx = cook.indexOf('office_id', 0);
	    var val = "";

	    if(idx != -1) {
	        cook = cook.substring(idx, cook.length);
	        begin = cook.indexOf("=", 0) + 1;
	        end = cook.indexOf(";", begin);
	        val = unescape( cook.substring(begin, end) );
	    }
	    	
	    if(val!= "") {
	       	$("#office_id").val(val);
	       	$('input:checkbox[id="idChk"]').attr("checked", true); 
	    }
	}


</script>

<body>
    <div class="login-container">
        <div class="center box">
            <div class="login-title">
                <h3>Reseller 관리 페이지</h3>
            </div>
            <form id="mainForm" method="post">
				<input type="hidden" id="flag" name="flag" value="" />
				<input type="hidden" id="UCP_CD" name="UCP_CD" value="01" /><!--  by lee -->

	            <div class="login-content">
	                <div class="input-group">
	                    <label for="login-input-text"></label>
	                    <input type="text" class="df-input" id="office_id" name="office_id" value=""  placeholder="id">	<!-- 아이디 emp_no  -->
	                </div>
	                <div class="input-group">
	                    <label for="login-input-text"></label>
	                    <input type="password" class="df-input" id="pw" name="pw"  placeholder="password">		<!-- 비밀번 pswd -->
	                </div>
	                <div class="checkbox float-right">
	                    <label>
	                        <input type="checkbox" name="idChk" id="idChk" onClick="javascript:confirmSave(this);">save ID
	                    </label>
	                </div>
	                <button type="button" class="btn df-btn" onClick="javascript:login();">Login</button>
	                <button type="button" class="btn df-btn" onclick="location.href='/join'">Join</button>
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