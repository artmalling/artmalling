<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.ObjectInputStream" %>
<%@ page import="java.io.*" %>
<%@ page import="ksnet.SignPad" %> 

<%
    request.setCharacterEncoding("utf-8");

    String filepath    = BaseProperty.get("signImgPath");//"/data_in/dps/";//"C:/java/data_in/dps/mnt/image/"; 
    //String filepath    = "c:/java/data_in/dps/mnt/image/";
    String resultPath  = "";
    String signData    = request.getParameter("signImg");
    String img         = "sign.bmp";//
    
    //System.out.println("### filepath:"+ filepath);
    
    StringBuffer localPath = new StringBuffer();
    localPath.append(filepath + img);
    System.out.println(localPath + "   localPath");
    System.out.println(signData + "   signData");
    resultPath = localPath.toString();//BaseProperty.get("signImgRoot").toString()+ img;
    SignPad sp    = new SignPad();
    int result = sp.saveToBMP(signData, resultPath);
    System.out.println(result + "   result");
    System.out.println(resultPath + "   resultPath");
    
    
    /*
    ksnet.util.sign.SignbmpJni jt = new ksnet.util.sign.SignbmpJni();
    System.out.println("a new SignbmpJni:");
    String signData = "HCH2sJJxmvJPQ9kwoWLeSxkg196juTnPCj+aGj9h+OE07+Wy2GtCygoKCdQRfxJesoxR5Lm+N2jP4Z6SghED+XH9xrpHvIgQwI04uHrLT8tLIp0rrX+yYVx1FVRCOgGEYTOV0O2skQU4GVjJowlmK7EExe+fzqfAfNmI7Ysw2CO1S5fOTFY11fWAc2nmZfeqYoKH9N/qiiOhRaxsTqppiryd+RYZxfOuiSLTN4pHzi0DPUmTzpDfMyJhOozEuohpFV7obUW3/lZkRbtGBLWrXJRWDIZhIN0ZW+p5bD2C9bMS/A3X9qGNGNnDeucUhjHxzI5b7NuCqsjeOVHK4yZL0TIB7bXn5JKiJTn7n8t0o03V3wvbTHEkevrD8AmU7NqdynHkfDuS1FFyThIa6AwQo0VeaNdMjKPQUquTf3Y5OK+4xsLcFFCbB1x2rt5eZSGzl6Tuheqm5Jmkdr5T3W9ZFHvx9B5n/fl6XVNKKHIfGsPPxDoREOHyEqmqtp5S1bJXBPchdgsMkRJjHzPM54Txn4mpcRUO9Aciw7Wufs8b5PEw2uwUTDr1fhb4sBH7aAkGST4e6cBTRjCms3O/zdMPvQ==9Aciw7Wufs8b5PEw2uwUTDr1fhb4sBH7aAkGST4e6cBTRjCms3O/zdMPvQ==";
    int result = jt.KSNET_SIGNBMP_EXTRACT(signData, signData.length(), "");
    */

%>
<html>
<body>
<script LANGUAGE="JavaScript">
<!--
    //parent.fn_Imagemake('<%//=localPath%>','<%//=resultPath%>');
    parent.fn_Imagemake('<%=resultPath%>');
-->
</script>

</body>
</html>
 
