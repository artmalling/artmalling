<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출관리 > 카드 청구 > 카드빈 관리
 * 작 성 일 : 2010.05.24
 * 작 성 자 : 장형욱
 * 수 정 자 : 
 * 파 일 명 : psal9040.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        2010.05.24 (장형욱) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
	import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	request.setCharacterEncoding("utf-8");
	String dir = BaseProperty.get("context.common.dir");
	// PID 확인을 위한
    String pageName = request.getRequestURI();
    int nSubStrFr = pageName.lastIndexOf("/") + 1 ;
    int nSubStrTo = pageName.lastIndexOf(".jsp") - 1 ;
    pageName = pageName.substring(nSubStrFr, nSubStrTo).toUpperCase();

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
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"
	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작   *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var strChangFlag      = false;
var bfListRowPosition = 0;                             // 이전 List Row Position
var intChangRow       = 0;
var EXCEL_PARAMS = "";
var g_strPid           = "<%=pageName%>";                 // PID

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-05-19
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
          
    //Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1();  

    //-- 입력필드
    initEmEdit(EM_S_BIN_NO_S,    "000000",       PK);        //-- 카드빈      
    initEmEdit(EM_E_BIN_NO_S,    "000000",       PK);        //-- 카드빈      
    initEmEdit(EM_CCOMP_CD_S,    "00",           NORMAL);         
    initEmEdit(EM_CCOMP_NM_S,    "GEN^20",       READ);   
    
    initEmEdit(EM_BIN_NO,        "000000",      PK);  
    initEmEdit(EM_CCOMP_CD,      "00",          PK);         
    initEmEdit(EM_CCOMP_NM,      "GEN^20",      READ);       
    initEmEdit(EM_CARD_NAME,     "GEN^20",      PK);     
    initEmEdit(EM_APP_DT,        "today",       PK);     
    
    initComboStyle(LC_DCARD_TYPE_S, DS_O_DCARD,   "CODE^0^30, NAME^0^80", 1, NORMAL);
    initComboStyle(LC_DCARD_TYPE,   DS_O_DCARD_D, "CODE^0^30, NAME^0^80", 1, PK);
    initComboStyle(LC_VCARD_TYPE,   DS_O_VCARD,   "CODE^0^30, NAME^0^80", 1, PK);
    initComboStyle(LC_CHECK_YN,     DS_O_CHECK_YN,"CODE^0^30, NAME^0^80", 1, PK);
    
    
    
    
    
    // EMedit에 초기화
    getEtcCode("DS_O_DCARD",     "D", "D038", "Y");
    getEtcCode("DS_O_DCARD_D",   "D", "D038", "N"); 
    getVcardCode("DS_O_VCARD",   "", "", "N");    
    getEtcCode("DS_O_CHECK_YN", "D", "D022", "N");
    
    LC_DCARD_TYPE.Index = 0;    
    LC_VCARD_TYPE.Index = 0;
    LC_CHECK_YN.Index = 0;
    
    RD_DEL_YN.CodeValue = "N";
    LC_DCARD_TYPE_S.BindColVal = "%"; 
    
    //화면에서 사용자가 입력,수정,삭제 한 데이터가 있는지 확인하는 함수-해당 페이지를 닫을 때 ‘저장하시겠습니까?’ 로직 처리를 위해 필요함
    registerUsingDataset("psal904","DS_O_MASTER,DS_IO_DETAIL");
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}       name="NO"               width=30      align=center</FC>'
                     + '<FC>id=BIN_NO         name="카드빈번호"         width=80     align=center</FC>'
                     + '<FC>id=DCARD_TYPE     name="카드종류코드"   width=80    align=center</FC>'
                     + '<FC>id=DCARD_NAME     name="카드종류명"    width=100     align=left</FC>'
                     + '<FC>id=CCOMP_CD       name="카드발급사코드"      width=100    align=center</FC>'
                     + '<FC>id=CCOMP_NM       name="카드발급사명"        width=100    align=left</FC>'
                     + '<FC>id=CARD_NAME      name="카드명칭"           width=130    align=left</FC>'
                     + '<FC>id=VCARD_TYPE     name="밴사카드종류코드"     width=100     align=center</FC>'
                     + '<FC>id=VCARD_NAME     name="밴사카드종류명"      width=100      align=left</FC>'
                     + '<FC>id=APP_DT         name="적용일자"           width=80      align=center mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=DEL_YN         name="삭제여부"           width=60      align=center</FC>'
                     + '<FC>id=REF_CODE1      name="체크취소"           width=60      align=center</FC>'
                     ;
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 신규       - btn_New()
     (3) 삭제       - btn_Delete()
     (4) 저장       - btn_Save()
     (5) 엑셀       - btn_Excel()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-05-23
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {  
    if ( DS_IO_DETAIL.IsUpdated) {
        if(showMessage(EXCLAMATION, YESNO, "USER-1073") != 1 ){
            return false;
        }else{
          strChangFlag = true;
        }
    }
    
    if(trim(EM_S_BIN_NO_S.text).length == 0){          //카드빈
        showMessage(EXCLAMATION, OK, "USER-1001","카드빈");
        EM_S_BIN_NO_S.Focus();
        return;
    }
    if(trim(EM_E_BIN_NO_S.text).length == 0){           //카드빈
        showMessage(EXCLAMATION, OK, "USER-1001","카드빈");
        EM_E_BIN_NO_S.Focus();
        return;
    }

    if( EM_S_BIN_NO_S.Text > EM_E_BIN_NO_S.Text){         //조회일 정합성
        showMessage(EXCLAMATION, OK, "USER-1015","카드빈 시작번호는 카드빈 종료번호보다 작아야 합니다.");
        EM_S_BIN_NO_S.Focus();
        return;
    }
    
    showMaster();
}

/**
 * btn_New()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-05-23
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    if ( DS_IO_DETAIL.IsUpdated) {
        if(showMessage(EXCLAMATION, YESNO, "USER-1072") != 1 ){
            setTimeout("EM_BIN_NO.Focus();",50);
            return false;
        }else{
            strChangFlag = true;
            if(DS_O_MASTER.NameValue(DS_O_MASTER.CountRow, "BIN_NO") == ""){
                DS_O_MASTER.DeleteRow(DS_O_MASTER.RowPosition);
            }
        }
    }
    
    DS_O_MASTER.AddRow();
    DS_IO_DETAIL.ClearData();
    DS_IO_DETAIL.AddRow();
   
    strChangFlag = false;
    RD_DEL_YN.CodeValue = "N";
    initEmEdit(EM_BIN_NO,           "000000",       PK);  
    initComboStyle(LC_DCARD_TYPE,   DS_O_DCARD, "CODE^0^20, NAME^0^80", 1, NORMAL);
    bfListRowPosition = 0;
    intChangRow = 1;
    EM_BIN_NO.focus();
}
 

/**
 * btn_Save()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-05-23
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    // 저장할 데이터 없는 경우
    if (!DS_IO_DETAIL.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(EXCLAMATION, OK, "USER-1028");
        return;
    } 
    if (trim(EM_BIN_NO.text).length == 0) {
        showMessage(EXCLAMATION, OK, "USER-1003",  "카드빈 번호");
        EM_BIN_NO.Focus();
        return;
    } 
    if (trim(LC_DCARD_TYPE.BindColVal).length == 0) {
        showMessage(EXCLAMATION, OK, "USER-1003",  "포인트카드종류");
        LC_DCARD_TYPE.Focus();
        return;
    } 
    if (trim(EM_CCOMP_CD.text).length == 0) {
        showMessage(EXCLAMATION, OK, "USER-1003",  "카드발급사");
        EM_CCOMP_CD.Focus();
        return;
    }    
    if (trim(EM_CCOMP_NM.text).length == 0) {
        showMessage(EXCLAMATION, OK, "USER-1003",  "카드발급사명");
        EM_CCOMP_NM.Focus();
        return;
    }     
    if (trim(EM_CARD_NAME.text).length == 0) {
        showMessage(EXCLAMATION, OK, "USER-1003",  "카드명칭");
        EM_CARD_NAME.Focus();
        return;
    }      
    if (trim(LC_VCARD_TYPE.BindColVal).length == 0) {
        showMessage(EXCLAMATION, OK, "USER-1003",  "밴사카드종류");
        LC_VCARD_TYPE.Focus();
        return;
    }
    if (trim(EM_APP_DT.text).length == 0) {
        showMessage(EXCLAMATION, OK, "USER-1003",  "적용일자");
        EM_APP_DT.Focus();
        return;
    }      
    if (trim(RD_DEL_YN.CodeValue).length == 0) {
        showMessage(EXCLAMATION, OK, "USER-1003",  "삭제여부");
        RD_DEL_YN.Focus();
        return;
    }      
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        return;
    }   
    saveData();
}

/**
 * btn_Excel()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-05-23
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
        
    if(DS_O_MASTER.CountRow == 0 ){
        showMessage(EXCLAMATION, OK, "USER-1000",  "조회 후 엑셀다운 하십시오.");
        return false;
    }
    var ExcelTitle = "카드빈 관리"
    //openExcel2(GD_MASTER, ExcelTitle, EXCEL_PARAMS, true );
    	openExcel5(GD_MASTER, ExcelTitle, EXCEL_PARAMS, true , "",g_strPid );

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-05-23
 * 개       요 : 카드발급사코드 관리 조회
 * return값 : void
 */
function showMaster(){
    var binNo  = EM_S_BIN_NO_S.text;
    var binNo2 = EM_E_BIN_NO_S.text
  
    if (binNo == "")
        binNo = "000000";   
    
    if (binNo2 == "")
        binNo2 = "999999";   
    
    EXCEL_PARAMS  = "카드빈 번호="       + binNo + "~" + binNo2;
    EXCEL_PARAMS += "-카드발급사="       + EM_CCOMP_NM_S.text;
    EXCEL_PARAMS += "-포인트카드종류="   + LC_DCARD_TYPE_S.text;
    
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strSBinNo="     +  encodeURIComponent(EM_S_BIN_NO_S.text)
                    + "&strEBinNo="     +  encodeURIComponent(EM_E_BIN_NO_S.text)   
                    + "&strCcomp="      +  encodeURIComponent(EM_CCOMP_CD_S.text)   
                    + "&strDcardType="  +  encodeURIComponent(LC_DCARD_TYPE_S.BindColVal);   
    
    TR_MAIN.Action  = "/dps/psal904.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();

    //그리드 첫 row 상세조회
    if(DS_O_MASTER.CountRow > 0){
        GD_MASTER.Focus();
        if(intChangRow > 0){
            bfListRowPosition = DS_O_MASTER.RowPosition;
            setFocusGrid(GD_MASTER, DS_O_MASTER, intChangRow);
            doClick(intChangRow);
        }
    }else{
    	EM_S_BIN_NO_S.Focus();
    	DS_IO_DETAIL.ClearData();
    	RD_DEL_YN.CodeValue = "N";
    }

    bfListRowPosition = 0;
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
}

/**
 * saveData()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-05-23
 * 개       요 : 카드발급사코드 관리 등록
 * return값 : void
 */
function saveData(){
   var goTo        = "saveData";
   var action      = "I";  //조회는 O
   TR_MAIN.Action  ="/dps/psal904.ps?goTo="+goTo;   
   TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; 
   TR_MAIN.Post();

   btn_Search();
}

/**
 * btn_Delete()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-05-19
 * 개       요 : 선택된 카드빈 삭제 
 * return값 : void
 */
function btn_Delete(row){
	 
	 
	if ( DS_IO_DETAIL.CountRow < 1){
		//삭제할 내용이 없습니다
		showMessage(INFORMATION, OK, "USER-1019");
		
		return;
	}

	// 상세에 변경내역있을  경우
	if( DS_IO_DETAIL.IsUpdated){
		showMessage(INFORMATION , OK, "USER-1091");
		
		return;
	}

	//선택한 항목을 삭제하겠습니까?
	if( showMessage(QUESTION, YESNO, "USER-1023") != 1 ){
		
		return;
	}
	 
	 
     
    if( row == undefined ) 
        row = DS_O_MASTER.RowPosition;
    
    DS_IO_DETAIL.DeleteRow(1);
     
    var goTo          = "saveData";    
    var action        = "I";     
    var parameters    = "&strBinNo="   + encodeURIComponent(DS_O_MASTER.NameValue(row ,"BIN_NO"))
                      + "&strDcardType=" + encodeURIComponent(DS_O_MASTER.NameValue(row ,"DCARD_TYPE"));
    
    TR_DETAIL.Action  = "/dps/psal904.ps?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue= "SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_DETAIL.Post();
    
    btn_Search();
    
    
}  
  
/**
 * doOnClick()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-05-19
 * 개       요 : 선택된 클럽관리 정보 상세 조회 
 * return값 : void
 */
function doClick(row){
    if( row == undefined ) 
        row = DS_O_MASTER.RowPosition;
     
    var goTo          = "searchDetail";    
    var action        = "O";     
    var parameters    = "&strBinNo="   + encodeURIComponent(DS_O_MASTER.NameValue(row ,"BIN_NO"))
                      + "&strDcardType=" + encodeURIComponent(DS_O_MASTER.NameValue(row ,"DCARD_TYPE"));
    TR_DETAIL.Action  = "/dps/psal904.ps?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue= "SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_DETAIL.Post();
    
    EM_BIN_NO.Enable = false;
    //LC_DCARD_TYPE.Enable = false;
    //initEmEdit(EM_BIN_NO,      "GEN^6",       READ);  
    //initComboStyle(LC_DCARD_TYPE,   DS_O_DCARD, "CODE^0^20, NAME^0^80", 1, READ);
}  

/**
 * keyPressEvent()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-05-25
 * 개      요  : Enter, Tab키 이벤트
 * return값 :
 */
function keyPressEvent(kcode, objCd, objNm) { 
	objNm.Text = "";//조건입력시 코드초기화 
    if (objCd.Text.length > 0 ) {
        if (kcode == 13 || kcode == 9 || objCd.Text.length == 2) { //TAB,ENTER 키 실행시에만  
            var goTo       = "searchOnMaster" ;    
            var action     = "O";     
            var parameters = "&strCcompCd="+encodeURIComponent(objCd.Text);
            
            TR_MAIN.Action="/pot/ccom027.cc?goTo="+goTo+parameters;
            TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_RESULT)"; //조회는 O
            TR_MAIN.Post();
              
            if (DS_O_RESULT.CountRow == 1 ) {
            	objCd.Text   = DS_O_RESULT.NameValue(1, "CODE");
            	objNm.Text   = DS_O_RESULT.NameValue(1, "NAME");
            } else {
                 //1건 이외의 내역이 조회 시 팝업 호출
                getCcompPop(objCd, objNm)
            }
        }  
    }  
} 
-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                         *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                                                                                                         *-->
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
<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
    intChangRow = 0;
    bfListRowPosition = DS_O_MASTER.RowPosition;
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_DETAIL event=onFail>
    trFailed(TR_DETAIL.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_MASTER event=CanRowPosChange(row)>
    if (strChangFlag == false && DS_IO_DETAIL.IsUpdated){
        if( showMessage(QUESTION, YESNO, "USER-1074") != 1 ){
            setTimeout("EM_BIN_NO.Focus();",50);
            return false;
        }else{
        	 if(DS_O_MASTER.NameValue(DS_O_MASTER.CountRow, "BIN_NO") == ""){
                 DS_O_MASTER.DeleteRow(DS_O_MASTER.RowPosition);
             }
             bfListRowPosition = row;
             intChangRow = 0;
        }
    }else{
    	return true;
    }
</script>
<!--DS_O_MASTER  CanRowPosChange(row)-->
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)> 
    //그리드 첫 row 상세조회
    if(row != 0){
    	if( bfListRowPosition == row)
            return;
        if( intChangRow == 0 ){
            bfListRowPosition = row;
            doClick(row);
        }
    }else{
        DS_IO_DETAIL.ClearData();
    }
    if(DS_O_MASTER.CountRow > 0 && DS_IO_DETAIL.CountRow == 0){
        doClick(DS_O_MASTER.RowPosition);
    }
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 카드발급사 onKillFocus() -->
<script language=JavaScript for=EM_CCOMP_CD_S event=onKillFocus()>
    if (EM_CCOMP_CD_S.Text.length < 2) {
        EM_CCOMP_CD_S.Text = "";
        EM_CCOMP_NM_S.Text = "";
    }
</script>
<!-- 카드발급사 onKillFocus() -->
<script language=JavaScript for=EM_CCOMP_CD event=onKillFocus()>
    if (EM_CCOMP_CD.Text.length < 2) {
        EM_CCOMP_CD.Text = "";
        EM_CCOMP_NM.Text = "";
    }
</script>

<!-- 적용일자 onKillFocus() -->
<script language=JavaScript for=EM_APP_DT event=onKillFocus()>
    checkDateTypeYMD(EM_APP_DT);
</script>  

<!-- Grid sorting 기능  -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                  *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->
<!-- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=DS_O_DCARD classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=DS_O_CHECK_YN classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>


<comment id="_NSID_">
<object id=DS_O_DCARD_D classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=DS_O_VCARD classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
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

<comment id="_NSID_">
<object id="TR_DETAIL" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
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
						<th width="80" class="point">카드빈</th>
						<td width="160"><comment id="_NSID_"> <object
							id=EM_S_BIN_NO_S classid=<%=Util.CLSID_EMEDIT%> width=50
							tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>~
							<comment id="_NSID_"> <object
                            id=EM_E_BIN_NO_S classid=<%=Util.CLSID_EMEDIT%> width=50
                            tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
					    </td>

						<th width="80">카드발급사</th>
						<td width="180"><comment id="_NSID_"> <object
							id=EM_CCOMP_CD_S classid=<%=Util.CLSID_EMEDIT%> width=30
							tabindex=1 onKillFocus="javascript:onKillFocus()"
							onKeyUp="javascript:keyPressEvent(event.keyCode, EM_CCOMP_CD_S, EM_CCOMP_NM_S);"></object> </comment> <script> _ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/detail_search_s.gif"
							align="absmiddle"
							onclick="getCcompPop(EM_CCOMP_CD_S, EM_CCOMP_NM_S)" /> <comment
							id="_NSID_"> <object id=EM_CCOMP_NM_S
							classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
						</td>

						<th width="80">카드종류</th>
						<td><comment id="_NSID_"> <object
							id=LC_DCARD_TYPE_S classid=<%=Util.CLSID_LUXECOMBO%> height=110
							width=130 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script></td>
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
		<td></td>
	</tr>
	<tr valign="top">
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"> <object id=GD_MASTER
					width="100%" height=423 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_MASTER">
				</object> </comment> <script>_ws_(_NSID_);</script></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="80" class="point">카드빈 번호</th>
						<td width="150"><comment id="_NSID_"> <object
							id=EM_BIN_NO classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1
							onkeyup="javascript:checkByteStr(EM_CCOMP_CD, 6, '');"></object>
						</comment> <script> _ws_(_NSID_);</script></td>

						<th width="80" class="point">카드종류</th>
						<td width="150"><comment id="_NSID_"> <object
							id=LC_DCARD_TYPE classid=<%=Util.CLSID_LUXECOMBO%> height=100
							width=130 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script></td>
							
						<th width="80" class="point">카드발급사</th>
                        <td><comment id="_NSID_"> <object
                            id=EM_CCOMP_CD classid=<%=Util.CLSID_EMEDIT%> width=30
                            tabindex=1 onKillFocus="javascript:onKillFocus()"
                            onKeyUp="javascript:keyPressEvent(event.keyCode, EM_CCOMP_CD, EM_CCOMP_NM);"></object> </comment> <script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"
                            align="absmiddle"
                            onclick="getCcompPop(EM_CCOMP_CD, EM_CCOMP_NM)" /> <comment
                            id="_NSID_"> <object id=EM_CCOMP_NM
                            classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
                        </td>
					</tr>
					<tr>
						<th width="80" class="point">카드명칭</th>
						<td width="150"><comment id="_NSID_"> <object
							id=EM_CARD_NAME classid=<%=Util.CLSID_EMEDIT%> width=120
							tabindex=1
							onkeyup="javascript:checkByteStr(EM_CARD_NAME, 20, '');"></object>
						</comment> <script> _ws_(_NSID_);</script></td>

						<th width="80" class="point">밴사카드종류</th>
						<td width="150"><comment id="_NSID_"> <object id=LC_VCARD_TYPE
							classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=130
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>

						<th width="80" class="point">적용일자</th>
						<td><comment id="_NSID_"> <object id=EM_APP_DT
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_APP_DT)" /></td>
					</tr>
					<tr>
						<th width="80" class="point">삭제여부</th>
						<td ><comment id="_NSID_"> <object
							id=RD_DEL_YN classid=<%=Util.CLSID_RADIO%>
							style="height: 20; width: 100" tabindex=1>
							<param name=Cols value="2">
							<param name=Format value="Y^Yes,N^No">
							<param name=CodeValue value="Y">
						</object> </comment><script> _ws_(_NSID_);</script></td>
						
						<th width="80" class="point">체크카드취소</th>
						<td width="150" colspan="3"><comment id="_NSID_"> <object id=LC_CHECK_YN
							classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=130
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
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
<comment id="_NSID_">
<object id=BD_HEADER classid=<%=Util.CLSID_BIND%>>
	<param name=DataID value=DS_IO_DETAIL>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
               <c>col=BIN_NO         ctrl=EM_BIN_NO            Param=Text</c>
               <c>col=DCARD_TYPE     ctrl=LC_DCARD_TYPE        Param=BindColVal</c>
               <c>col=CCOMP_CD       ctrl=EM_CCOMP_CD          Param=Text</c>
               <c>col=CCOMP_NM       ctrl=EM_CCOMP_NM          Param=Text</c>
               <c>col=CARD_NAME      ctrl=EM_CARD_NAME         Param=Text</c>
               <c>col=VCARD_TYPE     ctrl=LC_VCARD_TYPE        Param=BindColVal</c>
               <c>col=APP_DT         ctrl=EM_APP_DT            Param=Text</c>
               <c>col=DEL_YN         ctrl=RD_DEL_YN            Param=CodeValue</c>
               <c>col=REF_CODE1      ctrl=LC_CHECK_YN          Param=BindColVal</c>
             '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>
