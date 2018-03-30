<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 상품권관리 > 상품권 입/출고 > 점내 불출 내역 조회
 * 작 성 일 : 2011.03.14
 * 작 성 자 : 신익수
 * 수 정 자 : 
 * 파 일 명 : mgif3210.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 점내 불출내역을 조회 한다.
 * 이    력 : 2011.03.14 (신익수) 신규개발
 *         
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
<script language="javascript"  src="/<%=dir%>/js/common.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js"  type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript"><!--
//디테일 조회 두번 막기 위해 
var old_Row = 0;

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
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    // Output Data Set Header 초기화
    //그리드 초기화
    gridCreate(); //마스터
    
    // EMedit에 초기화
    initEmEdit(OUT_DATE_FROM, "SYYYYMMDD", PK);   //불출기간 FROM
    initEmEdit(OUT_DATE_TO, "TODAY", PK);         //불출기간 TO 
    
  
    //콤보 초기화
    //initComboStyle(LC_STR_CD,DS_O_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);  //점
    initComboStyle(LC_POUT_TYPE,DS_O_POUT_TYPE, "CODE^0^30,NAME^0^180", 1, NORMAL);  //불출유형   
    //initComboStyle(LC_POUT_FLAG,DS_O_POUT_FLAG, "CODE^0^30,NAME^0^180", 1, NORMAL);  //불출유형   
    //initEmEdit(EM_O_EVENT_CD,   "GEN^11", NORMAL);         //행사코드(조회)
    //initEmEdit(EM_O_EVENT_NAME, "GEN^40", READ);           //행사명(조회)
    
    
    getStore("DS_O_STR_CD", "Y", "", "N");
    getEtcCode("DS_O_POUT_TYPE","D", "M014", "Y","N",LC_POUT_TYPE);
    //getEtcCode("DS_O_POUT_FLAG","D", "M007", "Y","N",LC_POUT_FLAG);
    DS_O_STR_CD.Filter();     // 점 : 본사점 제외 셋팅
    //LC_STR_CD.index = 0;
    
    //LC_STR_CD.Focus();
}

function gridCreate(){
	 var hdrProperies =  '<FC>id=POUT_TYPE         name="불출코드"       width=30  SHOW=FALSE  </FC>'
				         + '<FC>id=POUT_TYPE_NM       name="불출유형"          width=200  align=left suppress=1</FC>'
				         + '<FC>id=GIFT_AMT_NAME       name="권종"         	 width=100  align=left sumtext="합계"</FC>'
				         + '<FC>id=GIFTCERT_QTY         name="불출수량"     	 width=100   align=RIGHT mask="#,###"	sumtext=@sum </FC>'
				         + '<FC>id=GIFTCERT_SUM         name="불출금액"     		width=150   align=RIGHT	mask="#,###" sumtext=@sum </FC>'
				         + '<FC>id=GIFTDRAWL_QTY         name="회수수량"   	   width=100   align=RIGHT mask="#,###"	sumtext=@sum </FC>'
				         + '<FC>id=GIFTDRAWL_SUM         name="회수금액"     		width=150   align=RIGHT	mask="#,###" sumtext=@sum </FC>'
				         + '<FC>id=GIFTDRAWL_RATE         name="회수율"     		width=100   align=RIGHT	mask="###.##" sumtext=@sum </FC>'
				         ;
	initGridStyle(GD_MASTER, "common", hdrProperies, false);
	
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
		
     // 조회조건 셋팅
     
     var strReqYmdFrom   = OUT_DATE_FROM.Text;     //입고일자 FROM
     var strReqYmdTo     = OUT_DATE_TO.Text;       //입고일자 TO
     var strPoutType     =  LC_POUT_TYPE.BindColVal;   //불출유형        
     
     
     if(strReqYmdFrom > strReqYmdTo) {
         showMessage(INFORMATION, OK, "USER-1015");
         OUT_DATE_FROM.Focus();
         return;
     }
     
     //데이타 셋 클리어
     DS_O_MASTER.ClearData();
     
     
     var goTo       = "getPoutrReqMst" ;    
     var action     = "O";     
     var parameters = "&strReqYmdFrom="+ encodeURIComponent(strReqYmdFrom)
                    + "&strReqYmdTo="  + encodeURIComponent(strReqYmdTo)
                    + "&strPoutType="  + encodeURIComponent(strPoutType) 
                    ;
    
     TR_MAIN.Action="/mss/mgif321.mg?goTo="+goTo+parameters;  
     TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
     TR_MAIN.Post();
     
     old_Row = 1;
  
     // 조회결과 Return
     setPorcCount("SELECT", GD_MASTER);
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
	 
    if(DS_O_MASTER.CountRow <= 0){
        showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
          return;
      }

    
    var strReqYmdFrom   = OUT_DATE_FROM.Text;     //입고일자 FROM
    var strReqYmdTo     = OUT_DATE_TO.Text;       //입고일자 TO
    var strPoutType     =  LC_POUT_TYPE.Text;   //불출유형        
   // var strPoutFlag     = LC_POUT_FLAG.Text;    //불출구분
    //var strVenCd    = EM_O_EVENT_CD.Text;         //행사코드
    
    var parameters = "기간 = "+strReqYmdFrom
		+ " ~ "+strReqYmdTo
    	+ " , 불출유형= "+strPoutType;

	var ExcelTitle = "상품권 회수율 조회"
	
	openExcel2(GD_MASTER, ExcelTitle, parameters, true );
	
	//var ExcelTitle = "점내불출내역조회"

	//openExcel2(GD_DETAIL, ExcelTitle, parameters, true );
}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
	     
		var strStrCd = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "STR_CD");
	    var strConfDt = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "CONF_DT");
	    var strConfSlipNo = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "CONF_SLIP_NO");
	    
	    //alert("strStrCd===="+strStrCd);
	    //alert("strConfDt===="+strConfDt);
	    //alert("strConfSlipNo===="+strConfSlipNo);
	    
	    var parameters = "&strStrCd="+strStrCd
		            + "&strConfDt="+strConfDt
		            + "&strConfSlipNo="+strConfSlipNo;
		    
		 window.open("/mss/mgif321.mg?goTo=print"+parameters, "OZREPORT", 1000, 700);         
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
<script language=JavaScript for=TR_MAIN1 event=onSuccess>
    for(i=0;i<TR_MAIN1.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
  /*  showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }*/
    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_MAIN1 event=onFail>
   /* showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN1.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN1.ErrorMsg);
    for(i=1;i<TR_MAIN1.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN1.SrvErrMsg('GAUCE',i));
    }*/
    trFailed(TR_MAIN1.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_STR_CD event=OnFilter(row)>
if (DS_O_STR_CD.NameValue(row, "GBN") != "0") {// 본사점 제외
    return true;
}
return false;
</script>


 
  
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               *-->
<!--*************************************************************************-->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    //그리드 정렬기능
    if( row < 1) {
        sortColId( eval(this.DataID), row , colid );
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
<comment id="_NSID_"><object id="DS_O_STR_CD"          classid=<%=Util.CLSID_DATASET%>>
<param name=UseFilter   value=true>
</object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_POUT_TYPE"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_POUT_FLAG"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_O_ORG_NM"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- 공통함수용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"            classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"            classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_MAIN1" classid=<%=Util.CLSID_TRANSACTION%>>
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
             <th width="80" class="POINT">불출기간</th>
             <td width="210">
                <comment id="_NSID_">
                    <object id=OUT_DATE_FROM classid=<%=Util.CLSID_EMEDIT%> width="70" onblur="javascript:checkDateTypeYMD(this);" align="absmiddle"> 
                    </object>
                 </comment><script>_ws_(_NSID_);</script>
                 <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',OUT_DATE_FROM)" /> ~ 
                 <comment id="_NSID_">
                    <object id=OUT_DATE_TO classid=<%=Util.CLSID_EMEDIT%> onblur="javascript:checkDateTypeYMD(this);" width="70" align="absmiddle">
                    </object>
                 </comment><script>_ws_(_NSID_);</script>
                 <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',OUT_DATE_TO)" align="absmiddle" />
             </td>
         <th width="80">불출유형</th>
         <td >
             <comment id="_NSID_">
                   <object id=LC_POUT_TYPE classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=140 align="absmiddle">
                   </object>
             </comment><script>_ws_(_NSID_);</script> 
         </td> 
         
         </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <!--  그리드의 구분dot & 여백  -->
  <tr><td class="dot"></td></tr>
  <!--  그리드의 구분dot & 여백  -->

  <tr>
    <td class="PT01 PB03">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
      <tr>
      <td>
          <comment id="_NSID_"><OBJECT id=GD_MASTER width=100% height=500 classid=<%=Util.CLSID_GRID%>>
              <param name="DataID" value="DS_O_MASTER">
               <Param Name="ViewSummary"   value="1" >
          </OBJECT></comment><script>_ws_(_NSID_);</script>
      </td>  
       </tr>
      </table> 
    </td>
    </tr>

</table>
</DIV>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>

