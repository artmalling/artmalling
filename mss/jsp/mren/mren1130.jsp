<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 임대관리 > 전력 시간대 관리
 * 작 성 일 : 2010.05.16
 * 작 성 자 : 신익수
 * 수 정 자 : 
 * 파 일 명 : MREN1130.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 전력 시간대 관리
 * 이    력 : 2010.05.16 (신익수) 신규작성
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
 * 작 성 일 : 2010.03.23
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){
    // Input Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_O_DUPKEYVALUE.setDataHeader('<gauce:dataset name="H_SEL_DUP_KEYVALUE"/>');
    registerUsingDataset('<%=((SessionInfo) session.getAttribute("sessionInfo")).getPGM_ID()%>'.toLowerCase(), "DS_IO_MASTER");
    
    //그리드 초기화
    gridCreate(); //마스터
    
    //콤보 초기화
    initComboStyle(LC_S_PWR_GB ,DS_LC_S_PWR_GB , "CODE^0^30,NAME^0^150", 1, PK); // [조회용]전력구분     
    initComboStyle(LC_S_MONTH ,DS_LC_S_MONTH , "CODE^0^30,NAME^0^80", 1, PK); // [조회용]월
    
    //시스템 코드 공통코드에서 가지고 오기
    getEtcCode("DS_LC_S_PWR_GB",   "D", "M101", "N", "N", LC_S_PWR_GB );        // [조회/등록용]전력구분
    getEtcCode("DS_LC_S_MONTH",   "D", "M100", "N", "N", LC_S_MONTH );        // [조회/등록용]월
    
    //그리드 공통 코드 가져오기
    getEtcCode("DS_PWR_GB",           "D", "M101", "N");    // 전력구분     
    getEtcCode("DS_MONTH",           "D", "M100", "N");    // 월   
    getEtcCode("DS_TIME",           "D", "M059", "N");    // 시간     
    getEtcCode("DS_TIME_ZONE",           "D", "M050", "N");    // 시간대     
    //DS_LC_S_PWR_KIND_CD.Filter();
    //getEtcCode("DS_PWR_TYPE",           "D", "M047", "N");    // 전압구분     
    //getEtcCode("DS_PWR_SEL_CHARGE",     "D", "M081", "N");    // 요금제구분     
    //getEtcCode("DS_TIME_ZONE",          "D", "M050", "N");    // 시간대     
    LC_S_PWR_GB.Focus();
    
    if (LC_S_PWR_GB.BindColVal == "2")  {
        LC_S_MONTH.Enable = false;
        LC_S_MONTH.BindColVal = "00";
    } else {
        LC_S_MONTH.Enable = true;
        LC_S_MONTH.BindColVal = "01";
    }
}
 
function gridCreate(){
	var hdrProperies = ''
		            + '<FC>ID={CURROW}     NAME="NO"  WIDTH=40      ALIGN=CENTER</FC>'
		            + '<FC>ID=TIME_FLAG    NAME="전력구분" WIDTH=150  ALIGN=LEFT    edit={IF(CHECKGB=T,"true","false")}  EDITSTYLE=LOOKUP    DATA="DS_PWR_GB:CODE:NAME"  </FC>'
		            + '<FC>ID=MONTH        NAME="월"      WIDTH=100  ALIGN=LEFT  edit={IF(CHECKGB=T,"true","false")}  EDITSTYLE=LOOKUP    DATA="DS_MONTH:CODE:NAME"  </FC>'
		            + '<FC>ID=TIME         NAME="시간"     WIDTH=100 ALIGN=LEFT  edit={IF(CHECKGB=T,"true","false")} EDITSTYLE=LOOKUP    DATA="DS_TIME:CODE:NAME"</FC>'
		            + '<FC>ID=TIME_ZONE    NAME="시간대"   WIDTH=80  ALIGN=LEFT  edit={IF(CHECKGB=T,"true","false")}  EDITSTYLE=LOOKUP    DATA="DS_TIME_ZONE:CODE:NAME"</FC>'
		        ;   
		            
	initGridStyle(GD_MASTER, "COMMON", hdrProperies, true);
	
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
 * 작 성 일 : 2010.03.23
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    if (DS_IO_MASTER.IsUpdated) {//변경데이터 있을 시 확인
        var ret = showMessage(Question, YesNo, "USER-1059");
        if (ret == "1") {
            var strTimeFlag  = LC_S_PWR_GB.BindColVal;    
            var strMonth = LC_S_MONTH.BindColVal;
            
            var goTo = "getPowerTime";
            var parameters = ""
                + "&strTimeFlag="    + encodeURIComponent(strTimeFlag)
                + "&strMonth="       + encodeURIComponent(strMonth);
            
            TR_MAIN.Action = "/mss/mren113.mr?goTo=" + goTo + parameters;
            TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
            TR_MAIN.Post();
        
            // 조회결과 Return
            setPorcCount("SELECT", GD_MASTER);
        } else {
            return;
        }
    }  else {
    	var strTimeFlag  = LC_S_PWR_GB.BindColVal;    
        var strMonth = LC_S_MONTH.BindColVal;
        
        var goTo = "getPowerTime";
        var parameters =  "&strTimeFlag="+ encodeURIComponent(strTimeFlag)
                         +"&strMonth="   + encodeURIComponent(strMonth)
                         ;
        TR_MAIN.Action = "/mss/mren113.mr?goTo=" + goTo + parameters;
        TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
        TR_MAIN.Post();   
        // 조회결과 Return
        setPorcCount("SELECT", GD_MASTER);
    }
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.23
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    if (DS_IO_MASTER.IsUpdated) {//변경 데이터가 있을때만 저장
    
        //필수 입력값,스크립트 중복 값 체크
	    if (!checkValidate()) return;
    
        //DB중복값제크
        if (!checkValidateDB()) {
            showMessage(INFORMATION, OK, "USER-1000", "등록 된 내역과 겹치는 사용구간이 존재합니다."); 
            return; 
        }

        //변경또는 신규 내용을 저장하시겠습니까?
        if( showMessage(INFORMATION, YESNO, "USER-1010") != 1 ){
            GD_MASTER.Focus();
            return;
        }
    
	    //저장
        var goTo = "save";
        TR_SAVE.Action = "/mss/mren113.mr?goTo=" + goTo;
        TR_SAVE.KeyValue = "SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)";
        TR_SAVE.Post();
    } else {
        showMessage(INFORMATION, OK, "USER-1028");
        return;
    }
}


/**
 * btn_AddRow()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.10
 * 개    요 : 행추가
 * return값 :
 */
function btn_AddRow() {
    DS_IO_MASTER.AddRow();
    GD_MASTER.SetColumn("TIME_FLAG");
}

/**
 * btn_DeleteRow()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.10
 * 개    요 : 행삭제
 * return값 :
 */
function btn_DeleteRow() {
	DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition); 
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 
/**
 * checkValidate()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.23
 * 개    요 : 값체크(저장)
 * return값 :
 */
function checkValidate() {
    // 필수 입력값 체크
    for (var n=1; n<=DS_IO_MASTER.CountRow; n++) {
        if (DS_IO_MASTER.RowStatus(n) != 0 ) {
            // 전력구분
            if (DS_IO_MASTER.NameValue(n,"TIME_FLAG") == "") {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("TIME_FLAG");
                showMessage(INFORMATION, OK, "USER-1002", "전력구분");
                return false;
            }

            // 월
            if (DS_IO_MASTER.NameValue(n,"MONTH") == "") {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("MONTH");
                showMessage(INFORMATION, OK, "USER-1002", "월");
                return false;
            }

            // 시간
            if (DS_IO_MASTER.NameValue(n,"TIME") == "") {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("TIME");
                showMessage(INFORMATION, OK, "USER-1002", "시간");
                return false;
            }
            
            // 시간대
            if (DS_IO_MASTER.NameValue(n,"TIME_ZONE") == "") {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("TIME_ZONE");
                showMessage(INFORMATION, OK, "USER-1002", "시간대");
                return false;
            }
        }
    }
	 
	// 중복값 체크 
	for (var i=1; i<=DS_IO_MASTER.CountRow; i++) {
        var tmpChkKeyVal = "" 
            + "" + DS_IO_MASTER.NameValue(i, "TIME_FLAG")
            + "" + DS_IO_MASTER.NameValue(i, "MONTH")
            + "" + DS_IO_MASTER.NameValue(i, "TIME");
        for (var k=i+1; k<=DS_IO_MASTER.CountRow; k++) {
			if (DS_IO_MASTER.RowStatus(k) == 1 ) { //신규건 체크
	            var insChkKeyVal = "" //용도구분, 전압구분, 요금제구분, 시간대
	                + "" + DS_IO_MASTER.NameValue(k, "TIME_FLAG")
	                + "" + DS_IO_MASTER.NameValue(k, "MONTH")
	                + "" + DS_IO_MASTER.NameValue(k, "TIME");
	            if (tmpChkKeyVal==insChkKeyVal) {
                    DS_IO_MASTER.RowPosition = k;
                    showMessage(INFORMATION, OK, "USER-1000", "["+i+"]번째 행과 신규행 ["+k+"]의 키값이 중복됩니다.");
                    return false;
	            }
			}
        }
	} 
	
    return true;
}

/**
 * checkValidateDB()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.23
 * 개    요 : 값체크(저장)
 * return값 :
 */
function checkValidateDB() {
	// 중복키값 색상초기화
	for (var j=1; j<=DS_IO_MASTER.CountRow; j++) {
	    DS_IO_MASTER.NameValue(j,"DUPCHK") = "N"; 
	}
	 
	var goTo = "getDupKeyValue";
	var parameters = "";
	
	TR_MAIN.Action = "/mss/mren113.mr?goTo=" + goTo + parameters;
	TR_MAIN.KeyValue = "SERVLET(O:DS_O_DUPKEYVALUE=DS_O_DUPKEYVALUE, I:DS_IO_MASTER=DS_IO_MASTER)";
	TR_MAIN.StatusResetType= "2"; //DS상태 초기화 하지 않음
	TR_MAIN.Post();
	
	if (DS_O_DUPKEYVALUE.CountRow < 1 ) {
	    return true;
	} else { 
	    for (var i=1; i<=DS_IO_MASTER.CountRow; i++) {
	        if (DS_IO_MASTER.RowStatus(i) == 1 ) { // 신규
	            var tmpKey = ""
                    + "" + DS_IO_MASTER.NameValue(k, "TIME_FLAG")
                    + "" + DS_IO_MASTER.NameValue(k, "MONTH")
                    + "" + DS_IO_MASTER.NameValue(k, "TIME");
	            for (var k=1; k<=DS_O_DUPKEYVALUE.CountRow; k++) {
	                if (DS_O_DUPKEYVALUE.NameValue(k,"DUPVALUE") == tmpKey) {
	                    DS_IO_MASTER.NameValue(i,"DUPCHK") = "Y";
	                } 
	            }
	        }
	    }
	    return false;
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

<script language=JavaScript for=TR_SAVE event=onSuccess>
    for(i=0;i<TR_SAVE.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_SAVE.SrvErrMsg('UserMsg',i));
    }
    
    //저장 후 재 조회
    btn_Search();
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
  /*  showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }*/
    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_SAVE event=onFail>
    /*showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_SAVE.ErrorCode + "\n" + "ErrorMsg  : " + TR_SAVE.ErrorMsg);
    for(i=1;i<TR_SAVE.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_SAVE.SrvErrMsg('GAUCE',i));
    }*/
    trFailed(TR_SAVE.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>
   //DS_TIME_ZONE.Filter(); // 시간대 필터링
</script>

<script language=JavaScript for=DS_PWR_GB event=OnFilter(row)>
// 요금제구분
if (DS_PWR_GB.NameValue(row,"CODE") == "1"||DS_PWR_GB.NameValue(row,"CODE") == "2") {// 
    return true;
} else { 
    return false;
}
</script>

<script language=JavaScript for=DS_TIME_ZONE event=OnFilter(row)>
// 시간대 필터링
DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"TIME_ZONE") = "";
if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "TIME_FLAG") == "2") { //용도구분이 산업용(을)
    if ((DS_TIME_ZONE.NameValue(row,"CODE").substr(0,1)) == "2") { // 심야,주간,저녁
        return true;
    } else { 
        return false;
    }
} else if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "TIME_FLAG") == "1") {//용도구분이 일반용(을) 산업용(병)
    if ((DS_TIME_ZONE.NameValue(row,"CODE").substr(0,1)) == "1") { // 경,중,최대부하 
        return true;
    } else { 
        return false;
    }
} else {
    if (DS_TIME_ZONE.NameValue(row,"CODE") == "00") {
        return true;
    } else { 
        return false;
    }
}
</script>

<script language=JavaScript for=DS_MONTH event=OnFilter(row)>
// 월 필터링

DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"MONTH") = "";

if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "TIME_FLAG") == "2") { //용도구분이 산업용(을)
    if ((DS_MONTH.NameValue(row,"CODE")) == "00") { // 심야,주간,저녁
        return true;
    } else { 
        return false;
    }
    
} else if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "TIME_FLAG") == "1")  {
    if ((DS_MONTH.NameValue(row,"CODE")) != "00") {
        return true;
    } else { 
        return false;
    }
} else {
	if (DS_MONTH.NameValue(row,"CODE") == "00") {
        return true;
    } else { 
        return false;
    }
}
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<script language=JavaScript for=LC_S_PWR_GB event=OnCloseUp()>
if (LC_S_PWR_GB.BindColVal == "2")  {
    LC_S_MONTH.Enable = false;
    LC_S_MONTH.BindColVal = "00";
} else {
	LC_S_MONTH.Enable = true;
	LC_S_MONTH.BindColVal = "01";
}
</script>

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
//그리드 정렬기능 
    sortColId( eval(this.DataID), row , colid );
</script>

<script language=JavaScript for=GD_MASTER event=OnCloseUp(row,colid)>
if (colid == "TIME_FLAG") {
    DS_TIME_ZONE.Filter(); // 월,시간대 필터링
    DS_MONTH.Filter();
} 
</script>

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝 
<!--*************************************************************************-->

<!--************************  *************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->
<!-- =============== Input용 -->
<comment id="_NSID_"><object id="DS_IO_MASTER"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_S_MONTH"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_S_PWR_GB"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_PWR_GB"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_MONTH"        classid=<%=Util.CLSID_DATASET%>>
<param name=UseFilter   value=true>
</object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_TIME"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_TIME_ZONE"    classid=<%=Util.CLSID_DATASET%>>
<param name=UseFilter   value=true>
</object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_O_DUPKEYVALUE"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- =============== Output용 -->

<!-- =============== ONLOAD용 -->
<!-- 필터사용 DATASET -->

<!-- =============== 공통함수용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_SAVE" classid=<%=Util.CLSID_TRANSACTION%>>
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
						<th width="80" class="point">전력구분</th>
						<td width="200" ><comment id="_NSID_"> <object
							id=LC_S_PWR_GB  classid=<%=Util.CLSID_LUXECOMBO%>
							width="190" height=100 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						
						<th width="80" class="point">월</th>
                        <td ><comment id="_NSID_"> <object
                            id=LC_S_MONTH  classid=<%=Util.CLSID_LUXECOMBO%>
                            width="140" height=100 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
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
    <tr>
        <td align="right"><img id="IMG_ADD_ROW"
            style="vertical-align: middle;" src="/<%=dir%>/imgs/btn/add_row.gif"
            width="52" height="18" onclick="btn_AddRow();" hspace="2" /><img
            id="IMG_DEL_ROW" style="vertical-align: middle;"
            src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18"
            onclick="btn_DeleteRow();" /></td>
    </tr>
    <tr>
        <td height="3"></td>
    </tr>
	<tr valign="top">
		<td align="left">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr valign="top">
				<td><comment id="_NSID_"><OBJECT id=GD_MASTER
					width=100% height=483 classid=<%=Util.CLSID_GRID%>>
					<param name="DataID" value="DS_IO_MASTER">
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

