<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > POS기준정보> 임대협력사명판관리
 * 작 성 일 : 2010.01.19
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod8040.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 임대 협력사의 POS 명판정보를 관리한다
 * 이    력 :
 *        2010.01.19 (정진영) 신규작성
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
var isOnPopup = false;  // 그리드 팝업 실행여부
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
    
    //그리드 초기화
    gridCreate1(); //마스터

    // EMedit에 초기화
    initEmEdit(EM_COMP_NO   , "000-00-00000",  NORMAL);  //사업자번호
    initEmEdit(EM_COMP_NAME , "GEN^28"      ,  NORMAL);  //상호명
    initEmEdit(EM_VEN_CD    , "CODE^6^0"    ,  NORMAL);  //협력사코드
    initEmEdit(EM_VEN_NAME  , "GEN^40"      ,  READ);    //협력사명

    //콤보 초기화 
    initComboStyle(LC_USE_YN,DS_USE_YN, "CODE^0^30,NAME^0^80", 1, NORMAL);  //사용여부(조회)

    // 삭제된 로우 표시여부
    //DS_MASTER.ViewDeletedRow = true;
    
    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_USE_YN"      , "D", "D022", "Y");
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_USE_YN,'Y');

    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pcod804","DS_MASTER" );
    
    EM_COMP_NO.Focus();
    
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}   width=25   align=center edit=none     name="NO"         </FC>'
                     + '<FG>name="*협력사"'
                     + '<FC>id=VEN_CD     width=70   align=center edit=Numeric  name="*코드   "      EditStyle=Popup</FC>'
                     + '<FC>id=VEN_NAME   width=130   align=left   edit=none     name="*명   "        </FC>'
                     + '</FG>'
                     + '<FC>id=COMP_NAME  width=90   align=left                 name="*상호명"      </FC>'
                     + '<FC>id=COMP_NO    width=100   align=center edit=Numeric     name="*사업자번호 "  mask="XXX-XX-XXXXX"</FC>'
                     + '<FC>id=ADDR       width=250  align=left                 name="*주소 "      </FC>'
                     + '<FC>id=REP_NAME   width=85   align=left                 name="*대표자명 "     </FC>'
                     + '<FG>name="*전화번호"'
                     + '<FC>id=PHONE1_NO  width=50   align=left   edit=Numeric  name="국 "         </FC>'
                     + '<FC>id=PHONE2_NO  width=50   align=left   edit=Numeric  name="지역"        </FC>'
                     + '<FC>id=PHONE3_NO  width=50   align=left   edit=Numeric  name="번호"        </FC>'
                     + '</FG>'
                     + '<FC>id=USE_YN     width=60   align=center               name="*사용;여부 "   EditStyle=Combo data="Y:YES,N:NO"</FC>';

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
    if( DS_MASTER.IsUpdated){
        if( showMessage(QUESTION, YESNO, "USER-1059") != 1){
            GD_MASTER.Focus();
            return ;
        }
    }
    DS_MASTER.ClearData();

    var strCompNo   = EM_COMP_NO.Text;
    var strCompName = EM_COMP_NAME.Text;
    var strUseYn    = LC_USE_YN.BindColVal;
    var strVenCd    = EM_VEN_CD.Text;

    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strCompNo="	+encodeURIComponent(strCompNo)
                   + "&strCompName="+encodeURIComponent(strCompName)
                   + "&strUseYn="	+encodeURIComponent(strUseYn)
                   + "&strVenCd="	+encodeURIComponent(strVenCd);
    TR_MAIN.Action="/dps/pcod804.pc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();

    //조회후 결과표시
    setPorcCount("SELECT",GD_MASTER);
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
    if (!DS_MASTER.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
        if( DS_MASTER.CountRow < 1){
        	EM_COMP_NO.Focus();
        }else{
            GD_MASTER.Focus();
        }
        return;
    }

    if( !checkMasterValidation())
        return;

    // 마감체크 (common.js)
    if( getCloseCheck('DS_CLOSECHECK','',getTodayFormat("YYYYMMDD"),'PCOD','04','0','T') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
        GD_MASTER.Focus();
        return;
    }
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        GD_MASTER.Focus();
        return; 
    }
    var venCd = DS_MASTER.NameValue(DS_MASTER.RowPosition,"VEN_CD");
    TR_MAIN.Action="/dps/pcod804.pc?goTo=save";  
    TR_MAIN.KeyValue="SERVLET(I:DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();    
    
    if(TR_MAIN.ErrorCode == 0){
    	btn_Search();
    	//DS_MASTER.RowPosition = DS_MASTER.NameValueRow("VEN_CD",venCd);
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
function btn_addRow(){
	DS_MASTER.AddRow();
	DS_MASTER.NameValue(DS_MASTER.CountRow,"USE_YN") = "Y";
	setFocusGrid(GD_MASTER,DS_MASTER,DS_MASTER.CountRow,"VEN_CD");
}
/**
 * btn_delRow1()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  행사장 삭제
 * return값 : void
 */
function btn_delRow(){
    var ckeckYn = DS_MASTER.NameValue(DS_MASTER.RowPosition, "EDIT_YN");
    if(ckeckYn == "N"){
        showMessage(INFORMATION, OK, "USER-1000", "당일 등록한 건만 삭제 가능합니다.");
        GD_MASTER.Focus();
        return;
    }
    DS_MASTER.DeleteRow(DS_MASTER.RowPosition);
}

/**
 * btn_preview()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  미리보기 팝업 실행
 * return값 : void
 */
function btn_preview(){
	var row = DS_MASTER.RowPosition;
	if(row<1){
        showMessage(INFORMATION, OK, "USER-1000", "선택된 내용이 없습니다.");
        EM_COMP_NO.Focus();
        return;
	}
    var colid;
    var isCheck = false;
	var lengthCneckRtn = checkByteLengthStr(DS_MASTER.NameValue(row,"COMP_NAME"),28,"N");
    if( lengthCneckRtn != null){
        showMessage(EXCLAMATION, OK, "GAUCE-1000", "상호명은 28Byte 이상 초과 입력할수 없습니다.");
        colid = "COMP_NAME";
        isCheck = true;
    }
    lengthCneckRtn = checkByteLengthStr(DS_MASTER.NameValue(row,"ADDR"),42,"N");
    if( !isCheck && lengthCneckRtn != null){
        showMessage(EXCLAMATION, OK, "GAUCE-1000", "주소는 42Byte 이상 초과 입력할수 없습니다.");
        colid = "ADDR";
        isCheck = true;
    }
    lengthCneckRtn = checkByteLengthStr(DS_MASTER.NameValue(row,"REP_NAME"),10,"N");
    if( !isCheck && lengthCneckRtn != null){
        showMessage(EXCLAMATION, OK, "GAUCE-1000", "대표자명은 10Byte 이상 초과 입력할수 없습니다.");
        colid = "REP_NAME";
        isCheck = true;
    }
    if(isCheck){
        setFocusGrid(GD_MASTER,DS_MASTER,row,colid);
        return;
    }
    var arrArg  = new Array();
    arrArg.push(DS_MASTER.NameValue(row,"COMP_NAME"));
    arrArg.push(DS_MASTER.NameValue(row,"COMP_NO"));
    arrArg.push(DS_MASTER.NameValue(row,"ADDR"));
    arrArg.push(DS_MASTER.NameValue(row,"REP_NAME"));
    arrArg.push(DS_MASTER.NameValue(row,"PHONE1_NO"));
    arrArg.push(DS_MASTER.NameValue(row,"PHONE2_NO"));
    arrArg.push(DS_MASTER.NameValue(row,"PHONE3_NO"));
    var returnVal = window.showModalDialog("/dps/pcod804.pc?goTo=preview",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
   
}

/**
 * process()
 * 작 성 자     : 김경은
 * 작 성 일     : 2010-06-10
 * 개    요        : 처리버튼 클릭시
 * return값 : void
 */
function btn_send_stmp_emg(){
	
	 	var strVenCd = DS_MASTER.NameValue(DS_MASTER.RowPosition,"VEN_CD");
		var strProcDt       = getRawData(addDate('D',1,getTodayFormat('YYYYMMDD')));

        if( strVenCd == ''){
        	showMessage(EXCLAMATION, OK, "USER-1000","협력업체가 존재하지 않습니다.");
        	return;
        }
        
	    if( showMessage(QUESTION, YESNO, "USER-1204") == 1 ){
	 
	        var parameters    = "&strProcDt="  + encodeURIComponent(strProcDt)
	    					  + "&strVenCd="   + encodeURIComponent(strVenCd)
	    					  ;
	       
	    	TR_MAIN.Action = "/dps/pcod804.pc?goTo=sendstmpemg"+parameters;
	    	TR_MAIN.KeyValue = "SERVLET(O:DS_MASTER=DS_MASTER)";
	    	//searchSetWait("B"); // 프로그래스바
	    	TR_MAIN.Post();        
	    }
}

/**
 * setVenCode()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 협력사 팝업을 실행한다.
 * return값 : void
**/
function setVenCode(evnFlag){
    var codeObj = EM_VEN_CD;
    var nameObj = EM_VEN_NAME;
    
    if( evnFlag == 'POP'){
        //venPop(codeObj,nameObj,'','','','3');
        venPop(codeObj,nameObj,'','','','');
        codeObj.Focus();
        return;
    }

    if( codeObj.Text ==""){
        nameObj.Text = "";    
        return;
    }
    
    //setVenNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj , 1,'','','','3');
    setVenNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj , 1,'','','','');
}

/**
 * setVenCode()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 협력사 팝업을 실행한다.(그리드)
 * return값 : void
**/
function setVenCodeToGrid(evnFlag, row){
	 
    var codeStr = DS_MASTER.NameValue(row,"VEN_CD");
    if( codeStr == "" && evnFlag != 'POP'){
        clearVenInfo(row, true);
        return;
    }
    var rtnMap;
    if( evnFlag == 'POP'){
    	//rtnMap = venToGridPop(codeStr,'','','Y','','3');
    	rtnMap = venToGridPop(codeStr,'','','Y','','');
    }else{
    	clearVenInfo(row,false);
    	//rtnMap = setVenNmWithoutToGridPop("DS_SEARCH_NM", codeStr, '' , 1,'','Y','','3');
    	rtnMap = setVenNmWithoutToGridPop("DS_SEARCH_NM", codeStr, '' , 1,'','Y','','');
    }
    
    if( rtnMap == null){
    	if( DS_MASTER.NameValue(row,"VEN_NAME") == ""){
            clearVenInfo(row,true);
    	}    	
    	return;
    }
    
    getVenInfo("DS_SEARCH_NM",rtnMap.get("VEN_CD"));
    
    if(DS_SEARCH_NM.CountRow != 1){
        showMessage(INFORMATION, OK, "USER-1000", "협력사 정보가 존재하지 않습니다.");
        clearVenInfo(row,true);
        return;
    }
    DS_MASTER.NameValue(row,"VEN_CD")    = DS_SEARCH_NM.NameValue(1,"VEN_CD");
    DS_MASTER.NameValue(row,"VEN_NAME")  = DS_SEARCH_NM.NameValue(1,"VEN_NAME");
    DS_MASTER.NameValue(row,"COMP_NAME") = DS_SEARCH_NM.NameValue(1,"COMP_NAME");
    DS_MASTER.NameValue(row,"COMP_NO")   = DS_SEARCH_NM.NameValue(1,"COMP_NO");
    DS_MASTER.NameValue(row,"ADDR")      = DS_SEARCH_NM.NameValue(1,"ADDR")+" "+DS_SEARCH_NM.NameValue(1,"DTL_ADDR");
    DS_MASTER.NameValue(row,"REP_NAME")  = DS_SEARCH_NM.NameValue(1,"REP_NAME");
    DS_MASTER.NameValue(row,"PHONE1_NO") = DS_SEARCH_NM.NameValue(1,"PHONE1_NO");
    DS_MASTER.NameValue(row,"PHONE2_NO") = DS_SEARCH_NM.NameValue(1,"PHONE2_NO");
    DS_MASTER.NameValue(row,"PHONE3_NO") = DS_SEARCH_NM.NameValue(1,"PHONE3_NO");
    
}

/**
 * clearVenInfo()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 협력사 정보를 초기화한다.
 * return값 : void
**/
function clearVenInfo(row, codeYes){
	if( codeYes == true){
	    DS_MASTER.NameValue(row,"VEN_CD")    = "";
	}
    DS_MASTER.NameValue(row,"VEN_NAME")  = "";
    DS_MASTER.NameValue(row,"COMP_NAME") = "";
    DS_MASTER.NameValue(row,"COMP_NO")   = "";
    DS_MASTER.NameValue(row,"ADDR")      = "";
    DS_MASTER.NameValue(row,"REP_NAME")  = "";
    DS_MASTER.NameValue(row,"PHONE1_NO") = "";
    DS_MASTER.NameValue(row,"PHONE2_NO") = "";
    DS_MASTER.NameValue(row,"PHONE3_NO") = "";
}
/**
 * checkMasterValidation()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 입력값을 체크한다.
 * return값 : void
**/
function checkMasterValidation(){
	var row;
	var colid;
	var isCheck = false;
    for(var i=1; i<=DS_MASTER.CountRow; i++){
    	var rowStatus = DS_MASTER.RowStatus(i);
        if( !(rowStatus == "1" ||rowStatus == "3"))
            continue;
        row = i;
        if( DS_MASTER.NameValue(row,"VEN_CD")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "협력사");
            colid = "VEN_CD";
            isCheck = true;
            break;
        }
        if( DS_MASTER.NameValue(row,"VEN_NAME")==""){
            showMessage(EXCLAMATION, OK, "USER-1036", "협력사");
            colid = "VEN_CD";
            isCheck = true;
            break;
        }
        var dupRow = checkDupKey(DS_MASTER,"VEN_CD");
        if( dupRow > 0){
            showMessage(EXCLAMATION, OK, "USER-1044");
            colid = "VEN_CD";
            isCheck = true;
            break;        	
        }
        if( DS_MASTER.NameValue(row,"COMP_NAME")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "상호명");
            colid = "COMP_NAME";
            isCheck = true;
            break;
        }
        var lengthCneckRtn = checkByteLengthStr(DS_MASTER.NameValue(row,"COMP_NAME"),28,"N");
        if( lengthCneckRtn != null){
        	showMessage(EXCLAMATION, OK, "GAUCE-1000", "상호명은 28Byte 이상 초과 입력할수 없습니다.");
            colid = "COMP_NAME";
            isCheck = true;
            break;
        }
        if( DS_MASTER.NameValue(row,"ADDR")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "주소");
            colid = "ADDR";
            isCheck = true;
            break;
        }
        lengthCneckRtn = checkByteLengthStr(DS_MASTER.NameValue(row,"ADDR"),42,"N");
        if( lengthCneckRtn != null){
            showMessage(EXCLAMATION, OK, "GAUCE-1000", "주소는 42Byte 이상 초과 입력할수 없습니다.");
            colid = "ADDR";
            isCheck = true;
            break;
        }
        if( DS_MASTER.NameValue(row,"REP_NAME")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "대표자명");
            colid = "REP_NAME";
            isCheck = true;
            break;
        }
        lengthCneckRtn = checkByteLengthStr(DS_MASTER.NameValue(row,"REP_NAME"),10,"N");
        if( lengthCneckRtn != null){
            showMessage(EXCLAMATION, OK, "GAUCE-1000", "대표자명은 10Byte 이상 초과 입력할수 없습니다.");
            colid = "REP_NAME";
            isCheck = true;
            break;
        }
        if( DS_MASTER.NameValue(row,"PHONE1_NO")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "전화번호");
            colid = "PHONE1_NO";
            isCheck = true;
            break;
        }
        if( DS_MASTER.NameValue(row,"PHONE2_NO")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "전화번호");
            colid = "PHONE2_NO";
            isCheck = true;
            break;
        }
        if( DS_MASTER.NameValue(row,"PHONE3_NO")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "전화번호");
            colid = "PHONE3_NO";
            isCheck = true;
            break;
        }
        if( DS_MASTER.NameValue(row,"USE_YN")==""){
            showMessage(EXCLAMATION, OK, "USER-1002", "사용여부");
            colid = "USE_YN";
            isCheck = true;
            break;
        }
    }

    if(isCheck){
        setFocusGrid(GD_MASTER,DS_MASTER,row,colid);
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

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_MASTER event=OnDataError(row,colid)>
    var errorCode = DS_MASTER.ErrorCode;
    if(errorCode == "50019"){
        showMessage(EXCLAMATION, OK, "USER-1044");
    }else if( errorCode == "50018"){
        showMessage(EXCLAMATION, OK, "USER-1003", "협력사");
    }else{
        showMessage(EXCLAMATION, OK, "USER-1000",DS_MASTER.ErrorMsg);       
    }
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid );    
</script>

<script language=JavaScript for=GD_MASTER event=OnExit(row,colid,oldData)>
    if( row < 1 || isOnPopup)
        return;
    var value = DS_MASTER.NameValue(row,colid);
    if( oldData == value )
        return;
    switch(colid){
        case 'VEN_CD':  
            setVenCodeToGrid('NAME',row);
            break;
    }
</script>
<script language=JavaScript for=GD_MASTER event=OnPopup(row,colid,data)>
    if( row < 1 )
        return;
    isOnPopup = true;
    switch(colid){
        case 'VEN_CD':  
        	setVenCodeToGrid('POP',row);
            break;
    }
    isOnPopup = false;
</script>
<!-- 협력사(조회) -->
<script language=JavaScript for=EM_VEN_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    setVenCode('NAME');
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
<comment id="_NSID_"><object id="DS_USE_YN"        classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSECHECK"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
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
            <th width="80" >사업자번호</th>
            <td width="165">
              <comment id="_NSID_">
                <object id=EM_COMP_NO classid=<%=Util.CLSID_EMEDIT%>  width=165  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
            <th width="80">상호명</th>
            <td width="165">
              <comment id="_NSID_">
                <object id=EM_COMP_NAME classid=<%=Util.CLSID_EMEDIT%>  width=165  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
            <th width="80">사용여부</th>
            <td >
               <comment id="_NSID_">
                 <object id=LC_USE_YN classid=<%= Util.CLSID_LUXECOMBO %> width=165 tabindex=1 align="absmiddle"></object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th width="80">협력사코드</th>
            <td colspan="5">
              <comment id="_NSID_">
                <object id=EM_VEN_CD classid=<%=Util.CLSID_EMEDIT%>  width=80  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" onclick="javascipt:setVenCode('POP');" align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_VEN_NAME classid=<%=Util.CLSID_EMEDIT%>  width=328  tabindex=1 align="absmiddle"></object>
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
      <tr>
        <td ><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
               <td class="right PB03"><img 
                 src="/<%=dir%>/imgs/btn/preview.gif"  onClick="javascript:btn_preview();" hspace="4"/><img 
                 src="/<%=dir%>/imgs/btn/add_row.gif"  onClick="javascript:btn_addRow()"  hspace="2"/><img
                 src="/<%=dir%>/imgs/btn/del_row.gif"  onClick="javascript:btn_delRow()" />
                 
         			<td width="100">
            		<table width="100%" >
                    <td align="right">
						<table border="0" cellspacing="0" cellpadding="0">
						  <tr>
						    <td class="btn_l"> </td>
						    <td class="btn_c"><a href="#" tabindex=1 onclick="btn_send_stmp_emg()">긴급명판전송</a></td>
						    <td class="btn_r"></td>
						  </tr>
						</table>                
	                </td>		
					</table>				
		            </td>
		            
               </td>
           </tr>
        </table></td>
      </tr>
      <tr valign="top">
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
            <td>
              <comment id="_NSID_">
                <object id=GD_MASTER width=100% height=455 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_MASTER">
                </object>
              </comment>
              <script>_ws_(_NSID_);</script>
            </td>
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


