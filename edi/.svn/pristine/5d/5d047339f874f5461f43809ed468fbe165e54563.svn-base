<%
 /**
  * 코딩 표준을 설명하기 위한 셈플 JSP 페이지입니다.
  * 마스터/디테일형의 테이블로부터 모든 마스터 정보를 조회해 출력하는 페이지 예시입니다.
  * 페이지에서 스크립트릿(Scriplet)은 가급적 사용을 제한합니다. 아래의 예제와 같이 JSTL을
  * 이용해 EL(Expression Language)을 사용하도록 합니다.
  *
  * @created  on 1.0, 06/02/05
  * @created  by GIL-DONG HONG(FUJITSU KOREA LTD.)
  * 
  * @modified on 1.1, 06/02/06
  * @modified by MOO-GAE AH(Other Company)
  * @caused   by 보다 낳은 셈플을 제공하기 위한 예시...
  */
%>
<!-- WAS로 부터 독립된 페이지 구현을 위해 문자셋과 페이지 인코딩을 선언하도록 합니다. -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!-- 화면에서 사용할 JSTL 테그를 선언합니다. core, format, xml만 사용 할 수 있습니다. -->
<!-- 
	아래의 예시는 Servlet 2.3용 JSTL 테그입니다. 
	Servlet 2.4(즉, JSTL 1.1)를 지원하는 WAS는 taglib의  uri가 변경 될 수 있습니다.
-->
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/ajax-lib.tld" prefix="script" %>
<!-- format을 위한 locale set을 지정합니다. 이는 include등으로 대체될 수 있습니다. -->
<c:set var="empcode" value="1999060" scope="session"/>
<html>
    <head>
        <title></title>
        <!-- meta tag를 이용해 페이지 인코딩셋을 지정하기 바랍니다. -->
        <meta http-equiv="content-type" content="text/html; charset=euc-kr">
        <!-- 모든 tag의 효과는 css(스타일쉬트)를 이용합니다. -->
        <!--  link href="/pattern/css/style.css" rel="stylesheet" type="text/css" -->

        <script language="javascript">
        	function insertIt() {
	        	document.location.href="board.jstl?goTo=view";
        	}
        	function searchIt() {
        	    if(document.form1.where.value != '' && document.form1.condition.value != '') {
        	        form1.submit();
        	    } else {
        	        alert('검색시 조건과 검색명을 입력해 주세요');
        	    }
        	}
        	function doInit() {
        		if (document.form1.condition.value == '') {
        			document.location.href = "board.jstl?goTo=list";
        		}
        	}
        </script>
    </head>
    <body>
        <form name="form1" method="post" action="board.jstl?goTo=list">
            <table border="1">
                <tr>
                    <td>조건</td>
                    <td>
	                   	<select name="condition" onchange="javascript:doInit();">
	                	<c:choose>
	                		<c:when test="${empty param.condition}">
	                			<option value="" selected>선택</option>
	                		</c:when>
	                		<c:otherwise>
	                			<option value="">선택</option>
	                		</c:otherwise>
	                	</c:choose>
	                	<c:choose>
	                		<c:when test="${'제목'==param.condition}">
	                			<option value="제목" selected>제목</option>
	                		</c:when>
	                		<c:otherwise>
	                			<option value="제목">제목</option>
	                		</c:otherwise>
	                	</c:choose>
	                	<c:choose>
	                		<c:when test="${'작성자'==param.condition}">
	                			<option value="작성자" selected>작성자</option>
	                		</c:when>
	                		<c:otherwise>
	                			<option value="작성자">작성자</option>
	                		</c:otherwise>
						</c:choose>
						<c:choose>
	                		<c:when test="${'내용'==param.condition}">
	                			<option value="내용" selected>내용</option>
	                		</c:when>
	                		<c:otherwise>
	                			<option value="내용">내용</option>
	                		</c:otherwise>
						</c:choose>
						</select>
                    </td>
                    <td><input type="text" size="20" name="where" value='<c:out value="${param.where}"/>'></td>
                    <td><input type="button" name="b1" value="조회" onclick="javascript:searchIt();"></td>
                </tr>
            </table>
            <!--  참조 하셈 JSTL -->
    	    <table border="1">
    	    	<tr>
    	    		<td width="80">no</td>
    	    		<td width="200">title</td>
    	    		<td width="50">writer</td>
    	    		<td width="30">date</td>
    	    	</tr>
    	    	<c:forEach items="${list}" var="it" varStatus="a">
	    		<tr>
	    		    <td><c:out value="${it.no}"/></td>
	    			<td>
	    			    <a href="board.jstl?goTo=detail&no=<c:out value="${it.no}"/>">
	    				   <c:out value="${it.title}"/>
	    				</a>
	    			</td>
	    			<td><c:out value="${it.writer}"/></td>
	    			<td><c:out value="${it.wdate}"/></td>
	    		</tr>
                </c:forEach>
                <tr>
                	<td colspan="4">
		    			<input type="button" name="b1" value="신규" onclick="insertIt();"/>
		    		</td>
		    	</tr>
    	    </table>
    	    
    	    <hr>
    	    <!--  참조 하셈 -->
    	    <table border="1">
    	    	<tr>
    	    		<td width="80">no</td>
    	    		<td width="200">title</td>
    	    		<td width="50">writer</td>
    	    		<td width="30">date</td>
    	    	</tr>
    	    	<%
    	    		List list = (List)request.getAttribute("list");
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
    	</form>
    </body>
</html>
