<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 상품권 출/입고> 본사점 반품 확정
 * 작 성 일 : 2011.01.17
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : mgif2080.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 :
 *        2011.01.17 (김성미) 신규작성 
          2011.03.29 (김슬기) 수정개발
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" 
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>
<% request.setCharacterEncoding("utf-8"); %>

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
<script language="javascript" src="/<%=dir%>/js/common.js"    type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"     type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"    type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"     type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-14
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
        
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //디테일
    
    // EMedit에 초기화
    initEmEdit(EM_S_RFD_DT_S, "YYYYMMDD", PK);  //기간 S(조회)
    initEmEdit(EM_S_RFD_DT_E, "YYYYMMDD", PK);  //기간 E(조회)
    initEmEdit(EM_O_RFD_DT_E, "YYYYMMDD", PK);  //반품확정일자
    
    //콤보 초기화
    initComboStyle(LC_O_HSTR_CD, DS_O_HSTR_CD, "CODE^0^30,NAME^0^80", 1, PK); //본사점(조회) 
    //initComboStyle(LC_O_HSTR_CONF, DS_O_HSTR_CONF, "CODE^0^30,NAME^0^80", 1, NORMAL); //복사확정여부(조회)
    initComboStyle(LC_O_STR_CD, DS_O_STR_CD, "CODE^0^30,NAME^0^80", 1, NORMAL); //반품점(조회)

    //공통코드에서 가져 오기
    getStore("DS_O_HSTR_CD", "N", "0", "N");
    getStore("DS_O_STR_CD", "N", "1", "N");
    
    EM_S_RFD_DT_S.Text = getTodayFormat("YYYYMM01");
    EM_S_RFD_DT_E.Text = getTodayFormat("YYYYMMDD");
    EM_O_RFD_DT_E.Text = getTodayFormat("YYYYMMDD");
    
    LC_O_HSTR_CD.Index = 0;
    LC_O_STR_CD.Index  = 0;
    LC_O_HSTR_CONF.Index  = 0;  
    LC_O_HSTR_CD.Focus();
    
    //종료시 데이터 변경 체크 (common.js)
    registerUsingDataset("mgif208", "DS_MASTER");
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}    name="NO"           width=50   align=center</FC>'
                     + '<FC>id=HSTR_NAME   name="본사점"       width=100  align=left   </FC>'
                     + '<FC>id=STR_NAME    name="반품점"       width=100  align=left   </FC>'
                     + '<FC>id=RFD_DT      name="반품일자"     width=100  align=center Mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=RFD_SLIP_NO name="순번"         width=100   align=center </FC>'
                     + '<FC>id=HSTR_CONF   name="본사확정여부" width=100  align=left   sumtext="합계"</FC>'
                     + '<FC>id=RFD_QTY_SUM name="수량"         width=80   align=rignt  Edit=Numeric sumtext={subsum(RFD_QTY_SUM)}</FC>'
                     + '<FC>id=RFD_AMT_SUM name="반품금액"     width=150   align=rignt Edit=Numeric sumtext={subsum(RFD_AMT_SUM)}</FC>';                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    GD_MASTER.ViewSummary = "1";
}

function gridCreate2(){    
    var hdrProperies = '<FC>id={currow}      name="NO"         width=50   align=center </FC>'
			         + '<FC>id=GIFT_AMT_NAME name="금종명"     width=100   align=left   </FC>'
			         + '<FC>id=GIFTCERT_AMT  name="상품권금액" width=100   align=right  Edit=Numeric</FC>'
			         + '<FC>id=GIFT_S_NO     name="시작번호"   width=150   align=center </FC>'
			         + '<FC>id=GIFT_E_NO     name="종료번호"   width=150   align=center sumtext="합계"</FC>'
			         + '<FC>id=RFD_QTY       name="수량"       width=80   align=right  Edit=Numeric sumtext={subsum(RFD_QTY)}</FC>'
			         + '<FC>id=RFD_AMT       name="출고금액"   width=150   align=right  Edit=Numeric sumtext={subsum(RFD_AMT)}</FC>';        
    initGridStyle(GD_DETAIL, "common", hdrProperies, false);
    GD_DETAIL.ViewSummary = "1";
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
	if (EM_S_RFD_DT_S.Text > EM_S_RFD_DT_E.Text){ 
        showMessage(INFORMATION, OK, "USER-1008", "종료기간", "시작기간");
        EM_S_RFD_DT_E.Focus();
        return;
    }
    
    DS_MASTER.ClearData();
    DS_DETAIL.ClearData();
    
    var strHStrCd   = LC_O_HSTR_CD.BindColVal;   //본사점코드
    var strRfdDtS   = EM_S_RFD_DT_S.Text;        //시작기간
    var strRfdDtE   = EM_S_RFD_DT_E.Text;        //종료기간    
    var strStrCd    = LC_O_STR_CD.BindColVal;    //반품점코드   
    var strHstrConf = LC_O_HSTR_CONF.BindColVal; //본사확정여부
       
    var goTo = "getMaster";
    var action = "O";
    var parameters = "&strHStrCd="   + encodeURIComponent(strHStrCd)
                   + "&strRfdDtS="   + encodeURIComponent(strRfdDtS)
                   + "&strRfdDtE="   + encodeURIComponent(strRfdDtE)
                   + "&strStrCd="    + encodeURIComponent(strStrCd)
                   + "&strHstrConf=" + encodeURIComponent(strHstrConf);
    TR_MAIN.Action = "/mss/mgif208.mg?goTo=" + goTo + parameters;
    TR_MAIN.KeyValue = "SERVLET(" + action + ":DS_MASTER=DS_MASTER)";
    TR_MAIN.Post();
    
    // 조회결과 Return
    setPorcCount("SELECT", DS_MASTER.RealCount(1,DS_MASTER.CountRow));

    if (DS_MASTER.CountRow != 0) {
        GD_MASTER.Focus();    
       // alert();
        if(DS_MASTER.NameValue(DS_MASTER.RowPosition,"HSTR_CONF") == "확정") {
       // 	alert();
            EM_O_RFD_DT_E.Enable = false;
            enableControl(rfddt, false);
        }
        else {
            EM_O_RFD_DT_E.Enable = true;
            enableControl(rfddt, true);
        }
    }else {
      //  showMessage(STOPSIGN, OK, "GAUCE-1003", TR_MAIN.SrvErrMsg('GAUCE',i));
      return;
    } 
    
    gv_preRownoMaster = DS_MASTER.RowPosition;
    gv_preRownoDetail = DS_DETAIL.RowPosition;
  

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
 * 작 성 일 : 2010-12-12
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {

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
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {
	if (DS_MASTER.CountRow == 0){
        showMessage(StopSign, OK, "USER-1079", "확정");
        return;
    }    
    if (DS_MASTER.NameValue(DS_MASTER.RowPosition,"HSTR_CONF") == "확정"){
        showMessage(StopSign, OK, "USER-1000", "이미 반품확정된 전표입니다. ");
        return;
    }
    
    var strRfddt = EM_O_RFD_DT_E.Text;
    if(strRfddt < DS_MASTER.NameValue(DS_MASTER.RowPosition,"RFD_DT")) {
    	showMessage(StopSign, Ok,  "USER-1020", "반품확정일자","반품일자"); 
    	EM_O_RFD_DT_E.Text = getTodayFormat("YYYYMMDD");
    	setTimeout("EM_O_RFD_DT_E.Focus()",50); 
         return;
    }
    
    // 마감체크 (common.js) : 일마감 / 수불마감 
    if( getCloseCheck('DS_CLOSECHECK'
                      , DS_MASTER.NameValue(DS_MASTER.RowPosotion,"STR_CD")
                      , strRfddt
                      ,'MGIF','25','0','D') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "일", "");
        return;
    }
    
    // 마감체크 (common.js) : 월마감 / 수불마감 
    if( getCloseCheck('DS_CLOSECHECK'
                      , DS_MASTER.NameValue(DS_MASTER.RowPosotion,"STR_CD")
                      , strRfddt
                      ,'MGIF','46','0','M') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "월", "");
        return;
    }
    
    if (!DS_DETAIL.IsUpdated) {
        if(showMessage(Question, YESNO, "USER-1205") != 1){
             return;
        }
    }       
    
    DS_DETAIL.UseChangeInfo = "false";
    
    var strRfdDt     = DS_MASTER.NameValue(DS_MASTER.RowPosition,"RFD_DT");
    var strStrCd     = DS_MASTER.NameValue(DS_MASTER.RowPosition,"STR_CD");
    var strRfdSlipNo = DS_MASTER.NameValue(DS_MASTER.RowPosition,"RFD_SLIP_NO");  
    var strRfdDt_E   = EM_O_RFD_DT_E.Text;
    
    var goTo = "conf";
    var parameters = "&strRfdDt="     + encodeURIComponent(strRfdDt)
                   + "&strStrCd="     + encodeURIComponent(strStrCd)
                   + "&strRfdSlipNo=" + encodeURIComponent(strRfdSlipNo)
                   + "&strRfdDt_E="   + encodeURIComponent(strRfdDt_E);
    TR_MAIN.Action = "/mss/mgif208.mg?goTo=" + goTo + parameters;  
    TR_MAIN.KeyValue = "SERVLET(I:DS_DETAIL=DS_DETAIL)";
    TR_MAIN.Post();

    DS_MASTER.ClearData();
    DS_DETAIL.ClearData();
    btn_Search();
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
* getDetail()
* 작 성 자 : 김슬기
* 작 성 일 : 2011-03-25
* 개    요 :  디테일 리스트 조회
* return값 : void
*/
function getDetail(){
    var strStrCd     = DS_MASTER.NameValue(DS_MASTER.RowPosition,"STR_CD");
    var strRfdDt     = DS_MASTER.NameValue(DS_MASTER.RowPosition,"RFD_DT");
    var strRfdSlipNo = DS_MASTER.NameValue(DS_MASTER.RowPosition,"RFD_SLIP_NO");
   
    var goTo       = "getDetail" ;    
    var action     = "O";     
    var parameters = "&strStrCd="     + encodeURIComponent(strStrCd)
                   + "&strRfdDt="     + encodeURIComponent(strRfdDt)
                   + "&strRfdSlipNo=" + encodeURIComponent(strRfdSlipNo);
   
    TR_MAIN.Action="/mss/mgif207.mg?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_DETAIL=DS_DETAIL)"; //조회는 O
    TR_MAIN.Post();
} 
 
function getDate(){
	openCal('G',EM_O_RFD_DT_E);
	if(EM_O_RFD_DT_E.Text < DS_MASTER.NameValue(DS_MASTER.RowPosition,"RFD_DT")){
		showMessage(EXCLAMATION, OK, "USER-1008", "반품 확정일자", "반품일자");
		EM_O_RFD_DT_E.Text = DS_MASTER.NameValue(DS_MASTER.RowPosition,"RFD_DT");
		return;
	}
}
--></script>
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
  /*  showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    } */
    trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_MASTER event=OnDataError(row,colid)>
    var colName = GD_MASTER.GetHdrDispName(-3, colid);
    if (this.ErrorCode == "50018") {
        showMessage(STOPSIGN, OK, "GAUCE-1005", colName);
    } else if (this.ErrorCode == "50019") {
        showMessage(STOPSIGN, OK, "GAUCE-1007", row);
    } else {
        showMessage(STOPSIGN, OK, "USER-1000", this.ErrorMsg);
    }
</script>

<script language=JavaScript for=DS_DETAIL event=OnDataError(row,colid)>
    var colName = GD_DETAIL.GetHdrDispName(-3, colid);
    if (this.ErrorCode == "50018") {
        showMessage(STOPSIGN, OK, "GAUCE-1005", colName);
    } else if (this.ErrorCode == "50019") {
        showMessage(STOPSIGN, OK, "GAUCE-1007", row);
    } else {
        showMessage(STOPSIGN, OK, "USER-1000", this.ErrorMsg);
    }
</script>

<script language=JavaScript for=DS_MASTER event=OnRowPosChanged(row)>
if(clickSORT) return;
    if (row > 0) {        
    	 if(DS_MASTER.NameValue(DS_MASTER.RowPosition,"HSTR_CONF") == "확정") {
    		   //   alert();
    	            EM_O_RFD_DT_E.Enable = false;
    	            enableControl(rfddt, false);
    	  }
    	  else {
    		        EM_O_RFD_DT_E.Enable = true;
    	            enableControl(rfddt, true);
    	  }
    	 
        setTimeout("getDetail()",50);    
    }else {
        DS_DETAIL.ClearData();
    }  
</script>  

<script language=JavaScript for=DS_DETAIL event=OnRowPosChanged(row)>
    if(clickSORT) return; 
</script> 

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------->
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

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                   *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input용 -->
<!-- 검색용 -->
<comment id="_NSID_">
<object id="DS_O_HSTR_CD"  classid=<%= Util.CLSID_DATASET %>></object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_STR_CD"  classid=<%= Util.CLSID_DATASET %>>
</object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_MASTER"  classid=<%= Util.CLSID_DATASET %>>
</object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_DETAIL"  classid=<%= Util.CLSID_DATASET %>>
</object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=DS_I_CONDITION  classid=<%= Util.CLSID_DATASET %>></object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_RESULT"  classid=<%= Util.CLSID_DATASET %>></object>
</comment><script>_ws_(_NSID_);</script>    

<comment id="_NSID_">
<object id="DS_CLOSECHECK"  classid=<%= Util.CLSID_DATASET %>></object>
</comment><script>_ws_(_NSID_);</script>  
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<div id="testdiv" class="testdiv">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="80" class="point">본사점</th>
            <td width="140">
              <comment id="_NSID_">
              <object id=LC_O_HSTR_CD classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=140 align="absmiddle">
              </object></comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80" class="point">기간</th>
            <td>
              <comment id="_NSID_">
              <object id=EM_S_RFD_DT_S classid=<%=Util.CLSID_EMEDIT%> width=80 align="absmiddle" onblur="javascript:checkDateTypeYMD(this);">
              </object></comment><script>_ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_S_RFD_DT_S)" align="absmiddle" />
              ~ 
              <comment id="_NSID_">
              <object id=EM_S_RFD_DT_E classid=<%=Util.CLSID_EMEDIT%> width=80 align="absmiddle" onblur="javascript:checkDateTypeYMD(this);">
              </object></comment><script>_ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_S_RFD_DT_E)" align="absmiddle" />
            </td>
          </tr>
          <tr>
            <th>반품점</th>
            <td>
              <comment id="_NSID_">
              <object id=LC_O_STR_CD ORP_FLAG classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=140 align="absmiddle">
              </object></comment><script>_ws_(_NSID_);</script>
            </td>
            <th>본사확정여부</th>
            <td>
              <comment id="_NSID_">
              <object id=LC_O_HSTR_CONF classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=140 align="absmiddle">
                <param name=CBData          value="%^전체,Y^확정,N^미확정">
                <param name=CBDataColumns   value="Code,Text">
                <param name=ListExprFormat  value="Code^0^30,Text^0^115">
                <param name=SearchColumn    value="Text">
                <param name=BindColumn      value="Code">
              </object></comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr> 
  <tr>
    <td class="dot"></td>
  </tr>
  <tr valign="top">
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr valign="top">
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
		      <tr>
		        <td>
		          <comment id="_NSID_"><OBJECT id=GD_MASTER width=100% height=200 classid=<%=Util.CLSID_GRID%>>
		          <param name="DataID" value="DS_MASTER"></OBJECT></comment><script>_ws_(_NSID_);</script>
		        </td>  
		      </tr>
		    </table>
          </td>
        </tr>
        <tr>
          <td height="5"></td>
        </tr>
        <tr>
          <td class="dot"></td>
        </tr>
        <tr valign="top">
          <td>
            <table width="205" border="0" cellspacing="0" cellpadding="0" class="s_table">
              <tr>                
                <th width=80 class="point">반품확정일자</th>
                <td>
                  <comment id="_NSID_">
                  <object id=EM_O_RFD_DT_E classid=<%=Util.CLSID_EMEDIT%> width=80 align="absmiddle" onblur="javascript:checkDateTypeYMD(this);">
                  </object></comment><script>_ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:getDate();" id=rfddt align="absmiddle" /></td>
               </tr>
             </table>
           </td>
        </tr>   
        <tr>
          <td height="5"></td>
        </tr>     
        <tr valign="top">
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
              <tr>
                <td>
                  <comment id="_NSID_"><OBJECT id=GD_DETAIL width=100% height=233 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_DETAIL">
                  </OBJECT></comment><script>_ws_(_NSID_);</script>
               </td>  
             </tr>
           </table>
        </td>
      </tr>
    </table></td>
  </tr>    
</table>
</div>

<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>

