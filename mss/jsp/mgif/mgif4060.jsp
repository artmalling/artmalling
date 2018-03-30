<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 상품권 재고관리> 점별 재고조회
 * 작 성 일 : 2011.01.18
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : mgif4060.jsp
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
 var top = 125;		//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID

 function doInit(){

		//Master 그리드 세로크기자동조정  2013-07-17
		 var obj   = document.getElementById("GD_MASTER"); 
		 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

	    // Input Data Set Header 초기화
	    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');

	    // Output Data Set Header 초기화
	    
	    //그리드 초기화
	    gridCreate1(); //마스터
	    
	    // EMedit에 초기화
        initEmEdit(EM_STK_S_DT, "SYYYYMMDD", PK);    //일자(조회)
        initEmEdit(EM_STK_E_DT, "YYYYMMDD", PK);    //일자(조회) 
        
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
        + '           <HEADER fix="true"  left="0" top="0" right="60" bottom="60" text="금종" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="0" top="0" right="60" bottom="40" edit=""  borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEWSUMMARY text="합계"  bgcolor="#b9d9ea" align="CenterCenter" />' 
        + '       </COLUMN>' 
        + '       <COLUMN id="PREV"  refcolid="">'
        + '           <HEADER left="60" top="0" right="270" bottom="20" text="전월이월" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '       </COLUMN>'
        + '       <COLUMN id="PREV_QTY"  refcolid="PREV_QTY">'
        + '           <HEADER fix="true" left="60" top="20" right="160" bottom="40" text="점재고이월수량" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="60" top="0" right="160" bottom="20" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(PREV_QTY)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>' 
        + '       <COLUMN id="PREV_AMT"  refcolid="PREV_AMT">'
        + '           <HEADER  fix="true" left="60" top="40" right="160" bottom="60" text="점재고이월금액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="60" top="20" right="160" bottom="40" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  bgcolor="#EDF4F8" displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(PREV_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>' 
        + '       <COLUMN id="PREV_STBOX_QTY"  refcolid="PREV_STBOX_QTY">'
        + '           <HEADER fix="true" left="160" top="20" right="270" bottom="40" text="금고이월재고수량" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="160" top="0" right="270" bottom="20" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(PREV_STBOX_QTY)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>' 
        + '       <COLUMN id="PREV_STBOX_AMT"  refcolid="PREV_STBOX_AMT">'
        + '           <HEADER  fix="true" left="160" top="40" right="270" bottom="60" text="금고이월재고금액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="160" top="20" right="270" bottom="40" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  bgcolor="#EDF4F8"  displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(PREV_STBOX_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>'  
        + '       <COLUMN id="PREV"  refcolid="">'
        + '           <HEADER left="270" top="0" right="480" bottom="20" text="입고" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '       </COLUMN>'
        + '       <COLUMN id="IN_QTY"  refcolid="IN_QTY">'
        + '           <HEADER  left="270" top="20" right="370" bottom="40" text="발행입고수량" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="270" top="0" right="370" bottom="20" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(IN_QTY)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>' 
        + '       <COLUMN id="IN_AMT"  refcolid="IN_AMT">'
        + '           <HEADER  left="270" top="40" right="370" bottom="60" text="발행입고금액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="270" top="20" right="370" bottom="40" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  bgcolor="#EDF4F8" displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(IN_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>' 
        + '       <COLUMN id="REUSE_IN_QTY"  refcolid="REUSE_IN_QTY">'
        + '           <HEADER left="370" top="20" right="480" bottom="40" text="재사용입고수량" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="370" top="0" right="480" bottom="20" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(REUSE_IN_QTY)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>' 
        + '       <COLUMN id="REUSE_IN_AMT"  refcolid="REUSE_IN_AMT">'
        + '           <HEADER left="370" top="40" right="480" bottom="60" text="재사용입고금액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="370" top="20" right="480" bottom="40" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  bgcolor="#EDF4F8"  displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(REUSE_IN_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>'  
        + '       <COLUMN id="OUT"  refcolid="">'
        + '           <HEADER left="480" top="0" right="1490" bottom="20" text="출고" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '       </COLUMN>'
        + '       <COLUMN id="RFD_OUT_QTY"  refcolid="RFD_OUT_QTY">'
        + '           <HEADER  left="480" top="20" right="580" bottom="40" text="반품출고수량" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="480" top="0" right="580" bottom="20" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(RFD_OUT_QTY)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>' 
        + '       <COLUMN id="RFD_OUT_AMT"  refcolid="RFD_OUT_AMT">'
        + '           <HEADER   left="480" top="40" right="580" bottom="60" text="반품출고금액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="480" top="20" right="580" bottom="40" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  bgcolor="#EDF4F8"  displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(RFD_OUT_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>' 
        + '       <COLUMN id="SALE_QTY"  refcolid="SALE_QTY">'
        + '           <HEADER  left="580" top="20" right="680" bottom="40" text="판매수량" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="580" top="0" right="680" bottom="20" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(SALE_QTY)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>' 
        + '       <COLUMN id="SALE_AMT"  refcolid="SALE_AMT">'
        + '           <HEADER  left="580" top="40" right="680" bottom="60" text="판매금액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="580" top="20" right="680" bottom="40" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  bgcolor="#EDF4F8"  displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(SALE_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>'     
        + '       <COLUMN id="EXCH_SALE_QTY"  refcolid="EXCH_SALE_QTY">'
        + '           <HEADER  left="680" top="20" right="780" bottom="40" text="교환판매수량" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="680" top="0" right="780" bottom="20" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(EXCH_SALE_QTY)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>' 
        + '       <COLUMN id="EXCH_SALE_AMT"  refcolid="EXCH_SALE_AMT">'
        + '           <HEADER  left="680" top="40" right="780" bottom="60" text="교환판매금액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="680" top="20" right="780" bottom="40" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  bgcolor="#EDF4F8"  displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(EXCH_SALE_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>'    
        + '       <COLUMN id="POS_PREP_QTY"  refcolid="POS_PREP_QTY">'
        + '           <HEADER  left="780" top="20" right="880" bottom="40" text="POS준비금수량" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="780" top="0" right="880" bottom="20" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(POS_PREP_QTY)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>' 
        + '       <COLUMN id="POS_PREP_AMT"  refcolid="POS_PREP_AMT">'
        + '           <HEADER  left="780" top="40" right="880" bottom="60" text="POS준비금금액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="780" top="20" right="880" bottom="40" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  bgcolor="#EDF4F8"  displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(POS_PREP_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>'    
        + '       <COLUMN id="EVENT_QTY"  refcolid="EVENT_QTY">'
        + '           <HEADER  left="880" top="20" right="980" bottom="40" text="사은행사수량" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="880" top="0" right="980" bottom="20" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(EVENT_QTY)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>' 
        + '       <COLUMN id="EVENT_AMT"  refcolid="EVENT_AMT">'
        + '           <HEADER  left="880" top="40" right="980" bottom="60" text="사은행사금액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="880" top="20" right="980" bottom="40" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  bgcolor="#EDF4F8"  displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(EVENT_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>'  
        + '       <COLUMN id="ACC_POUT_QTY"  refcolid="ACC_POUT_QTY">'
        + '           <HEADER  left="980" top="20" right="1080" bottom="40" text="재무강제불출수량" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="980" top="0" right="1080" bottom="20" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(ACC_POUT_QTY)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>' 
        + '       <COLUMN id="ACC_POUT_AMT"  refcolid="ACC_POUT_AMT">'
        + '           <HEADER  left="980" top="40" right="1080" bottom="60" text="재무강제불출금액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="980" top="20" right="1080" bottom="40" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  bgcolor="#EDF4F8"  displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(ACC_POUT_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>'  
        + '       <COLUMN id="SPS_POUT_QTY"  refcolid="SPS_POUT_QTY">'
        + '           <HEADER  left="1080" top="20" right="1190" bottom="40" text="특판강제불출수량" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="1080" top="0" right="1190" bottom="20" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(SPS_POUT_QTY)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>' 
        + '       <COLUMN id="SPS_POUT_AMT"  refcolid="SPS_POUT_AMT">'
        + '           <HEADER  left="1080" top="40" right="1190" bottom="60" text="특판강제불출금액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="1080" top="20" right="1190" bottom="40" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  bgcolor="#EDF4F8"  displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(SPS_POUT_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>'  
        + '       <COLUMN id="COMPL_QTY"  refcolid="COMPL_QTY">'
        + '           <HEADER  left="1190" top="20" right="1290" bottom="40" text="컴플레인용수량" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="1190" top="0" right="1290" bottom="20" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(COMPL_QTY)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>' 
        + '       <COLUMN id="COMPL_AMT"  refcolid="COMPL_AMT">'
        + '           <HEADER  left="1190" top="40" right="1290" bottom="60" text="컴플레인용금액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="1190" top="20" right="1290" bottom="40" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  bgcolor="#EDF4F8"  displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(COMPL_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>'        
        + '       <COLUMN id="POUT_QTY"  refcolid="POUT_QTY" >'
        + '           <HEADER left="1290" top="20" right="1390" bottom="40" text="DESK불출수량" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="1290" top="0" right="1390" bottom="20" align="RightCenter" borderstyle="Line" bordercolor="#dddddd"  displayformat="#,##0"/>'
        + '         <VIEWSUMMARY text="@GFSUM(POUT_QTY)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />' 
        + '       </COLUMN>' 
        + '       <COLUMN id="POUT_AMT"  refcolid="POUT_AMT" >'
        + '           <HEADER left="1290" top="40" right="1390" bottom="60" text="DESK불출금액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="1290" top="20" right="1390" bottom="40" align="RightCenter" borderstyle="Line" bordercolor="#dddddd"   bgcolor="#EDF4F8" displayformat="#,##0"/>'
        + '         <VIEWSUMMARY text="@GFSUM(POUT_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />' 
        + '       </COLUMN>'
        + '       <COLUMN id="PRIZ_QTY"  refcolid="PRIZ_QTY" >'
        + '           <HEADER left="1390" top="20" right="1490" bottom="40" text="경품행사용수량" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="1390" top="0" right="1490" bottom="20" align="RightCenter" borderstyle="Line" bordercolor="#dddddd"  displayformat="#,##0"/>'
        + '         <VIEWSUMMARY text="@GFSUM(PRIZ_QTY)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />' 
        + '       </COLUMN>' 
        + '       <COLUMN id="PRIZ_AMT"  refcolid="PRIZ_AMT" >'
        + '           <HEADER left="1390" top="40" right="1490" bottom="60" text="경품행사용금액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="1390" top="20" right="1490" bottom="40" align="RightCenter" borderstyle="Line" bordercolor="#dddddd"   bgcolor="#EDF4F8" displayformat="#,##0"/>'
        + '         <VIEWSUMMARY text="@GFSUM(PRIZ_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />' 
        + '       </COLUMN>'        
        + '       <COLUMN id="RFD"  refcolid="">'
        + '           <HEADER left="1490" top="0" right="1930" bottom="20" text="회수" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '       </COLUMN>'
        + '       <COLUMN id="NOR_DRAWL_QTY"  refcolid="NOR_DRAWL_QTY">'
        + '           <HEADER  left="1490" top="20" right="1570" bottom="40" text="정상수량" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="1490" top="0" right="1570" bottom="20" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(NOR_DRAWL_QTY)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>' 
        + '       <COLUMN id="NOR_DRAWL_AMT"  refcolid="NOR_DRAWL_AMT">'
        + '           <HEADER   left="1490" top="40" right="1570" bottom="60" text="정상금액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="1490" top="20" right="1570" bottom="40" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  bgcolor="#EDF4F8"  displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(NOR_DRAWL_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>'   
        + '       <COLUMN id="VEN_DRAWL_QTY"  refcolid="VEN_DRAWL_QTY">'
        + '           <HEADER  left="1570" top="20" right="1670" bottom="40" text="가맹점수량" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="1570" top="0" right="1670" bottom="20" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(VEN_DRAWL_QTY)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>' 
        + '       <COLUMN id="VEN_DRAWL_AMT"  refcolid="VEN_DRAWL_AMT">'
        + '           <HEADER   left="1570" top="40" right="1670" bottom="60" text="가맹점금액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="1570" top="20" right="1670" bottom="40" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  bgcolor="#EDF4F8"  displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(VEN_DRAWL_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>'  
        + '       <COLUMN id="EXCH_DRAWL_QTY"  refcolid="EXCH_DRAWL_QTY">'
        + '           <HEADER  left="1670" top="20" right="1750" bottom="40" text="교환수량" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="1670" top="0" right="1750" bottom="20" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(EXCH_DRAWL_QTY)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>' 
        + '       <COLUMN id="EXCH_DRAWL_AMT"  refcolid="EXCH_DRAWL_AMT">'
        + '           <HEADER   left="1670" top="40" right="1750" bottom="60" text="교환금액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="1670" top="20" right="1750" bottom="40" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  bgcolor="#EDF4F8"  displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(EXCH_DRAWL_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>'  
        + '       <COLUMN id="RFD_DRAWL_QTY"  refcolid="RFD_DRAWL_QTY">'
        + '           <HEADER  left="1750" top="20" right="1830" bottom="40" text="판매반품회수수량" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="1750" top="0" right="1830" bottom="20" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(RFD_DRAWL_QTY)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>' 
        + '       <COLUMN id="RFD_DRAWL_AMT"  refcolid="RFD_DRAWL_AMT">'
        + '           <HEADER   left="1750" top="40" right="1830" bottom="60" text="판매반품회수금액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="1750" top="20" right="1830" bottom="40" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  bgcolor="#EDF4F8"  displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(RFD_DRAWL_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>'  
        + '       <COLUMN id="REUSE_IN_QTY_M"  refcolid="REUSE_IN_QTY_M">'
        + '           <HEADER  left="1830" top="20" right="1930" bottom="40" text="재사용수량" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="1830" top="0" right="1930" bottom="20" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(REUSE_IN_QTY_M)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>' 
        + '       <COLUMN id="REUSE_IN_AMT_M"  refcolid="REUSE_IN_AMT_M">'
        + '           <HEADER   left="1830" top="40" right="1930" bottom="60" text="재사용금액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="1830" top="20" right="1930" bottom="40" align="RightCenter"  borderstyle="Line" bordercolor="#dddddd"  bgcolor="#EDF4F8"  displayformat="#,##0"/>'
        + '           <VIEWSUMMARY text="@GFSUM(REUSE_IN_AMT_M)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />'  
        + '       </COLUMN>' 
        + '       <COLUMN id="STBOX_PREV_QTY"  refcolid="STBOX_PREV_QTY" >'
        + '           <HEADER left="1930" top="0" right="2100" bottom="30" text="금고재고수량" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="1930" top="0" right="2100" bottom="20" align="RightCenter" borderstyle="Line" bordercolor="#dddddd"  displayformat="#,##0"/>'
        + '         <VIEWSUMMARY text="@GFSUM(STBOX_PREV_QTY)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />' 
        + '       </COLUMN>' 
        + '       <COLUMN id="STBOX_PREV_AMT"  refcolid="STBOX_PREV_AMT" >'
        + '           <HEADER left="1930" top="30" right="2100" bottom="60" text="금고재고금액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="1930" top="20" right="2100" bottom="40" align="RightCenter" borderstyle="Line" bordercolor="#dddddd"   bgcolor="#EDF4F8" displayformat="#,##0"/>'
        + '         <VIEWSUMMARY text="@GFSUM(STBOX_PREV_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />' 
        + '       </COLUMN>'   
        + '       <COLUMN id="QTY"  refcolid="QTY" >'
        + '           <HEADER left="2100" top="0" right="2200" bottom="30" text="현재고수량" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="2100" top="0" right="2200" bottom="20" align="RightCenter" borderstyle="Line" bordercolor="#dddddd"  displayformat="#,##0"/>'
        + '         <VIEWSUMMARY text="@GFSUM(QTY)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />' 
        + '       </COLUMN>' 
        + '       <COLUMN id="AMT"  refcolid="AMT" >'
        + '           <HEADER left="2100" top="30" right="2200" bottom="60" text="현재고금액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="2100" top="20" right="2200" bottom="40" align="RightCenter" borderstyle="Line" bordercolor="#dddddd"   bgcolor="#EDF4F8" displayformat="#,##0"/>'
        + '         <VIEWSUMMARY text="@GFSUM(AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />' 
        + '       </COLUMN>'    
        + '       <COLUMN id="PREV_DRAWL_QTY"  refcolid="PREV_DRAWL_QTY" >'
        + '           <HEADER left="2200" top="0" right="2320" bottom="30" text="기초미회수내역수량" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="2200" top="0" right="2320" bottom="20" align="RightCenter" borderstyle="Line" bordercolor="#dddddd"  displayformat="#,##0"/>'
        + '         <VIEWSUMMARY text="@GFSUM(PREV_DRAWL_QTY)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />' 
        + '       </COLUMN>' 
        + '       <COLUMN id="PREV_DRAWL_AMT"  refcolid="PREV_DRAWL_AMT" >'
        + '           <HEADER left="2200" top="30" right="2320" bottom="60" text="기초미회수내역금액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="2200" top="20" right="2320" bottom="40" align="RightCenter" borderstyle="Line" bordercolor="#dddddd"   bgcolor="#EDF4F8" displayformat="#,##0"/>'
        + '         <VIEWSUMMARY text="@GFSUM(PREV_DRAWL_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />' 
        + '       </COLUMN>'   
        + '       <COLUMN id="NON_DRAWL_QTY"  refcolid="NON_DRAWL_QTY" >'
        + '           <HEADER left="2320" top="0" right="2430" bottom="30" text="기간미회수수량" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="2320" top="0" right="2430" bottom="20" align="RightCenter" borderstyle="Line" bordercolor="#dddddd"  displayformat="#,##0"/>'
        + '         <VIEWSUMMARY text="@GFSUM(NON_DRAWL_QTY)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />' 
        + '       </COLUMN>' 
        + '       <COLUMN id="NON_DRAWL_AMT"  refcolid="NON_DRAWL_AMT" >'
        + '           <HEADER left="2320" top="30" right="2430" bottom="60" text="기간미회수금액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="2320" top="20" right="2430" bottom="40" align="RightCenter" borderstyle="Line" bordercolor="#dddddd"   bgcolor="#EDF4F8" displayformat="#,##0"/>'
        + '         <VIEWSUMMARY text="@GFSUM(NON_DRAWL_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />' 
        + '       </COLUMN>'  
        + '       <COLUMN id="SUM_DRAWL_QTY"  refcolid="SUM_DRAWL_QTY" >'
        + '           <HEADER left="2430" top="0" right="2540" bottom="30" text="누적미회수수량" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="2430" top="0" right="2540" bottom="20" align="RightCenter" borderstyle="Line" bordercolor="#dddddd"  displayformat="#,##0"/>'
        + '         <VIEWSUMMARY text="@GFSUM(SUM_DRAWL_QTY)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />' 
        + '       </COLUMN>' 
        + '       <COLUMN id="SUM_DRAWL_AMT"  refcolid="SUM_DRAWL_AMT" >'
        + '           <HEADER left="2430" top="30" right="2540" bottom="60" text="누적수내역금액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#dddddd"/>'
        + '           <VIEW left="2430" top="20" right="2540" bottom="40" align="RightCenter" borderstyle="Line" bordercolor="#dddddd"   bgcolor="#EDF4F8" displayformat="#,##0"/>'
        + '         <VIEWSUMMARY text="@GFSUM(SUM_DRAWL_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0" />' 
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
	    
	    TR_MAIN.Action   = "/mss/mgif406.mg?goTo=" + goTo + parameters;
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
	var ExcelTitle = "점별상품권재고조회";
	
	//openExcelM(GD_MASTER, ExcelTitle, parameters, true );
	openExcelM2(GD_MASTER, ExcelTitle, parameters, true, g_strPid );
	//openExcel5(GD_MASTER, ExcelTitle, parameters, true , "",g_strPid );

    
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
  * getEtcCodeSub_Type()
  * 작 성 자 : 김정민
  * 작 성 일 : 2011-04-14
  * 개    요 : 상품권종류 
  * return값 : void
  */
function getEtcCodeSub_Type() {
    var goTo = "getEtcCodeSub_Type"; 
      
    TR_MAIN.Action = "/mss/mgif406.mg?goTo=" + goTo; 
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
 
    TR_MAIN.Action = "/mss/mgif406.mg?goTo=" + goTo + parameters; 
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
           id=GD_MASTER width=100% height=760 classid=<%=Util.CLSID_MGRID%> tabindex=1>
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

