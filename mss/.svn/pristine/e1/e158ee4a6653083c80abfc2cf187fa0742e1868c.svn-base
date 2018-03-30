<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 임대관리 > 계약변경이력(POPUP)
 * 작 성 일 : 2010.03.25
 * 작 성 자 : 김유완
 * 수 정 자 : 
 * 파 일 명 : MREN1060.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 도시가스요금표관리
 * 이    력 : 2010.04.19 (김유완) 신규작성
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
<%String dir = BaseProperty.get("context.common.dir");%>
<html>
<head>
<title>계약변경이력-POPUP</title>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"   type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작 
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--
 

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/

 var strCntrId      = dialogArguments[0];
 var strStrCd       = dialogArguments[1];
 var strVenCd       = dialogArguments[2];
 var strVenNm       = dialogArguments[3];
 var strCompNo      = dialogArguments[4];
 var strRepNm       = dialogArguments[5];
 var strRentType    = dialogArguments[6];
 var strRentFlag    = dialogArguments[7];
 
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.25
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){
    // Input Data Set Header 초기화 
     
    //그리드 초기화
    gridCreate("MST"); //마스터
    //콤보 초기화 
    initComboStyle(LC_S_FCL_FLAG,DS_LC_FCL_FLAG,            "CODE^0^30,NAME^0^80", 1, READ);    // [조회용]시설구분(점코드)
    initComboStyle(LC_S_RENT_TYPE,  DS_LC_S_RENT_TYPE,      "CODE^0^30,NAME^0^80", 1, READ);    // [조회용]임대형태
    initComboStyle(LC_S_RENT_FLAG,  DS_LC_S_RENT_FLAG,      "CODE^0^30,NAME^0^80", 1, READ);    // [조회용]임대구분
    initEmEdit(EM_S_VEN_CD,     "GEN^6",  READ);                                        // [조회용]협력업사코드 
    initEmEdit(EM_S_VEN_NAME,   "GEN^40", READ);                                        // [조회용]협력업사명  
    initEmEdit(EM_COMP_NO,      "000-00-00000", READ);                                  // [조회용]사업자번호
    initEmEdit(EM_REP_NAME,     "GEN^40", READ);                                        // [조회용]대표자명 
     

    getEtcCode("DS_LC_S_RENT_TYPE",     "D", "P003", "N", "N", LC_S_RENT_TYPE); // [조회용]임대형태      
    getEtcCode("DS_LC_S_RENT_FLAG",     "D", "M091", "N", "N", LC_S_RENT_FLAG); // [조회용]임대구분    
    
    getFlc("DS_LC_FCL_FLAG", "C", "", "Y", "N", "1");                           // [조회용]시설구분(점코드) 
    getEtcCode("DS_LC_GAS_REDU_TYPE",   "D", "M053", "N");                      // 도시가스경감구분 
    getEtcCode("DS_LC_CNTR_TYPE",       "D", "M042", "N");                      // 계약유형 
    //getEtcCode("DS_LC_PWR_DC_TYPE",     "D", "M048", "N");                      // 주택전력복지할인구분      
    //getEtcCode("DS_LC_PWR_REDU_TYPE",   "D", "M049", "N");                      // 주택전력누진하향적용구분      
    getEtcCode("DS_LC_KIND_CD",         "D", "M045", "N");                      // 용도      
    getEtcCode("DS_LC_PWR_TYPE",        "D", "M047", "N");                      // 전압      
    getEtcCode("DS_LC_PWR_SEL_CHARGE",  "D", "M081", "N");                      // 선택요금      
    getEtcCode("DS_LC_WWTR_CHARGE_YN",  "D", "D022", "N");                      // 온수(급탕)차등요금제여부     
    
    
     
    enableControl(imgvencd, false);

    
    LC_S_FCL_FLAG.BindColVal = strStrCd;
    EM_S_VEN_CD.Text = strVenCd;
    EM_S_VEN_NAME.Text = strVenNm;
    EM_COMP_NO.Text = strCompNo;
    EM_REP_NAME.Text = strRepNm;
    LC_S_RENT_TYPE.BindColVal = strRentType;
    LC_S_RENT_FLAG.BindColVal = strRentFlag; 
    //LC_S_FCL_FLAG.index = "0"; 
    btn_Search();
} 

function gridCreate(gdGnb){
	//마스터그리드
	if (gdGnb == "MST") {
	    var hdrProperies = ''
	        + '<FC>ID={CURROW}         NAME="NO"'
	        + '                                            WIDTH=30    ALIGN=CENTER</FC>'
	        + '<FC>ID=CNTR_TYPE        NAME="계약유형"'
	        + '                                            WIDTH=100   ALIGN=LEFT  EDITSTYLE=LOOKUP    DATA="DS_LC_CNTR_TYPE:CODE:NAME"</FC>'
	        + '<FC>ID=CNTR_S_DT        NAME="계약시작일"'
	        + '                                            WIDTH=100   ALIGN=CENTER    MASK="XXXX/XX/XX"</FC>'
	        + '<FC>ID=CNTR_E_DT        NAME="계약종료일"'
	        + '                                            WIDTH=100   ALIGN=CENTER    MASK="XXXX/XX/XX"</FC>'
	        + '<FC>ID=CNTR_AREA        NAME="계약면적"'
	        + '                                            WIDTH=100   ALIGN=RIGHT     EDIT=REALNUMERIC</FC>'
	        + '<FC>ID=EXCL_AREA        NAME="전용면적"'
	        + '                                            WIDTH=100   ALIGN=RIGHT     EDIT=REALNUMERIC</FC>'
	        + '<FC>ID=SHR_AREA         NAME="공유면적"'
	        + '                                            WIDTH=100   ALIGN=RIGHT     EDIT=REALNUMERIC</FC>'
	        + '<FC>ID=RENT_DEPOSIT     NAME="임대보증금"'
	        + '                                            WIDTH=100   ALIGN=RIGHT     EDIT=REALNUMERIC</FC>'
	        + '<FC>ID=MM_RENTFEE_NOVAT NAME="월임대료(VAT제외)"'
	        + '                                            WIDTH=120   ALIGN=RIGHT     EDIT=REALNUMERIC</FC>'
	        + '<FC>ID=MM_RENTFEE_VAT   NAME="월임대료VAT금액"'
	        + '                                            WIDTH=120   ALIGN=RIGHT     EDIT=REALNUMERIC</FC>'
	        + '<FC>ID=MM_RENTFEE       NAME="월임대료(VAT포함)"'
	        + '                                            WIDTH=120   ALIGN=RIGHT     EDIT=REALNUMERIC</FC>'
	        + '<FC>ID=DONGFH           NAME="동/층/호"'
	        + '                                            WIDTH=100   ALIGN=LEFT</FC>'
	        + '<FC>ID=PHONE            NAME="담당자연락처"'
	        + '                                            WIDTH=120   ALIGN=LEFT</FC>'
	        + '<FC>ID=CHAR_NAME        NAME="담당자명"'
	        + '                                            WIDTH=140   ALIGN=LEFT</FC>'
	        + '<FC>ID=MNTN_CAL_YN      NAME="관리비부과여부"'
	        + '                                            WIDTH=100   ALIGN=LEFT</FC>'
            + '<FC>ID=PWR_KIND_CD      NAME="전기용도"'
            + '                                            WIDTH=100   ALIGN=LEFT      EDITSTYLE=LOOKUP    DATA="DS_LC_KIND_CD:CODE:NAME"  SHOW=FALSE</FC>'
            + '<FC>ID=PWR_TYPE         NAME="전압"'
            + '                                            WIDTH=100   ALIGN=LEFT      EDITSTYLE=LOOKUP    DATA="DS_LC_PWR_TYPE:CODE:NAME"  SHOW=FALSE</FC>'
            + '<FC>ID=PWR_SEL_CHARGE   NAME="선택요금"'
            + '                                            WIDTH=100   ALIGN=LEFT      EDITSTYLE=LOOKUP    DATA="DS_LC_PWR_SEL_CHARGE:CODE:NAME"  SHOW=FALSE</FC>'
            + '<FC>ID=PWR_CNTR_QTY     NAME="계약전력"'
            + '                                            WIDTH=100   ALIGN=RIGHT     EDIT=REALNUMERIC  SHOW=FALSE</FC>'
            + '<FC>ID=PWR_REVER_RATE   NAME="역율"'
            + '                                            WIDTH=100   ALIGN=RIGHT     EDIT=REALNUMERIC  SHOW=FALSE</FC>'
            + '<FC>ID=WWTR_KIND_CD     NAME="온수(급탕)용도"'
            + '                                            WIDTH=120   ALIGN=LEFT      EDITSTYLE=LOOKUP    DATA="DS_LC_KIND_CD:CODE:NAME"  SHOW=FALSE</FC>'
            + '<FC>ID=WWTR_QTY         NAME="온수계약용량/;계약면적"'
            + '                                            WIDTH=100   ALIGN=RIGHT     EDIT=REALNUMERIC  SHOW=FALSE</FC>'
            + '<FC>ID=WWTR_CHARGE_YN   NAME="온수(급탕)차등;요금제여부"'
            + '                                            WIDTH=120   ALIGN=LEFT      EDITSTYLE=LOOKUP    DATA="DS_LC_WWTR_CHARGE_YN:CODE:NAME"  SHOW=FALSE</FC>'
            + '<FC>ID=STM_KIND_CD      NAME="(취사)증기용도"'
            + '                                            WIDTH=100   ALIGN=LEFT      EDITSTYLE=LOOKUP    DATA="DS_LC_KIND_CD:CODE:NAME"  SHOW=FALSE</FC>'
            + '<FC>ID=STM_QTY          NAME="증기열교환기열량"'
            + '                                            WIDTH=100   ALIGN=RIGHT     EDIT=REALNUMERIC  SHOW=FALSE</FC>'
            + '<FC>ID=CWTR_KIND_CD     NAME="냉수용도"'
            + '                                            WIDTH=100   ALIGN=LEFT      EDITSTYLE=LOOKUP    DATA="DS_LC_KIND_CD:CODE:NAME"  SHOW=FALSE</FC>'
            + '<FC>ID=CWTR_QTY         NAME="냉수열교환기열량"'
            + '                                            WIDTH=120   ALIGN=RIGHT     EDIT=REALNUMERIC  SHOW=FALSE</FC>'
            + '<FC>ID=GAS_KIND_CD      NAME="가스용도"'
            + '                                            WIDTH=100   ALIGN=LEFT      EDITSTYLE=LOOKUP    DATA="DS_LC_KIND_CD:CODE:NAME"  SHOW=FALSE</FC>'
            + '<FC>ID=GAS_REDU_TYPE    NAME="도시가스경감구분"'
            + '                                            WIDTH=120   ALIGN=LEFT      EDITSTYLE=LOOKUP    DATA="DS_LC_GAS_REDU_TYPE:CODE:NAME"  SHOW=FALSE</FC>'
            + '<FC>ID=WTR_KIND_CD      NAME="수도용도"'
            + '                                            WIDTH=120   ALIGN=LEFT      EDITSTYLE=LOOKUP    DATA="DS_LC_KIND_CD:CODE:NAME"  SHOW=FALSE</FC>'
            + '<FC>ID=DIV_RATE         NAME="공용안분율"'
            + '                                            WIDTH=100   ALIGN=RIGHT     EDIT=REALNUMERIC  SHOW=FALSE</FC>'
            + '<FC>ID=TV_CNT           NAME="TV수신수량"'
            + '                                            WIDTH=100   ALIGN=RIGHT     EDIT=REALNUMERIC  SHOW=FALSE</FC>'
            + '<FC>ID=MOD_DATE         NAME="수정일시"'
            + '                                            WIDTH=140   ALIGN=CENTER</FC>'
	        ;   
	    initGridStyle(GD_MASTER, "COMMON", hdrProperies, false); 
	    GD_MASTER.TitleHeight = "35";
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
 * 작 성 일 : 2010.04.19
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	var strParams = "&strCntrId="      + encodeURIComponent(strCntrId)
			       + "&strStrCd="      + encodeURIComponent(strStrCd)
			       + "&strVenCd="      + encodeURIComponent(strVenCd)
			       + "&strCompNo="     + encodeURIComponent(strCompNo)
			       + "&strRepNm="      + encodeURIComponent(strRepNm)
			       + "&strRentType="   + encodeURIComponent(strRentType)
			       + "&strRentFlag="   + encodeURIComponent(strRentFlag);
	TR_MAIN.Action="/mss/mren201.mr?goTo=getMrenStory"+strParams;
	TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
	TR_MAIN.Post();  

    // 조회결과 Return
    setPorcCount("SELECT", GD_MASTER);
}

/**
 * btn_Close()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.19
 * 개    요 : Close
 * return값 : void
 */  
 function btn_Close()
 {
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
    sortColId( eval(this.DataID), row , colid );
</script>

<script language=JavaScript for=EM_S_VEN_CD event=OnKillFocus()> 
//협력사코드 변경시
    if(!this.Modified) return;
       
    if(this.text==''){
        EM_S_VEN_NAME.Text = "";
        return;
    } 

    setVenNmWithoutPop("DS_O_RESULT", EM_S_VEN_CD, EM_S_VEN_NAME , '1');
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
<comment id="_NSID_"><object id="DS_IO_MASTER"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- =============== Output용 -->

<!-- =============== ONLOAD용 -->
<comment id="_NSID_"><object id="DS_LC_S_RENT_TYPE"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_S_RENT_FLAG"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_FCL_FLAG"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_GAS_REDU_TYPE"   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_CNTR_TYPE"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_PWR_DC_TYPE"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_PWR_REDU_TYPE"   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_PWR_TYPE"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_PWR_SEL_CHARGE"  classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_KIND_CD"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_WWTR_CHARGE_YN"  classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- =============== 공통함수용 -->
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
				        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
				          <tr>
				            <td width="" class="title">
				              <img src="/<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="popR05 PL03"/>
				              <SPAN id="title1" class="PL03">계약이력조회</SPAN>
				            </td>
				            <td><table border="0" align="right" cellpadding="0" cellspacing="0">
				              <tr>
				                <td><img src="/<%=dir%>/imgs/btn/search.gif" width="50" height="22" onClick="btn_Search();"/></td>
				                <td><img src="/<%=dir%>/imgs/btn/close.gif" width="50" height="22"   onClick="btn_Close();"/></td>
				                
				                </tr>
				            </table></td>
				          </tr>
				        </table></td>
                        </td>
                    </tr>
                </table>
                </td>
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
			                        <th width="80">시설구분</th>
			                        <td width="160"><comment id="_NSID_"> <object
			                            id=LC_S_FCL_FLAG classid=<%= Util.CLSID_LUXECOMBO %>
			                            width="160" height=100 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
			                        </td>
			                        <th width="80">협력사</th>  
			                        <td width="230" ><comment id="_NSID_"> <object id=EM_S_VEN_CD
			                            classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1
			                            align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
			                            src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03" id=imgvencd
			                            onclick="javascript:venPop(EM_S_VEN_CD, EM_S_VEN_NAME);EM_S_VEN_CD.Focus();"
			                            align="absmiddle" /> <comment id="_NSID_"> <object
			                            id=EM_S_VEN_NAME classid=<%=Util.CLSID_EMEDIT%> width=150 tabindex=1
			                            align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td> 
			                       <th width="80">사업자번호</th>
			                        <td><comment id="_NSID_"> <object id=EM_COMP_NO
			                            classid=<%=Util.CLSID_EMEDIT%> width=160 tabindex=1
			                            align="absmiddle"> </object> </comment>
			                            <script>_ws_(_NSID_);</script>
			                        </td>
			                    </tr>
			                    <tr> 
			                        <th>대표자명</th>
			                        <td><comment id="_NSID_"> <object id=EM_REP_NAME
			                            classid=<%=Util.CLSID_EMEDIT%> width=155 tabindex=1
			                            align="absmiddle"> </object> </comment>
			                            <script>_ws_(_NSID_);</script>
			                        </td>
			                        <th>임대형태</th>
			                        <td><comment id="_NSID_"> <object id=LC_S_RENT_TYPE
			                            classid=<%=Util.CLSID_LUXECOMBO%> width="230" tabindex=1
			                            align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
			                        <th>임대구분</th>
			                        <td><comment id="_NSID_"> <object id=LC_S_RENT_FLAG
			                            classid=<%=Util.CLSID_LUXECOMBO%> width="165" tabindex=1
			                            align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
			                    </tr> 
			                </table>
                        </td>
                    </tr>
                </table>
                </td>
            </tr>
		    <tr>
		        <td class="sub_title"><img
		            src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12"
		            align="absmiddle" class="PR03" />계약변경 이력</td>
		    </tr>
            <tr>
                <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                    class="g_table">
		            <tr valign="top">
		                <td><comment id="_NSID_"><OBJECT id=GD_MASTER
		                    width=100% height=368 tabindex=1 classid=<%=Util.CLSID_GRID%>>
		                    <param name="DataID" value="DS_IO_MASTER">
		                </OBJECT></comment><script>_ws_(_NSID_);</script></td>
		            </tr>
                </table>
                </td>
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
</body>
</html>

