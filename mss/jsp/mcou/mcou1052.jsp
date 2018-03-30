<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 상담/계약 > 상담관리 > 상담일지작성(신청내역상세pop) 
 * 작 성 일 : 2011.03.07
 * 작 성 자 : 김유완
 * 수 정 자 : 
 * 파 일 명 : mcou1052.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 신규상담처리(단변)
 * 이    력 : 2011.02.25 (김유완) 수정개발
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
	//session 정보
	SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
	String sess_org_cd_t = sessionInfo.getORG_CD();
	
    int tmplen = (10 - (sess_org_cd_t.length()));
    String sess_org_cd = sess_org_cd_t;
    for (int i=0; i<tmplen; i++) {
        sess_org_cd += "0";
    }
    
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
var strReqDt    = dialogArguments[0];
var strReqSeq   = dialogArguments[1];
var strToday    = getTodayFormat("yyyymmdd")
//Session ORG_CD
var session_org_cd = "";
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
	session_org_cd = document.getElementById('sess_org_cd').value;
    // Input Data Set Header 초기화
    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MO_COUNSELREQ_P"/>');
    
    // EMedit에 초기화
    initEmEdit(EM_RQ_COMPNM,    "GEN", READ);   // [상담신청]회사명
    initEmEdit(EM_RQ_REPNM,     "GEN", READ);   // [상담신청]대표자명
    initEmEdit(EM_RQ_DATE, "YYYYMMDD", READ);   // [상담신청]신청일자
    initEmEdit(EM_RQ_NAME,      "GEN", READ);   // [상담신청]신청인
    initEmEdit(EM_RQ_PHONE1_NO, "GEN", READ);   // [상담신청]전화번호1
    initEmEdit(EM_RQ_PHONE2_NO, "GEN", READ);   // [상담신청]전화번호2
    initEmEdit(EM_RQ_PHONE3_NO, "GEN", READ);   // [상담신청]전화번호3
    initEmEdit(EM_RQ_MOBILE_PH1,"GEN", READ);   // [상담신청]휴대폰번호1
    initEmEdit(EM_RQ_MOBILE_PH2,"GEN", READ);   // [상담신청]휴대폰번호2
    initEmEdit(EM_RQ_MOBILE_PH3,"GEN", READ);   // [상담신청]휴대폰번호3
    initEmEdit(EM_RQ_TITLE,     "GEN", READ);   // [상담신청]제목
    initEmEdit(EM_RQ_EMAIL,     "GEN", READ);   // [상담신청]Email
    initTxtAreaEdit(TXT_RQ_CONTEN,     READ);   // [상담신청]상담신청내역

    btn_Search();
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
    var goTo = "getListMaster";
    var parameters = ""
        + "&strReqDt="      + encodeURIComponent(strReqDt) // 신청일자
        + "&strReqSeq="     + encodeURIComponent(strReqSeq);// SEQ 
    TR_MAIN.Action = "/mss/mcou101.mu?goTo=" + goTo + parameters;
    TR_MAIN.KeyValue = "SERVLET(O:DS_O_MASTER=DS_O_MASTER)";
    TR_MAIN.Post();
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
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
}

/**
 * btn_Close()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 창닫기
 * return값 : void
 */

function btn_Close() {
	 window.close();
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
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
    showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_IO_DETAIL event=OnRowPosChanged(row)>
if(clickSORT) return;
if (DS_IO_DETAIL.CountRow > 0) {
	if (DS_IO_DETAIL.NameValue(row, "ANS_TYPE") == "4") {
	    enableControl(LC_RJT_REASON, true);
	} else {
	    enableControl(LC_RJT_REASON, false);
	    LC_RJT_REASON.DefaultString   = "==선택하세요==";
	    LC_RJT_REASON.Index = -1;
	}
}
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
//그리드 정렬기능
    if( row < 1) sortColId( eval(this.DataID), row , colid );
</script>

<script language=JavaScript for=EM_DELI_DT event=onKillFocus()>
//상담예정일 체크
checkDateTypeYMD( EM_DELI_DT );
</script>

<script language=JavaScript for= LC_ANS_TYPE event=OnSelChange()>
//답변유형에 따라 
if (DS_IO_DETAIL.CountRow > 0) {
    if (LC_ANS_TYPE.BindColVal == "4") { // 답변유형이 거절일경우 거절상세 활성화
        enableControl(LC_RJT_REASON, true);
    } else {
        enableControl(LC_RJT_REASON, false);
        LC_RJT_REASON.DefaultString   = "==선택하세요==";
        LC_RJT_REASON.Index = -1;
    }
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
<!-- ===============- Input용  -->
<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_MASTER"           classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- ONLOAD용 -->
<!-- ===============- 공통함수용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"           classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"           classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

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

<body onLoad="doInit();">

<input type=hidden id=sess_org_cd value=<%=sess_org_cd%>>   <!--Session ORG_CD Temp -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="pop01"></td>
        <td class="pop02"></td>
        <td class="pop03"></td>
    </tr>
    <tr>
        <td class="pop04"></td>
        <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="" class="title"><img
                            src="/<%=dir%>/imgs/comm/title_head.gif" width="15" height="13"
                            align="absmiddle" class="popR05 PL03" /> <SPAN id="title1"
                            class="PL03">상담신청 내역(상세)</SPAN></td>
                        <td>
                        <table border="0" align="right" cellpadding="0" cellspacing="0">
                            <tr>
                                <td><img src="/<%=dir%>/imgs/btn/close.gif" width="50"
                                    height="22" onClick="btn_Close();" /></td>
                            </tr>
                        </table>
                        </td>
                    </tr>
                </table>
                </td>
            </tr>
		    <tr>
		        <td height="10"></td>
		    </tr>
            <tr>
                <td class="popT01 PB03">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="o_table">
					<tr>
						<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0"
							class="s_table">
							<tr>
								<th width="70">회사명</th>
								<td width="170"><comment id="_NSID_"> <object id=EM_RQ_COMPNM
									classid=<%=Util.CLSID_EMEDIT%> width=165 align="absmiddle">
								</object> </comment><script>_ws_(_NSID_);</script></td>
								<th width="70">대표자명</th>
								<td width="265"><comment id="_NSID_"> <object id=EM_RQ_REPNM
									classid=<%=Util.CLSID_EMEDIT%> width=260 align="absmiddle">
								</object> </comment><script>_ws_(_NSID_);</script></td>
								<th width="70">신청일자</th>
								<td><comment id="_NSID_"> <object id=EM_RQ_DATE
									classid=<%=Util.CLSID_EMEDIT%> width=142 align="absmiddle">
								</object> </comment><script>_ws_(_NSID_);</script></td>
							</tr>
							<tr>
								<th>신청인</th>
								<td><comment id="_NSID_"> <object id=EM_RQ_NAME
									classid=<%=Util.CLSID_EMEDIT%> width=165 align="absmiddle">
								</object> </comment><script>_ws_(_NSID_);</script></td>
                                <th>Email</th>
                                <td><comment id="_NSID_"> <object id=EM_RQ_EMAIL
                                    classid=<%=Util.CLSID_EMEDIT%> width=260 align="absmiddle">
                                </object> </comment><script>_ws_(_NSID_);</script></td>
								<th>휴대폰번호</th>
								<td><comment id="_NSID_"> <object
									id=EM_RQ_MOBILE_PH1 classid=<%=Util.CLSID_EMEDIT%> width=40
									align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script> - <comment
									id="_NSID_"> <object id=EM_RQ_MOBILE_PH2
									classid=<%=Util.CLSID_EMEDIT%> width=40 align="absmiddle">
								</object> </comment><script>_ws_(_NSID_);</script> - <comment id="_NSID_">
								<object id=EM_RQ_MOBILE_PH3 classid=<%=Util.CLSID_EMEDIT%>
									width=40 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
							</tr>
							<tr>
								<th>제목</th>
								<td colspan="3"><comment id="_NSID_"> <object
									id=EM_RQ_TITLE classid=<%=Util.CLSID_EMEDIT%> width=520
									align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                                <th>전화번호</th>
                                <td><comment id="_NSID_"> <object
                                    id=EM_RQ_PHONE1_NO classid=<%=Util.CLSID_EMEDIT%> width=40
                                    align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script> - <comment
                                    id="_NSID_"> <object id=EM_RQ_PHONE2_NO
                                    classid=<%=Util.CLSID_EMEDIT%> width=40 align="absmiddle">
                                </object> </comment><script>_ws_(_NSID_);</script> - <comment id="_NSID_">
                                <object id=EM_RQ_PHONE3_NO classid=<%=Util.CLSID_EMEDIT%>
                                    width=40 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
							</tr>
							<tr>
								<th>상담신청내역</th>
								<td colspan="5"><comment id="_NSID_"> <object
									id=TXT_RQ_CONTEN classid=<%=Util.CLSID_TEXTAREA%> height=75
									width=100% tabindex=0 tabindex=1 align="absmiddle"> </object></comment> <script>_ws_(_NSID_);</script>
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
            </tr>
            <tr>
                <td height="2"></td>
            </tr>
        </table>
        </td>
        <td class="pop06"></td>
    </tr>
    <tr>
        <td class="pop07"></td>
        <td class="pop08"></td>
        <td class="pop09"></td>
    </tr>
</table>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BD_O_MASTER classid=<%=Util.CLSID_BIND%>>
        <param name=DataID          value=DS_O_MASTER>
        <param name="ActiveBind"    value=true>
        <param name=BindInfo        value='
        <c>Col=COMP_NAME        Ctrl=EM_RQ_COMPNM       param=Text</c>
        <c>Col=REP_NAME         Ctrl=EM_RQ_REPNM        param=Text</c>
        <c>Col=REQ_DT           Ctrl=EM_RQ_DATE         param=Text</c>
        <c>Col=REQ_NAME         Ctrl=EM_RQ_NAME         param=Text</c>
        <c>Col=PHONE1_NO        Ctrl=EM_RQ_PHONE1_NO    param=Text</c>
        <c>Col=PHONE2_NO        Ctrl=EM_RQ_PHONE2_NO    param=Text</c>
        <c>Col=PHONE3_NO        Ctrl=EM_RQ_PHONE3_NO    param=Text</c>
        <c>Col=MOBILE_PH1       Ctrl=EM_RQ_MOBILE_PH1   param=Text</c>
        <c>Col=MOBILE_PH2       Ctrl=EM_RQ_MOBILE_PH2   param=Text</c>
        <c>Col=MOBILE_PH3       Ctrl=EM_RQ_MOBILE_PH3   param=Text</c>
        <c>Col=TITLE            Ctrl=EM_RQ_TITLE        param=Text</c>
        <c>Col=EMAIL            Ctrl=EM_RQ_EMAIL        param=Text</c>
        <c>Col=REQ_CONTENT      Ctrl=TXT_RQ_CONTEN      param=Text</c>
        '>
</object>
</comment><script>_ws_(_NSID_);</script>
</body>
</html>

