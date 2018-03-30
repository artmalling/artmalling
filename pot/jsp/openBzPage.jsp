<%@ page language="java" contentType="text/html;charset=utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ page import="common.dao.CCom900DAO, java.io.*, common.vo.SessionInfo, kr.fujitsu.ffw.util.String2" %>
<%@ page import="java.net.InetAddress, java.net.UnknownHostException, java.net.URL, java.net.HttpURLConnection" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"  prefix="button" %>
<%
	String userId		= null;
	String pid			= null;
	String subSystem	= null;       
	String lcode		= null;
	String mcode		= null;
	String title		= null;
	String url			= null;
	String url2			= null;
	String permission	= null;
	String userIp		= null; // 20171102 ip 신규 추가.
	String userPblIp	= null; // 20171102 ip 신규 추가.
	
	pid		= request.getParameter("pid");
	lcode	= request.getParameter("lcode");
    mcode	= request.getParameter("mcode");
    title	= request.getParameter("title");    
    url 	= request.getParameter("url");


    SessionInfo sessionInfo = (SessionInfo)(session.getAttribute("sessionInfo"));

    if (sessionInfo != null) {   
	    sessionInfo.setPGM_ID(pid); 
	    sessionInfo.setL_CD(lcode); 
	    sessionInfo.setM_CD(mcode);
	    
	    session.setAttribute("sessionInfo", sessionInfo);
	    
	    userId = sessionInfo.getUSER_ID();				//사용자ID        
        subSystem = pid.substring(0,1).toUpperCase();	//주업무영역
        
        // 사설 아이피 체크
        //InetAddress inetAddress = InetAddress.getLocalHost(); // 사설 아이피 확인.
        //userIp = inetAddress.getHostAddress();
        /*
        // 공인 아이피 체크
        URL whatismyip = new URL("http://www.whatismyip.org/");
        try {
	        HttpURLConnection con = (HttpURLConnection) whatismyip.openConnection();
	        InputStream is = con.getInputStream();
	        InputStreamReader isr = new InputStreamReader(is);
	        BufferedReader br = new BufferedReader(isr);
	        br.skip(2460);
	        userPblIp = br.readLine();
	        userPblIp = userPblIp.substring(userPblIp.indexOf(">")+1,userPblIp.indexOf("</span>")); 
		    br.close();
	        is.close();
        }
        catch(Exception e) {
        	// 에러시 오류 메세지.
        	userPblIp = "error, unknown";
        }
        */
        
     	// 사설 아이피 체크
        //userIp = request.getRemoteAddr();
        String ip = request.getHeader("X-Forwarded-For");
 
        if (ip == null) {
            ip = request.getHeader("Proxy-Client-IP");
            System.out.println(">>>> Proxy-Client-IP : " + ip);
        }
        if (ip == null) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
            System.out.println(">>>> HTTP_X_FORWARDED_FOR : " + ip);
        }
        if (ip == null) {
            ip = request.getHeader("HTTP_CLIENT_IP");
            System.out.println(">>>> HTTP_CLIENT_IP : " + ip);
        }
        if (ip == null) {
            ip = request.getRemoteAddr();
            System.out.println(">>>> getRemoteAddr : "+ip);
        }

        userIp = ip;

        System.out.println("IP : " + userIp);

        
        try {
        	CCom900DAO dao = new CCom900DAO();
            //버튼 권한처리
            permission = dao.getButtonPermission(userId, pid);              	            
//			버튼권한 (세션에서 제거함)
//            session.setAttribute("buttonPermission", permission);
//			프로그램 타이틀   (세션에서 제거함)
//            session.setAttribute("title", title);

            //사용자 방문 로그 기록
            //dao.setLog(userId, pid, subSystem, lcode, mcode); 		
            dao.setLog(userId, pid, subSystem, lcode, mcode, userIp);	// 아이피 기록 추가.
            //dao.setLog(userId, pid, subSystem, lcode, mcode, userIp, userPblIp);	// 아이피 기록 추가_공인.
            // URL에 버튼권한/프로그램명 전달
            url2 = url + "&pid="+pid;
             	            	            
        }
        catch(Exception e) {
            throw new JspException(e);
        }
	    
	    //session.setAttribute("sessionInfo", sessionInfo);
	    out.println(".");
    }
    else {
%>
        <script language="JavaScript">
		//Filter에서 체크하고 있긴 합니다만.... 일단 살려놓습니다.20110713
        alert("사용자 세션이 종료되었습니다. 다시 로그인하십시오.");
    	</script>       
<%      
    }
%>

<script language="JavaScript">
	<!-- 2011.08.04 lcode ADD(MARIO OUTLET) -->
	top.mainFrame.fn_CreateWin('<%=pid%>', '<%=title%>', '<%=url2%>', '<%=permission%>', '<%=title%>', '<%=lcode%>');
</script>



