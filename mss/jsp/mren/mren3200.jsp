<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 임대관리 > 월직접관리비등록
 * 작 성 일 : 2016.12.28
 * 작 성 자 : 김광래
 * 수 정 자 : 
 * 파 일 명 : MREN320.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 월직접 관리비를 등록한다
 * 이    력 : 
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                    *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");

	//PID 확인을 위한
	String pageName = request.getRequestURI();
	int nSubStrFr = pageName.lastIndexOf("/") + 1 ;
	int nSubStrTo = pageName.lastIndexOf(".jsp") - 1 ;
	pageName = pageName.substring(nSubStrFr, nSubStrTo).toUpperCase();
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"     type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                 *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
/*************************************************************************
 * 0. 전역변수
 *************************************************************************/
var g_currRow   = 1; 
var g_taxInvFlag  = false;          // 과면세 구분 (면세일경우  vat계산 제외)
var excelStrCd    = "";             // 시설구분
var excelCalYM    = "";             // 부과년월
var excelMntnitem = "";             // 관리비항목
var excelVenCd    = "";             // 협력사코드
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.25
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 155;			//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID 
function doInit() {
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_MNTNITEM"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	 
	var obj   = document.getElementById("GD_DETAIL"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    // 입력 Data Set Header 초기화
    DS_MR_MNTNITEM.setDataHeader('<gauce:dataset name="H_SEL_MR_MNTNITEM"/>');
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_MR_ITEMAMT"/>');
    
    registerUsingDataset('<%=((SessionInfo) session.getAttribute("sessionInfo")).getPGM_ID()%>'.toLowerCase(), "DS_IO_DETAIL");

    //그리드 초기화
    gridCreate1();
    gridCreate2();

    // EMedit에 초기화
    initComboStyle(LC_S_STR_CD,DS_STR_CD,               "CODE^0^30,NAME^0^100", 1, PK);     // [조회용]시설구분
    initEmEdit(EM_S_CAL_YM,                             "YYYYMM", PK);                      // [조회용]부과년월
    initEmEdit(EM_S_VEN_CD,     "GEN^6",NORMAL);                                            // [조회용]협력업사코드 
    initEmEdit(EM_S_VEN_NM,   "GEN^40",READ);                                               // [조회용]협력업사명   
    initEmEdit(EM_CAL_YM,                               "YYYYMM", PK);                      // 부과년월   
    
    getEtcCode("DS_LC_TAX_INVFLAG",  "D", "P004", "N");      // 과면세구분     
    
    //콤보 초기화
    getFlc("DS_STR_CD",         "M", "1", "Y", "N");    // [조회용]시설구분  
    LC_S_STR_CD.Focus();
    EM_S_CAL_YM.Text = getTodayFormat("YYYYMM");
    
    //종료시 데이터 변경 체크 (common.js )
    registerUsingDataset("mren320","DS_IO_DETAIL" );
    
    LC_S_STR_CD.Index = 0;
}

/**
 * gridCreate("대상그리드")
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.25
 * 개    요 : 마스터그리드SET
 * return값 : void
 */
function gridCreate1() {
	var hdrProperies = '<FC>ID={CURROW}            NAME="NO"			    WIDTH=30   ALIGN=CENTER 						 </FC>'
                     + '<FC>ID=CODE        		   NAME="관리항목코드"		WIDTH=100  ALIGN=CENTER     EditStyle=Popup     edit=none</FC>'
                     + '<FC>ID=NAME                NAME="관리항목명"		WIDTH=100  ALIGN=LEFT 					        edit=none</FC>'
                     + '<FC>ID=TAX_INV_FLAG        NAME="과세구분"	    	WIDTH=70  ALIGN=LEFT 		EditStyle=Lookup    edit=none  Data="DS_LC_TAX_INVFLAG:CODE:NAME"	</FC>'
        ;
        initGridStyle(id=GD_MNTNITEM, "common", hdrProperies, true);
}

/**
 * gridCreate("대상그리드")
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.25
 * 개    요 : 디테일그리드SET
 * return값 : void
 */
function gridCreate2() {
	var hdrProperies = '<FC>ID={CURROW}      NAME="NO"				    WIDTH=30   ALIGN=CENTER 						 </FC>'
                     + '<FC>ID=VEN_CD        NAME="협력사코드"		    WIDTH=100  EDIT=REALNUMERIC ALIGN=CENTER EditStyle=Popup  Edit={IF(SysStatus="I","true","false")} </FC>'
                     + '<FC>ID=VEN_NM        NAME="협력사명"			WIDTH=200  ALIGN=LEFT 					edit=none</FC>'
                     + '<FC>ID=MNTN_ITEM_CD  NAME="관리비항목"		    WIDTH=120  ALIGN=LEFT 	show=false		edit=none'  
                     + '	   EditStyle=Lookup    Data="DS_MR_MNTNITEM:CODE:NAME"									 </FC>'
                     + '<FC>ID=USE_AMT_NOVAT NAME="공급가액"			WIDTH=110  ALIGN=RIGHT EDIT=REALNUMERIC edit=true</FC>'
                     + '<FC>ID=VAT_AMT       NAME="부가세"			    WIDTH=110  ALIGN=RIGHT EDIT=REALNUMERIC edit=none</FC>'
                     + '<FC>ID=USE_AMT       NAME="총요금"			    WIDTH=110  ALIGN=RIGHT EDIT=REALNUMERIC edit=none</FC>'
                     + '<FC>ID=COST_AMT      NAME="단가"				WIDTH=90   ALIGN=RIGHT EDIT=REALNUMERIC edit=none 	show="false"</FC>'
                     + '<FC>ID=CAL_YM        NAME="정산년월"			WIDTH=170  ALIGN=LEFT 					edit=true  	show="false"</FC>'
                     + '<FC>ID=STR_CD        NAME="시설구분"			WIDTH=90   ALIGN=RIGHT EDIT=REALNUMERIC  			show="false"</FC>' 
                     + '<FC>ID=CNTR_ID       NAME="계약ID"			    WIDTH=90   ALIGN=RIGHT EDIT=REALNUMERIC  			show="false"</FC>' 
                     + '<FC>ID=CAL_TYPE      NAME="정산구분"			WIDTH=90   ALIGN=RIGHT EDIT=REALNUMERIC  			show="false"</FC>'           
                     + '<FC>ID=FLAG          NAME="EDIT구분"			WIDTH=90   ALIGN=RIGHT EDIT=REALNUMERIC 			show="false"</FC>'
                     ;
        
        initGridStyle(GD_DETAIL, "common", hdrProperies, true);
}

/*************************************************************************
 * 2. 공통버튼
 (1) 조회       - btn_Search(), subQuery()
 (2) 신규       - btn_New()
 (3) 삭제       - btn_Delete()
 (4) 저장       - btn_Save()
 (5) 엑셀       - btn_Excel()
 (6) 출력       - btn_Print()
 (7) 확정       - btn_Conf()
 *************************************************************************/

/**
 * btn_Search()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.25
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 
	 
    //저장되지 않은 내용이 있을경우 경고
    if (DS_IO_DETAIL.IsUpdated) {
        ret = showMessage(QUESTION, YESNO, "USER-1059");
        if (ret != "1") {
            return false;
        } 
    }
    
    if (!checkValidate()) return;

    
    //데이터셋 초기화
    DS_MR_MNTNITEM.ClearData();
    DS_IO_DETAIL.ClearData();
    //마스터 조회
    getMntnitem("DS_MR_MNTNITEM", LC_S_STR_CD.BindColVal, "N");

	var strStrCd      = LC_S_STR_CD.BindColVal;       // 시설구분
	var strCalYM      = EM_CAL_YM.Text;               // 부과년월(입력)	 

    //-- 익월정산되었으면 입력/수정불가
    if (getCalCheck("DS_O_CALCHECK", strStrCd, strCalYM, "2") == "TRUE") { 	
        enableControl(IMG_ADD, false);
        enableControl(IMG_DEL, false);
        
        GD_DETAIL.Editable = "false";   //입력불가
    
    //-- 당월입금내역이 있으면 입력/수정불가
    } else {
    	 if (getCalCheck("DS_O_CALCHECK", strStrCd, strCalYM, "3") == "TRUE") { 	
            enableControl(IMG_ADD, false);
            enableControl(IMG_DEL, false);
            
            GD_DETAIL.Editable = "false";   //입력불가
            
      	 } else {
	        enableControl(IMG_ADD, true);
	        enableControl(IMG_DEL, true);
	        
	        GD_DETAIL.Editable = "True";    //입력가능
      	 }
	 } 
}

/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.25
 * 개    요 : 초기화
 * return값 : void
 */
function btn_New() {

	//부과년월 동기화
	EM_S_CAL_YM.Text = EM_CAL_YM.Text;
	
	//시설, 부과년월 선택체크
    //if (!chkBfCloseYN()) return;
	
	var strStrCd      = LC_S_STR_CD.BindColVal;       // 시설구분
	var strCalYM      = EM_CAL_YM.Text;               // 부과년월(입력)	    
    if (getCalCheck("DS_O_CALCHECK", strStrCd, strCalYM, "2") == "TRUE") { 	
        showMessage(STOPSIGN, OK, "USER-1000", "익월이 정산되어 입력이 불가능합니다.");    	
    	return;
   	} else if (getCalCheck("DS_O_CALCHECK", strStrCd, strCalYM, "3") == "TRUE") { 	
        showMessage(STOPSIGN, OK, "USER-1000", "정산월의 당월입금내역이 존재합니다. 입력이 불가능합니다.");    	
    	return;
   	} 
		
	if(DS_MR_MNTNITEM.CountRow == 0){
        showMessage(STOPSIGN, OK, "USER-1000", "반드시 조회 이후 신규로 등록하십시오.");
        return;
	}
	if (EM_CAL_YM.Text == "") { 
        showMessage(STOPSIGN, OK, "USER-1003", "부과년월");
        EM_CAL_YM.Focus();
        return;
    }
	
	
	DS_O_VEN_CD.ClearData();
// 	DS_IO_DETAIL.ClearData();
	
	//기존 데이터가 있으면 행추가로 등록 
// 	if(DS_IO_DETAIL.CountRow > 0){
// 		showMessage(STOPSIGN, OK, "USER-1000", "행추가로 등록 하십시오.");
// 		return;
// 	}
	
	// parameters
	var strStrCd      = LC_S_STR_CD.BindColVal;       // 시설구분
	var strCalYM      = EM_CAL_YM.Text;               // 부과년월(입력)
	var strMrMntnItem = DS_MR_MNTNITEM.NameValue(DS_MR_MNTNITEM.RowPosition, "CODE"); //관리항목코드 
	var mrMntnItem    = DS_MR_MNTNITEM.NameValue(DS_MR_MNTNITEM.RowPosition, "NAME"); //광리항목명
	
	var goTo = "venSearch";
	var parameters = "&strStrCd="      + encodeURIComponent(strStrCd)
	               + "&strCalYM="      + encodeURIComponent(strCalYM)
	               + "&strMrMntnItem=" + encodeURIComponent(strMrMntnItem);
	
	TR_MAIN.Action = "/mss/mren320.mr?goTo=" + goTo + parameters;
	TR_MAIN.KeyValue = "SERVLET(O:DS_O_VEN_CD=DS_O_VEN_CD)";
	TR_MAIN.Post();
	
	// 신규
	//GD_MASTER.SetColumn("VEN_CD");
	
	for (var i=1; i<=DS_O_VEN_CD.CountRow; i++) {
		DS_IO_DETAIL.AddRow();
		
		DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "STR_CD") 	     = strStrCd;
		DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "CAL_YM")       = strCalYM;
		DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VEN_CD")       = DS_O_VEN_CD.NameValue(i, "VEN_CD");
		DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "VEN_NM")       = DS_O_VEN_CD.NameValue(i, "VEN_NM");
		DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "MNTN_ITEM_CD") = DS_O_VEN_CD.NameValue(i, "MNTN_ITEM_CD");
		
		//DS_IO_MASTER.NameValue(i, "COST_AMT") = EM_COST_AMT.Text;
		
		//DS_IO_MASTER.UserStatus(i) = 1;
	}
	
	//DS_IO_MASTER.AddRow();
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.25
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
	//시설, 부과년월 선택체크
	if (DS_IO_DETAIL.CountRow == 0) {
	    //if (!chkDelCloseYN()) return;
	    //DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
	    
		showMessage(INFORMATION, OK, "USER-1000", "삭제할 데이터가 없습니다.");
        return false;
	    
	}
	
	var strStrCd      = LC_S_STR_CD.BindColVal;       // 시설구분
	var strCalYM      = EM_CAL_YM.Text;               // 부과년월(입력)	    
    if (getCalCheck("DS_O_CALCHECK", strStrCd, strCalYM, "2") == "TRUE") { 	
        showMessage(STOPSIGN, OK, "USER-1000", "익월이 정산되어 삭제가 불가능합니다.");    	
    	return;
   	} else if (getCalCheck("DS_O_CALCHECK", strStrCd, strCalYM, "3") == "TRUE") { 	
        showMessage(STOPSIGN, OK, "USER-1000", "정산월의 당월입금내역이 존재합니다. 삭제가 불가능합니다.");    	
    	return;
   	} 
		
	
	if (DS_IO_DETAIL.RowStatus(DS_IO_DETAIL.RowPosition) == 1) { // 신규시에만 삭제
	    DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition); 
	} else {
	    // 선택한 항목을 삭제하겠습니까?
	    if( showMessage(INFORMATION, YESNO, "USER-1023") != 1 ){
	        GD_DETAIL.Focus();
	        return;
	    }  
	    
	    DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition); 
	    
	    // parameters
	    
	    var goTo = "delete";
	    
	    TR_MAIN.Action = "/mss/mren320.mr?goTo=" + goTo;
	    TR_MAIN.KeyValue = "SERVLET(I:DS_IO_DETAIL=DS_IO_DETAIL)";
	    TR_MAIN.Post();
	    
        // 정상 처리일 경우 조회
        if( TR_SAVE.ErrorCode == 0){
        	getDetail();
        }
	}
	
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.25
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    if (DS_IO_DETAIL.IsUpdated) {//변경 데이터가 있을때만 저장
        //필수 입력값 체크
        if (!checkValidateSave()) return;
        
        //변경또는 신규 내용을 저장하시겠습니까?
        if( showMessage(INFORMATION, YESNO, "USER-1010") != 1 ){
            GD_DETAIL.Focus();
            return;
        }
        //저장
        g_currRow = DS_IO_DETAIL.RowPosition;
        
        var goTo = "save";
        
        TR_SAVE.Action = "/mss/mren320.mr?goTo=" + goTo;
        TR_SAVE.KeyValue = "SERVLET(I:DS_IO_DETAIL=DS_IO_DETAIL)";
        TR_SAVE.Post();
        
        // 정상 처리일 경우 조회
        if( TR_SAVE.ErrorCode == 0){
        	getDetail();
        }
    } else {
        showMessage(INFORMATION, OK, "USER-1028");
    } 
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.06
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
	excelStrCd    = LC_S_STR_CD.BindColVal;       // 시설구분
	excelCalYM    = EM_S_CAL_YM.Text;             // 부과년월
	excelVenCd    = EM_S_VEN_CD.Text;             // 협력사코드
	var parameters = "시설구분="+nvl(excelStrCd,'전체')                    
                   + " -부과년월="+nvl(excelCalYM,'전체')    
                   + " -협력사="+nvl(excelVenCd,'전체') ;
		
	GD_DETAIL.GridToExcelExtProp("HideColumn") = "{currow}";       // GridToExcel 사용시 숨길 컬럼지정
	
    //openExcel2(GD_DETAIL, "월직접관리비등록", parameters, true );
	openExcel5(GD_DETAIL, "월직접관리비등록", parameters, true , "",g_strPid );
    GD_DETAIL.Focus();
    
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 

 /**
  * getMntnitem()
  * 작 성 자 : FKL
  * 작 성 일 : 2010.04.25
  * 개    요 : 관리비항목코드가져오기
  * return값 :
  */
 function getMntnitem(strDsSet, strCd, allGb) {
	 var strdate = EM_S_CAL_YM.Text;             // 부과년월
     var goTo    = "getMntnitem";
     var parameters = ""
             + "&strAllGb=" + encodeURIComponent(allGb)
             + "&strStrCd=" + encodeURIComponent(strCd)
             + "&strdate="  + encodeURIComponent(strdate);
     TR_MNTN.Action = "/mss/mren320.mr?goTo=" + goTo + parameters;
     TR_MNTN.KeyValue = "SERVLET(O:DS_MR_MNTNITEM="+strDsSet+")";
     TR_MNTN.Post();
 }
 
 /**
  * getDetail()
  * 작 성 자 : FKL
  * 작 성 일 : 2010.04.25
  * 개    요 : 관리비항목코드가져오기
  * return값 :
  */
 function getDetail() {
	  
     //입력값 동기화
     EM_CAL_YM.Text     = EM_S_CAL_YM.Text;
     
     // parameters
     var strStrCd    = LC_S_STR_CD.BindColVal;       // 시설구분
     var strCalYM    = DS_MR_MNTNITEM.NameValue(DS_MR_MNTNITEM.RowPosition, "S_DATE"); //부과년월
     var strVenCd    = EM_S_VEN_CD.Text;             // 협력사코드
     
     excelStrCd    = LC_S_STR_CD.BindColVal;       // 시설구분
	 excelCalYM    = strCalYM;                     // 부과년월
	 excelVenCd    = EM_S_VEN_CD.Text;             // 협력사코드
     
     var goTo = "getDetail";
     var parameters = 
          "&strStrCd="       + encodeURIComponent(strStrCd)
         + "&strCalYM="      + encodeURIComponent(strCalYM)
         + "&strMntnitem="   + encodeURIComponent(DS_MR_MNTNITEM.NameValue(DS_MR_MNTNITEM.RowPosition, "CODE"))
         + "&strVenCd="      + encodeURIComponent(strVenCd);
     TR_MAIN.Action = "/mss/mren320.mr?goTo=" + goTo + parameters;
     TR_MAIN.KeyValue = "SERVLET(O:DS_IO_DETAIL=DS_IO_DETAIL)";
     TR_MAIN.Post();
     
     // 조회결과 Return
     setPorcCount("SELECT", GD_DETAIL);
     g_currRow = 1;
 }
 
/**
 * chkDelCloseYN()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.25
 * 개    요 : 월기타 직접비 삭제 전 마감여부체크
 * return값 :
 */
// function chkDelCloseYN() {
	 
//     var strStrCd = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "STR_CD");
//     var strCalYM = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "CAL_YM");
	
//     //마감체크 함수
//     if (getCloseCheck("DS_CLOSE_YN", strStrCd, strCalYM, "MREN", "48", "0", "M") == "TRUE") {
//         var strCalY     = (EM_CAL_YM.Text).substring(0,4);
//         var strCalM     = (EM_CAL_YM.Text).substring(4,6);
//         showMessage(INFORMATION, OK, "USER-1000", "선택한 시설의 "+strCalY+"년"+strCalM+"월은 이미 정산마감 되었습니다.");
//         return false;
//     } 
    
// 	return true;
// }

/**
 * getCloseYN()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.25
 * 개    요 : 행추가 전 및 부과년월 Killfocus 이 후 마감여부체크
 * return값 :
 */
function getCloseYN() {

	//부과년월 동기화
	EM_S_CAL_YM.Text = EM_CAL_YM.Text;
	
	btn_Search();
	
// 	var strStrCd      = LC_S_STR_CD.BindColVal;       // 시설구분
// 	var strCalYM      = EM_CAL_YM.Text;               // 부과년월(입력)
	
// 	//익월 정산 체크 함수(getCalCheck)
//     if (getCalCheck("DS_O_CALCHECK", strStrCd, strCalYM, "2") == "TRUE") { 	
//         enableControl(IMG_ADD, false);
//         enableControl(IMG_DEL, false);
        
//         GD_DETAIL.Editable = "false";   //입력불가
        
//   	 } else {
//         enableControl(IMG_ADD, true);
//         enableControl(IMG_DEL, true);
        
//         GD_DETAIL.Editable = "True";    //입력가능
// 	 } 

}



/**
* getCalCheck()
* 작 성 자 : 이재득
* 작 성 일 : 2010-03-08
* 개    요 :  마감체크
			  V_STR_CD          --> 점
			  V_CLOSE_DT        --> 마감체크일자
			  V_CLOSE_TASK_FLAG --> 업무구분(PCOD/MGIF/...)
			  V_CLOSE_UNIT_FLAG --> 단위업무(매출일마감/수불일마감)
			  V_CLOSE_ACNT_FLAG --> 회계마감 구분(일반마감:'0' / 회계마감:'1')
			  V_CLOSE_FLAG      --> 마감구분(시간마감:T / 일마감:D / 월마감:M)
* return값 : TRUE/FALSE
*            -- 선택월에 마감 자료 존재 함 ==> 마감 TRUE
*            -- 선택월에 마감 자료 존재안함 ==> 마감 FALSE
*/
/*
function getCalCheck(strStrCd, strYM , strGbn){

    var goTo = "getCalCheck";
    
	var parameters = "&strStrCd=" +encodeURIComponent(strStrCd)
				   + "&strYM="    +encodeURIComponent(strYM)
				   + "&strGbn="   +encodeURIComponent(strGbn)
				;

	TR_MAIN.Action="/mss/mren320.mr?goTo=" + goTo + parameters;
	TR_MAIN.KeyValue="SERVLET(O:DS_O_CALCHECK=DS_O_CALCHECK)";
	TR_MAIN.Post();
	
	var dataSet = eval("DS_O_CALCHECK");
	if( dataSet.CountRow==1){
		 return dataSet.NameValue(1, "V_RETURN");
	}else
		return false;

}
*/

/**
 * checkValidate()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.25
 * 개    요 : 조회전 필수값체크
 * return값 :
 */
function checkValidate() {
	 
	 /* 시설구분 필수 값 체크*/
     if (LC_S_STR_CD.BindColVal == "") {
         showMessage(INFORMATION, OK, "USER-1000", "시설(구분)을 선택하세요");
         LC_S_STR_CD.Focus();
         return false;
     }
     
     /* 부과년월 필수 값 체크*/
     if (EM_S_CAL_YM.Text == "") {
         showMessage(INFORMATION, OK, "USER-1000", "부과년월 입력/선택 하세요");
         EM_S_CAL_YM.Focus();
         return false;
     }
     
    return true;
}

/**
 * checkValidateSave()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.25
 * 개    요 : 저장전 협력사코드(계약코드) 중복 값 체크
 * return값 :
 */
function checkValidateSave() {
    for (var i=1; i<=DS_IO_DETAIL.CountRow; i++) {
    	/* 협력사 코드 필수 입력 */
    	if(DS_IO_DETAIL.NameValue(i,"VEN_NM")==""){
            showMessage(STOPSIGN, OK, "USER-1003", "협력사코드");
            setFocusGrid(GD_DETAIL, DS_IO_DETAIL, i, "VEN_CD");
            return;
    	}
        //협력사코드 중복 체크
       	var iItemCd = DS_IO_DETAIL.NameValue(i,"VEN_CD");
        for(var k=i+1; k<=DS_IO_DETAIL.CountRow; k++) {
        	var kItemCd = DS_IO_DETAIL.NameValue(k,"VEN_CD");
        	if (iItemCd==kItemCd) {
        		showMessage(STOPSIGN, OK, "USER-1000", i+"번째행과 "+ k +"번째행의  협력사가 중복됩니다.");
                DS_IO_DETAIL.RowPosition = k;
                GD_DETAIL.SetColumn("VEN_CD");
                return false;
        	}
        }
    }
    return true;
}

/* 행 추가 */
function btn_addRow(){
	
	if(DS_MR_MNTNITEM.CountRow  == 0){
        showMessage(EXCLAMATION, OK, "USER-1000", "행추가는 조회 후 가능 합니다.");
        return false;
		
	}
	/* 부과년월은 필수 입력 */
	if (LC_S_STR_CD.BindColVal == "") { 
        showMessage(STOPSIGN, OK, "USER-1003", "시설구분");
        EM_CAL_YM.Focus();
        return;
    }
	
	/* 부과년월은 필수 입력 */
	if (EM_CAL_YM.Text == "" || EM_CAL_YM.Text == null) { 
        showMessage(STOPSIGN, OK, "USER-1003", "부과년월");
        EM_CAL_YM.Focus();
        return;
    }
	/* 행추가전 마감 여부 체크 */
	//getCloseYN();
	
	//부과년월 동기화
	EM_S_CAL_YM.Text = EM_CAL_YM.Text;
	
    var strStrCd = LC_S_STR_CD.BindColVal;
    var strCalYM = EM_CAL_YM.Text;
    
	DS_IO_DETAIL.AddRow();
	DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "STR_CD") 		 = strStrCd;
	DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "CAL_YM")       = strCalYM;
	DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "MNTN_ITEM_CD") = DS_MR_MNTNITEM.NameValue(DS_MR_MNTNITEM.RowPosition, "CODE");
	
}

/* 신규행만 행 삭제 */
function btn_delRow(){
	if(DS_IO_DETAIL.CountRow == 0){
		showMessage(EXCLAMATION , OK, "USER-1019");
		return false;
	}
	if(DS_IO_DETAIL.RowStatus(DS_IO_DETAIL.RowPosition) != 1 ){
		showMessage(EXCLAMATION , OK, "USER-1039");
		return false;
	}
	DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
}

-->
</script>
</head>

<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                     *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                                                                          *-->
<!--*    1. TR Success 메세지 처리                                                                                         *-->
<!--*    2. TR Fail 메세지 처리                                                                                               *-->
<!--*    3. DataSet Success 메세지 처리                                                                               *-->
<!--*    4. DataSet Fail 메세지 처리                                                                                     *-->
<!--*    5. DataSet 이벤트 처리                                                                                               *-->
<!--*************************************************************************-->
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<script language=JavaScript for=TR_SAVE event=onSuccess>
    for(i=0;i<TR_SAVE.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_SAVE.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_SAVE event=onFail>
    trFailed(TR_SAVE.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
  
<script language=JavaScript for=DS_MR_MNTNITEM event=OnRowPosChanged(row)>
 
if (row > 0) {
	getDetail();
}
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    //그리드 정렬기능
    if( row < 1) {
        sortColId( eval(this.DataID), row , colid );
    }
</script>

<!-- 협력사코드 변경시 -->
<script language=JavaScript for=EM_S_VEN_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
        
    if(this.text==''){
    	EM_S_VEN_NM.Text = "";
        return;
    }   
    setVenNmWithoutPop( "DS_O_VEN", this, EM_S_VEN_NM, '1',LC_S_STR_CD.BindColVal,'','','','','','',EM_S_CAL_YM.Text);
</script>

<!-- Grid GD_DETAIL OnExit event 처리 -->
<script language=JavaScript for=GD_DETAIL event=OnExit(row,colid,oldData)>

    var orgValue = DS_IO_DETAIL.OrgNameValue(row,colid);
    var newValue = DS_IO_DETAIL.NameValue(row,colid);
    var changeFlag = oldData != newValue  ;
    
    var strTAX_INV_FLAG =  DS_MR_MNTNITEM.NameValue(DS_MR_MNTNITEM.RowPosition, "TAX_INV_FLAG");  //과세구분 1:과세 2:면세 3:영세
    
    switch (colid) {
    case "USE_AMT_NOVAT" :

    	if( strTAX_INV_FLAG != "2"){        		
	 		eval(this.DataID).NameValue(row,"VAT_AMT") = getRoundDec("1" ,eval(this.DataID).NameValue(row,"USE_AMT_NOVAT") * 0.1);
	 		eval(this.DataID).NameValue(row,"USE_AMT") = eval(this.DataID).NameValue(row,"USE_AMT_NOVAT") + eval(this.DataID).NameValue(row,"VAT_AMT");
	 	}else {	 		
	 		eval(this.DataID).NameValue(row,"USE_AMT") = eval(this.DataID).NameValue(row,"USE_AMT_NOVAT");
	 		eval(this.DataID).NameValue(row,"VAT_AMT") = 0;	 	
	 	}
    	
// 	 	if( changeFlag && !g_taxInvFlag){        		
// 	 		eval(this.DataID).NameValue(row,"VAT_AMT") = getRoundDec("1" ,eval(this.DataID).NameValue(row,"USE_AMT_NOVAT") * 0.1);
// 	 		eval(this.DataID).NameValue(row,"USE_AMT") = eval(this.DataID).NameValue(row,"USE_AMT_NOVAT") + eval(this.DataID).NameValue(row,"VAT_AMT");
// 	 	}else if(changeFlag && g_taxInvFlag){
// 	 		eval(this.DataID).NameValue(row,"USE_AMT") = eval(this.DataID).NameValue(row,"USE_AMT_NOVAT");
// 	 		eval(this.DataID).NameValue(row,"VAT_AMT") = 0;
// 	 	}else{
// 	 		return
// 	 	}
	 	break;
    }
    return true;
</script>

<script language=JavaScript for=GD_DETAIL event=OnPopup(row,colid,data)>
var orgValue = DS_IO_DETAIL.OrgNameValue(row,colid);
var newValue = DS_IO_DETAIL.NameValue(row,colid);
var strstrcd = LC_S_STR_CD.BindColVal;
var strCalYm = EM_CAL_YM.Text;
var changeFlag = (orgValue != newValue || DS_IO_DETAIL.RowStatus(row) == 1) ;
    switch (colid) {
        case "VEN_CD" :  
        	//setGridPumbunCode('POP', row);
        	var popupData = venToGridPop(newValue, '',strstrcd,'','','','','','',strCalYm);
            if(popupData != null){
            	var strVenCd = popupData.get("VEN_CD");
                eval(this.DataID).NameValue(row,"VEN_CD") = strVenCd;
                eval(this.DataID).NameValue(row,"VEN_NM") = popupData.get("VEN_NAME");
                
            } else {
                eval(this.DataID).NameValue(row,"VEN_CD") = "";
                eval(this.DataID).NameValue(row,"VEN_NM") = "";
            }
            break;   
    }
</script>

<script language=JavaScript for=GD_DETAIL    event=CanColumnPosChange(row,colid)>   
    var orgValue = DS_IO_DETAIL.OrgNameValue(row,colid);
    var newValue = DS_IO_DETAIL.NameValue(row,colid);
    var strstrcd = LC_S_STR_CD.BindColVal;
    var strCalYm = EM_CAL_YM.Text;
    var changeFlag = (orgValue != newValue || DS_IO_DETAIL.RowStatus(row) == 1) ;
    
    switch (colid) {
        case "VEN_CD" :               
            if( changeFlag ){            	
                eval(this.DataID).NameValue(row,"VEN_NM") = "";                
                if(newValue == ''){
                    return false;
                }
                var popupData = setVenNmWithoutToGridPop("DS_O_RESULT",newValue,'','1',strstrcd,'','','','','','',strCalYm);
                if(popupData != null){
                	var strVenCd = popupData.get("VEN_CD");
                    eval(this.DataID).NameValue(row,"VEN_CD") = strVenCd;
                    eval(this.DataID).NameValue(row,"VEN_NM") = popupData.get("VEN_NAME"); 
                }else {
                    eval(this.DataID).NameValue(row,"VEN_CD") = "";                    
                }
            }
            break;        
    }  
    return true;
</script>

<script language=JavaScript for=LC_S_STR_CD event=OnSelChange()>
//[조회용]시설구분 변경시

//LC_MR_MNTNITEM.Index = 0;
</script>

<script language=JavaScript for=EM_CAL_YM event=OnKillFocus()>
// 마감여부체크
 if (EM_CAL_YM.Text.replace(/^\s*|\s*$/g, "").length == 6) {
 	getCloseYN();
 } 
</script>

<script language=JavaScript for=DS_MR_MNTNITEM event=CanRowPosChange(row)>
    if (DS_IO_DETAIL.CountRow > 0) {
    	for (var i=1; i<=DS_IO_DETAIL.CountRow; i++) {
    		if (DS_IO_DETAIL.RowStatus(i) == 1) { // 신규행작성시
    			var ret = showMessage(Question, YesNo, "USER-1049");
                if (ret == "1") {
                    DS_IO_DETAIL.DeleteRow(row);
                    return true;    
                } else {
                    return false;   
                }
    		}else if (DS_IO_DETAIL.RowStatus(i) == 3) { //데이터 변경시
                var ret = showMessage(Question, YesNo, "USER-1049");
                if (ret == "1") {
                	rollBackRowData(DS_IO_DETAIL, row);
                    return true;    
                } else {
                    return false;   
                }
            }
    	}
    }
    return true;
</script>

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                      *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                         *-->
<!--*    1. DataSet                                                         *-->
<!--*    2. Transaction                                                     *-->
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->
<!-- =============== Input용 -->
<comment id="_NSID_"><object id="DS_IO_DETAIL"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<!-- ===============- ONLOAD용 -->
<comment id="_NSID_"><object id="DS_STR_CD"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_MR_MNTNITEM"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSE_YN"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_VEN_CD"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_LC_TAX_INVFLAG" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>


<!-- ===============- 공통함수용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_VEN"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_CALCHECK"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_SAVE" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_MNTN" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 3. Excelupload  --------------------------------------->
<comment id="_NSID_">
<object id=INF_EXCELUPLOAD classid=<%=Util.CLSID_INPUTFILE%>
    style="position: absolute; left: 355px; top: 55px; width: 110px; height: 23px; visibility: hidden;">
    <param name="Text" value='FileOpen'>
    <param name="Enable" value="true">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                     *-->
<!--*************************************************************************-->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_MNTNITEM");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
	var obj   = document.getElementById("GD_DETAIL");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top2;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
    
}
</script>

<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                         *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<div id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="PT01 PB03" >
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="o_table">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="50" class="point">시설구분</th>
						<td width="115"><comment id="_NSID_"><object
							id=LC_S_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width="110"
							align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script></td>
						<th width="50" class="point">부과년월</th>
						<td width="110"><comment id="_NSID_"><object
							id=EM_S_CAL_YM classid=<%=Util.CLSID_EMEDIT%> width="85"
							onblur="javascript:checkDateTypeYM(this);"
							align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script><img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('M',EM_S_CAL_YM);" /></td>
						<th width="70">협력사</th>
						<td ><comment id="_NSID_"> <object id=EM_S_VEN_CD
							classid=<%=Util.CLSID_EMEDIT%> width=60 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							onclick="javascript:venPop(EM_S_VEN_CD, EM_S_VEN_NM, LC_S_STR_CD.BindColVal,'','','','','','',EM_S_CAL_YM.Text);EM_S_VEN_CD.Focus();"
							align="absmiddle" /> <comment id="_NSID_"> <object
							id=EM_S_VEN_NM classid=<%=Util.CLSID_EMEDIT%> width=150
							tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="dot"></td>
	</tr>
	<tr>
		<td class="PT05">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr >
				    <td width="35%" class="sub_title PB03 "><img
						src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
						align="absmiddle" /> 관리비항목
					</td>
					<td width="54%">
						<table width="185" border="0" cellspacing="0" cellpadding="0" class="s_table">
							<tr>
								<th width="80" class="point">부과년월</th>
								<td ><comment id="_NSID_"><object
									id=EM_CAL_YM style="vertical-align: middle;"
									onblur="javascript:checkDateTypeYM(this);"
									classid=<%=Util.CLSID_EMEDIT%> width="60"></object></comment><script>_ws_(_NSID_);</script><img
									id="IMG_CAL_YM" style="vertical-align: middle;"
									src="/<%=dir%>/imgs/btn/date.gif"
									onclick="javascript:openCal('M',EM_CAL_YM);" />
								</td>				
							</tr>
						</table>
					</td>
					<td align="right" >
						<img src="/<%=dir%>/imgs/btn/add_row.gif" id="IMG_ADD"  width="52" height="18" hspace="2" onclick="javascript:btn_addRow();" />
						<img src="/<%=dir%>/imgs/btn/del_row.gif" id="IMG_DEL"  width="52" height="18"            onclick="javascript:btn_delRow();" />
					</td>
				</tr>
			</table>
		</td>
    </tr>
	<tr>
		<td class="PT05">
	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
	         <tr valign="top">
	            <td width="35%" class="PR03">
	            <table width="100%" border="0" cellspacing="0" cellpadding="0"
	               class="BD4A">
	               <tr>
	                  <td width="100%">
	                  <comment id="_NSID_"> <object
	                     id=GD_MNTNITEM width=100% height=460 classid=<%=Util.CLSID_GRID%> tabindex=1>
	                     <param name="DataID" value="DS_MR_MNTNITEM">
	                  </object> </comment><script>_ws_(_NSID_);</script></td>
	               </tr>
	            </table>
	            </td>
	            <td width="65%">
	            	<table width="100%" border="0" cellspacing="0" cellpadding="0">	
		            <tr valign="top">
		            	<td>
		            	<table width="100%" border="0" cellspacing="0" cellpadding="0"
			               class="BD4A">
			               <tr>
			                  <td width="100%">
			                  <comment id="_NSID_"> <object
			                     id=GD_DETAIL width=100% height=460 classid=<%=Util.CLSID_GRID%> tabindex=1>
			                     <param name="DataID" value="DS_IO_DETAIL">
			                  </object> </comment><script>_ws_(_NSID_);</script></td>
			               </tr>
			            </table>
			            </td>
			         </tr>
			         
			         </table>
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
