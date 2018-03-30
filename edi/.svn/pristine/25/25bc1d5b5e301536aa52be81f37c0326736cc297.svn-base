<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/ajax-lib.tld" prefix="ajax"%>
<%@ page import="java.util.*" %>

<html>
<ajax:library />
<script language="javascript">
	function displayIt(flag) {
		if (flag == 0) {
			document.all.detail.style.visibility = 'hidden';
		} else {
			document.all.detail.style.top = document['body'].scrollTop
					+ event.clientY;
			document.all.detail.style.left = document['body'].scrollLeft
					+ event.clientX;
			document.all.detail.style.visibility = 'visible';
		}
	}

	function getData(no, title) {
		var param = '';
		param = "&where=detail&no=" + no + "&title=" + title;
//		alert(param);
		<ajax:open callback="on_loadedXML" 
						    param="param" 
						    method="POST" 
						    urlvalue="sam010.ajax"/>
	}

	<ajax:callback function="on_loadedXML">
//	alert(xml);
	//rowsNode[로우].childNodes[컬럼].childNodes[0].nodeValue;
	var no = rowsNode[0].childNodes[0].childNodes[0].nodeValue;
	var title = rowsNode[0].childNodes[1].childNodes[0].nodeValue;
	var writer = rowsNode[0].childNodes[2].childNodes[0].nodeValue;
	var contents = rowsNode[0].childNodes[3].childNodes[0].nodeValue;

	document.all.title.value = title != 'null' ? title : '';
	document.all.writer.value = writer != 'null' ? writer : '';
	document.all.contents.value = contents != 'null' ? contents : '';
	document.all.no.value = no;
	</ajax:callback>
</script>
<body>
[JSTL + AJAX]
<table border="1">
	<tr>
		<td>번호</td>
		<td>제목</td>
		<td>작성자</td>
		<td>작성일</td>
	</tr>
	<c:forEach items="${ret}" var="it">
		<tr>
			<td><c:out value="${it.no}" /></td>
			<td style="cursor: hand;"
				onmouseover="javascript:getData('<c:out value="${it.no}"/>', '<c:out value="${it.title}"/>'), displayIt(1);"
				onmouseout="javascript:displayIt(0);"><font color="blue"><c:out
				value="${it.title}" /></font></td>
			<td><c:out value="${it.writer}" /></td>
			<td><c:out value="${it.wdate}" /></td>
		</tr>
	</c:forEach>

</table>
<div id="detail"
	style="width: 600px; height: 43px; position: absolute; z-index: 1; visibility: hidden;">
<table border="1" bgcolor="white">
	<tr>
		<td>DIV제목</td>
		<td colspan="2"><input type="text" name="title" id="title"
			size="50" value="<c:out value="${map.title}"/>"></td>
	</tr>
	<tr>
		<td>작성자</td>
		<td colspan="2"><input type="text" name="writer" id="writer"
			size="8" value="<c:out value="${map.writer}"/>"></td>
	</tr>
	<tr>
		<td>글 내용</td>
		<td colspan="2"><textarea cols="60" rows="10" id="contents"
			name="contents"><c:out value="${map.contents}" /></textarea></td>
	</tr>
</table>
<input type="hidden" name="no" id="no"></div>

    	    <!-- 참조 하세요: 일반 JSP소스 -->

[일반JSP]
    	    <table border="1">
    	    	<tr>
    	    		<td >번호</td>
    	    		<td >제목</td>
    	    		<td >작성자</td>
    	    		<td >작성일</td>
    	    	</tr>
    	    	<%
    	    		List list = (List)request.getAttribute("ret");
    	    		Map map = null;
    	    		for (int i=0; i < list.size(); i++) {
    	    			map = (Map) list.get(i);
    	    			out.println("<tr>");
    	    			out.println("<td>" + map.get("no") + "</td>");
    	    			out.println("<td>" + map.get("title") + "</td>");
    	    			out.println("<td>" + map.get("writer") + "</td>");
    	    			out.println("<td>" + map.get("wdate") + "</td>");
    	    			out.println("</tr>");
    	    		}
    	    	%>
    	    </table>
</body>
</html>
