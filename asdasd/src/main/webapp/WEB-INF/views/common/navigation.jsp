<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
   function lfPageMove(param){

		var category = $("input[name='category0']:checked").val();
		$("#category").val(category);
		
		$("#pageNo").val(param);
		
		alert($("#form2").$(".ov").val());
		alert($("#form3").$(".ov").val());
		alert($("#form4").$(".ov").val());

		$("#r_pageNo").val($("#form2").$(".ov").val());
		$("#c_pageNo").val($("#form3").$(".ov").val());
		$("#g_pageNo").val($("#form4").$(".ov").val());
		
		$("#form1").attr("action","#"); 
		$("#form1").submit();
		
		
		
   } 
</script>
<div class="brd_btm paging" align="center">
      <a href="javaScript:lfPageMove('${pageInfo.pageBegin}')" class="btn_fir">《</a>
      
      <a href="javaScript:lfPageMove('<c:out value="${pageInfo.prevPage}"/>')" class="btn_prv">〈</a>
      
      <c:forEach begin="${pageInfo.blockBegin }" end="${pageInfo.blockEnd}" step="1" var="i">
         <c:choose>
            <c:when test="${i == pageInfo.curPage}">
            <a href="#" class="ov" >${i}</a>
            </c:when>
            <c:otherwise>
            <a href="javaScript:lfPageMove('<c:out value="${i}" />')"><c:out value="${i}"/></a>
            </c:otherwise>
         </c:choose>
      </c:forEach>
      
      <a href="javaScript:lfPageMove('<c:out value="${pageInfo.nextPage}" />')" class="btn_nxt">〉</a>
      
      <a href="javaScript:lfPageMove('<c:out value="${pageInfo.pageEnd}" />')" class="btn_last">》</a>
</div>