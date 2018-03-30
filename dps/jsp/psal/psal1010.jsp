<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업 > 매출관리 > 당초계획
 * 작 성 일 : 2010.01.17
 * 작 성 자 : 박종은
 * 수 정 자 : 
 * 파 일 명 : psal1010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 당초파트별년매출계획
 * 이    력 :2010.02.22 박종은
 * 
 ******************************************************************************/
-->

<%@ page language="java" contentType="text/html;charset=utf-8"
   import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%
   request.setCharacterEncoding("utf-8");
%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
   String dir = BaseProperty.get("context.common.dir");
%>

<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"
   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"
   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"
   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"
   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"
   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"
   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"
   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js"
   type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">


/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 120;		//해당화면의 그리드top위치
 function doInit(){

	 
	 //Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_MASTER"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	 
     // Input Data Set Header 초기화

     // Output Data Set Header 초기화
     DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    
     //그리드 초기화
     gridCreate1(); //마스터
     
     // EMedit에 초기화
     initEmEdit(EM_PROF_IRATE, "NUMBER^5^2", NORMAL);         //이익신장율
     initEmEdit(EM_SALE_IRATE, "NUMBER^5^2", NORMAL);         //매출신장율
     initEmEdit(EM_PLAN_YEAR, "YYYY", PK);                    //계획년월
     
     //계획년월 정렬
     EM_PLAN_YEAR.alignment = 1;
     
     //이익신장율 초기화
     EM_PROF_IRATE.text = 0;
     
     //매출신장율초기화
     EM_SALE_IRATE.text = 0;
     
     //콤보 초기화
     initComboStyle(LC_STR_CD,DS_STR_CD, "CODE^0^30,NAME^0^140", 1, PK);  //점(조회)
     //점마스터에서 점코드 가지고 오기
     getStore("DS_STR_CD", "Y", "", "N");     
     
     var strcd = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';     // 로그인 점코드
     LC_STR_CD.BindColVal = strcd;
     GD_MASTER.focus();
     LC_STR_CD.Focus();
     //데이터셋 체크 수정용 점정보
     getStore("DS_STR_CD_I", "Y", "1", "N");  
     
     //계획년월 당해년도 초기화
     EM_PLAN_YEAR.text = today.getYear();

     registerUsingDataset("psal101"," DS_IO_MASTER" );
   
   
 }

 function gridCreate1(){
     var hdrProperies = '<FC>id={currow}            name="NO"            width=30    align=center                    BgColor={if(ERROR_CHECK = "","white","orange")} </FC>'
    	              + '<FC>id=CONF_FLAG           name="확정"           width=40     align=center       Edit= none     EditStyle=CheckBox        HeadCheck=false   HeadCheckShow=false</FC>'
                      + '<FC>id=STR_CD              name="점"             width=40    align=center       Edit=none    BgColor={if(ERROR_CHECK = "",if(STR_CD = "","orange","white"),"orange") }</FC>'
                      + '<FC>id=STR_NAME            name="점명"           width=60    align=left          Edit=none    BgColor={if(ERROR_CHECK = "",if(STR_NAME = "","orange","white"),"orange")} </FC>'
                      + '<FC>id=ORG_CD              name="조직코드"        width=85    align=center        Edit=none    BgColor={if(ERROR_CHECK = "",if(ORG_CD = "","orange","white"),"orange")}   sumtext="합계" </FC>'
                      + '<FC>id=PLAN_YEAR           name="목표;년도"       width=40    align=center        Edit=none    BgColor={if(ERROR_CHECK = "",if(PLAN_YEAR = "","orange","white"),"orange")}</FC>'
                      + '<FC>id=ORG_LEVEL           name="조직;레벨"       width=40    align=center        Edit=none    BgColor={if(ERROR_CHECK = "",if(ORG_LEVEL = "","orange","white"),"orange")}</FC>'
                      + '<FC>id=DEPT_CD             name="팀"           width=40    align=center        Edit=none    BgColor={if(ERROR_CHECK = "",if(DEPT_CD = "","orange","white"),"orange")}</FC>'
                      + '<FC>id=TEAM_CD             name="파트"             width=40    align=center        Edit=none    BgColor={if(ERROR_CHECK = "",if(TEAM_CD = "","orange","white"),"orange")}</FC>'
                      + '<FC>id=ORG_NAME             name="파트명"           width=80   align=left          Edit=none                              BgColor={if(ERROR_CHECK = "",if(ORG_NAME = "","orange","white"),"orange")}</FC>'
                      + '<G>                        name="전년매출실적"'
                      + '<C>id=BFYY_NORM_SAMT       name="정상"           width=100    align=right         Edit=none     BgColor={if(ERROR_CHECK = "","white","orange")} sumtext={subsum(BFYY_NORM_SAMT)}</C>'
                      + '<C>id=BFYY_EVT_SAMT         name="행사"           width=100    align=right         Edit=none     BgColor={if(ERROR_CHECK = "","white","orange")} sumtext={subsum(BFYY_EVT_SAMT)}</C>'
                      + '<C>id=BFYY_SALE_TAMT       name="총매출"         width=100     align=right        Edit=none     BgColor={if(ERROR_CHECK = "","white","orange")} sumtext={subsum(BFYY_SALE_TAMT)}</C>'
                      + '<C>id=BFYY_PROF_TAMT       name="이익"           width=100    align=right         Edit=none     BgColor={if(ERROR_CHECK = "","white","orange")} sumtext={subsum(BFYY_PROF_TAMT)}</C>'
                      + '<C>id=BFYY_SALE_CRATE      name="매출구성비"      width=80    align=right Dec=2   Edit=none     BgColor={if(ERROR_CHECK = "","white","orange")} sumtext={subsum(BFYY_SALE_CRATE)}</C>'
                      + '<C>id=BFYY_PROF_CRATE      name="이익구성비"      width=80    align=right Dec=2   Edit=none     BgColor={if(ERROR_CHECK = "","white","orange")} sumtext={subsum(BFYY_PROF_CRATE)}</C>'
                      + '</G> '
                      + '<G>                        name="당초년매출목표"'
                      + '<C>id=ORIGIN_NORM_SAMT     name="정상"           width=100    align=right         Edit={if(CONF_FLAG = "F","", none)}       BgColor={if(ERROR_CHECK = "","white","orange")} sumtext={subsum(ORIGIN_NORM_SAMT)}</C>'
                      + '<C>id=ORIGIN_EVT_SAMT      name="행사"           width=100    align=right         Edit={if(CONF_FLAG = "F","", none)}       BgColor={if(ERROR_CHECK = "","white","orange")} sumtext={subsum(ORIGIN_EVT_SAMT)}</C>'
                      + '<C>id=ORIGIN_SALE_TAMT     name="총매출"          width=100    align=right        Edit=none     BgColor={if(ERROR_CHECK = "","white","orange")} sumtext={subsum(ORIGIN_SALE_TAMT)}</C>'
                      + '<C>id=ORIGIN_PROF_TAMT     name="이익"           width=100    align=right         Edit={if(CONF_FLAG = "F","", none)}       BgColor={if(ERROR_CHECK = "","white","orange")} sumtext={subsum(ORIGIN_PROF_TAMT)}</C>'
                      + '<C>id=ORIGIN_SALE_CRATE    name="매출구성비"      width=80    align=right Dec=2   Edit=none     BgColor={if(ERROR_CHECK = "","white","orange")} sumtext={subsum(ORIGIN_SALE_CRATE)}</C>'
                      + '<C>id=ORIGIN_PROF_CRATE    name="이익구성비"      width=80    align=right Dec=2   Edit=none     BgColor={if(ERROR_CHECK = "","white","orange")} sumtext={subsum(ORIGIN_PROF_CRATE)}</C>'
                      + '<C>id=ORIGIN_SALE_IRATE    name="매출신장율"      width=80    align=right Dec=2   Edit=none     BgColor={if(ERROR_CHECK = "","white","orange")}</C>'
                      + '<C>id=ORIGIN_PROF_IRATE    name="이익신장율"      width=80    align=right Dec=2   Edit=none     BgColor={if(ERROR_CHECK = "","white","orange")}</C>'
                      + '</G> '
                      + '<C>id=ERROR_CHECK          name="에러체크"        width=80    align=right         Edit=none    show=false </C>'
                      ;
                      

     initGridStyle(GD_MASTER, "common", hdrProperies, true);
     
     //합계표시
     GD_MASTER.ViewSummary = "1";
     GD_MASTER.DecRealData = true;
     DS_IO_MASTER.UseChangeInfo = false;  
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

    //저장되지 않은 내용이 있을경우 경고
    if (DS_IO_MASTER.IsUpdated) {
        ret = showMessage(QUESTION, YESNO, "USER-1084");
        if (ret != "1") {
            return false;
        } 
    }
    //점
    if (isNull(LC_STR_CD.BindColVal)==true ) {
        showMessage(INFORMATION, OK, "USER-1003","점");
        LC_STR_CD.focus();
        return;
    }
    
    //계획년도
    if (isNull(EM_PLAN_YEAR.text) ==true ) {
        showMessage(INFORMATION, OK, "USER-1003","목표년도");
        EM_PLAN_YEAR.focus();
        return;
    }
    
    //계획년도 자릿수, 공백 체크
    if (EM_PLAN_YEAR.text.replace(" ","").length != 4 ) {
        showMessage(INFORMATION, OK, "USER-1027","목표년도","4");
        EM_PLAN_YEAR.focus();
        return;
    }
    
    DS_IO_MASTER.ClearData();
    
    var strStrCd        = LC_STR_CD.BindColVal;         //점
    var strPlanYear     = EM_PLAN_YEAR.text;         //계획년도
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strPlanYear="        +encodeURIComponent(strPlanYear);
    
    TR_MAIN.Action="/dps/psal101.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    //스크롤바 위치 조정
    GD_MASTER.SETVSCROLLING(0);
    GD_MASTER.SETHSCROLLING(0);
    GD_MASTER.Focus();

    // 조회결과 Return
    setPorcCount("SELECT", DS_IO_MASTER.CountRow);
}

/**
 * btn_New()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-02-25
 * 개    요 : Grid CLEAR
 * return값 : void
 */
function btn_New() {

    //저장되지 않은 내용이 있을경우 경고
    if (DS_IO_MASTER.IsUpdated) {
        ret = showMessage(QUESTION, YESNO, "USER-1085");
        if (ret != "1") {
            return false;
        } 
    }

   DS_IO_MASTER.ClearData();
   EM_PLAN_YEAR.text = today.getYear(); 
   EM_PROF_IRATE.text = 0;
   EM_SALE_IRATE.text = 0;
   
   var strcd = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';     // 로그인 점코드
   LC_STR_CD.bindcolval = strcd;
   return;
    
}

/**
 * btn_Delete()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : void
 */
function btn_Delete() {

}

/**
 * btn_Save()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-02-25
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
   // 저장할 데이터 없는 경우
    if (!DS_IO_MASTER.IsUpdated ){
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
        return;
    }
   
    if (!checkDSBlank( GD_MASTER, "1,3,4,5,6,7"))  return;
    //데이터 길이 체크
    
    var strStrCd        = DS_IO_MASTER.NameValue(1,"STR_CD");         //점
    var strPlanYear     = DS_IO_MASTER.NameValue(1,"PLAN_YEAR");      //파트코드

    var goTo       = "searchConfFlag" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strPlanYear="        +encodeURIComponent(strPlanYear);

    TR_MAIN.Action="/dps/psal101.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_CHKCONFFLAG=DS_CHKCONFFLAG)"; 
    TR_MAIN.Post();
    
    
    if (DS_CHKCONFFLAG.countRow != 0) {
      showMessage(INFORMATION, OK, "USER-1000", "이미 확정된 데이터입니다.<br>취소 후 다시 등록하십시오.");
        return;
    }
        
    for(j=1; j <= DS_IO_MASTER.CountRow; j++ ){
      if(DS_IO_MASTER.NameValue(j, "STR_CD").length!=2){
         showMessage(INFORMATION, OK, "USER-1027","점코드","2");
         setFocusGrid(GD_MASTER, DS_IO_MASTER,j,"STR_CD");
         return;
      }
      
      if(DS_IO_MASTER.NameValue(j, "ORG_CD").length!=10){
            showMessage(INFORMATION, OK, "USER-1027","조직코드","10");
            setFocusGrid(GD_MASTER, DS_IO_MASTER,j,"ORG_CD");
            return;
        }

        if(DS_IO_MASTER.NameValue(j, "PLAN_YEAR").length!=4){
            showMessage(INFORMATION, OK, "USER-1027","목표년도","4");
            setFocusGrid(GD_MASTER, DS_IO_MASTER,j,"PLAN_YEAR");
            return;
        }

        if(DS_IO_MASTER.NameValue(j, "ORG_LEVEL").length!=1){
            showMessage(INFORMATION, OK, "USER-1027","조직레벨","1");
            setFocusGrid(GD_MASTER, DS_IO_MASTER,j,"ORG_LEVEL");
            return;
        }
        
        if(DS_IO_MASTER.NameValue(j, "DEPT_CD").length!=2){
            showMessage(INFORMATION, OK, "USER-1027","팀코드","2");
            setFocusGrid(GD_MASTER, DS_IO_MASTER,j,"DEPT_CD");
            return;
        }

        if(DS_IO_MASTER.NameValue(j, "TEAM_CD").length!=2){
            showMessage(INFORMATION, OK, "USER-1027","파트코드","2");
            setFocusGrid(GD_MASTER, DS_IO_MASTER,j,"TEAM_CD");
            return;
        }
    }
    errorRow ="";
    errcnt = 0;
    errorchk();
    if(errcnt > 0){
      showMessage(INFORMATION, OK, "USER-1000",errorRow+" 행이 데이터 정합성이 일치하지 않습니다.");
      var noCheckRow = errorRow.split(",");
      for(i=1; i <= noCheckRow.length; i++){
            for(j=1; j <= DS_IO_MASTER.CountRow; j++ ){
                if(noCheckRow[i-1] == j ){
                    DS_IO_MASTER.NameValue(j,"ERROR_CHECK") = "TRUE";
                    break;
                }
            }
        }
      return;
    }
    //중복된 데이터 체크 
    var retChk  = checkDupKey(DS_IO_MASTER, "STR_CD||DEPT_CD||TEAM_CD");
    if (retChk != 0) {
      showMessage(INFORMATION, OK, "USER-1044",retChk);
      return;
    }
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 )
        return;
    
    TR_MAIN.Action="/dps/psal101.ps?goTo=save";
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    

    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
        btn_Search();
    }
}

/**
 * btn_Excel()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

 /**
  * chkMGrid()
  * 작 성 자 : 박종은
  * 작 성 일 : 2010-02-18
  * 개    요 :  마진마스터 수정 여부 체크
  * return값 : void
  */
 function chkMGrid(){
     chk_grid1 = 0;
     
     for(var i=1; i<=DS_IO_MASTER.CountRow; i++ ) {
         if( DS_IO_MASTER.RowStatus(i) != "0"){    
               chk_grid1 += 1;
         }
     }
     
}
 /**
  * loadExcelData()
  * 작 성 자 : FKL
  * 작 성 일 : 2010.01.24
  * 개    요 : Excel파일 DateSet에 저장
  * return값 :
  */
 function loadExcelData() {

    //저장되지 않은 내용이 있을경우 경고
    if (DS_IO_MASTER.IsUpdated) {
        ret = showMessage(QUESTION, YESNO, "USER-1086");
        if (ret != "1") {
            return false;
        } 
    }


    var strStrCd        = LC_STR_CD.BindColVal;         //점
    var strPlanYear     = EM_PLAN_YEAR.text;         //계획년도
    
    var goTo       = "searchConfFlag" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strPlanYear="        +encodeURIComponent(strPlanYear);

    TR_MAIN.Action="/dps/psal101.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_CHKCONFFLAG=DS_CHKCONFFLAG)"; 
    TR_MAIN.Post();
    
    
    if (DS_CHKCONFFLAG.countRow != 0) {
      showMessage(INFORMATION, OK, "USER-1000", "이미 확정된 데이터입니다.<br>취소 후 다시 등록하십시오.");
        return;
    }
    
   // 엑셀 파일명 초기화
   INF_EXCELUPLOAD.Value = '';
   //Fils Open창
   INF_EXCELUPLOAD.Open();
   
   //loadExcelData 옵션처리
   var strExcelFileName = "'" + INF_EXCELUPLOAD.Value + "'"; //파일이름
   if (strExcelFileName == "''")
       return;

   DS_IO_MASTER.ClearData();

   var strStartRow = 7; //시작Row
   var strEndRow = 0; //끝Row
   var strReadType = 0; //읽기모드
   var strBlankCount = 0; //공백row개수
   var strLFTOCR = 0; //줄바꿈처리 
   var strFireEvent = 1; //이벤트발생
   var strSheetIndex = 1; //Sheet Index 추가
   var strtrEtc = "1";//엑셀 컬럼에 1000단위 구분기호(,)가 있을 경우, 구분기호를 무시하고 데이터를 가져온다. (생략가능, 생략시 디폴트값으로 0세팅 MAX: 1,2,1,72    UMX: 2,0,1,72 이상버전 사용가능)
   var strtrcol = 0;//Excel 파일에서 읽어 들일 시작 Col 위치 (생략가능, 생략시 디폴트값으로 0세팅 MAX: 1,2,1,80    UMX: 2,0,1,80 이상버전 사용가능)

    var strOption = strExcelFileName
        + "," + strStartRow + "," + strEndRow + "," + strReadType 
        + "," + strBlankCount + "," + strLFTOCR + "," + strFireEvent
        + "," + strSheetIndex + "," + strtrEtc+ "," + strtrcol;
    //Excel파일 DateSet에 저장               
    DS_IO_MASTER.Do("Excel.Application", strOption);
    //DateSet에 저장 후  Excel Header ROW삭제(첫행)
    DS_IO_MASTER.DeleteRow(1);
    
    //에러체크
    errorState();

    //전년매출
    searchBFYY();
    if(errcnt == 0 ){
        //수식 계산
        changecolumn();
    }
    
 }
 

 /**
  * applyIrate()
  * 작 성 자 : 박종은
  * 작 성 일 : 2010.01.24
  * 개     요 : 이익신장율, 매출신장율 적용
  * return값 :
  */
 function applyIrate() {
   var ProfIRate = EM_PROF_IRATE.text;   //이익시장율
   var SaleIRate = EM_SALE_IRATE.text;   //매출신장율
   var OriginSaleTAmt = 0;               //당초 총매출
   var BfyyNormCRate = 0;                 //전년 정상 비율
   var BfyyEvtCRate = 0;                  //전년 행사 비율
   
   if (SaleIRate != 0){
      for(i=1; i <= DS_IO_MASTER.CountRow; i++){
         if(getRoundDec("1",DS_IO_MASTER.NameValue(i,"BFYY_NORM_SAMT"),0) != 0){
             if(getRoundDec("1",DS_IO_MASTER.NameValue(i,"BFYY_SALE_TAMT"),0) != 0){
                 OriginSaleTAmt   = getRoundDec("1",DS_IO_MASTER.NameValue(i,"BFYY_SALE_TAMT"),0) + getRoundDec("1",DS_IO_MASTER.NameValue(i,"BFYY_SALE_TAMT"),0)*getRoundDec("1",SaleIRate,0)/100;
                 BfyyNormCRate    = (getRoundDec("1",DS_IO_MASTER.NameValue(i,"BFYY_NORM_SAMT"),0)*100)/getRoundDec("1",DS_IO_MASTER.NameValue(i,"BFYY_SALE_TAMT"),0);
                 BfyyEvtCRate     = 100 - getRoundDec("1",BfyyNormCRate,0);
             }
             OriginSaleTAmt = getRoundDec("1",OriginSaleTAmt,0);
             BfyyNormCRate  = getRoundDec("1",BfyyNormCRate,0);
             BfyyEvtCRate   = getRoundDec("1", BfyyEvtCRate,0);
             
             DS_IO_MASTER.NameValue(i,"ORIGIN_NORM_SAMT") = getRoundDec("1",(OriginSaleTAmt * BfyyNormCRate)/100,0);    //round(DS_IO_MASTER.NameValue(i,"BFYY_NORM_SAMT"),0)+ (round(DS_IO_MASTER.NameValue(i,"BFYY_NORM_SAMT"),0)* round(SaleIRate,0)/100);
         }
         
         if(getRoundDec("1",DS_IO_MASTER.NameValue(i,"BFYY_EVT_SAMT"),0) != 0){
             DS_IO_MASTER.NameValue(i,"ORIGIN_EVT_SAMT") = getRoundDec("1",(OriginSaleTAmt * BfyyEvtCRate)/100,0);    //round(DS_IO_MASTER.NameValue(i,"BFYY_EVT_SAMT"),0)+ (round(DS_IO_MASTER.NameValue(i,"BFYY_EVT_SAMT"),0)* round(SaleIRate,0)/100);
         }
      }
   }
   else{
      for(i=1; i <= DS_IO_MASTER.CountRow; i++){
         if(DS_IO_MASTER.NameValue(i,"ORIGIN_NORM_SAMT") == 0){
            DS_IO_MASTER.NameValue(i,"ORIGIN_NORM_SAMT") = getRoundDec("1",DS_IO_MASTER.NameValue(i,"BFYY_NORM_SAMT"),0);
         }
         if(DS_IO_MASTER.NameValue(i,"ORIGIN_EVT_SAMT") == 0){
            DS_IO_MASTER.NameValue(i,"ORIGIN_EVT_SAMT") = getRoundDec("1",DS_IO_MASTER.NameValue(i,"BFYY_EVT_SAMT"),0) ;
         }
      }
   }
      
   if (ProfIRate != 0){
      for(i=1; i <= DS_IO_MASTER.CountRow; i++){
         if(round(DS_IO_MASTER.NameValue(i,"BFYY_PROF_TAMT"),0) != 0){
             DS_IO_MASTER.NameValue(i,"ORIGIN_PROF_TAMT") = getRoundDec("1",DS_IO_MASTER.NameValue(i,"BFYY_PROF_TAMT"),0)+ getRoundDec("1",DS_IO_MASTER.NameValue(i,"BFYY_PROF_TAMT")* ProfIRate/100,0);
         }
      } 
    }
   else {
      for(i=1; i <= DS_IO_MASTER.CountRow; i++){
         if(DS_IO_MASTER.NameValue(i,"ORIGIN_PROF_TAMT") == 0){
            DS_IO_MASTER.NameValue(i,"ORIGIN_PROF_TAMT") = getRoundDec("1",DS_IO_MASTER.NameValue(i,"BFYY_PROF_TAMT"),0);
         }
         
      }
   }
   
   var orgSaleCRate = 0;
   var orgPorfCRate = 0;
   for(i=1; i <= DS_IO_MASTER.CountRow; i++){
      
      DS_IO_MASTER.NameValue(i,"ORIGIN_SALE_TAMT") = getRoundDec("1",DS_IO_MASTER.NameValue(i,"ORIGIN_NORM_SAMT") + DS_IO_MASTER.NameValue(i,"ORIGIN_EVT_SAMT"),0);
      orgSaleCRate =round(orgSaleCRate,0)+ round(DS_IO_MASTER.NameValue(i,"ORIGIN_SALE_TAMT"),0);
      orgPorfCRate =round(orgPorfCRate,0)+ round(DS_IO_MASTER.NameValue(i,"ORIGIN_PROF_TAMT"),0);
      
      orgSaleCRate = getRoundDec("1",orgSaleCRate,0);
      orgPorfCRate = getRoundDec("1",orgPorfCRate,0);
      
      if(round(DS_IO_MASTER.NameValue(i,"BFYY_SALE_TAMT"),2) != 0){
         if(round(DS_IO_MASTER.NameValue(i,"ORIGIN_SALE_TAMT"),2) > 0){
            DS_IO_MASTER.NameValue(i,"ORIGIN_SALE_IRATE") = getRoundDec("1",((getRoundDec("1",DS_IO_MASTER.NameValue(i,"ORIGIN_SALE_TAMT"),2) - getRoundDec("1",DS_IO_MASTER.NameValue(i,"BFYY_SALE_TAMT"),2))/getRoundDec("1",DS_IO_MASTER.NameValue(i,"BFYY_SALE_TAMT"),2))*100.00,2);
            if(round(DS_IO_MASTER.NameValue(i,"ORIGIN_SALE_IRATE"),2) >= 1000.00){
               DS_IO_MASTER.NameValue(i,"ORIGIN_SALE_IRATE") = 999.99;
            }
         }
         else {
            DS_IO_MASTER.NameValue(i,"ORIGIN_SALE_IRATE") = 0.00;
         }
      }
      
      if(round(DS_IO_MASTER.NameValue(i,"BFYY_PROF_TAMT"),2) != 0){
         if(round(DS_IO_MASTER.NameValue(i,"ORIGIN_PROF_TAMT"),2) > 0){
             DS_IO_MASTER.NameValue(i,"ORIGIN_PROF_IRATE") = getRoundDec("1",((getRoundDec("1",DS_IO_MASTER.NameValue(i,"ORIGIN_PROF_TAMT"),2) - getRoundDec("1",DS_IO_MASTER.NameValue(i,"BFYY_PROF_TAMT"),2))/getRoundDec("1",DS_IO_MASTER.NameValue(i,"BFYY_PROF_TAMT"),2))*100.00,2);
             if(round(DS_IO_MASTER.NameValue(i,"ORIGIN_PROF_IRATE"),2) >= 1000.00){
               DS_IO_MASTER.NameValue(i,"ORIGIN_PROF_IRATE") = 999.99;
             }
         }
         else{
            DS_IO_MASTER.NameValue(i,"ORIGIN_PROF_IRATE") = 0.00;
         }
            
      }
      
   }
   for(i=1; i <= DS_IO_MASTER.CountRow; i++){
      if(round(DS_IO_MASTER.NameValue(i,"ORIGIN_SALE_TAMT"),2) != 0){
    	     DS_IO_MASTER.NameValue(i,"ORIGIN_SALE_CRATE") = getRoundDec("1",getRoundDec("1",DS_IO_MASTER.NameValue(i,"ORIGIN_SALE_TAMT"),2)/getRoundDec("1",orgSaleCRate,2)*100.00,2);
         }
         else{
             DS_IO_MASTER.NameValue(i,"ORIGIN_SALE_CRATE") = 0.00;
         }
         if(round(DS_IO_MASTER.NameValue(i,"ORIGIN_PROF_TAMT"),2) != 0){
             DS_IO_MASTER.NameValue(i,"ORIGIN_PROF_CRATE") = getRoundDec("1",getRoundDec("1",DS_IO_MASTER.NameValue(i,"ORIGIN_PROF_TAMT"),2)/getRoundDec("1",orgPorfCRate,2)*100.00,2);
         }
         else{
             DS_IO_MASTER.NameValue(i,"ORIGIN_PROF_CRATE") = 0.00;
         }
    }
   
 }

 /**
 * changecolumn()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010.01.24
 * 개     요 : 수식계산
 * return값 :
 */
 function changecolumn(){
     var orgSaleCRate = 0;                 //총매출합계
     var orgPorfCRate = 0;                 //이익합계
     
     for(i=1; i <= DS_IO_MASTER.CountRow; i++){
       for(j=1; j <= DS_STR_CD_I.CountRow; j++){
             if(DS_IO_MASTER.NameValue(i,"STR_CD") == DS_STR_CD_I.ColumnValue(j,1) ){
                 DS_IO_MASTER.NameValue(i,"STR_NAME") = DS_STR_CD_I.ColumnValue(j,2);
             }
         }
         DS_IO_MASTER.NameValue(i,"ORIGIN_SALE_TAMT") = getRoundDec("1",DS_IO_MASTER.NameValue(i,"ORIGIN_NORM_SAMT"),0) + getRoundDec("1",DS_IO_MASTER.NameValue(i,"ORIGIN_EVT_SAMT"),0);
         
         orgSaleCRate = getRoundDec("1",orgSaleCRate,0)+ getRoundDec("1",DS_IO_MASTER.NameValue(i,"ORIGIN_SALE_TAMT"),0);
         orgPorfCRate = getRoundDec("1",orgPorfCRate,0)+ getRoundDec("1",DS_IO_MASTER.NameValue(i,"ORIGIN_PROF_TAMT"),0);
         orgSaleCRate = getRoundDec("1",orgSaleCRate,0);
         orgPorfCRate = getRoundDec("1",orgPorfCRate,0);
         
         if(getRoundDec("1",DS_IO_MASTER.NameValue(i,"BFYY_SALE_TAMT"),0) != 0){
             DS_IO_MASTER.NameValue(i,"ORIGIN_SALE_IRATE") = getRoundDec("1",((getRoundDec("1",DS_IO_MASTER.NameValue(i,"ORIGIN_SALE_TAMT"),2) - getRoundDec("1",DS_IO_MASTER.NameValue(i,"BFYY_SALE_TAMT"),2))/getRoundDec("1",DS_IO_MASTER.NameValue(i,"BFYY_SALE_TAMT"),2))*100.00,2);
             if(getRoundDec("1",DS_IO_MASTER.NameValue(i,"ORIGIN_SALE_IRATE"),2) >= 1000.00){
                 DS_IO_MASTER.NameValue(i,"ORIGIN_SALE_IRATE") = 999.99;
             }
         }
         else{
             DS_IO_MASTER.NameValue(i,"ORIGIN_SALE_IRATE") = 0.00;
         }
         
         if(getRoundDec("1",DS_IO_MASTER.NameValue(i,"BFYY_PROF_TAMT"),0) != 0){
             DS_IO_MASTER.NameValue(i,"ORIGIN_PROF_IRATE") = getRoundDec("1",((getRoundDec("1",DS_IO_MASTER.NameValue(i,"ORIGIN_PROF_TAMT"),2) - getRoundDec("1",DS_IO_MASTER.NameValue(i,"BFYY_PROF_TAMT"),2))/getRoundDec("1",DS_IO_MASTER.NameValue(i,"BFYY_PROF_TAMT"),2))*100.00,2);
             if(getRoundDec("1",DS_IO_MASTER.NameValue(i,"ORIGIN_PROF_IRATE"),2) >= 1000.00){
                 DS_IO_MASTER.NameValue(i,"ORIGIN_PROF_IRATE") = 999.99;
             }
         }
         else{
             DS_IO_MASTER.NameValue(i,"ORIGIN_PROF_IRATE") = 0.00;
         }
         
     }
     for(i=1; i <= DS_IO_MASTER.CountRow; i++){
         if(getRoundDec("1",DS_IO_MASTER.NameValue(i,"ORIGIN_SALE_TAMT"),2) != 0){
          DS_IO_MASTER.NameValue(i,"ORIGIN_SALE_CRATE") = getRoundDec("1",getRoundDec("1",DS_IO_MASTER.NameValue(i,"ORIGIN_SALE_TAMT"),2)/getRoundDec("1",orgSaleCRate,2)*100.00,2);
         }
         else{
          DS_IO_MASTER.NameValue(i,"ORIGIN_SALE_CRATE") = 0.00;
         }
         if(getRoundDec("1",DS_IO_MASTER.NameValue(i,"ORIGIN_PROF_TAMT"),2) != 0){
          DS_IO_MASTER.NameValue(i,"ORIGIN_PROF_CRATE") = getRoundDec("1",getRoundDec("1",DS_IO_MASTER.NameValue(i,"ORIGIN_PROF_TAMT"),2)/getRoundDec("1",orgPorfCRate,2)*100.00,2);
         }
         else{
          DS_IO_MASTER.NameValue(i,"ORIGIN_PROF_CRATE") = 0.00;
         }
         
     }
 }

 /**
 * ExcelDownData()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010.01.24
 * 개     요 : 엑셀다운
 * return값 :
 */
 function ExcelDownData() {
    
     if(DS_IO_MASTER.CountRow <= 0){
       showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
         return;
     }
     var strTitle = "당초파트별년매출목표";

     var strStrCd        = LC_STR_CD.Text;            //점
     var strPlanYear     = EM_PLAN_YEAR.text;         //계획년도
     var parameters = "점 "              + strStrCd
                    + "    목표년도 "     + strPlanYear;
     
     GD_MASTER.GridToExcelExtProp("HideColumn") = "{currow}";       // GridToExcel 사용시 숨길 컬럼지정
     openExcel2(GD_MASTER, strTitle, parameters, true );
 }

 /**
 * errorchk()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010.01.24
 * 개     요 : 에러체크
 * return값 :
 */
function errorchk(){
   
   
   for(i=1; i <= DS_IO_MASTER.CountRow; i++){
      j = i;
      
        var strStrCd        = DS_IO_MASTER.NameValue(i,"STR_CD");         //점
        var strOrgCd        = DS_IO_MASTER.NameValue(i,"ORG_CD");         //조직코드
        var strOrgLevel     = DS_IO_MASTER.NameValue(i,"ORG_LEVEL");      //조직레벨
        var strDeptCd       = DS_IO_MASTER.NameValue(i,"DEPT_CD");        //부서코드
        var strTeamCd       = DS_IO_MASTER.NameValue(i,"TEAM_CD");        //파트코드
        
        if(strStrCd.length == 2 && strOrgCd.length == 10 && strOrgLevel.length ==1 && strDeptCd.length == 2 && strTeamCd.length ==2
        && !isNull(strStrCd)	&& !isNull(strOrgCd) && !isNull(strOrgLevel) && !isNull(strDeptCd) && !isNull(strTeamCd) 	){

            var goTo       = "searchOrgMst" ;    
            var action     = "O";     
            var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                           + "&strOrgCd="           +encodeURIComponent(strOrgCd)
                           + "&strOrgLevel="        +encodeURIComponent(strOrgLevel)
                           + "&strDeptCd="          +encodeURIComponent(strDeptCd)
                           + "&strTeamCd="          +encodeURIComponent(strTeamCd);

            TR_MAIN.Action="/dps/psal101.ps?goTo="+goTo+parameters;  
            TR_MAIN.KeyValue="SERVLET("+action+":DS_CHKORGMST=DS_CHKORGMST)"; 
            TR_MAIN.Post();
            i = j;
            
            if (DS_CHKORGMST.countRow == 0) {
             errcnt += 1;
             errorRow += i+",";
            }
        }
        else{
        	errcnt += 1;
            errorRow += i+",";
        }
   }
   
   errorRow = errorRow.substr(0,errorRow.length-1);
   
}

/**
* errorState()
* 작 성 자 : 박종은
* 작 성 일 : 2010.01.24
* 개     요 : 에러체크
* return값 :
*/
function errorState(){
   
    errorRow ="";
    errcnt = 0;
    errorchk();
    if(errcnt > 0){
        var noCheckRow = errorRow.split(",");
        
        for(i=1; i <= noCheckRow.length; i++){
            for(j=1; j <= DS_IO_MASTER.CountRow; j++ ){
                if(noCheckRow[i-1] == j ){
                    DS_IO_MASTER.NameValue(j,"ERROR_CHECK") = "TRUE";
                    break;
                }
            }
        
        }

    }
    
    for(k=1; k <= DS_IO_MASTER.CountRow; k++){
        if( isNull(DS_IO_MASTER.NameValue(k,"STR_CD"))     == true || 
                isNull(DS_IO_MASTER.NameValue(k,"ORG_CD"))     == true || 
                isNull(DS_IO_MASTER.NameValue(k,"ORG_LEVEL"))  == true || 
                isNull(DS_IO_MASTER.NameValue(k,"DEPT_CD"))    == true || 
                isNull(DS_IO_MASTER.NameValue(k,"TEAM_CD"))    == true){
          DS_IO_MASTER.NameValue(k,"ERROR_CHECK") = "TRUE";
        }
        if(DS_IO_MASTER.NameValue(k,"ORG_CD") == "합계"){
         DS_IO_MASTER.DeleteRow(k);
        }
    }
    
}


/**
* searchBFYY()
* 작 성 자 : 박종은
* 작 성 일 : 2010.03.21
* 개     요 : 전년실적 조회
* return값 :
*/
function searchBFYY(){
    var j = 0;
  
    for(i=1; i <= DS_IO_MASTER.CountRow; i++){
        j = i;
     
        var strStrCd        = DS_IO_MASTER.NameValue(i,"STR_CD");         //점
        var strPlanYear     = DS_IO_MASTER.NameValue(i,"PLAN_YEAR");      //년도
        var strDeptCd       = DS_IO_MASTER.NameValue(i,"DEPT_CD");        //팀
        var strTeamCd       = DS_IO_MASTER.NameValue(i,"TEAM_CD");        //파트

        if(strStrCd.length == 2 &&  strDeptCd.length ==2 && strTeamCd.length == 2 && strPlanYear.length == 4
        && !isNull(strStrCd)    && !isNull(strDeptCd) && !isNull(strTeamCd)   && !isNull(strPlanYear)  ){

        var goTo       = "searchBFYY" ;    
        var action     = "O";     
        var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                       + "&strPlanYear="        +encodeURIComponent(strPlanYear)
                       + "&strDeptCd="          +encodeURIComponent(strDeptCd)
                       + "&strTeamCd="          +encodeURIComponent(strTeamCd);

        TR_MAIN.Action="/dps/psal101.ps?goTo="+goTo+parameters;  
        TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_BFYY=DS_IO_BFYY)"; 
        TR_MAIN.Post();
        }
        i = j;
        
        if(DS_IO_BFYY.CountRow > 0){
    	    DS_IO_MASTER.NameValue(i, "BFYY_NORM_SAMT")  = DS_IO_BFYY.NameValue(i,"BFYY_NORM_SAMT");
    	    DS_IO_MASTER.NameValue(i, "BFYY_EVT_SAMT")   = DS_IO_BFYY.NameValue(i,"BFYY_EVT_SAMT");
    	    DS_IO_MASTER.NameValue(i, "BFYY_SALE_TAMT")  = DS_IO_BFYY.NameValue(i,"BFYY_SALE_TAMT");
    	    DS_IO_MASTER.NameValue(i, "BFYY_PROF_TAMT")  = DS_IO_BFYY.NameValue(i,"BFYY_PROF_TAMT");
    	    DS_IO_MASTER.NameValue(i, "BFYY_SALE_CRATE") = DS_IO_BFYY.NameValue(i,"BFYY_SALE_CRATE");
    	    DS_IO_MASTER.NameValue(i, "BFYY_PROF_CRATE") = DS_IO_BFYY.NameValue(i,"BFYY_PROF_CRATE");
        }
        else{
            DS_IO_MASTER.NameValue(i, "BFYY_NORM_SAMT")  = 0;
            DS_IO_MASTER.NameValue(i, "BFYY_EVT_SAMT")   = 0;
            DS_IO_MASTER.NameValue(i, "BFYY_SALE_TAMT")  = 0;
            DS_IO_MASTER.NameValue(i, "BFYY_PROF_TAMT")  = 0;
            DS_IO_MASTER.NameValue(i, "BFYY_SALE_CRATE") = 0;
            DS_IO_MASTER.NameValue(i, "BFYY_PROF_CRATE") = 0;
        }
       
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

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<!--------------------- 3. Excelupload  --------------------------------------->
<comment id="_NSID_">
<object id=INF_EXCELUPLOAD classid=<%=Util.CLSID_INPUTFILE%>
   style="position: absolute; left: 355px; top: 55px; width: 110px; height: 23px; visibility: hidden;">
   <param name="Text" value='FileOpen'>
   <param name="Enable" value="true">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- Grid GD_DETAIL OnExit event 처리 -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
	if(row <= 0 ){
	    setFocusGrid(GD_MASTER, DS_IO_MASTER,0,colid);
	    sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
	}
</script>

<script language="javascript">
    var lOption = 0;
    var szTitle, szTitle2, szTitle3;
    var szName = "Sheet Name";
    var szPath = "C:\\Test\\Test";
    var today    = new Date();
    var chk_grid1 = 0;
    var errchk_flag = 0;
    var errcnt = 0;
    var errorRow = "";
    var errorRowS = "";
    var old_Row = 0;
    var old_ORIGIN_NORM_SAMT = 0; //정상
    var old_ORIGIN_EVT_SAMT = 0;   //행사
    var old_ORIGIN_PROF_TAMT = 0; //이익
     
</script>



<script language=JavaScript for=DS_IO_MASTER
   event=onColumnChanged(Row,Colid)>
old_Row = Row
//처음값
old_ORIGIN_NORM_SAMT = round(DS_IO_MASTER.NameValue(Row, "ORIGIN_NORM_SAMT"),0); //정상
old_ORIGIN_EVT_SAMT = round(DS_IO_MASTER.NameValue(Row, "ORIGIN_EVT_SAMT"),0);   //행사
old_ORIGIN_PROF_TAMT = round(DS_IO_MASTER.NameValue(Row, "ORIGIN_PROF_TAMT"),0); //이익
// 이 Event에서 SetColumn을 사용하는 것은 의미가 없다. Changed를 수행한 후 SetColumn이 자동으로 수행되기 때문이다.
</script>

<script language=Javascript for=GD_MASTER
   event=OnExit(row,colid,olddata)>

   switch (colid) {
   case "STR_CD" :
      if(olddata != DS_IO_MASTER.NameValue(row,"STR_CD")){
           for(i=1; i <= DS_STR_CD_I.CountRow; i++){
            if(DS_IO_MASTER.NameValue(row,"STR_CD") == DS_STR_CD_I.ColumnValue(i,1) ){
               DS_IO_MASTER.NameValue(row,"STR_NAME") = DS_STR_CD_I.ColumnValue(i,2);
            }
           }
      }
        break;
   case "ORIGIN_NORM_SAMT" :
       if(olddata != DS_IO_MASTER.NameValue(row,"ORIGIN_NORM_SAMT") ){
           changecolumn();
       }
       
       break;
   case "ORIGIN_EVT_SAMT" :
      if(olddata != DS_IO_MASTER.NameValue(row,"ORIGIN_EVT_SAMT") ){
            changecolumn();
        }
       break;
   case "ORIGIN_PROF_TAMT" :
      if(olddata != DS_IO_MASTER.NameValue(row,"ORIGIN_PROF_TAMT") ){
            changecolumn();
        }
       break;
   default:
       break;
   
   }
</script>
<script language=JavaScript for=EM_PROF_IRATE event=OnKillFocus()>
    if(EM_PROF_IRATE.text.length == 0){
      EM_PROF_IRATE.text = 0;
      return;
    }
</script>

<script language=JavaScript for=EM_SALE_IRATE event=OnKillFocus()>
    if(EM_SALE_IRATE.text.length == 0){
        EM_SALE_IRATE.text = 0;
        return;
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
<object id="DS_STR_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_STR_CD_I" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_BFYY" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_IO_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_CHKORGMST" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_CHKCONFFLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_STR_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_DEPT_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_TEAM_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
   <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_MASTER");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)-top) <= top) {
    	grd_height = top+300;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
}
</script>

<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<DIV id="testdiv" class="testdiv">

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
                  <td width="150"><comment id="_NSID_"> <object
                     id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=140 tabindex=1
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width="80" class="point">목표년도</th>
                  <td colspan="5"><comment id="_NSID_"> <object
                     id=EM_PLAN_YEAR classid=<%=Util.CLSID_EMEDIT%> width=120
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  </td>
               </tr>
            </table>
            </td>
         </tr>
      </table>
      </td>
   </tr>

   <tr>
      <td class="PT01 PB03">
      <table width="100%" border="0" cellspacing="0" cellpadding="0"
         class="">
         <tr>
            <td>
            <table width="460" class="s_table">
               <tr>
                  <th width="100">이익신장율</th>
                  <td width="100"><comment id="_NSID_"> <object
                     id=EM_PROF_IRATE classid=<%=Util.CLSID_EMEDIT%> width=80 
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>%

                  </td>
                  <th width="100">매출신장율</th>
                  <td width="100"><comment id="_NSID_"> <object
                     id=EM_SALE_IRATE classid=<%=Util.CLSID_EMEDIT%> width=80 
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>%
                  </td>
                  <td width="60"><img src="/<%=dir%>/imgs/btn/apply.gif"
                     onclick="applyIrate();" align="right" /></td>
               </tr>
            </table>
            </td>
            <td class="right PB03">
            <table width="160" border="0" cellpadding="0" cellspacing="0">
               <tr>
                  <th><img src="/<%=dir%>/imgs/btn/excel_s.gif"
                     onclick="loadExcelData();" align="absmiddle" /></th>
                  <th><img src="/<%=dir%>/imgs/btn/excel_down.gif"
                     onclick="ExcelDownData();" align="absmiddle" /></th>
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
            <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0"
               class="BD4A">
               <tr>
                  <td width="100%"><comment id="_NSID_"> <object
                     id=GD_MASTER width=100% height=476 classid=<%=Util.CLSID_GRID%>>
                     <param name="DataID" value="DS_IO_MASTER">
                  </object> </comment><script>_ws_(_NSID_);</script></td>
               </tr>
            </table>
            </td>
         </tr>
      </table>
      </td>
   </tr>


</table>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</div>
<body>
</html>
