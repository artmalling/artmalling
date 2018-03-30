<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 상품권 재고관리> 점별 재고조회
 * 작 성 일 : 2011.01.18
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : mgif4140.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 : 2011.01.18 (김성미) 신규작성
 *         2011.04.18 (김정민) 수정개발
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>
<%
    request.setCharacterEncoding("utf-8");
%>


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

<script LANGUAGE="JavaScript"><!--


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
	    gridCreate1(); //마스터
	    
	    // EMedit에 초기화
        initEmEdit(EM_STK_S_DT, "SYYYYMMDD", READ);    //일자(조회)
        initEmEdit(EM_STK_E_DT, "YYYYMMDD", PK);    //일자(조회) 
        
        EM_STK_S_DT.Text    = ("20120701");
        EM_STK_E_DT.Text    = getTodayFormat("YYYYMMDD");   // 일자(조회)
	
	    //콤보 초기화
	    initComboStyle(LC_STR_CD,DS_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);                  //본사점(조회)
	    initComboStyle(LC_GIFT_TYPE_CD,DS_GIFT_TYPE_CD, "CODE^0^40,NAME^0^100", 1, PK);      //상품권종류(조회)
	    initComboStyle(LC_GIFT_AMT_TYPE,DS_GIFT_AMT_TYPE, "CODE^0^40,NAME^0^100", 1, NORMAL);    //금종(조회)
	    
	    // 공통에서 가져오기
	    getStore("DS_STR_CD", "Y", "1", "N");   //점(조회)
	    
	    getEtcCodeSub_Type();               // 상품권종류 
	    getEtcCodeSub_Amt();                // 금종  
	    
	    LC_STR_CD.Index = 0;                //점(조회)    
	    LC_GIFT_TYPE_CD.Index = 0;          //상품권종류
	    LC_GIFT_AMT_TYPE.Index = 0;         //금종  
	    
	    LC_STR_CD.Focus();
	}  
	  
function gridCreate1(){ 
	var hdrProperies = '<COLUMNINFO>' 
        + '       <COLUMN id="GIFT_AMT_NAME" refcolid="GIFT_AMT_NAME" >'
        + '           <HEADER left="0" top="0" right="60" bottom="60" text="금종" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="0" top="0" right="60" bottom="40" edit=""  borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEWSUMMARY text="합계"  bgcolor="#b9d9ea" align="CenterCenter" />' 
        + '       </COLUMN>' 
        + '       <COLUMN id="PREV"  refcolid="">'
        + '           <HEADER left="60" top="0" right="160" bottom="20" text="불출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '       </COLUMN>'
        + '       <COLUMN id="POUT_QTY"  refcolid="POUT_QTY">'
        + '           <HEADER left="60" top="20" right="160" bottom="40" text="데스크불출수량" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="60" top="0" right="160" bottom="20" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(POUT_QTY)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>' 
        + '       <COLUMN id="POUT_AMT"  refcolid="POUT_AMT">'
        + '           <HEADER left="60" top="40" right="160" bottom="60" text="데스크불출금액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="60" top="20" right="160" bottom="40" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  bgcolor="#EDF4F8" displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(POUT_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>' 
        + '       <COLUMN id="PREV_2"  refcolid="">'
        + '           <HEADER left="160" top="0" right="370" bottom="20" text="판매" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '       </COLUMN>'
        + '       <COLUMN id="SALE_QTY"  refcolid="SALE_QTY">'
        + '           <HEADER left="160" top="20" right="270" bottom="40" text="판매+반품수량" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="160" top="0" right="270" bottom="20" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(SALE_QTY)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>' 
        + '       <COLUMN id="SALE_AMT"  refcolid="SALE_AMT">'
        + '           <HEADER left="160" top="40" right="270" bottom="60" text="판매+반품금액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="160" top="20" right="270" bottom="40" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  bgcolor="#EDF4F8"  displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(SALE_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>' 
        + '       <COLUMN id="EXCH_SALE_QTY"  refcolid="EXCH_SALE_QTY">'
        + '           <HEADER  left="270" top="20" right="370" bottom="40" text="교환판매수량" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="270" top="0" right="370" bottom="20" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(EXCH_SALE_QTY)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>' 
        + '       <COLUMN id="EXCH_SALE_AMT"  refcolid="EXCH_SALE_AMT">'
        + '           <HEADER  left="270" top="40" right="370" bottom="60" text="교환판매금액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="270" top="20" right="370" bottom="40" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  bgcolor="#EDF4F8" displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(EXCH_SALE_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>' 
        + '       <COLUMN id="PREV_3"  refcolid="">'
        + '           <HEADER left="370" top="0" right="480" bottom="20" text="현재고" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '       </COLUMN>'
        + '       <COLUMN id="SUM_DESK_Q"  refcolid="SUM_DESK_Q">'
        + '           <HEADER left="370" top="20" right="480" bottom="40" text="고객센터재고수량" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="370" top="0" right="480" bottom="20" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(SUM_DESK_Q)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>' 
        + '       <COLUMN id="SUM_DESK_A"  refcolid="SUM_DESK_A">'
        + '           <HEADER left="370" top="40" right="480" bottom="60" text="고객센터재고금액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="370" top="20" right="480" bottom="40" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  bgcolor="#EDF4F8"  displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(SUM_DESK_A)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>'  
        + '     </COLUMNINFO>';
    initMGridStyle(GD_MASTER, "common", hdrProperies);
    DS_O_MASTER.UseChangeInfo = false; 
    GD_MASTER.ViewSummary = "1";
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
	    var strCD       = LC_STR_CD.BindColVal;                     //본사점
	    var strDtFrom   = EM_STK_S_DT.Text;     //일자 FROM 
	    var strDtTo     = EM_STK_E_DT.Text;                           //일자 TO
	    var strGiftType = LC_GIFT_TYPE_CD.BindColVal;               //상품권종류
	    var strGiftAmt  = LC_GIFT_AMT_TYPE.BindColVal;              //금종
	//alert(strSaleSlip);
	    var goTo       = "getMaster";
	    var action     = "O";
	    var parameters = "&strCD="          + encodeURIComponent(strCD)
	                   + "&strDtFrom="      + encodeURIComponent(strDtFrom)
	                   + "&strDtTo="        + encodeURIComponent(strDtTo)
	                   + "&strGiftType="    + encodeURIComponent(strGiftType)
	                   + "&strGiftAmt="     + encodeURIComponent(strGiftAmt);	    
	    TR_MAIN.Action   = "/mss/mgif414.mg?goTo=" + goTo + parameters;
	    TR_MAIN.KeyValue = "SERVLET(" + action + ":DS_O_MASTER=DS_O_MASTER)";
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
    var parameters = "";
	var ExcelTitle = "상품권재고조회(재무)";
	
	openExcelM(GD_MASTER, ExcelTitle, parameters, true );
    
}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
	 
	 var strCD       = LC_STR_CD.BindColVal;                     //본사점
	 var strDtFrom   = EM_STK_S_DT.Text;     //일자 FROM 
	 var strDtTo     = EM_STK_E_DT.Text;                           //일자 TO
	 var strGiftType = LC_GIFT_TYPE_CD.BindColVal;               //상품권종류
	 var strGiftAmt  = LC_GIFT_AMT_TYPE.BindColVal;              //금종
	 
	 var parameters = "&STR_CD="          + strCD
     + "&STK_S_DT="      + strDtFrom
     + "&STK_E_DT="        + strDtTo
     + "&GIFT_TYPE_CD="    + strGiftType
     + "&GIFT_AMT_TYPE="     + strGiftAmt;
	 
	window.open("/mss/jsp/mgif/mgif4141.jsp?"+parameters,"OZPRINT", 1000, 700);	 
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
  * getEtcCodeSub_Type()
  * 작 성 자 : 김정민
  * 작 성 일 : 2011-04-14
  * 개    요 : 상품권종류 
  * return값 : void
  */
function getEtcCodeSub_Type() {
    var goTo = "getEtcCodeSub_Type"; 
      
    TR_MAIN.Action = "/mss/mgif414.mg?goTo=" + goTo; 
    TR_MAIN.KeyValue = "SERVLET(O:DS_GIFT_TYPE_CD=DS_GIFT_TYPE_CD)";
    TR_MAIN.StatusResetType= "2";
    TR_MAIN.Post();
}

/**
 * getEtcCodeSub_Amt()
 * 작 성 자 : 김정민
 * 작 성 일 : 2011-04-14
 * 개    요 : 금종 
 * return값 : void
 */
function getEtcCodeSub_Amt() {
    
    var strGiftTypeCd = LC_GIFT_TYPE_CD.BindColVal;
     
    var goTo = "getEtcCodeSub_Amt"; 
    var parameters = "&strGiftTypeCd="   + encodeURIComponent(strGiftTypeCd); 
  //  alert(strGiftTypeCd);
 
    TR_MAIN.Action = "/mss/mgif414.mg?goTo=" + goTo + parameters; 
    TR_MAIN.KeyValue = "SERVLET(O:DS_GIFT_AMT_TYPE=DS_GIFT_AMT_TYPE)";
    TR_MAIN.StatusResetType= "2";
    TR_MAIN.Post();
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
    trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!-- MASTER 정렬 -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    //정렬
    if (row == 0){
        sortColId(eval(this.DataID), row, colid);
    }
</script>

<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>
    if(clickSORT)return;
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 상품권종류 OnSelChange() -->
<script language=JavaScript for=LC_GIFT_TYPE_CD event=OnSelChange()>
    getEtcCodeSub_Amt();
    LC_GIFT_AMT_TYPE.Index = 0;         //금종  
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
<comment id="_NSID_"><object id="DS_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_GIFT_TYPE_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_GIFT_AMT_TYPE"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
 
<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ================ 공통 --> 
<comment id="_NSID_"><object id="DS_I_CONDITION"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
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
            <td width="150"><comment id="_NSID_"> 
                 <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> height=100
							width=150 align="absmiddle"></object></comment> <script>_ws_(_NSID_);</script>
            </td>
            <th width="80" class="point">일자</th>
            <td>
                <comment id="_NSID_"> 
                  <object id=EM_STK_S_DT classid=<%=Util.CLSID_EMEDIT%>   width=120 tabindex=1 align="absmiddle" onblur="javascript:checkDateTypeYMD(this);">
                  </object></comment><script>_ws_(_NSID_);</script>
                    <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_STK_S_DT)" align="absmiddle" />
                 ~  <comment id="_NSID_">
                 <object id=EM_STK_E_DT classid=<%=Util.CLSID_EMEDIT%>   width=120 tabindex=1 align="absmiddle" onblur="javascript:checkDateTypeYMD(this);">
                  </object></comment><script>_ws_(_NSID_);</script>
                    <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_STK_E_DT)" align="absmiddle" />
            </td> 
          </tr> 
          <tr>
            <th width="80" class="point">상품권종류</th>
            <td  width="150">
                 <comment id="_NSID_">
               <object id=LC_GIFT_TYPE_CD classid=<%= Util.CLSID_LUXECOMBO %> height=100 tabindex=1 width=140 align="absmiddle">
               </object>
               </comment><script>_ws_(_NSID_);</script>
              </td>
            <th width="80">금종</th>
            <td>
                 <comment id="_NSID_">
               <object id=LC_GIFT_AMT_TYPE classid=<%= Util.CLSID_LUXECOMBO %> height=100 tabindex=1 width=140 align="absmiddle">
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
        <comment id="_NSID_"> <object
           id=GD_MASTER width=100% height=477 classid=<%=Util.CLSID_MGRID%> tabindex=1>
           <param name="DataID" value="DS_O_MASTER">
           <Param Name="IndicatorInfo"       value='
             <INDICATORINFO width="20" fontsize="9" indexnumber="true"/>'>
           <Param Name="sort"      value="false">
        </object> </comment><script>_ws_(_NSID_);</script> 
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

