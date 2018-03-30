<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 상품권관리 > 상품권 폐기 > 상품권 폐기내역 조회
 * 작 성 일 : 2011.03.18
 * 작 성 자 : 신익수
 * 수 정 자 : 
 * 파 일 명 : mgif3140.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 상품권 폐기 내역을 조회 합니다..
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
    initEmEdit(EM_S_YYYYMM, "THISMN", PK);          //조회월
    initEmEdit(EM_S_CARD_NO, "NUMBER2^16^0", PK);       //카드번호
    EM_S_CARD_NO.Format = "0000-0000-0000-0000";
   
    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_O_STR_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);  //점
    
    getStore("DS_O_STR_CD", "Y", "", "Y");
    
    LC_STR_CD.index = 0;
    
    EM_S_CARD_NO.Focus();
}

function gridCreate(){
	 var hdrProperies =   '<FC>id={currow}         name="NO"          width=25   align=center</FC>'
				         + '<FC>id=STR_CD            name="점코드"      SHOW=FALSE  </FC>'
				         + '<FC>id=STR_NM             name="점"          width=120  align=left sumtext="합계"</FC>'
				         + '<FC>id=SALE_DT              name="판매일자"     width=100   align=center mask="XXXX/XX/XX"</FC>'
				         + '<FC>id=POS_NO         name="POS_NO"      width=80   align=light </FC>'
				         + '<FC>id=TRAN_NO          name="TRAN_NO"     width=80   align=light </FC>'
				         + '<FC>id=SALE_ETC_AMT             name="판매금액"       width=110  align=right sumtext=@sum  </FC>'
				         + '<FC>id=CARD_DATA             name="카드번호"       width=170  align=center  </FC>'
				         + '<FC>id=CCOMP_NM             name="카드사명"       width=80  align=left  </FC>'
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
     var strStrCd           = LC_STR_CD.BindColVal;         //점코드
     var strSYYYYMM         = EM_S_YYYYMM.Text;             //조회월
     var strCardNo          = EM_S_CARD_NO.Text;            //조회카드번호
     
     if(EM_S_YYYYMM.Text == '') {
         showMessage(INFORMATION, OK, "USER-1003","조회월");
         EM_S_YYYYMM.Focus();
         return;
     }
     
     /*
     if(EM_S_CARD_NO.Text == '') {
         showMessage(INFORMATION, OK, "USER-1003","카드번호");
         EM_S_CARD_NO.Focus();
         return;
     }
     */
     /*
     if(strCardNo.length < '15') {
         showMessage(INFORMATION, OK, "USER-1000","카드번호를 확인해 주세요.");
         EM_S_CARD_NO.Focus();
         return;
     }
     */
     
     //데이타 셋 클리어
     DS_O_MASTER.ClearData();
     
     var goTo       = "getMaster" ;    
     var action     = "O";     
     var parameters = "&strStrCd="  + encodeURIComponent(strStrCd)
                    + "&strSYYYYMM="+ encodeURIComponent(strSYYYYMM)
                    + "&strCardNo=" + encodeURIComponent(strCardNo) 
                    ;
     
     TR_MAIN.Action="/mss/mgif314.mg?goTo="+goTo+parameters;  
     TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
     TR_MAIN.Post();
     
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

    var strStrCd           = LC_STR_CD.Text;         //점코드
    var strSYYYYMM         = EM_S_YYYYMM.Text;             //조회월
    var strCardNo          = EM_S_CARD_NO.Text;            //조회카드번호
    
    var parameters = " 점= "+strStrCd
    	+ " , 월= "+strSYYYYMM
		+ " , 카드번호= "+strCardNo;

	var ExcelTitle = "상품권개인카드매출조회"
	
	openExcel2(GD_MASTER, ExcelTitle, parameters, true );
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
    /*showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN1.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN1.ErrorMsg);
    for(i=1;i<TR_MAIN1.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN1.SrvErrMsg('GAUCE',i));
    }*/
    trFailed(TR_MAIN1.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>

</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

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
<comment id="_NSID_"><object id="DS_O_STR_CD"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

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
             <th width="80" >점</th>
             <td width="120">
               <comment id="_NSID_">
                 <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=120 align="absmiddle"></object>
               </comment>
               <script>_ws_(_NSID_);</script> 
             </td>
             <th width="80" class="POINT">조회월</th>
             <td width="100">
                <comment id="_NSID_">
                    <object id=EM_S_YYYYMM classid=<%=Util.CLSID_EMEDIT%> width="70" onblur="javascript:checkDateTypeYM(this);" align="absmiddle"> 
                    </object>
                 </comment><script>_ws_(_NSID_);</script>
                 <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('M',EM_S_YYYYMM)" /> 
             </td>
             <th width="80" class="POINT">카드번호</th>
             <td >
                <comment id="_NSID_">
                    <object id=EM_S_CARD_NO classid=<%=Util.CLSID_EMEDIT%> width="140" align="absmiddle"> 
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

