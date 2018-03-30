<%
/*******************************************************************************
* 시스템명 : 파일 다운로드 프로그램 
* 작 성 일  : 2010.
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
<%@ page import="kr.fujitsu.ffw.base.Configure"%>
<%@ page import="kr.fujitsu.ffw.base.BaseProperty"%> 

<% //request.setCharacterEncoding("utf-8");  %>
<% request.setCharacterEncoding("euc-kr");%> 
 
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
	
			String strFileName   = BaseProperty.get("mss.file.upload.dir") + request.getParameter("strPath") +  request.getParameter("strFileNm") ;
			System.out.println("###############[인코딩 전] strFileName : " + strFileName);
			strFileName     = new String(strFileName.getBytes("8859_1"), "EUC-KR");
			String strOragName   = request.getParameter("strFileNm");
			String filename2     = new String(strOragName.getBytes("8859_1"), "EUC-KR");
			/*
			String strA     = new String(strFileName.getBytes("euc-kr"),"utf-8");
			String strB     = new String(strFileName.getBytes("utf-8"),"euc-kr"); 
			String strC     = new String(strFileName.getBytes("8859_1"), "EUC-KR");
			String strD     = new String(strFileName.getBytes("EUC-KR"), "8859_1");
			System.out.println("############### strA : " + strA);
			System.out.println("############### strB : " + strB);
			System.out.println("############### strC : " + strC);
			System.out.println("############### strD : " + strD);
			*/
			System.out.println("###############[인코딩 후] strFileName : " + strFileName);
			
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
				out.println("<script>");
				out.println("    alert('파일이 존재 하지 않습니다');");
				out.println("</script>");
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
