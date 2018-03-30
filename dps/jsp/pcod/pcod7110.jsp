<!-- 
/*******************************************************************************
 * 시스템명 : 기준정보 > 행사코드 > 행사장 POS관리
 * 작 성 일 : 2016.10.24
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : pcod7110.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 행사장 POS관리 한다.
 * 이    력 :
 *        2016.10.24 (박래형) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<% request.setCharacterEncoding("utf-8"); %> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"  prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"      prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"   prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%String dir = BaseProperty.get("context.common.dir");%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"   type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                      *-->
<!--*************************************************************************-->
 
<script LANGUAGE="JavaScript">
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
var onPopup  = false;
var nTopSize = 330;

// 현재일자
var strToday   = "";

// 디테일 조회구분
var gAllSearch = true;

// 데이터셋 이벤트 실행여부
var gEvtFlag   = true;   

//저장시점 Value
var gSaveVal = { 
                 FLAG  : false 
               };

/**
 * doInit()
 * 작 성 자 : 박래형
 * 작 성 일 : 2016-10-24
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
	// 그리드 높이 자동 지정
	var obj   = document.getElementById("GD_DETAIL1"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-nTopSize) + "px";
	 
	var obj   = document.getElementById("GD_DETAIL2"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-nTopSize) + "px";

    // Data Set Header 초기화
    DS_MASTER.setDataHeader ('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_DETAIL1.setDataHeader('<gauce:dataset name="H_SEL_DETAIL1"/>');
    DS_DETAIL2.setDataHeader('<gauce:dataset name="H_SEL_DETAIL2"/>');

    // EMedit에 초기화

    // 콤보 초기화
    initComboStyle(LC_STR_CD,         DS_STR_CD,         "CODE^0^30,NAME^0^140", 1, PK);  // 점(조회)
    initComboStyle(LC_EVENT_PLACE_CD, DS_EVENT_PLACE_CD, "CODE^0^30,NAME^0^140", 1, PK);  // 행사장(조회)
    
    // 공통 데이터 가져오기
    getStore("DS_STR_CD", "Y", "", "N");			// 점
    getEtcCode("DS_HALL_CD", "D", "P197", "Y");		// 관
    getEtcCode("DS_FLOR_CD", "D", "P061", "Y");		// 층
    getEtcCode("DS_USE_YN", "D", "P091", "Y");		// 사용여부 

    // 콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_STR_CD, '<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if(LC_STR_CD.Index < 0) LC_STR_CD.Index = 0; 
    
    // 행사장 콤보
    getEventPlaceCode("DS_EVENT_PLACE_CD", LC_STR_CD.BindColVal, "Y", "");
    LC_EVENT_PLACE_CD.Index = 0; 
    
    // 그리드 초기화
    gridCreate();
    
    // 기타 오브젝트 콘트롤
    fnSetObj(false);

    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pcod711","DS_MASTER,DS_DETAIL1,DS_DETAIL2" );
    
    // 현재일자 세팅
    strToday   = getTodayDB("DS_TODAY");
    
    // 로딩 후 포커스 위치 설정
    LC_STR_CD.Focus();
}

/**
 * gridCreate()
 * 작 성 자 : 박래형
 * 작 성 일 : 2016-10-24
 * 개    요 : 그리드 초기화 
 * return값 : void
 */
function gridCreate(){
	var hdrProperies = "";
	
	// 행사장 마스터 그리드
    hdrProperies = '<FC>id={currow}         width=25   align=center  name="NO"         </FC>'
                 + '<FC>id=STR_CD           width=80   align=left    name="점"         EditStyle=Lookup   Data="DS_STR_CD:CODE:NAME" </FC>'
                 + '<FG>name="행사장"'                                 
                 + '<FC>id=EVENT_PLACE_CD   width=60   align=center  name="코드"       </FC>'
                 + '<FC>id=EVENT_PLACE_NAME width=150  align=left    name="명"         </FC>'
                 + '</FG>'                                               
                 + '<FC>id=EVENT_POSITION   width=120  align=left    name="행사장위치" </FC>'
                 + '<FC>id=AREA_SIZE        width=80   align=right   name="면적"       </FC>'
                 + '<FC>id=FLOR_CD          width=80   align=left    name="층"         EditStyle=Lookup   Data="DS_FLOR_CD:CODE:NAME" </FC>'
                 + '<FC>id=USE_YN           width=60   align=center  name="사용여부"   EditStyle=Lookup   Data="DS_USE_YN:CODE:NAME"  </FC>'
                 ;
    initGridStyle(GD_MASTER, "common", hdrProperies, false);

	// 행사장별 POS 그리드
    hdrProperies = '<FC>id={currow}         width=25   align=center  name="NO"   edit=none </FC>'
                 + '<FC>id=CHK              width=60   align=center  name="선택" HeadCheckShow=true EditStyle=CheckBox </FC>'
                 + '<FG>name="POS"'                                 
                 + '<FC>id=POS_NO           width=60   align=center  name="번호" EditStyle=Popup  edit={IF(SysStatus="I","true","false")} </FC>'
                 + '<FC>id=POS_NAME         width=150  align=left    name="명"   edit=none</FC>'
                 + '</FG>'   
                 + '<FC>id=HALL_CD          width=80   align=left    name="관"   EditStyle=Lookup Data="DS_HALL_CD:CODE:NAME" edit=none</FC>'
                 + '<FC>id=FLOR_CD          width=80   align=left    name="층"   EditStyle=Lookup Data="DS_FLOR_CD:CODE:NAME" edit=none</FC>'
                 ;
    initGridStyle(GD_DETAIL1, "common", hdrProperies, true);

	// 제외 브랜드 그리드
    hdrProperies = '<FC>id={currow}         width=25   align=center  name="NO"   edit=none </FC>'
                 + '<FC>id=CHK              width=60   align=center  name="선택" HeadCheckShow=true EditStyle=CheckBox </FC>'
                 + '<FG>name="브랜드"'                                 
                 + '<FC>id=EX_PUMBUN_CD     width=120  align=center  name="코드" EditStyle=Popup  edit={IF(SysStatus="I","true","false")} </FC>'
                 + '<FC>id=PUMBUN_NAME      width=150  align=left    name="명"   edit=none</FC>'
                 + '</FG>'   
                 + '<FC>id=SALE_DT          width=100  align=center  name="일자" mask="XXXX/XX/XX" EditStyle=Popup edit=numeric </C>'
                 ;
    initGridStyle(GD_DETAIL2, "common", hdrProperies, true);
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search()
     (2) 신규       - btn_New()
     (3) 삭제       - btn_Delete()
     (4) 저장       - btn_Save()
     (5) 엑셀       - btn_Excel()
     (6) 출력       - btn_Print()
     (7) 확정       - btn_Conf()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자 : 박래형
 * 작 성 일 : 2016-10-24
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {

	// 값 체크
	if(!fnChkValidation("search")) return;
    
    var strCd           = LC_STR_CD.BindColVal;
    var strEventPlaceCd = LC_EVENT_PLACE_CD.BindColVal;
    
    var goTo         = "searchMaster" ;    
    var action       = "O";  
    var parameters   = "&strStrCd="        + encodeURIComponent(strCd)
                     + "&strEventPlaceCd=" + encodeURIComponent(strEventPlaceCd)
    TR_SEARCH_MASTER.Action   ="/dps/pcod711.pc?goTo="+goTo+parameters;  
    TR_SEARCH_MASTER.KeyValue ="SERVLET("+action+":DS_MASTER=DS_MASTER)";
    TR_SEARCH_MASTER.Post();
    
    // 조회 후 결과표시
    setPorcCount("SELECT", GD_MASTER);
}

/**
 * btn_New()
 * 작 성 자 : 박래형
 * 작 성 일 : 2016-10-24
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    gAllSearch = false;
}

/**
 * btn_Delete()
 * 작 성 자 : 박래형
 * 작 성 일 : 2016-10-24
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
    gAllSearch = false;
}

/**
 * btn_Save()
 * 작 성 자 : 박래형
 * 작 성 일 : 2016-10-24
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {

	// 값 체크
	if(!fnChkValidation("save")) return;
	
    var goTo       = "save";    
    var action     = "I";  
    TR_SAVE.Action="/dps/pcod711.pc?goTo="+goTo;
    TR_SAVE.KeyValue="SERVLET("+action+":DS_DETAIL1=DS_DETAIL1,"+action+":DS_DETAIL2=DS_DETAIL2)";
    TR_SAVE.Post();    
}

/**
 * btn_Excel()
 * 작 성 자 : 박래형
 * 작 성 일 : 2016-10-24
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
}

/**
 * btn_Print()
 * 작 성 자 : 박래형
 * 작 성 일 : 2016-10-24
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
}

/**
 * btn_Conf()
 * 작 성 자 : 박래형
 * 작 성 일 : 2016-10-24
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

/**
 * searchDetail()
 * 작 성 자 : 박래형
 * 작 성 일 : 2016-10-24
 * 개    요 : 행사장별 POS, 제외브랜드 조회
 * return값 : void
 */
function searchDetail() {
	var strCd           = DS_MASTER.NameValue(DS_MASTER.Rowposition, "STR_CD");
	var strEventPlaceCd = DS_MASTER.NameValue(DS_MASTER.Rowposition, "EVENT_PLACE_CD");
	
	var goTo         = "searchDetail";    
	var action       = "O";  
	var parameters   = "&strStrCd="        + encodeURIComponent(strCd)
	                 + "&strEventPlaceCd=" + encodeURIComponent(strEventPlaceCd)
	                 ;
	
// 	alert("parameters = " + parameters);
	TR_SEARCH_DETAIL.Action   ="/dps/pcod711.pc?goTo="+goTo+parameters;  
	TR_SEARCH_DETAIL.KeyValue="SERVLET("+action+":DS_DETAIL1=DS_DETAIL1,"+action+":DS_DETAIL2=DS_DETAIL2)";
	TR_SEARCH_DETAIL.Post();
}
 
/**
 * fnChkValidation()
 * 작 성 자 : 박래형
 * 작 성 일 : 2016-10-24
 * 개    요 : 트랜잭션 발생전 값 체크
 * return값 : boolean
 */
function fnChkValidation(strSid){
	
	switch(strSid){

		// 조회
		case "search":    
			if( LC_STR_CD.BindColVal == ""){
		        // (점)은/는 반드시 입력해야 합니다.
		        showMessage(EXCLAMATION, OK, "USER-1002", "점");
		        LC_STR_CD.Focus();
		        return false;
		    }
			
	        // 변경된 상세내역이 존재합니다. 조회하시겠습니까?
		    if(DS_DETAIL1.IsUpdated || DS_DETAIL2.IsUpdated){
		    	if( showMessage(QUESTION, YESNO, "USER-1059") != 1) return false;
		    }
	
		    DS_DETAIL1.ClearData();
		    DS_DETAIL2.ClearData();
		    DS_MASTER.ClearData();
		    gAllSearch = true;
		    return true;
			break;

	    // 저장
		case "save":
	        // 저장할 내용이 없습니다.
		    if (!DS_DETAIL1.IsUpdated && !DS_DETAIL2.IsUpdated){
		        showMessage(INFORMATION, OK, "USER-1028");
		        return false;
		    }
	        
	        // 행사장별 POS 관리
            for(nRow = 1; nRow <= DS_DETAIL1.CountRow; nRow++){
                
                var strRowStatus = DS_DETAIL1.RowStatus(nRow);
                var strPosNo     = DS_DETAIL1.NameValue(nRow, "POS_NO");
                var strPosName   = DS_DETAIL1.NameValue(nRow, "POS_NAME");
                
                // 입력 수정시에만 체크한다.
                if (strRowStatus == 1 || strRowStatus == 3) {
                    
                    if(strPosName == ""){
                        showMessage(EXCLAMATION, OK, "USER-1003", "POS번호");
                    	setFocusGrid(GD_DETAIL1, DS_DETAIL1, nRow, "POS_NO");
                        return false;
                    }
                    
                    // 중복체크(POS번호)
                    if(gfnCheckDup(DS_DETAIL1, strPosNo, "POS_NO") > 1){
                    	DS_DETAIL1.Rowposition = nRow;
                        showMessage(INFORMATION, Ok, "USER-1000", "중복된 POS번호(" + strPosNo + ")가 존재합니다.");
                    	setFocusGrid(GD_DETAIL1, DS_DETAIL1, nRow, "POS_NO");
                        return false;
                    }
                }
            }
	        
	        // 제외 브랜드 관리
            for(nRow = 1; nRow <= DS_DETAIL2.CountRow; nRow++){
                
                var strRowStatus = DS_DETAIL2.RowStatus(nRow);
                var strPbCd      = DS_DETAIL2.NameValue(nRow, "EX_PUMBUN_CD");
                var strPbNm      = DS_DETAIL2.NameValue(nRow, "PUMBUN_NAME");
                var strSaleDt    = DS_DETAIL2.NameValue(nRow, "SALE_DT");
                
                // 입력 수정시에만 체크한다.
                if (strRowStatus == 1 || strRowStatus == 3) {
                    
                    if(strPbNm == ""){
                        showMessage(EXCLAMATION, OK, "USER-1003", "브랜드코드");
                    	setFocusGrid(GD_DETAIL2, DS_DETAIL2, nRow, "EX_PUMBUN_CD");
                        return false;
                    }
                    
                    if(strSaleDt == ""){
                        showMessage(EXCLAMATION, OK, "USER-1003", "일자");
                    	setFocusGrid(GD_DETAIL2, DS_DETAIL2, nRow, "SALE_DT");
                        return false;
                    }
                    
                    if(!checkYYYYMMDD(strSaleDt)){
                        showMessage(INFORMATION, Ok, "USER-1000", "(YYYYMMDD)날짜 형식이 아닙니다.");
                    	setFocusGrid(GD_DETAIL2, DS_DETAIL2, nRow, "SALE_DT");
                        return false;
                    }
                    
                    // 중복체크 (제외브랜드, 날짜)
                    if(gfnCheckDup(DS_DETAIL2, strPbCd + strSaleDt, "EX_PUMBUN_CD:SALE_DT") > 1){
                    	DS_DETAIL2.Rowposition = nRow;
                        showMessage(INFORMATION, Ok, "USER-1000", "중복된 코드(" + strPbCd + ":" + strSaleDt + ")가 존재합니다.");
                    	setFocusGrid(GD_DETAIL2, DS_DETAIL2, nRow, "EX_PUMBUN_CD");
                        return false;
                    }
                }
            }

		    //변경또는 신규 내용을 저장하시겠습니까?
		    if(showMessage(QUESTION, YESNO, "USER-1010") == 1){
                gSaveVal.FLAG = true;
    		    gAllSearch    = false;
    		    return true;
		    }else{
                return false;
		    }
			break;
	
		default:
			return false;
			break;
	}
}

/**
 * btn_addRow(strFlag)
 * 작 성 자 : 박래형
 * 작 성 일 : 2016-10-24
 * 개    요 : 행추가
 * return값 : void
 */
function btn_addRow(strFlag){

	// 행사장 마스터가 없으면 등록X
	if(DS_MASTER.CountRow < 1){
	    showMessage(INFORMATION, OK, "USER-1025");
	    return;
	}
 
	var strStrCd        = DS_MASTER.NameValue(DS_MASTER.Rowposition, "STR_CD");
	var strEventPlaceCd = DS_MASTER.NameValue(DS_MASTER.Rowposition, "EVENT_PLACE_CD");
	
	var objDs = null;
	var objGd = null;
	var strFocusColId = "";
	
	if(strFlag == "DTL1"){			// 행사장별 POS
		objDs = DS_DETAIL1;
		objGd = GD_DETAIL1;
		strFocusColId = "POS_NO";
		
		var nNewCnt = 0;
		for(var i = 1; i <= objDs.CountRow; i++){
			if(objDs.RowStatus(i) == "1" && objDs.NameValue(i, "POS_NO") == "") nNewCnt++;
		}
		if(nNewCnt > 0){
			showMessage(INFORMATION, Ok, "USER-1000", "이미 신규행이 존재합니다.");
			setFocusGrid(objGd, objDs, objDs.Rowposition, strFocusColId);
			return;
		}
	    
	}else if(strFlag == "DTL2"){	// 제외 브랜드 관리
		objDs = DS_DETAIL2;
		objGd = GD_DETAIL2;
		strFocusColId = "EX_PUMBUN_CD";
	}
	
	objDs.Addrow();
	objDs.NameValue(objDs.Rowposition, "STR_CD")         = strStrCd;
	objDs.NameValue(objDs.Rowposition, "EVENT_PLACE_CD") = strEventPlaceCd;

	if(strFlag == "DTL2"){	// 제외 브랜드 관리
		objDs.NameValue(objDs.Rowposition, "SALE_DT") = strToday;
	}
	
	// 포커스
	setFocusGrid(objGd, objDs, objDs.Rowposition, strFocusColId);
}

/**
 * btn_delRow(strFlag)
 * 작 성 자 : 박래형
 * 작 성 일 : 2016-10-24
 * 개    요 : 행삭제
 * return값 : void
 */
function btn_delRow(strFlag){
	 
	var objDs = null;
	var objGd = null;
	
	if(strFlag == "DTL1"){			// 행사장별 POS
		objDs = DS_DETAIL1;
		objGd = GD_DETAIL1;
	}else if(strFlag == "DTL2"){	// 제외 브랜드 관리
		objDs = DS_DETAIL2;
		objGd = GD_DETAIL2;
	}

	objGd.redraw = false;
    var strChk       = "";
    var strRowStatus = "";
    
    for(var i=objDs.CountRow; i>0; --i){
        strRowStatus = objDs.RowStatus(i);
        strChk       = objDs.NameValue(i, "CHK");
//         if(strRowStatus != "1") continue;
        if(strChk       != "T") continue;
        
        objDs.DeleteRow(i);
    }
    objGd.redraw = true;
}

/**
 * fnSetObj()
 * 작 성 자 : 박래형
 * 작 성 일 : 2016-10-24
 * 개    요 : 마스터 컨트롤러 상요여부지정
 * return값 : void
 */
function fnSetObj(strFlag){
    enableControl(IMG_ADD_ROW1, strFlag);
    enableControl(IMG_DEL_ROW1, strFlag);
    enableControl(IMG_ADD_ROW2, strFlag);
    enableControl(IMG_DEL_ROW2, strFlag);
}

/**
 * fnCallPopupPosNo()
 * 작 성 자 : 박래형
 * 작 성 일 : 2016-10-24
 * 개    요 : 행사장별 POS POPUP
 * return값 : void
 */
function fnCallPopupPosNo(objGrd, strEvt, strMulti){
	
	var objDs  = eval(objGrd.DataID);	// 그리드에 바인딩된 데이터셋
	var nDsRow = objDs.Rowposition;		// 그리드에 바인딩된 데이터셋의 현재row

    var OBJPARAMS = { PID     : "PCOD711"
                    , EVTFLAG : strEvt
                    , MULTI   : strMulti
    		        , PARAMS  : { STR_CD : objDs.NameValue(nDsRow, "STR_CD")
    		        	        , POS_NO : objDs.NameValue(nDsRow, "POS_NO")
    		                    }
                    };
    var returnList = gfnCallByPopUpPosNo("DS_POP", OBJPARAMS);	// POS 조회

    gEvtFlag = false;
    if(returnList == undefined || returnList.length <= 0){
        gEvtFlag = true;
    	return;
    }

//     objGrd.Redraw = false;
	var strStrCd        = DS_MASTER.NameValue(DS_MASTER.Rowposition, "STR_CD");
	var strEventPlaceCd = DS_MASTER.NameValue(DS_MASTER.Rowposition, "EVENT_PLACE_CD");
	
    for(var i = 0; i < returnList.length; i++){
    	if(i != 0) objDs.AddRow();
    	objDs.NameValue(objDs.Rowposition, "STR_CD")         = strStrCd;
    	objDs.NameValue(objDs.Rowposition, "EVENT_PLACE_CD") = strEventPlaceCd;
        objDs.NameValue(objDs.Rowposition, "POS_NO")         = returnList[i]["POS_NO"];
        objDs.NameValue(objDs.Rowposition, "POS_NAME")       = returnList[i]["POS_NAME"];
        objDs.NameValue(objDs.Rowposition, "HALL_CD")        = returnList[i]["HALL_CD"];
        objDs.NameValue(objDs.Rowposition, "FLOR_CD")        = returnList[i]["FLOR_CD"];
    }
    gEvtFlag = true;
//     objGrd.Redraw = true;
//     setTimeout("setFocusGrid(GD_DETAIL1, DS_DETAIL1, "+row+", 'POS_NO');" ,50);
}

/**
 * setPumbunCodeToGrid()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 브랜드명을 등록한다.(Grid)
 * return값 : void
 */
function setPumbunCodeToGrid(evnflag, row){
    var code    = DS_DETAIL2.NameValue(row,"EX_PUMBUN_CD");
    var strCd   = DS_DETAIL2.NameValue(row,"STR_CD");
    var floorCd = "";
    
    if( code == "" && evnflag != "POP" ){
        DS_DETAIL2.NameValue(row,"PUMBUN_NAME") = "";
        return;     
    }
    var rtnMap = null;
    if( evnflag == "POP" ){
        rtnMap = strPbnToGridPop(code,'','Y','', strCd, '','','','','Y','','','','','','',floorCd);
    }else if( evnflag == "NAME" ){
        DS_DETAIL2.NameValue(row,"PUMBUN_NAME") = "";
        rtnMap = setStrPbnNmWithoutToGridPop("DS_SEARCH_NM",code,'',"Y",1,'', strCd, '','','','','Y','','','','','','',floorCd);
    }    
    if( rtnMap != null){
        DS_DETAIL2.NameValue(row,"EX_PUMBUN_CD") = rtnMap.get("PUMBUN_CD");
        DS_DETAIL2.NameValue(row,"PUMBUN_NAME")  = rtnMap.get("PUMBUN_NAME");
    }
}
 
/**
 * setPumbunCodeToGridMulti()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 브랜드명을 등록한다.(Grid, 다중)(사용안함)
 * return값 : void
 */
function setPumbunCodeToGridMulti(evnflag, row){
    var code    = DS_DETAIL2.NameValue(row,"EX_PUMBUN_CD");
    var strCd   = DS_DETAIL2.NameValue(row,"STR_CD");
    var floorCd = "";
    
    if( code == "" && evnflag != "POP" ){
        DS_DETAIL2.NameValue(row,"PUMBUN_NAME") = "";
        return;
    }
    
    var rtnMap = null;
    if( evnflag == "POP" ){
//         rtnMap = strPbnMultiSelPop(code,'','Y','', strCd, '','','','','Y','','','','','','',floorCd);
        rtnMap = strPbnToGridPop(code,'','Y','', strCd, '','','','','Y','','','','','','',floorCd);
    }else if( evnflag == "NAME" ){
        DS_DETAIL2.NameValue(row,"PUMBUN_NAME") = "";
        rtnMap = setStrPbnNmWithoutToGridPop("DS_SEARCH_NM",code,'',"Y",1,'', strCd, '','','','','Y','','','','','','',floorCd);
    }    
    if( rtnMap != null){
        if(evnflag == "NAME"){
            DS_DETAIL2.NameValue(row,"EX_PUMBUN_CD") = rtnMap.get("PUMBUN_CD");
            DS_DETAIL2.NameValue(row,"PUMBUN_NAME")  = rtnMap.get("PUMBUN_NAME");
        }else{
            var total = rtnMap.length;
            
            if(total < 1){
                if( DS_DETAIL2.NameValue(row,"PUMBUN_NAME") == ""){
                    DS_DETAIL2.NameValue(row,"EX_PUMBUN_CD")= "";
                }
                return;
            }
            var idx = 0;

        	var strStrCd        = DS_MASTER.NameValue(DS_MASTER.Rowposition, "STR_CD");
        	var strEventPlaceCd = DS_MASTER.NameValue(DS_MASTER.Rowposition, "EVENT_PLACE_CD");
            
            for( var i=0; i<total; i++){
                if( idx!=0 && DS_DETAIL2.NameValue(row+idx-1,"PUMBUN_CD") !=""){
                    DS_DETAIL2.AddRow();
                    DS_DETAIL2.NameValue(row+idx,"STR_CD")         = strStrCd;
                    DS_DETAIL2.NameValue(row+idx,"EVENT_PLACE_CD") = strEventPlaceCd;
                    DS_DETAIL2.NameValue(row+idx,"SALE_DT")        = strToday;
                }
                DS_DETAIL2.NameValue(row+idx,"EX_PUMBUN_CD") = rtnMap[i].PUMBUN_CD;
                DS_DETAIL2.NameValue(row+idx,"PUMBUN_NAME")  = rtnMap[i].PUMBUN_NAME;
                if(checkDupKey(DS_DETAIL2,"EX_PUMBUN_CD")==0){
               	 idx++;
                }
               
            }
        }
    }else{
        if( DS_DETAIL2.NameValue(row,"PUMBUN_NAME") == ""){
            DS_DETAIL2.NameValue(row,"EX_PUMBUN_CD") = "";
        }
    }
}

</script>
</head>

<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                        *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                 *-->
<!--*    1. TR Success 메세지 처리
<!--*    2. TR Fail 메세지 처리
<!--*    3. DataSet Success 메세지 처리
<!--*    4. DataSet Fail 메세지 처리
<!--*    5. DataSet 이벤트 처리
<!--*************************************************************************-->
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<!-- 메인 -->
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<!-- 마스터 조회 -->
<script language=JavaScript for=TR_SEARCH_MASTER event=onSuccess>
    for(i=0;i<TR_SEARCH_MASTER.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_SEARCH_MASTER.SrvErrMsg('UserMsg',i));
    }

    // 행사장별 POS, 제외브랜드 조회
    searchDetail();
    gAllSearch = false;
</script>

<!-- 디테일 조회 -->
<script language=JavaScript for=TR_SEARCH_DETAIL event=onSuccess>
    for(i=0;i<TR_SEARCH_DETAIL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_SEARCH_DETAIL.SrvErrMsg('UserMsg',i));
    }
</script>

<!-- 저장 -->
<script language=JavaScript for=TR_SAVE event=onSuccess>
    for(i=0;i<TR_SAVE.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_SAVE.SrvErrMsg('UserMsg',i));
    }
    
    gSaveVal.FLAG = false;
    
    // 저장 후 재조회
    btn_Search();
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<!-- 메인 -->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<!-- 마스터 조회 -->
<script language=JavaScript for=TR_SEARCH_MASTER event=onFail>
    trFailed(TR_SEARCH_MASTER.ErrorMsg);
</script>

<!-- 디테일 조회 -->
<script language=JavaScript for=TR_SEARCH_DETAIL event=onFail>
    trFailed(TR_SEARCH_DETAIL.ErrorMsg);
</script>

<!-- 저장 -->
<script language=JavaScript for=TR_SAVE event=onFail>
    trFailed(TR_SAVE.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->


<!-- 데이터셋 행 변경전 -->
<script language=JavaScript for=DS_MASTER event=CanRowPosChange(row)>

    if(gSaveVal.FLAG) return;
    
    if(DS_DETAIL1.IsUpdated || DS_DETAIL2.IsUpdated){
        if(showMessage(Question, YesNo, "USER-1000","변경된 내역이 있습니다. 이동 하시겠습니까?")==1){
            return true;
        }else{
            return false;
        }
    }
</script>

<!-- 데이터셋 행 변경시 -->
<script language=JavaScript for=DS_MASTER event=OnRowPosChanged(row)>

    if(row <= 0){
    	fnSetObj(false);
    }else{
    	
    	// 사용여부에 따라
    	if(this.NameValue(row, "USE_YN") == "Y"){
        	fnSetObj(true);
    	}else{
        	fnSetObj(false);
    	}
        
		// 조회버튼 클릭시 디테일조회 하지않는다.(여러번 조회 되는것 방지)
		if(gAllSearch) return false;
		
		// 행사장별 POS, 제외브랜드 조회
		searchDetail();
    }
</script>

<!-- 데이터셋 값 변경 후 -->
<script language=JavaScript for=DS_DETAIL1 event=OnColumnChanged(row,colid)>
    if(!gEvtFlag) return;

    switch(colid){
        
        case "POS_NO" :    // POS 번호

            this.NameValue(row, "POS_NAME") = "";
            this.NameValue(row, "HALL_CD")  = "";
            this.NameValue(row, "FLOR_CD")  = "";
        	if(this.NameValue(row, colid) == "") return;
        
        	fnCallPopupPosNo(GD_DETAIL1, "EVT", "M");
            break;
            
        default :
            break;
    }
</script>

<!-- 데이터셋 값 변경 후 -->
<script language=JavaScript for=DS_DETAIL2 event=OnColumnChanged(row,colid)>
    if(!gEvtFlag) return;

    switch(colid){
        
        case "EX_PUMBUN_CD" :    // 제외브랜드

        	setPumbunCodeToGrid('NAME', row);
            break;
            
        default :
            break;
    }
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=JavaScript for=GD_MASTER  event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<script language=JavaScript for=GD_DETAIL1 event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<script language=JavaScript for=GD_DETAIL2 event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<!-- 그리드 헤더 체크박스 클릭시 -->
<script language="javascript"  for=GD_DETAIL1 event=OnHeadCheckClick(Col,Colid,bCheck)>

	this.redraw = false;
    switch(Colid){
        case "CHK":
            for (var row = 1; row <= DS_DETAIL1.CountRow; row++) {
                if(bCheck){
                    DS_DETAIL1.NameValue(row, "CHK") = "T";
                }else{
                	DS_DETAIL1.NameValue(row, "CHK") = "F";
                }
            }
            break;
            
        default:
            break;
    }
    this.redraw = true;
</script>

<!-- 그리드 헤더 체크박스 클릭시 -->
<script language="javascript"  for=GD_DETAIL2 event=OnHeadCheckClick(Col,Colid,bCheck)>

	this.redraw = false;
    switch(Colid){
        case "CHK":
            for (var row = 1; row <= DS_DETAIL2.CountRow; row++) {
                if(bCheck){
                    DS_DETAIL2.NameValue(row, "CHK") = "T";
                }else{
                	DS_DETAIL2.NameValue(row, "CHK") = "F";
                }
            }
            break;
            
        default:
            break;
    }
    this.redraw = true;
</script>

<!-- 팝업  -->
<script language=JavaScript for=GD_DETAIL1 event=OnPopup(row,colid,data)>
    if(row <= 0) return;

    switch(colid){
        case "POS_NO":		// POS번호
        	fnCallPopupPosNo(GD_DETAIL1, "POP", "M");
            break;
        
        default:
        	break;
    }
</script>



<!-- 팝업  -->
<script language=JavaScript for=GD_DETAIL2 event=OnPopup(row,colid,data)>
    if(row <= 0) return;

    switch(colid){
        case "EX_PUMBUN_CD":	// 제외브랜드
        	setPumbunCodeToGrid('POP', row);
//             setTimeout("setFocusGrid(GD_DETAIL2, DS_DETAIL2, "+row+", 'EX_PUMBUN_CD');" ,50);
            break;
            
        case "SALE_DT":			// 일자
            openCal(GD_DETAIL2, row, colid);   //그리드 달력 
            setTimeout("setFocusGrid(GD_DETAIL2, DS_DETAIL2, "+row+", 'SALE_DT');" ,50);
            break;
        
        default:
        	break;
    }
</script>

<!-- 행사장코드(POPUP) -->
<script language=JavaScript for=EM_EVENT_PLACE_CD event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
//     setEventCode('NAME','S');
</script> 
 
<!-- 점 (조회) -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
</script>

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                   *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->
<comment id="_NSID_"><object id="DS_I_COMMON"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_MASTER"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_DETAIL1"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_DETAIL2"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_STR_CD"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_HALL_CD"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_FLOR_CD"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_USE_YN"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_EVENT_PLACE_CD" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_POP"            classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_TODAY"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>


<!--------------------- 2. Transaction  --------------------------------------->
<!-- 메인 -->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<!-- 마스터 조회 -->
<comment id="_NSID_">
<object id="TR_SEARCH_MASTER" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<!-- 디테일 조회 -->
<comment id="_NSID_">
<object id="TR_SEARCH_DETAIL" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<!-- 저장 -->
<comment id="_NSID_">
<object id="TR_SAVE" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                               *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                           *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<div id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">

	<!-- 조회조건 영역 시작 -->
	<tr>
		<td class="PT01 PB03">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
							<tr>
								<th width="60" class="point">점</th>
								<td width="140">
									<comment id="_NSID_">
										<object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1  align="absmiddle">
										</object>
									</comment><script>_ws_(_NSID_);</script>
								</td>
								<th width="60" class="point">행사장코드</th>
								<td>
									<comment id="_NSID_">
										<object id=LC_EVENT_PLACE_CD classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1  align="absmiddle">
										</object>
									</comment><script>_ws_(_NSID_);</script>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<!-- 조회조건 영역 종료 -->
	
	<tr>
		<td class="dot"></td>
	</tr>
	
	<!-- 행사장 그리드 시작 -->
	<tr>
		<td class="PT01 PB03">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
				<tr>
					<td width="100%" >
						<comment id="_NSID_"><object id=GD_MASTER width="100%" height=200px classid=<%=Util.CLSID_GRID%>>
							<param name="DataID" value="DS_MASTER">
						</object></comment><script>_ws_(_NSID_);</script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<!-- 행사장 그리드 종료 -->
	
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" >
				<tr>
					<td class="PT03 PB03" width=490px>
						<!-- 행사장별 POS 시작-->
						<table width="100%" border="0" cellspacing="0" cellpadding="0" >
							<tr>
								<td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
										<tr>
											<td class="sub_title PB03 PT10" width="130px">
												<img src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PB03" align="absmiddle" /> 
												행사장별 POS관리
											</td>
											<td class="right PT03">
												<img src="/<%=dir%>/imgs/btn/add_row.gif" id=IMG_ADD_ROW1 onClick="javascript:btn_addRow('DTL1');" hspace="2" />
												<img src="/<%=dir%>/imgs/btn/del_row.gif" id=IMG_DEL_ROW1 onClick="javascript:btn_delRow('DTL1');" />
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
										<tr>
											<td>
												<comment id="_NSID_">
													<object id=GD_DETAIL1 width="100%" height=360 classid=<%=Util.CLSID_GRID%>>
														<param name="DataID" value="DS_DETAIL1">
													</object>
												</comment><script>_ws_(_NSID_);</script>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						<!-- 행사장별 POS 종료-->
					</td>
					<td width=8px></td>
					<td class="PT03 PB03" align="left">
						<!-- 행사장별 POS 시작-->
						<table width="100%" border="0" cellspacing="0" cellpadding="0" >
							<tr>
								<td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
										<tr>
											<td class="sub_title PB03 PT10" width="120px">
												<img src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PB03" align="absmiddle" /> 
												제외 브랜드 관리
											</td>
											<td class="right PT03">
												<img src="/<%=dir%>/imgs/btn/add_row.gif" id=IMG_ADD_ROW2 onClick="javascript:btn_addRow('DTL2');" hspace="2" />
												<img src="/<%=dir%>/imgs/btn/del_row.gif" id=IMG_DEL_ROW2 onClick="javascript:btn_delRow('DTL2');" />
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
										<tr>
											<td>
												<comment id="_NSID_">
													<object id=GD_DETAIL2 width="100%" height=360 classid=<%=Util.CLSID_GRID%>>
														<param name="DataID" value="DS_DETAIL2">
													</object>
												</comment><script>_ws_(_NSID_);</script>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						<!-- 행사장별 POS 종료-->
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>