<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.ObjectInputStream" %>
<%@ page import="java.io.*" %> 

<%
    request.setCharacterEncoding("utf-8");

    String img      = request.getParameter("memberImg");
    String filepath = BaseProperty.get("memberImgPath");
    String result   = "";
    
    StringBuffer localPath = new StringBuffer();
    localPath.append(filepath + img);
    System.out.println(" " +localPath );
    if( localPath.lastIndexOf(File.separator) != (localPath.length()-1)){
        localPath.append(File.separator);
    }
 
    File file = new File(localPath.toString());
     
    if((file.exists() == false)) {
    	result = "false";
    } else {
    	result = BaseProperty.get("memberImgRoot").toString() + img;
    }
%>
<html>
<body>
<script LANGUAGE="JavaScript">
<!--
    parent.btn_img('<%=result%>');
-->
</script>
</body>
</html>
 
