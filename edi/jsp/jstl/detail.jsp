
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
<!-- 화면에서 사용할 JSTL 테그를 선언합니다. core, format, xml만 사용 할 수 있습니다. -->
<!-- 
	아래의 예시는 Servlet 2.3용 JSTL 테그입니다. 
	Servlet 2.4(즉, JSTL 1.1)를 지원하는 WAS는 taglib의  uri가 변경 될 수 있습니다.
-->
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c" %>
세션에서 들어온 값은...<c:out value="${empcode}"/>
<html>
<script language='javascript'>
	function move() {
		document.form1.action="board.jstl?goTo=list";
		document.form1.method="post";
		document.form1.submit();
	}
</script>
<body>
	<form name="form1">
		<table border="1">
			<tr>
				<td>제목</td>
				<td><input type="text" name="title" size="20" value="<c:out value="${map.title}"/>"></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><input type="text" name="writer" size="8" value="<c:out value="${map.writer}"/>"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea cols="60" rows="10" name="contents"><c:out value="${map.contents}"/></textarea></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="button" name="b1" value="리스트로" onclick="javascript:move();">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
