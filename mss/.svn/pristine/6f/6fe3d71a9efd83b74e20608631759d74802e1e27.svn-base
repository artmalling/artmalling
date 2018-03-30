<!--
/*******************************************************************************
 * 시스템명 : 경영지원 > 상품권관리 > 정산관리 > 회계전표 I/F
 * 작 성 일 : 2011.09.19
 * 작 성 자 : 김성미
 * 수 정 자 : 
 * 파 일 명 : MGIF6210.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : SAP I/F 전송
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
  import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button" %>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                              *-->
<!--*************************************************************************-->
<loginChk:islogin />
<% String dir = BaseProperty.get("context.common.dir"); %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache" />
<title>회계전표 I/F</title>
<link rel="stylesheet" type="text/css" href="/<%=dir%>/css/mds.css" />
<script language="javascript" src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_ccs.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js" type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                      *-->
<!--*************************************************************************-->
<script type="text/javascript">
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
var newMasterYn = false;
var btnClickSelect = false;
var btnClickNew = false;
var btnClickSave = false;
var globalCntrCd = "";
var globalSapIf = "";
var globalReqDt = "";
var toDay = "";
/**
 * doInit()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-09-05
 * 개    요 : 해당 페이지 LOAD 시
 * return값 : void
 */
function doInit() {
	 
    // EMedit 초기화
    initEmEdit(EM_S_REQ_DT, "YYYYMMDD", PK); // 생성일(조회)
    initEmEdit(EM_S_REQ_YM, "YYYYMM", PK); // 생성월(조회)
    
    // 콤보 초기화
    initComboStyle(LC_STR_CD, DS_IO_STR_CD, "CODE^0^30,NAME^0^100", 1, PK); // 센터코드(조회)
    initComboStyle(LC_S_SAP_IF, DS_O_SAP_IF,   "CODE^0^50,NAME^0^150", 1, PK); // SAP I/F(조회)

    // 콤보데이터 가져오기 
    getStore("DS_IO_STR_CD", "Y", "", "N");   
    //getEtcCodeReferLike("DS_O_SAP_IF", "D", "P701", "", "N"); // SAP I/F(조회)
    RD_CAL_GB.CodeValue = "1";
    getIFCode();
    // 콤보데이터 기본값 설정
    LC_STR_CD.Index = 0; // 센터(조회)
    LC_S_SAP_IF.Index = 0;  // SAP I/F(조회)

    // DB시간 가져오기
    toDay = getTodayDB("DS_I_COMMON");
    
    // EMedit 기본값
    EM_S_REQ_DT.Text = toDay;// 생성일(조회)  : db시간
    EM_S_REQ_YM.Text = toDay;// 생성일(조회)  : db시간
    RD_CAL_GB.CodeValue = "1";
    
    RD_CAL_GB.enable = false;
    
    // 포커스 초기화
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
 * 작 성 자 : 김재겸
 * 작 성 일 : 2011-09-05
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {

}

/**
 * btn_New()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2011-09-05
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {

}

/**
 * btn_Delete()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2011-09-05
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2011-09-05
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {

}

/**
 * btn_Excel()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2011-09-05
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-09-05
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {

}

/**
 * btn_Conf()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2011-09-05
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * getIFCode()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-09-19
 * 개    요 : 정산구분에 따른  SAP I/F 콤보 조회
 * 사용방법 : getIFCode()
 * return값 : true, false
 */
function getIFCode(){
	TR_MAIN.Action = "/mss/mgif621.mg?goTo=getIFCode";
	TR_MAIN.KeyValue = "SERVLET(O:DS_O_SAP_IF=DS_O_SAP_IF)";
	TR_MAIN.Post();
}

/**
 * getSapIfsCode()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2011-09-05
 * 개    요 : SAP I/F 코드 구하기
 * 사용방법 : initFocus()
 * return값 : void
 */
function getSapIfsCode() {
    // 점코드
    var strCode = "";
    var codeRow = DS_O_SAP_IF.NameValueRow("CODE", globalSapIf);    
    if (codeRow > 0) {
        strCode = DS_O_SAP_IF.NameValue(codeRow, "REFER_CODE");
    }
    
    return strCode;
}

/**
 * sapIfCreate()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2011-03-22
 * 개    요 : SAP I/F 생성
 * return값 : void
 */
function sapIfCreate() {
    if (globalCntrCd == "" || globalSapIf == "" || globalReqDt == "") {
        // 데이터 조회 후 ()이/가 가능합니다.
        showMessage(INFORMATION, OK, "USER-1075", "생성");
        return false;
        
    } else {
        var cnt = 0;            
        var strCalGb = RD_CAL_GB.CodeValue;
        
        if (strCalGb == "1") {
            var strReqDt = EM_S_REQ_DT.Text;
        }else if (strCalGb == "2"){
        	var strReqDt = EM_S_REQ_YM.Text;
        }
        
        // SAP I/F 코드
    	  var sapIfCode = getSapIfsCode();
    	  if (sapIfCode.trim() == "") {
    		    return false;
    	  }
        
        var parameters = "&strCntrCd="+ encodeURIComponent(globalCntrCd)
                       + "&strSapIf=" + encodeURIComponent(globalSapIf)
                       + "&strReqDt=" + encodeURIComponent(strReqDt);
        
        TR_MAIN.Action = "/mss/mgif621.mg?goTo="+sapIfCode+parameters;
        TR_MAIN.KeyValue = "SERVLET(O:DS_O_MASTER=DS_O_MASTER)";
        TR_MAIN.Post();
        
        // 정상 처리일 경우 조회
        if (TR_MAIN.ErrorCode == 0) {
        }
    }
}

/**
 * sapIfSend()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2011-03-22
 * 개    요 : SAP I/F 전송
 * return값 : void
 */
function sapIfSend() {
    if (globalCntrCd == "" || globalSapIf == "" || globalReqDt == "") {
        // 데이터 조회 후 ()이/가 가능합니다.
        showMessage(INFORMATION, OK, "USER-1075", "전송");
        return false;
    } else {              
        // SAP I/F 코드
        var sapIfCode = getSapIfsCode();
        if (sapIfCode.trim() == "") {
            return false;
        }
        
        var strCalGb = RD_CAL_GB.CodeValue;
        
        if (strCalGb == "1") {
        	var strReqDt = EM_S_REQ_DT.Text;
        }else if (strCalGb == "2"){
            var strReqDt = EM_S_REQ_YM.Text;
        }
        
        var parameters = "&strCntrCd="+ encodeURIComponent(globalCntrCd)
                       + "&strSapIf=" + encodeURIComponent(globalSapIf)
                       + "&strReqDt=" + encodeURIComponent(strReqDt)
                       + "&strCalGb=" + encodeURIComponent(strCalGb);
        
        TR_MAIN.Action = "/mss/mgif621.mg?goTo=ifsSend"+parameters;
        TR_MAIN.KeyValue = "SERVLET(O:DS_O_MASTER=DS_O_MASTER)";
        TR_MAIN.Post();
        
        // 정상 처리일 경우 조회
        if (TR_MAIN.ErrorCode == 0) {
        }
    }
}

/**
 * process()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2011-03-22
 * 개    요 : SAP I/F 전송
 * return값 : void
 */
function process(){

	 if (isNull(LC_STR_CD.BindColVal)==true ) {
        showMessage(EXCLAMATION, OK, "USER-1000", "전송처리시 센터는 반드시 선택해야 합니다.");
        LC_STR_CD.Focus();
        return false;
    }
    
	if( trim(EM_S_REQ_DT.Text).length == 0 ) {
        showMessage(EXCLAMATION, OK, "USER-1001","전기일");
        EM_S_REQ_DT.Focus();
        return false;
    }     
    
    if( showMessage(QUESTION, YESNO, "USER-1204") == 1 ){
 
        var parameters    = "&strStrCd="   + encodeURIComponent(LC_STR_CD.BindColVal)
    					  + "&strSReqDt="  + encodeURIComponent(EM_S_REQ_DT.Text);
       
    	TR_MAIN.Action = "/mss/mgif621.mg?goTo=save"+parameters;
    	TR_MAIN.KeyValue = "SERVLET(O:DS_O_MASTER=DS_O_MASTER)";
    	//searchSetWait("B"); // 프로그래스바
    	TR_MAIN.Post();        
    }
}
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                        *-->
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
<script type="text/javascript" for="TR_MAIN" event="onSuccess">
    for (var i=0; i<this.SrvErrCount('UserMsg'); i++) {
        showMessage(INFORMATION, OK, "USER-1000", this.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script type="text/javascript" for="TR_MAIN" event="onFail">
    trFailed(this.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_SAP_IF event=OnFilter(row)>
if(RD_CAL_GB.CodeValue == 1){
	if (DS_O_SAP_IF.NameValue(row, "CAL_GB") != "1") {// 일자별 
	    return false;
	}
	return true;	
}else if (RD_CAL_GB.CodeValue == 2){
	if (DS_O_SAP_IF.NameValue(row, "CAL_GB") != "2") {// 월별 
	    return false;
	}
	return true;
}

</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=RD_CAL_GB event=OnClick()>
DS_O_SAP_IF.Filter();
LC_S_SAP_IF.Index = 0;  // SAP I/F(조회)
if(RD_CAL_GB.CodeValue == "1"){ // 일자
	document.getElementById("title").innerText = "전기일";
    DIV_DATE.style.display = '';
    DIV_YYYYMM.style.display = 'none';
}else if(RD_CAL_GB.CodeValue == "2"){ // 월
	document.getElementById("title").innerText = "전기월";
	DIV_DATE.style.display = 'none';
    DIV_YYYYMM.style.display = '';
}
// EMedit 기본값
EM_S_REQ_DT.Text = toDay;// 생성일(조회)  : db시간
EM_S_REQ_YM.Text = toDay;// 생성일(조회)  : db시간
</script>
<script language=JavaScript for=LC_S_SAP_IF event=OnCloseUp()>
globalCntrCd = "";
globalSapIf = "";
lobalReqDt = "";
</script>
<script language=JavaScript for=LC_STR_CD event=OnCloseUp()>
globalCntrCd = "";
globalSapIf = "";
lobalReqDt = "";
</script>
<script language=JavaScript for=EM_S_REQ_DT event=OnKillFocus()>
globalCntrCd = "";
globalSapIf = "";
lobalReqDt = "";
</script>

<script language=JavaScript for=EM_S_REQ_YM event=OnKillFocus()>
globalCntrCd = "";
globalSapIf = "";
lobalReqDt = "";
</script>

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                              *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                   *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->
<!-- =============== Input용 -->

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_MASTER" classid="<%=Util.CLSID_DATASET%>"></object></comment><script type="text/javascript">_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT" classid="<%=Util.CLSID_DATASET%>"></object></comment><script type="text/javascript">_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_STR_CD" classid="<%=Util.CLSID_DATASET%>"></object></comment><script type="text/javascript">_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_SAP_IF" classid="<%=Util.CLSID_DATASET%>">
<param name=UseFilter value=true>
</object></comment>
<script type="text/javascript">_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_DATE" classid="<%=Util.CLSID_DATASET%>"></object></comment><script type="text/javascript">_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON" classid="<%=Util.CLSID_DATASET%>"></object></comment><script type="text/javascript">_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION" classid="<%=Util.CLSID_DATASET%>"></object></comment><script type="text/javascript">_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
  <object id="TR_MAIN" classid="<%=Util.CLSID_TRANSACTION%>">
    <param name="KeyName" value="Toinb_dataid4">
  </object>
</comment>
<script type="text/javascript">_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                               *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* E. 본문시작                                                           *-->
<!--*************************************************************************-->
</head>
<body onLoad="doInit();" class="PL10 PT15">
<table width="100%"  border="0" cellspacing="0" cellpadding="0">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

  <tr>
    <td class="PT01 PB03"><table width="50%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="80" class="point">점</th>
            <td>
                    <comment id="_NSID_">
                        <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=100% tabindex=1 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>

            </td>
          </tr> 
          <tr>
            <th class="point">SAP I/F</th>
            <td>
                    <comment id="_NSID_">
                      <object id="LC_S_SAP_IF" classid="<%=Util.CLSID_LUXECOMBO%>" width="275" align="absmiddle">
                      </object>
                    </comment>
                    <script type="text/javascript">_ws_(_NSID_);</script>

            </td>
          </tr> 
          <tr>
            <th class="point">정산구분</th>
            <td>
                    <comment id="__NSID__">
                      <object id=RD_CAL_GB classid=<%=Util.CLSID_RADIO%> style="height:24; width:175">
                        <param name=Cols   value="2">
                        <!-- 
                        <param name=Format  value="1^일정산,2^월정산">
                         -->
                        <param name=Format  value="1^일정산,2^">
                      </object></comment><SCRIPT>_ws_(__NSID__);</SCRIPT>
            </td>
          </tr>         
          <tr>
            <th id="title" class="point">전기일</th>
            <td>
                <div id="DIV_DATE">
                    <comment id="_NSID_">
                      <object id="EM_S_REQ_DT" classid="<%=Util.CLSID_EMEDIT%>" width="80" align="absmiddle" onblur="javascript:checkDateTypeYMD(this);">
                      </object>
                    </comment>
                    <script type="text/javascript">_ws_(_NSID_);</script>
                    <a href="#calendarPopup" onclick="openCal('G', EM_S_REQ_DT); return false;" onkeydown="if(event.keyCode == 13) openCal('G', EM_S_REQ_DT);"><img src="/pot/imgs/btn/date.gif" align="absmiddle" /></a>
                    </div>
                   
                    <div id="DIV_YYYYMM" style="Display='none'">
                    <comment id="_NSID_">
                    <object id="EM_S_REQ_YM" classid="<%=Util.CLSID_EMEDIT%>" width="80" align="absmiddle" onblur="javascript:checkDateTypeYM(this);">
                    </object>
                    </comment>
                    <script type="text/javascript">_ws_(_NSID_);</script>
                    <a href="#calendarPopup" onclick="openCal('M', EM_S_REQ_YM); return false;" onkeydown="if(event.keyCode == 13) openCal('M', EM_S_REQ_YM);"><img src="/pot/imgs/btn/date.gif" align="absmiddle" /></a>
                 </div>
            </td>           
          </tr>
         <tr>
             <td colspan=2 align="Right"> 
               <img src="/<%=dir%>/imgs/btn/re_fee.gif" id="IMG_CREATE" width="0" height="0" alt="정산재생성" onclick="sapIfCreate(); return false;" />
               <img src="/<%=dir%>/imgs/btn/send_pre.gif" id="IMG_SEND" width="0" height="0" alt="전송처리" onclick="sapIfSend(); return false;" />
               <img src="/<%=dir%>/imgs/btn/send_pre.gif" id="IMG_SEND" width="62" height="18" alt="전송처리" onclick="process(); return false;" />
             </td>
         </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>

</table>
<!-- //wrap -->
</body>
</html>
