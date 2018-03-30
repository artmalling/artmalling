<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 회원관리 > 멤버쉽운영 > 영수증적립내역상세조회
 * 작 성 일    : 2010.03.25
 * 작 성 자    : jinjung.kim
 * 수 정 자    : 
 * 파 일 명    : DMBO6030.jsp
 * 버       전    : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개       요    :  
 * 이       력    :
 *           2010.03.25 (jinjung.kim) 신규작성
 *
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<%@ page import="java.text.SimpleDateFormat,java.util.Calendar" %>
<% request.setCharacterEncoding("utf-8"); %> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"        prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"            prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                              *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");
	//PID 확인을 위한
	String pageName = request.getRequestURI();
	int nSubStrFr = pageName.lastIndexOf("/") + 1 ;
	int nSubStrTo = pageName.lastIndexOf(".jsp") - 1 ;
	pageName = pageName.substring(nSubStrFr, nSubStrTo).toUpperCase();

%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dcs.js"  type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                      *-->
<!--*************************************************************************-->
<%
    HttpSession sess = request.getSession();
    SessionInfo sessionInfo = (SessionInfo)sess.getAttribute("sessionInfo");
    String BRCH_ID = sessionInfo.getBRCH_ID();

    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
    Calendar cal = Calendar.getInstance();
    String SALE_DT_TO = sdf.format(cal.getTime());
    
    String strToMonth = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	strToMonth = strToMonth + "01";
	
	String toDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
%>

<script LANGUAGE="JavaScript">
<!--
var EXCEL_PARAMS = "";
var bfMasterRowPos = 0;
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : jinjung.kim
 * 작 성 일     : 2010.03.25
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 300;		//해당화면의 동적그리드top위치
 var top2 = 500;		//해당화면의 동적그리드top위치 
 var g_strPid           = "<%=pageName%>";                 // PID

function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GR_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GR_DETAIL2"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top2) + "px"; 

    //Data Set Header 생성
    DS_O_CUST.setDataHeader('<gauce:dataset name="H_CUST"/>');
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    DS_O_DETAIL2.setDataHeader('<gauce:dataset name="H_DETAIL2"/>');
    
    gridCreate1(); //그리드 초기화
    
    //검색조건
    initEmEdit(EM_SALE_DT_FROM,   "YYYYMMDD",            PK);         //영업일자
    initEmEdit(EM_SALE_DT_TO,     "YYYYMMDD",            PK);         //영업일자
    initEmEdit(EM_Q_CARD_NO,      "0000-0000-0000-0000", NORMAL);     //카드번호
    initEmEdit(EM_CARD_NO_CUT,    "00000000",            NORMAL);     //단축 카드번호
    initEmEdit(EM_Q_SS_NO,        "000000",      NORMAL);     //생년월일
    initEmEdit(EM_CUST_ID_S,      "GEN^9",               NORMAL);     //회원코드
    initEmEdit(EM_CUST_NAME_S,    "GEN^40",              READ);       //회원명
    
    //회원정보 
    initEmEdit(EM_CUST_NM,        "GEN^40",              READ);       //회원명
    initEmEdit(EM_HOME_PH,        "GEN^20",              READ);       //자택전화
    initEmEdit(EM_MOBILE_PH,      "GEN^20",              READ);       //이동전화
    initEmEdit(EM_SS_NO,          "000000",      READ);       //생년월일
    initEmEdit(EM_HOME_ADDR,      "GEN^400",             READ);       //회원주소 
    initEmEdit(EM_POINT,          "NUMBER^9^0",          READ);       //누적포인트
//     initEmEdit(EM_OCCURS_POINT,   "NUMBER^9^0",          READ);       //발생포인트
//     initEmEdit(EM_SUM_POINT,   	  "NUMBER^9^0",          READ);       //누적+발생포인트    
    initEmEdit(EM_EMAIL,          "GEN^80",              READ);       //이메일주소
    initEmEdit(EM_CUST_GRADE,     "GEN^40",              READ);       //회원등급
    initEmEdit(EM_CUST_TYPE,      "GEN^40",     		 READ);       //회원유형


	getEtcCode("DS_ADD_TYPE", "D", "D006", "N");    //적립유형
    
    
    EM_CUST_ID_H.style.display = "none";
    EM_CARD_NO_H.style.display = "none";
    EM_SS_NO_H.style.display   = "none";
    
    //default ;
    //조회일자 초기값.
    EM_SALE_DT_FROM.Text = addDate("M", "-1", '<%=strToMonth%>');
    EM_SALE_DT_TO.Text   = "<%=SALE_DT_TO%>";

    EM_SALE_DT_FROM.focus();
}

/**
 * gridCreate1()
 * 작 성 자     : jinjung.kim
 * 작 성 일     : 2010.03.25
 * 개       요     : 그리드 초기화
 * return값 : void
 */ 
function gridCreate1() {
    var hdrProperies = '<FC>id={currow}     name="NO"           width=30   align=center  </FC>'
                     + '<FC>id=SALE_DT      name="거래일자"     width=100   align=center   mask="XXXX/XX/XX" SumText="합계"  </FC>'
                     + '<FC>id=STR_CD       name="점포"         width=100   align=center   </FC>'
                     + '<FC>id=POS_NO       name="POS번호"      width=60   align=center   </FC>'
                     + '<FC>id=POS_NAME     name="POS명"      width=150  align=center   </FC>'
                     + '<FC>id=TRAN_NO      name="거래번호"     width=60   align=center   </FC>'
                     + '<FC>id=SALE_TOT_AMT name="매출금액"     width=90  align=right   SumText=@sum </FC>'
                     + '<FC>id=ADD_POINT    name="발생포인트"   width=100   align=right   SumText=@sum </FC>';
                     
     var hdrProperies2 = '<C>id=ITEM_NAME   name="상품명"  width=150  align=left       SumText="합계"  </C>'
                       + '<C>id=SALE_QTY    name="수량"    width=40   align=center    SumText=@sum  </C>'
                       + '<C>id=SALE_PRC    name="단가"    width=70   align=right     </C>'
                       + '<C>id=SALE_AMT    name="금액"    width=80  align=right      SumText=@sum  </C>';
     
     var hdrProperies3 = '<C>id=ADD_TYPE   name="적립유형"  width=120  align=left    EditStyle=Lookup Data="DS_ADD_TYPE:CODE:NAME"  SumText="합계" </C>'
                       + '<C>id=PAY_NAME   name="결재수단"  width=70  align=left    </C>'
                       + '<C>id=PAY_AMT    name="매출금액"  width=70  align=right   SumText=@sum  </C>'
                       + '<C>id=ADD_RATE   name="적립율"    width=50  align=right    </C>'
                       + '<C>id=ADD_POINT  name="포인트"    width=60  align=right   SumText=@sum  </C>';

    initGridStyle(GR_MASTER,  "common", hdrProperies,  false);
    initGridStyle(GR_DETAIL,  "common", hdrProperies2, false);
    initGridStyle(GR_DETAIL2, "common", hdrProperies3, false);

    GR_MASTER.ViewSummary  = "1";
    GR_DETAIL.ViewSummary  = "1";
    GR_DETAIL2.ViewSummary = "1";
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 엑셀       - btn_Excel()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자     : jinjung.kim
 * 작 성 일     : 2010.03.25
 * 개       요     : 조회시 호출
 * return값 : void
 */
function btn_Search() {

    if(trim(EM_SALE_DT_FROM.Text).length == 0 ){
        showMessage(EXCLAMATION, OK, "USER-1000",  "영업일자의 시작일자는 필수입력항목입니다.");
        EM_SALE_DT_FROM.Focus();
        return;
    }

    if(trim(EM_SALE_DT_TO.Text).length == 0 ){
        showMessage(EXCLAMATION, OK, "USER-1000",  "영업일자의 종료일자는 필수입력항목입니다.");
        EM_SALE_DT_TO.Focus();
        return;
    }

    if (EM_SALE_DT_TO.Text < EM_SALE_DT_FROM.Text) {
        showMessage(EXCLAMATION, OK, "USER-1000",  "영업일자의 시작일이 종료일보다 큽니다.");
        EM_SALE_DT_FROM.Focus();
        return;
    }

    if(trim(EM_Q_CARD_NO.Text).length == 0 && trim(EM_Q_SS_NO.Text).length == 0 && trim(EM_CUST_ID_S.Text).length == 0 ){
        showMessage(EXCLAMATION, OK, "USER-1000",  "카드번호/생년월일/회원명 중 하나는 반드시 입력되어야 합니다.");
        EM_Q_CARD_NO.Focus();
        return;
    }else {
        if (trim(EM_CUST_ID_S.Text).length > 0 && trim(EM_CUST_ID_S.Text).length != 9) {
            showMessage(EXCLAMATION, OK, "USER-1000",  "회원은 9자리입니다.");
            EM_CUST_ID_S.focus();
            return;
       }
   }
    DS_O_DETAIL.ClearData();
	DS_O_DETAIL2.ClearData();
	bfMasterRowPos = 0;
	
    var goTo        = "searchMaster";    
    var parameters  = "&SALE_DT_FROM=" + encodeURIComponent(EM_SALE_DT_FROM.Text);
        parameters += "&SALE_DT_TO="   + encodeURIComponent(EM_SALE_DT_TO.Text);
        parameters += "&CARD_NO="      + encodeURIComponent(EM_Q_CARD_NO.Text);
        parameters += "&SS_NO="        + encodeURIComponent(EM_Q_SS_NO.Text);
        parameters += "&CUST_ID="      + encodeURIComponent(EM_CUST_ID_S.Text);
        
    EXCEL_PARAMS = "시작일자=" + EM_SALE_DT_FROM.Text;
    EXCEL_PARAMS += "-종료일자=" + EM_SALE_DT_TO.Text;
    EXCEL_PARAMS += "-카드번호=" + EM_Q_CARD_NO.Text;
    EXCEL_PARAMS += "-생년월일=" + EM_Q_SS_NO.Text;
    EXCEL_PARAMS += "-고객ID=" + EM_CUST_ID_S.Text;
    EXCEL_PARAMS += "-고객명=" + EM_CUST_NAME_S.Text;

    TR_MASTER.Action   = "/dcs/dmbo603.do?goTo=" + goTo + parameters;  
    TR_MASTER.KeyValue = "SERVLET(O:DS_O_CUST=DS_O_CUST,O:DS_O_MASTER=DS_O_MASTER)"; 
    TR_MASTER.Post();

    //조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
}
/**
 * btn_Excel()
 * 작 성 자     : jinjung.kim
 * 작 성 일     : 2010.03.25
 * 개       요     : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
    GR_MASTER.GridToExcelExtProp("HideColumn") = "{currow}";
    var ExcelTitle = "영수증적립내역상세";
    //openExcel2(GR_MASTER, ExcelTitle, EXCEL_PARAMS, true );
    openExcel5(GR_MASTER, ExcelTitle, EXCEL_PARAMS, true , "",g_strPid );

}
/**
 * btn_New()
 * 작 성 자     : jinjung.kim
 * 작 성 일     : 2010-02-25
 * 개       요     : Grid 레코드 추가
 * return값 : void
 */
 
function btn_New() {
	DS_O_CUST.ClearData();
    DS_O_MASTER.ClearData();
    DS_O_DETAIL.ClearData();
    DS_O_DETAIL2.ClearData();
    EM_CARD_NO_CUT.Text = "";
    EM_Q_CARD_NO.Text = "";
    EM_CARD_NO_H.Text = "";
    EM_Q_SS_NO.Text = "";
   // EM_SS_NO_S.Text = "";
   // EM_SS_NO_H.Text = "";
    EM_CUST_ID_S.Text = "";
	EM_CUST_NAME_S.Text = "";  
	EM_SS_NO.Text = ""; 
	initEmEdit(EM_SS_NO,          "000000",      READ);
}


/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
 * f_Search2()
 * 작 성 자     : jinjung.kim
 * 작 성 일     : 2010.03.25
 * 개       요     : 디테일 조회
 * return값 : void
 */
function f_Search2(row) {	 
    var ds = DS_O_MASTER;
    var goTo        = "searchDetail";    
    var parameters  = "&STR_CD="  + encodeURIComponent(ds.NameValue(row, "STR_CD"));
        parameters += "&SALE_DT=" + encodeURIComponent(ds.NameValue(row, "SALE_DT"));
        parameters += "&POS_NO="  + encodeURIComponent(ds.NameValue(row, "POS_NO"));
        parameters += "&TRAN_NO=" + encodeURIComponent(ds.NameValue(row, "TRAN_NO"));

    TR_DETAIL.Action   = "/dcs/dmbo603.do?goTo=" + goTo + parameters;  
    TR_DETAIL.KeyValue = "SERVLET(O:DS_O_DETAIL=DS_O_DETAIL,O:DS_O_DETAIL2=DS_O_DETAIL2)"; 
    TR_DETAIL.Post();
}




-->
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
<script language=JavaScript for=TR_MASTER event=onSuccess>
    
    for(var i = 0; i < this.SrvErrCount('UserMsg'); i++) {
        showMessage(INFORMATION, OK, "USER-1000", this.SrvErrMsg('UserMsg',i));
    }
    if (DS_O_CUST.CountRow > 0) {
        initEmEdit(EM_SS_NO,          "000000",      READ);
    } else {
        initEmEdit(EM_SS_NO,          "000000",      READ);
    }
    if (DS_O_MASTER.CountRow > 0) {
        GR_MASTER.focus();
    } else {
        EM_SALE_DT_FROM.focus();
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MASTER event=onFail>
    trFailed(TR_MASTER.ErrorMsg);
</script>
<script language=JavaScript for=TR_DETAIL event=onFail>
    trFailed(TR_DETAIL.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>
	if( row < 1 || bfMasterRowPos == row)
    	return;
	bfMasterRowPos = row;
    f_Search2(row);
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 단축카드번호 onKillFocus() -->
<script language=JavaScript for=EM_CARD_NO_CUT event=onKillFocus()>
    //EM_Q_CARD_NO.Text = cardCheckDigit(EM_CARD_NO_CUT.Text); 
	if ( trim(EM_CARD_NO_CUT.Text).length != 0 ) {
		EM_Q_CARD_NO.Text = cardCheckDigit(EM_CARD_NO_CUT.Text);
    }
</script>
<!-- 회원ID onKillFocus() -->
<script language=JavaScript for=EM_CUST_ID_S event=onKillFocus()>
    if ((EM_CUST_ID_S.Modified) && (EM_CUST_ID_S.Text.length != 9)) {
        EM_CUST_NAME_S.Text = ""; 
        EM_CUST_NAME_S.Text = ""; 
        EM_CARD_NO_H.Text   = "";
        EM_SS_NO_H.Text     = "";
    } 
</script>
<script language=JavaScript for=EM_CUST_ID_S event=onKeyDown(kcode,scode)>
    if (!(kcode == 13 || kcode == 9)) EM_CUST_NAME_S.Text = "";
</script>
<!-- Grid DETAIL oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    setPorcCount("SELECT", document.getElementById(this.DataId).CountRow);
    sortColId( eval(this.DataID), row, colid);
</script>
<!-- Grid DETAIL oneClick event 처리 -->
<script language=JavaScript for=GR_DETAIL event=OnClick(row,colid)>
   setPorcCount("SELECT", document.getElementById(this.DataId).CountRow);
    sortColId( eval(this.DataID), row, colid);
</script>
<!-- Grid DETAIL oneClick event 처리 -->
<script language=JavaScript for=GR_DETAIL2 event=OnClick(row,colid)>
    setPorcCount("SELECT", document.getElementById(this.DataId).CountRow);
    sortColId( eval(this.DataID), row, colid);
</script>


<!-- 조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_SALE_DT_FROM event=onKillFocus()>
    if(!checkDateTypeYMD(EM_SALE_DT_FROM)){
    	EM_SALE_DT_FROM.text = addDate("M", "-1", '<%=strToMonth%>');
    }
</script>
    
<!-- 조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_SALE_DT_TO event=onKillFocus()>
	if(!checkDateTypeYMD(EM_SALE_DT_TO)){
		EM_SALE_DT_TO.text = <%=toDate%>;
	}
</script> 

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                              *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                  *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->
<!-- ===============- Output용 -->
<comment id="_NSID_">
  <object id="DS_O_CUST"  classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
  <object id="DS_O_MASTER"  classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
  <object id="DS_O_DETAIL"  classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
  <object id="DS_O_DETAIL2"  classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
  <object id="DS_I_CONDITION"  classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
  <object id="DS_O_RESULT"  classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_ADD_TYPE" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
  <object id="TR_MASTER" classid=<%=Util.CLSID_TRANSACTION%>>
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
<comment id="_NSID_">
  <object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
  </object>
</comment>
<script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                 *-->
<!--*************************************************************************-->

<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GR_MASTER");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
	
}
</script>

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
      <td> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
        <tr>
          <td>
          <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
            <tr>
                <th width="77" class="point">영업일자</th>
                <td colspan="5">
                    <comment id="_NSID_">
                      <object id=EM_SALE_DT_FROM classid=<%=Util.CLSID_EMEDIT%> width=80 align="absmiddle" tabindex=1> <img src="/<%=dir%>/imgs/icon/ico_calender.gif" align="absmiddle"/></object>
                    </comment>
                    <script> _ws_(_NSID_);</script>                                             
                    <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_SALE_DT_FROM)"/> 
                    ~
                    <comment id="_NSID_">
                      <object id=EM_SALE_DT_TO classid=<%=Util.CLSID_EMEDIT%> width=80 align="absmiddle" tabindex=1> <img src="/<%=dir%>/imgs/icon/ico_calender.gif" align="absmiddle"/></object>
                    </comment>
                    <script> _ws_(_NSID_);</script>                                             
                    <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_SALE_DT_TO)"/>
                </td>
              </tr>
              <tr>
                <th width="77">카드번호</th> 
                <!--
                <td width="160">
                  <comment id="_NSID_">
                    <object id=EM_Q_CARD_NO classid=<%=Util.CLSID_EMEDIT%> width="140" tabindex=1 align="absmiddle"></object> 
                  </comment>
                  <script> _ws_(_NSID_);</script>
                </td>
                -->
				<td width="170"><comment id="_NSID_"> <object style="display:none"
					id=EM_CARD_NO_CUT classid=<%=Util.CLSID_EMEDIT%> width="55"
					tabindex=1 align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
				    <comment id="_NSID_"> <object
					id=EM_Q_CARD_NO classid=<%=Util.CLSID_EMEDIT%> width="155"
					tabindex=1 align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
				</td>                
                <th width="80">생년월일</th>
                <td width="150">
                  <comment id="_NSID_">
                    <object id=EM_Q_SS_NO classid=<%=Util.CLSID_EMEDIT%> width=140  tabindex=1 ></object>
                    </comment>
                  <script> _ws_(_NSID_);</script>
                </td>
                <th width="80">회원명</th>
                <td>
                  <comment id="_NSID_">
                    <object id=EM_CUST_ID_H classid=<%=Util.CLSID_EMEDIT%> tabindex=1 align="absmiddle"></object> 
                  </comment>
                  <script> _ws_(_NSID_);</script>
                   <comment id="_NSID_">
                    <object id=EM_CARD_NO_H classid=<%=Util.CLSID_EMEDIT%> tabindex=1 align="absmiddle"></object> 
                  </comment>
                  <script> _ws_(_NSID_);</script>
                   <comment id="_NSID_">
                    <object id=EM_SS_NO_H classid=<%=Util.CLSID_EMEDIT%> tabindex=1 align="absmiddle"></object> 
                  </comment>
                  <script> _ws_(_NSID_);</script>
                  <comment id="_NSID_">
                    <object id=EM_CUST_ID_S classid=<%=Util.CLSID_EMEDIT%> width=67 tabindex=1 onKeyUp="javascript:getCustInfoSrch(event.keyCode,this,'EM_CUST_ID_S','P');" align="absmiddle"></object> 
                  </comment>
                  <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle" onclick="getCompPop(EM_CUST_ID_S,EM_CUST_NAME_S,'P')"/> 
                  <comment id="_NSID_">
                    <object id=EM_CUST_NAME_S classid=<%=Util.CLSID_EMEDIT%> width=75 align="absmiddle"></object>       
                  </comment>
                  <script> _ws_(_NSID_);</script>
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
      <td class="PT01 PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td>
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
              <tr>
                <th width="80">회원명</th>
                <td width="160">
                  <comment id="_NSID_">
                    <object id=EM_CUST_NM classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1 align="absmiddle"></object> 
                 </comment>
                 <script> _ws_(_NSID_);</script>
                </td>
                <th width="80">자택전화</th> 
                <td width="160">
                  <comment id="_NSID_">
                  <object id=EM_HOME_PH classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1></object>
                  </comment>
                  <script> _ws_(_NSID_);</script>
                  </td>
                <th width="80">이동전화</th>
                <td>
                  <comment id="_NSID_">
                  <object id=EM_MOBILE_PH classid=<%=Util.CLSID_EMEDIT%> width=168 tabindex=1></object>
                 </comment>
                  <script> _ws_(_NSID_);</script>
                </td>
              </tr>
             <tr>
                <th width="80">생년월일</th>
                <td>
                  <comment id="_NSID_">
                   <object id=EM_SS_NO classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1></object>
                  </comment>
                  <script> _ws_(_NSID_);</script>
                   </td>
                <th>회원주소</th>
                <td colspan="3">
                  <comment id="_NSID_">
                <object id=EM_HOME_ADDR classid=<%=Util.CLSID_EMEDIT%> width=429 tabindex=1 align="absmiddle"></object>
                 </comment>
                  <script> _ws_(_NSID_);</script>
                </td>
              </tr>
              <tr>
                <th >누적포인트</th>
                <td>
                  <comment id="_NSID_">       
                    <object id=EM_POINT classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1></object>
                  </comment>
                  <script> _ws_(_NSID_);</script>  
                </td>     
                <th>이메일주소</th>
                <td>
                  <comment id="_NSID_">     
                    <object id=EM_EMAIL classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1></object>
                  </comment>
                  <script> _ws_(_NSID_);</script>     
                </td>
                <th>회원등급</th>
                <td>
                  <comment id="_NSID_">       
                    <object id=EM_CUST_GRADE classid=<%=Util.CLSID_EMEDIT%> width=168 tabindex=1></object>
                  </comment>
                  <script> _ws_(_NSID_);</script> 
                </td>
              </tr>
              <tr>               
				<th>회원유형</th>
				<td colspan="5"><comment id="_NSID_"> <object id=EM_CUST_TYPE
					classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
				</td>	
                <th style="display:none" >발생포인트</th>
                <td style="display:none">
                  <comment id="_NSID_">       
                    <object id=EM_OCCURS_POINT classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1></object>
                  </comment>
                  <script> _ws_(_NSID_);</script>  
                </td>
				<th style="display:none">가용+발생</th>
				<td style="display:none"><comment id="_NSID_"> <object id=EM_SUM_POINT
					classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
				</td>                 
              </tr>  
            </table>
          </td>
        </tr>
      </table>
      </td> 
    </tr>
    <tr>
		<td class="right red">**회원정보안내 화면과 적립내역이 상이할시에는 해당 거래건이 서버로 미전송되어 안보이는건 입니다.<br>차후 매출전송이 되면 나타납니다.</font></td> 
    </tr>
    <tr valign="top"> 
      <td class="PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr valign="top">
            <td width="50%" rowspan="2">
              <comment id="_NSID_">
                <object id=GR_MASTER width="100%" height=650 classid=<%=Util.CLSID_GRID%> tabindex=1>
                  <param name="DataID" value="DS_O_MASTER">
                </object>
              </comment>
              <script>_ws_(_NSID_);</script>
            </td>
            <td width="50%">
              <comment id="_NSID_">
                <object id=GR_DETAIL width="400" height=200 classid=<%=Util.CLSID_GRID%> tabindex=1>
                  <param name="DataID" value="DS_O_DETAIL">
                </object>
              </comment>
              <script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr valign="top">
            <td width="100%" valign="top">
                <comment id="_NSID_">
                <object id=GR_DETAIL2 width="400" height=450 classid=<%=Util.CLSID_GRID%> tabindex=1>
                  <param name="DataID" value="DS_O_DETAIL2">
                </object>
              </comment>
              <script>_ws_(_NSID_);</script>
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
  <object id=BD_MASTER classid=<%= Util.CLSID_BIND %>>
    <param name=DataID          value=DS_O_CUST>
    <param name="ActiveBind"    value=true>
    <param name=BindInfo        value='
            <c>col=CUST_NAME         ctrl=EM_CUST_NM           Param=Text </c>
            <c>col=HOME_PH1          ctrl=EM_HOME_PH           Param=Text </c>
            <c>col=MOBILE_PH1        ctrl=EM_MOBILE_PH         Param=Text </c>
            <c>col=SS_NO             ctrl=EM_SS_NO             Param=Text </c>
            <c>col=HOME_ADDR         ctrl=EM_HOME_ADDR         Param=Text </c>
            <c>col=POINT             ctrl=EM_POINT             Param=Text </c>
            <c>col=OCCURS_POINT      ctrl=EM_OCCURS_POINT      Param=Text </c>
            <c>col=SUM_POINT     	 ctrl=EM_SUM_POINT    	   Param=Text </c>
            <c>col=EMAIL1            ctrl=EM_EMAIL             Param=Text </c>
            <c>col=CUST_GRADE_NM     ctrl=EM_CUST_GRADE        Param=Text </c>
            <c>col=CUST_TYPE_NM      ctrl=EM_CUST_TYPE         Param=Text </c>
        '>
  </object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>

