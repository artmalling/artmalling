<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 임대관리 > 상하수도요금표관리
 * 작 성 일 : 2010.03.17
 * 작 성 자 : 김유완
 * 수 정 자 : 
 * 파 일 명 : MREN1030.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 상하수도요금표관리
 * 이    력 : 2010.03.17 (김유완) 신규작성
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
 * 작 성 일 : 2010.03.17
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){
    // Input Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MR_WATERPRC"/>');
    registerUsingDataset('<%=((SessionInfo) session.getAttribute("sessionInfo")).getPGM_ID()%>'.toLowerCase(), "DS_IO_MASTER");
    
    //그리드 초기화
    gridCreate("MST"); //마스터
    
    //콤보 초기화
    initComboStyle(LC_S_WTR_TYPE,DS_LC_S_WTR_TYPE, "CODE^0^30,NAME^0^80", 1, NORMAL);       // [조회용]상하수도구분     
    initComboStyle(LC_S_WTR_KIND_CD,DS_LC_S_WTR_KIND_CD, "CODE^0^30,NAME^0^80", 1, NORMAL); // [조회용]업종구분     
    initComboStyle(LC_S_AREA_FLAG,DS_LC_S_AREA_FLAG, "CODE^0^30,NAME^0^80", 1, NORMAL);     // [조회용]지역    
       
    //시스템 코드 공통코드에서 가지고 오기
    getEtcCode("DS_LC_S_WTR_TYPE",      "D", "M055", "Y", "N", LC_S_WTR_TYPE);      // [조회용]상하수도구분     
    getEtcCode("DS_LC_S_WTR_KIND_CD",   "D", "M045", "Y", "N", LC_S_WTR_KIND_CD);   // [조회용]업종구분        
    DS_LC_S_WTR_KIND_CD.Filter();

    getEtcCode("DS_LC_S_AREA_FLAG",     "D", "M080", "Y", "N", LC_S_AREA_FLAG);     // [조회용]지역   
    getEtcCode("DS_LC_WTR_TYPE",        "D", "M055", "N");  // 상하수도구분     
    getEtcCode("DS_LC_WTR_KIND_CD",     "D", "M045", "N");  // 업종구분                                                                 
    DS_LC_WTR_KIND_CD.Filter();
    getEtcCode("DS_LC_AREA_FLAG",       "D", "M080", "N");  // 지역   
    LC_S_AREA_FLAG.Focus();
}

function gridCreate(gdGnb){
	//마스터그리드
	if (gdGnb == "MST") {
	    var hdrProperies = ''
	        + '<FC>ID={CURROW}      NAME="NO"'
	        + '                                         WIDTH=30    ALIGN=CENTER'
	        + '                                         BGCOLOR={IF(DUPCHK="Y","RED","WHITE")}</FC>'
	        + '<FC>ID=AREA_FLAG     NAME="*지역"'
	        + '                                         WIDTH=110   ALIGN=LEFT     EDITSTYLE=LOOKUP   DATA="DS_LC_AREA_FLAG:CODE:NAME"'
	        + '                                         BGCOLOR={IF(DUPCHK="Y","RED","WHITE")}</FC>'
	        + '<FC>ID=WTR_TYPE      NAME="*상하수도구분"'
	        + '                                         WIDTH=130   ALIGN=LEFT     EDITSTYLE=LOOKUP   DATA="DS_LC_WTR_TYPE:CODE:NAME"'
	        + '                                         BGCOLOR={IF(DUPCHK="Y","RED","WHITE")}</FC>'
	        + '<FC>ID=WTR_KIND_CD   NAME="*업종구분"'
	        + '                                         WIDTH=110   ALIGN=LEFT     EDITSTYLE=LOOKUP   DATA="DS_LC_WTR_KIND_CD:CODE:NAME"'
	        + '                                         BGCOLOR={IF(DUPCHK="Y","RED","WHITE")}</FC>'
	        + '<FC>ID=SEQ           NAME="SEQ"'
	        + '                                         WIDTH=130   ALIGN=RIGHT    EDIT=NUMERIC    SHOW=FALSE</FC>'
	        + '<FC>ID=USE_S_QTY     NAME="*사용구간(㎥) FROM"'
	        + '                                         WIDTH=130   ALIGN=RIGHT    EDIT=NUMERIC'
	        + '                                         BGCOLOR={IF(DUPCHK="Y","RED","WHITE")}</FC>'
	        + '<FC>ID=USE_E_QTY     NAME="*사용구간(㎥) TO"'
	        + '                                         WIDTH=130   ALIGN=RIGHT    EDIT=NUMERIC'
	        + '                                         BGCOLOR={IF(DUPCHK="Y","RED","WHITE")}</FC>'
	        + '<FC>ID=UNIT_PRC      NAME="*단가(원)"'
	        + '                                         WIDTH=130   ALIGN=RIGHT    EDIT=NUMERIC</FC>'
	        + '<FC>ID=DUPCHK        NAME="중복체크"'
	        + '                                         WIDTH=130   SHOW=FALSE</FC>'
	        ;   
	    initGridStyle(GD_MASTER, "COMMON", hdrProperies, true);
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
 * 작 성 일 : 2010.03.17
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    if (DS_IO_MASTER.IsUpdated) {//변경데이터 있을 시 확인
        var ret = showMessage(Question, YesNo, "USER-1059");
        if (ret == "1") {
            // parameters
            var strWtrType  = LC_S_WTR_TYPE.BindColVal;     // [조회용]상하수도구분
            var strWtrKind  = LC_S_WTR_KIND_CD.BindColVal;  // [조회용]업종구분
            var strAreaFlag = LC_S_AREA_FLAG.BindColVal;    // [조회용]지역
            
            var goTo = "getMaster";
            var parameters = ""
                + "&strWtrType="    + encodeURIComponent(strWtrType)
                + "&strWtrKind="    + encodeURIComponent(strWtrKind)
                + "&strAreaFlag="   + encodeURIComponent(strAreaFlag);
            TR_MAIN.Action = "/mss/mren103.mr?goTo=" + goTo + parameters;
            TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
            TR_MAIN.Post();
        
            // 조회결과 Return
            setPorcCount("SELECT", GD_MASTER);
        } else {
            return;
        }
    }  else {
        // parameters
        var strWtrType  = LC_S_WTR_TYPE.BindColVal;     // [조회용]상하수도구분
        var strWtrKind  = LC_S_WTR_KIND_CD.BindColVal;  // [조회용]업종구분
        var strAreaFlag = LC_S_AREA_FLAG.BindColVal;    // [조회용]지역
        
        var goTo = "getMaster";
        var parameters = ""
            + "&strWtrType="    + encodeURIComponent(strWtrType)
            + "&strWtrKind="    + encodeURIComponent(strWtrKind)
            + "&strAreaFlag="   + encodeURIComponent(strAreaFlag);
        TR_MAIN.Action = "/mss/mren103.mr?goTo=" + goTo + parameters;
        TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
        TR_MAIN.Post();
    
        // 조회결과 Return
        setPorcCount("SELECT", GD_MASTER);
    }
}

/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.17
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    DS_IO_MASTER.AddRow();
    GD_MASTER.SetColumn("AREA_FLAG");
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.17
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
    DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition); 
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.17
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    if (DS_IO_MASTER.IsUpdated) {//변경 데이터가 있을때만 저장
        //필수 입력값,스크립트 중복 값 체크
	    if (!checkValidate()) return;
    
        //DB중복값제크
        if (!checkValidateDB()) {
            showMessage(INFORMATION, OK, "USER-1000", "이미 등록된 내역과 겹치는 사용구간이 존재합니다."); 
            return; 
        }
        
      //변경또는 신규 내용을 저장하시겠습니까?
        if( showMessage(INFORMATION, YESNO, "USER-1010") != 1 ){
            GD_MASTER.Focus();
            return;
        }
    
	    //저장
        var goTo = "save";
        TR_SAVE.Action = "/mss/mren103.mr?goTo=" + goTo;
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
    GD_MASTER.SetColumn("AREA_FLAG");
}

/**
 * btn_DeleteRow()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.10
 * 개    요 : 행삭제
 * return값 :
 */
function btn_DeleteRow() {
	DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition); 
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 
/**
 * setUseQty()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.17
 * 개    요 : 사용구간From Set
 * return값 : maxToVal
 */
function setUseQty(Row) {
	//이미 입력된 내역이 있을때는 입력하지 않음
    //if (DS_IO_MASTER.NameValue(Row, "USE_S_QTY") != "" ) return;
	//지역,상하수도구분,업종구분이 모두 등록된 상태
    if (DS_IO_MASTER.NameValue(Row, "AREA_FLAG") == "" )    return;
    if (DS_IO_MASTER.NameValue(Row, "WTR_TYPE") == "" )     return;
    if (DS_IO_MASTER.NameValue(Row, "WTR_KIND_CD") == "" )  return;
    
   	var maxToVal = 0;
   	var strChkKeyVal  = ""
        + "" +DS_IO_MASTER.NameValue(Row, "AREA_FLAG")
        + "" +DS_IO_MASTER.NameValue(Row, "WTR_TYPE")
        + "" +DS_IO_MASTER.NameValue(Row, "WTR_KIND_CD");
    for (i=1; i<=DS_IO_MASTER.CountRow; i++) {
    	if (i != Row) {
	    	var tmpChkKeyVal = ""
	    		+ "" +DS_IO_MASTER.NameValue(i, "AREA_FLAG")
	            + "" +DS_IO_MASTER.NameValue(i, "WTR_TYPE")
	            + "" +DS_IO_MASTER.NameValue(i, "WTR_KIND_CD");
	    	if (strChkKeyVal == tmpChkKeyVal) {
	    	    var tmpMaxToVal = eval(DS_IO_MASTER.NameValue(i, "USE_E_QTY"));
	    		if (tmpMaxToVal > maxToVal) {
	    			maxToVal = eval(tmpMaxToVal);
	    		}
	    	}
    	}
    } 
    if (eval(maxToVal) > 0) {
	    DS_IO_MASTER.NameValue(Row, "USE_S_QTY") = eval(maxToVal+1);
    } else {
    	DS_IO_MASTER.NameValue(Row, "USE_S_QTY") = 0;
    }
}

 
 
/**
 * checkValidate()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.17
 * 개    요 : 값체크(저장)
 * return값 :
 */
function checkValidate() {
    // 필수 입력값 체크
    for (var n=1; n<=DS_IO_MASTER.CountRow; n++) {
        if (DS_IO_MASTER.RowStatus(n) != 0 ) {
            // 지역
            if (DS_IO_MASTER.NameValue(n,"AREA_FLAG") == "") {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("AREA_FLAG");
                showMessage(INFORMATION, OK, "USER-1002", "지역");
                return false;
            }
            
            // 상하수도구분
            if (DS_IO_MASTER.NameValue(n,"WTR_TYPE") == "") {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("WTR_TYPE");
                showMessage(INFORMATION, OK, "USER-1002", "상하수도구분");
                return false;
            }
            
            // 업종구분
            if (DS_IO_MASTER.NameValue(n,"WTR_KIND_CD") == "") {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("WTR_KIND_CD");
                showMessage(INFORMATION, OK, "USER-1002", "업종구분");
                return false;
            }
            
            
            // 사용구간(To)
            if (DS_IO_MASTER.NameValue(n,"USE_E_QTY") == 0) {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("USE_E_QTY");
                showMessage(INFORMATION, OK, "USER-1002", "사용구간(To)");
                return false;
            }
            
            //사용구간 체크(From ~ To)
            var strUseS = DS_IO_MASTER.NameValue(n, "USE_S_QTY");
            var strUseE = DS_IO_MASTER.NameValue(n, "USE_E_QTY");
            if (eval(strUseS) > eval(strUseE)) {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("USE_S_QTY");
                showMessage(INFORMATION, OK, "USER-1009", "사용구간(From)", "사용구간(To)");
                return false;
            }
            
            // 단가(원)
            if (DS_IO_MASTER.NameValue(n,"UNIT_PRC") == 0) {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("UNIT_PRC");
                showMessage(INFORMATION, OK, "USER-1002", "단가(원)");
                return false;
            }
        }
    }
	 
	// 중복값 체크 
	for (var i=1; i<=DS_IO_MASTER.CountRow; i++) {
        var tmpChkKeyVal = ""
            + "" +DS_IO_MASTER.NameValue(i, "AREA_FLAG")
            + "" +DS_IO_MASTER.NameValue(i, "WTR_TYPE")
            + "" +DS_IO_MASTER.NameValue(i, "WTR_KIND_CD");
        for (var k=i+1; k<=DS_IO_MASTER.CountRow; k++) {
            var targetChkKeyVal = ""
                + "" +DS_IO_MASTER.NameValue(k, "AREA_FLAG")
                + "" +DS_IO_MASTER.NameValue(k, "WTR_TYPE")
                + "" +DS_IO_MASTER.NameValue(k, "WTR_KIND_CD");
            if (tmpChkKeyVal == targetChkKeyVal) {
            	var iUseS = DS_IO_MASTER.NameValue(i, "USE_S_QTY");
            	var iUseE = DS_IO_MASTER.NameValue(i, "USE_E_QTY");
            	var kUseS = DS_IO_MASTER.NameValue(k, "USE_S_QTY");
            	var kUseE = DS_IO_MASTER.NameValue(k, "USE_E_QTY");
                if ( // 사용구간(From)
                     (eval(iUseS) >= eval(kUseS) && eval(iUseS) <= eval(kUseE)) ||
                     (eval(iUseE) >= eval(kUseS) && eval(iUseE) <= eval(kUseE)) 
                    ||
                    // 사용구간(To)
                     (eval(kUseS) >= eval(iUseS) && eval(kUseS) <= eval(iUseE)) ||
                     (eval(kUseE) >= eval(iUseS) && eval(kUseE) <= eval(iUseE)))  
                {
                       DS_IO_MASTER.RowPosition = k;
                       showMessage(INFORMATION, OK, "USER-1000", "["+i+"]번째 행의 사용구간이  ["+k+"]번째 행의 사용구간과 중복 됩니다.");
                       return false;
                }
            }
        }
	} 
    return true;
}

/**
 * checkValidateDB()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.17
 * 개    요 : 값체크(저장)
 * return값 :
 */
function checkValidateDB() {
	// 중복키값 색상초기화
	for (var j=1; j<=DS_IO_MASTER.CountRow; j++) {
	    DS_IO_MASTER.NameValue(j,"DUPCHK") = "N"; 
	}
     
	var goTo = "getDupKeyValue";
	var parameters = "";
	TR_MAIN.Action = "/mss/mren103.mr?goTo=" + goTo + parameters;
	TR_MAIN.KeyValue = "SERVLET(O:DS_O_DUPKEYVALUE=DS_O_DUPKEYVALUE, I:DS_IO_MASTER=DS_IO_MASTER)";
	TR_MAIN.StatusResetType= "2"; //DS상태 초기화 하지 않음
	TR_MAIN.Post();
	
	if (DS_O_DUPKEYVALUE.CountRow < 1 ) {
	    return true;
	} else { 
	    for (var i=1; i<=DS_IO_MASTER.CountRow; i++) {
	        //if (DS_IO_MASTER.RowStatus(i) == 1 || DS_IO_MASTER.RowStatus(i) == 3) { // 신규일시
	        if (DS_IO_MASTER.RowStatus(i) == 1) { // 신규일시
	            DS_IO_MASTER.NameValue(i,"DUPCHK") = "N"; // 중복키값 색상초기화
	            var tmpKey = DS_IO_MASTER.NameValue(i,"AREA_FLAG") 
	              +""+ DS_IO_MASTER.NameValue(i,"WTR_TYPE")
	              +""+ DS_IO_MASTER.NameValue(i,"WTR_KIND_CD")
	              +""+ DS_IO_MASTER.NameValue(i,"USE_S_QTY");
	            for (var k=1; k<=DS_O_DUPKEYVALUE.CountRow; k++) {
	                if (DS_O_DUPKEYVALUE.NameValue(k,"DUPVALUE") == tmpKey) {
	                    DS_IO_MASTER.NameValue(i,"DUPCHK") = "Y";
	                } 
	            }
	        }
	    }
	    return false;
	}
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
 /*   showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }*/
    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_SAVE event=onFail>
 /*   showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_SAVE.ErrorCode + "\n" + "ErrorMsg  : " + TR_SAVE.ErrorMsg);
    for(i=1;i<TR_SAVE.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_SAVE.SrvErrMsg('GAUCE',i));
    }*/
    trFailed(TR_SAVE.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_LC_S_WTR_KIND_CD event=OnFilter(row)>
// 용도구분
if (DS_LC_S_WTR_KIND_CD.NameValue(row,"CODE").substring(0,1) == "6" ||
	DS_LC_S_WTR_KIND_CD.NameValue(row,"CODE").substring(0,1) == "%") { 
    return true;
} else { 
    return false;
}
</script>

<script language=JavaScript for=DS_LC_WTR_KIND_CD event=OnFilter(row)>
// 용도구분
if (DS_LC_WTR_KIND_CD.NameValue(row,"CODE").substring(0,1) == "6" ) { 
    return true;
} else { 
    return false;
}
</script>

<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>
if(clickSORT) return;
if (DS_IO_MASTER.RowStatus(row) == "1") {
    GD_MASTER.ColumnProp('AREA_FLAG',   'Edit') = "";       // 지역
    GD_MASTER.ColumnProp('WTR_TYPE',    'Edit') = "";       // 상하수도구분
    GD_MASTER.ColumnProp('WTR_KIND_CD', 'Edit') = "";       // 업종구분
} else {
    GD_MASTER.ColumnProp('AREA_FLAG',   'Edit') = "NONE";   // 지역
    GD_MASTER.ColumnProp('WTR_TYPE',    'Edit') = "NONE";   // 상하수도구분
    GD_MASTER.ColumnProp('WTR_KIND_CD', 'Edit') = "NONE";   // 업종구분
}

</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
//그리드 정렬기능
    if( row < 1) sortColId( eval(this.DataID), row , colid );
</script>

<script language=JavaScript for=GD_MASTER event=OnCloseUp(row,colid)>
//Combo선택시
	setUseQty(row);
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
<comment id="_NSID_"><object id="DS_IO_MASTER"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- =============== Output용 -->
<comment id="_NSID_"><object id="DS_O_DUPKEYVALUE"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- =============== ONLOAD용 -->
<comment id="_NSID_"><object id="DS_LC_S_WTR_TYPE"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_S_WTR_KIND_CD"   classid=<%=Util.CLSID_DATASET%>><param name=UseFilter   value=true></object>
</comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_S_AREA_FLAG"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_WTR_TYPE"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_WTR_KIND_CD"     classid=<%=Util.CLSID_DATASET%>><param name=UseFilter   value=true></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_AREA_FLAG"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- =============== 공통함수용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"           classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"           classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
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
						<th width="80">지역</th>
						<td width="140"><comment id="_NSID_"> <object
							id=LC_S_AREA_FLAG classid=<%=Util.CLSID_LUXECOMBO%>
							width="140" height=100 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="80">상하수도구분</th>
						<td width="140"><comment id="_NSID_"> <object
							id=LC_S_WTR_TYPE classid=<%=Util.CLSID_LUXECOMBO%>
							width="140" height=100 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="80">업종구분</th>
						<td ><comment id="_NSID_"> <object
							id=LC_S_WTR_KIND_CD classid=<%=Util.CLSID_LUXECOMBO%>
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
					width=100% height=483 classid=<%=Util.CLSID_GRID%>>
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

