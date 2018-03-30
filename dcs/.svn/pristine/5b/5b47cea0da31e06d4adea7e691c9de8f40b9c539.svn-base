<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.util.Map" %>
<%@ page language="java" import="Kisinfo.Check.IPIN2Client"%>
<%@ page language="java" import="java.net.URLDecoder"%>
<%
	//**************************************************************************************************************
	//나이스평가정보 Copyright(c) NICE INFOMATION SERVICE INC. ALL RIGHTS RESERVED
	//
	//서비스명 : 마이핀('내번호') 서비스
	//페이지명 : 마이핀('내번호') , 메인 결과 페이지
	//$ID$
    //**************************************************************************************************************

	String sIDPCODE		  = "";		       //고객사이트 구분 ID를 입력해 주세요(나이스평가정보에서 발급한 사이트 ID)
	String sIDPPWD	  	  = "";		       //고객사이트 비밀 번호를 입력해 주세요(나이스평가정보에서 발급한 사이트 비밀번호)

	String enc_data = "";	
	
  int   iReturn        = 0;		//인증 결과 복호화 성공 여부 판정 변수 초기화
	String strUserName    = "";	//이름
	String strDupInfo     = "";	//중복가입 확인값 (D.I, 64Byte Local Key) 
	String strBirthData	  = ""; //생년월일 
	String strCipherDateTime = "";  //암호화 시간 
	String strCoInfo1  = "";        //연계정보 (C.I, 88byte 범용 Key) 
	String strCiUpdate = "";
	String strUtfName = "";	
	String strVno         = "";		//아이핀 번호 (마이핀 번호가 아닙니다. 자세한 사항은 별첨 PDF안내자료를 참고해 주시기 바랍니다) 
	
	enc_data = request.getParameter("enc_data");    //암호화된 인증결과 및 부가정보를 전달받습니다. 

	if (!enc_data.equals("") && enc_data != null) {
		IPIN2Client pCrypt = new IPIN2Client();
		iReturn = pCrypt.fnResponse(sIDPCODE, sIDPPWD, enc_data);    //인증결과 및 부가정보 복호화  
						//여기에서 sIDPPWD 는 mypin_main.jsp에서의 소스 처리와 다르게 1회만 입력합니다.  
        
        //인증성공 (iReturn 이 1인 경우)
        if (iReturn == 1) {                      
		   	strUserName = pCrypt.getName();
		   	strUtfName = URLDecoder.decode(pCrypt.getIPINInfo("UTF8_NAME") , "UTF-8") +"/"+ pCrypt.getIPINInfo("UTF8_NAME"); 		   			   	
		   	strDupInfo  = pCrypt.getDupInfo();			
			strBirthData   = pCrypt.getBirthDate();
			strCipherDateTime = pCrypt.getCipherDateTime();
			strCoInfo1  = pCrypt.getCoInfo1();
			strCiUpdate = pCrypt.getCIUpdate();
		   	strVno      = pCrypt.getVNumber();    //아이핀 번호는 마이핀 번호가 아닙니다. 시스템적으로 사용되는 13자리 별도의 항목으로서 여기서 추출할 필요는 없으며 만약 이를 저장하시는 경우에는 DB입력전에 enc_data를 다시 복호화 사용하시기를 권장합니다. 각 항목별 자세한 의미는 PDF자료를 참고하여 주시기 바랍니다. 
		} else if (iReturn == -1) {                        
			//복호화 시스템 오류
			out.println("인증 실패 : 복호화 시스템 오류" + "<br><br>");
		} else if (iReturn == -4) {                        
			//복호화 처리중 오류
			out.println("인증 실패 : 복호화 처리중 오류" + "<br><br>");
		} else if (iReturn == -5) {
			//복호화 위변조 검증 실패
			out.println("인증 실패 : 복호화 위변조 검증 실패" + "<br><br>");
		} else if (iReturn == -6) {                        
			//유효하지 않은 암호화 데이터
			out.println("인증 실패 : 유효하지 않은 암호화 데이터" + "<br><br>");
		}
		System.out.println("iReturn " + iReturn);
	}	
%>	

<head>
	<title>나이스평가정보 마이핀(My-PIN) 서비스</title>
<style type="text/css"> 
BODY
{
    COLOR: #7f7f7f;
    FONT-FAMILY: "Dotum","DotumChe","Arial";
    BACKGROUND-COLOR: #ffffff
}
</style>
</head>
<body>

	<b><아래는 인증결과 정보입니다. 여기서는 화면에 출력하는 예제를 구성합니다.></b> <br><br>
	<form>
	<table border=0>
		<tr>
			<td>이름 :</td>
			<td><input type="text" value="<%=strUserName%>" readonly></td>
		</tr>
		<tr>
		        <td>이름(utf8) :</td>
			<td><input type="text" value="<%=strUtfName%>" readonly size=100></td>
		</tr>
		<tr>
			<td>D.I (중복확인Key) :</td>
			<td><input type="text" value="<%=strDupInfo%>" readonly size=100></td>
		</tr>
		<tr>
			<td>생년월일  :</td>
			<td><input type="text" value="<%=strBirthData%>" readonly></td>
		</tr>
		<tr>
			<td>인증시각  :</td>
			<td><input type="text" value="<%=strCipherDateTime%>" readonly></td>
		</tr>
		<tr>
			<td>C.I (연계정보Key값)  :</td>
			<td><input type="text" value="<%=strCoInfo1%>" readonly size=100></td>
		</tr>
		<tr>
			<td>연결정보 버전  :</td>
			<td><input type="text" value="<%=strCiUpdate%>" readonly></td>
		</tr>
		<tr>
			<td>아이핀 번호(마이핀 번호가 아닙니다) :</td>
			<td><input type="text" value="<%=strVno%>" readonly size=13></td>
		</tr>
		</table>
	<input type="hidden" name="enc_data" value="<%=enc_data%>"><br> 
</form>
</body>