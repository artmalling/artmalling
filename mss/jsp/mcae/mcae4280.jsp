<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 사은행사관리 > 사은품 지급/취소 > POS별 지급취소내역 조회
 * 작 성 일 : 2011.05.18
 * 작 성 자 : 김정민
 * 수 정 자 : 
 * 파 일 명 : MCAE4280.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : POS별 지급취소 내역을 조회한다.
 * 이    력 : 2011.05.18 (김정민) 신규개발 
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
<!--
var g_select = false;
var top = 150;
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
	 
	//Master 그리드 세로크기자동조정  2013-07-17
		var obj   = document.getElementById("GD_MASTER"); 
		obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    // Input Data Set Header 초기화
    DS_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');

    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate1(); //마스터    
    //gridCreate2();
    
    // EMedit에 초기화
    initEmEdit(EM_POS_CD, "NUMBER3^4", NORMAL);        //POS코드
    initEmEdit(EM_POS_NM, "GEN", READ);           //POS명
    initEmEdit(EM_S_DT, "SYYYYMMDD", PK);         //영수증일자S
    initEmEdit(EM_E_DT, "TODAY", PK);         //영수증일자E 

    //콤보 초기화
    initComboStyle(LC_S_STR,DS_O_STR, "CODE^0^30,NAME^0^80", 1, PK);      //점(조회) 
    initComboStyle(LC_S_FLOR,DS_O_FLOR_CD, "CODE^0^30,NAME^0^70", 1, NORMAL);  //층 
    getEtcCode("DS_O_FLOR_CD", "D", "P061", "Y", "N", LC_S_FLOR);
    getEtcCode("DS_O_FLOR_CD_GD", "D", "P061", "N", "N", LC_S_FLOR);
    
    getStore("DS_O_STR", "Y", "1", "N");
    LC_S_STR.Index = 0;
    LC_S_STR.Focus();
} 

function gridCreate1(){
    var hdrProperies ='<FC>id={currow}  name="NO"          width=30    align=center</FC>'
			        + '<FC>id=STR_CD    name="점"           width=90   align=left Show=false  </FC>'
                    + '<FC>id=STR_NM    name="점"           width=90   align=left </FC>'
			        + '<FC>id=FLOR_CD   name="층"           width=80   align=left  EDITSTYLE=LOOKUP   DATA="DS_O_FLOR_CD_GD:CODE:NAME" </FC>'
                    + '<FC>id=POS_NO    name="POS번호"      width=100  align=center  sumtext="합계" </FC>' 
                    + '<FC>id=JGCANCLE  name="반납;거래건수"   		gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=95   align=right sumtext=@sum </FC>'
                    + '<FC>id=ALLCANDRAW  name="전체회수;거래건수"  gte_columntype="number:0:true" gte_Summarytype="number:0:true"	 width=95   align=right sumtext=@sum </FC>'
                    + '<FC>id=ACANDRAW  name="미회수;거래건수"   	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=95   align=right sumtext=@sum </FC>'
                    + '<FC>id=PCANDRAW  name="부분회수;거래건수"    gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=95   align=right sumtext=@sum </FC>'
                    + '<FC>id=DRAWAQTY  name="회수건수;(상품권수+현금)"   gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=95   align=right sumtext=@sum </FC>'
                    + '<FG>id=STR_NAME  name="회수 수량"      align=center >' 
                    + '<FC>id=DRAWMQTY  name="상품권수량"        	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=100   align=right  sumtext=@sum </FC>'
                    + '<FC>id=DRAWMAMT  name="상품권금액"           gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=100   align=right  sumtext=@sum </FC>'
                    + '</FG>' 
                    + '<FC>id=DRAWCAMT   name="회수현금;금액"   	gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=100  align=right  sumtext=@sum </FC>'
                    + '<FC>id=PAY_AMT   name="회수 총 금액"   		gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=100  align=right  sumtext=@sum </FC>'
                    ;
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
} 
/*function gridCreate2(){
    var hdrProperies2 ='<FC>id={currow}     name="NO"          width=30   align=center</FC>'
			        + '<FC>id=POS_NO        name="POS번호"      width=80  align=center</FC>'
			        + '<FC>id=SALE_DT       name="지급취소일자"   mask="XXXX/XX/XX"   width=90   align=center</FC>'
			        + '<FC>id=SKU_NAME      name="지급사은품"    width=120  align=left  sumtext="합계" </FC>'
			        + '<FC>id=SRAWLFLAG     name="회수구분"      width=100  align=left</FC>'
                    + '<FC>id=BUY_COST_PRC  name="매입원가"      width=90   align=right  sumtext=@sum </FC>'
                    + '<FC>id=QTY           name="회수수량"      width=90   align=right  sumtext=@sum </FC>'
                    + '<FC>id=TOT_AMT           name="회수금액"      width=90   align=right  sumtext=@sum </FC>'
                    + '<FC>id=AMT           name="대납 회수금액"  width=110  align=right  sumtext=@sum </FC>'
                    ;
                     
    initGridStyle(GD_DETAIL, "common", hdrProperies2, false);
}*/

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
	if(LC_S_STR.BindColVal.length == 0){  // 점코드
        showMessage(EXCLAMATION , OK, "USER-1001", "점");
        LC_S_STR.focus();
        return;
    }
    if(EM_S_DT.Text.length == 0){   // 조회시작일
        showMessage(EXCLAMATION , OK, "USER-1001","조회기간");
        EM_S_DT.focus();
        return;
    }else if(EM_E_DT.Text.length == 0){    // 조회 종료일
        showMessage(EXCLAMATION , OK, "USER-1001","조회기간");
        EM_E_DT.focus();
        return;
    }else if(EM_S_DT.Text > EM_E_DT.Text){ // 조회일 정합성
        showMessage(EXCLAMATION , OK, "USER-1015");
        EM_S_DT.focus();
        return;
    }

    DS_MASTER.ClearData();
   // DS_DETAIL.ClearData();
    
    // 조회조건 셋팅
    var strStrCd        = LC_S_STR.BindColVal;
    var strSdt          = EM_S_DT.Text;
    var strEdt          = EM_E_DT.Text;
    var strFlorCd       = LC_S_FLOR.BindColVal;
    var strPosCd        = EM_POS_CD.Text;
    
    var goTo       = "getMaster" ;    
    var parameters = "&strStrCd=" + encodeURIComponent(strStrCd)
                   + "&strSdt="   + encodeURIComponent(strSdt)
                   + "&strEdt="   + encodeURIComponent(strEdt)
                   + "&strFlorCd="+ encodeURIComponent(strFlorCd)
                   + "&strPosCd=" + encodeURIComponent(strPosCd);
    
    TR_MAIN.Action="/mss/mcae428.mc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET(O:DS_MASTER=DS_MASTER)"; //조회는 O
    g_select = true;
    TR_MAIN.Post();
    g_select = false;
    /*if(DS_MASTER.CountRow > 0){
    	getDetail2();
    }*/
    
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
	if(DS_MASTER.CountRow <= 0){
	      showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
	        return;
	    }
	    var strTitle = "POS사은품회수내역(재무)";

	    var strSaleDtS      = EM_S_DT.Text;         //시작일자
	    var strSaleDtE      = EM_E_DT.Text;         //종료일자
	    var strFlorCd       = LC_S_FLOR.BindColVal;   // 층
	    var strPosCd        = EM_POS_CD.Text;         // POS번호
	    
	    var parameters = 
	                   " 행사기간  "  + strSaleDtS
	                   + " ~ " + strSaleDtE
	                   + " ,   층  "      + strFlorCd
	    			   + " ,   POS번호   "      + strPosCd;
	    				
	    
	    GD_MASTER.GridToExcelExtProp("HideColumn") = "{currow}";       // GridToExcel 사용시 숨길 컬럼지정
	    openExcel2(GD_MASTER, strTitle, parameters, true );

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
 /*function getDetail() {
	 if(DS_MASTER.CountRow ==0){  // 회수정보 조회 내역 여부 
	        showMessage(EXCLAMATION , OK, "USER-1001", "점");
	        return;
	    } 
	    var strStrCd        = LC_S_STR.BindColVal;
	    var strSdt          = EM_S_DT.Text;
	    var strEdt          = EM_E_DT.Text;
	    
	    var row = DS_MASTER.RowPosition;
	    var goTo       = "getDetail" ;  
	    var parameters = "&strStrCd="+ encodeURIComponent(strStrCd)
	                   + "&strPosNo="+ encodeURIComponent(DS_MASTER.NameValue(row, "POS_NO"))
	                   + "&strSdt="  + encodeURIComponent(strSdt)
	                   + "&strEdt="  + encodeURIComponent(strEdt);
	    TR_MAIN.Action="/mss/mcae428.mc?goTo="+goTo+parameters;  
	    TR_MAIN.KeyValue="SERVLET(O:DS_DETAIL=DS_DETAIL)"; //조회는 O
	    TR_MAIN.Post();
	     
	    // 조회결과 Return
	    setPorcCount("SELECT", DS_DETAIL.CountRow);
 }*/
 
 /**
  * getDetail2()
  * 작 성 자 : 
  * 작 성 일 : 2011-05-18
  * 개    요 : 합산 영수증 정보 조회
  * return값 : void
  */
 /*function getDetail2() {
     if(DS_MASTER.CountRow ==0){  // 회수정보 조회 내역 여부 
            showMessage(EXCLAMATION , OK, "USER-1001", "점");
            return;
        } 
        var strStrCd        = LC_S_STR.BindColVal;
        var strSdt          = EM_S_DT.Text;
        var strEdt          = EM_E_DT.Text;
        
        var row = DS_MASTER.RowPosition;
        var goTo       = "getDetail" ;  
        var parameters = "&strStrCd=" + encodeURIComponent(strStrCd)
                       + "&strPosNo=" + encodeURIComponent(DS_MASTER.NameValue(row, "POS_NO"))
                       + "&strSdt="   + encodeURIComponent(strSdt) 
                       + "&strEdt="   + encodeURIComponent(strEdt) ;
        TR_MAIN.Action="/mss/mcae428.mc?goTo="+goTo+parameters;  
        TR_MAIN.KeyValue="SERVLET(O:DS_DETAIL=DS_DETAIL)"; //조회는 O
        TR_MAIN.Post(); 
 }*/
 
 /**
  * openPosPop()
  * 작 성 자 : 
  * 작 성 일 : 2011-03-15
  * 개    요 : 포스팝업 오픈
  * return값 : void
  */
 function openPosPop() {
	
	  if(LC_S_FLOR.BindColVal == ""){
		  showMessage(EXCLAMATION , OK, "USER-1001", "층");
		  LC_S_FLOR.Focus();
		  return;
	  }
	  
	  posNoPop(EM_POS_CD,EM_POS_NM,LC_S_STR.BindColVal,LC_S_FLOR.BindColVal);
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
<script language=JavaScript for=DS_MASTER event=CanRowPosChange(row)>
 if(DS_MASTER.IsUpdated){
         if(showMessage(EXCLAMATION , YESNO, "USER-1074") != 1 ){
             return false;
         } 
         return true;
}
return true;
</script>
<!--  <script language=JavaScript for=DS_MASTER event=OnRowPosChanged(row)>
if(clickSORT) return;
 
if (row > 0 && g_select==false) {  
    
    setTimeout("getDetail()",50);
//    GD_DETAIL.SetColumn("RANK");
}  
</script> -->

<script language=JavaScript for=DS_DETAIL event=OnRowPosChanged(row)>
if(clickSORT) return;
 
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>

if(row == 0) sortColId( eval(this.DataID), row , colid );
</script>
<!--  <script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
if(row == 0) sortColId( eval(this.DataID), row , colid );
</script> -->
<!-- 포스 조회 -->
<script language=JavaScript for=EM_POS_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
if(!this.Modified)
    return;
//코드가 존재 하지 않으면 명을 클리어 후 리턴
if( EM_POS_CD.Text ==""){
	EM_POS_NM.Text = "";
       return;
   }

   if(EM_POS_CD.Text != null){
        if(EM_POS_CD.Text.length > 0){
        	if(LC_S_FLOR.BindColVal == ""){
                showMessage(EXCLAMATION , OK, "USER-1001", "층");
                EM_POS_CD.Text = "";
                LC_S_FLOR.Focus();
                return;
            }
        	setPosNoNmWithoutPop("DS_O_RESULT", EM_POS_CD, EM_POS_NM , 1, LC_S_STR.BindColVal, LC_S_FLOR.BindColVal);
        	if(DS_O_RESULT.CountRow == 1){
        		EM_POS_CD.Text = DS_O_RESULT.NameValue(1, "POS_NO");
        		EM_POS_NM.Text = DS_O_RESULT.NameValue(1, "POS_NAME");
        	}
        }
    } 
</script>

<script language=JavaScript for=LC_S_STR event=OnSelChange()>
EM_POS_CD.Text = "";
EM_POS_NM.Text = ""; 
</script>

<script language=JavaScript for=LC_S_FLOR event=OnSelChange()>
EM_POS_CD.Text = "";
EM_POS_NM.Text = ""; 
</script>

<script language=JavaScript for=EM_NDRAWL_RSN event=onKillFocus()>
//checkByteStr(this, 100, 'Y');
</script>

<script language=JavaScript for=EM_REMARK event=onKillFocus()>
//checkByteStr(this, 100, 'Y');
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
<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_MASTER");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
}
</script>

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
<comment id="_NSID_"><object id="DS_O_STR"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>  
<comment id="_NSID_"><object id="DS_O_RESULT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_FLOR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_FLOR_CD_GD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

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
	          <th width="80" class="point">점</th>
	          <td width="140" >
	              <comment id="_NSID_">
                      <object id=LC_S_STR classid=<%= Util.CLSID_LUXECOMBO %> height=100 tabindex=1 width=140 align="absmiddle">
                      </object>
                  </comment><script>_ws_(_NSID_);</script>    
	          </td>
	          <th width="80">층</th>
	          <td width="140"> 
	               <comment id="_NSID_">
                      <object id=LC_S_FLOR classid=<%= Util.CLSID_LUXECOMBO %> height=100 tabindex=1 width=140 align="absmiddle">
                      </object>
                  </comment><script>_ws_(_NSID_);</script>    
	          </td>  
	          <th width="80">POS</th>
	          <td>
	              <comment id="_NSID_">
	                      <object id=EM_POS_CD classid=<%= Util.CLSID_EMEDIT %> width=60 tabindex=1 align="absmiddle">
	                      </object>
	              </comment><script>_ws_(_NSID_);</script>  
	              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" onclick="javascript:openPosPop();"  align="absmiddle"/>
	              <comment id="_NSID_">
                          <object id=EM_POS_NM classid=<%= Util.CLSID_EMEDIT %> width=130 tabindex=1 align="absmiddle">
                          </object>
                  </comment><script>_ws_(_NSID_);</script>  
	          </td>
	      </tr>
	      <tr>
	          <th class="point">기간</th>
              <td colspan="5" align="absmiddle">
                  <comment id="_NSID_">
                          <object id=EM_S_DT classid=<%= Util.CLSID_EMEDIT %> onblur="javascript:checkDateTypeYMD(this);" width=90 tabindex=1 align="absmiddle">
                          </object>
                  </comment><script>_ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_S_DT)" /> 
                  ~
                  <comment id="_NSID_">
                          <object id=EM_E_DT classid=<%= Util.CLSID_EMEDIT %> onblur="javascript:checkDateTypeYMD(this);" width=90 tabindex=1 align="absmiddle">
                          </object>
                  </comment><script>_ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_E_DT)" />      
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
   <td width="100%"  class="PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0">          
     <tr>             
       <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
         <tr>
           <td>
                <comment id="_NSID_"><OBJECT id=GD_MASTER width=100% height=523 classid=<%=Util.CLSID_GRID%>>
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
 <!--<tr valign="top">
   <td width="100%" ><table width="100%" border="0" cellspacing="0" cellpadding="0">          
     <tr>
       <td ><table width="100%" border="0" cellspacing="0" cellpadding="0">
 
         <tr>           
           <td ><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
             <tr>
               <td>
                   <comment id="_NSID_"><OBJECT id=GD_DETAIL width=100% height=244 classid=<%=Util.CLSID_GRID%>>
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
  </tr> -->
</table>
</div> 
</body>
</html>

