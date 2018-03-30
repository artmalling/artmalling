<%@ page language="java" contentType="application/json;charset=UTF-8"  pageEncoding="UTF-8" %>
<%@ page import="java.io.*" %>
<%@ page import="org.json.simple.*"%>
<%@ page import="org.json.*" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="ecmn.dao.SyruppointDAO"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>


<%  response.setContentType("application/json; charset=UTF-8");
	request.setCharacterEncoding("UTF-8");
	StringBuffer jsonBuffer = new StringBuffer();
	String json = null;
	String line = null;

	BufferedReader reader = request.getReader();
    
    while((line = reader.readLine()) != null) {
        jsonBuffer.append(line);
    }
    json = jsonBuffer.toString();
    //json = "{\"trno\":\"20150527165719IGR\",\"cardno\":\"2000003374496\"}";
    JSONObject jsonobj = (JSONObject)new JSONParser().parse(json); 
    
	String strtrno 			= jsonobj.get("trno").toString();                   // 전문추적번호(YYYYMMDDHH24)+random3자리(총17자리
	String strcardno 		= jsonobj.get("cardno").toString();                 // 카드번호
	
	String strtelco 		= jsonobj.get("telco").toString();                 // 카드번호
	String strci 			= jsonobj.get("ci").toString();                 // 카드번호
    
 try{
	 	SyruppointDAO dao = new SyruppointDAO();
		Date date = new Date();
		SimpleDateFormat today = new SimpleDateFormat("yyyyMMdd");
		
		JSONObject obj= dao.Getpoint(strcardno,strtelco,strci);
		
		FileWriter fw = new FileWriter("d:/java/webapps/edi/jsp/ecmn/syruplog/" + today.format(date)+"_inputpoint_json.log",true);
		fw.write("\r\n" + json + ", MARIO =" + obj);
		fw.close();
		
		out.print(obj);
		out.flush();
		
	    
	} catch(IOException e){
		System.out.println(e.toString());
	}
%>