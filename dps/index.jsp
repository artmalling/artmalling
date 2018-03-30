<%! public String nvl(String param) {
        return param != null ? param:"";
}%>
<%="This is a test jsp file on dcs context<BR>"%>
<%
    String uid = "";
    String pwd = "";
    
    uid =nvl(request.getParameter("uid"));
    pwd =nvl(request.getParameter("pwd"));

    if (!uid.equals("")) {
        session.setAttribute("uid",uid);
        session.setAttribute("pwd",pwd);

        out.println("session was setting up to " + uid + "<BR>");
    } 
    
     
out.println("current uid of session is " + session.getAttribute("uid")); 
out.println(">> " + session.getAttribute("test") + "<BR>");
%>
