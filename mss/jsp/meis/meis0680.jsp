<!-- 
/*******************************************************************************
 * 시스템명 : 경영실적 > 경영실적> 경영실적2차배부처리
 * 작 성 일 : 2011.06.17
 * 작 성 자 : 이정식
 * 수 정 자 : 
 * 파 일 명 : meis0680.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 경영실적 본사 공통비  1차 배부내역 및 점 공통비용에 대해 2차 배부 처리한다.
 * 이    력 :
 *        2011.06.17 (이정식) 신규작성
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
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var onPopFlag       = false;
var lo_strCd        = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-17
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
    
    LC_STR_CD.Focus();
    
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("meis0680","DS_BIZ_RSLT" );
}

/**
 * setEmEdit()
 * 작 성 자 : 이정식
 * 작 성 일 :  2011-06-17
 * 개    요 : EMEDIT 설정 
 * return값 : void
 */
function setEmEdit(){
	initEmEdit(EM_RSLT_YM, "YYYYMM", PK); //경영실적년월
	EM_RSLT_YM.Text = "<%=strYm%>";
}

/**
 * setCombo()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-17
 * 개    요 : 콤보 설정 
 * return값 : void
 */
function setCombo(){
	initComboStyle(LC_STR_CD,   DS_STR_CD,  "CODE^0^30,NAME^0^90", 1, PK);   //점(조회)
	initComboStyle(LC_S_ORG_FLAG,   DS_S_ORG_FLAG,  "CODE^0^30,NAME^0^90", 1, PK);   //조직구분(조회)
	initComboStyle(LC_DEPT_CD,   DS_DEPT_CD,  "CODE^0^30,NAME^0^90", 1, PK);	//팀(조회)
	initComboStyle(LC_TEAM_CD,   DS_TEAM_CD,  "CODE^0^30,NAME^0^90", 1, PK);	//파트(조회)	
	 
	getStore("DS_STR_CD", "N", "1", "N");         //점콤보 가져오기 ( gauce.js )  
	getEtcCode("DS_ORG_FLAG", "D", "P047", "N");  //조직구분콤보 데이터가져오기 ( gauce.js )
	getEtcCode("DS_S_ORG_FLAG", "D", "P047", "Y");  //조직구분콤보 데이터가져오기 ( gauce.js )
	LC_S_ORG_FLAG.Index= 0;
	
	
	//콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_STR_CD.Index < 0){
        LC_STR_CD.Index= 0;
    }
    
    lo_strCd = LC_STR_CD.BindColVal;
    var lvl = "3";
    if(RD_DIV_FLAG.CodeValue=="3") lvl = "4";
    getDivCombo(DS_DIV_CD, EM_RSLT_YM.Text, "2", "2", "N", lo_strCd, lvl); //배부기준콤보 데이터가져오기 ( gauce.js )
}

/**
 * gridCreate()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-17
 * 개    요 : 그리드 초기화 
 * return값 : void
 */
function gridCreate(){
	var hdrProperies = '<FC>id={currow}     width=35  align=center name="NO"</FC>'
		             + '<FC>id=CHECK_FLAG   width=20  align=center name="" EditStyle=checkbox HeadCheck=false HeadCheckShow=true edit={IF(EDIT_FLAG="1","true","false")}</FC>'
		             + '<FC>id=ORG_FLAG     width=105 align=center name="조직구분" edit="None"  EditStyle=Lookup data="DS_ORG_FLAG:CODE:NAME"</FC>'
                     + '<FC>id=ORG_CD       width=85  align=center name="조직코드" edit="None"</FC>'
                     + '<FC>id=ORG_NAME     width=80  align=left   name="조직명" edit="None" SumText="합계"</FC>'
                     + '<C>id=DEPT_NM       width=80  align=left   name="팀" edit="None"</C>'
                     + '<C>id=TEAM_NM       width=80  align=left   name="파트" edit="None"</C>'
                     + '<C>id=PC_NM         width=80  align=left   name="PC" edit="None"</C>'
                     + '<C>id=BIZ_CD        width=60  align=center name="항목코드" edit="None"</C>'
                     + '<C>id=BIZ_NM        width=80  align=left   name="항목명" edit="None"</C>'
                     + '<C>id=RSLT_AMT      width=80  align=right  name="금액" edit="None" SumText=@sum</C>'
                     + '<C>id=SD_DIV_CD     width=80  align=center name="배부기준" edit={IF(EDIT_FLAG="1","true","false")} EditStyle=Lookup data="DS_DIV_CD:CODE:NAME"</C>'
                     + '<C>id=SD_DIV_BIZ_CD width=80  align=center name="배부항목" edit="AlphaNum" EditStyle=Popup edit={IF(EDIT_FLAG="1","true","false")}</C>'
                     + '<C>id=BIZ_CD_NM     width=80  align=left   name="항목명" edit="None"</C>'
                     ;
        
    initGridStyle(GD_BIZ_RSLT, "common", hdrProperies, true);
    GD_BIZ_RSLT.ViewSummary = "1";
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
 * 작 성 일 : 2011-06-17
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	if( DS_BIZ_RSLT.IsUpdated){
        //변경내역이 있습니다. 조회하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1084") != 1){
        	EM_RSLT_YM.Focus();
            return false;
        }
    }
    
    //1. validation
    if (isNull(EM_RSLT_YM.text)){
        showMessage(EXCLAMATION, OK, "USER-1003", "경영실적년월"); //(경영실적년월)은/는 반드시 입력해야 합니다.
        EM_RSLT_YM.focus();
        return;
    }
    if (!checkYYYYMM(EM_RSLT_YM.text)){
        showMessage(EXCLAMATION, OK, "USER-1061", "경영실적년월");//(경영실적년월)은/는 유효하지 않는 날짜입니다.
        EM_RSLT_YM.focus();
        return;
    }
	
	DS_BIZ_RSLT.ClearData();
	
	lo_strCd = LC_STR_CD.BindColVal;
	var lvl = "3";
    if(RD_DIV_FLAG.CodeValue=="3") lvl = "4";
    getDivCombo(DS_DIV_CD, EM_RSLT_YM.Text, "2", "2", "N", lo_strCd, lvl); //배부기준콤보 데이터가져오기 ( gauce.js )
	
	//헤더체크초기화
    GD_BIZ_RSLT.ColumnProp('CHECK_FLAG','HeadCheck') = false;
	
	var goTo       = "searchBizRslt" ;    
    var action     = "O";     
    var parameters = "&strStrCd="   + LC_STR_CD.BindColVal  //점코드
                   + "&strRsltYm="  + EM_RSLT_YM.text       //경영실적년월
                   + "&strDivFlag=" + RD_DIV_FLAG.CodeValue //배부구분
                   
                   + "&strDeptCd=" + LC_DEPT_CD.BindColVal		//팀
                   + "&strTeamCd=" + LC_TEAM_CD.BindColVal		//파트
                   + "&strOrgFlag=" + LC_S_ORG_FLAG.BindColVal	//조직구분                   
                   ;
    
    DS_BIZ_RSLT.DataID   = "/mss/meis068.me?goTo="+goTo+parameters;
    DS_BIZ_RSLT.SyncLoad = "true";
    DS_BIZ_RSLT.Reset();
}

/**
 * subQuery()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-17
 * 개    요 : 
 * return값 : void
 */
function subQuery(row){
}

/**
 * btn_New()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-17
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
}

/**
 * btn_Delete()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-17
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-17
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    if (DS_BIZ_RSLT.NameValueRow("CHECK_FLAG","T") == 0){
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
        return;
    }
    
    for(var i = 1; i <= DS_BIZ_RSLT.CountRow; i++){
        if(DS_BIZ_RSLT.NameValue( i, "CHECK_FLAG") == "T"){
            if(isNull(DS_BIZ_RSLT.NameValue( i, "SD_DIV_CD"))){
            	showMessage(EXCLAMATION, Ok,  "USER-1002", "배분기존코드");
                setFocusGrid(GD_BIZ_RSLT,DS_BIZ_RSLT, i, "SD_DIV_CD");
                return;
            }
            
            if(isNull(DS_BIZ_RSLT.NameValue( i, "SD_DIV_BIZ_CD"))){
                showMessage(EXCLAMATION, Ok,  "USER-1002", "배부항목");
                setFocusGrid(GD_BIZ_RSLT,DS_BIZ_RSLT, i, "SD_DIV_BIZ_CD");
                return;
            }
        }
    }
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        return;
    }

    TR_MAIN.Action   = "/mss/meis068.me?goTo=save";  
    TR_MAIN.KeyValue = "SERVLET(I:DS_BIZ_RSLT=DS_BIZ_RSLT)"; 
    TR_MAIN.Post();
    
    btn_Search();
}

/**
 * btn_Excel()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-17
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
}

/**
 * btn_Print()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-17
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
}

/**
 * btn_Conf()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-17
 * 개    요 : 확정 처리
 * return값 : void
 */
function btn_Conf() {
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * getBizData()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-17
 * 개    요 : 배부항목명을 등록한다.(Grid)
 * return값 : void
 */
function getBizData(row, colid , popFlag){
    var strCd = DS_BIZ_RSLT.NameValue(row,"SD_DIV_BIZ_CD");
    var strYm = DS_BIZ_RSLT.NameValue(row,"BIZ_RSLT_YM");
     
    if( strCd == "" && popFlag != "1" ){
        DS_BIZ_RSLT.NameValue(row,"BIZ_CD_NM") = "";
        return;     
    }
     
    var rtnMap = null;
     
    if(popFlag != "1"){
        DS_BIZ_RSLT.NameValue(row, "BIZ_CD_NM") = "";
        rtnMap = getBizNonPopGrid("DS_I_COMMON", strCd, strYm, "2");
    }else{
        rtnMap = getBizPopGrid(strCd, strYm, "2");
    }  
    
    if( rtnMap != null){
        DS_BIZ_RSLT.NameValue(row,"SD_DIV_BIZ_CD") = rtnMap[0];
        DS_BIZ_RSLT.NameValue(row,"BIZ_CD_NM") = rtnMap[1];
    }else{
        if(DS_BIZ_RSLT.NameValue(row, "BIZ_CD_NM") == "") DS_BIZ_RSLT.NameValue(row, "SD_DIV_BIZ_CD") = "";
    }
    
    if(DS_BIZ_RSLT.NameValue(row, "SD_DIV_BIZ_CD") != "" && DS_BIZ_RSLT.NameValue(row, "SD_DIV_CD") != ""){
        DS_BIZ_RSLT.NameValue(row, "CHECK_FLAG") = "T";
    }
}
 
/**
 * copyLst()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-06-17
 * 개    요 : 전월 배부기준, 배부항목 복사
 * return값 : void
 */
function copyLst(){
    var cnt = 0;
    GD_BIZ_RSLT.ReDraw = "false";
    for(var i=1; i<=DS_BIZ_RSLT.CountRow; i++){ 
        if(DS_BIZ_RSLT.NameString(i, "EDIT_FLAG") == "1"){
            if(DS_BIZ_RSLT.NameValue(i, "LST_DIV_CD") != "" 
                && DS_BIZ_RSLT.NameValue(i, "LST_BIZ_CD") != ""){
                if(!(DS_BIZ_RSLT.NameValue(i, "LST_DIV_CD") == DS_BIZ_RSLT.NameValue(i, "SD_DIV_CD") 
                    && DS_BIZ_RSLT.NameValue(i, "LST_BIZ_CD") == DS_BIZ_RSLT.NameValue(i, "SD_DIV_BIZ_CD"))){
                	if(DS_DIV_CD.NameValueRow("CODE", DS_BIZ_RSLT.NameValue(i, "LST_DIV_CD")) != 0){
                		DS_BIZ_RSLT.NameValue(i, "SD_DIV_CD")     = DS_BIZ_RSLT.NameValue(i, "LST_DIV_CD");
                        DS_BIZ_RSLT.NameValue(i, "SD_DIV_BIZ_CD") = DS_BIZ_RSLT.NameValue(i, "LST_BIZ_CD");
                        DS_BIZ_RSLT.NameValue(i, "BIZ_CD_NM")     = DS_BIZ_RSLT.NameValue(i, "LST_BIZ_NM");
                        DS_BIZ_RSLT.NameValue(i, "CHECK_FLAG")    = "T";
                        cnt++;
                	}
                }
            }
        }
    }
    GD_BIZ_RSLT.ReDraw = "true";
    showMessage(INFORMATION, OK, "USER-1222", cnt);
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
<script language=JavaScript for=DS_BIZ_RSLT event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    setPorcCount("SELECT", rowcnt);
    GD_BIZ_RSLT.Focus();
</script>
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<script language=JavaScript for=DS_BIZ_RSLT  event=OnLoadError()>
    dsFailed(this);
</script>
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------->
<script language=JavaScript for=GD_BIZ_RSLT event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<!--헤더 체크시 일괄체크 처리-->
<script language="javascript"  for=GD_BIZ_RSLT event=OnHeadCheckClick(col,colid,bCheck)>
    this.ReDraw = "false";    // 그리드 전체 draw 를 false 로 지정
    if (bCheck == '1'){       // 전체체크
        for(var i=1; i<=DS_BIZ_RSLT.CountRow; i++) 
        	if(DS_BIZ_RSLT.NameString(i, "EDIT_FLAG") == "1") //변경전 적용 시작일이 크지 않은 경우만 수정 가능
        		DS_BIZ_RSLT.NameString(i, colid) = 'T';
    }else{                    // 전체체크해제
        for(var i=1; i<=DS_BIZ_RSLT.CountRow; i++) DS_BIZ_RSLT.NameString(i, colid) = 'F';
    }
    this.ReDraw = "true";       
</script>

<script language=JavaScript for=GD_BIZ_RSLT event=OnPopup(row,colid,data)>
    onPopFlag = true;
    getBizData(row , colid , '1');
    onPopFlag = false;
</script>

<script language=JavaScript for=GD_BIZ_RSLT event=OnExit(row,colid,oldData)>
    if(row < 1) return;
    if( onPopFlag) return;
    if( oldData == DS_BIZ_RSLT.NameValue(row,colid)) return;
    
    if(colid=="SD_DIV_BIZ_CD"){
    	getBizData(row , colid , '0');
    }

    return true;
</script>

<script language=JavaScript for=DS_BIZ_RSLT event=onColumnChanged(row,colid)>
    if(row <= 0) return;
    if(colid == "SD_DIV_CD"){
        if(this.NameValue(row, "SD_DIV_BIZ_CD") != "" && this.NameValue(row, "SD_DIV_CD") != ""){
            this.NameValue(row, "CHECK_FLAG") = "T";
        }
    }
</script>

<!-- 조회조건의 점코드 변경 -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
//DATASET,전체구분,점,팀,파트,PC,조직레벨
fn_getOrg(DS_DEPT_CD, "Y", LC_STR_CD.BindColVal, "%", "%", "%", "2");
LC_DEPT_CD.Index= 0;
if(LC_STR_CD.BindColVal == "%") enableControl(LC_DEPT_CD, false);	
else enableControl(LC_DEPT_CD, true);	
</script>

<!-- 조회조건의 팀코드 변경 -->
<script language=JavaScript for=LC_DEPT_CD event=OnSelChange()>
//DATASET,전체구분,점,팀,파트,PC,조직레벨
fn_getOrg(DS_TEAM_CD, "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "%", "%", "3");
LC_TEAM_CD.Index= 0;
if(LC_DEPT_CD.BindColVal == "%" || RD_DIV_FLAG.CodeValue == "1") enableControl(LC_TEAM_CD, false);	
else enableControl(LC_TEAM_CD, true);
</script>

<!-- 배부구분변경 -->
<script language=JavaScript for=RD_DIV_FLAG event=OnSelChange()>
//1: 파트	3: PC
enableControl(LC_TEAM_CD, true);
LC_TEAM_CD.Index= 0;
if(LC_DEPT_CD.BindColVal == "%" || RD_DIV_FLAG.CodeValue == "1") enableControl(LC_TEAM_CD, false);
else enableControl(LC_TEAM_CD, true);
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
    <!--[콤보]점코드 -->
    <object id="DS_STR_CD"   classid=<%= Util.CLSID_DATASET %>></object>
    <!--[콤보]조직구분 -->
    <object id="DS_S_ORG_FLAG" classid=<%= Util.CLSID_DATASET %>></object>   
    <!--[콤보]부분코드 -->
    <object id="DS_DEPT_CD" classid=<%= Util.CLSID_DATASET %>></object>     
    <!--[콤보]파트코드 -->
    <object id="DS_TEAM_CD" classid=<%= Util.CLSID_DATASET %>></object>       
    
    <!--[그리드]계정항목 -->
    <object id="DS_BIZ_RSLT"      classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드 콤보]배부기준코드 -->
    <object id="DS_DIV_CD"  classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드콤보]조직구분 -->
    <object id="DS_ORG_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
<!-- ====================Input용================== -->

<!-- ===========gauce.js 공통함수 호출용=========== -->
    <object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object>
    <object id="DS_I_COMMON"    classid=<%= Util.CLSID_DATASET %>></object>
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
            <th width="80" class="point">점코드</th>
            <td width="160">
              <comment id="_NSID_">
                <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=160 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80" class="point">경영실적년월</th>
            <td width="160">
              <comment id="_NSID_">
                <object id=EM_RSLT_YM classid=<%=Util.CLSID_EMEDIT%> width=80 onblur="checkDateTypeYM(this, '<%=strYm%>');" align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/date.gif" class="PR03"
                onclick="javascript:openCal('M',EM_RSLT_YM)" align="absmiddle" />
            </td>
            <th width="80" class="point">배부구분</th>
            <td>
              <comment id="_NSID_">
                <object id=RD_DIV_FLAG classid=<%=Util.CLSID_RADIO%> tabindex=1 style="height:20; width:80">
                  <param name=Cols    value="2">
                  <param name=Format  value="1^파트,3^PC">
                  <param name=CodeValue  value="1">
                </object>  
              </comment><script> _ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th width="80" id="th_deptTeamCd">팀</th>
            <td width="160">
              <comment id="_NSID_">
                <object id=LC_DEPT_CD classid=<%= Util.CLSID_LUXECOMBO %> width=160 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>                      
            <th width="80" id="th_deptTeamCd">파트</th>
            <td width="160">
              <comment id="_NSID_">
                <object id=LC_TEAM_CD classid=<%= Util.CLSID_LUXECOMBO %> width=160 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80">조직구분</th>
            <td width="160">
              <comment id="_NSID_">
                <object id=LC_S_ORG_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=160 tabindex=1 align="absmiddle"></object>
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
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td class="right PB02" valign="bottom">
                  <img src="/<%=dir%>/imgs/btn/copy_last.gif" onclick="javascript:copyLst();""/>
                </td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td class="PT03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top">
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
                  <tr>
                    <td>
                      <comment id="_NSID_"><object id=GD_BIZ_RSLT width="100%" height=459 classid=<%=Util.CLSID_GRID%>>
                        <param name="DataID" value="DS_BIZ_RSLT">
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
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
</body>
</html>
