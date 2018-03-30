<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > POS기준정보> 판매사원관리
 * 작 성 일 : 2010.01.19
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod8050.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 판매사원(POS사용자) 정보를 관리한다
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


/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
var bfStrCd;
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
    DS_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터

    // EMedit에 초기화
    initEmEdit(EM_ORG_CD      , "CODE^10",  NORMAL);  //조직코드
    initEmEdit(EM_ORG_NAME    , "GEN^40" ,  NORMAL);  //조직명
    initEmEdit(EM_SALE_USER_ID, "CODE^9" ,  NORMAL);  //사원번호
    initEmEdit(EM_EMP_NAME    , "GEN^10" ,  NORMAL);  //사원명

    //콤보 초기화 
    initComboStyle(LC_STR_CD       , DS_STR_CD       , "CODE^0^30,NAME^0^140" , 1, PK);  //점(조회)
    initComboStyle(LC_POS_AUTH_FLAG, DS_POS_AUTH_FLAG, "CODE^0^30,NAME^0^180", 1, NORMAL);  //권한구분(조회)
    initComboStyle(LC_EMP_FLAG     , DS_EMP_FLAG     , "CODE^0^30,NAME^0^110", 1, NORMAL);  //사원구분(조회)

    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_POS_AUTH_FLAG"   , "D", "P083", "Y");
    getEtcCode("DS_EMP_FLAG"        , "D", "P025", "Y");
    getEtcCode("DS_I_POS_AUTH_FLAG" , "D", "P083", "N");
    getEtcCode("DS_I_EMP_FLAG"      , "D", "P025", "N");
    getEtcCode("DS_I_LUNAR_FLAG"    , "D", "P085", "N");
    
    // 점코드 조회
    getStore("DS_STR_CD"  , "N", "1", "N");
    getStore("DS_I_STR_CD", "N", "1", "N");
    
    // 전점 추가(gauce.js )
    insComboData(LC_STR_CD,"**","전점");
    DS_I_STR_CD.AddRow();
    DS_I_STR_CD.NameValue(DS_I_STR_CD.CountRow, "CODE") = "**";
    DS_I_STR_CD.NameValue(DS_I_STR_CD.CountRow, "NAME") = "전점";
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_POS_AUTH_FLAG,'%');
    setComboData(LC_EMP_FLAG,'%');
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_STR_CD.Index < 0){
        LC_STR_CD.Index= 0;
    }
    // 삭제된 로우 표시여부
    //DS_MASTER.ViewDeletedRow = true;


    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pcod805","DS_MASTER" );
    
    bfStrCd = LC_STR_CD.BindColVal;
    LC_STR_CD.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}       width=30   align=center edit=none     name="NO"                </FC>'
                     + '<FC>id=CHK            name="선택"       width=60                align=center  HeadCheckShow=true EditStyle=CheckBox </FC>'
                     + '<FC>id=STR_CD         width=70   align=left                 name="*점"                EditStyle=Lookup data="DS_I_STR_CD:CODE:NAME" edit={IF(EMP_FLAG=1 AND SysStatus<>"I","false","true")} </FC>'
                     + '<FC>id=EMP_FLAG       width=110  align=left                 name="*사원구분"          EditStyle=Lookup data="DS_I_EMP_FLAG:CODE:NAME" edit={IF(SysStatus="I","true","false")}</FC>'
                     + '<FC>id=SALE_USER_ID   width=70   align=center edit=AlphaNum name="*사원번호 "          EditStyle=Popup  edit={IF(EMP_FLAG=2 AND SysStatus="I","true","false")}</FC>'
                     + '<FC>id=EMP_NAME       width=100   align=left                 name="*사원명 "            edit=true</FC>'
                     //+ '<FC>id=EMP_NAME       width=120   align=left                 name="*사원명 "            edit={IF(EMP_FLAG=1,"true","false")}</FC>'
                     + '<FC>id=PWD_NO         width=70   align=left   edit=Numeric  name="*비밀번호 "          </FC>'
                     + '<FG>name="조직"'
                     + '<FC>id=ORG_CD         width=100  align=center edit=AlphaNum name="코드 "              EditStyle=Popup</FC>'
                     + '<FC>id=ORG_NAME       width=120  align=left   edit=none     name="명 "                </FC>'
                     + '</FG>'
                     + '<FG>name="브랜드"'
                     + '<FC>id=PUMBUN_CD      width=70   align=center edit=Numeric  name="코드 "               EditStyle=Popup edit={IF(EMP_FLAG=2,"true",IF(SysStatus="I","true","false"))}</FC>'
                     + '<FC>id=PUMBUN_NAME    width=130  align=left   edit=none     name="명 "                 </FC>'
                     + '</FG>'
                     + '<FC>id=POS_AUTH_FLAG  width=130  align=left                 name="*권한구분 "           EditStyle=Lookup data="DS_I_POS_AUTH_FLAG:CODE:NAME" </FC>'
                     + '<FG>name="전화번호"'
                     + '<FC>id=TEL_NO_1       width=70   align=left   edit=Numeric  name="국 "                 </FC>'
                     + '<FC>id=TEL_NO_2       width=70   align=left   edit=Numeric  name="지역 "               </FC>'
                     + '<FC>id=TEL_NO_3       width=70   align=left   edit=Numeric  name="번호 "               </FC>'
                     + '</FG>'
                     + '<FC>id=BIRTH_DT       width=80   align=center edit=Numeric  name="생년월일 "           EditStyle=Popup mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=LUNAR_FLAG     width=70   align=left                 name="양음력;구분 "         EditStyle=Lookup data="DS_I_LUNAR_FLAG:CODE:NAME" </FC>'
                     + '<FC>id=PWD_MOD_DT     width=80   align=center edit=none     name="비밀번호;최종변경일 "  mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=USE_YN         width=70   align=left                 name="*사용여부 "            EditStyle=Combo data="Y:YES,N:NO" </FC>';

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
	
    if( DS_MASTER.IsUpdated){
        // 변경된 상세내역이 존재합니다. 조회하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1059") != 1){
            GD_MASTER.Focus();
            return ;
        }
    }
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
    
    TR_MAIN.Action="/dps/pcod805.pc?goTo=save";  
    TR_MAIN.KeyValue="SERVLET(I:DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();    
    
    if(TR_MAIN.ErrorCode == 0){
        searchMaster();        
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

    if( LC_STR_CD.BindColVal == ""){
        // (점)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1002", "점");
        LC_STR_CD.Focus();
        return;
    }
    DS_MASTER.AddRow();
    var row = DS_MASTER.CountRow;
    DS_MASTER.NameValue(row,"STR_CD")     = LC_STR_CD.BindColVal;
    DS_MASTER.NameValue(row,"PWD_MOD_DT") = getTodayFormat("YYYYMMDD");    
    DS_MASTER.NameValue(row,"DEL_YN")     = "Y";    
    DS_MASTER.NameValue(row,"USE_YN")     = "Y";    
    
    setFocusGrid(GD_MASTER, DS_MASTER, row, "STR_CD");
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
    if( DS_MASTER.NameValue(row,"DEL_YN") != "Y" ){
        showMessage(INFORMATION, OK, "USER-1000", "당일 등록 건만 삭제 가능 합니다.");
        GD_MASTER.Focus();
        return;
    }
    DS_MASTER.DeleteRow(row);
}

/**
 * searchMaster()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  판매사원 리스트 조회
 * return값 : void
 */
function searchMaster(){

    var strCd       = LC_STR_CD.BindColVal;
    var posAuthFlag = LC_POS_AUTH_FLAG.BindColVal;
    var empFlag     = LC_EMP_FLAG.BindColVal;
    var orgCd       = EM_ORG_CD.Text;
    var orgName     = EM_ORG_NAME.Text;
    var saleUserId  = EM_SALE_USER_ID.Text;
    var empName     = EM_EMP_NAME.Text;

    
    var goTo       = "searchMaster" ;    
    var action     = "O";  
    var parameters = "&strStrCd="+encodeURIComponent(strCd)
                   + "&strSaleUserNo="+encodeURIComponent(saleUserId)
                   + "&strEmpName="+encodeURIComponent(empName)
                   + "&strOrgCd="+encodeURIComponent(orgCd)
                   + "&strOrgName="+encodeURIComponent(orgName)
                   + "&strPosAuthFlag="+encodeURIComponent(posAuthFlag)
                   + "&strEmpFlag="+encodeURIComponent(empFlag);
    TR_MAIN.Action="/dps/pcod805.pc?goTo="+goTo+parameters;      
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();    
    
    //조회후 결과표시
    setPorcCount("SELECT",GD_MASTER);  

} 
/**
 * getOrgCode()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 조직명을 등록한다.
 * return값 : void
 */
function getOrgCode(evnFlag){
	var codeObj = EM_ORG_CD;
	var nameObj = EM_ORG_NAME;

    if( evnFlag == 'POP'){
    	orgCornerOutPop(codeObj,nameObj,'N','','','','','',LC_STR_CD.BindColVal);
        codeObj.Focus();
        return;
    }

    if( codeObj.Text ==""){
        nameObj.Text = "";    
        return;
    }
    
    setOrgCornerOutNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj , 'N', 0,'','','','','',LC_STR_CD.BindColVal);
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
        return;     
    }
    var rtnMap = null;
    if( evnflag == "POP" ){
        rtnMap = strPbnToGridPop(code,'','N','', strCd, '','','','','Y');
    }else if( evnflag == "NAME" ){
        DS_MASTER.NameValue(row,"PUMBUN_NAME") = "";
        rtnMap = setStrPbnNmWithoutToGridPop("DS_SEARCH_NM",code,'',"N",1,'', strCd, '','','','','Y');
    }    
    if( rtnMap != null){
        DS_MASTER.NameValue(row,"PUMBUN_CD")   = rtnMap.get("PUMBUN_CD");
        DS_MASTER.NameValue(row,"PUMBUN_NAME") = rtnMap.get("PUMBUN_NAME");
    }else{
        if( DS_MASTER.NameValue(row,"PUMBUN_NAME") == ""){
            DS_MASTER.NameValue(row,"PUMBUN_CD")   = "";
        }
    }
}

/**
 * setOrgCodeToGrid()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 조직명을 등록한다.(Grid)
 * return값 : void
 */
function setOrgCodeToGrid(evnflag, row){
    var code  = DS_MASTER.NameValue(row,"ORG_CD");
    var strCd = DS_MASTER.NameValue(row,"STR_CD");
    if( code == "" && evnflag != "POP" ){
        DS_MASTER.NameValue(row,"ORG_NAME") = "";
        return;     
    }
    var rtnMap = null;
    if( evnflag == "POP" ){
        rtnMap = orgCornerOutToGridPop(code,'','N','','','','','Y', strCd);
    }else if( evnflag == "NAME" ){
        DS_MASTER.NameValue(row,"ORG_NAME") = "";
        rtnMap = setOrgCornerOutNmWithoutToGridPop("DS_SEARCH_NM",code,'',"N",1,'','','','','Y', strCd);
    }    
    if( rtnMap != null){
        DS_MASTER.NameValue(row,"ORG_CD")   = rtnMap.get("ORG_CD");
        DS_MASTER.NameValue(row,"ORG_NAME") = rtnMap.get("ORG_NAME");
    }else{
        if( DS_MASTER.NameValue(row,"ORG_NAME") == ""){
            DS_MASTER.NameValue(row,"ORG_CD")   = "";
        }
    }
}
/**
 * setUserIdToGrid()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 사원명을 등록한다.(Grid)
 * return값 : void
 */
function setUserIdToGrid(evnflag, row){
    var code  = DS_MASTER.NameValue(row,"SALE_USER_ID");
    if( code == "" && evnflag != "POP" ){
        DS_MASTER.NameValue(row,"EMP_NAME") = "";
        return;     
    }
    
    if( evnflag == "NAME" ){
        DS_MASTER.NameValue(row,"EMP_NAME") = "";
        setNmToDataSet('DS_SEARCH_NM', 'SEL_USR_MST', code);
        if(DS_SEARCH_NM.CountRow == 1){
        	DS_MASTER.NameValue(row,"SALE_USER_ID") = DS_SEARCH_NM.NameValue(1,"CODE_CD");
        	DS_MASTER.NameValue(row,"EMP_NAME")     = DS_SEARCH_NM.NameValue(1,"CODE_NM");
            return;
        }
    }
    var rtnMap = commonPopToGrid('사원','SEL_USR_MST_TEST',code);
    if( rtnMap.size() < 1){
    	if(DS_MASTER.NameValue(row,"EMP_NAME") == ""){
    		DS_MASTER.NameValue(row,"SALE_USER_ID") = "";
    	}
        return;
    }
    DS_MASTER.NameValue(row,"SALE_USER_ID") = rtnMap.get("CODE_CD");
    DS_MASTER.NameValue(row,"EMP_NAME")     = rtnMap.get("CODE_NM");
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

    var dupRow = checkDupKey(DS_MASTER,"SALE_USER_ID");
    if( dupRow > 0){
        showMessage(EXCLAMATION, OK, "USER-1044");
        setFocusGrid(GD_MASTER,DS_MASTER,dupRow,"SALE_USER_ID");
        return false;
    }
    
    for(var i=1; i<=DS_MASTER.CountRow; i++){
        var rowStatus = DS_MASTER.RowStatus(i);
        if( !(rowStatus == "1" || rowStatus == "3") )
            continue;
        row = i;
        if( DS_MASTER.NameValue(i,"STR_CD")==""){
            showMessage(EXCLAMATION, OK, "USER-1002", "점");
            errYn = true;
            colid = "STR_CD";
            break;
        }
        if( DS_MASTER.NameValue(i,"EMP_FLAG")==""){
            showMessage(EXCLAMATION, OK, "USER-1002", "사원구분");
            errYn = true;
            colid = "EMP_FLAG";
            break;
        }
        if( DS_MASTER.NameValue(i,"EMP_FLAG")=="2" && DS_MASTER.NameValue(i,"SALE_USER_ID")=="" ){
            showMessage(EXCLAMATION, OK, "USER-1003", "사원번호");
            errYn = true;
            colid = "SALE_USER_ID";
            break;
        }
        if( DS_MASTER.NameValue(i,"EMP_NAME")==""){
        	if(DS_MASTER.NameValue(i,"EMP_FLAG")=="2"){
                showMessage(EXCLAMATION, OK, "USER-1036", "사원번호");
                colid = "SALE_USER_ID";
        	}else{
                showMessage(EXCLAMATION, OK, "USER-1003", "사원명");
                colid = "EMP_NAME";        		
        	}
            errYn = true;
            break;
        }

        if( !checkInputByte( GD_MASTER, DS_MASTER, i, "EMP_NAME", "사원명") )
            return false;
        
        if( DS_MASTER.NameValue(i,"PWD_NO")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "비밀번호");
            errYn = true;
            colid = "PWD_NO";
            break;
        }
        if( DS_MASTER.NameValue(i,"ORG_CD")!="" && DS_MASTER.NameValue(i,"ORG_NAME")=="" ){
            showMessage(EXCLAMATION, OK, "USER-1036", "조직");
            errYn = true;
            colid = "ORG_CD";
            break;
        }
        
        
//         if( DS_MASTER.NameValue(i,"EMP_FLAG")=="2"){
//             if( DS_MASTER.NameValue(i,"PUMBUN_CD")!="" && DS_MASTER.NameValue(i,"PUMBUN_NAME")=="" ){
//                 showMessage(EXCLAMATION, OK, "USER-1036", "브랜드");
//                 errYn = true;
//                 colid = "PUMBUN_CD";
//                 break;
//             }
//         }else{
//             if( DS_MASTER.NameValue(i,"PUMBUN_CD")=="" ){
//                 showMessage(EXCLAMATION, OK, "USER-1003", "브랜드");
//                 errYn = true;
//                 colid = "PUMBUN_CD";
//                 break;
//             }
//             if( DS_MASTER.NameValue(i,"PUMBUN_NAME")=="" ){
//                 showMessage(EXCLAMATION, OK, "USER-1036", "브랜드");
//                 errYn = true;
//                 colid = "PUMBUN_CD";
//                 break;
//             }
        	
//         }
        
        
        if( DS_MASTER.NameValue(i,"POS_AUTH_FLAG")==""){
            showMessage(EXCLAMATION, OK, "USER-1002", "권한구분");
            errYn = true;
            colid = "POS_AUTH_FLAG";
            break;
        }
        if( DS_MASTER.NameValue(i,"BIRTH_DT")!="" && DS_MASTER.NameValue(i,"LUNAR_FLAG")==""){
            showMessage(EXCLAMATION, OK, "USER-1002", "양음력구분");
            errYn = true;
            colid = "LUNAR_FLAG";
            break;
        }
        if( DS_MASTER.NameValue(i,"USE_YN")==""){
            showMessage(EXCLAMATION, OK, "USER-1002", "사용여부");
            errYn = true;
            colid = "USE_YN";
            break;
        }
        if( DS_MASTER.NameValue(i,"STR_CD")=="**" && DS_MASTER.NameValue(i,"EMP_FLAG")=="1"){
            showMessage(INFORMATION, OK, "USER-1000", "POS전용사용자는 전점에서 선택할수 없습니다.");
            errYn = true;
            colid = "EMP_FLAG";
            break;
        }
    }
    
    if(errYn){
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
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<!-- 디테일 선택시 전체 선택/해제 -->
<script language=JavaScript for=GD_MASTER
    event="OnHeadCheckClick(Col,Colid,bCheck)">       
    if (Colid == "CHK") {
        if (bCheck == 1) {
            GD_MASTER.Redraw = false;
            for (var i = 0; i < DS_MASTER.CountRow; i++)
            {
                DS_MASTER.NameValue(i + 1, "CHK") = "T";
            }    
            GD_MASTER.Redraw = true;
        }
        else if (bCheck == 0) {
            GD_MASTER.Redraw = false;
            for (var i = 0; i < DS_MASTER.CountRow; i++)
            {
                DS_MASTER.NameValue(i + 1, "CHK") = "F";
            }
            GD_MASTER.Redraw = true;
            DS_MASTER.ResetStatus();
        }
    }
</script>

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid );
</script>
<script language=JavaScript for=GD_MASTER event=OnListSelect(index,row,colid)>
    if( row < 1)
        return;
    if( colid=='STR_CD'){
        if( DS_MASTER.NameValue(row,"STR_CD")=="**" ){
        	if(DS_MASTER.NameValue(row,"EMP_FLAG") == "1"){
                DS_MASTER.NameValue(row,"SALE_USER_ID")="";
                DS_MASTER.NameValue(row,"EMP_NAME")="";
        	}
            DS_MASTER.NameValue(row,"EMP_FLAG") = "2";
        }
        DS_MASTER.NameValue(row,"PUMBUN_CD")="";
        DS_MASTER.NameValue(row,"PUMBUN_NAME")="";
    }else if( colid=='EMP_FLAG'){
    	if( DS_MASTER.NameValue(row,"STR_CD")=="**" && DS_MASTER.NameValue(row,"EMP_FLAG") == "1"){
    		showMessage(INFORMATION, OK, "USER-1000", "POS전용사용자는 전점에서 선택할수 없습니다.");
    		DS_MASTER.NameValue(row,"EMP_FLAG") = "2";
    		return;
    	}
    	DS_MASTER.NameValue(row,"SALE_USER_ID")="";
    	DS_MASTER.NameValue(row,"EMP_NAME")="";
    }
</script> 
<script language=JavaScript for=GD_MASTER event=OnExit(row,colid,olddata)>
    if(row < 1 || onPopup){
        return;
    }
    var value = DS_MASTER.NameValue(row,colid);
    if( value == olddata)
        return;
    
    switch(colid){
        case 'PWD_NO':
        	if( DS_MASTER.RowStatus(row) == '1'){
                DS_MASTER.NameValue(row,"PWD_MOD_DT") = getTodayFormat("YYYYMMDD");
                break;
        	}
        	if(DS_MASTER.OrgNameValue(row,"PWD_NO") == value ){
                DS_MASTER.NameValue(row,"PWD_MOD_DT") = DS_MASTER.OrgNameValue(row,"PWD_MOD_DT");
                break;
        	}
            DS_MASTER.NameValue(row,"PWD_MOD_DT") = getTodayFormat("YYYYMMDD");        	
            break;
        case 'SALE_USER_ID':
            setUserIdToGrid('NAME', row);
            break;
        case 'ORG_CD':
            setOrgCodeToGrid('NAME', row);
            break;
        case 'PUMBUN_CD':
            setPumbunCodeToGrid('NAME', row);
            break;
        case 'BIRTH_DT':
            if(!checkDateTypeYMD(GD_MASTER,colid,'')){ 
                return;
            }
            break;
    
    }
</script> 
<!-- 팝업  -->
<script language=JavaScript for=GD_MASTER event=OnPopup(row,colid,data)>
    if(row < 1){
        return;
    }
    onPopup = true;
    switch(colid){
        case 'SALE_USER_ID':
            setUserIdToGrid('POP', row);
            break;
        case 'ORG_CD':
            setOrgCodeToGrid('POP', row);
            break;
        case 'PUMBUN_CD':
            setPumbunCodeToGrid('POP', row);
            break;
        case 'BIRTH_DT':
            openCal(GD_MASTER,row,colid);
            break;
    }
    onPopup = false;
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
        DS_MASTER.ClearData();
    }
    bfStrCd = this.BindColVal;
</script>
<!-- 조직(조회) -->
<script language=JavaScript for=EM_ORG_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    getOrgCode('NAME');
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
<comment id="_NSID_"><object id="DS_POS_AUTH_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_EMP_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_I_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_POS_AUTH_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_EMP_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_LUNAR_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSECHECK"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

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
            <th width="80" class="point">점</th>
            <td width="140">
               <comment id="_NSID_">
                 <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle"></object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80">조직</th>
            <td width="220">
              <comment id="_NSID_">
                <object id=EM_ORG_CD classid=<%=Util.CLSID_EMEDIT%>  width=80  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/detail_search_s.gif"   onclick="javascript:getOrgCode('POP');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_ORG_NAME classid=<%=Util.CLSID_EMEDIT%>  width=110  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
            <th width="80">사원번호</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_SALE_USER_ID classid=<%=Util.CLSID_EMEDIT%>  width=140  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th >사원명</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_EMP_NAME classid=<%=Util.CLSID_EMEDIT%>  width=135  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
            <th >권한구분</th>
            <td >
               <comment id="_NSID_">
                 <object id=LC_POS_AUTH_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=215 tabindex=1  align="absmiddle"></object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
            <th >사원구분</th>
            <td >
               <comment id="_NSID_">
                 <object id=LC_EMP_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle"></object>
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
      <tr>
        <td ><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
               <td class="right PB03"><img 
               src="/<%=dir%>/imgs/btn/add_row.gif" onClick="javascript:btn_addRow();" hspace="2" /><img 
               src="/<%=dir%>/imgs/btn/del_row.gif" onClick="javascript:btn_delRow();"  /></td>
           </tr>
        </table></td>
      </tr>
      <tr valign="top">
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
            <td>
              <comment id="_NSID_">
                <object id=GD_MASTER width=100% height=457 classid=<%=Util.CLSID_GRID%>>
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

