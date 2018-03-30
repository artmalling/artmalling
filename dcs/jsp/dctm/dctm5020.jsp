<!-- 
 * 시스템명 : 포인트카드 > 고객관리 > 회원관리 > 조건별 회원조회
 * 작 성 일 : 2016.11.01
 * 작 성 자 : KHJ
 * 수 정 자 : 
 * 파 일 명 : dctm5020.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>

<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
    request.setCharacterEncoding("utf-8");
    String dir = BaseProperty.get("context.common.dir");
    
    String fromDate = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());  
    fromDate = fromDate + "01";
    String toDate   = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    
 // PID 확인을 위한
    String pageName = request.getRequestURI();
    int nSubStrFr = pageName.lastIndexOf("/") + 1 ;
    int nSubStrTo = pageName.lastIndexOf(".jsp") - 1 ;
    pageName = pageName.substring(nSubStrFr, nSubStrTo).toUpperCase();

    
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>

	
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--
var strCompPersFlag = "P";

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-29
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 210;		//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID
 var nDisplayRow = 100;					// 그리드에 출력할 Row 갯수
 var nPageNum = 0;
function doInit(){

    //Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	
    // Input Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_O_RESULT.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    var strOrgFlag = "1";
    
    // EMedit에 초기화
    //-- 검색 필드
    

    initComboStyle(LC_SEX_CD, DS_O_SEX_CD, "CODE^0^30,NAME^0^110", 1, NORMAL); //성별

    
    initComboStyle(LC_STR_CD,	DS_IO_STR_CD,	"CODE^0^30,NAME^0^150", 1, PK);        // 점(조회)
    initComboStyle(LC_DEPT_CD,DS_DEPT_CD, "CODE^0^30,NAME^0^80",  1, NORMAL);	// 팀(조회)
    initComboStyle(LC_TEAM_CD,DS_TEAM_CD, "CODE^0^30,NAME^0^80",  1, NORMAL);	// 파트(조회)
    initComboStyle(LC_PC_CD,DS_PC_CD,     "CODE^0^30,NAME^0^80",  1, NORMAL);	// PC(조회)
    initComboStyle(LC_FLOOR_CD,DS_O_FLOOR_CD,     "CODE^0^30,NAME^0^80",  1, NORMAL);	// PC(조회)

    // EMedit에 초기화
    initEmEdit(EM_FROM_DT,	"YYYYMMDD", PK);				// 시작일
    initEmEdit(EM_TO_DT,	"YYYYMMDD", PK);            // 종료일
    
    initEmEdit(EM_ENTR_FR,	"YYYYMMDD", PK)				// 가입시작일
    initEmEdit(EM_ENTR_TO,	"YYYYMMDD", PK);			// 가입종료일

    initEmEdit(EM_FROM_AMT, "NUMBER^9^0", NORMAL);      // 매출기간
    initEmEdit(EM_TO_AMT, 	"NUMBER^9^0", NORMAL);      // 매출기간
    
    initEmEdit(EM_POINT_FR, "NUMBER^9^0", NORMAL);      // 매출
    initEmEdit(EM_POINT_TO, 	"NUMBER^9^0", NORMAL);  // 매출
    
    
    initEmEdit(EM_AGE_FR, 	"NUMBER^9^0", NORMAL);      // 나이
    initEmEdit(EM_AGE_TO, 	"NUMBER^9^0", NORMAL);      // 나이
    
    initEmEdit(EM_PUMBUN_CD,   "CODE^6^0", NORMAL);     //브랜드(조회)
    initEmEdit(EM_PUMBUN_NAME, "GEN^40",   READ);       //브랜드(조회)
    
    initEmEdit(EM_ADDR, "GEN^40",   NORMAL);            //주소
      

    getEtcCode("DS_O_SEX_CD", "D", "D002", "Y");
    getEtcCode("DS_O_BIR_MONTH", "D", "M100", "Y");
    getStore("DS_IO_STR_CD",     "Y", "", "N");  
    getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y", "", strOrgFlag);                        	// 팀    
    getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag); 	// 파트    
    getPc2("DS_PC_CD", "Y",     LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal, "Y", "", strOrgFlag);// PC
    getEtcCode("DS_O_FLOOR_CD", "D", "P061", "Y");
   
    //조회일자 초기값.
    //LC_CUST_GRADE.Index = 0;
    LC_SEX_CD.Index = 0;
//     LC_MOBILE_COMP.Index = 0;
    //LC_BIR_MONTH_S.Index = 0;

    EM_AGE_FR.Text = 0;
    EM_AGE_TO.Text = 999;
    
    EM_FROM_AMT.Text = 0;
    EM_TO_AMT.Text = 999999999;
    
    EM_POINT_FR.Text = 0;
    EM_POINT_TO.Text = 999999999;
    
    LC_STR_CD.index   = 0;
    LC_DEPT_CD.Index = 0;
    LC_TEAM_CD.Index = 0;
    LC_PC_CD.Index   = 0;
    LC_FLOOR_CD.Index   = 0;
    
    EM_PUMBUN_CD.text 		= "";
	EM_PUMBUN_NAME.text		= "";
	EM_PUMBUN_CD.Enabled 	= false;

	LC_FLOOR_CD.Enable	= false;
    
    LC_STR_CD.Focus(); 
    
     
    EM_FROM_DT.Text = "<%=fromDate%>";
    EM_TO_DT.Text = "<%=toDate%>";
    EM_ENTR_FR.Text = "<%=fromDate%>";
    EM_ENTR_TO.Text = "<%=toDate%>";
    
    countPage(0,0);
    
    condOnOff(false)
    
}

function gridCreate1(){
    var hdrProperies = '<FC>id=ROW_NUM      name="NO"           width=40    edit=none	align=center </FC>'
                     + '<FC>id=CUST_NO      name="회원ID"       width=90    edit=none	align=center sumtext="회원수"</FC>'
                     + '<FC>id=MSKD_NAME    name="회원명"       width=150	edit=none	align=center sumtext={count(CUST_NO)}</FC>'
                     + '<FC>id=CUST_SEX     name="성별"       	width=60    edit=none	align=center </FC>'
                     + '<FC>id=CUST_AGE	    name="나이" 	    width=60	edit=none	align=center </FC>'
                     + '<FC>id=MSKD_HP 		name="핸드폰번호"   width=120   edit=none	align=center mask="XXX-XXXX-XXXX"</FC>'
                     + '<FC>id=ADDR 		name="주	소"     width=350   edit=none	align=left </FC>'
                     + '<FC>id=SALE_AMT     name="구매금액"     width=100   edit=none	align=right</FC>'
                     + '<FC>id=TOT_PT       name="포인트"       width=100   edit=none	align=right</FC>'
                     + '<FC>id=SMS_YN		name="문자수신"		width=80	edit=none	align=center color ={if(SMS_YN="N","RED")} </FC>'
                     + '<FC>id=DM_YN		name="우편수신"		width=80	edit=none	align=center color ={if(DM_YN="N","RED")} </FC>'
                     + '<FC>id=ENTR_GB      name="가입구분" 	width=100   edit=none	align=center  </FC>'
                     + '<FC>id=DI      		name="혜택구분" 	width=100   edit=none	align=center  </FC>'
                     + '<FC>id=LAST_SALE_DT name="최종구매일자"	width=100   edit=none	align=center mask="XXXX/XX/XX"  </FC>'
                     + '<FC>id=ROW_NUM      name="포인트"		width=100   edit=none	align=right show=false </FC>'
                     ;

    initGridStyle(GD_MASTER, "common", hdrProperies, true);
    initGridStyle(GD_HIDDEN, "common", hdrProperies, true);
    //합계표시
    GD_MASTER.ViewSummary = "1";
  
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
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-29
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {

	 DS_O_RESULT.ClearData();
	 DS_O_MASTER.ClearData();
	 
	/*
	String strStrCd     	= String2.nvl(form.getParam("strStrCd"));
        String strFromDt     	= String2.nvl(form.getParam("strFromDt"));
        String strToDt     		= String2.nvl(form.getParam("strToDt"));

        String strSEX_CD        = String2.nvl(form.getParam("strSEX_CD"));

        String strPoint_from    = String2.nvl(form.getParam("strPoint_from"));
        String strPoint_to      = String2.nvl(form.getParam("strPoint_to"));
        
        String strSMs           = String2.nvl(form.getParam("strSMs"));
        
        
        String strCndtnGbn		= String2.nvl(form.getParam("strCndtnGbn"));
        String strBrandCd		= String2.nvl(form.getParam("strBrandCd"));
        String strFloorCd		= String2.nvl(form.getParam("strFloorCd"));
        String strOrgCd			= String2.nvl(form.getParam("strOrgCd"));
	*/
	var strStrCd  	= LC_STR_CD.BindColVal;				//점
    var strFromDt 	= EM_FROM_DT.text;      			//매출시작일자
    var strToDt   	= EM_TO_DT.text;       				//메출종료일자
    
	 
    var strSEX_CD     = LC_SEX_CD.BindColVal;			//성별
    var strPoint_from = EM_POINT_FR.TEXT;		        //포인트범위
    var strPoint_to   = EM_POINT_TO.TEXT;       		//포인트범위 
    
    var strAgeFrom = EM_AGE_FR.text;            //나이범위
    var strAgeTo   = EM_AGE_TO.text;       		//나이범위
    
        
    var strCndtnGbn = RD_CONDITION.CodeValue; // 조회조건
    
    var strBrandCd = EM_PUMBUN_CD.TEXT;	// 브랜드
    
    var strOrgCd = LC_STR_CD.BindColVal + LC_DEPT_CD.BindColVal + LC_TEAM_CD.BindColVal + LC_PC_CD.BindColVal;	// 조직
    
    var strFloorCd 	= LC_FLOOR_CD.BindColVal;			//층
    
	var strSMs        	= "";							//SMS수신거부제외
	var strDM       	= "";							//DM수신거부제외
	var strChkCond		= "";							// 조회조건 설정여부	
    
    if (CHK_SMS.checked == true) {
    	strSMs        = "Y";	
    } else {
    	strSMs        = "N";
    }
	
    if (CHK_DM.checked == true) {
    	strDM        = "Y";	
    } else {
    	strDM        = "N";
    }
    
    
    if (COND_ONOFF.checked == true) {
    	strChkCond	= "Y";
    } else {
    	strChkCond	= "N";
    }
    	
    
    var strAddr   	= EM_ADDR.Text;					//주소
    var strAmt_from	= EM_FROM_AMT.text;        		//매출금액범위
    var strAmt_to	= EM_TO_AMT.text;       		//매출금액범위
    var strEntrFrDt = EM_ENTR_FR.TEXT; 				//가입일자
    var strEntrToDt = EM_ENTR_TO.TEXT;     			//가입일자
    
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strStrCd="     	   	+ encodeURIComponent(strStrCd)
			        + "&strFromDt="        	+ encodeURIComponent(strFromDt)
			        + "&strToDt="     	   	+ encodeURIComponent(strToDt) 
			        + "&strCndtnGbn="    	+ encodeURIComponent(strCndtnGbn)
                    + "&strSEX_CD="        	+ encodeURIComponent(strSEX_CD)
                    + "&strPoint_from="    	+ encodeURIComponent(strPoint_from)
                    + "&strPoint_to="      	+ encodeURIComponent(strPoint_to)
                    + "&strAgeFrom="    	+ encodeURIComponent(strAgeFrom)
                    + "&strAgeTo="      	+ encodeURIComponent(strAgeTo)
                    + "&strSMs="           	+ encodeURIComponent(strSMs)
                    + "&strDM="           	+ encodeURIComponent(strDM)
                    + "&strOrgCd="   		+ encodeURIComponent(strOrgCd)
                    + "&strFloorCd="     	+ encodeURIComponent(strFloorCd)
                    + "&strBrandCd="     	+ encodeURIComponent(strBrandCd)
                    + "&strAddr="     		+ encodeURIComponent(strAddr)
                    + "&strAmt_from="    	+ encodeURIComponent(strAmt_from)
                    + "&strAmt_to="      	+ encodeURIComponent(strAmt_to)
                    + "&strEntrFrDt="       + encodeURIComponent(strEntrFrDt)
			        + "&strEntrToDt="     	+ encodeURIComponent(strEntrToDt)
			        + "&strChkCond="     	+ encodeURIComponent(strChkCond)
                    ;
    searchSetWait("B");              
    TR_MAIN.Action  = "/dcs/dctm502.dm?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();    
    searchDoneWait();
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
    
    if (DS_O_MASTER.CountRow>0){
	    nPageNum = 1;
	    var nLstPage = Math.floor(DS_O_MASTER.CountRow / 100) + 1; // 마지막 페이지 번호
	    countPage(nPageNum,nLstPage);
	    var strData = DS_O_MASTER.ExportData(1, 100, true);
	    DS_O_RESULT.ImportData(strData);
	    DS_O_RESULT.ResetStatus();
    } else {
    	nPageNum = 0;
    	countPage(nPageNum,nPageNum);
    }
    
    
    //if (DS_O_MASTER.CountRow > 0 )
    //    GD_MASTER.Focus();
    //else 
    	//EM_ADDR.Focus();    
}

/**
 * btn_Excel()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-29
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
		 
	var strStrCd  = LC_STR_CD.Text; 			     	//점
    var strFromDt = EM_FROM_DT.text;      				//시작일자
    var strToDt   = EM_TO_DT.text;       				//종료일자
	 
    
    var strSEX_CD     = LC_SEX_CD.Text;             	//성별
    var strPoint_from = EM_FROM_AMT.text;        		//포인트
    var strPoint_to   = EM_TO_AMT.text;       		//포인트
    
    var strAgeFrom = EM_AGE_FR.text;            //나이범위
    var strAgeTo   = EM_AGE_TO.text;       		//나이범위
    
    var strCndtnGbn = RD_CONDITION.CodeValue; // 조회조건
    
    var strBrandCd = EM_PUMBUN_CD.TEXT;	// 브랜드
    var strBrandNm = EM_PUMBUN_NAME.TEXT;	// 브랜드
    
    var strOrgCd = LC_STR_CD.BindColVal + LC_DEPT_CD.BindColVal + LC_TEAM_CD.BindColVal + LC_PC_CD.BindColVal;	// 조직
    
    var strFloorCd 	= LC_FLOOR_CD.BindColVal;			//층
    
    var strSMs        = "";								//SMS수신거부제외 
    if (CHK_SMS.checked == true) {
    	strSMs        = "SMS수신거부제외 ";	
    }
    
    var strMask       = "";								//개인정보 가리기
    if (CHK_MASK.checked == true) {
    	strMask        = "개인정보숨김 ";	
    }
    
    //strMOBILE_COMP = LC_MOBILE_COMP.BindColVal;
    
   
    //var strBIR_MONTH_S = LC_BIR_MONTH_S.Text;           //생일월
    //var strHOME_ADDR   = EM_ADDR.Text;					//주소
    
    
    
    
    var ExcelTitle = "회원 조회"
    var parameters = "가입점="        + strStrCd
				   + " ,매출기간="   + strFromDt + "~" + strToDt
				   + " ,성별="       + strSEX_CD
				   + " ,매출금액="   + strPoint_from + "~" + strPoint_to
				    + " ,연령구간="   + strAgeFrom + "~" + strAgeTo
				   + " ,"            + strSMs
				   + " ,"            + strMask
                   ;
    if (strCndtnGbn == "1") {
    	parameters = parameters 
    			 	+ " ,브랜드=" + strBrandNm + "("+ strBrandCd +")";
    } else if (strCndtnGbn == "2") {
    	parameters = parameters 
				 	+ " ,팀=" 	+ LC_DEPT_CD.text 
				 	+ " ,파트=" 	+ LC_TEAM_CD.text 
				 	+ " ,PC=" 	+ LC_PC_CD.text
				 	;
    } else if (strCndtnGbn == "3") {
    	parameters = parameters 
				 	+ " ,층= " 	+ LC_FLOOR_CD.text
				 	;
    }
    //openExcel2(GD_MASTER, ExcelTitle, parameters, true );
    openExcel5(GD_HIDDEN, ExcelTitle, parameters, true , "",g_strPid );

}

/**
 * btn_New()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-22
 * 개      요      : 신규추가 초기화
 * return값 : void
 */
function btn_New() {
	 
    //조회일자 초기값.   	    
    //EM_ADDR.Text = ""; 
   
}
/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * changePage(strAction)
  * 작 성 자     : jyk
  * 작 성 일     : 2018-01-09
  * 개      요      : 그리드 페이지 변경
  * return값 : void
  */
 function changePage(strAction) {
	if (DS_O_MASTER.CountRow > 0 ) { 
		var nPage = 0;						// 페이지 리스트 시작번호
		var nLstPage = Math.floor(DS_O_MASTER.CountRow/100)+1; // 마지막 페이지 번호
		if (strAction == "N") {				// next
			nPage = DS_O_RESULT.NameValue(DS_O_RESULT.CountRow,"ROW_NUM") + 1;		// 그리드 데이터셋 마지막 행 번호 + 1
			if (DS_O_MASTER.CountRow > nPage) {
				var strData = DS_O_MASTER.ExportData(nPage, nDisplayRow, true);		// 일부 데이터 EXPORT
				DS_O_RESULT.ClearData();											
			    DS_O_RESULT.ImportData(strData);									// 그리드 데이터 셋에 IMPORT
			    DS_O_RESULT.ResetStatus();											// 그리드 데이터 셋 상태 리셋
			    nPageNum = nPageNum + 1;
			    countPage(nPageNum,nLstPage);
			    return;
			} else {
				showMessage(INFORMATION, OK, "USER-1000", "마지막 페이지 입니다.");
				return;
			}
		} else if (strAction == "P") {		// previous
			nPage = DS_O_RESULT.NameValue(1,"ROW_NUM") - nDisplayRow;				// 그리드 데이터셋 첫 행 번호 - nDisplayRow
			if (nPage >= 1) {
				var strData = DS_O_MASTER.ExportData(nPage, nDisplayRow, true);		// 일부 데이터 EXPORT
				DS_O_RESULT.ClearData();
			    DS_O_RESULT.ImportData(strData);									// 그리드 데이터 셋에 IMPORT
			    DS_O_RESULT.ResetStatus();											// 그리드 데이터 셋 상태 리셋
			    nPageNum = nPageNum - 1;
			    countPage(nPageNum,nLstPage);
			    return;
			} else {
				showMessage(INFORMATION, OK, "USER-1000", "첫 페이지 입니다.");
				return;
			}
		} else if (strAction == "F") {		// first
			nPage = 1;																// 가장 첫페이지.
			if (nPage >= 1) {
				var strData = DS_O_MASTER.ExportData(nPage, nDisplayRow, true);		// 일부 데이터 EXPORT
				DS_O_RESULT.ClearData();
			    DS_O_RESULT.ImportData(strData);									// 그리드 데이터 셋에 IMPORT
			    DS_O_RESULT.ResetStatus();											// 그리드 데이터 셋 상태 리셋
			    nPageNum = 1;
			    countPage(nPageNum,nLstPage);
			    return;
			} else {
				showMessage(INFORMATION, OK, "USER-1000", "첫 페이지 입니다.");
				return;
			}
		} else if (strAction == "L") {		// last
			nPage = Math.floor(DS_O_MASTER.CountRow / nDisplayRow) * nDisplayRow + 1; // (데이터셋 총행수 / nDisplayRow) 소수점 버림 * nDisplayRow + 1
			if (DS_O_MASTER.CountRow > nPage) {
				var strData = DS_O_MASTER.ExportData(nPage, nDisplayRow, true);		// 일부 데이터 EXPORT
				DS_O_RESULT.ClearData();
			    DS_O_RESULT.ImportData(strData);									// 그리드 데이터 셋에 IMPORT
			    DS_O_RESULT.ResetStatus();											// 그리드 데이터 셋 상태 리셋
			    nPageNum = nLstPage;
			    countPage(nPageNum,nLstPage);
			    return;
			} else {
				showMessage(INFORMATION, OK, "USER-1000", "마지막 페이지 입니다.");
				return;
			}
		}
	}
}
 /**
  * chkMasking(tfChk)
  * 작 성 자     : jyk
  * 작 성 일     : 2018-01-09
  * 개      요      : 그리드 개인정보 숨김/표기
  * return값 : void
  */
 function chkMasking(tfChk) {
	 if (tfChk){
		 GD_MASTER.ColumnProp("MSKD_HP", "Value") = "MSKD_HP";
		 GD_MASTER.ColumnProp("MSKD_NAME", "Value") = "MSKD_NAME";
		 GD_HIDDEN.ColumnProp("MSKD_HP", "Value") = "MSKD_HP";
		 GD_HIDDEN.ColumnProp("MSKD_NAME", "Value") = "MSKD_NAME";
	 } else {
		 GD_MASTER.ColumnProp("MSKD_HP", "Value") = "HP";
		 GD_MASTER.ColumnProp("MSKD_NAME", "Value") = "CUST_NAME";
		 GD_HIDDEN.ColumnProp("MSKD_HP", "Value") = "HP";
		 GD_HIDDEN.ColumnProp("MSKD_NAME", "Value") = "CUST_NAME";
	 }
 }
 /**
  * countPage(pagenum,lstpagenum)
  * 작 성 자     : jyk
  * 작 성 일     : 2018-01-09
  * 개      요      : 페이지 카운트 출력
  * return값 : void
  */ 
 function countPage(pagenum,lstpagenum) {
	 obj 			= document.getElementById("pageCnt");
	 obj.innerText  = "　　"+ pagenum +" / "+ lstpagenum ;
 }
 
 /**
  * setZero(obj)
  * 작 성 자     : jyk
  * 작 성 일     : 2018-01-09
  * 개      요      : 입력값 없을 경우 0으로 표기
  * return값 : void
  */ 
 function setZero(obj) {
	 var strTemp = obj.text;
	 if (strTemp.length == 0) {
		 var strObjId =  obj.id;
		 if (strObjId.indexOf("FR") > 0) {
		 	 obj.text = 0;
		 }
		 else {
			 if (strObjId.indexOf("AGE") > 0)
				obj.text = 999;
			 else
				obj.text = 999999999;
		 }
	 }
 }
 
function condOnOff(tf) {

	 RD_CONDITION.enable 	= tf;
	 LC_DEPT_CD.enable 		= tf;
	 LC_TEAM_CD.enable 		= tf;
	 LC_PC_CD.enable 		= tf;
	 EM_PUMBUN_CD.enabled 	= tf;
	 EM_PUMBUN_NAME.enabled	= tf;
	 LC_FLOOR_CD.enable		= tf;
	 
	if (tf) {
		RD_CONDITION.CodeValue	= 2;
		EM_PUMBUN_CD.enabled 	= !tf;
		EM_PUMBUN_NAME.enabled 	= !tf;
		LC_FLOOR_CD.enable 		= !tf;
		LC_DEPT_CD.index 		= 0;
		LC_FLOOR_CD.index 		= 0;
		EM_PUMBUN_CD.text 		= "";
		EM_PUMBUN_NAME.text 	= "";
	}
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

<!-- 점(조회)  변경시  -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
	var strOrgFlag="1";	
	getDept2("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y", "", strOrgFlag);                                  // 팀		
	getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);           // 파트		
	getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag);// PC 
    LC_DEPT_CD.Index = 0;
    LC_TEAM_CD.Index = 0;
    LC_PC_CD.Index   = 0;
</script>

<!-- 팀(조회)  변경시  -->
<script language=JavaScript for=LC_DEPT_CD event=OnSelChange()>
var strOrgFlag="1";
    if(LC_DEPT_CD.BindColVal != "%"){
    	getTeam2("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y", "", strOrgFlag);           // 파트   
    }else{
        DS_TEAM_CD.ClearData();
        insComboData( LC_TEAM_CD, "%", "전체",1);
        DS_PC_CD.ClearData();
        insComboData( LC_PC_CD, "%", "전체",1);
    }
    LC_TEAM_CD.Index = 0;
</script>

<!-- TEAM(조회)  변경시  -->
<script language=JavaScript for=LC_TEAM_CD event=OnSelChange()>
var strOrgFlag="1";
    if(LC_TEAM_CD.BindColVal != "%"){
    	getPc2("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y", "", strOrgFlag);// PC   
    }else{
        DS_PC_CD.ClearData();
        insComboData( LC_PC_CD, "%", "전체",1);
    }
    LC_PC_CD.Index   = 0;
</script>

<script language=JavaScript for=RD_CONDITION event=OnSelChange()>
	
	if(RD_CONDITION.CodeValue =="1"){
		EM_PUMBUN_CD.Enabled 	= true;
		
		LC_DEPT_CD.index 	= 0;
		LC_DEPT_CD.Enable	= false;
		LC_TEAM_CD.Enable	= false;
		LC_PC_CD.Enable		= false;
		
		LC_FLOOR_CD.index 	= 0;
		LC_FLOOR_CD.Enable	= false;
	}else if (RD_CONDITION.CodeValue =="2") {
		EM_PUMBUN_CD.text 		= "";
		EM_PUMBUN_NAME.text		= "";
		EM_PUMBUN_CD.Enabled 	= false;

		
		LC_DEPT_CD.Enable	= true;
		LC_TEAM_CD.Enable	= true;
		LC_PC_CD.Enable		= true;
		
		LC_FLOOR_CD.index 	= 0;
		LC_FLOOR_CD.Enable	= false;
	}else if (RD_CONDITION.CodeValue =="3") {
		
		EM_PUMBUN_CD.text 		= "";
		EM_PUMBUN_NAME.text		= "";
		EM_PUMBUN_CD.Enabled 	= false;
		
		LC_DEPT_CD.index 	= 0;
		LC_DEPT_CD.Enable	= false;
		LC_TEAM_CD.Enable	= false;
		LC_PC_CD.Enable		= false;
		
		LC_FLOOR_CD.Enable	= true;
	}
</script>

<!-- Grid sorting 기능  -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    //sortColId(eval(this.DataID), row, colid);
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
<comment id="_NSID_">
<object id="DS_IO_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_DEPT_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_TEAM_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_PC_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>


<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>


<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>


<comment id="_NSID_">
<object id="DS_O_SEX_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_FLOOR_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>





<!--------------------- 2. Transaction  --------------------------------------->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->

<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_MASTER");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+200) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
}
</script>

<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
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
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="o_table">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="80" class="point">점</th>
						<td width="200">  
							<comment id="_NSID_">
		                        <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=130 tabindex=1 align="absmiddle">
		                        </object>
		                    </comment><script>_ws_(_NSID_);</script> 
                  		</td>
                  		<th width="80" class="point">가입기간</th>
						<td width="320" > 
						 <comment id="_NSID_">
		                      <object id=EM_ENTR_FR classid=<%=Util.CLSID_EMEDIT%>  width=110 tabindex=1 align="absmiddle">
		                      </object>
		                  </comment><script> _ws_(_NSID_);</script>
		                  <img src="/<%=dir%>/imgs/btn/date.gif" id="IMG_FROM_DT" onclick="javascript:openCal('G',EM_ENTR_FR)" align="absmiddle" />
		                  ~
		                  <comment id="_NSID_">
		                      <object id=EM_ENTR_TO classid=<%=Util.CLSID_EMEDIT%>  width=110 tabindex=1 align="absmiddle">
		                      </object>
		                  </comment><script> _ws_(_NSID_);</script>
		                  <img src="/<%=dir%>/imgs/btn/date.gif" id="IMG_TO_DT" onclick="javascript:openCal('G',EM_ENTR_TO)" align="absmiddle" />
			            </td>
                  		<th width="80" class="point">매출기간</th>
						<td width="300" > 
						 <comment id="_NSID_">
		                      <object id=EM_FROM_DT classid=<%=Util.CLSID_EMEDIT%>  width=110 tabindex=1 align="absmiddle">
		                      </object>
		                  </comment><script> _ws_(_NSID_);</script>
		                  <img src="/<%=dir%>/imgs/btn/date.gif" id="IMG_FROM_DT" onclick="javascript:openCal('G',EM_FROM_DT)" align="absmiddle" />
		                  ~
		                  <comment id="_NSID_">
		                      <object id=EM_TO_DT classid=<%=Util.CLSID_EMEDIT%>  width=110 tabindex=1 align="absmiddle">
		                      </object>
		                  </comment><script> _ws_(_NSID_);</script>
		                  <img src="/<%=dir%>/imgs/btn/date.gif" id="IMG_TO_DT" onclick="javascript:openCal('G',EM_TO_DT)" align="absmiddle" />
			            </td>
			              
			            <th width="80" > 매출범위</th>
						<td > 
						 <comment id="_NSID_">
		                      <object id=EM_FROM_AMT classid=<%=Util.CLSID_EMEDIT%>  width=110 tabindex=1 align="absmiddle" onblur="javascript:setZero(EM_FROM_AMT)">
		                      </object>
		                  </comment><script> _ws_(_NSID_);</script>
		                 ~
		                  <comment id="_NSID_">
		                      <object id=EM_TO_AMT classid=<%=Util.CLSID_EMEDIT%>  width=110 tabindex=1 align="absmiddle" onblur="javascript:setZero(EM_TO_AMT)">
		                      </object>
		                  </comment><script> _ws_(_NSID_);</script>
			            </td> 
                  	</tr>
					<tr>
						<th width="80">성별</th>
						<td width="200"><comment id="_NSID_"> <object
							id=LC_SEX_CD classid=<%=Util.CLSID_LUXECOMBO%> width=130
							tabindex=5></object> </comment> <script> _ws_(_NSID_);</script></td>
						</td>
						
			            
						<th width="80" >나이 범위</th>
						<td width="300">
							<comment id="_NSID_"> <object id=EM_AGE_FR
							width=110 classid=<%=Util.CLSID_EMEDIT%> tabindex=1
							align="absmiddle" onblur="javascript:setZero(EM_AGE_FR)"></object> </comment> <script> _ws_(_NSID_);</script> 
							~
							<comment id="_NSID_"> <object id=EM_AGE_TO
							width=110 classid=<%=Util.CLSID_EMEDIT%> tabindex=1
							align="absmiddle" onblur="javascript:setZero(EM_AGE_TO)"></object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="80" >주소</th>
						<td width="300">
							<comment id="_NSID_"> <object
	                   		id=EM_ADDR classid=<%=Util.CLSID_EMEDIT%> width=250
	                   		align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th width="80" >포인트범위</th>
						<td>
							<comment id="_NSID_"> <object id=EM_POINT_FR
							width=110 classid=<%=Util.CLSID_EMEDIT%> tabindex=1
							align="absmiddle" onblur="javascript:setZero(EM_POINT_FR)"></object> </comment> <script> _ws_(_NSID_);</script> 
							~
							<comment id="_NSID_"> <object id=EM_POINT_TO
							width=110 classid=<%=Util.CLSID_EMEDIT%> tabindex=1
							align="absmiddle" onblur="javascript:setZero(EM_POINT_TO)"></object> </comment> <script> _ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th width="78" rowspan="2">조회조건 <input type="checkbox" id=COND_ONOFF onclick="condOnOff(this.checked);")></th>
						<td width="200" rowspan="2" >  
							<comment id="_NSID_">
							<object id="RD_CONDITION" classid=<%=Util.CLSID_RADIO%> tabindex=1 style="height:50; width:150">
							<param name=Cols    value="2">
							<param name=Format  value="2^조직,1^브랜드,3^층">                   
							<param name=CodeValue  value="2">
							</object>  
							</comment><script> _ws_(_NSID_);</script> 
				        </td>
						<th width="70">팀</th>
		                <td width="200"><comment id="_NSID_"> <object
		                   id=LC_DEPT_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
		                   align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
		                <th width="70" >파트</th>
		                <td width="300"><comment id="_NSID_"> <object
		                   id=LC_TEAM_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
		                   align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
		                <th width="70">PC</th>
		                <td ><comment id="_NSID_"> <object
		                   id=LC_PC_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
		                   align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
		                </td>
					</tr>
					<tr>
						<th width="80">브랜드</th>
	               		<td width="200"><comment id="_NSID_"> <object id=EM_PUMBUN_CD
	                   	classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1
	                   	align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
	                   	src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
	                   	onclick="if(RD_CONDITION.CodeValue =='1'){javascript:strPbnPop(EM_PUMBUN_CD,EM_PUMBUN_NAME, 'Y'); EM_PUMBUN_CD.focus();}"
	                   	align="absmiddle" /> <comment id="_NSID_"> <object
	                   	id=EM_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%> width=120
	                   	align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
	               		</td>
						<th width="80" >층</th>
						<td colspan="3">
						<comment id="_NSID_"> <object
							id=LC_FLOOR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=130
							tabindex=5></object> </comment> <script> _ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>	
						<th width="80">조회옵션</th>
						<td colspan="7">
							<input type="checkbox" id=CHK_SMS  value="F"   align="absmiddle"  tabindex=1 checked>SMS수신거부제외
							<input type="checkbox" id=CHK_DM  value="F"   align="absmiddle"  tabindex=1 checked>DM수신거부제외
							<input type="checkbox" id=CHK_MASK align="absmiddle"  tabindex=1 checked onclick="chkMasking(CHK_MASK.checked);">개인정보숨김
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
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<div>☞ 페이지 이동 :
				<img src="/<%=dir%>/imgs/btn/first.gif" onclick="changePage('F')" align="absmiddle" />
				<img src="/<%=dir%>/imgs/btn/before2.gif" onclick="changePage('P')" align="absmiddle" />
				<img src="/<%=dir%>/imgs/btn/next2.gif"   onclick="changePage('N')" align="absmiddle" />
				<img src="/<%=dir%>/imgs/btn/last.gif"   onclick="changePage('L')" align="absmiddle" /></div>
				<div id="pageCnt"></div>
			</tr>
			<tr>
				<td><object id=GD_MASTER width="100%" height=500
					classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_RESULT" tabindex=1>
				</object>
				<object id=GD_HIDDEN width="100%" height=500
					classid=<%=Util.CLSID_GRID%> tabindex=1 style="display:none;">
					<param name="DataID" value="DS_O_MASTER" tabindex=1>
				</object>
				
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
