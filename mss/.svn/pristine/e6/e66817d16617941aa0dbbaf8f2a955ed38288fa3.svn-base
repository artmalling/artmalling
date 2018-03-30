<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 상품권 입/출고> 지점 출고조회/삭제 
 * 작 성 일 : 2011.03.23
 * 작 성 자 : 김슬기
 * 수 정 자 : 
 * 파 일 명 : mgif2040.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 지점출고 확정된 내역을 조회한다. 입고확정전의 자료는 삭제후 재등록한다
 * 이    력 :
 *        2011.03.23 (김슬기) 신규작성
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
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){
    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    
    //그리드 초기화
    gridCreate1(); 
    gridCreate2();
    
    // EMedit에 초기화
    initEmEdit(EM_S_OUT_DT_S, "YYYYMMDD", PK); //기간 S(조회)
    initEmEdit(EM_S_OUT_DT_E, "YYYYMMDD", PK);  //기간 E(조회)
    
    //콤보 초기화
    initComboStyle(LC_O_OUT_STR,DS_O_OUT_STR, "CODE^0^30,NAME^0^80", 1, NORMAL); //출고점(조회) 
    //initComboStyle(LC_O_IN_CONF,DS_O_IN_CONF, "CODE^0^30,NAME^0^80", 1, NORMAL); //접입고확정(조회)
    initComboStyle(LC_O_REQ_STR,DS_O_REQ_STR, "CODE^0^30,NAME^0^80", 1, NORMAL); //신청점(조회)

    //공통코드에서 가져 오기 
    getStore("DS_O_OUT_STR", "N", "0", "N");
    getStore("DS_O_REQ_STR", "N", "1", "Y");
    getEtcCode("DS_O_IN_CONF", "D", "", "N", "N");  
    
    EM_S_OUT_DT_S.Text = getTodayFormat("YYYYMM01");
    EM_S_OUT_DT_E.Text = getTodayFormat("YYYYMMDD");
    
    LC_O_OUT_STR.Index = 0;
    LC_O_REQ_STR.Index = 0;
    LC_O_IN_CONF.Index = 0;
    LC_O_OUT_STR.Focus();
    
    //종료시 데이터 변경 체크 (common.js)
    registerUsingDataset("mgif204", "DS_MASTER");       
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}    name="NO"         width=30   align=center   edit=none </FC>'
			    	 + '<FC>id=FLAG        name="선택"       width=50   align=center   EditStyle=CheckBox  HeadCheckShow=true Edit={IF(IN_CONF="미확정","true","false")}</FC>'
			         + '<FC>id=OUT_NAME    name="출고점"     width=110  align=left     edit=none </FC>'
                     + '<FC>id=REQ_NAME    name="신청점"     width=110  align=left     edit=none </FC>'
                     + '<FC>id=OUT_DT      name="출고일자"   width=90   align=center   edit=none Mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=REQ_DT     name="출고일자"   width=90   align=center   edit=none Show=false  Mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=REQ_SLIP_NO name="순번"       width=100  align=center   edit=none Show=false </FC>'
                     + '<FC>id=OUT_SLIP_NO name="순번"       width=100  align=center   edit=none sumtext="합계"</FC>'
                     + '<FC>id=OUT_QTY_SUM name="수량"       width=90  align=right    edit=none sumtext={subsum(OUT_QTY_SUM)}</FC>'
                     + '<FC>id=OUT_AMT_SUM name="출고금액"   width=120  align=right    edit=none sumtext={subsum(OUT_AMT_SUM)}</FC>'
                     + '<FC>id=IN_CONF     name="점입고확정" width=80   align=left     edit=none </FC>';                 
    initGridStyle(GD_MASTER, "common", hdrProperies, true);
    GD_MASTER.ViewSummary = "1";
}

function gridCreate2(){
    var hdrProperies = '<FC>id={currow}      name="NO"         width=30  align=center  </FC>'
                     + '<FC>id=GIFT_AMT_NAME name="금종명"     width=110  align=left   </FC>'
                     + '<FC>id=GIFTCERT_AMT  name="상품권금액" width=110  align=rignt  Edit=Numeric </FC>'
                     + '<FC>id=GIFT_S_NO     name="시작번호"   width=150  align=center </FC>'
                     + '<FC>id=GIFT_E_NO     name="종료번호"   width=150  align=center sumtext="합계"</FC>'
                     + '<FC>id=OUT_QTY       name="수량"       width=100  align=right  Edit=Numeric sumtext={subsum(OUT_QTY)}</FC>'
                     + '<FC>id=OUT_AMT       name="출고금액"   width=120  align=right  Edit=Numeric sumtext={subsum(OUT_AMT)}</FC>';                   
    initGridStyle(GD_DETAIL, "common", hdrProperies, false);
    GD_DETAIL.ViewSummary = "1";
    DS_DETAIL.UseChangeInfo = false;
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
	if (DS_DETAIL.IsUpdated) {
        if (showMessage(Question, YesNo, "USER-1059") != "1") { //아니요
            DS_MASTER.RowPosition = gv_preRownoMaster;
            DS_DETAIL.RowPosition = gv_preRownoDetail;
            return;
        }      
	}  
	if (EM_S_OUT_DT_S.Text > EM_S_OUT_DT_E.Text){ 
        showMessage(INFORMATION, OK, "USER-1008", "종료기간", "시작기간");
        EM_S_OUT_DT_E.Focus();
        return;
    }
    if (LC_O_OUT_STR.BindColVal == "") {
    	 showMessage(INFORMATION, OK, "USER-1000", "출고점이 확실하지 않습니다.");
    	 return;
    }
	
    DS_MASTER.ClearData();
    DS_DETAIL.ClearData();

    var strOutStr = LC_O_OUT_STR.BindColVal; //출고점코드
    var strReqStr = LC_O_REQ_STR.BindColVal; //신청점코드
    var strOutDtS = EM_S_OUT_DT_S.Text;      //시작기간
    var strOutDtE = EM_S_OUT_DT_E.Text;      //종료기간
    var strInConf = LC_O_IN_CONF.BindColVal; //점입고확정
       
    var goTo = "getMaster";
    var action = "O";
    var parameters = "&strOutStr=" + encodeURIComponent(strOutStr) 
                   + "&strReqStr=" + encodeURIComponent(strReqStr) 
                   + "&strOutDtS=" + encodeURIComponent(strOutDtS) 
                   + "&strOutDtE=" + encodeURIComponent(strOutDtE)
                   + "&strInConf=" + encodeURIComponent(strInConf);
    TR_MAIN.Action = "/mss/mgif204.mg?goTo=" + goTo + parameters;
    TR_MAIN.KeyValue = "SERVLET(" + action + ":DS_MASTER=DS_MASTER)";
    TR_MAIN.Post();
    
    // 조회결과 Return
    setPorcCount("SELECT", DS_MASTER.RealCount(1,DS_MASTER.CountRow));
    
    if (DS_MASTER.CountRow != 0) {
    	GD_MASTER.Focus();    
    }else {
    	return;
        //showMessage(STOPSIGN, OK, "GAUCE-1003", TR_MAIN.SrvErrMsg('GAUCE',i));
    } 
    //전체선택 해제
    GD_MASTER.ColumnProp("FLAG", "HeadCheck")= "false";
 
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
    if (!DS_MASTER.IsUpdated) {
        if (showMessage(StopSign, Ok, "USER-1019") != "1") {
            //DS_MASTER.Focus();
            return;
        }
        else {
        	return;
        }
    }
    else { 
        if(showMessage(Question, YesNo, "USER-1023") != "1") {
        	// DS_MASTER.Focus();
        	return;
        }  
        else {

            var strOutStr  = DS_MASTER.NameValue(DS_MASTER.RowPosition,"OUT_STR");     //출고점코드 
            var strOutDt   = DS_MASTER.NameValue(DS_MASTER.RowPosition,"OUT_DT");      //출고일
             
            var goTo = "updategift";
            var parameters = "&strOutStr="   + encodeURIComponent(strOutStr) 
                           + "&strOutDt="    + encodeURIComponent(strOutDt); 
            
            var goTo = "delete";
            TR_MAIN.Action   = "/mss/mgif204.mg?goTo=" + goTo+parameters;
            TR_MAIN.KeyValue ="SERVLET(I:DS_MASTER=DS_MASTER, I:DS_DETAIL=DS_DETAIL)"; //조회는 O
            TR_MAIN.Post(); 
        } 
        btn_Search();
    }
    
   // return;
 
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

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 
/**
 * getDetail()
 * 작 성 자 : 김슬기
 * 작 성 일 : 2011-03-07
 * 개    요 :  입금내역 조회
 * return값 : void
 */
function getDetail(){    
	var strOutDt   = DS_MASTER.NameValue(DS_MASTER.RowPosition,"OUT_DT");      //출고일
    var strOutStr  = DS_MASTER.NameValue(DS_MASTER.RowPosition,"OUT_STR");     //출고점코드
    var strOutSlip = DS_MASTER.NameValue(DS_MASTER.RowPosition,"OUT_SLIP_NO"); //출고전표번호
	    
    var goTo       = "getDetail" ;    
    var action     = "O";     
    var parameters = "&strOutDt="   + encodeURIComponent(strOutDt)
                   + "&strOutStr="  + encodeURIComponent(strOutStr)
                   + "&strOutSlip=" + encodeURIComponent(strOutSlip);
   
    TR_MAIN.Action="/mss/mgif204.mg?goTo="+goTo+parameters; 
    TR_MAIN.KeyValue="SERVLET("+action+":DS_DETAIL=DS_DETAIL)"; //조회는 O
    TR_MAIN.Post();   
}

 

-->
</script>
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
	    if (colid != "FLAG"){
	        sortColId(eval(this.DataID), row, colid);
	    }
    }    
</script>

<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    //정렬
    if (row == 0){
        sortColId(eval(this.DataID), row, colid);
    }     
</script>

<script language=javascript  for=GD_MASTER event=OnHeadCheckClick(Col,Colid,bCheck)>
//헤더 전체 체크/체크해제 컨트롤
    if (bCheck == '1'){ // 전체체크
        for(var i=1; i<=DS_MASTER.CountRow; i++){
        	if (DS_MASTER.NameValue(i, "IN_CONF") == "미확정"){
        	    DS_MASTER.NameValue(i, "FLAG") = 'T';
        	}
        }
    }else{  // 전체체크해제
        for (var i=1; i<=DS_MASTER.CountRow; i++){
            DS_MASTER.NameValue(i, "FLAG") = 'F';
        }
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
<object id="DS_O_OUT_STR"  classid=<%= Util.CLSID_DATASET %>></object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_IN_CONF"  classid=<%= Util.CLSID_DATASET %>></object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_REQ_STR"  classid=<%= Util.CLSID_DATASET %>></object>
</comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_MASTER"  classid=<%= Util.CLSID_DATASET %>></object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_DETAIL"  classid=<%= Util.CLSID_DATASET %>></object>
</comment><script>_ws_(_NSID_);</script>

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
<body onLoad="doInit();" class="PL10 PT15 ">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<DIV id="testdiv" class="testdiv">

<table width="100%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td>
          <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
            <tr>
	          <th width="80" class="point">출고점</th>
	          <td width="140">
	            <comment id="_NSID_">
	            <object id=LC_O_OUT_STR classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=145 tabindex=0 align="absmiddle">
	            </object>
	            </comment><script>_ws_(_NSID_);</script>   
	          </td>
	          <th width="80" class="point">기간</th>
	          <td width="220">
	            <comment id="_NSID_">
	            <object id=EM_S_OUT_DT_S classid=<%= Util.CLSID_EMEDIT %> width=80 tabindex=0 align="absmiddle" onblur="javascript:checkDateTypeYMD(this);">
	            </object>
	            </comment><script>_ws_(_NSID_);</script>
	            <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_S_OUT_DT_S)" />
	            ~
	            <comment id="_NSID_">
                <object id=EM_S_OUT_DT_E classid=<%= Util.CLSID_EMEDIT %> width=80 tabindex=0 align="absmiddle" onblur="javascript:checkDateTypeYMD(this);">
                </object>
                </comment><script>_ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_S_OUT_DT_E)" />
              </td>
              <th width="80">점입고확정</th>
              <td>
                <comment id="_NSID_">
                <object id=LC_O_IN_CONF classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=145 tabindex=0 align="absmiddle" >
                  <param name=CBData          value="%^전체,Y^확정,N^미확정">
                  <param name=CBDataColumns   value="Code,Text">
                  <param name=ListExprFormat  value="Code^0^30,Text^0^115">
                  <param name=SearchColumn    value="Text">
                  <param name=BindColumn      value="Code">
                </object>
                </comment><script>_ws_(_NSID_);</script>   
              </td>
            </tr>
            <tr>  
              <th>신청점</th>
              <td colspan="5">
                <comment id="_NSID_">
                <object id=LC_O_REQ_STR classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=145 tabindex=0 align="absmiddle">
                </object>
                </comment><script>_ws_(_NSID_);</script>   
              </TD>
            </tr>              
          </table>
        </td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="dot"></td>
  </tr>
    <tr valign="top">
      <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="100%"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
            <tr>
              <td width="100%">
	            <comment id="_NSID_"><OBJECT id=GD_MASTER width=100% height=233 classid=<%=Util.CLSID_GRID%>>
	            <param name="DataID" value="DS_MASTER">
	            </OBJECT></comment><script>_ws_(_NSID_);</script>
	          </td>
            </tr>
	      </table></td>
	    </tr>
	    <tr>
          <td height=5></td>
        </tr>
        <tr>
          <td class="dot"></td>
        </tr>
	    <tr>
          <td width="100%"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
            <tr>
              <td width="100%">
                <comment id="_NSID_"><OBJECT id=GD_DETAIL width=100% height=240 classid=<%=Util.CLSID_GRID%>>
                <param name="DataID" value="DS_DETAIL">
                </OBJECT></comment><script>_ws_(_NSID_);</script>
               </td>
             </tr>
           </table></td>
         </tr>
       </table></td>
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

