<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > 행사코드> 행사코드관리
 * 작 성 일 : 2010.01.18
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod7030.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 행사정보를 관리한다
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
var isLoading = false;
var isOnPopup = false;
var btnSaveClick = false;
var checkValidation = false;
var bfEventYm = getTodayFormat("YYYYMM");
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
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');
    DS_IO_EVENT_PLACE.setDataHeader('<gauce:dataset name="H_SEL_EVENT_PLACE"/>');
    DS_IO_EVENT_POS.setDataHeader('<gauce:dataset name="H_SEL_POS_NO"/>');
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //행사일
    gridCreate3(); //행사장 
    gridCreate4(); //POS번호

    // EMedit에 초기화
    initEmEdit(EM_EVENT_YM     , "YYYYMM"   , PK);  //행사년월
    initEmEdit(EM_EVENT_CD     , "CODE^11"  , NORMAL);  //행사코드
    initEmEdit(EM_EVENT_NAME   , "GEN^40"   , NORMAL);  //행사명

    //콤보 초기화
    initComboStyle(LC_O_EVENT_TYPE    , DS_O_EVENT_TYPE    , "CODE^0^30,NAME^0^80", 1, NORMAL);  //행사종류(조회)
    initComboStyle(LC_O_EVENT_MNG_FLAG, DS_O_EVENT_MNG_FLAG, "CODE^0^30,NAME^0^80", 1, NORMAL);  //행사주관구분(조회)
    initComboStyle(LC_O_EVENT_L_CD    , DS_O_EVENT_L_CD    , "CODE^0^30,NAME^0^80", 1, NORMAL);  //행사테마(대)(조회)
    initComboStyle(LC_O_EVENT_M_CD    , DS_O_EVENT_M_CD    , "CODE^0^30,NAME^0^80", 1, NORMAL);  //행사테마(중)(조회)
    initComboStyle(LC_O_EVENT_S_CD    , DS_O_EVENT_S_CD    , "CODE^0^30,NAME^0^80", 1, NORMAL);  //행사테마(소)(조회)
    
  //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_O_EVENT_TYPE", "D", "P072", "Y");
    getEtcCode("DS_O_EVENT_MNG_FLAG", "D", "P073", "Y");
    
    getEtcCode("DS_I_EVENT_TYPE", "D", "P072", "N");
    getEtcCode("DS_I_EVENT_PLU_FLAG", "D", "P071", "N");
    getEtcCode("DS_I_EVENT_MNG_FLAG", "D", "P073", "N");   

    //행사테마 대분류 가지고 오기( popup_dps.js )
    getEvtThmeLCode("DS_O_EVENT_L_CD", "Y");
    getEventPlaceCode("DS_I_EVENT_PLACE_CD","","N","Y");
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_O_EVENT_TYPE,"%");
    setComboData(LC_O_EVENT_MNG_FLAG,"%");
    setComboData(LC_O_EVENT_L_CD,"%");

    // 필터 적용여부
    DS_IO_EVENT_PLACE.UseFilter = true;
    DS_IO_EVENT_POS.UseFilter = true;
    DS_I_EVENT_PLACE_CD.UseFilter = true;
    // 삭제된 로우 표시여부
    //DS_IO_MASTER.ViewDeletedRow = true;
    //DS_IO_EVENT_PLACE.ViewDeletedRow = true;
    //DS_IO_EVENT_POS.ViewDeletedRow = true;
    
    // 행사년월 기본값
    EM_EVENT_YM.Text = getTodayFormat("YYYYMM");

    detailEnable(false);
    
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pcod703","DS_IO_MASTER,DS_IO_DETAIL,DS_IO_EVENT_PLACE,DS_IO_EVENT_POS" );
    EM_EVENT_YM.Focus();
}

function gridCreate1(){
	var editFlagStr =  'IF(DTLCNT=0 AND (SysStatus="I" OR SysStatus="U" OR EVENT_S_DT >"'+getTodayFormat("YYYYMMDD")+'"),"true","false")';
    var hdrProperies = '<FC>id={currow}        width=30   align=center  edit=none     name="NO"    </FC>'
                     + '<FG>name="*행사테마"'
    	             + '<FC>id=EVENT_THME_CD   width=55   align=center  edit=AlphaNum name="코드"        EditStyle=Popup  edit={IF(SysStatus="I","true","false")}</FC>'
                     + '<FC>id=EVENT_THME_NAME width=110   align=left    edit=none     name="명"          < /FC>'
                     + '</FG>'
                     + '<FC>id=EVENT_CD        width=110   align=center  edit=none     name="행사코드"     </FC>'
                     + '<FC>id=EVENT_NAME      width=150  align=left                  name="*행사명"       edit={'+editFlagStr+'}</FC>'
                     + '<FC>id=EVENT_S_DT      width=85   align=center  edit=Numeric  name="*행사시작일"   mask="XXXX/XX/XX" EditStyle=Popup  edit={'+editFlagStr+'}</FC>'
                     + '<FC>id=EVENT_E_DT      width=85   align=center  edit=Numeric  name="*행사종료일"   mask="XXXX/XX/XX" EditStyle=Popup  edit={'+editFlagStr+'}</FC>'                     
                     + '<FC>id=EVENT_TYPE      width=85   align=left                  name="*행사종류"     EditStyle=Lookup   Data="DS_I_EVENT_TYPE:CODE:NAME" edit={'+editFlagStr+'}</FC>'
                     + '<FC>id=EVENT_PLU_FLAG  width=100   align=left                  name="*행사유형"     EditStyle=Lookup   Data="DS_I_EVENT_PLU_FLAG:CODE:NAME" edit={'+editFlagStr+'}</FC>'
                     + '<FC>id=EVENT_MNG_FLAG  width=85   align=left                  name="*행사주관구분" EditStyle=Lookup   Data="DS_I_EVENT_MNG_FLAG:CODE:NAME" edit={'+editFlagStr+'}</FC>'
                     + '<FC>id=EVENT_ORG_CD    width=100  align=center  edit=AlphaNum name="*주관조직"     EditStyle=Popup  edit={'+editFlagStr+'}</FC>'
                     + '<FC>id=EVENT_ORG_NAME  width=100  align=left    edit=none     name="주관조직명"    </FC>'
                     + '<FC>id=EVENT_CHAR_ID   width=100  align=center  edit=AlphaNum name="*담당자"       EditStyle=Popup  edit={'+editFlagStr+'}</FC>'
                     + '<FC>id=EVENT_CHAR_NAME width=100  align=left    edit=none     name="담당자명"      </FC>'
                     + '<FC>id=BIGO            width=200  align=left    edit=none     name="행사내용"     Edit=true </FC>';
;
 
    initGridStyle(GD_MASTER, "common", hdrProperies, true);
}
function gridCreate2(){
    var hdrProperies = '<FC>id={currow}     width=30  align=center  edit=none     name="NO"    </FC>'
                     + '<FC>id=SEL          width=60  align=center                name="선택"         EditStyle=CheckBox  edit={IF( MOD_YN = "Y" AND ORG_EVENT_S_DT >"'+getTodayFormat("YYYYMMDD")+'","true","false")}</FC>'
                     + '<FC>id=STR_NAME     width=95  align=left    edit=none     name="*점"          </FC>'
                     + '<FC>id=EVENT_S_DT   width=90  align=center  edit=Numeric  name="*행사시작일"  mask="XXXX/XX/XX" EditStyle=Popup edit={IF( SEL="T" AND DTLCNT = "0" AND MOD_YN = "Y" AND ORG_EVENT_S_DT >"'+getTodayFormat("YYYYMMDD")+'" ,"true","false")} </FC>'
                     + '<FC>id=EVENT_E_DT   width=90  align=center  edit=Numeric  name="*행사종료일"  mask="XXXX/XX/XX" EditStyle=Popup edit={IF( SEL="T" AND MOD_YN = "Y","true","false")}</FC>';

    initGridStyle(GD_DETAIL, "common", hdrProperies, true);
}
function gridCreate3(){
    var hdrProperies = '<FC>id=EVENT_PLACE_CD width=124   align=center    name="*행사장 "  EditStyle=Lookup   Data="DS_I_EVENT_PLACE_CD:CODE:NAME" </FC>';

    initGridStyle(GD_EVENT_PLACE, "common", hdrProperies, true);
}

function gridCreate4(){
    var hdrProperies = '<FC>id=POS_NO   width=100  align=center  name="*POS번호 "   EditStyle=Popup  </FC>'
                     + '<FC>id=SPS_YN   width=88   align=center  name="*특판여부 "  EditStyle=Combo  data="Y:YES,N:NO"</FC>';

    initGridStyle(GD_EVENT_POS, "common", hdrProperies, true);
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
	var clearYn = false;
	if( DS_IO_MASTER.IsUpdated ){
		if( DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition) == '1'){
			if(showMessage(QUESTION, YESNO, "USER-1051")!=1){
				GD_MASTER.Focus();
				return;
			}
		}else{
            if(showMessage(QUESTION, YESNO, "USER-1050")!=1){
                GD_MASTER.Focus();
                return;
            }			
		}
		DS_IO_MASTER.UndoAll();
		clearYn = true;
	}
	if( DS_IO_DETAIL.IsUpdated || DS_IO_EVENT_PLACE.IsUpdated || DS_IO_EVENT_POS.IsUpdated ){
		if( !clearYn){
            if(showMessage(QUESTION, YESNO, "USER-1050")!=1){
            	if(DS_IO_DETAIL.IsUpdated ){
                    GD_DETAIL.Focus();
            	}else if( DS_IO_EVENT_PLACE.IsUpdated){
                    GD_EVENT_PLACE.Focus();
            	}else if( DS_IO_EVENT_POS.IsUpdated){
                    GD_EVENT_POS.Focus();
            	}
                return;
            }
		}
	}
	DS_IO_DETAIL.ClearData();
	DS_IO_EVENT_PLACE.ClearData();
	DS_IO_EVENT_POS.ClearData();
	DS_IO_MASTER.AddRow();
	DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow,"EVENT_S_DT") = addDate("D",1,getTodayFormat("YYYYMMDD"),"");
	DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow,"EVENT_YM") = addDate("D",1,getTodayFormat("YYYYMMDD"),"").substring(0,6);
	
	setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.CountRow,"EVENT_THME_CD");
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {

    // 삭제할 데이터 없는 경우
    if ( DS_IO_MASTER.CountRow < 1){
        //삭제할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1019");
        EM_EVENT_YM.Focus();
        return;
    }
    
    if( DS_IO_DETAIL.IsUpdated || DS_IO_EVENT_PLACE.IsUpdated || DS_IO_EVENT_POS.IsUpdated ){
        showMessage(INFORMATION , OK, "USER-1091");
        GD_DETAIL.Focus();
        return;
    }
    var row = DS_IO_MASTER.RowPosition;
    if( DS_IO_MASTER.NameValue(row,"EVENT_S_DT") < addDate("D",1,getTodayFormat("YYYYMMDD"),"")){
        showMessage(INFORMATION , OK, "USER-1000","시작된 행사를 삭제 할 수 없습니다.");
        GD_MASTER.Focus();
        return;    	
    }
    if( DS_IO_MASTER.NameValue(row,"DTLCNT") > 0 ){
        showMessage(INFORMATION , OK, "USER-1000","행사에 등록된 단품 또는 브랜드이 존재합니다.");
        GD_MASTER.Focus();
        return;     
    }
    var selCnt = getNameValueCount(DS_IO_DETAIL,"SEL","T");
    if( selCnt > 0 ){
        showMessage(INFORMATION , OK, "USER-1000","행사에 등록된 점이 존재합니다.");
        GD_MASTER.Focus();
        return;     
    }
    //선택한 항목을 삭제하겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1023") != 1 ){
        GD_MASTER.Focus();
        return; 
    }
    
    var rowStatus = DS_IO_MASTER.RowStatus(row);
    DS_IO_DETAIL.ClearData();
    DS_IO_MASTER.DeleteRow(row);
    if( rowStatus == "1")
    	return;
    
    btnSaveClick = true;
    TR_MAIN.Action="/dps/pcod703.pc?goTo=delete";  
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();    
    btnSaveClick = false;
    if(TR_MAIN.ErrorCode == 0){
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
    if (!DS_IO_MASTER.IsUpdated && !DS_IO_DETAIL.IsUpdated && !DS_IO_EVENT_PLACE.IsUpdated && !DS_IO_EVENT_POS.IsUpdated ){
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
        if( DS_IO_MASTER.CountRow < 1){
        	EM_EVENT_YM.Focus();
        }else{
            GD_MASTER.Focus();
        }
        return;
    }

    if( !checkMasterValidation())
        return;
    if( !checkDetailValidation())
        return;
    if( !checkEventPlaceValidation())
        return;
    if( !checkEventPosValidation())
        return;

    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
    	GD_MASTER.Focus();
        return; 
    }
    var eventCd = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"EVENT_CD");
    var eventName = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"EVENT_NAME");
    btnSaveClick = true;
    TR_MAIN.Action="/dps/pcod703.pc?goTo=save";  
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER,I:DS_IO_DETAIL=DS_IO_DETAIL,I:DS_IO_EVENT_PLACE=DS_IO_EVENT_PLACE,I:DS_IO_EVENT_POS=DS_IO_EVENT_POS)"; //조회는 O
    TR_MAIN.Post();    
    btnSaveClick = false;
    if(TR_MAIN.ErrorCode == 0){
    	searchMaster();
    	if(eventCd != ""){
    		DS_IO_MASTER.RowPosition = DS_IO_MASTER.NameValueRow("EVENT_CD",eventCd);
    	}else{
            DS_IO_MASTER.RowPosition = DS_IO_MASTER.NameValueRow("EVENT_NAME",eventName);
    	}
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
 * btn_addRow1()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  행사장 추가
 * return값 : void
 */
function btn_addRow1(){
    var ckeckYn = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SEL");
    var eventEDt = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "EVENT_E_DT");
    if(ckeckYn == "F"){
        showMessage(INFORMATION, OK, "USER-1000", "점의 선택을 체크 후 추가 가능 합니다.");
        GD_DETAIL.Focus();
    	return;
    }
    if( eventEDt < getTodayFormat("YYYYMMDD") ){
        showMessage(INFORMATION, OK, "USER-1000", "이미 종료된 행사 입니다.");
        GD_DETAIL.Focus();
        return;
    }
    DS_IO_EVENT_PLACE.AddRow();
    DS_IO_EVENT_PLACE.NameValue(DS_IO_EVENT_PLACE.CountRow,"STR_CD") = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "STR_CD");
    DS_IO_EVENT_PLACE.NameValue(DS_IO_EVENT_PLACE.CountRow,"EVENT_CD") = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "EVENT_CD");
}
/**
 * btn_delRow1()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  행사장 삭제
 * return값 : void
 */
function btn_delRow1(){
    if(DS_IO_EVENT_PLACE.CountRow < 1){
        showMessage(INFORMATION, OK, "USER-1019");
        GD_EVENT_PLACE.Focus();
        return;     
    }
	var eventSDt = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "EVENT_S_DT");
    var eventEDt = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "EVENT_E_DT");
    var ckeckYn = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SEL");
    if(ckeckYn == "F"){
        showMessage(INFORMATION, OK, "USER-1000", "점의 선택을 체크 후 삭제 가능 합니다.");
        GD_DETAIL.Focus();
        return;
    }
    if( eventEDt < getTodayFormat("YYYYMMDD") ){
        showMessage(INFORMATION, OK, "USER-1000", "이미 종료된 행사 입니다.");
        GD_DETAIL.Focus();
        return;
    }
    if( eventSDt <= getTodayFormat("YYYYMMDD") && DS_IO_EVENT_PLACE.RowStatus(DS_IO_EVENT_PLACE.RowPosition) !="1"){
        showMessage(INFORMATION, OK, "USER-1000", "이미 시작된 행사의 행사장은 삭제할수 없습니다.");
        GD_DETAIL.Focus();
        return;
    }
    DS_IO_EVENT_PLACE.DeleteRow(DS_IO_EVENT_PLACE.RowPosition);
}
/**
 * btn_addRow2()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  POS 추가
 * return값 : void
 */
function btn_addRow2(){

    var ckeckYn = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SEL");
    var eventEDt = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "EVENT_E_DT");
    if(ckeckYn == "F"){
        showMessage(INFORMATION, OK, "USER-1000", "점의 선택을 체크 후 추가 가능 합니다.");
        GD_DETAIL.Focus();
        return;
    }
    if( eventEDt < getTodayFormat("YYYYMMDD") ){
        showMessage(INFORMATION, OK, "USER-1000", "이미 종료된 행사 입니다.");
        GD_DETAIL.Focus();
        return;
    }
    DS_IO_EVENT_POS.AddRow();
    DS_IO_EVENT_POS.NameValue(DS_IO_EVENT_POS.CountRow,"STR_CD") = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "STR_CD");
    DS_IO_EVENT_POS.NameValue(DS_IO_EVENT_POS.CountRow,"EVENT_CD") = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "EVENT_CD");
    DS_IO_EVENT_POS.NameValue(DS_IO_EVENT_POS.CountRow,"SPS_YN") = "N";
}
/**
 * btn_delRow2()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  POS 삭제
 * return값 : void
 */
function btn_delRow2(){
	if(DS_IO_EVENT_POS.CountRow < 1){
        showMessage(INFORMATION, OK, "USER-1019");
        GD_EVENT_POS.Focus();
        return;		
	}
    var eventSDt = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "EVENT_S_DT");
    var eventEDt = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "EVENT_E_DT");
    var ckeckYn = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SEL");
    if(ckeckYn == "F"){
        showMessage(INFORMATION, OK, "USER-1000", "점의 선택을 체크 후 삭제 가능 합니다.");
        GD_DETAIL.Focus();
        return;
    }
    if( eventEDt < getTodayFormat("YYYYMMDD") ){
        showMessage(INFORMATION, OK, "USER-1000", "이미 종료된 행사 입니다.");
        GD_DETAIL.Focus();
        return;
    }
    if( eventSDt <= getTodayFormat("YYYYMMDD") && DS_IO_EVENT_POS.RowStatus(DS_IO_EVENT_POS.RowPosition) !="1"){
        showMessage(INFORMATION, OK, "USER-1000", "이미 시작된 행사의 POS는 삭제할수 없습니다.");
        GD_DETAIL.Focus();
        return;
    }
    DS_IO_EVENT_POS.DeleteRow(DS_IO_EVENT_POS.RowPosition);
}
/**
 * searchMaster()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  마스터 리스트 조회
 * return값 : void
 */
function searchMaster(){
	
    if( EM_EVENT_YM.Text == '') {
        showMessage(INFORMATION, OK, "USER-1001", "행사년월");
        EM_EVENT_YM.Focus();
        return;
    }
    
    if( DS_IO_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated || DS_IO_EVENT_PLACE.IsUpdated || DS_IO_EVENT_POS.IsUpdated ){
        if(showMessage(QUESTION, YESNO, "USER-1059")!=1){
            GD_MASTER.Focus();
            return ;
        }
    }
    
    DS_IO_MASTER.ClearData();    
    DS_IO_DETAIL.ClearData(); 
    DS_IO_EVENT_PLACE.ClearData(); 
    DS_IO_EVENT_POS.ClearData();  
    var strEventYm      = EM_EVENT_YM.Text;
    var strEventType    = LC_O_EVENT_TYPE.BindColVal;
    var strEventMngFlag = LC_O_EVENT_MNG_FLAG.BindColVal;
    var strEventLCd     = LC_O_EVENT_L_CD.BindColVal;
    var strEventMCd     = LC_O_EVENT_M_CD.BindColVal;
    var strEventSCd     = LC_O_EVENT_S_CD.BindColVal;
    var strEventCd      = EM_EVENT_CD.Text;
    var strEventName    = EM_EVENT_NAME.Text;
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strEventYm="+encodeURIComponent(strEventYm)
                   + "&strEventType="+encodeURIComponent(strEventType)
                   + "&strEventMngFlag="+encodeURIComponent(strEventMngFlag)
                   + "&strEventLCd="+encodeURIComponent(strEventLCd)
                   + "&strEventMCd="+encodeURIComponent(strEventMCd)
                   + "&strEventSCd="+encodeURIComponent(strEventSCd)
                   + "&strEventCd="+encodeURIComponent(strEventCd)
                   + "&strEventName="+encodeURIComponent(strEventName);    
    isLoading = true;
    TR_MAIN.Action="/dps/pcod703.pc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();    

    //조회후 결과표시
    setPorcCount("SELECT",GD_MASTER);  

} 

/**
 * searchDetial()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-01-24
 * 개    요 :  디테일 리스트 조회
 * return값 : void
 */
function searchDetail(){
	    
	DS_IO_DETAIL.ClearData();  

	var goTo       = "searchDetail" ;    
	var action     = "O";  
    var strEventCd = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"EVENT_CD");
    var parameters = "&strEventCd="+encodeURIComponent(strEventCd);

    TR_SUB.Action="/dps/pcod703.pc?goTo="+goTo+parameters;  
    TR_SUB.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_SUB.Post();
    //조회후 결과표시
    setPorcCount("SELECT",GD_DETAIL);  

   

}

/**
 * searchEventPlace()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-01-24
 * 개    요 :  행사장 리스트 조회
 * return값 : void
 */
function searchEventPlace(){
        
	 DS_IO_EVENT_PLACE.ClearData();  

    var goTo       = "searchEvtPlac" ;    
    var action     = "O";  
    var strEventCd = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"EVENT_CD");
    var parameters = "&strEventCd="+encodeURIComponent(strEventCd);

    TR_SUB.Action="/dps/pcod703.pc?goTo="+goTo+parameters;  
    TR_SUB.KeyValue="SERVLET("+action+":DS_IO_EVENT_PLACE=DS_IO_EVENT_PLACE)"; //조회는 O
    TR_SUB.Post();
    //조회후 결과표시
    //setPorcCount("SELECT",GD_EVENT_PLACE);  

}

/**
 * searchPos()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-01-24
 * 개    요 :  포스 리스트 조회
 * return값 : void
 */
function searchPos(){
        
    DS_IO_EVENT_POS.ClearData();  

    var goTo       = "searchEvtPos" ;    
    var action     = "O";  
    var strEventCd = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"EVENT_CD");
    var parameters = "&strEventCd="+encodeURIComponent(strEventCd);

    TR_SUB.Action="/dps/pcod703.pc?goTo="+goTo+parameters;  
    TR_SUB.KeyValue="SERVLET("+action+":DS_IO_EVENT_POS=DS_IO_EVENT_POS)"; //조회는 O
    TR_SUB.Post();
    //조회후 결과표시
    //setPorcCount("SELECT",GD_EVENT_POS);  

}
/**
 * checkMasterValidation()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 행사마스터 값을 검증한다.
 * return값 : void
**/
function checkMasterValidation(){
	var row = DS_IO_MASTER.RowPosition;
	var rowStatus = DS_IO_MASTER.RowStatus(row);
	if(!(rowStatus=="1" ||rowStatus=="3"))
		return true;
	var isCheck = false;
	var colid;
	if( rowStatus == "1" && DS_IO_MASTER.NameValue(row,"EVENT_THME_CD")==""){
        showMessage(EXCLAMATION, OK, "USER-1003", "행사테마");
		colid = "EVENT_THME_CD";
		isCheck = true;
	}else if( rowStatus == "1" && DS_IO_MASTER.NameValue(row,"EVENT_THME_NAME")==""){
        showMessage(EXCLAMATION, OK, "USER-1036", "행사테마");
        colid = "EVENT_THME_CD";
        isCheck = true;
	}else if( DS_IO_MASTER.NameValue(row,"EVENT_NAME")==""){
        showMessage(EXCLAMATION, OK, "USER-1003", "행사명");
        colid = "EVENT_NAME";
        isCheck = true;
    }else if( !checkInputByte( GD_MASTER, DS_IO_MASTER, row, "EVENT_NAME", "행사명")){
        colid = "EVENT_NAME";
        isCheck = true;
    }else if( DS_IO_MASTER.NameValue(row,"EVENT_S_DT")==""){
        showMessage(EXCLAMATION, OK, "USER-1003", "행사시작일");
        colid = "EVENT_S_DT";
        isCheck = true;
    /**}else if( DS_IO_MASTER.NameValue(row,"EVENT_S_DT")<=getTodayFormat("YYYYMMDD")){
        showMessage(EXCLAMATION, OK, "USER-1011", "행사시작일");
        colid = "EVENT_S_DT";
        isCheck = true;*/
    }else if( DS_IO_MASTER.NameValue(row,"EVENT_E_DT")==""){
        showMessage(EXCLAMATION, OK, "USER-1003", "행사종료일");
        colid = "EVENT_E_DT";
        isCheck = true;
    }else if( DS_IO_MASTER.NameValue(row,"EVENT_E_DT")<getTodayFormat("YYYYMMDD")){
        showMessage(EXCLAMATION, OK, "USER-1030", "행사종료일");
        colid = "EVENT_E_DT";
        isCheck = true;
    }else if( DS_IO_MASTER.NameValue(row,"EVENT_E_DT")< DS_IO_MASTER.NameValue(row,"EVENT_S_DT")){
        showMessage(EXCLAMATION, OK, "USER-1020", "행사종료일", "행사시작일");
        colid = "EVENT_E_DT";
        isCheck = true;
    }else if( DS_IO_MASTER.NameValue(row,"EVENT_TYPE")==""){
        showMessage(EXCLAMATION, OK, "USER-1003", "행사종류");
        colid = "EVENT_TYPE";
        isCheck = true;
    }else if( DS_IO_MASTER.NameValue(row,"EVENT_PLU_FLAG")==""){
        showMessage(EXCLAMATION, OK, "USER-1003", "행사유형");
        colid = "EVENT_PLU_FLAG";
        isCheck = true;
    }else if( DS_IO_MASTER.NameValue(row,"EVENT_MNG_FLAG")==""){
        showMessage(EXCLAMATION, OK, "USER-1003", "행사주관구분");
        colid = "EVENT_MNG_FLAG";
        isCheck = true;
    }else if( DS_IO_MASTER.NameValue(row,"EVENT_ORG_CD")==""){
        showMessage(EXCLAMATION, OK, "USER-1003", "주관조직");
        colid = "EVENT_ORG_CD";
        isCheck = true;
    }else if( DS_IO_MASTER.NameValue(row,"EVENT_ORG_NAME")==""){
        showMessage(EXCLAMATION, OK, "USER-1036", "주관조직");
        colid = "EVENT_ORG_CD";
        isCheck = true;
    }else if( DS_IO_MASTER.NameValue(row,"EVENT_CHAR_ID")==""){
        showMessage(EXCLAMATION, OK, "USER-1003", "담당자");
        colid = "EVENT_CHAR_ID";
        isCheck = true;
    }else if( DS_IO_MASTER.NameValue(row,"EVENT_CHAR_NAME")==""){
        showMessage(EXCLAMATION, OK, "USER-1036", "담당자");
        colid = "EVENT_CHAR_ID";
        isCheck = true;
    }
	
	if(isCheck){
		setFocusGrid(GD_MASTER,DS_IO_MASTER,row,colid);
		return false;
	}
	return true;
}

/**
 * checkDetailValidation()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 점별행사마스터 값을 검증한다.
 * return값 : void
**/
function checkDetailValidation(){
	var isCheck = false;
	var row;
	for(var i=1; i<=DS_IO_DETAIL.CountRow; i++){
		if( !(DS_IO_DETAIL.NameValue(i,"SEL") == "T" && DS_IO_DETAIL.RowStatus(i) == "3"))
			continue;
		row = i;
        if( DS_IO_DETAIL.NameValue(row,"EVENT_S_DT")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "행사시작일");
            colid = "EVENT_S_DT";
            isCheck = true;
            break;
        }
        if( DS_IO_DETAIL.NameValue(row,"EVENT_S_DT")<=getTodayFormat("YYYYMMDD") && DS_IO_DETAIL.NameValue(row,"EVENT_S_DT") != DS_IO_DETAIL.OrgNameValue(row,"EVENT_S_DT")){
            showMessage(EXCLAMATION, OK, "USER-1011", "행사시작일");
            colid = "EVENT_S_DT";
            isCheck = true;
            break;
        }
        if( DS_IO_DETAIL.NameValue(row,"EVENT_S_DT") < DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"EVENT_S_DT") 
                || DS_IO_DETAIL.NameValue(row,"EVENT_S_DT") > DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"EVENT_E_DT")){
            showMessage(INFORMATION, OK, "USER-1000", "점별 행사시작일은 행사코드의 행사기간 내에 존재해야 합니다.");    
            colid = "EVENT_S_DT";
            isCheck = true;
            break;
        }
		if( DS_IO_DETAIL.NameValue(row,"EVENT_E_DT")==""){
	        showMessage(EXCLAMATION, OK, "USER-1003", "행사종료일");
	        colid = "EVENT_E_DT";
	        isCheck = true;
	        break;
	    }
		if( DS_IO_DETAIL.NameValue(row,"EVENT_E_DT")<getTodayFormat("YYYYMMDD")){
	        showMessage(EXCLAMATION, OK, "USER-1030", "행사종료일");
	        colid = "EVENT_E_DT";
	        isCheck = true;
            break;
	    }
		if( DS_IO_DETAIL.NameValue(row,"EVENT_E_DT")< DS_IO_DETAIL.NameValue(row,"EVENT_S_DT")){
	        showMessage(EXCLAMATION, OK, "USER-1020", "행사종료일", "행사시작일");
	        colid = "EVENT_E_DT";
	        isCheck = true;
            break;
	    }
	}

    if(isCheck){
        setFocusGrid(GD_DETAIL,DS_IO_DETAIL,row,colid);
        return false;
    }
    return true;    
}

/**
 * checkEventPlaceValidation()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 점별행사장 값을 검증한다.
 * return값 : void
**/
function checkEventPlaceValidation(){
	checkValidation = true;
	DS_IO_EVENT_PLACE.Filter();
    var strCd;
    var eventPlaceCd;
    var row;
    var dupRow = checkDupKey(DS_IO_EVENT_PLACE,"STR_CD||EVENT_PLACE_CD");
	if( dupRow > 0 ){
        checkValidation = false;
        strCd = DS_IO_EVENT_PLACE.NameValue(dupRow,"STR_CD");
        eventPlaceCd = DS_IO_EVENT_PLACE.NameValue(dupRow,"EVENT_PLACE_CD");
        DS_IO_DETAIL.RowPosition = DS_IO_DETAIL.NameValueRow("STR_CD",strCd);
        DS_IO_EVENT_PLACE.Filter();
        row = DS_IO_EVENT_PLACE.NameValueRow("EVENT_PLACE_CD",eventPlaceCd);
        setFocusGrid(GD_EVENT_PLACE, DS_IO_EVENT_PLACE, row, "EVENT_PLACE_CD");
		//showMessage(EXCLAMATION, OK, "USER-1044");
		return false;
	} 
	for(var i=1;i<=DS_IO_EVENT_PLACE.CountRow;i++){
		var rowStatus = DS_IO_EVENT_PLACE.RowStatus(i);
		if( !(rowStatus == "1" || rowStatus == "3") )
			continue;
		
		if( DS_IO_EVENT_PLACE.NameValue(i,"EVENT_PLACE_CD") == ""){
	        checkValidation = false;
	        strCd = DS_IO_EVENT_PLACE.NameValue(i,"STR_CD");
	        eventPlaceCd = DS_IO_EVENT_PLACE.NameValue(i,"EVENT_PLACE_CD");
	        DS_IO_DETAIL.RowPosition = DS_IO_DETAIL.NameValueRow("STR_CD",strCd);
	        DS_IO_EVENT_PLACE.Filter();
            showMessage(EXCLAMATION, OK, "USER-1002", "행사장");
            setFocusGrid(GD_EVENT_PLACE, DS_IO_EVENT_PLACE, DS_IO_EVENT_PLACE.CountRow, "EVENT_PLACE_CD");
            return false;
		}
	}
	checkValidation = false;
    DS_IO_EVENT_PLACE.Filter();
    return true;    
}

/**
 * checkEventPosValidation()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 점별행사POS 값을 검증한다.
 * return값 : void
**/
function checkEventPosValidation(){
    checkValidation = true;
    var isCheck = false;
    DS_IO_EVENT_POS.Filter();
    var strCd;
    var posNo;
    var row;
    var colid;
    var dupRow = checkDupKey(DS_IO_EVENT_POS,"STR_CD||POS_NO");
    if( dupRow > 0 ){
        checkValidation = false;
        strCd = DS_IO_EVENT_POS.NameValue(dupRow,"STR_CD");
        posNo = DS_IO_EVENT_POS.NameValue(dupRow,"POS_NO");
        DS_IO_DETAIL.RowPosition = DS_IO_DETAIL.NameValueRow("STR_CD",strCd);
        DS_IO_EVENT_POS.Filter();
        row = DS_IO_EVENT_POS.NameValueRow("POS_NO",posNo);
        setFocusGrid(GD_EVENT_POS, DS_IO_EVENT_POS, row, "POS_NO");
        //showMessage(EXCLAMATION, OK, "USER-1044");
        return false;
    } 

    for(var i=1;i<=DS_IO_EVENT_POS.CountRow;i++){
        var rowStatus = DS_IO_EVENT_POS.RowStatus(i);
        if( !(rowStatus == "1" || rowStatus == "3") )
            continue;
        
        if( DS_IO_EVENT_POS.NameValue(i,"POS_NO") == ""){
            strCd = DS_IO_EVENT_POS.NameValue(i,"STR_CD");
            posNo = DS_IO_EVENT_POS.NameValue(i,"POS_NO");
            showMessage(EXCLAMATION, OK, "USER-1003", "POS번호");
        	colid="POS_NO";
        	isCheck = true;
            break;
        }
        if( DS_IO_EVENT_POS.NameValue(i,"POS_NAME") == ""){
            strCd = DS_IO_EVENT_POS.NameValue(i,"STR_CD");
            posNo = DS_IO_EVENT_POS.NameValue(i,"POS_NO");
            showMessage(EXCLAMATION, OK, "USER-1036", "POS번호");
            colid="POS_NO";
            isCheck = true;
            break;
        }
        if( DS_IO_EVENT_POS.NameValue(i,"SPS_YN") == ""){
            strCd = DS_IO_EVENT_POS.NameValue(i,"STR_CD");
            posNo = DS_IO_EVENT_POS.NameValue(i,"POS_NO");
            showMessage(EXCLAMATION, OK, "USER-1002", "특판여부");
            colid="SPS_YN";
            isCheck = true;
            break;
        }
    }
    if(isCheck){
        checkValidation = false;
        DS_IO_DETAIL.RowPosition = DS_IO_DETAIL.NameValueRow("STR_CD",strCd);
        DS_IO_EVENT_POS.Filter();
        row = DS_IO_EVENT_POS.NameValueRow("POS_NO",posNo);
        setFocusGrid(GD_EVENT_POS, DS_IO_EVENT_POS, row==0?DS_IO_EVENT_POS.CountRow:row, colid);
        return false;
    }
    checkValidation = false;
    DS_IO_EVENT_POS.Filter();
    return true;    
}
/**
 * setCalEventDt()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 달력 팝업을 실행한다.
 * return값 : void
**/
function setCalEventDt(evnFlag){
    var obj = EM_EVENT_YM;
    
    if( evnFlag == 'POP'){
        openCal('M',obj);
    }
    
    if(!checkDateTypeYM( obj, bfEventYm))
        return;
    
    if( bfEventYm != obj.Text){
    	if( DS_IO_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated || DS_IO_EVENT_PLACE.IsUpdated || DS_IO_EVENT_POS.IsUpdated ){
            if(showMessage(QUESTION, YESNO, "USER-1063","행사년월")!=1){
            	obj.Text = bfEventYm;
                GD_MASTER.Focus();
                return;
            }
    	}
    	DS_IO_MASTER.ClearData();
        DS_IO_DETAIL.ClearData();
        DS_IO_EVENT_PLACE.ClearData();
        DS_IO_EVENT_POS.ClearData();
    }
    
    bfEventYm = obj.Text;
} 

/**
 * detailEnable()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 상세내역 사용여부 지정
 * return값 : void
**/
function detailEnable(flag){
	GD_DETAIL.Editable = flag; 
	checkStrEventUse();
}

/**
 * detailCheckAll()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 상세내역 전체 선택 및 선택취소
 * return값 : void
**/
function detailCheckAll(flag){
	
	if(flag){
		for(var i=1; i<=DS_IO_DETAIL.CountRow; i++){
			DS_IO_DETAIL.NameValue(i,"SEL") = "T";
		}
		return;
	}
	
    for(var i=1; i<=DS_IO_DETAIL.CountRow; i++){
        var dtlCnt = 0;
    	if( i != DS_IO_DETAIL.RowPosition){
    		dtlCnt = getFliterNameValueCount(DS_IO_EVENT_PLACE,"STR_CD",DS_IO_DETAIL.NameValue(i,"STR_CD"));
            dtlCnt += getFliterNameValueCount(DS_IO_EVENT_POS,"STR_CD",DS_IO_DETAIL.NameValue(i,"STR_CD"));
    	}else{
            dtlCnt = getNameValueCount(DS_IO_EVENT_PLACE,"STR_CD",DS_IO_DETAIL.NameValue(i,"STR_CD"));
            dtlCnt += getNameValueCount(DS_IO_EVENT_POS,"STR_CD",DS_IO_DETAIL.NameValue(i,"STR_CD"));
    	}
    	
    	if( dtlCnt > 0)
    		continue;
    	
    	DS_IO_DETAIL.NameValue(i,"SEL") = "F";
    }
}

/**
 * setDetailDataUpate()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 상세내역 전체 값을 변경한다.
 * return값 : void
**/
function setDetailDataUpate(colid, data){
    for( var i = 1; i<=DS_IO_DETAIL.CountRow; i++){
    	DS_IO_DETAIL.NameValue(i,colid) = data;
    }
    //DS_IO_DETAIL.ResetStatus();
}
/**
 * checkStrEventUse()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 선택된 상세내역의 상태에 따라 행사장, POS 등력여부 변경
 * return값 : void
**/
function checkStrEventUse(){
    var flag = false;
    var row = DS_IO_DETAIL.RowPosition;
    if( DS_IO_DETAIL.NameValue(row,"SEL")=="T"
            && DS_IO_DETAIL.NameValue(row,"EVENT_E_DT")>=getTodayFormat("YYYYMMDD")){
        flag = true;
    }
    GD_EVENT_PLACE.Editable = flag;
    GD_EVENT_POS.Editable = flag;
    enableControl(IMG_EVENT_PLACE_ADD,flag);
    enableControl(IMG_EVENT_PLACE_DEL,flag);
    enableControl(IMG_POS_ADD,flag);
    enableControl(IMG_POS_DEL,flag);
}
//

/**
 * checkStrEventSDt()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 점별 행사의 행사기간 체크
 * return값 : void
**/
function checkStrEventSDt(){
    var row = DS_IO_MASTER.RowPosition;
	for( var i =1; i<= DS_IO_DETAIL.CountRow; i++){
		var selFlag   = DS_IO_DETAIL.NameValue(i,"SEL");
		var detEvtSDt = DS_IO_DETAIL.NameValue(i,"EVENT_S_DT");
	    if( selFlag=="T"
	            && ( DS_IO_MASTER.NameValue(row,"EVENT_S_DT") > detEvtSDt 
	            		|| DS_IO_MASTER.NameValue(row,"EVENT_E_DT") < detEvtSDt)){
	        return false;
	    }
	}
	return true;
	
}
/**
 * getCountStrEvtSelModf()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 점별 행사의 선택이 변경된 수를 조회
 * return값 : void
**/
function getCountStrEvtSelModf(){
	var cnt = 0;
    for(var i=1; i<=DS_IO_DETAIL.CountRow; i++){
        if( DS_IO_DETAIL.NameValue(i,"SEL") != DS_IO_DETAIL.OrgNameValue(i,"SEL") )
        	cnt++;
    }
    return cnt;
}

/**
 * setEventCode()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 행사코드를 조회한다.
 * return값 : void
 */
function setEventCode( evnFlag){

    var codeObj = EM_EVENT_CD;
    var nameObj = EM_EVENT_NAME;
    
    if( codeObj.Text == "" && evnFlag != "POP" ){
        nameObj.Text = "";
        return;     
    }

    if( evnFlag == "POP" ){
        eventPop(codeObj,nameObj);
        codeObj.Focus();
    }else if( evnFlag == "NAME" ){
        setEventNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj, 0);
    }    
    
}
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
<script language=JavaScript for=DS_IO_MASTER event=OnLoadCompleted(rowcnt)>
    isLoading = false;
</script>

<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<script language=JavaScript for=DS_IO_EVENT_PLACE event=OnDataError(row,colid)>
    //
    var errorCode = DS_IO_EVENT_PLACE.ErrorCode;
    if(errorCode == "50019"){
    	showMessage(EXCLAMATION, OK, "USER-1044");
    }else if( errorCode == "50018"){
        showMessage(EXCLAMATION, OK, "USER-1002", "행사장");
    }else{
        showMessage(EXCLAMATION, OK, "USER-1000",DS_IO_EVENT_PLACE.ErrorMsg);    	
    }
</script>
<script language=JavaScript for=DS_IO_EVENT_POS event=OnDataError(row,colid)>
    //
    var errorCode = DS_IO_EVENT_POS.ErrorCode;
    if(errorCode == "50019"){
        showMessage(EXCLAMATION, OK, "USER-1044");
    }else if( errorCode == "50018"){
        showMessage(EXCLAMATION, OK, "USER-1003", "POS번호");
    }else{
        showMessage(EXCLAMATION, OK, "USER-1000",DS_IO_EVENT_POS.ErrorMsg);       
    }
</script>

<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(row)>
    if( row < 1 || btnSaveClick)
        return;
    
    if( DS_IO_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated || DS_IO_EVENT_PLACE.IsUpdated || DS_IO_EVENT_POS.IsUpdated ){
        if(showMessage(QUESTION, YESNO, "USER-1049")!=1){
            GD_MASTER.Focus();
            return false;
        }
    }
    DS_IO_DETAIL.ClearData();
    DS_IO_EVENT_PLACE.ClearData();
    DS_IO_EVENT_POS.ClearData();
    DS_IO_MASTER.UndoAll();
</script>
<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>
    if( row < 1 || isLoading)
    	return;
    if( DS_IO_MASTER.RowStatus(row) != '1'){
        searchDetail();
        searchEventPlace();
        searchPos();
        checkStrEventUse();
        detailEnable(true);
        //var flag = DS_IO_MASTER.NameValue(row,"EVENT_S_DT") > getTodayFormat("YYYYMMDD");
        //GD_DETAIL.ColumnProp('SEL', 'HeadCheckShow') = flag;
    }else{
        detailEnable(false);
    }
</script>
<script language=JavaScript for=DS_IO_DETAIL event=OnRowPosChanged(row)>
    if( row < 1 )
        return;
    DS_I_EVENT_PLACE_CD.Filter();
    DS_IO_EVENT_PLACE.Filter();
    DS_IO_EVENT_POS.Filter();
    checkStrEventUse();
</script>
<script language=JavaScript for=DS_IO_EVENT_PLACE event=OnFilter(row)>
    if(checkValidation)
    	return true;
    var value = this.NameValue(row,"STR_CD");
    if( value != DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"STR_CD"))
        return false;
    
    return true;
</script>
<script language=JavaScript for=DS_IO_EVENT_POS event=OnFilter(row)>
    var value = this.NameValue(row,"STR_CD");
    if( value != DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"STR_CD"))
        return false;
    
    return true;
</script>
<script language=JavaScript for=DS_I_EVENT_PLACE_CD event=OnFilter(row)>
    var value = this.NameValue(row,"STR_CD");
    if( value != DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"STR_CD"))
        return false;
    
    return true;
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid ,"DS_IO_DETAIL,DS_IO_EVENT_PLACE,DS_IO_EVENT_POS");    
</script>
<!--  전체선택 제외 (2010.4.22)
<script language=JavaScript for=GD_DETAIL event=OnHeadCheckClick(row,colid,bCheck)>
    if( colid !="SEL"){
        return;
    }
    var eventSDt = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"EVENT_S_DT");
    if( eventSDt > getTodayFormat("YYYYMMDD")){
        detailCheckAll(bCheck=="1");
        return;
    }
    GD_DETAIL.ColumnProp('SEL', 'HeadCheck') = false;
</script>
 -->
<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid );
</script> 
 
<script language=JavaScript for=GD_DETAIL event=OnCheckClick(row,colid,check)>
    //
    if( colid !="SEL" )
        return;
    if( DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"EVENT_S_DT") < addDate("D",1,getTodayFormat("YYYYMMDD"),"")){
        return;
    }
    var selValue = DS_IO_DETAIL.NameValue(row,"SEL");
    var strCd = DS_IO_DETAIL.NameValue(row,"STR_CD");
    if( selValue != "T" ){
        var dtlCnt = getNameValueCount(DS_IO_EVENT_PLACE,"STR_CD",strCd);
        dtlCnt += getNameValueCount(DS_IO_EVENT_POS,"STR_CD",strCd);
        if( dtlCnt > 0){
            showMessage(INFORMATION, OK, "USER-1046");
            DS_IO_DETAIL.NameValue(row,"SEL") = "T";
            return;
        }
        if( Number(DS_IO_DETAIL.NameValue(row,"DTLCNT")) > 0){
            showMessage(INFORMATION, OK, "USER-1000", "해당 점별행사에 브랜드 또는 단품이 존재합니다.");
            DS_IO_DETAIL.NameValue(row,"SEL") = "T";
            return;
        }
        DS_IO_DETAIL.NameValue(row,"EVENT_S_DT") = "";
        DS_IO_DETAIL.NameValue(row,"EVENT_E_DT") = "";
        checkStrEventUse();
        return;
    }
    if(DS_IO_DETAIL.NameValue(row,"EVENT_S_DT") == ""){
        DS_IO_DETAIL.NameValue(row,"EVENT_S_DT") = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"EVENT_S_DT");
    }
    if(DS_IO_DETAIL.NameValue(row,"EVENT_E_DT") == ""){
        DS_IO_DETAIL.NameValue(row,"EVENT_E_DT") = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"EVENT_E_DT");
    }
    checkStrEventUse();

</script>
 

<script language=JavaScript for=GD_EVENT_PLACE event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid );
</script>
<script language=JavaScript for=GD_EVENT_POS event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid );
</script>

<script language=JavaScript for=GD_MASTER event=OnExit(row,colid,oldData)>
    if( row < 1 || isOnPopup)
        return;
    var value = DS_IO_MASTER.NameValue(row,colid);
    if( oldData == value )
        return;
    var rtnMap = null;
    switch(colid){
        case 'EVENT_THME_CD':
            DS_IO_MASTER.NameValue(row,"EVENT_THME_NAME") = "";
        	if( value == ""){
                return;
        	}
        	rtnMap = setEventThmeNmWithoutToGridPop("DS_SEARCH_NM",value,"",1,"Y","3");
        	if(rtnMap !=null){
        		DS_IO_MASTER.NameValue(row,"EVENT_THME_CD")   = rtnMap.get("EVENT_THME_CD");
                DS_IO_MASTER.NameValue(row,"EVENT_THME_NAME") = rtnMap.get("EVENT_THME_NAME");
        	}
        	if( DS_IO_MASTER.NameValue(row,"EVENT_THME_NAME") == ""){
        		DS_IO_MASTER.NameValue(row,"EVENT_THME_CD")   = "";
        	}
        	
        	break;
        case 'EVENT_S_DT':
        	var nextDay = addDate("D",1,getTodayFormat("YYYYMMDD"),"");
        	if( !checkDateTypeYMD(GD_MASTER,"EVENT_S_DT",nextDay))
        		return;
        	if( value < nextDay){
                showMessage(INFORMATION, OK, "USER-1011", "행사시작일");
                if(DS_IO_MASTER.RowStatus(row)=="1"){
                	DS_IO_MASTER.NameValue(row,"EVENT_S_DT")  = nextDay;
                }else{
                    DS_IO_MASTER.NameValue(row,"EVENT_S_DT")  = DS_IO_MASTER.OrgNameValue(row,"EVENT_S_DT");  
                    //setDetailDataUpate("EVENT_S_DT",DS_IO_MASTER.OrgNameValue(row,"EVENT_S_DT"));                               	
                }
                return;
        	}
        	if(!checkStrEventSDt()){
                showMessage(INFORMATION, OK, "USER-1000", "등록된 점 중에 해당 기간을 벗어나는 행사가 존재합니다.");
                if(DS_IO_MASTER.RowStatus(row)=="1"){
                    DS_IO_MASTER.NameValue(row,"EVENT_S_DT")  = nextDay;
                }else{
                    DS_IO_MASTER.NameValue(row,"EVENT_S_DT")  = DS_IO_MASTER.OrgNameValue(row,"EVENT_S_DT");  
                    //setDetailDataUpate("EVENT_S_DT",DS_IO_MASTER.OrgNameValue(row,"EVENT_S_DT"));                                 
                }
                return;
        	}
        	DS_IO_MASTER.NameValue(row,"EVENT_YM") = value.substring(0,6);
        	//setDetailDataUpate("EVENT_S_DT",value);
            break;
        case 'EVENT_E_DT':
            var nextDay = addDate("D",1,getTodayFormat("YYYYMMDD"),"");
            var toDay = getTodayFormat("YYYYMMDD");
            if( !checkDateTypeYMD(GD_MASTER,"EVENT_E_DT",toDay))
                return;
            if( value < toDay){
                showMessage(INFORMATION, OK, "USER-1030", "행사종료일");
                if(DS_IO_MASTER.RowStatus(row)=="1"){
                    DS_IO_MASTER.NameValue(row,"EVENT_E_DT")  = toDay;
                }else{
                    DS_IO_MASTER.NameValue(row,"EVENT_E_DT")  = DS_IO_MASTER.OrgNameValue(row,"EVENT_E_DT");       
                    //setDetailDataUpate("ORG_EVENT_E_DT",DS_IO_MASTER.OrgNameValue(row,"EVENT_E_DT"));                                 
                }
                return;
            }
            if(!checkStrEventSDt()){
                showMessage(INFORMATION, OK, "USER-1000", "등록된 점 중에 해당 기간을 벗어나는 행사가 존재합니다.");
                if(DS_IO_MASTER.RowStatus(row)=="1"){
                    DS_IO_MASTER.NameValue(row,"EVENT_E_DT")  = toDay;
                }else{
                    DS_IO_MASTER.NameValue(row,"EVENT_E_DT")  = DS_IO_MASTER.OrgNameValue(row,"EVENT_E_DT");  
                    //setDetailDataUpate("ORG_EVENT_E_DT",DS_IO_MASTER.OrgNameValue(row,"EVENT_E_DT"));                                 
                }
                return;
            }
            //setDetailDataUpate("ORG_EVENT_E_DT",value);
            break;
        case 'EVENT_ORG_CD':
            DS_IO_MASTER.NameValue(row,"EVENT_ORG_NAME") = "";
            if( value == ""){
                return;
            }            
            rtnMap = setOrgCornerOutNmWithoutToGridPop("DS_SEARCH_NM",value,"","N",1);
            if(rtnMap !=null){
                DS_IO_MASTER.NameValue(row,"EVENT_ORG_CD")   = rtnMap.get("ORG_CD");
                DS_IO_MASTER.NameValue(row,"EVENT_ORG_NAME") = rtnMap.get("ORG_NAME");
            }
            if( DS_IO_MASTER.NameValue(row,"EVENT_ORG_NAME") == ""){
                DS_IO_MASTER.NameValue(row,"EVENT_ORG_CD")   = "";
            }
            break;
        case 'EVENT_CHAR_ID':        	
        	DS_IO_MASTER.NameValue(row,"EVENT_CHAR_NAME") = "";
            if( value == ""){
                return;
            }
            setNmToDataSet('DS_SEARCH_NM', 'SEL_USR_MST', value);
            if(DS_SEARCH_NM.CountRow == 1){
                DS_IO_MASTER.NameValue(row,"EVENT_CHAR_ID")   = DS_SEARCH_NM.NameValue(1,"CODE_CD");
                DS_IO_MASTER.NameValue(row,"EVENT_CHAR_NAME") = DS_SEARCH_NM.NameValue(1,"CODE_NM");
                return;
            }
            rtnMap = commonPopToGrid('사원','SEL_USR_MST_TEST',value);
            if( rtnMap.size() > 0){
                DS_IO_MASTER.NameValue(row,"EVENT_CHAR_ID")   = rtnMap.get("CODE_CD");
                DS_IO_MASTER.NameValue(row,"EVENT_CHAR_NAME") = rtnMap.get("CODE_NM");
                return;
            }
            if( DS_IO_MASTER.NameValue(row,"EVENT_CHAR_NAME") == ""){
                DS_IO_MASTER.NameValue(row,"EVENT_CHAR_ID")   = "";
            }
            break;
    }
</script>
<script language=JavaScript for=GD_MASTER event=OnPopup(row,colid,data)>

    if( row < 1 )
        return;
    var rtnMap = null;
    isOnPopup = true;
    switch(colid){
        case 'EVENT_THME_CD':        	
        	rtnMap = eventThmeToGridPop(data,"","Y","3");
            if(rtnMap !=null){
                DS_IO_MASTER.NameValue(row,"EVENT_THME_CD")   = rtnMap.get("EVENT_THME_CD");
                DS_IO_MASTER.NameValue(row,"EVENT_THME_NAME") = rtnMap.get("EVENT_THME_NAME");
            }
            if( DS_IO_MASTER.NameValue(row,"EVENT_THME_NAME") == ""){
                DS_IO_MASTER.NameValue(row,"EVENT_THME_CD")   = "";
            }
            break;
        case 'EVENT_S_DT':
        	openCal(GD_MASTER,row,colid);
            var value = DS_IO_MASTER.NameValue(row,colid);
            var nextDay = addDate("D",1,getTodayFormat("YYYYMMDD"),"");
            if( !checkDateTypeYMD(GD_MASTER,"EVENT_S_DT",nextDay)){
                isOnPopup = false;
                return;
            }
            if( value < nextDay){
                showMessage(INFORMATION, OK, "USER-1011", "행사시작일");
                if(DS_IO_MASTER.RowStatus(row)=="1"){
                    DS_IO_MASTER.NameValue(row,"EVENT_S_DT")  = nextDay;
                }else{
                    DS_IO_MASTER.NameValue(row,"EVENT_S_DT")  = DS_IO_MASTER.OrgNameValue(row,"EVENT_S_DT");   
                    //setDetailDataUpate("EVENT_S_DT",DS_IO_MASTER.OrgNameValue(row,"EVENT_S_DT"));                                     
                }
                isOnPopup = false;
                return;
            }
            if(!checkStrEventSDt()){
                showMessage(INFORMATION, OK, "USER-1000", "등록된 점 중에 해당 기간을 벗어나는 행사가 존재합니다.");
                if(DS_IO_MASTER.RowStatus(row)=="1"){
                    DS_IO_MASTER.NameValue(row,"EVENT_S_DT")  = nextDay;
                }else{
                    DS_IO_MASTER.NameValue(row,"EVENT_S_DT")  = DS_IO_MASTER.OrgNameValue(row,"EVENT_S_DT");  
                    //setDetailDataUpate("EVENT_S_DT",DS_IO_MASTER.OrgNameValue(row,"EVENT_S_DT"));                                 
                }
                return;
            }
            DS_IO_MASTER.NameValue(row,"EVENT_YM") = value.substring(0,6);
            //setDetailDataUpate("EVENT_S_DT",value);
            break;
        case 'EVENT_E_DT':
            openCal(GD_MASTER,row,colid);
            var value = DS_IO_MASTER.NameValue(row,colid);
            var nextDay = addDate("D",1,getTodayFormat("YYYYMMDD"),"");
            var toDay = getTodayFormat("YYYYMMDD");
            if( !checkDateTypeYMD(GD_MASTER,"EVENT_E_DT",toDay)){
                isOnPopup = false;
                return;
            }
            if( value < toDay){
                showMessage(INFORMATION, OK, "USER-1030", "행사종료일");
                if(DS_IO_MASTER.RowStatus(row)=="1"){
                    DS_IO_MASTER.NameValue(row,"EVENT_E_DT")  = toDay;
                }else{
                    DS_IO_MASTER.NameValue(row,"EVENT_E_DT")  = DS_IO_MASTER.OrgNameValue(row,"EVENT_E_DT");
                    //setDetailDataUpate("ORG_EVENT_E_DT",DS_IO_MASTER.OrgNameValue(row,"EVENT_E_DT"));                    
                }
                isOnPopup = false;
                return;
            }
            if(!checkStrEventSDt()){
                showMessage(INFORMATION, OK, "USER-1000", "등록된 점 중에 해당 기간을 벗어나는 행사가 존재합니다.");
                if(DS_IO_MASTER.RowStatus(row)=="1"){
                    DS_IO_MASTER.NameValue(row,"EVENT_E_DT")  = toDay;
                }else{
                    DS_IO_MASTER.NameValue(row,"EVENT_E_DT")  = DS_IO_MASTER.OrgNameValue(row,"EVENT_E_DT");  
                    //setDetailDataUpate("ORG_EVENT_E_DT",DS_IO_MASTER.OrgNameValue(row,"EVENT_E_DT"));                                 
                }
                return;
            }
            //setDetailDataUpate("ORG_EVENT_E_DT",value);
            break;
        case 'EVENT_ORG_CD':
        	rtnMap = orgCornerOutToGridPop(data,"","N");
            if(rtnMap !=null){
                DS_IO_MASTER.NameValue(row,"EVENT_ORG_CD")   = rtnMap.get("ORG_CD");
                DS_IO_MASTER.NameValue(row,"EVENT_ORG_NAME") = rtnMap.get("ORG_NAME");
            }
            if( DS_IO_MASTER.NameValue(row,"EVENT_ORG_NAME") == ""){
                DS_IO_MASTER.NameValue(row,"EVENT_ORG_CD")   = "";
            }
            break;
        case 'EVENT_CHAR_ID':
        	rtnMap = commonPopToGrid('사원','SEL_USR_MST_TEST',data);
            if( rtnMap.size() > 0){
                DS_IO_MASTER.NameValue(row,"EVENT_CHAR_ID")   = rtnMap.get("CODE_CD");
                DS_IO_MASTER.NameValue(row,"EVENT_CHAR_NAME") = rtnMap.get("CODE_NM");
                return;
            }
            if( DS_IO_MASTER.NameValue(row,"EVENT_CHAR_NAME") == ""){
                DS_IO_MASTER.NameValue(row,"EVENT_CHAR_ID")   = "";
            }
            break;
    }
    isOnPopup = false;
</script>
<script language=JavaScript for=GD_DETAIL event=OnExit(row,colid,oldData)>
    if( row < 1 || isOnPopup)
        return;
    var value = DS_IO_DETAIL.NameValue(row,colid);    
    if( oldData == value )
        return;
    switch(colid){
        case 'EVENT_S_DT':
            var defDate = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"EVENT_S_DT");
            var nextDay = addDate("D",1,getTodayFormat("YYYYMMDD"),"");
            var orgDate = DS_IO_DETAIL.OrgNameValue(row,"EVENT_S_DT");
            if( !checkDateTypeYMD(GD_DETAIL,"EVENT_S_DT",defDate))
                return;
            if( value < nextDay){
                showMessage(INFORMATION, OK, "USER-1011", "행사시작일");
                DS_IO_DETAIL.NameValue(row,"EVENT_S_DT")  =  orgDate == ''?defDate:orgDate;  
                return;
            }
            if( value < defDate 
            		|| value > DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"EVENT_E_DT")){
                showMessage(INFORMATION, OK, "USER-1000", "점별 행사시작일은 행사코드의 행사기간 내에 존재해야 합니다.");       
                DS_IO_DETAIL.NameValue(row,"EVENT_S_DT")  =  orgDate == ''?defDate:orgDate;  
                return;     	
            }
            break;
        case 'EVENT_E_DT':
            var defDate = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"EVENT_E_DT");
            var nextDay = addDate("D",1,getTodayFormat("YYYYMMDD"),"");
            var toDay = getTodayFormat("YYYYMMDD");
            var orgDate = DS_IO_DETAIL.OrgNameValue(row,"EVENT_E_DT");
            if( !checkDateTypeYMD(GD_DETAIL,"EVENT_E_DT",defDate))
                return;
            if( value < toDay){
                showMessage(INFORMATION, OK, "USER-1030", "행사종료일");
                DS_IO_DETAIL.NameValue(row,"EVENT_E_DT")  =  orgDate == ''?defDate:orgDate;  
                return;
            }
            break;
    }
</script>
<script language=JavaScript for=GD_DETAIL event=OnPopup(row,colid,data)>
    if( row < 1 )
        return;
    isOnPopup = true;
    switch(colid){
        case 'EVENT_S_DT':
            openCal(GD_DETAIL,row,colid);
            var value = DS_IO_DETAIL.NameValue(row,colid);
            var defDate = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"EVENT_S_DT");
            var nextDay = addDate("D",1,getTodayFormat("YYYYMMDD"),"");
            var orgDate = DS_IO_DETAIL.OrgNameValue(row,"EVENT_S_DT");
            if( !checkDateTypeYMD(GD_DETAIL,"EVENT_S_DT",defDate)){
                isOnPopup = false;
                return;
            }
            if( value < nextDay){
                showMessage(INFORMATION, OK, "USER-1011", "행사시작일");
                DS_IO_DETAIL.NameValue(row,"EVENT_S_DT")  = orgDate == ''?defDate:orgDate;  
                isOnPopup = false;
                return;
            }
            if( value < defDate 
                    || value > DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"EVENT_E_DT")){
                showMessage(INFORMATION, OK, "USER-1000", "점별 행사시작일은 행사코드의 행사기간 내에 존재하여야 합니다.");       
                DS_IO_DETAIL.NameValue(row,"EVENT_S_DT")  =  orgDate == ''?defDate:orgDate;  
                return;         
            }
            break;
        case 'EVENT_E_DT':
            openCal(GD_DETAIL,row,colid);
            var value = DS_IO_DETAIL.NameValue(row,colid);
            var defDate = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"EVENT_E_DT");
            var nextDay = addDate("D",1,getTodayFormat("YYYYMMDD"),"");
            var orgDate = DS_IO_DETAIL.OrgNameValue(row,"EVENT_E_DT");
            var toDay = getTodayFormat("YYYYMMDD");
            if( !checkDateTypeYMD(GD_DETAIL,"EVENT_E_DT",defDate)){
                isOnPopup = false;
                return;
            }
            if( value < toDay){
                showMessage(INFORMATION, OK, "USER-1030", "행사종료일");
                DS_IO_DETAIL.NameValue(row,"EVENT_E_DT")  = orgDate == ''?defDate:orgDate;  
                isOnPopup = false;
                return;
            }
            break;
    }
    isOnPopup = false;
</script>
<script language=JavaScript for=GD_EVENT_POS event=OnExit(row,colid,oldData)>
    if( row < 1 || isOnPopup)
        return;
    var value = DS_IO_EVENT_POS.NameValue(row,colid);    
    if( oldData == value )
        return;
    switch(colid){
        case 'POS_NO':
        	DS_IO_EVENT_POS.NameValue(row,"POS_NAME") = "";
            if( value == ""){
                return;
            }            
            var strCd = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"STR_CD");
            rtnMap = setPosNoNmWithoutToGridPop("DS_SEARCH_NM",value,"",1,strCd,"","","Y");
            if(rtnMap !=null){
            	DS_IO_EVENT_POS.NameValue(row,"POS_NO")   = rtnMap.get("POS_NO");
            	DS_IO_EVENT_POS.NameValue(row,"POS_NAME") = rtnMap.get("POS_NAME");
            }
            if( DS_IO_EVENT_POS.NameValue(row,"POS_NAME") == ""){
            	DS_IO_EVENT_POS.NameValue(row,"POS_NO")   = "";
            }
            break;
    }
</script>
<script language=JavaScript for=GD_EVENT_POS event=OnPopup(row,colid,data)>
    if( row < 1 )
        return;
    isOnPopup = true;
    switch(colid){
        case 'POS_NO':
        	var strCd = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"STR_CD");
            rtnMap = posNoToGridPop(data,"",strCd,"","","Y");
            if(rtnMap !=null){
            	DS_IO_EVENT_POS.NameValue(row,"POS_NO")   = rtnMap.get("POS_NO");
            	DS_IO_EVENT_POS.NameValue(row,"POS_NAME") = rtnMap.get("POS_NAME");
            }
            if( DS_IO_EVENT_POS.NameValue(row,"POS_NAME") == ""){
            	DS_IO_EVENT_POS.NameValue(row,"POS_NO")   = "";
            }
            break;
    }
    isOnPopup = false;
</script>
<!-- 적용일(from)(조회) -->
<script language=JavaScript for=EM_EVENT_YM event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setCalEventDt('NAME');
</script>
<!-- 행사테마(대)(조회) -->
<script language=JavaScript for=LC_O_EVENT_L_CD event=OnSelChange()>
    DS_O_EVENT_M_CD.ClearData();
    DS_O_EVENT_S_CD.ClearData();
    getEvtThmeMCode("DS_O_EVENT_M_CD", this.BindColVal, "Y");
    setComboData(LC_O_EVENT_M_CD,'%');
</script>
<!-- 행사테마(중)(조회) -->
<script language=JavaScript for=LC_O_EVENT_M_CD event=OnSelChange()>
    DS_O_EVENT_S_CD.ClearData();
    getEvtThmeSCode("DS_O_EVENT_S_CD", LC_O_EVENT_L_CD.BindColVal, this.BindColVal, "Y");
    setComboData(LC_O_EVENT_S_CD,'%');
</script>

<!-- 행사코드(조회) -->
<script language=JavaScript for=EM_EVENT_CD event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setEventCode('NAME');
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
<comment id="_NSID_"><object id="DS_O_EVENT_TYPE"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_EVENT_MNG_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_EVENT_L_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_EVENT_M_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_EVENT_S_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_I_EVENT_TYPE"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_EVENT_PLU_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_EVENT_MNG_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_EVENT_PLACE_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_EVENT_PLACE"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_EVENT_POS"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
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
            <th width="80" class="point">행사년월</th>
            <td width="166">
              <comment id="_NSID_">
                <object id=EM_EVENT_YM classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1 align="absmiddle"></object>
              </comment> <script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/date.gif"  class="PR03" onclick="javascript:setCalEventDt('POP')" align="absmiddle" />
            </td>
            <th width="80" >행사종류</th>
            <td width="165">
              <comment id="_NSID_">
                <object id=LC_O_EVENT_TYPE classid=<%= Util.CLSID_LUXECOMBO %> width=165 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80">행사주관구분</th>
            <td >
              <comment id="_NSID_">
                <object id=LC_O_EVENT_MNG_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=165 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th >행사테마(대)</th>
            <td >
              <comment id="_NSID_">
                <object id=LC_O_EVENT_L_CD classid=<%= Util.CLSID_LUXECOMBO %> width=165 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th >행사테마(중)</th>
            <td >
              <comment id="_NSID_">
                <object id=LC_O_EVENT_M_CD classid=<%= Util.CLSID_LUXECOMBO %> width=165 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th >행사테마(소)</th>
            <td >
              <comment id="_NSID_">
                <object id=LC_O_EVENT_S_CD classid=<%= Util.CLSID_LUXECOMBO %> width=165 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>          
            <th width="70" >행사코드</th>
            <td colspan="5">
              <comment id="_NSID_">
                <object id=EM_EVENT_CD classid=<%=Util.CLSID_EMEDIT%> width=145 tabindex=1 align="absmiddle"></object>
              </comment> <script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" onclick="javascript:setEventCode('POP');" align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_EVENT_NAME classid=<%=Util.CLSID_EMEDIT%> width=260 tabindex=1 align="absmiddle"></object>
              </comment> <script> _ws_(_NSID_);</script>
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
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
        <tr>
          <td>
            <comment id="_NSID_"><object id=GD_MASTER width="100%" height=220 classid=<%=Util.CLSID_GRID%>>
              <param name="DataID" value="DS_IO_MASTER">
            </object></comment><script>_ws_(_NSID_);</script>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td class="PT10">
      <table width="100%" border="0" cellspacing="0" cellpadding="0" >
        <tr>
          <td rowspan="2">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
              <tr>
                <td>
                  <comment id="_NSID_"><object id=GD_DETAIL  width="400" height=220 classid=<%=Util.CLSID_GRID%>>
                    <param name="DataID" value="DS_IO_DETAIL">
                  </object></comment><script>_ws_(_NSID_);</script>
                </td>
              </tr>
            </table>
          </td >
          <td class="right PL15" width=160><img src="/<%=dir%>/imgs/btn/add_row.gif" id=IMG_EVENT_PLACE_ADD onClick="javascript:btn_addRow1()" hspace="2" /><img src="/<%=dir%>/imgs/btn/del_row.gif" id=IMG_EVENT_PLACE_DEL  onClick="javascript:btn_delRow1()" />
          </td>
          <td class="right PL15" width="100%"><img src="/<%=dir%>/imgs/btn/add_row.gif" id=IMG_POS_ADD onClick="javascript:btn_addRow2()" hspace="2" /><img src="/<%=dir%>/imgs/btn/del_row.gif" id=IMG_POS_DEL onClick="javascript:btn_delRow2()" />
          </td>
        </tr>
        <tr>
          <td class="PL15">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
              <tr>
                <td>
                  <comment id="_NSID_"><object id=GD_EVENT_PLACE width="160" height=200 classid=<%=Util.CLSID_GRID%>>
                    <param name="DataID" value="DS_IO_EVENT_PLACE">
                  </object></comment><script>_ws_(_NSID_);</script>
                </td>
              </tr>
            </table>
          </td>
          <td class="PL15" >
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
              <tr>
                <td>
                  <comment id="_NSID_"><object id=GD_EVENT_POS width="100%" height=200 classid=<%=Util.CLSID_GRID%>>
                    <param name="DataID" value="DS_IO_EVENT_POS">
                  </object></comment><script>_ws_(_NSID_);</script>
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

