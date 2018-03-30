<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 회원관리 > 이력조회 > 주소변경이력조회 
 * 작 성 일 : 2012.05.22
 * 작 성 자 : kj
 * 수 정 자 : 
 * 파 일 명 : dctm4140.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        2012.05.22 (kj) 신규작성
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

    String strSsno = "EM_SS_NO_S";
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
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--
var strCompPersFlag = "P";
var strSdt    = "";
var strEdt    = "";
var strCustId = "";
var strCustNm = "";
var strCardNo = "";
var strSSNo   = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : kj
 * 작 성 일 : 2010-03-21
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 260;		//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID

function doInit(){

	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    // Input Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');  
    
    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate1(); //마스터
    initEmEdit(EM_CARD_NO_S,   "0000-0000-0000-0000", NORMAL);     //카드번호
    initEmEdit(EM_SS_NO_H,     "000000",     		  NORMAL);     //생년월일_hidden
    initEmEdit(EM_SS_NO_S,     "000000",      		 NORMAL);     //생년월일
    initEmEdit(EM_CUST_ID_S,   "GEN^9",               NORMAL);     //회원코드
    initEmEdit(EM_CUST_ID_H,   "GEN^9",               NORMAL);     //회원코드_hidden
    initEmEdit(EM_CUST_NAME_S, "GEN^40",              READ);       //회원명
    
    initEmEdit(EM_CUST_NAME,   "GEN^40",              READ);       //회원명 
    initEmEdit(EM_HOME_PH,     "GEN^40",              READ);       //자택전화
    initEmEdit(EM_HOME_PH1,    "GEN^40",              READ);       //자택전화hidden
    initEmEdit(EM_HOME_PH2,    "GEN^40",              READ);       //자택전화hidden
    initEmEdit(EM_HOME_PH3,    "GEN^40",              READ);       //자택전화hidden
    initEmEdit(EM_MOBILE_PH,   "GEN^40",              READ);       //이동전화 
    initEmEdit(EM_MOBILE_PH1,  "GEN^40",              READ);       //이동전화 hidden
    initEmEdit(EM_MOBILE_PH2,  "GEN^40",              READ);       //이동전화 hidden
    initEmEdit(EM_MOBILE_PH3,  "GEN^40",              READ);       //이동전화 hidden
    initEmEdit(EM_SS_NO,       "000000",    		  READ);       //생년월일
    initEmEdit(EM_HOME_ADDR,   "GEN^400",             READ);       //회원주소 
    initEmEdit(EM_POINT,       "NUMBER^9^0",          READ);       //누적포인트
//     initEmEdit(EM_OCCURS_POINT,"NUMBER^9^0",          READ);       //발생포인트
//     initEmEdit(EM_SUM_POINT,   "NUMBER^9^0",          READ);       //누적+발생포인트
    initEmEdit(EM_EMAIL,       "GEN^80",              READ);       //이메일주소
    initEmEdit(EM_EMAIL1,      "GEN^80",              READ);       //이메일주소hidden
    initEmEdit(EM_EMAIL2,      "GEN^80",              READ);       //이메일주소hidden
    initEmEdit(EM_CUST_GTADE,  "GEN^40",              READ);       //회원등급
    initEmEdit(EM_CUST_TYPE,   "GEN^40",     		  READ);       //회원유형
    initEmEdit(EM_ENTR_DT,    "YYYYMMDD",             READ);       //가입일자 추가 16.12.22
 
    //활성화 비활성화 화면 초기 설정
    EM_HOME_PH1.style.display    = "none";
    EM_HOME_PH2.style.display    = "none"; 
    EM_HOME_PH3.style.display    = "none";
    EM_MOBILE_PH1.style.display  = "none";
    EM_MOBILE_PH2.style.display  = "none";
    EM_MOBILE_PH3.style.display  = "none";
    EM_EMAIL1.style.display      = "none"; 
    EM_EMAIL2.style.display      = "none";
    EM_CUST_ID_H.style.display   = "none";
    EM_CARD_NO_H.style.display   = "none";
    EM_SS_NO_H.style.display     = "none";
        
    document.getElementById('titleSsno').innerHTML = "생년월일";
    document.getElementById('titleCust').innerHTML = "회원명";
    
    //조회일자 초기값.
    initEmEdit(EM_S_DT_S,              "YYYYMMDD", PK);     //시작일
    initEmEdit(EM_E_DT_S,              "YYYYMMDD", PK);     //종료일
    
    
    EM_S_DT_S.text = <%= fromDate %>;
    EM_E_DT_S.text = <%= toDate %>;      
    
    EM_CARD_NO_S.Focus();
}
 
function gridCreate1(){
    var hdrProperies = '<FC>id={currow}     name="NO"            	width=30    align=center</FC>'
			        + '<FC>id=CUST_ID      	name="회원ID"         	width=90    align=center</FC>'
			        + '<FC>id=CUST_NAME    	name="회원명"         	width=90    align=left</FC>'
			        + '<FC>id=JUSO_GBN     	name="주소구분"         	width=90    align=center</FC>'
			        + '<FC>id=BF_ZIP_CD     name="변경전 우편번호"  	width=100  	align=center mask="XXX-XXX"</FC>'
			        + '<FC>id=BF_ADDR     	name="변경전 주소"  		width=300   align=left</FC>'
			        + '<FC>id=AFT_ZIP_CD    name="변경후 우편번호"  	width=100   align=center mask="XXX-XXX"</FC>'
			        + '<FC>id=AFT_ADDR    	name="변경후 주소"  		width=300   align=left</FC>'
			        + '<FC>id=MOD_DATE     	name="수정일시"        	width=145   align=center mask="XXXX/XX/XX XX:XX:XX"</FC>'
			        + '<FC>id=MOD_ID       	name="수정자ID"        	width=90   	align=left </FC>'
			        + '<FC>id=USER_NAME    	name="수정자명"        	width=90   	align=left</FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
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
 * 작 성 자 : kj
 * 작 성 일 : 2010-03-29
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
     
    if(trim(EM_SS_NO_S.Text).length == 0 && trim(EM_CUST_ID_S.Text).length == 0 
            && trim(EM_CARD_NO_S.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1000",  "조회시 [카드번호],[생년월일],[회원명] 중 1개는  반드시 입력해야 합니다.");
        EM_CARD_NO_S.Focus();
        return;
    }
    
    srchEvent('%');
    
    if (trim(EM_S_DT_S.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "시작일자");
        EM_S_DT_S.Focus();
        return;
    } else if (trim(EM_E_DT_S.text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1003",  "종료일자");
        EM_E_DT_S.Focus();
        return;
    }     
    
    if (eval(strSdt) > eval(strEdt) )
    {
        showMessage(EXCLAMATION, OK, "USER-1015",  "종료일자");
        EM_E_DT_S.Focus();
        return;     
    }
    
    strSdt    = EM_S_DT_S.text;
    strEdt    = EM_E_DT_S.text;
    strCustId = EM_CUST_ID_S.text;
    strCustNm = EM_CUST_NAME_S.text;
    strCardNo = EM_CARD_NO_S.text;
    strSSNo   = EM_SS_NO_S.text;
    
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strSdt="       + encodeURIComponent(strSdt)
                    + "&strEdt="       + encodeURIComponent(strEdt)                    
                    + "&strCustId="    + encodeURIComponent(strCustId)
                    + "&strCardNo="    + encodeURIComponent(strCardNo)
                    + "&strSSNo="      + encodeURIComponent(strSSNo);            

    TR_MAIN.Action  = "/dcs/dctm414.dm?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();          

    setPorcCount("SELECT", DS_O_MASTER.CountRow);
    
    if (DS_O_MASTER.CountRow > 0 )
        GD_MASTER.Focus();
    else 
        EM_CARD_NO_S.Focus();          
}

/**
 * btn_Excel()
 * 작 성 자 : kj
 * 작 성 일 : 2010-03-29
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

    var ExcelTitle = "주소변경이력 조회"
    var parameters = "조회일자="   + strSdt + "~" + strEdt
                   + " -카드번호=" + strCardNo
                   + " -생년월일=" + strSSNo
                   + " -회원명ID=" + strCustId
                   + " -회원명="   + strCustNm;
    //openExcel2(GD_MASTER, ExcelTitle, parameters, true );
    openExcel5(GD_MASTER, ExcelTitle, parameters, true , "",g_strPid );

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

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
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 회원ID onKillFocus() -->
<script language=JavaScript for=EM_CUST_ID_S event=onKillFocus()>
    if ((EM_CUST_ID_S.Modified) && (EM_CUST_ID_S.Text.length != 9)) {
        EM_CUST_NAME_S.Text = ""; 
        EM_CUST_ID_S.Text   = ""; 
        EM_CARD_NO_H.Text   = "";
        EM_SS_NO_H.Text     = "";
    } 
</script>

<!-- 조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_S_DT_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_S_DT_S)){
        EM_S_DT_S.text = <%=fromDate%>;
    }
</script>
    
<!-- 조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_E_DT_S event=onKillFocus()>
    if(!checkDateTypeYMD(EM_E_DT_S)){
        initEmEdit(EM_E_DT_S,    "TODAY",     PK);         
    }
</script>  

<script language=JavaScript for=EM_CUST_ID_S
	event=onKeyDown(kcode,scode)>
    if (!(kcode == 13 || kcode == 9)) EM_CUST_NAME_S.Text = "";
</script>

<!-- Grid sorting 기능  -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                         *-->
<!--*    1. DataSet                                                         *-->
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_CUSTDETAIL" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- 공통함수용  -->
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_MASTER");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
	var obj   = document.getElementById("GR_DETAIL");
}
</script>

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
		<!-- 회원정보 공통 -->
		<%@ include file="/jsp/common/cmemSearch.jsp"%>
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="o_table">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="80" class="point">조회일자</th>
						<td><comment id="_NSID_"> <object id=EM_S_DT_S
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_S_DT_S)" />- <comment
							id="_NSID_"> <object id=EM_E_DT_S
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_E_DT_S)" /></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
		<tr>
		<td class="dot"></td>
    </tr>
		 <%@ include file="/jsp/common/memView.jsp"%>
		<!-- 회원정보 공통 // -->
	<tr valign="top">
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><object id=GD_MASTER width="100%" height=630
					classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_MASTER">
				</object></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BD_CUSTDETAIL classid=<%= Util.CLSID_BIND %>>
	<param name=DataID value=DS_O_CUSTDETAIL>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
            <c>col=CUST_NAME     ctrl=EM_CUST_NAME    Param=Text</c>
            <c>col=HOME_PH1      ctrl=EM_HOME_PH1     Param=Text</c>
            <c>col=HOME_PH2      ctrl=EM_HOME_PH2     Param=Text</c>
            <c>col=HOME_PH3      ctrl=EM_HOME_PH3     Param=Text</c>
            <c>col=MOBILE_PH1    ctrl=EM_MOBILE_PH1   Param=Text</c>
            <c>col=MOBILE_PH2    ctrl=EM_MOBILE_PH2   Param=Text</c>
            <c>col=MOBILE_PH3    ctrl=EM_MOBILE_PH3   Param=Text</c>
            <c>col=SS_NO         ctrl=EM_SS_NO        Param=Text</c>
            <c>col=HOME_ADDR     ctrl=EM_HOME_ADDR    Param=Text</c>
            <c>col=POINT         ctrl=EM_POINT        Param=Text</c>
            <c>col=OCCURS_POINT  ctrl=EM_OCCURS_POINT Param=Text</c>
            <c>col=EMAIL1        ctrl=EM_EMAIL1       Param=Text</c>
            <c>col=EMAIL2        ctrl=EM_EMAIL2       Param=Text</c>
            <c>col=GRADE_NAME    ctrl=EM_CUST_GTADE   Param=Text</c>
            <c>col=CUST_TYPE_NM  ctrl=EM_CUST_TYPE    Param=Text</c>
            <c>col=ENTR_DT  	 ctrl=EM_ENTR_DT     Param=Text</c> 
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>
