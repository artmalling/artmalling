<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출관리 > 매출속보
 * 작 성 일 : 
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : psal5210.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
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
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){
    
    // Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');   
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');
    DS_O_MG_RATE.setDataHeader('<gauce:dataset name="H_SEL_MG_RATE"/>');
    
    
    
    
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //디테일
    
    // EMedit에 초기화
    initEmEdit(EM_PUMBUN_CD  , "CODE^6^0" ,  NORMAL);    //브랜드코드
    initEmEdit(EM_PUMBUN_NAME, "GEN^40"   ,  NORMAL);     //브랜드명
    
    initEmEdit(EM_SALE_DT_S,                      "YYYYMMDD",                PK);   //매출일자
    EM_SALE_DT_S.alignment = 1;

    initEmEdit(EM_SALE_DT_E,                      "YYYYMMDD",                PK);   //대비일자
    EM_SALE_DT_E.alignment = 1;

    //현재년도 셋팅
    EM_SALE_DT_S.text =  varToMon+"01";
    

    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_STR_CD, "CODE^0^30,NAME^0^140", 1, PK);              //점(조회)
    
    //팀
    initComboStyle(LC_DEPT_CD,DS_DEPT_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);            //팀(조회)
    
    //파트
    initComboStyle(LC_TEAM_CD,DS_TEAM_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);            //파트(조회)

    //PC
    initComboStyle(LC_PC_CD,DS_PC_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);                //PC(조회)
    
    getStore("DS_STR_CD", "Y", "", "N");                                                          // 점        
    getDept("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y");                                              // 팀 
    getTeam("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y");                       // 파트  
    getPc("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal,  "Y");   // PC  
    
    var strcd = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드
    
    LC_STR_CD.BindColVal = strcd;
    LC_DEPT_CD.Index = 0;
    LC_TEAM_CD.Index = 0;
    LC_PC_CD.Index   = 0;
    
    EM_SALE_DT_E.text =  varToday;
    
    GD_MASTER.focus();
    LC_STR_CD.Focus();
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("psal521","DS_O_MASTER,DS_IO_DETAIL" );
    
}

function gridCreate1(){
	   
    var hdrProperies = '<FC>id={currow}        name="NO"             width=30   align=center</FC>'
        + '<FC>id=STR_CD          name=""        width=100  align=center show=false</FC>'
    	+ '<FC>id=SALE_DT         name="매출일자"        width=100  align=center mask="XXXX/XX/XX"</FC>'
    	+ '<FC>id=POS_NO          name="POS번호"        width=100  align=center </FC>'
    	+ '<FC>id=PUMBUN_CD       name="브랜드코드"        width=100  align=center </FC>'
    	+ '<FC>id=PUMBUN_NAME       name="브랜드명"        width=100  align=left </FC>'
    	+ '<FC>id=PUMMOK_CD       name="품목코드"        width=100  align=center </FC>'
    	+ '<FC>id=PUMMOK_NAME       name="품목명"        width=100  align=left </FC>'
    	+ '<FC>id=EVENT_CD        name="행사코드"        width=100  align=center </FC>'
    	+ '<FC>id=EVENT_NAME        name="행사명"        width=100  align=center </FC>'
    	+ '<FC>id=EVENT_FLAG      name="행사구분"        width=100  align=center </FC>' 
    	+ '<FC>id=EVENT_RATE      name="행사율"        width=100  align=right </FC>' 
    	+ '<FC>id=MG_RATE         name="마진율"        width=100  align=right </FC>' 
    	+ '<FC>id=ORG_CD          name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=FLOOR           name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=VEN_CD          name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=SALE_QTY        name="판매수량"        width=100  align=right </FC>' 
    	+ '<FC>id=TOT_SALE_AMT    name="총매출금액"        width=100  align=right </FC>' 
    	+ '<FC>id=VAT_AMT         name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=REDU_AMT        name="할인금액"        width=100  align=right </FC>' 
    	+ '<FC>id=DC_AMT          name="에누리금액"        width=100  align=right </FC>' 
    	+ '<FC>id=NORM_SALE_AMT   name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=NET_SALE_AMT    name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=SALE_PROF_AMT   name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=CUST_CNT        name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=REP_PUMBUN_CD   name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=BUYER_CD        name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=CHAR_SM         name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=SPS_SALE_QTY    name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=SPS_SALE_AMT    name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=SAL_COST_PRC    name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=TAX_FLAG   	name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=BIZ_TYPE    	name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=REG_DATE        name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=REG_ID          name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=MOD_DATE        name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=MOD_ID          name=""        width=100  align=center show=false</FC>' ;
                     
    initGridStyle(GD_MASTER, "common", hdrProperies,false);
}

function gridCreate2(){
	   
    var hdrProperies = '<FC>id={currow}        name="NO"             width=30   align=center</FC>'
        + '<FC>id=STR_CD          name=""        width=100  align=center show=false</FC>'
    	+ '<FC>id=SALE_DT         name="매출일자"        width=100  align=center show=false</FC>'
    	+ '<FC>id=POS_NO          name="POS번호"        width=100  align=center show=false</FC>'
    	+ '<FC>id=PUMBUN_CD       name="브랜드코드"        width=100  align=center show=false</FC>'
    	+ '<FC>id=PUMMOK_CD       name="품목코드"        width=100  align=center show=false</FC>'
    	+ '<FC>id=EVENT_CD        name="행사코드"        width=100  align=center show=false</FC>'
    	+ '<FC>id=EVENT_FLAG      name="행사구분"        width=100  align=center show=false</FC>' 
    	+ '<FC>id=EVENT_RATE      name="행사율"        width=100  align=center show=false</FC>' 
    	+ '<FC>id=MG_RATE         name="마진율"        width=100  align=center show=false</FC>' 
    	+ '<FC>id=SEQ             name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=ORG_CD          name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=FLOOR           name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=VEN_CD          name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=CUST_CNT        name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=REP_PUMBUN_CD   name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=BUYER_CD        name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=CHAR_SM         name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=SPS_SALE_QTY    name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=SPS_SALE_AMT    name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=SAL_COST_PRC    name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=REG_DATE        name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=REG_ID          name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=MOD_DATE        name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=MOD_ID          name=""        width=100  align=center show=false</FC>'
    	+ '<FG>                     name="매출취소"'
    	+ '<FC>id=OCCUR_FLAG_C      name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=MOD_EVENT_FLAG_C  name="행사구분"        width=100  align=center edit=none </FC>' 
    	+ '<FC>id=MG_APP_DT_C       name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=MOD_MG_RATE_C     name="마진율"        width=100  align=right edit=none</FC>' 
    	+ '<FC>id=SALE_QTY_C        name="*판매수량"        width=100  align=right  edit=RealNumeric edit=none</FC>' 
    	+ '<FC>id=TOT_SALE_AMT_C    name="*총매출금액"        width=100 align=right edit=RealNumeric  edit=none</FC>' 
    	+ '<FC>id=REDU_AMT_C        name="할인금액"        width=100  align=rightr  edit=RealNumeric edit=none</FC>' 
    	+ '<FC>id=DC_AMT_C          name="에누리금액"        width=100  align=rightr edit=RealNumeric  edit=none</FC>' 
    	+ '<FC>id=VAT_AMT_C         name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=NORM_SALE_AMT_C   name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=NET_SALE_AMT_C    name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=SALE_PROF_AMT_C   name=""        width=100  align=center show=false</FC>' 
    	+ '</FG>'
    	+ '<FG>                     name="매출발생"'
    	+ '<FC>id=OCCUR_FLAG_N      name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=MOD_EVENT_FLAG_N  name="*행사구분"        width=100  align=center  edit="Numeric" edit={IF(SysStatus="1","true","false"}</FC>' 
    	+ '<FC>id=MG_APP_DT_N       name="*마진적용일"        width=100    edit="Numeric" align=center mask="XXXX/XX/XX" editStyle=popup edit={IF(SysStatus="1","true","false"} </FC>' 
    	+ '<FC>id=MOD_MG_RATE_N     name="마진율"        width=100  align=right edit=none </FC>' 
    	+ '<FC>id=SALE_QTY_N        name="판매수량"        width=100  align=right edit=none </FC>' 
    	+ '<FC>id=TOT_SALE_AMT_N    name="총매출금액"        width=100  align=right edit=none </FC>' 
    	+ '<FC>id=REDU_AMT_N        name="할인금액"        width=100  align=right edit=none </FC>' 
    	+ '<FC>id=DC_AMT_N          name="에누리금액"        width=100  align=right edit=none </FC>' 
    	+ '<FC>id=VAT_AMT_N         name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=NORM_SALE_AMT_N   name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=NET_SALE_AMT_N    name=""        width=100  align=center show=false</FC>' 
    	+ '<FC>id=SALE_PROF_AMT_N   name=""        width=100  align=center show=false</FC>' 
    	+ '</FG>';
                     
                     
    initGridStyle(GD_DETAIL, "common", hdrProperies, true);
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
 * 작 성 자 : PJE
 * 작 성 일 : 2010-03-16
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	
	var strStrCd      = LC_STR_CD.BindColVal;
    var strDeptCd     = LC_DEPT_CD.BindColVal;
    var strTeamCd     = LC_TEAM_CD.BindColVal;
    var strPcCd       = LC_PC_CD.BindColVal;
    var strSaleDtS    = EM_SALE_DT_S.Text;
    var strSaleDtE    = EM_SALE_DT_E.Text;
    var strPumbunCd   = EM_PUMBUN_CD.Text;
   
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strStrCd="    + encodeURIComponent(strStrCd)
                    + "&strDeptCd="   + encodeURIComponent(strDeptCd)
                    + "&strTeamCd="   + encodeURIComponent(strTeamCd)
                    + "&strPcCd="     + encodeURIComponent(strPcCd)
                    + "&strSaleDtS="  + encodeURIComponent(strSaleDtS)
                    + "&strSaleDtE="  + encodeURIComponent(strSaleDtE)
                    + "&strPumbunCd=" + encodeURIComponent(strPumbunCd);
    TR_MAIN.Action  ="/dps/psal521.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; 
    TR_MAIN.Post();
    
    if(DS_O_MASTER.CountRow > 0){
    	DS_O_MASTER.RowPosition = 0;
        sortColId( DS_O_MASTER, 0, "SALE_DT");
        GD_MASTER.Focus();
        //searchDetail();
    }else{
    	EM_PUMBUN_CD.Focus();
    }
}

/**
 * btn_New()
 * 작 성 자 :  
 * 작 성 일 :  
 * 개     요 :   
 * return값 : 
 */
function btn_New() {

}

/**
 * btn_Delete()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개    요 : 
 * return값 : 
 */
function btn_Delete() {
	
}

/**
 * btn_Save()
 * 작 성 자 :  
 * 작 성 일 :  
 * 개     요 :  
 * return값 : void
 */
 
function pre_Save() {

	if(DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"MG_RATE_CHECK") == 'N') {
		showMessage(EXCLAMATION, OK, "USER-1069","매출발생 마진율");
		return false;	 
	}
	 
	if(DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"MOD_MG_RATE_N") >= 0) {
	 	var strTaxFlag = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"TAX_FLAG"); 
		var strBizType = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"BIZ_TYPE");
		
		var strSaleQty = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"SALE_QTY_C");
		var strTotSaleAmt = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"TOT_SALE_AMT_C");
		var strReduAmt = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"REDU_AMT_C")
		var strDcAmt = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"DC_AMT_C");
		
	    var strNormSaleAmt = strTotSaleAmt - strReduAmt;	
	    var strNetSaleAmt = strTotSaleAmt - strReduAmt - strDcAmt;	
	    
	    //SALE_PROF_AMT_C
		DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"NORM_SALE_AMT_C") = strNormSaleAmt;
		DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"NET_SALE_AMT_C") = strNetSaleAmt;
		DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"NORM_SALE_AMT_N") = strNormSaleAmt;
		DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"NET_SALE_AMT_N") = strNetSaleAmt;
		
		return true;
	} else {
		showMessage(EXCLAMATION, OK, "USER-1069","매출발생 마진율");
		return false;
	}
	 
}

function btn_Save() {
	
	if(pre_Save()) {
	
		
		var strTaxFlag = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"TAX_FLAG"); 
		var strBizType = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"BIZ_TYPE");
		
		var parameters  = "&strTaxFlag="    + encodeURIComponent(strTaxFlag)
					     + "&strBizType="   + encodeURIComponent(strBizType);
					     
		var goTo       = "save";    
		TR_MAIN.Action="/dps/psal521.ps?goTo="+goTo+parameters;  
	    TR_MAIN.KeyValue="SERVLET(I:DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
	    TR_MAIN.Post();
	}
	   
	// alert(DS_IO_DETAIL.SysStatus(DS_IO_DETAIL.RowPosition));
}

/**
 * btn_Excel()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : 
 */

function btn_Excel() {

    
}

/**
 * btn_Print()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : 
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

function searchDetail(){
	
	var row = DS_O_MASTER.RowPosition;
	var strStrCd      = DS_O_MASTER.NameValue(row,"STR_CD");
	var strSaleDt      = DS_O_MASTER.NameValue(row,"SALE_DT");
	var strPosNo      = DS_O_MASTER.NameValue(row,"POS_NO");
	var strPumbunCd      = DS_O_MASTER.NameValue(row,"PUMBUN_CD");
	var strPummokCd      = DS_O_MASTER.NameValue(row,"PUMMOK_CD");
	var strEventCd      = DS_O_MASTER.NameValue(row,"EVENT_CD");
	var strEventFlag      = DS_O_MASTER.NameValue(row,"EVENT_FLAG");
	var strEventRate      = DS_O_MASTER.NameValue(row,"EVENT_RATE");
	var strMgRate      = DS_O_MASTER.NameValue(row,"MG_RATE");
	   
    var goTo        = "searchDetail";    
    var action      = "O";     
    var parameters  = "&strStrCd="   	  + encodeURIComponent(strStrCd)
                    + "&strSaleDt="   	  + encodeURIComponent(strSaleDt)
                    + "&strPosNo="   	  + encodeURIComponent(strPosNo)
                    + "&strPumbunCd="     + encodeURIComponent(strPumbunCd)
                    + "&strPummokCd=" 	  + encodeURIComponent(strPummokCd)
                    + "&strEventCd="  	  + encodeURIComponent(strEventCd)
                    + "&strEventFlag="	  + encodeURIComponent(strEventFlag)
                    + "&strEventRate=" 	  + encodeURIComponent(strEventRate)
                    + "&strMgRate=" 	  + encodeURIComponent(strMgRate);
    TR_DETAIL.Action  ="/dps/psal521.ps?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; 
    TR_DETAIL.Post();
}

function btn_Add(){
	
	var row = DS_O_MASTER.RowPosition;
	var strStrCd      = DS_O_MASTER.NameValue(row,"STR_CD");
	var strSaleDt      = DS_O_MASTER.NameValue(row,"SALE_DT");
	var strPosNo      = DS_O_MASTER.NameValue(row,"POS_NO");
	var strPumbunCd      = DS_O_MASTER.NameValue(row,"PUMBUN_CD");
	var strPummokCd      = DS_O_MASTER.NameValue(row,"PUMMOK_CD");
	var strEventCd      = DS_O_MASTER.NameValue(row,"EVENT_CD");
	var strEventFlag      = DS_O_MASTER.NameValue(row,"EVENT_FLAG");
	var strEventRate      = DS_O_MASTER.NameValue(row,"EVENT_RATE");
	var strMgRate      = DS_O_MASTER.NameValue(row,"MG_RATE");
	var strSaleQty      = DS_O_MASTER.NameValue(row,"SALE_QTY");
	var strTotSaleAmt      = DS_O_MASTER.NameValue(row,"TOT_SALE_AMT");
	var strReduAmt      = DS_O_MASTER.NameValue(row,"REDU_AMT");
	var strDcAmt      = DS_O_MASTER.NameValue(row,"DC_AMT");
	var strSaleProfAmt = DS_O_MASTER.NameValue(row,"SALE_PROF_AMT");
	var strVatAmt = DS_O_MASTER.NameValue(row,"VAT_AMT");
	var strNetSaleAmt = DS_O_MASTER.NameValue(row,"NET_SALE_AMT");
	var strNormSaleAmt = DS_O_MASTER.NameValue(row,"NORM_SALE_AMT");
	
	
	// 2011.08.20 추가 START
	var strSkuFlag      = DS_O_MASTER.NameValue(row,"SKU_FLAG");
	// 단품 브랜드인 경우 매출정정 불가 MESSAGE 출력
	if (strSkuFlag == "1") {
		////showMessage(EXCLAMATION, OK, "USER-1000","비단품 브랜드에 대해서만 마진 정정 가능합니다.");
		////return false;
	}
	// 2011.08.20 추가 END
	
	if(DS_O_MASTER.CountRow > 0	){
		
		if(DS_IO_DETAIL.RowStatus(DS_IO_DETAIL.RowPosition) != "1") {
			DS_IO_DETAIL.ClearData();
			DS_IO_DETAIL.AddRow();
			
			DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"STR_CD") = strStrCd;
			DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"SALE_DT") = strSaleDt; 
			DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"POS_NO") = strPosNo;   
			DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"PUMBUN_CD") =  strPumbunCd; 
			DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"PUMMOK_CD") =  strPummokCd; 
			DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"EVENT_CD") =  strEventCd;  
			DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"EVENT_FLAG") =  strEventFlag; 
			DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"EVENT_RATE") =  strEventRate; 
			DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"MG_RATE") =  strMgRate;    
			
			DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"OCCUR_FLAG_C") =  "1";    
			DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"OCCUR_FLAG_N") =  "0";
			
			DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"MOD_EVENT_FLAG_C") = strEventFlag;
			DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"MOD_MG_RATE_C") = strMgRate;
			DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"MG_APP_DT_C") = strSaleDt;
			DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"MG_APP_DT_N") = varToday;
			DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"SALE_QTY_C") = strSaleQty;
			DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"SALE_QTY_N") = strSaleQty;
			DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"TOT_SALE_AMT_C") = strTotSaleAmt;
			DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"TOT_SALE_AMT_N") = strTotSaleAmt;
			DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"REDU_AMT_C") = strReduAmt;
			DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"REDU_AMT_N") = strReduAmt;
			DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"DC_AMT_C") = strDcAmt;
			DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"DC_AMT_N") = strDcAmt;

			
			// CENTRAL
			DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"NET_SALE_AMT_C") = strNetSaleAmt;
			DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"NET_SALE_AMT_N") = strNetSaleAmt;
			DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"NORM_SALE_AMT_C") = strNormSaleAmt;
			DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"NORM_SALE_AMT_N") = strNormSaleAmt;
			DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"VAT_AMT_C") = strVatAmt;
			DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"VAT_AMT_N") = strVatAmt;
			DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"SALE_PROF_AMT_C") = strSaleProfAmt;
			

			
			// alert(DS_IO_DETAIL.SysStatus(DS_IO_DETAIL.RowPosition));
			
			} else {
			showMessage(EXCLAMATION, OK, "USER-1078");
		}
	}	

}


function btn_Del(){
	
	
	if(DS_IO_DETAIL.RowStatus(DS_IO_DETAIL.RowPosition) == "1") {
		DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
	} else {
		showMessage(EXCLAMATION, OK, "USER-1070","삭제");
	}
}



/**
 * setPumbunCode()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 브랜드명을 등록한다.
 * return값 : void
 */
function setPumbunCode(evnflag){
    var codeObj = EM_PUMBUN_CD;
    var nameObj = EM_PUMBUN_NAME;
    var strCd = LC_STR_CD.BindColVal;
    
    if( codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
        return;     
    }

    if( strCd == ""){
        // (점)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", "점");
        LC_STR_CD.Focus();
        return;
    }

    if( evnflag == "POP" ){
        strPbnPop(codeObj,nameObj,'Y','', strCd,'','','','','','');
        codeObj.Focus();
    }else if( evnflag == "NAME" ){
        setStrPbnNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj,"Y",0,'', strCd,'','','','','','');
    }    
}


function getModMgRate() {
	var mRow = DS_O_MASTER.RowPosition;
	var dRow = DS_IO_DETAIL.RowPosition;
	
	
    
	var strStrCd      = DS_O_MASTER.NameValue(mRow,"STR_CD");
	var strPumbunCd      = DS_O_MASTER.NameValue(mRow,"PUMBUN_CD");
	var strEventCd      = DS_O_MASTER.NameValue(mRow,"EVENT_CD");
	var strEventRate      = DS_O_MASTER.NameValue(mRow,"EVENT_RATE");
	var strEventFlagN      = DS_IO_DETAIL.NameValue(dRow,"MOD_EVENT_FLAG_N");
	var strMgAppDt      = DS_IO_DETAIL.NameValue(dRow,"MG_APP_DT_N");   
    
	var goTo        = "searchMgRate";    
    var action      = "O";     
    var parameters  = "&strStrCd="    	  + encodeURIComponent(strStrCd)
                    + "&strPumbunCd="     + encodeURIComponent(strPumbunCd)
                    + "&strEventCd="  	  + encodeURIComponent(strEventCd)
                    + "&strEventRate="    + encodeURIComponent(strEventRate)
                    + "&strEventFlagN="   + encodeURIComponent(strEventFlagN)
                    + "&strMgAppDt="      + encodeURIComponent(strMgAppDt);
                    
    TR_DETAIL.Action  ="/dps/psal521.ps?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_MG_RATE=DS_O_MG_RATE)"; 
    TR_DETAIL.Post();
    
    var vMgRate ;
    if (DS_O_MG_RATE.CountRow > 0) {
    	vMgRate = DS_O_MG_RATE.NameValue(1,"MOD_MG_RATE");
    	DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"MG_RATE_CHECK") = 'Y';
    } else {
    	DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"MG_RATE_CHECK") = 'N';
    	vMgRate = -99.99;
    }

    return vMgRate;
}


function calcSaleProfAmt(row) {
	var strBiztype;
	
	var strProfAmt = 0;
	var strNetSaleAmt = 0;
	var strSaleMgRate = 0;
	var strDcAmt = 0;
	var strNormSaleAmt = 0;
	
	strBiztype    = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "BIZ_TYPE");
	strNetSaleAmt = DS_IO_DETAIL.NameValue(row, "NET_SALE_AMT_N");
	strSaleMgRate = DS_IO_DETAIL.NameValue(row, "MOD_MG_RATE_N");
	strDcAmt      = DS_IO_DETAIL.NameValue(row, "DC_AMT_N");
/*	
	alert("row           : " + row);
	alert("strBiztype    : " + strBiztype);
	alert("strNetSaleAmt : " + strNetSaleAmt);
	alert("strSaleMgRate : " + strSaleMgRate);
	alert("strDcAmt      : " + strDcAmt);
*/	
	if (strBiztype == "2") {
		strProfAmt     = getRoundDec("1", strNetSaleAmt * (strSaleMgRate / 100)) ;
	} else if (strBiztype == "3") {
		strNormSaleAmt = strNetSaleAmt + strDcAmt ;
		strProfAmt     = getRoundDec("1", strNormSaleAmt * (strSaleMgRate / 100)) ;
	}
	DS_IO_DETAIL.NameValue(row, "SALE_PROF_AMT_N") = strProfAmt;	
	//alert(strProfAmt);
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
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_DETAIL.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_DETAIL event=onFail>
    trFailed(TR_DETAIL.ErrorMsg);
</script>



<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=Javascript>
    // 이전 Focus에 대한 정보를 저장한다.
    var old_Row = 0;
</script>

<!-- Grid GD_MASTER OnPopup event 처리 -->


<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid, "DS_IO_DETAIL"); //헤더 클릭시 정렬
</script>

<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
</script>

<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>
	if(row > 0 && old_Row != row ){
		if (DS_IO_DETAIL.IsUpdated ) {
		    ret = showMessage(QUESTION, YESNO, "USER-1049");
		    if (ret != "1") {
		    	DS_O_MASTER.RowPosition = old_Row;
		        return;
		    } 
		}
		DS_IO_DETAIL.ClearData();
	}
	old_Row = row;
	
</script>

<!-- DETAIL 팝업  -->
<script language=JavaScript for=GD_DETAIL event=OnPopup(row,colid,data)>
    //isOnPopup = true;
    openCal(this,row,colid);
    //isOnPopup = false;
</script>

<script language=JavaScript for=GD_DETAIL event=OnExit(row,colid)>
	if(colid == "MG_APP_DT_N") {
		if(!checkDateTypeYMD(this,colid,'')){
        	setTimeout("setFocusGrid(GD_DETAIL,DS_IO_DETAIL,"+row+",'"+colid+"');",50);
            return false;
        }
		
	}
</script>

<script language=JavaScript for=DS_IO_DETAIL event=onColumnChanged(row,colid)>
	
	switch(colid){
        case 'SALE_QTY_C': 
        	
        	if(DS_IO_DETAIL.NameValue(row,"SALE_QTY_C") == 0) {
        		DS_IO_DETAIL.NameValue(row,"SALE_QTY_C") = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"SALE_QTY");
        		showMessage(EXCLAMATION, OK, "USER-1003","취소 판매수량");
        		setTimeout("setFocusGrid(GD_DETAIL,DS_IO_DETAIL,"+row+",'"+colid+"');",50);
        	} else {
	        	if(DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"SALE_QTY") < DS_IO_DETAIL.NameValue(row,"SALE_QTY_C")) {
	        		DS_IO_DETAIL.NameValue(row,"SALE_QTY_C") = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"SALE_QTY");
	        		showMessage(EXCLAMATION, OK, "USER-1021","취소 판매수량","원 판매수량");
	        		setTimeout("setFocusGrid(GD_DETAIL,DS_IO_DETAIL,"+row+",'"+colid+"');",50);
	        	} 
        	}
        	DS_IO_DETAIL.NameValue(row,"SALE_QTY_N") = DS_IO_DETAIL.NameValue(row,"SALE_QTY_C");
        	break;
        case 'TOT_SALE_AMT_C': 
        	if(DS_IO_DETAIL.NameValue(row,"TOT_SALE_AMT_C") == 0) {
        		DS_IO_DETAIL.NameValue(row,"TOT_SALE_AMT_C") = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"TOT_SALE_AMT");
        		showMessage(EXCLAMATION, OK, "USER-1003","취소 총매출금액");
        		setTimeout("setFocusGrid(GD_DETAIL,DS_IO_DETAIL,"+row+",'"+colid+"');",50);
        	} else {
	        	if(DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"TOT_SALE_AMT") < DS_IO_DETAIL.NameValue(row,"TOT_SALE_AMT_C")) {
	        		DS_IO_DETAIL.NameValue(row,"TOT_SALE_AMT_C") = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"TOT_SALE_AMT");
	        		showMessage(EXCLAMATION, OK, "USER-1021","취소 총매출금액","원 총매출금액");
	        		setTimeout("setFocusGrid(GD_DETAIL,DS_IO_DETAIL,"+row+",'"+colid+"');",50);
	        	} 
        	}
        	DS_IO_DETAIL.NameValue(row,"TOT_SALE_AMT_N") = DS_IO_DETAIL.NameValue(row,"TOT_SALE_AMT_C");
        	break;
        case 'REDU_AMT_C': 
        	
        	if(DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"REDU_AMT") < DS_IO_DETAIL.NameValue(row,"REDU_AMT_C")) {
        		DS_IO_DETAIL.NameValue(row,"REDU_AMT_C") = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"REDU_AMT");
        		showMessage(EXCLAMATION, OK, "USER-1021","취소 할인금액","원 할인금액");
        		setTimeout("setFocusGrid(GD_DETAIL,DS_IO_DETAIL,"+row+",'"+colid+"');",50);
        	} 
        	DS_IO_DETAIL.NameValue(row,"REDU_AMT_N") = DS_IO_DETAIL.NameValue(row,"REDU_AMT_C");
        	break;
        case 'DC_AMT_C': 
        	
        	if(DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"DC_AMT") < DS_IO_DETAIL.NameValue(row,"DC_AMT_C")) {
        		DS_IO_DETAIL.NameValue(row,"DC_AMT_C") = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"DC_AMT");
        		showMessage(EXCLAMATION, OK, "USER-1021","취소 에누리금액","원 에누리금액");
        		setTimeout("setFocusGrid(GD_DETAIL,DS_IO_DETAIL,"+row+",'"+colid+"');",50);
        	} 
        	DS_IO_DETAIL.NameValue(row,"DC_AMT_N") = DS_IO_DETAIL.NameValue(row,"DC_AMT_C");
        	break;
        case 'MOD_EVENT_FLAG_N':
        	if(DS_IO_DETAIL.NameValue(row,"MOD_EVENT_FLAG_N") != "" && DS_IO_DETAIL.NameValue(row,"MG_APP_DT_N") !="") {
        		
        		DS_IO_DETAIL.NameValue(row,"MOD_MG_RATE_N") = getModMgRate();
        		calcSaleProfAmt(row);
        		
        	}
        	break;
        case 'MG_APP_DT_N': 
        	if(DS_IO_DETAIL.NameValue(row,"MOD_EVENT_FLAG_N") != ""  && DS_IO_DETAIL.NameValue(row,"MG_APP_DT_N") !="") {
        		DS_IO_DETAIL.NameValue(row,"MOD_MG_RATE_N") = getModMgRate();	
        		calcSaleProfAmt(row);
            }
        	break;
	}
</script>



<script language="javascript">
    var today    = new Date();
    var old_Row = 0;
    var searchChk = "";

    // 오늘 일자 셋팅 
    var now = new Date();
    var mon = now.getMonth()+1;
    if(mon < 10)mon = "0" + mon;
    var day = now.getDate();
    if(day < 10)day = "0" + day;
    var varToday = now.getYear().toString()+ mon + day;
    var varToMon = now.getYear().toString()+ mon;
</script>

<!-- 점(조회)  변경시  -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
    getDept("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y");                                              // 팀 
    getTeam("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y");                       // 파트  
    getPc("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal, "Y");    // PC 
    LC_DEPT_CD.Index = 0;
    LC_TEAM_CD.Index = 0;
    LC_PC_CD.Index   = 0;
</script>

<!-- 팀(조회)  변경시  -->
<script language=JavaScript for=LC_DEPT_CD event=OnSelChange()>
    if(LC_DEPT_CD.BindColVal != "%"){
        getTeam("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y");                       // 파트   
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
    if(LC_TEAM_CD.BindColVal != "%"){
        getPc("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal, "Y");    // PC   
    }else{
        DS_PC_CD.ClearData();
        insComboData( LC_PC_CD, "%", "전체",1);
    }
    LC_PC_CD.Index   = 0;
</script>

<!-- 년월 -->
<script language=JavaScript for=EM_SALE_DT_S event=onKillFocus()>

    //영업조회일
    if (isNull(EM_SALE_DT_S.text) ==true ) {
        showMessage(Information, OK, "USER-1003","시작일자"); 
        EM_SALE_DT_S.text = varToMon+"01";
        return ;
    }
    //영업조회일 자릿수, 공백 체크
    if (EM_SALE_DT_S.text.replace(" ","").length != 8 ) {
        showMessage(Information, OK, "USER-1027","시작일자","8");
        EM_SALE_DT_S.text = varToMon+"01";
        return ;
    }
    //일자형식체크
    if (!checkYYYYMMDD(EM_SALE_DT_S.text) ) {
        showMessage(Information, OK, "USER-1069","시작일자");
        EM_SALE_DT_S.text = varToMon+"01";
        return ;
    }
    
    if(EM_SALE_DT_S.text > EM_SALE_DT_E.text) {
    	showMessage(Information, OK, "USER-1021","시작일자","종료일자");
        EM_SALE_DT_S.text = varToMon+"01";
        EM_SALE_DT_S.Focus();
        return ;
    }

</script>

<!-- 년월 -->
<script language=JavaScript for=EM_SALE_DT_E event=onKillFocus()>

    //영업조회일
    if (isNull(EM_SALE_DT_E.text) ==true ) {
        showMessage(Information, OK, "USER-1003","종료일자"); 
        EM_SALE_DT_E.text = varToday;
        return ;
    }
    //영업조회일 자릿수, 공백 체크
    if (EM_SALE_DT_E.text.replace(" ","").length != 8 ) {
        showMessage(Information, OK, "USER-1027","종료일자","8");
        EM_SALE_DT_E.text = varToday;
        return ;
    }
    //일자형식체크
    if (!checkYYYYMMDD(EM_SALE_DT_E.text) ) {
        showMessage(Information, OK, "USER-1069","종료일자");
        EM_SALE_DT_E.text = varToday;
        return ;
    }
    
    if(EM_SALE_DT_S.text > EM_SALE_DT_E.text) {
    	showMessage(Information, OK, "USER-1020","종료일자","시작일자");
        EM_SALE_DT_E.text = varToday;
        EM_SALE_DT_E.Focus();
        return ;
    }
    
    
    
    
</script>

<!-- 브랜드(조회) -->
<script language=JavaScript for=EM_PUMBUN_CD event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    
    if(!this.Modified)
        return;
    setPumbunCode('NAME');
    
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
<object id="DS_O_PC" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_PUMBUN_CD" classid=<%=Util.CLSID_DATASET%>></object>
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
<object id="DS_SEARCH_NM" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>


<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_MG_RATE" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_0_PC" classid=<%=Util.CLSID_DATASET%>></object>
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

<comment id="_NSID_">
<object id="DS_O_CMPRDT" classid=<%=Util.CLSID_DATASET%>></object>
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
<object id="TR_DETAIL" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                               *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                           *-->
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
                  <th width="70" class="point">점</th>
                  <td width="105"><comment id="_NSID_"> <object
                     id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width="70" >팀</th>
                  <td width="105"><comment id="_NSID_"> <object
                     id=LC_DEPT_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width="70">파트</th>
                  <td width="105"><comment id="_NSID_"> <object
                     id=LC_TEAM_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width="70">PC</th>
                  <td ><comment id="_NSID_"> <object
                     id=LC_PC_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
               </tr>
               <tr>
                  <th class="point">매출일자</th>
                  <td colspan="3"><comment id="_NSID_"> <object
                     id=EM_SALE_DT_S classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif"
                     onclick="javascript:openCal('G',EM_SALE_DT_S)" align="absmiddle" />
                  ~
                     <comment id="_NSID_"> <object
                     id=EM_SALE_DT_E classid=<%=Util.CLSID_EMEDIT%> width=72
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif"
                     onclick="javascript:if(EM_SALE_DT_E.Enable) openCal('G',EM_SALE_DT_E); " align="absmiddle" />
                  </td>
                  <th width="60" >브랜드</th>
		          <td colspan="3">
		              <comment id="_NSID_">
		                <object id=EM_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1 align="absmiddle"></object>
		              </comment><script> _ws_(_NSID_);</script>
		              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" onclick="javascript:setPumbunCode('POP');"  align="absmiddle" />
		              <comment id="_NSID_">
		                <object id=EM_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%> width=130 tabindex=1 align="absmiddle"></object>
		              </comment><script> _ws_(_NSID_);</script>
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
				<td><comment id="_NSID_"> <object id=GD_MASTER
					width="100%" height=350 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_MASTER">
				</object> </comment> <script>_ws_(_NSID_);</script></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="right PB02" valign="bottom"><img src="/<%=dir%>/imgs/btn/add_row.gif"
					hspace="2" onclick="javascript:btn_Add();" /> <img
					src="/<%=dir%>/imgs/btn/del_row.gif"
					onclick="javascript:btn_Del();" />
			    </td>
			</tr>
		</table>
		</td>
	</tr>
	<tr valign="top">
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" 
			class="BD4A"> 
			<tr>
				<td><comment id="_NSID_"> <object id=GD_DETAIL
					width="100%" height=100 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_IO_DETAIL">
				</object> </comment> <script>_ws_(_NSID_);</script></td>
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
