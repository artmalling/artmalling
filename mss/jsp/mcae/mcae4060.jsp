<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 사은행사관리 > 사은품 지급/취소 > 행사별 지급취소내역 조회
 * 작 성 일 : 2011.06.09
 * 작 성 자 : 김정민
 * 수 정 자 : 
 * 파 일 명 : MCAE4060.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : POS별 지급취소 내역을 조회한다.
 * 이    력 : 2011.06.09 (김정민) 신규개발 
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
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">

var btnSaveClick = false;
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
 var top = 500;		//해당화면의 동적그리드top위치
function doInit(){

	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_DETAIL"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	
    // Input Data Set Header 초기화
    DS_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');

    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate1(); //마스터    
    gridCreate2();
    
    // EMedit에 초기화       
    initEmEdit(EM_S_DT, "SYYYYMMDD", PK);                   // [조회용]영수증일자S
    initEmEdit(EM_E_DT, "YYYYMMDD", PK);                    // [조회용]영수증일자E 
    initEmEdit(EM_S_EVENT_CD, "NUMBER3^11^0", NORMAL);      // [조회용]행사코드
    initEmEdit(EM_S_EVENT_NM, "GEN^40", READ);              // [조회용]행사명

    //콤보 초기화
    initComboStyle(LC_S_STR_CD,DS_S_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);      //점(조회)  

    EM_E_DT.Text   = getTodayFormat("YYYYMMDD");
    getStore("DS_S_STR_CD", "Y", "1", "N");
    getEtcCode("DS_EVENT_TYPE", "D", "M002", "N", "N");   //사은행사유형 
    LC_S_STR_CD.Index = 0;
    LC_S_STR_CD.Focus();
}  
function gridCreate1(){
    var hdrProperies ='<FC>id={currow}      name="NO"          width=30    align=center</FC>'
			        + '<FC>id=STR_CD        name="점"          width=90   align=left  EDITSTYLE=LOOKUP   DATA="DS_S_STR_CD:CODE:NAME" </FC>'
                    + '<FC>id=EVENT_CD      name="행사명코드"    width=80   align=left show=false   </FC>'
			        + '<FC>id=EVENT_NAME    name="행사명"       width=140   align=left   </FC>'
                    + '<FC>id=EVENT_S_DT    name="기간S"        width=80   align=left   show=false </FC>'
                    + '<FC>id=EVENT_E_DT    name="기간E"        width=80   align=left   show=false </FC>'
                    + '<FC>id=EVENT_DT      name="행사기간"      width=170   align=center Mask="XXXX/XX/XX~XXXX/XX/XX"  sumtext="합계"  </FC>'
                    + '<FC>id=EVENT_TYPE    name="사은행사유형"   width=110   align=left EDITSTYLE=LOOKUP   DATA="DS_EVENT_TYPE:CODE:NAME"  </FC>' 
                    + '<FC>id=CQTY          name="지급취소;건수"   width=65   align=right sumtext=@sum </FC>'
                    + '<FC>id=MQTY          name="미회수;건수"    width=65   align=right  sumtext=@sum </FC>'
                    + '<FG>id=STR_NAME      name="회수 수량"      align=center >' 
                    + '<FC>id=SQTY          name="상품권"        width=65   align=right  sumtext=@sum </FC>'
                    + '<FC>id=MPQTY         name="물품"          width=65   align=right  sumtext=@sum </FC>'
                    + '</FG>'  
                    ;
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
} 
function gridCreate2(){ 
    var hdrProperies2 ='<FC>id={currow}     name="NO"           width=30   align=center</FC>' 
			        + '<FC>id=PRSNT_DT      name="지급취소일자"   mask="XXXX/XX/XX"   width=120   align=center</FC>'
			        + '<FC>id=PRSNT_NO      name="순번"          width=120  align=center  sumtext="합계" </FC>'
                    + '<FC>id=O_SLIP_NO     name="원거래전표번호"  width=200  align=center   </FC>'
                    + '<FC>id=SKU_NAME      name="지급사은품"     width=200  align=left   </FC>'
                    + '<FC>id=BUY_COST_PRC  name="매입원가"       width=100   align=right  sumtext=@sum </FC>' 
                    ;
                     
    initGridStyle(GD_DETAIL, "common", hdrProperies2, false);
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
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-03-14
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	if(LC_S_STR_CD.BindColVal.length == 0){  // 점코드
        showMessage(EXCLAMATION , OK, "USER-1001", "점");
        LC_S_STR_CD.focus();
        return;
    }
    if(EM_S_DT.Text.length == 0){   // 조회시작일
        showMessage(EXCLAMATION , OK, "USER-1001","기간");
        EM_S_DT.focus();
        return;
    }else if(EM_E_DT.Text.length == 0){    // 조회 종료일
        showMessage(EXCLAMATION , OK, "USER-1001","기간");
        EM_E_DT.focus();
        return;
    }else if(EM_S_DT.Text > EM_E_DT.Text){ // 조회일 정합성
        showMessage(EXCLAMATION , OK, "USER-1015");
        EM_S_DT.focus();
        return;
    }

    DS_MASTER.ClearData();
    DS_DETAIL.ClearData();
    
    // 조회조건 셋팅
    var strStrCd        = LC_S_STR_CD.BindColVal;
    var strSdt          = EM_S_DT.Text;
    var strEdt          = EM_E_DT.Text; 
    var strEvent        = EM_S_EVENT_CD.Text;
    
    var goTo       = "getMaster" ;    
    var parameters = "&strStrCd=" + encodeURIComponent(strStrCd)
                   + "&strSdt="   + encodeURIComponent(strSdt)
                   + "&strEdt="   + encodeURIComponent(strEdt)
                   + "&strEvent=" + encodeURIComponent(strEvent); 
    
    TR_MAIN.Action="/mss/mcae406.mc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET(O:DS_MASTER=DS_MASTER)"; //조회는 O
    g_select = true;
    TR_MAIN.Post(); 
    g_select = false;
    if(DS_MASTER.CountRow > 0){
    	getDetail();
    }
    
    // 조회결과 Return
    setPorcCount("SELECT", DS_MASTER.CountRow);
    
    GD_MASTER.Focus();
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
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-03-14
 * 개    요 : 사은품 회수 저장
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
  * 작 성 자 : 
  * 작 성 일 : 2011-05-18
  * 개    요 : 합산 영수증 정보 조회
  * return값 : void
  */
 function getDetail() {
	 if(DS_MASTER.CountRow ==0){  // 회수정보 조회 내역 여부 
	        showMessage(EXCLAMATION , OK, "USER-1001", "점");
	        return;
	    } 
	    var strStrCd   = DS_MASTER.NameValue(DS_MASTER.RowPosition,"STR_CD");
	    var strEvent   = DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_CD");  
        //var strSdt     = DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_S_DT");  
        //var strEdt     = DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_E_DT");   
        var strSdt          = EM_S_DT.Text;
        var strEdt          = EM_E_DT.Text; 
        
	    var goTo       = "getDetail" ;  
	    var parameters = "&strStrCd=" + encodeURIComponent(strStrCd)   
	                   + "&strEvent=" + encodeURIComponent(strEvent)   
                       + "&strSdt="   + encodeURIComponent(strSdt) 
                       + "&strEdt="   + encodeURIComponent(strEdt);
	    TR_MAIN.Action="/mss/mcae406.mc?goTo="+goTo+parameters;  
	    TR_MAIN.KeyValue="SERVLET(O:DS_DETAIL=DS_DETAIL)"; //조회는 O
	    TR_MAIN.Post();
	    
	    // 조회결과 Return
	    setPorcCount("SELECT", DS_DETAIL.CountRow);
 }
 
 /**
  * getDetail2()
  * 작 성 자 : 
  * 작 성 일 : 2011-05-18
  * 개    요 : 합산 영수증 정보 조회
  * return값 : void
  */
 function getDetail2() {
     if(DS_MASTER.CountRow ==0){  // 회수정보 조회 내역 여부 
            showMessage(EXCLAMATION , OK, "USER-1001", "점");
            return;
        } 
	     var strStrCd   = DS_MASTER.NameValue(DS_MASTER.RowPosition,"STR_CD");
	     var strEvent   = DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_CD");  
	      
	     var goTo       = "getDetail" ;  
	     var parameters = "&strStrCd=" + encodeURIComponent(strStrCd)   
	                    + "&strEvent=" + encodeURIComponent(strEvent);
        TR_MAIN.Action="/mss/mcae406.mc?goTo="+goTo+parameters;  
        TR_MAIN.KeyValue="SERVLET(O:DS_DETAIL=DS_DETAIL)"; //조회는 O
        TR_MAIN.Post();
 }
  
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
     mssEventMstPop('SEL_STR_EVENT_POP',EM_S_EVENT_CD,EM_S_EVENT_NM,LC_S_STR_CD.BindColVal,'4/6');     
  }
  

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
<script language=JavaScript for=DS_MASTER event=CanRowPosChange(row)>
 if(DS_MASTER.IsUpdated){
         if(showMessage(EXCLAMATION , YESNO, "USER-1074") != 1 ){
             return false;
         } 
         return true;
}
return true;
</script>
<script language=JavaScript for=DS_MASTER event=OnRowPosChanged(row)>
if(clickSORT) return; 
if (row > 0 && g_select==false) {   
    setTimeout("getDetail()",50); 
}  
</script>

<script language=JavaScript for=DS_DETAIL event=OnRowPosChanged(row)>
if(clickSORT) return; 
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>

if(row == 0) sortColId( eval(this.DataID), row , colid );
</script>
<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
if(row == 0) sortColId( eval(this.DataID), row , colid );
</script>
 
<script language=JavaScript for=LC_S_STR_CD event=OnSelChange()>
EM_S_EVENT_CD.Text = "";
EM_S_EVENT_NM.Text = "";
</script>

 <script language=JavaScript for=EM_S_EVENT_CD event=OnKillFocus()>
//[조회용]행사; 코드 자동완성 및 팝업호출
//if (EM_SEL_EVENT_CD.Text.length > 0 ) {
    if(!this.Modified)
        return;
        
    if(this.text==''){
        EM_S_EVENT_NM.Text = "";
        return;
    }
    
    if (LC_S_STR_CD.BindColVal == "") {//점 미선택시
        EM_S_EVENT_CD.Text = "";
        showMessage(STOPSIGN, OK, "USER-1003", "점");
        LC_S_STR_CD.Focus();
        return;
    } 
    setMssEvtMstNmWithoutPop('DS_O_RESULT', 'SEL_STR_EVT_NAME', EM_S_EVENT_CD, EM_S_EVENT_NM, LC_S_STR_CD.BindColVal,'4/6');  
    if (DS_O_RESULT.CountRow == 1 ) {  
        EM_S_EVENT_CD.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "EVENT_CD");
        EM_S_EVENT_NM.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "EVENT_NM");
    } else {
        //1건 이외의 내역이 조회 시 팝업 호출  
        mssEventMstPop('SEL_STR_EVENT_POP',EM_S_EVENT_CD,EM_S_EVENT_NM,LC_S_STR_CD.BindColVal,'4/6');     
    }
//}
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
<object id=DS_I_CONDITION classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_S_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>  
<comment id="_NSID_"><object id="DS_EVENT_TYPE"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>  
<comment id="_NSID_"><object id="DS_O_RESULT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
 
<!-- ===============- Output용 --> 
<comment id="_NSID_"><object id="DS_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_DETAIL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>
    

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
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
	          <th width="60" class="point">점</th>
	          <td width="120" >
	              <comment id="_NSID_">
                      <object id=LC_S_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> height=100 tabindex=1 width=120 align="absmiddle">
                      </object>
                  </comment><script>_ws_(_NSID_);</script>    
	          </td>
	          <th width="60" class="point">기간</th>
              <td width="220"align="absmiddle">
                  <comment id="_NSID_">
                          <object id=EM_S_DT classid=<%= Util.CLSID_EMEDIT %> onblur="javascript:checkDateTypeYMD(this);" width=80 tabindex=1 align="absmiddle">
                          </object>
                  </comment><script>_ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_S_DT)" /> 
                  ~
                  <comment id="_NSID_">
                          <object id=EM_E_DT classid=<%= Util.CLSID_EMEDIT %> onblur="javascript:checkDateTypeYMD(this);" width=80 tabindex=1 align="absmiddle">
                          </object>
                  </comment><script>_ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_E_DT)" />      
              </td>
	          <th width="60">행사코드</th>    
             <td><comment id="_NSID_"> <object
                 id=EM_S_EVENT_CD classid=<%=Util.CLSID_EMEDIT%> width=80
                 tabindex=1 align="absmiddle" tabindex=1> </object> </comment><script> _ws_(_NSID_);</script>
             <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
                 onclick="javascript:getSEvent();" align="absmiddle" /> <comment
                 id="_NSID_"> <object id=EM_S_EVENT_NM
                 classid=<%=Util.CLSID_EMEDIT%> width=110 tabindex=1
                 align="absmiddle" tabindex=1> </object> </comment><script> _ws_(_NSID_);</script>
             </td> 
	      </tr>
	      <tr>
	          
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="dot"></td>
  </tr>
  <tr valign="top">
   <td width="100%"  class="PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0">          
     <tr>             
       <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
         <tr>
           <td>
                <comment id="_NSID_"><OBJECT id=GD_MASTER width=100% height=390 classid=<%=Util.CLSID_GRID%>>
               <param name="DataID" value="DS_MASTER">
               <Param Name="ViewSummary"   value="1" >
               </OBJECT></comment><script>_ws_(_NSID_);</script>
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
   <td width="100%" ><table width="100%" border="0" cellspacing="0" cellpadding="0">          
     <tr>
       <td ><table width="100%" border="0" cellspacing="0" cellpadding="0">
 
         <tr>           
           <td ><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
             <tr>
               <td>
                   <comment id="_NSID_"><OBJECT id=GD_DETAIL width=100% height=390 classid=<%=Util.CLSID_GRID%>>
                   <param name="DataID" value="DS_DETAIL">
                   <Param Name="ViewSummary"   value="1" >
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
</body>
</html>

