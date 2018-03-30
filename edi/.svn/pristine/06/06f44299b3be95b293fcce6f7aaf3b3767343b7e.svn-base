<%
/*******************************************************************************
* 시스템명 : 파일 다운로드 프로그램 
* 작 성 일  : 2011.
* 작 성 자 : 김호선
* 수 정 자 : 
* 파 일 명 : fileDownload.jsp
* 버    전 : 1.1
* 개    요 : 
* 이    력 :
*****************************************************************************/
%>
<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.io.*"%>
<%@ page import="common.util.*"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="kr.fujitsu.ffw.base.Configure"%>
<%@ page import="kr.fujitsu.ffw.base.BaseProperty"%> 

<% request.setCharacterEncoding("utf-8");  %>
<% //request.setCharacterEncoding("euc-kr");%> 
 
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<body>
<%
       BufferedOutputStream outs = null;
       BufferedInputStream fin = null;
    
        try {

            Configure configure  = Configure.getInstance();
    
            //String strFileName   = BaseProperty.get("mss.file.upload.dir") + request.getParameter("strPath") +  request.getParameter("strFileNm") ;
            String strFileName   = BaseProperty.get("mss.file.upload.dir") + request.getParameter("strPath") +  URLDecoder.decode(request.getParameter("strFileNm"), "UTF-8");
            String strOragName   = URLDecoder.decode(request.getParameter("strFileNm"), "UTF-8");
            String filename2     = strOragName; // new String(strOragName.getBytes("8859_1"), "EUC-KR");

            File file = new File(strFileName); 
            out.clear();
         
            if (file.exists()) {
                if (file.isFile()) { 
                    
                    //아래 두줄은 꼭 해줘야함
                    out.clear();
          
                    response.setContentType("application/octet-stream");
                    response.setHeader("Content-Disposition", "attachment;filename=" + filename2 + ";");
                    fin = new BufferedInputStream(new FileInputStream(file));
                    outs = new BufferedOutputStream(response.getOutputStream());
                    int read = 0;
                    
                    byte[] buf = new byte[512];
                    while ((read = fin.read(buf)) != -1 ) {
                        outs.write(buf, 0, read);
                    }
                    
                    if (outs != null) {
                        outs.close();
                    }
                    if (fin != null) {
                        fin.close();
                    }
                }
            } else {
                if (file.isFile()) { 
                    
                    //아래 두줄은 꼭 해줘야함
                    out.clear();
          
                    response.setContentType("application/octet-stream");
                    response.setHeader("Content-Disposition", "attachment;filename=" + filename2 + ";");
                    fin = new BufferedInputStream(new FileInputStream(file));
                    outs = new BufferedOutputStream(response.getOutputStream());
                    int read = 0;
                    
                    byte[] buf = new byte[512];
                    while ((read = fin.read(buf)) != -1 ) {
                        outs.write(buf, 0, read);
                    }
                    
                    if (outs != null) {
                        outs.close();
                    }
                    if (fin != null) {
                        fin.close();
                    }
                } else {
                    out.println("<script>");
                    out.println("    alert('파일이 존재 하지 않습니다.');");
                    out.println("</script>");
                }
            }
        } catch (Exception e) {
        } finally {
            try{
                if (outs != null) {
                    outs.close();
                }   
                if (fin != null) {
                    fin.close();
                }
            } catch (Exception e) {
                
            }
            
        }

%>
</body>
</html>
