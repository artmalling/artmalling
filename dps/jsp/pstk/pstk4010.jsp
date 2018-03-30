<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 재고수불 > 저장품 > 저장품입고등록 
 * 작 성 일 : 2010.05.31
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pstk4010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 저장품 입고/입고반품 등록관리를  한다.
 * 이    력 :
 *        2010.05.31 (정진영) 신규작성
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
var isOnPopup = false;
var bfStrCd;
var bfVenCd;
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

    initEmEdit(EM_SLIP_NO     , "YYYYMMDD"   , PK);      //전표일자
    initEmEdit(EM_SLIP_SEQ_NO , "CODE^5^0"   , PK);      //전표일련번호
    initEmEdit(EM_VEN_CD      , "CODE^6^0"   , PK);      //협력사코드
    initEmEdit(EM_VEN_NAME    , "GEN^40"     , READ);    //협력사명
    initEmEdit(EM_CONF_DT     , "YYYYMMDD"   , READ);    //확정일자
    initEmEdit(EM_IN_TOT_QTY  , "NUMBER^7^0" , READ);    //입고총수량
    initEmEdit(EM_IN_TOT_AMT  , "NUMBER^13^0", READ);    //입고총금액
    
    //콤보 초기화 
    initComboStyle(LC_O_STR_CD    ,DS_O_STR_CD    , "CODE^0^30,NAME^0^80", 1, PK);      //점(조회)
    initComboStyle(LC_O_SLIP_FLAG ,DS_O_SLIP_FLAG , "CODE^0^30,NAME^0^80", 1, NORMAL);  //전표구분(조회)
    initComboStyle(LC_STR_CD      ,DS_STR_CD      , "CODE^0^30,NAME^0^80", 1, PK);      //점
    initComboStyle(LC_SLIP_FLAG   ,DS_SLIP_FLAG   , "CODE^0^30,NAME^0^80", 1, PK);      //전표구분
    //initComboStyle(LC_TAX_FLAG    ,DS_TAX_FLAG    , "CODE^0^30,NAME^0^80", 1, READ);  //과세구분 (제외)
    initComboStyle(LC_SLIP_STATUS ,DS_SLIP_STATUS , "CODE^0^30,NAME^0^80", 1, READ);    //확정구분

    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_O_SLIP_FLAG"  , "D", "P803", "Y");
    
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
    setComboData(LC_O_SLIP_FLAG, '%');
    
    enableCnt("R");

    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pstk401","DS_MASTER,DS_DETAIL" );
    LC_O_STR_CD.Focus();
    
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}      width=30   align=center name="NO"           </FC>'
                     + '<FC>id=SLIP_NO       width=80   align=center name="전표일자"      mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=SLIP_SEQ_NO   width=75   align=center name="전표번호"      </FC>'
                     + '<FC>id=SLIP_FLAG     width=90   align=left   name="입고/반품구분 " EditStyle=Lookup data="DS_SLIP_FLAG:CODE:NAME" </FC>';

    initGridStyle(GD_MASTER, "common", hdrProperies, false);
}


function gridCreate2(){
    var hdrProperies = '<FC>id={currow}      width=25   align=center  edit=none     sumtext=""   name="NO"          </FC>'
                     + '<FC>id=PUMBUN_CD     width=75   align=center  edit=none     sumtext=""   name="브랜드코드"    </FC>'
                     + '<FC>id=PUMBUN_NAME   width=110  align=left    edit=none     sumtext=""   name="브랜드명"       </FC>'
                     + '<FC>id=SKU_CD        width=110  align=center  edit=Numeric  sumtext=""   name="*단품코드"    EditStyle=Popup </FC>'
                     + '<FC>id=SKU_NAME      width=120  align=left    edit=none     sumtext=""   name="단품명"       </FC>'
                     + '<FC>id=UNIT_CD       width=65   align=left    edit=none     sumtext=""   name="단위"         EditStyle=Lookup data="DS_UNIT_CD:CODE:NAME" </FC>'
                     + '<FC>id=IN_QTY        width=75   align=right   edit=Numeric  sumtext=@sum name="*수량"        </FC>'
                     + '<FC>id=IN_PRC        width=85   align=right   edit=Numeric  sumtext=@sum name="*원가"        </FC>'
                     + '<FC>id=IN_AMT        width=85   align=right   edit=none     sumtext=@sum name="금액"         </FC>';

    initGridStyle(GD_DETAIL, "common", hdrProperies, true);

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
    if( DS_MASTER.IsUpdated || DS_DETAIL.IsUpdated){
        // 변경된 상세내역이 존재합니다. 조회하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1059") != 1){
            if( DS_MASTER.IsUpdated){
                LC_SLIP_FLAG.Focus();              
            }else{
                GD_DETAIL.Focus();              
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

    var row = DS_MASTER.RowPosition;
    if(DS_MASTER.RowStatus(row)==1){
        // 초기화하시겠습니까?)
        if(showMessage(QUESTION, YESNO, "USER-1051")!=1){
        	DS_MASTER.Focus();
            return; 
        }
        DS_DETAIL.ClearData();
        DS_MASTER.UndoAll();
    }
    
    if( DS_DETAIL.IsUpdated || DS_MASTER.IsUpdated){
        // 변경된 상세내역이 존재합니다. 신규추가하시겠습니까?)
        if(showMessage(QUESTION, YESNO, "USER-1050")!=1){
            if( DS_MASTER.IsUpdated){
            	LC_SLIP_FLAG.Focus();              
            }else{
                GD_DETAIL.Focus();              
            }
            return;         
        }
        DS_DETAIL.ClearData();
        DS_MASTER.UndoAll();
    }

    DS_DETAIL.ClearData();
    DS_MASTER.addRow();
    row = DS_MASTER.CountRow;
    bfMasterRow = row;
    //기초값 설정
    setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    setComboData(LC_SLIP_STATUS,'1'); //미확정 설정
    EM_SLIP_NO.Text = getTodayFormat("YYYYMMDD");
    bfStrCd = LC_STR_CD.BindColVal;
    enableCnt("I");
    LC_SLIP_FLAG.Focus();
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {

	var row = DS_MASTER.RowPosition;
	if( row < 1){
        showMessage(INFORMATION, OK, "USER-1019");
        LC_O_STR_CD.Focus();
        return;
	}
	if(DS_MASTER.NameValue(row,"SLIP_STATUS")!="1"){
        showMessage(INFORMATION, OK, "USER-1000", "확정된 데이터 입니다.");
		GD_MASTER.Focus();
        return;
	}
	
    if( showMessage(QUESTION, YESNO, "USER-1023") != 1 ){
    	GD_MASTER.Focus();
        return; 
    }
    DS_MASTER.DeleteRow(row);

    btnSaveYn = true;
    TR_MAIN.Action="/dps/pstk401.pt?goTo=delete";  
    TR_MAIN.KeyValue="SERVLET(I:DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();    
    btnSaveYn = false;
    if(TR_MAIN.ErrorCode == 0){
        bfMasterRow = 0;
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
    if (!DS_MASTER.IsUpdated && !DS_DETAIL.IsUpdated ){
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
        if(DS_DETAIL.CountRow > 0){
            GD_DETAIL.Focus();
            return;
        }
        if( DS_MASTER.CountRow < 1){
            LC_O_STR_CD.Focus();
        }else{
            GD_MASTER.Focus();
        }
        return;
    }

    if( !checkMasterValidation())
        return;
    if( !checkDetailValidation())
        return;
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
    	LC_SLIP_FLAG.Focus();
        return; 
    }
    var slipNo = DS_MASTER.NameValue(DS_MASTER.RowPosition,"SLIP_NO");
    var slipSeqNo = DS_MASTER.NameValue(DS_MASTER.RowPosition,"SLIP_SEQ_NO");
    btnSaveYn = true;
    TR_MAIN.Action="/dps/pstk401.pt?goTo=save";  
    TR_MAIN.KeyValue="SERVLET(I:DS_MASTER=DS_MASTER,I:DS_DETAIL=DS_DETAIL)"; //조회는 O
    TR_MAIN.Post();    
    btnSaveYn = false;
    
    if(TR_MAIN.ErrorCode == 0){
    	var row = DS_MASTER.CountRow;
    	if(slipSeqNo != ""){
    		row = getNameValueRow( DS_MASTER, "SLIP_NO||SLIP_SEQ_NO", slipNo+"||"+slipSeqNo);
    	}
        bfMasterRow = 0;
        searchMaster();
        
        DS_MASTER.RowPosition = row;
    }
    LC_SLIP_FLAG.Focus();
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
function btn_addRow(){
	var masterRow = DS_MASTER.RowPosition;
	if( masterRow < 1){
        showMessage(INFORMATION, OK, "USER-1000", "전표마스터 선택 후 행추가가 가능합니다.");
        if(DS_MASTER.CountRow < 1){
        	LC_O_STR_CD.Focus();
        }else{
        	GD_MASTER.Focus();
        }
		return;
	}
	if( DS_MASTER.NameValue(masterRow,"SLIP_STATUS")!="1"){
        showMessage(INFORMATION, OK, "USER-1000", "확정된 데이터 입니다.");
        GD_MASTER.Focus();
        return;		
	}
	var strCd     = DS_MASTER.NameValue(masterRow,"STR_CD");
    var slipNo    = DS_MASTER.NameValue(masterRow,"SLIP_NO");
    var slipSeqNo = DS_MASTER.NameValue(masterRow,"SLIP_SEQ_NO");

    if( strCd == ""){
        showMessage(EXCLAMATION, OK, "USER-1002", "점");
        setTimeout("LC_STR_CD.Focus();",50);
        return;
    }
    if( EM_VEN_CD.Text == ""){
        showMessage(EXCLAMATION, OK, "USER-1003", "협력사");
        setTimeout("EM_VEN_CD.Focus();",50);
        return;
    }
    DS_DETAIL.AddRow();
    var row = DS_DETAIL.CountRow;
    DS_DETAIL.NameValue(row,"STR_CD")      = strCd;
    DS_DETAIL.NameValue(row,"SLIP_NO")     = slipNo;
    DS_DETAIL.NameValue(row,"SLIP_SEQ_NO") = slipSeqNo;
    
    setFocusGrid(GD_DETAIL, DS_DETAIL, row, "SKU_CD");
}
/**
 * btn_delRow()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  행 삭제
 * return값 : void
 */
function btn_delRow(){
    if(DS_DETAIL.CountRow < 1){
        showMessage(INFORMATION, OK, "USER-1019");
        if(DS_MASTER.CountRow < 1){
            LC_O_STR_CD.Focus();
        }else{
            GD_MASTER.Focus();
        }
        return;     
    }
    if( DS_MASTER.NameValue(DS_MASTER.RowPosition,"SLIP_STATUS")!="1"){
        showMessage(INFORMATION, OK, "USER-1000", "확정된 데이터 입니다.");
        GD_MASTER.Focus();
        return;     
    }
    DS_DETAIL.DeleteRow(DS_DETAIL.RowPosition);
    setTotalValue();
}

/**
 * searchMaster()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  F&B매장 리스트 조회
 * return값 : void
 */
function searchMaster(){

	DS_MASTER.ClearData();
    DS_DETAIL.ClearData();
    
    var strStrCd    = LC_O_STR_CD.BindColVal;
    var strFromDt   = EM_O_FROM_DT.Text;
    var strToDt     = EM_O_TO_DT.Text;
    var strVenCd    = EM_O_VEN_CD.Text;
    var strPumbunCd = EM_O_PUMBUN_CD.Text;
    var strSlipFlag = LC_O_SLIP_FLAG.BindColVal;

    
    var goTo       = "searchMaster" ;    
    var action     = "O";  
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                   + "&strFromDt="+encodeURIComponent(strFromDt)
                   + "&strToDt="+encodeURIComponent(strToDt)
                   + "&strVenCd="+encodeURIComponent(strVenCd)
                   + "&strPumbunCd="+encodeURIComponent(strPumbunCd)
                   + "&strSlipFlag="+encodeURIComponent(strSlipFlag);
    TR_SUB.Action="/dps/pstk401.pt?goTo="+goTo+parameters;      
    TR_SUB.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_SUB.Post();    
    
    //조회후 결과표시
    setPorcCount("SELECT",GD_MASTER);  

} 
/**
 * searchDetail()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  F&B매장메뉴분류 리스트 조회
 * return값 : void
 */
function searchDetail(){
    DS_DETAIL.ClearData();
    var masterRow    = DS_MASTER.RowPosition;
    if( masterRow < 1){
        if(DS_MASTER.CountRow < 1){
            LC_STR_CD.Focus();
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
    TR_MAIN.Action="/dps/pstk401.pt?goTo="+goTo+parameters;      
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
function getVenCode(evnflag, scvflag){
    var codeObj = scvflag=="S"?EM_O_VEN_CD:EM_VEN_CD;
    var nameObj = scvflag=="S"?EM_O_VEN_NAME:EM_VEN_NAME;
    var strObj  = scvflag=="S"?LC_O_STR_CD:LC_STR_CD;

    if(scvflag=="I"){
    	if(DS_DETAIL.CountRow > 0){
    		if(showMessage(QUESTION, YESNO, "USER-1064","협력사코드","전표상세") != 1 ){
    			codeObj.Text = bfVenCd;
    			codeObj.Focus();
    			return;
    		}
    	}
        DS_DETAIL.ClearData();
    }
    if( codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
        if(scvflag=="I")
            bfVenCd = codeObj.Text;
        return;     
    }
    
    if( evnflag == "POP" ){
        venPop(codeObj,nameObj,strObj.BindColVal);
        codeObj.Focus();
    }else if( evnflag == "NAME" ){
        setVenNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj, 1, strObj.BindColVal);
    }
    if(scvflag=="I")
    	bfVenCd = codeObj.Text;
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
    
    if(!checkDateTypeYMD( obj , getTodayFormat("YYYYMMDD")))
        return;
    
    if(scvFlag != "I")
        return;
    
    if(obj.Text < getTodayFormat("YYYYMMDD")){  
        obj.Text = getTodayFormat("YYYYMMDD");
        showMessage(INFORMATION, OK, "USER-1030","입고/반품일자");    
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
 * setSkuCodeToGrid()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 단품 팝업을 실행한다.(그리드)
 * return값 : void
**/
function setSkuCodeToGrid(evnFlag, row){
    var codeStr = DS_DETAIL.NameValue(row,"SKU_CD");
    var strCd   = DS_MASTER.NameValue(DS_MASTER.RowPosition,"STR_CD");
    var venCd   = DS_MASTER.NameValue(DS_MASTER.RowPosition,"VEN_CD");
    var appDt   = DS_MASTER.NameValue(DS_MASTER.RowPosition,"SLIP_NO");

    if( strCd == ""){
        showMessage(EXCLAMATION, OK, "USER-1002", "점");
        setTimeout("LC_STR_CD.Focus();",50);
        return;
    }
    if( appDt == ""){
        showMessage(EXCLAMATION, OK, "USER-1003", "입고/반품일자");
        setTimeout("EM_SLIP_NO.Focus();",50);
        return;
    }/*
    if( venCd == ""){
        showMessage(EXCLAMATION, OK, "USER-1003", "협력사");
        setTimeout("EM_VEN_CD.Focus();",50);
        return;
    }*/
    if( codeStr == "" && evnFlag != 'POP'){
        DS_DETAIL.NameValue(row,"PUMBUN_CD")   = "";
        DS_DETAIL.NameValue(row,"PUMBUN_NAME") = "";
        DS_DETAIL.NameValue(row,"PUMMOK_CD")   = "";
        DS_DETAIL.NameValue(row,"DEPT_CD")     = "";
        DS_DETAIL.NameValue(row,"TEAM_CD")     = "";
        DS_DETAIL.NameValue(row,"PC_CD")       = "";
        DS_DETAIL.NameValue(row,"SKU_NAME")    = "";
        DS_DETAIL.NameValue(row,"UNIT_CD")     = "";
        DS_DETAIL.NameValue(row,"IN_QTY")      = "";
        DS_DETAIL.NameValue(row,"IN_PRC")      = "";
        DS_DETAIL.NameValue(row,"IN_AMT")      = "";
        return;
    }
    var rtnMap;
    if( evnFlag == 'POP'){
        rtnMap = strSkuToGridPop(codeStr,'','Y', '', strCd, '', '3', '', 'Y');//, '', '', venCd);
    }else{
        DS_MASTER.NameValue(row,"SKU_NAME") = "";
        rtnMap = setStrSkuNmWithoutToGridPop("DS_SEARCH_NM", codeStr, '' ,'Y', 1, '', strCd, '', '3', '', 'Y');//, '', '', venCd);
    }
    
    if( rtnMap == null){
        if( DS_DETAIL.NameValue(row,"SKU_NAME") == ""){
            DS_DETAIL.NameValue(row,"PUMBUN_CD")   = "";
            DS_DETAIL.NameValue(row,"PUMMOK_CD")   = "";
            DS_DETAIL.NameValue(row,"PUMBUN_NAME") = "";
            DS_DETAIL.NameValue(row,"SKU_NAME")    = "";
            DS_DETAIL.NameValue(row,"SKU_CD")      = "";
            DS_DETAIL.NameValue(row,"DEPT_CD")     = "";
            DS_DETAIL.NameValue(row,"TEAM_CD")     = "";
            DS_DETAIL.NameValue(row,"PC_CD")       = "";
            DS_DETAIL.NameValue(row,"IN_QTY")      = "";
            DS_DETAIL.NameValue(row,"IN_PRC")      = "";
            DS_DETAIL.NameValue(row,"IN_AMT")      = "";
        }       
        return;
    }

    DS_DETAIL.NameValue(row,"SKU_CD")      = rtnMap.get("SKU_CD");
    DS_DETAIL.NameValue(row,"SKU_NAME")    = rtnMap.get("SKU_NAME");
    DS_DETAIL.NameValue(row,"PUMBUN_CD")   = rtnMap.get("PUMBUN_CD");
    DS_DETAIL.NameValue(row,"PUMBUN_NAME") = rtnMap.get("PUMBUN_NAME");
    DS_DETAIL.NameValue(row,"PUMMOK_CD")   = rtnMap.get("PUMMOK_CD");
    DS_DETAIL.NameValue(row,"UNIT_CD")     = rtnMap.get("SALE_UNIT_CD");
    var detailData = false;
    setDataSet("DS_SEARCH_NM","SEL_STRPBN_ORG_CD", strCd, rtnMap.get("PUMBUN_CD"));
    
    if( DS_SEARCH_NM.CountRow == 1){
        var buyOrgCd     = DS_SEARCH_NM.NameValue(1,"COL1");
        DS_DETAIL.NameValue(row,"DEPT_CD")    = buyOrgCd.substring(2,4);    
        DS_DETAIL.NameValue(row,"TEAM_CD")    = buyOrgCd.substring(4,6);     
        DS_DETAIL.NameValue(row,"PC_CD")      = buyOrgCd.substring(6,8);         
        detailData = true;
    }else{
        showMessage(EXCLAMATION, OK, "USER-1000", "조직정보가 존재하지 않습니다.");
    }
    
    if( detailData ){	
        setDataSet("DS_SEARCH_NM","SEL_STRSKUPRCMST_NORM_PRC", strCd, rtnMap.get("SKU_CD"), appDt);
        if( DS_SEARCH_NM.CountRow == 1){
            DS_DETAIL.NameValue(row,"IN_PRC")      = DS_SEARCH_NM.NameValue(1,"COL1");
            setAmtValue(row);
            setTotalValue();
            return;
        }
        showMessage(EXCLAMATION, OK, "USER-1000", "정상원가가 존재하지 않습니다.");
    }
    DS_DETAIL.NameValue(row,"PUMBUN_CD")   = "";
    DS_DETAIL.NameValue(row,"PUMBUN_NAME") = "";
    DS_DETAIL.NameValue(row,"PUMMOK_CD")   = "";
    DS_DETAIL.NameValue(row,"DEPT_CD")     = "";
    DS_DETAIL.NameValue(row,"TEAM_CD")     = "";
    DS_DETAIL.NameValue(row,"PC_CD")       = "";
    DS_DETAIL.NameValue(row,"SKU_CD")      = "";
    DS_DETAIL.NameValue(row,"SKU_NAME")    = "";
    DS_DETAIL.NameValue(row,"UNIT_CD")     = "";
    DS_DETAIL.NameValue(row,"IN_QTY")      = "";
    DS_DETAIL.NameValue(row,"IN_PRC")      = "";
    DS_DETAIL.NameValue(row,"IN_AMT")      = "";

    setAmtValue(row);
    setTotalValue();
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
    
    enableControl(EM_SLIP_NO         , insFlag);
    enableControl(IMG_SLIP_NO        , insFlag);
    enableControl(EM_SLIP_SEQ_NO     , readFlag);
    enableControl(EM_VEN_CD          , insFlag);
    enableControl(IMG_VEN_CD         , insFlag);
    enableControl(EM_VEN_NAME        , readFlag);
    enableControl(EM_CONF_DT         , readFlag);
    enableControl(EM_IN_TOT_QTY      , readFlag);
    enableControl(EM_IN_TOT_AMT      , readFlag);
    enableControl(LC_STR_CD          , insFlag);
    enableControl(LC_SLIP_FLAG       , insFlag);
    enableControl(LC_SLIP_STATUS       , readFlag);
    enableControl(IMG_ADD_ROW        , updFlag);
    enableControl(IMG_DEL_ROW        , updFlag);
    GD_DETAIL.Editable = updFlag;
}

/**
 * setAmtValue()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 수량과 원가로 금액을 계산한다.
 * return값 : void
 */
function setAmtValue(row){
	var qty = Number(DS_DETAIL.NameValue(row,"IN_QTY"));
    var prc = Number(DS_DETAIL.NameValue(row,"IN_PRC"));
	DS_DETAIL.NameValue(row,"IN_AMT") = qty * prc;
}
/**
 * setTotalValue()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 상세 입력 된 수량 및 금액의 총 값을 입력한다.
 * return값 : void
 */
function setTotalValue(){
	EM_IN_TOT_QTY.Text = DS_DETAIL.Sum(DS_DETAIL.ColumnIndex("IN_QTY"),0,0);
	EM_IN_TOT_AMT.Text = DS_DETAIL.Sum(DS_DETAIL.ColumnIndex("IN_AMT"),0,0);
}
/**
 * checkMasterValidation()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 상세 입력 값을 검증한다.
 * return값 : void
 */
function checkMasterValidation(){
	 
    var rowStatus = DS_MASTER.SysStatus(DS_MASTER.RowPosition);
    var totalQty = DS_DETAIL.Sum(DS_DETAIL.ColumnIndex("IN_QTY"),0,0);
    var totalAmt = DS_DETAIL.Sum(DS_DETAIL.ColumnIndex("IN_AMT"),0,0);

    if( DS_DETAIL.CountRow < 1){
        showMessage(INFORMATION, OK, "USER-1000", "1건 이상의 상세 데이터를 입력하세요.");
        GD_DETAIL.Focus();
        return false;           
    }
    
    if( LC_STR_CD.BindColVal == ""){
        showMessage(EXCLAMATION, OK, "USER-1002", "점");
        LC_STR_CD.Focus();
        return false;     
    }else if( EM_SLIP_NO.Text == ""){
        showMessage(EXCLAMATION, OK, "USER-1003", "전표일자");
        EM_SLIP_NO.Focus();
        return false;     
    }else if( !checkYYYYMMDD(EM_SLIP_NO.Text)){
        showMessage(EXCLAMATION, OK, "USER-1007", "전표일자");
        EM_SLIP_NO.Focus();
        return false;     
    }else if( rowStatus=="1" && EM_SLIP_NO.Text < getTodayFormat("YYYYMMDD")){
        showMessage(EXCLAMATION, OK, "USER-1030", "전표일자");
        EM_SLIP_NO.Focus();
        return false;     
    }else if( LC_SLIP_FLAG.BindColVal == ""){
        showMessage(EXCLAMATION, OK, "USER-1003", "전표구분");
        LC_SLIP_FLAG.Focus();
        return false;     
    }else if( EM_VEN_CD.Text == ""){
        showMessage(EXCLAMATION, OK, "USER-1003", "협력사코드");
        EM_VEN_CD.Focus();
        return false;     
    }else if( EM_VEN_NAME.Text == ""){
        showMessage(EXCLAMATION, OK, "USER-1036", "협력사코드");
        EM_VEN_CD.Focus();
        return false;     
    }else if( totalQty != EM_IN_TOT_QTY.Text ){
        showMessage(EXCLAMATION, OK, "USER-1000", "총수량과 전표상세의 수량 합계가 일치 하지 않습니다.");
        GD_DETAIL.Focus();
        return false;         	
    }else if( totalAmt != EM_IN_TOT_AMT.Text ){
        showMessage(EXCLAMATION, OK, "USER-1000", "총금액과 전표상세의 금액 합계가 일치 하지 않습니다.");
        GD_DETAIL.Focus();
        return false;           
    }
    return true;
}

/**
 * checkDetailValidation()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 상세 입력 값을 검증한다.
 * return값 : void
 */
function checkDetailValidation(){
    var row;
    var colid;
    var errYn = false;

    var dupRow = checkDupKey(DS_DETAIL,"SKU_CD");
    if( dupRow > 0){
        showMessage(EXCLAMATION, OK, "USER-1044");
        setFocusGrid(GD_DETAIL,DS_DETAIL,dupRow,"SKU_CD");
        return false;
    }
    
    for(var i=1; i<=DS_DETAIL.CountRow; i++){
        var rowStatus = DS_DETAIL.RowStatus(i);
        if( !(rowStatus == "1" || rowStatus == "3") )
            continue;

        if( DS_MASTER.NameValue(DS_MASTER.RowPosition,"SLIP_STATUS")!="1"){
            showMessage(INFORMATION, OK, "USER-1000", "확정된 데이터 입니다.");
            GD_MASTER.Focus();
            return;     
        }
        row = i;
        if( DS_DETAIL.NameValue(i,"SKU_CD")=="" ){
            showMessage(EXCLAMATION, OK, "USER-1003", "단품코드");
            errYn = true;
            colid = "SKU_CD";
            break;
        }
        if( DS_DETAIL.NameValue(i,"SKU_NAME")==""){
            showMessage(EXCLAMATION, OK, "USER-1036", "단품코드");
            colid = "SKU_CD";    
            errYn = true;
            break;
        }
        if( DS_DETAIL.NameValue(i,"IN_QTY")==""){
            showMessage(EXCLAMATION, OK, "USER-1008", "수량", 0);
            colid = "IN_QTY";    
            errYn = true;
            break;
        }
        if( DS_DETAIL.NameValue(i,"IN_PRC")==""){
            showMessage(EXCLAMATION, OK, "USER-1008", "원가", 0);
            colid = "IN_PRC";    
            errYn = true;
            break;
        }
    }
    
    if(errYn){
        setFocusGrid(GD_DETAIL,DS_DETAIL,row,colid);
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
<script language=JavaScript for=DS_DETAIL event=OnDataError(row,colid)>
    var errorCode = DS_DETAIL.ErrorCode;
    if(errorCode == "50019"){
        showMessage(EXCLAMATION, OK, "USER-1044");
    }else if( errorCode == "50018"){
        showMessage(EXCLAMATION, OK, "USER-1003", "단품코드");
    }else{
        showMessage(EXCLAMATION, OK, "USER-1000",DS_DETAIL.ErrorMsg);       
    }
</script>
<script language=JavaScript for=DS_MASTER event=CanRowPosChange(row)>
    if(btnSaveYn || row < 1)
        return true;
    
    if( DS_DETAIL.IsUpdated || DS_MASTER.IsUpdated){
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
    
    if(DS_MASTER.RowStatus(row)!="1"){
        searchDetail();
    }
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=JavaScript for=GD_DETAIL event=OnExit(row,colid,oldData)>
    if( row < 1 || isOnPopup)
        return;
    var value = DS_DETAIL.NameValue(row,colid);
    if( oldData == value )
        return;
    switch(colid){
        case 'SKU_CD':  
            setSkuCodeToGrid('NAME',row);
            break;
        case 'IN_QTY':  
        case 'IN_PRC':  
            setAmtValue(row);
            setTotalValue();
            break;
    }
</script>
<script language=JavaScript for=GD_DETAIL event=OnPopup(row,colid,data)>
    if( row < 1 )
        return;
    isOnPopup = true;
    switch(colid){
        case 'SKU_CD':  
            setSkuCodeToGrid('POP',row);
            break;
    }
    isOnPopup = false;
</script>

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
<!-- 점 -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
    if( bfStrCd == this.BindColVal)
        return;

    if(DS_DETAIL.CountRow > 0){
        if(showMessage(QUESTION, YESNO, "USER-1064","점","전표상세") != 1 ){
            setComboData(LC_STR_CD,bfStrCd);
            LC_STR_CD.Focus();
            return;
        }
    }
    DS_DETAIL.ClearData();
    
    bfStrCd = this.BindColVal;
</script>
<script language=JavaScript for=LC_STR_CD event=onKillFocus()>
//
    //
    
    
</script>
<!-- 협력사 -->
<script language=JavaScript for=EM_VEN_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    getVenCode('NAME','I');
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
<script language=JavaScript for=EM_SLIP_NO event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    getCalDt('NAME',EM_SLIP_NO,"I");
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
<comment id="_NSID_"><object id="DS_O_STR_CD"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_SLIP_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_STR_CD"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SLIP_FLAG"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SLIP_STATUS"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_TAX_FLAG"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_UNIT_CD"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

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
            <th >입고/반품구분</th>
            <td >
               <comment id="_NSID_">
                 <object id=LC_O_SLIP_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=140 align="absmiddle">
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
                    <th width="70" class="point">점</th>
                    <td width="100">
                      <comment id="_NSID_">
                        <object id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%>  width=100  tabindex=1 align="absmiddle"></object>
                      </comment><script> _ws_(_NSID_);</script>
                    </td>
                    <th width="75" class="point">입고/반품일자</th>
                    <td width="95">
                      <comment id="_NSID_">
                        <object id=EM_SLIP_NO classid=<%=Util.CLSID_EMEDIT%> width=73 tabindex=1 align="absmiddle"></object>
                      </comment> <script> _ws_(_NSID_);</script><img 
                      src="/<%=dir%>/imgs/btn/date.gif"  class="PR03" id=IMG_SLIP_NO onclick="javascript:getCalDt('POP', EM_SLIP_NO,'I')" align="absmiddle" />
                    </td>
                    <th width="50" class="point">전표번호</th>
                    <td >
                      <comment id="_NSID_">
                        <object id=EM_SLIP_SEQ_NO classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1 align="absmiddle"></object>
                      </comment> <script> _ws_(_NSID_);</script>
                    </td>
                  </tr>
                  <tr>
                    <th class="point">입고/반품구분</th>
                    <td >
                      <comment id="_NSID_">
                        <object id=LC_SLIP_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=100 tabindex=1 align="absmiddle"></object>
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th class="point">협력사</th>
                    <td colspan="3">
                      <comment id="_NSID_">
                        <object id=EM_VEN_CD classid=<%=Util.CLSID_EMEDIT%>  width=73  tabindex=1 align="absmiddle"></object>
                      </comment><script> _ws_(_NSID_);</script><img 
                      src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_VEN_CD  onclick="javascript:getVenCode('POP','I');"  align="absmiddle" />
                      <comment id="_NSID_">
                        <object id=EM_VEN_NAME classid=<%=Util.CLSID_EMEDIT%>  width=117  tabindex=1 align="absmiddle"></object>
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
                    <th >확정일자</th>
                    <td colspan="3">
                      <comment id="_NSID_">
                        <object id=EM_CONF_DT classid=<%=Util.CLSID_EMEDIT%>  width=95  tabindex=1 align="absmiddle"></object>
                      </comment><script> _ws_(_NSID_);</script>
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
                    <td class="right PB03"><img 
                    src="/<%=dir%>/imgs/btn/add_row.gif" id=IMG_ADD_ROW onClick="javascript:btn_addRow();" hspace="2" /><img 
                    src="/<%=dir%>/imgs/btn/del_row.gif" id=IMG_DEL_ROW onClick="javascript:btn_delRow();"  /></td>
                  </tr>
                </table></td>
              </tr>
              <tr valign="top">
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                  <tr>
                    <td>
                      <comment id="_NSID_">
                        <object id=GD_DETAIL width=100% height=334 classid=<%=Util.CLSID_GRID%>>
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

