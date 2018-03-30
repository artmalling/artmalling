<%@ page language="java" contentType="application/json;charset=UTF-8"  pageEncoding="UTF-8" %>
<%@ page import="java.io.*" %>
<%@ page import="org.json.simple.*"%>
<%@ page import="org.json.*" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="ecmn.dao.SyrupmemberDAO"%>
<%@ page import="ecmn.dao.CryptoUtil"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>



<%
	response.setContentType("application/json; charset=UTF-8");
	request.setCharacterEncoding("UTF-8");
	StringBuffer jsonBuffer = new StringBuffer();
	
	
	String json = null;
	String line = null;
	String strjson = null;

	BufferedReader reader = request.getReader();
    
    while((line = reader.readLine()) != null) {
        jsonBuffer.append(line);
    }
    strjson = jsonBuffer.toString();
    
    //CryptoUtil decryptsyrup = new CryptoUtil();
    json = CryptoUtil.decrypt(strjson);
    //json  decrypt(json, 1eff58b3a3d561d45eddce4204013b01, 2dc1da729b6e1842d4d3c571a2232807)
    //json = "{\"trno\":\"20150627165719IGR\",\"korname\":\"TEST2\",\"birthday\":\"19821206\",\"mdn\":\"01099991235\",\"birthdaytype\":\"S\",\"authtype\":\"Y\",\"gender\":\"M\",\"nationality\":\"K\",\"nationno\":\"\",\"basicaddr\":\"서울특별시 마포구 성암로 189\",\"detailaddr\":\"중소기업 DMC 타워\",\"zipcode\":\"121904\",\"smsYN\":\"Y\",\"emailYN\":\"Y\",\"dmYN\":\"Y\",\"email1\":\"\",\"email2\":\"\"}";
    JSONObject jsonobj = (JSONObject)new JSONParser().parse(json); 
    
    
    
	String strtrno 			= jsonobj.get("trno").toString();                   // 전문추적번호(YYYYMMDDHH24)+random3자리(총17자리
	String strkorname 		= jsonobj.get("korname").toString();                // 고객명
	String strbirthday 		= jsonobj.get("birthday").toString();               // 생년월일(yyyyMMdd)
	String strmdn	 		= jsonobj.get("mdn").toString();					  // 핸드폰번호
	String strbirthdaytype 		= jsonobj.get("birthdaytype").toString();           // L:음력,S:양력
	String strauthtype	 	= jsonobj.get("authtype").toString();               // Y:인증,N:미인증
	String strgender	 	= jsonobj.get("gender").toString();                 // M:남, F:여
	String strnationality		= jsonobj.get("nationality").toString();			  // K:한국,A:외국인
	String strnationno	 	= jsonobj.get("nationno").toString();				  // 01:중국 02:일본 03:대만 04:홍콩 99:기타 (시럽측 구분자 없기 때문에 99로 들어올 예정)
	String strbasicaddr 		= jsonobj.get("basicaddr").toString();              // 기본주소(신주소)
	String strdetailaddr 		= jsonobj.get("detailaddr").toString();             // 상세주소(신주소)
	String strzipcode	 	= jsonobj.get("zipcode").toString();                // 우편번호(6자리)(중간에 '-' 없이 값만 전송')
	String strsmsyn 		= jsonobj.get("smsYN").toString(); 		  // SMS 수신동의여부 Y:동의, N:비동의
	String stremailyn 		= jsonobj.get("emailYN").toString();		  // 이메일수신동의여부 Y:동의, N:비동의
	String strdmyn		 	= jsonobj.get("dmYN").toString();					  // 우편물수신동의여부 Y:동의, N:비동의
	String stremail1		 	= jsonobj.get("email1").toString();
	String stremail2		 	= jsonobj.get("email2").toString();
	
	String strtelco		 	= jsonobj.get("telco").toString();
	String strci		 	= jsonobj.get("ci").toString();
	String strdi		 	= jsonobj.get("di").toString();

	
		
	try{
		SyrupmemberDAO dao = new SyrupmemberDAO();
		Date date = new Date();
		SimpleDateFormat today = new SimpleDateFormat("yyyyMMdd");
		
		JSONObject obj= dao.Getmember(strkorname,strbirthday,strmdn,strbirthdaytype,strauthtype,strgender,strnationality,strnationno,strbasicaddr,strdetailaddr,strzipcode,strsmsyn,stremailyn,strdmyn,stremail1,stremail2,strtelco,strci,strdi);
		
		FileWriter fw = new FileWriter("d:/java/webapps/edi/jsp/ecmn/syruplog/" + today.format(date)+"_inputmember_json.log",true);
		fw.write("\r\n" + json + ", MARIO =" + obj);
		fw.close();
		
		out.print(obj);
		out.flush();
		
	    
	} catch(IOException e){
		System.out.println(e.toString());
	}
%>