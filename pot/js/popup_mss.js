/**
 * 시스템명 : 한국후지쯔 경영지원 팝업 스크립트
 * 작 성 일 : 2010-01-24
 * 작 성 자 : 김성미
 * 수 정 자 :
 * 파 일 명 : potup_mss.js
 * 버    전 : 1.0
 * 인 코 딩 : 
 * 개    요 : 경영지원 파트 팝업 자바스크립트 표준 공통 함수
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
showWindow()            : Window 오픈                 <--미사용
gauceModalCalendarYMD() : GAUCE 달력 모달창 오픈       <--미사용
showModalCalendarYMD()  : 달력 모달창을 오픈한다       <--미사용
showModalCalendarYM()   : 월달력 모달창을 오픈한다      <--미사용 

commonPop()             : 공통팝업을 구현하기 위한 함수  <--수정중
commonPopOnlyCd()       : 공통팝업을 구현하기 위한 함수  <--수정중
commonPopToGrid()       : 공통팝업을 구현하기 위한 함수  <--수정중
setNmWithoutPop()       : 코드를 입력하며 명을 가지고 오는 기능을 위한 함수

====================popup_mss.js===============================
// 추가 되는 함수 명을 기술하세요


====================popup_mss.js===============================


☞-------------------POPOP  ---------------------------------
getPostPop()            : 우편번호 팝업 [공통]


====================popup_mss.js===============================
// 추가되는 팝업 함수명을 기술하세요
eventPop()				: 점코드 기준으로 종료되지 않은 행사 코드를 조회
getSkuPop()				: 품번을 기준으로 SKU 조회 팝업
getEvtVenPop()          : 사은행사 및 상품권 협력사 팝업
getEvtVenNonPop() 		: 사은행사 및 상품권 협력사 코드/명 가져오기
getGiftAmtPop()         : 금종코드/명 Popup
getGiftAmtNonPop()      : 금종코드/명 가져오기
getEvtTrgPop()          : 대상범위코드/명 Popup
getEvtTrgNonPop()       : 대상범위코드/명 가져오기
getEvtSkuPop()          : 사은품코드/명 Popup
getEvtSkuNonPop()       : 사은품코드/명 가져오기
getGiftTypePop()        : 상품권종류/명 Popup
getGiftTypeNonPop()     : 상품권종류/명 가져오기
getGiftVenPop()         : 제휴협력사코드/명 Popup
getGiftVenNonPop()      : 제휴협력사코드/명 가져오기
getCardComPop()         : 카드사코드/명 Popup
getCardComNonPop()      : 카드사코드/명 가져오기
getCampainPop()         : 캠패인코드/명 Popup
getCampainNonPop()      : 캠패인코드/명 가져오기
getUserPop()            : 사원번호/명 Popup
getUserNonPop()         : 사원번호/명 가져오기
getMssEvtVenPop()       : 상품권 협력사 팝업 (협력사 마스터와 left join)
getMssEvtVenNonPop() 	: 상품권 협력사 코드/명 가져오기  (협력사 마스터와 left join)
getBizPop()             : 실적항목코드/명 Popup
getBizNonPop()          : 실적항목코드/명 가져오기
getBizPopGrid()         : 실적항목코드/명 Popup - 그리드용
getBizNonPopGrid()      : 실적항목코드/명 가져오기 - 그리드용
getAccPop()             : 계정/예산항목코드/명 Popup
getAccNonPop()          : 계정/예산항목코드/명 가져오기
====================popup_mss.js===============================

☞-------------------non-POPOP  ---------------------------------
getEtcCode()            : 공통코드를 가지고 오는 함수 [공통] <-- 20100125 워크샵 후 활성화시킴
setUserNmWithoutPop()   : 사용자명을 가지고 오는 함수 [공통]

====================popup_mss.js===============================
// 추가되는 non_popup 함수명을 기술하세요.
getComboCd()			: 물품 입고/반품 등록시 행사코드별 협력사/품번 가지고 오는 함수 [경영지원]
setEvtNmWithoutPop()    : 이벤트 명 셋팅 하는 함수
getGiftCombo()    		: 상품권종류 및 금종 콤보 [경영지원]
====================popup_mss.js===============================
*/



/** 
* getComboCd()
* 작 성 자 : 김성미
* 작 성 일 : 2010-01-25
* 개    요 : 협력사 콤보
* 사용방법 : getComboVenCd(strDataSet, strEvtCd)
*            arguments[0] -> 콤보 조회 내용이 담길 DATASET
*            arguments[1] -> 콤보 조회를 위한 조회 조건(필수)
*			 arguments[2] -> 조회할 쿼리 명
* 실행  예) getComboCd("DS_O_VEN_CD", "20100101001");
*
* return값 : void
*/

function getComboCd(strDataSet, strCondiCd, strSvcId, strStrCd) {
	
		var strParams = "&strCondiCd="+encodeURIComponent(strCondiCd)
					  + "&strSvcId="+encodeURIComponent(strSvcId)
					  + "&strDataSet="+encodeURIComponent(strDataSet)
					  + "&strStrCd="+encodeURIComponent(strStrCd);
	    TR_MAIN.Action	= "/pot/ccom200.cc?goTo=getComboCd"+strParams;
	    TR_MAIN.KeyValue= "SERVLET(O:"+strDataSet+"="+strDataSet+")";
	    TR_MAIN.Post();
}


/** 
* eventPop()
* 작 성 자 : 김성미
* 작 성 일 : 2010-01-25
* 개    요 : 행사조회 Popup
* 사용방법 : eventPop(serviceId, objCd, objNm, objSDt, objEDt, strFlg)
*            arguments[0] -> [ccom210_service.xml] 에 정의한 QUERY의 ID   예) "SEL_USR_MST"
*            arguments[1] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[2] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[3] -> 팝업 그리드 더블클릭시 시작일자를  받아올 EMEDIT ID
*            arguments[4] -> 팝업 그리드 더블클릭시 종료일자를  받아올 EMEDIT ID
*            arguments[5] -> 시작, 종료일자 리턴 여부
*            arguments[m] -> 추가 조건 
*
* 실행  예) eventPop("SEL_EVENT_MST", EM_EVENT_CD, EM_EVENT_NM EM_EVENT_S_DT, EM_EVENT_E_DT, "Y");
*
* return값 : void
*/
function mssEventPop(serviceId, objCd, objNm, objSDt, objEDt, strFlg, strStr)
{
	var strWidth  = "330px;";//시작,종료일 리턴 여부에 따른 POPUP싸이즈 조절
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 7, arguments );
	var strCode = "";
	var strName = "";
	
	if (typeof(objCd) == "object" ) {
		strCode = objCd.Text;
		strName = objNm.Text;
		if (strName.length < 1) {
			objCd.Text = ""; 
			objNm.Text = "";
		}
	} else {
		strCode = objCd;
	}
	
	arrArg.push(rtnMap);
	arrArg.push(serviceId);
	arrArg.push(strCode);
	arrArg.push(strStr);
	arrArg.push(addCondition);
	arrArg.push(strFlg);
	
	if(strFlg == "Y" && strName.length < 1){
		objSDt.Text = "";
		objEDt.Text = "";
	}
	strWidth  	= "350px;";
    var returnVal = window.showModalDialog("/pot/ccom210.cc?goTo=pop",
                                           arrArg,
                                           "dialogWidth:"+strWidth+"dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
  	if (returnVal){
		var map = arrArg[0];
		objCd.Text = map.get("EVENT_CD");
		objNm.Text = map.get("EVENT_NM");
		if(strFlg == "Y"){
			objSDt.Text = map.get("EVENT_S_DT");
			objEDt.Text = map.get("EVENT_E_DT");
		}
 	}
}


/**
* setMssEvtNmWithoutPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-01-26
* 개    요 : 팝업 없이 행사코드 입력후  키업 이벤트시 행사명 셋팅 
* 사용방법 : setMssEvtNmWithoutPop(strDataSet, strTitle, serviceId, objCd, objNm, searchTp)
*            arguments[0] -> Output용 dataset 문자  	예)"DS_O_RESULT"
*            arguments[1] -> 코드를 받아올 EMEDIT ID
*            arguments[2] -> 이름을 받아올 EMEDIT ID
*            arguments[3] -> 행사시작일을 받아올 EMEDIT ID
*            arguments[4] -> 행사종료일을 받아올 EMEDIT ID
*            arguments[5] -> 행사일자 셋팅 여부 (Y OR N)
*
* 실행 예) setEvtNmWithoutPop('DS_O_RESULT', '담당자', 'SEL_USR_MST', EM_CORP_NO, EM_REP_NAME);
*
* return값 : void
*/
function setMssEvtNmWithoutPop(strDataSet, serviceId, objCd, objNm, objSDt, objEDt, strFlg, strStrCd){
	var strCode = "";
	var strName = "";
	if (typeof(objCd) == "object" ) {
		objNm.Text = "";
		if(trim(objCd.Text) == ""){
			return;
		} 
		strCode = objCd.Text;
		strName = objNm.Text;
	} else {
		if(trim(objCd) == ""){
			return;
		}
		strCode = objCd;
	}
	
	var addCondition = setAddCondition( 7, arguments );
	var dataSetId = eval(strDataSet);
	var codeCd = objCd.Text;
	var cdSize = objCd.Format.length;
	DS_I_CONDITION.setDataHeader( 'SERVICE_ID:STRING(50),CODE_CD:STRING(60),ADD_CONDITION:STRING(100)' );
	
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "SERVICE_ID") 		= serviceId;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "CODE_CD")    		= codeCd;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION")   = addCondition;
	
	TR_MAIN.Action	 = "/pot/ccom210.cc?goTo=getOneWithoutPop";
	TR_MAIN.KeyValue = "SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
	TR_MAIN.Post();
	return dataSetId;
}

/** 
* getSkuPop()
* 작 성 자 : 김성미
* 작 성 일 : 2010-01-25
* 개    요 : 행사조회 Popup
* 사용방법 : eventPop(serviceId, strDataSet, strFlg, strSkuGb)
*            arguments[0] -> [ccom220_service.xml] 에 정의한 QUERY의 ID   예) "SEL_USR_MST"
*            arguments[1] -> 데이터셋 명
*            arguments[2] -> 호출 화면 ID
*            arguments[m] -> 추가 조건 
*
* 실행  예) getSkuPop("SEL_EVENT_MST", "DS_I_SKU" "MCAE301");
*
* return값 : void
*/
function getSkuPop(serviceId){
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 1, arguments );
	var arrCondi = new Array();
	arrCondi = addCondition.split("#G#");
	arrArg.push(rtnMap);
	arrArg.push(serviceId);
	arrArg.push(arrCondi[0]); 		// 점코드
	arrArg.push("");		  		// 품번코드
	arrArg.push(arrCondi[1]);		// 사은품 구분
	arrArg.push(arrCondi[2]);		// 이벤트 코드
	
	var returnVal = window.showModalDialog("/pot/ccom220.cc?goTo=pop",
                                           arrArg,
                                           "dialogWidth:450px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
  	if (returnVal){
		var map = arrArg[0];
		return map;
 	}
}

/** 
* getEvtVenPop()
* 작 성 자 : 김유완
* 작 성 일 : 2010-02-21
* 개    요 : 가맹점코드/명 Popup
* 사용방법 : getEvtVenPop( objCd, objNm, gbnMulti)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 멀티입력(M:멀티,S:단일)
*            arguments[3] -> 점코드
*            arguments[4] -> 협력사 구분 (01: 카드 협력사, 02: 일반협력사 ,  '': 통합)
*            //--추가조건--
*            arguments[5] -> 점코드
*            arguments[n] -> 추가
*
* 실행  예) 
* 		   getEntVenPop( EM_CODE, EM_NAME, "M" );
* 추가조건   getEntVenPop( EM_CODE, EM_NAME, "M", LC_STR_CD.BindColVal );
*
* return값 : 코드/명
*/
function getEvtVenPop( objCd, objNm, gbnMulti, strStrCd, strVenFlag)
{
	var rtnArray = new Array();
    var arrArg   = new Array();
	var addCondition = setAddCondition( 5, arguments );
	
	var strCode = "";
	var strName = "";
	if (gbnMulti == "M" ) {
		strCode = objCd;
		strName = objNm;
	} else {
		if (typeof(objCd) == "object" ) {
			strCode = objCd.Text;
			strName = objNm.Text;
			//[Fix : 2010.04.11] 명을 기준 으로 올바른코드값 체크
			if (strName.length < 1) {
				objCd.Text = ""; 
				objNm.Text = "";
			}
		} else {
			strCode = objCd;
			strName = objNm;
		}
	}
    arrArg.push(rtnArray);
	arrArg.push(strCode);
	arrArg.push('');//[Fix : 2010.04.11] 명은 조회조건에서 제외 arrArg.push(strName);
	arrArg.push(gbnMulti);
	arrArg.push(strStrCd);
	arrArg.push(strVenFlag);
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom201.cc?goTo=callPopup",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
  	if (returnVal){
  		if (gbnMulti == "M") {
  			var rt = arrArg[0];
  			return rt;
  		} else {
  			var rt = arrArg[0][0];
  			objCd.Text = rt.CODE;
  			objNm.Text = rt.NAME;
  			return rt;
  		}
 	}
}

/**
* getEvtVenNonPop()
* 작 성 자 : 김유완
* 작 성 일 : 2010-02-16
* 개    요 : 가맹점코드/명 가져오기
* 사용방법 : getEvtVenNonPop( strDataSet, objCd, objNm, authGb, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 사용위치 : "E":EMEDIT, "G":GRID
*            arguments[4] -> POP호출여부 : "Y":팝업호출, "N":팝업호출하지않음)
*            arguments[5] -> 점코드
*            arguments[6] -> 협력사 구분 (01: 카드 협력사, 02: 일반협력사 ,  '': 통합)
*            //--추가조건--
*            arguments[n] -> 추가
*
* 실행  예) getEvtVenNonPop("DS_O_RESULT", EM_S_BUYER_CD, EM_S_BUYER_CD, "E" , "Y");
*
* return값 : 코드/명
*/
function getEvtVenNonPop( strDataSet, objCd, objNm, mgGb, searchTp, strStrCd, strVenFlag){
	
	if (typeof(objCd) == "object" ) {
		objNm.Text = "";//[Fix : 2010.04.11]코드기준검색
		if(trim(objCd.Text) == ""){
			return;
		} 
		strCode = objCd.Text;
		strName = objNm.Text;
	} else {
		if(trim(objCd) == ""){
			return;
		}
		strCode = objCd;
		strName = objNm;
	}
	
	var addCondition = setAddCondition( 7, arguments );
	var dataSetId = eval(strDataSet);
	
	DS_I_CONDITION.setDataHeader  ('CODE:STRING(20),NAME:STRING(40),STR_CD:STRING(2),VEN_FLAG:STRING(02),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "CODE") = strCode; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "NAME") = strName; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "STR_CD") = strStrCd;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "VEN_FLAG")= strVenFlag;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

	TR_MAIN.Action="/pot/ccom201.cc?goTo=getDate";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post(); 
    
    if (dataSetId.CountRow == 1) {
    	if (mgGb == "E") {
			objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "CODE");
			objNm.text = dataSetId.NameValue(dataSetId.RowPosition, "NAME");	
    	} 
    	return dataSetId;
	}else{
		if(searchTp == "Y"){
	    	if (mgGb == "E") {
	    		return getEvtVenPop( objCd, objNm, "S" , strStrCd, strVenFlag,  addCondition);
	    	} else {
	    		return getEvtVenPop( objCd, objNm, "M" , strStrCd, strVenFlag , addCondition);
	    	}
		} else {
			return dataSetId;
		}
	}
}

/** 
* getGiftAmtPop()
* 작 성 자 : 김유완
* 작 성 일 : 2010-02-21
* 개    요 : 금종코드/명 Popup
* 사용방법 : getEvtVenPop( objCd, objNm, gbnMulti)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 멀티입력(M:멀티,S:단일)
*            arguments[3] -> 상품권종류
*            arguments[4] -> 발행형태
*            //--추가조건--
*            arguments[n] -> 추가
*
* 실행  예) 
* 		   getGiftAmtPop( EM_CODE, EM_NAME, "M" );
* 추가조건   getGiftAmtPop( EM_CODE, EM_NAME, "M", EM_GIFT_TYPE_CD.Text, ISSUE_TYPE.Text);
*
* return값 : 코드/명
*/
function getGiftAmtPop( objCd, objNm, gbnMulti, strGiftType, strIssue)
{
	var rtnArray = new Array();
    var arrArg   = new Array();
	var addCondition = setAddCondition( 5, arguments );
	
	var strCode = "";
	var strName = "";
	if (gbnMulti == "M" ) {
		strCode = objCd;
		strName = objNm;
	} else {
		if (typeof(objCd) == "object" ) {
			strCode = objCd.Text;
			strName = objNm.Text;
			//[Fix : 2010.04.11] 명을 기준 으로 올바른코드값 체크
			if (strName.length < 1) {
				objCd.Text = ""; 
				objNm.Text = "";
			}
		} else {
			strCode = objCd;
			strName = objNm;
		}
	}

    arrArg.push(rtnArray);
	arrArg.push(strCode);
	arrArg.push('');//[Fix : 2010.04.11] 명은 조회조건에서 제외 arrArg.push(strName);
	arrArg.push(strGiftType);
	arrArg.push(strIssue);
	arrArg.push(gbnMulti);
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom202.cc?goTo=callPopup",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
  	if (returnVal){
  		if (gbnMulti == "M") {
  			var rt = arrArg[0];
  			return rt;
  		} else {
  			var rt = arrArg[0][0];
  			objCd.Text = rt.CODE;
  			objNm.Text = rt.NAME;
  			return rt;
  		}
 	}
}

/**
* getGiftAmtNonPop()
* 작 성 자 : 김유완
* 작 성 일 : 2010-02-16
* 개    요 : 금종코드/명 가져오기
* 사용방법 : getGiftAmtNonPop( strDataSet, objCd, objNm, authGb, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 사용위치 : "E":EMEDIT, "G":GRID
*            arguments[4] -> POP호출여부 : "Y":팝업호출, "N":팝업호출하지않음)
*            //--추가조건--
*            arguments[3] -> 점코드
*            arguments[n] -> 추가
*
* 실행  예) getGiftAmtNonPop("DS_O_RESULT", EM_S_BUYER_CD, EM_S_BUYER_CD, "E" , "Y", EM_GIFT_TYPE_CD.Text, ISSUE_TYPE.Text);
*
* return값 : 코드/명
*/
function getGiftAmtNonPop( strDataSet, objCd, objNm, mgGb, searchTp, strGiftType, strIssue){
	if (typeof(objCd) == "object" ) {
		objNm.Text = "";//[Fix : 2010.04.11]코드기준검색
		if(trim(objCd.Text) == ""){
			return;
		} 
		strCode = objCd.Text;
		strName = objNm.Text;
	} else {
		if(trim(objCd) == ""){
			return;
		}
		strCode = objCd;
		strName = objNm;
	}
	
	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);
	
	DS_I_CONDITION.setDataHeader  ('CODE:STRING(20),NAME:STRING(40),GTYPE:STRING(4),ISSUE:STRING(1),MGBN:STRING(2),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "CODE") = strCode; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "NAME") = strName; 
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "GTYPE") = strGiftType; 
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ISSUE") = strIssue; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "MGBN") = mgGb;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

	TR_MAIN.Action="/pot/ccom202.cc?goTo=getDate";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post(); 
    
    if (dataSetId.CountRow == 1) {
    	if (mgGb == "E") {
			objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "CODE");
			objNm.text = dataSetId.NameValue(dataSetId.RowPosition, "NAME");	
    	} 
    	return dataSetId;
	}else{
		if(searchTp == "Y"){
	    	if (mgGb == "E") {
	    		return getGiftAmtPop( objCd, objNm, "S" );
	    	} else {
	    		return getGiftAmtPop( objCd, objNm, "M" );
	    	}
		} else {
			return dataSetId;
		}
	}
}

/** 
* getEvtTrgPop()
* 작 성 자 : 김유완
* 작 성 일 : 2010-02-21
* 개    요 : 대상범위코드/명 Popup
* 사용방법 : getEvtTrgPop( objCd, objNm, gbnMulti)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 멀티입력(M:멀티,S:단일)
*            //--추가조건--
*            arguments[3] -> 점코드
*            arguments[n] -> 추가
*
* 실행  예) 
* 		   getEvtTrgPop( EM_CODE, EM_NAME, "M" );
* 추가조건   getEvtTrgPop( EM_CODE, EM_NAME, "M", LC_STR_CD.BindColVal );
*
* return값 : 코드/명
*            대상범위(From) : TRG_F
*            대상범위(To)   : TRG_T
*/
function getEvtTrgPop( objCd, objNm, gbnMulti )
{
	var rtnArray = new Array();
    var arrArg   = new Array();
	var addCondition = setAddCondition( 3, arguments );
	
	var strCode = "";
	var strName = "";
	if (gbnMulti == "M" ) {
		strCode = objCd;
		strName = objNm;
	} else {
		if (typeof(objCd) == "object" ) {
			strCode = objCd.Text;
			strName = objNm.Text;
			//[Fix : 2010.04.11] 명을 기준 으로 올바른코드값 체크
			if (strName.length < 1) {
				objCd.Text = ""; 
				objNm.Text = "";
			}
		} else {
			strCode = objCd;
			strName = objNm;
		}
	}

    arrArg.push(rtnArray);
	arrArg.push(strCode);
	arrArg.push('');//[Fix : 2010.04.11] 명은 조회조건에서 제외 arrArg.push(strName);
	arrArg.push(gbnMulti);
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom203.cc?goTo=callPopup",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
  	if (returnVal){
  		if (gbnMulti == "M") {
  			var rt = arrArg[0];
  			return rt;
  		} else {
  			var rt = arrArg[0][0];
  			objCd.Text = rt.CODE;
  			objNm.Text = rt.NAME;
  			return rt;
  		}
 	}
}


/**
* getEvtTrgNonPop()
* 작 성 자 : 김유완
* 작 성 일 : 2010-02-16
* 개    요 : 대상범위코드/명 가져오기
* 사용방법 : getEvtTrgNonPop( strDataSet, objCd, objNm, authGb, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 사용위치 : "E":EMEDIT, "G":GRID
*            arguments[4] -> POP호출여부 : "Y":팝업호출, "N":팝업호출하지않음)
*            //--추가조건--
*            arguments[3] -> 점코드
*            arguments[n] -> 추가
*
* 실행  예) getEvtTrgNonPop("DS_O_RESULT", EM_S_BUYER_CD, EM_S_BUYER_CD, "E" , "Y");
*
* return값 : 코드/명
*/
function getEvtTrgNonPop( strDataSet, objCd, objNm, mgGb, searchTp){
	if (typeof(objCd) == "object" ) {
		objNm.Text = "";//[Fix : 2010.04.11]코드기준검색
		if(trim(objCd.Text) == ""){
			return;
		} 
		strCode = objCd.Text;
		strName = objNm.Text;
	} else {
		if(trim(objCd) == ""){
			return;
		}
		strCode = objCd;
		strName = objNm;
	}
	
	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);
	
	DS_I_CONDITION.setDataHeader  ('CODE:STRING(20),NAME:STRING(40),MGBN:STRING(2),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "CODE") = strCode; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "NAME") = strName; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "MGBN") = mgGb;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

	TR_MAIN.Action="/pot/ccom203.cc?goTo=getDate";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post(); 
    
    if (dataSetId.CountRow == 1) {
    	if (mgGb == "E") {
			objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "CODE");
			objNm.text = dataSetId.NameValue(dataSetId.RowPosition, "NAME");	
    	} 
    	return dataSetId;
	}else{
		if(searchTp == "Y"){
	    	if (mgGb == "E") {
	    		return getEvtTrgPop( objCd, objNm, "S" );
	    	} else {
	    		return getEvtTrgPop( objCd, objNm, "M" );
	    	}
		} else {
			return dataSetId;
		}
	}
}


/** 
* getEvtSkuPop()
* 작 성 자 : 김유완
* 작 성 일 : 2010-02-21
* 개    요 : 사은품코드/명 Popup
* 사용방법 : getEvtSkuPop( objCd, objNm, gbnMulti)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 멀티입력(M:멀티,S:단일)
*            //--추가조건--
*            arguments[3] -> 점코드
*            arguments[4] -> 품번코드
*            arguments[5] -> 협력사코드
*            arguments[n] -> 추가
*
* 실행  예) 
* 		   getEvtSkuPop( EM_CODE, EM_NAME, "M" );
* 추가조건   getEvtSkuPop( EM_CODE, EM_NAME, "M", LC_STR_CD.BindColVal, EM_PUMBUN_CD.Text, EM_VEN_CD.Text );
*
* return값 : 코드/명
*/
function getEvtSkuPop( objCd, objNm, gbnMulti )
{
	var rtnArray = new Array();
    var arrArg   = new Array();
	var addCondition = setAddCondition( 3, arguments );
	
	var strCode = "";
	var strName = "";
	if (gbnMulti == "M" ) {
		strCode = objCd;
		strName = objNm;
	} else {
		if (typeof(objCd) == "object" ) {
			strCode = objCd.Text;
			strName = objNm.Text;
			//[Fix : 2010.04.11] 명을 기준 으로 올바른코드값 체크
			if (strName.length < 1) {
				objCd.Text = ""; 
				objNm.Text = "";
			}
		} else {
			strCode = objCd;
			strName = objNm;
		}
	}

    arrArg.push(rtnArray);
	arrArg.push(strCode);
	arrArg.push('');//[Fix : 2010.04.11] 명은 조회조건에서 제외 arrArg.push(strName);
	arrArg.push(gbnMulti);
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom204.cc?goTo=callPopup",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
  	if (returnVal){
  		if (gbnMulti == "M") {
  			var rt = arrArg[0];
  			return rt;
  		} else {
  			var rt = arrArg[0][0];
  			objCd.Text = rt.CODE;
  			objNm.Text = rt.NAME;
  			return rt;
  		}
 	}
}

/**
* getEvtSkuNonPop()
* 작 성 자 : 김유완
* 작 성 일 : 2010-02-16
* 개    요 : 사은품코드/명 가져오기
* 사용방법 : getEvtSkuNonPop( strDataSet, objCd, objNm, authGb, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 사용위치 : "E":EMEDIT, "G":GRID
*            arguments[4] -> POP호출여부 : "Y":팝업호출, "N":팝업호출하지않음)
*            //--추가조건--
*            arguments[3] -> 점코드
*            arguments[n] -> 추가
*
* 실행  예) getEvtSkuNonPop("DS_O_RESULT", EM_S_BUYER_CD, EM_S_BUYER_CD, "E" , "Y");
*
* return값 : 코드/명
*/
function getEvtSkuNonPop( strDataSet, objCd, objNm, mgGb, searchTp){
	if (typeof(objCd) == "object" ) {
		objNm.Text = "";//[Fix : 2010.04.11]코드기준검색
		if(trim(objCd.Text) == ""){
			return;
		} 
		strCode = objCd.Text;
		strName = objNm.Text;
	} else {
		if(trim(objCd) == ""){
			return;
		}
		strCode = objCd;
		strName = objNm;
	}
	
	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);
	
	DS_I_CONDITION.setDataHeader  ('CODE:STRING(20),NAME:STRING(40),MGBN:STRING(2),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "CODE") = strCode; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "NAME") = strName; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "MGBN") = mgGb;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

	TR_MAIN.Action="/pot/ccom204.cc?goTo=getDate";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post(); 
    
    if (dataSetId.CountRow == 1) {
    	if (mgGb == "E") {
			objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "CODE");
			objNm.text = dataSetId.NameValue(dataSetId.RowPosition, "NAME");	
    	} 
    	return dataSetId;
	}else{
		if(searchTp == "Y"){
	    	if (mgGb == "E") {
	    		return getEvtSkuPop( objCd, objNm, "S" );
	    	} else {
	    		return getEvtSkuPop( objCd, objNm, "M" );
	    	}
		} else {
			return dataSetId;
		}
	}
}

/** 
 * getGiftTypePop()
 * 작 성 자 : 김유완
 * 작 성 일 : 2010-02-21
 * 개    요 : 상품권종류/명 Popup
 * 사용방법 : getEvtSkuPop( objCd, objNm, gbnMulti)
 *            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
 *            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
 *            arguments[2] -> 멀티입력(M:멀티,S:단일)
 *            //--추가조건--
 *            arguments[n] -> 추가
 *
 * 실행  예) 
 * 		   getGiftTypePop( EM_CODE, EM_NAME, "M" );
 * 추가조건  getGiftTypePop( EM_CODE, EM_NAME, "M");
 *
 * return값 : 코드/명
 */
function getGiftTypePop( objCd, objNm, gbnMulti )
{
	var rtnArray = new Array();
    var arrArg   = new Array();
	var addCondition = setAddCondition( 3, arguments );
	
	var strCode = "";
	var strName = "";
	if (gbnMulti == "M" ) {
		strCode = objCd;
		strName = objNm;
	} else {
		if (typeof(objCd) == "object" ) {
			strCode = objCd.Text;
			strName = objNm.Text;
			//[Fix : 2010.04.11] 명을 기준 으로 올바른코드값 체크
			if (strName.length < 1) {
				objCd.Text = ""; 
				objNm.Text = "";
			}
		} else {
			strCode = objCd;
			strName = objNm;
		}
	}

    arrArg.push(rtnArray);
	arrArg.push(strCode);
	arrArg.push('');//[Fix : 2010.04.11] 명은 조회조건에서 제외 arrArg.push(strName);
	arrArg.push(gbnMulti);
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom205.cc?goTo=callPopup",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
  	if (returnVal){
  		if (gbnMulti == "M") {
  			var rt = arrArg[0];
  			return rt;
  		} else {
  			var rt = arrArg[0][0];
  			objCd.Text = rt.CODE;
  			objNm.Text = rt.NAME;
  			return rt;
  		}
 	}
}

/**
* getGiftTypeNonPop()
* 작 성 자 : 김유완
* 작 성 일 : 2010-02-16
* 개    요 : 상품권종류/명 가져오기
* 사용방법 : getGiftTypeNonPop( strDataSet, objCd, objNm, authGb, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 사용위치 : "E":EMEDIT, "G":GRID
*            arguments[4] -> POP호출여부 : "Y":팝업호출, "N":팝업호출하지않음)
*            //--추가조건--
*            arguments[3] -> 점코드
*            arguments[n] -> 추가
*
* 실행  예) getGiftTypeNonPop("DS_O_RESULT", EM_S_BUYER_CD, EM_S_BUYER_CD, "E" , "Y");
*
* return값 : 코드/명
*/
function getGiftTypeNonPop( strDataSet, objCd, objNm, mgGb, searchTp){
	if (typeof(objCd) == "object" ) {
		objNm.Text = "";//[Fix : 2010.04.11]코드기준검색
		if(trim(objCd.Text) == ""){
			return;
		} 
		strCode = objCd.Text;
		strName = objNm.Text;
	} else {
		if(trim(objCd) == ""){
			return;
		}
		strCode = objCd;
		strName = objNm;
	}
	
	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);
	
	DS_I_CONDITION.setDataHeader  ('CODE:STRING(20),NAME:STRING(40),MGBN:STRING(2),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "CODE") = strCode; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "NAME") = strName; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "MGBN") = mgGb;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

	TR_MAIN.Action="/pot/ccom205.cc?goTo=getDate";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post(); 
    
    if (dataSetId.CountRow == 1) {
    	if (mgGb == "E") {
			objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "CODE");
			objNm.text = dataSetId.NameValue(dataSetId.RowPosition, "NAME");	
    	} 
    	return dataSetId;
	}else{
		if(searchTp == "Y"){
	    	if (mgGb == "E") {
	    		return getGiftTypePop( objCd, objNm, "S" );
	    	} else {
	    		return getGiftTypePop( objCd, objNm, "M" );
	    	}
		} else {
			return dataSetId;
		}
	}
}

/** 
 * getGiftVenPop()
 * 작 성 자 : 김유완
 * 작 성 일 : 2010-02-21
 * 개    요 : 제휴협력사코드/명 Popup
 * 사용방법 : getEvtSkuPop( objCd, objNm, gbnMulti)
 *            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
 *            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
 *            arguments[2] -> 멀티입력(M:멀티,S:단일)
 *            //--추가조건--
 *            arguments[3] -> 점코드
 *            arguments[n] -> 추가
 *
 * 실행  예) 
 * 		   getGiftVenPop( EM_CODE, EM_NAME, "M" );
 * 추가조건  getGiftVenPop( EM_CODE, EM_NAME, "M", LC_STR_CD.BindColVal);
 *
 * return값 : 코드/명
 */
function getGiftVenPop( objCd, objNm, gbnMulti )
{
	var rtnArray = new Array();
    var arrArg   = new Array();
	var addCondition = setAddCondition( 3, arguments );
	
	var strCode = "";
	var strName = "";
	if (gbnMulti == "M" ) {
		strCode = objCd;
		strName = objNm;
	} else {
		if (typeof(objCd) == "object" ) {
			strCode = objCd.Text;
			strName = objNm.Text;
			//[Fix : 2010.04.11] 명을 기준 으로 올바른코드값 체크
			if (strName.length < 1) {
				objCd.Text = ""; 
				objNm.Text = "";
			}
		} else {
			strCode = objCd;
			strName = objNm;
		}
	}

    arrArg.push(rtnArray);
	arrArg.push(strCode);
	arrArg.push('');//[Fix : 2010.04.11] 명은 조회조건에서 제외 arrArg.push(strName);
	arrArg.push(gbnMulti);
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom206.cc?goTo=callPopup",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
  	if (returnVal){
  		if (gbnMulti == "M") {
  			var rt = arrArg[0];
  			return rt;
  		} else {
  			var rt = arrArg[0][0];
  			objCd.Text = rt.CODE;
  			objNm.Text = rt.NAME;
  			return rt;
  		}
 	}
}

/**
* getGiftVenNonPop()
* 작 성 자 : 김유완
* 작 성 일 : 2010-02-16
* 개    요 : 제휴협력사코드/명 가져오기
* 사용방법 : getGiftVenNonPop( strDataSet, objCd, objNm, authGb, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 사용위치 : "E":EMEDIT, "G":GRID
*            arguments[4] -> POP호출여부 : "Y":팝업호출, "N":팝업호출하지않음)
*            //--추가조건--
*            arguments[3] -> 점코드
*            arguments[n] -> 추가
*
* 실행  예) getGiftVenNonPop("DS_O_RESULT", EM_S_BUYER_CD, EM_S_BUYER_CD, "E" , "Y");
*
* return값 : 코드/명
*/
function getGiftVenNonPop( strDataSet, objCd, objNm, mgGb, searchTp){
	if (typeof(objCd) == "object" ) {
		objNm.Text = "";//[Fix : 2010.04.11]코드기준검색
		if(trim(objCd.Text) == ""){
			return;
		} 
		strCode = objCd.Text;
		strName = objNm.Text;
	} else {
		if(trim(objCd) == ""){
			return;
		}
		strCode = objCd;
		strName = objNm;
	}
	
	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);
	
	DS_I_CONDITION.setDataHeader  ('CODE:STRING(20),NAME:STRING(40),MGBN:STRING(2),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "CODE") = strCode; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "NAME") = strName; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "MGBN") = mgGb;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

	TR_MAIN.Action="/pot/ccom206.cc?goTo=getDate";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post(); 
    
    if (dataSetId.CountRow == 1) {
    	if (mgGb == "E") {
			objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "CODE");
			objNm.text = dataSetId.NameValue(dataSetId.RowPosition, "NAME");	
    	} 
    	return dataSetId;
	}else{
		if(searchTp == "Y"){
	    	if (mgGb == "E") {
	    		return getGiftVenPop( objCd, objNm, "S" );
	    	} else {
	    		return getGiftVenPop( objCd, objNm, "M" );
	    	}
		} else {
			return dataSetId;
		}
	}
}

/** 
 * getCardComPop()
 * 작 성 자 : 김유완
 * 작 성 일 : 2010-02-21
 * 개    요 : 카드사코드/명 Popup
 * 사용방법 : getCardComPop( objCd, objNm, gbnMulti)
 *            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
 *            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
 *            arguments[2] -> 멀티입력(M:멀티,S:단일)
 *            //--추가조건--
 *            arguments[3] -> 점코드
 *            arguments[4] -> 카드청구사
 *            arguments[n] -> 추가
 *
 * 실행  예) 
 * 		   getCardComPop( EM_CODE, EM_NAME, "M" );
 * 추가조건  getCardComPop( EM_CODE, EM_NAME, "M", LC_STR_CD.BindColVal, EM_CARDC_CD.Text);
 *
 * return값 : 코드/명
 */
function getCardComPop( objCd, objNm, gbnMulti )
{
	var rtnArray = new Array();
    var arrArg   = new Array();
	var addCondition = setAddCondition( 3, arguments );
	
	var strCode = "";
	var strName = "";
	if (gbnMulti == "M" ) {
		strCode = objCd;
		strName = objNm;
	} else {
		if (typeof(objCd) == "object" ) {
			strCode = objCd.Text;
			strName = objNm.Text;
			//[Fix : 2010.04.11] 명을 기준 으로 올바른코드값 체크
			if (strName.length < 1) {
				objCd.Text = ""; 
				objNm.Text = "";
			}
		} else {
			strCode = objCd;
			strName = objNm;
		}
	}

    arrArg.push(rtnArray);
	arrArg.push(strCode);
	arrArg.push('');//[Fix : 2010.04.11] 명은 조회조건에서 제외 arrArg.push(strName);
	arrArg.push(gbnMulti);
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom207.cc?goTo=callPopup",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
  	if (returnVal){
  		if (gbnMulti == "M") {
  			var rt = arrArg[0];
  			return rt;
  		} else {
  			var rt = arrArg[0][0];
  			objCd.Text = rt.CODE;
  			objNm.Text = rt.NAME;
  			return rt;
  		}
 	}
}

/**
* getCardComNonPop()
* 작 성 자 : 김유완
* 작 성 일 : 2010-02-16
* 개    요 : 카드사코드/명 가져오기
* 사용방법 : getCardComNonPop( strDataSet, objCd, objNm, authGb, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 사용위치 : "E":EMEDIT, "G":GRID
*            arguments[4] -> POP호출여부 : "Y":팝업호출, "N":팝업호출하지않음)
*            //--추가조건--
*            arguments[3] -> 점코드
*            arguments[n] -> 추가
*
* 실행  예) getCardComNonPop("DS_O_RESULT", EM_S_BUYER_CD, EM_S_BUYER_CD, "E" , "Y");
*
* return값 : 코드/명
*/
function getCardComNonPop( strDataSet, objCd, objNm, mgGb, searchTp){
	if (typeof(objCd) == "object" ) {
		objNm.Text = "";//[Fix : 2010.04.11]코드기준검색
		if(trim(objCd.Text) == ""){
			return;
		} 
		strCode = objCd.Text;
		strName = objNm.Text;
	} else {
		if(trim(objCd) == ""){
			return;
		}
		strCode = objCd;
		strName = objNm;
	}
	
	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);
	
	DS_I_CONDITION.setDataHeader  ('CODE:STRING(20),NAME:STRING(40),MGBN:STRING(2),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "CODE") = strCode; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "NAME") = strName; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "MGBN") = mgGb;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

	TR_MAIN.Action="/pot/ccom207.cc?goTo=getDate";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post(); 
    
    if (dataSetId.CountRow == 1) {
    	if (mgGb == "E") {
			objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "CODE");
			objNm.text = dataSetId.NameValue(dataSetId.RowPosition, "NAME");	
    	} 
    	return dataSetId;
	}else{
		if(searchTp == "Y"){
	    	if (mgGb == "E") {
	    		return getCardComPop( objCd, objNm, "S" );
	    	} else {
	    		return getCardComPop( objCd, objNm, "M" );
	    	}
		} else {
			return dataSetId;
		}
	}
}

/** 
 * getCampainPop()
 * 작 성 자 : 김유완
 * 작 성 일 : 2010-02-21
 * 개    요 : 캠패인코드/명 Popup
 * 사용방법 : getCampainPop( objCd, objNm, gbnMulti)
 *            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
 *            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
 *            arguments[2] -> 멀티입력(M:멀티,S:단일)
 *            //--추가조건--
 *            arguments[3] -> 점코드
 *            arguments[4] -> 캠패인구분
 *            arguments[n] -> 추가
 *
 * 실행  예) 
 * 		   getCampainPop( EM_CODE, EM_NAME, "M" );
 * 추가조건  getCampainPop( EM_CODE, EM_NAME, "M", LC_STR_CD.BindColVal, EM_COMP_TYPE.Text);
 *
 * return값 : 코드/명
 */
function getCampainPop( objCd, objNm, gbnMulti )
{
	var rtnArray = new Array();
    var arrArg   = new Array();
	var addCondition = setAddCondition( 3, arguments );
	
	var strCode = "";
	var strName = "";
	if (gbnMulti == "M" ) {
		strCode = objCd;
		strName = objNm;
	} else {
		if (typeof(objCd) == "object" ) {
			strCode = objCd.Text;
			strName = objNm.Text;
			//[Fix : 2010.04.11] 명을 기준 으로 올바른코드값 체크
			if (strName.length < 1) {
				objCd.Text = ""; 
				objNm.Text = "";
			}
		} else {
			strCode = objCd;
			strName = objNm;
		}
	}

    arrArg.push(rtnArray);
	arrArg.push(strCode);
	arrArg.push('');//[Fix : 2010.04.11] 명은 조회조건에서 제외 arrArg.push(strName);
	arrArg.push(gbnMulti);
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom208.cc?goTo=callPopup",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
  	if (returnVal){
  		if (gbnMulti == "M") {
  			var rt = arrArg[0];
  			return rt;
  		} else {
  			var rt = arrArg[0][0];
  			objCd.Text = rt.CODE;
  			objNm.Text = rt.NAME;
  			return rt;
  		}
 	}
}

/**
* getCampainNonPop()
* 작 성 자 : 김유완
* 작 성 일 : 2010-02-16
* 개    요 : 캠패인코드/명 가져오기
* 사용방법 : getCampainNonPop( strDataSet, objCd, objNm, authGb, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 사용위치 : "E":EMEDIT, "G":GRID
*            arguments[4] -> POP호출여부 : "Y":팝업호출, "N":팝업호출하지않음)
*            //--추가조건--
*            arguments[5] -> 점코드
*            arguments[n] -> 추가
*
* 실행  예) getCampainNonPop("DS_O_RESULT", EM_S_BUYER_CD, EM_S_BUYER_CD, "E" , "Y");
*
* return값 : 코드/명
*/
function getCampainNonPop( strDataSet, objCd, objNm, mgGb, searchTp){
	if (typeof(objCd) == "object" ) {
		objNm.Text = "";//[Fix : 2010.04.11]코드기준검색
		if(trim(objCd.Text) == ""){
			return;
		} 
		strCode = objCd.Text;
		strName = objNm.Text;
	} else {
		if(trim(objCd) == ""){
			return;
		}
		strCode = objCd;
		strName = objNm;
	}
	
	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);
	
	DS_I_CONDITION.setDataHeader  ('CODE:STRING(20),NAME:STRING(40),MGBN:STRING(2),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "CODE") = strCode; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "NAME") = strName; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "MGBN") = mgGb;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

	TR_MAIN.Action="/pot/ccom208.cc?goTo=getDate";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post(); 
    
    if (dataSetId.CountRow == 1) {
    	if (mgGb == "E") {
			objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "CODE");
			objNm.text = dataSetId.NameValue(dataSetId.RowPosition, "NAME");	
    	} 
    	return dataSetId;
	}else{
		if(searchTp == "Y"){
	    	if (mgGb == "E") {
	    		return getCampainPop( objCd, objNm, "S" );
	    	} else {
	    		return getCampainPop( objCd, objNm, "M" );
	    	}
		} else {
			return dataSetId;
		}
	}
}

/** 
 * getUserPop()
 * 작 성 자 : 김유완
 * 작 성 일 : 2010-02-21
 * 개    요 : 사원번호/명 Popup
 * 사용방법 : getCampainPop( objCd, objNm, gbnMulti)
 *            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
 *            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
 *            arguments[2] -> 멀티입력(M:멀티,S:단일)
 *            //--추가조건--
 *            arguments[3] -> 조직코드
 *            arguments[n] -> 추가
 *
 * 실행  예) 
 * 		   getUserPop( EM_CODE, EM_NAME, "M" );
 * 추가조건  getUserPop( EM_CODE, EM_NAME, "M", EM_ORG_CD.Text);
 *
 * return값 : 코드/명
 */
function getUserPop( objCd, objNm, gbnMulti )
{
	var rtnArray = new Array();
    var arrArg   = new Array();
	var addCondition = setAddCondition( 3, arguments );
	
	var strCode = "";
	var strName = "";
	if (gbnMulti == "M" ) {
		strCode = objCd;
		strName = objNm;
	} else {
		if (typeof(objCd) == "object" ) {
			strCode = objCd.Text;
			strName = objNm.Text;
			//[Fix : 2010.04.11] 명을 기준 으로 올바른코드값 체크
			if (strName.length < 1) {
				objCd.Text = ""; 
				objNm.Text = "";
			}
		} else {
			strCode = objCd;
			strName = objNm;
		}
	}

    arrArg.push(rtnArray);
	arrArg.push(strCode);
	arrArg.push('');//[Fix : 2010.04.11] 명은 조회조건에서 제외 arrArg.push(strName);
	arrArg.push(gbnMulti);
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom209.cc?goTo=callPopup",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
  	if (returnVal){
  		if (gbnMulti == "M") {
  			var rt = arrArg[0];
  			return rt;
  		} else {
  			var rt = arrArg[0][0];
  			objCd.Text = rt.CODE;
  			objNm.Text = rt.NAME;
  			return rt;
  		}
 	}
}

/**
* getUserNonPop()
* 작 성 자 : 김유완
* 작 성 일 : 2010-02-16
* 개    요 : 사원번호/명 가져오기
* 사용방법 : getUserNonPop( strDataSet, objCd, objNm, authGb, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 사용위치 : "E":EMEDIT, "G":GRID
*            arguments[4] -> POP호출여부 : "Y":팝업호출, "N":팝업호출하지않음)
*            //--추가조건--
*            arguments[3] -> 점코드
*            arguments[n] -> 추가
*
* 실행  예) getUserNonPop("DS_O_RESULT", EM_S_BUYER_CD, EM_S_BUYER_CD, "E" , "Y");
*
* return값 : 코드/명
*/
function getUserNonPop( strDataSet, objCd, objNm, mgGb, searchTp){
	if (typeof(objCd) == "object" ) {
		objNm.Text = "";//[Fix : 2010.04.11]코드기준검색
		if(trim(objCd.Text) == ""){
			return;
		} 
		strCode = objCd.Text;
		strName = objNm.Text;
	} else {
		if(trim(objCd) == ""){
			return;
		}
		strCode = objCd;
		strName = objNm;
	}
	
	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);
	
	DS_I_CONDITION.setDataHeader  ('CODE:STRING(20),NAME:STRING(40),MGBN:STRING(2),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "CODE") = strCode; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "NAME") = strName; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "MGBN") = mgGb;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

	TR_MAIN.Action="/pot/ccom209.cc?goTo=getDate";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post(); 
    
    if (dataSetId.CountRow == 1) {
    	if (mgGb == "E") {
			objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "CODE");
			objNm.text = dataSetId.NameValue(dataSetId.RowPosition, "NAME");	
    	} 
    	return dataSetId;
	}else{
		if(searchTp == "Y"){
	    	if (mgGb == "E") {
	    		return getUserPop( objCd, objNm, "S" );
	    	} else {
	    		return getUserPop( objCd, objNm, "M" );
	    	}
		} else {
			return dataSetId;
		}
	}
}

/**                                                                             
 * getGiftCombo()                                                                
 * 작 성 자 : 김성미                                                             
 * 작 성 일 : 2010-03-11                                                         
 * 개    요 : 상품권 관련 공통 콤보 조회                                         
 * 사용방법 : getGiftCombo(strDataSet, strEvtCd)                                 
 *            arguments[0] -> 콤보 조회 내용이 담길 DATASET                      
 *            arguments[1] -> 조회할 콤보 구분 : TP => 상품권 종류 , AMT => 금종 
 *			//--추가조건--                                                           
 *            arguments[3] -> TP: 상품권 종류 구분(미필수) , AMT:상품권종류코드(필수)                                   
 *            arguments[4] -> TP: 지급/수취 구분(미필수) , AMT:발행형태(필수)                                          
 * 상품권 종류 실행  예) getGiftCombo("DS_O_GIFT_TYP_CD", "TP");
 * 금종 종류 실행  예) getGiftCombo("DS_O_GIFT_TYP_CD", "AMT", "0001", "1");                             
 *                                                                               
 * return값 : void                                                               
 */                                                                              
 function getGiftCombo(strDataSet, strFlag) {                                    
 	var addCondition = setAddCondition( 2, arguments );  
 	
 	var strParams = "&strDataSet="+encodeURIComponent(strDataSet)                                          
 				  + "&strFlag="+encodeURIComponent(strFlag)                                                  
 	              + "&addCondition="+encodeURIComponent(addCondition);  
     TR_MAIN.Action	= "/pot/ccom211.cc?goTo=getGiftCombo"+strParams;             
     TR_MAIN.KeyValue= "SERVLET(O:"+strDataSet+"="+strDataSet+")";               
     TR_MAIN.Post();                                                             
 }   
 
 /** 
  * getHomeIdPop()
  * 작 성 자 : 김유완
  * 작 성 일 : 2010-02-21
  * 개    요 : 시설코드 Popup
  * 사용방법 : getCampainPop( objCd, objNm, gbnMulti)
  *            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
  *            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
  *            arguments[2] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
  *            arguments[3] -> 점코드
  *            arguments[4] -> 멀티입력(M:멀티,S:단일)
  *            arguments[5] -> 조회구분(0: 주거세대마스터체크 0, 1: 주거세대마스터체크 )
  *            //--추가조건--
  *            arguments[n] -> 추가
  *
  * 실행  예) 
  * 추가조건  getUserPop( EM_CODE, EM_NAME, "M", EM_ORG_CD.Text);
  *
  * return값 : 코드/명
  */
 function getHomeIdPop( objCd, strName, strName2, strStrCd, strMultiGbn, strSgbn )
 {
	var rtnArray = new Array();
	var arrArg   = new Array();
 	var addCondition = setAddCondition( 6, arguments );
 	
 	var strCode = "";
 	if (strMultiGbn == "M" ) {
 		strCode = objCd;
 	} else {
 		if (typeof(objCd) == "object" ) {
 			strCode = objCd.Text;
 			if (strName.length < 1) {
 	 			objCd.Text = "";
 			}
 		} else {
 			strCode = objCd;
 		}
 	}

	arrArg.push(rtnArray);
 	arrArg.push(strCode);
 	arrArg.push('');//[Fix : 2010.04.11] 명은 조회조건에서 제외 arrArg.push(strName);
 	arrArg.push('');//[Fix : 2010.04.11] 명은 조회조건에서 제외 arrArg.push(strName2);
 	arrArg.push(strStrCd);
 	arrArg.push(strMultiGbn);
 	arrArg.push(strSgbn);
 	arrArg.push(addCondition);

     var returnVal = window.showModalDialog("/pot/ccom212.cc?goTo=callPopup",
                                            arrArg,
                                            "dialogWidth:458px;dialogHeight:395px;scroll:no;" +
                                            "resizable:no;help:no;unadorned:yes;center:yes;status:no");
   	if (returnVal){
   		if (strMultiGbn == "M") {
   			var rt = arrArg[0];
   			return rt;
   		} else {
   			var rt = arrArg[0][0];
   			objCd.Text = rt.HUSE_ID;
   			return rt;
   		}
  	}
 }
 
 /**
 * getHomeIdNonPop()
 * 작 성 자 : 김유완
 * 작 성 일 : 2010-02-16
 * 개    요 : 시설코드 가져오기
 * 사용방법 : getUserNonPop( strDataSet, objCd, objNm, authGb, searchTp)
 *            arguments[0] -> 데이터셋
 *            arguments[1] -> 코드
 *            arguments[2] -> 시설코드
 *            arguments[3] -> 사용위치 : "E":EMEDIT, "G":GRID
 *            arguments[4] -> POP호출여부 : "Y":팝업호출, "N":팝업호출하지않음)
 *            arguments[5] -> 조회구분(0: 주거세대마스터체크 0, 1: 주거세대마스터체크 )
 *            //--추가조건--
 *            arguments[n] -> 추가
 *
 * 실행  예) getHomeIdNonPop("DS_O_RESULT", EM_S_BUYER_CD, EM_S_BUYER_CD, "E" , "Y");
 *
 * return값 : 코드/명
 */
 function getHomeIdNonPop( strDataSet, objCd, strStrCd, strMGGb, strSgbn, strPopYN){
 	if (typeof(objCd) == "object" ) {
 		if(trim(objCd.Text) == ""){
 			return;
 		} 
 		strCode = objCd.Text;
 	} else {
 		if(trim(objCd) == ""){
 			return;
 		}
 		strCode = objCd;
 	}
 	
 	var addCondition = setAddCondition( 6, arguments );
 	var dataSetId = eval(strDataSet);
 	
 	DS_I_CONDITION.setDataHeader  ('CODE:STRING(20),NAME:STRING(40),NAME2:STRING(40),STRCD:STRING(2),MGBN:STRING(2),SGBN:STRING(1),ADD_CONDITION:STRING(200)');
 	DS_I_CONDITION.ClearData();
 	DS_I_CONDITION.Addrow();
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "CODE") = strCode;    
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "NAME") = ""; 
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "NAME2")= ""; 
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "STRCD")= strStrCd; 
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "MGBN") = strMGGb; 
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "SGBN") = strSgbn; 
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

 	TR_MAIN.Action="/pot/ccom212.cc?goTo=getDate";
     TR_MAIN.KeyValue="SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
     TR_MAIN.Post(); 
     
     if (dataSetId.CountRow == 1) {
     	if (strMGGb == "E") {
 			objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "CODE");
     	} 
     	return dataSetId;
 	}else{
 		if(strPopYN == "Y"){
 	    	if (strMGGb == "E") {
 	    		return getHomeIdPop( objCd, "", "", strStrCd, "S", strSgbn );
 	    	} else {
 	    		return getHomeIdPop( objCd, "", "", strStrCd, "M", strSgbn );
 	    	}
 		} else {
 			return dataSetId;
 		}
 	}
 }
 
 /** 
 * getMssEvtVenPop()
 * 작 성 자 : 김성미
 * 작 성 일 : 2010-04-05
 * 개    요 : 상품권 협력사 가져오기
 * 사용방법 : getMssEvtVenPop( objCd, objNm, gbnMulti)
 *            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
 *            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
 *            arguments[2] -> 멀티입력(M:멀티,S:단일)
 *            arguments[3] -> 협력사 구분 (1: 제휴협력사, 2: 가맹점, 3:위탁 협력사)
 *            arguments[4] -> 상품권 협력사 조회 구분 ( '' : 협력사 개별조회 , 'A' : 협력사 통합 조회)
 *            //--추가조건--
 *            arguments[5] -> 점코드
 *            arguments[6] -> 매입 매출 구분
 *            arguments[n] -> 추가
 *
 * 실행  예) 
 * 		   getMssEvtVenPop( EM_CODE, EM_NAME, "M" , "1", );
 * 추가조건   getMssEvtVenPop( EM_CODE, EM_NAME, "M", LC_STR_CD.BindColVal );
 *
 * return값 : 코드/명
 */
 function getMssEvtVenPop( objCd, objNm, gbnMulti, venTbGnb , strSearchGb)
 {
 	var rtnArray = new Array();
     var arrArg   = new Array();
 	var addCondition = setAddCondition( 5, arguments );
 	
 	var strCode = "";
 	var strName = "";
 	if (gbnMulti == "M" ) {
 		strCode = objCd;
 		strName = objNm;
 	} else {
 		if (typeof(objCd) == "object" ) {
 			strCode = objCd.Text;
 			strName = objNm.Text;
			//[Fix : 2010.04.11] 명을 기준 으로 올바른코드값 체크
			if (strName.length < 1) {
				objCd.Text = ""; 
				objNm.Text = "";
			}
 		} else {
 			strCode = objCd;
 			strName = objNm;
 		}
 	}

    arrArg.push(rtnArray);
 	arrArg.push(strCode);
 	arrArg.push('');//[Fix : 2010.04.11] 명은 조회조건에서 제외 arrArg.push(strName);
 	arrArg.push(gbnMulti);
 	arrArg.push(venTbGnb);
 	arrArg.push(strSearchGb);
 	arrArg.push(addCondition);

     var returnVal = window.showModalDialog("/pot/ccom213.cc?goTo=callPopup",
                                            arrArg,
                                            "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                            "resizable:no;help:no;unadorned:yes;center:yes;status:no");
   	if (returnVal){
   		if (gbnMulti == "M") {
   			var rt = arrArg[0];
   			return rt;
   		} else {
   			var rt = arrArg[0][0];
   			if (typeof(objCd) == "object" ) {
	   			objCd.Text = rt.CODE;
	   			objNm.Text = rt.NAME;
   			}
   			return rt;
   		}
  	}
 }

 /**
 * getMssEvtVenNonPop()
 * 작 성 자 : 김유완
 * 작 성 일 : 2010-02-16
 * 개    요 : 상품권 협력사 코드/명 가져오기
 * 사용방법 : getMssEvtVenNonPop( strDataSet, objCd, objNm, authGb, searchTp)
 *            arguments[0] -> 데이터셋
 *            arguments[1] -> 코드
 *            arguments[2] -> 명
 *            arguments[3] -> 사용위치 : "E":EMEDIT, "G":GRID
 *            arguments[4] -> POP호출여부 : "Y":팝업호출, "N":팝업호출하지않음)
 *            arguments[5] -> 협력사 구분 (1: 제휴협력사, 2: 가맹점, 3:위탁 협력사)
 *            arguments[6] -> 상품권 협력사 조회 구분 ( '' : 협력사 개별조회 , 'A' : 협력사 통합 조회)
 *            //--추가조건--
 *            arguments[7] -> 점코드
 *            arguments[8] -> 매입 매출 구분
 *            arguments[n] -> 추가
            
 *
 * 실행  예) getMssEvtVenNonPop("DS_O_RESULT", EM_S_BUYER_CD, EM_S_BUYER_CD, "E" , "Y");
 *
 * return값 : 코드/명
 */
 function getMssEvtVenNonPop( strDataSet, objCd, objNm, mgGb, searchTp, venTbGnb, strSearchGb){
 	if (typeof(objCd) == "object" ) {
 		objNm.Text = "";//[Fix : 2010.04.11]코드기준검색
 		if(trim(objCd.Text) == ""){
 			return;
 		} 
 		strCode = objCd.Text;
 		strName = objNm.Text;
 	} else {
 		if(trim(objCd) == ""){
 			return;
 		}
 		strCode = objCd;
 		strName = objNm;
 	}
 	
 	var addCondition = setAddCondition( 7, arguments );
 	var dataSetId = eval(strDataSet);
 	
 	DS_I_CONDITION.setDataHeader  ('CODE:STRING(20),NAME:STRING(40),MGBN:STRING(2),TBGBN:STRING(1),SEARCHGB:STRING(1),ADD_CONDITION:STRING(200)');
 	DS_I_CONDITION.ClearData();
 	DS_I_CONDITION.Addrow();
 	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "CODE") = strCode; 
 	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "NAME") = strName; 
 	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "MGBN") = mgGb;
 	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "TBGBN")= venTbGnb;
 	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "SEARCHGB")= strSearchGb;
 	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;
 	TR_MAIN.Action="/pot/ccom213.cc?goTo=getList";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post(); 
     
     if (dataSetId.CountRow == 1) {
     	if (mgGb == "E") {
 			objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "CODE");
 			objNm.text = dataSetId.NameValue(dataSetId.RowPosition, "NAME");	
     	} 
     	return dataSetId;
 	}else{
 		if(searchTp == "Y"){
 	    	if (mgGb == "E") {
 	    		return getMssEvtVenPop( objCd, objNm, "S", venTbGnb , strSearchGb, addCondition)
 	    	} else {
 	    		return getMssEvtVenPop( objCd, objNm, "M", venTbGnb , strSearchGb, addCondition)
 	    	}
 		} else {
 			return dataSetId;
 		}
 	}
 }
 
 /** 
 * mssEventMstPop()
 * 작 성 자 : 김성미
 * 작 성 일 : 2010-01-25
 * 개    요 : 행사조회 Popup
 * 사용방법 : eventPop(serviceId, objCd, objNm, objSDt, objEDt, strFlg)
 *            arguments[0] -> [ccom210_service.xml] 에 정의한 QUERY의 ID   예) "SEL_USR_MST"
 *            arguments[1] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
 *            arguments[2] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
 *            arguments[3] -> 점코드
 *            arguments[4] -> 사은행사 구분 4: 사은행사, 5: 경품행사, 6: 제휴카드행사 
 *            				(사은, 제휴카드 행사를 같이 조회 할경우   '/' 로 구분)
 *            arguments[5] -> 사은품종류 01: 상품권, 02: 물품, 03: 상품권+물품, 04: 상품권+(상품권+물품), 05: 물품 + (상품권+물품)
 *            -- 추가 --
 *            arguments[6] -> 행사 조회 시작일
 *            arguments[7] -> 행사 조회 종료일
 *            
 * 실행  예) mssEventMstPop('SEL_STR_EVENT_POP',EM_S_EVENT_CD,EM_S_EVENT_NAME,LC_S_STR_CD.BindColVal, '5', '04');"
 *
 * return값 : void
 */
 function mssEventMstPop(serviceId, objCd, objNm, strStr, strEventType, strEvtGiftType)
 {
 	var strWidth  = "330px;";//시작,종료일 리턴 여부에 따른 POPUP싸이즈 조절
     var rtnMap  = new Map();
     var arrArg  = new Array();
 	var addCondition = setAddCondition( 6, arguments );
 	var strCode = "";
 	var strName = "";
 	
 	if (typeof(objCd) == "object" ) {
 		strCode = objCd.Text;
 		strName = objNm.Text;
 		if (strName.length < 1) {
 			objCd.Text = ""; 
 			objNm.Text = "";
 		}
 	} else {
 		strCode = objCd;
 	}
 	arrArg.push(rtnMap);
 	arrArg.push(serviceId);
 	arrArg.push(strCode);
 	arrArg.push(strStr);
 	arrArg.push(strEventType);
 	arrArg.push(strEvtGiftType);
 	arrArg.push(addCondition);
 	
 	strWidth  	= "350px;";
     var returnVal = window.showModalDialog("/pot/ccom217.cc?goTo=callPopup",
                                            arrArg,
                                            "dialogWidth:"+strWidth+"dialogHeight:395px;scroll:no;" +
                                            "resizable:no;help:no;unadorned:yes;center:yes;status:no");
   	if (returnVal){
 		var map = arrArg[0];
 		objCd.Text = map.get("EVENT_CD");
 		objNm.Text = map.get("EVENT_NM");
  	}
 }


 /**
 * setMssEvtMstNmWithoutPop()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-01-26
 * 개    요 : 팝업 없이 행사코드 입력후  키업 이벤트시 행사명 셋팅 
 * 사용방법 : setMssEvtNmWithoutPop(strDataSet, strTitle, serviceId, objCd, objNm, searchTp)
 *            arguments[0] -> Output용 dataset 문자  	예)"DS_O_RESULT"
 *            arguments[1] -> 코드를 받아올 EMEDIT ID
 *            arguments[2] -> 이름을 받아올 EMEDIT ID
 *			  arguments[3] -> 점코드
 *            arguments[4] -> 사은행사 구분 4: 사은행사, 5: 경품행사, 6: 제휴카드행사 
 *            				(사은, 제휴카드 행사를 같이 조회 할경우   콤마(/)로 구분)
 *            arguments[5] -> 사은품종류 01: 상품권, 02: 물품, 03: 상품권+물품, 04: 상품권+(상품권+물품), 05: 물품 + (상품권+물품)
 * 실행 예) setEvtNmWithoutPop('DS_O_RESULT', '담당자', 'SEL_USR_MST', EM_CORP_NO, EM_REP_NAME);
 *
 * return값 : void
 */
 function setMssEvtMstNmWithoutPop(strDataSet, serviceId, objCd, objNm, strStrCd, strEventType, strEvtGiftType){
 	var strCode = "";
 	var strName = "";
 	if (typeof(objCd) == "object" ) {
 		objNm.Text = "";
 		if(trim(objCd.Text) == ""){
 			return;
 		} 
 		strCode = objCd.Text;
 		strName = objNm.Text;
 	} else {
 		if(trim(objCd) == ""){
 			return;
 		}
 		strCode = objCd;
 	}
 	
 	var dataSetId = eval(strDataSet);
 	var codeCd = objCd.Text;
 	var cdSize = objCd.Format.length;
 	DS_I_CONDITION.setDataHeader( 'SERVICE_ID:STRING(50),CODE_CD:STRING(60),STR_CD:STRING(2),EVENT_TYPE:STRING(10),EVENT_GIFT_TYPE:STRING(10),ADD_CONDITION:STRING(100)' );
 	
 	DS_I_CONDITION.ClearData();
 	DS_I_CONDITION.Addrow();
 	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "SERVICE_ID") 		= serviceId;
 	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "CODE_CD")    		= codeCd;
 	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "STR_CD")    		= strStrCd;
 	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "EVENT_TYPE")    	= strEventType;
 	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "EVENT_GIFT_TYPE") = strEvtGiftType;
 	
 	TR_MAIN.Action	 = "/pot/ccom217.cc?goTo=getOneWithoutPop";
 	TR_MAIN.KeyValue = "SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
 	TR_MAIN.Post();
 	return dataSetId;
 }
 
 /** 
  * getGaugIdPop()
  * 작 성 자 : 김유완
  * 작 성 일 : 2010-04-05
  * 개    요 : 계량기마스터 Popup
  * 사용방법 : getGaugIdPop( objCd, objNm, gbnMulti)
  *            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
  *            arguments[1] -> 시설구분
  *            arguments[2] -> 계량기구분
  *            arguments[3] -> 멀티입력(M:멀티,S:단일)
  *            arguments[4] -> 미등록계량기("Y:미등록체크", "N:체크안함")
  *            arguments[5] -> 계량기용도
  *            //--추가조건--
  *            arguments[6] -> 계량기레벨
  *            arguments[n] -> 추가
  *
  * 실행  예) 
  * 추가조건  getGaugIdPop( EM_CODE, EM_NAME, "M", EM_ORG_CD.Text);
  *
  * return값 : 코드/명
  */
 function getGaugIdPop( objCd, objNm, strFlc, strgaugGbn, strMultiGbn, strUseYnChk, strGaugKind)
 {
	var rtnArray = new Array();
	var arrArg   = new Array();
 	var addCondition = setAddCondition( 7, arguments );
 	
 	var strCode = "";
 	if (strMultiGbn == "M" ) {
 		strCode = objCd;
 	} else {
 		if (typeof(objCd) == "object" ) {
 			strCode = objCd.Text;
			if ((objNm.Text).length < 1) {
				objCd.Text = ""; 
				objNm.Text = "";
			}
 		} else {
 			strCode = objCd;
 		}
 	}

	arrArg.push(rtnArray);
 	arrArg.push(strCode);
 	arrArg.push(strFlc);
 	arrArg.push(strgaugGbn);
 	arrArg.push(strMultiGbn);
 	arrArg.push(strUseYnChk);
 	arrArg.push(strGaugKind);
 	arrArg.push(addCondition);

	var returnVal = window.showModalDialog("/pot/ccom214.cc?goTo=callPopup",
                                            arrArg,
                                            "dialogWidth:458px;dialogHeight:395px;scroll:no;" +
                                            "resizable:no;help:no;unadorned:yes;center:yes;status:no");
   	if (returnVal){
   		if (strMultiGbn == "M") {
   			var rt = arrArg[0];
   			return rt;
   		} else {
   			var rt = arrArg[0][0];
   			objCd.Text = rt.GAUG_ID;
   			return rt;
   		}
  	}
 }

 /**
 * getGaugIdNonPop()
 * 작 성 자 : 김유완
 * 작 성 일 : 2010-02-16
 * 개    요 : 계량기ID 가져오기
 * 사용방법 : getUserNonPop( strDataSet, objCd, objNm, authGb, searchTp)
 *            arguments[0] -> 데이터셋
 *            arguments[1] -> 코드
 *            arguments[2] -> 시설코드
 *            arguments[3] -> 계량기구분
 *            arguments[4] -> 사용위치 : "E":EMEDIT, "G":GRID
 *            arguments[5] -> POP호출여부 : "Y":팝업호출, "N":팝업호출하지않음)
 *            arguments[6] -> 미등록계량기("T:미등록체크", "F:체크안함")
 *            //--추가조건--
 *            arguments[7] -> 계량기레벨
 *            arguments[n] -> 추가
 *
 * 실행  예) getGaugIdNonPop("DS_O_RESULT", EM_S_BUYER_CD, EM_S_BUYER_CD, "E" , "Y");
 *
 * return값 : 코드/명
 */
 function getGaugIdNonPop( strDataSet, objCd, strFlc, strgaugGbn, strMGGb, strPopYN, strUseYnChk, strGaugKind){
 	if (typeof(objCd) == "object" ) {
 		if(trim(objCd.Text) == ""){
 			return;
 		} 
 		strCode = objCd.Text;
 	} else {
 		if(trim(objCd) == ""){
 			return;
 		}
 		strCode = objCd;
 	}
 	
 	var addCondition = setAddCondition( 8, arguments );
 	var dataSetId = eval(strDataSet);
 	
 	DS_I_CONDITION.setDataHeader  ('CODE:STRING(20),FLCCD:STRING(2),GAUGTYPE:STRING(2),MGBN:STRING(2),USEYN:STRING(1),GAUGKIND:STRING(2),ADD_CONDITION:STRING(200)');
 	DS_I_CONDITION.ClearData();
 	DS_I_CONDITION.Addrow();
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "CODE") = strCode;    
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "FLCCD") = strFlc
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "GAUGTYPE")= strgaugGbn; 
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "MGBN") = strMGGb; 
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "USEYN") = strUseYnChk; 
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "GAUGKIND") = strGaugKind; 
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

 	TR_MAIN.Action="/pot/ccom214.cc?goTo=getDate";
     TR_MAIN.KeyValue="SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
     TR_MAIN.Post(); 
     
     if (dataSetId.CountRow == 1) {
     	if (strMGGb == "E") {
 			objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "GAUG_ID");
     	} 
     	return dataSetId;
 	}else{
 		if(strPopYN == "Y"){
 	    	if (strMGGb == "E") {
 	    		return getGaugIdPop( objCd, strFlc, strgaugGbn, "S", strUseYnChk);
 	    	} else {
 	    		return getGaugIdPop( objCd, strFlc, strgaugGbn, "M", strUseYnChk);
 	    	}
 		} else {
 			return dataSetId;
 		}
 	}
 }
 
 /** 
  * getCntrPop()
  * 작 성 자 : 김유완
  * 작 성 일 : 2010-04-05
  * 개    요 : 임대계약마스터 Popup
  * 사용방법 :  arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
  *            arguments[1] -> 시설구분
  *            arguments[2] -> 협력사코드
  *            arguments[3] -> 계량기형태
  *            arguments[4] -> 계량기종류
  *            arguments[5] -> 멀티입력(M:멀티,S:단일)
  *            arguments[6] -> 미등록계약ID"Y:미등록체크", "N:체크안함", "E:일반계약ID조회")
  *            arguments[7] -> C:임대계약마스터, H:주거세대마스터
  *            //--추가조건--
  *            arguments[n] -> 추가
  *
  * 실행  예) 
  * 추가조건  getCntrPop( EM_CODE, EM_NAME, "M", EM_ORG_CD.Text);
  *
  * return값 : 코드/명
  */
 function getCntrPop( objCd, strFlc, strVenCd, strGaugType, strGaugKindCd, strMultiGbn, strUseYnChk, strSchLoc)
 {
	 var rtnArray = new Array();
	 var arrArg   = new Array();
	 var addCondition = setAddCondition( 8, arguments );
	 
	 var strCode = "";
	 if (strMultiGbn == "M" ) {
		 strCode = objCd;
	 } else {
		 if (typeof(objCd) == "object" ) {
			 strCode = objCd.Text;
			 objCd.Text = "";
		 } else {
			 strCode = objCd;
		 }
	 }
	 
	 arrArg.push(rtnArray);
	 arrArg.push(strCode);
	 arrArg.push(strFlc);
	 arrArg.push(strVenCd);
	 arrArg.push(strGaugType);
	 arrArg.push(strGaugKindCd);
	 arrArg.push(strMultiGbn);
	 arrArg.push(strUseYnChk);
	 arrArg.push(strSchLoc);
	 arrArg.push(addCondition);
	 
	 var returnVal = window.showModalDialog("/pot/ccom215.cc?goTo=callPopup",
			 arrArg,
			 "dialogWidth:458px;dialogHeight:395px;scroll:no;" +
	 		 "resizable:no;help:no;unadorned:yes;center:yes;status:no");
	 if (returnVal){
		 if (strMultiGbn == "M") {
			 var rt = arrArg[0];
			 return rt;
		 } else {
			 var rt = arrArg[0][0];
			 if (typeof(objCd) == "object" ) {
				 objCd.Text = rt.CNTR_ID;
			 } 
			 return rt;
		 }
	 }
 }
 
 /**
  * getCntrNonPop()
  * 작 성 자 : 김유완
  * 작 성 일 : 2010-02-16
  * 개    요 : 계량기ID 가져오기
  * 사용방법 : getUserNonPop( strDataSet, objCd, objNm, authGb, searchTp)
  *            arguments[0] -> 데이터셋
  *            arguments[1] -> 코드
  *            arguments[2] -> 시설코드
  *            arguments[3] -> 협력사코드
  *            arguments[4] -> 계량기형태
  *            arguments[5] -> 계량기종류
  *            arguments[6] -> 사용위치 : "E":EMEDIT, "G":GRID
  *            arguments[7] -> POP호출여부 : "Y":팝업호출, "N":팝업호출하지않음)
  *            arguments[8] -> 미등록계약ID"Y:미등록체크", "N:체크안함", "E:일반계약ID조회")
  *            arguments[9] -> C:임대계약마스터, H:주거세대마스터
  *            //--추가조건--
  *            arguments[n] -> 추가
  *
  * 실행  예) getCntrNonPop("DS_O_RESULT", EM_S_BUYER_CD, EM_S_BUYER_CD, "E" , "Y");
  *
  * return값 : 코드/명
  */
 function getCntrNonPop( strDataSet, objCd, strFlc, strVenCd, strGaugType, strGaugKindCd, strMGGb, strPopYN, strUseYnChk, strSchLoc){
	 if (typeof(objCd) == "object" ) {
		 if(trim(objCd.Text) == ""){
			 return;
		 } 
		 strCode = objCd.Text;
	 } else {
		 if(trim(objCd) == ""){
			 return;
		 }
		 strCode = objCd;
	 }
	 
	 var addCondition = setAddCondition( 10, arguments );
	 var dataSetId = eval(strDataSet);
	 
	 DS_I_CONDITION.setDataHeader  ('CODE:STRING(20),FLCCD:STRING(2),VENCD:STRING(6),VENNM:STRING(40),GTYPE:STRING(10),GKINDCD:STRING(10),MGBN:STRING(2),USEYN:STRING(1),SCHLOC:STRING(1),ADD_CONDITION:STRING(200)');
	 DS_I_CONDITION.ClearData();
	 DS_I_CONDITION.Addrow();
	 DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "CODE")  	= strCode;    
	 DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "FLCCD") 	= strFlc
	 DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "VENCD") 	= strVenCd; 
	 DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "VENNM") 	= ""; 
	 DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "GTYPE") 	= strGaugType; 
	 DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "GKINDCD")= strGaugKindCd; 
	 DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "MGBN")  	= strMGGb; 
	 DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "USEYN") 	= strUseYnChk; 
	 DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "SCHLOC")	= strSchLoc; 
	 DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;
	 
	 TR_MAIN.Action="/pot/ccom215.cc?goTo=getDate";
	 TR_MAIN.KeyValue="SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
	 TR_MAIN.Post(); 
	 
	 if (dataSetId.CountRow == 1) {
		 if (strMGGb == "E") {
			 objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "CNTR_ID");
		 } 
		 return dataSetId;
	 }else{
		 if(strPopYN == "Y"){
			 if (strMGGb == "E") {
				 return getCntrPop( objCd, strFlc, "", strGaugType, strGaugKindCd, "S", "N");
			 } else {
				 return getCntrPop( objCd, strFlc, "", strGaugType, strGaugKindCd, "M", "N");
			 }
		 } else {
			 return dataSetId;
		 }
	 }
 }
 
  
  /** 
   * getEvtCardComp()
   * 작 성 자 : 김성미
   * 작 성 일 : 2010-04-11
   * 개    요 : 사은행사 제휴카드사 협력사별 제휴카드 정보 조회 팝업
   * 사용방법 : getEvtCardComp( objCd, objNm, gbnMulti)
   *            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
   *            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
   *            arguments[2] -> 멀티입력(M:멀티,S:단일)
   *            //--추가조건--
   *            arguments[3] -> 점코드
   *            arguments[n] -> 추가
   *
   * 실행  예)  getEvtCardComp( EM_CODE, EM_NAME, "M", LC_STR_CD.BindColVal );
   *
   * return값 : 코드/명
   */
   function getEvtCardComp( objCd, objNm, gbnMulti, strStrCd)
   {
   	var rtnArray = new Array();
       var arrArg   = new Array();
   	var addCondition = setAddCondition( 4, arguments );
   	
   	var strCode = "";
   	var strName = "";
   	if (gbnMulti == "M" ) {
   		strCode = objCd;
   		strName = objNm;
   	} else {
   		if (typeof(objCd) == "object" ) {
   			strCode = objCd.Text;
   			strName = objNm.Text;
  			if (strName.length < 1) {
  				objCd.Text = ""; 
  				objNm.Text = "";
  			}
   		} else {
   			strCode = objCd;
   			strName = objNm;
   		}
   	}

     arrArg.push(rtnArray);
   	arrArg.push(strCode);
   	arrArg.push(strStrCd);
   	arrArg.push(gbnMulti);
   	arrArg.push(addCondition);

     var returnVal = window.showModalDialog("/pot/ccom216.cc?goTo=callPopup",
                                              arrArg,
                                              "dialogWidth:400px;dialogHeight:395px;scroll:no;" +
                                              "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     	if (returnVal){
     		if (gbnMulti == "M") {
     			var rt = arrArg[0];
     			return rt;
     		} else {
     			var rt = arrArg[0][0];
     			objCd.Text = rt.CODE;
     			objNm.Text = rt.NAME;
     			HD_VEN_CD.Value = rt.VEN_CD;
     			return rt;
     		}
    	}
   }

   /**
   * getEvtCardCompNonPop()
   * 작 성 자 : 김성미
   * 작 성 일 : 2010-04-11
   * 개    요 : 사은행사 제휴카드사 협력사별 제휴카드 코드/명 가져오기
   * 사용방법 : getEvtCardCompNonPop( strDataSet, objCd, objNm, mgGb, searchTp)
   *            arguments[0] -> 데이터셋
   *            arguments[1] -> 코드
   *            arguments[2] -> 명
   *            arguments[3] -> 사용위치 : "E":EMEDIT, "G":GRID
   *            arguments[4] -> POP호출여부 : "Y":팝업호출, "N":팝업호출하지않음)
   *            //--추가조건--
   *            arguments[5] -> 점코드
   *            arguments[n] -> 추가
   * 실행  예) getMssGiftEvtVenNonPop("DS_O_RESULT", EM_S_BUYER_CD, EM_S_BUYER_CD, "E" , "Y");
   * return값 : 코드/명
   */
   function getEvtCardCompNonPop( strDataSet, objCd, objNm, mgGb, searchTp, strStrCd){
   	if (typeof(objCd) == "object" ) {
   		objNm.Text = "";
   		if(trim(objCd.Text) == ""){
   			return;
   		} 
   		strCode = objCd.Text;
   		strName = objNm.Text;
   	} else {
   		if(trim(objCd) == ""){
   			return;
   		}
   		strCode = objCd;
   		strName = objNm;
   	}
   	
   	var addCondition = setAddCondition( 5, arguments );
   	var dataSetId = eval(strDataSet);
   	
   	DS_I_CONDITION.setDataHeader  ('STR_CD:STRING(2),CARD_COMP:STRING(2),CARD_COMP_NM:STRING(40)');
   	DS_I_CONDITION.ClearData();
    DS_I_CONDITION.Addrow();
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "STR_CD")      = strStrCd;    
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "CARD_COMP")   = strCode;
    TR_MAIN.Action="/pot/ccom216.cc?goTo=getList";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  
       
       if (dataSetId.CountRow == 1) {
       	if (mgGb == "E") {
   			objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "CODE");
   			objNm.text = dataSetId.NameValue(dataSetId.RowPosition, "NAME");	
   			HD_VEN_CD.Value = dataSetId.NameValue(dataSetId.RowPosition, "VEN_CD");
       	} 
       	return dataSetId;
   	}else{
   		if(searchTp == "Y"){
   	    	if (mgGb == "E") {
   	    		return getEvtCardComp( objCd, objNm, "S", strStrCd, addCondition);
   	    	} else {
   	    		return getEvtCardComp( objCd, objNm, "M", strStrCd, addCondition);
   	    	}
   		} else {
   			return dataSetId;
   		}
   	}
   }

/** 
 * getBizPop()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-05-11
 * 개    요 : 실적항목코드 Popup
 * 사용방법 : getBizPop( objCd, objNm)
 *            arguments[0] -> 코드를 받아올 EMEDIT ID
 *            arguments[1] -> 명을 받아올 EMEDIT ID
 *            //조회조건
 *            arguments[2] -> 항목레벨
 *            arguments[3] -> 상위항목코드
 *
 * 실행  예) 
 * 		   getBizPop(EM_BIZ_CD, EM_BIZ_NM);
 *
 * return값 : 코드/명
 */
function getBizPop(objCd, objNm){
	var arrArg   = new Array();
   	arrArg.push(objCd.Text);
   	arrArg.push(arguments[2]==undefined?"":arguments[2]);
   	arrArg.push(arguments[3]==undefined?"":arguments[3]);

   	var returnVal = window.showModalDialog( "/pot/ccom221.cc?goTo=callPopup"
    		                              , arrArg
    		                              , "dialogWidth:358px;dialogHeight:395px;scroll:no;" 
    		                              + "resizable:no;help:no;unadorned:yes;center:yes;status:no");
    if (returnVal){
		objCd.Text = returnVal[0];
		objNm.Text = returnVal[1];
		return returnVal;
    }
}

/** 
 * getBizNonPop()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-05-11
 * 개    요 : 실적항목코드 Popup
 * 사용방법 : getBizNonPop( objCd, objNm)
 *            arguments[0] -> 데이터셋
 *            arguments[1] -> 코드를 받아올 EMEDIT ID
 *            arguments[2] -> 명을 받아올 EMEDIT ID
 *
 * 실행  예) 
 * 		   getBizNonPop(dsSet, EM_BIZ_CD, EM_BIZ_NM);
 *
 * return값 : 코드/명
 */
function getBizNonPop(strDataSet, objCd, objNm){
	var dsSet      = eval(strDataSet);
	var parameters = "&strCode=" + objCd.text ;

    dsSet.ClearData();          
    dsSet.DataID   = "/pot/ccom221.cc?goTo=getBizCdNm"+parameters;
    dsSet.SyncLoad = "true";
    dsSet.Reset();
	
	if (dsSet.CountRow == 1) {
		objCd.text = dsSet.NameValue(1, "CODE");
		objNm.text = dsSet.NameValue(1, "NAME");	
	}else{
		objNm.Text = "";
		return getBizPop(objCd, objNm);
	}
}

/** 
 * getBizPopGrid()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-05-11
 * 개    요 : 실적항목코드 Popup
 * 사용방법 : getBizPopGrid( objCd, objNm)
 *            arguments[0] -> 실적항목코드
 *            arguments[1] -> 계획년월
 *            arguments[2] -> 계획/실적구분
 *
 * 실행  예) 
 * 		   getBizPopGrid(code, planYm, type);
 *
 * return값 : 코드/명
 */
function getBizPopGrid(code, planYm, type){
	var arrArg   = new Array();
   	arrArg.push(code);
   	arrArg.push(planYm);
   	arrArg.push(type);

   	var returnVal = window.showModalDialog( "/pot/ccom221.cc?goTo=callPopup3"
    		                              , arrArg
    		                              , "dialogWidth:358px;dialogHeight:395px;scroll:no;" 
    		                              + "resizable:no;help:no;unadorned:yes;center:yes;status:no");
    if (returnVal){
		return returnVal;
    }
}

/** 
 * getBizNonPopGrid()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-05-11
 * 개    요 : 실적항목코드 Non Popup
 * 사용방법 : getBizNonPopGrid( objCd, code, planYm, type)
 *            arguments[0] -> 데이터셋
 *            arguments[1] -> 실적항목코드
 *            arguments[2] -> 계획년월
 *            arguments[3] -> 계획/실적 구분
 *
 * 실행  예) 
 * 		   getBizNonPopGrid(dsSet, code, planYm, type);
 *
 * return값 : 코드/명
 */
function getBizNonPopGrid(strDataSet, code, planYm, type){
	var dsSet      = eval(strDataSet);
	var parameters = "&strCode="   + code
	               + "&strPlanYm=" + planYm
	               + "&strType="   + type;

    dsSet.ClearData();          
    dsSet.DataID   = "/pot/ccom221.cc?goTo=getBizPlanCdNm"+parameters;
    dsSet.SyncLoad = "true";
    dsSet.Reset();
	
    var arrArg   = new Array();
	if (dsSet.CountRow == 1) {
		arrArg[0] = dsSet.NameValue(1, "CODE");
		arrArg[1] = dsSet.NameValue(1, "NAME");	
	}else{
		arrArg = getBizPopGrid(code, planYm, type);
	}
	return arrArg;
}

/** 
 * getAccPop()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-05-18
 * 개    요 : 계정/예산항목코드 Popup
 * 사용방법 : getAccPop(strPopFlag, strAccFlag, strAccCd)
 *            arguments[0] -> 팝업구분
 *            arguments[1] -> 계정/예산구분
 *            arguments[2] -> 계정/예산항목
 *
 * 실행  예) 
 * 		   getAccPop(strPopFlag, strAccFlag, strAccCd);
 *
 * return값 : 코드/명
 */
function getAccPop(strPopFlag, strCon1, strCon2){
	var arrArg   = new Array();
	arrArg.push(strPopFlag);
	arrArg.push(strCon1);
	arrArg.push(strCon2);

   	var returnVal = window.showModalDialog( "/pot/ccom221.cc?goTo=callPopup2"
    		                              , arrArg
    		                              , "dialogWidth:358px;dialogHeight:395px;scroll:no;" 
    		                              + "resizable:no;help:no;unadorned:yes;center:yes;status:no");
    if (returnVal){
		return returnVal;
    }
}

/** 
 * getAccNonPop()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-05-11
 * 개    요 : 계정/예산항목코드
 * 사용방법 : getAccNonPop(strPopFlag, strDataSet, strBizCd, strAccFlag, strAccCd)
 *            arguments[0] -> 데이터셋
 *            arguments[1] -> 코드를 받아올 EMEDIT ID
 *            arguments[2] -> 명을 받아올 EMEDIT ID
 *
 * 실행  예) 
 * 		   getAccNonPop(strPopFlag, dsSet, strBizCd, strAccFlag, strAccCd);
 *
 * return값 : 코드/명
 */
function getAccNonPop(strPopFlag, strDataSet, strCon1, strCon2, strAccCd){
	var dsSet      = eval(strDataSet);
	var parameters = "&strFlag="  + strPopFlag
	               + "&strCon1="  + strCon1
	               + "&strCon2="  + strCon2
	               + "&strAccCd=" + strAccCd;

    dsSet.ClearData();          
    dsSet.DataID   = "/pot/ccom221.cc?goTo=getAccCdNm"+parameters;
    dsSet.SyncLoad = "true";
    dsSet.Reset();
	
    var arrArg   = new Array();
	if (dsSet.CountRow == 1) {
		arrArg[0] = dsSet.NameValue(1, "CODE");
		arrArg[1] = dsSet.NameValue(1, "NAME");	
	}else{
		arrArg = getAccPop(strPopFlag, strCon2, strAccCd);
	}
	return arrArg;
}
