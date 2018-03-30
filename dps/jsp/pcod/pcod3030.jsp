<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > 마진코드> 임대을B수수료관리
 * 작 성 일 : 2010.05.18
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod3030.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 임대을 B 협력사의 브랜드별 수수료를 관리한다.
 * 이    력 :
 *        2010.05.18 (정진영) 신규작성
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
var bfMasterRow = 0;
var bfAmtMasterRow = 0;
var bfAmtSctnMasterRow = 0;
var btnSaveYn = false;
var isOnPopup = false;

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
    DS_NRML_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MARGINMST"/>');
    DS_AMT_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MARGINMST_DT"/>');
    DS_AMT_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_MARGINMST"/>');
    DS_AMT_SCTN_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MARGINMST_DT"/>');
    DS_AMT_SCTN_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_MARGINMST"/>');


    // 텝 초기화
    initTab('TAB_MAIN');
    
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //기간 상세
    gridCreate3(); //금액 상세1
    gridCreate4(); //금액 상세2
//     gridCreate5(); //금액구간 상세1
//     gridCreate6(); //금액구간 상세2

    // EMedit에 초기화
    initEmEdit(EM_VEN_CD        , "CODE^6^0" ,  NORMAL);  //협력사코드(조회)
    initEmEdit(EM_VEN_NAME      , "GEN^40"   ,  NORMAL);  //협력사명(조회)
    initEmEdit(EM_PUMBUN_CD     , "CODE^6^0" ,  NORMAL);  //브랜드코드(조회)
    initEmEdit(EM_PUMBUN_NAME   , "GEN^40"   ,  NORMAL);  //브랜드명(조회)
    initEmEdit(EM_STR_NAME_M    , "GEN^40"   ,  READ);    //점명(상세)
    initEmEdit(EM_PUMBUN_CD_M   , "CODE^6^0" ,  READ);    //브랜드코드(상세)
    initEmEdit(EM_PUMBUN_NAME_M , "GEN^40"   ,  READ);    //브랜드명(상세)
    //콤보 초기화 
    initComboStyle(LC_STR_CD           ,DS_STR_CD           , "CODE^0^30,NAME^0^140", 1, PK);  //점(조회)
    initComboStyle(LC_RENTB_MGAPP_FLAG ,DS_RENTB_MGAPP_FLAG , "CODE^0^30,NAME^0^80", 1, NORMAL);  //수수료구분(조회)

    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_RENTB_MGAPP_FLAG" , "D", "P086", "Y");
    
    
    // 점코드 조회
    getStore("DS_STR_CD"  , "Y", "", "N");
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_STR_CD.Index < 0){
        LC_STR_CD.Index= 0;
    }
    setComboData(LC_RENTB_MGAPP_FLAG, '%');

    
    // 삭제된 로우 표시여부
    //DS_DETAIL.ViewDeletedRow = true;
    
    btnAddDelEnableCnt( false);

        
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pcod303","DS_NRML_MASTER,DS_AMT_MASTER,DS_AMT_DETAIL,DS_AMT_SCTN_MASTER,DS_AMT_SCTN_DETAIL" );
    
    LC_STR_CD.Focus();
    
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}         width=25   align=center name="NO"            </FC>'
                     + '<FG>name="협력사"'
                     + '<FC>id=VEN_CD           width=80   align=center name="코드"          </FC>'
                     + '<FC>id=VEN_NAME         width=100  align=left   name="명"            </FC>'
                     + '</FG>'
                     + '<FG>name="브랜드"'
                     + '<FC>id=PUMBUN_CD        width=80   align=center name="코드"          </FC>'
                     + '<FC>id=PUMBUN_NAME      width=100  align=left   name="명"            </FC>'
                     + '</FG>'
                     + '<FC>id=RENTB_MGAPP_FLAG width=70   align=left   name="수수료;구분 "     EditStyle=Lookup Data="DS_RENTB_MGAPP_FLAG:CODE:NAME"</FC>';
 
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    
}
function gridCreate2(){
    var hdrProperies = '<FC>id={currow}        width=25   align=center edit=none        name="NO"          </FC>'
                     + '<FG>name="마진코드"'
                     + '<FC>id=EVENT_FLAG      width=80   align=center edit=Numeric     name="*행사구분"    edit={IF(SysStatus="I","true","false")}</FC>'
                     + '<FC>id=EVENT_RATE      width=60   align=center edit=none        name="행사율"       </FC>'
                     + '</FG>'
                     + '<FC>id=REMARK          width=120  align=left  name="행사구분명" edit={IF(APP_S_DT>"'+getTodayFormat("YYYYMMDD")+'","true","false")}  </FC>'
                     + '<FC>id=NORM_MG_RATE    width=70   align=right  edit=RealNumeric name="*마진율 "      edit={IF(APP_S_DT>"'+getTodayFormat("YYYYMMDD")+'","true","false")} </FC>'
                     + '<FC>id=APP_S_DT        width=85   align=center edit=Numeric     name="*적용시작일 "  mask="XXXX/XX/XX" EditStyle=Popup edit={IF(SysStatus="I" ,"true",IF(EDIT_YN="Y" AND Status<>"I","true","false"))}</FC>'
                     + '<FC>id=APP_E_DT        width=85   align=center edit=none        name="적용종료일 "   mask="XXXX/XX/XX" </FC>';

    initGridStyle(GD_NRML_MASTER, "common", hdrProperies, true);
}

function gridCreate3(){
    var hdrProperies = '<FC>id={currow}        width=25   align=center edit=none        name="NO"          </FC>'
                     + '<FC>id=APP_S_DT        width=90   align=center edit=Numeric     name="*적용시작일 "  mask="XXXX/XX/XX" EditStyle=Popup edit={IF(SysStatus="I" ,"true",IF(EDIT_YN="Y" AND Status<>"I","true","false"))}</FC>'
                     + '<FC>id=APP_E_DT        width=90   align=center edit=none        name="적용종료일 "   mask="XXXX/XX/XX" </FC>';

    initGridStyle(GD_AMT_MASTER, "common", hdrProperies, true);
}
function gridCreate4(){
    var hdrProperies = '<FC>id={currow}        width=25   align=center edit=none        name="NO"              </FC>'
                     + '<FG>name="마진코드"'
                     + '<FC>id=EVENT_FLAG      width=80   align=center edit=Numeric     name="*행사구분"       edit={IF(SysStatus="I","true","false")}</FC>'
                     + '<FC>id=EVENT_RATE      width=60   align=center edit=none        name="행사율"          </FC>'
                     + '</FG>'
                     + '<FC>id=REMARK          width=120  align=left   name="행사구분명"      edit={IF(APP_S_DT>"'+getTodayFormat("YYYYMMDD")+'","true","false")}  </FC>'
                     + '<FC>id=BAS_AMT         width=150  align=right  edit=Numeric     name="*기준금액;(이하)" edit={IF(APP_S_DT>"'+getTodayFormat("YYYYMMDD")+'","true","false")}  </FC>'
                     + '<FC>id=NORM_MG_RATE    width=70   align=right  edit=RealNumeric name="*마진율 "         edit={IF(APP_S_DT>"'+getTodayFormat("YYYYMMDD")+'","true","false")} </FC>';

    initGridStyle(GD_AMT_DETAIL, "common", hdrProperies, true);
}
function gridCreate5(){
    var hdrProperies = '<FC>id={currow}        width=25   align=center edit=none        name="NO"          </FC>'
                     + '<FC>id=APP_S_DT        width=90   align=center edit=Numeric     name="*적용시작일 "  mask="XXXX/XX/XX" EditStyle=Popup edit={IF(SysStatus="I" ,"true",IF(EDIT_YN="Y" AND Status<>"I","true","false"))}</FC>'
                     + '<FC>id=APP_E_DT        width=90   align=center edit=none        name="적용종료일 "   mask="XXXX/XX/XX" </FC>';

    initGridStyle(GD_AMT_SCTN_MASTER, "common", hdrProperies, true);
}
function gridCreate6(){
    var hdrProperies = '<FC>id={currow}        width=25   align=center edit=none        name="NO"          </FC>'
                     + '<FG>name="마진코드"'
                     + '<FC>id=EVENT_FLAG      width=80   align=center edit=Numeric     name="*행사구분"    edit={IF(SysStatus="I","true","false")}</FC>'
                     + '<FC>id=EVENT_RATE      width=60   align=center edit=none        name="행사율"       </FC>'
                     + '</FG>'
                     + '<FC>id=REMARK          width=120  align=left   name="행사구분명"  edit={IF(APP_S_DT>"'+getTodayFormat("YYYYMMDD")+'","true","false")}  </FC>'
                     + '<FG>name="금액구간"'
                     + '<FC>id=BAS_AMT_FROM    width=85   align=right  edit=Numeric     name="시작(<)"      edit={"false"}</FC>'
                     + '<FC>id=BAS_AMT         width=85   align=right  edit=Numeric     name="*끝(>=)"      edit={IF(APP_S_DT>"'+getTodayFormat("YYYYMMDD")+'","true","false")}</FC>'
                     + '</FG>'
                     + '<FC>id=NORM_MG_RATE    width=70   align=right  edit=RealNumeric name="*마진율 "      edit={IF(APP_S_DT>"'+getTodayFormat("YYYYMMDD")+'","true","false")}  </FC>';

    initGridStyle(GD_AMT_SCTN_DETAIL, "common", hdrProperies, true);
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
    if( LC_STR_CD.BindColVal == ""){
        showMessage(EXCLAMATION, OK, "USER-1002", "점");
        LC_STR_CD.Focus();
        return;
    }
    if( DS_NRML_MASTER.IsUpdated 
    		|| DS_AMT_MASTER.IsUpdated 
    		|| DS_AMT_DETAIL.IsUpdated
            || DS_AMT_SCTN_MASTER.IsUpdated 
            || DS_AMT_SCTN_DETAIL.IsUpdated){
        // 변경된 상세내역이 존재합니다. 조회하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1059") != 1){
        	switch(getTabItemSelect('TAB_MAIN')){
        	    case 1:
                    GD_NRML_MASTER.Focus();
                    break;
                case 2:
                	if(DS_AMT_MASTER.IsUpdated){
                        GD_AMT_MASTER.Focus();
                        break;
                	}
                    GD_AMT_DETAIL.Focus();
                    break;
                case 3:
                    if(DS_AMTSCTN__MASTER.IsUpdated){
                    	GD_AMT_SCTN_MASTER.Focus();
                        break;
                    }
                    GD_AMT_SCTN_DETAIL.Focus();
                    break;
        	}
            return ;
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
    // 저장할 데이터 없는 경우
    if (!DS_NRML_MASTER.IsUpdated 
            && !DS_AMT_MASTER.IsUpdated 
            && !DS_AMT_DETAIL.IsUpdated
            && !DS_AMT_SCTN_MASTER.IsUpdated 
            && !DS_AMT_SCTN_DETAIL.IsUpdated ){
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
        switch(getTabItemSelect('TAB_MAIN')){
            case 1:
                GD_NRML_MASTER.Focus();
                break;
            case 2:
                GD_AMT_MASTER.Focus();
                break;
            case 3:
                GD_AMT_SCTN_MASTER.Focus();
                break;
        }
        return;
    }

    if( !checkValidation( getTabItemSelect('TAB_MAIN') ))
        return;

    // 마감체크 (common.js)
    if( getCloseCheck('DS_CLOSECHECK','',getTodayFormat("YYYYMMDD"),'PCOD','01','0','T') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
        switch(getTabItemSelect('TAB_MAIN')){
            case 1:
            	GD_NRML_MASTER.Focus();
                break;
            case 2:
                GD_AMT_MASTER.Focus();
                break;
            case 3:
                GD_AMT_SCTN_MASTER.Focus();
                break;
        }
        return;
    }
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        switch(getTabItemSelect('TAB_MAIN')){
            case 1:
            	GD_NRML_MASTER.Focus();
                break;
            case 2:
                GD_AMT_MASTER.Focus();
                break;
            case 3:
                GD_AMT_SCTN_MASTER.Focus();
                break;
        }
        return; 
    }
    
    DS_NRML_MASTER.ResetUserStatus();
    DS_AMT_MASTER.ResetUserStatus();
    DS_AMT_SCTN_MASTER.ResetUserStatus();

    var goTo;
    var marginData;
    var marginDateData; 
    var appSDt = "";
    switch(getTabItemSelect('TAB_MAIN')){
        case 1:
        	goTo = "saveNormal";
        	marginData = "DS_NRML_MASTER";
        	marginDateData = "DS_MASTER"; // 실제 정장시 사용되지 않지만. 값을 갯수를 맞추기 위해 입력
            break;
        case 2:
            goTo = "save";
            marginData = "DS_AMT_DETAIL";
            marginDateData = "DS_AMT_MASTER";
            appSDt = DS_AMT_MASTER.NameValue(DS_AMT_MASTER.RowPosition,"APP_S_DT");
            break;
        case 3:
            goTo = "save";
            marginData = "DS_AMT_SCTN_DETAIL";
            marginDateData = "DS_AMT_SCTN_MASTER";
            appSDt = DS_AMT_SCTN_MASTER.NameValue(DS_AMT_SCTN_MASTER.RowPosition,"APP_S_DT");
            break;
    }
    btnSaveYn = true;
    TR_MAIN.Action="/dps/pcod303.pc?goTo="+goTo;  
    TR_MAIN.KeyValue="SERVLET(I:DS_MARGIN="+marginData+",I:DS_MARGIN_DT="+marginDateData+")"; //조회는 O
    TR_MAIN.Post();    
    btnSaveYn = false;
    if(TR_MAIN.ErrorCode == 0){
        searchDetail(DS_MASTER.RowPosition);
    }
    
    switch(getTabItemSelect('TAB_MAIN')){
        case 1:
        	GD_NRML_MASTER.Focus();
            break;
        case 2:
            GD_AMT_MASTER.Focus();
            DS_AMT_MASTER.RowPosition = DS_AMT_MASTER.NameValueRow("APP_S_DT",appSDt);
            break;
        case 3:
            GD_AMT_SCTN_MASTER.Focus();
            DS_AMT_SCTN_MASTER.RowPosition = DS_AMT_SCTN_MASTER.NameValueRow("APP_S_DT",appSDt);
            break;
    }

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
 * 작 성 일 : 2010-02-18
 * 개    요 :  행 추가 
 * return값 : void
 */
function btn_addRow( gubn){
    var dataSet;
    var grid;
    var dfClum;
    var row;
    var masterRow = DS_MASTER.RowPosition;
    if( masterRow < 1 ){
        showMessage(INFORMATION, OK, "USER-1013");
        LC_STR_CD.Focus();
        return;
    }
    var strCd = DS_MASTER.NameValue(masterRow,"STR_CD");
    var pumbunCd = DS_MASTER.NameValue(masterRow,"PUMBUN_CD");
    switch(gubn){
        case '10': //NORMAL
            dataSet = DS_NRML_MASTER;
            grid = GD_NRML_MASTER;
            dfClum = "EVENT_FLAG";
            
            if(hasAddRow(DS_NRML_MASTER)){
                showMessage(INFORMATION, OK, "USER-1078");
                return;
            }

            for(var i = 1; i <= DS_NRML_MASTER.CountRow; i++ ) {
            	DS_NRML_MASTER.UserStatus(i) = 1;
            }
            DS_NRML_MASTER.AddRow();
            row = DS_NRML_MASTER.CountRow;
            DS_NRML_MASTER.NameValue(row,"STR_CD") = strCd;
            DS_NRML_MASTER.NameValue(row,"PUMBUN_CD") = pumbunCd;
            DS_NRML_MASTER.NameValue(row,"EVENT_RATE") = "00";
            DS_NRML_MASTER.NameValue(row,"APP_E_DT") = "99991231";
            break;
        case '21': //AMT_DT
            dataSet = DS_AMT_MASTER;
            grid = GD_AMT_MASTER;
            dfClum = "APP_S_DT";

            if(hasAddRow(DS_AMT_MASTER)){
                showMessage(INFORMATION, OK, "USER-1078");
                return;
            }
            for(var i = 1; i <= DS_AMT_MASTER.CountRow; i++ ) {
            	DS_AMT_MASTER.UserStatus(i) = 1;
            }
            DS_AMT_MASTER.AddRow();
            row = DS_AMT_MASTER.CountRow;
            DS_AMT_MASTER.NameValue(row,"STR_CD") = strCd;
            DS_AMT_MASTER.NameValue(row,"PUMBUN_CD") = pumbunCd;
            DS_AMT_MASTER.NameValue(row,"EVENT_RATE") = "00";
            DS_AMT_MASTER.NameValue(row,"APP_S_DT") = getDataMaxDt(DS_AMT_MASTER, null, "Y");
            DS_AMT_MASTER.NameValue(row,"APP_E_DT") = "99991231";
            break;
        case '22': //AMT_MAGIN
            dataSet = DS_AMT_DETAIL;
            grid = GD_AMT_DETAIL;
            dfClum = "EVENT_FLAG";
            var amtMstRow = DS_AMT_MASTER.RowPosition;
            if( amtMstRow < 1){
                showMessage(INFORMATION, OK, "USER-1042", "적용일");
                GD_AMT_MASTER.Focus();
                return;            	
            }
            var appSDt = DS_AMT_MASTER.NameValue(amtMstRow,'APP_S_DT');
            var appeDt = DS_AMT_MASTER.NameValue(amtMstRow,'APP_E_DT');
            if( appSDt == ""){
                showMessage(INFORMATION, OK, "USER-1003", "적용시작일");
                setFocusGrid(GD_AMT_MASTER, DS_AMT_MASTER, amtMstRow, 'APP_S_DT');
                return;             
            }
            DS_AMT_DETAIL.AddRow();
            row = DS_AMT_DETAIL.CountRow;
            DS_AMT_DETAIL.NameValue(row,"STR_CD") = strCd;
            DS_AMT_DETAIL.NameValue(row,"PUMBUN_CD") = pumbunCd;
            DS_AMT_DETAIL.NameValue(row,"EVENT_RATE") = "00";
            DS_AMT_DETAIL.NameValue(row,"APP_S_DT") = appSDt;
            DS_AMT_DETAIL.NameValue(row,"APP_E_DT") = appeDt;
            break;
        case '31': //AMT_SCTN_DT
            dataSet = DS_AMT_SCTN_MASTER;
            grid = GD_AMT_SCTN_MASTER;
            dfClum = "APP_S_DT";

            if(hasAddRow(DS_AMT_SCTN_MASTER)){
                showMessage(INFORMATION, OK, "USER-1078");
                return;
            }
            for(var i = 1; i <= DS_AMT_SCTN_MASTER.CountRow; i++ ) {
            	DS_AMT_SCTN_MASTER.UserStatus(i) = 1;
            }
            DS_AMT_SCTN_MASTER.AddRow();
            row = DS_AMT_SCTN_MASTER.CountRow;
            DS_AMT_SCTN_MASTER.NameValue(row,"STR_CD") = strCd;
            DS_AMT_SCTN_MASTER.NameValue(row,"PUMBUN_CD") = pumbunCd;
            DS_AMT_SCTN_MASTER.NameValue(row,"EVENT_RATE") = "00";
            DS_AMT_SCTN_MASTER.NameValue(row,"APP_S_DT") = getDataMaxDt(DS_AMT_SCTN_MASTER, null, "Y");
            DS_AMT_SCTN_MASTER.NameValue(row,"APP_E_DT") = "99991231";
            break;
        case '32': //AMT_SCTN_MAGIN
            dataSet = DS_AMT_SCTN_DETAIL;
            grid = GD_AMT_SCTN_DETAIL;
            dfClum = "EVENT_FLAG";

            var amtSctnMstRow = DS_AMT_SCTN_MASTER.RowPosition;
            if( amtSctnMstRow < 1){
                showMessage(INFORMATION, OK, "USER-1042", "적용일");
                GD_AMT_SCTN_MASTER.Focus();
                return;             
            }
            var appSDt = DS_AMT_SCTN_MASTER.NameValue(amtSctnMstRow,'APP_S_DT');
            var appEDt = DS_AMT_SCTN_MASTER.NameValue(amtSctnMstRow,'APP_E_DT');
            if( appSDt == ""){
                showMessage(INFORMATION, OK, "USER-1003", "적용시작일");
                setFocusGrid(GD_AMT_SCTN_MASTER, DS_AMT_SCTN_MASTER, amtSctnMstRow, 'APP_S_DT');
                return;             
            }
            DS_AMT_SCTN_DETAIL.AddRow();
            row = DS_AMT_SCTN_DETAIL.CountRow;
            DS_AMT_SCTN_DETAIL.NameValue(row,"STR_CD") = strCd;
            DS_AMT_SCTN_DETAIL.NameValue(row,"PUMBUN_CD") = pumbunCd;
            DS_AMT_SCTN_DETAIL.NameValue(row,"EVENT_RATE") = "00";
            DS_AMT_SCTN_DETAIL.NameValue(row,"APP_S_DT") = appSDt;
            DS_AMT_SCTN_DETAIL.NameValue(row,"APP_E_DT") = appEDt;
            break;
    }

    setFocusGrid(grid, dataSet, row, dfClum);
}

/**
 * btn_delRow()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  행 삭제 
 * return값 : void
 */
function btn_delRow( gubn){
	var dataSet;
	var grid;
    switch(gubn){
        case '10': //NORMAL
        	dataSet = DS_NRML_MASTER;
        	grid = GD_NRML_MASTER;
            break;
        case '21': //AMT_DT
            dataSet = DS_AMT_MASTER;
            grid = GD_AMT_MASTER;
            break;
        case '22': //AMT_MAGIN
            dataSet = DS_AMT_DETAIL;
            grid = GD_AMT_DETAIL;
            break;
        case '31': //AMT_SCTN_DT
            dataSet = DS_AMT_SCTN_MASTER;
            grid = GD_AMT_SCTN_MASTER;
            break;
        case '32': //AMT_SCTN_MAGIN
            dataSet = DS_AMT_SCTN_DETAIL;
            grid = GD_AMT_SCTN_DETAIL;
            break;
    }
    
    if(dataSet.CountRow < 1){
        showMessage(INFORMATION, OK, "USER-1019");
        if(DS_MASTER.CountRow < 1){
            LC_STR_CD.Focus();
        }else{
            GD_MASTER.Focus();
        }
        return;     
    }
    var row = dataSet.RowPosition;
    var ckeckYn = dataSet.SysStatus( row );
    if(ckeckYn != "1"){
        showMessage(INFORMATION, OK, "USER-1052");
        grid.Focus();
        return;
    }
    switch(gubn){
        case '21': //AMT_DT
            if( DS_AMT_DETAIL.CountRow > 0){
                showMessage(INFORMATION, OK, "USER-1046");
                GD_AMT_DETAIL.Focus();
                return;
            }
            break;
        case '31': //AMT_SCTN_DT
            if( DS_AMT_SCTN_DETAIL.CountRow > 0){
                showMessage(INFORMATION, OK, "USER-1046");
                GD_AMT_SCTN_DETAIL.Focus();
                return;
            }
            break;    
    }
    dataSet.DeleteRow(row);
    dataSet.ResetUserStatus();
}
/**
 * hasAddRow()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  데이터셋에 행추가된 로우가 존재하는지 여부
 * return값 : void
 */
function hasAddRow( dataSet ){
	if( dataSet.CountRow < 1)
	    return false;
	
	for( var i=1; i<=dataSet.CountRow; i++){
		if(dataSet.SysStatus(i) == "1")
			return true;
	}
	return false;
}
/**
 * getDataMaxDt()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  데이터셋을 시작일중 가장 큰 일자를 조회한다.
 * return값 : void
 */
function getDataMaxDt(dataSet, eventFlag, addDayYn){
    var toDay = getTodayFormat("YYYYMMDD");
    var nextDay = addDate('D',1,toDay,"");
    var maxAppSDt;
    if(eventFlag == null){
    	maxAppSDt = getMaxData( dataSet, "APP_S_DT", true );
    }else{
    	maxAppSDt = getMaxData( dataSet, "APP_S_DT", true, "EVENT_FLAG", eventFlag );
    }
    if(addDayYn == 'Y')
        maxAppSDt = maxAppSDt!=''?addDate('D',1,maxAppSDt,""):'';
    maxAppSDt = (maxAppSDt!=''&&maxAppSDt>toDay)?maxAppSDt:nextDay;
    
    return maxAppSDt;
}
/**
 * searchMaster()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  혐력사의 브랜드 리스트 조회
 * return값 : void
 */
function searchMaster(){

    DS_MASTER.ClearData();
    DS_AMT_MASTER.ClearData();
    DS_AMT_DETAIL.ClearData();
    DS_AMT_SCTN_MASTER.ClearData();
    DS_AMT_SCTN_DETAIL.ClearData();
    
    var strStrCd          = LC_STR_CD.BindColVal;
    var strVenCd          = EM_VEN_CD.Text;
    var strVenName        = EM_VEN_NAME.Text;
    var strPumbunCd       = EM_PUMBUN_CD.Text;
    var strPumbunName     = EM_PUMBUN_NAME.Text;
    var strRentbMgappFlag = LC_RENTB_MGAPP_FLAG.BindColVal;

    
    var goTo       = "searchMaster" ;    
    var action     = "O";  
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                   + "&strVenCd="+encodeURIComponent(strVenCd)
                   + "&strVenName="+encodeURIComponent(strVenName)
                   + "&strPumbunCd="+encodeURIComponent(strPumbunCd)
                   + "&strPumbunName="+encodeURIComponent(strPumbunName)
                   + "&strRentbMgappFlag="+encodeURIComponent(strRentbMgappFlag);
    TR_SUB.Action="/dps/pcod303.pc?goTo="+goTo+parameters;      
    TR_SUB.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_SUB.Post();    
    
    //조회후 결과표시
    setPorcCount("SELECT",GD_MASTER);  

} 
/**
 * searchDetail()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  상세정보 조회
 * return값 : void
 */
function searchDetail(row){
	var mgappFlag = DS_MASTER.NameValue( row, "RENTB_MGAPP_FLAG");
	var strCd = DS_MASTER.NameValue( row, "STR_CD");
    var pumbunCd = DS_MASTER.NameValue( row, "PUMBUN_CD");
    DS_AMT_MASTER.ClearData();
    DS_AMT_DETAIL.ClearData();
    DS_AMT_SCTN_MASTER.ClearData();
    DS_AMT_SCTN_DETAIL.ClearData();
    btnAddDelEnableCnt( false);
	switch(mgappFlag){
	    case '1':
	    	setTabItemIndex("TAB_MAIN", 1);
	    	searchMargin("DS_NRML_MASTER", strCd, pumbunCd);
	        btnAddDelEnableCnt( true, "10");
	        //조회후 결과표시
	        setPorcCount("SELECT",GD_NRML_MASTER);  	    	
	    	break;
        case '2':
            setTabItemIndex("TAB_MAIN", 2);
            bfAmtMasterRow = 0;
            searchMarginDt("DS_AMT_MASTER", strCd, pumbunCd);
            btnAddDelEnableCnt( true, "21");
            //btnAddDelEnableCnt( true, "22");
            //조회후 결과표시
            setPorcCount("SELECT",GD_AMT_MASTER);  
            break;
        case '3':
            setTabItemIndex("TAB_MAIN", 3);
            bfAmtSctnMasterRow = 0;
            searchMarginDt("DS_AMT_SCTN_MASTER", strCd, pumbunCd);
            btnAddDelEnableCnt( true, "31");
            //btnAddDelEnableCnt( true, "32");
            //조회후 결과표시
            setPorcCount("SELECT",GD_AMT_SCTN_MASTER);  
            break;
	}
} 
/**
 * searchDetail2()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  상세정보 조회
 * return값 : void
 */
function searchDetail2(dataSet, row, toGrid){
	if( dataSet.SysStatus(row) == "1"){
		eval(toGrid.DataID).ClearData();
        return;		
	}
	
    var strCd = dataSet.NameValue( row, "STR_CD");
    var pumbunCd = dataSet.NameValue( row, "PUMBUN_CD");
    var appSDt = dataSet.NameValue( row, "APP_S_DT");
    searchMargin(toGrid.DataID, strCd, pumbunCd, appSDt);
    //조회후 결과표시
    setPorcCount("SELECT", eval(toGrid.DataID).CountRow);  
} 

/**
 * searchMargin()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  마진정보 조회
 * return값 : void
 */
function searchMargin( dataSetId , strCd, pumbunCd , appSDt){
	
    var goTo       = "searchMargin";    
    var action     = "O";  
    var parameters = "&strStrCd="+encodeURIComponent(strCd)
                   + "&strPumbunCd="+encodeURIComponent(pumbunCd)
                   + "&strAppSDt="+encodeURIComponent(appSDt==null?'':appSDt);
    TR_MAIN.Action="/dps/pcod303.pc?goTo="+goTo+parameters;      
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MARGIN="+dataSetId+")"; //조회는 O
    TR_MAIN.Post();    
} 

/**
 * searchMarginDt()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  마진 적용일 정보  조회
 * return값 : void
 */

function searchMarginDt( dataSetId , strCd, pumbunCd ){
     
    var goTo       = "searchMarginDt";    
    var action     = "O";  
    var parameters = "&strStrCd="+encodeURIComponent(strCd)
                   + "&strPumbunCd="+encodeURIComponent(pumbunCd);
    TR_SUB2.Action="/dps/pcod303.pc?goTo="+goTo+parameters;      
    TR_SUB2.KeyValue="SERVLET("+action+":DS_MARGIN_DT="+dataSetId+")"; //조회는 O
    TR_SUB2.Post();    
} 

/**
 * setVenCode()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-28
 * 개    요 : 협력사 팝업을 실행한다.
 * return값 : void
**/

function getVenCode(evnFlag){
    var codeObj = EM_VEN_CD;
    var nameObj = EM_VEN_NAME;
    
    if( evnFlag == 'POP'){
        venPop(codeObj,nameObj,LC_STR_CD.BindColVal,'','','5');
        codeObj.Focus();
        return;
    }

    if( codeObj.Text =="" ){
        nameObj.Text = "";
        return;
    }
        
    setVenNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj , 0, LC_STR_CD.BindColVal,'','','5');
}


/**
 * setPumbunCode()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-28
 * 개    요 : 브랜드 팝업을 실행한다.
 * return값 : void
**/
function getPumbunCode(evnFlag){

	var codeObj = EM_PUMBUN_CD;
	var nameObj = EM_PUMBUN_NAME;
	
	if( evnFlag == 'POP'){
        strPbnPop(codeObj,nameObj,'N','',LC_STR_CD.BindColVal,'','','','','','','','','5');
        codeObj.Focus();        
        return;
    }
    
    if( codeObj.Text == ""){
        nameObj.Text = "";
        return;
    }
    
    setStrPbnNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj , 'N', 0,'',LC_STR_CD.BindColVal,'','','','','','','','','5');
}

/**
 * setCalData()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  달력 팝업 실행
 * return값 : void
 */
function setCalData( evnFlag, grid, row){
	var dataSet = eval(grid.DataID);
	if(grid.id=="GD_NRML_MASTER"){
		if(dataSet.NameValue(row,"EVENT_FLAG") == ""){
	        showMessage(INFORMATION, OK, "USER-1000", "행사구분을 입력하세요.");
            dataSet.NameValue(row,"APP_S_DT") = "";
	        setTimeout('setFocusGrid(GD_NRML_MASTER,DS_NRML_MASTER,'+row+',"EVENT_FLAG");',50);
	        return;
		}
	}
	
    if( evnFlag == 'POP'){
        openCal(grid,row,"APP_S_DT");
    }
    var maxAppSDt;
    var insMaxAppSDt = "";
    if(grid.id=="GD_NRML_MASTER"){
        maxAppSDt = getDataMaxDt(dataSet,dataSet.NameValue(dataSet.RowPosition,"EVENT_FLAG"));
        if(dataSet.SysStatus(row)=="1"){
            var cnt = getNameValueCount(dataSet,"EVENT_FLAG",dataSet.NameValue(dataSet.RowPosition,"EVENT_FLAG"));
            insMaxAppSDt = cnt<2?maxAppSDt:addDate('D',1,maxAppSDt,"");
        }
    }else{
        maxAppSDt = getDataMaxDt(dataSet);
        if(dataSet.SysStatus(row)=="1"){
            insMaxAppSDt = dataSet.CountRow<2?maxAppSDt:addDate('D',1,maxAppSDt,"");
        }
    }
    if(!checkDateTypeYMD( grid ,"APP_S_DT", insMaxAppSDt))
       return;
    var rowStatus = dataSet.SysStatus(row);
    
    if( rowStatus == "1" ? (dataSet.NameValue(row,"APP_S_DT") < maxAppSDt):(dataSet.NameValue(row,"APP_S_DT") != maxAppSDt)){
        showMessage(INFORMATION, OK, "USER-1000","적용시작일은 익일 이 후 면서<br>등록된 기간 중 가장 큰 일자 이어야 합니다.");
        if(dataSet.SysStatus(row)=="1"){
            dataSet.NameValue(row,"APP_S_DT") = insMaxAppSDt;
        } else{
            dataSet.NameValue(row,"APP_S_DT") = dataSet.OrgNameValue(row,"APP_S_DT");        	
        }
    }
    if( rowStatus !="1" && dataSet.NameValue(row,"APP_S_DT") != dataSet.OrgNameValue(row,"APP_S_DT")){
    	if( grid.id=="GD_NRML_MASTER"){
            btnAddDelEnableCnt( false, '10')    		
    	}else if( grid.id=="GD_AMT_MASTER"){
            btnAddDelEnableCnt( false, '21')            
        }else if( grid.id=="GD_AMT_SCTN_MASTER"){
            btnAddDelEnableCnt( false, '31')            
        }
    		
    }
}

/**
 * btnAddDelEnableCnt()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 행추가삭제 버튼 선택여부 제어
 * return값 : void
 */
function btnAddDelEnableCnt( flag, gubn){

	if(gubn==null){
	    enableControl(IMG_ADD_ROW_10 , flag);  // 기간
	    enableControl(IMG_DEL_ROW_10 , flag);  // 기간
	    enableControl(IMG_ADD_ROW_21 , flag);  // 금액마스터
	    enableControl(IMG_DEL_ROW_21 , flag);  // 금액마스터
	    enableControl(IMG_ADD_ROW_22 , flag);  // 금액상세
	    enableControl(IMG_DEL_ROW_22 , flag);  // 금액상세
// 	    enableControl(IMG_ADD_ROW_31 , flag);  // 금액기간마스터
// 	    enableControl(IMG_DEL_ROW_31 , flag);  // 금액기간마스터
// 	    enableControl(IMG_ADD_ROW_32 , flag);  // 금액기간상세
// 	    enableControl(IMG_DEL_ROW_32 , flag);  // 금액기간상세
        return;
	}
    eval("enableControl(IMG_ADD_ROW_"+gubn+","+flag+")");
	eval("enableControl(IMG_DEL_ROW_"+gubn+","+flag+")");
}

/**
 * checkValidation()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 입력 값을 검증한다.
 * return값 : void
 */
function checkValidation( gubn){
	var grid;
	var dataSet;
    var row;
    var colid;
    var errYn = false;
    var lowMgRate = DS_MASTER.NameValue(DS_MASTER.RowPosition,"LOW_MG_RATE");
    switch(gubn){
        case 1:
        	grid = GD_NRML_MASTER;
        	dataSet = DS_NRML_MASTER;
            var dupRow = checkDupKey(dataSet,"EVENT_FLAG||APP_S_DT");
            if( dupRow > 0){
                showMessage(EXCLAMATION, OK, "USER-1044");
                row = dupRow;
                colid = "EVENT_FLAG";
                errYn = true;
                break;
            }
            
            for(var i=1; i<=dataSet.CountRow; i++){
                var rowStatus = dataSet.SysStatus(i);
                if( !(rowStatus == "1" || rowStatus == "3") )
                    continue;
                row = i;
                if( dataSet.NameValue(i,"EVENT_FLAG")=="" ){
                    showMessage(EXCLAMATION, OK, "USER-1003", "행사구분");
                    errYn = true;
                    colid = "EVENT_FLAG";
                    break;
                }
                if ( replaceStr(dataSet.NameValue(i,"EVENT_FLAG")," ","").length != 2 ) {
                    showMessage(EXCLAMATION, OK, "USER-1027","행사구분","2");
                    errYn = true;
                    colid = "EVENT_FLAG";
                    break;
                }
                if ( !isNumberStr(dataSet.NameValue(i,"EVENT_FLAG")) ) {
                    showMessage(Information, OK, "USER-1005","행사구분");
                    errYn = true;
                    colid = "EVENT_FLAG";
                    break;
                }
                if( Number(dataSet.NameValue(i,"EVENT_FLAG"))>10){
                	showMessage(Information, OK, "USER-1021","행사구분", '10');
                    errYn = true;
                    colid = "EVENT_FLAG";
                    break;
                }
                if( dataSet.NameString(i,"NORM_MG_RATE")==""){
                    showMessage(EXCLAMATION, OK, "USER-1036", "마진율");
                    colid = "NORM_MG_RATE";    
                    errYn = true;
                    break;
                }
                if( dataSet.NameValue(i,"NORM_MG_RATE") < lowMgRate){
                    showMessage(EXCLAMATION, OK, "USER-1020", "마진율","최저마진율("+lowMgRate+")");
                    colid = "NORM_MG_RATE";    
                    errYn = true;
                    break;
                }
                if( Number(dataSet.NameValue(i,"NORM_MG_RATE"))<0){
                    showMessage(EXCLAMATION, OK, "USER-10020", "마진율", 0);
                    errYn = true;
                    colid = "NORM_MG_RATE";
                    break;
                }

                if( Number(dataSet.NameValue(i,"NORM_MG_RATE"))==0){
                    errYn = showMessage(EXCLAMATION, YESNO, "USER-1000", "마진율이 0입니다. 등록하시겠습니까?") != 1;
                    colid = "NORM_MG_RATE";    
                    if(errYn)
                        break;
                }
                
                if( dataSet.NameValue(i,"APP_S_DT")==""){
                    showMessage(EXCLAMATION, OK, "USER-1003", "적용시작일");
                    errYn = true;
                    colid = "APP_S_DT";
                    break;
                }
                if( dataSet.NameValue(i,"APP_S_DT") != dataSet.OrgNameValue(i,"APP_S_DT") || rowStatus == "1"){
                    var appSdtMax = getDataMaxDt(dataSet, dataSet.NameValue(i,"EVENT_FLAG"));
                    if( rowStatus == "1"?(dataSet.NameValue(i,"APP_S_DT") < appSdtMax):(dataSet.NameValue(i,"APP_S_DT") != appSdtMax)){
                        showMessage(INFORMATION, OK, "USER-1000","적용시작일은 익일 이 후 면서<br>등록된 기간 중 가장 큰 일자 이어야 합니다.");
                        errYn = true;
                        colid = "APP_S_DT";
                        break;
                    }                	
                }
            }
        	break;
        case 2:
            grid = GD_AMT_MASTER;
            dataSet = DS_AMT_MASTER;
            var dupRow = checkDupKey(dataSet,"APP_S_DT");
            if( dupRow > 0){
                showMessage(EXCLAMATION, OK, "USER-1044");
                row = dupRow;
                colid = "APP_S_DT";
                errYn = true;
                break;
            }
            
            for(var i=1; i<=dataSet.CountRow; i++){
                var rowStatus = dataSet.SysStatus(i);
                if( !(rowStatus == "1" || rowStatus == "3") )
                    continue;
                row = i;
                
                if( dataSet.NameValue(i,"APP_S_DT")==""){
                    showMessage(EXCLAMATION, OK, "USER-1003", "적용시작일");
                    errYn = true;
                    colid = "APP_S_DT";
                    break;
                }
                if( dataSet.NameValue(i,"APP_S_DT") != dataSet.OrgNameValue(i,"APP_S_DT") || rowStatus == "1"){
                    var appSdtMax = getDataMaxDt(dataSet);
                    if( rowStatus == "1"?(dataSet.NameValue(i,"APP_S_DT") < appSdtMax):(dataSet.NameValue(i,"APP_S_DT") != appSdtMax)){
                        showMessage(INFORMATION, OK, "USER-1000","적용시작일은 익일 이 후 면서<br>등록된 기간 중 가장 큰 일자 이어야 합니다.");
                        errYn = true;
                        colid = "APP_S_DT";
                        break;
                    }                	
                }
            }

            grid = GD_AMT_DETAIL;
            dataSet = DS_AMT_DETAIL;
            if(dataSet.CountRow < 1){
                showMessage(EXCLAMATION, OK, "USER-1000","하위데이터가 존재하지 않습니다.<br>하위 데이터를 입력하세요");
                row = 1;
                colid = "EVENT_FLAG";
                errYn = true;
                break;            	
            }
            var dupRow = checkDupKey(dataSet,"EVENT_FLAG");
            if( dupRow > 0){
                showMessage(EXCLAMATION, OK, "USER-1044");
                row = dupRow;
                colid = "EVENT_FLAG";
                errYn = true;
                break;
            }
            
            for(var i=1; i<=dataSet.CountRow; i++){
                var rowStatus = dataSet.SysStatus(i);
                if( !(rowStatus == "1" || rowStatus == "3") )
                    continue;
                row = i;
                if( dataSet.NameValue(i,"EVENT_FLAG")=="" ){
                    showMessage(EXCLAMATION, OK, "USER-1003", "행사구분");
                    errYn = true;
                    colid = "EVENT_FLAG";
                    break;
                }
                if ( replaceStr(dataSet.NameValue(i,"EVENT_FLAG")," ","").length != 2 ) {
                    showMessage(EXCLAMATION, OK, "USER-1027","행사구분","2");
                    errYn = true;
                    colid = "EVENT_FLAG";
                    break;
                }
                if ( !isNumberStr(dataSet.NameValue(i,"EVENT_FLAG")) ) {
                    showMessage(EXCLAMATION, OK, "USER-1005","행사구분");
                    errYn = true;
                    colid = "EVENT_FLAG";
                    break;
                }
                if( Number(dataSet.NameValue(i,"EVENT_FLAG"))>10){
                    showMessage(Information, OK, "USER-1021","행사구분", '10');
                    errYn = true;
                    colid = "EVENT_FLAG";
                    break;
                }
                if( dataSet.NameValue(i,"BAS_AMT")==""){
                    showMessage(EXCLAMATION, OK, "USER-1008", "기준금액", 0);
                    colid = "BAS_AMT";    
                    errYn = true;
                    break;
                }
                if( dataSet.NameString(i,"NORM_MG_RATE")==""){
                    showMessage(EXCLAMATION, OK, "USER-1036", "마진율");
                    colid = "NORM_MG_RATE";    
                    errYn = true;
                    break;
                }
                if( dataSet.NameValue(i,"NORM_MG_RATE") < lowMgRate){
                    showMessage(EXCLAMATION, OK, "USER-1020", "마진율","최저마진율("+lowMgRate+")");
                    colid = "NORM_MG_RATE";    
                    errYn = true;
                    break;
                }
                if( Number(dataSet.NameValue(i,"NORM_MG_RATE"))<0){
                    showMessage(EXCLAMATION, OK, "USER-10020", "마진율", 0);
                    errYn = true;
                    colid = "NORM_MG_RATE";
                    break;
                }

                if( Number(dataSet.NameValue(i,"NORM_MG_RATE"))==0){
                	errYn = showMessage(EXCLAMATION, YESNO, "USER-1000", "마진율이 0입니다. 등록하시겠습니까?") != 1;
                    colid = "NORM_MG_RATE";    
                    if(errYn)
                        break;
                }
                if( dataSet.NameValue(i,"NORM_MG_RATE") > 100){
                    showMessage(EXCLAMATION, OK, "USER-1021", "마진율",100);
                    colid = "NORM_MG_RATE";    
                    errYn = true;
                    break;
                }                
            }
            break;
        case 3:
            grid = GD_AMT_SCTN_MASTER;
            dataSet = DS_AMT_SCTN_MASTER;
            var dupRow = checkDupKey(dataSet,"APP_S_DT");
            if( dupRow > 0){
                showMessage(EXCLAMATION, OK, "USER-1044");
                row = dupRow;
                colid = "APP_S_DT";
                errYn = true;
                break;
            }
            
            for(var i=1; i<=dataSet.CountRow; i++){
                var rowStatus = dataSet.SysStatus(i);
                if( !(rowStatus == "1" || rowStatus == "3") )
                    continue;
                row = i;
                
                if( dataSet.NameValue(i,"APP_S_DT")==""){
                    showMessage(EXCLAMATION, OK, "USER-1003", "적용시작일");
                    errYn = true;
                    colid = "APP_S_DT";
                    break;
                }
                if( dataSet.NameValue(i,"APP_S_DT") != dataSet.OrgNameValue(i,"APP_S_DT") || rowStatus == "1"){
                    var appSdtMax = getDataMaxDt(dataSet);
                    if( rowStatus == "1"?(dataSet.NameValue(i,"APP_S_DT") < appSdtMax):(dataSet.NameValue(i,"APP_S_DT") != appSdtMax)){
                        showMessage(INFORMATION, OK, "USER-1000","적용시작일은 익일 이 후 면서<br>등록된 기간 중 가장 큰 일자 이어야 합니다.");
                        errYn = true;
                        colid = "APP_S_DT";
                        break;
                    }
                }
            }

            grid = GD_AMT_SCTN_DETAIL;
            dataSet = DS_AMT_SCTN_DETAIL;
            if(dataSet.CountRow < 1){
                showMessage(EXCLAMATION, OK, "USER-1000","하위데이터가 존재하지 않습니다.<br>하위 데이터를 입력하세요");
                row = 1;
                colid = "EVENT_FLAG";
                errYn = true;
                break;              
            }
            var dupRow = checkDupKey(dataSet,"EVENT_FLAG");
            if( dupRow > 0){
                showMessage(EXCLAMATION, OK, "USER-1044");
                row = dupRow;
                colid = "EVENT_FLAG";
                errYn = true;
                break;
            }
            var dupRow = checkDupKey(dataSet,"BAS_AMT");
            if( dupRow > 0){
                showMessage(EXCLAMATION, OK, "USER-1044");
                row = dupRow;
                colid = "BAS_AMT";
                errYn = true;
                break;
            }
            
            for(var i=1; i<=dataSet.CountRow; i++){
                var rowStatus = dataSet.SysStatus(i);
                if( !(rowStatus == "1" || rowStatus == "3") )
                    continue;
                row = i;
                if( dataSet.NameValue(i,"EVENT_FLAG")=="" ){
                    showMessage(EXCLAMATION, OK, "USER-1003", "행사구분");
                    errYn = true;
                    colid = "EVENT_FLAG";
                    break;
                }
                if ( replaceStr(dataSet.NameValue(i,"EVENT_FLAG")," ","").length != 2 ) {
                    showMessage(EXCLAMATION, OK, "USER-1027","행사구분","2");
                    errYn = true;
                    colid = "EVENT_FLAG";
                    break;
                }
                if ( !isNumberStr(dataSet.NameValue(i,"EVENT_FLAG")) ) {
                    showMessage(EXCLAMATION, OK, "USER-1005","행사구분");
                    errYn = true;
                    colid = "EVENT_FLAG";
                    break;
                }
                if( Number(dataSet.NameValue(i,"EVENT_FLAG"))>10){
                    showMessage(Information, OK, "USER-1021","행사구분", '10');
                    errYn = true;
                    colid = "EVENT_FLAG";
                    break;
                }
                if( dataSet.NameValue(i,"BAS_AMT")==""){
                    showMessage(EXCLAMATION, OK, "USER-1008", "금액구간 끝", 0);
                    colid = "BAS_AMT";    
                    errYn = true;
                    break;
                }
                if( dataSet.NameString(i,"NORM_MG_RATE")==""){
                    showMessage(EXCLAMATION, OK, "USER-1036", "마진율");
                    colid = "NORM_MG_RATE";    
                    errYn = true;
                    break;
                }
                if( dataSet.NameValue(i,"NORM_MG_RATE") < lowMgRate){
                    showMessage(EXCLAMATION, OK, "USER-1020", "마진율","최저마진율("+lowMgRate+")");
                    colid = "NORM_MG_RATE";    
                    errYn = true;
                    break;
                }                
                if( Number(dataSet.NameValue(i,"NORM_MG_RATE"))<0){
                    showMessage(EXCLAMATION, OK, "USER-10020", "마진율", 0);
                    errYn = true;
                    colid = "NORM_MG_RATE";
                    break;
                }

                if( Number(dataSet.NameValue(i,"NORM_MG_RATE"))==0){
                    errYn = showMessage(EXCLAMATION, YESNO, "USER-1000", "마진율이 0입니다. 등록하시겠습니까?") != 1;
                    colid = "NORM_MG_RATE";    
                    if(errYn)
                        break;
                }
                if( dataSet.NameValue(i,"NORM_MG_RATE") > 100){
                    showMessage(EXCLAMATION, OK, "USER-1021", "마진율",100);
                    colid = "NORM_MG_RATE";    
                    errYn = true;
                    break;
                }                
            }
            break;
    }    
    if(errYn){
        setFocusGrid(grid,dataSet,row,colid);
        return false;
    }
    return true;
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
<script language=JavaScript for=TR_SUB2 event=onSuccess>
    for(i=0;i<TR_SUB2.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_SUB2.SrvErrMsg('UserMsg',i));
    }
</script>


<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_SUB event=onFail>
    trFailed(TR_SUB.ErrorMsg);
</script>
<script language=JavaScript for=TR_SUB2 event=onFail>
    trFailed(TR_SUB2.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_NRML_MASTER event=OnDataError(row,colid)>
    var errorCode = DS_NRML_MASTER.ErrorCode;
    if(errorCode == "50019"){
        showMessage(EXCLAMATION, OK, "USER-1044");
    }else if( errorCode == "50018"){
    	if(colid=='EVENT_FLAG')
    	    showMessage(EXCLAMATION, OK, "USER-1003", "행사구분");
    	else if(colid=='APP_S_DT')
            showMessage(EXCLAMATION, OK, "USER-1003", "적용시작일");
    }else{
        showMessage(EXCLAMATION, OK, "USER-1000",DS_NRML_MASTER.ErrorMsg);       
    }
</script>
<script language=JavaScript for=DS_AMT_MASTER event=OnDataError(row,colid)>
    var errorCode = DS_AMT_MASTER.ErrorCode;
    if(errorCode == "50019"){
        showMessage(EXCLAMATION, OK, "USER-1044");
    }else if( errorCode == "50018"){
    	if(colid=='APP_S_DT')
            showMessage(EXCLAMATION, OK, "USER-1003", "적용시작일");
    }else{
        showMessage(EXCLAMATION, OK, "USER-1000",DS_AMT_MASTER.ErrorMsg);       
    }
</script>
<script language=JavaScript for=DS_AMT_DETAIL event=OnDataError(row,colid)>
    var errorCode = DS_AMT_DETAIL.ErrorCode;
    if(errorCode == "50019"){
        showMessage(EXCLAMATION, OK, "USER-1044");
    }else if( errorCode == "50018"){
        if(colid=='EVENT_FLAG')
            showMessage(EXCLAMATION, OK, "USER-1003", "행사구분");
    }else{
        showMessage(EXCLAMATION, OK, "USER-1000",DS_AMT_DETAIL.ErrorMsg);       
    }
</script>
<script language=JavaScript for=DS_AMT_SCTN_MASTER event=OnDataError(row,colid)>
    var errorCode = DS_AMT_SCTN_MASTER.ErrorCode;
    if(errorCode == "50019"){
        showMessage(EXCLAMATION, OK, "USER-1044");
    }else if( errorCode == "50018"){
        if(colid=='APP_S_DT')
            showMessage(EXCLAMATION, OK, "USER-1003", "적용시작일");
    }else{
        showMessage(EXCLAMATION, OK, "USER-1000",DS_AMT_SCTN_MASTER.ErrorMsg);       
    }
</script>
<script language=JavaScript for=DS_AMT_SCTN_DETAIL event=OnDataError(row,colid)>
    var errorCode = DS_AMT_SCTN_DETAIL.ErrorCode;
    if(errorCode == "50019"){
        showMessage(EXCLAMATION, OK, "USER-1044");
    }else if( errorCode == "50018"){
        if(colid=='EVENT_FLAG')
            showMessage(EXCLAMATION, OK, "USER-1003", "행사구분");
    }else{
        showMessage(EXCLAMATION, OK, "USER-1000",DS_AMT_SCTN_DETAIL.ErrorMsg);       
    }
</script>
<script language=JavaScript for=DS_MASTER event=CanRowPosChange(row)>
    if(btnSaveYn || row < 1)
        return true;
    
    if( DS_NRML_MASTER.IsUpdated 
            || DS_AMT_MASTER.IsUpdated 
            || DS_AMT_DETAIL.IsUpdated
            || DS_AMT_SCTN_MASTER.IsUpdated 
            || DS_AMT_SCTN_DETAIL.IsUpdated){
        // 변경된 상세내역이 존재합니다. 이동하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1049") != 1){
            return false;
        }
        DS_NRML_MASTER.ClearData();
        DS_AMT_MASTER.ClearData();
        DS_AMT_DETAIL.ClearData();
        DS_AMT_SCTN_MASTER.ClearData();
        DS_AMT_SCTN_DETAIL.ClearData();
    }
    return true;
</script>
<script language=JavaScript for=DS_MASTER event=OnRowPosChanged(row)>
    if(row < 1 || bfMasterRow == row)
        return;
    bfMasterRow = row;
    searchDetail( row);
</script>

<script language=JavaScript for=DS_AMT_MASTER event=CanRowPosChange(row)>
    if(btnSaveYn || row < 1)
        return true;
    if(DS_AMT_MASTER.IsUpdated || DS_AMT_DETAIL.IsUpdated){
        // 변경된 상세내역이 존재합니다. 이동하시겠습니까?)
        if(showMessage(QUESTION, YESNO, "USER-1049")!=1)
            return false;
        bfAmtMasterRow = 0;
        DS_AMT_MASTER.UndoAll();
        DS_AMT_DETAIL.ClearData();
        DS_AMT_MASTER.RowPosition = 0;
    }
    return true;
</script>
<script language=JavaScript for=DS_AMT_MASTER event=OnRowPosChanged(row)>
    if(row < 1 || bfAmtMasterRow == row)
        return;
    bfAmtMasterRow = row;
    searchDetail2( DS_AMT_MASTER, row, GD_AMT_DETAIL);
    // 적용시작되었으면 상세 수정 및 행추가 불가
    var appSDt = DS_AMT_MASTER.NameValue(row,"APP_S_DT");
    if( appSDt < getTodayFormat("YYYYMMDD") && DS_AMT_MASTER.SysStatus(row) !="1"){
    	DS_AMT_DETAIL.Editable = false;
    	btnAddDelEnableCnt( false, "22" );
    }else{
        DS_AMT_DETAIL.Editable = true;
        btnAddDelEnableCnt( true, "22" );
    }
</script>

<script language=JavaScript for=DS_AMT_SCTN_MASTER event=CanRowPosChange(row)>
    if(btnSaveYn || row < 1)
        return true;
    if(DS_AMT_SCTN_MASTER.IsUpdated || DS_AMT_SCTN_DETAIL.IsUpdated){
        // 변경된 상세내역이 존재합니다. 이동하시겠습니까?)
        if(showMessage(QUESTION, YESNO, "USER-1049")!=1)
            return false;
        DS_AMT_SCTN_MASTER.UndoAll();
        DS_AMT_SCTN_DETAIL.ClearData();
        DS_AMT_SCTN_MASTER.RowPosition = 0;
    }
    return true;
</script>
<script language=JavaScript for=DS_AMT_SCTN_MASTER event=OnRowPosChanged(row)>
    if(row < 1 || bfAmtSctnMasterRow == row)
        return;
    bfAmtSctnMasterRow = row;
    searchDetail2( DS_AMT_SCTN_MASTER, row, GD_AMT_SCTN_DETAIL);
    // 적용시작되었으면 상세 수정  불가
    var appSDt = DS_AMT_SCTN_MASTER.NameValue(row,"APP_S_DT");
    if( appSDt < getTodayFormat("YYYYMMDD") && DS_AMT_SCTN_MASTER.SysStatus(row) !="1"){
        DS_AMT_SCTN_DETAIL.Editable = false;
        btnAddDelEnableCnt( false, "32" );
    }else{
    	DS_AMT_SCTN_DETAIL.Editable = true;
        btnAddDelEnableCnt( true, "32" );    	
    }
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid );    
</script>

<!-- 팝업  -->
<script language=JavaScript for=GD_NRML_MASTER event=OnPopup(row,colid,data)>
    if(row < 1){
        return;
    }
    isOnPopup = true;
    switch(colid){
        case 'APP_S_DT':
        	setCalData('POP',GD_NRML_MASTER,row);
        	break;
    }
    isOnPopup = false;
</script>
<script language=JavaScript for=GD_NRML_MASTER event=OnExit(row,colid,olddata)>
    if(row < 1 || isOnPopup){
        return;
    }
    var value = DS_NRML_MASTER.NameValue(row,colid);
    if( value == olddata)
        return;
    switch(colid){
        case 'EVENT_FLAG':
        	if( DS_NRML_MASTER.SysStatus(row) == "1"){
        		if(value == "")
        			DS_NRML_MASTER.NameValue(row,"APP_S_DT") = "";
        		else
        			DS_NRML_MASTER.NameValue(row,"APP_S_DT") = getDataMaxDt(DS_NRML_MASTER,value,"Y");
        	}
            break;    
        case 'APP_S_DT':
            setCalData('NAME',GD_NRML_MASTER,row);
            break;    
    }
</script> 
<!-- 팝업  -->
<script language=JavaScript for=GD_AMT_MASTER event=OnPopup(row,colid,data)>
    if(row < 1){
        return;
    }
    isOnPopup = true;
    switch(colid){
        case 'APP_S_DT':
            setCalData('POP',GD_AMT_MASTER,row);
            break;
    }
    isOnPopup = false;
</script>
<script language=JavaScript for=GD_AMT_MASTER event=OnExit(row,colid,olddata)>
    if(row < 1 || isOnPopup){
        return;
    }
    var value = DS_AMT_MASTER.NameValue(row,colid);
    if( value == olddata)
        return;
    switch(colid){
        case 'APP_S_DT':
            setCalData('NAME',GD_AMT_MASTER,row);
            break;    
    }
</script> 
<!-- 팝업  -->
<script language=JavaScript for=GD_AMT_SCTN_MASTER event=OnPopup(row,colid,data)>
    if(row < 1){
        return;
    }
    isOnPopup = true;
    switch(colid){
        case 'APP_S_DT':
            setCalData('POP',GD_AMT_SCTN_MASTER,row);
            break;
    }
    isOnPopup = false;
</script>
<script language=JavaScript for=GD_AMT_SCTN_MASTER event=OnExit(row,colid,olddata)>
    if(row < 1 || isOnPopup){
        return;
    }
    var value = DS_AMT_SCTN_MASTER.NameValue(row,colid);
    if( value == olddata)
        return;
    switch(colid){
        case 'APP_S_DT':
            setCalData('NAME',GD_AMT_SCTN_MASTER,row);
            break;    
    }
</script> 
<!-- 협력사(조회) -->
<script language=JavaScript for=EM_VEN_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    getVenCode('NAME');
</script>
<!-- 브랜드(조회) -->
<script language=JavaScript for=EM_PUMBUN_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    getPumbunCode('NAME');
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
<comment id="_NSID_"><object id="DS_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_RENTB_MGAPP_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSECHECK"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_NRML_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_AMT_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_AMT_DETAIL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_AMT_SCTN_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_AMT_SCTN_DETAIL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

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
<comment id="_NSID_">
<object id="TR_SUB2" classid=<%=Util.CLSID_TRANSACTION%>>
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
            <th width="80" class="point">점</th>
            <td width="120">
               <comment id="_NSID_">
                 <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=120 tabindex=1 align="absmiddle">
                 </object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="70" >협력사</th>
            <td width="200">
              <comment id="_NSID_">
                <object id=EM_VEN_CD classid=<%=Util.CLSID_EMEDIT%>  width=50  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/detail_search_s.gif"   onclick="javascript:getVenCode('POP');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_VEN_NAME classid=<%=Util.CLSID_EMEDIT%>  width=120  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
            <th width="70" >브랜드</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%>  width=50 tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/detail_search_s.gif"   onclick="javascript:getPumbunCode('POP');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%>  width=120  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th >수수료구분</th>
            <td colspan="5">
               <comment id="_NSID_">
                 <object id=LC_RENTB_MGAPP_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=120 tabindex=1 align="absmiddle">
                 </object>
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
        <td width="350"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
            <td>
              <comment id="_NSID_">
                <object id=GD_MASTER width=100% height=479 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_MASTER">
                </object>
              </comment>
              <script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
        <td class="PL10 "><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td ><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
              <tr>
                <th width="50" >점</th>
                <td width="120">
                  <comment id="_NSID_">
                    <object id=EM_STR_NAME_M classid=<%= Util.CLSID_EMEDIT %> width=120 tabindex=1 align="absmiddle"></object>
                  </comment><script>_ws_(_NSID_);</script>
                </td>
                <th width="50" >브랜드</th>
                <td >
                  <comment id="_NSID_">
                    <object id=EM_PUMBUN_CD_M classid=<%=Util.CLSID_EMEDIT%>  width=50  tabindex=1 align="absmiddle"></object>
                  </comment><script> _ws_(_NSID_);</script>
                  <comment id="_NSID_">
                    <object id=EM_PUMBUN_NAME_M classid=<%=Util.CLSID_EMEDIT%>  width=130  tabindex=1 align="absmiddle"></object>
                  </comment><script> _ws_(_NSID_);</script>
                </td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td class="PT05"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr >
                <td valign="top" >
                  <div id=TAB_MAIN width="100%" height=452 TitleWidth=90 TitleAlign="center" >
                    <menu TitleName="일반"     DivId="tab_page1" Enable="false" />
                    <menu TitleName="금액"     DivId="tab_page2" Enable="false" />
<!--                     <menu TitleName="금액구간" DivId="tab_page3" Enable="false" /> -->
                  </div>
                  <div id=tab_page1 width="100%" >
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr >
                        <td class="right PB03 PT03"><img 
                        src="/<%=dir%>/imgs/btn/add_row.gif" id=IMG_ADD_ROW_10 onClick="javascript:btn_addRow('10');" hspace="2" /><img 
                        src="/<%=dir%>/imgs/btn/del_row.gif" id=IMG_DEL_ROW_10 onClick="javascript:btn_delRow('10');"  /></td>
                      </tr>
                      <tr valign="top">
                        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                          <tr>
                            <td>
                              <comment id="_NSID_">
                                <object id=GD_NRML_MASTER width=100% height=400 classid=<%=Util.CLSID_GRID%>>
                                  <param name="DataID" value="DS_NRML_MASTER">
                                </object>
                              </comment><script>_ws_(_NSID_);</script>
                            </td>
                          </tr>
                        </table></td>
                      </tr>
                    </table>
                  </div>
                  <div id=tab_page2 width="100%" >
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td class="right PB03 PT03"><img 
                        src="/<%=dir%>/imgs/btn/add_row.gif" id=IMG_ADD_ROW_21 onClick="javascript:btn_addRow('21');" hspace="2" /><img 
                        src="/<%=dir%>/imgs/btn/del_row.gif" id=IMG_DEL_ROW_21 onClick="javascript:btn_delRow('21');"  /></td>
                      </tr>
                      <tr valign="top">
                        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                          <tr>
                            <td>
                              <comment id="_NSID_">
                                <object id=GD_AMT_MASTER width=100% height=186 classid=<%=Util.CLSID_GRID%>>
                                  <param name="DataID" value="DS_AMT_MASTER">
                                </object>
                              </comment><script>_ws_(_NSID_);</script>
                            </td>
                          </tr>
                        </table></td>
                      </tr>
                      <tr>
                        <td class="right PB03 PT03"><img 
                        src="/<%=dir%>/imgs/btn/add_row.gif" id=IMG_ADD_ROW_22 onClick="javascript:btn_addRow('22');" hspace="2" /><img 
                        src="/<%=dir%>/imgs/btn/del_row.gif" id=IMG_DEL_ROW_22 onClick="javascript:btn_delRow('22');"  /></td>
                      </tr>
                      <tr valign="top">
                        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                          <tr>
                            <td>
                              <comment id="_NSID_">
                                <object id=GD_AMT_DETAIL width=100% height=186 classid=<%=Util.CLSID_GRID%>>
                                  <param name="DataID" value="DS_AMT_DETAIL">
                                </object>
                              </comment><script>_ws_(_NSID_);</script>
                            </td>
                          </tr>
                        </table></td>
                      </tr>
                    </table>
                  </div>
                  
                  <!--
                  <div id=tab_page3 width="100%" >
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td class="right PB03 PT03"><img 
                        src="/<%=dir%>/imgs/btn/add_row.gif" id=IMG_ADD_ROW_31 onClick="javascript:btn_addRow('31');" hspace="2" /><img 
                        src="/<%=dir%>/imgs/btn/del_row.gif" id=IMG_DEL_ROW_31 onClick="javascript:btn_delRow('31');"  /></td>
                      </tr>
                      <tr valign="top">
                        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                          <tr>
                            <td>
                              <comment id="_NSID_">
                                <object id=GD_AMT_SCTN_MASTER width=100% height=186 classid=<%=Util.CLSID_GRID%>>
                                  <param name="DataID" value="DS_AMT_SCTN_MASTER">
                                </object>
                              </comment><script>_ws_(_NSID_);</script>
                            </td>
                          </tr>
                        </table></td>
                      </tr>
                      <tr>
                        <td class="right PB03 PT03"><img 
                        src="/<%=dir%>/imgs/btn/add_row.gif" id=IMG_ADD_ROW_32 onClick="javascript:btn_addRow('32');" hspace="2" /><img 
                        src="/<%=dir%>/imgs/btn/del_row.gif" id=IMG_DEL_ROW_32 onClick="javascript:btn_delRow('32');"  /></td>
                      </tr>
                      <tr valign="top">
                        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                          <tr>
                            <td>
                              <comment id="_NSID_">
                                <object id=GD_AMT_SCTN_DETAIL width=100% height=186 classid=<%=Util.CLSID_GRID%>>
                                  <param name="DataID" value="DS_AMT_SCTN_DETAIL">
                                </object>
                              </comment><script>_ws_(_NSID_);</script>
                            </td>
                          </tr>
                        </table></td>
                      </tr>
                    </table>
                  </div>
                  -->
                  
                  
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
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

<comment id="_NSID_">
<object id=BO_MAIN classid=<%= Util.CLSID_BIND %>>
    <param name=DataID value=DS_MASTER>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
            <c>col=STR_NAME             ctrl=EM_STR_NAME_M              param=Text </c>
            <c>col=PUMBUN_CD            ctrl=EM_PUMBUN_CD_M             param=Text </c>
            <c>col=PUMBUN_NAME          ctrl=EM_PUMBUN_NAME_M           param=Text </c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>

