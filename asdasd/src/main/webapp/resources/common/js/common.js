
/* 레프트 메뉴 높이 조절 */
window.onload = function(){
	height();
};

function height(){
	var autoHgt = document.getElementById("contents").offsetHeight+"px";
	document.getElementById("snb").style.height = autoHgt;
	//alert (autoHgt);
}

function validate(evt,obj) {
	var theEvent = evt || window.event;
	var keyCode = theEvent.keyCode || theEvent.which;
	var key = String.fromCharCode( keyCode );
	var regex = /[0-9]|\./;
	if( !regex.test(key) ) {
		if( keyCode == 8 ){
			return;
		}
		theEvent.returnValue = false;
		if(theEvent.preventDefault) theEvent.preventDefault();
		if( keyCode > 128 ){
			obj.value = obj.value.substring(0,obj.value.length-1);
		}
	}
}

function validateNumber(obj) {
	var regex = /[0-9]|\./;
	if( !regex.test(obj.value) ) {
		alert("숫자만 입력해 주세요.");
		obj.value="";
	}
}