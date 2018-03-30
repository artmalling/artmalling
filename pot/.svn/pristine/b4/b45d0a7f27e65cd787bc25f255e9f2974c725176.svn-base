/**
 * 시스템명 : 한국후지쯔 공통 팝업 스크립트
 * 작 성 일 : 2010-01-20
 * 작 성 자 : FKL
 * 수 정 자 :
 * 파 일 명 : potup.js
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
openCal()               : 달력 오픈
showWindow()            : Window 오픈                 <--미사용
gauceModalCalendarYMD() : GAUCE 달력 모달창 오픈       <--미사용
showModalCalendarYMD()  : 달력 모달창을 오픈한다       <--미사용
showModalCalendarYM()   : 월달력 모달창을 오픈한다      <--미사용 


☞-------------------POPOP  ---------------------------------
commonPop()             : 공통팝업[공통]
commonPopOnlyCd()       : 공통팝업(코드만 조회)    [공통]  <--미사용
commonPopToGrid         : 공통팝업(그리드에서 조회)[공통]   <--미사용
getPostPop()            : 우편번호 팝업 [공통]
orgMstToGridPop()		: 조직 Popup(Grid) [시스템관리]
orgMstWithoutToGridPop(): 조직코드 입력시 명칭 갖고오기(Grid)[시스템관리]
helpPop()             	: 도움말팝업[공통]
NoticeMainPop()         : 공지사항팝업[공통]


☞-------------------non-POPOP  ---------------------------------
getEtcCode()            : 공통코드를 가지고 오는 함수 [공통] <-- 20100125 워크샵 후 활성화시킴
setNmToDataSet()        : 팝업 없이 코드 입력후  키업 이벤트시 코드,코드명 DataSet에 셋팅 [공통] 
setNmWithoutPop()       : 팝업 없이 코드 입력후  키업 이벤트시 코드명 셋팅 [공통]
setUserNmWithoutPop()   : 사용자명을 가지고 오는 함수 [공통] <--setNmWithoutPop()의 응용형태


공통에 포함되어할 기준정보 테이블 및 쿼리를 작성해서 공통팀에게 의뢰하시기 바랍니다.
사용 예는 --> 기준정보>> 조직코드 >> 점정보관리를 참조하세요
*/

/**
* openCal()
* 작 성 자 : FKL
* 작 성 일 : 2010. 01. 22
* 개    요 : 캘렌다 오픈
* 사용방법 : openCal(obj1, obj2, obj3)
*            obj1 -> 년도, 년도+월, 년도+월+일
*            obj2 -> 선택시 일자를 받을 EMEDIT ID
* return값 : 
*/

function openCal(obj1, obj2, obj3) {
  var obj = new Array();
  var rtn = "";
  
  if (arguments.length == 2 && obj1 != 'H' && obj1 != 'G' && obj1 != 'M' && obj1 != 'Y') {
    showMessage(STOPSIGN, OK, "SCRIPT-1002");
    return;
  } else if (arguments.length == 2 && (obj1 == 'H' || obj1 == 'G' || obj1 == 'M' || obj1 == 'Y')) {    
    obj.push(obj1);
    obj.push(obj2);
  }

  if (arguments.length >= 3 && arguments[0].classid.toUpperCase() == CLSID_GRID) obj.push(eval(arguments[0].DataID).NameValue(obj2, obj3));

  if(obj1 == "Y"){
	  rtn = window.showModalDialog("/pot/html/common/calendarY.html",obj,"dialogWidth:218px;dialogHeight:130px;scroll:no;resizable:no;help:no;unadorned:yes;center:yes;status:no");
  } else if(obj1 == "M"){
	  rtn = window.showModalDialog("/pot/html/common/calendarM.html",obj,"dialogWidth:218px;dialogHeight:100px;scroll:no;resizable:no;help:no;unadorned:yes;center:yes;status:no");
  }else{
	  if(arguments.length == 4){
		  if(arguments[3] == "Y")
			  rtn = window.showModalDialog("/pot/html/common/calendarY.html",obj,"dialogWidth:218px;dialogHeight:130px;scroll:no;resizable:no;help:no;unadorned:yes;center:yes;status:no");
		  else if(arguments[3] == "M")
			  rtn = window.showModalDialog("/pot/html/common/calendarM.html",obj,"dialogWidth:218px;dialogHeight:100px;scroll:no;resizable:no;help:no;unadorned:yes;center:yes;status:no");
		  else
			  rtn = window.showModalDialog("/pot/html/common/calendar.html",obj,"dialogWidth:280px;dialogHeight:225px;scroll:no;resizable:yes;help:no;center:yes;status:no");
	  }else{
		  rtn = window.showModalDialog("/pot/html/common/calendar.html",obj,"dialogWidth:280px;dialogHeight:225px;scroll:no;resizable:yes;help:no;center:yes;status:no");
	  }
  }
  if (arguments.length >= 3 && arguments[0].classid.toUpperCase() == CLSID_GRID)  eval(arguments[0].DataID).NameValue(obj2, obj3) = rtn;
  
  /*20100513 김경은 
  if (obj1 == "Y"){
      obj2.Focus();
  } else if (obj1 == "G"){
      obj2.Focus();
  } else if (obj1 == "H") {
      obj2.focus();
  } else if (obj1 == "M") {
	  obj2.focus();
  }
  */
  
  // 20100513 김경은 ---------------------------------------
  if(rtn != null) {
	  var strYear   = "";
	  var strMonth  = "";
	  var strDay    = "";
	  if(obj1 == "G" || obj1 == "H"){
		  strYear  = rtn.substr(0,4);
	  	  strMonth = rtn.substr(4,2);
	  	  strDay   = rtn.substr(6,2);
	  }else if(obj1 == "M"){
		  strYear  = rtn.substr(0,4);
	  	  strMonth = rtn.substr(4,2);
	  }else if(obj1 == "Y"){
		  strYear  = rtn.substr(0,4);
	  }
	  
	  fSetDate(obj1, obj2, strYear, strMonth, strDay);
  }
  // -------------------------------------------------------
  
  return rtn;
}

/**
* fSetDate(obj1, obj2, iYear, iMonth, iDay)
* 작 성 자 : 
* 작 성 일 : 
* 개    요 : 선택된 날짜를 세팅한다.
* 사용방법 : getEtcCode("D", "PS01", strDataSet)
*            arguments[0] -> sys_part
*            arguments[1] -> 코드구분 comm_part
*            arguments[2] -> 저장할 DataSet의 ID
* return값 : void
*/
function fSetDate(obj1, obj2, iYear, iMonth, iDay){ 
        switch(arguments[0]){
	        case 'Y' :
	        	arguments[1].Focus();
	        	arguments[1].text = iYear;
			break;
	        case 'M' :
	        	arguments[1].Focus();
	        	arguments[1].text = iYear+""+iMonth;
			break;
	        case 'H' :
            	arguments[1].Focus();
            	arguments[1].value = iYear+"-"+iMonth+"-"+iDay;
                break;
            case 'G' :
            	arguments[1].Focus();
            	arguments[1].text = iYear+""+iMonth+""+iDay;
                break;
            default :
                break;
        }

} 

/**
* getEtcCode(sysPart, comPart, strDataSet)
* 작 성 자 : FKL
* 작 성 일 : 2010-12-30
* 개    요 : 기타 코드  콤보 세팅을 위한 dataSet을 가져오는 함수 
* 사용방법 : getEtcCode("D", "PS01", strDataSet)
*            arguments[0] -> sys_part
*            arguments[1] -> 코드구분 comm_part
*            arguments[2] -> 저장할 DataSet의 ID
* return값 : void
*/

function getEtcCode(strDataSet, sysPart, commPart, allGb, nulGb, objComboNm) {

    DS_I_COMMON.setDataHeader('SYS_PART:STRING(1),COMM_PART:STRING(4),ALL_GB:STRING(1),NUL_GB:STRING(1)');
    
	DS_I_COMMON.ClearData();
	DS_I_COMMON.Addrow();
	DS_I_COMMON.NameValue(1, "SYS_PART")  = sysPart;
	DS_I_COMMON.NameValue(1, "COMM_PART") = commPart;
	DS_I_COMMON.NameValue(1, "ALL_GB")    = allGb ;
	DS_I_COMMON.NameValue(1, "NUL_GB")    = nulGb == null ? 'N' : nulGb ;
	
    TR_MAIN.Action	= "/pot/ccom900.cc?goTo=getEtcCode";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+strDataSet+")";
    TR_MAIN.Post();
    
    //if (allGb == "Y") {
    if (typeof(objComboNm) == "object" ) objComboNm.index = '0';
    //}
}


/**
* getEtcCodeRefer(sysPart, comPart, strDataSet)
* 작 성 자 : FKL
* 작 성 일 : 2010-12-30
* 개    요 : 기타 코드  콤보 세팅을 위한 dataSet을 가져오는 함수 ( REFER_CODE, REFER_VALUE 포함)
* 사용방법 : getEtcCodeRefer("D", "PS01", strDataSet)
*            arguments[0] -> sys_part
*            arguments[1] -> 코드구분 comm_part
*            arguments[2] -> 저장할 DataSet의 ID
* return값 : void
*/

function getEtcCodeRefer(strDataSet, sysPart, commPart, allGb, nulGb, objComboNm) {

    DS_I_COMMON.setDataHeader('SYS_PART:STRING(1),COMM_PART:STRING(4),ALL_GB:STRING(1),NUL_GB:STRING(1)');
    
	DS_I_COMMON.ClearData();
	DS_I_COMMON.Addrow();
	DS_I_COMMON.NameValue(1, "SYS_PART")  = sysPart;
	DS_I_COMMON.NameValue(1, "COMM_PART") = commPart;
	DS_I_COMMON.NameValue(1, "ALL_GB")    = allGb ;
	DS_I_COMMON.NameValue(1, "NUL_GB")    = nulGb == null ? 'N' : nulGb ;
	
    TR_MAIN.Action	= "/pot/ccom900.cc?goTo=getEtcCodeRefer";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+strDataSet+")";
    TR_MAIN.Post();
    
    //if (allGb == "Y") {
    if (typeof(objComboNm) == "object" ) objComboNm.index = '0';
    //}
}

function getPostPop_old(objCd, objNm)
{

    var rtnMap  = new Map();
    var arrArg  = new Array();

    arrArg.push(rtnMap);
	arrArg.push(objCd.Text);

    var returnVal = window.showModalDialog("/pot/ccom430.cc?goTo=list",
                                           arrArg,
                                           "dialogWidth:910px;dialogHeight:450px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		var map = arrArg[0];
		objCd.Text = map.get("POST_NO");
		objNm.Text = map.get("ADDR1");
 	}
}

/**
* getPostPop()
* 작 성 자 : FKL
* 작 성 일 : 2010. 01. 22
* 개    요 : 우편번호 팝업
* 사용방법 : getPostPop(objCd, objNm1,objNm2)
*            arguments[0] -> 팝업 그리드 더블클릭시 우편번호를 받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 주소1을 받아올 EMEDIT ID
*            arguments[2] -> 팝업 그리드 더블클릭시 주소2를 받아올 EMEDIT ID
* return값 : array
*/

function getPostPop(objCd,objNm1,objNm2)
{
    var rtnMap  = new Map();
    var arrArg  = new Array();

    arrArg.push(rtnMap);
	//arrArg.push(objCd.Text);

    var returnVal = window.showModalDialog("/pot/ccom430.cc?goTo=list",
                                           arrArg,
                                           "dialogWidth:910px;dialogHeight:390px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
  	if (returnVal){
		var map = arrArg[0];
		objCd.Text = map.get("POST_NO");
//		objNm1.Text = map.get("ADDR1");
//		objNm2.Text = map.get("ADDR2");
		objNm1.Text = map.get("ADDR2");
		objNm2.Text = "";
		objNm2.Focus();	
 	}
}

function getPostPop2(objPostNo1,objPostNo2,objAddr1,objAddr2){

    var rtnMap  = new Map();
    var arrArg  = new Array();
    var strPost1 = "";
    var strPost2 = "";

    arrArg.push(rtnMap);

    var returnVal = window.showModalDialog("/pot/ccom430.cc?goTo=list",
                                           arrArg,
                                           "dialogWidth:910px;dialogHeight:450px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
  	if (returnVal){
		var map = arrArg[0];
		
		objPostNo1.Text = map.get("POST_NO1");
		objPostNo2.Text = map.get("POST_NO2");
		objAddr1.Text = map.get("ADDR1");
		objAddr2.Text = map.get("ADDR2");
		objAddr2.Focus();	
 	}
}




/** 
* commonPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-01-22
* 개    요 : 공통 Popup
* 사용방법 : commonPop(strBrandCode, strTitle, serviceId, objCd, objNm)
*            arguments[0] -> 윈도우 TITLE BAR 또는 HTML에 보여질 텍스트 
*            arguments[1] -> [ccom911_service.xml] 에 정의한 QUERY의 ID   예) "SEL_USR_MST"
*            arguments[2] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[3] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[m] -> 추가 조건 
*
* 실행  예) commonPop(strBrandCode, "서브 브랜드", "SEL_USR_MST", EM_SBRAND_CD_SUB, EM_SBRAND_NM_SUB);
*
* return값 : void
*/
function commonPop(strTitle, serviceId, objCd, objNm)
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 4, arguments );

    arrArg.push(rtnMap);
	arrArg.push(strTitle);
	arrArg.push(serviceId);
	arrArg.push(objCd.Text);
	if( !objNm.Enable || objNm.ReadOnly ){
		arrArg.push('');
	}else{
		arrArg.push(objNm.Text);
	}
	arrArg.push(addCondition);
	
    var returnVal = window.showModalDialog("/pot/ccom911.cc?goTo=pop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		var map = arrArg[0];
		objCd.Text = map.get("CODE_CD");
		objNm.Text = map.get("CODE_NM");
		return map;
 	}
  	if( objNm.Text == ""){
  		objCd.Text = "";  		
  	}
}



/**
* commonPopToGrid()
* 작 성 자 : ckj
* 작 성 일 : 2006-08-31
* 개    요 : 공통 Popup
* 사용방법 : commonPopToGrid(strTitle, serviceId)
*            arguments[0] -> 윈도우 TITLE BAR 또는 HTML에 보여질 텍스트 
*            arguments[1] -> [ccom911_service.xml] 에 정의한 QUERY의 ID   예) "SEL_USR_MST"
*			 arguments[2] -> 팝업 검색어로 가지고갈 조건...
*            arguments[m] -> 팝업에서 조회시 추가할 조건 
*
* 실행  예) commonPopToGrid("서브 브랜드", "SEL_SBRAND");
*
* return값 : Map (CODE_CD),(CODE_NM)
*/
function commonPopToGrid(strTitle, serviceId, searchCondition)
{

    var rtnMap  	 = new Map();
    var arrArg  	 = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnMap);
	arrArg.push(strTitle);
	arrArg.push(serviceId);
	arrArg.push(searchCondition);
	arrArg.push('');
	arrArg.push(addCondition);
	
    var returnVal = window.showModalDialog("/pot/ccom911.cc?goTo=popToGrid",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
    
  	if (returnVal) return arrArg[0];
    else       return rtnMap;
}

/**
* setAddCondition()
* 작 성 자 : FKL
* 작 성 일 : 2010-01-22
* 개    요 : 공통 POP 쿼리 생성시 사용 
* 사용방법 : setAddCondition(argsLength, arguments)
*            arguments[0] -> 필수조건의 argument 갯수
*            arguments[1] -> 호출한 function 의 argument Object
*
* 실행  예) setAddCondition(5, arguments);
*
* return값 : void
*/
function setAddCondition() {
	var startPoint = arguments[0];
	var args 	   = arguments[1];
	var rvalue = '';
	
	if( args.length > startPoint ) {
		rvalue = args[startPoint];
		for( var i=startPoint+1; i<args.length; i++ ) {
			rvalue += "#G#";
			rvalue += args[i];
		}
	}
	return rvalue;
}

/**
* setAddCondWithColumn()
* 작 성 자 : FKL
* 작 성 일 : 2010-01-22
* 개    요 : 공통 POP 쿼리 생성시 사용 
* 사용방법 : setAddCondWithColumn(argsLength, arguments)
*            arguments[0] -> 조건이외의 argument 갯수
*            arguments[1] -> 호출한 function 의 argument Object
*
* 실행  예) setAddCondWithColumn(5, arguments);
*
* return값 : void
*/
function setAddCondWithColumn() {
	var startPoint = arguments[0];
	var args 	   = arguments[1];
	var rvalue = '';
	
	if( args.length > startPoint ) {
		rvalue = args[startPoint] + ":" + args[startPoint+1];
		for( var i=startPoint+2; i<args.length; i+=2 ) {
			rvalue += "#G#";
			rvalue += args[i] + ":" + args[i+1];
		}
	}
	return rvalue;
}


/**
* setNmWithoutPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-01-22
* 개    요 : 팝업 없이 코드 입력후  키업 이벤트시 코드명 셋팅 
* 사용방법 : setNmWithoutPop(strDataSet, strTitle, serviceId, objCd, objNm)
*            arguments[0] -> Output용 dataset 문자  	예)"DS_O_SBRAND"
*            arguments[1] -> 윈도우 TITLE BAR 또는 HTML에 보여질 텍스트 
*            arguments[2] -> [ccom911_service.xml] 에 정의한 QUERY의 ID   예) "SEL_SBRAND"
*            arguments[3] -> 코드를 받아올 EMEDIT ID
*            arguments[4] -> 이름을 받아올 EMEDIT ID
*
* 실행 예) setNmWithoutPop('DS_O_RESULT', '담당자', 'SEL_USR_MST', EM_CORP_NO, EM_REP_NAME);
*
* return값 : void
*/
function setNmWithoutPop(strDataSet, strTitle, serviceId, objCd, objNm){
	if(trim(objCd.Text) == ""){
		objNm.Text = "";
		return;
	}
	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);
	var codeCd = objCd.Text;
	var cdSize = objCd.Format.length;

	DS_I_CONDITION.setDataHeader( 'SERVICE_ID:STRING(50),CODE_CD:STRING(60),ADD_CONDITION:STRING(100)' );
	
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "SERVICE_ID") 		= serviceId;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "CODE_CD")    		= codeCd;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION")   = addCondition;
	
	TR_MAIN.Action	 = "/pot/ccom911.cc?goTo=getOneWithoutPop";
	TR_MAIN.KeyValue = "SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
	TR_MAIN.Post();

	if (dataSetId.countRow == 0) {
		objNm.text = "";
	}else{
		objCd.Text = dataSetId.NameValue(dataSetId.RowPosition, "CODE_CD");
		objNm.Text = dataSetId.NameValue(dataSetId.RowPosition, "CODE_NM");
	}
}

/**
* setUserNmWithoutPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-01-22
* 개    요 : 사원명 팝업 없이 코드 입력후  키업 이벤트시 코드명 셋팅 (응용) 
* 사용방법 : setUserNmWithoutPop(strDataSet, strTitle, serviceId, objCd, objNm, searchTp)
*            arguments[0] -> Output용 dataset 문자  	예)"DS_O_SBRAND"
*            arguments[1] -> 윈도우 TITLE BAR 또는 HTML에 보여질 텍스트 
*            arguments[2] -> [ccom911_service.xml] 에 정의한 QUERY의 ID   예) "SEL_SBRAND"
*            arguments[3] -> 코드를 받아올 EMEDIT ID
*            arguments[4] -> 이름을 받아올 EMEDIT ID
*            arguments[5] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            arguments[m] -> 추가조건  
*
* 사용 예) setUserNmWithoutPop('DS_O_RESULT', '담당자', 'SEL_USR_MST', EM_CORP_NO, EM_REP_NAME, 0);
*
* return값 : void
*/
function setUserNmWithoutPop(strDataSet, strTitle, serviceId, objCd, objNm, searchTp){
	if(trim(objCd.Text) == ""){
		objNm.Text = "";
		return;
	}
	var addCondition = setAddCondition( 6, arguments );
	var dataSetId = eval(strDataSet);
	var codeCd = objCd.Text;
	var cdSize = objCd.Format.length;

	DS_I_CONDITION.setDataHeader( 'SERVICE_ID:STRING(50),CODE_CD:STRING(60),ADD_CONDITION:STRING(100)' );
	
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "SERVICE_ID") 		= serviceId;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "CODE_CD")    		= codeCd;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION")   = addCondition;
	
	TR_MAIN.Action	 = "/pot/ccom911.cc?goTo=getOneWithoutPop";
	TR_MAIN.KeyValue = "SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
	TR_MAIN.Post();

	if (dataSetId.countRow == 1) {
		objNm.Text = dataSetId.NameValue(dataSetId.RowPosition, "CODE_NM");
	}else{
		objNm.text = "";
		if(searchTp == "1"){
 			commonPop('사원', 'SEL_USR_MST_TEST', objCd, objNm);
		}else{
			if(cdSize == objCd.text.length){ objCd.text = ""; }
		}
	}
}

/**
* setNmToDataSet()
* 작 성 자 : FKL
* 작 성 일 : 2010-01-22
* 개    요 : 팝업 없이 코드 입력후  키업 이벤트시 코드,코드명 DataSet에 셋팅 
* 사용방법 : setNmToDataSet(strDataSet, serviceId, codeCd)
*            arguments[0] -> Output용 dataset 문자  	예)"DS_O_SBRAND"
*            arguments[1] -> [ccom911_service.xml] 에 정의한 QUERY의 ID   예) "SEL_SBRAND"
*            arguments[2] -> 조회 조건이 될 코드
*            arguments[m] -> 추가조건 
*
* 실행 예) setNmToDataSet("DS_O_SBRAND", "SEL_SBRAND", "02");
*
* return값 : void
*/
function setNmToDataSet(strDataSet, serviceId, codeCd) {
	var addCondition = setAddCondition( 3, arguments );
	
	DS_I_CONDITION.setDataHeader( 'SERVICE_ID:STRING(50),CODE_CD:STRING(100),ADD_CONDITION:STRING(500)' );
	
    DS_I_CONDITION.ClearData();
    DS_I_CONDITION.Addrow();
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "SERVICE_ID") 		= serviceId;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "CODE_CD")    		= codeCd;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION")   = addCondition;
    TR_MAIN.Action	 = "/pot/ccom911.cc?goTo=getOneWithoutPop";
    TR_MAIN.KeyValue = "SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();
	
}



/**
* setDataSet()
* 작 성 자 : ckj
* 작 성 일 : 2006-09-08
* 개    요 : 쿼리 서비스ID와 조건을 이용하여 DataSet에 셋팅 
* 사용방법 : setDataSet(strDataSet, serviceId)
*            arguments[0] -> Output용 dataset 문자  	예)"DS_O_SBRAND"
*            arguments[1] -> [ccom911_service.xml] 에 정의한 QUERY의 ID   예) "SEL_SBRAND"
*            arguments[m] -> 추가조건 
*
*
* 실행 예) setDataSet("DS_O_SBRAND", "SEL_SBRAND");
*
* return값 : DS_O_RESULT(COL1, COL2, COL3, COL4, COL5)
*/
function setDataSet(strDataSet, serviceId) {
	var addCondition = setAddCondition( 2, arguments );
	
	DS_I_CONDITION.setDataHeader( 'SERVICE_ID:STRING(50),ADD_CONDITION:STRING(100)' );
	
    DS_I_CONDITION.ClearData();
    DS_I_CONDITION.Addrow();
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "SERVICE_ID") 		= serviceId;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION")   = addCondition;
    
    TR_MAIN.Action	 = "/pot/ccom911.cc?goTo=getCommonDataSet";
    TR_MAIN.KeyValue = "SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();
}

/**
* commonPopOnlyCd()
* 작 성 자 : 김완규
* 작 성 일 : 2006-08-29
* 개    요 : 공통 Popup중 조회결과에 CODE만을 나타내는 팝업
* 사용방법 : commonPop(strBrandCode, strTitle, serviceId, objCd)
*            arguments[0] -> 윈도우 TITLE BAR 또는 HTML에 보여질 텍스트 
*            arguments[1] -> [ccom911_service.xml] 에 정의한 QUERY의 ID   예) "SEL_RELCODE1"
*            arguments[2] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[m] -> 추가 조건
*
* 실행  예) commonPopOnlyCd("관리코드1", "SEL_RELCODE1", EM_RELCODE1);
*
* return값 : void
*/
function commonPopOnlyCd(strTitle, serviceId, objCd)
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
    var addCondition = setAddCondition( 3, arguments );
    
    arrArg.push(rtnMap);
	arrArg.push(strTitle);
	arrArg.push(serviceId);
	arrArg.push(objCd.Text);
	arrArg.push(addCondition);
		 
    var returnVal = window.showModalDialog("/pot/ccom911.cc?goTo=popOnlyCd",
                                           arrArg,
                                           "dialogWidth:450px;dialogHeight:525px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		var map = arrArg[0];
		objCd.Text = map.get("CODE_CD");
 	}
 	
}


/*------------------------------------------------------------------------------------------------*/

/**
* getCloseChk()
* 작 성 자 : ckj
* 작 성 일 : 2006-09-25
* 개    요 : 마감 날짜 체크 
* 사용방법 : getCloseChk(strDataSet, brandCd, ipgoDt)
*            arguments[0] -> Output용 dataset 문자  	예)"DS_O_SBRAND"
*            arguments[1] -> 브랜드 코드 
*            arguments[2] -> 입고날짜 
*
*
* 실행 예) getCloseChk("DS_O_RESULT", "01", "20060912");
*
* return값 : DS_O_RESULT(COL1, COL2, COL3, COL4, COL5)
*/
function getCloseChk(strDataSet, brandCd, ipgoDt) {
	setDataSet(strDataSet, "SEL_CLOSE", brandCd, ipgoDt, brandCd, ipgoDt );	
}

/**
* getLastDay()
* 작 성 자 : ckj
* 작 성 일 : 2006-09-25
* 개    요 : 전월 마지막 날짜 
* 사용방법 : getLastDay(strDataSet, ipgoDt)
*            arguments[0] -> Output용 dataset 문자  	예)"DS_O_SBRAND"
*            arguments[1] -> 입고날짜 
*
*
* 실행 예) getLastDay("DS_O_RESULT", "20060912");
*
* return값 : DS_O_RESULT(COL1, COL2, COL3, COL4, COL5)
*/
function getLastDay(strDataSet, ipgoDt) {
	setDataSet(strDataSet, "SEL_LASTDAY", ipgoDt);	
}



/**
* getArrayData()
* 작 성 자 : 배형순
* 작 성 일 : 2006. 08. 14
* 개    요  : 
*            
* return값 : array
*/  
function getArrayData(arrObj, row, colid)
{
	if (arrObj.length > 0 ) 
	{
		for(var i=0;arrObj[0].length;i++)
		{
			if(arrObj[0][i] == colid)
			{
				return arrObj[row][i];
			}
		}
	} 
	else 
	{
		return '';
	}
}


/**
* multiCodePop()
* 작 성 자 : 배형순
* 작 성 일 : 2006. 08. 09
* 개    요 : 코드 Pop-Up(Multi Select)
* 특이사항 :
* return값 : array
*/
function multiCodePop(strBunryuCode, strCode, ChkList)
{

    var rtnMap  = new Map();
    var arrArg  = new Array();

    arrArg.push(rtnMap);
    arrArg.push(strBunryuCode);
    arrArg.push(strCode);
    arrArg.push(ChkList);
    
    var returnVal = window.showModalDialog("/danpum/gcod902.gc?goTo=list",
                                           arrArg,
                                           "dialogWidth:500px;dialogHeight:525px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
                                           

  	if (typeof(returnVal) != "object") 
  	{
		return new Array();
  	}
  	else 
  	{
	    if (returnVal.length != 0)
	    {
	        return returnVal;
	    } 
	    else 
	    {
	        return new Array();
	    }
	}
}


/** 
* orgMstToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-15
* 개    요 : 조직 Popup(Grid)
* 사용방법 : orgMstToGridPop( strCd, strNm, authGb, strGbn  )  
*            arguments[0] -> 팝업 할 그리드의 코드
*            arguments[1] -> 팝업 할 그리드의 명
*            arguments[2] -> 권한 체크 여부
*            arguments[3] -> 팝업 위치 콜id
*            //--추가조건-- 
*            arguments[4] -> 조직구분
*            arguments[5] -> 점코드
*            arguments[6] -> 부문코드
*            arguments[7] -> 팀코드
*            arguments[8] -> PC코드
*            arguments[9] -> 사용여부
*            arguments[10]-> 조직명
*
* 실행  예) orgMstToGridPop( "CODE", "", "", "DEPT_CD");
*
* return값 : map
*              CODE     --> 콜ID 코드
               NAME     --> 콜ID 명 
*/
function orgMstToGridPop( strCd, strNm, authGb, strGbn  )
{
    var rtnMap  = new Map();
    var arrArg  = new Array(); 
    
    var addCondition = setAddCondition(4, arguments ); 
    
    arrArg.push(rtnMap);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push(authGb); 
	arrArg.push(strGbn); 
	arrArg.push(addCondition);
	 
    var returnVal = window.showModalDialog("/pot/ccom912.cc?goTo=orgPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:365px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
 
  	if (returnVal){
		var map = arrArg[0];
		return map;
 	} 
	return null;
	 
} 

/** 
* orgMstWithoutToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-15
* 개    요 : 조직코드 입력시 명칭 갖고오기(Grid)
* 사용방법 : orgMstWithoutToGridPop( strDS, strCd, strGbn, searchTp  )  
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 팝업 위치 콜id      
*            arguments[3] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건-- 
*            arguments[4] -> 조직구분
*            arguments[5] -> 점코드
*            arguments[6] -> 부문코드
*            arguments[7] -> 팀코드
*            arguments[8] -> PC코드
*            arguments[9] -> 사용여부
*            arguments[10]-> 조직명 
*
* 실행  예) orgMstWithoutToGridPop('DS_GRID_NM', newValue, "DEPT_CD", '1';
* 
* return값 : map
*              CODE     --> 콜ID 코드
               NAME     --> 콜ID 명 
*/
function orgMstWithoutToGridPop(strDataSet, strCd, strGbn,  searchTp){
	var addCondition = setAddCondition(4, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('CODE:STRING(20), GBN:STRING(20),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "CODE") 	= strCd;  
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "GBN") 	= strGbn;  
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition; 

    TR_MAIN.Action="/pot/ccom912.cc?goTo=searchOnPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  
     
    if (dataSetId.countRow == 1) {
    	var rtnMap  = new Map();
   	    for(var i=1;i<=dataSetId.CountColumn;i++)
        {
   	    	rtnMap.put(dataSetId.ColumnID(i), dataSetId.NameValue(1, dataSetId.ColumnID(i)));
        }
   	    return rtnMap;
	}else{
		if(searchTp == "1"){
			if(addCondition == "") 
				return orgMstToGridPop( strCd, '', '', strGbn); 
			else
				return orgMstToGridPop( strCd, '', '', strGbn, addCondition); 
		}else{
			return null;
		}
	}
}    
/**
* helpPop()
* 작 성 자 : HSEON
* 작 성 일 : 2010-06-21
* 개    요 : 도움말 팝업
* 사용방법 : helpPop(strPid:프로그램ID)
* 실행  예) helpPop("TCOM101");
* return값 : void
*/
function helpPop(strPid)
{
    var returnVal = window.showModalDialog("/pot/ccom913.cc?goTo=helpPop",
    										strPid,
                                           "dialogWidth:850px;dialogHeight:700px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
}

/**
* NoticeMainPop()
* 작 성 자 : HSEON
* 작 성 일 : 2010-06-21
* 개    요 : 공지사항 팝업
* 사용방법 : NoticeMainPop(strFlag : 전체/부문)
* 실행  예) NoticeMainPop("TCOM101");
* return값 : void
*/
function NoticeMainPop(strNotiid)
{ 
    var returnVal = window.showModalDialog("/pot/ccom914.cc?goTo=noticeMainPop",
    									   "&strNoti=" + strNotiid,
    									   "dialogWidth:850px;dialogHeight:700px;scroll:no;" +
    									   "resizable:no;help:no;unadorned:yes;center:yes;status:no");
}

/**
* NoticeMainPop2()
* 작 성 자 : SBCHO
* 작 성 일 : 2012-06-11
* 개    요 : 공지사항 팝업 조회자 등록 포함
* 사용방법 : NoticeMainPop2(strFlag : 전체/부문, userid : 사용자 id)
* 실행  예) NoticeMainPop2("TCOM101", "fkl");
* return값 : void
*/
function NoticeMainPop2(strNotiid, userid)
{ 
    var returnVal = window.showModalDialog("/pot/ccom914.cc?goTo=noticeMainPop",
    									   "&strNoti=" + strNotiid + "&userid=" + userid,
    									   "dialogWidth:850px;dialogHeight:700px;scroll:no;" +
    									   "resizable:no;help:no;unadorned:yes;center:yes;status:no");
}
