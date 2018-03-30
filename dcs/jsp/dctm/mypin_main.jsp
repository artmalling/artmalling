<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page language="java" import="Kisinfo.Check.IPIN2Client" %>
<% 
	//**************************************************************************************************************
	//나이스평가정보 Copyright(c) NICE INFORMATION SERVICE INC. ALL RIGHTS RESERVED
	//
	//서비스명 : 마이핀('내번호') 서비스
	//페이지명 : 마이핀('내번호') 메인 호출 페이지
        //
	//IN : MyPin번호                  OUT : 응답코드(유효성확인), DI
	//IN : MyPin번호, 이름            OUT : 응답코드(실명확인), DI, CI
	//IN : MyPin번호, 생년월일,이름   OUT : 응답코드(연령확인), DI, CI
	//IN : MyPin번호, 생년월일        OUT : 응답코드(연령확인,ARS), DI, CI
	//$ID$
        //**************************************************************************************************************

	String enc_data         = "";
	String sIDPCODE			= "AC38";		    //고객사이트 구분 ID를 입력해 주세요(나이스평가정보에서 발급한 사이트 ID)
	String sIDPPWD			= "00000000";		    //고객사이트 비밀 번호를 입력해 주세요(나이스평가정보에서 발급한 사이트 비밀번호)
	String sRETURNURL		= "./mypin_process.jsp";	//인증을 처리하고 팝업된 창을 닫기 위한 중간 URL
	IPIN2Client pCrypt = new IPIN2Client();
	
	int iResult = pCrypt.fnRequest(sIDPCODE, sIDPPWD, sIDPPWD, sRETURNURL);	//클라이언트 요청 정보 암호화 함수입니다. 
						//여기에서 sIDPPWD 는 위 소스와 같이 반드시 2회 입력합니다. 



	if (iResult == 0) {							
		//위 값이 0인 경우가 암호화 성공한 경우입니다. 
		enc_data = pCrypt.getCipherData();
		System.out.println("CLIENT enc_data : " + enc_data);
	} else if (iResult == -1) { 
		//암호화 시스템 오류
	} else if (iResult == -2) {                
		//암호화 처리 오류
	} else if (iResult == -3) {                
		//유효하지 않은 요청 데이터
	} else if (iResult == -9) {                
		//입력 데이타 오류
	}
	System.out.println("iResult : " + iResult);
	
%>

<head>
	<title>나이스평가정보 마이핀(내번호) 본인확인 서비스</title>
	
<script language='javascript'>
	window.name = "Parent_window"; 
	function fnPopup(){
		window.open('', 'popupMYPIN',"left=200, top=100, status=0, width=445, height=550");
		document.form_ipin.target = "popupMYPIN";
		document.form_ipin.action = "https://cert.vno.co.kr/MYPIN/mypin_ext.cb";
		document.form_ipin.submit();
	}
</script>
</head>

<body>

<!-- 마이핀(내번호) 서비스를 호출하기 위해서는 다음과 같은 form이 필요합니다 -->
<form name="form_ipin" method="post">
    <input type="hidden" name="enc_data" value="<%=enc_data%>">   
    <input type="button" value="나이스평가정보 마이핀 번호 인증용" onclick="javascript:fnPopup();">
</form>

<!-- 마이핀 서비스 팝업 페이지에서 인증 받기 버튼 클릭후, 해당 부모 페이지를 이동하기 위해 필요한 form 입니다 -->
<form name="vnoform" method="post">
    <input type="hidden" name="enc_data">
</form>

</body>