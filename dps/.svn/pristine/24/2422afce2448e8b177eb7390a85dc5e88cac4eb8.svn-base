<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 매출관리 > POS 정산 > 거래별 매출내역 현황
 * 작 성 일 : 2012.06.27
 * 작 성 자 : DHL
 * 수 정 자 : 
 * 파 일 명 : psal5370.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        2012.06.27 DHL  신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
                                                                       common.vo.SessionInfo,
                                                                       kr.fujitsu.ffw.base.BaseProperty,
                                                                       kr.fujitsu.ffw.util.Date2" %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"      prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"   prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"       prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"    prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                           		*-->
<!--*************************************************************************-->
<loginChk:islogin />
<%    
    String dir        = BaseProperty.get("context.common.dir");
    String strYm      = Date2.getYear();
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"   type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"     type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                  *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : DHL
 * 작 성 일 : 2012-06-27
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
	 
    // EMedit에 초기화
    initComboStyle(LC_STR_CD,   DS_STR_CD,  "CODE^0^30,NAME^0^90", 1, PK);		//점(조회)
    getStore("DS_STR_CD", "Y", "", "N");			//점콤보 가져오기 ( gauce.js )
    
    initComboStyle(LC_HALL_CD,DS_HALL_CD,	"CODE^0^30,NAME^0^140", 1, PK);		//관 (조회)
    //시스템 코드 공통코드에서 가지고 오기
    getEtcCode("DS_HALL_CD","D", "P197", "Y" ,"N");
    LC_HALL_CD.Index = 0;
    
    initEmEdit(EM_SALE_DT_S,	"TODAY",  PK);		//시작일자
    EM_SALE_DT_S.alignment = 1;

    initEmEdit(EM_SALE_DT_E,	"TODAY",  PK);		//종료일자
    EM_SALE_DT_E.alignment = 1;

    initEmEdit(EM_POSNO,		"GEN^4",  NORMAL);	//시작포스번호
    EM_POSNO.alignment = 3;
    
    var strcd   = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';		// 로그인 점코드   
    LC_STR_CD.BindColVal  = strcd;   
	LC_STR_CD.Focus();
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
 * 작 성 자 : DHL
 * 작 성 일 : 2012-06-27
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {

    if(!chkValidation("search")) return;

    var strStrCd        = LC_STR_CD.BindColVal;		//점코드
    //var strStrNm        = LC_STR_CD.BindCol;		//점이름
    var strSaleDtS      = EM_SALE_DT_S.text;		//시작일자
    var strSaleDtE      = EM_SALE_DT_E.text;		//종료일자
    var strPosNo        = EM_POSNO.text;			//POS 번호
    var strHallCd		= LC_HALL_CD.BindColVal;	//관코드
    //var strCashierId    = EM_POSNO.text;			//POS 번호
    
    /*
    if (strPosNo.equals('')) {
    	strPosNo = '전체';
    }
    */
    /*
    if (strCashierId.equals('%')) {
    	strCashierId = '전체';
    }
    */
    
    var parameters = "&strStrCd="  + strStrCd              //점코드
                   //+ "&strStrNm="  + strStrNm              //점이름
                   + "&strSaleDtS=" + strSaleDtS           //시작일자
                   + "&strSaleDtE=" + strSaleDtE           //종료일자
                   + "&strPosNo=" + strPosNo               //POS 번호
                   + "&strHallCd=" + strHallCd				//관코드
                   ; 
    
    IFrame.location.href="/dps/jsp/psal/psal5371.jsp?"+parameters;
}

/**
 * subQuery()
 * 작 성 자 : DHL
 * 작 성 일 : 2012-06-27
 * 개    요 : 
 * return값 : void
 */
function subQuery(row){
}

/**
 * btn_New()
 * 작 성 자 : DHL
 * 작 성 일 : 2012-06-27
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
}

/**
 * btn_Delete()
 * 작 성 자 : DHL
 * 작 성 일 : 2012-06-27
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : DHL
 * 작 성 일 : 2012-06-27
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
}

/**
 * btn_Excel()
 * 작 성 자 : DHL
 * 작 성 일 : 2012-06-27
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
}

/**
 * btn_Print()
 * 작 성 자 : DHL
 * 작 성 일 : 2012-06-27
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
	    var strStrCd        = LC_STR_CD.BindColVal;      //점코드
	    //var strStrNm        = LC_STR_CD.BindCol;            //점이름
	    var strSaleDtS      = EM_SALE_DT_S.text;         //시작일자
	    var strSaleDtE      = EM_SALE_DT_E.text;         //종료일자
	    var strPosNo        = EM_POSNO.text;             //POS 번호
	    var strHallCd		= LC_HALL_CD.BindColVal;	//관코드
	        
	    //var strCashierId    = EM_POSNO.text;           //POS 번호
	    
	    if (strPosNo.equals('')) {
	    	strPosNo = '전체';
	    }
	    
	    /*
	    if (strCashierId.equals('%')) {
	    	strCashierId = '전체';
	    }
	    */
	    
	    var parameters = "&strStrCd="  + strStrCd              //점코드
	                   //+ "&strStrNm="  + strStrNm              //점이름
	                   + "&strSaleDtS=" + strSaleDtS           //시작일자
	                   + "&strSaleDtE=" + strSaleDtS           //종료일자
	                   + "&strPosNo=" + strPosNo               //POS 번호
	                   + "&strHallCd=" + strHallCd				//관코드
	                   ; 
                   ;
    window.open("/dps/jsp/psal/psal5371.jsp?"+parameters,"OZREPORT", 1000, 700);	 
}

/**
 * btn_Conf()
 * 작 성 자 : DHL
 * 작 성 일 : 2012-06-27
 * 개    요 : 확정 처리
 * return값 : void
 */
function btn_Conf() {
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

/**
 * chkValidation(gbn)
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-14
 * 개    요 :  저장
 * return값 : void
 */
function chkValidation(gbn){
    switch (gbn){
    case "search" :

        //점 체크
        if (isNull(LC_STR_CD.BindColVal)==true ) {
            showMessage(Information, OK, "USER-1003","점");
            LC_STR_CD.focus();
            return false;
        }

        //매출일자
        if (isNull(EM_SALE_DT_S.text) ==true ) {
            showMessage(Information, OK, "USER-1003","매출시작일자"); 
            EM_SALE_DT_S.focus();
            return false;
        }
        //년월 자릿수, 공백 체크
        if (EM_SALE_DT_S.text.replace(" ","").length != 8 ) {
            showMessage(Information, OK, "USER-1027","매출시작일자","8");
            EM_SALE_DT_S.focus();
            return false;
        }
        if(!checkYYYYMMDD(EM_SALE_DT_S.text)){
        	showMessage(Information, OK, "USER-1004","매출시작일자");
            EM_SALE_DT_S.focus();
            return false;
        }
        	
        if (isNull(EM_SALE_DT_E.text) ==true ) {
            showMessage(Information, OK, "USER-1003","매출종료일자"); 
            EM_SALE_DT_E.focus();
            return false;
        }
        //년월 자릿수, 공백 체크
        if (EM_SALE_DT_E.text.replace(" ","").length != 8 ) {
            showMessage(Information, OK, "USER-1027","매출종료일자","8");
            EM_SALE_DT_E.focus();
            return false;
        }
        if(!checkYYYYMMDD(EM_SALE_DT_E.text)){
            showMessage(Information, OK, "USER-1004","매출종료일자");
            EM_SALE_DT_E.focus();
            return false;
        }
        
        if(!isBetweenFromTo(EM_SALE_DT_S.text, EM_SALE_DT_E.text)){
            showMessage(INFORMATION, OK, "USER-1015"); 
            EM_SALE_DT_S.focus();
            return false;
        }
        break;
   
    }
    return true;
}

 -->
</script>
</head>

<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                     *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                                                                          *-->
<!--*    1. TR Success 메세지 처리
<!--*    2. TR Fail 메세지 처리
<!--*    3. DataSet Success 메세지 처리
<!--*    4. DataSet Fail 메세지 처리
<!--*    5. DataSet 이벤트 처리
<!--*    6. 컴포넌트 이벤트 처리
<!--*************************************************************************-->
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
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<!----------------------- 2. TR Fail 메세지 처리  ----------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                      *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                         *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->
<comment id="_NSID_">
<!-- ====================Output용================== -->
    <!--[콤보]점코드 -->
    <object id="DS_STR_CD"   classid=<%= Util.CLSID_DATASET %>></object>
    <!--[콤보]관코드 -->
    <object id="DS_HALL_CD"   classid=<%= Util.CLSID_DATASET %>></object>
<!-- ====================Input용================== -->
<!-- ===========gauce.js 공통함수 호출용=========== -->
    <object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object>
	<object id="DS_I_COMMON" classid=<%= Util.CLSID_DATASET %>></object>
</comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
    <!-- ===========gauce.js 공통함수 호출용=========== -->
    <object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
        <param name="KeyName" value="Toinb_dataid4">
    </object>
</comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                     *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                         *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->
	<div id="testdiv" class="testdiv">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="PT01 PB03"><table width="100%" border="0"
						cellspacing="0" cellpadding="0" class="o_table">
						<tr>
							<td><table width="100%" border="0" cellpadding="0"
									cellspacing="0" class="s_table">
									<tr>
										<th width="50" class="point">점코드</th>
										<td width="100"><comment id="_NSID_"> <object
												id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95
												tabindex=1 align="absmiddle"></object> </comment> <script>_ws_(_NSID_);</script>
										</td>
										<th width="50" class="point">매출일자</th>
										<td width="210"><comment id="_NSID_"> <object
												id=EM_SALE_DT_S classid=<%=Util.CLSID_EMEDIT%> width=72
												tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
											<img src="/<%=dir%>/imgs/btn/date.gif"
											onclick="javascript:openCal('G',EM_SALE_DT_S)"
											align="absmiddle" /> ~ <comment id="_NSID_"> <object
												id=EM_SALE_DT_E classid=<%=Util.CLSID_EMEDIT%> width=72
												tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
											<img src="/<%=dir%>/imgs/btn/date.gif"
											onclick="javascript:if(EM_SALE_DT_E.Enable) openCal('G',EM_SALE_DT_E); "
											align="absmiddle" />
										</td>
										<th width="50" class="point">관코드</th>
										<td><comment id="_NSID_"> <object
												id=LC_HALL_CD classid=<%=Util.CLSID_LUXECOMBO%> width=105
												tabindex=1 align="absmiddle"></object> </comment> <script>_ws_(_NSID_);</script>
										</td>
										<th width="50">POS번호</th>
										<td width="105"><comment id="_NSID_"> <object id=EM_POSNO
												classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
												align="absmiddle"> </object> </comment> <script>_ws_(_NSID_);</script>
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
				<td>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td class="BD4A" width="100%"><iframe id="IFrame"
									width="100%" height="500" scrolling="no"
									style="overflow-y: hidden;" src=""></iframe>
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
