<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > 조직코드> 조직/바이어(SM)관리
 * 작 성 일 : 2010.01.14
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod0020.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 조직/바이어(SM)정보를 관리한다
 * 이    력 :
 *        2010.01.14 (정진영) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
 <% request.setCharacterEncoding("utf-8"); %> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"		prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"			prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"		prefix="button" %>

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
var bfTreePos;              // OnRowPosChanged Event 가 초기 로딩시 2번 발생하는 것을 제어하기 위한 변수
var bfMasterPos;            // OnRowPosChanged Event 가 초기 로딩시 2번 발생하는 것을 제어하기 위한 변수
var btnSaveClick = false;
var tvClick = false;
var tvClickIdx= 1;
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // 코드입력을 위한 입력 박스 초기화
    initTab('TAB_CODE');
    
    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_IO_TREE_MAIN.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_IO_BUYER_MASTER.setDataHeader('<gauce:dataset name="H_SEL_BUYER_MASTER"/>');
    DS_IO_BUYER_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_BUYER_DETAIL"/>');
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //디테일

    // EMedit에 초기화
    initEmEdit(EM_O_ORG_CD, "CODE^10", NORMAL);  //조직코드(조회)
    initEmEdit(EM_O_ORG_NM, "GEN^40", NORMAL);  //조직명 (조회)
    
    initEmEdit(EM_I_ORG_CD, "CODE^10", READ);  //조직코드
    initEmEdit(EM_I_ORG_NM, "GEN^40", PK);  //조직명
    initEmEdit(EM_I_ORG_FLAG, "GEN", READ);  //조직구분
    initEmEdit(EM_I_STR_CD, "CODE^2", READ);  //점코드
    initEmEdit(EM_I_DEPT_CD, "CODE^2", PK);  //팀코드
    initEmEdit(EM_I_TEAM_CD, "CODE^2", PK);  //파트코드
    initEmEdit(EM_I_PC_CD, "CODE^2", PK);  //PC코드
    initEmEdit(EM_I_CORNER_CD, "CODE^2", PK);  //코너코드
    initEmEdit(EM_I_ORG_SHORT_NM, "GEN^20", PK);  //조직약명
    
    // MARIO OUTLET
    
    //initEmEdit(EM_I_SAP_ORG, "CODE^8", NORMAL);  //인사조직코드
    //initEmEdit(EM_I_SAP_ORG_NM, "GEN^40", READ);  //인사조직코드명
    
    
    initEmEdit(EM_I_BF_ORG_CD, "CODE^10", NORMAL);  //이전조직코드
    initEmEdit(EM_I_BF_ORG_NM, "GEN^40", READ);  //이전조직코드명
    
    // MARIO OUTLET
    /*------
    initEmEdit(EM_I_KOSTL_CD, "CODE^10", NORMAL);  //코스트센터코드
    initEmEdit(EM_I_KOSTL_NM, "GEN^40", READ);     //코스트센터코드명
    -------*/
    
    initEmEdit(EM_I_EMP_CNT, "NUMBER^3^0", NORMAL);  //직영인원수
    initEmEdit(EM_I_AREA_SIZE, "NUMBER^5^2", NORMAL);  //면적
    initEmEdit(EM_I_APP_S_DT, "YYYYMMDD", PK);  //적용시작일
    initEmEdit(EM_I_APP_E_DT, "YYYYMMDD", PK);  //적용종료일
    initEmEdit(EM_I_SORT_ORDER, "NUMBER^5^0", PK);  //정렬순서
    
    //0보다 큰값 입력(NUMBER)
    EM_I_EMP_CNT.NumericRange = "0~+:0";
    EM_I_AREA_SIZE.NumericRange = "0~+:0"; 
    
    
    //콤보 초기화
    initComboStyle(LC_O_STR_CD,DS_O_STR_CD, "CODE^0^30,NAME^0^140", 1, PK);  //점(조회)
    initComboStyle(LC_I_SAP_ORG,DS_O_ONLINE_PC, "CODE^0^50,NAME^0^140", 1, PK);  //온라인PC명
    initComboStyle(LC_O_ORG_FLAG,DS_O_ORG_FLAG, "CODE^0^30,NAME^0^140", 1, NORMAL);  //조직구분(조회)
    initComboStyle(LC_O_USE_YN,DS_O_USE_YN, "CODE^0^30,NAME^0^140", 1, NORMAL);  //사용여부(조회)
    initComboStyle(LC_O_ORG_LEVEL,DS_O_ORG_LEVEL, "CODE^0^20,NAME^0^40", 1, NORMAL);  //조직레벨
    initComboStyle(LC_O_ORG_CD,DS_O_ORG_CD, "CODE^0^80,NAME^0^250", 1, NORMAL);  //조직
    initComboStyle(LC_I_USE_YN,DS_I_USE_YN, "CODE^0^30,NAME^0^70", 1, PK);  //사용여부
    initComboStyle(LC_I_MNG_ORG_YN,DS_I_MNG_ORG_YN, "CODE^0^30,NAME^0^70", 1, PK);  //관리조직여부
    //initComboStyle(LC_I_FLOR_CD,DS_I_FLOR_CD, "CODE^0^30,NAME^0^70", 1, NORMAL);  //층
    initComboStyle(LC_I_BUDGET_YN,DS_I_BUDGET_YN, "CODE^0^30,NAME^0^70", 1, PK);  //예산사용부서
    
    
    //콤보의 바인드 컬럼 변경
    LC_O_ORG_CD.BindColumn = "TMP_CODE";

    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_O_ORG_FLAG", "D", "P047", "Y");
    getEtcCode("DS_O_USE_YN", "D", "D022", "Y");
    
    getEtcCode("DS_O_ORG_LEVEL", "D", "P048", "Y");
    getEtcCode("DS_O_ONLINE_PC", "D", "PS34", "N");
    
    getEtcCode("DS_I_USE_YN", "D", "D022", "N");
    getEtcCode("DS_I_MNG_ORG_YN", "D", "D022", "N");
    //getEtcCode("DS_I_FLOR_CD", "D", "P061", "N", "Y");
    getEtcCode("DS_I_BUDGET_YN", "D", "D022", "N");
    
    getEtcCode("DS_I_BUYER_MST_USE_YN", "D", "D022", "N");
    getEtcCode("DS_I_BUYER_MST_MAIN_YN", "D", "P046", "N");
    getEtcCode("DS_I_BUYER_MST_BUYER_FLAG", "D", "P020", "N");
    getEtcCode("DS_I_BUYER_ORG_USE_YN", "D", "D022", "N");
    
    //점콤보 가져오기 ( popup_dps.js )
    getStore("DS_O_STR_CD", "N", "", "N");
    //getFlc("DS_O_STR_CD", "C", "", "N", "N");  
        
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_O_ORG_FLAG,"%");
    setComboData(LC_O_USE_YN,"%"); 
    setComboData(LC_O_ORG_LEVEL,"%"); 
    setComboData(LC_I_USE_YN,"Y"); 
    setComboData(LC_I_MNG_ORG_YN,"N"); 
    setComboData(LC_I_BUDGET_YN,"N"); 
    setComboData(LC_O_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_O_STR_CD.Index < 0){
        LC_O_STR_CD.Index= 0;
    }
    allCntlDisable();
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pcod002","DS_IO_TREE_MAIN,DS_IO_BUYER_MASTER,DS_IO_BUYER_DETAIL" );

    //결과표시 초기화
    setPorcCount("CLEAR");
    //페이지로딩시 포커스
    LC_O_STR_CD.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}    name="NO"         width=30   align=center</FC>'
                     + '<FG>id=G_BUYER     name="바이어(SM)" '
                     + '<FC>id=BUYER_CD    name="코드"     width=60   align=center edit="none"</FC>'
                     + '<FC>id=BUYER_NAME  name="*명"     width=115   align=left</FC>'
                     + '</FG>'
                     + '<FC>id=MAIN_FLAG   name="*정부;구분"     width=45   align=left   edit={IF(BUYER_CD="","true","false")}   EditStyle=Lookup   Data="DS_I_BUYER_MST_MAIN_YN:CODE:NAME"</FC>'
                     + '<FC>id=BUYER_FLAG  name="*바이어;구분"       width=65  align=left  EditStyle=Lookup   Data="DS_I_BUYER_MST_BUYER_FLAG:CODE:NAME"</FC>'
                     + '<FC>id=EMP_NO      name="사원번호"       width=70  align=center  edit="none"</FC>'
                     + '<FC>id=EMP_NM      name="사원명"       width=90  align=left  edit="none"</FC>'
                     + '<FC>id=USE_YN      name="사용;여부"       width=50  align=left  EditStyle=Lookup   Data="DS_I_BUYER_MST_USE_YN:CODE:NAME"</FC>';

    initGridStyle(GD_BUYER_MASTER, "common", hdrProperies, true);
}

function gridCreate2(){
    var hdrProperies = '<FC>id={currow}    name="NO"         width=25   align=center</FC>'
                     + '<FG>id=G_BUYER     name="바이어(SM)" '
                     + '<FC>id=BUYER_CD    name="코드"     width=60   align=center edit="none"</FC>'
                     + '<FC>id=BUYER_NAME  name="명"     width=115   align=left edit="none"</FC>'
                     + '</FG>'
                     + '<FC>id=EMP_NO      name="*사원번호"       width=97  align=center edit=AlphaNum EditStyle=Popup  edit={IF(APP_S_DT="","true",IF(APP_S_DT>="'+getTodayFormat("YYYYMMDD")+'","true","false"))}  </FC>'
                     + '<FC>id=EMP_NM      name="사원명"       width=75  align=left edit="none"</FC>'
                     + '<FC>id=USE_YN      name="사용;여부"       width=47  align=left EditStyle=Lookup   Data="DS_I_BUYER_ORG_USE_YN:CODE:NAME"</FC>'
                     + '<FC>id=APP_S_DT    name="*적용시작일"     width=85   align=center edit="Numeric" EditStyle=Popup mask="XXXX/XX/XX" edit={IF(APP_S_DT="","true",IF(Status="I" AND SysStatus="I" ,"true",IF(APP_S_DT>="'+getTodayFormat("YYYYMMDD")+'" AND APP_E_DT="99991231" AND Status<>"I","true","false")))} </FC>'
                     + '<FC>id=APP_E_DT    name="*적용종료일"   width=85 align=center edit="none" mask="XXXX/XX/XX"</FC>';

    initGridStyle(GD_BUYER_DETAIL, "common", hdrProperies, true);
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

    if( DS_IO_TREE_MAIN.IsUpdated || DS_IO_BUYER_MASTER.IsUpdated || DS_IO_BUYER_DETAIL.IsUpdated ){
        // 변경된 상세 내역이 존재합니다. 조회하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1059") != 1 ){
            EM_I_ORG_NM.Focus();
            return;
        }
    }
    allCntlDisable( );
    DS_IO_BUYER_DETAIL.ClearData();
    DS_IO_BUYER_MASTER.ClearData();
    DS_IO_TREE_MAIN.ClearData();
    var strStrCd   = LC_O_STR_CD.BindColVal;
    var strOrgFlag = LC_O_ORG_FLAG.BindColVal;
    var strUseYn   = LC_O_USE_YN.BindColVal;
    var strOrgCd   = EM_O_ORG_CD.Text;
    var strOrgNm   = EM_O_ORG_NM.Text;

    var goTo       = "searchTreeMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                   + "&strOrgFlag="+encodeURIComponent(strOrgFlag)
                   + "&strUseYn="+encodeURIComponent(strUseYn)
                   + "&strOrgCd="+encodeURIComponent(strOrgCd)
                   + "&strOrgNm="+encodeURIComponent(strOrgNm);
    TR_MAIN.Action="/dps/pcod002.pc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_TREE_MAIN=DS_IO_TREE_MAIN)"; //조회는 O
    TR_MAIN.Post();
    //조회후 결과표시
    setPorcCount("SELECT",DS_IO_TREE_MAIN.CountRow);
    TV_MAIN.Focus();
    TV_MAIN.Index = 1;
    TV_MAIN.Focus();
    LC_O_ORG_CD.Index = 0;
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	
    //기존의 신규로우 존재 시 데이타 클리어 
    var insRow = DS_IO_TREE_MAIN.RowPosition;
    if(insRow < 1){
    	//조회 후 신규 등록이 가능합니다.
        showMessage(INFORMATION, OK, "USER-1025");
        LC_O_STR_CD.Focus();
        return;
    }
    var orgFlag = DS_IO_TREE_MAIN.NameValue( insRow, "ORG_FLAG");
    if( orgFlag < 1 ){
    	showMessage(INFORMATION, OK, "USER-1000","점레벨에서는 신규 입력할 수 없습니다.");
        TV_MAIN.Focus();
    	return;
    }
    if( DS_IO_TREE_MAIN.RowStatus(insRow) == '1' ) {
        if( showMessage(QUESTION, YESNO, "USER-1051") != 1 ){
            EM_I_ORG_NM.Focus();
            return;        	
        }
        DS_IO_TREE_MAIN.DeleteRow(insRow);
    }else {
    	insRow = insRow+1;
    }
    
    //수정된 내용 존재시
    if( DS_IO_TREE_MAIN.IsUpdated){
        //변경 된 상세 내역이 존재합니다.<br> 신규 작성  하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1050") != 1){            
        	EM_I_ORG_NM.Focus();
            return ;
        }
        DS_IO_TREE_MAIN.UndoAll();
    }
    addTreeRow(insRow)
    EM_I_ORG_NM.Focus();
	
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
    if (!DS_IO_TREE_MAIN.IsUpdated && !DS_IO_BUYER_MASTER.IsUpdated && !DS_IO_BUYER_DETAIL.IsUpdated ){
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
        if( DS_IO_TREE_MAIN.CountRow < 1)
            LC_O_STR_CD.Focus();
        else
        	TV_MAIN.Focus();
        return;
    }
    var orgCd = EM_I_ORG_CD.Text;
    
    if( !checkTreeValidation())
        return;
    if( !checkBuyerMstValidation())
        return;
    if( !checkBuyerOrgValidation())
        return;
    
   

    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
    	EM_I_ORG_NM.Focus();
        return;
    }
    
    DS_IO_BUYER_DETAIL.ResetUserStatus();
    btnSaveClick = true;
    TR_MAIN.Action="/dps/pcod002.pc?goTo=save";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_ORGMST=DS_IO_TREE_MAIN,I:DS_I_BUYER_MST=DS_IO_BUYER_MASTER,I:DS_I_BUYER_ORG=DS_IO_BUYER_DETAIL)"; //조회는 O
    TR_MAIN.Post();    
    btnSaveClick = false;

    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
        btn_Search();
        var row = DS_IO_TREE_MAIN.NameValueRow("ORG_CD",orgCd);
        row = row<1?1:row;
        DS_IO_TREE_MAIN.RowPosition = row;
    }
    EM_I_ORG_NM.Focus();
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
 * allCntlDisable()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-03-11
 * 개    요 :  모든 컨포넌트 입력 불가
 * return값 : void
 */
function allCntlDisable( ){
    enableControl(EM_I_ORG_CD, false);
    enableControl(EM_I_ORG_NM, false);
    enableControl(EM_I_ORG_FLAG, false);
    enableControl(EM_I_STR_CD, false);
    enableControl(EM_I_DEPT_CD, false);
    enableControl(EM_I_TEAM_CD, false);
    enableControl(EM_I_PC_CD, false);
    enableControl(EM_I_CORNER_CD, false);
    enableControl(EM_I_ORG_SHORT_NM, false);
    
    // MARIO OUTLET
   
    enableControl(LC_I_SAP_ORG, false);
    //enableControl(LC_I_SAP_ORG_NM, false);
    
    
    enableControl(EM_I_BF_ORG_CD, false);
    enableControl(EM_I_BF_ORG_NM, false);
    enableControl(EM_I_EMP_CNT, false);
    enableControl(EM_I_AREA_SIZE, false);
    enableControl(EM_I_APP_S_DT, false);
    enableControl(EM_I_APP_E_DT, false);
    enableControl(LC_I_USE_YN, false);
    enableControl(LC_I_MNG_ORG_YN, false);
    //enableControl(LC_I_FLOR_CD, false);
    enableControl(LC_I_BUDGET_YN, false); 
    enableControl(EM_I_SORT_ORDER, false);
    
    // MARIO OUTLET START
    /*------
    enableControl(EM_I_KOSTL_CD, false);
    enableControl(IMG_KOSTL_CD, false);
    enableControl(IMG_SAP_ORG, false);
    -------*/
    // MARIO OUTLET END
    
    enableControl(IMG_BF_ORG_CD, false);
    enableControl(IMG_APP_S_DT, false);
    enableControl(IMG_APP_E_DT, false);
    enableControl(IMG_BUYERMST_ADD_ROW, false);
    enableControl(IMG_BUYERMST_DEL_ROW, false);
    enableControl(IMG_BUYERDTL_ADD_ROW, false);
    enableControl(IMG_BUYERDTL_DEL_ROW, false);
        
    GD_BUYER_DETAIL.Editable    = false;
    GD_BUYER_MASTER.Editable    = false;
 }
/**
* btn_Add1()
* 작 성 자 : 
* 작 성 일 : 2010-02-10
* 개    요 : 바이이(SM) 정보 행추가
* return값 : void
*/
function btn_Add1(){
	
	if( DS_IO_BUYER_DETAIL.IsUpdated ){
		// 변경된 상세 내역이 존재합니다. 신규작성하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1050") != 1 ){
        	GD_BUYER_MASTER.Focus();
            return;
        }
    }
    DS_IO_BUYER_DETAIL.ClearData();
	var mainRow = DS_IO_TREE_MAIN.RowPosition;
	var orgFlag = DS_IO_TREE_MAIN.NameValue( mainRow, "ORG_FLAG");
    var strCd = DS_IO_TREE_MAIN.NameValue( mainRow, "STR_CD");
    var teamCd = DS_IO_TREE_MAIN.NameValue( mainRow, "TEAM_CD");
    var orgCd = DS_IO_TREE_MAIN.NameValue( mainRow, "ORG_CD");
    DS_IO_BUYER_MASTER.AddRow();
    var newRow = DS_IO_BUYER_MASTER.CountRow;
    DS_IO_BUYER_MASTER.NameValue( newRow, "ORG_FLAG") = orgFlag;
    DS_IO_BUYER_MASTER.NameValue( newRow, "STR_CD") = strCd;
    DS_IO_BUYER_MASTER.NameValue( newRow, "TEAM_CD") = teamCd;
    DS_IO_BUYER_MASTER.NameValue( newRow, "PC_ORG_CD") = orgCd;
    DS_IO_BUYER_MASTER.NameValue( newRow, "USE_YN") = "Y";
    setFocusGrid(GD_BUYER_MASTER, DS_IO_BUYER_MASTER, newRow, "BUYER_NAME");
    
}

/**
* btn_Del1()
* 작 성 자 : 
* 작 성 일 : 2010-02-10
* 개    요 : 바이이(SM) 정보 행삭제
* return값 : void
*/
function btn_Del1(){
	if( DS_IO_BUYER_MASTER.CountRow < 1)
	    return;
	
	if( DS_IO_BUYER_MASTER.RowStatus(DS_IO_BUYER_MASTER.RowPosition) != "1"){
		// 신규입력 데이터만 삭제 가능합니다.
        showMessage(INFORMATION, OK, "USER-1052");
        GD_BUYER_MASTER.Focus();
        return;
	}
	
	if( DS_IO_BUYER_DETAIL.IsUpdated ){
		// 변경된상세 내역이 있습니다 삭제하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1056") != 1 ){
            GD_BUYER_MASTER.Focus();
            return;
        }
    }
	DS_IO_BUYER_MASTER.DeleteRow(DS_IO_BUYER_MASTER.RowPosition);
    GD_BUYER_MASTER.Focus();
}

/**
* btn_Add2()
* 작 성 자 : 
* 작 성 일 : 2010-02-10
* 개    요 : 바이이(SM) 담당자 정보 행추가
* return값 : void
*/
function btn_Add2(){
    var mainRow = DS_IO_BUYER_MASTER.RowPosition;
    var buyerCd = DS_IO_BUYER_MASTER.NameValue( mainRow, "BUYER_CD");
    var buyerName = DS_IO_BUYER_MASTER.NameValue( mainRow, "BUYER_NAME");
    var orgFlag = DS_IO_BUYER_MASTER.NameValue( mainRow, "ORG_FLAG");
    var strCd = DS_IO_BUYER_MASTER.NameValue( mainRow, "STR_CD");
    var teamCd = DS_IO_BUYER_MASTER.NameValue( mainRow, "TEAM_CD");
    var orgCd = DS_IO_BUYER_MASTER.NameValue( mainRow, "PC_ORG_CD");
    
    if( buyerCd == ''){
        var newCnt = 0;          

        for(var i = 1; i <= DS_IO_BUYER_MASTER.CountRow; i++ ) {
            if( DS_IO_BUYER_MASTER.RowStatus(i) == 1)
                newCnt++;
            
            if( newCnt > 1){
                // 저장되지 않은 마스터 정보가 1건 이상 존재 합니다. <br> 저장후 등록하세요
                showMessage(INFORMATION, OK, "USER-1058");
                GD_BUYER_MASTER.Focus();
                return ;
            }
        }
    }
    for(var i = 1; i <= DS_IO_BUYER_DETAIL.CountRow; i++ ) {
        if( DS_IO_BUYER_DETAIL.RowStatus(i) == 1){
        	// 신규데이터 입력은 1건만 가능합니다.
            showMessage(INFORMATION, OK, "USER-1078");
            setFocusGrid(GD_BUYER_DETAIL, DS_IO_BUYER_DETAIL, DS_IO_BUYER_DETAIL.CountRow, "EMP_NO");
            return ;
        }
    }
    for(var i = 1; i <= DS_IO_BUYER_DETAIL.CountRow; i++ ) {
    	DS_IO_BUYER_DETAIL.UserStatus(i) = 1;
    }
    var maxAppSDt = DS_IO_BUYER_DETAIL.Max(DS_IO_BUYER_DETAIL.ColumnIndex("APP_S_DT"),0,0);     
    maxAppSDt = (maxAppSDt=='' || maxAppSDt < getTodayFormat("YYYYMMDD"))?getTodayFormat("YYYYMMDD"):getRawData(addDate('d',1,(maxAppSDt)));
    DS_IO_BUYER_DETAIL.AddRow();
    var newRow = DS_IO_BUYER_DETAIL.CountRow;
    DS_IO_BUYER_DETAIL.NameValue( newRow, "BUYER_CD") = buyerCd;
    DS_IO_BUYER_DETAIL.NameValue( newRow, "BUYER_NAME") = buyerName;
    DS_IO_BUYER_DETAIL.NameValue( newRow, "STR_CD") = strCd;
    DS_IO_BUYER_DETAIL.NameValue( newRow, "TEAM_CD") = teamCd;
    DS_IO_BUYER_DETAIL.NameValue( newRow, "PC_ORG_CD") = orgCd;
    DS_IO_BUYER_DETAIL.NameValue( newRow, "USE_YN") = "Y";
    DS_IO_BUYER_DETAIL.NameValue( newRow, "APP_S_DT") = maxAppSDt;
    setFocusGrid(GD_BUYER_DETAIL, DS_IO_BUYER_DETAIL, newRow, "EMP_NO");
    
}


/**
* btn_Del1()
* 작 성 자 : 
* 작 성 일 : 2010-02-10
* 개    요 : 바이이(SM) 담당자 정보 행삭제
* return값 : void
*/
function btn_Del2(){
    if( DS_IO_BUYER_DETAIL.CountRow < 1)
        return;
    
    if( DS_IO_BUYER_DETAIL.SysStatus(DS_IO_BUYER_DETAIL.RowPosition) != "1"){
        showMessage(INFORMATION, OK, "USER-1052");
        return;
    }
    
    DS_IO_BUYER_DETAIL.DeleteRow(DS_IO_BUYER_DETAIL.RowPosition);
    DS_IO_BUYER_DETAIL.ResetUserStatus();

    
}

/**
* searchBuyerMaster()
* 작 성 자 : 정진영
* 작 성 일 : 2010-02-09
* 개    요 :  바이어 정보를 조회한다.
* return값 : void
*/
function searchBuyerMaster(){

    DS_IO_BUYER_DETAIL.ClearData();
	DS_IO_BUYER_MASTER.ClearData();
	
    var strOrgCd   = EM_I_ORG_CD.Text;
    var strOrgFlag = DS_IO_TREE_MAIN.NameValue( DS_IO_TREE_MAIN.RowPosition, "ORG_FLAG");
    
    strOrgFlag = strOrgFlag == '0'?'':strOrgFlag;
    
    var goTo       = "searchBuyerMaster" ;    
    var action     = "O";     
    var parameters = "&strOrgCd="+encodeURIComponent(strOrgCd)
                   + "&strOrgFlag="+encodeURIComponent(strOrgFlag);
                   
    TR_BUYER_MST.Action="/dps/pcod002.pc?goTo="+goTo+parameters;  
    TR_BUYER_MST.KeyValue="SERVLET("+action+":DS_IO_BUYER_MASTER=DS_IO_BUYER_MASTER)"; //조회는 O
    TR_BUYER_MST.Post();
    
}

/**
* searchBuyerDetail()
* 작 성 자 : 정진영
* 작 성 일 : 2010-02-09
* 개    요 :  바이어 정보를 조회한다.
* return값 : void
*/
function searchBuyerDetail(){

    DS_IO_BUYER_DETAIL.ClearData();
    var strBuyerCd   = DS_IO_BUYER_MASTER.NameValue( DS_IO_BUYER_MASTER.RowPosition, "BUYER_CD");

    var goTo       = "searchBuyerDetail" ;    
    var action     = "O";     
    var parameters = "&strBuyerCd="+encodeURIComponent(strBuyerCd);
                   
    TR_BUYER_ORG.Action="/dps/pcod002.pc?goTo="+goTo+parameters;  
    TR_BUYER_ORG.KeyValue="SERVLET("+action+":DS_IO_BUYER_DETAIL=DS_IO_BUYER_DETAIL)"; //조회는 O
    TR_BUYER_ORG.Post();
}

/**
 * checkTreeValidation()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-09
 * 개    요 :  트리 DataSet 의  입력을 체크한다.
 * return값 : void
 */
function checkTreeValidation(){
	var check=false;
    var titleNm = "";
    var componentId = "";
    var row;
    for(var i = 1; i <= DS_IO_TREE_MAIN.CountRow; i++ ) {
        var rowStatus = DS_IO_TREE_MAIN.RowStatus(i);
        
        if( rowStatus == 0 
            || rowStatus == 2
            || rowStatus == 4)
            continue;
        row = i;
        if( DS_IO_TREE_MAIN.NameValue( i, "ORG_NAME") == ''){
            check = true;
            titleNm = "조직명";
            componentId = "EM_I_ORG_NM";
            break;
        }
        
        if( !checkInputByte( null, DS_IO_TREE_MAIN, i, "ORG_NAME", "조직명", "EM_I_ORG_NM") )
        	return false;
        
        var orgLvl = DS_IO_TREE_MAIN.NameValue( i, "ORG_LEVEL");
        if( orgLvl > 1 && (DS_IO_TREE_MAIN.NameValue( i, "DEPT_CD") == '00' ||DS_IO_TREE_MAIN.NameValue( i, "DEPT_CD") == '')){
            check = true;
            titleNm = "팀코드";
            componentId = "EM_I_DEPT_CD";
            break;
        }
        if( orgLvl > 2 && (DS_IO_TREE_MAIN.NameValue( i, "TEAM_CD") == '00' ||DS_IO_TREE_MAIN.NameValue( i, "TEAM_CD") == '')){
            check = true;
            titleNm = "파트코드";
            componentId = "EM_I_TEAM_CD";
            break;
        }
        if( orgLvl > 3 && (DS_IO_TREE_MAIN.NameValue( i, "PC_CD") == '00' ||DS_IO_TREE_MAIN.NameValue( i, "PC_CD") == '')){
            check = true;
            titleNm = "PC코드";
            componentId = "EM_I_PC_CD";
            break;
        }
        if( orgLvl > 4 && (DS_IO_TREE_MAIN.NameValue( i, "CORNER_CD") == '00' ||DS_IO_TREE_MAIN.NameValue( i, "CORNER_CD") == '')){
            check = true;
            titleNm = "코너코드";
            componentId = "EM_I_CORNER_CD";
            break;
        }
        if( DS_IO_TREE_MAIN.NameValue( i, "ORG_SHORT_NAME") == ''){
            check = true;
            titleNm = "조직약명";
            componentId = "EM_I_ORG_SHORT_NM";
            break;
        }        
        
        if( DS_IO_TREE_MAIN.NameValue( i, "SORT_ORDER") == 0){
            check = true;
            titleNm = "정렬순서";
            componentId = "EM_I_SORT_ORDER";
            break;
        }      
        
        if( !checkInputByte( null, DS_IO_TREE_MAIN, i, "ORG_SHORT_NAME", "조직약명", "EM_I_ORG_SHORT_NM") )
            return false;

        // MARIO OUTLET
        /* 
        if( DS_IO_TREE_MAIN.NameValue( i, "SAP_ORG_CD") == '' ){
        	showMessage(EXCLAMATION, OK, "USER-1000", "온라인PC명을 입력하세요.");
            DS_IO_TREE_MAIN.RowPosition = i;
            LC_I_SAP_ORG.Focus();
            return false;
        }   
        
        if( DS_IO_TREE_MAIN.NameValue( i, "SAP_ORG_CD").length != 8 ){
        	showMessage(EXCLAMATION, OK, "USER-1000", "온라인PC명 자릿수가 틀렸습니다.");
            DS_IO_TREE_MAIN.RowPosition = i;
            LC_I_SAP_ORG.Focus();
            return false;
        } 
         */
        if( DS_IO_TREE_MAIN.NameValue( i, "BF_ORG_CD") != '' 
        		&& DS_IO_TREE_MAIN.NameValue( i, "BF_ORG_NAME") == '' 
        		&& DS_IO_TREE_MAIN.NameValue( i, "BF_ORG_CD") != DS_IO_TREE_MAIN.NameValue( i, "ORG_CD")){
            showMessage(EXCLAMATION, OK, "USER-1036", "이전조직");
            DS_IO_TREE_MAIN.RowPosition = i;
            EM_I_BF_ORG_CD.Focus();
            return false;
        }
        
        // MARIO OUTLET START
        /*
        if( orgLvl == 4 && DS_IO_TREE_MAIN.NameValue( i, "KOSTL_CD") == ''){
            check = true;
            titleNm = "코스트센터코드";
            componentId = "EM_I_KOSTL_CD";
            break;
        }
        if( DS_IO_TREE_MAIN.NameValue( i, "KOSTL_CD") != '' && DS_IO_TREE_MAIN.NameValue( i, "KOSTL_NAME") == ''){
            showMessage(EXCLAMATION, OK, "USER-1036", "코스트센터코드");
            DS_IO_TREE_MAIN.RowPosition = i;
            EM_I_KOSTL_CD.Focus();
            return false;
        }        
        */
     	// MARIO OUTLET END

     	
        if( DS_IO_TREE_MAIN.NameValue( i, "MNG_ORG_YN") == ''){
            check = true;
            titleNm = "관리조직여부 ";
            componentId = "LC_I_MNG_ORG_YN";
            break;
        }
        /*
        if( orgLvl > 4 && DS_IO_TREE_MAIN.NameValue( i, "FLOR_CD") == ''){
            check = true;
            titleNm = "층";
            componentId = "LC_I_FLOR_CD";
            break;
        }
        */
        if( DS_IO_TREE_MAIN.NameValue( i, "BUDGET_YN") == ''){
            check = true;
            titleNm = "순서/예산사용 ";
            componentId = "LC_I_BUDGET_YN";
            break;
        }
        if( DS_IO_TREE_MAIN.NameValue( i, "APP_S_DT") == ''){
            check = true;
            titleNm = "적용시작일";
            componentId = "EM_I_APP_S_DT";
            break;
        }
        if( DS_IO_TREE_MAIN.NameValue( i, "APP_S_DT") < getTodayFormat("YYYYMMDD") && DS_IO_TREE_MAIN.NameValue( i, "APP_S_DT") != DS_IO_TREE_MAIN.OrgNameValue( i, "APP_S_DT")){
            showMessage(EXCLAMATION, Ok,  "USER-1030","적용시작일");
            DS_IO_TREE_MAIN.RowPosition = i;
            EM_I_APP_S_DT.Focus();
            return false;
        }
        if( DS_IO_TREE_MAIN.NameValue( i, "APP_E_DT") == ''){
            check = true;
            titleNm = "적용종료일 ";
            componentId = "EM_I_APP_E_DT";
            break;
        }
        if( DS_IO_TREE_MAIN.NameValue( i, "APP_E_DT") < getTodayFormat("YYYYMMDD") && DS_IO_TREE_MAIN.NameValue( i, "APP_E_DT") != DS_IO_TREE_MAIN.OrgNameValue( i, "APP_E_DT")){
            showMessage(EXCLAMATION, Ok,  "USER-1030", "적용종료일");
            DS_IO_TREE_MAIN.RowPosition = i;
            EM_I_APP_E_DT.Focus();
            return false;
        }        

        var gap = daysBetween(DS_IO_TREE_MAIN.NameValue( i, "APP_S_DT"), DS_IO_TREE_MAIN.NameValue( i, "APP_E_DT"));
        
        if ( gap < 1) {
            showMessage(EXCLAMATION, Ok,  "USER-1008", "적용종료일","적용시작일");
            DS_IO_TREE_MAIN.RowPosition = i;
            EM_I_APP_E_DT.Focus();
            return false;
        }

        	
    }
    if( check ){
        // ()은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", titleNm);
        DS_IO_TREE_MAIN.RowPosition = row;
        eval(componentId).Focus();
        return false;
    }
    return true;
}

/**
* checkBuyerMstValidation()
* 작 성 자 : 정진영
* 작 성 일 : 2010-02-09
* 개    요 :  바이어(SM) 정보 의  입력을 체크한다.
* return값 : void
*/
function checkBuyerMstValidation(){
    var check = false;
    var mainCheck = false;
    var titleNm = "";
    var colId = "";
    var row;
    for(var i = 1; i <= DS_IO_BUYER_MASTER.CountRow; i++ ) {
        var rowStatus = DS_IO_BUYER_MASTER.RowStatus(i);

        if( DS_IO_BUYER_MASTER.NameValue( i, "MAIN_FLAG") == 1) {
            if( mainCheck  &&  (rowStatus == 1 || rowStatus == 3) ){
                // 정 바이어(SM)은/는 하나만 존재해야 합니다.
                showMessage(EXCLAMATION, OK, "USER-1057", "정 바이어(SM)");
                DS_IO_BUYER_MASTER.RowPosition = i;
                GD_BUYER_MASTER.SetColumn("MAIN_FLAG");
                return false;
            }
            mainCheck = true;
        }
        
        if( rowStatus == 0 
            || rowStatus == 2
            || rowStatus == 4)
            continue;
        row = i;
        if( DS_IO_BUYER_MASTER.NameValue( i, "BUYER_NAME") == ''){
            check = true;
            titleNm = "바이어(SM)명";
            colId = "BUYER_NAME";
            break;
        }
        
        if( !checkInputByte( GD_BUYER_MASTER, DS_IO_BUYER_MASTER, i, "BUYER_NAME", "바이어(SM)명", null) )
            return false;

        if( DS_IO_BUYER_MASTER.NameValue( i, "MAIN_FLAG") == ''){
            check = true;
            titleNm = "정부구분";
            colId = "MAIN_FLAG";
            break;
        }
        
        
        if( DS_IO_BUYER_MASTER.NameValue( i, "BUYER_FLAG") == ''){
            check = true;
            titleNm = "바이어구분";
            colId = "BUYER_FLAG";
            break;
        }

        
    }
    
    if( check ){
        // ()은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", titleNm);
        DS_IO_BUYER_MASTER.RowPosition = row;
        GD_BUYER_MASTER.SetColumn(colId);
        return false;
    }
    return true;
}

/**
* checkBuyerOrgValidation()
* 작 성 자 : 정진영
* 작 성 일 : 2010-02-09
* 개    요 :  바이어(SM) 담당자 정보 의  입력을 체크한다.
* return값 : void
*/
function checkBuyerOrgValidation(){

    var check = false;
    var titleNm = "";
    var colId = "";
    var row;
    for(var i = 1; i <= DS_IO_BUYER_DETAIL.CountRow; i++ ) {
        var rowStatus = DS_IO_BUYER_DETAIL.SysStatus(i);
        
        if( rowStatus == 0 
            || rowStatus == 2
            || rowStatus == 4)
            continue;
        row = i;
        
        if( DS_IO_BUYER_DETAIL.NameValue( i, "EMP_NO") == ''){
            check = true;
            titleNm = "사원번호";
            colId = "EMP_NO";
            break;
        }

        if( DS_IO_BUYER_DETAIL.NameValue( i, "APP_S_DT") == ''){
            check = true;
            titleNm = "적용시작일";
            colId = "APP_S_DT";
            break;
        }
        
        if( DS_IO_BUYER_DETAIL.NameValue( i, "APP_E_DT") == '99991231'){
            var maxValue = getMaxData( DS_IO_BUYER_DETAIL, "APP_S_DT", true);
            var maxRow = DS_IO_BUYER_DETAIL.NameValueRow("APP_S_DT",maxValue);
            if( i != maxRow){
                showMessage(EXCLAMATION, Ok,  "USER-1000", "데이터의 [적용시작일]은 가장 큰 [적용시작일] 이어야 합니다."); 
                setFocusGrid(GD_BUYER_DETAIL,DS_IO_BUYER_DETAIL,row,"APP_S_DT");
                return false;
            }
        }
        if( rowStatus==1){
            var maxValue = getMaxData( DS_IO_BUYER_DETAIL, "APP_S_DT", false);
            var maxRow = DS_IO_BUYER_DETAIL.NameValueRow("APP_S_DT",maxValue);
            if( i != maxRow){
                showMessage(EXCLAMATION, Ok,  "USER-1000", "데이터의 [적용시작일]은 가장 큰 [적용시작일] 이어야 합니다.");    
                setFocusGrid(GD_BUYER_DETAIL,DS_IO_BUYER_DETAIL,row,"APP_S_DT");
                return false;
            }
        }
    }
    
    if( check ){
        // ()은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", titleNm);
        setFocusGrid(GD_BUYER_DETAIL,DS_IO_BUYER_DETAIL,row,colId);
        return false;
    }
    return true;
}

/**
* addTreeRow()
* 작 성 자 : 정진영
* 작 성 일 : 2010-02-09
* 개    요 :  트리에 신규 추가한다.
* 사용법: addTreeRow(row)
*        row --> 추가 할 로우 위치 
*               ( 로우 위치의 데이터는 밑으로 밀려난다.)
* return값 : void
*/
function addTreeRow(row) {
    var orgCd = DS_IO_TREE_MAIN.NameValue(row-1, "ORG_CD");
	var orgLvl = DS_IO_TREE_MAIN.NameValue(row-1, "ORG_LEVEL");
    var orgflag = DS_IO_TREE_MAIN.NameValue(row-1, "ORG_FLAG");
    var orgflagNm = DS_IO_TREE_MAIN.NameValue(row-1, "ORG_FLAG_NM");
    var strCd = DS_IO_TREE_MAIN.NameValue(row-1, "STR_CD"); 
    var deptCd = DS_IO_TREE_MAIN.NameValue(row-1, "DEPT_CD"); 
    var teamCd = DS_IO_TREE_MAIN.NameValue(row-1, "TEAM_CD"); 
    var pcCd = DS_IO_TREE_MAIN.NameValue(row-1, "PC_CD"); 
    var cornerCd = DS_IO_TREE_MAIN.NameValue(row-1, "CORNER_CD");
    var maxLvl = orgflag=='1'?5:4;
    orgLvl =  orgLvl < maxLvl ? (Number(orgLvl) + 1) :(Number(orgLvl) + 0) ; 
    if( maxLvl < orgLvl){
        showMessage(EXCLAMATION, OK, "USER-1000", "매입조직일 경우 코너레벨을 입력할수 없습니다.");
        TV_MAIN.Focus();
        return;
    }
    var pOrgCd = strCd;
    pOrgCd += orgLvl<2?'00':deptCd;
    pOrgCd += orgLvl<3?'00':teamCd;
    pOrgCd += orgLvl<4?'00':pcCd;
    pOrgCd += '00';
	DS_IO_TREE_MAIN.InsertRow(row);
    DS_IO_TREE_MAIN.NameValue(row, "ORG_LEVEL") = ""+orgLvl;
    DS_IO_TREE_MAIN.NameValue(row, "ORG_FLAG") = orgflag;
    DS_IO_TREE_MAIN.NameValue(row, "ORG_FLAG_NM") = orgflagNm;
    DS_IO_TREE_MAIN.NameValue(row, "LVL") = orgLvl; 
    DS_IO_TREE_MAIN.NameValue(row, "P_ORG_CD") = pOrgCd;
    DS_IO_TREE_MAIN.NameValue(row, "STR_CD") = strCd; 
    DS_IO_TREE_MAIN.NameValue(row, "DEPT_CD") = orgLvl==2?'':deptCd; 
    DS_IO_TREE_MAIN.NameValue(row, "TEAM_CD") = orgLvl==3?'':teamCd; 
    DS_IO_TREE_MAIN.NameValue(row, "PC_CD") =  orgLvl==4?'':(maxLvl==4? '00' : pcCd) ; 
    DS_IO_TREE_MAIN.NameValue(row, "CORNER_CD") = orgLvl==5?'':'00';
    DS_IO_TREE_MAIN.NameValue(row, "USE_YN") = "Y"; 
    DS_IO_TREE_MAIN.NameValue(row, "MNG_ORG_YN") = "N"; 
    DS_IO_TREE_MAIN.NameValue(row, "APP_S_DT") = getRawData(addDate('D',1,getTodayFormat('YYYYMMDD')));
    DS_IO_TREE_MAIN.NameValue(row, "APP_E_DT") = "99991231";
    
    viewOrgFlag( orgflag );
    vlewOrgLvlCode( orgLvl , 1);
}

/**
* getTreeToCombo()
* 작 성 자 : 정진영
* 작 성 일 : 2010-02-09
* 개    요 :  트리 데이터를 이용하여 콤보 데이터를 구성한다.
* 사용법: getTreeToCombo(flag)
*        flag --> 구성할 조직 구분(% 는 모든 데이터)
* return값 : void
*/
function getTreeToCombo(flag){

    DS_O_ORG_CD.ClearAll();
	DS_O_ORG_CD.setDataHeader('TMP_CODE:STRING(11),CODE:STRING(10),NAME:STRING(40)');
	for( var i = 1 ; i <= DS_IO_TREE_MAIN.CountRow; i++) {
		var orgLvl = DS_IO_TREE_MAIN.NameValue(i, "ORG_LEVEL");
        var orgflag = DS_IO_TREE_MAIN.NameValue(i, "ORG_FLAG");
		if( flag == '%' || ( flag == orgLvl && ( orgLvl=='1'? orgflag == 0 : true))) {
	        var tmpOrgCd = DS_IO_TREE_MAIN.NameValue(i, "TMP_ORG_CD");
            var orgCd = DS_IO_TREE_MAIN.NameValue(i, "ORG_CD");
	        var orgNm = DS_IO_TREE_MAIN.NameValue(i, "ORG_NAME");
		    DS_O_ORG_CD.Addrow();
            DS_O_ORG_CD.NameValue(DS_O_ORG_CD.CountRow, "TMP_CODE")  = tmpOrgCd;
		    DS_O_ORG_CD.NameValue(DS_O_ORG_CD.CountRow, "CODE")  = orgCd;
		    DS_O_ORG_CD.NameValue(DS_O_ORG_CD.CountRow, "NAME")  = orgNm;
		}
	}
}


/**
* vlewOrgLvlCode()
* 작 성 자 : 정진영
* 작 성 일 : 2010-02-09
* 개    요 :  트리 레벨별 코드를 표시한다.
* return값 : void
*/
function vlewOrgLvlCode( orgLvl, rowStatus){
	
    //setObjTypeStyle( LC_I_FLOR_CD, "COMBO", NORMAL );
	allCntlDisable( );
    
    switch(orgLvl){
        case 0:
            enableControl(LC_I_MNG_ORG_YN, true);
            //enableControl(LC_I_FLOR_CD, true);
            enableControl(LC_I_BUDGET_YN, true);
            enableControl(EM_I_BF_ORG_CD, true);
            enableControl(IMG_BF_ORG_CD, true);
            enableControl(EM_I_SORT_ORDER, true);
            
            // MARIO OUTLET START
            
            
            ////enableControl(EM_I_KOSTL_CD, true);            
            ////enableControl(IMG_SAP_ORG, true);            
            ////enableControl(IMG_KOSTL_CD, true);      
            // MARIO OUTLET END
        case 1:
            document.getElementById('codeNameTitle').innerText='점코드';
            setTabItemIndex('TAB_CODE',1);
            break;
        case 2:
            document.getElementById('codeNameTitle').innerText = '팀코드';
            setTabItemIndex('TAB_CODE',2);
            if(rowStatus == '1')
            	enableControl(EM_I_DEPT_CD, true);
            break;
        case 3:
            document.getElementById('codeNameTitle').innerText = '파트코드';
            setTabItemIndex('TAB_CODE',3);
            if(rowStatus == '1')
                enableControl(EM_I_TEAM_CD, true);
            break;
        case 4:
            document.getElementById('codeNameTitle').innerText = 'PC코드';
            setTabItemIndex('TAB_CODE',4);
            GD_BUYER_DETAIL.Editable    = true;
            GD_BUYER_MASTER.Editable    = true;
            enableControl(IMG_BUYERMST_ADD_ROW, true);
            enableControl(IMG_BUYERMST_DEL_ROW, true);
            enableControl(IMG_BUYERDTL_ADD_ROW, true);
            enableControl(IMG_BUYERDTL_DEL_ROW, true);
            if(rowStatus == '1')
                enableControl(EM_I_PC_CD, true);
            break;
        case 5:
            document.getElementById('codeNameTitle').innerText = '코너코드';
            setTabItemIndex('TAB_CODE',5);
            enableControl(EM_I_EMP_CNT, true);
            enableControl(EM_I_AREA_SIZE, true);
            enableControl(LC_I_SAP_ORG, true);
           // setObjTypeStyle( LC_I_FLOR_CD, "COMBO", PK );
            if(rowStatus == '1')
                enableControl(EM_I_CORNER_CD, true);
            break;
    }

    if( orgLvl == 1)
        return;
    
    enableControl(EM_I_ORG_NM, true);
    enableControl(EM_I_ORG_SHORT_NM, true);
    // MARIO OUTLET START
    
    
    // MARIO OUTLET END 
    enableControl(EM_I_BF_ORG_CD, true);
    enableControl(LC_I_USE_YN, true);
    enableControl(LC_I_MNG_ORG_YN, true);
    
    //enableControl(LC_I_FLOR_CD, true);
    enableControl(LC_I_BUDGET_YN, true);
    enableControl(EM_I_SORT_ORDER, true);
    
    // MARIO OUTLET START
    ////enableControl(IMG_SAP_ORG, true);
    // MARIO OUTLET END
    
    enableControl(IMG_BF_ORG_CD, true);
    enableControl(EM_I_APP_E_DT, true);
    enableControl(IMG_APP_E_DT, true);
    
    // MARIO OUTLET START
    ////enableControl(EM_I_KOSTL_CD, true);
    ////enableControl(IMG_KOSTL_CD, true);
    // MARIO OUTLET END

 	// MARIO OUTLET START
 	/*
    if( orgLvl == 4 ){
    	TH_KOSTL_CD.className = "point";
    	setObjTypeStyle( EM_I_KOSTL_CD, "EMEDIT", PK );
        if(EM_I_KOSTL_CD.Text != ''){
            enableControl(EM_I_KOSTL_CD, false);
            enableControl(IMG_KOSTL_CD, false);
        }
    }else{
        TH_KOSTL_CD.className = "";
        setObjTypeStyle( EM_I_KOSTL_CD, "EMEDIT", NORMAL );
    	
    }
 	*/
	// MARIO OUTLET END
    
    if( EM_I_APP_S_DT.Text == '' || EM_I_APP_S_DT.Text > getTodayFormat("YYYYMMDD")){
        enableControl(EM_I_APP_S_DT, true);
        enableControl(IMG_APP_S_DT, true);    	
    }
    
}

/**
* viewOrgFlag()
* 작 성 자 : 정진영
* 작 성 일 : 2010-02-09
* 개    요 :  조직 구분에 따라 표시한다.
* return값 : void
*/
function viewOrgFlag( orgFlag){

    if(orgFlag == 2 ){
        document.getElementById('buyerSmTitle').innerHTML = '<img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/> 바이어 정보';
        document.getElementById('buyerSmTitle2').innerHTML = '<img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/> 바이어 담당자정보';
        GD_BUYER_MASTER.ColumnProp('G_BUYER', 'Name')= "바이어";
        GD_BUYER_DETAIL.ColumnProp('G_BUYER', 'Name')= "바이어";
        return;
    }
    
    document.getElementById('buyerSmTitle').innerHTML = '<img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/> SM 정보';
    document.getElementById('buyerSmTitle2').innerHTML = '<img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/> SM 담당자정보';
    GD_BUYER_MASTER.ColumnProp('G_BUYER', 'Name')= "SM";
    GD_BUYER_DETAIL.ColumnProp('G_BUYER', 'Name')= "SM";
    
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

<script language=JavaScript for=TR_BUYER_MST event=onSuccess>
    for(i=0;i<TR_BUYER_MST.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_BUYER_MST.SrvErrMsg('UserMsg',i));
    }
</script>
<script language=JavaScript for=TR_BUYER_ORG event=onSuccess>
    for(i=0;i<TR_BUYER_ORG.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_BUYER_ORG.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_BUYER_MST event=onFail>
    trFailed(TR_BUYER_MST.ErrorMsg);
</script>
<script language=JavaScript for=TR_BUYER_ORG event=onFail>
    trFailed(TR_BUYER_ORG.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<script language=JavaScript for=DS_IO_TREE_MAIN
	event=OnLoadCompleted(rowcnt)>
    if(rowcnt < 1)
    	return;
    
    getTreeToCombo(LC_O_ORG_LEVEL.BindColVal);
</script>
<script language=JavaScript for=DS_IO_BUYER_MASTER
	event=OnLoadCompleted(rowcnt)>
    if(rowcnt < 1)
        return;
</script>
<script language=JavaScript for=DS_IO_BUYER_DETAIL
	event=OnLoadCompleted(rowcnt)>
    if(rowcnt < 1)
        return;
</script>
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->

<script language=JavaScript for=DS_IO_TREE_MAIN
	event=OnColumnChanged(row,colid)>
    if( row < 1)
        return;
    switch(colid){
        case "STR_CD" :
        case "DEPT_CD" :
        case "TEAM_CD" :
        case "PC_CD" :
        case "CORNER_CD" :
            var rowStatus = this.RowStatus(row);
            if( rowStatus != 1)
            	break;
            
        	var newOrgCd = this.NameValue(row,"STR_CD")
        	             + this.NameValue(row,"DEPT_CD")
                         + this.NameValue(row,"TEAM_CD")
                         + this.NameValue(row,"PC_CD")
                         + this.NameValue(row,"CORNER_CD");
        	
        	this.NameValue(row,"ORG_CD") = newOrgCd;
            break;
        case "ORG_CD" :
            var newOrgCd = this.NameValue(row,"ORG_CD");
            var orgLvl = this.NameValue(row,"ORG_LEVEL");
            if(newOrgCd.length == 10 && orgLvl == 4){
                for( var i = 1 ; i <= DS_IO_BUYER_MASTER.CountRow; i++){
                    DS_IO_BUYER_MASTER.NameValue(i,"PC_ORG_CD") = newOrgCd;
                }
                for( var i = 1 ; i <= DS_IO_BUYER_DETAIL.CountRow; i++){
                    DS_IO_BUYER_DETAIL.NameValue(i,"PC_ORG_CD") = newOrgCd;
                }
            }
            break;
        default :
            break;
    }
</script>
<script language=JavaScript for=DS_IO_BUYER_DETAIL
	event=OnColumnChanged(row,colid)>
    if( row < 1)
        return;
    switch(colid){
        case "EMP_NO":
        	var checkValue = this.NameValue(row,colid);
        	if( checkValue == ""){
                this.NameValue(row,"EMP_NM") = "";
        		break;
        	}
        	setNmToDataSet('DS_SEARCH_NM', 'SEL_USR_MST', checkValue);
        	if(DS_SEARCH_NM.CountRow == 1){
        		this.NameValue(row,colid) = DS_SEARCH_NM.NameValue(1,"CODE_CD");
                this.NameValue(row,"EMP_NM") = DS_SEARCH_NM.NameValue(1,"CODE_NM");
                return;
        	}
        	var rtnVal = commonPopToGrid('사원','SEL_USR_MST_TEST',checkValue);
            if( rtnVal.size() < 1){
                this.NameValue(row,colid) = "";
                this.NameValue(row,"EMP_NM") = "";
                return;
            }
            this.NameValue(row,colid) = rtnVal.get("CODE_CD");
            this.NameValue(row,"EMP_NM") = rtnVal.get("CODE_NM");
        	break;
        case "APP_S_DT" :
            if(!checkDateTypeYMD(GD_BUYER_DETAIL,"APP_S_DT",''))
                return;
            var checkValue = this.NameValue(row,colid);
            var maxAppSDt = DS_IO_BUYER_DETAIL.Max(DS_IO_BUYER_DETAIL.ColumnIndex("APP_S_DT"),0,0);     
            maxAppSDt = (maxAppSDt=='' || maxAppSDt < getTodayFormat("YYYYMMDD"))?getTodayFormat("YYYYMMDD"):getRawData(addDate('d',1,(maxAppSDt)));
        	if( checkValue != "" ){
                var dupRow = checkDupKey(this, "APP_S_DT");
                if (dupRow > 0) {
                	//()행에 중복되는 데이터가 존재합니다.
                    showMessage(EXCLAMATION, Ok,  "USER-1044", dupRow);
                    this.NameValue(row, "APP_S_DT")    = this.RowStatus(row)==1?maxAppSDt:this.OrgNameValue(row, "APP_S_DT");           
                    GD_BUYER_DETAIL.SetColumn("APP_S_DT");
                    return ;
                }
                if ( checkValue < getTodayFormat("YYYYMMDD")) {
                    showMessage(EXCLAMATION, Ok,  "USER-1030", "적용시작일");    
                    this.NameValue(row, "APP_S_DT")    = this.RowStatus(row)==1?maxAppSDt:this.OrgNameValue(row, "APP_S_DT");                
                    GD_BUYER_DETAIL.SetColumn("APP_S_DT");
                    return false;
                }
                if ( this.NameValue(row,"APP_E_DT")!='' && checkValue > this.NameValue(row,"APP_E_DT")) {
                    showMessage(EXCLAMATION, Ok,  "USER-1021", "적용시작일","적용종료일");    
                    this.NameValue(row, "APP_S_DT")    = this.RowStatus(row)==1?maxAppSDt:this.OrgNameValue(row, "APP_S_DT");                
                    GD_BUYER_DETAIL.SetColumn("APP_S_DT");
                    return false;
                }
                if( this.OrgNameValue(row,"APP_S_DT") == checkValue){
                    enableControl(IMG_BUYERDTL_ADD_ROW, true);
                    enableControl(IMG_BUYERDTL_DEL_ROW, true);
                }else{
                    enableControl(IMG_BUYERDTL_ADD_ROW, false);
                    enableControl(IMG_BUYERDTL_DEL_ROW, false);
                }
                if( this.RowStatus(row)==1){
                    var maxValue = getMaxData( this, "APP_S_DT", false);
                    var maxRow = this.NameValueRow(colid,maxValue);
                    if( row != maxRow){
                        showMessage(EXCLAMATION, Ok,  "USER-1000", "데이터의 [적용시작일]은 가장 큰 [적용시작일] 이어야 합니다.");    
                        this.NameValue(row, "APP_S_DT")    = this.RowStatus(row)==1?maxAppSDt:this.OrgNameValue(row, "APP_S_DT");                
                        GD_BUYER_DETAIL.SetColumn("APP_S_DT");
                        return false;
                    }
                }
                
        	}
            break;
        default :
            break;
    }
</script>
<script language=JavaScript for=DS_IO_TREE_MAIN
	event=CanRowPosChange(row)>
    if( row < 1 || btnSaveClick)
     	return true;
    if( this.IsUpdated || DS_IO_BUYER_MASTER.IsUpdated || DS_IO_BUYER_DETAIL.IsUpdated ){
    	if(this.RowMark(row) == '1'){
	    	this.RowMark(row) = '0';
            EM_I_ORG_NM.Focus();
            tvClick = false;
		    return false;
	    }
        //변경된상세내역이 존재합니다<br> 이동하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1049") != 1 ){
        	if(tvClick)
        	    this.RowMark(row) = '1';
            EM_I_ORG_NM.Focus();
            return false;
        }
        DS_IO_BUYER_DETAIL.ClearData();
        DS_IO_BUYER_MASTER.ClearData();
        var rowStatus = this.RowStatus(row);
        this.UndoAll();
        
        if( rowStatus==1){
        	setTimeout( "TV_MAIN.Reset();",50);
            setTimeout( "TV_MAIN.Focus();",50);
            setTimeout( "TV_MAIN.Index = " + (row <= tvClickIdx ? tvClickIdx-1:tvClickIdx)+";",50);
        }
    }
    return true;
</script>

<script language=JavaScript for=DS_IO_TREE_MAIN
	event=OnRowPosChanged(row)>
    if( row < 1 || bfTreePos == row)
        return;
    tvClick = false;
    bfTreePos = row;
    var lvl = this.NameValue( row, "LVL");
    var orgflag = this.NameValue( row, "ORG_FLAG");
    viewOrgFlag( orgflag );
    vlewOrgLvlCode( lvl );
    bfMasterPos = 0;
    
    searchBuyerMaster();
</script>
<script language=JavaScript for=DS_IO_BUYER_MASTER
	event=CanRowPosChange(row)>
    if( row < 1 || btnSaveClick)
    	return true;
    
    if( DS_IO_BUYER_DETAIL.IsUpdated ){
    	//변경된상세내역이 존재합니다<br> 이동하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1049") != 1 ){
        	setFocusGrid(GD_BUYER_MASTER, this, row, "BUYER_CD");
            return false;
        }
    }
</script>

<script language=JavaScript for=DS_IO_BUYER_MASTER
	event=OnRowPosChanged(row)>

    if( row < 1 || bfMasterPos == row)
        return;
    bfMasterPos = row;
    searchBuyerDetail();
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=TV_MAIN
    event=OnItemClick(idx)>
    tvClick = true;
    tvClickIdx = idx;
</script>
<script language=JavaScript for=GD_BUYER_DETAIL
	event=OnPopup(row,colid,data)>
    if(colid == "EMP_NO"){
        var rtnVal = commonPopToGrid('사원','SEL_USR_MST_TEST',data);
        if( rtnVal.size() < 1){
            eval(this.DataID).NameValue(row,colid) = "";
            eval(this.DataID).NameValue(row,"EMP_NM") = "";
        	return;
        }
        eval(this.DataID).NameValue(row,colid) = rtnVal.get("CODE_CD");
        eval(this.DataID).NameValue(row,"EMP_NM") = rtnVal.get("CODE_NM");
    }else{
        openCal(this,row,colid);	
    }
</script>

<script language=JavaScript for=GD_BUYER_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid );    
</script>
<script language=JavaScript for=GD_BUYER_DETAIL event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid );
</script>
<script language=JavaScript for=EM_O_ORG_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
        
    if(this.text==''){
    	EM_O_ORG_NM.Text = "";
        return;
    }   
    setOrgNmWithoutPop('DS_SEARCH_NM',EM_O_ORG_CD,EM_O_ORG_NM,'N','0','','','','','',LC_O_STR_CD.BindColVal);
</script>

<!-- 인사조직코드 변경시 -->
<!-- MARIO OUTLET START -->
<script language=JavaScript for=LC_I_SAP_ORG event=onKillFocus()>
//변경된 내역이 없으면 무시
    /* if(!this.Modified)
        return;
        
    if(this.text=='' || this.Text == EM_I_ORG_CD.Text){
    	LC_I_SAP_ORG_NM.Text = "";
        return;
    }   
    setNmWithoutPop('DS_SEARCH_NM','인사조직','SEL_COMM_CODE_ONLY',LC_I_SAP_ORG,LC_I_SAP_ORG_NM,'D','P043');
    
    if( DS_SEARCH_NM.CountRow == 1){
    	LC_I_SAP_ORG.Text = DS_SEARCH_NM.NameValue(1,"CODE_CD");
    	LC_I_SAP_ORG_NM.Text = DS_SEARCH_NM.NameValue(1,"CODE_NM");
        return;
    }
    LC_I_SAP_ORG_NM.Text = "";
    commonPop('인사조직','SEL_COMM_CODE_ONLY',LC_I_SAP_ORG ,LC_I_SAP_ORG_NM,'D','P043');
     */
</script>
<!-- MARIO OUTLET END -->

<!-- 이전조직코드 변경시 -->
<script language=JavaScript for=EM_I_BF_ORG_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
        
    if(this.Text =='' || this.Text == EM_I_ORG_CD.Text){
    	EM_I_BF_ORG_NM.Text = "";
        return;
    }
    setOrgNmWithoutPop('DS_SEARCH_NM',EM_I_BF_ORG_CD,EM_I_BF_ORG_NM,'N','1','','','','','',LC_O_STR_CD.BindColVal);
    
</script>

<!-- 코스트센터코드 변경시 -->
<!-- MARIO OUTLET START
<script language=JavaScript for=EM_I_KOSTL_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
        
    if(this.text=='' ){
        EM_I_KOSTL_NM.Text = "";
        return;
    }   
    setNmWithoutPop('DS_SEARCH_NM','코스트센터','SEL_COMM_CODE_ONLY',EM_I_KOSTL_CD,EM_I_KOSTL_NM,'D','P096');
    
    if( DS_SEARCH_NM.CountRow == 1){
    	EM_I_KOSTL_CD.Text = DS_SEARCH_NM.NameValue(1,"CODE_CD");
    	EM_I_KOSTL_NM.Text = DS_SEARCH_NM.NameValue(1,"CODE_NM");
        return;
    }
    EM_I_KOSTL_NM.Text = "";
    commonPop('코스트센터','SEL_COMM_CODE_ONLY',EM_I_KOSTL_CD ,EM_I_KOSTL_NM,'D','P096');
</script>
 MARIO OUTLET START -->
 
<!-- 조직레벨변경시 -->
<script language=JavaScript for=LC_O_ORG_LEVEL event=OnSelChange()>
    getTreeToCombo(this.BindColVal);
</script>
<!-- 조직변경시 -->
<script language=JavaScript for=LC_O_ORG_CD event=OnSelChange()>
    if( this.BindColVal == '')
    	return;
    DS_IO_TREE_MAIN.RowPosition = DS_IO_TREE_MAIN.NameValueRow( "TMP_ORG_CD",this.BindColVal);
</script>
<!-- 점(조회)변경시 -->
<script language=JavaScript for=LC_O_STR_CD event=OnSelChange()>
    
</script>
<!-- 조직구분(조회)변경시 -->
<script language=JavaScript for=LC_O_ORG_FLAG event=OnSelChange()>
</script>
<!-- 사용여부(조회)변경시 -->
<script language=JavaScript for=LC_O_USE_YN event=OnSelChange()>
</script>

<!-- 적용시작일  -->
<script language=JavaScript for=EM_I_APP_S_DT event=OnKillFocus()>
    if(!checkDateTypeYMD(this,getRawData(addDate('D',1,getTodayFormat('YYYYMMDD'))),"DS_IO_TREE_MAIN","APP_S_DT"))
        return;
    var orgValue = DS_IO_TREE_MAIN.OrgNameValue(DS_IO_TREE_MAIN.RowPosition,"APP_S_DT");
    var toDate = getTodayFormat('YYYYMMDD');
    if( toDate > this.Text){
        showMessage(EXCLAMATION, OK,"USER-1030","적용시작일");
        if(DS_IO_TREE_MAIN.RowStatus(DS_IO_TREE_MAIN.RowPosition) == 1)
            DS_IO_TREE_MAIN.NameValue(DS_IO_TREE_MAIN.RowPosition,"APP_S_DT") = "";
        else
            DS_IO_TREE_MAIN.NameValue(DS_IO_TREE_MAIN.RowPosition,"APP_S_DT") = orgValue;
    }
</script>
<script language=JavaScript for=EM_I_APP_E_DT event=OnKillFocus()>
    
    if(!checkDateTypeYMD(this,'99991231',"DS_IO_TREE_MAIN","APP_E_DT"))
        return;
    var orgValue = DS_IO_TREE_MAIN.OrgNameValue(DS_IO_TREE_MAIN.RowPosition,"APP_E_DT");
    var toDate = getTodayFormat('YYYYMMDD');
    if( toDate > this.Text){
        showMessage(EXCLAMATION, OK,"USER-1030","적용종료일");
        if(DS_IO_TREE_MAIN.RowStatus(DS_IO_TREE_MAIN.RowPosition) == 1)
            DS_IO_TREE_MAIN.NameValue(DS_IO_TREE_MAIN.RowPosition,"APP_E_DT") = "";
        else
            DS_IO_TREE_MAIN.NameValue(DS_IO_TREE_MAIN.RowPosition,"APP_E_DT") = orgValue;
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
<object id="DS_O_STR_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_ORG_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_ONLINE_PC" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_USE_YN" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_ORG_LEVEL" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_ORG_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_USE_YN" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_MNG_ORG_YN" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_FLOR_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_BUDGET_YN" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_BUYER_MST_USE_YN" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_BUYER_MST_MAIN_YN" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_BUYER_MST_BUYER_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_BUYER_ORG_USE_YN" classid=<%= Util.CLSID_DATASET %>></object>
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
<object id="DS_SEARCH_NM" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_IO_BUYER_MASTER" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_BUYER_DETAIL" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_TREE_MAIN" classid=<%= Util.CLSID_DATASET %>></object>
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
<object id="TR_BUYER_MST" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="TR_BUYER_ORG" classid=<%=Util.CLSID_TRANSACTION%>>
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
						<th width="75" class="point">점</th>
						<td width="170"><comment id="_NSID_"> <object
							id=LC_O_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=170
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="75">조직구분</th>
						<td width="170"><comment id="_NSID_"> <object
							id=LC_O_ORG_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=170
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="75">사용여부</th>
						<td><comment id="_NSID_"> <object id=LC_O_USE_YN
							classid=<%= Util.CLSID_LUXECOMBO %> width=170 align="absmiddle">
						</object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th>조직</th>
						<td colspan="5"><comment id="_NSID_"> <object
							id=EM_O_ORG_CD classid=<%= Util.CLSID_EMEDIT %> width=148
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							onclick="javascript: orgPop(EM_O_ORG_CD,EM_O_ORG_NM, 'N','','','','','',LC_O_STR_CD.BindColVal); EM_O_ORG_CD.Focus();"
							align="absmiddle" /> <comment id="_NSID_"> <object
							id=EM_O_ORG_NM classid=<%= Util.CLSID_EMEDIT %> width=357
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
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
	<tr valign="top">
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr valign="top">
				<td width="250">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
								<table width="100%" border="0" cellpadding="0" cellspacing="0"
									class="s_table">
									<tr>
										<th width="50">조직레벨</th>
										<td><comment id="_NSID_"> <object
											id=LC_O_ORG_LEVEL classid=<%= Util.CLSID_LUXECOMBO %>
											width=100 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
										</td>
									</tr>
									<tr>
										<th width="50">조직</th>
										<td><comment id="_NSID_"> <object
											id=LC_O_ORG_CD classid=<%= Util.CLSID_LUXECOMBO %> width=100%
											align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr valign="top">
						<td class="PT02">
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="BD2A">
							<tr>
								<td><comment id="_NSID_"> <object id=TV_MAIN
									classid=<%=Util.CLSID_TREEVIEW%> height=429 width=100%>
									<param name=DataID value="DS_IO_TREE_MAIN">
									<!-- Bind할 DataSet의 ID -->
									<param name=TextColumn value="TXT">
									<!-- 컨텐츠 -->
									<param name=LevelColumn value="LVL">
									<!-- 레벨 -->
									<param name=UseImage value="false">
									<param name=ExpandOneClick value="false">
									<param name=SingleExpand value="false">
                                    <param name=ExpandLevel value="2">
									<param name=BorderStyle value="0">
									
									<param name=FontSize  value="10.5">
									<param name=FontName  value="돋움">
									
								</object> </comment><script>_ws_(_NSID_);</script></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
				<td class="PL10">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="sub_title PB03"><img
							src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
							align="absmiddle" /> 조직정보</td>
					</tr>
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
								<table width="100%" border="0" cellpadding="0" cellspacing="0"
									class="s_table">
									<tr>
										<th width="90" class="point">조직코드</th>
										<td width="150"><comment id="_NSID_"> <object
											id=EM_I_ORG_CD classid=<%=Util.CLSID_EMEDIT%> width=110
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
										<th width="80" class="point">조직명</th>
										<td colspan="3"><comment id="_NSID_"> <object
											id=EM_I_ORG_NM classid=<%=Util.CLSID_EMEDIT%> width=190
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
									</tr>
									<tr>
										<th width="90" class="point">조직구분</th>
										<td><comment id="_NSID_"> <object
											id=EM_I_ORG_FLAG classid=<%=Util.CLSID_EMEDIT%> width=110
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
										<th width="80" class="point" id="codeNameTitle">점코드</th>
										<td width="93">
											<div id=TAB_CODE width=80 height=25 MenuDisplay='false' TitleWidth=16 >
											    <menu TitleName="점"   DivId="tab_page1" />
	                                            <menu TitleName="팀" DivId="tab_page2" />
	                                            <menu TitleName="파트"   DivId="tab_page3" />
	                                            <menu TitleName="PC"   DivId="tab_page4" />
	                                            <menu TitleName="코너" DivId="tab_page5" />
											</div>
										<div id=tab_page1 >
										<comment id="_NSID_"> <object id=EM_I_STR_CD
                                            classid=<%=Util.CLSID_EMEDIT%> width=100% tabindex=1
                                            align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</div>
                                        <div id=tab_page2 >
                                        <comment id="_NSID_"> <object id=EM_I_DEPT_CD
                                            classid=<%=Util.CLSID_EMEDIT%> width=100% tabindex=1
                                            align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                                        </div>
                                        <div id=tab_page3 >
                                        <comment id="_NSID_"> <object id=EM_I_TEAM_CD
                                            classid=<%=Util.CLSID_EMEDIT%> width=100% tabindex=1
                                            align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                                        </div>
                                        <div id=tab_page4 >
                                        <comment id="_NSID_"> <object id=EM_I_PC_CD
                                            classid=<%=Util.CLSID_EMEDIT%> width=100% tabindex=1
                                            align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                                        </div>
                                        <div id=tab_page5 >
                                        <comment id="_NSID_"> <object id=EM_I_CORNER_CD
                                            classid=<%=Util.CLSID_EMEDIT%> width=100% tabindex=1
                                            align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                                        </div>
										</td>
										<th width="70" class="point">조직약명</th>
										<td><comment id="_NSID_"> <object
											id=EM_I_ORG_SHORT_NM classid=<%=Util.CLSID_EMEDIT%> width=118
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
									</tr>
									<tr>
									   
										<th width="90" class="point">관리조직여부</th>
										<td colspan="3"><comment id="_NSID_"> <object
											id=LC_I_MNG_ORG_YN classid=<%= Util.CLSID_LUXECOMBO %>
											width=75 tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
                                        <th >직영인원수</th>
                                        <td><comment id="_NSID_"> <object
                                            id=EM_I_EMP_CNT classid=<%=Util.CLSID_EMEDIT%> width=118
                                            tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                                        </td>
									</tr>
									<tr>
										<th >이전조직</th>
										<td colspan="3"><comment id="_NSID_"> <object
											id=EM_I_BF_ORG_CD classid=<%=Util.CLSID_EMEDIT%> width=75
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script><img
											src="/<%=dir%>/imgs/btn/detail_search_s.gif"
											id="IMG_BF_ORG_CD" class="PR03" 
											onclick="javascript:if( EM_I_BF_ORG_CD.Enable ){ orgPop(EM_I_BF_ORG_CD,EM_I_BF_ORG_NM, 'N','','','','','',LC_O_STR_CD.BindColVal); EM_I_BF_ORG_CD.Focus();}"
											align="absmiddle" /> <comment id="_NSID_"> <object
					 						id=EM_I_BF_ORG_NM classid=<%=Util.CLSID_EMEDIT%> width=123
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
                                        <th >면적(㎡)</th>
                                        <td ><comment id="_NSID_"> <object
                                            id=EM_I_AREA_SIZE classid=<%=Util.CLSID_EMEDIT%> width=118
                                            tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                                        </td>
										<!-- 
										<th>층</th>
										<td><comment id="_NSID_"> <object
											id=LC_I_FLOR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=123
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
										 -->
									</tr>
									<!-- MARIO OUTLET START -->
									<!-- 
									<tr>
                                        <th id=TH_KOSTL_CD >코스트센터</th>
                                        <td colspan="3"><comment id="_NSID_"> <object
                                            id=EM_I_KOSTL_CD classid=<%=Util.CLSID_EMEDIT%> width=90
                                            tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script><img
                                            src="/<%=dir%>/imgs/btn/detail_search_s.gif"
                                            id="IMG_KOSTL_CD" class="PR03" 
                                            onclick="javascript:commonPop('코스트센터','SEL_COMM_CODE_ONLY',EM_I_KOSTL_CD ,EM_I_KOSTL_NM,'D','P096'); EM_I_KOSTL_CD.Focus();"
                                            align="absmiddle" /> <comment id="_NSID_"> <object
                                            id=EM_I_KOSTL_NM classid=<%=Util.CLSID_EMEDIT%> width=130
                                            tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                                        </td>

                                        <th >직영인원수</th>
                                        <td ><comment id="_NSID_"> <object
                                            id=EM_I_EMP_CNT classid=<%=Util.CLSID_EMEDIT%> width=118
                                            tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                                        </td>
                                    </tr>
								    -->	 
								    <!-- MARIO OUTLET END -->
                                    <tr>
                                        <th width=89 class="point">사용여부</th>
                                        <td><comment id="_NSID_"> <object
                                            id=LC_I_USE_YN classid=<%= Util.CLSID_LUXECOMBO %> width=75
                                            tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                                        </td>
										<th width="80" class="point">적용시작일</th>
										<td width="92"><comment id="_NSID_"> <object
											id=EM_I_APP_S_DT classid=<%=Util.CLSID_EMEDIT%> width=70
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script><img
											src="/<%=dir%>/imgs/btn/date.gif" id="IMG_APP_S_DT"
											align="absmiddle" class="PR03"
											onclick="javascript:if( EM_I_APP_S_DT.Enable ) openCal('G',EM_I_APP_S_DT);" />
										</td>
										<th width="80" class="point">적용종료일</th>
										<td ><comment id="_NSID_"> <object
											id=EM_I_APP_E_DT classid=<%=Util.CLSID_EMEDIT%> width=70
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script><img
											src="/<%=dir%>/imgs/btn/date.gif" id="IMG_APP_E_DT"
											align="absmiddle" class="PR03"
											onclick="javascript:if( EM_I_APP_E_DT.Enable ) openCal('G',EM_I_APP_E_DT)" />
										</td>
									</tr>
									<tr>
										<th class="point">예산사용</th>
										<td><comment id="_NSID_"><object
											id=LC_I_BUDGET_YN classid=<%= Util.CLSID_LUXECOMBO %>
											width=75 tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>

										<th class="point">순서</th>
										<td colspan="3"><comment id="_NSID_">  <object
											id=EM_I_SORT_ORDER classid=<%= Util.CLSID_EMEDIT %> width=80
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>

									</tr>
									<tr>
										 <!-- MARIO OUTLET START -->
									    
										<th >온라인PC명</th>
										<td colspan="3"><comment id="_NSID_"> <object
											id=LC_I_SAP_ORG classid=<%=Util.CLSID_LUXECOMBO%> width=150 
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										 <%-- <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"
											id="IMG_SAP_ORG" class="PR03" 
											onclick="commonPop('인사조직','SEL_COMM_CODE_ONLY',LC_I_SAP_ORG ,LC_I_SAP_ORG_NM,'D','P043'); LC_I_SAP_ORG.Focus();"
											align="absmiddle" /> <comment id="_NSID_"> <object
											id=LC_I_SAP_ORG_NM classid=<%=Util.CLSID_EMEDIT%> width=130
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>  --%>
										
										  <!-- MARIO OUTLET END -->
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="sub_title PB03 PT10" id=buyerSmTitle><img
									src="/<%=dir%>/imgs/comm/ring_blue.gif" align="absmiddle"
									class="PR03" /> 바이어(SM)정보</td>
								<td class="right PB02" valign="bottom"><img src="/<%=dir%>/imgs/btn/add_row.gif"
									width="52" height="18" id="IMG_BUYERMST_ADD_ROW" hspace="2"
									onClick="javascript:btn_Add1();" /><img
									src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18"
									id="IMG_BUYERMST_DEL_ROW" onClick="javascript:btn_Del1();" /></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr valign="top">
								<td>
								<table border="0" cellspacing="0" cellpadding="0" class="BD4A"
									width="100%">
									<tr>
										<td><comment id="_NSID_"><object
											id=GD_BUYER_MASTER width="100%" height=130
											classid=<%=Util.CLSID_GRID%>>
											<param name="DataID" value="DS_IO_BUYER_MASTER">
										</object></comment><script>_ws_(_NSID_);</script></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="sub_title PB03 PT10" id=buyerSmTitle2><img
									src="/<%=dir%>/imgs/comm/ring_blue.gif" align="absmiddle"
									class="PR03" /> 바이어(SM) 담당자 정보</td>
								<td class="right PB02" valign="bottom"><img src="/<%=dir%>/imgs/btn/add_row.gif"
									width="52" height="18" id="IMG_BUYERDTL_ADD_ROW" hspace="2"
									onClick="javascript:btn_Add2();" /><img
									src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18"
									id="IMG_BUYERDTL_DEL_ROW" onClick="javascript:btn_Del2();" /></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr valign="top">
								<td>
								<table border="0" cellspacing="0" cellpadding="0" class="BD4A"
									width="100%">
									<tr>
										<td><comment id="_NSID_"><object
											id=GD_BUYER_DETAIL width="100%" height=130
											classid=<%=Util.CLSID_GRID%>>
											<param name="DataID" value="DS_IO_BUYER_DETAIL">
										</object></comment><script>_ws_(_NSID_);</script></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
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
<object id=BO_HEADER classid=<%= Util.CLSID_BIND %>>
	<param name=DataID value=DS_IO_TREE_MAIN>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
            <c>col=ORG_CD          ctrl=EM_I_ORG_CD             param=Text</c>
            <c>col=ORG_NAME        ctrl=EM_I_ORG_NM             param=Text</c>
            <c>col=ORG_SHORT_NAME  ctrl=EM_I_ORG_SHORT_NM       param=Text</c>
            <c>col=ORG_FLAG_NM     ctrl=EM_I_ORG_FLAG           param=Text</c>
            <c>col=STR_CD          ctrl=EM_I_STR_CD             param=Text</c>
            <c>col=DEPT_CD         ctrl=EM_I_DEPT_CD            param=Text</c>
            <c>col=TEAM_CD         ctrl=EM_I_TEAM_CD            param=Text</c>
            <c>col=PC_CD           ctrl=EM_I_PC_CD              param=Text</c>
            <c>col=CORNER_CD       ctrl=EM_I_CORNER_CD          param=Text</c>
            <c>col=BF_ORG_CD       ctrl=EM_I_BF_ORG_CD          param=Text</c>
            <c>col=BF_ORG_NAME     ctrl=EM_I_BF_ORG_NM          param=Text</c>
            <c>col=SAP_ORG_CD      ctrl=LC_I_SAP_ORG            param=BindColVal</c>
            <c>col=KOSTL_CD        ctrl=EM_I_KOSTL_CD           param=Text</c>
            <c>col=KOSTL_NAME      ctrl=EM_I_KOSTL_NM           param=Text</c>
            <c>col=MNG_ORG_YN      ctrl=LC_I_MNG_ORG_YN         param=BindColVal</c>
            <c>col=EMP_CNT         ctrl=EM_I_EMP_CNT            param=Text</c>
            <c>col=AREA_SIZE       ctrl=EM_I_AREA_SIZE          param=Text</c>
            <c>col=APP_S_DT        ctrl=EM_I_APP_S_DT           param=Text</c>
            <c>col=APP_E_DT        ctrl=EM_I_APP_E_DT           param=Text</c>
            <c>col=USE_YN          ctrl=LC_I_USE_YN             param=BindColVal</c>
            <c>col=BUDGET_YN       ctrl=LC_I_BUDGET_YN          param=BindColVal</c>
            <c>col=SORT_ORDER      ctrl=EM_I_SORT_ORDER         param=Text</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>

