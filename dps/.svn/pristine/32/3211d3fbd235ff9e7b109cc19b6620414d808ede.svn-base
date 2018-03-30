<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > 행사코드> 점별행사관리(품번)
 * 작 성 일 : 2010.01.18
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod7050.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 점별 브랜드행사 정보를 등록 수정 한다.
 * 이    력 :
 *        2010.01.18 (정진영) 신규작성
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
var bfEventCd = "";
var bfStrCd = "";
var onPopup = false;
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
    DS_EVTMST.setDataHeader('<gauce:dataset name="H_SEL_EVTMST"/>');
    DS_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //행사정보
    gridCreate2(); //점별브랜드행사

    // EMedit에 초기화
    initEmEdit(EM_EVENT_CD   , "CODE^11"  ,  PK);        //행사코드
    initEmEdit(EM_EVENT_NAME , "GEN^40"   ,  READ);      //행사명
    initEmEdit(EM_PUMBUN_CD  , "CODE^6^0" ,  NORMAL);    //브랜드코드
    initEmEdit(EM_PUMBUN_NAME, "GEN^40"   ,  NORMAL);     //브랜드명

    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_STR_CD, "CODE^0^30,NAME^0^140", 1, PK);  //점(조회)

    //점콤보 가져오기 ( gauce.js )
    getStore("DS_STR_CD", "Y", "", "N");
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_STR_CD.Index < 0){
        LC_STR_CD.Index= 0;
    }
    // 삭제된 로우 표시여부
    //DS_MASTER.ViewDeletedRow = true;
    
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pcod705","DS_MASTER" );
    
    bfStrCd = LC_STR_CD.BindColVal;
    LC_STR_CD.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}             width=25   align=center name="NO"         </FC>'
                     + '<FG>name="행사테마"'
                     + '<FC>id=EVENT_THME_CD        width=50   align=center name="코드"       </FC>'
                     + '<FC>id=EVENT_THME_NAME      width=100  align=left   name="명"         </FC>'
                     + '</FG>'
                     + '<FC>id=EVENT_S_DT           width=80   align=center name="행사시작일 " mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=EVENT_E_DT           width=80   align=center name="행사종료일" mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=EVENT_TYPE_NAME      width=80   align=left   name="행사종류"   </FC>'
                     + '<FC>id=EVENT_PLU_FLAG_NAME  width=100   align=left   name="행사유형"   </FC>'
                     + '<FC>id=EVENT_MNG_FLAG_NAME  width=80   align=left   name="행사주관"   </FC>'
                     + '<FC>id=EVENT_ORG_NAME       width=125  align=left   name="주관조직"   </FC>'
                     + '<FC>id=EVENT_CHAR_NAME      width=100  align=left   name="담당자"     </FC>';

    initGridStyle(GD_EVTMST, "common", hdrProperies, false);
}
function gridCreate2(){
    var hdrProperies = '<FC>id={currow}        width=25 align=center edit=none        name="NO"               </FC>'
                     + '<FC>id=PUMBUN_CD       width=80 align=center edit=Numeric     name="*브랜드코드"         EditStyle=Popup  edit={IF(SysStatus="I","true","false")} </FC>'
                     + '<FC>id=PUMBUN_NAME     width=130 align=left   edit=none        name="브랜드명"            </FC>'
                     + '<C>id=EVENT_FLAG      width=90 align=center                  name="*행사구분"         EditStyle=Lookup data="DS_EVENT_FLAG:COL1:COL1" edit={IF(SysStatus="I","true","false")} </C>'
                     + '<C>id=EVENT_RATE      width=90 align=right  edit=Numeric     name="*행사율"           edit={IF(SysStatus="I",IF(EVENT_CHECK="0","true",IF(EVENT_CHECK="5","true"),"false"),"false")} </FC>'
                     + '<C>id=APP_S_DT        width=90 align=center edit=none        name="행사시작일"        mask="XXXX/XX/XX" </C>'
                     + '<C>id=APP_E_DT        width=90 align=center edit=Numeric     name="*행사종료일"       mask="XXXX/XX/XX" EditStyle=Popup edit={IF( SysStatus="U" OR (APP_E_DT>="'+getTodayFormat("YYYYMMDD")+'" AND CONF_YN="N" ) ,"true","false")} </C>'
                     + '<C>id=NORM_MG_RATE    width=90 align=right  edit=none        name="정상;마진율"       </C>'
                     + '<C>id=EVENT_MG_RATE   width=90 align=right  edit=RealNumeric name="*행사;마진율"      edit={IF(SysStatus="I",IF(EVENT_CHECK="0","true",IF(EVENT_CHECK="5","true","false")),IF(APP_S_DT>"'+getTodayFormat("YYYYMMDD")+'" AND CONF_YN="N",IF(EVENT_CHECK="0","true",IF(EVENT_CHECK="5","true","false")),"false"))} </C>'
                     + '<G>name="행사목표"'
                     + '<C>id=GOAL_SALE_AMT   width=90 align=right  edit=Numeric     name="매출액"            edit={IF(SysStatus="I","true",IF(APP_S_DT>"'+getTodayFormat("YYYYMMDD")+'" AND CONF_YN="N","true","false"))} </C>'
                     + '<C>id=GOAL_PROF_AMT   width=90 align=right  edit=Numeric     name="이익액"            edit={IF(SysStatus="I","true",IF(APP_S_DT>"'+getTodayFormat("YYYYMMDD")+'" AND CONF_YN="N","true","false"))} </C>'
                     + '</G>'
                     + '<C>id=LIMIT_SALE_QTY  width=90 align=right  edit=Numeric     name="한정판매;수량"      edit={IF(SysStatus="I","true",IF(APP_S_DT>"'+getTodayFormat("YYYYMMDD")+'" AND CONF_YN="N","true","false"))} </C>'
                     + '<C>id=DC_DIV_RATE     width=90 align=right  edit=none        name="당사에누리;분담율"  show="false" </C>'
                     + '<C>id=CPN_ISSUE_QTY   width=90 align=right  edit=none        name="쿠폰발행;수량"      show="false" </C>'
                     + '<C>id=CPN_BARCODE     width=90 align=center edit=none        name="쿠폰;바코드 "        show="false" </C>'
                     + '<C>id=CONF_YN         width=90 align=center edit=none        name="확정;여부"          </C>';

    initGridStyle(GD_MASTER, "common", hdrProperies, true);
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
	//
    if( LC_STR_CD.BindColVal == ""){
        // (점)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1002", "점");
        LC_STR_CD.Focus();
        return;
    }
    if( EM_EVENT_CD.Text == ""){
        // (행사코드)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", "행사코드");
        EM_EVENT_CD.Focus();
        return;
    }

    if( EM_EVENT_NAME.Text == ""){
        // 존재하지 않는 행사코드입니다.
        showMessage(EXCLAMATION, OK, "USER-1036", "행사코드");
        EM_EVENT_CD.Focus();
        return;
    }

    if( DS_MASTER.IsUpdated){
        // 변경된 상세내역이 존재합니다. 조회하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1059") != 1){
            GD_MASTER.Focus();
            return ;
        }
    }
    
    searchEvtMst();
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
	// 저장할 데이터 없는 경우
    if (!DS_MASTER.IsUpdated ){
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
        if( DS_MASTER.CountRow < 1){
            LC_STR_CD.Focus();
        }else{
            GD_MASTER.Focus();
        }
        return;
    }

    if( !checkMasterValidation())
        return;

    // 마감체크 (common.js)
    if( getCloseCheck('DS_CLOSECHECK','',getTodayFormat("YYYYMMDD"),'PCOD','03','0','T') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
        GD_MASTER.Focus();
        return;
    }
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        GD_MASTER.Focus();
        return; 
    }
    var pumbunCd = DS_MASTER.NameValue(DS_MASTER.RowPosition,"PUMBUN_CD");
    TR_MAIN.Action="/dps/pcod705.pc?goTo=save";  
    TR_MAIN.KeyValue="SERVLET(I:DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();    
    
    if(TR_MAIN.ErrorCode == 0){
        searchMaster();        
        DS_MASTER.RowPosition = DS_MASTER.NameValueRow("PUMBUN_CD",pumbunCd);
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
//
/**
 * btn_addRow()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-01-24
 * 개    요 :  행추가
 * return값 : void
 */
function btn_addRow(){
	if(DS_EVTMST.CountRow < 1){
		showMessage(INFORMATION, OK, "USER-1025");
		LC_STR_CD.Focus();
		return;		
	}
	DS_MASTER.AddRow();
	var row = DS_MASTER.CountRow;
	DS_MASTER.NameValue(row,"STR_CD")   = LC_STR_CD.BindColVal;
    DS_MASTER.NameValue(row,"EVENT_CD") = EM_EVENT_CD.Text;
    DS_MASTER.NameValue(row,"APP_S_DT") = DS_EVTMST.NameValue(DS_EVTMST.RowPosition,"EVENT_S_DT");
    DS_MASTER.NameValue(row,"APP_E_DT") = DS_EVTMST.NameValue(DS_EVTMST.RowPosition,"EVENT_E_DT");
    DS_MASTER.NameValue(row,"CONF_YN")  = "N";
    
    setFocusGrid(GD_MASTER,DS_MASTER, row, "PUMBUN_CD");
    
}
/**
 * btn_delRow()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-01-24
 * 개    요 :  행삭제
 * return값 : void
 */
function btn_delRow(){
    if(DS_MASTER.CountRow < 1){
        showMessage(INFORMATION, OK, "USER-1019");
        LC_STR_CD.Focus();
        return;     
    }
    var row  = DS_MASTER.RowPosition;
    if( DS_MASTER.NameValue(row,"APP_S_DT") <= getTodayFormat("YYYYMMDD") ){
        showMessage(INFORMATION, OK, "USER-1000", "이미 시작된 행사 입니다.");
        GD_MASTER.Focus();
        return;
    }
    if( DS_MASTER.NameValue(row,"CONF_YN") == "Y" ){
        showMessage(INFORMATION, OK, "USER-1000", "확정된 행사 입니다.");
        GD_MASTER.Focus();
        return;
    }
    DS_MASTER.DeleteRow(row);
}
/**
 * searchEvtMst()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-01-24
 * 개    요 :  행사마스터 조회
 * return값 : void
 */
function searchEvtMst(){    

	DS_MASTER.ClearData();
    DS_EVTMST.ClearData();
    var strCd = LC_STR_CD.BindColVal;
    var eventCd = EM_EVENT_CD.Text;
    var goTo       = "searchEvtmst" ;    
    var action     = "O";  
    var parameters = "&strStrCd="+encodeURIComponent(strCd)
                   + "&strEventCd="+encodeURIComponent(eventCd);
    TR_MAIN.Action="/dps/pcod705.pc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_EVTMST=DS_EVTMST)"; //조회는 O
    TR_MAIN.Post();

    enableControl(IMG_ADD_ROW,false);
    enableControl(IMG_DEL_ROW,false);
    if(DS_EVTMST.CountRow > 0){
        var eventType = DS_EVTMST.NameValue(1,"EVENT_TYPE");
        var eventSDt  = DS_EVTMST.NameValue(1,"EVENT_S_DT");
        if( eventSDt > getTodayFormat("YYYYMMDD")){
            enableControl(IMG_ADD_ROW,true);
            enableControl(IMG_DEL_ROW,true);
        }
        /*
        GD_MASTER.ColumnProp('LIMIT_SALE_QTY', 'edit') = 'none';
        GD_MASTER.ColumnProp('DC_DIV_RATE', 'edit')    = 'none';
        GD_MASTER.ColumnProp('CPN_ISSUE_QTY', 'edit')  = 'none';
        GD_MASTER.ColumnProp('CPN_BARCODE', 'edit')    = 'none';
        // 쿠폰행사 일 경우 당사에누리분담율, 쿠폰발행수량, 쿠폰바코드 입력
        if( eventType == "2"){
            GD_MASTER.ColumnProp('DC_DIV_RATE', 'edit')    = 'Numeric';
            GD_MASTER.ColumnProp('CPN_ISSUE_QTY', 'edit')  = 'Numeric';
            GD_MASTER.ColumnProp('CPN_BARCODE', 'edit')    = 'Numeric';

        // 한정행사 일 경우 한정판매수량입력   
        }else if(eventType == "3"){
            GD_MASTER.ColumnProp('LIMIT_SALE_QTY', 'edit') = 'Numeric';
            
        }
        */
    }
    //조회후 결과표시
    setPorcCount("SELECT",GD_EVTMST);  

}
/**
 * searchMaster()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  점별행사브랜드 리스트 조회
 * return값 : void
 */
function searchMaster(){

    var strCd      = LC_STR_CD.BindColVal;
    var eventCd    = EM_EVENT_CD.Text;
    var pumbunCd   = EM_PUMBUN_CD.Text;
    var pumbunName = EM_PUMBUN_NAME.Text;
    var goTo       = "searchMaster" ;    
    var action     = "O";  
    var parameters = "&strStrCd="+encodeURIComponent(strCd)
                   + "&strEventCd="+encodeURIComponent(eventCd)
                   + "&strPumbunCd="+encodeURIComponent(pumbunCd)
                   + "&strPumbunName="+encodeURIComponent(pumbunName);
    TR_MAIN.Action="/dps/pcod705.pc?goTo="+goTo+parameters;      
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();    
    
    //조회후 결과표시
    setPorcCount("SELECT",GD_MASTER);  

} 

/**
 * setEventCode()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 브랜드명을 등록한다.
 * return값 : void
 */
function setEventCode(evnflag){
    var codeObj = EM_EVENT_CD;
    var nameObj = EM_EVENT_NAME;
    var strCd = LC_STR_CD.BindColVal;

    if( DS_MASTER.IsUpdated){
        // 변경된 상세내역이 존재합니다. 행사코드을 변경하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1063","행사코드") != 1 ){
            codeObj.Text = bfEventCd;
            GD_MASTER.Focus();
            return;
        }
    }
    DS_EVTMST.ClearData();
    DS_MASTER.ClearData();
    
    if( codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
        bfEventCd = "";
        return;     
    }
    
    if( evnflag == "POP" ){
        eventPop(codeObj,nameObj,LC_STR_CD.BindColVal,'','','1');
        codeObj.Focus();
    }else if( evnflag == "NAME" ){
        setEventNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj, 1,LC_STR_CD.BindColVal,'','','1');
    }    
    bfEventCd = codeObj.Text;
}
/**
 * setPumbunCode()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 브랜드명을 등록한다.
 * return값 : void
 */
function setPumbunCode(evnflag){
    var codeObj = EM_PUMBUN_CD;
    var nameObj = EM_PUMBUN_NAME;
    var strCd = LC_STR_CD.BindColVal;
    
    if( codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
        return;     
    }

    if( strCd == ""){
        // (점)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", "점");
        LC_STR_CD.Focus();
        return;
    }

    if( evnflag == "POP" ){
        strPbnPop(codeObj,nameObj,'Y','', strCd,'','','','','','2');
        codeObj.Focus();
    }else if( evnflag == "NAME" ){
        setStrPbnNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj,"Y",0,'', strCd,'','','','','','2');
    }    
}

/**
 * setPumbunCodeToGrid()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 브랜드명을 등록한다.(Grid)
 * return값 : void
 */
function setPumbunCodeToGrid(evnflag, row){
    var code  = DS_MASTER.NameValue(row,"PUMBUN_CD");
    var strCd = DS_MASTER.NameValue(row,"STR_CD");
    if( code == "" && evnflag != "POP" ){
    	DS_MASTER.NameValue(row,"PUMBUN_NAME") = "";
        DS_MASTER.NameValue(row,"SKU_FLAG")    = "";
        DS_MASTER.NameValue(row,"EVENT_FLAG")  = "";
        DS_MASTER.NameValue(row,"EVENT_CHECK")  = ""; // MARIO OUTLET 추가 0720
        DS_MASTER.NameValue(row,"NORM_MG_RATE")= getMarginNormMgRate(row);
    	DS_EVENT_FLAG.ClearData();
        return;     
    }
    var rtnMap = null;
    if( evnflag == "POP" ){
    	rtnMap = strPbnToGridPop(code,'','Y','', strCd, '','','','','Y','2');
    }else if( evnflag == "NAME" ){
        DS_MASTER.NameValue(row,"PUMBUN_NAME") = "";
        DS_MASTER.NameValue(row,"SKU_FLAG")    = "";
        DS_MASTER.NameValue(row,"EVENT_FLAG")  = "";
        DS_MASTER.NameValue(row,"EVENT_CHECK")  = ""; // MARIO OUTLET 추가 0720
        DS_MASTER.NameValue(row,"NORM_MG_RATE")= getMarginNormMgRate(row);
        DS_EVENT_FLAG.ClearData();
        rtnMap = setStrPbnNmWithoutToGridPop("DS_SEARCH_NM",code,'',"Y",1,'', strCd, '','','','','Y','2');
    }    
    if( rtnMap != null){
    	DS_MASTER.NameValue(row,"PUMBUN_CD")   = rtnMap.get("PUMBUN_CD");
        DS_MASTER.NameValue(row,"PUMBUN_NAME") = rtnMap.get("PUMBUN_NAME");
        DS_MASTER.NameValue(row,"SKU_FLAG")    = rtnMap.get("SKU_FLAG");
        DS_MASTER.NameValue(row,"EVENT_FLAG")  = "";
        DS_MASTER.NameValue(row,"EVENT_CHECK")  = ""; // MARIO OUTLET 추가 0720
        DS_MASTER.NameValue(row,"NORM_MG_RATE")= getMarginNormMgRate(row);
        getMarginEventFlag(row);
    }else{
    	if( DS_MASTER.NameValue(row,"PUMBUN_NAME") == ""){
            DS_MASTER.NameValue(row,"PUMBUN_CD")   = "";
            DS_MASTER.NameValue(row,"SKU_FLAG")    = "";
            DS_MASTER.NameValue(row,"EVENT_FLAG")  = "";
            DS_MASTER.NameValue(row,"EVENT_CHECK")  = ""; // MARIO OUTLET 추가 0720
            DS_MASTER.NameValue(row,"NORM_MG_RATE")= getMarginNormMgRate(row);
            DS_EVENT_FLAG.ClearData();
    	}
    }
}



 /**
  * setPumbunCodeToGridMulti()
  * 작 성 자 : 
  * 작 성 일 : 2010-04-04
  * 개    요 : 브랜드명을 등록한다.(Grid, 다중)
  * return값 : void
  */
 function setPumbunCodeToGridMulti(evnflag, row){
     var code  = DS_MASTER.NameValue(row,"PUMBUN_CD");
     var strCd = DS_MASTER.NameValue(row,"STR_CD");
     if( code == "" && evnflag != "POP" ){
         DS_MASTER.NameValue(row,"PUMBUN_NAME") = "";
         DS_MASTER.NameValue(row,"SKU_FLAG")    = "";
         DS_MASTER.NameValue(row,"EVENT_FLAG")  = "";
         DS_MASTER.NameValue(row,"EVENT_CHECK")  = ""; // MARIO OUTLET 추가 0720
         DS_MASTER.NameValue(row,"NORM_MG_RATE")= getMarginNormMgRate(row);
         DS_EVENT_FLAG.ClearData();
         return;     
     }
     var rtnMap = null;
     if( evnflag == "POP" ){
         rtnMap = strPbnMultiSelPop(code,'','Y','', strCd, '','','','','Y','2');
     }else if( evnflag == "NAME" ){
         DS_MASTER.NameValue(row,"PUMBUN_NAME") = "";
         DS_MASTER.NameValue(row,"SKU_FLAG")    = "";
         DS_MASTER.NameValue(row,"EVENT_FLAG")  = "";
         DS_MASTER.NameValue(row,"EVENT_CHECK")  = ""; // MARIO OUTLET 추가 0720
         DS_MASTER.NameValue(row,"NORM_MG_RATE")= getMarginNormMgRate(row);
         DS_EVENT_FLAG.ClearData();
         rtnMap = setStrPbnNmWithoutToGridPop("DS_SEARCH_NM",code,'',"Y",1,'', strCd, '','','','','Y','2');
     }    
     if( rtnMap != null){
    	 if(evnflag == "NAME"){
             DS_MASTER.NameValue(row,"PUMBUN_CD")   = rtnMap.get("PUMBUN_CD");
             DS_MASTER.NameValue(row,"PUMBUN_NAME") = rtnMap.get("PUMBUN_NAME");
             DS_MASTER.NameValue(row,"SKU_FLAG")    = rtnMap.get("SKU_FLAG");
             DS_MASTER.NameValue(row,"EVENT_FLAG")  = "";
             DS_MASTER.NameValue(row,"EVENT_CHECK")  = ""; // MARIO OUTLET 추가 0720
             DS_MASTER.NameValue(row,"NORM_MG_RATE")= getMarginNormMgRate(row);
             getMarginEventFlag(row);
    	 }else{
    		 var total = rtnMap.length;
    		 if(total < 1){
    	         if( DS_MASTER.NameValue(row,"PUMBUN_NAME") == ""){
    	             DS_MASTER.NameValue(row,"PUMBUN_CD")   = "";
    	             DS_MASTER.NameValue(row,"SKU_FLAG")    = "";
    	             DS_MASTER.NameValue(row,"EVENT_FLAG")  = "";
    	             DS_MASTER.NameValue(row,"EVENT_CHECK")  = ""; // MARIO OUTLET 추가 0720
    	             DS_MASTER.NameValue(row,"NORM_MG_RATE")= getMarginNormMgRate(row);
    	             DS_EVENT_FLAG.ClearData();
    	         }
    	         return;
    		 }
    		 
    		 for( var i=0; i<total; i++){
    			 if( i!=0){
    				 DS_MASTER.AddRow();
    				 DS_MASTER.NameValue(row+i,"STR_CD")   = LC_STR_CD.BindColVal;
    				 DS_MASTER.NameValue(row+i,"EVENT_CD") = EM_EVENT_CD.Text;
    				 DS_MASTER.NameValue(row+i,"APP_S_DT") = DS_EVTMST.NameValue(DS_EVTMST.RowPosition,"EVENT_S_DT");
    				 DS_MASTER.NameValue(row+i,"APP_E_DT") = DS_EVTMST.NameValue(DS_EVTMST.RowPosition,"EVENT_E_DT");
    				 DS_MASTER.NameValue(row+i,"CONF_YN")  = "N";
    			 }
                 DS_MASTER.NameValue(row+i,"PUMBUN_CD")   = rtnMap[i].PUMBUN_CD;
                 DS_MASTER.NameValue(row+i,"PUMBUN_NAME") = rtnMap[i].PUMBUN_NAME;
                 DS_MASTER.NameValue(row+i,"SKU_FLAG")    = rtnMap[i].SKU_FLAG;
                 DS_MASTER.NameValue(row+i,"EVENT_FLAG")  = "";
                 DS_MASTER.NameValue(row+i,"NORM_MG_RATE")= getMarginNormMgRate(row);
    		 }
    	 }
     }else{
         if( DS_MASTER.NameValue(row,"PUMBUN_NAME") == ""){
             DS_MASTER.NameValue(row,"PUMBUN_CD")   = "";
             DS_MASTER.NameValue(row,"SKU_FLAG")    = "";
             DS_MASTER.NameValue(row,"EVENT_FLAG")  = "";
             DS_MASTER.NameValue(row,"EVENT_CHECK")  = ""; // MARIO OUTLET 추가 0720
             DS_MASTER.NameValue(row,"NORM_MG_RATE")= getMarginNormMgRate(row);
             DS_EVENT_FLAG.ClearData();
         }
     }
 }

/**
 * getMarginEventFlag()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 마진마스터에서 행사구분 리스트를 조회한다.(Popup.js) 
 * return값 : void
 */
function getMarginEventFlag(row){
	var strCd    = DS_MASTER.NameValue(row,"STR_CD");
    var pumbunCd = DS_MASTER.NameValue(row,"PUMBUN_CD");

    if( strCd == ""){
        // (점)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", "점");
        LC_STR_CD.Focus();
        return;        
    }
    if( pumbunCd == ""){
        // (브랜드)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", "브랜드");
        setFocusGrid(GD_MASTER,DS_MASTER,row,"PUMBUN_CD");
        return;
    }
    
    setDataSet("DS_EVENT_FLAG","SEL_MARGINMST_EVENT_FLAG", strCd, pumbunCd);
}
/**
 * getMarginNormMgRate()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 마진마스터에서 정상마진율을 조회한다.(Popup.js) 
 * return값 : void
 */
function getMarginNormMgRate(row){
	
    var strCd     = DS_MASTER.NameValue(row,"STR_CD");
    var pumbunCd  = DS_MASTER.NameValue(row,"PUMBUN_CD");
    var eventFlag = DS_MASTER.NameValue(row,"EVENT_FLAG");
    var appSDt    = DS_MASTER.NameValue(row,"APP_S_DT");
    // GridID.ColumnProp("Vendor","Edit")="None";
    // MARIO OUTLET 추가 0720
    
    DS_MASTER.NameValue(row,"EVENT_CHECK") = "";
    for(var i = 0;i<=DS_EVENT_FLAG.CountRow;i++)
    {
    	
    	if(DS_EVENT_FLAG.NameValue(i,"COL1") == eventFlag) {
    		DS_MASTER.NameValue(row,"EVENT_CHECK") = DS_EVENT_FLAG.NameValue(i,"COL2");
    	}
    }
	
    DS_MASTER.NameValue(row,"EVENT_RATE") = "";
    
    if(DS_MASTER.NameValue(row,"EVENT_CHECK").length > 0) {
	    if(DS_MASTER.NameValue(row,"EVENT_CHECK") != "0") {
	    	if(DS_MASTER.NameValue(row,"EVENT_CHECK") != "5") {
	    		
	    		DS_MASTER.NameValue(row,"EVENT_RATE") = "00";	
	    	}
	    } 
    }
    //
    
    DS_MASTER.NameValue(row,"NORM_MG_RATE_YN")         = "N";
    if( strCd == "" 
    	|| pumbunCd == ""
    	|| eventFlag == ""
        || appSDt == ""){
        return 0;        
    }
    
    setDataSet("DS_SEARCH_NM","SEL_MARGINMST_NORM_MG_RATE", strCd, pumbunCd, eventFlag, appSDt);
    if( DS_SEARCH_NM.CountRow == 1){
        DS_MASTER.NameValue(row,"NORM_MG_RATE_YN")         = "Y";
        
        if(DS_MASTER.NameValue(row,"EVENT_CHECK") != "0") {
        	if(DS_MASTER.NameValue(row,"EVENT_CHECK") != "5") {
        		DS_MASTER.NameValue(row,"EVENT_MG_RATE") = DS_SEARCH_NM.NameValue(1,"COL1"); // MARIO OUTLET 추가 0720
        	}
        }
        
        return DS_SEARCH_NM.NameValue(1,"COL1");
    }

    showMessage(EXCLAMATION, OK, "USER-1000", "정상마진율이 존재하지 않습니다.");
    return '';
}

/**
 * checkMasterValidation()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 입력 값을 검증한다.
 * return값 : void
 */
function checkMasterValidation(){
	var row;
	var colid;
	var errYn = false;
	
	for(var i=1; i<=DS_MASTER.CountRow; i++){
		var rowStatus = DS_MASTER.RowStatus(i);
		if( !(rowStatus == "1" || rowStatus == "3") )
			continue;
		row = i;
		if( DS_MASTER.NameValue(i,"PUMBUN_CD")==""){
		    showMessage(EXCLAMATION, OK, "USER-1003", "브랜드코드");
		    errYn = true;
		    colid = "PUMBUN_CD";
		    break;
		}
        if( DS_MASTER.NameValue(i,"PUMBUN_NAME")==""){
            showMessage(EXCLAMATION, OK, "USER-1036", "브랜드코드");
            errYn = true;
            colid = "PUMBUN_CD";
            break;
        }
        if( DS_MASTER.NameValue(i,"EVENT_FLAG")==""){
            showMessage(EXCLAMATION, OK, "USER-1002", "행사구분");
            errYn = true;
            colid = "EVENT_FLAG";
            break;
        }
        if( DS_MASTER.NameValue(i,"NORM_MG_RATE_YN")=="N"){
            showMessage(EXCLAMATION, OK, "USER-1000", "정상마진율이 존재하지 않습니다.");
            errYn = true;
            colid = "EVENT_FLAG";
            break;
        }
        if( DS_MASTER.NameValue(i,"EVENT_RATE")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "행사율");
            errYn = true;
            colid = "EVENT_RATE";
            break;
        }
        if( DS_MASTER.NameValue(i,"APP_E_DT")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "행사종료일");
            errYn = true;
            colid = "APP_E_DT";
            break;
        }
        if( DS_MASTER.NameValue(i,"APP_E_DT") < getTodayFormat("YYYYMMDD")){
            showMessage(EXCLAMATION, OK, "USER-1030", "행사종료일");
            errYn = true;
            colid = "APP_E_DT";
            break;
        }
        if( DS_MASTER.NameValue(i,"APP_E_DT")< DS_MASTER.NameValue(i,"APP_S_DT")){
            showMessage(EXCLAMATION, OK, "USER-1020", "행사종료일", "행사시작일");
            errYn = true;
            colid = "APP_E_DT";
            break;
        }
        if( Number(DS_MASTER.NameValue(i,"EVENT_MG_RATE"))<=0){
	        if(showMessage(QUESTION, YESNO, "USER-1000","행사마진율이 0입니다. 등록하시겠습니까?") != "1") {
	            errYn = true;
	            colid = "EVENT_MG_RATE";
	            break;
	        }
        }
        if( Number(DS_MASTER.NameValue(i,"EVENT_MG_RATE"))>100){
            showMessage(EXCLAMATION, OK, "USER-1021", "행사마진율", 100);
            errYn = true;
            colid = "EVENT_MG_RATE";
            break;
        }
        if(checkDupDtPbnCD(i)){
            showMessage(EXCLAMATION, OK, "USER-1000", "브랜드의 행사구분에 중복되는 기간이 존재합니다.");
            errYn = true;
            colid = "PUMBUN_CD";
            break;
        }
        
	}
	
	if(errYn){
		setFocusGrid(GD_MASTER,DS_MASTER,row,colid);
		return false;
	}
	return true;
}


/**
 * checkDupDtPbnCD()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 브랜드의 기간을 중복을 체크한다.
 * return값 : void
 */
function checkDupDtPbnCD(row){
	var pumbunCd  = DS_MASTER.NameValue(row,"PUMBUN_CD");
    var eventFlag = DS_MASTER.NameValue(row,"EVENT_FLAG");
    var eventRate = DS_MASTER.NameValue(row,"EVENT_RATE");
    var evtSDt    = DS_MASTER.NameValue(row,"APP_S_DT");
    var evtEDt    = DS_MASTER.NameValue(row,"APP_E_DT");
    for( var i=1; i<=DS_MASTER.CountRow; i++ ){
    	if(i==row)
    		continue;
    	if( DS_MASTER.NameValue(i,"PUMBUN_CD") == pumbunCd
    		&& DS_MASTER.NameValue(i,"EVENT_FLAG") == eventFlag
            && DS_MASTER.NameValue(i,"EVENT_RATE") == eventRate
    		&& ((DS_MASTER.NameValue(i,"APP_S_DT") <= evtSDt
            && DS_MASTER.NameValue(i,"APP_E_DT") >= evtSDt)
            || (DS_MASTER.NameValue(i,"APP_S_DT") <= evtEDt
            && DS_MASTER.NameValue(i,"APP_E_DT") >= evtEDt)))
    		return true;
    }
    return false;
	
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

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
    
    if(DS_MASTER.RowStatus(row)==1 && DS_MASTER.NameValue(row,"PUMBUN_CD") !="")
        getMarginEventFlag(row);
</script>
<script language=JavaScript for=GD_MASTER event=OnRowPosChanged(row)>

if(DS_MASTER.NameValue(row,"PUMBUN_CD")!="")
    getMarginEventFlag(row);
</script>
<!-- 팝업  -->
<script language=JavaScript for=GD_MASTER event=OnPopup(row,colid,data)>
    if(row < 1){
    	return;
    }
    onPopup = true;
    switch(colid){
        case 'PUMBUN_CD':
        	setPumbunCodeToGridMulti('POP', row);
        	break;
        case 'APP_E_DT':
            var eventEDt = DS_EVTMST.NameValue(DS_EVTMST.RowPosition,"EVENT_E_DT");
            openCal(GD_MASTER,row,colid);
            if( DS_MASTER.NameValue(row,"APP_E_DT") < getTodayFormat("YYYYMMDD")){
                showMessage(EXCLAMATION, OK, "USER-1030", "행사종료일");
                if(DS_MASTER.RowStatus(row)=="1"){
                    DS_MASTER.NameValue(row,"APP_E_DT")  = eventEDt;
                }else{
                    DS_MASTER.NameValue(row,"APP_E_DT")  = DS_MASTER.OrgNameValue(row,"APP_E_DT");                                
                }
                setTimeout("setFocusGrid(GD_MASTER,DS_MASTER,"+row+",'APP_E_DT');",50);
            }
            break;
    
    }
    onPopup = false;
</script>
<script language=JavaScript for=GD_MASTER event=OnExit(row,colid,olddata)>
    if(row < 1 || onPopup){
        return;
    }
    var value = DS_MASTER.NameValue(row,colid);
    if( value == olddata)
    	return;
    
    switch(colid){
        case 'PUMBUN_CD':
            setPumbunCodeToGrid('NAME', row);
            break;
        case 'APP_E_DT':
        	var eventEDt = DS_EVTMST.NameValue(DS_EVTMST.RowPosition,"EVENT_E_DT");
            if(!checkDateTypeYMD(GD_MASTER,colid,eventEDt))
                return;
            if( DS_MASTER.NameValue(row,"APP_E_DT") < getTodayFormat("YYYYMMDD")){
                showMessage(EXCLAMATION, OK, "USER-1030", "행사종료일");
                if(DS_MASTER.RowStatus(row)=="1"){
                    DS_MASTER.NameValue(row,"APP_E_DT")  = eventEDt;
                }else{
                    DS_MASTER.NameValue(row,"APP_E_DT")  = DS_MASTER.OrgNameValue(row,"APP_E_DT");                                
                }
                setTimeout("setFocusGrid(GD_MASTER,DS_MASTER,"+row+",'APP_E_DT');",50);
                return;
            }
            break;
    
    }
</script> 
 
<script language=JavaScript for=GD_MASTER event=OnListSelect(index)>
    DS_MASTER.NameValue(DS_MASTER.RowPosition,"NORM_MG_RATE")= getMarginNormMgRate(DS_MASTER.RowPosition);
</script>
 

<!-- 행사코드(조회) -->
<script language=JavaScript for=EM_EVENT_CD event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setEventCode('NAME');
</script> 
 
<!-- 브랜드(조회) -->
<script language=JavaScript for=EM_PUMBUN_CD event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setPumbunCode('NAME');
</script> 
 
<!-- 점 (조회) -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
    if( bfStrCd != this.BindColVal){
        if( DS_MASTER.IsUpdated ){
            // 변경된 상세내역이 존재합니다. 점을 변경하시겠습니까?
            if( showMessage(QUESTION, YESNO, "USER-1063","점") != 1 ){
                setComboData(LC_STR_CD,bfStrCd);
                GD_MASTER.Focus();
                return;
            }
        }
        DS_EVTMST.ClearData();
        DS_MASTER.ClearData();
    }
    bfStrCd = this.BindColVal;
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
<comment id="_NSID_"><object id="DS_STR_CD"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_EVENT_FLAG"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSECHECK"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_MASTER"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_EVTMST"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
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
            <th width="60" class="point">점</th>
            <td width="140">
              <comment id="_NSID_">
                <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1  align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="60" class="point">행사코드</th>
            <td width="220">
              <comment id="_NSID_">
                <object id=EM_EVENT_CD classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" onclick="javascript:setEventCode('POP');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_EVENT_NAME classid=<%=Util.CLSID_EMEDIT%> width=109 tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
            <th width="60" >브랜드</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" onclick="javascript:setPumbunCode('POP');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1 align="absmiddle"></object>
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
  <tr>
    <td  class="PT01 PB03">
      <table width="100%" border="0" cellspacing="0" cellpadding="0" >
        <tr>
          <td width="100%" >
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
              <tr>
                <td width="100%" >
                  <comment id="_NSID_"><object id=GD_EVTMST width="100%" height=85 classid=<%=Util.CLSID_GRID%>>
                    <param name="DataID" value="DS_EVTMST">
                  </object></comment><script>_ws_(_NSID_);</script>
                </td>
              </tr>
            </table>
          </td>  
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" >
        <tr>
          <td class="right PT03 " ><img 
          src="/<%=dir%>/imgs/btn/add_row.gif" id=IMG_ADD_ROW onClick="javascript:btn_addRow();" hspace="2" /><img 
          src="/<%=dir%>/imgs/btn/del_row.gif" id=IMG_DEL_ROW onClick="javascript:btn_delRow();"  />
          </td>
        </tr>
        <tr>
          <td >
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
              <tr>
                <td>
                  <comment id="_NSID_"><object id=GD_MASTER width="100%" height=388 classid=<%=Util.CLSID_GRID%>>
                    <param name="DataID" value="DS_MASTER">
                  </object></comment><script>_ws_(_NSID_);</script>
                </td>
              </tr>
            </table>
          </td >
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

