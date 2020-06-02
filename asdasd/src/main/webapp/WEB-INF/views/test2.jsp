<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
<meta charset="UTF-8">

<script type="text/javascript" src="./../resources/jquery/lib/jquery.js"></script>
<script type='text/javascript' src='./../resources/jquery/lib/jquery.bgiframe.min.js'></script>
<script type='text/javascript' src='./../resources/jquery/lib/jquery.ajaxQueue.js'></script>
<script type='text/javascript' src='./../resources/jquery/jquery.autocomplete.js'></script>
<link rel="stylesheet" type="text/css" href="./../resources/jquery/jquery.autocomplete.css" />
</head>
<body>
<style>
#wrapper {
  width:150px;
  height:150px;
  background: green;
  box-shadow: 0 1px 15px rgba(0,0,0,.8);
  position:absolute;
}

#line-wrapper {
  cursor:pointer;
  width:56px;
  height:35px;
  position:relative;
  top:52.5px;
  left:47px;
}

/* 추가된 부분 */
.init {
  animation:none !important;
}

.line {
  background:#ffffff;
  margin-top:6px;
  margin-bottom:6px;
  width:56px;
  height:7px; 
  border-radius:2px;
  box-shadow:0 1px 3px rgba(0,0,0,.5);
  position:relative;
}

.line-top {
  animation:line-top .5s forwards ease-out,
            line-top-rotate .3s .5s forwards ease-out;
}

/* 추가된 부분 */
.top-reverse {
  animation:line-top-rotate-reverse .3s forwards ease-out,
            line-top-reverse .5s .3s forwards ease-out;
}

.line-mid {
  animation:line-mid .5s forwards ease-out;
}

/* 추가된 부분 */
.mid-reverse {
  animation:line-mid-invisible .3s forwards ease-out, 
            line-mid-reverse .5s .3s forwards ease-out;
}

.line-bot {
  animation:line-bot .5s forwards ease-out,
            line-bot-rotate .3s .5s forwards ease-out;
}

/* 추가된 부분 */
.bot-reverse {
  animation:line-bot-rotate-reverse .3s forwards ease-out,
            line-bot-reverse .5s .3s forwards ease-out;
}

@keyframes line-top {
  0% {transform:translateY(0px)}
  100% {transform:translateY(13px)}
}

/* 추가된 부분 */
@keyframes line-top-reverse {
  0% {transform:translateY(13px)}
  100% {transform:translateY(0px)}
}

@keyframes line-top-rotate {
  0% {transform:translateY(13px) rotateZ(0deg)}
  100% {transform:translateY(13px) rotateZ(45deg)}
}

/* 추가된 부분 */
@keyframes line-top-rotate-reverse {
  0% {transform:translateY(13px) rotateZ(45deg)}
  100% {transform:translateY(13px) rotateZ(0deg)}
}

@keyframes line-mid {
  0% {transform:scale(1)}
  100% {transform:scale(0)}
}

/* 추가된 부분 */
@keyframes line-mid-reverse {
  0% {transform:scale(0)}
  100% {transform:scale(1)}
}

@keyframes line-mid-invisible {
  0% {transform:scale(0)}
  100% {transform:scale(0)}
}

@keyframes line-bot {
  0% {transform:translateY(0px)}
  100% {transform:translateY(-13px)}
}

/* 추가된 부분 */
@keyframes line-bot-reverse {
  0% {transform:translateY(-13px)}
  100% {transform:translateY(0px)}
}

@keyframes line-bot-rotate {
  0% {transform:translateY(-13px) rotateZ(0deg)}
  100% {transform:translateY(-13px) rotateZ(135deg)}
}

/* 추가된 부분 */
@keyframes line-bot-rotate-reverse {
  0% {transform:translateY(-13px) rotateZ(135deg)}
  100% {transform:translateY(-13px) rotateZ(0deg)}
}
</style>
	<script>
	
	$('#line-wrapper').click(function(){
	  /* 추가된 부분 */
	  $('.line').removeClass('init');
	  $('#line-top').toggleClass('line-top').toggleClass('top-reverse');
	  $('#line-mid').toggleClass('line-mid').toggleClass('mid-reverse');
	  $('#line-bot').toggleClass('line-bot').toggleClass('bot-reverse');
	})
	</script>
	

<div id="wrapper">
  <div id="line-wrapper">
    <!-- 추가된 부분 -->
    <div id="line-top" class="line init top-reverse"></div>
    <div id="line-mid" class="line init mid-reverse"></div>
    <div id="line-bot" class="line init bot-reverse"></div>
  </div>
</div>
	
</body>
</html>