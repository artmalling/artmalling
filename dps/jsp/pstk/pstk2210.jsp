<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 재고수불 > 재고실사> 실사재고현황(단품)
 * 작 성 일 : 2010.04.29
 * 작 성 자 : 이재득
 * 수 정 자 : 
 * 파 일 명 : pstk221.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 단품별 실사재고현황을 조회한다.
 * 이    력 :
 *        2010.04.29 (이재득) 작성
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
<%

	String dir = BaseProperty.get("context.common.dir");

	//PID 확인을 위한
	String pageName = request.getRequestURI();
	int nSubStrFr = pageName.lastIndexOf("/") + 1 ;
	int nSubStrTo = pageName.lastIndexOf(".jsp") - 1 ;
	pageName = pageName.substring(nSubStrFr, nSubStrTo).toUpperCase();
	
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

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 var bfMasterRowPos = 0;
 /**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.29
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top2 = 425;		//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_DETAIL"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top2) + "px";

    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');    
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2();
    
    // EMedit에 초기화( gauce.js )
    initEmEdit(EM_O_STK_YM,       "THISMN",    PK);     //실사년월
    initEmEdit(EM_O_PUMBUN_CD,    "CODE^6^0",  NORMAL);     //브랜드코드
    initEmEdit(EM_O_PUMBUN_NAME,  "GEN^40",    READ); //브랜드명
    initEmEdit(EM_O_PUMBUN_TO_CD,    "CODE^6^0",  NORMAL);     //브랜드코드
    initEmEdit(EM_O_PUMBUN_TO_NAME,  "GEN^40",    READ); //브랜드명
    initEmEdit(EM_O_STK_DT,       "YYYYMMDD",  READ); //재고조사일
    initEmEdit(EM_O_STK_FLAG,     "GEN^10",    READ); //재고실사구분
    initEmEdit(EM_O_STATE,        "GEN^40",    READ); //상태
    //콤보 초기화
    initComboStyle(LC_O_STR_CD,DS_O_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);  //점(조회)
    initComboStyle(LC_O_DEPT_CD,DS_O_DEPT_CD, "CODE^0^30,NAME^0^110", 1, PK);  //팀    
    initComboStyle(LC_O_TEAM_CD,DS_O_TEAM_CD, "CODE^0^30,NAME^0^110", 1, NORMAL);  //파트
    initComboStyle(LC_O_PC_CD,DS_O_PC_CD, "CODE^0^30,NAME^0^110", 1, NORMAL);  //PC
    
    // 로딩시 값을 가겨오지 않는 콤보 데이셋 초기화    
    DS_O_TEAM_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_O_PC_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    
    //점콤보 가져오기 ( gauce.js )     
    getStore("DS_O_STR_CD", "Y", "", "N");    
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_O_STR_CD, '<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); 
    
    LC_O_STR_CD.Focus();
    getPbnStk();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}          name="NO"              width=30     align=center    edit=none  sumtext=""</FC>'                     
                     + '<FC>id=PUMBUN_CD         name="브랜드코드"        width=75    align=center edit=none  sumtext="합계"</FC>'
                     + '<FC>id=PUMBUN_NAME       name="브랜드명"          width=90    align=left  edit=none   sumtext=""</FC>'                     
                     + '<FC>id=STR_CD            name="점"              width=85    align=center  edit=none  show="false"</FC>'
                     + '<FC>id=PUMMOK_CD         name="품목코드"        width=85    align=center  edit=none  show="false"</FC>'
                     + '<FC>id=STK_YM            name="실사년월"        width=85    align=center  edit=none  show="false"</FC>'
                     + '<FG> name="기초재고" '
                     + '<FC>id=SRVY_QTY          name="수량"            width=70    align=right   edit=none  sumtext=@sum</FC>'
                     + '<FC>id=SRVY_AMT          name="금액"            width=110    align=right  edit=none   sumtext=@sum</FC>'
                     + '</FG> ' 
                     + '<FC>id=PUMMOK_CD         name="품목코드"        width=85    align=center  edit=none  show="false"</FC>'
                     + '<FC>id=STK_YM            name="실사년월"        width=85    align=center  edit=none  show="false"</FC>'
                     + '<FG> name="매입" '
                     + '<FC>id=BUY_TOT_QTY       name="수량"            width=70    align=right  edit=none   sumtext=@sum</FC>'
                     + '<FC>id=BUY_TOT_SALE_AMT  name="금액"            width=110    align=right  edit=none   sumtext=@sum</FC>'
                     + '</FG> ' 
                     + '<FG> name="매출" '
                     + '<FC>id=SALE_QTY          name="수량"            width=70    align=right  edit=none   sumtext=@sum</FC>'
                     + '<FC>id=SALE_AMT     name="금액"            width=110    align=right  edit=none   sumtext=@sum</FC>'
                     + '</FG> ' 
                     + '<FG> name="장부재고" '
                     + '<FC>id=JB_QTY            name="수량"            width=70    align=right  edit=none   sumtext=@sum</FC>'
                     + '<FC>id=JB_AMT            name="금액"            width=110    align=right  edit=none   sumtext=@sum</FC>'
                     + '</FG> ' 
                     + '<FG> name="실사재고합계" '
                     + '<FC>id=SRVY_SUM_QTY      name="수량"            width=70    align=right  edit=none   sumtext=@sum</FC>'
                     + '<FC>id=SRVY_SUM_AMT      name="금액"            width=110    align=right  edit=none   sumtext=@sum</FC>'
                     + '</FG> ' 
                     + '<FG> name="차이" '
                     + '<FC>id=LOSS_QTY          name="수량"            width=70    align=right  edit=none   sumtext=@sum  SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=QTY_LOSS_RATE     name="율"          width=55    align=right  edit=none   sumtext={((sum(JB_QTY)-sum(SRVY_SUM_QTY))/sum(JB_QTY))*100}  SubBgColor=#FFFFE0 DisplayFormat ="#,###.##"  </FC>'
                     + '<FC>id=LOSS_COST_AMT     name="금액"        width=110    align=right  edit=none   sumtext=@sum  SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=AMT_LOSS_RATE     name="율"          width=55    align=right  edit=none   sumtext={((sum(JB_AMT)-sum(SRVY_SUM_AMT))/sum(JB_AMT))*100}  SubBgColor=#FFFFE0 DisplayFormat ="#,###.##"  </FC>'
                     + '</FG> ' ; 
    initGridStyle(GD_MASTER, "common", hdrProperies, true);
}

function gridCreate2(){
    var hdrProperies = '<FC>id={currow}          name="NO"              width=30    align=center    edit=none  sumtext=""   SubBgColor=#FFFFE0</FC>'  
                     + '<FC>id=PUMMOK_CD         name="품목코드"        width=85    align=center edit=none  show=false       SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=PUMMOK_NAME       name="품목명"          width=90    align=left   edit=none  sumtext=""      SubBgColor=#FFFFE0 </FC>'
                     + '<FC>id=MODEL_NO	          name="브랜드단품코드"   width=110   align=center edit=none  sumtext=""      SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=SKU_CD            name="단품코드"        width=110   align=center edit=none  sumtext=""      SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=SKU_NAME          name="단품명"          width=120    align=left   edit=none  sumtext=""      SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=STR_CD            name="점"              width=85    align=center edit=none  show="false"</FC>'                     
                     + '<FC>id=STK_YM            name="실사년월"        width=85    align=center edit=none  show="false"</FC>'
                     + '<FG> name="기초재고" '
                     + '<FC>id=SRVY_QTY          name="수량"            width=70    align=right  edit=none  sumtext=@sum     SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=SRVY_AMT          name="금액"            width=110    align=right  edit=none   sumtext=@sum    SubBgColor=#FFFFE0</FC>'
                     + '</FG> '                                       
                     + '<FG> name="매입" '
                     + '<FC>id=BUY_TOT_QTY       name="수량"            width=70    align=right  edit=none   sumtext=@sum  SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=BUY_TOT_SALE_AMT  name="금액"            width=110    align=right  edit=none   sumtext=@sum  SubBgColor=#FFFFE0</FC>'
                     + '</FG> ' 
                     + '<FG> name="매출" '
                     + '<FC>id=SALE_QTY          name="수량"            width=70    align=right  edit=none   sumtext=@sum  SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=SALE_AMT     name="금액"            width=110    align=right  edit=none   sumtext=@sum  SubBgColor=#FFFFE0</FC>'
                     + '</FG> ' 
                     + '<FG> name="장부재고" '
                     + '<FC>id=JB_QTY            name="수량"            width=70    align=right  edit=none   sumtext=@sum  SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=JB_AMT            name="금액"            width=110    align=right  edit=none   sumtext=@sum  SubBgColor=#FFFFE0</FC>'
                     + '</FG> ' 
                     + '<FG> name="실사재고" '
                    // + '<FC>id=NORM_QTY          name="정상수량"         width=70    align=right  edit=none   sumtext=@sum  SubBgColor=#FFFFE0</FC>'
                    // + '<FC>id=NORM_AMT          name="정상금액"         width=110    align=right  edit=none   sumtext=@sum  SubBgColor=#FFFFE0</FC>'
                    // + '<FC>id=INFRR_QTY         name="불량수량"         width=70    align=right  edit=none   sumtext=@sum  SubBgColor=#FFFFE0</FC>'
                    // + '<FC>id=INFRR_AMT         name="불량금액"         width=110    align=right  edit=none   sumtext=@sum  SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=SRVY_SUM_QTY      name="합계수량"         width=70    align=right  edit=none   sumtext=@sum  SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=SRVY_SUM_AMT      name="합계금액"         width=110    align=right  edit=none   sumtext=@sum  SubBgColor=#FFFFE0</FC>'
                     + '</FG> ' 
                     + '<FG> name="차이" '
                     + '<FC>id=LOSS_QTY          name="수량"            width=70    align=right  edit=none   sumtext=@sum  SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=QTY_LOSS_RATE     name="율"          width=55    align=right  edit=none   sumtext={((sum(JB_QTY)-sum(SRVY_SUM_QTY))/sum(JB_QTY))*100}  SubBgColor=#FFFFE0 DisplayFormat ="#,###.##"  </FC>'
                     + '<FC>id=LOSS_COST_AMT     name="금액"        width=110    align=right  edit=none   sumtext=@sum  SubBgColor=#FFFFE0</FC>'
                     + '<FC>id=AMT_LOSS_RATE     name="율"          width=55    align=right  edit=none   sumtext={((sum(JB_AMT)-sum(SRVY_SUM_AMT))/sum(JB_AMT))*100}  SubBgColor=#FFFFE0 DisplayFormat ="#,###.##"  </FC>'
                     + '</FG> ' ;
                     
    initGridStyle(GD_DETAIL, "common", hdrProperies, true);
    GD_DETAIL.ViewSummary = "1";      
    DS_IO_DETAIL.SubSumExpr  = "PUMMOK_CD"; 
    GD_DETAIL.ColumnProp("PUMMOK_CD", "subSumText")     = "품목소계"; 
    GD_DETAIL.ColumnProp("PUMMOK_CD", "sumtext")           = "합계";
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
 * 작 성 일 : 2010.04.29
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() { 
    if( LC_O_STR_CD.BindColVal == "" ){
        showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "점");            
        LC_O_STR_CD.Focus();
        return false;
    }else if( EM_O_STK_YM.Text == "" ){
        showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "실사년월");            
        EM_O_STK_YM.Focus();
        return false;
    }else if( LC_O_DEPT_CD.BindColVal == "" ){
        showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "팀");            
        LC_O_DEPT_CD.Focus();
        return false;
    }else if( LC_O_TEAM_CD.BindColVal == "" ){
        showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "파트");            
        LC_O_TEAM_CD.Focus();
        return false;
    }else if( LC_O_PC_CD.BindColVal == "" ){
        showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "PC");            
        LC_O_PC_CD.Focus();
        return false;
    }
    
    bfMasterRowPos = 0;
    DS_IO_MASTER.ClearData();
    
    var strStrCd      = LC_O_STR_CD.BindColVal;    
    var strStkYm      = EM_O_STK_YM.Text;
    var strDeptCd     = LC_O_DEPT_CD.BindColVal;
    var strTeamCd     = LC_O_TEAM_CD.BindColVal;
    var strPcCd       = LC_O_PC_CD.BindColVal;    
    var strPumbunCd   = nvl(EM_O_PUMBUN_CD.Text,    '000000');
    var strPumbunToCd = nvl(EM_O_PUMBUN_TO_CD.Text, '999999');
    
    var strStkDt      = EM_O_STK_DT.Text;
    
    var strStkYmSDt = strStkYm;
    strStkYmSDt += "01";
    var strStkYmBf = setDateAdd("M", -1, strStkYmSDt).substring(0, 6);
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                    +"&strStkYm="+encodeURIComponent(strStkYm)
                    +"&strStkYmBf="+encodeURIComponent(strStkYmBf)
                    +"&strStkYmSDt="+encodeURIComponent(strStkYmSDt)
                    +"&strStkDt="+encodeURIComponent(strStkDt)
                    +"&strDeptCd="+encodeURIComponent(strDeptCd)
                    +"&strTeamCd="+encodeURIComponent(strTeamCd)
                    +"&strPcCd="+encodeURIComponent(strPcCd)               
                    +"&strPumbunCd="+encodeURIComponent(strPumbunCd)
                    +"&strPumbunToCd="+encodeURIComponent(strPumbunToCd);   
    
    TR_MAIN.Action="/dps/pstk221.pt?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    //조회후 결과표시
    setPorcCount("SELECT", GD_MASTER);  
    
    if(DS_IO_MASTER.CountRow == 0){
    	DS_IO_DETAIL.ClearData();
    }   
}

/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.29
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
     
 }
/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.29
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {  
    
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.29
 * 개    요 : DB에 저장 / 수정 
 * return값 : void
*/
function btn_Save() {    
     
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.29
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

    if(DS_IO_MASTER.CountRow <= 0){
      showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
        return;
    }
    var strTitle = "실자재고현황(단품)";

    var strStrCd        = LC_O_STR_CD.text;    
    var strStkYm        = EM_O_STK_YM.Text;
    var strDeptCd       = LC_O_DEPT_CD.text;
    var strTeamCd       = LC_O_TEAM_CD.text;
    var strPcCd         = LC_O_PC_CD.text;    
    var strPumbunCd     = EM_O_PUMBUN_CD.Text;
    var strPumbunName   = EM_O_PUMBUN_NAME.Text;
    var strPumbunToCd   = EM_O_PUMBUN_TO_CD.Text;
    var strPumbunToName = EM_O_PUMBUN_TO_NAME.Text;
    var strStkDt        = EM_O_STK_DT.Text;
    var strStkFlag      = EM_O_STK_FLAG.Text;
    var strState        = EM_O_STATE.Text;
    
    var parameters = "점 "              + strStrCd
                   + "    실사년월 "     + strStkYm
                   + "    팀 "        + strDeptCd
                   + "    파트 "          + strTeamCd
                   + "    PC "         + strPcCd
                   + "    브랜드,명 "      + strPumbunCd
                   + " "                + strPumbunName
                   + " ~    브랜드,명"     + strPumbunToCd
                   + " "                + strPumbunToName
                   + "    재고실사일 "     + strStkDt
                   + "    재고실사구분 "   + strStkFlag
                   + "    상태 "          + strState;
    
    GD_DETAIL.GridToExcelExtProp("HideColumn") = "{currow}";       // GridToExcel 사용시 숨길 컬럼지정
    //openExcel2(GD_DETAIL, strTitle, parameters, true );
    openExcel5(GD_DETAIL, strTitle, parameters,true, "",g_strPid );
    
}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.29
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.29
 * 개    요 : 확정 처리
 * return값 : void
 */
function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 
 /**
  * searchDetail
  * 작 성 자 : 
  * 작 성 일 : 2010-04-29
  * 개    요 : 상세내역을 조회한다.
  * return값 : void
 **/
 function searchDetail() {

     var strStrCd     = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");
     var strStkYm     = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STK_YM");
     var strPumbunCd  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PUMBUN_CD");
     
     var strStkDt      = EM_O_STK_DT.Text;
     
     var strStkYmSDt = strStkYm;
     strStkYmSDt += "01";
     var strStkYmBf = setDateAdd("M", -1, strStkYmSDt).substring(0, 6); 

     DS_IO_DETAIL.ClearData();
         
     var goTo       = "searchDetail" ;    
     var action     = "O";
     var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                    + "&strStkYm="+encodeURIComponent(strStkYm)
                    +"&strStkYmBf="+encodeURIComponent(strStkYmBf)
                    +"&strStkYmSDt="+encodeURIComponent(strStkYmSDt)
                    +"&strStkDt="+encodeURIComponent(strStkDt)
                    + "&strPumbunCd="+encodeURIComponent(strPumbunCd);
     TR_SUB.Action="/dps/pstk221.pt?goTo="+goTo+parameters;  
     TR_SUB.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
     TR_SUB.Post();

     //조회후 결과표시
     setPorcCount("SELECT",GD_DETAIL);    
 }  
 
     
/**
  * setPumbunCdCombo()
  * 작 성 자 : 이재득
  * 작 성 일 : 2010.04.29
  * 개    요 : 브랜드POPUP를 조회한다.
  * return값 : void
  */
 function setPumbunCdSkuType(evnflag, fromto){
	 
     var strStrCd  = LC_O_STR_CD.BindColVal; 
     var strDeptCd  = LC_O_DEPT_CD.BindColVal;
     var strTeamCd = LC_O_TEAM_CD.BindColVal;  
     var strPcCd  = LC_O_PC_CD.BindColVal;
     var strCornerCd = "00";
     var codeObj = "";
     var nameObj = "";
     
     var strOrgCd = strStrCd+strDeptCd+strTeamCd+strPcCd+strCornerCd;
     
     if(LC_O_TEAM_CD.BindColVal == "%" || LC_O_PC_CD.BindColVal == "%")
         strOrgCd = "";
     
     if(fromto == "FROM"){
         var codeObj = EM_O_PUMBUN_CD;
         var nameObj = EM_O_PUMBUN_NAME;
     }else{
         var codeObj = EM_O_PUMBUN_TO_CD;
         var nameObj = EM_O_PUMBUN_TO_NAME;
     }  
      
     if(codeObj.Text == "" && evnflag != "POP" ){
         nameObj.Text = "";
         EM_O_STK_DT.Text = "";
         EM_O_STK_FLAG.Text = ""; 
         EM_O_STATE.Text = "";
         return;
     }         

     var result = null;

     if( evnflag == "POP" ){
         result = strPbnPop(codeObj,nameObj,'Y', '',strStrCd, strOrgCd,'','','','','1','','','','','');
          
     }else if( evnflag == "NAME" ){
         setStrPbnNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj,"Y", '1','',strStrCd, strOrgCd,'','','','','1','','','','','');
         //getPbnInf();
         strSkuType = DS_SEARCH_NM.NameValue(1, "SKU_TYPE");
     }

     if( result != null ){         
         //getPbnInf();
         strSkuType = result.get("SKU_TYPE");         
     }     
 } 
 
 /**
  * getPbnStk()
  * 작 성 자 : 
  * 작 성 일 : 
  * 개     요 : 브랜드에 따른 재고실사 조회
  * return값 : void
  */
 function getPbnStk() {
      var strStrCd       = LC_O_STR_CD.BindColVal;
      var strPumbunCd    = EM_O_PUMBUN_CD.Text;           
      var strStkYm       = EM_O_STK_YM.Text;              
      
      var goTo       = "searchPbnStk" ;    
      var action     = "O";     
      var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                      +"&strStkYm="+encodeURIComponent(strStkYm);
      
      TR_MAIN.Action="/dps/pstk221.pt?goTo="+goTo+parameters;  
      TR_MAIN.KeyValue="SERVLET("+action+":DS_O_PBNSTK=DS_O_PBNSTK)"; //조회는 O
      TR_MAIN.Post();     
      
      EM_O_STK_DT.Text = DS_O_PBNSTK.NameValue(1, "SRVY_DT");
      EM_O_STK_FLAG.Text = DS_O_PBNSTK.NameValue(1, "STK_FLAG_NAME"); 
      EM_O_STATE.Text = DS_O_PBNSTK.NameValue(1, "CLOSE_DT");
 }
 
 /**
  * getPbnInf()
  * 작 성 자 : 
  * 작 성 일 : 2010.04.29
  * 개     요 : 브랜드정보(조직/재고평가구분) 조회
  * return값 : void
  */
 function getPbnInf() {
      var strStrCd       = LC_O_STR_CD.BindColVal;
      var strPumbunCd    = EM_O_PUMBUN_CD.Text;       
      
      var goTo       = "searchPbnInf" ;    
      var action     = "O";     
      var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                      +"&strPumbunCd="+encodeURIComponent(strPumbunCd);
      
      TR_MAIN.Action="/dps/pstk221.pt?goTo="+goTo+parameters;  
      TR_MAIN.KeyValue="SERVLET("+action+":DS_O_PBNINF=DS_O_PBNINF)"; //조회는 O
      TR_MAIN.Post();    
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
<!--------------------- 3. Excelupload  --------------------------------------->

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_IO_MASTER
    event=OnDataError(row,colid)>
var colName = GD_MASTER.GetHdrDispName(-3, colid);
if( this.ErrorCode == "50018" ) {
    showMessage(STOPSIGN, OK, "GAUCE-1005", colName);
} else if ( this.ErrorCode == "50019") {
    showMessage(STOPSIGN, OK, "GAUCE-1007", row);
} else {
    showMessage(STOPSIGN, OK, "USER-1000", this.ErrorMsg);
}
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 적용기준일 -->
<script language=JavaScript for=EM_O_STK_YM event=onKillFocus()>
    if(!checkDateTypeYM(this))
        return;
    getPbnStk();
</script>

<!-- 브랜드코드 변경시 -->
<script language=JavaScript for=EM_O_PUMBUN_CD event=OnKillFocus()>   
    if(!this.Modified)
        return;    
    setPumbunCdSkuType("NAME", "FROM");
</script>

<!-- 브랜드코드 변경시 -->
<script language=JavaScript for=EM_O_PUMBUN_TO_CD event=OnKillFocus()>   
    if(!this.Modified)
        return;    
    setPumbunCdSkuType("NAME", "TO");
</script>

<script language=JavaScript for=LC_O_STR_CD event=OnSelChange>
    
    DS_O_DEPT_CD.ClearData();
    DS_O_TEAM_CD.ClearData();
    DS_O_PC_CD.ClearData();
    EM_O_PUMBUN_CD.Text = "";
    EM_O_PUMBUN_NAME.Text = "";
    EM_O_PUMBUN_TO_CD.Text = "";
    EM_O_PUMBUN_TO_NAME.Text = "";
    if (this.BindColVal == '%'){
        insComboData(LC_O_DEPT_CD, "%", "전체", 1);
        setComboData(LC_O_DEPT_CD, "%");
        return;     
    }
    
    getDept("DS_O_DEPT_CD", "Y", LC_O_STR_CD.BindColVal, "N");
    if(DS_O_DEPT_CD.CountRow < 1){
        insComboData(LC_O_DEPT_CD, "%", "전체", 1);       
    }
    LC_O_DEPT_CD.Index = 0;
    
    if (EM_O_STK_YM.Text != "" && EM_O_STK_YM.Text.length == 6){
        getPbnStk();
    }
</script>

<script language=JavaScript for=LC_O_DEPT_CD event=OnSelChange>
    
    DS_O_TEAM_CD.ClearData();
    DS_O_PC_CD.ClearData();
    EM_O_PUMBUN_CD.Text = "";
    EM_O_PUMBUN_NAME.Text = "";
    EM_O_PUMBUN_TO_CD.Text = "";
    EM_O_PUMBUN_TO_NAME.Text = "";
    if (this.BindColVal == '%'){
        insComboData(LC_O_TEAM_CD, "%", "전체", 1);
        setComboData(LC_O_TEAM_CD, "%");
        return;     
    }
    
    getTeam("DS_O_TEAM_CD", "Y", LC_O_STR_CD.BindColVal,
                LC_O_DEPT_CD.BindColVal, "Y");

    if(DS_O_TEAM_CD.CountRow < 1){
        insComboData(LC_O_TEAM_CD, "%", "전체", 1);       
    }
    LC_O_TEAM_CD.Index = 0;
</script>

<script language=JavaScript for=LC_O_TEAM_CD event=OnSelChange>
    
    DS_O_PC_CD.ClearData();
    EM_O_PUMBUN_CD.Text = "";
    EM_O_PUMBUN_NAME.Text = "";
    EM_O_PUMBUN_TO_CD.Text = "";
    EM_O_PUMBUN_TO_NAME.Text = "";
    if (this.BindColVal == '%'){
        insComboData(LC_O_PC_CD, "%", "전체", 1);
        setComboData(LC_O_PC_CD, "%");
        return;     
    }
    getPc("DS_O_PC_CD", "Y", LC_O_STR_CD.BindColVal,
                LC_O_DEPT_CD.BindColVal, LC_O_TEAM_CD.BindColVal, "Y");

    if(DS_O_PC_CD.CountRow < 1){
        insComboData(LC_O_PC_CD, "%", "전체", 1);       
    }
    LC_O_PC_CD.Index = 0;
</script>

<script language=JavaScript for=LC_O_PC_CD event=OnSelChange>
    EM_O_PUMBUN_CD.Text = "";
    EM_O_PUMBUN_NAME.Text = "";
    EM_O_PUMBUN_TO_CD.Text = "";
    EM_O_PUMBUN_TO_NAME.Text = "";
</script>

<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>
    if( row < 1 || bfMasterRowPos == row)
        return;
    bfMasterRowPos = row;
    searchDetail();
</script>

<!-- Grid Master oneClick event 처리 -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
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
<object id="DS_O_PUMBUN_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_PBNSTK" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_PBNINF" classid=<%= Util.CLSID_DATASET %>></object>
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

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_IO_MASTER" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_DETAIL" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_SEARCH_NM" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_DEPT_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_TEAM_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_PC_CD" classid=<%= Util.CLSID_DATASET %>></object>
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

<script language='javascript'>
window.onresize = function(){
	var obj   = document.getElementById("GD_DETAIL");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top2) {
    	grd_height = top2;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top2);
    }
    obj.style.height  = grd_height + "px";
    
    
}
</script>


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
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th class="point" width="80">점</th>
            <td width="165">
                 <comment id="_NSID_">
                    <object id=LC_O_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=165 tabindex=1 align="absmiddle">
                    </object>
                </comment><script>_ws_(_NSID_);</script>
            </td>
            <th class="point" width="80">팀</th>
            <td width="165"><comment id="_NSID_"> <object id=LC_O_DEPT_CD
                classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165 tabindex=1
                align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
            <th width="80">파트</th>
            <td><comment id="_NSID_"> <object id=LC_O_TEAM_CD
                classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165 tabindex=1
                align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td> 
          </tr>
          <tr>
            <th width="80">PC</th>
            <td><comment id="_NSID_"> <object id=LC_O_PC_CD
                classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165 tabindex=1
                align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
            <th class="point" width="80">실사년월</th>
            <td colspan=3>
                <comment id="_NSID_">
                      <object id=EM_O_STK_YM classid=<%=Util.CLSID_EMEDIT%>  width=138 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/date.gif" class="PR03" onclick="javascript:openCal('M',EM_O_STK_YM)" align="absmiddle" /></td>                      
          </tr>
          <tr>
            <th width="80">브랜드</th>
            <td colspan=5>
                <comment id="_NSID_">
                      <object id=EM_O_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%>  width=60 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03" onclick="javascript: setPumbunCdSkuType('POP', 'FROM')" align="absmiddle" />
                <comment id="_NSID_">
                      <object id=EM_O_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%>  width=255 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script> ~
                <comment id="_NSID_">
                      <object id=EM_O_PUMBUN_TO_CD classid=<%=Util.CLSID_EMEDIT%>  width=60 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03" onclick="javascript: setPumbunCdSkuType('POP', 'TO')" align="absmiddle" />
                <comment id="_NSID_">
                      <object id=EM_O_PUMBUN_TO_NAME classid=<%=Util.CLSID_EMEDIT%>  width=260 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>                
            </td>
          </tr>
          <tr>
            <th width="80">재고조사일</th>
            <td width="165">
                <comment id="_NSID_">
                    <object id=EM_O_STK_DT classid=<%=Util.CLSID_EMEDIT%>  width=165 tabindex=1>
                    </object>
                </comment><script> _ws_(_NSID_);</script>
            </td>
            <th width="80">재고실사구분</th>
            <td width="165">
                <comment id="_NSID_">
                    <object id=EM_O_STK_FLAG classid=<%=Util.CLSID_EMEDIT%>  width=165 tabindex=1>
                    </object>
                </comment><script> _ws_(_NSID_);</script>
            </td>
            <th width="80">상태</th>
            <td>
                <comment id="_NSID_">
                    <object id=EM_O_STATE classid=<%=Util.CLSID_EMEDIT%>  width=165 tabindex=1>
                    </object>
                </comment><script> _ws_(_NSID_);</script>
            </td>
          </tr> 
      </table></td>
    </tr>
<tr>
    <td class="dot"></td>
  </tr>
  <tr>
     <td class="PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
            <tr>
                <td>
                    <comment id="_NSID_">
                        <OBJECT id=GD_MASTER width=100% height=250 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID" value="DS_IO_MASTER">
                            <Param Name="ViewSummary"   value="1" >
                        </OBJECT>
                    </comment><script>_ws_(_NSID_);</script>
                </td>
            </tr>
        </table>
     </td>
  </tr> 
  <tr>
    <td class="dot"></td>
  </tr>
  <tr>
     <td class="PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
            <tr>
                <td>
                    <comment id="_NSID_">
                        <OBJECT id=GD_DETAIL width=100% height=222 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID" value="DS_IO_DETAIL">
                        </OBJECT>
                    </comment><script>_ws_(_NSID_);</script>
                </td>
            </tr>
        </table>
     </td>
  </tr>  
</table>
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>

