<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > 브랜드코드> 브랜드이동관리
 * 작 성 일 : 2010.01.17
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod2050.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 코너별 브랜드이동을 등록한다.
 * 이    력 :
 *        2010.01.14 (정진영) 신규작성
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

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 var bfStrCd = "";
 var bfModDt = "";
 var addRowClick = false;
 var btnSave = false;
 var bfMasterRowPos = 0;
 var onPopFlag = false;
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
    gridCreate2(); //이동브랜드내역

    // EMedit에 초기화
    initEmEdit(EM_MOD_DT, "YYYYMMDD", PK);  //변경일자

    //콤보 초기화
    initComboStyle( LC_STR_CD   , DS_STR_CD   , "CODE^0^30,NAME^0^140", 1, PK);  //점(조회)
    initComboStyle( LC_ORG_FLAG , DS_ORG_FLAG , "CODE^0^30,NAME^0^80", 1, NORMAL);  //조직구분(조회)

    //점콤보 가져오기 ( gauce.js )
    getStore("DS_STR_CD", "Y", "", "N");
    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_ORG_FLAG", "D", "P047", "N");
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_STR_CD.Index < 0){
        LC_STR_CD.Index= 0;
    }
    setComboData(LC_ORG_FLAG,'1');
    EM_MOD_DT.Text = getRawData(addDate('D',1,getTodayFormat('YYYYMMDD')));
    bfModDt = EM_MOD_DT.Text;
    bfStrCd = LC_STR_CD.BindColVal;
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pcod205","DS_MASTER,DS_DETAIL" );
    
    LC_STR_CD.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}          name="NO"          edit="none" width=30   align=center</FC>'
                     + '<FC>id=MOD_DT            name="변경일자"    edit="none"  width=80  mask="XXXX/XX/XX" align=center</FC>'
                     + '<FG>                     name="변경전"      '
                     + '<FC>id=MOD_BF_ORG_CD     name="*조직코드"   width=100 EditStyle=Popup  edit="Numeric"  align=center</FC>'
                     + '<FC>id=MOD_BF_ORG_NM     name="조직명"      width=145 edit="none"    align=left</FC>'
                     + '<FC>id=MOD_BF_BUYER_NM   name="바이어(SM)"  width=90 edit="none"    align=left</FC>'
                     + '</FG>'
                     + '<FG>                     name="변경후"      '
                     + '<FC>id=MOD_AFT_ORG_CD    name="*조직코드"   width=100  EditStyle=Popup edit="Numeric" align=center</FC>'
                     + '<FC>id=MOD_AFT_ORG_NM    name="조직명"      width=145  edit="none" align=left</FC>'
                     + '<FC>id=MOD_AFT_BUYER_NM  name="바이어(SM)"  width=90 edit="none"   align=left</FC>'
                     + '</FG>';

    initGridStyle(GD_MASTER, "common", hdrProperies, true);
}
function gridCreate2(){
    var hdrProperies = '<FC>id={currow}          name="NO"         edit="none" width=30   align=center</FC>'
                     + '<FC>id=SEL               name="선택   "      width=50    align=center EditStyle=CheckBox Pointer=Hand HeadCheckShow=true </FC>'
                     + '<FG>                     name="브랜드"     '
                     + '<FC>id=PUMBUN_CD         name="코드"       width=55  edit="none"  align=center</FC>'
                     + '<FC>id=PUMBUN_NAME       name="명"         width=150  edit="none" align=left</FC>'
                     + '</FG>'
                     + '<FC>id=VEN_NAME          name="협력사명"   width=80  edit="none"  align=left</FC>'
                     + '<FG>                     name="변경전"     '
                     + '<FC>id=MOD_BF_ORG_CD     name="코너코드"   width=80  edit="none" align=center</FC>'
                     + '<FC>id=MOD_BF_ORG_NAME   name="코너명"     width=150 edit="none"  align=left</FC>'
                     + '</FG>'
                     + '<FG>                     name="변경후"     '
                     + '<FC>id=MOD_AFT_ORG_CD    name="코너코드"   width=80  edit="none" align=center</FC>'
                     + '<FC>id=MOD_AFT_ORG_NAME  name="코너명"     width=150 edit="none"  align=left</FC>'
                     + '</FG>';

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
 * 작 성 일 : 2010-12-12
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {


    if( LC_STR_CD.BindColVal == '') {
        // ()은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", "점");
        LC_STR_CD.Focus();
        return;
    }
    if( LC_ORG_FLAG.BindColVal == '') {
        // ()은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", "조직구분");
        LC_ORG_FLAG.Focus();
        return;
    }
    if( EM_MOD_DT.Text == '') {
        // ()은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", "변경일자");
        EM_MOD_DT.Focus();
        return;
    }
    if( DS_MASTER.IsUpdated || DS_DETAIL.IsUpdated){
    	// 변경된 상세내역이 존재합니다. 조회하세겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1059") != 1 ){
        	GD_MASTER.Focus();
        	return;
        }
    }
    DS_MASTER.ClearData();
    DS_DETAIL.ClearData();
    bfMasterRowPos = 0;
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
	//선택한 항목을 삭제하겠습니까?
	if( showMessage(QUESTION, YESNO, "USER-1023") != 1 ){
        setFocusGrid(GD_MASTER,DS_MASTER,DS_MASTER.RowPosition,"MOD_BF_ORG_CD");
	    return;
	}
	    
	DS_MASTER.DeleteRow(DS_MASTER.RowPosition);
    DS_DETAIL.ClearData();	  
	TR_MAIN.Action="/dps/pcod205.pc?goTo=delete";
	TR_MAIN.KeyValue="SERVLET(I:DS_MASTER=DS_MASTER)"; //조회는 O
	TR_MAIN.Post();

    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
        bfMasterRowPos = 0;
        searchMaster();       
    }
    GD_MASTER.Focus();
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
	// 저장할 데이터 없는 경우
    if (!DS_MASTER.IsUpdated && !DS_DETAIL.IsUpdated  ){
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
        setFocusGrid(GD_MASTER,DS_MASTER,DS_MASTER.RowPosition,"MOD_BF_ORG_CD");
        return;
    }
    
    if( !checkMasterValidation())
        return;

    // 마감체크 (common.js)
    if( getCloseCheck('DS_CLOSECHECK','',getTodayFormat("YYYYMMDD"),'PCOD','05','0','T') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
        setFocusGrid(GD_MASTER,DS_MASTER,DS_MASTER.RowPosition,"MOD_BF_ORG_CD");
        return;
    }
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        setFocusGrid(GD_MASTER,DS_MASTER,DS_MASTER.RowPosition,"MOD_BF_ORG_CD");
        return;
    }

    var bfOrgCd = DS_MASTER.NameValue(DS_MASTER.RowPosition,"MOD_BF_ORG_CD");
    var afOrgCd = DS_MASTER.NameValue(DS_MASTER.RowPosition,"MOD_AFT_ORG_CD");
    btnSave = true; 
    var strStrCd = LC_STR_CD.BindColVal;
    var strModDate = EM_MOD_DT.Text;
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                   + "&strModDate="+encodeURIComponent(strModDate);
    TR_MAIN.Action="/dps/pcod205.pc?goTo=save"+parameters;
    TR_MAIN.KeyValue="SERVLET(I:DS_MASTER=DS_MASTER,I:DS_DETAIL=DS_DETAIL)"; //조회는 O
    TR_MAIN.Post();
    btnSave = false;

    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
        bfMasterRowPos = 0;
        searchMaster(); 
        var row = getNameValueRow(DS_MASTER,"MOD_BF_ORG_CD||MOD_AFT_ORG_CD",bfOrgCd+"||"+afOrgCd);    
        row = row<1?1:row;
        DS_MASTER.RowPosition = row;
    }
    GD_MASTER.Focus();
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

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

 /**
  * btn_addRow()
  * 작 성 자 : 정진영
  * 작 성 일 : 2010-02-28
  * 개    요 : 마스터 행을 추가한다.
  * return값 : void
 **/ 
 function btn_addRow(){

	if( LC_STR_CD.BindColVal == '') {
	    // ()은/는 반드시 입력해야 합니다.
	    showMessage(EXCLAMATION, OK, "USER-1003", "점");
	    LC_STR_CD.Focus();
	    return;
	}
	if( EM_MOD_DT.Text == '') {
	    // ()은/는 반드시 입력해야 합니다.
	    showMessage(EXCLAMATION, OK, "USER-1003", "변경일자");
	    EM_MOD_DT.Focus();
	    return;
	}

	var strStrCd = LC_STR_CD.BindColVal;
    var strOrgFlag = LC_ORG_FLAG.BindColVal;
	var strModDate = EM_MOD_DT.Text;
	
	getTodayAfModDt();
	
	if( DS_TODAY_AF_MOD_DT.CountRow > 1 ){
        showMessage(EXCLAMATION, OK, "USER-1034");
        EM_MOD_DT.Focus();
        return;
	}else if( DS_TODAY_AF_MOD_DT.CountRow == 1){
		var value = DS_TODAY_AF_MOD_DT.NameValue(DS_TODAY_AF_MOD_DT.RowPosition,"MOD_DT");
		if( value != strModDate){
	        showMessage(EXCLAMATION, OK, "USER-1000", "이미 등록된 변경일자("+value+")가 존재 합니다.");
	        setFocusGrid(GD_MASTER,DS_MASTER,DS_MASTER.RowPosition,"MOD_DT");
	        return;
		}
	}
	DS_MASTER.AddRow();
    DS_MASTER.NameValue(DS_MASTER.CountRow,"STR_CD") = strStrCd;
    DS_MASTER.NameValue(DS_MASTER.CountRow,"ORG_FLAG") = strOrgFlag;
    DS_MASTER.NameValue(DS_MASTER.CountRow,"MOD_DT") = strModDate;
	DS_MASTER.NameValue(DS_MASTER.CountRow,"PROC_YN") = "N";
	
	setFocusGrid(GD_MASTER,DS_MASTER,DS_MASTER.CountRow,"MOD_BF_ORG_CD");
 }
 /**
  * btn_delRow()
  * 작 성 자 : 정진영
  * 작 성 일 : 2010-02-28
  * 개    요 : 마스터 행을 삭제한다.
  * return값 : void
 **/ 
function btn_delRow(){
    if(DS_MASTER.RowStatus(DS_MASTER.RowPosition) == 1){
        DS_MASTER.DeleteRow(DS_MASTER.RowPosition);
        return;
    }
    showMessage(INFORMATION, OK, "USER-1052");
}

/**
 * searchMaster
 * 작 성 자 : 
 * 작 성 일 : 2010-03-02
 * 개    요 : 마스터을 조회한다.
 * return값 : void
**/
function searchMaster() {

    DS_MASTER.ClearData();
    
    var strStrCd = LC_STR_CD.BindColVal;
    var strModDate = EM_MOD_DT.Text;
    var strOrgFlag = LC_ORG_FLAG.BindColVal;
    
    var goTo       = "searchMaster" ;    
    var action     = "O";
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                   + "&strModDate="+encodeURIComponent(strModDate)
                   + "&strOrgFlag="+encodeURIComponent(strOrgFlag);
    TR_MAIN.Action="/dps/pcod205.pc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();
    //조회후 결과표시
    setPorcCount("SELECT",GD_MASTER);
}
/**
 * searchDetail
 * 작 성 자 : 
 * 작 성 일 : 2010-03-02
 * 개    요 : 상세내역을 조회한다.
 * return값 : void
**/
function searchDetail() {

    if( LC_STR_CD.BindColVal == '') {
        // ()은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", "점");
        LC_STR_CD.Focus();
        return;
    }
    if( LC_ORG_FLAG.BindColVal == '') {
        // ()은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", "조직구분");
        LC_ORG_FLAG.Focus();
        return;
    }
    
    if( EM_MOD_DT.Text == '') {
        // ()은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", "변경일자");
        EM_MOD_DT.Focus();
        return;
    }
    var strBfOrgCd = DS_MASTER.NameValue( DS_MASTER.RowPosition, "MOD_BF_ORG_CD");
    var strAftOrgCd = DS_MASTER.NameValue( DS_MASTER.RowPosition, "MOD_AFT_ORG_CD");

    DS_DETAIL.ClearData();
    
    if( strBfOrgCd != '' 
    	&& DS_MASTER.NameValue( DS_MASTER.RowPosition, "MOD_BF_ORG_NM")  != '' 
    	&& strAftOrgCd != '' 
        && DS_MASTER.NameValue( DS_MASTER.RowPosition, "MOD_AFT_ORG_NM") != '' )
    	{
    	
    	GD_DETAIL.ColumnProp('SEL', 'HeadCheck') =  'FALSE';
        var strStrCd = LC_STR_CD.BindColVal;
        var strModDate = EM_MOD_DT.Text;
        var strOrgFlag = LC_ORG_FLAG.BindColVal;
        
        var goTo       = "searchDetail" ;    
        var action     = "O";
        var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                       + "&strModDate="+encodeURIComponent(strModDate)
                       + "&strOrgFlag="+encodeURIComponent(strOrgFlag)
                       + "&strBfOrgCd="+encodeURIComponent(strBfOrgCd)
                       + "&strAftOrgCd="+encodeURIComponent(strAftOrgCd);
        TR_SUB.Action="/dps/pcod205.pc?goTo="+goTo+parameters;  
        TR_SUB.KeyValue="SERVLET("+action+":DS_DETAIL=DS_DETAIL)"; //조회는 O
        TR_SUB.Post();
        
        //조회후 결과표시
        setPorcCount("SELECT",GD_DETAIL);
        
    }
    
}

/**
 * changeOrg
 * 작 성 자 : 
 * 작 성 일 : 2010-03-03
 * 개    요 : 조직정보 변경시 처리 한다.
 * return값 : void
**/
function changeOrg( bfAfFlag, orgCd, orgNm, kostlCd){
    var row = DS_MASTER.RowPosition;	
    var codeCol  = bfAfFlag == "BF" ? "MOD_BF_ORG_CD"   : "MOD_AFT_ORG_CD"; 
	var nameCol  = bfAfFlag == "BF" ? "MOD_BF_ORG_NM"   : "MOD_AFT_ORG_NM";
	var buyerCol = bfAfFlag == "BF" ? "MOD_BF_BUYER_NM" : "MOD_AFT_BUYER_NM";
    var kostlCol = bfAfFlag == "BF" ? "MOD_BF_KOSTL_CD" : "MOD_AFT_KOSTL_CD"  ;
	
    DS_MASTER.NameValue(row, codeCol) = orgCd;
    DS_MASTER.NameValue(row, nameCol) = orgNm;
    DS_MASTER.NameValue(row, kostlCol) = kostlCd;
    
	if( orgCd == DS_MASTER.NameValue(row, bfAfFlag == "BF" ? "MOD_AFT_ORG_CD" : "MOD_BF_ORG_CD")){
		showMessage(EXCLAMATION, OK, "USER-1000", "변경전 조직과 변경후 조직 정보가 같습니다.");
	    DS_MASTER.NameValue(row, codeCol) = "";
	    DS_MASTER.NameValue(row, nameCol) = "";
        DS_MASTER.NameValue(row, buyerCol) = "";
        DS_MASTER.NameValue(row, kostlCol) = "";
        setFocusGrid(GD_MASTER,DS_MASTER,row,codeCol);
        DS_DETAIL.ClearData();
		return;
		
	}

    if( DS_MASTER.NameValue(row, bfAfFlag == "BF" ? "MOD_AFT_KOSTL_CD" : "MOD_BF_KOSTL_CD") != ""
    		&& kostlCd != DS_MASTER.NameValue(row, bfAfFlag == "BF" ? "MOD_AFT_KOSTL_CD" : "MOD_BF_KOSTL_CD")){
        showMessage(EXCLAMATION, OK, "USER-1000", "변경전 조직과 변경후 조직 의 코스트센터코드가 같지 않습니다.");
        DS_MASTER.NameValue(row, codeCol) = "";
        DS_MASTER.NameValue(row, nameCol) = "";
        DS_MASTER.NameValue(row, buyerCol) = "";
        DS_MASTER.NameValue(row, kostlCol) = "";
        setFocusGrid(GD_MASTER,DS_MASTER,row,codeCol);
        DS_DETAIL.ClearData();
        return;
        
    }
    getMainBuyer( "DS_MAIN_BUYER", orgCd , LC_ORG_FLAG.BindColVal);
    
    var dupRow = checkDupKey(DS_MASTER, "MOD_BF_ORG_CD||MOD_AFT_ORG_CD");
    if( dupRow > 0){
        showMessage(EXCLAMATION, OK, "USER-1044", dupRow);
        DS_MASTER.NameValue(row, codeCol) = "";
        DS_MASTER.NameValue(row, nameCol) = "";
        DS_MASTER.NameValue(row, buyerCol) = "";
        DS_MASTER.NameValue(row, kostlCol) = "";
        setFocusGrid( GD_MASTER, DS_MASTER, dupRow, codeCol);
        DS_DETAIL.ClearData();
        return false;
        
    }
    
    if( DS_MAIN_BUYER.CountRow == 1){
    	DS_MASTER.NameValue(row, buyerCol) = DS_MAIN_BUYER.NameValue(1,"BUYER_NAME");
    }else{

        if(LC_ORG_FLAG.BindColVal=='2')
            showMessage(EXCLAMATION, OK, "USER-1000", "["+orgCd+"] "+orgNm+"의 (정)바이어가 없습니다.");
        else
            showMessage(EXCLAMATION, OK, "USER-1000", "["+orgCd+"] "+orgNm+"의 (정)SM이 없습니다.");

        DS_MASTER.NameValue(row, codeCol) = "";
        DS_MASTER.NameValue(row, nameCol) = "";
    	DS_MASTER.NameValue(row, buyerCol) = "";
        DS_MASTER.NameValue(row, kostlCol) = "";
        DS_DETAIL.ClearData();
    	return;
    }

    
    if( DS_MASTER.NameValue(row,"MOD_BF_ORG_NM")!=''
            && DS_MASTER.NameValue(row,"MOD_AFT_ORG_NM")!='')
        searchDetail();
}
/**
 * getTodayAfModDt()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-03
 * 개    요 : 오늘 이후 변경일자 내역 조회
 * return값 : void
**/
function getTodayAfModDt(){
	
    var goTo       = "searchTodayAfModDt" ;    
    var action     = "O";
    var strStrCd = LC_STR_CD.BindColVal;
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd);
    TR_MAIN.Action="/dps/pcod205.pc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MOD_DT=DS_TODAY_AF_MOD_DT)"; //조회는 O
    TR_MAIN.Post();    
    
}
/**
 * checkMasterValidation
 * 작 성 자 : 
 * 작 성 일 : 2010-03-03
 * 개    요 : 브랜드이동관리 마스터 입력 체크
 * return값 : void
**/
function checkMasterValidation(){

    var check = false;
    var titleNm = "";
    var columnId = "";
    var row;

    for(var i = 1; i <= DS_MASTER.CountRow; i++ ) {
        var rowStatus = DS_MASTER.RowStatus(i);

        if( rowStatus == 0 
              || rowStatus == 2
              || rowStatus == 4)
                continue;
        if( DS_MASTER.NameValue( i, "MOD_BF_ORG_CD") == ''){
            check = true;
            titleNm = "변경전조직코드";
            columnId = "MOD_BF_ORG_CD";
            row = i;
            break;;
        }
        if( DS_MASTER.NameValue( i, "MOD_BF_ORG_NM") == ''){
            showMessage(EXCLAMATION, OK, "USER-1000", "변경전조직코드가 유효하지 않습니다.");
            setFocusGrid( GD_MASTER, DS_MASTER, i, "MOD_BF_ORG_CD");
            return false;
        }
        
        if( DS_MASTER.NameValue( i, "MOD_AFT_ORG_CD") == ''){
            check = true;
            titleNm = "변경후조직코드";
            columnId = "MOD_AFT_ORG_CD";
            row = i;
            break;
        }
        
        if( DS_MASTER.NameValue( i, "MOD_AFT_ORG_NM") == ''){
            showMessage(EXCLAMATION, OK, "USER-1000", "변경후조직코드가 유효하지 않습니다.");
            setFocusGrid( GD_MASTER, DS_MASTER, i, "MOD_BF_ORG_CD");
            return false;
        }
        if( DS_MASTER.NameValue( i, "MOD_BF_ORG_CD").substring(0,2) != LC_STR_CD.BindColVal){
            showMessage(EXCLAMATION, OK, "USER-1000", "변경전조직코드는  "+LC_STR_CD.Text+"의 조직이 아닙니다.");
            setFocusGrid( GD_MASTER, DS_MASTER, i, 'MOD_BF_ORG_CD');
            return false;
        }
        if( DS_MASTER.NameValue( i, "MOD_AFT_ORG_CD").substring(0,2) != LC_STR_CD.BindColVal){
            showMessage(EXCLAMATION, OK, "USER-1000", "변경후조직코드  "+LC_STR_CD.Text+"의 조직이 아닙니다.");
            setFocusGrid( GD_MASTER, DS_MASTER, i, 'MOD_AFT_ORG_CD');
            return false;
        }
        if( DS_MASTER.NameValue( i, "MOD_BF_KOSTL_CD") != DS_MASTER.NameValue( i, "MOD_AFT_KOSTL_CD")){
            showMessage(EXCLAMATION, OK, "USER-1000", "변경후조직코드 과 변경전 조직의 코스트센터코드가 다릅니다");
            setFocusGrid( GD_MASTER, DS_MASTER, i, 'MOD_AFT_ORG_CD');
            return false;
        }
        var dupRow = checkDupKey(DS_MASTER, "MOD_BF_ORG_CD||MOD_AFT_ORG_CD");
        if( dupRow > 0){
            showMessage(EXCLAMATION, OK, "USER-1044", dupRow);
            setFocusGrid( GD_MASTER, DS_MASTER, i, 'MOD_BF_ORG_CD');
            return false;
        	
        }
    }

    if( check ){
        // ()은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", titleNm);
        setFocusGrid( GD_MASTER, DS_MASTER, row, columnId);
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
    if(DS_DETAIL.IsUpdated && !btnSave){
        if(showMessage(QUESTION, YESNO, addRowClick?"USER-1050":"USER-1049")!= 1){
            addRowClick = false;
            return false;       
        }
    }
    addRowClick = false;
    return true;
</script>
<script language=JavaScript for=DS_MASTER event=OnRowPosChanged(row)>
    if( row < 1 || bfMasterRowPos == row)
    	return;
    bfMasterRowPos = row;
    searchDetail();
    
</script>
<script language=JavaScript for=DS_MASTER event=OnDataError(row,colid)>
    if(colid == 'MOD_BF_ORG_CD'){
        showMessage(EXCLAMATION, OK, "USER-1003", "변경전조직코드");
        setTimeout("setFocusGrid( GD_MASTER, DS_MASTER, "+row+",'"+ colid+"');",50);    	
    }else if(colid == 'MOD_AFT_ORG_CD'){
        showMessage(EXCLAMATION, OK, "USER-1003", "변경후조직코드");
        setTimeout("setFocusGrid( GD_MASTER, DS_MASTER, "+row+",'"+ colid+"');",50);
    }else{
    	showMessage(EXCLAMATION, OK, "USER-1044", row);
    }
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>


<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid );
</script>

<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid );
</script>

<script language=JavaScript for=GD_MASTER event=OnExit(row,colid,oldData)>
    var nameCol = colid == "MOD_BF_ORG_CD" ? "MOD_BF_ORG_NM" : "MOD_AFT_ORG_NM"  ;
    var buyerCol = colid == "MOD_BF_ORG_CD" ? "MOD_BF_BUYER_NM" : "MOD_AFT_BUYER_NM"  ;
    var kostlCol = colid == "MOD_BF_ORG_CD" ? "MOD_BF_KOSTL_CD" : "MOD_AFT_KOSTL_CD"  ;
    var value = eval(this.DataID).NameValue(row, colid);
    if(onPopFlag)
    	return;
    if(value == oldData )
    	return;
    eval(this.DataID).NameValue(row, nameCol) = "";
    eval(this.DataID).NameValue(row, buyerCol) = "";  
    eval(this.DataID).NameValue(row, kostlCol) = "";
    DS_DETAIL.ClearData();
    if( value == ""){  
    	return;
    }
    var orgLvl = LC_ORG_FLAG.BindColVal == "1"?"5":"4"; 
    var popupData = setOrgNmWithoutToGridPop( 'DS_ORG_NAME', eval(this.DataID).NameValue(row, colid), '', 'N', 1, '', '', LC_ORG_FLAG.BindColVal, orgLvl, 'Y',LC_STR_CD.BindColVal, eval(this.DataID).NameValue(row, colid == "MOD_BF_ORG_CD" ? "MOD_AFT_KOSTL_CD" : "MOD_BF_KOSTL_CD" ));

    if(popupData != null){
        if(orgLvl == 5){
            if( popupData.get("CORNER_CD") == "00"){
                showMessage(EXCLAMATION, OK, "USER-1000", "조직코드는 코너레벨의 조직을 선택하세요.");
                eval(this.DataID).NameValue(row, colid) = "";
                eval(this.DataID).NameValue(row, nameCol) = "";
                eval(this.DataID).NameValue(row, buyerCol) = "";
                eval(this.DataID).NameValue(row, kostlCol) = "";
                DS_DETAIL.ClearData();
                return false;
            }
        }else{
            if( popupData.get("PC_CD") == "00" || popupData.get("CORNER_CD") != "00"){
                showMessage(EXCLAMATION, OK, "USER-1000", "조직코드는 PC레벨의 조직을 선택하세요.");
                eval(this.DataID).NameValue(row, colid) = "";
                eval(this.DataID).NameValue(row, nameCol) = "";
                eval(this.DataID).NameValue(row, buyerCol) = "";
                eval(this.DataID).NameValue(row, kostlCol) = "";
                DS_DETAIL.ClearData();
                return false;
            }
        }
        changeOrg(colid == "MOD_BF_ORG_CD" ? "BF" :"AF",popupData.get("ORG_CD"),popupData.get("ORG_NAME"),popupData.get("KOSTL_CD"));
    } else {
    	if( eval(this.DataID).NameValue(row, nameCol) == ""){
            eval(this.DataID).NameValue(row, colid) = "";
            eval(this.DataID).NameValue(row, nameCol) = "";
            eval(this.DataID).NameValue(row, buyerCol) = "";
            eval(this.DataID).NameValue(row, kostlCol) = "";
            DS_DETAIL.ClearData();
    	}
    }
</script>
<script language=JavaScript for=GD_MASTER event=OnPopup(row,colid,data)>
    var orgLvl = LC_ORG_FLAG.BindColVal == "1"?"5":"4";
    var popupData = orgToGridPop( data, '', 'N', '', '', LC_ORG_FLAG.BindColVal, orgLvl, 'Y',LC_STR_CD.BindColVal, eval(this.DataID).NameValue(row, colid == "MOD_BF_ORG_CD" ? "MOD_AFT_KOSTL_CD" : "MOD_BF_KOSTL_CD" ));
    var nameCol = colid == "MOD_BF_ORG_CD" ? "MOD_BF_ORG_NM" : "MOD_AFT_ORG_NM"  ;
    var buyerCol = colid == "MOD_BF_ORG_CD" ? "MOD_BF_BUYER_NM" : "MOD_AFT_BUYER_NM"  ;
    var kostlCol = colid == "MOD_BF_ORG_CD" ? "MOD_BF_KOSTL_CD" : "MOD_AFT_KOSTL_CD"  ;
    onPopFlag = true;
    
    if(popupData != null){
    	if(orgLvl == 5){
    		if( popupData.get("CORNER_CD") == "00"){
                showMessage(EXCLAMATION, OK, "USER-1000", "조직코드는 코너레벨의 조직을 선택하세요.");
    	        eval(this.DataID).NameValue(row, colid) = "";
    	        eval(this.DataID).NameValue(row, nameCol) = "";
    	        eval(this.DataID).NameValue(row, buyerCol) = "";
                eval(this.DataID).NameValue(row, kostlCol) = "";
                DS_DETAIL.ClearData();
                onPopFlag = false;
    	        return;
    		}
    	}else{
            if( popupData.get("PC_CD") == "00"){
                showMessage(EXCLAMATION, OK, "USER-1000", "조직코드는 PC레벨의 조직을 선택하세요.");
                eval(this.DataID).NameValue(row, colid) = "";
                eval(this.DataID).NameValue(row, nameCol) = "";
                eval(this.DataID).NameValue(row, buyerCol) = "";
                eval(this.DataID).NameValue(row, kostlCol) = "";
                DS_DETAIL.ClearData();
                onPopFlag = false;
                return;
            }
    		
    	}
    	
        changeOrg(colid == "MOD_BF_ORG_CD" ? "BF" :"AF",popupData.get("ORG_CD"),popupData.get("ORG_NAME"),popupData.get("KOSTL_CD"));
    } else {
        if( eval(this.DataID).NameValue(row, nameCol) == ""){
            eval(this.DataID).NameValue(row, colid) = "";
            eval(this.DataID).NameValue(row, nameCol) = "";
            eval(this.DataID).NameValue(row, buyerCol) = "";
            eval(this.DataID).NameValue(row, kostlCol) = "";
            DS_DETAIL.ClearData();
        }
    }
    onPopFlag = false;
</script>
<script language="javascript"  for=GD_DETAIL event=OnHeadCheckClick(Col,Colid,bCheck)>
    var dataSet = eval(this.DataID);
    for( var i=1 ; i<=dataSet.CountRow; i++){
    	dataSet.NameValue(i,Colid) = bCheck=='0'?'F':'T';
    }
</script>


<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
    if( bfStrCd == this.BindColVal)
    	return;
    
    if(DS_MASTER.IsUpdated || DS_DETAIL.IsUpdated){
        // 변경된 상세내역이 존재합니다. 점을 변경하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1063","점") != 1 ){
            setComboData(LC_STR_CD  ,bfStrCd); 
            GD_MASTER.Focus();
        }else{
            bfStrCd = this.BindColVal;
            DS_MASTER.ClearData();
            DS_DETAIL.ClearData();          
        }
    }else{
        bfStrCd = this.BindColVal;
        DS_MASTER.ClearData();
        DS_DETAIL.ClearData();
    }
</script>
<script language=JavaScript for=LC_ORG_FLAG event=OnSelChange()>
    if(  this.BindColVal == '1'  ){
    	GD_MASTER.ColumnProp('MOD_BF_BUYER_NM', 'Name')= "SM";
        GD_MASTER.ColumnProp('MOD_AFT_BUYER_NM', 'Name')= "SM";
        GD_DETAIL.ColumnProp('MOD_BF_ORG_CD', 'Name')= "코너코드";
        GD_DETAIL.ColumnProp('MOD_BF_ORG_NAME', 'Name')= "코너명";
        GD_DETAIL.ColumnProp('MOD_AFT_ORG_CD', 'Name')= "코너코드";
        GD_DETAIL.ColumnProp('MOD_AFT_ORG_NAME', 'Name')= "코너명";
    }else{
        GD_MASTER.ColumnProp('MOD_BF_BUYER_NM', 'Name')= "바이어";
        GD_MASTER.ColumnProp('MOD_AFT_BUYER_NM', 'Name')= "바이어";
        GD_DETAIL.ColumnProp('MOD_BF_ORG_CD', 'Name')= "PC코드";
        GD_DETAIL.ColumnProp('MOD_BF_ORG_NAME', 'Name')= "PC명";
        GD_DETAIL.ColumnProp('MOD_AFT_ORG_CD', 'Name')= "PC코드";
        GD_DETAIL.ColumnProp('MOD_AFT_ORG_NAME', 'Name')= "PC명";
    }
    DS_MASTER.ClearData();
    DS_DETAIL.ClearData();
</script>
<script language=JavaScript for=EM_MOD_DT event=OnKillFocus()>
    var value = EM_MOD_DT.Text;
    if( bfModDt != value){
        if( DS_MASTER.IsUpdated || DS_DETAIL.IsUpdated){
            // 변경된 상세내역이 존재합니다. 변경일자을 변경하시겠습니까?
            if( showMessage(QUESTION, YESNO, "USER-1063","변경일자") != 1 ){
            	this.Text = bfModDt;
                GD_MASTER.Focus();
                return;
            }
        }
        bfModDt = value;
        DS_MASTER.ClearData();
        DS_DETAIL.ClearData();
    }

    if( !checkDateTypeYMD(this,getRawData(addDate('D',1,getTodayFormat('YYYYMMDD')))))
        return;

    if( value < getRawData(addDate('D',1,getTodayFormat('YYYYMMDD')))){
        showMessage(EXCLAMATION, OK, "USER-1011", "변경일자");
        this.Text = getRawData(addDate('D',1,getTodayFormat('YYYYMMDD')));
        this.Focus();
    }

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
<comment id="_NSID_">
<object id="DS_STR_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_ORG_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_MAIN_BUYER" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_ORG_NAME" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_TODAY_AF_MOD_DT" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_CLOSECHECK" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_MASTER" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_DETAIL" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="TR_SUB" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">

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
						<th width="80" class="point">점</th>
						<td width="140"><comment id="_NSID_"> <object
							id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="80" class="point">조직구분</th>
						<td width="140"><comment id="_NSID_"> <object
							id=LC_ORG_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="80" class="point">변경일자</th>
						<td><comment id="_NSID_"> <object id=EM_MOD_DT
							classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" class="PR03"
							onclick="javascript:openCal('G',EM_MOD_DT)" align="absmiddle" />
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
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="right PB02" valign="bottom"><img
					src="/<%=dir%>/imgs/btn/add_row.gif" width="52" height="18"
					onclick="javascript: addRowClick = true; btn_addRow();" hspace="2" /><img
					src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18"
					onclick="javascript:btn_delRow();" /></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0" class="BD4A"
			width="100%">
			<tr>
				<td><comment id="_NSID_"><object id=GD_MASTER
					width="100%" height=230 classid=<%=Util.CLSID_GRID%>>
					<param name="DataID" value="DS_MASTER">
				</object></comment><script>_ws_(_NSID_);</script></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="sub_title PB03 PT10"><img
					src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
					align="absmiddle" /> 이동브랜드내역</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"><object id=GD_DETAIL
					width="100%" height=225 classid=<%=Util.CLSID_GRID%>>
					<param name="DataID" value="DS_DETAIL">
				</object></comment><script>_ws_(_NSID_);</script></td>
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

