<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 임대관리 > 관리비항목 관리
 * 작 성 일 : 2010.01.14
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : MREN1020.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 관리비항목관리
 * 이    력 : 2010.01.14(박래형) 신규작성
           2010.03.10 (김유완) 수정개발
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"   %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"          prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"       prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"           prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"        prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"     type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"   type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작 
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.10
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 115;		//해당화면의 동적그리드top위치
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	
    // Input Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MR_MNTNITEM"/>');
    registerUsingDataset('<%=((SessionInfo) session.getAttribute("sessionInfo")).getPGM_ID()%>'.toLowerCase(), "DS_IO_MASTER");
    //그리드 초기화
    gridCreate("MST"); //마스터
    
    //콤보 초기화
    initComboStyle(LC_S_STR_CD,DS_LC_S_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);           // [조회용]시설구분(점코드)     
    initComboStyle(LC_S_MNTN_TYPE,DS_LC_S_MNTN_TYPE, "CODE^0^30,NAME^0^80", 1, NORMAL); // [조회용]관리비분류     
    initComboStyle(LC_S_MNTN_FLAG,DS_LC_S_MNTN_FLAG, "CODE^0^30,NAME^0^80", 1, NORMAL); // [조회용]관리비구분팀    
       
    //시스템 코드 공통코드에서 가지고 오기
    getFlc("DS_LC_S_STR_CD", "M", "1", "Y", "N");            // [조회용]시설구분(점코드) 
    LC_S_STR_CD.index = "0";
    LC_S_STR_CD.Focus();
    getEtcCode("DS_LC_S_MNTN_TYPE",  "D", "M036", "Y", "N", LC_S_MNTN_TYPE); // [조회용]관리비분류                                                                 
    getEtcCode("DS_LC_S_MNTN_FLAG",  "D", "M077", "Y", "N", LC_S_MNTN_FLAG); // [조회용]관리비구분
    getFlc("DS_LC_STR_CD", "M", "1", "Y", "N", "1");         // 시설구분
    getEtcCode("DS_LC_MNTN_TYPE",    "D", "M036", "N");      // 관리비분류                                                                 
    getEtcCode("DS_LC_MNTN_FLAG",    "D", "M077", "N");      // 관리비구분                                                     
    getEtcCode("DS_LC_CAL_CD",       "D", "M037", "N");      // 계산항목                                                                              
    getEtcCodeSub("DS_LC_CAL_TYPE",  "M038");                // 계산방식                                                                             
    getEtcCode("DS_LC_AUTO_DIV_YN",  "D", "P091", "N");      // 시설별 자동배부                                                                             
    getEtcCode("DS_LC_AUTO_DIV_ITEM","D", "M078", "N");      // 자동배부항목                                                                             
    getEtcCode("DS_LC_TAX_INVFLAG",  "D", "P004", "N");      // 과면세구분                                                                                  
    getEtcCode("DS_LC_USE_YN",       "D", "P091", "N");      // 사용여부                                                                                   
}


function gridCreate(gdGnb){
        //마스터그리드
        if (gdGnb == "MST") {
            var hdrProperies = ''
                + '<FC>ID={CURROW}      NAME="NO"'
                + '                                         WIDTH=30    ALIGN=CENTER'
                + '                                         BGCOLOR={IF(DUPCHK="Y",(IF(DUPCHK="Y","RED","WHITE")),(IF(DUPCHK2="Y","RED","WHITE")))}</FC>'
                + '<FC>ID=STR_CD        NAME="*시설구분"'
                + '                                         WIDTH=80    ALIGN=LEFT      EDITSTYLE=LOOKUP   DATA="DS_LC_STR_CD:CODE:NAME"'    
                + '                                         BGCOLOR={IF(DUPCHK="Y",(IF(DUPCHK="Y","RED","WHITE")),(IF(DUPCHK2="Y","RED","WHITE")))}</FC>'
                + '<FC>ID=MNTN_ITEM_CD  NAME="*관리비코드"'
                + '                                         WIDTH=70    ALIGN=CENTER    EDIT=NUMERIC'
                + '                                         BGCOLOR={IF(DUPCHK="Y","RED","WHITE")}</FC>'
                + '<FC>ID=MNTN_ITEM_NM  NAME="*관리비명"'
                + '                                         WIDTH=160   ALIGN=LEFT      LANGUAGE="1"</FC>'
                + '<FC>ID=MNTN_TYPE     NAME="*관리비분류"'
                + '                                         WIDTH=70    ALIGN=LEFT      EDITSTYLE=LOOKUP   DATA="DS_LC_MNTN_TYPE:CODE:NAME"'
                + '                                         BGCOLOR={IF(DUPCHK2="Y","RED","WHITE")}</FC>'
                + '<FC>ID=MNTN_FLAG     NAME="*관리비구분"'
                + '                                         WIDTH=70    ALIGN=LEFT      EDITSTYLE=LOOKUP   DATA="DS_LC_MNTN_FLAG:CODE:NAME"'
                + '                                         BGCOLOR={IF(DUPCHK2="Y","RED","WHITE")}</FC>'
                + '<FC>ID=CAL_CD        NAME="*계산항목"'
                + '                                         WIDTH=85    ALIGN=LEFT      EDIT=NONE EDITSTYLE=LOOKUP   DATA="DS_LC_CAL_CD:CODE:NAME"'
                + '                                         BGCOLOR={IF(DUPCHK2="Y","RED","WHITE")}</FC>'
                + '<FC>ID=CAL_TYPE      NAME="*계산방식"'
                + '                                         WIDTH=70    ALIGN=LEFT      EDITSTYLE=LOOKUP   DATA="DS_LC_CAL_TYPE:CODE:NAME"</FC>'
                + '<FC>ID=AREA_UNIT_PRC NAME="정액"'
                + '                                         WIDTH=70    ALIGN=RIGHT     EDIT=NONE </FC>'
                + '<FC>ID=PUB_APP_RATE  NAME="공용임대매장;적용율"'
                + '                                         WIDTH=90    ALIGN=RIGHT     EDIT=NONE SHOW="FALSE"</FC>'
                + '<FC>ID=AUTO_DIV_YN   NAME="*시설별자동배부"'
                + '                                         WIDTH=100   ALIGN=LEFT      EDITSTYLE=LOOKUP   DATA="DS_LC_AUTO_DIV_YN:CODE:NAME" SHOW="FALSE"</FC>'
                + '<FC>ID=AUTO_DIV_ITEM NAME="자동배부항목"'
                + '                                         WIDTH=90    ALIGN=LEFT      EDIT=NONE   EDITSTYLE=LOOKUP   DATA="DS_LC_AUTO_DIV_ITEM:CODE:NAME" SHOW="FALSE"</FC>'
                + '<FC>ID=TAX_INV_FLAG  NAME="*과면세구분"'
                + '                                         WIDTH=70    ALIGN=LEFT      EDITSTYLE=LOOKUP  DATA="DS_LC_TAX_INVFLAG:CODE:NAME"</FC>'
                + '<FC>ID=SORT_NO       NAME="출력순서 "'
                + '                                         WIDTH=70    ALIGN=RIGHT     EDIT=NUMERIC</FC>'
                + '<FC>ID=USE_YN        NAME="*사용여부"'   
                + '                                         WIDTH=60    ALIGN=LEFT      EDITSTYLE=LOOKUP  show=false   DATA="DS_LC_USE_YN:CODE:NAME"  '
                + '                                         BGCOLOR={IF(DUPCHK2="Y","RED","WHITE")}</FC>'
                + '<FC>ID=DUPCHK        NAME="중복체크"'
                + '                                         WIDTH=60    ALIGN=LEFT      SHOW=FALSE</FC>'
                + '<FC>ID=DUPCHK2       NAME="중복체크"'
                + '                                         WIDTH=60    ALIGN=LEFT      SHOW=FALSE</FC>'
                + '<FC>ID=REMARK        NAME="비고(청구서:비고)"'
                + '                                         WIDTH=200   ALIGN=LEFT      LANGUAGE="1"</FC>'
                ;   
            initGridStyle(GD_MASTER, "COMMON", hdrProperies, true);
            GD_MASTER.TitleHeight = "35";
        }
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
 * 작 성 일 : 2010.03.10
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    if (DS_IO_MASTER.IsUpdated) {//변경데이터 있을 시 확인
        var ret = showMessage(Question, YesNo, "USER-1059");
        if (ret == "1") {
            // 점체크
            if (LC_S_STR_CD.BindColVal == "" || LC_S_STR_CD.BindColVal == "%") {//점 미선택시
                showMessage(STOPSIGN, OK, "USER-1003", "시설구분");
                LC_S_STR_CD.Focus();
                return;
            }  
        
            // parameters
            var strStrCd    = LC_S_STR_CD.BindColVal;   // [조회용]시설구분(점코드)
            var strMntnType = LC_S_MNTN_TYPE.BindColVal;// [조회용]관리비분류
            var strMntnFlag = LC_S_MNTN_FLAG.BindColVal;// [조회용]관리비구분팀
            
            var goTo = "getMaster";
            var parameters = ""
                + "&strStrCd="      + encodeURIComponent(strStrCd)
                + "&strMntnType="   + encodeURIComponent(strMntnType)
                + "&strMntnFlag="   + encodeURIComponent(strMntnFlag);
            TR_MAIN.Action = "/mss/mren102.mr?goTo=" + goTo + parameters;
            TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
            TR_MAIN.Post();
        
            // 조회결과 Return
            setPorcCount("SELECT", GD_MASTER);
            
        } else {
            return;
        }
        
    }  else {
        // 점체크
        if (LC_S_STR_CD.BindColVal == "" || LC_S_STR_CD.BindColVal == "%") {//점 미선택시
            showMessage(STOPSIGN, OK, "USER-1003", "시설구분");
            LC_S_STR_CD.Focus();
            return;
        }  
    
        // parameters
        var strStrCd    = LC_S_STR_CD.BindColVal;   // [조회용]시설구분(점코드)
        var strMntnType = LC_S_MNTN_TYPE.BindColVal;// [조회용]관리비분류
        var strMntnFlag = LC_S_MNTN_FLAG.BindColVal;// [조회용]관리비구분팀
        
        var goTo = "getMaster";
        var parameters = ""
            + "&strStrCd="      + encodeURIComponent(strStrCd)
            + "&strMntnType="   + encodeURIComponent(strMntnType)
            + "&strMntnFlag="   + encodeURIComponent(strMntnFlag);
        TR_MAIN.Action = "/mss/mren102.mr?goTo=" + goTo + parameters;
        TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
        TR_MAIN.Post();
    
        // 조회결과 Return
        setPorcCount("SELECT", GD_MASTER);
    }
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.10
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    if (DS_IO_MASTER.IsUpdated) {//변경 데이터가 있을때만 저장
        //필수 입력값 체크
	    if (!checkValidate()) return;
	    	
	    //값 초기화(색상 초기화)
	    for (var j=1; j<=DS_IO_MASTER.CountRow; j++) {
	      DS_IO_MASTER.NameValue(j,"DUPCHK")    = "N"; // 1.점, 관리비코드(중복키값 초기화)
	      DS_IO_MASTER.NameValue(j,"DUPCHK2")   = "N"; // 2.점, 관리비분류, 관리비구분, 계산항목, 사용여부(중복키값 초기화)
	    }
	    // 1.점, 관리비코드 
	    var dupRow = checkDupKey(DS_IO_MASTER, "STR_CD||MNTN_ITEM_CD"); 
	    if (dupRow == 0) {
	    	// 2.점, 관리비분류, 관리비구분, 계산항목, 사용여부
	    	dupRow = checkDupKey(DS_IO_MASTER, "STR_CD||MNTN_TYPE||MNTN_FLAG||CAL_CD||USE_YN"); 
	    	if (dupRow > 0) {
	            DS_IO_MASTER.RowPosition = dupRow;
	            DS_IO_MASTER.NameValue(dupRow,"DUPCHK2") = "Y";
	            GD_MASTER.SetColumn('MNTN_TYPE');
	            showMessage(INFORMATION, OK, "USER-1044", dupRow);
	            return;
	    	}
	    } else {
            DS_IO_MASTER.RowPosition = dupRow;
            DS_IO_MASTER.NameValue(dupRow,"DUPCHK") = "Y";
            GD_MASTER.SetColumn('MNTN_ITEM_CD');
            showMessage(INFORMATION, OK, "USER-1044", dupRow);
            return;
	    }
    
	    //DB중복값제크
	    if (!checkValidateDB()) {
	    	showMessage(INFORMATION, OK, "USER-1000", "이미 등록된 관리비항목들이 존재합니다."); 
	    	return; 
	    }
	    

	   //변경또는 신규 내용을 저장하시겠습니까?
	   if( showMessage(INFORMATION, YESNO, "USER-1010") != 1 ){
		   GD_MASTER.Focus();
		    return;
		    }
	  
	    //저장
        var goTo = "save";
        TR_SAVE.Action = "/mss/mren102.mr?goTo=" + goTo;
        TR_SAVE.KeyValue = "SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)";
        TR_SAVE.Post();
    } else {
        showMessage(INFORMATION, OK, "USER-1028");
        return;
    }
}


/**
 * btn_AddRow()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.10
 * 개    요 : 행추가
 * return값 :
 */
function btn_AddRow() {
    DS_IO_MASTER.AddRow();
    //기본값 설정
    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SORT_NO") = 0;
    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "USE_YN") = "Y";
    DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PUB_APP_RATE") = "100";
    GD_MASTER.SetColumn("STR_CD");
}

/**
 * btn_DeleteRow()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.10
 * 개    요 : 행삭제
 * return값 :
 */
function btn_DeleteRow() {
	//등록된 내역은 삭제 할 수 없습니다.
	if (DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition) == 1) {
	    DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition); 
	} else {
		showMessage(INFORMATION, OK, "USER-1000", "이미 저장된 관리비항목은 삭제 할 수 없습니다. 사용여부를 [미사용]으로 변경하여 해당 관리비항목의 사용을 중지하세요.");
        GD_MASTER.SetColumn("USE_YN");
        //DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "USE_YN") = "N";
	}
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

/**
 * checkValidate()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.10
 * 개    요 : 값체크(저장)
 * return값 :
 */
function checkValidate() {
	for (i=1; i<=DS_IO_MASTER.CountRow; i++) {
		if (DS_IO_MASTER.RowStatus(i) != 0 ) {
            //점코드
            if (DS_IO_MASTER.NameValue(i,"STR_CD") == "") {
                DS_IO_MASTER.RowPosition = i;
                GD_MASTER.SetColumn("STR_CD");
                showMessage(INFORMATION, OK, "USER-1002", "시설구분");
                return false;
            }
			
			//관리비 항목코드
			if (DS_IO_MASTER.NameValue(i,"MNTN_ITEM_CD") == ""){
                DS_IO_MASTER.RowPosition = i;
                GD_MASTER.SetColumn("MNTN_ITEM_CD");
                showMessage(INFORMATION, OK, "USER-1002", "관리비 항목코드");
                return false;
			} else if (DS_IO_MASTER.NameValue(i,"MNTN_ITEM_CD").length != 2) {
				DS_IO_MASTER.RowPosition = i;
				GD_MASTER.SetColumn("MNTN_ITEM_CD");
				showMessage(INFORMATION, OK, "USER-1000", "관리비 항목코드는 2자리수 입니다.");
				return false;
			}
			
            //관리비 항목명
            if (DS_IO_MASTER.NameValue(i,"MNTN_ITEM_NM") == ""){
                DS_IO_MASTER.RowPosition = i;
                GD_MASTER.SetColumn("MNTN_ITEM_NM");
                showMessage(INFORMATION, OK, "USER-1002", "관리비 항목명");
                return false;
            } else  { //Byte체크
		        var tmpLenA = checkLenByte(DS_IO_MASTER, i, "MNTN_ITEM_NM")
		        if (tmpLenA > 40 ) {
	                DS_IO_MASTER.RowPosition = i;
	                GD_MASTER.SetColumn("MNTN_ITEM_NM");
	                showMessage(INFORMATION, OK, "USER-1048", "40");
	                return false;
		        }
            }
            
            //관리비 분류
            if (DS_IO_MASTER.NameValue(i,"MNTN_TYPE") == ""){
                DS_IO_MASTER.RowPosition = i;
                GD_MASTER.SetColumn("MNTN_TYPE");
                showMessage(INFORMATION, OK, "USER-1002", "관리비 분류");
                return false;
            } 
            
            //관리비구분
            if (DS_IO_MASTER.NameValue(i,"MNTN_FLAG") == "") {
                DS_IO_MASTER.RowPosition = i;
                GD_MASTER.SetColumn("MNTN_FLAG");
                showMessage(INFORMATION, OK, "USER-1002", "관리비구분");
                return false;
            }
            
            //계산항목
            if (DS_IO_MASTER.NameValue(i,"CAL_CD") == "") {
                DS_IO_MASTER.RowPosition = i;
                GD_MASTER.SetColumn("CAL_CD");
                showMessage(INFORMATION, OK, "USER-1002", "계산항목");
                return false;
            }
            
            //계산방식
            if (DS_IO_MASTER.NameValue(i,"CAL_TYPE") == ""){
                DS_IO_MASTER.RowPosition = i;
                GD_MASTER.SetColumn("CAL_TYPE");
                showMessage(INFORMATION, OK, "USER-1002", "계산방식");
                return false;
            } else if (DS_IO_MASTER.NameValue(i,"CAL_TYPE") == "3"||DS_IO_MASTER.NameValue(i,"CAL_TYPE") == "4") { // [계산방식]정액
                //정액
//                 if (DS_IO_MASTER.NameValue(i,"AREA_UNIT_PRC") == "") {
//                     DS_IO_MASTER.RowPosition = i;
//                     GD_MASTER.SetColumn("AREA_UNIT_PRC");
//                     showMessage(INFORMATION, OK, "USER-1003", "정액");
//                     return false;
//                 }
            }
            /* 2011.09.08 공용임대매장적용율, 시설별자동배부 미관리
            if (DS_IO_MASTER.NameValue(i,"PUB_APP_RATE") > 100 ){
                DS_IO_MASTER.RowPosition = i;
                GD_MASTER.SetColumn("PUB_APP_RATE");
                showMessage(INFORMATION, OK, "USER-1000", " '공용임대매장적용율'은 100 이하로 입력하셔야 합니다. ");
                return false;
            } 
            
            //공용임대매장적용율
            if (DS_IO_MASTER.NameValue(i,"MNTN_TYPE") == "01" && DS_IO_MASTER.NameValue(i,"MNTN_FLAG") == "1" ){ //수도광열비
	            if (DS_IO_MASTER.NameValue(i,"PUB_APP_RATE") < 1 ){
	                DS_IO_MASTER.RowPosition = i;
	                GD_MASTER.SetColumn("PUB_APP_RATE");
	                showMessage(INFORMATION, OK, "USER-1000", "[관리비분류:수도광열비,구분:공용] 일 시 '공용임대매장적용율'은  0 이상이어야 합니다. ");
	                return false;
	            } 
            }
            
            //시설별자동배부
            if (DS_IO_MASTER.NameValue(i,"AUTO_DIV_YN") == ""){
                DS_IO_MASTER.RowPosition = i;
                GD_MASTER.SetColumn("AUTO_DIV_YN");
                showMessage(INFORMATION, OK, "USER-1002", "시설별자동배부");
                return false;
            } else if (DS_IO_MASTER.NameValue(i,"AUTO_DIV_YN") == "Y") { // [계산방식]정액
                //자동배부항목
                if (DS_IO_MASTER.NameValue(i,"AUTO_DIV_ITEM") == "") {
                    DS_IO_MASTER.RowPosition = i;
                    GD_MASTER.SetColumn("AUTO_DIV_ITEM");
                    showMessage(INFORMATION, OK, "USER-1003", "자동배부항목");
                    return false;
                }
            }*/
            
            //과면세구분
            if (DS_IO_MASTER.NameValue(i,"TAX_INV_FLAG") == "") {
                DS_IO_MASTER.RowPosition = i;
                GD_MASTER.SetColumn("TAX_INV_FLAG");
                showMessage(INFORMATION, OK, "USER-1002", "과면세구분");
                return false;
            }
            
            //사용여부
            if (DS_IO_MASTER.NameValue(i,"USE_YN") == "") {
                DS_IO_MASTER.RowPosition = i;
                GD_MASTER.SetColumn("USE_YN");
                showMessage(INFORMATION, OK, "USER-1002", "사용여부");
                return false;
            }
		}
	} 
	
    return true;
}

 /**
  * checkValidateDB()
  * 작 성 자 : FKL
  * 작 성 일 : 2010.03.10
  * 개    요 : 값체크(저장)
  * return값 :
  */
 function checkValidateDB() {
	// 1.점, 관리비코드
	var goTo = "getDupKeyValue";
    var parameters = "";
	TR_MAIN.Action = "/mss/mren102.mr?goTo=" + goTo + parameters;
	TR_MAIN.KeyValue = "SERVLET(O:DS_O_DUPKEYVALUE=DS_O_DUPKEYVALUE, I:DS_IO_MASTER=DS_IO_MASTER)";
	TR_MAIN.StatusResetType= "2";
	TR_MAIN.Post();
	
	if (DS_O_DUPKEYVALUE.CountRow == 0 ) {
		return true;
	} else { 
	    for (var i=1; i<=DS_IO_MASTER.CountRow; i++) {
	        if (DS_IO_MASTER.RowStatus(i) == 1 || DS_IO_MASTER.RowStatus(i) == 3) { // 신규일시
	            for (var k=1; k<=DS_O_DUPKEYVALUE.CountRow; k++) {
	            	if (DS_O_DUPKEYVALUE.NameValue(k,"GBNFLAG") == "1" ) {
			        	var tmpKey = DS_IO_MASTER.NameValue(i,"STR_CD") 
                            +""+ DS_IO_MASTER.NameValue(i,"MNTN_ITEM_CD");
	                    if (DS_O_DUPKEYVALUE.NameValue(k,"DUPVALUE") == tmpKey) {
	                        DS_IO_MASTER.NameValue(i,"DUPCHK") = "Y";
	                    } 
	            	} else {
	                    var tmpKey = DS_IO_MASTER.NameValue(i,"STR_CD") 
		                    +""+ DS_IO_MASTER.NameValue(i,"MNTN_TYPE")
		                    +""+ DS_IO_MASTER.NameValue(i,"MNTN_FLAG")
		                    +""+ DS_IO_MASTER.NameValue(i,"CAL_CD")
		                    +""+ DS_IO_MASTER.NameValue(i,"USE_YN");
		                if (DS_O_DUPKEYVALUE.NameValue(k,"DUPVALUE") == tmpKey) {
		                    DS_IO_MASTER.NameValue(i,"DUPCHK2") = "Y";
		                } 
	            	}
	            }
	        }
	    }
	    
	    return false;
	}
 }
  
 /**
  * checkLenByte()
  * 작 성 자 : FKL
  * 작 성 일 : 2010.03.10
  * 개    요 : 문자열 Byte체크
  * return값 :
  */
 function checkLenByte(objDateSet, row, colid) {
	//byte체크
	var intByte = 0;
	var strTemp = objDateSet.NameValue(row, colid);
	for (k = 0; k < strTemp.length; k++) {
	    var onechar = strTemp.charAt(k);
	    if (escape(onechar).length > 4) {
	        intByte += 2;
	    } else {
	        intByte++;
	    }
	}
	return intByte;
}
 
/**
 * getEtcCodeSub()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.10
 * 개    요 : 공통코드가져오기
 * return값 :
 */
function getEtcCodeSub(objDateSet, objCode) {
	var goTo = "getEtcCodeSub";
	var parameters = ""
        + "&strDSName="     + encodeURIComponent(objDateSet)
        + "&strEtcCode="    + encodeURIComponent(objCode);
	TR_MAIN.Action = "/mss/mren102.mr?goTo=" + goTo + parameters;
	TR_MAIN.KeyValue = "SERVLET(O:"+objDateSet+"="+objDateSet+")";
	TR_MAIN.StatusResetType= "2";
	TR_MAIN.Post();
}
  
/**
 * gridEditCotl()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.10
 * 개    요 : GRID 컨트롤
 * return값 :
 */
function gridEditCotl(row) {
	//DS_LC_MNTN_FLAG.Filter();
	DS_LC_CAL_CD.Filter();     //[계산방식]데이터 필터
    DS_LC_CAL_TYPE.Filter();   //[계산항목]데이터 필터
    
    //관리비분류선택
    if (DS_IO_MASTER.NameValue(row,"MNTN_TYPE") != "") {
	    if (DS_IO_MASTER.NameValue(row,"MNTN_TYPE") == "01" || DS_IO_MASTER.NameValue(row,"MNTN_TYPE") == "08") {//01수도광열비, 08기타직접비 일시	    	
	        GD_MASTER.ColumnProp('CAL_CD', 'Edit')     = "";
	        GD_MASTER.ColumnProp('MNTN_FLAG', 'Edit')  = "None";
	        //GD_MASTER.ColumnProp('AUTO_DIV_YN', 'Edit')= "None";   // 시설별자동배부
	        //GD_MASTER.ColumnProp('AUTO_DIV_ITEM', 'Edit')  = "None";// 자동배부항목
	         if (DS_IO_MASTER.NameValue(row,"MNTN_TYPE") == "01") {
	        	 GD_MASTER.ColumnProp('MNTN_FLAG', 'Edit')  = "None"; 
	        	 GD_MASTER.ColumnProp('CAL_CD', 'Edit')     = "None";
	         }
	        
	    } else {
	        GD_MASTER.ColumnProp('MNTN_FLAG', 'Edit')  = "None";
	        GD_MASTER.ColumnProp('CAL_CD', 'Edit')     = "None";
	        //GD_MASTER.ColumnProp('AUTO_DIV_YN', 'Edit')= "";       // 시설별자동배부
	        //GD_MASTER.ColumnProp('AUTO_DIV_ITEM', 'Edit')   = "";  // 자동배부항목
	    }
    }
    /* 2011.09.08 공용임대매장적용율, 시설별자동배부 미관리
    // 관리비분류, 수도광열비 / 관리비구분이 공동일때 공용임대적용율 입력가능
    if (DS_IO_MASTER.NameValue(row,"MNTN_TYPE") == "01" || DS_IO_MASTER.NameValue(row,"MNTN_TYPE") == "08") {
        if  (DS_IO_MASTER.NameValue(row,"MNTN_FLAG") == "1") {
            GD_MASTER.ColumnProp('PUB_APP_RATE', 'Edit')   = "RealNumeric";
        } else {
            GD_MASTER.ColumnProp('PUB_APP_RATE', 'Edit') = "None";
        }
    } else {
        GD_MASTER.ColumnProp('PUB_APP_RATE', 'Edit') = "None";
    }*/

    //계산방식이 정액일시만 정액컬럼 활성화, 시설별자동배부 비활성화
    if (DS_IO_MASTER.NameValue(row,"CAL_TYPE") == "3" || DS_IO_MASTER.NameValue(row,"CAL_TYPE") == "4") { 
        GD_MASTER.ColumnProp('AREA_UNIT_PRC', 'Edit') = "Numeric";
        //GD_MASTER.ColumnProp('AUTO_DIV_YN', 'Edit')= "None";       // 시설별자동배부
        //GD_MASTER.ColumnProp('AUTO_DIV_ITEM', 'Edit')  = "None";   // 자동배부항목
        
    } else {
        GD_MASTER.ColumnProp('AREA_UNIT_PRC', 'Edit') = "None";
        if (DS_IO_MASTER.NameValue(row,"MNTN_TYPE") != "01") {
            //GD_MASTER.ColumnProp('AUTO_DIV_YN', 'Edit')= "";        // 시설별자동배부
            //GD_MASTER.ColumnProp('AUTO_DIV_ITEM', 'Edit')   = "";   // 자동배부항목
        } else {
            //GD_MASTER.ColumnProp('AUTO_DIV_YN', 'Edit')= "None";    // 시설별자동배부
            //GD_MASTER.ColumnProp('AUTO_DIV_ITEM', 'Edit')  = "None";// 자동배부항목
        }
    }
    
    /*2011.09.08 공용임대매장적용율, 시설별자동배부 미관리
    //시설별 자동배부(사용/미사용)
    if (DS_IO_MASTER.NameValue(row,"MNTN_TYPE") != "01") {
        if (DS_IO_MASTER.NameValue(row,"AUTO_DIV_YN") == "Y" ) { //시설별 자동배부 사용일시
            GD_MASTER.ColumnProp('AUTO_DIV_ITEM', 'Edit')   = "";
        } else {
            GD_MASTER.ColumnProp('AUTO_DIV_ITEM', 'Edit')   = "None";
        }
    } else {
        GD_MASTER.ColumnProp('AUTO_DIV_ITEM', 'Edit')   = "None";
    }*/
}
 
-->
</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리
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

<script language=JavaScript for=TR_SAVE event=onSuccess>
    for(i=0;i<TR_SAVE.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_SAVE.SrvErrMsg('UserMsg',i));
    }
    
    //저장 후 재 조회
    btn_Search();
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
<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>
if(clickSORT) return;
gridEditCotl(row);
if (DS_IO_MASTER.RowStatus(row) == "1") {
    GD_MASTER.ColumnProp('STR_CD', 'Edit')         = "";        // 점코드
    GD_MASTER.ColumnProp('MNTN_ITEM_CD', 'Edit')   = "Numeric"; // 관리비항목코드
    //enableControl(IMG_DEL_ROW, true);
} else {
	GD_MASTER.ColumnProp('STR_CD', 'Edit')         = "None";    // 점코드
	GD_MASTER.ColumnProp('MNTN_ITEM_CD', 'Edit')   = "None";    // 관리비항목코드
    //enableControl(IMG_DEL_ROW, false);
}
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
//그리드 정렬기능
    if( row < 1) sortColId( eval(this.DataID), row , colid );
</script>

<script language=JavaScript for=GD_MASTER event=OnCloseUp(row,colid)>
	//관리비분류선택
	if (colid == "MNTN_TYPE") {
		
		DS_LC_CAL_CD.Filter();     //[계산방식]데이터 필터
		DS_LC_CAL_TYPE.Filter();   //[계산항목]데이터 필터
		
		if (DS_IO_MASTER.NameValue(row,"MNTN_TYPE") == "01" || DS_IO_MASTER.NameValue(row,"MNTN_TYPE") == "08") { //01수도광열비, 08기타직접비일시		 
		    GD_MASTER.ColumnProp('CAL_CD', 'Edit')     = "";
		    GD_MASTER.ColumnProp('MNTN_FLAG', 'Edit')  = "None";
		    GD_MASTER.ColumnProp('AUTO_DIV_YN', 'Edit')= "None";       // 시설별자동배부
		    DS_IO_MASTER.NameValue(row,"AUTO_DIV_YN")  = "N";          // 시설별자동배부
		    GD_MASTER.ColumnProp('AUTO_DIV_ITEM', 'Edit')  = "None";   // 자동배부항목
		    
		    DS_IO_MASTER.NameValue(row,"AUTO_DIV_ITEM")= "";           // 자동배부항목
		   
		    if(DS_IO_MASTER.NameValue(row,"MNTN_TYPE") == "08"){       // 기타직접비일때 관리구분은 사용자로 셋팅
		    	GD_MASTER.ColumnProp('MNTN_FLAG', 'Edit')  = "None";
				DS_IO_MASTER.NameValue(row,"MNTN_FLAG")    = "2"; 
			    DS_IO_MASTER.NameValue(row,"CAL_CD")       = "";     
			    GD_MASTER.ColumnProp('MNTN_FLAG', 'Edit')  = "None";
			}else{// 수도광열비...
			    DS_IO_MASTER.NameValue(row,"MNTN_FLAG")    = "1";          // [관리비구분]공용
			    DS_IO_MASTER.NameValue(row,"CAL_CD")       = "90";          // 간접비선택(고정)
			    GD_MASTER.ColumnProp('MNTN_FLAG', 'Edit')  = "None";
			    GD_MASTER.ColumnProp('CAL_CD', 'Edit')     = "None";
		        GD_MASTER.ColumnProp('AUTO_DIV_YN', 'Edit')= "";           // 시설별자동배부
		        GD_MASTER.ColumnProp('AUTO_DIV_ITEM', 'Edit')   = "";      // 자동배부항목
				
			}
		} else {
		    DS_IO_MASTER.NameValue(row,"MNTN_FLAG")    = "1";          // [관리비구분]공용
		    DS_IO_MASTER.NameValue(row,"CAL_CD")       = "90";          // 간접비선택(고정)
		    GD_MASTER.ColumnProp('MNTN_FLAG', 'Edit')  = "None";
		    GD_MASTER.ColumnProp('CAL_CD', 'Edit')     = "None";
	        GD_MASTER.ColumnProp('AUTO_DIV_YN', 'Edit')= "";           // 시설별자동배부
	        GD_MASTER.ColumnProp('AUTO_DIV_ITEM', 'Edit')   = "";      // 자동배부항목
		}
	//공용임대적용율(관리비분류:수도광열비, 관리비분류:공용 일시 활성화)
	} else if (colid == "MNTN_FLAG") {
		DS_LC_CAL_TYPE.Filter();     //[계산방식]데이터 필터
		if (DS_IO_MASTER.NameValue(row,"MNTN_TYPE") == "01" || DS_IO_MASTER.NameValue(row,"MNTN_TYPE") == "08") {
			if  (DS_IO_MASTER.NameValue(row,"MNTN_FLAG") == "1") {
				//GD_MASTER.ColumnProp('PUB_APP_RATE', 'Edit')   = "RealNumeric";
			} else {
				GD_MASTER.ColumnProp('PUB_APP_RATE', 'Edit') = "None";
				DS_IO_MASTER.NameValue(row,"PUB_APP_RATE") = "100";
			}
		} else {
			//GD_MASTER.ColumnProp('PUB_APP_RATE', 'Edit') = "None";
			DS_IO_MASTER.NameValue(row,"PUB_APP_RATE") = "100";
		}
		
	//계산방식에따라
	} else if (colid == "CAL_TYPE") {
		//계산방식이 정액일시만 정액컬럼 활성화, 시설별자동배부 비활성화
		if (DS_IO_MASTER.NameValue(row,"CAL_TYPE") == "3" || DS_IO_MASTER.NameValue(row,"CAL_TYPE") == "4" || DS_IO_MASTER.NameValue(row,"CAL_TYPE") == "6") { 
			//DS_IO_MASTER.NameValue(row,"AREA_UNIT_PRC")   = "0";
	        GD_MASTER.ColumnProp('AREA_UNIT_PRC', 'Edit') = "Numeric";
	        GD_MASTER.ColumnProp('AUTO_DIV_YN', 'Edit')= "None";       // 시설별자동배부
	        DS_IO_MASTER.NameValue(row,"AUTO_DIV_YN")  = "N";          // 시설별자동배부
	        GD_MASTER.ColumnProp('AUTO_DIV_ITEM', 'Edit')  = "None";   // 자동배부항목
	        DS_IO_MASTER.NameValue(row,"AUTO_DIV_ITEM")= "";           // 자동배부항목
	        
	    } else {
	    	DS_IO_MASTER.NameValue(row,"AREA_UNIT_PRC")    = "0";
	        GD_MASTER.ColumnProp('AREA_UNIT_PRC', 'Edit') = "None";
	        if (DS_IO_MASTER.NameValue(row,"MNTN_TYPE") != "01") {
	            GD_MASTER.ColumnProp('AUTO_DIV_YN', 'Edit')= "";        // 시설별자동배부
	            GD_MASTER.ColumnProp('AUTO_DIV_ITEM', 'Edit')   = "";   // 자동배부항목
	        } else {
	            GD_MASTER.ColumnProp('AUTO_DIV_YN', 'Edit')= "None";    // 시설별자동배부
	            DS_IO_MASTER.NameValue(row,"AUTO_DIV_YN")  = "N";       // 시설별자동배부
	            GD_MASTER.ColumnProp('AUTO_DIV_ITEM', 'Edit')  = "None";// 자동배부항목
	            DS_IO_MASTER.NameValue(row,"AUTO_DIV_ITEM")= "";        // 자동배부항목
	        }
	    }
		
	//시설별 자동배부(사용/미사용)
	} else if (colid == "AUTO_DIV_YN") {
	    if (DS_IO_MASTER.NameValue(row,"MNTN_TYPE") != "01") {
	        if (DS_IO_MASTER.NameValue(row,"AUTO_DIV_YN") == "Y" ) { //시설별 자동배부 사용일시
	            GD_MASTER.ColumnProp('AUTO_DIV_ITEM', 'Edit')   = "";
	        } else {
	            GD_MASTER.ColumnProp('AUTO_DIV_ITEM', 'Edit')   = "None";
	            DS_IO_MASTER.NameValue(row,"AUTO_DIV_ITEM")     = "";
	        }
	    } else {
	    	GD_MASTER.ColumnProp('AUTO_DIV_ITEM', 'Edit')   = "None";
	    }
	
	}
</script>



<!-- 데이터셋(컬럼) 값 변경 후 -->
<script language="javascript"  for=DS_IO_MASTER   event=OnColumnChanged(row,colid)>

	switch(colid){

		case 'MNTN_FLAG':     //관리비구분
			//공용임대적용율(관리비분류:수도광열비, 관리비분류:공용 일시 활성화)
			
			DS_LC_CAL_TYPE.Filter();     //[계산방식]데이터 필터
			if (DS_IO_MASTER.NameValue(row,"MNTN_TYPE") == "01" || DS_IO_MASTER.NameValue(row,"MNTN_TYPE") == "08") {
				if  (DS_IO_MASTER.NameValue(row,"MNTN_FLAG") == "1") {
					//GD_MASTER.ColumnProp('PUB_APP_RATE', 'Edit')   = "RealNumeric";
				} else {
					GD_MASTER.ColumnProp('PUB_APP_RATE', 'Edit') = "None";
					DS_IO_MASTER.NameValue(row,"PUB_APP_RATE") = "100";
				}
			} else {
				//GD_MASTER.ColumnProp('PUB_APP_RATE', 'Edit') = "None";
				DS_IO_MASTER.NameValue(row,"PUB_APP_RATE") = "100";
			}
			break;
	}
</script>

<script language=JavaScript for=DS_LC_CAL_CD event=OnFilter(row)>
//관리비분류에 따라 계산항목
if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "MNTN_TYPE") == "08") {	
	if (DS_LC_CAL_CD.NameValue(row,"CODE") == "90") {
        if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CAL_CD") == "90") {
            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CAL_CD") = "";
        }
    	return false;
    } else if(DS_LC_CAL_CD.NameValue(row,"CODE") < "80"){ 
        return false;
    }
}else if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "MNTN_TYPE") == "01"){
	if (DS_LC_CAL_CD.NameValue(row,"CODE") == "90") {
        if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CAL_CD") == "90") {
            //DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CAL_CD") = "";
        }
    	return false;
    } else if(DS_LC_CAL_CD.NameValue(row,"CODE") >= "80"){ 
        return false;
    }
} else {
    if (DS_LC_CAL_CD.NameValue(row,"CODE") == "90") {
        return true;
    } else { 
        return false;
    }
}
</script>

<script language=JavaScript for=DS_LC_CAL_TYPE event=OnFilter(row)>

//관리비분류(관리비구분)에 따라 계산방식변경
// if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "MNTN_TYPE") == "01" ) {// 수도광열비
// 	if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"MNTN_FLAG") == "1") { // 직접비 공용
// 		if (DS_LC_CAL_TYPE.NameValue(row,"RCODE2") == "0") {			
// 	        //필터로 변경된 값초기화
// 	        if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CAL_TYPE") == DS_LC_CAL_TYPE.NameValue(row,"CODE")) {
// 	            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CAL_TYPE") = "";
// 	        }
// 	        return false;
// 	    } else { 
// 	        return true;
// 	    }
// 	} else { //직접비 사용자
//         if (DS_LC_CAL_TYPE.NameValue(row,"RCODE1") == "0" || DS_LC_CAL_TYPE.NameValue(row,"RCODE1") == "2") {
        	
//             //필터로 변경된 값초기화
//             if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CAL_TYPE") == DS_LC_CAL_TYPE.NameValue(row,"CODE")) {
//                 DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CAL_TYPE") = "";
//             }
//             return false;
//         } else { 
//             return true;
//         }
// 	}
// }else 
	
if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "MNTN_TYPE") == "08") {// 직접비

	if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"MNTN_FLAG") == "1") { // 직접비 공용

		if (DS_LC_CAL_TYPE.NameValue(row,"RCODE2") == "0") {			
	        //필터로 변경된 값초기화
	        
	        if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CAL_TYPE") == DS_LC_CAL_TYPE.NameValue(row,"CODE")) {
	            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CAL_TYPE") = "";
	        }
	        return false;
	    } else { 

	        return true;
	    }
	} else { //직접비 사용자
		
        if (DS_LC_CAL_TYPE.NameValue(row,"RCODE1") == "1" || DS_LC_CAL_TYPE.NameValue(row,"RCODE1") == "0") {
        	
            //필터로 변경된 값초기화
            if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CAL_TYPE") == DS_LC_CAL_TYPE.NameValue(row,"CODE")) {
                DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CAL_TYPE") = "";
            }
            return false;
        } else { 
            return true;
        }
	}
} else { // 간접비(공용)
	if (DS_LC_CAL_TYPE.NameValue(row,"RCODE3") == "0") {
        //필터로 변경된 값초기화
        if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CAL_TYPE") == DS_LC_CAL_TYPE.NameValue(row,"CODE")) {
            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CAL_TYPE") = "";
        }
        return false;
    } else { 
        return true;
    }
}
</script>
 

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝 
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->
<!-- =============== Input용 -->
<comment id="_NSID_"><object id="DS_IO_MASTER"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- =============== Output용 -->
<comment id="_NSID_"><object id="DS_O_DUPKEYVALUE"  classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- =============== ONLOAD용 -->
<comment id="_NSID_"><object id="DS_LC_S_STR_CD"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_S_MNTN_TYPE" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_S_MNTN_FLAG" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_MNTN_TYPE"   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_MNTN_FLAG"   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_STR_CD"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_AUTO_DIV_YN" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_AUTO_DIV_ITEM" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_TAX_INVFLAG" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_USE_YN"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- 필터사용 DATASET -->
<comment id="_NSID_">
<object id="DS_LC_CAL_TYPE"    classid=<%=Util.CLSID_DATASET%>>
<param name=UseFilter   value=true>
</object>
</comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_LC_CAL_CD"    classid=<%=Util.CLSID_DATASET%>>
<param name=UseFilter   value=true>
</object>
</comment><script>_ws_(_NSID_);</script>

<!-- =============== 공통함수용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

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

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝 
<!--*************************************************************************-->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_MASTER");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
}
</script>


<!--*************************************************************************-->
<!--* E. 본문시작 
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<div id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="o_table">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th class="point" width="80">시설구분</th>
						<td width="140"><comment id="_NSID_"> <object
							id=LC_S_STR_CD classid=<%=Util.CLSID_LUXECOMBO%>
							width="140" height=100 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="80">관리비분류</th>
						<td width="140"><comment id="_NSID_"> <object
							id=LC_S_MNTN_TYPE classid=<%=Util.CLSID_LUXECOMBO%>
							width="140" height=100 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="80">관리비구분</th>
						<td><comment id="_NSID_"> <object
							id=LC_S_MNTN_FLAG classid=<%=Util.CLSID_LUXECOMBO%>
							width="140" height=100 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
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
		<td align="right"><img id="IMG_ADD_ROW"
			style="vertical-align: middle;" src="/<%=dir%>/imgs/btn/add_row.gif"
			width="52" height="18" onclick="btn_AddRow();" hspace="2" /><img
			id="IMG_DEL_ROW" style="vertical-align: middle;"
			src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18"
			onclick="btn_DeleteRow();" /></td>
	</tr>
	<tr>
		<td height="3"></td>
	</tr>
	<tr valign="top">
		<td align="left">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr valign="top">
				<td><comment id="_NSID_"><OBJECT id=GD_MASTER
					width=100% height=760 classid=<%=Util.CLSID_GRID%>>
					<param name="DataID" value="DS_IO_MASTER">
				</OBJECT></comment><script>_ws_(_NSID_);</script></td>
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

