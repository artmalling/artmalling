<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 상담/계약 > 상담관리 > 바이어 변경(POP)
 * 작 성 일 : 2011.02.25
 * 작 성 자 : 김유완
 * 수 정 자 : 
 * 파 일 명 : mcou1012.jsp
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
var strBuyerCd  = dialogArguments[2];
var strToday    = getTodayFormat("yyyymmdd")
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
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_CHANGE_BUYER"/>');
    // Output Data Set Header 초기화

    // EMedit에 초기화
    initEmEdit(EM_BUYER_CD, "NUMBER3^6^2",NORMAL); // 바이어코드
    initEmEdit(EM_BUYER_NM, "GEN",READ);           // 바이어명
    //콤보 초기화
    initComboStyle(LC_SEL_STR_CD,DS_LC_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);       // 점코드     
    initComboStyle(LC_SEL_DEPT_CD,DS_LC_DEPT_CD, "CODE^0^30,NAME^0^80", 1, NORMAL); // 팀     
    initComboStyle(LC_SEL_TEAM_CD,DS_LC_TEAM_CD, "CODE^0^30,NAME^0^80", 1, NORMAL); // 파트    
    initComboStyle(LC_SEL_PC_CD,DS_LC_PC_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);     // PC    
    //시스템 코드 공통코드에서 가지고 오기
    getStore("DS_LC_STR_CD", "Y", "1", "N");
    getDept("DS_LC_DEPT_CD", "N", LC_SEL_STR_CD.BindColVal, "Y");
    getTeam("DS_LC_TEAM_CD", "N", LC_SEL_STR_CD.BindColVal, LC_SEL_DEPT_CD.BindColVal, "Y");
    getPc("DS_LC_PC_CD", "N", LC_SEL_STR_CD.BindColVal, LC_SEL_DEPT_CD.BindColVal, LC_SEL_TEAM_CD.BindColVal, "Y");
    //초기 포커스 설정
    LC_SEL_STR_CD.Focus();
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
    var goTo = "getBuyer";
    var parameters = ""
        + "&strBuyerCd="    + encodeURIComponent(strBuyerCd);// 바이어 
    TR_MAIN2.Action = "/mss/mcou101.mu?goTo=" + goTo + parameters;
    TR_MAIN2.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
    TR_MAIN2.Post();
    
    LC_SEL_STR_CD.Index = 0;
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
	//값 체크 
	if (!checkValidate()) return;
		
    if (DS_IO_MASTER.IsUpdated) {//변경 데이터가 있을때만 저장
    	
    	//변경또는 신규 내용을 저장하시겠습니까?
        if( showMessage(INFORMATION, YESNO, "USER-1010") != 1 ){
            LC_SEL_STR_CD.Focus();
            return;
        }
    
        var goTo = "buyerCngSave";
        var parameters = ""
            + "&strReqDt="      + encodeURIComponent(strReqDt) // 신청일자
            + "&strReqSeq="     + encodeURIComponent(strReqSeq);// SEQ 
        TR_MAIN.Action = "/mss/mcou101.mu?goTo=" + goTo + parameters;
        TR_MAIN.KeyValue = "SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)";
        TR_MAIN.Post();
        //답변내역 재조회
        btn_Close("saveClose");
    } else {
        showMessage(INFORMATION, OK, "USER-1028");
    }
}

/**
 * btn_Close()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 창닫기
 * return값 : void
 */

function btn_Close(ent) {
     window.returnValue = ent;
     window.close();      
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

/**
 * checkValidate()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.03.02
 * 개    요 : 값체크
 * return값 :
 */
function checkValidate() {
	var strOldBuyerCD = DS_IO_MASTER.NameValue(1, "OLD_BUYER_CD");
	var strNewBuyerCD = DS_IO_MASTER.NameValue(1, "NEW_BUYER_CD");
	
	//바이어 입력확인
    if (strNewBuyerCD.length < 1 ) {
    	showMessage(STOPSIGN, OK, "USER-1003", "바이어");
    	EM_BUYER_CD.Focus();
    	return false;
    }
	
    //변경바이어 확인
    if (strNewBuyerCD.length == strOldBuyerCD) {
        showMessage(STOPSIGN, OK, "USER-1000", "이전바이어와 동일한 바이어를 입력(등록)하였습니다.");
        EM_BUYER_CD.Focus();
        return false;
    }
    return true;
}
/**
 * callPopup()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.01.24
 * 개    요 : 팝업 호출
 * return값 :
 */
function callPopup(popupNm) {
    if (popupNm == "buyer") {//바이어
        if (LC_SEL_STR_CD.BindColVal == ""|| LC_SEL_STR_CD.BindColVal == "%") {//점 미선택시
            showMessage(STOPSIGN, OK, "USER-1003", "점");
            LC_SEL_STR_CD.Focus();
            return;
        }  
    
        var strOrgCd = LC_SEL_STR_CD.BindColVal;
        if (LC_SEL_DEPT_CD.BindColVal == "" || LC_SEL_DEPT_CD.BindColVal == "%") {
            strOrgCd +=  "00000000";
        } else {
            strOrgCd += LC_SEL_DEPT_CD.BindColVal;
            if (LC_SEL_TEAM_CD.BindColVal == "" || LC_SEL_TEAM_CD.BindColVal == "%") {
                strOrgCd +=  "000000";
            } else {
                strOrgCd += LC_SEL_TEAM_CD.BindColVal;
                if (LC_SEL_PC_CD.BindColVal == "" || LC_SEL_PC_CD.BindColVal == "%") {
                    strOrgCd +=  "0000";
                } else {
                    strOrgCd += LC_SEL_TEAM_CD.BindColVal + "00";
                }
            }
        }
        
        buyerPop( EM_BUYER_CD, EM_BUYER_NM , 'N', '', '1', strOrgCd, '', '');
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

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
   /* showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }*/
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_MAIN2 event=onFail>
    /*showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN2.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN2.ErrorMsg);
    for(i=1;i<TR_MAIN2.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN2.SrvErrMsg('GAUCE',i));
    }*/
    trFailed(TR_MAIN2.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>
if(clickSORT) return;
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->

<script language=JavaScript for=EM_BUYER_CD event=OnKillFocus()>
//[조회용]바이어코드  자동완성 및 팝업호출
//if (EM_BUYER_CD.Text.length > 0 ) {
	if(!this.Modified)
        return;
        
    if(this.text==''){
    	EM_BUYER_NM.Text = "";
        return;
    } 
    
    if (LC_SEL_STR_CD.BindColVal == ""|| LC_SEL_STR_CD.BindColVal == "%") {//점 미선택시
        showMessage(STOPSIGN, OK, "USER-1003", "점");
        LC_SEL_STR_CD.Focus();
        return;
    }  

    var strOrgCd = LC_SEL_STR_CD.BindColVal;
    if (LC_SEL_DEPT_CD.BindColVal == "" || LC_SEL_DEPT_CD.BindColVal == "%") {
        strOrgCd +=  "00000000";
    } else {
        strOrgCd += LC_SEL_DEPT_CD.BindColVal;
        if (LC_SEL_TEAM_CD.BindColVal == "" || LC_SEL_TEAM_CD.BindColVal == "%") {
            strOrgCd +=  "000000";
        } else {
            strOrgCd += LC_SEL_TEAM_CD.BindColVal;
            if (LC_SEL_PC_CD.BindColVal == "" || LC_SEL_PC_CD.BindColVal == "%") {
                strOrgCd +=  "0000";
            } else {
                strOrgCd += LC_SEL_TEAM_CD.BindColVal + "00";
            }
        }
    }
    
    //단일건 체크 
    setBuyerNmWithoutPop("DS_O_RESULT", EM_BUYER_CD, EM_BUYER_NM , 'N', 1, '', '', strOrgCd);
 
//}
</script>

<script language=JavaScript for=LC_SEL_STR_CD event=OnSelChange()>
//[점]콤보 변경
    //시스템 코드 공통코드에서 가지고 오기
    getDept("DS_LC_DEPT_CD", "N", LC_SEL_STR_CD.BindColVal, "Y");
    if (LC_SEL_STR_CD.BindColVal == "" || LC_SEL_STR_CD.BindColVal == "%") {
        // 팀비활성화   
        enableControl(LC_SEL_DEPT_CD, false);
        LC_SEL_DEPT_CD.Index = 0;
        // 파트비활성화   
        enableControl(LC_SEL_TEAM_CD, false);
        LC_SEL_TEAM_CD.Index = 0;
        // PC비활성화   
        enableControl(LC_SEL_PC_CD, false);
        LC_SEL_PC_CD.Index = 0;
    } else {
        // 팀활성화   
        enableControl(LC_SEL_DEPT_CD, true);
        LC_SEL_DEPT_CD.Index = 0;
        // 파트비활성화   
        enableControl(LC_SEL_TEAM_CD, false);
        LC_SEL_TEAM_CD.Index = 0;
        // PC비활성화   
        enableControl(LC_SEL_PC_CD, false);
        LC_SEL_PC_CD.Index = 0;
    }
    EM_BUYER_CD.Text = "";
    EM_BUYER_NM.Text = "";
</script>
<script language=JavaScript for= LC_SEL_DEPT_CD event=OnSelChange()>
//[팀]콤보 변경
    //시스템 코드 공통코드에서 가지고 오기
    getTeam("DS_LC_TEAM_CD", "N", LC_SEL_STR_CD.BindColVal, LC_SEL_DEPT_CD.BindColVal, "Y");
    if (LC_SEL_DEPT_CD.BindColVal == "" || LC_SEL_DEPT_CD.BindColVal == "%") {
        // 파트비활성화   
        enableControl(LC_SEL_TEAM_CD, false);
        LC_SEL_TEAM_CD.Index = 0;
        // PC비활성화   
        enableControl(LC_SEL_PC_CD, false);
        LC_SEL_PC_CD.Index = 0;
    } else {
        // 파트활성화   
        enableControl(LC_SEL_TEAM_CD, true);
        LC_SEL_TEAM_CD.Index = 0;
        // PC비활성화   
        enableControl(LC_SEL_PC_CD, false);
        LC_SEL_PC_CD.Index = 0;
    }
</script>
<script language=JavaScript for= LC_SEL_TEAM_CD event=OnSelChange()>
//[파트]콤보 변경
    //시스템 코드 공통코드에서 가지고 오기
    getPc("DS_LC_PC_CD", "N", LC_SEL_STR_CD.BindColVal, LC_SEL_DEPT_CD.BindColVal, LC_SEL_TEAM_CD.BindColVal, "Y");
    if (LC_SEL_TEAM_CD.BindColVal == "" || LC_SEL_TEAM_CD.BindColVal == "%") {
        // PC비활성화   
        enableControl(LC_SEL_PC_CD, false);
        LC_SEL_PC_CD.Index = 0;
    } else {
        // PC활성화   
        enableControl(LC_SEL_PC_CD, true);
        LC_SEL_PC_CD.Index = 0;
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
<comment id="_NSID_"><object id="DS_IO_MASTER"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<!-- ===============- ONLOAD용 -->
<comment id="_NSID_"><object id="DS_LC_STR_CD"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_DEPT_CD"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_TEAM_CD"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_PC_CD"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

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

<comment id="_NSID_">
<object id="TR_MAIN2" classid=<%=Util.CLSID_TRANSACTION%>>
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
                            class="PL03">바이어 변경</SPAN></td>
                        <td>
                        <table border="0" align="right" cellpadding="0" cellspacing="0">
                            <tr>
                                <td><img src="/<%=dir%>/imgs/btn/save.gif" width="50"
                                    height="22" onClick="btn_Save()" /></td>
                                <td><img src="/<%=dir%>/imgs/btn/close.gif" width="50"
                                    height="22" onClick="btn_Close('close');" /></td>
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
								<th width="80" class="point">점</th>
								<td ><comment id="_NSID_"> <object
									id=LC_SEL_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> height=100
									width=100 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
								</td>
								<th width="80">팀</th>
								<td ><comment id="_NSID_"> <object
									id=LC_SEL_DEPT_CD classid=<%=Util.CLSID_LUXECOMBO%> height=100
									width=100 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
								</td>
								<th width="80">파트</th>
								<td ><comment id="_NSID_"> <object
									id=LC_SEL_TEAM_CD classid=<%=Util.CLSID_LUXECOMBO%> height=100
									width=100 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
								</td>
								<th width="80">PC</th>
								<td><comment id="_NSID_"> <object id=LC_SEL_PC_CD
									classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=100
									align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
							</tr>
							<tr>
								<th>바이어</th>
								<td colspan="7"><comment id="_NSID_"> <object
									id=EM_BUYER_CD classid=<%=Util.CLSID_EMEDIT%> width=70
									tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
								<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
									onclick="javascript:callPopup('buyer')" align="absmiddle" />
								<comment id="_NSID_"> <object id=EM_BUYER_NM
									classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1
									align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
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
<object id=BD_IO_MASTER classid=<%=Util.CLSID_BIND%>>
        <param name=DataID          value=DS_IO_MASTER>
        <param name="ActiveBind"    value=true>
        <param name=BindInfo        value='
        <c>Col=NEW_STR_CD       Ctrl=LC_SEL_STR_CD      param=BindColVal</c>
        <c>Col=NEW_DEPT_CD      Ctrl=LC_SEL_DEPT_CD     param=BindColVal</c>
        <c>Col=NEW_TEAM_CD      Ctrl=LC_SEL_TEAM_CD     param=BindColVal</c>
        <c>Col=NEW_PC_CD        Ctrl=LC_SEL_PC_CD       param=BindColVal</c>
        <c>Col=NEW_BUYER_CD     Ctrl=EM_BUYER_CD        param=Text</c>
        <c>Col=NEW_BUYER_NAME   Ctrl=EM_BUYER_NM        param=Text</c>
        '>
</object>
</comment><script>_ws_(_NSID_);</script>
</body>
</html>

