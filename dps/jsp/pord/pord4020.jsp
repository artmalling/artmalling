<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 발주결재 > 기간별매입현황집계표
 * 작 성 일 : 2010.04.15
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : pord4020.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 기간별매입현황집계표  
 * 이    력 :
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

var strToday            = "";  // 현재날짜

var g_disPlayStrNM      = "";
var g_disPlayBuMunNM    = "";
var g_disPlayTeamNM     = "";
var g_disPlayPcNM       = "";
var g_disPlayBizTypeNM  = "";
var g_disPlaySlipFlagNM = "";
var g_disPlayPumbunCD   = "";
var g_disPlayPumbunNM   = "";



var g_strStrCd      = "";
var g_strBumun      = "";
var g_strTeam       = "";
var g_strPc         = "";
var g_strOrgCd      = "";
var g_strStartDt    = "";
var g_strEndDt      = "";
var g_strSkuFlag1   = "";
var g_strSkuFlag2   = "";
var g_disPlayPcNM   = "";
var g_strSlipflag1  = "";
var g_strSlipflag2  = "";
var g_strSlipflag3  = "";
var g_strSlipflag4  = "";
var g_strSlipflag5  = "";
var g_strSlipflag6  = "";
var g_strSlipflag7  = "";


/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-09
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top  = 145;		//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID

 function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GR_MASTER"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	 
     // Input  Data Set Header 초기화
     
     strToday        = getTodayDB("DS_O_RESULT")
     // Output Data Set Header 초기화
     DS_LIST.setDataHeader('<gauce:dataset name="H_LIST"/>');
     
     DS_O_TEAM.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
     DS_O_PC.setDataHeader('CODE:STRING(2),NAME:STRING(40)'); 
     
     // 그리드 초기화
     gridCreate1(); //마스터
     
     // EMedit에 초기화
     initEmEdit(RD_S_BUY_FLAG,        "GEN",      NORMAL);      //발행구분     
     initEmEdit(EM_S_START_DT,       "SYYYYMMDD", PK);          //조회용 시작일
     initEmEdit(EM_S_END_DT,         "TODAY",     PK);          //조회용 종료일

     initEmEdit(EM_S_PUMBUN_CD,        "GEN",       NORMAL);      //브랜드코드     
     initEmEdit(EM_S_PUMBUN_NM,        "GEN",       READ);        //브랜드명     
     
     //콤보 초기화
     initComboStyle(LC_O_STR,    DS_STR,           "CODE^0^30,NAME^0^80", 1, PK);              //조회용 점코드     
     initComboStyle(LC_O_BUMUN,  DS_O_DEPT,        "CODE^0^30,NAME^0^80", 1, NORMAL);          //조회용 팀     
     initComboStyle(LC_O_TEAM,   DS_O_TEAM,        "CODE^0^30,NAME^0^80", 1, NORMAL);          //조회용 파트     
     initComboStyle(LC_O_PC,     DS_O_PC,          "CODE^0^30,NAME^0^80", 1, NORMAL);          //조회용 PC      

     getStore("DS_STR", "Y", "", "N");                                                          // 점        
     getEtcCode("DS_O_GJDATE_TYPE", "D", "P214", "N");       // 기준일

     LC_O_STR.Index      = 0; 
     LC_O_BUMUN.Index    = 0;
     LC_O_TEAM.Index     = 0;
     LC_O_PC.Index       = 0;  
     LC_O_STR.Focus();
     CHK_1.checked       = true;
   
     registerUsingDataset("pord402","DS_LIST");
 } 
 
  
 function gridCreate1(){
     var hdrProperies = '<FC>id={currow}           name="NO"          width=30     edit=none align=center  sumtext="" SubBgColor={decode(curlevel,1,"#FFFFE0")}</FC>'
                      + '<FC>id=STR_CD             name="점코드"      width=65     edit=none align=left show=false</FC>'
                      + '<FC>id=STR_NM             name="점"          width=60     edit=none align=left  show=false</FC>'
                      + '<FC>id=VEN_CD             name="협력사코드"  width=80     edit=none align=left suppress="1" SubSumText="협력사소계" SubBgColor={decode(curlevel,1,"#FFFFE0")}</FC>'
                      + '<FC>id=VEN_NM             name="협력사"      width=130    edit=none align=left suppress="1" SubBgColor={decode(curlevel,1,"#FFFFE0")}</FC>'
                      + '<FC>id=PUMBUN_CD          name="브랜드코드"    width=70     edit=none align=center SubBgColor={decode(curlevel,1,"#FFFFE0")}</FC>'
                      + '<FC>id=PUMBUN_NM          name="브랜드"        width=130     edit=none align=left  SubBgColor={decode(curlevel,1,"#FFFFE0")}</FC>'
                      + '<FC>id=SALE_ORG_BM        name="팀코드"    width=80     edit=none align=center show=false</FC>'
                      + '<FC>id=SALE_ORG_BM_NM     name="팀명"      width=80     edit=none align=left SubBgColor={decode(curlevel,1,"#FFFFE0")}</FC>'
                      + '<FC>id=SALE_ORG_TEAM      name="파트코드"      width=80     edit=none align=center show=false</FC>'
                      + '<FC>id=SALE_ORG_TEAM_NM   name="파트명"      width=80    edit=none align=left SubBgColor={decode(curlevel,1,"#FFFFE0")}</FC>'
                      + '<FC>id=SALE_ORG_PC        name="PC코드"      width=80     edit=none align=center show=false</FC>'
                      + '<FC>id=SALE_ORG_PC_NM     name="PC명"        width=80    edit=none align=left SubBgColor={decode(curlevel,1,"#FFFFE0")}</FC>'
                      + '<FC>id=EVENT_CD           name="마진코드"    width=65     edit=none align=center SubSumText= "" SubBgColor={decode(curlevel,1,"#FFFFE0")}</FC>'
                      + '<FC>id=MG_RATE            name="마진율"      width=60     edit=none align=right SubSumText= "" SubBgColor={decode(curlevel,1,"#FFFFE0")}</FC>'
                      + '<FC>id=CHK_QTY            name="수량"        width=80     edit=none align=right  sumtext={subsum(CHK_QTY)} SubBgColor={decode(curlevel,1,"#FFFFE0")}</FC>'
                      + '<FG> name="원가금액"'
                      + '<FC>id=CHK_COST_TAMT      name="공급가"      width=120     edit=none align=right  sumtext={subsum(CHK_COST_TAMT)} SubBgColor={decode(curlevel,1,"#FFFFE0")}</FC>'
                      + '<FC>id=VAT_AMT            name="부가세"      width=110     edit=none align=right  sumtext={subsum(VAT_AMT)} SubBgColor={decode(curlevel,1,"#FFFFE0")}</FC>'
                      + '<FC>id=TOT_AMT            name="합계"        width=120     edit=none align=right  sumtext={subsum(TOT_AMT)} SubBgColor={decode(curlevel,1,"#FFFFE0")}</FC>'
                      + '</FG>'
                      + '<FC>id=OLD_SALE_TAMT      name="구매가계"    width=120    edit=none align=right show=false</FC>'
                      + '<FC>id=CHK_SALE_TAMT      name="매가계"      width=120     edit=none align=righ sumtext={subsum(CHK_SALE_TAMT)} SubBgColor={decode(curlevel,1,"#FFFFE0")}</FC>'
                      + '<FC>id=level              name=레벨                          Value={curlevel}    width=50 show=false</FC>';

     initGridStyle(GR_MASTER, "common", hdrProperies, true);     

     GR_MASTER.ViewSummary = "1";
     DS_LIST.SubSumExpr  = "1:VEN_CD"
     GR_MASTER.ColumnProp("PUMBUN_CD", "sumtext")           = "합계";  
     

//     DS_LIST.SubSumExpr  = "SALE_ORG_CD"; 
//     DS_LIST.SubSumExpr  = "PUMBUN_CD"; 
//     GR_MASTER.ColumnProp("STR_NM", "SubSumText")        = "소계";  
     
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
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-10
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    
     if(checkValidation("Search")){
         getList();
         // 조회결과 Return
         setPorcCount("SELECT", GR_MASTER);
         if(DS_LIST.CountRow <= 0)
            LC_O_STR.Focus();
     }
}

/**
 * btn_New()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-10
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {  
    
}

/**
 * btn_Delete()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-10
 * 개    요    : 삭제버튼 클릭 (신규등록일 경우 DS_IO_MASTER 삭제, 기존데이터일 경우 삭제 Action실행)
 * return값 : void
 */
function btn_Delete() {
    
}

/**
 * btn_Save()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {    
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
	if(DS_LIST.CountRow	<= 0){
		  showMessage(INFORMATION, OK, "USER-1000","다운 할	내용이 없습니다. 조회 후 엑셀다운 하십시오.");
			return;
		}
		var	strTitle = "기간별매입현황집계표";
/*
		var	strStrCd		= LC_STR_CD.Text;			//점
		var	strLevelCd		= LC_LEVEL_CD.Text;			//팀
		var	strSaleDtS		= EM_SALE_DT_S.text;		//시작년월
		var	strSaleDtE		= EM_SALE_DT_E.text;		//종료년월

		var	strCmprDtS1		 = EM_CMPR_DT_S1.text;		//시작년월
		var	strCmprDtE1		 = EM_CMPR_DT_E1.text;		//종료년월
		var	strCmprDtS2		 = EM_CMPR_DT_S2.text;		//시작년월
		var	strCmprDtE2		 = EM_CMPR_DT_E2.text;		//종료년월
	
		var	parameters = "점 "			 + strStrCd
					   + " ,   레벨	"	  +	strLevelCd
					   + " ,   매출시작일자	"  + strSaleDtS
					   + " ,   매출종료일자	"  + strSaleDtE
					   + " ,   대비시작일자	"  + strCmprDtS1
					   + " ,   대비종료일자	"  + strCmprDtE1
					   + " ,   대비시작일자	"  + strCmprDtS2
					   + " ,   대비종료일자	"  + strCmprDtE2
					   + " ,   단위: 원, 명, %";
		*/
		var	parameters = "";
		
		
		GR_MASTER.GridToExcelExtProp("HideColumn") = "{currow}";	   // GridToExcel 사용시 숨길 컬럼지정
		//openExcel2(GR_MASTER, strTitle,	parameters,	true );
		openExcel5(GR_MASTER, strTitle,	parameters,	true , "",g_strPid );

		
}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
    if(DS_LIST.CountRow == 0){
        showMessage(EXCLAMATION, OK, "USER-1210");
        return;
    }
  
	var strOrgFlag    = '<c:out value="${sessionScope.sessionInfo.ORG_FLAG}" />';
	var strUserId     = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';

    parameters  = "&strOrgFlag="+strOrgFlag
                + "&strStrCd="+g_strStrCd     
                + "&strBumun="+g_strBumun     
                + "&strTeam="+g_strTeam      
                + "&strPc="+g_strPc          
                + "&strStartDt="+g_strStartDt 
                + "&strEndDt="+g_strEndDt         
                + "&strUserId="+strUserId             
                + "&strSkuFlag1="+g_strSkuFlag1    
                + "&strSkuFlag2="+g_strSkuFlag2    
                + "&strSlipflag1="+g_strSlipflag1
                + "&strSlipflag2="+g_strSlipflag2
                + "&strSlipflag3="+g_strSlipflag3
                + "&strSlipflag4="+g_strSlipflag4
                + "&strSlipflag5="+g_strSlipflag5
                + "&strSlipflag6="+g_strSlipflag6
                + "&strSlipflag7="+g_strSlipflag7 
                + "&disPlayStrNM="+encodeURIComponent(g_disPlayStrNM)  
                + "&disPlayBuMunNM="+encodeURIComponent(g_disPlayBuMunNM)
                + "&disPlayTeamNM="+encodeURIComponent(g_disPlayTeamNM)
                + "&disPlayPcNM="+encodeURIComponent(g_disPlayPcNM)
                + "&disPlayBizTypeNM="+encodeURIComponent(g_disPlayBizTypeNM)
                + "&disPlaySlipFlagNM="+encodeURIComponent(g_disPlaySlipFlagNM)
                + "&disPlayPumbunCD="+encodeURIComponent(g_disPlayPumbunCD)
                + "&disPlayPumbunNM="+encodeURIComponent(g_disPlayPumbunNM);;

    window.open("/dps/pord402.po?goTo=print"+parameters,"OZREPORT", 1000, 700);
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
 * getList()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-15
 * 개    요 :  마스터 리스트 조회
 * return값 : void
 */
 function getList(){
	 
	 // 출력할때 조회조건은 조회를 누르는 시점의 조회조건으로 셋팅한다.
	 setOutPutValue();	    

//    setEventFlagDs();  //행사구분 행사율 데이터셋 복사
    // 조회조건 셋팅
    var strStrCd         = LC_O_STR.BindColVal;        //점
    var strBumun         = LC_O_BUMUN.BindColVal;      //팀
    var strTeam          = LC_O_TEAM.BindColVal;       //파트
    var strPc            = LC_O_PC.BindColVal;    
    var strOrgCd         = strStrCd + strBumun + strTeam + strPc; // 조직//PC
    var strStartDt       = EM_S_START_DT.Text;         //시작일
    var strEndDt         = EM_S_END_DT.Text;           //종료일
    var strPumbunCd      = EM_S_PUMBUN_CD.Text;         //시작일

    var strSkuFlag1      = "";  //단품     (직매입)
    var strSkuFlag2      = "";  //비단품(특정)
    
    var strSlipflag1     = "";    
    var strSlipflag2     = "";    
    var strSlipflag3     = "";    
    var strSlipflag4     = "";    
    var strSlipflag5     = "";    
    var strSlipflag6     = "";   
    var strSlipflag7     = "";    
    
    //거래형태 구분에 따른 변수 셋팅
    if(RD_S_BUY_FLAG.CodeValue == 1){   //전체
        strSkuFlag1 = '1';
        strSkuFlag2 = '2';        
    }    
    if(RD_S_BUY_FLAG.CodeValue == 2){
        strSkuFlag1 = '1';
        
    }
    if(RD_S_BUY_FLAG.CodeValue == 3){
        strSkuFlag2 = '2';
    }
    
    
    
    //전표 구분에 따른 변수 값 셋팅
    if(CHK_1.checked == true){  //전체
        strSlipflag1 = 'A';
        strSlipflag2 = 'B';
        strSlipflag3 = 'C';
        strSlipflag4 = 'D';
        strSlipflag5 = 'E';
        strSlipflag6 = 'F';
        strSlipflag7 = 'G';
        
    }else{        
        if(CHK_2.checked == true){
            strSlipflag1 = 'A';          
        }
        
        if(CHK_3.checked == true){
            strSlipflag2 = 'B';              
        }
        
        if(CHK_4.checked == true){
            strSlipflag3 = 'C'; 
            strSlipflag4 = 'D';         
        }
        
        if(CHK_5.checked == true){
            strSlipflag5 = 'E'; 
            strSlipflag6 = 'F';             
        }
        
        if(CHK_6.checked == true){
            strSlipflag7 = 'G';
        }
    }
    
    var goTo        = "getList" ;    
    var action      = "O";     
    var parameters  = "&strStrCd="+encodeURIComponent(strStrCd)     
                    + "&strBumun="+encodeURIComponent(strBumun)     
                    + "&strTeam="+encodeURIComponent(strTeam)      
                    + "&strPc="+encodeURIComponent(strPc)        
                    + "&strOrgCd="+encodeURIComponent(strOrgCd)          
                    + "&strStartDt="+encodeURIComponent(strStartDt)    
                    + "&strEndDt="+encodeURIComponent(strEndDt)    
                    + "&strSkuFlag1="+encodeURIComponent(strSkuFlag1)    
                    + "&strSkuFlag2="+encodeURIComponent(strSkuFlag2)    
                    + "&strSlipflag1="+encodeURIComponent(strSlipflag1)
                    + "&strSlipflag2="+encodeURIComponent(strSlipflag2)
                    + "&strSlipflag3="+encodeURIComponent(strSlipflag3)
                    + "&strSlipflag4="+encodeURIComponent(strSlipflag4)
                    + "&strSlipflag5="+encodeURIComponent(strSlipflag5)
                    + "&strSlipflag6="+encodeURIComponent(strSlipflag6)
                    + "&strSlipflag7="+encodeURIComponent(strSlipflag7)
                    + "&strPumbunCd="+encodeURIComponent(strPumbunCd); 
    
    TR_L_MAIN.Action="/dps/pord402.po?goTo="+goTo+parameters;  
    TR_L_MAIN.KeyValue="SERVLET("+action+":DS_LIST=DS_LIST)"; //조회는 O
    TR_L_MAIN.Post();        

    g_strStrCd         = strStrCd;
    g_strBumun         = strBumun;
    g_strTeam          = strTeam;
    g_strPc            = strPc;
    g_strOrgCd         = strOrgCd;
    g_strStartDt       = strStartDt;
    g_strEndDt         = strEndDt;
    g_strSkuFlag1      = strSkuFlag1;
    g_strSkuFlag2      = strSkuFlag2;    
    g_strSlipflag1     = strSlipflag1;
    g_strSlipflag2     = strSlipflag2;
    g_strSlipflag3     = strSlipflag3;
    g_strSlipflag4     = strSlipflag4;
    g_strSlipflag5     = strSlipflag5;
    g_strSlipflag6     = strSlipflag6;
    g_strSlipflag7     = strSlipflag7;
 } 
 
 /**
  * checkSlipFlag()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-04-08
  * 개    요 :  전표구분 선택시 체크 
  * return값 : 조회조건 문자열로 리턴
  */
 function checkSlipFlag (checkId){
      
     if(checkId == CHK_1){
         CHK_1.checked = true;
         CHK_2.checked = false;
         CHK_3.checked = false;
         CHK_4.checked = false;
         CHK_5.checked = false;
         CHK_6.checked = false;
     }else{
         CHK_1.checked = false;
     }
 }

/**
 * checkValidation(Gubun)
 * 작 성 자     : 박래형
 * 작 성 일     : 2010-02-28
 * 개    요        : 조회조건 값 체크 
 * Gubun : Search, Save, Delete
 * return값 : void
 */
function checkValidation(Gubun) {
     
     var messageCode = "USER-1001";

     switch (Gubun) {
     case "Search": 
         if(LC_O_STR.Text.length == 0){                                         // 점
               showMessage(EXCLAMATION, OK, messageCode, "점");
               LC_O_STR.Focus();
               return false;
         }  
         /*
         if(LC_O_BUMUN.Text.length == 0){                                       // 팀
             showMessage(EXCLAMATION, OK, messageCode, "팀");
             LC_O_BUMUN.Focus();
             return false;
         }  
         if(LC_O_TEAM.Text.length == 0){                                        // 파트
             showMessage(EXCLAMATION, OK, messageCode, "파트");
             LC_O_TEAM.Focus();
             return false;
         }  
         if(LC_O_PC.Text.length == 0){                                          // PC
             showMessage(EXCLAMATION, OK, messageCode, "PC");
             LC_O_PC.Focus();
             return false;
         }  
         */
         if(EM_S_START_DT.Text.length == 0){                                    // 조회일 정합성
             showMessage(EXCLAMATION, OK, "USER-1002", "조회시작일");
             EM_S_START_DT.Focus();
             return false;
        }

         if(EM_S_START_DT.Text > EM_S_END_DT.Text){                             // 조회일 정합성
             showMessage(EXCLAMATION, OK, "USER-1015");
             EM_S_START_DT.Focus();
             return false;
         }
         return true; 
         return true; 
     }     
}

/**
 * setOutPutValue(Gubun)
 * 작 성 자     : 박래형
 * 작 성 일     : 2010-07-22
 * 개    요        : 조회를 누르는 시점에서 출력할 데이터의 조회조건을 넘긴다.
 * return값 : void
 */
function setOutPutValue() {
    // 조회조건 명 (장표에서 화면구성)    
    var disPlayStrNM      = LC_O_STR.Text;             // 점명
    var disPlayBuMunNM    = LC_O_BUMUN.Text;           // 팀명
    var disPlayTeamNM     = LC_O_TEAM.Text;            // 파트명
    var disPlayPcNM       = LC_O_PC.Text;              // PC명    
    var disPlayBizTypeNM  = "";                        // 거래형태명
    var disPlaySlipFlagNM = "";                        // 전표구분명A
    var disPlayPumbunCD   = EM_S_PUMBUN_CD.Text;       // 브랜드코드
    var disPlayPumbunNM   = EM_S_PUMBUN_NM.Text;       // 브랜드명
    
    //거래형태 구분에 따른 거래형태명 셋팅
    if(RD_S_BUY_FLAG.CodeValue == 1){   //전체
        disPlayBizTypeNM = "직매입, 특정"        
    }    
    if(RD_S_BUY_FLAG.CodeValue == 2){
        disPlayBizTypeNM = "직매입"   
    }
    if(RD_S_BUY_FLAG.CodeValue == 3){
        disPlayBizTypeNM = "특정"   
    }   
    
    //전표 구분에 따른 전표구분명셋팅
    if(CHK_1.checked){
        disPlaySlipFlagNM += "매입, 반품, 대출입, 점출입, 매가인상하";
    }else{      
        if(CHK_2.checked){
            disPlaySlipFlagNM += "매입, " ;
        }         
        if(CHK_3.checked){
            disPlaySlipFlagNM += "반품, " ;             
        }        
        if(CHK_4.checked){
            disPlaySlipFlagNM += "대출입, " ;             
        }        
        if(CHK_5.checked){
            disPlaySlipFlagNM += "점출입, " ;             
        }                 
        if(CHK_6.checked){
            disPlaySlipFlagNM += "매가인상하, " ;             
        }
        disPlaySlipFlagNM = disPlaySlipFlagNM.substring(0, disPlaySlipFlagNM.length-2);
    }
    
    g_disPlayStrNM       = disPlayStrNM;
    g_disPlayBuMunNM     = disPlayBuMunNM;    
    g_disPlayTeamNM      = disPlayTeamNM;      
    g_disPlayPcNM        = disPlayPcNM;       
    g_disPlayBizTypeNM   = disPlayBizTypeNM;  
    g_disPlaySlipFlagNM  = disPlaySlipFlagNM; 
    g_disPlayPumbunCD    = disPlayPumbunCD;  
    g_disPlayPumbunNM    = disPlayPumbunNM; 
}


/**
 * searchPumbunPop()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-03-18
 * 개    요 :  조회조건 브랜드팝업
 * return값 : void
 */
 function searchPumbunPop(){
     
     var tmpOrgCd        = LC_O_STR.BindColVal + LC_O_BUMUN.BindColVal + LC_O_TEAM.BindColVal + LC_O_PC.BindColVal;
     var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
     var strStrCd        = LC_O_STR.BindColVal;                                       // 점
     var strOrgCd        = replaceStr(tmpOrgCd,"%","00")+"00";                        // 조직코드
     var strVenCd        = "";                                                        // 협력사
     var strBuyerCd      = "";                                                        // 바이어
     var strPumbunType   = "";                                                        // 브랜드유형
     var strUseYn        = "Y";                                                       // 사용여부
     var strSkuFlag      = "";                                                        // 단품구분(2:비단품)
     var strSkuType      = "";                                                        // 단품종류(1:규격단품)
     var strItgOrdFlag   = "";                                                        // 통합발주여부
     var strBizType      = "";                                                        // 거래형태(1:직매입) 
     var strSaleBuyFlag  = "";                                                        // 판매분매입구분

     var rtnMap = strPbnPop( EM_S_PUMBUN_CD, EM_S_PUMBUN_NM, 'Y'
                            , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                            , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                            , strBizType,strSaleBuyFlag);
     if(rtnMap != null){
         return true;
     }else{
         return false;
     }
 }

 /**
  * searchPumbunNonPop()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-18
  * 개    요 :  조회조건 브랜드팝업
  * return값 : void
  */
  function searchPumbunNonPop(){
         
      var tmpOrgCd        = LC_O_STR.BindColVal + LC_O_BUMUN.BindColVal + LC_O_TEAM.BindColVal + LC_O_PC.BindColVal;
      var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
      var strStrCd        = LC_O_STR.BindColVal;                                       // 점
      var strOrgCd        = replaceStr(tmpOrgCd,"%","00")+"00";                        // 조직코드
      var strVenCd        = "";                                                        // 협력사
      var strBuyerCd      = "";                                                        // 바이어
      var strPumbunType   = "";                                                       // 브랜드유형
      var strUseYn        = "Y";                                                       // 사용여부
      var strSkuFlag      = "";                                                        // 단품구분(2:비단품)
      var strSkuType      = "";                                                        // 단품종류(1:규격단품)
      var strItgOrdFlag   = "";                                                        // 통합발주여부
      var strBizType      = "";                                                        // 거래형태(1:직매입) 
      var strSaleBuyFlag  = "";                                                        // 판매분매입구분


      var rtnMap = setStrPbnNmWithoutPop( "DS_O_RESULT", EM_S_PUMBUN_CD, EM_S_PUMBUN_NM, "Y", "1"
                             , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                             , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                             , strBizType,strSaleBuyFlag);           

      if(rtnMap != null){
          return true;
      }else{
          return false;
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
        showMessage(EXCLAMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<script language=JavaScript for=TR_S_MAIN event=onSuccess>
    for(i=0;i<TR_S_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(EXCLAMATION, OK, "USER-1000", TR_S_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_S_MAIN event=onFail>
    trFailed(TR_S_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--  ===================DS_IO_MASTER============================ -->
<!-- Grid DS_IO_MASTER 변경시 DS_LIST의 마스터 내용 변경 -->

<!--  ===================DS_IO_MASTER============================ -->

<script language=JavaScript for=DS_LIST event=CanRowPosChange(row)>

</script>

<script language=JavaScript for=DS_LIST event=onRowPosChanged(row)>

</script>

<script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(row)>
</script>
<script language=JavaScript for=DS_IO_MASTER event=onRowPosChanged(row)>
</script>

<script language=JavaScript for=DS_IO_MASTER
    event=OnColumnChanged(row,colid)>

</script>
<!--  ===================DS_LIST============================ -->
<!--  DS_LIST 변경시 -->
<script language=JavaScript for=DS_LIST
    event=OnColumnChanged(row,colid)>

</script>

<!-- 디테일 삭제시 컴퍼넌트 총금액-->
<script language=JavaScript for=DS_LIST event=OnRowDeleted(row)>   
 
</script>


<!-- GR_MASTER CanColumnPosChange(Row,Colid) event 처리 -->
<script language="javascript"  for=GR_MASTER event=CanColumnPosChange(Row,Colid)>

</script>

<!-- 디테일 선택시 전체 선택/해제 -->
<script language=JavaScript for=GR_MASTER
    event="OnHeadCheckClick(Col,Colid,bCheck)">       
    if (Colid == "CHECK1") {
        if (bCheck == 1) {
            GR_MASTER.Redraw = false;
            for (var i = 0; i < DS_LIST.CountRow; i++)
            {
                DS_LIST.NameValue(i + 1, "CHECK1") = "T";
            }    
            GR_MASTER.Redraw = true;
        }
        else if (bCheck == 0) {
            GR_MASTER.Redraw = false;
            for (var i = 0; i < DS_LIST.CountRow; i++)
            {
                DS_LIST.NameValue(i + 1, "CHECK1") = "F";
            } 
            GR_MASTER.Redraw = true;
            DS_LIST.ResetStatus();
        }
    }
</script>

<!--  ===================GR_MASTER============================ -->
<!-- Grid Master oneClick event 처리 -->

<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid); 
</script>



<!--*************************************************************************-->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 점(조회)  변경시  -->
<script language=JavaScript for=LC_O_STR event=OnSelChange()>
    if(LC_O_STR.BindColVal != "%"){
        getDept("DS_O_DEPT", "Y", LC_O_STR.BindColVal, "Y");                                              // 팀 
        LC_O_BUMUN.Index = 0;
    }
</script>

<!-- 팀(조회)  변경시  -->
<script language=JavaScript for=LC_O_BUMUN event=OnSelChange()>
    if(LC_O_BUMUN.BindColVal != "%"){
        getTeam("DS_O_TEAM", "Y", LC_O_STR.BindColVal, LC_O_BUMUN.BindColVal, "Y");                       // 파트  
    }else{
        DS_O_TEAM.ClearData();
        insComboData( LC_O_TEAM, "%", "전체",1);
        DS_O_PC.ClearData();
        insComboData( LC_O_PC, "%", "전체",1);
    }
    LC_O_TEAM.Index = 0;
</script>

<!-- 파트(조회)  변경시  -->
<script language=JavaScript for=LC_O_TEAM event=OnSelChange()>
    if(LC_O_TEAM.BindColVal != "%"){
        getPc("DS_O_PC", "Y", LC_O_STR.BindColVal, LC_O_BUMUN.BindColVal, LC_O_TEAM.BindColVal, "Y");     // PC  
    }else{
        DS_O_PC.ClearData();
        insComboData( LC_O_PC, "%", "전체",1);
    }
    LC_O_PC.Index = 0;
</script>




<!-- 조회시작일 변경시  -->
<script lanaguage=JavaScript for=EM_S_START_DT event=OnKillFocus()>
//    checkDateTypeYMD( EM_S_START_DT );
    var strSyyyymmdd = strToday.substring(0,6) + "01";
    checkDateTypeYMD( EM_S_START_DT, strSyyyymmdd );
</script>

<!-- 조회종료일 변경시  -->
<script lanaguage=JavaScript for=EM_S_END_DT event=OnKillFocus()>
    checkDateTypeYMD( EM_S_END_DT );
</script>


<!-- 조회부 브랜드 KillFocus -->
<script language=JavaScript for=EM_S_PUMBUN_CD event=onKillFocus()>

    if(EM_S_PUMBUN_CD.Text != ""){
        searchPumbunNonPop();
    }else
        EM_S_PUMBUN_NM.Text = "";  
</script>

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
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_DEPT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_TEAM" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_PC" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_GJDATE_TYPE" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_PROC_STAT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_STR" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_LIST" classid=<%=Util.CLSID_DATASET%>>
    <Param Name="SubsumExpr" VALUE="3:SALE_ORG_BM,2:SALE_ORG_TEAM,1:SALE_ORG_PC">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
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
<object id="TR_S_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_L_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>


<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->

<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GR_MASTER");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
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
                        <th class="point" width="70">점</th>
                        <td width="110"><comment id="_NSID_"> <object
                            id=LC_O_STR classid=<%=Util.CLSID_LUXECOMBO%> height=100
                            width=100 align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script>
                        </td>
                        <th width="70">팀</th>
                        <td width="110"><comment id="_NSID_"> <object
                            id=LC_O_BUMUN classid=<%=Util.CLSID_LUXECOMBO%> width=100
                            align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script></td>
                        <th width="70">파트</th>
                        <td width="110"><comment id="_NSID_"> <object
                            id=LC_O_TEAM classid=<%=Util.CLSID_LUXECOMBO%> width=100
                            align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script></td>
                        <th width="70">PC</th>
                        <td><comment id="_NSID_"> <object id=LC_O_PC
                            classid=<%=Util.CLSID_LUXECOMBO%> width=100 align="absmiddle" tabindex=1>
                        </object> </comment><script>_ws_(_NSID_);</script></td>
                    </tr>
                    <tr>
                        <th class="point">검품기간</th>
                        <td colspan="3"><comment id="_NSID_"> <object
                            id=EM_S_START_DT classid=<%=Util.CLSID_EMEDIT%> width=70
                            tabindex=1 align="absmiddle" tabindex=1> </object> </comment><script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/date.gif"
                            onclick="javascript:openCal('G',EM_S_START_DT)" align="absmiddle" />
                            ~
                            <comment id="_NSID_"> <object
                            id=EM_S_END_DT classid=<%=Util.CLSID_EMEDIT%> width=70
                            tabindex=1 align="absmiddle" tabindex=1> </object> </comment><script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/date.gif"
                            onclick="javascript:openCal('G',EM_S_END_DT)" align="absmiddle" />                       
                        </td>
                        <th>브랜드</th>
                        <td colspan="3">
                            <comment id="_NSID_">
                                  <object id=EM_S_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%>  width=90 tabindex=1 align="absmiddle">
                                  </object>
                            </comment><script> _ws_(_NSID_);</script>
                            <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_S_PUMBUN" class="PR03" align="absmiddle" onclick="javascript:searchPumbunPop();" />
                            <comment id="_NSID_">
                                  <object id=EM_S_PUMBUN_NM classid=<%=Util.CLSID_EMEDIT%>  width=153 tabindex=1 align="absmiddle">
                                  </object>
                            </comment><script> _ws_(_NSID_);</script>
                        </td>
                    </tr>
                    <tr>
                        <th class="point">거래형태</th>
                        <td colspan="2"><comment id="_NSID_"> <object
                            id=RD_S_BUY_FLAG classid=<%=Util.CLSID_RADIO%>
                            style="height: 20; width: 183" tabindex=1>
                            <param name=Cols value="3">
                            <param name=Format value="1^전체,2^직매입,3^특정">
                            <param name=CodeValue value="1">
                            <param name=AutoMargin  value="true">
                        </object> </comment> <script> _ws_(_NSID_);</script></td>
                        <th class="point">전표구분</th>
                        <td colspan="4">
                            <input type="checkbox" id=CHK_1 onclick="javascript:checkSlipFlag(CHK_1);">전체
                            <input type="checkbox" id=CHK_2 onclick="javascript:checkSlipFlag(CHK_2);">매입
                            <input type="checkbox" id=CHK_3 onclick="javascript:checkSlipFlag(CHK_3);">반품
                            <input type="checkbox" id=CHK_4 onclick="javascript:checkSlipFlag(CHK_4);">대출입
                            <input type="checkbox" id=CHK_5 onclick="javascript:checkSlipFlag(CHK_5);">점출입
                            <input type="checkbox" id=CHK_6 onclick="javascript:checkSlipFlag(CHK_6);">매가인상하                    
<!--        
                        <comment id="_NSID_">                 
                         <object
                            id=RD_S_SLIP_FLAG classid=<%=Util.CLSID_RADIO%>
                            style="height: 20; width: 700" tabindex=1>
                            <param name=Cols value="8">
                            <param name=Format value=" ^전체,A^매입,B^반품,C^대출,D^대입,E^점출,F^점입,G^매가인상하">
                            <param name=CodeValue value=" ">
                        </object> </comment> <script> _ws_(_NSID_);</script></td>
 -->                   
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
                        <td><comment id="_NSID_"> <OBJECT id=GR_MASTER
                            width=100% height=750 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID"     value="DS_LIST">
                        </OBJECT> </comment><script>_ws_(_NSID_);</script></td>
                    </tr>
                </table>
                </td>
            </tr>
        </table>
        </td>
    </tr>
</table>
</div>
<body>
</html>

