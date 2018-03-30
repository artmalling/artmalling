<!-- 
/*******************************************************************************
 * 시스템명 : 회원관리 > 카드관리 > 주소수정
 * 작  성  일  : 2012.05.16
 * 작  성  자  : kj
 * 수  정  자  : 
 * 파  일  명  : dctm2033.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2012.05.16 (kj) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
	import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js"
	type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script LANGUAGE="JavaScript">
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }
				 
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                // 도로명 주소
                document.getElementById('EM_HNEW_ZIP_CD1').text = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('EM_HNEW_ADDR1').text = fullRoadAddr; 
                
                //document.getElementById('EM_HNEW_ADDR1').text = fullRoadAddr + " " + data.jibunAddress;
                //document.getElementById('sample4_jibunAddress').value = data.jibunAddress;
                
                // 지번 주소
                document.getElementById('EM_HOME_ZIP_CD1').text = data.zonecode; //5자리 새우편번호 사용
				document.getElementById('EM_HOME_ADDR1').text = data.jibunAddress; 
 
                if(data.userSelectedType == 'R')
                	EM_HOME_NEW_YN.Text = 'Y';
                else
                	EM_HOME_NEW_YN.Text = 'N';
                
				document.getElementById('EM_HNEW_ADDR2').focus(); 
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    //예상되는 도로명 주소에 조합형 주소를 추가한다.
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';

                } else {
                    document.getElementById('guide').innerHTML = '';
                }
            }
        }).open();
    }
</script>
<script LANGUAGE="JavaScript">

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : kj
 * 작 성 일 : 2012-05-16
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
var returnMap 		= dialogArguments[0];
var strCustId 		= dialogArguments[1];
var strHomeNewYn	= dialogArguments[2];
var strHomeZipCd1	= dialogArguments[3];
var strHomeZipCd2	= dialogArguments[4];
var strHomeAddr1	= dialogArguments[5];
var strHomeAddr2	= dialogArguments[6];
var strOffiNewYn	= dialogArguments[7];
var strOffiZipCd1	= dialogArguments[8];
var strOffiZipCd2	= dialogArguments[9];
var strOffiAddr1	= dialogArguments[10];
var strOffiAddr2	= dialogArguments[11];
var strAddrPathCd	= dialogArguments[12];
var strAddrFlag		= dialogArguments[13];

function doInit()
{
	DS_HOME_DATA.setDataHeader('<gauce:dataset name="H_HOME_JUSO"/>');
	DS_OFFI_DATA.setDataHeader('<gauce:dataset name="H_OFFI_JUSO"/>');	
	//집	
    initEmEdit(EM_PRE_HOME_NEW_YN,  "GEN^1",               NORMAL);
    initEmEdit(EM_PRE_HOME_ZIP_CD1, "GEN^5",          	PK);
    initEmEdit(EM_PRE_HOME_ZIP_CD2, "GEN^5",          PK);
    initEmEdit(EM_PRE_HOME_ADDR1,   "GEN^200",             PK);   
    initEmEdit(EM_PRE_HOME_ADDR2,   "GEN^200",             PK);      
    initEmEdit(EM_HOME_NEW_YN,  	"GEN^1",               NORMAL);
    initEmEdit(EM_HNEW_ZIP_CD1, 	"GEN^5",          PK);
    initEmEdit(EM_HOME_ZIP_CD1, 	"GEN^5",          PK);
    initEmEdit(EM_HOME_ZIP_CD2, 	"GEN^5",          PK);
    
    initEmEdit(EM_HNEW_ADDR1,   	"GEN^200",             PK);   
    initEmEdit(EM_HNEW_ADDR2,   	"GEN^200",             PK);
    
    initEmEdit(EM_HOME_ADDR1,   	"GEN^200",             PK);   
    initEmEdit(EM_HOME_ADDR2,   	"GEN^200",             PK);
    //회사
    initEmEdit(EM_PRE_OFFI_NEW_YN,  "GEN^1",               NORMAL);
    initEmEdit(EM_PRE_OFFI_ZIP_CD1, "GEN^5",          NORMAL);
    initEmEdit(EM_PRE_OFFI_ZIP_CD2, "GEN^5",          NORMAL);
    initEmEdit(EM_PRE_OFFI_ADDR1,   "GEN^200",             NORMAL);   
    initEmEdit(EM_PRE_OFFI_ADDR2,   "GEN^200",             NORMAL);     
    initEmEdit(EM_OFFI_NEW_YN,  	"GEN^1",               NORMAL);
    initEmEdit(EM_OFFI_ZIP_CD1, 	"GEN^5",          NORMAL);
    initEmEdit(EM_OFFI_ZIP_CD2, 	"GEN^5",          NORMAL);         
    initEmEdit(EM_OFFI_ADDR1,   	"GEN^200",             NORMAL);   
    initEmEdit(EM_OFFI_ADDR2,   	"GEN^200",             NORMAL);
    //고객ID
	initEmEdit(EM_CUST_ID_S, 		"GEN", NORMAL); 
    
	EM_HNEW_ADDR2.Language = 1;
	//집
	EM_PRE_HOME_NEW_YN.Text		= strHomeNewYn
    EM_PRE_HOME_ZIP_CD1.Text	= strHomeZipCd1;
    EM_PRE_HOME_ZIP_CD2.Text	= strHomeZipCd2;
    EM_PRE_HOME_ADDR1.Text		= strHomeAddr1;
    EM_PRE_HOME_ADDR2.Text 		= strHomeAddr2;
    
    EM_HNEW_ZIP_CD1.Text	= strHomeZipCd1;
    EM_HOME_ZIP_CD2.Text	= strHomeZipCd2;
    EM_HNEW_ADDR1.Text		= strHomeAddr1;
    //회사
    EM_PRE_OFFI_NEW_YN.Text		= strOffiNewYn
    EM_PRE_OFFI_ZIP_CD1.Text	= strOffiZipCd1;
    EM_PRE_OFFI_ZIP_CD2.Text	= strOffiZipCd2;    
    EM_PRE_OFFI_ADDR1.Text		= strOffiAddr1;
    EM_PRE_OFFI_ADDR2.Text 		= strOffiAddr2;
    
    EM_OFFI_ZIP_CD1.Text	= strOffiZipCd1;
    EM_OFFI_ZIP_CD2.Text	= strOffiZipCd2;    
    EM_OFFI_ADDR1.Text		= strOffiAddr1;
  	//고객ID
	EM_CUST_ID_S.Text     		= strCustId;
	RD_JUSO_GBN.CodeValue 		= strAddrFlag;
    
    EM_PRE_HOME_NEW_YN.style.display = "none";      
    EM_PRE_OFFI_NEW_YN.style.display = "none";
    EM_HOME_NEW_YN.style.display = "none";      
    EM_OFFI_NEW_YN.style.display = "none";
	//집
	EM_PRE_HOME_ZIP_CD1.Enable 	= false;
	EM_PRE_HOME_ZIP_CD2.Enable 	= false;
	EM_PRE_HOME_ADDR1.Enable 	= false;
	EM_PRE_HOME_ADDR2.Enable 	= false;
    EM_HNEW_ZIP_CD1.Enable 		= false;
    EM_HOME_ZIP_CD2.Enable 		= false;	
    EM_HNEW_ADDR1.Enable   		= false;
	//회사    
	EM_PRE_OFFI_ZIP_CD1.Enable 	= false;
	EM_PRE_OFFI_ZIP_CD2.Enable 	= false;
	EM_PRE_OFFI_ADDR1.Enable 	= false;
	EM_PRE_OFFI_ADDR2.Enable 	= false;    
    EM_OFFI_ZIP_CD1.Enable 		= false;
    EM_OFFI_ZIP_CD2.Enable 		= false;
    EM_OFFI_ADDR1.Enable   		= false;
  	//고객ID
	EM_CUST_ID_S.Enable 		= false;

	chgBtnEnable();

	EM_HNEW_ADDR1.Focus();	
	
	
	
	EM_PRE_HOME_ZIP_CD2.style.display = "none";    
	EM_HOME_ZIP_CD2.style.display = "none";    
	
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * btn_Close()
 * 작 성 자 : kj
 * 작 성 일 : 2011-05-16
 * 개       요 : 닫기
 * return값 : void
 */
function btn_Close()
{
    window.close();
}

/**
 * editCustnm()
 * 작 성 자 : kj
 * 작 성 일 : 2012-05-16
 * 개       요 : 주소 수정
 * return값 : void
 */
function editJuso()
{
    if(RD_JUSO_GBN.CodeValue == "H"){
	    if(EM_HNEW_ZIP_CD1.text==""){     
	        showMessage(EXCLAMATION, OK, "USER-1003",  "자택주소");
	        //getPostPop_dcs(EM_HNEW_ZIP_CD1,EM_HOME_ZIP_CD2,EM_HNEW_ADDR1,EM_HNEW_ADDR2,EM_HOME_NEW_YN);
	        return false;
	    }
	    if(trim(EM_HNEW_ADDR2.Text).length == 0){
	        showMessage(EXCLAMATION, OK, "USER-1003",  "자택상세주소");
	        EM_HNEW_ADDR2.Focus();
	        return false;
	    }
	}    
    
    //저장여부 QUESTION
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        return;
    }

    var strCustid  			= EM_CUST_ID_S.text;
    //집
    var strPreHomeNewYn		= EM_PRE_HOME_NEW_YN.Text;
    var strPreHomeZipCd1	= EM_PRE_HOME_ZIP_CD1.Text;
    var strPreHomeZipCd2	= EM_PRE_HOME_ZIP_CD2.Text;
    var strPreHomeAddr1		= EM_PRE_HOME_ADDR1.Text;   
    var strPreHomeAddr2		= EM_PRE_HOME_ADDR2.Text;
    //var strAptHomeNewYn		= strPreHomeNewYn;
    //도로명 주소 
    var strAptHomeNewYn		= EM_HOME_NEW_YN.Text;  //변경 후 도로명 주소구분
    var strAptHomeZipCd1	= EM_HNEW_ZIP_CD1.Text; //변경 후 도로명 자택 주소 우편번호
    var strAptHomeZipCd2	= EM_HNEW_ZIP_CD2.Text; //변경 후 도로명 자택 주소 우편번호
    var strAptHomeAddr1		= EM_HNEW_ADDR1.Text;   //변경 후 도로명 자택 주소1
    var strAptHomeAddr2		= EM_HNEW_ADDR2.Text;   //변경 후 도로명 자택 주소2
    //구주소
    var strAptHomeZipCd_1	= EM_HOME_ZIP_CD1.Text; //변경 후 구주소 자택 주소 우편번호
    var strAptHomeZipCd_2	= EM_HOME_ZIP_CD2.Text; //변경 후 구주소 자택 주소 우편번호
    var strAptHomeAddr_1	= EM_HOME_ADDR1.Text;   //변경 후 구주소 자택 주소1
    var strAptHomeAddr_2	= EM_HOME_ADDR2.Text;   //변경 후 구주소 자택 주소2
    
    //회사
    var strPreOffiNewYn		= EM_PRE_OFFI_NEW_YN.Text; 
    var strPreOffiZipCd1	= EM_PRE_OFFI_ZIP_CD1.Text;
    var strPreOffiZipCd2	= EM_PRE_OFFI_ZIP_CD2.Text;
    var strPreOffiAddr1		= EM_PRE_OFFI_ADDR1.Text;   
    var strPreOffiAddr2		= EM_PRE_OFFI_ADDR2.Text;   
    var strAptOffiNewYn		= strPreOffiNewYn;
    var strAptOffiZipCd1	= EM_OFFI_ZIP_CD1.Text;
    var strAptOffiZipCd2	= EM_OFFI_ZIP_CD2.Text;
    var strAptOffiAddr1		= EM_OFFI_ADDR1.Text;   
    var strAptOffiAddr2		= EM_OFFI_ADDR2.Text;      

    DS_HOME_DATA.ClearData();
    DS_HOME_DATA.Addrow();
    DS_OFFI_DATA.ClearData();
    DS_OFFI_DATA.Addrow();
    //집
    DS_HOME_DATA.NameValue(DS_HOME_DATA.RowPosition, "CUST_ID" )			= strCustid;
    DS_HOME_DATA.NameValue(DS_HOME_DATA.RowPosition, "HOME_NEW_YN" )		= strAptHomeNewYn;
    //변경 후 구주소
    DS_HOME_DATA.NameValue(DS_HOME_DATA.RowPosition, "HOME_ZIP_CD1" )		= strAptHomeZipCd_1;
    DS_HOME_DATA.NameValue(DS_HOME_DATA.RowPosition, "HOME_ZIP_CD2" )		= strAptHomeZipCd_2;    
    DS_HOME_DATA.NameValue(DS_HOME_DATA.RowPosition, "HOME_ADDR1" )			= strAptHomeAddr_1;
    DS_HOME_DATA.NameValue(DS_HOME_DATA.RowPosition, "HOME_ADDR2" )  		= strAptHomeAddr_2;
    //변경 후 도로명 주소
    DS_HOME_DATA.NameValue(DS_HOME_DATA.RowPosition, "HNEW_ZIP_CD1" )		= strAptHomeZipCd1;
    DS_HOME_DATA.NameValue(DS_HOME_DATA.RowPosition, "HNEW_ZIP_CD2" )		= strAptHomeZipCd2;    
    DS_HOME_DATA.NameValue(DS_HOME_DATA.RowPosition, "HNEW_ADDR1" )			= strAptHomeAddr1;
    DS_HOME_DATA.NameValue(DS_HOME_DATA.RowPosition, "HNEW_ADDR2" )  		= strAptHomeAddr2; 
        
    DS_HOME_DATA.NameValue(DS_HOME_DATA.RowPosition, "BF_HOME_NEW_YN" )		= strPreHomeNewYn;
    DS_HOME_DATA.NameValue(DS_HOME_DATA.RowPosition, "BF_HOME_ZIP_CD1" )	= strPreHomeZipCd1;
    DS_HOME_DATA.NameValue(DS_HOME_DATA.RowPosition, "BF_HOME_ZIP_CD2" )	= strPreHomeZipCd2;    
    DS_HOME_DATA.NameValue(DS_HOME_DATA.RowPosition, "BF_HOME_ADDR1" )		= strPreHomeAddr1;
    DS_HOME_DATA.NameValue(DS_HOME_DATA.RowPosition, "BF_HOME_ADDR2" )  	= strPreHomeAddr2;
    //회사
    DS_OFFI_DATA.NameValue(DS_OFFI_DATA.RowPosition, "CUST_ID" )			= strCustid;
    DS_OFFI_DATA.NameValue(DS_OFFI_DATA.RowPosition, "OFFI_NEW_YN" )		= strPreOffiNewYn;
    DS_OFFI_DATA.NameValue(DS_OFFI_DATA.RowPosition, "OFFI_ZIP_CD1" )		= strAptOffiZipCd1;
    DS_OFFI_DATA.NameValue(DS_OFFI_DATA.RowPosition, "OFFI_ZIP_CD2" )		= strAptOffiZipCd2;
    DS_OFFI_DATA.NameValue(DS_OFFI_DATA.RowPosition, "OFFI_ADDR1" )			= strAptOffiAddr1;
    DS_OFFI_DATA.NameValue(DS_OFFI_DATA.RowPosition, "OFFI_ADDR2" )  		= strAptOffiAddr2;
    DS_OFFI_DATA.NameValue(DS_OFFI_DATA.RowPosition, "BF_OFFI_NEW_YN" )		= strPreOffiNewYn;
    DS_OFFI_DATA.NameValue(DS_OFFI_DATA.RowPosition, "BF_OFFI_ZIP_CD1" )	= strPreOffiZipCd1;
    DS_OFFI_DATA.NameValue(DS_OFFI_DATA.RowPosition, "BF_OFFI_ZIP_CD2" )	= strPreOffiZipCd2;
    DS_OFFI_DATA.NameValue(DS_OFFI_DATA.RowPosition, "BF_OFFI_ADDR1" )		= strPreOffiAddr1;
    DS_OFFI_DATA.NameValue(DS_OFFI_DATA.RowPosition, "BF_OFFI_ADDR2" )  	= strPreOffiAddr2;    
  
    var goTo        = "editJusoPro" ;    
    var action      = "I";
    var parameters  = "&strAddrFlag=" + encodeURIComponent(RD_JUSO_GBN.CodeValue) + "&strAddrPathCd=" + encodeURIComponent(strAddrPathCd);
    TR_MAIN.Action  = "/dcs/dctm203.dm?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_HOME_DATA=DS_HOME_DATA,"+action+":DS_OFFI_DATA=DS_OFFI_DATA)";
    TR_MAIN.Post();

    saveClose();
}

function saveClose()
{
    var strColumnId = "";
    returnMap.put("SEL_JUSO", RD_JUSO_GBN.CodeValue);
    
    if(RD_JUSO_GBN.CodeValue == "H"){ 
    	
	    returnMap.put("HOME_NEW_YN",	EM_HOME_NEW_YN.Text);
	    //도로명주소
	    returnMap.put("HNEW_ZIP_CD1", 	EM_HOME_ZIP_CD1.Text);
	    returnMap.put("HNEW_ZIP_CD2", 	EM_HOME_ZIP_CD2.Text);
	    returnMap.put("HNEW_ADDR1", 	EM_HNEW_ADDR1.Text);
	    returnMap.put("HNEW_ADDR2", 	EM_HNEW_ADDR2.Text);
	    //구주소
	    returnMap.put("HOME_ADDR1", 	EM_HOME_ADDR1.Text);
	    returnMap.put("HOME_ADDR2", 	EM_HOME_ADDR2.Text);
	     
    }else{
	    returnMap.put("OFFI_NEW_YN", 	EM_OFFI_NEW_YN.Text);
	    returnMap.put("OFFI_ZIP_CD1", 	EM_OFFI_ZIP_CD1.Text);
	    returnMap.put("OFFI_ZIP_CD2", 	EM_OFFI_ZIP_CD2.Text);
	    returnMap.put("OFFI_ADDR1", 	EM_OFFI_ADDR1.Text);
	    returnMap.put("OFFI_ADDR2", 	EM_OFFI_ADDR2.Text);    	
    }    
        
    window.returnValue = true;
    window.close();
   
}

/**
 * chgBtnEnable()
 * 작 성 자 : kj
 * 작 성 일 : 2012-05-17
 * 개       요 : 변경할 주소 선택
 * return값 : void
 */
 function chgBtnEnable()
 {
 	if(RD_JUSO_GBN.CodeValue == "H"){	
 		document.getElementById("home_bf").style.display = "";
 		document.getElementById("home_af").style.display = "";
 		document.getElementById("offi_bf").style.display = "none";
 		document.getElementById("offi_af").style.display = "none"; 		
 	}else{
 		document.getElementById("home_bf").style.display = "none";
 		document.getElementById("home_af").style.display = "none";
 		document.getElementById("offi_bf").style.display = "";
 		document.getElementById("offi_af").style.display = "";
 	}
 }

-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                         *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                                                                                                        *-->
<!--*    1. TR Success 메세지 처리
<!--*    2. TR Fail 메세지 처리
<!--*    3. DataSet Success 메세지 처리
<!--*    4. DataSet Fail 메세지 처리
<!--*    5. DataSet 이벤트 처리
<!--*************************************************************************-->
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=RD_JUSO_GBN event=OnSelChange()>
	chgBtnEnable();
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                   *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->
<!-- =============== Input용 -->
<comment id="_NSID_">
<object id="DS_HOME_DATA" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_OFFI_DATA" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<!--------------------- 2. Transaction  --------------------------------------->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="pop01"></td>
		<td class="pop02"></td>
		<td class="pop03"></td>
	</tr>
	<tr>
		<td class="pop04"></td>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="396" class="title"><img
							src="/<%=dir%>/imgs/comm/title_head.gif" width="15" height="13"
							align="absmiddle" class="popR05 PL03" /> 주소 수정
							<comment id="_NSID_"><object id=RD_JUSO_GBN
								classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 0"
								align="absmiddle">
								<param name=Cols value="2">
								<param name=Format value="H^자택,O^직장">
								<param name="AutoMargin" value="true">
								<param name=CodeValue value="H">
							</object> </comment> <script> _ws_(_NSID_);</script></td>	
						<td>
						<table border="0" align="right" cellpadding="0" cellspacing="0">
							<tr>
								<td><img src="/<%=dir%>/imgs/btn/save.gif" tabindex=2
									onClick="editJuso()" /></td>
								<td><img src="/<%=dir%>/imgs/btn/close.gif" width="50"
									height="22" onClick="btn_Close();" tabindex=3 /></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td class="popT01 PB15">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0"
							class="s_table">
							<tr id="home_bf">
                            <th width="90">변경전 자택주소</th>
                            <td style="overflow: hidden; width: 420px; border-right: 0; padding-right: 0"><comment
                                id="_NSID_"> <object id=EM_PRE_HOME_NEW_YN
                                classid=<%=Util.CLSID_EMEDIT%> width=0 align="absmiddle">
                            </object> </comment> <script> _ws_(_NSID_);</script><comment
                                id="_NSID_"> <object id=EM_PRE_HOME_ZIP_CD1
                                classid=<%=Util.CLSID_EMEDIT%> width=40 align="absmiddle">
                            </object> </comment> <script> _ws_(_NSID_);</script> <comment id="_NSID_">
                            <object id=EM_PRE_HOME_ZIP_CD2 classid=<%=Util.CLSID_EMEDIT%>
                                width=30 align="absmiddle" > </object> </comment> <script> _ws_(_NSID_);</script>
                            <img src="/<%=dir%>/imgs/btn/search_post_s.gif" style="visibility:hidden">
                            <comment id="_NSID_"> <object id=EM_PRE_HOME_ADDR1
                                classid=<%=Util.CLSID_EMEDIT%> width=255 align="absmiddle"></object>
                            </comment> <script> _ws_(_NSID_);</script></td>
                            <td style="border-left: 1px solid #fff; padding-left: 0"><comment
                                id="_NSID_"> <object id=EM_PRE_HOME_ADDR2
                                classid=<%=Util.CLSID_EMEDIT%> width=233 tabindex=1
                                align="absmiddle"
                                onkeyup="javascript:checkByteStr(EM_PRE_HOME_ADDR2, 200, '');"></object>
                            </comment> <script> _ws_(_NSID_);</script></td>
                        	</tr>
							<tr id="home_af">
                            <th class="point">변경후 자택주소</th>
                            <td style="overflow: hidden; width: 420px; border-right: 0; padding-right: 0"><comment
                                id="_NSID_"> <object id=EM_HOME_NEW_YN
                                classid=<%=Util.CLSID_EMEDIT%> width=0 align="absmiddle">
                            </object> </comment> <script> _ws_(_NSID_);</script><comment
                                id="_NSID_"> <object id=EM_HNEW_ZIP_CD1  
                                classid=<%=Util.CLSID_EMEDIT%> width=40 align="absmiddle">
                            </object> </comment> <script> _ws_(_NSID_);</script> <comment id="_NSID_">
                            <object id=EM_HNEW_ZIP_CD2 classid=<%=Util.CLSID_EMEDIT%> style="display : none" 
                                width=30 align="absmiddle" > </object> </comment> <script> _ws_(_NSID_);</script>
                            <img src="/<%=dir%>/imgs/btn/search_post_s.gif"
                                onclick="javascript:sample4_execDaumPostcode()"
                                align="absmiddle" tabindex=1 id="IMG_HOME_ADDR">
                            <comment id="_NSID_"> <object id=EM_HNEW_ADDR1
                                classid=<%=Util.CLSID_EMEDIT%> width=255 align="absmiddle"></object>
                            </comment> <script> _ws_(_NSID_);</script></td>
                            <td style="border-left: 1px solid #fff; padding-left: 0"><comment
                                id="_NSID_"> <object id=EM_HNEW_ADDR2
                                classid=<%=Util.CLSID_EMEDIT%> width=233 tabindex=1
                                align="absmiddle"
                                onkeyup="javascript:checkByteStr(EM_HNEW_ADDR2, 200, '');"></object>
                            </comment> <script> _ws_(_NSID_);</script></td> 
							<span id="guide" style="color:#999"></span>
                        	</tr>
                        	<tr id="offi_bf">                        	
                            <th>변경전 직장주소</th>
                            <td style="overflow: hidden; width: 420px; border-right: 0; padding-right: 0"><comment
                                id="_NSID_"> <object id=EM_PRE_OFFI_NEW_YN
                                classid=<%=Util.CLSID_EMEDIT%> width=0 align="absmiddle">
                            </object> </comment> <script> _ws_(_NSID_);</script><comment
                                id="_NSID_"> <object id=EM_PRE_OFFI_ZIP_CD1
                                classid=<%=Util.CLSID_EMEDIT%> width=30 align="absmiddle">
                            </object> </comment> <script> _ws_(_NSID_);</script>- <comment id="_NSID_">
                            <object id=EM_PRE_OFFI_ZIP_CD2 classid=<%=Util.CLSID_EMEDIT%>
                                width=30 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                            <img src="/<%=dir%>/imgs/btn/search_post_s.gif" style="visibility:hidden">
                            <comment id="_NSID_"> <object id=EM_PRE_OFFI_ADDR1
                                classid=<%=Util.CLSID_EMEDIT%> width=256 align="absmiddle"></object>
                            </comment> <script> _ws_(_NSID_);</script></td>
                            <td style="border-left: 1px solid #fff; padding-left: 0"><comment
                                id="_NSID_"> <object id=EM_PRE_OFFI_ADDR2
                                classid=<%=Util.CLSID_EMEDIT%> width=233 tabindex=1
                                align="absmiddle"
                                onkeyup="javascript:checkByteStr(EM_PRE_OFFI_ADDR2, 200, '');"></object>
                            </comment> <script> _ws_(_NSID_);</script></td>
                        	</tr>
                        	<tr id="offi_af">
                            <th>변경후 직장주소</th>
                            <td style="overflow: hidden; width: 420px; border-right: 0; padding-right: 0"><comment
                                id="_NSID_"> <object id=EM_OFFI_NEW_YN
                                classid=<%=Util.CLSID_EMEDIT%> width=0 align="absmiddle">
                            </object> </comment> <script> _ws_(_NSID_);</script><comment
                                id="_NSID_"> <object id=EM_OFFI_ZIP_CD1
                                classid=<%=Util.CLSID_EMEDIT%> width=30 align="absmiddle">
                            </object> </comment> <script> _ws_(_NSID_);</script>- <comment id="_NSID_">
                            <object id=EM_OFFI_ZIP_CD2 classid=<%=Util.CLSID_EMEDIT%>
                                width=30 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                            <img src="/<%=dir%>/imgs/btn/search_post_s.gif"
                                onclick="getPostPop_dcs(EM_OFFI_ZIP_CD1,EM_OFFI_ZIP_CD2,EM_OFFI_ADDR1,EM_OFFI_ADDR2,EM_OFFI_NEW_YN)"
                                align="absmiddle" tabindex=1 id="IMG_OFFI_ADDR"
                                onkeydown="if(event.keyCode==13){getPostPopEnter_dcs(EM_OFFI_ZIP_CD1,EM_OFFI_ZIP_CD2,EM_OFFI_ADDR1,EM_OFFI_ADDR2,EM_OFFI_NEW_YN)}">
                            <comment id="_NSID_"> <object id=EM_OFFI_ADDR1
                                classid=<%=Util.CLSID_EMEDIT%> width=256 align="absmiddle"></object>
                            </comment> <script> _ws_(_NSID_);</script></td>
                            <td style="border-left: 1px solid #fff; padding-left: 0"><comment
                                id="_NSID_"> <object id=EM_OFFI_ADDR2
                                classid=<%=Util.CLSID_EMEDIT%> width=233 tabindex=1
                                align="absmiddle"
                                onkeyup="javascript:checkByteStr(EM_OFFI_ADDR2, 200, '');"></object>
                            </comment> <script> _ws_(_NSID_);</script></td>
                        	</tr> 
                        	<tr style="display : none" >
							<th class="point">자택주소(구주소)</th>
							<td colspan="2"
								style="overflow: hidden; width: 420px; border-right: 0; padding-right: 0">
								<comment
								id="_NSID_"> <object id=EM_HOME_ZIP_CD1 
								classid=<%=Util.CLSID_EMEDIT%> width=40 align="absmiddle">
							</object> </comment> <script> _ws_(_NSID_);</script> <comment id="_NSID_">
							<object id=EM_HOME_ZIP_CD2 classid=<%=Util.CLSID_EMEDIT%> 
								width=30 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
							<img src="/<%=dir%>/imgs/btn/search_post_s.gif" style="display : none"
								onclick="sample4_execDaumPostcode()"
								align="absmiddle" tabindex=5 id="IMG_OFFI_ADDR">
							<comment id="_NSID_"> <object id=EM_HOME_ADDR1
								classid=<%=Util.CLSID_EMEDIT%> width=255 align="absmiddle"></object>
							</comment> <script> _ws_(_NSID_);</script></td>
							<td style="border-left: 1px solid #fff; padding-left: 0"><comment
								id="_NSID_"> <object id=EM_HOME_ADDR2 style="display : none"
								classid=<%=Util.CLSID_EMEDIT%> width=233 tabindex=5
								align="absmiddle"
								onkeyup="javascript:checkByteStr(EM_HOME_ADDR2, 200, '');"></object>
							</comment> <script> _ws_(_NSID_);</script></td>
							<span id="guide" style="color:#999"></span>
						    </tr>                       	                        	
							<tr>
								<th width="100">회원아이디</th>
								<td colspan="2"><comment id="_NSID_"> <object id=EM_CUST_ID_S
									classid=<%=Util.CLSID_EMEDIT%> width=380 align="absmiddle">
								</object> </comment> <script> _ws_(_NSID_);</script></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
		<td class="pop06"></td>
	</tr>
	<tr>
		<td class="pop07"></td>
		<td class="pop08"></td>
		<td class="pop09"></td>
	</tr>
</table>
</body>
</html>
