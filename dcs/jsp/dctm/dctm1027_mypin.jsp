<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%
	//**************************************************************************************************************
	//나이스평가정보 Copyright(c) NICE INFOMATION SERVICE INC. ALL RIGHTS RESERVED
	//
	//서비스명 : 마이핀('내번호') 서비스
	//페이지명 : 마이핀('내번호') 팝업 결과 처리 페이지
	//$ID$
    //**************************************************************************************************************

	String enc_data = request.getParameter("enc_data");		//인증 결과및 부가 정보를 암호화한 데이타입니다.
									//이 소스는 수신받은 데이터(인증결과)를 메인화면으로 전달 후 close 하는 역할을 합니다.
	String param_r1 = request.getParameter("param_r1"); 
	String param_r2 = request.getParameter("param_r2"); 
	String param_r3 = request.getParameter("param_r3"); 
	
	if (!enc_data.equals("") && enc_data != null) {
		
		
	String sIDPCODE		  = "AC38";		       //고객사이트 구분 ID를 입력해 주세요(나이스평가정보에서 발급한 사이트 ID)
	String sIDPPWD	  	  = "11001206";		       //고객사이트 비밀 번호를 입력해 주세요(나이스평가정보에서 발급한 사이트 비밀번호)
    int   iReturn        = 0;		//인증 결과 복호화 성공 여부 판정 변수 초기화
	String strUserName    = "";	//이름
	String strDupInfo     = "";	//중복가입 확인값 (D.I, 64Byte Local Key) 
	String strBirthData	  = ""; //생년월일 
	String strSsnoData	  = ""; //생년월일2 
	String strCipherDateTime = "";  //암호화 시간 
	String strCoInfo1  = "";        //연계정보 (C.I, 88byte 범용 Key) 
	String strCiUpdate = "";
	String strUtfName = "";	
	String strVno         = "";		//아이핀 번호 (마이핀 번호가 아닙니다. 자세한 사항은 별첨 PDF안내자료를 참고해 주시기 바랍니다) 
	Kisinfo.Check.IPIN2Client pCrypt = new Kisinfo.Check.IPIN2Client();
	
	iReturn = pCrypt.fnResponse(sIDPCODE, sIDPPWD, enc_data);    //인증결과 및 부가정보 복호화  
	
	if (iReturn == 1) {                      
		   	strUserName = pCrypt.getName();	   			   	
		   	strDupInfo  = pCrypt.getDupInfo();			
			strBirthData   = pCrypt.getBirthDate();
			strSsnoData = strBirthData.substring(2);
			strCipherDateTime = pCrypt.getCipherDateTime();
			strCoInfo1  = pCrypt.getCoInfo1();
			strCiUpdate = pCrypt.getCIUpdate();
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
%>			
<head>
	<title>나이스평가정보 마이핀(내번호) 본인확인 서비스</title>
<script language='javascript'>
     function fnLoad() {
			parent.opener.parent.document.getElementById("EM_CUST_NAME").text = "<%= strUserName %>";
			parent.opener.parent.document.getElementById("EM_OFF_TERMS1_NAME").text = "<%= strUserName %>";
			parent.opener.parent.document.getElementById("EM_OFF_TERMS2_NAME").text = "<%= strUserName %>";
    		parent.opener.parent.document.getElementById("EM_DI").text = "<%= strDupInfo %>";
    		parent.opener.parent.document.getElementById("EM_CI").text = "<%= strCoInfo1%>";
			parent.opener.parent.document.getElementById("EM_SS_NO").text = "<%= strSsnoData%>";
    		parent.opener.parent.document.getElementById("EM_BIRTH_DT").text = "<%= strBirthData%>";
    		parent.opener.parent.document.getElementById("RD_NAME_CONF_YN").CodeValue = "Y";
    		parent.opener.parent.document.getElementById("LC_MOBILE_COMP").focus();
			self.close();
    }
	function fail(){
		alert("fail");
		self.close();
	}
</script> 		
</head>

<body onLoad="fnLoad()">
<%
    } else {
%>
<body onLoad="fail()">
<%
	}
%>
</body>