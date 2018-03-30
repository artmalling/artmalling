<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 재고수불 > 저장품 > 저장품입고확정 
 * 작 성 일 : 2010.06.02
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pstk4020.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 저장품 입고/입고반품 확정처리를  한다.
 * 이    력 :
 *        2010.06.02 (정진영) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
 <% request.setCharacterEncoding("utf-8"); %> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%String dir = BaseProperty.get("context.common.dir");%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">
<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
var bfMasterRow = 0;
var btnSaveYn = false;
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //상세

    // EMedit에 초기화
    initEmEdit(EM_O_FROM_DT     , "TODAY"   , PK);      //기간(From)
    initEmEdit(EM_O_TO_DT       , "TODAY"   , PK);      //기간(To)
    initEmEdit(EM_O_VEN_CD      , "CODE^6^0", NORMAL);  //협력사코드
    initEmEdit(EM_O_VEN_NAME    , "GEN^40"  , READ);    //협력사명
    initEmEdit(EM_O_PUMBUN_CD   , "CODE^6^0", NORMAL);  //브랜드코드
    initEmEdit(EM_O_PUMBUN_NAME , "GEN^40"  , READ);    //브랜드명

    initEmEdit(EM_SLIP_NO     , "YYYYMMDD"   , READ);    //전표일자
    initEmEdit(EM_SLIP_SEQ_NO , "CODE^5^0"   , READ);    //전표일련번호
    initEmEdit(EM_VEN_CD      , "CODE^6^0"   , READ);    //협력사코드
    initEmEdit(EM_VEN_NAME    , "GEN^40"     , READ);    //협력사명
    initEmEdit(EM_CONF_DT     , "YYYYMMDD"   , PK);      //확정일자
    initEmEdit(EM_IN_TOT_QTY  , "NUMBER^7^0" , READ);    //입고총수량
    initEmEdit(EM_IN_TOT_AMT  , "NUMBER^13^0", READ);    //입고총금액
    
    //콤보 초기화 
    initComboStyle(LC_O_STR_CD      ,DS_O_STR_CD      , "CODE^0^30,NAME^0^80", 1, PK);      //점(조회)
    initComboStyle(LC_O_SLIP_STATUS ,DS_O_SLIP_STATUS , "CODE^0^30,NAME^0^80", 1, NORMAL);  //확정구분(조회)
    initComboStyle(LC_STR_CD        ,DS_STR_CD        , "CODE^0^30,NAME^0^80", 1, READ);    //점
    initComboStyle(LC_SLIP_FLAG     ,DS_SLIP_FLAG     , "CODE^0^30,NAME^0^80", 1, READ);    //전표구분
    initComboStyle(LC_SLIP_STATUS   ,DS_SLIP_STATUS   , "CODE^0^30,NAME^0^80", 1, READ);    //확정구분

    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_O_SLIP_STATUS"  , "D", "P076", "Y");
    
    getEtcCode("DS_SLIP_FLAG"    , "D", "P803", "N");
    //getEtcCode("DS_TAX_FLAG"     , "D", "P004", "N");
    getEtcCode("DS_SLIP_STATUS"  , "D", "P076", "N");
    getEtcCode("DS_UNIT_CD"      , "D", "P013", "N");
    
    
    // 점코드 조회
    getStore("DS_O_STR_CD"  , "Y", "", "N");
    getStore("DS_STR_CD"    , "Y", "", "N");
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_O_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_O_STR_CD.Index < 0){
    	LC_O_STR_CD.Index= 0;
    }
    setComboData(LC_O_SLIP_STATUS, '%');
    
    enableCnt("R");
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pstk402","DS_MASTER,DS_DETAIL" );
    
    LC_O_STR_CD.Focus();
    
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}      width=25   align=center name="NO"           </FC>'
                     + '<FC>id=SLIP_NO       width=75   align=center name="전표일자"      mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=SLIP_SEQ_NO   width=56   align=center name="전표번호"      </FC>'
                     + '<FC>id=SLIP_FLAG     width=61   align=left   name="입고/반품;구분 " EditStyle=Lookup data="DS_SLIP_FLAG:CODE:NAME" </FC>'
                     + '<FC>id=SLIP_STATUS   width=56   align=left   name="확정구분"      EditStyle=Lookup data="DS_SLIP_STATUS:CODE:NAME" </FC>';

    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    GD_MASTER.TitleHeight = 44;
}


function gridCreate2(){
    var hdrProperies = '<FC>id={currow}      width=25   align=center  edit=none     sumtext=""   name="NO"          </FC>'
                     + '<FC>id=PUMBUN_CD     width=55   align=center  edit=none     sumtext=""   name="브랜드코드"    </FC>'
                     + '<FC>id=PUMBUN_NAME   width=110  align=left    edit=none     sumtext=""   name="브랜드명"       </FC>'
                     + '<FC>id=SKU_CD        width=100  align=center  edit=none     sumtext=""   name="단품코드"    </FC>'
                     + '<FC>id=SKU_NAME      width=120  align=left    edit=none     sumtext=""   name="단품명"       </FC>'
                     + '<FC>id=UNIT_CD       width=55   align=left    edit=none     sumtext=""   name="단위"         EditStyle=Lookup data="DS_UNIT_CD:CODE:NAME" </FC>'
                     + '<FC>id=IN_QTY        width=65   align=right   edit=none     sumtext=@sum name="수량"        </FC>'
                     + '<FC>id=IN_PRC        width=85   align=right   edit=none     sumtext=@sum name="원가"        </FC>'
                     + '<FC>id=IN_AMT        width=85   align=right   edit=none     sumtext=@sum name="금액"         </FC>';

    initGridStyle(GD_DETAIL, "common", hdrProperies, false);

    GD_DETAIL.ViewSummary = "1";  
    GD_DETAIL.ColumnProp("SKU_CD", "sumtext")        = "합계";
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
 * 작 성 일 : 2010-12-12
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    if( LC_O_STR_CD.BindColVal == ""){
        showMessage(EXCLAMATION, OK, "USER-1002", "점");
        LC_O_STR_CD.Focus();
        return;
    }
    if( EM_O_FROM_DT.Text == ""){
        showMessage(EXCLAMATION, OK, "USER-1003", "기간(From)");
        EM_O_FROM_DT.Focus();
        return;
    }
    if( EM_O_TO_DT.Text == ""){
        showMessage(EXCLAMATION, OK, "USER-1003", "기간(To)");
        EM_O_TO_DT.Focus();
        return;
    }
    if( EM_O_TO_DT.Text < EM_O_FROM_DT.Text){
        showMessage(EXCLAMATION, OK, "USER-1020", "기간(To)", "기간(From)");
        EM_O_TO_DT.Focus();
        return;
    }
    if( DS_MASTER.IsUpdated ){
        // 변경된 상세내역이 존재합니다. 조회하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1059") != 1){
            if( DS_MASTER.IsUpdated){
            	EM_CONF_DT.Focus();              
            }
        }
    }
    bfMasterRow = 0;
    searchMaster();
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {

}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {

}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
	 
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {
	if( LC_SLIP_STATUS.BindColVal !="1"){
        showMessage(INFORMATION, OK, "USER-1000", "이미 확정된 전표입니다.");
        GD_MASTER.Focus();
        return;
	}
	/*
    if (!DS_MASTER.IsUpdated  ){
        showMessage(INFORMATION, OK, "USER-1090");
        if( DS_MASTER.CountRow < 1){
            LC_O_STR_CD.Focus();
        }else{
        	EM_CONF_DT.Focus();
        }
        return;
    }
	*/
	/*
    if( !checkMasterValidation())
        return;
    */
    if(EM_CONF_DT.Text ==""){
        showMessage(EXCLAMATION, OK, "USER-1003", "확정일자");
        EM_CONF_DT.Focus();
        return;
    }
    if( EM_CONF_DT.Text < getTodayFormat("YYYYMMDD")){
        showMessage(EXCLAMATION, OK, "USER-1030","확정일자");    
        EM_CONF_DT.Focus();
        return;
    }
    
    if( showMessage(QUESTION, YESNO, "USER-1024") != 1 ){
        EM_CONF_DT.Focus();
        return; 
    }
    var slipNo = DS_MASTER.NameValue(DS_MASTER.RowPosition,"SLIP_NO");
    var slipSeqNo = DS_MASTER.NameValue(DS_MASTER.RowPosition,"SLIP_SEQ_NO");
    btnSaveYn = true;
    TR_MAIN.Action="/dps/pstk402.pt?goTo=conf";  
    TR_MAIN.KeyValue="SERVLET(I:DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();  
    btnSaveYn = false;
    
    if(TR_MAIN.ErrorCode == 0){    	
    	var row = getNameValueRow( DS_MASTER, "SLIP_NO||SLIP_SEQ_NO", slipNo+"||"+slipSeqNo);
        bfMasterRow = 0;
        searchMaster();
        DS_MASTER.RowPosition = row;
    }
    EM_CONF_DT.Focus();
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

/**
 * searchMaster()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  저장품 입고 헤더 리스트 조회
 * return값 : void
 */
function searchMaster(){

	DS_MASTER.ClearData();
    DS_DETAIL.ClearData();
    
    var strStrCd      = LC_O_STR_CD.BindColVal;
    var strFromDt     = EM_O_FROM_DT.Text;
    var strToDt       = EM_O_TO_DT.Text;
    var strVenCd      = EM_O_VEN_CD.Text;
    var strPumbunCd   = EM_O_PUMBUN_CD.Text;
    var strSlipStatus = LC_O_SLIP_STATUS.BindColVal;

    
    var goTo       = "searchMaster" ;    
    var action     = "O";  
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                   + "&strFromDt="+encodeURIComponent(strFromDt)
                   + "&strToDt="+encodeURIComponent(strToDt)
                   + "&strVenCd="+encodeURIComponent(strVenCd)
                   + "&strPumbunCd="+encodeURIComponent(strPumbunCd)
                   + "&strSlipStatus="+encodeURIComponent(strSlipStatus);
    TR_SUB.Action="/dps/pstk402.pt?goTo="+goTo+parameters;      
    TR_SUB.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_SUB.Post();    
    
    //조회후 결과표시
    setPorcCount("SELECT",GD_MASTER);  

} 
/**
 * searchDetail()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  저장품 입고 상세 리스트 조회
 * return값 : void
 */
function searchDetail(){
    DS_DETAIL.ClearData();
    var masterRow    = DS_MASTER.RowPosition;
    if( masterRow < 1){
        if(DS_MASTER.CountRow < 1){
            LC_O_STR_CD.Focus();
        }else{
            GD_MASTER.Focus();
        }
        return;
    }
    var strStrCd     = DS_MASTER.NameValue(masterRow,"STR_CD");
    var strSlipNo    = DS_MASTER.NameValue(masterRow,"SLIP_NO");
    var strSlipSeqNo = DS_MASTER.NameValue(masterRow,"SLIP_SEQ_NO");
    var strPumbunCd  = EM_O_PUMBUN_CD.Text;

    
    var goTo       = "searchDetail" ;    
    var action     = "O";  
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                   + "&strSlipNo="+encodeURIComponent(strSlipNo)
                   + "&strSlipSeqNo="+encodeURIComponent(strSlipSeqNo)
                   + "&strPumbunCd="+encodeURIComponent(strPumbunCd);
    TR_MAIN.Action="/dps/pstk402.pt?goTo="+goTo+parameters;      
    TR_MAIN.KeyValue="SERVLET("+action+":DS_DETAIL=DS_DETAIL)"; //조회는 O
    TR_MAIN.Post();    
    
    //조회후 결과표시
    setPorcCount("SELECT",GD_DETAIL);  

} 
/**
 * getVenCode()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 협력사명을 등록한다.
 * return값 : void
 */
function getVenCode(evnflag){
    var codeObj = EM_O_VEN_CD;
    var nameObj = EM_O_VEN_NAME;
    var strObj  = LC_O_STR_CD;

    if( codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
        return;     
    }
    
    if( evnflag == "POP" ){
        venPop(codeObj,nameObj,strObj.BindColVal);
        codeObj.Focus();
    }else if( evnflag == "NAME" ){
        setVenNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj, 1, strObj.BindColVal);
    }
}

/**
 * getCalDt()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 달력 팝업을 실행한다.
 * return값 : void
**/
function getCalDt(evnFlag, obj, scvFlag){
    
    if( evnFlag == 'POP'){
        openCal('G',obj);
    }
    
    if(!checkDateTypeYMD( obj , scvFlag != "I"?getTodayFormat("YYYYMMDD"):""))
        return;
    
    if(scvFlag != "I")
        return;
    
    if(obj.Text < getTodayFormat("YYYYMMDD")){
        obj.Text = "";
        showMessage(INFORMATION, OK, "USER-1030","확정일자");    
    }
}
/**
 * getPumbunCode()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 브랜드명을 등록한다.
 * return값 : void
 */
function getPumbunCode(evnflag){
    var codeObj = EM_O_PUMBUN_CD;
    var nameObj = EM_O_PUMBUN_NAME;
    var strObj  = LC_O_STR_CD;

    if( codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
        return;     
    }
    
    if( evnflag == "POP" ){
    	strPbnPop(codeObj,nameObj,'Y','',strObj.BindColVal,'','','','','','1');
        codeObj.Focus();
    }else if( evnflag == "NAME" ){
    	setStrPbnNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj,'Y', 1,'', strObj.BindColVal,'','','','','','1');
    }    
}

/**
 * enableCnt()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 입력 설정
 * return값 : void
 */
function enableCnt( mode ){
    var insFlag = mode=="I";
    var updFlag = !(mode=="R");
    var readFlag = false;
    
    enableControl(EM_SLIP_NO         , readFlag);
    enableControl(EM_SLIP_SEQ_NO     , readFlag);
    enableControl(EM_VEN_CD          , readFlag);
    enableControl(EM_VEN_NAME        , readFlag);
    enableControl(EM_CONF_DT         , updFlag);
    enableControl(IMG_CONF_DT        , updFlag);
    enableControl(EM_IN_TOT_QTY      , readFlag);
    enableControl(EM_IN_TOT_AMT      , readFlag);
    enableControl(LC_STR_CD          , readFlag);
    enableControl(LC_SLIP_FLAG       , readFlag);
    enableControl(LC_SLIP_STATUS     , readFlag);
    GD_DETAIL.Editable = readFlag;
}


/**
 * checkDetailValidation()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 마스터 값을 검증한다.
 * return값 : void
 */
function checkMasterValidation(){
    var row;
    var cmpt;
    var errYn = false;
    
    for(var i=1; i<=DS_MASTER.CountRow; i++){
        var rowStatus = DS_MASTER.RowStatus(i);
        if( !(rowStatus == "3" ) )
            continue;
        row = i;
        if( DS_MASTER.NameValue(i,"CONF_DT")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "확정일자");
            cmpt = "EM_CONF_DT";    
            errYn = true;
            break;
        }
        if( DS_MASTER.NameValue(i,"CONF_DT")< getTodayFormat("YYYYMMDD")){
            showMessage(EXCLAMATION, OK, "USER-1030","확정일자");    
            cmpt = "EM_CONF_DT";    
            errYn = true;
            break;
        }
    }
    
    if(errYn){
        DS_MASTER.RowPosition = row;
        eval(cmpt+".Focus()");
        return false;
    }
    return true;
}

-->
</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                     *-->
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
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<script language=JavaScript for=TR_SUB event=onSuccess>
    for(i=0;i<TR_SUB.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_SUB.SrvErrMsg('UserMsg',i));
    }
</script>


<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_SUB event=onFail>
    trFailed(TR_SUB.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_MASTER event=CanRowPosChange(row)>
    if(btnSaveYn || row < 1)
        return true;
    
    if( DS_MASTER.IsUpdated){
        // 변경된 상세내역이 존재합니다. 이동하시겠습니까?)
        if(showMessage(QUESTION, YESNO, "USER-1049")!=1)
            return false;
        DS_DETAIL.ClearData();
        DS_MASTER.UndoAll();
        DS_MASTER.RowPosition = 0;
    }
    return true;
</script>
<script language=JavaScript for=DS_MASTER event=OnRowPosChanged(row)>
    if(row < 1 || bfMasterRow == row)
        return;
    bfMasterRow = row;
    enableCnt(DS_MASTER.NameValue(row,"SLIP_STATUS")=="1"?"U":"R");
    
    searchDetail();
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<!-- 협력사(조회) -->
<script language=JavaScript for=EM_O_VEN_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    getVenCode('NAME','S');
</script>
<!-- 매장(조회) -->
<script language=JavaScript for=EM_O_PUMBUN_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    getPumbunCode('NAME','S');
</script>
<!-- 기간(From)(조회) -->
<script language=JavaScript for=EM_O_FROM_DT event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    getCalDt('NAME',EM_O_FROM_DT,"S");
</script>
<!-- 기간(To)(조회) -->
<script language=JavaScript for=EM_O_TO_DT event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    getCalDt('NAME',EM_O_TO_DT,"S");
</script>
<!-- 입고/반품일자 -->
<script language=JavaScript for=EM_CONF_DT event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    getCalDt('NAME',EM_CONF_DT,"I");
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

<!-- =============== Input용 -->
<!-- 검색용 -->
<comment id="_NSID_"><object id="DS_O_STR_CD"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_SLIP_STATUS"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_STR_CD"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SLIP_FLAG"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SLIP_STATUS"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_UNIT_CD"        classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSECHECK"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_DETAIL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="TR_SUB" classid=<%=Util.CLSID_TRANSACTION%>>
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
            <th width=80 class="point">점</th>
            <td width="140">
               <comment id="_NSID_">
                 <object id=LC_O_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle"></object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="60" class="point">기간</th>
            <td width="210">
              <comment id="_NSID_">
                <object id=EM_O_FROM_DT classid=<%=Util.CLSID_EMEDIT%> width=75 tabindex=1 align="absmiddle"></object>
              </comment> <script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/date.gif"  class="PR03" onclick="javascript:getCalDt('POP', EM_O_FROM_DT,'S')" align="absmiddle" />&nbsp;~
              <comment id="_NSID_">
                <object id=EM_O_TO_DT classid=<%=Util.CLSID_EMEDIT%> width=75 tabindex=1 align="absmiddle"></object>
              </comment> <script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/date.gif"  class="PR03" onclick="javascript:getCalDt('POP', EM_O_TO_DT,'S')" align="absmiddle" />
            </td>
            <th width="60">협력사</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_O_VEN_CD classid=<%=Util.CLSID_EMEDIT%>  width=50  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/detail_search_s.gif"   onclick="javascript:getVenCode('POP','S');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_O_VEN_NAME classid=<%=Util.CLSID_EMEDIT%>  width=115  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th >확정구분</th>
            <td >
               <comment id="_NSID_">
                 <object id=LC_O_SLIP_STATUS classid=<%= Util.CLSID_LUXECOMBO %> width=140 align="absmiddle">
                 </object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
            <th >브랜드코드</th>
            <td colspan="3">
              <comment id="_NSID_">
                <object id=EM_O_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%>  width=75  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/detail_search_s.gif"   onclick="javascript:getPumbunCode('POP');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_O_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%>  width=105  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
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
        <td width="300"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
            <td>
              <comment id="_NSID_">
                <object id=GD_MASTER width=100% height=480 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_MASTER">
                </object>
              </comment>
              <script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
        <td class="PL10"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td class="PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" >
              <tr>
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td class="sub_title PB03 PT05"><img src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PB03" align="absmiddle"/> 전표마스터</td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td ><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                  <tr>
                    <th width="70" >점</th>
                    <td width="100">
                      <comment id="_NSID_">
                        <object id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%>  width=100  tabindex=1 align="absmiddle"></object>
                      </comment><script> _ws_(_NSID_);</script>
                    </td>
                    <th width="75" >입고/반품일자</th>
                    <td width="95">
                      <comment id="_NSID_">
                        <object id=EM_SLIP_NO classid=<%=Util.CLSID_EMEDIT%> width=95 tabindex=1 align="absmiddle"></object>
                      </comment> <script> _ws_(_NSID_);</script>
                    </td>
                    <th width="50" >전표번호</th>
                    <td >
                      <comment id="_NSID_">
                        <object id=EM_SLIP_SEQ_NO classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1 align="absmiddle"></object>
                      </comment> <script> _ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th >입고/반품구분</th>
                    <td >
                      <comment id="_NSID_">
                        <object id=LC_SLIP_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=100 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th >협력사</th>
                    <td colspan="3">
                      <comment id="_NSID_">
                        <object id=EM_VEN_CD classid=<%=Util.CLSID_EMEDIT%>  width=95  tabindex=1 align="absmiddle"></object>
                      </comment><script> _ws_(_NSID_);</script>
                      <comment id="_NSID_">
                        <object id=EM_VEN_NAME classid=<%=Util.CLSID_EMEDIT%>  width=121  tabindex=1 align="absmiddle"></object>
                      </comment><script> _ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th >확정구분</th>
                    <td >
                      <comment id="_NSID_">
                        <object id=LC_SLIP_STATUS classid=<%= Util.CLSID_LUXECOMBO %> width=100 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th class="point" >확정일자</th>
                    <td colspan="3">
                      <comment id="_NSID_">
                        <object id=EM_CONF_DT classid=<%=Util.CLSID_EMEDIT%>  width=73  tabindex=1 align="absmiddle"></object>
                      </comment><script> _ws_(_NSID_);</script><img 
                      src="/<%=dir%>/imgs/btn/date.gif"  class="PR03" id=IMG_CONF_DT onclick="javascript:getCalDt('POP', EM_CONF_DT,'I')" align="absmiddle" />
                    </td>
                  </tr>
                  <tr>
                    <th >총수량</th>
                    <td >
                      <comment id="_NSID_">
                        <object id=EM_IN_TOT_QTY classid=<%= Util.CLSID_EMEDIT %> width=95 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th >총금액</th>
                    <td colspan="3">
                      <comment id="_NSID_">
                        <object id=EM_IN_TOT_AMT classid=<%=Util.CLSID_EMEDIT%>  width=95  tabindex=1 align="absmiddle"></object>
                      </comment><script> _ws_(_NSID_);</script>
                    </td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td ><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td class="sub_title PB03 PT02"><img src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PB03" align="absmiddle"/> 전표상세</td>
                  </tr>
                </table></td>
              </tr>
              <tr valign="top">
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                  <tr>
                    <td>
                      <comment id="_NSID_">
                        <object id=GD_DETAIL width=100% height=338 classid=<%=Util.CLSID_GRID%>>
                          <param name="DataID" value="DS_DETAIL">
                        </object>
                      </comment>
                      <script>_ws_(_NSID_);</script>
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

<comment id="_NSID_">
<object id=BO_HEADER classid=<%= Util.CLSID_BIND %>>
        <param name=DataID          value=DS_MASTER>
        <param name="ActiveBind"    value=true>
        <param name=BindInfo        value='
            <c>col=STR_CD          ctrl=LC_STR_CD         param=BindColVal </c>
            <c>col=SLIP_FLAG       ctrl=LC_SLIP_FLAG      param=BindColVal </c>
            <c>col=SLIP_STATUS     ctrl=LC_SLIP_STATUS    param=BindColVal </c>
            <c>col=SLIP_NO         ctrl=EM_SLIP_NO        param=Text </c>
            <c>col=SLIP_SEQ_NO     ctrl=EM_SLIP_SEQ_NO    param=Text </c>
            <c>col=VEN_CD          ctrl=EM_VEN_CD         param=Text </c>
            <c>col=VEN_NAME        ctrl=EM_VEN_NAME       param=Text </c>
            <c>col=CONF_DT         ctrl=EM_CONF_DT        param=Text </c>
            <c>col=IN_TOT_QTY      ctrl=EM_IN_TOT_QTY     param=Text </c>
            <c>col=IN_TOT_AMT      ctrl=EM_IN_TOT_AMT     param=Text </c>
        '>
</object>
</comment><script>_ws_(_NSID_);</script>
</body>
</html>

