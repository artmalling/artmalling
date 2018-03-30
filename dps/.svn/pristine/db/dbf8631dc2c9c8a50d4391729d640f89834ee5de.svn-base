<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 발주결재 > 전표별 발주현황 조회
 * 작 성 일 : 2010.04.18
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : pord1180.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 전표별 발주현황 조회 
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

var g_searchFlag    = 1;                            // 조회조건(구분)
var g_orgFlag       = "";
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
 var top = 195;		//해당화면의 동적그리드top위치
 var top2 = 195;		//해당화면의 동적그리드top위치
 function doInit(){
	 
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GR_MASTER"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GR_DETAIL"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top2) + "px";

	 
     strToday        = getTodayDB("DS_O_RESULT");
     
     // Output Data Set Header 초기화
     DS_MASTER.setDataHeader('<gauce:dataset name="H_LIST"/>');
     DS_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
     
     DS_O_TEAM.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
     DS_O_PC.setDataHeader('CODE:STRING(2),NAME:STRING(40)'); 
          
     // 그리드 초기화
     gridCreate1(); //현황
     gridCreate2(); //세부사항
     
     // EMedit에 초기화
     initEmEdit(RD_S_SLIP_ISSUE_CNT_FLAG,  "GEN",        NORMAL);        //발행구분     
     initEmEdit(EM_S_START_DT,             "SYYYYMMDD",  PK);            //조회용 시작일
     initEmEdit(EM_S_END_DT,               "TODAY",      PK);            //조회용 종료일
     initEmEdit(EM_S_PUMBUN_CD,            "000000",     NORMAL);        //브랜드코드
     initEmEdit(EM_S_PUMBUN_NM,            "GEN",        READ);          //브랜드명
     initEmEdit(EM_S_VEN_CD,               "000000",     NORMAL);        //협력사코드
     initEmEdit(EM_S_VEN_NM,               "GEN",        READ);          //협력사명
     
     //콤보 초기화
     initComboStyle(LC_O_STR,    DS_STR,           "CODE^0^30,NAME^0^140", 1, PK);              //조회용 점코드     
     initComboStyle(LC_O_BUMUN,  DS_O_DEPT,        "CODE^0^30,NAME^0^80", 1, NORMAL);          //조회용 팀     
     initComboStyle(LC_O_TEAM,   DS_O_TEAM,        "CODE^0^30,NAME^0^80", 1, NORMAL);          //조회용 파트     
     initComboStyle(LC_O_PC,     DS_O_PC,          "CODE^0^30,NAME^0^80", 1, NORMAL);          //조회용 PC     
     initComboStyle(LC_O_GJDATE, DS_O_GJDATE_TYPE, "CODE^0^30,NAME^0^80", 1, PK);              //조회용 기준일     
     initComboStyle(LC_O_ORG_FLAG,       DS_O_ORG_FLAG,   "CODE^0^30,NAME^0^110", 1, PK);       //조회용 조직구분        
     initComboStyle(LC_O_SLIP_PROC_STAT, DS_O_PROC_STAT,  "CODE^0^30,NAME^0^80", 1, NORMAL);   //조회용 전표상태
     initComboStyle(LC_O_ORD_OWN_FLAG,   DS_O_OWN_FLAG,   "CODE^0^30,NAME^0^80", 1, NORMAL);   //조회용 발주주체 

//     getStore("DS_STR", "Y", "", "N");                       // 점        
     getEtcCode("DS_O_GJDATE_TYPE", "D", "P214", "N");       // 기준일
     getEtcCode("DS_O_ORG_FLAG",    "D", "P047", "N");       // 조직구분
     getEtcCode("DS_O_PROC_STAT",   "D", "P207", "Y");       // 전표상태
     getEtcCode("DS_O_OWN_FLAG",    "D", "P202", "Y");       // 발주주체구분

     LC_O_ORG_FLAG.Index   = 0;      //조직구분
     LC_O_ORG_FLAG.Focus();
     LC_O_STR.Index        = 0; 
     LC_O_BUMUN.Index      = 0;
     LC_O_TEAM.Index       = 0;
     LC_O_PC.Index         = 0;  
     LC_O_GJDATE.Index     = 0;
     LC_O_SLIP_PROC_STAT.Index = 0;
     LC_O_ORD_OWN_FLAG.Index   = 0;
     CHK_1.checked       = true;   
     
     registerUsingDataset("pord118","DS_MASTER,DS_DETAIL");
 } 
 
  
 function gridCreate1(){
     var hdrProperies = '<FC>id={currow}           name="NO"         width=30    edit=none align=center show=false</FC>'
                      + '<FC>id=STR_CD             name="점코드"      width=130    edit=none align=left show=false</FC>'
                      + '<FC>id=SLIP_FLAG          name="전표구분코드" width=120   edit=none align=left show=false</FC>'
                      + '<FC>id=SLIP_FLAG_NM       name="전표구분"    width=140    edit=none align=center sumtext="합계"</FC>'
                      + '<FC>id=COUNT_SLIP_FLAG    name="전표수"    width=160    edit=none align=right sumtext=@sum</FC>'
                      + '<FC>id=COST_TAMT          name="원가"      width=240    edit=none align=right sumtext=@sum</FC>'
                      + '<FC>id=SALE_TAMT          name="매가"      width=240    edit=none align=right sumtext=@sum</FC>';

     initGridStyle(GR_MASTER, "common", hdrProperies, false);
 }
 
  
 function gridCreate2(){
     var hdrProperies = '<FC>id={currow}           name="NO"          width=30    edit=none align=center</FC>'
                      + '<FC>id=STR_CD             name="점코드"      width=65    edit=none align=left show=false</FC>'
                      + '<FC>id=STR_NM             name="점"          width=60    edit=none align=left show=false</FC>'
                      + '<FC>id=ORD_DT             name="발주일"      width=80    edit=none align=left  mask="XXXX/XX/XX" sumtext="합계"</FC>'
                      + '<FC>id=SLIP_FLAG          name="전표구분코드" width=80   edit=none align=left show=false</FC>'
                      + '<FC>id=SLIP_FLAG_NM       name="전표구분"    width=80    edit=none align=left </FC>'
                      + '<FC>id=SLIP_NO            name="전표번호"    width=100   edit=none align=center mask="XXXX-X-XXXXXXX"</FC>'
                      + '<FC>id=ORD_OWN_FLAG       name="발주주체"    width=80    edit=none align=left </FC>'
                      + '<FC>id=PUMBUN_CD          name="브랜드코드"    width=93    edit=none align=center </FC>'
                      + '<FC>id=PUMBUN_NM          name="브랜드"        width=100   edit=none align=left </FC>'
                      + '<FC>id=VEN_CD             name="협력사코드"  width=80    edit=none align=center </FC>'
                      + '<FC>id=VEN_NM             name="협력사명"    width=100   edit=none align=left </FC>'
                      + '<FC>id=TQTY               name="총수량"      width=80    edit=none align=right sumtext=@sum</FC>'
                      + '<FC>id=COST_TAMT          name="원가합계"    width=120    edit=none align=right sumtext=@sum</FC>'
                      + '<FC>id=OLD_SALE_TAMT      name="구매가합계"  width=120    edit=none align=right sumtext=@sum</FC>'
                      + '<FC>id=NEW_SALE_TAMT      name="신매가합계"  width=120    edit=none align=right sumtext=@sum</FC>'
                      + '<FC>id=SALE_TAMT          name="매가합계"    width=120    edit=none align=right sumtext=@sum</FC>'
                      + '<FC>id=NEW_GAP_RATE       name="차익율"      width=55    edit=none align=right</FC>'
                      + '<FC>id=SLIP_PROC_STAT_NM  name="전표상태"    width=93    edit=none align=left show=false</FC>'
                      + '<FC>id=SKU_FLAG           name="단품구분"    width=93    edit=none align=left show=false</FC>'
                      + '<FC>id=SKU_TYPE           name="단품종류"    width=93    edit=none align=left show=false</FC>'
                      + '<FC>id=PAIR_STR_CD        name="상대점"      width=93    edit=none align=left show=false</FC>'
                      + '<FC>id=PAIR_SLIP_NO       name="상대전표"    width=93    edit=none align=left show=false</FC>'
                      + '<FC>id=AUTO_SLIP_FLAG     name="자동전표여부" width=93    edit=none align=center </FC>'
                      ;

     initGridStyle(GR_DETAIL, "common", hdrProperies, false);
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
    
    if(!checkValidation("Search"))
    	return false;
/*	
	if(g_searchFlag == 1){
		setPorcCount("SELECT", GR_MASTER);
	}else if(g_searchFlag == 2){
		setPorcCount("SELECT", GR_MASTER);
	}
*/	
    getList();
         // 조회결과 Return
    if(g_searchFlag == 1){
        setPorcCount("SELECT", GR_MASTER);
    }else if(g_searchFlag == 2){
        setPorcCount("SELECT", GR_DETAIL);
    }
    if(DS_MASTER.CountRow <= 0)
        LC_O_ORG_FLAG.Focus();

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

//    setEventFlagDs();  //행사구분 행사율 데이터셋 복사
    // 조회조건 셋팅
    var strStrCd         = LC_O_STR.BindColVal;        //점
    var strBumun         = LC_O_BUMUN.BindColVal;      //팀
    var strTeam          = LC_O_TEAM.BindColVal;       //파트
    var strPc            = LC_O_PC.BindColVal;    
    var strOrgCd         = strStrCd + strBumun + strTeam + strPc; // 조직//PC
    var strGiJunDtType   = LC_O_GJDATE.BindColVal;     //기준일
    var strStartDt       = EM_S_START_DT.Text;         //시작일
    var strEndDt         = EM_S_END_DT.Text;           //종료일
    var strPumbunCd      = EM_S_PUMBUN_CD.Text;        //브랜드코드
    var strVenCd         = EM_S_VEN_CD.Text;           //협력사코드
    var strSlipProcStat  = LC_O_SLIP_PROC_STAT.BindColVal;
    var strOrgFlag       = LC_O_ORG_FLAG.BindColVal;
    var strOrdOwnFlag   = LC_O_ORD_OWN_FLAG.BindColVal;
    
    var slipFlagList = setSlipFlag();   
    if(!slipFlagList){ 
        return;
    }
    
    var goTo        = "getList" ;    
    var action      = "O";   
    
    var parameters  = "&strStrCd="+encodeURIComponent(strStrCd)   
                    + "&strBumun="+encodeURIComponent(strBumun)     
                    + "&strTeam="+encodeURIComponent(strTeam)      
                    + "&strPc="+encodeURIComponent(strPc)        
                    + "&strOrgCd="+encodeURIComponent(strOrgCd)        
                    + "&strGiJunDtType="+encodeURIComponent(strGiJunDtType)
                    + "&strStartDt="+encodeURIComponent(strStartDt)   
                    + "&strEndDt="+encodeURIComponent(strEndDt)   
                    + "&slipFlagList="+encodeURIComponent(slipFlagList)
                    + "&strPumbunCd="+encodeURIComponent(strPumbunCd)
                    + "&strVenCd="+encodeURIComponent(strVenCd)
                    + "&strSlipProcStat="+encodeURIComponent(strSlipProcStat)
                    + "&strOrgFlag="+encodeURIComponent(strOrgFlag)
                    + "&strOrdOwnFlag="+encodeURIComponent(strOrdOwnFlag);                    
    TR_S_MAIN.Action="/dps/pord118.po?goTo="+goTo+parameters;  
    TR_S_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_S_MAIN.Post();  
    getDetail();
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
     var strStrCd         = LC_O_STR.BindColVal;        //점
     var strBumun         = LC_O_BUMUN.BindColVal;      //팀
     var strTeam          = LC_O_TEAM.BindColVal;       //파트
     var strPc            = LC_O_PC.BindColVal;    
     var strOrgCd         = strStrCd + strBumun + strTeam + strPc; // 조직//PC
     var strGiJunDtType   = LC_O_GJDATE.BindColVal;     //기준일
     var strStartDt       = EM_S_START_DT.Text;         //시작일
     var strEndDt         = EM_S_END_DT.Text;           //종료일
     var strPumbunCd      = EM_S_PUMBUN_CD.Text;        //브랜드코드
     var strVenCd         = EM_S_VEN_CD.Text;           //협력사코드
     var strSlipProcStat  = LC_O_SLIP_PROC_STAT.BindColVal;
     var strOrgFlag       = LC_O_ORG_FLAG.BindColVal;
     var strOrdOwnFlag   = LC_O_ORD_OWN_FLAG.BindColVal;
     
     var slipFlagList = setSlipFlag();   
     if(!slipFlagList){ 
         return;
     }
     
     var goTo        = "getDetail" ;    
     var action      = "O";   
     
     var parameters  = "&strStrCd="+encodeURIComponent(strStrCd)   
                     + "&strBumun="+encodeURIComponent(strBumun)     
                     + "&strTeam="+encodeURIComponent(strTeam)      
                     + "&strPc="+encodeURIComponent(strPc)        
                     + "&strOrgCd="+encodeURIComponent(strOrgCd)        
                     + "&strGiJunDtType="+encodeURIComponent(strGiJunDtType)
                     + "&strStartDt="+encodeURIComponent(strStartDt)   
                     + "&strEndDt="+encodeURIComponent(strEndDt)   
                     + "&slipFlagList="+encodeURIComponent(slipFlagList)
                     + "&strPumbunCd="+encodeURIComponent(strPumbunCd)
                     + "&strVenCd="+encodeURIComponent(strVenCd)
                     + "&strSlipProcStat="+encodeURIComponent(strSlipProcStat)
                     + "&strOrgFlag="+encodeURIComponent(strOrgFlag)
                     + "&strOrdOwnFlag="+encodeURIComponent(strOrdOwnFlag);                    
     TR_S_MAIN.Action="/dps/pord118.po?goTo="+goTo+parameters;  
     TR_S_MAIN.KeyValue="SERVLET("+action+":DS_DETAIL=DS_DETAIL)"; //조회는 O
     TR_S_MAIN.Post();    
  }
        
 /**
  * setSlipFlag()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-04-08
  * 개    요 :  전표구분에 따른 조회조건 셋팅
  * return값 : 조회조건 문자열로 리턴
  */
 function setSlipFlag(){

     var strSlipIssueCnt = "A.SLIP_FLAG IN (";
     
     if(CHK_1.checked){
         strSlipIssueCnt += "'A','B','C','D','E','F','G')";
     }else{      
         if(CHK_2.checked){
             strSlipIssueCnt += "'A'," ;
         } 
         
         if(CHK_3.checked){
             strSlipIssueCnt += "'B'," ;             
         }
         
         if(CHK_4.checked){
             strSlipIssueCnt += "'C','D'," ;             
         }
         
         if(CHK_5.checked){
             strSlipIssueCnt += "'E','F'," ;             
         }
                  
         if(CHK_6.checked){
             strSlipIssueCnt += "'G'," ;             
         }
         strSlipIssueCnt = strSlipIssueCnt.substring(0, strSlipIssueCnt.length-1);
         strSlipIssueCnt += ")";
     }     
         
     if(CHK_1.checked == false && CHK_2.checked == false && CHK_3.checked == false 
     && CHK_4.checked == false && CHK_5.checked == false && CHK_6.checked == false){    
//    	 alert();
    	 showMessage(EXCLAMATION, OK, "GAUCE-1005", "전표구분");
    	 CHK_1.checked  = true;
//    	 var obj = document.getElementById("CHK_1");    	 
//    	 setTimeout("obj.Focus()",50);
    	 
         DS_MASTER.ClearData();
         return false;
     }              
     return strSlipIssueCnt;
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
         if(LC_O_GJDATE.Text.length == 0){                                      // 기준일
             showMessage(EXCLAMATION, OK, messageCode, "기준일");
             LC_O_GJDATE.Focus();
             return false;
         }
         
         if(EM_S_START_DT.Text.length == 0){                                    // 조회일 정합성
             showMessage(EXCLAMATION, OK, "USER-1002", "조회시작일");
             EM_S_START_DT.Focus();
             return false;
        }
         if(EM_S_END_DT.Text.length == 0){                                      // 조회일 정합성
             showMessage(EXCLAMATION, OK, "USER-1002", "조회종료일");
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
      var strPumbunType   = "";                                                        // 브랜드유형
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
     var strStrCd        = LC_O_STR.BindColVal;                                       // 점
     var strUseYn        = "Y";                                                       // 사용여부
     var strPumBunType   = "";                                                       // 브랜드유형(0정상)
     var strBizType      = "";                                                        // 거래형태
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
     var strStrCd        = LC_O_STR.BindColVal;                                       // 점
     var strUseYn        = "Y";                                                       // 사용여부
     var strPumBunType   = "";                                                       // 브랜드유형(0정상)
     var strBizType      = "";                                                        // 거래형태
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
 
 /**
  * getDetailPopup()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-14 
  * 개    요 : 단품에 따른 OrderNo 조회 팝업
  * 사용방법 : getOrderNoPopup()
  * return값 : OrderNo
  */
  function getDetailPopup(){
         var rtnMap  = new Map();
         var arrArg  = new Array();

         var strStrCd     = DS_DETAIL.NameValue(DS_DETAIL.RowPosition, "STR_CD");  
         var strOrdDt     = DS_DETAIL.NameValue(DS_DETAIL.RowPosition, "ORD_DT");
         var strSlipNo    = DS_DETAIL.NameValue(DS_DETAIL.RowPosition, "SLIP_NO");
         var strSlipFlag  = DS_DETAIL.NameValue(DS_DETAIL.RowPosition, "SLIP_FLAG");    //전표구분
         var strSkuflag   = DS_DETAIL.NameValue(DS_DETAIL.RowPosition, "SKU_FLAG");     //단품구분
         var strSkuType   = DS_DETAIL.NameValue(DS_DETAIL.RowPosition, "SKU_TYPE");     //단품종류
         var strPStrCd    = DS_DETAIL.NameValue(DS_DETAIL.RowPosition, "PAIR_STR_CD");  //상대점
         var strPSlipNo   = DS_DETAIL.NameValue(DS_DETAIL.RowPosition, "PAIR_SLIP_NO"); //상대전표
         var strStyleType = DS_DETAIL.NameValue(DS_DETAIL.RowPosition, "STYLE_TYPE");   //스타일타입

         arrArg.push(rtnMap);
         arrArg.push(strStrCd);        //점
         arrArg.push(strOrdDt);        //일자
         arrArg.push(strSlipNo);       //전표번호
         arrArg.push(strSlipFlag);     //전표구분
         arrArg.push(strSkuflag);      //단품구분
         arrArg.push(strSkuType);      //단품종류
         arrArg.push(strPStrCd);       //상대점
         arrArg.push(strPSlipNo);      //상대전표
         arrArg.push(strStyleType);    //스타일타입
/*
         alert(strStrCd);
         alert(strOrdDt);
         alert(strSlipNo);
         alert(strSlipFlag);
         alert(strSkuflag);
         alert(strSkuType);
*/              
         window.showModalDialog("/dps/pord118.po?goTo=selDetailPop",
                                 arrArg,
                                 "dialogWidth:800px;dialogHeight:500px;scroll:yes;" +
                                 "resizable:no;help:no;unadorned:yes;center:yes;status:no"); 
  }


/**
* getStore(strDataSet, authGb, bonsaGb, allstrGb, allGb)
* 작 성 자 : 후지쯔(공통)
* 작 성 일 : 2010-02-15
* 개    요 : 점 콤보 세팅을 위한 dataSet을 가져오는 함수 
* 사용방법 : getStore("DS_O_STORE", "Y", "Y", "Y", "Y");
*            arguments[0] -> 저장할 DataSet의 ID
*            arguments[1] -> 권한에 따라 보여질지 여부 ( Y/N )
*            arguments[2] -> 본사점 표시 유무  0:본사점, 1:매장 '':본사 + 매장
*            arguments[3] -> '전체'를 보일건지 여부 ( Y/N )
*            ---------------------------------------------------------------------
*            arguments[4] -> 매장, 매입조직 구분 없이 조회 여부
* return값 : void
*/

var jojikDataHeader = 'AUTH_GB:STRING(1),BONSA_GB:STRING(1),ALL_GB:STRING(1),STR_CD:STRING(4),DEPT:STRING(2),TEAM:STRING(2),PC:STRING(2),ORG_FLAG:STRING(1),MNG_ORG_YN:STRING(1),ADD_CONDITION:STRING(200)';

function getStore(strDataSet, authGb, bonsaGb, allGb, g_orgFlag) {
	

    var addCondition = setAddCondition( 5, arguments );
    
    DS_I_CONDITION.setDataHeader( jojikDataHeader );
    DS_I_CONDITION.ClearData();
    DS_I_CONDITION.Addrow();
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB")  = authGb;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "BONSA_GB") = bonsaGb;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ALL_GB") = allGb;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;
    
//    alert("orgFlag = !!!!!!  " + orgFlag);
    var strOrgFlag = g_orgFlag;    
//    var strOrgFlag = '1';    //임시데이터
    var parameters = "&strOrgFlag="+encodeURIComponent(strOrgFlag);
    
    TR_MAIN.Action  = "/dps/pord118.po?goTo=getStore"+parameters;
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_STORE="+strDataSet+")";
    TR_MAIN.Post();
}


/*

function getDept2(strDataSet, authGb, strStrCd, allGb, strMngOrgYn, strOrgFlag) {
    DS_I_CONDITION.setDataHeader( jojikDataHeader );
    DS_I_CONDITION.ClearData();
    DS_I_CONDITION.Addrow();
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB")  = authGb;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "STR_CD")  = strStrCd;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ALL_GB")  = allGb;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "MNG_ORG_YN")  = strMngOrgYn;
    alert(arguments[5]);
    if(arguments.length > 5)
        DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ORG_FLAG")  = arguments[5];
    
    TR_MAIN.Action    = "/dps/pord118.po?goTo=getDept";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_DEPT="+strDataSet+")";
    TR_MAIN.Post();
}


function getTeam(strDataSet, authGb,strStrCd, strDept, allGb, strMngOrgYn, g_orgFlag)  {    

    DS_I_CONDITION.setDataHeader( jojikDataHeader );
    
    DS_I_CONDITION.ClearData();
    DS_I_CONDITION.Addrow();
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB")  = authGb;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "STR_CD")  = strStrCd;        //점코드
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "DEPT")      = strDept;        //부서 
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ALL_GB")  = allGb;        //Y/N
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "MNG_ORG_YN")  = strMngOrgYn;
    if(arguments.length > 7)
        DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ORG_FLAG")  = arguments[6];
    
    TR_MAIN.Action    = "/dps/pord118.po?goTo=getTeam";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_TEAM="+strDataSet+")";
    TR_MAIN.Post();
}



function getPc(strDataSet, authGb,strStrCd, strDept, strTeam, allGb, strMngOrgYn, g_orgFlag)  {

    DS_I_CONDITION.setDataHeader( jojikDataHeader );
    
    DS_I_CONDITION.ClearData();
    DS_I_CONDITION.Addrow();
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB")  = authGb;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "STR_CD" )    = strStrCd; 
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "DEPT" )      = strDept; 
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "TEAM" )      = strTeam;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ALL_GB" )    = allGb;
    
    if(arguments.length > 8)
        DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ORG_FLAG")  = arguments[7];
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "MNG_ORG_YN")  = strMngOrgYn;
    TR_MAIN.Action    = "/dps/pord118.po?goTo=getPc";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_PC="+strDataSet+")";
    TR_MAIN.Post();
}
*/





/**
 * controlSearchCondition()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-04-18
 * 개    요 :  조회라디오버튼에 따른 구분조건변경(현황, 세부사항)
 * return값 : void
 */
function controlSearchCondition(){    
	 
	g_searchFlag   = RD_S_SLIP_ISSUE_CNT_FLAG.CodeValue;
	if(g_searchFlag == 1){
	    document.getElementById("gridMaster").style.display ="";
	    document.getElementById("gridDetail").style.display ="none";
	    setPorcCount("SELECT", GR_MASTER);
	    
	}else{
        document.getElementById("gridMaster").style.display ="none";
        document.getElementById("gridDetail").style.display ="";	
        setPorcCount("SELECT", GR_DETAIL);
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

<script language=JavaScript for=DS_MASTER event=CanRowPosChange(row)>
</script>

<script language=JavaScript for=DS_MASTER event=onRowPosChanged(row)>    

if(clickSORT)
    return;
</script>
<script language=JavaScript for=DS_DETAIL event=onRowPosChanged(row)>    

if(clickSORT)
    return;
</script>

<script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(row)>
</script>

<script language=JavaScript for=DS_IO_MASTER event=onRowPosChanged(row)>
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

<!-- GR_DETAIL CanColumnPosChange(Row,Colid) event 처리 -->
<script language=JavaScript for=GR_DETAIL event=OnDblClick(row,colid)>
    getDetailPopup();
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

<script language=JavaScript for=GR_DETAIL event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid); 
</script>

<!--*************************************************************************-->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<!-- 조직구분(조회)  변경시  -->
<script language=JavaScript for=LC_O_ORG_FLAG event=OnSelChange()>
    if(LC_O_ORG_FLAG.BindColVal != "%"){
        g_orgFlag = LC_O_ORG_FLAG.BindColVal;
    	getStore("DS_STR", "Y", "", "N", LC_O_ORG_FLAG.BindColVal);                       // 점
    	LC_O_STR.Index = 0;
    }
</script>


<!-- 점(조회)  변경시  -->
<script language=JavaScript for=LC_O_STR event=OnSelChange()>
	if(LC_O_STR.BindColVal != "%"){
	    getDept("DS_O_DEPT", "Y", LC_O_STR.BindColVal, "Y", "N", g_orgFlag);                                              // 팀 
	    LC_O_BUMUN.Index = 0;
	}
</script>

<!-- 팀(조회)  변경시   -->
<script language=JavaScript for=LC_O_BUMUN event=OnSelChange()>
	if(LC_O_BUMUN.BindColVal != "%"){
	    getTeam("DS_O_TEAM", "Y", LC_O_STR.BindColVal, LC_O_BUMUN.BindColVal, "Y", "N", g_orgFlag);                       // 파트  
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
	    getPc("DS_O_PC", "Y", LC_O_STR.BindColVal, LC_O_BUMUN.BindColVal, LC_O_TEAM.BindColVal, "Y", "N", g_orgFlag);     // PC  
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



<!-- 구분에 따른 조회기준 변경 -->
<script language=JavaScript for=RD_S_SLIP_ISSUE_CNT_FLAG event=OnSelChange()>
//    controlGrid();
    controlSearchCondition();

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
<object id="DS_O_ORG_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_PROC_STAT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_OWN_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
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
<object id="DS_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
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
	
    var obj   = document.getElementById("GR_MASTER");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
	var obj   = document.getElementById("GR_DETAIL");
    
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
                        <th class="point" width="70">조직구분</th>
                        <td width="110"><comment id="_NSID_"> <object
                            id=LC_O_ORG_FLAG classid=<%=Util.CLSID_LUXECOMBO%> height=100
                            width=100 align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script>
                        </td>
                        <th class="point" width="70">기준일</th>
                        <td width="120"><comment id="_NSID_"> <object
                            id=LC_O_GJDATE classid=<%=Util.CLSID_LUXECOMBO%> height=100
                            width=100 align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script>
                        </td>
                        <th class="point">조회기간</th>
                        <td colspan="3"><comment id="_NSID_"> <object
                            id=EM_S_START_DT classid=<%=Util.CLSID_EMEDIT%> width=70
                            tabindex=1 align="absmiddle" tabindex=1> </object> </comment><script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/date.gif"
                            onclick="javascript:openCal('G',EM_S_START_DT)" align="absmiddle" />~<comment id="_NSID_"> <object id=EM_S_END_DT
                            classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
                            align="absmiddle" tabindex=1> </object> </comment><script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/date.gif"
                            onclick="javascript:openCal('G',EM_S_END_DT)" align="absmiddle" />
                        </td>
                    </tr>
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
                    <th>브랜드</th>
                    <td colspan="3">
                        <comment id="_NSID_">
                              <object id=EM_S_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%>  width=88 tabindex=1 align="absmiddle">
                              </object>
                        </comment><script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_S_PUMBUN" class="PR03" align="absmiddle" onclick="javascript:searchPumbunPop();" />
                        <comment id="_NSID_">
                              <object id=EM_S_PUMBUN_NM classid=<%=Util.CLSID_EMEDIT%>  width=184 tabindex=1 align="absmiddle">
                              </object>
                        </comment><script> _ws_(_NSID_);</script>
                    </td>
                    <th>협력사</th>
                    <td colspan="3">
                        <comment id="_NSID_">
                              <object id=EM_S_VEN_CD classid=<%=Util.CLSID_EMEDIT%>  width=88 tabindex=1 align="absmiddle">
                              </object>
                        </comment><script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_S_VEN" class="PR03" align="absmiddle" onclick="javascript:getVenInfo(EM_S_VEN_CD, EM_S_VEN_NM);" />
                        <comment id="_NSID_">
                              <object id=EM_S_VEN_NM classid=<%=Util.CLSID_EMEDIT%>  width=184 tabindex=1 align="absmiddle">
                              </object>
                        </comment><script> _ws_(_NSID_);</script>
                    </td>
                  </tr>
                    <tr>
                        <th class="point" width="70">전표상태</th>
                        <td width="110"><comment id="_NSID_"> <object
                            id=LC_O_SLIP_PROC_STAT classid=<%=Util.CLSID_LUXECOMBO%> height=100
                            width=100 align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script>
                        </td>
                        <th class="point">구분</th>
                        <td><comment id="_NSID_"> <object
                            id=RD_S_SLIP_ISSUE_CNT_FLAG classid=<%=Util.CLSID_RADIO%>
                            style="height: 20; width: 110" tabindex=1>
                            <param name=Cols value="3">
                            <param name=Format value="1^현황,2^전표별">
                            <param name=CodeValue value="1">
                            <param name=AutoMargin  value="true">
                        </object> </comment> <script> _ws_(_NSID_);</script></td>
                        <th>발주주체</th>
                        <td  colspan="3"><comment id="_NSID_"> <object
                            id=LC_O_ORD_OWN_FLAG classid=<%=Util.CLSID_LUXECOMBO%> height=100
                            width=100 align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script>
                        </td>
                    </tr>
                    <tr>
                        <th class="point">전표구분</th>
                        <td colspan="7">
                            <input type="checkbox" id=CHK_1 onclick="javascript:checkSlipFlag(CHK_1);">전체
                            <input type="checkbox" id=CHK_2 onclick="javascript:checkSlipFlag(CHK_2);">매입
                            <input type="checkbox" id=CHK_3 onclick="javascript:checkSlipFlag(CHK_3);">반품
                            <input type="checkbox" id=CHK_4 onclick="javascript:checkSlipFlag(CHK_4);">대출입
                            <input type="checkbox" id=CHK_5 onclick="javascript:checkSlipFlag(CHK_5);">점출입
                            <input type="checkbox" id=CHK_6 onclick="javascript:checkSlipFlag(CHK_6);">매가인상하            
                        </td>
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
        <div id="gridMaster">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr valign="top">
                <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                        <td><comment id="_NSID_"> <OBJECT id=GR_MASTER
                            width=100% height=700 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID" value="DS_MASTER">
                            <Param Name="ViewSummary" value="1">
                        </OBJECT> </comment><script>_ws_(_NSID_);</script></td>
                    </tr>
                </table>
                </td>
            </tr>
        </table>
        </div>
        <div id="gridDetail">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr valign="top">
                <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                        <td><comment id="_NSID_"> <OBJECT id=GR_DETAIL
                            width=100% height=700 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID" value="DS_DETAIL">
                            <Param Name="ViewSummary" value="1">
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

