<!-- 
/*******************************************************************************
 * 시스템명 : 경영실적 > 경영실적> 경영실적조정관리
 * 작 성 일 : 2011.08.19
 * 작 성 자 : 이정식
 * 수 정 자 : 
 * 파 일 명 : meis0620.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 해당점의 경영실적금액을 조직간에 조정한다.
 * 이    력 :
 *        2011.08.19 (이정식) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
                                                                       common.vo.SessionInfo,
                                                                       kr.fujitsu.ffw.base.BaseProperty,
                                                                       kr.fujitsu.ffw.util.Date2" %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"      prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"   prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"       prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"    prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%    
    String dir        = BaseProperty.get("context.common.dir");
    String strYm      = Date2.addMonth(-1);
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"   type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
var lo_IsMasterLoaded; //마스터 그리드가 로딩되었는지 판단 
var onPopFlag = false;
/**
 * doInit()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-19
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
    //Input Data Set Header 초기화
    
    //Output Data Set Header 초기화

    //EMEDIT 설정
    setEmEdit();

    //콤보 초기화
    setCombo();
    
    //그리드 초기화
    gridCreate();
    
    enableControl(IMG_ROW_ADD,false);
    enableControl(IMG_ROW_DEL,false);
}

/**
 * setEmEdit()
 * 작 성 자 : 이정식
 * 작 성 일 :  2011-08-19
 * 개    요 : EMEDIT 설정 
 * return값 : void
 */
function setEmEdit(){
	initEmEdit(EM_RSLT_YM, "YYYYMM", PK); //실적년월
    EM_RSLT_YM.Text = "<%=strYm%>";
}

/**
 * setCombo()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-19
 * 개    요 : 콤보 설정 
 * return값 : void
 */
function setCombo(){
	initComboStyle(LC_STR_CD  , DS_STR_CD , "CODE^0^30,NAME^0^80", 1, PK); //점(조회) 콤보
    initComboStyle(LC_DEPT_CD , DS_DEPT_CD, "CODE^0^30,NAME^0^80", 1, NORMAL); //팀(조회) 콤보
    initComboStyle(LC_TEAM_CD , DS_TEAM_CD, "CODE^0^30,NAME^0^80", 1, NORMAL); //파트(조회) 콤보
    initComboStyle(LC_PC_CD   , DS_PC_CD  , "CODE^0^30,NAME^0^80", 1, NORMAL); //PC(조회) 콤보
    initComboStyle(LC_ORG_LVL , DS_ORG_LVL, "CODE^0^20,NAME^0^40", 1, NORMAL); //조직레벨
    
    getStore("DS_STR_CD", "N", "", "N");                                                                  //점콤보 가져오기 ( gauce.js )      
    //getDept("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y");                                                //팀콤보 가져오기 ( gauce.js )
    //getTeam("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y");                         //파트콤보 가져오기 ( gauce.js )
    //getPc("DS_PC_CD"    , "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y"); //PC콤보 가져오기 ( gauce.js )
    fn_getOrg(DS_DEPT_CD, "Y", LC_STR_CD.BindColVal, "%", "%", "%", "2");
    fn_getOrg(DS_TEAM_CD, "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "%", "%", "3");
    fn_getOrg(DS_PC_CD, "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal, "%", "4");
    
    getEtcCode("DS_ORG_LVL", "D", "P048", "Y");    

    LC_STR_CD.BindColVal = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';    // 로그인 점코드
    if( LC_STR_CD.Index < 0) LC_STR_CD.Index= 0;
    LC_DEPT_CD.Index = 0;
    LC_TEAM_CD.Index = 0;
    LC_PC_CD.Index   = 0;
    DS_ORG_LVL.DeleteRow(DS_ORG_LVL.CountRow);
    LC_ORG_LVL.Index = 0;
}

/**
 * gridCreate()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-19
 * 개    요 : 그리드 초기화 
 * return값 : void
 */
function gridCreate(){
	var hdrProperies = '<C>id={currow} width=25  align=center name="NO"</C>'
		             + '<C>id=ORG_CD   width=80  align=center name="조직코드"</C>'
                     + '<C>id=ORG_NAME width=90  align=left   name="조직명"</C>'
                     ;

    initGridStyle(GD_ORG, "common", hdrProperies, false);
    
    var hdrProperies1 = '<C>id={currow}       width=25 align=center name="NO"</C>'
                      + '<C>id=BIZ_CD         width=75 align=center name="항목코드"</C>'
                      + '<C>id=BIZ_CD_NM      width=80 align=left   name="항목명"</C>'
                      + '<C>id=TOT_AMT        width=90 align=right  name="조정후실적금액"</C>'
                      + '<C>id=RSLT_AMT       width=90 align=right  name="실적금액"</C>'
                      + '<C>id=ADJST_RECV_AMT width=90 align=right  name="조정받은금액"</C>'
                      + '<C>id=ADJST_AMT      width=90 align=right  name="조정금액"</C>'
                      ;

    initGridStyle(GD_BIZ, "common", hdrProperies1, false);
    
    var hdrProperies2 = '<C>id={currow}    width=25  align=center name="NO"</C>'
                      + '<C>id=TGET_ORG_CD width=95  align=center name="대상조직코드" edit="AlphaNum" EditStyle=Popup edit={IF(SysStatus="I","true","true")}</C>'
                      + '<C>id=ORG_NAME    width=95  align=left   name="조직명" edit="None" SumText="합계"</C>'
                      + '<C>id=TGET_BIZ_CD width=85  align=center name="대상항목코드" edit="AlphaNum" EditStyle=Popup edit={IF(SysStatus="I","true","false")}</C>'
                      + '<C>id=BIZ_CD_NM   width=95  align=left   name="실적항목명" edit="None"</C>'
                      + '<C>id=ADJST_AMT   width=100 align=right  name="조정금액" SumText=@sum edit={IF(SysStatus="I","true","false")}</C>'
                      + '<C>id=REMARK      width=290 align=left   name="비고" edit={IF(SysStatus="I","true","false")}</C>'
                      ;
  
    initGridStyle(GD_ADJST, "common", hdrProperies2, true);
    GD_ADJST.ViewSummary = "1";

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
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-19
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	//1. validation
    if (isNull(EM_RSLT_YM.text)){
        showMessage(EXCLAMATION, OK, "USER-1003", "실적년월"); //(실적년월)은/는 반드시 입력해야 합니다.
        EM_RSLT_YM.focus();
        return;
    }
    if (!checkYYYYMM(EM_RSLT_YM.text)){
        showMessage(EXCLAMATION, OK, "USER-1061", "실적년월");//(실적년월)은/는 유효하지 않는 날짜입니다.
        EM_RSLT_YM.focus();
        return;
    }

	//2. 데이터셋 초기화
    DS_BIZ.ClearData();
    DS_ADJST.ClearData();
    
    //3. 조회시작
    lo_IsMasterLoaded = 0;
    var goTo       = "searchOrg";

    var parameters = "&strRsltYm=" + EM_RSLT_YM.text       //실적년월
                   + "&strOrgLvl=" + LC_ORG_LVL.BindColVal //조직레벨
                   + "&strStrCd="  + LC_STR_CD.BindColVal  //점코드
                   + "&strDeptCd=" + LC_DEPT_CD.BindColVal //팀코드
                   + "&strTeamCd=" + LC_TEAM_CD.BindColVal //파트코드
                   + "&strPcCd="   + LC_PC_CD.BindColVal   //PC코드
                   ;
    DS_ORG.DataID = "/mss/meis062.me?goTo="+goTo+parameters;
    DS_ORG.SyncLoad = "true";
    DS_ORG.Reset();
    
}

/**
 * subQuery()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-19
 * 개    요 : 
 * return값 : void
 */
function subQuery(row){
	DS_BIZ.ClearData();
    var goTo          = "searchBiz";
    var parameters    = "&strStrCd="  + DS_ORG.NameValue(row,"STR_CD")
                      + "&strRsltYm=" + DS_ORG.NameValue(row,"BIZ_RSLT_YM")
                      + "&strOrgCd="  + DS_ORG.NameValue(row,"ORG_CD");
   
    DS_BIZ.DataID = "/mss/meis062.me?goTo="+goTo+parameters;
    DS_BIZ.SyncLoad = "true";
    DS_BIZ.Reset();	 
}

/**
 * subQuery2()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-19
 * 개    요 : 
 * return값 : void
 */
function subQuery2(row){
 	var parameters = "&strRsltYm=" + DS_BIZ.NameValue(row,"BIZ_RSLT_YM")
                   + "&strStrCd="  + DS_BIZ.NameValue(row,"STR_CD")
                   + "&strOrgCd="  + DS_BIZ.NameValue(row,"ORG_CD")
                   + "&strBizCd="  + DS_BIZ.NameValue(row,"BIZ_CD")
                   ;

 	var goTo       = "searchAdj" ;
 	
 	DS_ADJST.ClearData();
 	DS_ADJST.DataID   = "/mss/meis062.me?goTo="+goTo+parameters;
 	DS_ADJST.SyncLoad = "true";
 	DS_ADJST.Reset();
}

/**
 * btn_New()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-19
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
}

/**
 * btn_Delete()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-19
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-19
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    if(!DS_ADJST.IsUpdated){
        //저장할 내용이 없습니다.
        showMessage(INFORMATION, OK, "USER-1028");
        return;
    }
    
    
    for(var i = 1; i<=DS_ADJST.CountRow ; i++){
        if(DS_ADJST.RowStatus(i) == "1"){
        	if(isNull(DS_ADJST.NameValue( i, "ORG_NAME"))){
                showMessage(EXCLAMATION, Ok,  "USER-1003", "대상조직코드");
                setFocusGrid(GD_ADJST,DS_ADJST, i, "TGET_ORG_CD");
                return;
            }
        	
        	if(isNull(DS_ADJST.NameValue( i, "BIZ_CD_NM"))){
                showMessage(EXCLAMATION, Ok,  "USER-1003", "대상항목코드");
                setFocusGrid(GD_ADJST,DS_ADJST, i, "TGET_BIZ_CD");
                return;
            }
        	
            if(DS_ADJST.NameValue(i, "ADJST_AMT") == 0){
                showMessage(INFORMATION, OK, "USER-1003", "조정금액");
                setFocusGrid(GD_ADJST,DS_ADJST, i, "ADJST_AMT");
                return;
            }
            
            if(getByteValLength(DS_ADJST.NameValue(i, "REMARK")) > 4000){
                showMessage(EXCLAMATION, OK, "USER-1054", "비고", "4000");
                setFocusGrid(GD_ADJST,DS_ADJST, i, "REMARK");
                return false;
            }
        }
    }

    if(DS_BIZ.NameValue(DS_BIZ.RowPosition, "TOT_AMT") <0 ){
    	showMessage(EXCLAMATION , Ok,  "USER-1020", "조정후실적금액", "0");
    	GD_ADJST.Focus();
    	return false;
    }
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        return;
    }
    
    var strOrgRowPo = DS_ORG.RowPosition;
    var strBizRowPo = DS_BIZ.RowPosition;
    
    TR_MAIN.Action   = "/mss/meis062.me?goTo=save";  
    TR_MAIN.KeyValue = "SERVLET(I:DS_ADJST=DS_ADJST)"; 
    TR_MAIN.Post();
    
    //정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
        DS_ORG.RowPosition = strOrgRowPo;
        DS_BIZ.RowPosition = strBizRowPo;
    }
}

/**
 * btn_Excel()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-19
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
}

/**
 * btn_Print()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-19
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
}

/**
 * btn_Conf()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-19
 * 개    요 : 확정 처리
 * return값 : void
 */
function btn_Conf() {
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * btn_addRow()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-19
 * 개    요 :  조정내역 행추가
 * return값 : void
 */
function btn_addRow(){
    DS_ADJST.AddRow();
    DS_ADJST.NameValue(DS_ADJST.CountRow,"BIZ_RSLT_YM") = DS_BIZ.NameValue(DS_BIZ.RowPosition,"BIZ_RSLT_YM");
    DS_ADJST.NameValue(DS_ADJST.CountRow,"STR_CD")      = DS_BIZ.NameValue(DS_BIZ.RowPosition,"STR_CD");
    DS_ADJST.NameValue(DS_ADJST.CountRow,"BIZ_CD")      = DS_BIZ.NameValue(DS_BIZ.RowPosition,"BIZ_CD");
    DS_ADJST.NameValue(DS_ADJST.CountRow,"ORG_CD")      = DS_BIZ.NameValue(DS_BIZ.RowPosition,"ORG_CD");
    DS_ADJST.NameValue(DS_ADJST.CountRow,"ORG_FLAG")    = DS_BIZ.NameValue(DS_BIZ.RowPosition,"ORG_FLAG");
    DS_ADJST.NameValue(DS_ADJST.CountRow,"ORG_LEVEL")   = DS_BIZ.NameValue(DS_BIZ.RowPosition,"ORG_LEVEL");
    DS_ADJST.NameValue(DS_ADJST.CountRow,"DEPT_CD")     = DS_BIZ.NameValue(DS_BIZ.RowPosition,"DEPT_CD");
    DS_ADJST.NameValue(DS_ADJST.CountRow,"TEAM_CD")     = DS_BIZ.NameValue(DS_BIZ.RowPosition,"TEAM_CD");
    DS_ADJST.NameValue(DS_ADJST.CountRow,"PC_CD")       = DS_BIZ.NameValue(DS_BIZ.RowPosition,"PC_CD");
    setFocusGrid(GD_ADJST,DS_ADJST, DS_ADJST.CountRow, "TGET_ORG_CD");
}

/**
 * btn_delRow()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-19
 * 개    요 :  조정내역 행삭제
 * return값 : void
 */
function btn_delRow(){
    if( DS_ADJST.CountRow < 1){
        showMessage(INFORMATION, OK, "USER-1019");
        return;
    }
    
    if(DS_ADJST.RowStatus(DS_ADJST.RowPosition) == 1) {
    	row = DS_BIZ.RowPosition;
    	DS_ADJST.DeleteRow(DS_ADJST.RowPosition);
    	DS_BIZ.NameValue(row, "ADJST_AMT") = GD_ADJST.SummaryString('ADJST_AMT', 1);
        DS_BIZ.NameValue(row, "TOT_AMT")   = DS_BIZ.NameValue(row, "RSLT_AMT") + DS_BIZ.NameValue(row, "ADJST_RECV_AMT") - DS_BIZ.NameValue(row, "ADJST_AMT");
    } else {
    	showMessage(EXCLAMATION, OK, "USER-1000", "저장된 내역은 삭제할수 없습니다.");     
    }
}

/**
 * setOrgCodeToGrid()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-19
 * 개    요 : 조직명을 등록한다.(Grid)
 * return값 : void
 */
function setOrgCodeToGrid(evnflag, row){
	var code    = DS_ADJST.NameValue(row,"TGET_ORG_CD");
    var strCd   = DS_ADJST.NameValue(row,"STR_CD");
    
    if( code == "" && evnflag != "POP" ){
        DS_ADJST.NameValue(row,"ORG_NAME") = "";
        return;     
    }
    var rtnMap = null;
    if( evnflag == "POP" ){
        rtnMap = orgCornerOutToGridPop(code,'','N','','','','','Y', strCd);
    }else if( evnflag == "NAME" ){
        DS_ADJST.NameValue(row,"ORG_NAME") = "";
        rtnMap = setOrgCornerOutNmWithoutToGridPop("DS_SEARCH_NM",code,'',"N",1,'','','','','Y', strCd);
    }
    
    if( rtnMap != null){
        if(rtnMap.get("STR_CD") == strCd){
            DS_ADJST.NameValue(row,"TGET_ORG_CD") = rtnMap.get("ORG_CD");
            DS_ADJST.NameValue(row,"ORG_NAME")    = rtnMap.get("ORG_NAME");
        } else {
            DS_ADJST.NameValue(row,"TGET_ORG_CD") = "";
            DS_ADJST.NameValue(row,"ORG_NAME")    = "";
            showMessage(EXCLAMATION, OK, "USER-1000", "점정보가 불일치 합니다.");
            setFocusGrid(GD_ADJST,DS_ADJST, row, "TGET_ORG_CD");
        }
    }else{
        if( DS_ADJST.NameValue(row,"ORG_NAME") == ""){
            DS_ADJST.NameValue(row,"TGET_ORG_CD") = "";
        }
    }
}
 
/**
 * getBizData()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-08-19
 * 개    요 : 배부항목명을 등록한다.(Grid)
 * return값 : void
 */
function getBizData(row, colid , popFlag){
    var strCd = DS_ADJST.NameValue(row,"TGET_BIZ_CD");
    var strYm = DS_ADJST.NameValue(row,"BIZ_RSLT_YM");
     
    if( strCd == "" && popFlag != "1" ){
        DS_ADJST.NameValue(row,"BIZ_CD_NM") = "";
        return;     
    }
     
    var rtnMap = null;
     
    if(popFlag != "1"){
        DS_ADJST.NameValue(row, "BIZ_CD_NM") = "";
        rtnMap = getBizNonPopGrid("DS_I_COMMON", strCd, strYm, "2");
    }else{
        rtnMap = getBizPopGrid(strCd, strYm, "2");
    }  
    
    if( rtnMap != null){
        DS_ADJST.NameValue(row,"TGET_BIZ_CD") = rtnMap[0];
        DS_ADJST.NameValue(row,"BIZ_CD_NM")   = rtnMap[1];
    }else{
        if(DS_ADJST.NameValue(row, "BIZ_CD_NM") == "") DS_ADJST.NameValue(row, "TGET_BIZ_CD") = "";
    }

}

 /**
  * fn_getOrg()
  * 작 성 자 : 최재형
  * 작 성 일 : 2011-07-01
  * 개    요 : 조직조회
  * return값 : void
  */ 
function fn_getOrg(dataSet, strAllGb, strStrCd, strDeptCd, strTeamCd, strPcCd, strOrgLevel) {
		
	var goTo = "getOrg";
	var parameters  = "&strAllGb=" +  strAllGb;
		parameters += "&strStrCd=" +  strStrCd;
		parameters += "&strDeptCd=" +  strDeptCd;
		parameters += "&strTeamCd=" +  strTeamCd;
		parameters += "&strPcCd=" +  strPcCd;
		parameters += "&strOrgLevel=" +  strOrgLevel;
		
	dataSet.DataID   = "/mss/meis043.me?goTo="+goTo+parameters;
	dataSet.SyncLoad = "true";
	dataSet.Reset();
		
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
<!--*    6. 컴포넌트 이벤트 처리
<!--*************************************************************************-->
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<!----------------------- 2. TR Fail 메세지 처리  ----------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<script language=JavaScript for=DS_ORG event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    setPorcCount("SELECT", rowcnt);
</script>

<script language=JavaScript for=DS_BIZ event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    setPorcCount("SELECT", rowcnt);
    if(lo_IsMasterLoaded) setPorcCount("SELECT", rowcnt);
    lo_IsMasterLoaded = 1;
    
    if(rowcnt>0){
    	enableControl(IMG_ROW_ADD,true);
        enableControl(IMG_ROW_DEL,true);
    } else {
    	enableControl(IMG_ROW_ADD,false);
        enableControl(IMG_ROW_DEL,false);
    }
</script>

<script language=JavaScript for=DS_ADJST event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    if(lo_IsMasterLoaded) setPorcCount("SELECT", rowcnt);
    lo_IsMasterLoaded = 1;
</script>
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<script language=JavaScript for=DS_ORG  event=OnLoadError()>
    dsFailed(this);
</script>

<script language=JavaScript for=DS_BIZ  event=OnLoadError()>
    dsFailed(this);
</script>

<script language=JavaScript for=DS_ADJST  event=OnLoadError()>
    dsFailed(this);
</script>
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_ORG event=CanRowPosChange(row)>
    if( row < 1)
        return;
    
    if( DS_ADJST.IsUpdated ){
        //변경된 상세내역이 존재합니다. 이동 하시겠습니까? 
        if( showMessage(QUESTION, YESNO, "USER-1049") != 1 ) return false;
    }
    return true;
</script>

<!--로우변경시 디테일정보 로딩-->
<script language=JavaScript for=DS_ORG event=OnRowPosChanged(row)>
     if (this.CountRow >0 && row>0) {
         subQuery(row);
     }
</script>

<script language=JavaScript for=DS_BIZ event=CanRowPosChange(row)>
    if( row < 1)
        return;
    
    if( DS_ADJST.IsUpdated ){
        //변경된 상세내역이 존재합니다. 이동 하시겠습니까? 
        if( showMessage(QUESTION, YESNO, "USER-1049") != 1 ) return false;
    }
    return true;
</script>

<!--로우변경시 디테일정보 로딩-->
<script language=JavaScript for=DS_BIZ event=OnRowPosChanged(row)>
     if (this.CountRow >0 && row>0) {
         subQuery2(row);
     }
</script>

<script language=JavaScript for=DS_ADJST event=onColumnChanged(row,colid)>
    if(colid=="ADJST_AMT") {
    	row = DS_BIZ.RowPosition;
    	DS_BIZ.NameValue(row, "ADJST_AMT") = GD_ADJST.SummaryString('ADJST_AMT', 1);
    	DS_BIZ.NameValue(row, "TOT_AMT")   = DS_BIZ.NameValue(row, "RSLT_AMT") + DS_BIZ.NameValue(row, "ADJST_RECV_AMT") - DS_BIZ.NameValue(row, "ADJST_AMT");
    }
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------->
<!-- 점(조회)  변경시  -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
    //getDept("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y");                                           // 팀 
    //getTeam("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y");                    // 파트  
    //getPc("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal, "Y"); // PC 
    
    fn_getOrg(DS_DEPT_CD, "Y", LC_STR_CD.BindColVal, "%", "%", "%", "2");
    fn_getOrg(DS_TEAM_CD, "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "%", "%", "3");
    fn_getOrg(DS_PC_CD, "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal, "%", "4");
    
    LC_DEPT_CD.Index = 0;
    LC_TEAM_CD.Index = 0;
    LC_PC_CD.Index   = 0;
</script>

<!-- 팀(조회)  변경시  -->
<script language=JavaScript for=LC_DEPT_CD event=OnSelChange()>
    if(LC_DEPT_CD.BindColVal != "%"){
        //getTeam("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y"); // 파트   
        fn_getOrg(DS_TEAM_CD, "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "%", "%", "3");
    }else{
        DS_TEAM_CD.ClearData();
        insComboData( LC_TEAM_CD, "%", "전체",1);
        DS_PC_CD.ClearData();
        insComboData( LC_PC_CD, "%", "전체",1);
    }
    LC_TEAM_CD.Index = 0;
</script>

<!-- TEAM(조회)  변경시  -->
<script language=JavaScript for=LC_TEAM_CD event=OnSelChange()>
    if(LC_TEAM_CD.BindColVal != "%"){
        //getPc("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal, "Y"); // PC   
        fn_getOrg(DS_PC_CD, "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal, "%", "4");
    }else{
        DS_PC_CD.ClearData();
        insComboData( LC_PC_CD, "%", "전체",1);
    }
    LC_PC_CD.Index   = 0;
</script>

<script language=JavaScript for=GD_ADJST event=OnPopup(row,colid,data)>
    onPopFlag = true;
    if(colid == "TGET_ORG_CD") setOrgCodeToGrid('POP', row);
    else getBizData(row , colid , '1');
    onPopFlag = false;
</script>

<script language=JavaScript for=GD_ADJST event=OnExit(row,colid,oldData)>
    if(row < 1) return;
    if( onPopFlag) return;
    if( oldData == DS_ADJST.NameValue(row,colid)) return;
    
    if(colid=="TGET_ORG_CD") setOrgCodeToGrid('NAME', row);
    else getBizData(row , colid , '0');

    return true;
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
<comment id="_NSID_">
<!-- ====================Output용================== -->
    <object id="DS_ORG"           classid=<%= Util.CLSID_DATASET %>></object>
    <object id="DS_BIZ"           classid=<%= Util.CLSID_DATASET %>></object>
    <object id="DS_ADJST"         classid=<%= Util.CLSID_DATASET %>></object>
    <!--[콤보]점구분 -->
    <object id="DS_STR_CD"        classid=<%= Util.CLSID_DATASET %>></object>
    <!--[콤보]팀구분 -->
    <object id="DS_DEPT_CD"       classid=<%= Util.CLSID_DATASET %>></object>
    <!--[콤보]파트구분 -->
    <object id="DS_TEAM_CD"       classid=<%= Util.CLSID_DATASET %>></object>
    <!--[콤보]PC구분 -->
    <object id="DS_PC_CD"         classid=<%= Util.CLSID_DATASET %>></object>
    <!--[콤보]조직레벨 -->
    <object id="DS_ORG_LVL"       classid=<%= Util.CLSID_DATASET %>></object>
<!-- ====================Input용================== -->

<!-- ===========gauce.js 공통함수 호출용=========== -->
    <object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object>
    <object id="DS_I_COMMON"    classid=<%= Util.CLSID_DATASET %>></object>
    <object id="DS_SEARCH_NM"   classid=<%= Util.CLSID_DATASET %>></object>
</comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
    <!-- ===========gauce.js 공통함수 호출용=========== -->
    <object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
        <param name="KeyName" value="Toinb_dataid4">
    </object>
</comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


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
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th>실적년월</th>
            <td colspan=3>
              <comment id="_NSID_">
                <object id=EM_RSLT_YM classid=<%=Util.CLSID_EMEDIT%> width=80 onblur="checkDateTypeYM(this, '<%=strYm%>');" align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/date.gif" class="PR03"
                onclick="javascript:openCal('M',EM_RSLT_YM)" align="absmiddle" />
            </td>
            <th>조직레벨</th>
            <td colspan=3>
              <comment id="_NSID_">
                <object id=LC_ORG_LVL classid=<%= Util.CLSID_LUXECOMBO %> width=110 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th width="70" class="point">점</th>
            <td width="130">
              <comment id="_NSID_">
                <object id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=110 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script></td>
            <th width="70" class="point">팀</th>
            <td width="130">
              <comment id="_NSID_">
                <object id=LC_DEPT_CD classid=<%=Util.CLSID_LUXECOMBO%> width=110 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="70" >파트</th>
            <td width="130">
              <comment id="_NSID_">
                <object id=LC_TEAM_CD classid=<%=Util.CLSID_LUXECOMBO%> width=110 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="70">PC</th>
            <td>
              <comment id="_NSID_">
                <object id=LC_PC_CD classid=<%=Util.CLSID_LUXECOMBO%> width=110 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="dot"></td>
  </tr>
  <tr valign="top">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td width="235"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td class="PT03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top">
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
                  <tr>
                    <td>
                      <comment id="_NSID_"><object id=GD_ORG width="100%" height=231 classid=<%=Util.CLSID_GRID%>>
                        <param name="DataID" value="DS_ORG">
                      </object></comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
        <td class="PL10"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td class="PT03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top">
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
                  <tr>
                    <td>
                      <comment id="_NSID_"><object id=GD_BIZ width="100%" height=231 classid=<%=Util.CLSID_GRID%>>
                        <param name="DataID" value="DS_BIZ">
                      </object></comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="sub_title PB03 PT10" ><img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/> 조정내역</td>
        <td class="right PB02" valign="bottom"><img src="/<%=dir%>/imgs/btn/add_row.gif" id=IMG_ROW_ADD onclick="javascript:btn_addRow();" hspace="2"/><img src="/<%=dir%>/imgs/btn/del_row.gif" id=IMG_ROW_DEL onclick="javascript:btn_delRow();""/>
        </td>
      </tr>
    </table></td>
  </tr>
  <tr valign="top">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="PT03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr valign="top">
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
              <tr>
                <td>
                  <comment id="_NSID_"><object id=GD_ADJST width="100%" height=214 classid=<%=Util.CLSID_GRID%>>
                    <param name="DataID" value="DS_ADJST">
                  </object></comment><script>_ws_(_NSID_);</script>
                </td>
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
</div>
</body>
</html>
