/**
 * 시스템명 : 한국후지쯔 포인트카드 팝업 스크립트
 * 작 성 일 : 2010-01-20
 * 작 성 자 : FKL
 * 수 정 자 :
 * 파 일 명 : potup_dcs.js
 * 버    전 : 1.0
 * 인 코 딩 : 
 * 개    요 : 팝업 자바스크립트 표준 공통 함수
 */

/** 목록을 반드시 작성하여 주시기 바랍니다.
 *  백화점     : CCom000 ~ CCom199
 *  경영지원   : CCom200 ~ CCom399
 *  포인트카드 : CCom400 ~ CCom599
 *  문화센터   : CCom600 ~ CCom799
 *  공통       : CCom900 ~ CCom999
 */

/**
공통함수 목록

☞-------------------FUNCTION ---------------------------------


☞-------------------POPOP  ---------------------------------
getBrchPop()	가맹점찾기
getCustPop()	회원명찾기
getCompPop()	법인명찾기

☞-------------------non-POPOP  ---------------------------------

*/

/**
* getBrchPop()
* 작 성 자 : 남형석
* 작 성 일 : 2010. 01. 25
* 개    요 : 가맹점 찾기 팝업
* 사용방법 : getBrchPop(objCd, objNm)
*            arguments[0] -> 팝업 그리드 더블클릭시 가맹점코드를 받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 가맹점이름을 받아올 EMEDIT ID
* return값 : array
*/
function getBrchPop(objCd, objNm)
{
    var rtnMap  = new Map();
    var arrArg  = new Array();

    arrArg.push(rtnMap);
	arrArg.push(objCd.Text);

    var returnVal = window.showModalDialog("/pot/ccom400.cc?goTo=list",
                                           arrArg,
                                           "dialogWidth:580px;dialogHeight:430px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		var map = arrArg[0];
		objCd.Text = map.get("BRCH_ID");
		objNm.Text = map.get("BRCH_NAME");
 	}else{
 		if(objNm.Text == ""){
 			objCd.Text = "";
 			objNm.Text = "";
 			objCd.Focus();
 		}
		
 	}
    
}

/**
* getBrchPop2()
* 작 성 자 : 남형석
* 작 성 일 : 2010. 01. 25
* 개    요 : 가맹점 찾기 팝업
* 사용방법 : getBrchPop(objCd, objNm)
*            arguments[0] -> 팝업 그리드 더블클릭시 가맹점코드를 받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 가맹점이름을 받아올 EMEDIT ID
* return값 : array
*/
function getBrchPop2(objCd, objNm, objStrCd)
{
    var rtnMap  = new Map();
    var arrArg  = new Array();

    arrArg.push(rtnMap);
	arrArg.push(objCd.Text);

    var returnVal = window.showModalDialog("/pot/ccom400.cc?goTo=list",
                                           arrArg,
                                           "dialogWidth:580px;dialogHeight:430px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		var map = arrArg[0];
		objCd.Text = map.get("BRCH_ID");
		objNm.Text = map.get("BRCH_NAME");
		objStrCd.Text = map.get("STR_CD");
 	}else{
 		if(objNm.Text == ""){
 			objCd.Text = "";
 			objNm.Text = "";
 			objStrCd.Text = "";
 			objCd.Focus();
 		}
		
 	}
    
}

/**
* getCustPop()
* 작 성 자 : 남형석
* 작 성 일 : 2010. 01. 25
* 개    요 : 회원명 찾기 팝업
* 사용방법 : getCustPop(objCd, objNm)
*            arguments[0] -> 팝업 그리드 더블클릭시 회원코드를 받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 회원명을 받아올 EMEDIT ID
* return값 : array
*/
function getCustPop(objCd, objNm)
{

    var rtnMap  = new Map();
    var arrArg  = new Array();

    arrArg.push(rtnMap);
	arrArg.push(objCd.Text);

    var returnVal = window.showModalDialog("/pot/ccom410.cc?goTo=list&flag=P",
                                           arrArg,
                                           "dialogWidth:580px;dialogHeight:422px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		var map = arrArg[0];
		objCd.Text = map.get("CUST_ID");
		objNm.Text = map.get("CUST_NAME");
 	}
    
}

/**
* getCompPop()
* 작 성 자 : 김영진
* 작 성 일 : 2010. 02. 28
* 개    요 : 법인명/회원명 찾기 팝업
* 사용방법 : getCompPop(objCd, objNm)
*            arguments[0] -> 팝업 그리드 더블클릭시 회원코드를 받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 회원명을 받아올 EMEDIT ID
* return값 : array
*/
function getCompPop(objCd, objNm, flag, scrId)
{

    var rtnMap  = new Map();
    var arrArg  = new Array();

    arrArg.push(rtnMap);
	arrArg.push(objCd.Text);
	var parameters  = "&flag=" + flag;
	var url = "/pot/ccom410.cc?goTo=list";
	if(flag == "C"){
		url = "/pot/ccom420.cc?goTo=list";
	}else if(flag == "P"){
		url = "/pot/ccom410.cc?goTo=list";
	}
	parameters += "&strScrId="+ scrId;
	
    var returnVal = window.showModalDialog(url+parameters,
                                           arrArg,
                                           "dialogWidth:580px;dialogHeight:420px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		var map = arrArg[0];
		objCd.Text = map.get("CUST_ID");
		objNm.Text = map.get("CUST_NAME");
 	}else{
 		if(objNm.Text == ""){
 			objCd.Text = "";
 			objNm.Text = "";
 			objCd.Focus();
 		}
		
 	}
}


/**
* getCompPop()
* 작 성 자 : 김영진
* 작 성 일 : 2010. 02. 28
* 개    요 : 법인명/회원명 찾기 팝업
* 사용방법 : getCompPop(objCd, objNm)
*            arguments[0] -> 팝업 그리드 더블클릭시 회원코드를 받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 회원명을 받아올 EMEDIT ID
* return값 : array
*/
function getCardPop(objCd, objNm, flag, scrId)
{

    var rtnMap  = new Map();
    var arrArg  = new Array();

    arrArg.push(rtnMap);
	arrArg.push(objCd.Text);
	var parameters  = "&flag=" + flag;
	var url = "/pot/ccom410.cc?goTo=list";
	if(flag == "C"){
		url = "/pot/ccom420.cc?goTo=list";
	}else if(flag == "P"){
		url = "/pot/ccom410.cc?goTo=list";
	}
	
	if(nvl(scrId) || scrId == undefined) scrId = "P";	// 개인회원
	parameters += "&strScrId="+ scrId;
	
    var returnVal = window.showModalDialog(url+parameters,
                                           arrArg,
                                           "dialogWidth:580px;dialogHeight:420px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		var map = arrArg[0];
		//objCd.Text = map.get("CUST_ID");
		//objNm.Text = map.get("CUST_NAME");
		objCd.Text = map.get("CARD_NO");
 	}else{
 		if(objNm.Text == ""){
 			objCd.Text = "";
 			objNm.Text = "";
 			objCd.Focus();
 		}
		
 	}
}

/**
* getSsNoPop()
* 작 성 자 : 김영진
* 작 성 일 : 2010. 03. 28
* 개    요 : 사업자번호 찾기 팝업
* 사용방법 : getSsNoPop(objCd, objNm)
*            arguments[0] -> 팝업 그리드 더블클릭시 사업자번호를 받아올 EMEDIT ID
* return값 : array
*/
function getSsNoPop(objCd, flag)
{

    var rtnMap  = new Map();
    var arrArg  = new Array();

    arrArg.push(rtnMap);
	arrArg.push(objCd.Text);
	var parameters  = "&flag=" + flag;
    var returnVal = window.showModalDialog("/pot/ccom420.cc?goTo=list"+parameters,
                                           arrArg,
                                           "dialogWidth:580px;dialogHeight:422px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		var map = arrArg[0];
		objCd.Text = map.get("SS_NO");
		showCustInfo();
 	}
    
}

/**
* getPostPop_dcs()
* 작 성 자 : 남형석
* 작 성 일 : 2010. 01. 22
* 개    요 : 우편번호 팝업
* 사용방법 : getPostPop(objCd, objNm)
*            arguments[0] -> 팝업 그리드 더블클릭시 우편번호를 받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 주소를 받아올 EMEDIT ID
* return값 : array
*/

function getPostPop_dcs(objCd1,objCd2,objNm1,objNm2,objGubun)
{
    
    var rtnMap  = new Map();
    var arrArg  = new Array();

    arrArg.push(rtnMap);
	//arrArg.push(objCd.Text);

    var returnVal = window.showModalDialog("/pot/ccom430.cc?goTo=list",
                                           arrArg,
                                           "dialogWidth:910px;dialogHeight:450px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		var map = arrArg[0];
		objCd1.Text = map.get("POST_NO1");
		objCd2.Text = map.get("POST_NO2");
		objNm1.Text = map.get("ADDR1");
		objNm2.Text = map.get("ADDR2");
		objGubun.Text = map.get("GUBUN");
		//팝업 close 후 포커스
		objNm2.Focus();	
 	}
    
}

/**
* getPostPopEnter_dcs()
* 작 성 자 : 남형석
* 작 성 일 : 2010. 01. 22
* 개    요 : 우편번호 팝업
* 사용방법 : getPostPopEnter_dcs(objCd1,objCd2,objCd3,objNm1)
*            arguments[0] -> 팝업 그리드 더블클릭시 우편번호를 받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 주소를 받아올 EMEDIT ID
* return값 : array
*/

function getPostPopEnter_dcs(objCd1,objCd2,objNm1,objNm2,objGubun)
{
    
    var rtnMap  = new Map();
    var arrArg  = new Array();

    arrArg.push(rtnMap);
	//arrArg.push(objCd.Text);

    var returnVal = window.showModalDialog("/pot/ccom430.cc?goTo=list",
                                           arrArg,
                                           "dialogWidth:910px;dialogHeight:450px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		var map = arrArg[0];
		objCd1.Text = map.get("POST_NO1");
		objCd2.Text = map.get("POST_NO2");
		objNm1.Text = map.get("ADDR1");
		objNm2.Text = map.get("ADDR2");
		objGubun.Text = map.get("GUBUN");
 	}
}

/**
* juminCheck(jumin)
* 작 성 자 : FKL
* 작 성 일 : 2006.12.01
* 개    요 : 주민번호 Check
* 사용방법 : juminCheck("12345671234567")
* return값 : true/false
*/
function juminCheck( str ) {

	if(str =='') return false;	//공백이라면

	str = getRawData(str);	// "-" 제거
	var  j=9
	var  id_chk=0

	object =  new Array(13)
	for(var i=0;i < 13;i++) {
		object[i] = str.substring(i,i+1)
	}
	var chkdigit = str.substring(12, 13)
	for(var i=0;i < 12;i++){
	    if( i == 8 )
	    j = 9
	    object[i]=object[i]*j
	    j--
	    id_chk +=object[i]
	}
    if(((id_chk%11 == 0) && (chkdigit == 1)) || ((id_chk%11 ==10)&& (chkdigit ==0))){
         return true;
    }
    else if((id_chk %11 != 0) && (id_chk % 11 != 10 ) && (id_chk % 11 == chkdigit)){
         return true;
    }
    else{
         return false;
    }
}

/**
* setCustInfoToDataSet()
* 작 성 자 : FKL
* 작 성 일 : 2010-01-22
* 개    요 : 팝업 없이 코드 입력후  키업 이벤트시 코드,코드명 DataSet에 셋팅 
* 사용방법 : setNmToDataSet(strDataSet, serviceId, codeCd)
*            arguments[0] -> Output용 dataset 문자  	예)"DS_O_SBRAND"
*            arguments[1] -> [dcom100_service.xml] 에 정의한 QUERY의 ID   예) "SEL_SBRAND"
*            arguments[2] -> 조회 조건이 될 코드
*            arguments[m] -> 추가조건 
*
* 실행 예) setCustInfoToDataSet("DS_O_SBRAND", "SEL_SBRAND", "02");
*
* return값 : void
*/
function setCustInfoToDataSet(strDataSet, serviceId, strCustId, strCardNo, strSsNo, goTo, strFlag, strScrId) {
	DS_I_CONDITION.setDataHeader( 'SERVICE_ID:STRING(50),CUST_ID:STRING(100),CARD_NO:STRING(100),SS_NO:STRING(100),COMP_PERS_FLAG:STRING(1),SCR_ID:STRING(7)' );
	
    DS_I_CONDITION.ClearData();
    DS_I_CONDITION.Addrow();
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "SERVICE_ID") 		= serviceId;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "CUST_ID")    		= strCustId;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "CARD_NO")    		= strCardNo;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "SS_NO")    		= strSsNo;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "COMP_PERS_FLAG")  = strFlag;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "SCR_ID")          = strScrId; 
    
    TR_MAIN.Action	 = "/dcs/dcom100.cc?goTo="+goTo;
    TR_MAIN.KeyValue = "SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:"+encodeURIComponent(strDataSet)+"="+encodeURIComponent(strDataSet)+")";
    TR_MAIN.Post();
}

/**
 * getCustInfoSrch()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010.02.23
 * 개       요 : Enter, Tab키 이벤트
 * return값 :
 */
function getCustInfoSrch(kcode,obj,objNm,cpflag, scrId) {
	var intLength = 0;
	var strSsNo   = ""; 
	var strCardNo = ""; 
	var strCustId = ""; 
	// MARIO OUTLET
	var intLength13 = 0;
	var intLength16 = 0;
    var goTo      = "getOneWithoutPop";
    if(objNm == 'EM_SS_NO_S'){
    	//intLength = 13;
    	intLength = 6;
    	strSsNo = obj.Text;
    }else  if(objNm == 'EM_SS_NO_S1'){
    	intLength = 10;
    	strSsNo = obj.Text;
    }else if(objNm == 'EM_CARD_NO_S'){
    	intLength = 16;
    	intLength13 = 13;
    	intLength16 = 16;
    	strCardNo = obj.Text;
    }else if(objNm == 'EM_CUST_ID_S'){
    	intLength = 9;
    	strCustId = obj.Text;
    }
    if (trim(obj.Text).length > 0 ) {
    	// MARIO OUTLET
    	//if (kcode == 13 || kcode == 9 || trim(obj.Text).length == intLength ) { //TAB,ENTER 키 실행시에만             
        if (kcode == 13 || kcode == 9 || trim(obj.Text).length == intLength  || trim(obj.Text).length == intLength13  || trim(obj.Text).length == intLength16) { //TAB,ENTER 키 실행시에만 
        	setCustInfoToDataSet("DS_O_RESULT", "SEL_CUSTSRCH", strCustId, strCardNo, strSsNo, goTo, cpflag, scrId);
            if (DS_O_RESULT.CountRow == 1 ) {
            	if(objNm != 'EM_CUST_ID_S'){
                    EM_CUST_ID_H.Text   = DS_O_RESULT.NameValue(1, "CUST_ID");
            	}
                if(objNm == 'EM_CUST_ID_S'){
                	EM_CUST_NAME_S.Text = DS_O_RESULT.NameValue(1, "CUST_NAME");
                }
               //EM_CARD_NO_H.Text = DS_O_RESULT.NameValue(1, "CARD_NO");
               //EM_SS_NO_H.Text   = DS_O_RESULT.NameValue(1, "SS_NO");
            }else{
           	     EM_CUST_ID_H.Text   = "";
        	     EM_CARD_NO_H.Text   = "";
        	     EM_SS_NO_H.Text     = "";
        	     EM_CUST_NAME_S.Text = "";
        	     if(objNm == 'EM_CUST_ID_S'){
            	     getCompPop(EM_CUST_ID_S,EM_CUST_NAME_S,cpflag, scrId);
        	     }

            }
        }
    }
}

/**
 * srchEvent()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010.02.25
 * 개      요  : 조회 버튼 클릭시 자동 조회
 * return값 :
 */
function srchEvent(flag) {
	
	var strCustId = EM_CUST_ID_S.Text;
	var strCardNo = EM_CARD_NO_S.Text;
	var strSsNo   = EM_SS_NO_S.Text
	var strComPerFlag = flag; 
	if(trim(strComPerFlag) == ""){
		strComPerFlag = RD_COMP_PERS_FLAG_S.CodeValue; 
	}
    var goTo      = "searchCustinfo";
    if(trim(EM_CUST_ID_S.Text).length == 0){
    	strCustId   = EM_CUST_ID_H.Text;
    }
    if(trim(EM_CARD_NO_S.Text).length == 0){
    	strCardNo = EM_CARD_NO_H.Text;
    }
    if(trim(EM_SS_NO_S.Text).length == 0){
    	strSsNo = EM_SS_NO_H.Text;
    }
    
	setCustInfoToDataSet("DS_O_CUSTDETAIL", "SEL_CUSTINFO", strCustId, strCardNo, strSsNo, goTo, strComPerFlag, '');
	
	if(trim(EM_HOME_PH1.Text).length != 0){
        EM_HOME_PH.Text   = EM_HOME_PH1.Text +" - "+ EM_HOME_PH2.Text +" - "+ EM_HOME_PH3.Text;
    }else if(trim(EM_HOME_PH2.Text).length != 0 && trim(EM_HOME_PH3.Text).length != 0){
    	EM_HOME_PH.Text   = EM_HOME_PH2.Text +" - "+ EM_HOME_PH3.Text;
    }else{
    	EM_HOME_PH.Text = "";
    }
    if(trim(EM_MOBILE_PH1.Text).length != 0){
        EM_MOBILE_PH.Text = EM_MOBILE_PH1.Text +" - "+ EM_MOBILE_PH2.Text +" - "+ EM_MOBILE_PH3.Text;
    }else{
    	EM_MOBILE_PH.Text = "";
    }
    if(trim(EM_EMAIL1.Text).length != 0){
        EM_EMAIL.Text     = EM_EMAIL1.Text +"@"+ EM_EMAIL2.Text;
    }else{
    	 EM_EMAIL.Text = "";
    }
    if(trim(EM_SS_NO.Text).length != 0){
        if(trim(EM_SS_NO.Text).length == 10){
            EM_SS_NO.format = "#00-00-00000";
        }
        if(trim(EM_SS_NO.Text).length == 13){
            EM_SS_NO.format = "000000-0******";
        }
    }else{
        EM_SS_NO.Text = "";
        EM_SS_NO.format = "0000000000000";
    }
	
    return true;
}

/**
 * srchEvent()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010.02.25
 * 개      요  : 조회 버튼 클릭시 자동 조회
 * return값 :
 */
function srchEvent2(flag, gubun) {
	var strCustId = EM_CUST_ID_S.Text;
	var strCardNo = EM_CARD_NO_S.Text;
	var strSsNo   = EM_SS_NO_S.Text
	var strComPerFlag = flag; 
	var strScrId  = gubun;
	if(trim(strComPerFlag) == ""){
		strComPerFlag = RD_COMP_PERS_FLAG_S.CodeValue; 
	}
    var goTo      = "searchCustinfo";
    if(trim(EM_CUST_ID_S.Text).length == 0){
    	strCustId   = EM_CUST_ID_H.Text;
    }
    if(trim(EM_CARD_NO_S.Text).length == 0){
    	strCardNo = EM_CARD_NO_H.Text;
    }
    if(trim(EM_SS_NO_S.Text).length == 0){
    	strSsNo = EM_SS_NO_H.Text;
    }
	setCustInfoToDataSet("DS_O_CUSTDETAIL", "SEL_CUSTINFO", strCustId, strCardNo, strSsNo, goTo, strComPerFlag, strScrId);
	
	if(trim(EM_HOME_PH1.Text).length != 0){
        EM_HOME_PH.Text   = EM_HOME_PH1.Text +" - "+ EM_HOME_PH2.Text +" - "+ EM_HOME_PH3.Text;
    }else if(trim(EM_HOME_PH2.Text).length != 0 && trim(EM_HOME_PH3.Text).length != 0){
    	EM_HOME_PH.Text   = EM_HOME_PH2.Text +" - "+ EM_HOME_PH3.Text;
    }else{
    	EM_HOME_PH.Text = "";
    }
    if(trim(EM_MOBILE_PH1.Text).length != 0){
        EM_MOBILE_PH.Text = EM_MOBILE_PH1.Text +" - "+ EM_MOBILE_PH2.Text +" - "+ EM_MOBILE_PH3.Text;
    }else{
    	EM_MOBILE_PH.Text = "";
    }
    if(trim(EM_EMAIL1.Text).length != 0){
        EM_EMAIL.Text     = EM_EMAIL1.Text +"@"+ EM_EMAIL2.Text;
    }else{
    	 EM_EMAIL.Text = "";
    }
    if(trim(EM_SS_NO.Text).length != 0){
        if(trim(EM_SS_NO.Text).length == 10){
            EM_SS_NO.format = "#00-00-00000";
        }
        if(trim(EM_SS_NO.Text).length == 13){
            EM_SS_NO.format = "000000-0******";
        }
    }else{
        EM_SS_NO.Text = "";
        EM_SS_NO.format = "0000000000000";
    }
	
    return true;
}

/**
 * srchCustInfoEvent()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010.03.23
 * 개      요  : 조회 버튼 클릭시 자동 조회
 * return값 :
 */
function srchCustInfoEvent() {
	var strCardNo = EM_CARD_NO_S.Text;
    var goTo      = "searchCustinfo";
	setCustInfoToDataSet("DS_O_CUSTDETAIL", "SEL_CUSTINFO", '', strCardNo, '', goTo, '', '');
	
	if(trim(EM_HOME_PH1.Text).length != 0){
        EM_HOME_PH.Text   = EM_HOME_PH1.Text +"-"+ EM_HOME_PH2.Text +"-"+ EM_HOME_PH3.Text;
    }else{
    	EM_HOME_PH.Text = "";
    }
    if(trim(EM_MOBILE_PH1.Text).length != 0){
        EM_MOBILE_PH.Text = EM_MOBILE_PH1.Text +"-"+ EM_MOBILE_PH2.Text +"-"+ EM_MOBILE_PH3.Text;
    }else{
    	EM_MOBILE_PH.Text = "";
    }
    if(trim(EM_EMAIL1.Text).length != 0){
        EM_EMAIL.Text     = EM_EMAIL1.Text +"@"+ EM_EMAIL2.Text;
    }else{
    	 EM_EMAIL.Text = "";
    }
    if(trim(EM_SS_NO.Text).length != 0){
        if(trim(EM_SS_NO.Text).length == 10){
            EM_SS_NO.format = "#00-00-00000";
        }
        if(trim(EM_SS_NO.Text).length == 13){
            EM_SS_NO.format = "000000-0******";
        }
    }else{
        EM_SS_NO.Text = "";
        if(trim(EM_SS_NO.Text).length == 10){
            EM_SS_NO.format = "#00-00-00000";
        }
        if(trim(EM_SS_NO.Text).length == 13){
            EM_SS_NO.format = "000000-0000000";
        }
    }
	
    return true;
}

/**
 * getLastDay()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010.03.23
 * 개    요 : 마지막 날짜
 * return값 :
 */
function getLastDay( year, month ) {
     return new Date( new Date( year, month, 1 ) - 86400000 ).getDate();
}

/**
* getAge(jumin, toDay)
* 작 성 자 : 김영진
* 작 성 일 : 2010-05-09
* 개   요  : 나이 계산
* return값 : age
*/
function getAge(jumin, toDay){
    var birth = jumin.substring(0,2);
    var year  = toDay.substring(0,4);
	var nai= 0;

    if(jumin.length == 6) {
    	nai = (parseInt(year) - (1900 + parseInt(birth)) + 1);
    	// 100살이 넘으면 2000년생으로 간주하여 100살을 뺀다.
    	if(nai > 100) nai = nai - 100;
    	
    }else{
        // 생년월일에서 태어난 연도 추출
        var firstJumin = jumin.substring(6, 7);
        nai = iAge(parseInt(birth), parseInt(year), firstJumin);
    }
    return nai;
}

/**
 * iAge(birth, year, firstJumin)
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-05-09
 * 개   요  : 나이 계산
 * return값 : age
 */
function iAge(birth, year, firstJumin){
    var nai = 0;
    // 우리나이로 나이계산
    if (firstJumin == "1" || firstJumin == "2" || firstJumin == "5" || firstJumin == "6") {
        // 주민번호가 첫째자리 1 또는 2이면 2000년 이전 출생자
        nai = (year - (1900 + birth)) + 1;
        
    }else if (firstJumin == "3" || firstJumin == "4" || firstJumin == "7" || firstJumin == "8"){
        // 주민번호 첫째자리 3이나 4이면 2000년도 이후 출생자
        nai = (year - (2000 + birth) + 1);
    }
    return nai;
}

/**
 * getStrCd(birth, year, firstJumin)
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-05-09
 * 개   요  : 나이 계산
 * return값 : age
 */
function getGstrCd() {
	var dsName = "DS_TEMPORARY";
    var trName = "TR_TEMPORARY";
    
    var ds;
    var tr;
    
    if (null == document.getElementById(dsName)) {
        ds = document.createElement("OBJECT");
        ds.classid = CLSID_DATASET; 
        ds.id = dsName;
        document.body.insertAdjacentElement("afterBegin", ds) ;
    } else {
        ds = document.getElementById(dsName);
    }
    
    if (null == document.getElementById(trName)) {
        tr = document.createElement("OBJECT");
        tr.classid = CLSID_TRANSACTION; 
        tr.id = trName;
        document.body.insertAdjacentElement("afterBegin", tr) ;
    } else {
        tr = document.getElementById(trName);
    }
    
    var parameters  = "&dsName="  + encodeURIComponent(dsName) ;
        parameters += "&sqlId=G_STR_CD";
    
    tr.Action	 = "/dcs/dcom100.cc?goTo=getCommonResult"+ parameters;
    tr.KeyValue = "SERVLET(O:" + ds.id + "=" + ds.id + ")";
    tr.KeyName  = "Toinb_dataid4";
    tr.Post();
    
    return (null == ds.NameValue(1, "G_STR_CD") || "" == ds.NameValue(1, "G_STR_CD")) ? "01" : ds.NameValue(1, "G_STR_CD");
}

/**
 * setPumbunCdCombo()
 * 작 성 자 : 강진
 * 작 성 일 : 2012.05.08
 * 개    요 : 품번POPUP/품목COMBO를 조회한다.
 * return값 : void
 */
function setPumbunCdCombo(evnflag){
    
    var codeObj = EM_O_PUMBUN_CD;
    var nameObj = EM_O_PUMBUN_NM;
    var result = null;

    if( evnflag == "POP" ){
    	//단품구분 삭제 2012.07.25
        result = strPbnPop2(codeObj,nameObj,'Y','','','','','','','','','','','','','');          
        //result = strPbnPop2(codeObj,nameObj,'Y','','','','','','','','1','','','','','');
    }else if( evnflag == "NAME" ){
    	//단품구분 삭제 2012.07.25
        setStrPbnNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj,"Y",'1','','','','','','','','','','','','','');       
        //setStrPbnNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj,"Y",'1','','','','','','','','1','','','','',''); 
    } 
}
