<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 사은행사관리 > 사은품 입고/반품 > 상품권 입고/반품조회
 * 작 성 일 : 2011.06.03
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : MCAE3030.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 상품권 입고/반품 내역 조회
 * 이    력 :
 *        2011.06.03 (김정민) 신규작성
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

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
/*************************************************************************
 * 0. 전역변수
 *************************************************************************/  
var g_select =false;
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
 var top = 520;		//해당화면의 동적그리드top위치
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_DETAIL"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    gridCreate2();
    
    // EMedit에 초기화
    initEmEdit(EM_S_S_DT, "SYYYYMMDD", PK);        //기간 S
    initEmEdit(EM_S_E_DT, "YYYYMMDD", PK);         //기간 E
    initEmEdit(EM_S_EVENT_CD, "NUMBER3^11^0", NORMAL);               //행사코드
    initEmEdit(EM_S_EVENT_NM, "GEN^40", READ);               //행사명

    //콤보 초기화
    initComboStyle(LC_S_STR_CD,DS_S_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);      //점
    initComboStyle(LC_S_BUY_FLAG,DS_S_BUY_FLAG, "CODE^0^30,NAME^0^80", 1, NORMAL);  //불출반납구분

    EM_S_E_DT.Text          = getTodayFormat("YYYYMMDD");     //기간E

    getStore("DS_S_STR_CD", "Y", "1", "N");
   //시스템 코드 공통코드에서 가지고 오기
    getEtcCode("DS_S_BUY_FLAG",   "D", "M007", "Y" ,"N");
    

    LC_S_BUY_FLAG.Index = 0;
    LC_S_STR_CD.Index = 0;
    LC_S_STR_CD.Focus();
    
    
    //     
}


function gridCreate1(){
    var hdrProperies ='<FC>id={currow}      name="NO"          width=50   align=center</FC>'
			        + '<FC>id=STR_CD        name="점"          width=80   align=center EditStyle=Lookup   Data="DS_S_STR_CD:CODE:NAME" </FC>'
			        + '<FC>id=EVENT_NAME    name="행사"        width=120  align=LEFT</FC>'
                    + '<FC>id=EVENT_DT      name="행사기간"     width=170  align=center Mask="XXXX/XX/XX~XXXX/XX/XX" SumText="합계" </FC>'
                    + '<FC>id=POUT_FLAG     name="불출반납구분"  width=100  align=LEFT EditStyle=Lookup   Data="DS_S_BUY_FLAG:CODE:NAME" </FC>'
                    + '<FC>id=CONF_DT       name="입고일자"     width=80   align=center Mask="XXXX/XX/XX" </FC>'
                    + '<FC>id=CONF_SLIP_NO2  name="순번"        width=50   align=center</FC>'
                    + '<FC>id=CONF_SLIP_NO  name="순번"        width=50  show=false  align=center</FC>'
                    + '<FC>id=CONF_QTY      name="수량"        width=60   align=RIGHT sumtext=@sum </FC>'
                    + '<FC>id=CONF_AMT      name="입고금액"     width=100  align=RIGHT sumtext=@sum </FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    GD_MASTER.ViewSummary = "1";
}

function gridCreate2(){ 
    var hdrProperies2 ='<FC>id={currow}      name="NO"           width=70   align=center</FC>'
			        + '<FC>id=GIFT_TYPE_NAME name="상품권 종류"    width=120  align=left </FC>'
			        + '<FC>id=GIFT_AMT_NAME  name="금종명"        width=150  align=left SumText="합계" </FC>'
                    + '<FC>id=ISSUE_TYPE     name="ISSUE_TYPE"   width=120  align=center Show=false </FC>'
			        + '<FC>id=GIFTCERT_AMT   name="상품권금액"     width=120  align=right </FC>' 
                    + '<FC>id=CONF_QTY       name="수량"          width=120  align=right sumtext=@sum </FC>'
                    + '<FC>id=CONF_AMT       name="입고금액"       width=120  align=right sumtext=@sum </FC>';
                     
    initGridStyle(GD_DETAIL, "common", hdrProperies2, false);
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
	DS_MASTER.ClearData();
    DS_DETAIL.ClearData();
    
    if(LC_S_STR_CD.BindColVal == ""){  // 점코드
        showMessage(EXCLAMATION , OK, "USER-1001", "점");
        return;
    }
    if(EM_S_S_DT.Text.length == 0){   // 조회시작일
        showMessage(EXCLAMATION , OK, "USER-1001","조회기간");
        EM_S_S_DT.Focus();
        return;
    }else if(EM_S_E_DT.Text.length == 0){    // 조회 종료일
        showMessage(EXCLAMATION , OK, "USER-1001","조회기간");
        EM_S_E_DT.Focus();
        return;
    }else if(EM_S_S_DT.Text > EM_S_E_DT.Text){ // 조회일 정합성
        showMessage(EXCLAMATION , OK, "USER-1015");
        EM_S_S_DT.Focus();
        return;
    }
    
    // 조회조건 셋팅
   var strStrCd    = LC_S_STR_CD.BindColVal;
   var strSdt      = EM_S_S_DT.Text;
   var strEdt      = EM_S_E_DT.Text;
   var strBuy      = LC_S_BUY_FLAG.BindColVal;
   var strEvent    = EM_S_EVENT_CD.Text; 
  
   var goTo       = "getMaster" ;    
   var action     = "O";     
   var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                  + "&strSdt="  +encodeURIComponent(strSdt)
                  + "&strEdt="  +encodeURIComponent(strEdt)
                  + "&strBuy="  +encodeURIComponent(strBuy)
                  + "&strEvent="+encodeURIComponent(strEvent);
   
   TR_MAIN.Action="/mss/mcae303.mc?goTo="+goTo+parameters;  
   TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
   g_select = true;
   TR_MAIN.Post(); 
   g_select = false;
   
   //조회결과 Return
   setPorcCount("SELECT", DS_MASTER.CountRow);
 
   if(DS_MASTER.CountRow > 0){
       getDetail2();
   }
//  setObject(false);
  
 // GD_MASTER.Focus();
	 
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
//    DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
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
 * getSEvent()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-01-26
 * 개    요 :  조회용 이벤트 팝업
 * return값 : void
 */
 function getSEvent(){
    
    // 조회 이벤트 조건 검색시 점코드 필수 
    if(LC_S_STR_CD.BindColVal.length == 0){
        showMessage(EXCLAMATION, OK, "USER-1001", "점");
        return;
    }
    mssEventPop('SEL_STR_EVENT_POP',EM_S_EVENT_CD,EM_S_EVENT_NM,'','','N', LC_S_STR_CD.BindColVal
            , EM_S_S_DT.Text, EM_S_E_DT.Text,'02');
    
 }
 
 /**
  * getDetail()
  * 작 성 자 : 김정민
  * 작 성 일 : 2011-06-03
  * 개    요 :  조회용 이벤트 팝업
  * return값 : void
  */
 function getDetail() {
   // 조회조건 셋팅
   var strStrCd    = DS_MASTER.NameValue(DS_MASTER.RowPosition,"STR_CD");
   var strEvent    = DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_CD");
   var strIlja     = DS_MASTER.NameValue(DS_MASTER.RowPosition,"CONF_DT");
   var strSlip     = DS_MASTER.NameValue(DS_MASTER.RowPosition,"CONF_SLIP_NO");
  
   var goTo       = "getDetail" ;    
   var action     = "O";     
   var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                  + "&strEvent="+encodeURIComponent(strEvent)
                  + "&strIlja=" +encodeURIComponent(strIlja)
                  + "&strSlip=" +encodeURIComponent(strSlip);
   
   TR_MAIN.Action="/mss/mcae303.mc?goTo="+goTo+parameters;  
   TR_MAIN.KeyValue="SERVLET("+action+":DS_DETAIL=DS_DETAIL)"; //조회는 O 
   TR_MAIN.Post();  
   
   //조회결과 Return
   setPorcCount("SELECT", DS_DETAIL.CountRow);
 }
 

 /**
  * getDetail2()
  * 작 성 자 : 김정민
  * 작 성 일 : 2011-06-03
  * 개    요 :  조회용 이벤트 팝업
  * return값 : void
  */
 function getDetail2() {
   // 조회조건 셋팅
   var strStrCd    = DS_MASTER.NameValue(DS_MASTER.RowPosition,"STR_CD");
   var strEvent    = DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_CD");
   var strIlja     = DS_MASTER.NameValue(DS_MASTER.RowPosition,"CONF_DT");
   var strSlip     = DS_MASTER.NameValue(DS_MASTER.RowPosition,"CONF_SLIP_NO");
  
   var goTo       = "getDetail" ;    
   var action     = "O";     
   var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                  + "&strEvent="+encodeURIComponent(strEvent)
                  + "&strIlja=" +encodeURIComponent(strIlja)
                  + "&strSlip=" +encodeURIComponent(strSlip);
   
   TR_MAIN.Action="/mss/mcae303.mc?goTo="+goTo+parameters;  
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
trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
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

<script language=JavaScript for=DS_MASTER event=OnRowPosChanged(row)>
if(clickSORT) return;
    if (row > 0 && g_select==false) {  
        
        setTimeout("getDetail()",50);
    //    GD_DETAIL.SetColumn("RANK");
    }    
</script>

<script language=JavaScript for=DS_DETAIL event=OnRowPosChanged(row)>
if(clickSORT) return; 
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 조회용 행사코드명 한건 조회 -->
<script language=JavaScript for=EM_S_EVENT_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
if(!this.Modified)
    return;
//코드가 존재 하지 않으면 명을 클리어 후 리턴
if( EM_S_EVENT_CD.Text ==""){
    EM_S_EVENT_NM.Text = "";
       return;
   }
if(EM_S_EVENT_CD.text!=null){
    if(EM_S_EVENT_CD.text.length > 0){
        // 조회 이벤트 조건 검색시 점코드 필수 
        if(LC_S_STR_CD.BindColVal.length == 0){
            showMessage(EXCLAMATION , OK, "USER-1001", "점");
            return;
        }
        var ret = setMssEvtNmWithoutPop('DS_O_RESULT', 'SEL_STR_EVT_NAME', EM_S_EVENT_CD, EM_S_EVENT_NM, EM_S_S_DT.Text, EM_S_E_DT.Text, "N", LC_S_STR_CD.BindColVal);
        // 조회내용이 없거나 1개 이상이면 팝업 호출
        if(ret.CountRow == 1){
            EM_S_EVENT_CD.Text = ret.NameValue(ret.RowPosition, "EVENT_CD");
            EM_S_EVENT_NM.Text = ret.NameValue(ret.RowPosition, "EVENT_NM");
        }else{
            mssEventPop('SEL_STR_EVENT_POP',EM_S_EVENT_CD,EM_S_EVENT_NM,'','','N', LC_S_STR_CD.BindColVal
                    , EM_S_S_DT.Text, EM_S_E_DT.Text,'02');
        }
    }
}
</script>

<script language=JavaScript for=LC_S_STR_CD event=OnSelChange()> 
EM_S_EVENT_CD.Text = "";
EM_S_EVENT_NM.Text = "";
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               *-->
<!--*************************************************************************-->

<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_DETAIL");
    
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
<!--* D. 가우스 DataSet & Transaction 정의                                   *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input용 -->
<!-- 검색용 -->
<comment id="_NSID_"><object id="DS_S_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_S_BUY_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_DETAIL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

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

<DIV id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
	          <th width="80" class="point">점</th>
	          <td width="120">
	              <comment id="_NSID_">
                        <object id=LC_S_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=120  tabindex=1 align="absmiddle">
                        </object>
                  </comment><script>_ws_(_NSID_);</script>              
	         <th width="80" class="point">기간</th> 
             <td width="240" align="absmiddle"><comment id="_NSID_">
             <object id=EM_S_S_DT classid=<%=Util.CLSID_EMEDIT%> width=90
                 onblur="javascript:checkDateTypeYMD(this);" tabindex=1
                 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script> <img
                 src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                 onclick="javascript:openCal('G',EM_S_S_DT)" /> ~ <comment
                 id="_NSID_"> <object id=EM_S_E_DT
                 classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1
                 onblur="javascript:checkDateTypeYMD(this);" align="absmiddle">
             </object> </comment><script>_ws_(_NSID_);</script> <img
                 src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                 onclick="javascript:openCal('G',EM_S_E_DT)" /></td>
            <th width="80">불출반납구분</th>
            <td><comment id="_NSID_"> <object id=LC_S_BUY_FLAG
                classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=100
                align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script>
            </td>
	        </tr>
	        <tr>   
            <th>행사코드</th>  
             <td colspan=5><comment id="_NSID_"> <object
                 id=EM_S_EVENT_CD classid=<%=Util.CLSID_EMEDIT%> width=80
                 tabindex=1 align="absmiddle" tabindex=1> </object> </comment><script> _ws_(_NSID_);</script>
             <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
                 onclick="javascript:getSEvent();" align="absmiddle" /> <comment
                 id="_NSID_"> <object id=EM_S_EVENT_NM
                 classid=<%=Util.CLSID_EMEDIT%> width=113 tabindex=1
                 align="absmiddle" tabindex=1> </object> </comment><script> _ws_(_NSID_);</script>
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
    <td class="PT01 PB03"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="BD4A">
      <tr>
        <td>
             <comment id="_NSID_"><OBJECT id=GD_MASTER width=100% height=380 classid=<%=Util.CLSID_GRID%>>
                <param name="DataID" value="DS_MASTER">
             </OBJECT></comment><script>_ws_(_NSID_);</script>
        </td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="dot"></td>
  </tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
      <tr>
        <td>
          <comment id="_NSID_"><OBJECT id=GD_DETAIL width=100% height=380 classid=<%=Util.CLSID_GRID%>>
              <param name="DataID" value="DS_DETAIL">
          </OBJECT></comment><script>_ws_(_NSID_);</script>
        </td>  
      </tr>
    </table></td>
  </tr>
</table>
</DIV>
</body>
</html>

