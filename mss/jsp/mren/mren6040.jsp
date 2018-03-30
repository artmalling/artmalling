<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 임대관리 > CESBILLING > 주거세대 월관리비정산 
 * 작 성 일 : 2010.06.07
 * 작 성 자 : 김유완
 * 수 정 자 : 
 * 파 일 명 : MREN6040.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 주거세대 전출시 관리비를 정산한다.
 * 이    력 : 2010.06.07 (김유완)  신규개발 
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
	import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
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
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"
	type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--

/*************************************************************************
 * 0. 전역변수
 *************************************************************************/
 
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.06.07
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){
    // Input Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');
    
    //그리드 초기화
    gridCreate("MST");
    gridCreate("DTL");
    
    // EMedit에 초기화
    initComboStyle(LC_S_STR_CD,DS_S_FCL_FLAG,   "CODE^0^30,NAME^0^100", 1, PK); //[조회용]시설구분 
    initEmEdit(EM_S_CAL_YM,                     "YYYYMM",     PK);              //[조회]부과년월
    initEmEdit(EM_S_DONG,                       "000",        NORMAL);          //[조회]동 (조회)
    initEmEdit(EM_S_HO,                         "0000",       NORMAL);          //[조회]호 (조회)
    
    initComboStyle(LC_STR_CD,DS_S_FCL_FLAG,     "CODE^0^30,NAME^0^100", 1, PK); // 시설구분
    initEmEdit(EM_CAL_YM,                       "YYYYMM",     PK);              // 부과년월
    
    initEmEdit(EM_I_HUSE_ID,                    "GEN^20",     READ);            //세대주ID
    initEmEdit(EM_I_DONG,                       "GEN^3",      READ);            //동
    initEmEdit(EM_I_HO,                         "GEN^4",      READ);            //호
    initEmEdit(EM_I_HHOLD_NAME,                 "GEN^40",     READ);            //세대주명  
    initEmEdit(EM_I_PHONE1,                     "0000",       READ);            //전화번호1
    initEmEdit(EM_I_PHONE2,                     "0000",       READ);            //전화번호2
    initEmEdit(EM_I_PHONE3,                     "0000",       READ);            //전화번호3
    initEmEdit(EM_I_MOVE_IN_DT,                 "YYYYMMDD",   READ);            //전입일   
    initEmEdit(EM_I_MOVE_OUT_DT,                "YYYYMMDD",   READ);            //전출일  
    initEmEdit(EM_I_CNTR_AREA,                  "NUMBER^9^2", READ);            //면적 

    //시스템 코드 공통코드에서 가지고 오기
    getFlc("DS_S_FCL_FLAG",             "M", "2", "Y", "N");                                // [조회용]시설구분  
    
    //화면초기화
    EM_S_CAL_YM.Text = getTodayFormat("YYYYMM");
    LC_S_STR_CD.Index = 0; 
    LC_STR_CD.index = 0;
    LC_S_STR_CD.Focus();
    enableControl(IMG_MAIN_COST,false);//관리비정산
    
}

/**
 * gridCreate("대상그리드")
 * 작 성 자 : FKL
 * 작 성 일 : 2010.06.07
 * 개    요 : 그리드SET
 * return값 : void
 */
function gridCreate(grdGBN) {
    if (grdGBN == "MST") {
        
        var hdrProperies = ''
            + '<FC>ID={CURROW}      NAME=NO'         
            + '                                     WIDTH=30    ALIGN=CENTER</FC>'
            + '<FC>ID=HUSE_ID       NAME=세대ID'            
            + '                                     WIDTH=80    ALIGN=CENTER</FC>'
            + '<FC>ID=DONGHO        NAME=동호'            
            + '                                     WIDTH=120   ALIGN=LEFT MASK="XXX-XXXX"</FC>'
            + '<FC>ID=HHOLD_ID      NAME=HHOLD_ID'            
            + '                                     WIDTH=80    ALIGN=CENTER SHOW=FALSE</FC>'
            + '<FC>ID=STR_CD        NAME=STR_CD'        
            + '                                     WIDTH=130   WIDTH=80   ALIGN=CENTER  SHOW=FALSE </FC>'
            + '<FC>ID=MOVE_OUT_DT   NAME=MOVE_OUT_ID'        
            + '                                     WIDTH=130   WIDTH=80   ALIGN=CENTER  SHOW=FALSE </FC>'
            ;
            initGridStyle(GD_MASTER, "COMMON", hdrProperies, false);
    } else {
        
        var hdrProperies = ''
            + '<FC>ID={CURROW}      NAME=NO'         
            + '                                     WIDTH=30    ALIGN=CENTER</FC>'
            + '<FC>ID=MNTN_ITEM_CD  NAME=관리항목'            
            + '                                     WIDTH=200   ALIGN=CENTER    SHOW=FALSE</FC>'
            + '<FC>ID=MNTN_ITEM_NM  NAME=관리항목'        
            + '                                     WIDTH=225   ALIGN=CENTER</FC>'
            + '<FC>ID=USE_QTY       NAME=사용량'        
            + '                                     WIDTH=120   ALIGN=RIGHT     EDIT=NUMERIC </FC>'
            + '<FC>ID=USE_AMT       NAME=금액'        
            + '                                     WIDTH=120   ALIGN=RIGHT     EDIT=NUMERIC </FC>'
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
 * 작 성 일 : 2010.06.07
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	if (!checkValidateSearch()) return;
	
	var strStrCd     = LC_S_STR_CD.BindColVal;     // [조회용]시설구분
    var strCalYM     = EM_S_CAL_YM.Text;           // [조회용]세대주명
	var strDong      = EM_S_DONG.Text;             // [조회용]동
    var strHo        = EM_S_HO.Text;               // [조회용]호
    
    var goTo = "getMaster";
    var parameters = "&strStrCd="   + encodeURIComponent(strStrCd)
                   + "&strDong="    + encodeURIComponent(strDong)
                   + "&strHo="      + encodeURIComponent(strHo)
                   + "&strCalYM="   + encodeURIComponent(strCalYM);
    TR_MAIN.Action = "/mss/mren604.mr?goTo=" + goTo + parameters;
    TR_MAIN.KeyValue = "SERVLET(O:DS_O_MASTER=DS_O_MASTER)";
    TR_MAIN.Post();

    // 조회결과 Return
    setPorcCount("SELECT", GD_MASTER);
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
 * 작 성 일 : 2010.06.07
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {

}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.06.07
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {

}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.06.07
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.06.07
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 2010.06.07
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * getDetail()
 * 작 성 자 : 김유완
 * 작 성 일 : 2010-05-04
 * 개    요 : DETAIL조회
 * return값 : void
 */
function getDetail() { 
	var strCalYM     = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"CAL_YM");
	var strCntrId    = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"HHOLD_ID"); 
	var goTo       = "getDetail" ;    
	var parameters = "&strCalYM="  + encodeURIComponent(strCalYM)
	               + "&strCntrId=" + encodeURIComponent(strCntrId);
	TR_MAIN2.Action="/mss/mren604.mr?goTo="+goTo+parameters;  
	TR_MAIN2.KeyValue="SERVLET(O:DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
	TR_MAIN2.Post();
	setPorcCount("SELECT", DS_O_DETAIL.CountRow);   
}

/**
 * checkValidateSearch()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.06.07
 * 개    요 : 값체크
 * return값 :
 */
function checkValidateSearch() {
	if (LC_S_STR_CD.BindColVal == "") {
	    showMessage(INFORMATION, OK, "USER-1000", "시설(구분)을 선택하세요");
	    LC_S_STR_CD.Focus();
	    return false;
	}
    return true;
}

/**
* procCalculate()
* 작 성 자 : 
* 작 성 일 : 2010.06.07
* 개    요 : 월관리비정산
* return값 : void
*/
function procCalculate() {
    var strStrCd    = LC_STR_CD.BindColVal;     // 시설구분(점코드)
    var strCalYM    = EM_CAL_YM.Text;           // 부과년월
    var strCalY     = strCalYM.substring(0,4);
    var strCalM     = strCalYM.substring(5,6);
    var strDong      = EM_S_DONG.Text;          // [조회용]동
    var strHo        = EM_S_HO.Text;            // [조회용]호
     
    //관리비정산
    if( showMessage(INFORMATION, YESNO, "USER-1000", "이미 등록된 정보는 삭제되고 재생성됩니다."+strCalY+"년"+strCalM+"월 관리비 정산을 실행하시겠습니까?") != 1 ){
        return;
    }
    //조회조건동기화
    LC_S_STR_CD.BindColVal = LC_STR_CD.BindColVal;
    EM_S_CAL_YM.Text = EM_CAL_YM.Text;
    
    var goTo = "procCalculate";
    var parameters = ""
        + "&strStrCd="      + encodeURIComponent(strStrCd)
        + "&strCalYM="      + encodeURIComponent(strCalYM)
        + "&strDong="       + encodeURIComponent(strDong)
        + "&strHo="         + encodeURIComponent(strHo);
    TR_CAL.Action = "/mss/mren604.mr?goTo=" + goTo + parameters;
    TR_CAL.KeyValue = "SERVLET(O:DS_O_MASTER=DS_O_MASTER)";
    TR_CAL.Post();
    
    setPorcCount("SELECT", GD_MASTER);
}

/**
 * getCloseYN()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.06.07
 * 개    요 : 마감여부체크
 * return값 :
 */
function getCloseYN() {
	//마감체크
	if (LC_STR_CD.ValueOfIndex("MNTN_CAL_YN", LC_STR_CD.Index) == "Y") {
	    if (getCloseCheck("DS_CLOSE_YN", LC_STR_CD.BindColVal, EM_CAL_YM.Text, "MREN", "48", "0", "M") == "TRUE") {
	        enableControl(IMG_MAIN_COST,false);//관리비정산
	        var strCalY     = (EM_CAL_YM.Text).substring(0,4);
	        var strCalM     = (EM_CAL_YM.Text).substring(5,6);
	        showMessage(INFORMATION, OK, "USER-1000", "선택한 시설의 "+strCalY+"년"+strCalM+"월은 이미 정산마감 되었습니다.");
	        return true;
	    } else {
	        enableControl(IMG_MAIN_COST,true);//관리비정산
	        return false;
	    }
	} else {
	    enableControl(IMG_MAIN_COST,false);
	    return true;
	}
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

<script language=JavaScript for=TR_MAIN2 event=onSuccess>
    for(i=0;i<TR_MAIN2.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN2.SrvErrMsg('UserMsg',i));
    }
</script>

<script language=JavaScript for=TR_CAL event=onSuccess>
    for(i=0;i<TR_CAL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_CAL.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_MAIN2 event=onFail>
trFailed(TR_MAIN2.ErrorMsg);
</script>

<script language=JavaScript for=TR_CAL event=onFail>
trFailed(TR_CAL.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>
if(clickSORT)return;
if (row > 0 ) {  
	getDetail();
} else {
	DS_O_DETAIL.ClearData();
}
</script>

<script language=JavaScript for=DS_O_DETAIL event=OnRowPosChanged(row)>
if(clickSORT)return;
if (row < 1 ) {  
	DS_O_DETAIL.ClearData();
}    
</script>

<script language=JavaScript for=DS_O_MASTER event=CanRowPosChange(row)>
if (DS_O_MASTER.CountRow > 0) {
    if (DS_O_MASTER.RowStatus(row) == 3) { //데이터 변경시
        var ret = showMessage(Question, YesNo, "USER-1049");
        if (ret == "1") {
            rollBackRowData(DS_O_MASTER, row);
            return true;    
        } else {
            return false;   
        }
    }
    return true;
}
return true;
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    //정렬
    if (row == 0){
        sortColId(eval(this.DataID), row, colid);
    }    
</script>

<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    //정렬
    if (row == 0){
        sortColId(eval(this.DataID), row, colid);
    }    
</script>

<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
//마감여부체크
if (LC_STR_CD.ValueOfIndex("MNTN_CAL_YN", LC_STR_CD.Index) == "Y") {
    EM_CAL_YM.Enable     = true;
    //마감여부체크
    if (EM_CAL_YM.Text.length == 6) {
        if (getCloseYN()) return;//마감여부체크
    } else {
        enableControl(IMG_MAIN_COST,false);
    }
} else {
    showMessage(INFORMATION, OK, "USER-1000", "선택한 시설은 관리비 정산을 하지 않는 시설입니다.");
    enableControl(IMG_MAIN_COST,false);
    EM_CAL_YM.Text = "";
    EM_CAL_YM.Enable     = false;
    return;
}
</script>

<script language=JavaScript for=EM_CAL_YM event=OnKillFocus()>
//마감여부체크
if (EM_CAL_YM.Text.length == 6) {
    if (getCloseYN()) return;//마감여부체크
} else {
    enableControl(IMG_MAIN_COST,false);
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
<!-- 검색용 -->
<comment id="_NSID_">
<object id="DS_S_FCL_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_CLOSE_YN" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- 공통 -->
<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
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
<object id="TR_MAIN2" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_CAL" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

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
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th class="point" width="80">시설구분</th>
						<td width="133"><comment id="_NSID_"> <object
							id=LC_S_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width="130" 
							height=100 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th class="point" width="100">부과년월</th>
						<td width="115"><comment id="_NSID_"> <object
							id=EM_S_CAL_YM classid=<%=Util.CLSID_EMEDIT%> width=90
							onblur="javascript:checkDateTypeYM(this);" tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script><img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('M',EM_S_CAL_YM);" /></td>
						<th width="100">동호</th>
						<td ><comment id="_NSID_"> <object
							id=EM_S_DONG classid=<%=Util.CLSID_EMEDIT%> width="100"
							tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						- <comment id="_NSID_"> <object id=EM_S_HO
							classid=<%=Util.CLSID_EMEDIT%> width="100" tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
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
        <td>
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td class="PT01 PB03">
                <table width="460" border="0" cellpadding="0" cellspacing="0"
                    class="s_table">
                    <tr>
                        <th width="80" class="point">시설구분</th>
                        <td width="145"><comment id="_NSID_"><object
                            id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width="143" tabindex=1
                            align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script></td>
                        <th width="80" class="point">부과년월</th>
                        <td width="110"><comment id="_NSID_"><object
                            id=EM_CAL_YM classid=<%=Util.CLSID_EMEDIT%> width="85" tabindex=1
                            onblur="javascript:checkDateTypeYM(this);" align="absmiddle">
                        </object></comment><script>_ws_(_NSID_);</script><img
                            src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                            onclick="javascript:openCal('M',EM_CAL_YM);" /></td>
                    </tr>
                </table>
                </td>
                <td class="right"><img id="IMG_MAIN_COST"
                    src="/<%=dir%>/imgs/btn/maintenance_cost.gif" hspace="2" 
                    onclick="javascript:procCalculate();" /></td>
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
				<td width="270" class="PL05">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="BD4A">
					<tr>
						<td><comment id="_NSID_"><OBJECT id=GD_MASTER
							width=100% height=469 tabindex=1  classid=<%=Util.CLSID_GRID%>>
							<param name="DataID" value="DS_O_MASTER">
						</OBJECT></comment><script>_ws_(_NSID_);</script></td>
					</tr>
				</table>
				</td>
				<td width="5"></td>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
		                    <tr>
		                        <td class="PT10">
		                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
		                            <tr>
		                                <td class="sub_title"><img
		                                    src="/pot/imgs/comm/ring_blue.gif" class="PR03"
		                                    align="absmiddle" /> 세대정보</td>
		                            </tr>
		                        </table>
		                        </td>
		                    </tr>
                            <tr>
                                <td height="3"></td>
                            </tr>
							<tr>
								<td class="PT01 PB03">
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									class="s_table">
									<tr>
										<th width="80">세대ID</th>
										<td width="160"><comment id="_NSID_"> <object
											id=EM_I_HUSE_ID classid=<%=Util.CLSID_EMEDIT%> width=160
											tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
										<th width="80">동호</th>
										<td><comment id="_NSID_"> <object id=EM_I_DONG
											classid=<%=Util.CLSID_EMEDIT%> width="80" tabindex=1
											align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										- <comment id="_NSID_"> <object id=EM_I_HO
											classid=<%=Util.CLSID_EMEDIT%> width="80" tabindex=1
											align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
									</tr>
									<tr>
										<th>세대주명</th>
										<td><comment id="_NSID_"> <object
											id=EM_I_HHOLD_NAME classid=<%=Util.CLSID_EMEDIT%> width=160
											tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
										</td>
										<th>전화번호</th>
										<td><comment id="_NSID_"> <object
											id=EM_I_PHONE1 classid=<%=Util.CLSID_EMEDIT%> width=49
											tabindex=1 align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>-
										<comment id="_NSID_"> <object id=EM_I_PHONE2
											classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1
											align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>-
										<comment id="_NSID_"> <object id=EM_I_PHONE3
											classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1
											align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
										</td>
									</tr>
									<tr>
										<th>전입일</th>
										<td><object id=EM_I_MOVE_IN_DT
											classid=<%=Util.CLSID_EMEDIT%> width=160 tabindex=1
											align="absmiddle"> </object> </comment></td>
										<th class="point">전출일</th>
										<td><object id=EM_I_MOVE_OUT_DT
											classid=<%=Util.CLSID_EMEDIT%> width=170 tabindex=1
											onblur="javascript:checkDateTypeYMD(this);" align="absmiddle">
										</object> </comment></td>
									</tr>
									<tr>
										<th>면적</th>
										<td colspan="3"><comment id="_NSID_"> <object
											id=EM_I_CNTR_AREA classid=<%=Util.CLSID_EMEDIT%> width="160"
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
									</tr>
								</table>
								</td>
							</tr>
							<tr><td height=6></td></tr>
							<tr>
								<td class="PL02">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td class="PT02">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td class="sub_title" colspan="3"><img
													src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
													align="absmiddle" /> 월관리비정산 정보</td>
											</tr>
										</table>
										</td>
									</tr>
									<tr><td height=5></td></tr>
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="BD4A">
											<tr>
												<td><comment id="_NSID_"><OBJECT id=GD_DETAIL
													width=100% height=312 classid=<%=Util.CLSID_GRID%>> tabindex=1 
													<param name="DataID" value="DS_O_DETAIL">
												</OBJECT></comment><script>_ws_(_NSID_);</script></td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
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
<comment id="_NSID_">
<object id=BD_MASTER classid=<%=Util.CLSID_BIND%>>
    <param name=DataID value=DS_O_MASTER>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value=' 
        <c>Col=HUSE_ID      Ctrl=EM_I_HUSE_ID       param=Text</c>
        <c>Col=DONG         Ctrl=EM_I_DONG          param=Text</c>
        <c>Col=HO           Ctrl=EM_I_HO            param=Text</c>
        <c>Col=HHOLD_NAME   Ctrl=EM_I_HHOLD_NAME    param=Text</c>
        <c>Col=PHONE1_NO    Ctrl=EM_I_PHONE1        param=Text</c>
        <c>Col=PHONE2_NO    Ctrl=EM_I_PHONE2        param=Text</c>     
        <c>Col=PHONE3_NO    Ctrl=EM_I_PHONE3        param=Text</c>
        <c>Col=MOVE_IN_DT   Ctrl=EM_I_MOVE_IN_DT    param=Text</c> 
        <c>Col=MOVE_OUT_DT   Ctrl=EM_I_MOVE_OUT_DT  param=Text</c> 
        <c>Col=CNTR_AREA    Ctrl=EM_I_CNTR_AREA     param=Text</c>       
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>

</body>
</html>

