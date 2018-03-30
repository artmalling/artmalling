<%@ page language="java" contentType="text/html;charset=utf-8"
	import="kr.fujitsu.ffw.base.BaseProperty"%>
<%
	String dir_ = BaseProperty.get("context.common.dir");
	String pid = request.getParameter("pid");
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="396" class="title">
    <img src="/<%=dir_%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="PR05" /> 
	  <!-- 제목  --> 
	  <span id="spanPGNM" class="title"></span> 
	  <script LANGUAGE="JavaScript"> 
        document.all.spanPGNM.innerHTML= getProgramName('<%=pid%>');
      </script>
    </td>
	<td>
	  <table border="0" align="right" cellpadding="0" cellspacing="0">
		<tr>
		<td>
		<!-- 버튼권한  -->
		<script language=javascript>
		  createButton(getButtonPermission('<%=pid%>'));
        </script>
        </td>
	    </tr>
	  </table>
	</td>
  </tr>
</table>

