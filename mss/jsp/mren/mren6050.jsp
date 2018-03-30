<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > CES Billing > 메인계량기사용량조회
 * 작 성 일 : 2010.06.17
 * 작 성 자 : 김유완
 * 수 정 자 : 
 * 파 일 명 : MREN6050.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 메인계량기사용량조회
 * 이    력 : 2010.06.17 (김유완) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"   %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"          prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"       prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"           prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"        prefix="button" %>

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
<script language="javascript" src="/<%=dir%>/js/common.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"     type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"   type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작 
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.21
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){
    // Input Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MR_MGAUGUSED"/>');
    
    //그리드 초기화
    gridCreate("10"); //마스터
    
    //콤보 초기화
    initComboStyle(LC_S_GAUG_TYPE,DS_S_GAUG_TYPE,       "CODE^0^30,NAME^0^100", 1, PK);     // [조회용]]계량기구분   
    initEmEdit(EM_S_CAL_SYMD,                           "YYYYMMDD", PK);                    // [조회용]기간(FROM)
    initEmEdit(EM_S_CAL_EYMD,                           "YYYYMMDD", PK);                    // [조회용]기간(TO)
    
    //시스템 코드 공통코드에서 가지고 오기 
    EM_S_CAL_SYMD.Text = getTodayFormat("YYYYMMDD"); 
    EM_S_CAL_EYMD.Text = getTodayFormat("YYYYMMDD");
    getEtcCode("DS_S_GAUG_TYPE",                        "D", "M039", "N", "N", LC_S_GAUG_TYPE); // [조회용]계량기구분  
    DS_S_GAUG_TYPE.Filter();  //전압필터링
    LC_S_GAUG_TYPE.Focus();
    LC_S_GAUG_TYPE.index = 0; // [조회용]계량기구분  
    LC_S_GAUGE_GBN.index = 0; // [조회용]기간구분
    LC_S_GAUGE_GBN.className             = "combo_pk"; //조회구분 
    setObjTypeStyle( LC_S_GAUGE_GBN, "COMBO", PK );
}

function gridCreate(gdGnb){
	//마스터그리드
	if (gdGnb == "10") {
	    var hdrProperies = ''
	        + '<FC>ID={CURROW}     NAME="NO"'
	        + '                                         WIDTH=30   ALIGN=CENTER </FC>'
	        + '<FC>ID=DT           NAME="일자"'
	        + '                                         WIDTH=75   ALIGN=CENTER MASK="XXXX/XX/XX"</FC>'
	        + '<FC>ID=TIME_ZONE    NAME="시간"'
	        + '                                         WIDTH=75   ALIGN=CENTER </FC>' 
	        + '<R>'
            + '<G>                            name=$xkeyname_$$'
            + '<C>id=N_DEFAMT_$$         name="일반용기본요금"          width=120    align=right    mask="###,###"    </C>'
            + '<C>id=N_USEQTY_$$         name="일반용사용량"            width=120    align=right    mask="###,###"    </C>'
            + '<C>id=N_USEAMT_$$         name="일반용사용요금"          width=120    align=right    mask="###,###"    </C>'

            + '<C>id=I_DEFAMT_$$         name="산업용기본요금"          width=120    align=right    mask="###,###"    </C>'
            + '<C>id=I_USEQTY_$$         name="산업용사용량"            width=120    align=right    mask="###,###"    </C>'
            + '<C>id=I_USEAMT_$$         name="산업용사용요금"          width=120    align=right    mask="###,###"    </C>'

            + '<C>id=E_DEFAMT_$$         name="기타기본요금"          width=120    align=right    mask="###,###"    </C>'
            + '<C>id=E_USEQTY_$$         name="기타사용량"            width=120    align=right    mask="###,###"    </C>'
            + '<C>id=E_USEAMT_$$         name="기타사용요금"          width=120    align=right    mask="###,###"    </C>'
            + '</G>'
            + '</R>'   
	        ;   
	    initGridStyle(GD_MASTER, "COMMON", hdrProperies, false);
	}
	else if(gdGnb == "20") {
		var hdrProperies = ''
            + '<FC>ID={CURROW}     NAME="NO"'
            + '                                         WIDTH=30   ALIGN=CENTER </FC>'
            + '<FC>ID=DT           NAME="일자"'
            + '                                         WIDTH=75   ALIGN=CENTER MASK="XXXX/XX/XX"</FC>'
            + '<FC>ID=TIME_ZONE    NAME="시간"'
            + '                                         WIDTH=75   ALIGN=CENTER </FC>' 
            + '<R>'
            + '<G>                            name=$xkeyname_$$'
            + '<C>id=N_DEFAMT_$$         name="주택용기본요금"          width=120    align=right    mask="###,###"    </C>'
            + '<C>id=N_USEQTY_$$         name="주택용사용량"            width=120    align=right    mask="###,###"    </C>'
            + '<C>id=N_USEAMT_$$         name="주택용사용요금"          width=120    align=right    mask="###,###"    </C>'

            + '<C>id=I_DEFAMT_$$         name="업무용기본요금"          width=120    align=right    mask="###,###"    </C>'
            + '<C>id=I_USEQTY_$$         name="업무용사용량"            width=120    align=right    mask="###,###"    </C>'
            + '<C>id=I_USEAMT_$$         name="업무용사용요금"          width=120    align=right    mask="###,###"    </C>'

            + '<C>id=E_DEFAMT_$$         name="공공기본요금"          width=120    align=right    mask="###,###"    </C>'
            + '<C>id=E_USEQTY_$$         name="공공사용량"            width=120    align=right    mask="###,###"    </C>'
            + '<C>id=E_USEAMT_$$         name="공공사용요금"          width=120    align=right    mask="###,###"    </C>'
            + '</G>'
            + '</R>'   
            ;   
        initGridStyle(GD_MASTER, "COMMON", hdrProperies, false);
	} 
    else {
    	DS_IO_MASTER.GroupExpr = "DT:TIME_ZONE,STR_NM,:N_DEFAMT:N_USEQTY:N_USEAMT";
    	
    	var hdrProperies = ''
            + '<FC>ID={CURROW}     NAME="NO"'
            + '                                         WIDTH=30   ALIGN=CENTER </FC>'
            + '<FC>ID=DT           NAME="일자"'
            + '                                         WIDTH=75   ALIGN=CENTER MASK="XXXX/XX/XX"</FC>'
            + '<FC>ID=TIME_ZONE    NAME="시간"'
            + '                                         WIDTH=75   ALIGN=CENTER </FC>' 
            + '<R>'
            + '<G>                            name=$xkeyname_$$'
            + '<C>id=N_DEFAMT_$$         name="증기기본요금"          width=120    align=right    mask="###,###"    </C>'
            + '<C>id=N_USEQTY_$$         name="증기사용량"            width=120    align=right    mask="###,###"    </C>'
            + '<C>id=N_USEAMT_$$         name="증기사용요금"          width=120    align=right    mask="###,###"    </C>' 
            + '</G>'
            + '</R>'   
            ;   
        initGridStyle(GD_MASTER, "COMMON", hdrProperies, false);
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
 * 작 성 일 : 2010.03.21
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() { 
    var strGaugTp   = LC_S_GAUG_TYPE.BindColVal;    // [조회용]계량기구분
    var strSYmd     = EM_S_CAL_SYMD.Text;           // [조회용]부가년월(시작)
    var strEYmd     = EM_S_CAL_EYMD.Text;           // [조회용]부가년월(종료)
    var strGbn      = LC_S_GAUGE_GBN.BindColVal;    // [조회용]조회구분
    
    if (!checkValidateSearch()) return;
    gridCreate(strGaugTp);
    
    var goTo = "getMaster";
    var parameters = "&strGaugTp="  + encodeURIComponent(strGaugTp)
                   + "&strSYmd="    + encodeURIComponent(strSYmd)
                   + "&strGbn="     + encodeURIComponent(strGbn)
                   + "&strEYmd="    + encodeURIComponent(strEYmd);
    TR_MAIN.Action = "/mss/mren605.mr?goTo=" + goTo + parameters;
    TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
    TR_MAIN.Post();

    // 조회결과 Return
    setPorcCount("SELECT", GD_MASTER);
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
	var ExcelTitle = "메인계량기사용량조회 "        
	    var excel_gaug_tp  = LC_S_GAUG_TYPE.Text;
	    var excel_sGoal  = EM_S_CAL_SYMD.Text;
	    var excel_eGoal  = EM_S_CAL_EYMD.Text;
	    var parameters = "계량기구분="    +excel_gaug_tp
	                   + " - 조회구분=" + LC_S_GAUGE_GBN.Text
	                   + " - 부과년월/일(시작~종료)=" + excel_sGoal + " ~ " + excel_eGoal
	    
	    openExcel2(GD_MASTER, ExcelTitle, parameters, true );
	    GD_MASTER.Focus();
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

 /**
  * checkValidateSearch()
  * 작 성 자 : FKL
  * 작 성 일 : 2010.05.26
  * 개    요 : 값체크(조회시)
  * return값 :
  */
 function checkValidateSearch() {
     // 계량기구분
     if (LC_S_GAUG_TYPE.BindColVal == "" ) {
         showMessage(INFORMATION, OK, "USER-1002", "계량기구분");
         LC_S_GAUG_TYPE.Focus();
         return false;
     } 
     
     //부과년월 조회조건 체크
     if (EM_S_CAL_SYMD.Text > EM_S_CAL_EYMD.Text) {
         showMessage(INFORMATION, OK, "USER-1000", "조회시작(일/월)이 종료일보다 작아야 합니다.");
         EM_S_CAL_SYMD.Focus();
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

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
  <script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>
    if(clickSORT)return;
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
//그리드 정렬기능
    if( row < 1) sortColId( eval(this.DataID), row , colid );
</script>
<script language=JavaScript for=DS_S_GAUG_TYPE event=OnFilter(row)> 
	if(DS_S_GAUG_TYPE.NameValue(row,"CODE") == "10" || DS_S_GAUG_TYPE.NameValue(row,"CODE") == "20" ||
			DS_S_GAUG_TYPE.NameValue(row,"CODE") == "30" || DS_S_GAUG_TYPE.NameValue(row,"CODE") == "40") {
		return true;
	}
	else {
		return false;
	} 
</script>

<script language=JavaScript for=LC_S_GAUGE_GBN event=OnSelChange()>
if (LC_S_GAUGE_GBN.BindColVal == '3') {
    initEmEdit(EM_S_CAL_SYMD,                           "YYYYMM", PK);      // [조회용]기간(FROM)
    initEmEdit(EM_S_CAL_EYMD,                           "YYYYMM", PK);      // [조회용]기간(TO)
    EM_S_CAL_SYMD.Text = getTodayFormat("YYYYMM"); 
    EM_S_CAL_EYMD.Text = getTodayFormat("YYYYMM");
} else {
    initEmEdit(EM_S_CAL_SYMD,                           "YYYYMMDD", PK);    // [조회용]기간(FROM)
    initEmEdit(EM_S_CAL_EYMD,                           "YYYYMMDD", PK);    // [조회용]기간(TO)
    EM_S_CAL_SYMD.Text = getTodayFormat("YYYYMMDD"); 
    EM_S_CAL_EYMD.Text = getTodayFormat("YYYYMMDD");
}

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
<!-- =============== Input용 -->
<comment id="_NSID_"><object id="DS_IO_MASTER"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_MASTER_CROSSTAB" classid=<%=Util.CLSID_DATASET%>>
    <param name=DataID      value="DS_IO_MASTER">
    <param name=Logical     value="true">
    <param name=GroupExpr   value="DT:TIME_ZONE,STR_NM,:N_DEFAMT:N_USEQTY:N_USEAMT:I_DEFAMT:I_USEQTY:I_USEAMT:E_DEFAMT:E_USEQTY:E_USEAMT"></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- =============== Output용 -->
<comment id="_NSID_"><object id="DS_S_GAUG_TYPE"  classid=<%=Util.CLSID_DATASET%>> 
<param name=UseFilter   value=true>
</object></comment><script>_ws_(_NSID_);</script>
 
<!-- =============== 공통함수용 -->
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
 
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝 
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작 
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
						<th width="70" calss="point" >계량기구분</th>
                        <td width="130" ><comment id="_NSID_"> <object
                            id=LC_S_GAUG_TYPE classid=<%=Util.CLSID_LUXECOMBO%> width="127"
                            tabindex=1 height=100 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
                        </td>
						<th width="80" class="point">기간구분</th>
						<td width="130"><comment id="_NSID_"> <object id=LC_S_GAUGE_GBN
                            classid=<%=Util.CLSID_LUXECOMBO%> width="127" height=20
                            tabindex=1 align="absmiddle">
                            <param name=CBData value="1^시간,2^일,3^월">  
                            <param name=CBDataColumns value="CODE,NAME">
                            <param name=SearchColumn value="NAME">
                            <param name=ListExprFormat value="CODE^0^30,NAME^0^100">
                            <param name=InheritColor  value="true"> 
                            <param name=FontSiz value="9">
                            <param name=FontSiz value="돋움">
                            <param name=className value="combo">
                            <param name=BindColumn value="CODE">
                        </object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="80" class="point">기간</th>
						<td><comment id="_NSID_"><object id=EM_S_CAL_SYMD
                            classid=<%=Util.CLSID_EMEDIT%> width="80" tabindex=1
                            onblur="javascript:if(LC_S_GAUGE_GBN.BindColVal=='3'){checkDateTypeYM(this);}else{checkDateTypeYMD(this);}" align="absmiddle">
                        </object></comment><script>_ws_(_NSID_);</script><img
                            src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                            onclick="javascript:if(LC_S_GAUGE_GBN.BindColVal=='3'){openCal('M',EM_S_CAL_SYMD);}else{openCal('G',EM_S_CAL_SYMD);}" /> ~ <comment id="_NSID_"><object id=EM_S_CAL_EYMD
                            classid=<%=Util.CLSID_EMEDIT%> width="80" tabindex=1
                            onblur="javascript:if(LC_S_GAUGE_GBN.BindColVal=='3'){checkDateTypeYM(this);}else{checkDateTypeYMD(this);}" align="absmiddle">
                        </object></comment><script>_ws_(_NSID_);</script><img
                            src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                            onclick="javascript:if(LC_S_GAUGE_GBN.BindColVal=='3'){openCal('M',EM_S_CAL_EYMD);}else{openCal('G',EM_S_CAL_EYMD);}" /></td>
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
	<tr>
		<td height="1"></td>
	</tr>
	<tr valign="top">
		<td align="left">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr valign="top">
				<td><comment id="_NSID_"><OBJECT id=GD_MASTER
					width=100% height=503 classid=<%=Util.CLSID_GRID%>>
					<param name="DataID" value="DS_IO_MASTER_CROSSTAB">
				</OBJECT></comment><script>_ws_(_NSID_);</script></td>
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

