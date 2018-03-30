<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 임대관리 > 계량기시설구분등록
 * 작 성 일 : 2010.05.20
 * 작 성 자 : 김유완
 * 수 정 자 : 
 * 파 일 명 : MREn1120.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 계량기시설구분등록
 * 이    력 : 2010.05.20 (김유완) 신규작성
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
var g_currRow  = 1;
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.20
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){
    // Input Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MR_GAUGMST"/>');
    registerUsingDataset('<%=((SessionInfo) session.getAttribute("sessionInfo")).getPGM_ID()%>'.toLowerCase(), "DS_IO_MASTER");
    
    //그리드 초기화
    gridCreate(); //마스터
    
    //콤보 초기화
    initComboStyle(LC_S_GAUG_TYPE ,DS_GAUG_TYPE,    "CODE^0^30,NAME^0^80", 1, NORMAL);  // [조회용]계량기구분     
    LC_S_GAUG_TYPE.Focus();
    initEmEdit(EM_S_GAUG_ID,                        "GEN^20",NORMAL);                   // [조회용]계량기ID 
    initEmEdit(EM_S_INST_PLC,                       "GEN^40",READ);                     // [조회용]설치장소
    initEmEdit(EM_S_INST_PLC2,                      "GEN^40",NORMAL);                   // [조회용]설치장소
    //시스템 코드 공통코드에서 가지고 오기
    getEtcCode("DS_GAUG_TYPE",      "D", "M039", "Y", "N", LC_S_GAUG_TYPE);             // [조회용]계량기구분 
    getFlc("DS_FCL_FLAG",           "M", "", "N", "N");                                // 시설구분[전체]
    getEtcCode("DS_GAUG_KIND_CD",   "D", "M045", "N", "N");                             // 용도구분
}

function gridCreate(){
    //마스터그리드
    var hdrProperies = ''
        + '<FC>ID={CURROW}         NAME="NO"'
        + '                                            WIDTH=30    ALIGN=CENTER</FC>'
        + '<FC>ID=GAUG_ID          NAME="계량기ID"'
        + '                                            WIDTH=80    ALIGN=CENTER    EDIT=NONE</FC>'
        + '<FC>ID=INST_PLC         NAME="설치장소"'
        + '                                            WIDTH=190   ALIGN=LEFT      EDIT=NONE</FC>'
        + '<FC>ID=STR_CD           NAME="*시설구분"'
        + '                                            WIDTH=100   ALIGN=LEFT      EDITSTYLE=LOOKUP   DATA="DS_FCL_FLAG:CODE:NAME"</FC>'
        + '<FC>ID=GAUG_TYPE        NAME="계량기구분"'
        + '                                            WIDTH=80    ALIGN=LEFT      EDIT=NONE   EDITSTYLE=LOOKUP   DATA="DS_GAUG_TYPE:CODE:NAME"</FC>'
        + '<FC>ID=GAUG_KIND_CD     NAME="*계량기용도"'
        + '                                            WIDTH=100   ALIGN=LEFT      EDITSTYLE=LOOKUP   DATA="DS_GAUG_KIND_CD:CODE:NAME"</FC>'
        + '<FC>ID=HIGH_GAUG_ID     NAME="상위계량기ID"'
        + '                                            WIDTH=80    ALIGN=CENTER    EDIT=NONE</FC>'
        + '<FC>ID=VALID_S_DT       NAME="유효시작일자"'
        + '                                            WIDTH=100   ALIGN=CENTER    EDIT=NONE MASK="XXXX/XX/XX"</FC>'
        + '<FC>ID=VALID_E_DT       NAME="유효종료일자"'
        + '                                            WIDTH=100   ALIGN=CENTER    EDIT=NONE MASK="XXXX/XX/XX"</FC>'
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
 * 작 성 일 : 2010.05.20
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    if (DS_IO_MASTER.IsUpdated) {//변경데이터 있을 시 확인
        var ret = showMessage(Question, YesNo, "USER-1059");
        if (ret == "1") {
            var strGaugType = LC_S_GAUG_TYPE.BindColVal;// [조회용]계량기구분
            var strGaugID   = EM_S_GAUG_ID.Text;        // [조회용]계량기ID
            var strInstPlc  = EM_S_INST_PLC2.Text;      // [조회용]설치장소
            var goTo = "getMaster";
            var parameters = ""
                + "&strGaugType="   + encodeURIComponent(strGaugType)
                + "&strGaugID="     + encodeURIComponent(strGaugID)
                + "&strInstPlc="    + encodeURIComponent(strInstPlc);
            TR_MAIN.Action = "/mss/mren112.mr?goTo=" + goTo + parameters;
            TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
            TR_MAIN.Post();
        
            // 조회결과 Return
            setPorcCount("SELECT", GD_MASTER);
            
            if (DS_IO_MASTER.CountRow > 0) {
                if (arguments[0] == undefined || arguments[0] == 1) {
                    g_currRow = 1;
                } else {
                    DS_IO_MASTER.RowPosition = arguments[0];
                }
            }
        } else {
            return;
        }
    }  else {
        var strGaugType = LC_S_GAUG_TYPE.BindColVal;// [조회용]계량기구분
        var strGaugID   = EM_S_GAUG_ID.Text;        // [조회용]계량기ID
        var strInstPlc  = EM_S_INST_PLC2.Text;      // [조회용]설치장소
        var goTo = "getMaster";
        var parameters = ""
            + "&strGaugType="   + encodeURIComponent(strGaugType)
            + "&strGaugID="     + encodeURIComponent(strGaugID)
            + "&strInstPlc="    + encodeURIComponent(strInstPlc);
        TR_MAIN.Action = "/mss/mren112.mr?goTo=" + goTo + parameters;
        TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
        TR_MAIN.Post();
    
        // 조회결과 Return
        setPorcCount("SELECT", GD_MASTER);
        
        if (DS_IO_MASTER.CountRow > 0) {
            if (arguments[0] == undefined || arguments[0] == 1) {
                g_currRow = 1;
            } else {
                DS_IO_MASTER.RowPosition = arguments[0];
            }
        }
    }
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.20
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    if (DS_IO_MASTER.IsUpdated) {//변경 데이터가 있을때만 저장
    
        //필수 입력값,스크립트 중복 값 체크
        if (!checkValidateSave()) return;
    
        //변경또는 신규 내용을 저장하시겠습니까?
        if( showMessage(INFORMATION, YESNO, "USER-1010") != 1 ){
            GD_MASTER.Focus();
            return;
        }
    
        g_currRow = DS_IO_MASTER.RowPosition;
        //저장
        var goTo = "save";
        TR_SAVE.Action = "/mss/mren112.mr?goTo=" + goTo;
        TR_SAVE.KeyValue = "SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)";
        TR_SAVE.Post();
    } else {
        showMessage(INFORMATION, OK, "USER-1028");
        return;
    }
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * callPopup()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.01
 * 개    요 : 팝업 호출
 * return값 :
 */
function callPopup(popupNm) {
    if (popupNm == "gaugId") { // 계량기ID
        var rt = getGaugIdPop(EM_S_GAUG_ID, EM_S_INST_PLC, "", LC_S_GAUG_TYPE.BindColVal,  "S", "F", "");
        if (rt) {
            EM_S_INST_PLC.Text = rt.INST_PLC;
        }
    }
}
 
/**
 * checkValidateSave()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.20
 * 개    요 : 값체크(저장)
 * return값 :
 */
function checkValidateSave() {
    // 필수 입력값 체크
    for (var n=1; n<=DS_IO_MASTER.CountRow; n++) {
        if (DS_IO_MASTER.RowStatus(n) != 0 ) {
            // 시설구분
            if (DS_IO_MASTER.NameValue(n,"STR_CD") == "") {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("STR_CD");
                showMessage(INFORMATION, OK, "USER-1002", "시설구분");
                return false;
            }

            // 계량기용도
            if (DS_IO_MASTER.NameValue(n,"GAUG_KIND_CD") == "") {
                DS_IO_MASTER.RowPosition = n;
                GD_MASTER.SetColumn("GAUG_KIND_CD");
                showMessage(INFORMATION, OK, "USER-1002", "계량기용도");
                return false;
            }
        }
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

<script language=JavaScript for=TR_SAVE event=onSuccess>
    for(i=0;i<TR_SAVE.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_SAVE.SrvErrMsg('UserMsg',i));
    }
    //저장 후 재 조회
    btn_Search(g_currRow);
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_SAVE event=onFail>
    trFailed(TR_SAVE.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>

if (row > 0) {
	DS_GAUG_KIND_CD.Filter(); // 계량기용도
	if (DS_IO_MASTER.RowStatus(row) == "1") {
	    GD_MASTER.ColumnProp('GAS_KIND_CD',     'Edit') = "";   // 용도구분
	    // 용도상세구분
	    if (DS_IO_MASTER.NameValue(row,"GAS_KIND_CD") == "51" || DS_IO_MASTER.NameValue(row,"GAS_KIND_CD") == "52") { //01 산업용 , 02 냉방용 
	        GD_MASTER.ColumnProp('GAS_KIND_DTL_CD', 'Edit')  = "NONE";
	    } else {
	        GD_MASTER.ColumnProp('GAS_KIND_DTL_CD', 'Edit')  = "";
	    }
	    GD_MASTER.ColumnProp('AREA_FLAG',       'Edit') = "";   // 지역
	    
	} else {
	    GD_MASTER.ColumnProp('GAS_KIND_CD',     'Edit') = "NONE";   // 용도구분
	    GD_MASTER.ColumnProp('GAS_KIND_DTL_CD', 'Edit') = "NONE";   // 용도상세구분
	    GD_MASTER.ColumnProp('AREA_FLAG',       'Edit') = "NONE";   // 지역
	}
}
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
//그리드 정렬기능
    sortColId( eval(this.DataID), row , colid );
</script>

<script language=JavaScript for=EM_S_GAUG_ID event=OnKillFocus()> 
//계량기ID
    if(!this.Modified) return;
       
    if(this.text==''){;
        EM_S_INST_PLC.Text = "";
        return;
    } 

    //단일건 체크 
    getGaugIdNonPop( "DS_O_RESULT", EM_S_GAUG_ID, "", LC_S_GAUG_TYPE.BindColVal, "E", "N", "F", "");
    if (DS_O_RESULT.CountRow == 1 ) {
        EM_S_GAUG_ID.Text = DS_O_RESULT.NameValue(1, "GAUG_ID");
        EM_S_INST_PLC.Text = DS_O_RESULT.NameValue(1, "INST_PLC");
    } else {
        //1건 이외의 내역이 조회 시 팝업 호출
        EM_S_INST_PLC.Text = "";
        var rt = getGaugIdPop(EM_S_GAUG_ID, EM_S_INST_PLC, "", LC_S_GAUG_TYPE.BindColVal, "S", "F", "");
        if (rt) {
            //EM_S_GAUG_ID.Text = rt.GAUG_ID;
            EM_S_INST_PLC.Text = rt.INST_PLC;
        } 
    } 
</script>

<script language=JavaScript for=DS_GAUG_KIND_CD event=OnFilter(row)>
// 계량기용도(가스용도 )
if (DS_IO_MASTER.CountRow > 0) {
    if (DS_GAUG_KIND_CD.NameValue(row,"CODE").substring(0,1) == (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"GAUG_TYPE")).substring(0,1)) {
        return true;
    } else { 
        return false;
    }
} else {
	return true;
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
<!-- =============== Output용 -->

<!-- =============== ONLOAD용 -->
<comment id="_NSID_"><object id="DS_GAUG_TYPE"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_FCL_FLAG"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_GAUG_KIND_CD"   classid=<%=Util.CLSID_DATASET%>><param name=UseFilter value=true></object></comment><script>_ws_(_NSID_);</script>
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
						<th width="80">계량기구분</th>
						<td width="102"><comment id="_NSID_"> <object
							id=LC_S_GAUG_TYPE classid=<%=Util.CLSID_LUXECOMBO%> width="100"
							tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="80">계량기ID</th>
						<td width="250"><comment id="_NSID_"> <object
							id=EM_S_GAUG_ID classid=<%=Util.CLSID_EMEDIT%> width="70"
							tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/detail_search_s.gif"
							align="absmiddle" onclick="javascript:callPopup('gaugId');"
							class="PR03" /> <comment id="_NSID_"> <object
							id=EM_S_INST_PLC classid=<%=Util.CLSID_EMEDIT%> width="150"
							tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="80">설치장소</th>
						<td><comment id="_NSID_"> <object id=EM_S_INST_PLC2
							classid=<%=Util.CLSID_EMEDIT%> width="150" tabindex=1
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
    <tr>
        <td height="3"></td>
    </tr>
    <tr valign="top">
        <td align="left">
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
            class="BD4A">
            <tr valign="top">
                <td><comment id="_NSID_"><OBJECT id=GD_MASTER
                    width=100% height=483 tabindex=1 classid=<%=Util.CLSID_GRID%>>
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

