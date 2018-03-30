<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 상담/계약 > 상담관리 > 상담신청 바이어변경 이력  
 * 작 성 일 : 2011.01.14
 * 작 성 자 : 김슬기
 * 수 정 자 : 
 * 파 일 명 : mcou1040.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 상담신청 바이어변경 이력 
 * 이    력 : 2011.01.14 (김슬기) 신규작성
           2011.02.25 (김유완) 수정개발
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정
<!--*************************************************************************-->
<loginChk:islogin />
<%
    String dir = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"	    type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--

/*************************************************************************
 * 0. 전역변수설정
 *************************************************************************/
var g_select =false; // 그리드 조회시 건수
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

function doInit(){

    // Input Data Set Header 초기화
    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MO_COUNSELREQ"/>');
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_MO_BUYERMODHIS"/>');
    
    //그리드 초기화
    gridCreate("MST"); //마스터
    gridCreate("DTL"); //디테일
    
    // EMedit에 초기화
    initEmEdit(EM_S_SDATE, "SYYYYMMDD", PK);            //[조회용]조회기간S
    initEmEdit(EM_S_EDATE, "TODAY", PK);                //[조회용]조회기간E
    initEmEdit(EM_S_WORD, "GEN", NORMAL);               //[조회용]검색어
    initEmEdit(EM_S_BUYER_CD, "NUMBER3^6^2", NORMAL);   //[조회용]바이어코드
    initEmEdit(EM_S_BUYER_NM, "GEN", READ);             //[조회용]바이어명

    //콤보 초기화    
    initComboStyle(LC_S_STR_CD,DS_LC_S_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);       // [조회용]점코드     
    initComboStyle(LC_S_DEPT_CD,DS_LC_S_DEPT_CD, "CODE^0^30,NAME^0^80", 1, NORMAL); // [조회용]팀     
    initComboStyle(LC_S_TEAM_CD,DS_LC_S_TEAM_CD, "CODE^0^30,NAME^0^80", 1, NORMAL); // [조회용]파트    
    initComboStyle(LC_S_PC_CD,DS_LC_S_PC_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);     // [조회용]PC   
    initComboStyle(LC_S_WORD,DS_LC_S_WORD, "CODE^0^30,NAME^0^80", 1, NORMAL);       // [조회용]검색어
    initComboStyle(LC_S_PROC_STAT,DS_LC_S_PROC_STAT, "CODE^0^30,NAME^0^80", 1, NORMAL);//[조회용]상담진행상태

    //시스템 코드 공통코드에서 가지고 오기
    getStore("DS_LC_S_STR_CD",  "Y", "1", "N");
    getDept("DS_LC_S_DEPT_CD",  "N", LC_S_STR_CD.BindColVal, "Y");
    getTeam("DS_LC_S_TEAM_CD",  "N", LC_S_STR_CD.BindColVal, LC_S_DEPT_CD.BindColVal, "Y");
    getPc("DS_LC_S_PC_CD",      "N", LC_S_STR_CD.BindColVal, LC_S_DEPT_CD.BindColVal, LC_S_TEAM_CD.BindColVal, "Y");
    //load 시 기본 포커스
    LC_S_STR_CD.Focus();
    LC_S_STR_CD.Index = 0;
    LC_S_DEPT_CD.Index = 0;
    LC_S_TEAM_CD.Index = 0;
    LC_S_PC_CD.Index = 0;
   
    //시스템 코드 공통코드에서 발행기 가지고 오기
    getEtcCode("DS_LC_S_WORD",   "D", "M068", "Y", "N", LC_S_WORD);             //검색어
    getEtcCode("DS_LC_S_PROC_STAT",   "D", "M028", "Y", "N", LC_S_PROC_STAT);   //상담진행상태
}

function gridCreate(gdGnb){
    //마스터그리드
    if (gdGnb == "MST") {
        var hdrProperies = ''
            + '<FC>ID={CURROW}      NAME="NO"'
            + '                                         WIDTH=30    ALIGN=CENTER</FC>'
            + '<FC>ID=STR_NM        NAME="점"'
            + '                                         WIDTH=80    ALIGN=LEFT</FC>'
            + '<FC>ID=DEPT_NM       NAME="팀"'
            + '                                         WIDTH=100   ALIGN=LEFT</FC>'
            + '<FC>ID=TEAM_NM       NAME="파트"'
            + '                                         WIDTH=120   ALIGN=LEFT</FC>'
            + '<FC>ID=PC_NM         NAME="PC"'
            + '                                         WIDTH=140   ALIGN=LEFT</FC>'
            + '<FC>ID=BUYER_CD      NAME="바이어"'
            + '                                         WIDTH=70    ALIGN=CENTER</FC>'
            + '<FC>ID=TITLE         NAME="제목  "'
            + '                                         WIDTH=250   ALIGN=LEFT</FC>'
            + '<FC>ID=COMP_NAME     NAME="회사명"'
            + '                                         WIDTH=100   ALIGN=LEFT</FC>'
            + '<FC>ID=REP_NAME      NAME="대표자"'
            + '                                         WIDTH=100   ALIGN=LEFT</FC>'
            + '<FC>ID=REQ_NAME      NAME="신청인"'
            + '                                         WIDTH=100   ALIGN=LEFT</FC>'
            + '<FC>ID=REQ_DT        NAME="신청일"'
            + '                                         WIDTH=80    ALIGN=CENTER MASK="XXXX/XX/XX"</FC>'
            + '<FC>ID=REQ_SEQ       NAME="신청번호"'
            + '                                         WIDTH=60    ALIGN=CENTER SHOW=FALSE</FC>'
            + '<FC>ID=PROC_STAT     NAME="상담진행"'
            + '                                         WIDTH=80    ALIGN=LEFT EDITSTYLE=LOOKUP   DATA="DS_LC_S_PROC_STAT:CODE:NAME"</FC>'
            + '<FC>ID=ANS_DT        NAME="답변일"'
            + '                                         WIDTH=80    ALIGN=CENTER MASK="XXXX/XX/XX"</FC>'
            ;
        initGridStyle(GD_MASTER, "COMMON", hdrProperies, false);
    } else if (gdGnb == "DTL") {
        var hdrProperies = ''
            + '<FC>ID={CURROW}          NAME="NO"'
            + '                                                 WIDTH=30    ALIGN=CENTER</FC>'
            + '<FC>ID=MOD_DT            NAME="변경일자"'
            + '                                                 WIDTH=90    ALIGN=CENTER    MASK="XXXX/XX/XX"</FC>'
            + '<FC>ID=SEQ_NO            NAME="순번"'
            + '                                                 WIDTH=60    ALIGN=CENTER</FC>'
            + '<FC>ID=ORG_BUYER_CD      NAME="변경전 바이어코드"'
            + '                                                 WIDTH=80    ALIGN=LEFT   SHOW=FALSE</FC>'
            + '<FC>ID=O_ORG_NAME        NAME="변경전 바이어조직"'
            + '                                                 WIDTH=200   ALIGN=LEFT</FC>'
            + '<FC>ID=O_BUYER_NAME      NAME="변경전 바이어"'
            + '                                                 WIDTH=150   ALIGN=LEFT</FC>'
            + '<FC>ID=MOD_BUYER_CD      NAME="변경후 바이어코드"'
            + '                                                 WIDTH=80    ALIGN=LEFT   SHOW=FALSE</FC>'
            + '<FC>ID=M_ORG_NAME        NAME="변경후 바이어조직"'
            + '                                                 WIDTH=200   ALIGN=LEFT</FC>'
            + '<FC>ID=M_BUYER_NAME      NAME="변경후 바이어"'
            + '                                                 WIDTH=150   ALIGN=LEFT</FC>'
            ;
        initGridStyle(GD_DETAIL, "COMMON", hdrProperies, false);
    }
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
	//일자체크
    if (!checkValidate()) return;

	//parameters
    var strStrCd    = LC_S_STR_CD.BindColVal;   // 점코드
    var strDeptCd   = LC_S_DEPT_CD.BindColVal;  // 팀
    var strTeamCd   = LC_S_TEAM_CD.BindColVal;  // 파트
    var strPcCd     = LC_S_PC_CD.BindColVal;    // PC
    var strSdate    = EM_S_SDATE.Text;          // 조회시작일
    var strEdate    = EM_S_EDATE.Text;          // 조회종료일
    var strWordFlag = LC_S_WORD.BindColVal;     // 검색어구분
    var strWord     = EM_S_WORD.Text;           // 검색어
    var strProcStat = LC_S_PROC_STAT.BindColVal;// 상담진행상태
    var strBuyerCd  = EM_S_BUYER_CD.Text;       // 바이어코드
    
    var goTo = "getMaster";
    var parameters = ""
        + "&strStrCd="      + encodeURIComponent(strStrCd) 
        + "&strDeptCd="     + encodeURIComponent(strDeptCd) 
        + "&strTeamCd="     + encodeURIComponent(strTeamCd)
        + "&strPcCd="       + encodeURIComponent(strPcCd)
        + "&strSdate="      + encodeURIComponent(strSdate)
        + "&strEdate="      + encodeURIComponent(strEdate)
        + "&strWordFlag="   + encodeURIComponent(strWordFlag)
        + "&strWord="       + encodeURIComponent(strWord)
        + "&strProcStat="   + encodeURIComponent(strProcStat)
        + "&strBuyerCd="    + encodeURIComponent(strBuyerCd);
    TR_MAIN.Action = "/mss/mcou101.mu?goTo=" + goTo + parameters;
    TR_MAIN.KeyValue = "SERVLET(O:DS_O_MASTER=DS_O_MASTER)";
    g_select = true;
    TR_MAIN.Post();
    g_select = false;
    
    // 조회결과 Return
    setPorcCount("SELECT", GD_MASTER);
    
    searchDetail2();
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
  * callPopup()
  * 작 성 자 : FKL
  * 작 성 일 : 2011.01.24
  * 개    요 : 팝업 호출
  * return값 :
  */
 function callPopup(popupNm) {
     if (popupNm == "buyer") {//바이어
         if (LC_S_STR_CD.BindColVal == "" || LC_S_STR_CD.BindColVal == "%") {//점 미선택시
             showMessage(STOPSIGN, OK, "USER-1003", "점");
             LC_S_STR_CD.Focus();
             return;
         }  
     
         var strOrgCd = LC_S_STR_CD.BindColVal;
         if (LC_S_DEPT_CD.BindColVal == "" || LC_S_DEPT_CD.BindColVal == "%") {
             strOrgCd +=  "00000000";
         } else {
             strOrgCd += LC_S_DEPT_CD.BindColVal;
             if (LC_S_TEAM_CD.BindColVal == "" || LC_S_TEAM_CD.BindColVal == "%") {
                 strOrgCd +=  "000000";
             } else {
                 strOrgCd += LC_S_TEAM_CD.BindColVal;
                 if (LC_S_PC_CD.BindColVal == "" || LC_S_PC_CD.BindColVal == "%") {
                     strOrgCd +=  "0000";
                 } else {
                     strOrgCd += LC_S_TEAM_CD.BindColVal + "00";
                 }
             }
         }
         
         buyerPop( EM_S_BUYER_CD, EM_S_BUYER_NM , 'N', '', '', strOrgCd, '');
     }
 }
 
 /**
  * searchDetail()
  * 작 성 자 : FKL
  * 작 성 일 : 2010-12-12
  * 개    요 : 변경이력 조회
  * return값 : void
  */
 function searchDetail() {
     //parameters
     var strReqDt   = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "REQ_DT");    // 신청일자
     var strReqSeq  = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "REQ_SEQ");   // 신청번호
     
     var goTo = "getDetail";
     var parameters = ""
         + "&strReqDt="     + encodeURIComponent(strReqDt)
         + "&strReqSeq="    + encodeURIComponent(strReqSeq);
     TR_MAIN1.Action = "/mss/mcou104.mu?goTo=" + goTo + parameters;
     TR_MAIN1.KeyValue = "SERVLET(O:DS_IO_DETAIL=DS_IO_DETAIL)";
     TR_MAIN1.Post();

     // 조회결과 Return
     setPorcCount("SELECT", GD_DETAIL);
 }
 
 /**
  * searchDetail()
  * 작 성 자 : FKL
  * 작 성 일 : 2010-12-12
  * 개    요 : 변경이력 조회
  * return값 : void
  */
 function searchDetail2() {
     //parameters
     var strReqDt   = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "REQ_DT");    // 신청일자
     var strReqSeq  = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "REQ_SEQ");   // 신청번호
     
     var goTo = "getDetail";
     var parameters = ""
         + "&strReqDt="     + encodeURIComponent(strReqDt)
         + "&strReqSeq="    + encodeURIComponent(strReqSeq);
     TR_MAIN1.Action = "/mss/mcou104.mu?goTo=" + goTo + parameters;
     TR_MAIN1.KeyValue = "SERVLET(O:DS_IO_DETAIL=DS_IO_DETAIL)";
     TR_MAIN1.Post();
 
 }
 
 /**
  * checkValidate()
  * 작 성 자 : FKL
  * 작 성 일 : 2011.01.24
  * 개    요 : 값체크
  * return값 :
  */
 function checkValidate() {
     
     //시작, 종료일 일자체크
     var em_sdate = (trim(EM_S_SDATE.Text)).replace(' ','');
     var em_edate = (trim(EM_S_EDATE.Text)).replace(' ','');
     if (em_sdate.length < 8) {
         showMessage(STOPSIGN, OK, "USER-1003", "시작일");
         EM_S_SDATE.Focus();
         return false;
     } else if (em_edate.length < 8) {
         showMessage(STOPSIGN, OK, "USER-1003", "종료일");
         EM_S_EDATE.Focus();
         return false;
     }

     if (em_sdate > em_edate) { //시작일은 종료일보다 커야 합니다.
         showMessage(STOPSIGN, OK, "USER-1015");
         EM_S_SDATE.Focus();
         return false;
     }

     return true;
 }

 
-->
</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리
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

<script language=JavaScript for=TR_MAIN1 event=onSuccess>
    for(i=0;i<TR_MAIN1.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN1.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
  /*  showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }*/
    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_MAIN1 event=onFail>
  /*  showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }*/
    trFailed(TR_MAIN1.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>
if(clickSORT) return;
if (DS_O_MASTER.CountRow > 0 && g_select == false) {
//변경이력 조회
	setTimeout("searchDetail()", 170);
}
</script>

<script language=JavaScript for=DS_O_DETAIL event=OnRowPosChanged(row)>
if(clickSORT) return; 
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
//그리드 정렬기능
    if( row < 1) sortColId( eval(this.DataID), row , colid );
</script>

<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
//그리드 정렬기능[디테일]
    if( row < 1) sortColId( eval(this.DataID), row , colid );
</script>
 
<script language=JavaScript for=EM_S_BUYER_CD event=OnKillFocus()>
//[조회용]바이어코드 입력 시 자동입력 및 기본체크
//if (EM_S_BUYER_CD.Text.length > 0 ) {
	if(!this.Modified)
        return;
        
    if(this.text==''){
    	EM_S_BUYER_NM.Text = "";
        return;
    } 
    
    if (LC_S_STR_CD.BindColVal == "" || LC_S_STR_CD.BindColVal == "%") {//점 미선택시
        EM_S_BUYER_CD.Text = "";
        showMessage(STOPSIGN, OK, "USER-1003", "점");
        LC_S_STR_CD.Focus();
        return;
    } 
    
    var strOrgCd = LC_S_STR_CD.BindColVal;
    if (LC_S_DEPT_CD.BindColVal == "" || LC_S_DEPT_CD.BindColVal == "%") {
        strOrgCd +=  "00000000";
    } else {
        strOrgCd += LC_S_DEPT_CD.BindColVal;
        if (LC_S_TEAM_CD.BindColVal == "" || LC_S_TEAM_CD.BindColVal == "%") {
            strOrgCd +=  "000000";
        } else {
            strOrgCd += LC_S_TEAM_CD.BindColVal;
            if (LC_S_PC_CD.BindColVal == "" || LC_S_PC_CD.BindColVal == "%") {
                strOrgCd +=  "0000";
            } else {
                strOrgCd += LC_S_TEAM_CD.BindColVal + "00";
            }
        }
    }
    //데이터 조회
    setBuyerNmWithoutPop("DS_O_RESULT", EM_S_BUYER_CD, EM_S_BUYER_NM , 'N', 1, '', '', strOrgCd, '');

//} 
</script>

<script language=JavaScript for=LC_S_STR_CD event=OnSelChange()>
//[점]콤보 변경
    //시스템 코드 공통코드에서 가지고 오기
    getDept("DS_LC_S_DEPT_CD", "N", LC_S_STR_CD.BindColVal, "Y");
    if (LC_S_STR_CD.BindColVal == "" || LC_S_STR_CD.BindColVal == "%") {
        // 팀비활성화   
        enableControl(LC_S_DEPT_CD, false);
        LC_S_DEPT_CD.Index = 0;
        // 파트비활성화   
        enableControl(LC_S_TEAM_CD, false);
        LC_S_TEAM_CD.Index = 0;
        // PC비활성화   
        enableControl(LC_S_PC_CD, false);
        LC_S_PC_CD.Index = 0;
    } else {
        // 팀활성화   
        enableControl(LC_S_DEPT_CD, true);
        LC_S_DEPT_CD.Index = 0;
        // 파트비활성화   
        enableControl(LC_S_TEAM_CD, false);
        LC_S_TEAM_CD.Index = 0;
        // PC비활성화   
        enableControl(LC_S_PC_CD, false);
        LC_S_PC_CD.Index = 0;
    }
</script>
<script language=JavaScript for= LC_S_DEPT_CD event=OnSelChange()>
//[팀]콤보 변경
    //시스템 코드 공통코드에서 가지고 오기
    getTeam("DS_LC_S_TEAM_CD", "N", LC_S_STR_CD.BindColVal, LC_S_DEPT_CD.BindColVal, "Y");
    if (LC_S_DEPT_CD.BindColVal == "" || LC_S_DEPT_CD.BindColVal == "%") {
        // 파트비활성화   
        enableControl(LC_S_TEAM_CD, false);
        LC_S_TEAM_CD.Index = 0;
        // PC비활성화   
        enableControl(LC_S_PC_CD, false);
        LC_S_PC_CD.Index = 0;
    } else {
        // 파트활성화   
        enableControl(LC_S_TEAM_CD, true);
        LC_S_TEAM_CD.Index = 0;
        // PC비활성화   
        enableControl(LC_S_PC_CD, false);
        LC_S_PC_CD.Index = 0;
    }
    EM_S_BUYER_CD.Text = "";
    EM_S_BUYER_NM.Text = "";
</script>
<script language=JavaScript for= LC_S_TEAM_CD event=OnSelChange()>
//[파트]콤보 변경
    //시스템 코드 공통코드에서 가지고 오기
    getPc("DS_LC_S_PC_CD", "N", LC_S_STR_CD.BindColVal, LC_S_DEPT_CD.BindColVal, LC_S_TEAM_CD.BindColVal, "Y");
    if (LC_S_TEAM_CD.BindColVal == "" || LC_S_TEAM_CD.BindColVal == "%") {
        // PC비활성화   
        enableControl(LC_S_PC_CD, false);
        LC_S_PC_CD.Index = 0;
    } else {
        // PC활성화   
        enableControl(LC_S_PC_CD, true);
        LC_S_PC_CD.Index = 0;
    }
</script>

<script language=JavaScript for= LC_S_WORD event=OnSelChange()>
//검색어 콤보 변경시 LC_S_WORD
    var strWordFlag = LC_S_WORD.BindColVal;
    if (strWordFlag == "%") {
    	enableControl(EM_S_WORD, false);
    	EM_S_WORD.Text = "";
    } else {
    	enableControl(EM_S_WORD, true);
    }
    
</script>

<script language=JavaScript for=EM_S_SDATE event=onKillFocus()>
//[조회용]시작일 체크
checkDateTypeYMD( EM_S_SDATE );
</script>

<script language=JavaScript for=EM_S_EDATE event=onKillFocus()>
//[조회용]종료일 체크
checkDateTypeYMD( EM_S_EDATE );
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝 
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<!-- ===============- Input용  -->
<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_MASTER"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- ONLOAD용 -->
<comment id="_NSID_"><object id="DS_LC_S_STR_CD"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_S_DEPT_CD"   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_S_TEAM_CD"   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_S_PC_CD"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_S_WORD"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_S_PROC_STAT" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- 공통함수용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_MAIN1" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작
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
				<td><!-- search start -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
                    <tr>
                        <th class="point" width="70">점</th>
                        <td width=112><comment id="_NSID_"> <object id=LC_S_STR_CD
                            tabindex=1 classid=<%=Util.CLSID_LUXECOMBO%> width=110
                            align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                        <th width="70">팀</th>
                        <td width=112><comment id="_NSID_"> <object id=LC_S_DEPT_CD
                            tabindex=1 classid=<%=Util.CLSID_LUXECOMBO%> width=110
                            align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                        <th width="70">파트</th>
                        <td width=112><comment id="_NSID_"> <object id=LC_S_TEAM_CD
                            tabindex=1 classid=<%=Util.CLSID_LUXECOMBO%> width=110
                            align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                        <th width="70">PC</th>
                        <td><comment id="_NSID_"> <object id=LC_S_PC_CD
                            tabindex=1 classid=<%=Util.CLSID_LUXECOMBO%> width=110
                            align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                    </tr>
					<tr>
                        <th class="point">조회기간</th>
                        <td colspan="3"><comment id="_NSID_"> <object
                            id=EM_S_SDATE classid=<%=Util.CLSID_EMEDIT%> width=126
                            tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                            onclick="javascript:openCal('G',EM_S_SDATE)" /> ~ <comment
                            id="_NSID_"> <object id=EM_S_EDATE
                            classid=<%=Util.CLSID_EMEDIT%> width=126 tabindex=1
                            align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                            onclick="javascript:openCal('G',EM_S_EDATE)" /></td>
                        <th>검색어</th>
                        <td colspan="3"><comment id="_NSID_"> <object
                            id=LC_S_WORD tabindex=1 classid=<%=Util.CLSID_LUXECOMBO%>
                            width=110  align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
                        <comment id="_NSID_"> <object id=EM_S_WORD
                            classid=<%=Util.CLSID_EMEDIT%> width=198 tabindex=1
                            align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th >상담진행</th>
						<td colspan="3"><comment id="_NSID_"> <object
							id=LC_S_PROC_STAT classid=<%= Util.CLSID_LUXECOMBO %>
							width=110 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
                        <th>바이어</th>
                        <td colspan="3"><comment id="_NSID_"> <object
                            id=EM_S_BUYER_CD classid=<%=Util.CLSID_EMEDIT%> width=86
                            tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
                            onclick="javascript:callPopup('buyer')" align="absmiddle" /> <comment
                            id="_NSID_"> <object id=EM_S_BUYER_NM
                            classid=<%=Util.CLSID_EMEDIT%> width=198 tabindex=1
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
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="BD4A">
					<tr>
						<td width="100%"><comment id="_NSID_"><OBJECT
							id=GD_MASTER width=100% height=288 tabindex=1  classid=<%=Util.CLSID_GRID%>>
							<param name="DataID" value="DS_O_MASTER">
						</OBJECT></comment><script>_ws_(_NSID_);</script></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
    <tr>
        <td height="5"></td>
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
                        <td width="100%"><comment id="_NSID_"><OBJECT
                            id=GD_DETAIL width=100% height=150 tabindex=1 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID" value="DS_IO_DETAIL">
                        </OBJECT></comment><script>_ws_(_NSID_);</script></td>
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
</body>
</html>

