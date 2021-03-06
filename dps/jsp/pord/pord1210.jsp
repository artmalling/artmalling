<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 발주결재 > 자동전표 현황 조회
 * 작 성 일 : 2010.04.29
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : pord1210.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 자동전표 현황 조회
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
var strToday        = "";                            // 현재날짜

var intSearchCnt      = 0;                           // 조회버튼클릭 여부(0일 경우 마스터조회 건수)
var bfListRowPosition = 0;                           // 이전 List Row Position

var g_searchFlag    = 1;                             // 조회조건(구분)
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
 var top2 = 440;		//해당화면의 동적그리드top위치
 function doInit(){
//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GR_DETAIL1"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top2) + "px";

	 var obj   = document.getElementById("GR_DETAIL2"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top2) + "px";


	 
     strToday        = getTodayDB("DS_O_RESULT");
     // Output Data Set Header 초기화
     DS_MASTER.setDataHeader('<gauce:dataset name="H_LIST"/>');
     DS_DETAIL1.setDataHeader('<gauce:dataset name="H_DETAIL1"/>');
     DS_DETAIL2.setDataHeader('<gauce:dataset name="H_DETAIL2"/>');  
     DS_O_TEAM.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
     DS_O_PC.setDataHeader('CODE:STRING(2),NAME:STRING(40)'); 
          
     // 그리드 초기화
     gridCreate1(); //현황
     gridCreate2(); //세부사항1
     gridCreate3(); //세부사항2
     
     // EMedit에 초기화
     initEmEdit(EM_S_START_DT,     "SYYYYMMDD",  PK);            // 조회용 시작일
     initEmEdit(EM_S_END_DT,       "TODAY",      PK);            // 조회용 종료일
     initEmEdit(EM_S_PUMBUN_CD,    "000000",      NORMAL);       // 브랜드코드
     initEmEdit(EM_S_PUMBUN_NM,    "GEN",        READ);          // 브랜드명
     
     // 콤보 초기화
     initComboStyle(LC_O_STR,             DS_STR,                "CODE^0^30,NAME^0^140",  1, PK);       // 조회용 점코드     
     initComboStyle(LC_O_BUMUN,           DS_O_DEPT,             "CODE^0^30,NAME^0^80",  1, NORMAL);   // 조회용 팀     
     initComboStyle(LC_O_TEAM,            DS_O_TEAM,             "CODE^0^30,NAME^0^80",  1, NORMAL);   // 조회용 파트     
     initComboStyle(LC_O_PC,              DS_O_PC,               "CODE^0^30,NAME^0^80",  1, NORMAL);   // 조회용 PC
     initComboStyle(LC_O_AUTO_TRG_FLAG,   DS_O_AUTO_TRG_FLAG,    "CODE^0^20,NAME^0^140", 1, NORMAL);   // 자동전표구분   

     getStore("DS_STR", "Y", "", "N");                        // 점        
     getEtcCode("DS_O_GJDATE_TYPE",      "D", "P214", "N");   // 기준일
     getEtcCode("DS_O_ORG_FLAG",         "D", "P047", "N");   // 조직구분
     getEtcCode("DS_O_PROC_STAT",        "D", "P207", "Y");   // 전표상태         
     getEtcCode("DS_O_BIZ_TYPE",         "D", "P002", "N");   // 거래형태 
     getEtcCode("DS_O_TAX_FLAG",         "D", "P004", "N");   // 과세구분
     getEtcCode("DS_O_AUTO_TRG_FLAG",    "D", "P233", "Y");   // 자동전표구분
     getEtcCode("DS_AUTO_TRG_FLAG",      "D", "P233", "Y");   // 자동전표구분(그리드)

     LC_O_STR.Index            = 0; 
     LC_O_BUMUN.Index          = 0;
     LC_O_TEAM.Index           = 0;
     LC_O_PC.Index             = 0;   
     LC_O_AUTO_TRG_FLAG.Index = 0;
     
     registerUsingDataset("pord121","DS_MASTER,DS_DETAIL");
 } 
 
  
 function gridCreate1(){
     var hdrProperies = '<FC>id={currow}           name="NO"             width=45     edit=none align=center </FC>'
                      + '<FC>id=CHK_DT             name="발생일"         width=90     edit=none align=center mask="XXXX/XX/XX" sumtext="합계"</FC>'
                      + '<FC>id=AUTO_TRG_FLAG      name="구분"           width=110    edit=none align=left EditStyle=Lookup Data="DS_AUTO_TRG_FLAG:CODE:NAME" </FC>'
                      + '<FC>id=PUMBUN_CD          name="브랜드"           width=60     edit=none align=center </FC>'
                      + '<FC>id=PUMBUN_NM          name="브랜드명"          width=130    edit=none align=left </FC>'
                      + '<FC>id=VEN_CD             name="협력사"          width=60     edit=none align=center </FC>'
                      + '<FC>id=VEN_NM             name="협력사명"        width=130    edit=none align=left </FC>'
                      + '<FC>id=BIZ_TYPE           name="거래형태"        width=60     edit=none align=left EditStyle=Lookup Data="DS_O_BIZ_TYPE:CODE:NAME" </FC>'
                      + '<FC>id=TAX_FLAG           name="과세구분"        width=60     edit=none align=left EditStyle=Lookup Data="DS_O_TAX_FLAG:CODE:NAME" </FC>'
                      + '<FC>id=SALE_QTY           name="판매수량"       width=80    edit=none align=right  sumtext=@sum</FC>'
                      + '<FC>id=SAL_COST_AMT       name="판매원가금액"   width=120    edit=none align=right sumtext=@sum</FC>'
                      + '<FC>id=SALE_AMT           name="판매매가금액"   width=120    edit=none align=right  sumtext=@sum</FC>'
                      + '<FC>id=NORM_COST_AMT      name="정상원가금액"   width=120    edit=none align=right sumtext=@sum</FC>'
                      + '<FC>id=NORM_SALE_AMT      name="정상매가금액"   width=120   edit=none align=right sumtext=@sum</FC>'
                      + '<FC>id=SLIP_NO            name="전표번호(매입)"  width=110    edit=none align=center mask="XXXX-X-XXXXXXX"</FC>'
                      + '<FC>id=SLIP_NO_RFD        name="전표번호(반품)"  width=110    edit=none align=center mask="XXXX-X-XXXXXXX"</FC>'
                      + '<FC>id=REMARK             name="비고"            width=200    edit=none align=left </FC>';

     initGridStyle(GR_MASTER, "common", hdrProperies, false);
 }
 
  
 function gridCreate2(){
     var hdrProperies = '<FC>id={currow}           name="NO"            width=30    edit=none align=center</FC>'
    	              + '<FC>id=EVENT_CD           name="행사코드"       width=100    edit=none align=center  sumtext="합계"</FC>'
                      + '<FC>id=PUMMOK_CD          name="품목코드"       width=70    edit=none align=center </FC>'
                      + '<FC>id=PUMMOK_NM          name="품목명"         width=70    edit=none align=left </FC>'
                      + '<FC>id=SKU_CD             name="단품코드"       width=100    edit=none align=center </FC>'
                      + '<FC>id=SKU_NM             name="단품명"         width=100    edit=none align=left </FC>'
                      + '<FC>id=SALE_QTY           name="판매수량"       width=80    edit=none align=right  sumtext=@sum</FC>'
                      + '<FC>id=SAL_COST_PRC       name="판매원가"       width=80    edit=none align=right</FC>'
                      + '<FC>id=SAL_COST_AMT       name="판매원가금액"   width=80    edit=none align=right sumtext=@sum</FC>'
                      + '<FC>id=SALE_PRC           name="판매매가"       width=80    edit=none align=right </FC>'
                      + '<FC>id=SALE_AMT           name="판매매가금액"   width=80    edit=none align=right  sumtext=@sum</FC>'
                      + '<FC>id=MG_RATE            name="판매마진율"     width=80    edit=none align=right</FC>'
                      + '<FC>id=NORM_COST_PRC      name="정상원가"       width=93    edit=none align=right</FC>'
                      + '<FC>id=NORM_COST_AMT      name="정상원가금액"   width=93    edit=none align=right sumtext=@sum</FC>'
                      + '<FC>id=NORM_SALE_PRC      name="정상매가"       width=100   edit=none align=right</FC>'
                      + '<FC>id=NORM_SALE_AMT      name="정상매가금액"   width=100   edit=none align=right sumtext=@sum</FC>'
                      + '<FC>id=NORM_MG_RATE       name="정상마진율"     width=80    edit=none align=right</FC>'
                      + '<FC>id=REMARK             name="비고"           width=200   edit=none align=left</FC>';

     initGridStyle(GR_DETAIL1, "common", hdrProperies, false);
 }
 
 function gridCreate3(){
     var hdrProperies = '<FC>id={currow}           name="NO"            width=30    edit=none align=center</FC>'
                      + '<FC>id=SKU_CD             name="단품코드"       width=100    edit=none align=centert sumtext="합계"</FC>'
                      + '<FC>id=SKU_NM             name="단품명"         width=110   edit=none align=left </FC>'
                      + '<FC>id=SALE_QTY           name="수량"           width=50    edit=none align=right  sumtext=@sum</FC>'
                      + '<FG>  name ="구매가"'
                      + '<FC>id=BF_APP_S_DT        name="적용시작일"     width=90    edit=none align=center  mask="XXXX/XX/XX"</FC>'
                      + '<FC>id=BF_APP_E_DT        name="적용종료일"     width=90    edit=none align=center  mask="XXXX/XX/XX"</FC>'
                      + '<FC>id=BF_SALE_PRC        name="단가"           width=90    edit=none align=right </FC>'
                      + '<FC>id=BF_AMT             name="금액"           width=100    edit=none align=right sumtext=@sum</FC>'
                      + '</FG>'
                      + '<FG>  name ="신매가"'
                      + '<FC>id=AF_APP_S_DT        name="적용시작일"     width=90    edit=none align=center  mask="XXXX/XX/XX"</FC>'
                      + '<FC>id=AF_APP_E_DT        name="적용종료일"     width=90    edit=none align=center  mask="XXXX/XX/XX"</FC>'
                      + '<FC>id=AF_SALE_PRC        name="단가"           width=90   edit=none align=right</FC>'
                      + '<FC>id=AF_AMT             name="금액"           width=100    edit=none align=right sumtext=@sum</FC>'
                      + '</FG>';

     initGridStyle(GR_DETAIL2, "common", hdrProperies, false);
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
		intSearchCnt = 0;
		bfListRowPosition = 0;
		
		getList();
		setPorcCount("SELECT", GR_MASTER);
		
		if(DS_MASTER.CountRow <= 0)
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
 * getList()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-15
 * 개    요 :  마스터 리스트 조회
 * return값 : void
 */
 function getList(){
	 
	 if(LC_O_AUTO_TRG_FLAG.BindColVal == '%' || LC_O_AUTO_TRG_FLAG.BindColVal == '4'){  // 매가인상하(가격변경)
        document.getElementById("detail1").style.display ="none";
        document.getElementById("detail2").style.display ="";
     }else{
        document.getElementById("detail1").style.display ="";
        document.getElementById("detail2").style.display ="none";
     }
	 
	 if(LC_O_AUTO_TRG_FLAG.BindColVal == '%' || LC_O_AUTO_TRG_FLAG.BindColVal == '2' ){  // 반품재매입
		 GR_MASTER.ColumnProp("SLIP_NO","NAME") = "전표번호(매입)";
		 GR_MASTER.ColumnProp("SLIP_NO_RFD","SHOW") = true;
	 }else{
		 GR_MASTER.ColumnProp("SLIP_NO","NAME") = "전표번호";
		 GR_MASTER.ColumnProp("SLIP_NO_RFD","SHOW") = false;
	 }
	 
//    setEventFlagDs();  //행사구분 행사율 데이터셋 복사
    // 조회조건 셋팅
    var strStrCd        = LC_O_STR.BindColVal;        //점
    var strBumun        = LC_O_BUMUN.BindColVal;      //팀
    var strTeam         = LC_O_TEAM.BindColVal;       //파트
    var strPc           = LC_O_PC.BindColVal;    
    var strOrgCd        = strStrCd + strBumun + strTeam + strPc; // 조직//PC
    var strStartDt      = EM_S_START_DT.Text;         //시작일
    var strEndDt        = EM_S_END_DT.Text;           //종료일
    var strPumbunCd     = EM_S_PUMBUN_CD.Text;        //브랜드코드
    var strAutoTrgFlag  = LC_O_AUTO_TRG_FLAG.BindColVal;

    var goTo        = "getList" ;    
    var action      = "O";  
    var parameters  = "&strStrCd="+encodeURIComponent(strStrCd)   
                    + "&strBumun="+encodeURIComponent(strBumun)     
                    + "&strTeam="+encodeURIComponent(strTeam)      
                    + "&strPc="+encodeURIComponent(strPc)        
                    + "&strOrgCd="+encodeURIComponent(strOrgCd)        
                    + "&strStartDt="+encodeURIComponent(strStartDt)   
                    + "&strEndDt="+encodeURIComponent(strEndDt)   
                    + "&strPumbunCd="+encodeURIComponent(strPumbunCd)    
                    + "&strAutoTrgFlag="+encodeURIComponent(strAutoTrgFlag)                
    TR_MAIN.Action="/dps/pord121.po?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();  
//    getDetail();
 }
 
 /**
  * getDetail()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-04-25
  * 개    요 :  디테일  리스트 조회
  * return값 : void
  */
  function getDetail(){
 
     // 조회조건 셋팅
     var strChkDt       = DS_MASTER.NameValue(DS_MASTER.RowPosition, "CHK_DT");           // 발생일
     var strStrCd       = DS_MASTER.NameValue(DS_MASTER.RowPosition, "STR_CD");                                            // 점
     var strAutoTrgFlag = DS_MASTER.NameValue(DS_MASTER.RowPosition, "AUTO_TRG_FLAG");    // 자동전표구분
     var strSlipNo      = DS_MASTER.NameValue(DS_MASTER.RowPosition, "SLIP_NO");          // 전표번호
     var strPumbunCd    = DS_MASTER.NameValue(DS_MASTER.RowPosition, "PUMBUN_CD");        // 브랜드코드
     var strVenCd       = DS_MASTER.NameValue(DS_MASTER.RowPosition, "VEN_CD");           // 
     var strBizType     = DS_MASTER.NameValue(DS_MASTER.RowPosition, "BIZ_TYPE");         // 
     var strTaxFlag     = DS_MASTER.NameValue(DS_MASTER.RowPosition, "TAX_FLAG");         //
     var strSaleFlag    = DS_MASTER.NameValue(DS_MASTER.RowPosition, "SALE_FLAG");        // 매입반품 구분(0:매입, 1:반품) 

     var goTo        = "getDetail" ;    
     var action      = "O";        
     var parameters  = "&strChkDt="+encodeURIComponent(strChkDt)
    	             + "&strStrCd="+encodeURIComponent(strStrCd)
                     + "&strAutoTrgFlag="+encodeURIComponent(strAutoTrgFlag)
				     + "&strSlipNo="+encodeURIComponent(strSlipNo)
                     + "&strPumbunCd="+encodeURIComponent(strPumbunCd)
                     + "&strVenCd="+encodeURIComponent(strVenCd)
                     + "&strBizType="+encodeURIComponent(strBizType)
                     + "&strTaxFlag="+encodeURIComponent(strTaxFlag)
                     + "&strSaleFlag="+encodeURIComponent(strSaleFlag);                    
     TR_S_MAIN.Action="/dps/pord121.po?goTo="+goTo+parameters;  
     TR_S_MAIN.KeyValue="SERVLET(O:DS_DETAIL1=DS_DETAIL1,O:DS_DETAIL2=DS_DETAIL2)"; //조회는 O
     TR_S_MAIN.Post();    
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
             showMessage(EXCLAMATION, OK, "USER-1002", "매출시작일");
             EM_S_START_DT.Focus();
             return false;
        }
         if(EM_S_END_DT.Text.length == 0){                                      // 조회일 정합성
             showMessage(EXCLAMATION, OK, "USER-1002", "매출종료일");
             EM_S_END_DT.Focus();
             return false;
        }
         if(EM_S_START_DT.Text > EM_S_END_DT.Text){                             // 조회일 정합성
             showMessage(EXCLAMATION, OK, "USER-1015");
             EM_S_START_DT.Focus();
             return false;
         }
         return true; 
     }     
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
     var strPumbunType   = "";                                                       // 브랜드유형
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
 
 /**
  * getVenInfo(code, name)
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-18
  * 개    요 :  브랜드에 따른 협력사 팝업
  * return값 : void
  */
 function getVenInfo(code, name){
     var strStrCd        = LC_O_STR.BindColVal;                                    // 점
     var strUseYn        = "Y";                                                       // 사용여부
     var strPumBunType   = "";                                                       // 브랜드유형(0정상)
     var strBizType      = "1";                                                       // 거래형태
     var strMcMiGbn      = "1";                                                       // 매출처/매입처구분
     var strBizFlag      = "";                                                        // 거래구분
     

     var rtnMap = venPop(code, name
                          ,strStrCd,strUseYn,strPumBunType,strBizType,strMcMiGbn
                          ,strBizFlag);
     
     if(rtnMap != null){
         return true;
     }else{
         return false;      
     }
 } 

 /**
  * getVenNonInfo(code, name)
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-18
  * 개    요 :  브랜드에 따른 협력사 팝업
  * return값 : void
  */
 function getVenNonInfo(code, name){
     var strStrCd        = LC_O_STR.BindColVal;                                    // 점
     var strUseYn        = "Y";                                                       // 사용여부
     var strPumBunType   = "";                                                       // 브랜드유형(0정상)
     var strBizType      = "1";                                                       // 거래형태
     var strMcMiGbn      = "1";                                                       // 매출처/매입처구분
     var strBizFlag      = "";                                                        // 거래구분

     var rtnMap = setVenNmWithoutPop( "DS_O_RESULT", code, name, "1"
                                         ,strStrCd,strUseYn,strPumBunType,strBizType,strMcMiGbn
                                         ,strBizFlag);
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
<!-- Grid DS_IO_MASTER 변경시 DS_MASTER의 마스터 내용 변경 -->

<!--  ===================DS_IO_MASTER============================ -->

<script language=JavaScript for=DS_MASTER event=CanRowPosChange( row)>
</script>

<script language=JavaScript for=DS_MASTER event=onRowPosChanged(row)>

if(clickSORT)
    return;
    
    if(row != 0){
        if( bfListRowPosition == row)
            return;
        bfListRowPosition = row;
        
        var autoTrgFlag = this.NameValue(row, "AUTO_TRG_FLAG");
        if(autoTrgFlag == '4'){         // 매가인상하(가격변경)
            document.getElementById("detail1").style.display ="none";
            document.getElementById("detail2").style.display ="";
            
        }else{
        	document.getElementById("detail1").style.display ="";
            document.getElementById("detail2").style.display ="none";
            if(autoTrgFlag == '3'){  // 판매분재매입
                GR_DETAIL1.ColumnProp("NORM_COST_PRC", "SHOW") = false;
                GR_DETAIL1.ColumnProp("NORM_COST_AMT", "SHOW") = false;
                GR_DETAIL1.ColumnProp("NORM_SALE_PRC", "SHOW") = false;
                GR_DETAIL1.ColumnProp("NORM_SALE_AMT", "SHOW") = false;
                GR_DETAIL1.ColumnProp("NORM_MG_RATE", "SHOW")  = false;
            }else{
            	GR_DETAIL1.ColumnProp("NORM_COST_PRC", "SHOW") = true;
                GR_DETAIL1.ColumnProp("NORM_COST_AMT", "SHOW") = true;
                GR_DETAIL1.ColumnProp("NORM_SALE_PRC", "SHOW") = true;
                GR_DETAIL1.ColumnProp("NORM_SALE_AMT", "SHOW") = true;
                GR_DETAIL1.ColumnProp("NORM_MG_RATE", "SHOW")  = true;
            }
        }
    
        getDetail();
        if(intSearchCnt == 0){
            intSearchCnt++;
        }else
        	if(autoTrgFlag == '4')       // 반품재매입
        	    setPorcCount("SELECT", DS_DETAIL2.CountRow);
        	else
        		setPorcCount("SELECT", DS_DETAIL1.CountRow);
    } 
    
    if(DS_MASTER.NameValue(row, "SKU_FLAG") == "1"){
        GR_DETAIL1.ColumnProp("SKU_CD", "SHOW") = true;
        GR_DETAIL2.ColumnProp("SKU_CD", "SHOW") = true;
        GR_DETAIL1.ColumnProp("SKU_NM", "SHOW") = true;
        GR_DETAIL2.ColumnProp("SKU_NM", "SHOW") = true;
    }else{
        GR_DETAIL1.ColumnProp("SKU_CD", "SHOW") = false;
        GR_DETAIL2.ColumnProp("SKU_CD", "SHOW") = false;
        GR_DETAIL1.ColumnProp("SKU_NM", "SHOW") = false;
        GR_DETAIL2.ColumnProp("SKU_NM", "SHOW") = false;
    }
    
    if(clickSORT)
        return;

</script>

<script language=JavaScript for=DS_IO_MASTER
    event=OnColumnChanged(row,colid)>
</script>

<!--  ===================DS_MASTER============================ -->
<!--  DS_MASTER 변경시 -->
<script language=JavaScript for=DS_MASTER
    event=OnColumnChanged(row,colid)>
</script>

<!-- 디테일 삭제시 컴퍼넌트 총금액-->
<script language=JavaScript for=DS_MASTER event=OnRowDeleted(row)>    
</script>


<!-- GR_MASTER CanColumnPosChange(Row,Colid) event 처리 -->
<script language="javascript"  for=GR_MASTER event=CanColumnPosChange(Row,Colid)>
</script>

<!-- Grid GR_DETAIL1 oneClick event 처리 -->

<script language=JavaScript for=GR_DETAIL1 event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid); 
</script>
<!-- GR_DETAIL1 CanColumnPosChange(Row,Colid) event 처리 -->
<script language=JavaScript for=GR_DETAIL1 event=OnDblClick(row,colid)>
    //getDetailPopup();
</script>
<!-- Grid GR_DETAIL1 oneClick event 처리 -->

<script language=JavaScript for=GR_DETAIL2 event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid); 
</script>
<!-- GR_DETAIL2 CanColumnPosChange(Row,Colid) event 처리 -->
<script language=JavaScript for=GR_DETAIL2 event=OnDblClick(row,colid)>
    //getDetailPopup();
</script>

<!-- 디테일 선택시 전체 선택/해제 -->
<script language=JavaScript for=GR_MASTER
    event="OnHeadCheckClick(Col,Colid,bCheck)">       
    if (Colid == "CHECK1") {
        if (bCheck == 1) {
            GR_MASTER.Redraw = false;
            for (var i = 0; i < DS_MASTER.CountRow; i++)
            {
                DS_MASTER.NameValue(i + 1, "CHECK1") = "T";
            }    
            GR_MASTER.Redraw = true;
        }
        else if (bCheck == 0) {
            GR_MASTER.Redraw = false;
            for (var i = 0; i < DS_MASTER.CountRow; i++)
            {
                DS_MASTER.NameValue(i + 1, "CHECK1") = "F";
            } 
            GR_MASTER.Redraw = true;
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

<!-- 팀(조회)  변경시   -->
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

<!-- 파트(조회)  변경시   -->
<script language=JavaScript for=LC_O_TEAM event=OnSelChange()>
	if(LC_O_TEAM.BindColVal != "%"){
	    getPc("DS_O_PC", "Y", LC_O_STR.BindColVal, LC_O_BUMUN.BindColVal, LC_O_TEAM.BindColVal, "Y");     // PC  
	}else{
	    DS_O_PC.ClearData();
	    insComboData( LC_O_PC, "%", "전체",1);
	}
	LC_O_PC.Index = 0;
</script>

<!-- 조회부 브랜드 KillFocus -->
<script language=JavaScript for=EM_S_PUMBUN_CD event=onKillFocus()>

    if(EM_S_PUMBUN_CD.Text != ""){
            searchPumbunNonPop();
    }else
        EM_S_PUMBUN_NM.Text = "";  
</script>

<!-- 조회부 협력사 KillFocus -->
<script language=JavaScript for=EM_S_VEN_CD event=onKillFocus()>

    if(EM_S_VEN_CD.Text != ""){
        getVenNonInfo(EM_S_VEN_CD, EM_S_VEN_NM);
    }else
        EM_S_VEN_NM.Text = "";  
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

<!-- 자동전표구분  변경시   -->
<script language=JavaScript for=LC_O_AUTO_TRG_FLAG event=OnSelChange()>

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
<object id="DS_O_AUTO_TRG_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_AUTO_TRG_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_PROC_STAT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_BIZ_TYPE" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_TAX_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_STR" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>


<comment id="_NSID_">
<object id="DS_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_DETAIL1" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_DETAIL2" classid=<%=Util.CLSID_DATASET%>></object>
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


<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
<script language='javascript'>
window.onresize = function(){
	
	var obj   = document.getElementById("GR_DETAIL1");
	var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top2) {
    	grd_height = top2;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top2);
    }
    obj.style.height  = grd_height + "px";
    
	var obj   = document.getElementById("GR_DETAIL2");
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
                        <th class="point" width="60">점</th>
                        <td width="110"><comment id="_NSID_"> <object
                            id=LC_O_STR classid=<%=Util.CLSID_LUXECOMBO%> height=100
                            width=100 align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script>
                        </td>
                        <th width="70">팀</th>
                        <td width="102"><comment id="_NSID_"> <object
                            id=LC_O_BUMUN classid=<%=Util.CLSID_LUXECOMBO%> width=100
                            align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script></td>
                        <th width="70">파트</th>
                        <td width="120"><comment id="_NSID_"> <object
                            id=LC_O_TEAM classid=<%=Util.CLSID_LUXECOMBO%> width=118
                            align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script></td>
                        <th width="50">PC</th>
                        <td><comment id="_NSID_"> <object id=LC_O_PC
                            classid=<%=Util.CLSID_LUXECOMBO%> width=150 align="absmiddle" tabindex=1>
                        </object> </comment><script>_ws_(_NSID_);</script></td>
                    </tr>
					<tr>
						<th class="point">발생일</th>
						<td colspan="2"><comment id="_NSID_"> <object
						    id=EM_S_START_DT classid=<%=Util.CLSID_EMEDIT%> width=70
						    tabindex=1 align="absmiddle" tabindex=1> </object> </comment><script> _ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/date.gif"
						    onclick="javascript:openCal('G',EM_S_START_DT)" align="absmiddle" />~<comment id="_NSID_"> <object id=EM_S_END_DT
						    classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
						    align="absmiddle" tabindex=1> </object> </comment><script> _ws_(_NSID_);</script> <img
						    src="/<%=dir%>/imgs/btn/date.gif"
						    onclick="javascript:openCal('G',EM_S_END_DT)" align="absmiddle" />
						</td>
						<th>브랜드</th>
						<td colspan="2">
						    <comment id="_NSID_">
						          <object id=EM_S_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%>  width=80 tabindex=1 align="absmiddle">
						          </object>
						    </comment><script> _ws_(_NSID_);</script>
						    <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_S_PUMBUN" class="PR03" align="absmiddle" onclick="javascript:searchPumbunPop();" />
						    <comment id="_NSID_">
						          <object id=EM_S_PUMBUN_NM classid=<%=Util.CLSID_EMEDIT%>  width=94 tabindex=1 align="absmiddle">
						          </object>
						    </comment><script> _ws_(_NSID_);</script>
						</td>
                        <th class="point">구분</th>
                        <td><comment id="_NSID_"> <object
                            id=LC_O_AUTO_TRG_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=150
                            align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script></td>
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
                            width=100% height=300 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID" value="DS_MASTER">
                            <Param Name="ViewSummary"   value="1" >
                        </OBJECT> </comment><script>_ws_(_NSID_);</script></td>
                    </tr>
                </table>
                </td>
            </tr>
        </table>
        </td> 
    </tr>   
    <tr>
        <td height="10">
        </td>
    </tr>
    <tr valign="top">
        <td>     
        <div id ="detail1">   
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr valign="top">
                <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                        <td><comment id="_NSID_"> <OBJECT id=GR_DETAIL1
                            width=100% height=350 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID" value="DS_DETAIL1">
                            <Param Name="ViewSummary"   value="1" >
                        </OBJECT> </comment><script>_ws_(_NSID_);</script></td>
                    </tr>
                </table>
                </td>
            </tr>
        </table>
        </div>
        <div id ="detail2">   
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr valign="top">
                <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                        <td><comment id="_NSID_"> <OBJECT id=GR_DETAIL2
                            width=100% height=350 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID" value="DS_DETAIL2">
                            <Param Name="ViewSummary"   value="1" >
                        </OBJECT> </comment><script>_ws_(_NSID_);</script></td>
                    </tr>
                </table>
                </td>
            </tr>
        </table>
        </div>
        </td>
    </tr>
</table>
</div>
<body>
</html>

