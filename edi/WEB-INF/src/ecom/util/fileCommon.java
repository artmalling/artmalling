package ecom.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class fileCommon {
	
	public void downloadFile ( String path, String fileName, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String orgName = fileName; 

		if(request.getServerName().indexOf("local") > -1 || request.getServerName().indexOf("127.0.0.1") > -1) 
		{
			orgName = orgName;
		}else {
			orgName = orgName; 
		}
		
		request.setCharacterEncoding("EUC-KR");

		try {
		  File sourceFile = new File(path);
		  
		  if (sourceFile.isFile())
		  {  
		    String agentType  = request.getHeader("User-Agent");

		    if(agentType.indexOf("MSIE 5.5")>-1) {
		      response.setHeader("Accept-Ranges", "bytes");
	    	  response.setHeader("Content-Disposition", "filename=\"" + orgName + "\";");
		    } 
		    else {
			  response.setHeader("Content-Disposition", "attachment;filename=\"" + orgName + "\";");
		      response.setHeader("Content-Transfer-Encoding", "binary;");
		    }
		    
	        response.setHeader("Content-Length", String.valueOf(sourceFile.length()) );
		    response.setContentType("application/octet-stream");

		    BufferedInputStream fin = new BufferedInputStream(new java.io.FileInputStream(sourceFile));  
		    BufferedOutputStream outs = new BufferedOutputStream(response.getOutputStream());  
		    byte b[] = new byte[5 * 1024 * 1024];
		    
		    System.out.println("fin==>" + fin);
		    
		    System.out.println("outs==>" + outs);
		    

		    int read = 0;  
		    while ((read = fin.read(b)) != -1){  
		      outs.write(b,0,read);
		    }
		    outs.flush();
		    outs.close();  
		    fin.close(); 
		  }
		}
		catch(Exception e){
		  
			response.getOutputStream().println("<script language=javascript>");
			response.getOutputStream().println("  alert('File Error!!');");
			response.getOutputStream().println("  history.go(-1);");
			response.getOutputStream().println("</script>");
		}
	}
	
}
