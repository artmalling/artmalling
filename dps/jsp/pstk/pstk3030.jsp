<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 재고수불 > 재고실사> 월수불장현황
 * 작 성 일 : 2010.05.20
 * 작 성 자 : 이재득
 * 수 정 자 : 
 * 파 일 명 : pstk303.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 수불장 현황을 월 기준으로 보여준다.
 * 이    력 :
 *        2010.05.20 (이재득) 작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
 <% request.setCharacterEncoding("utf-8"); %> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>

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
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"
    type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">


/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
//엑셀 다운을 위한 조회조건 전역 선언
 var excelStrCd;
 var excelDeptCd;
 var excelTeamCd;
 var excelPcCd;
 var excelStkDt;
 var excelPumbunCd;
 /**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.20
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 170;		//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID

function doInit(){

	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_PBNMONTHQTY"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	 var obj   = document.getElementById("GD_PBNMONTHAMT"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	 
	
    //탭초기화 
    initTab('TAB_MAIN'); 

    // Input Data Set Header 초기화

    // Output Data Set Header 초기화    
    DS_PBNMONTHQTY.setDataHeader('<gauce:dataset name="H_SEL_PBNQTY"/>');
    DS_PBNMONTHAMT.setDataHeader('<gauce:dataset name="H_SEL_PBNAMT"/>');
    
    //그리드 초기화
    gridCreate1(); //수량기준    
    gridCreate2(); //금액기준
    
    // EMedit에 초기화( gauce.js )    
    initEmEdit(EM_O_STK_YM,       "THISMN",    PK);     // 년월
    initEmEdit(EM_O_PUMBUN_CD,    "CODE^6^0",  NORMAL); //브랜드코드
    initEmEdit(EM_O_PUMBUN_NAME,  "GEN^40",    READ);   //브랜드명    
    
    //콤보 초기화
    initComboStyle(LC_O_STR_CD,DS_O_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);  //점(조회) 
    initComboStyle(LC_O_DEPT_CD,DS_O_DEPT_CD, "CODE^0^30,NAME^0^110", 1, PK);  //팀    
    initComboStyle(LC_O_TEAM_CD,DS_O_TEAM_CD, "CODE^0^30,NAME^0^110", 1, PK);  //파트
    initComboStyle(LC_O_PC_CD,DS_O_PC_CD, "CODE^0^30,NAME^0^110", 1, PK);  //PC    
    
    // 로딩시 값을 가겨오지 않는 콤보 데이셋 초기화    
    DS_O_DEPT_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_O_TEAM_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_O_PC_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');

    initComboStyle(LC_BUY_FLAG,DS_BUY_FLAG, "CODE^0^30,NAME^0^110", 1, NORMAL);  //매입구분
    getEtcCodeRefer("DS_BUY_FLAG", "D", "P613", "Y");
    LC_BUY_FLAG.Index = 0;
    
    //점콤보 가져오기 ( gauce.js )     
    getStore("DS_O_STR_CD", "Y", "", "N");    
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_O_STR_CD, '<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); 
    
    LC_O_STR_CD.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}                 name="NO"         width=30    align=center  sumtext=""  edit=none</FC>'                  
                     + '<FC>id=PUMBUN_CD                name="브랜드코드"    width=65    align=center  sumtext=""  edit=none Suppress="1"</FC>'
                     + '<FC>id=PUMBUN_NAME              name="브랜드명"      width=100    align=left   sumtext=""  edit=none Suppress="1"</FC>' 
                     + '<FC>id=STK_YM                   name="년월"      width=75    align=center  sumtext=""  edit=none Suppress="1" mask="XXXX/XX"</FC>'
                     + '<FG> name="마진코드" '
                     + '<FC>id=EVENT_FLAG               name="행사구분"    width=60    align=center  sumtext=""  edit=none</FC>'
                     + '<FC>id=EVENT_RATE               name="행사율"      width=50    align=center  sumtext=""  edit=none</FC>'                     
                     + '</FG> '
                     + '<FC>id=MG_RATE                  name="마진율"      width=50    align=center  sumtext=""   edit=none</FC>' 
                     + '<FC>id=BUY_QTY                  name="매입"        width=70    align=right   sumtext=@sum  edit=none</FC>'                     
                     + '<FC>id=RFD_QTY                  name="반품"        width=70    align=right   sumtext=@sum  edit=none</FC>'
                     + '<FC>id=BORROW_QTY               name="대입"        width=70    align=right   sumtext=@sum  edit=none </FC>'                                                       
                     + '<FC>id=LEND_QTY                 name="대출"        width=70    align=right   sumtext=@sum  edit=none</FC>'
                     + '<FC>id=STRI_QTY                 name="점입"        width=70    align=right   sumtext=@sum  edit=none</FC>'
                     + '<FC>id=STRO_QTY                 name="점출"        width=70    align=right   sumtext=@sum  edit=none</FC>'
                     + '<FC>id=SALE_PRC_UP_BF_QTY       name="매가인하"    width=70    align=right   sumtext=@sum  edit=none</FC>'
                     + '<FC>id=SALE_PRC_DOWN_AF_QTY     name="매가인상"    width=70    align=right   sumtext=@sum  edit=none</FC>'
                     + '<FC>id=STK_ADJ_QTY              name="재고조정"    width=70    align=right   sumtext=@sum  edit=none</FC>'
                     + '<FC>id=SALE_QTY                 name="총매출"      width=70    align=right   sumtext=@sum  edit=none</FC>'
                     + '<FC>id=SRVY_E_QTY               name="기말재고"    width=70    align=right   sumtext=@sum  edit=none</FC>'
                     ;  
                     
    initGridStyle(GD_PBNMONTHQTY, "common", hdrProperies, true);
    GD_PBNMONTHQTY.ViewSummary = "1";    
    GD_PBNMONTHQTY.ColumnProp("PUMBUN_NAME", "sumtext")        = "합계";
}

function gridCreate2(){
    var hdrProperies = '<COLUMNINFO>' 
                     + '       <COLUMN id="PUMBUNCD" refcolid="PUMBUN_CD" >'
                     + '           <SUPPRESS>              <REFCOLID>PUMBUN_CD</REFCOLID>           </SUPPRESS>'
                     + '           <HEADER left="0" top="0" right="60" bottom="60" text="브랜드" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="0" top="0" right="60" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea"/>' 
                     + '       </COLUMN>'
       
                     + '       <COLUMN id="PUMBUNNAME"  refcolid="PUMBUN_NAME" >'
                     + '           <SUPPRESS>              <REFCOLID>PUMBUN_NAME</REFCOLID>           </SUPPRESS>'
                     + '           <HEADER left="60" top="0" right="160" bottom="60" text="브랜드명" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="60" top="0" right="160" bottom="40" align="leftCenter" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY  text=""  bgcolor="#b9d9ea"/>' 
                     + '       </COLUMN>'
                     
                     + '       <COLUMN id="STKYM" refcolid="STK_YM" >'
                     + '           <SUPPRESS>              <REFCOLID>PUMBUN_NAME</REFCOLID>           </SUPPRESS>'
                     + '           <HEADER left="160" top="0" right="230" bottom="60" text="년월" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="160" top="0" right="230" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca"  displayformat="XXXX/XX"/>'
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea"/>' 
                     + '       </COLUMN>'
       
                     + '       <COLUMN id="TOP_MG_CD"   >'
                     + '           <HEADER left="230" top="0" right="340" bottom="20" text="마진코드" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '       </COLUMN>'
                     
                     + '       <COLUMN id="EVENTFLAG" refcolid="EVENT_FLAG" >'
                     + '           <HEADER left="230" top="20" right="290" bottom="60" text="행사구분" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="230" top="0" right="290" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea"/>' 
                     + '       </COLUMN>'
       
                     + '       <COLUMN id="EVENTRATE"  refcolid="EVENT_RATE" >'
                     + '           <HEADER left="290" top="20" right="340" bottom="60" text="행사율" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="290" top="0" right="340" bottom="40" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEWSUMMARY  text=""  bgcolor="#b9d9ea"/>' 
                     + '       </COLUMN>'
                     
                     + '       <COLUMN id="MGRATE" refcolid="MG_RATE" >'
                     + '           <HEADER left="340" top="0" right="390" bottom="60" text="마진율" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="340" top="0" right="390" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca" displayformat="#,###.#0"/>'
                     + '           <VIEWSUMMARY text=""  bgcolor="#b9d9ea"/>' 
                     + '       </COLUMN>'

                     + '       <COLUMN id="TOP_BUY_SALE_AMT"   >'
                     + '           <HEADER left="390" top="0" right="480" bottom="20" text="매입" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '       </COLUMN>'
                     
                     + '       <COLUMN id="BUYSALEAMT" refcolid="BUY_SALE_AMT" >'
                     + '           <HEADER left="390" top="20" right="480" bottom="40" text="점출액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="390" top="0" right="480" bottom="20" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(BUY_SALE_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
                     
                     + '       <COLUMN id="BUYGAPAMT" refcolid="BUY_GAP_AMT" >'
                     + '           <HEADER left="390" top="40" right="480" bottom="60" text="점출차액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="390" top="20" right="480" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(BUY_GAP_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
                     
                     + '       <COLUMN id="TOP_RFD_SALE_AMT"   >'
                     + '           <HEADER left="480" top="0" right="570" bottom="20" text="반품" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '       </COLUMN>'
                     
                     + '       <COLUMN id="RFDSALEAMT" refcolid="RFD_SALE_AMT" >'
                     + '           <HEADER left="480" top="20" right="570" bottom="40" text="점출액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="480" top="0" right="570" bottom="20" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(RFD_SALE_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
                     
                     + '       <COLUMN id="RFDGAPAMT" refcolid="RFD_GAP_AMT" >'
                     + '           <HEADER left="480" top="40" right="570" bottom="60" text="점출차액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="480" top="20" right="570" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(RFD_GAP_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
                     
                     + '       <COLUMN id="TOP_BORROW_SALE_AMT"   >'
                     + '           <HEADER left="570" top="0" right="660" bottom="20" text="대입" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '       </COLUMN>'
                     
                     + '       <COLUMN id="BORROWSALEAMT" refcolid="BORROW_SALE_AMT" >'
                     + '           <HEADER left="570" top="20" right="660" bottom="40" text="점출액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="570" top="0" right="660" bottom="20" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(BORROW_SALE_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
                     
                     + '       <COLUMN id="BORROWGAPAMT" refcolid="BORROW_GAP_AMT" >'
                     + '           <HEADER left="570" top="40" right="660" bottom="60" text="점출차액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="570" top="20" right="660" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(BORROW_GAP_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
                     
                     + '       <COLUMN id="TOP_LEND_SALE_AMT"   >'
                     + '           <HEADER left="660" top="0" right="750" bottom="20" text="대출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '       </COLUMN>'
                     
                     + '       <COLUMN id="LENDSALEAMT" refcolid="LEND_SALE_AMT" >'
                     + '           <HEADER left="660" top="20" right="750" bottom="40" text="점출액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="660" top="0" right="750" bottom="20" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(LEND_SALE_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
                     
                     + '       <COLUMN id="LENDGAPAMT" refcolid="LEND_GAP_AMT" >'
                     + '           <HEADER left="660" top="40" right="750" bottom="60" text="점출차액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="660" top="20" right="750" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(LEND_GAP_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
                     
                     + '       <COLUMN id="TOP_STRI_SALE_AMT"   >'
                     + '           <HEADER left="750" top="0" right="840" bottom="20" text="점입" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '       </COLUMN>'
                     
                     + '       <COLUMN id="STRISALEAMT" refcolid="STRI_SALE_AMT" >'
                     + '           <HEADER left="750" top="20" right="840" bottom="40" text="점출액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="750" top="0" right="840" bottom="20" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(STRI_SALE_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
                     
                     + '       <COLUMN id="STRIGAPAMT" refcolid="STRI_GAP_AMT" >'
                     + '           <HEADER left="750" top="40" right="840" bottom="60" text="점출차액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="750" top="20" right="840" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(STRI_GAP_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
                     
                     + '       <COLUMN id="TOP_STRO_SALE_AMT"   >'
                     + '           <HEADER left="840" top="0" right="930" bottom="20" text="점출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '       </COLUMN>'
                     
                     + '       <COLUMN id="STROSALEAMT" refcolid="STRO_SALE_AMT" >'
                     + '           <HEADER left="840" top="20" right="930" bottom="40" text="점출액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="840" top="0" right="930" bottom="20" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(STRO_SALE_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
                     
                     + '       <COLUMN id="STROGAPAMT" refcolid="STRO_GAP_AMT" >'
                     + '           <HEADER left="840" top="40" right="930" bottom="60" text="점출차액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="840" top="20" right="930" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(STRO_GAP_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
                     

                     + '       <COLUMN id="TOP_SALE_PRC_UP_DOWN_AMT"   >'
                     + '           <HEADER left="930" top="0" right="1020" bottom="20" text="매가인상하" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '       </COLUMN>'
                     
                     + '       <COLUMN id="SALEPRCUPBFAMT" refcolid="SALE_PRC_UP_BF_AMT" >'
                     + '           <HEADER left="930" top="20" right="1020" bottom="40" text="매가인하" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="930" top="0" right="1020" bottom="20" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(SALE_PRC_UP_BF_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
                     
                     + '       <COLUMN id="SALEPRCDOWNAFAMT" refcolid="SALE_PRC_DOWN_AF_AMT" >'
                     + '           <HEADER left="930" top="40" right="1020" bottom="60" text="매가인상" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="930" top="20" right="1020" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(SALE_PRC_DOWN_AF_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
                     
                     
                     + '       <COLUMN id="TOP_SALE_SALE_AMT"   >'
                     + '           <HEADER left="1020" top="0" right="1110" bottom="20" text="총매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '       </COLUMN>'
                     
                     + '       <COLUMN id="SALESALEAMT" refcolid="SALE_SALE_AMT" >'
                     + '           <HEADER left="1020" top="20" right="1110" bottom="40" text="총매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="1020" top="0" right="1110" bottom="20" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(SALE_SALE_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
                     
                     + '       <COLUMN id="DCAMT" refcolid="DC_AMT" >'
                     + '           <HEADER left="1020" top="40" right="1110" bottom="60" text="에누리" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="1020" top="20" right="1110" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(DC_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
                     
                     + '       <COLUMN id="TOP_STK_ADJ_SALE_AMT"   >'
                     + '           <HEADER left="1110" top="0" right="1200" bottom="20" text="재고조정" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '       </COLUMN>'
                     
                     + '       <COLUMN id="STKADJSALEAMT" refcolid="STK_ADJ_SALE_AMT" >'
                     + '           <HEADER left="1110" top="20" right="1200" bottom="40" text="점출액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="1110" top="0" right="1200" bottom="20" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(STK_ADJ_SALE_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
                     
                     + '       <COLUMN id="STKADJGAPAMT" refcolid="STK_ADJ_GAP_AMT" >'
                     + '           <HEADER left="1110" top="40" right="1200" bottom="60" text="점출차액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="1110" top="20" right="1200" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(STK_ADJ_GAP_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
                     
                     + '       <COLUMN id="TOP_SRVY_E_AMT"   >'
                     + '           <HEADER left="1200" top="0" right="1290" bottom="20" text="기말재고" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '       </COLUMN>'
                     
                     + '       <COLUMN id="SRVYEAMT" refcolid="SRVY_E_AMT" >'
                     + '           <HEADER left="1200" top="20" right="1290" bottom="60" text="점출액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="1200" top="0" right="1290" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '           <VIEWSUMMARY text="@GFSUM(SRVY_E_AMT)"  bgcolor="#b9d9ea" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'

                     + '     </COLUMNINFO>';
                     
    initMGridStyle(GD_PBNMONTHAMT, "common", hdrProperies);
    DS_PBNMONTHAMT.UseChangeInfo = true;  
    GD_PBNMONTHAMT.ViewSummary = 1;             
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
 * 작 성 일 : 2010.05.19
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() { 
       
     
    if(!checkValidation()){
        return;
    }
    
    excelStrCd    = LC_O_STR_CD.Text;
    excelDeptCd   = LC_O_DEPT_CD.Text;
    excelTeamCd   = LC_O_TEAM_CD.Text;
    excelPcCd     = LC_O_PC_CD.Text;
    excelStkSDt   = EM_O_STK_YM.Text;
    excelPumbunCd = EM_O_PUMBUN_CD.Text;
    excelBuyFlag  = LC_BUY_FLAG.Text;
    
    switch(getTabItemSelect("TAB_MAIN")){
    case 1:
    	searchPbnQty();
    	searchPbnAmt();
        break;
    case 2:
    	searchPbnAmt();
    	searchPbnQty();
        break;    
    }   
}

/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.19
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
     
 }
/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.19
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
 function btn_Delete() { 
     
 }

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.19
 * 개    요 : DB에 저장 / 수정 
 * return값 : void
*/
function btn_Save() {
     
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.19
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
	var parameters = "점="     +nvl(excelStrCd,   '전체')                    
                   + " -팀=" +nvl(excelDeptCd,  '전체')    
                   + " -파트="   +nvl(excelTeamCd,  '전체')     
                   + " -PC="   +nvl(excelPcCd,    '전체')    
                   + " -년월=" +nvl(excelStkSDt,  '전체')
                   + " -브랜드=" +nvl(excelPumbunCd,'전체')
                   + " -매입구분=" +nvl(excelBuyFlag,'전체');

	switch(getTabItemSelect("TAB_MAIN")){
    case 1:
    	//openExcelM(GD_PBNMONTHAMT, "월수불장현황", parameters, true );
    	openExcelM2(GD_PBNMONTHAMT, "월수불장현황", parameters, true ,g_strPid );
    	GD_PBNMONTHAMT.Focus();
        break;
    case 2:
    	//openExcel2(GD_PBNMONTHQTY, "월수불장현황", parameters, true );
    	openExcel5(GD_PBNMONTHQTY, "월수불장현황", parameters, true , "",g_strPid );
    	GD_PBNMONTHAMT.Focus();
        break;    
    }
}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.19
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
	if(!checkValidation()){
        return;
    }
    
	var strStrCd     = LC_O_STR_CD.BindColVal;
    var strStrNm     = LC_O_STR_CD.Text;
    var strDeptCd    = LC_O_DEPT_CD.BindColVal;
    var strDeptNm    = LC_O_DEPT_CD.Text;
    var strTeamCd    = LC_O_TEAM_CD.BindColVal;
    var strTeamNm    = LC_O_TEAM_CD.Text;
    var strPcCd      = LC_O_PC_CD.BindColVal;
    var strPcNm      = LC_O_PC_CD.Text;
    var strStkYm     = EM_O_STK_YM.Text;    
    var strPumbunCd  = EM_O_PUMBUN_CD.Text;
    var strPumbunNm  = EM_O_PUMBUN_NAME.Text;
    var strOrgNm     = strStrNm + "/" + strDeptNm + "/" + strTeamNm + "/" + strPcNm;
    
    var strTaxFlag       = RD_TAX_FLAG.DataValue;
    var strTaxFlagCode   = RD_TAX_FLAG.CodeValue;
    
    var params   = "&strStrCd="+strStrCd
                 + "&strOrgNm="+encodeURIComponent(strOrgNm)
                 + "&strDeptCd="+strDeptCd
                 //+ "&strDeptNm="+encodeURIComponent(strDeptNm)
                 + "&strTeamCd="+strTeamCd
                 + "&strPcCd="+strPcCd                 
                 + "&strStkYm="+strStkYm
                 + "&strTaxFlag="+encodeURIComponent(strTaxFlag)
                 + "&strTaxFlagCode="+strTaxFlagCode
                 + "&strPumbunCd="+strPumbunCd
                 + "&strPumbunNm="+encodeURIComponent(strPumbunNm);
    window.open("/dps/pstk303.pt?goTo=print"+params,"OZREPORT", 1000, 700);
}

/**
 * btn_Conf()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.19
 * 개    요 : 확정 처리
 * return값 : void
 */
function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

 /**
  * searchPbnAmt
  * 작 성 자 : 
  * 작 성 일 : 2010.05.19
  * 개    요 : 금액기준 마스터을 조회한다.
  * return값 : void
 **/
 function searchPbnAmt(){
      
	 DS_PBNMONTHAMT.ClearData();
	 //DS_PBNMONTHQTY.ClearData();
	            
	 var strStrCd      = LC_O_STR_CD.BindColVal;
	 var strStkYm      = EM_O_STK_YM.Text;	 
	 var strDeptCd     = LC_O_DEPT_CD.BindColVal;
	 var strTeamCd     = LC_O_TEAM_CD.BindColVal;
	 var strPcCd       = LC_O_PC_CD.BindColVal;         
	 var strPumbunCd   = EM_O_PUMBUN_CD.Text;
	     
	 var strTaxFlag   = RD_TAX_FLAG.CodeValue;
     var strBuyFlag    = LC_BUY_FLAG.BindColVal;
	         
	 var goTo       = "searchPbnAmt" ;    
	 var action     = "O";     
	 var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
	                     +"&strStkYm="+encodeURIComponent(strStkYm)                   
	                     +"&strDeptCd="+encodeURIComponent(strDeptCd)
	                     +"&strTeamCd="+encodeURIComponent(strTeamCd)
	                     +"&strPcCd="+encodeURIComponent(strPcCd) 
	                     +"&strPumbunCd="+encodeURIComponent(strPumbunCd)
	                     +"&strTaxFlag="+encodeURIComponent(strTaxFlag)
                         +"&strBuyFlag="+encodeURIComponent(strBuyFlag);  
        
     TR_MAIN.Action="/dps/pstk303.pt?goTo="+goTo+parameters;  
     TR_MAIN.KeyValue="SERVLET("+action+":DS_PBNMONTHAMT=DS_PBNMONTHAMT)"; //조회는 O
     TR_MAIN.Post();
        
     //조회후 결과표시
     setPorcCount("SELECT", GD_PBNMONTHAMT);
  }
 
 /**
  * searchPbnQty
  * 작 성 자 : 
  * 작 성 일 : 2010.05.19
  * 개    요 : 수량기준 마스터을 조회한다.
  * return값 : void
 **/
 function searchPbnQty(){
      
     //DS_PBNMONTHAMT.ClearData();
     DS_PBNMONTHQTY.ClearData();
            
     var strStrCd      = LC_O_STR_CD.BindColVal;
     var strStkYm      = EM_O_STK_YM.Text;
     var strDeptCd     = LC_O_DEPT_CD.BindColVal;
     var strTeamCd     = LC_O_TEAM_CD.BindColVal;
     var strPcCd       = LC_O_PC_CD.BindColVal;         
     var strPumbunCd   = EM_O_PUMBUN_CD.Text;
     
     var strTaxFlag   = RD_TAX_FLAG.CodeValue;
     var strBuyFlag    = LC_BUY_FLAG.BindColVal;
         
     var goTo       = "searchPbnQty" ;    
     var action     = "O";     
     var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                     +"&strStkYm="+encodeURIComponent(strStkYm)                     
                     +"&strDeptCd="+encodeURIComponent(strDeptCd)
                     +"&strTeamCd="+encodeURIComponent(strTeamCd) 
                     +"&strPcCd="+encodeURIComponent(strPcCd) 
                     +"&strPumbunCd="+encodeURIComponent(strPumbunCd)
                     +"&strBuyFlag="+encodeURIComponent(strBuyFlag);     
        
     TR_MAIN.Action="/dps/pstk303.pt?goTo="+goTo+parameters;  
     TR_MAIN.KeyValue="SERVLET("+action+":DS_PBNMONTHQTY=DS_PBNMONTHQTY)"; //조회는 O
     TR_MAIN.Post();
        
     //조회후 결과표시
     setPorcCount("SELECT", GD_PBNMONTHQTY);
  }
 
 /**
  * checkValidation
  * 작 성 자 : 
  * 작 성 일 : 2010.05.19
  * 개    요 : checkValidation.
  * return값 : void
 **/
 function checkValidation(){
     if( LC_O_STR_CD.BindColVal == "" ){
         showMessage(EXCLAMATION, Ok,  "GAUCE-1005", "점");            
         LC_O_STR_CD.Focus();
         return false;
     }else if( LC_O_DEPT_CD.BindColVal == "" || LC_O_DEPT_CD.BindColVal == "%"){
         showMessage(EXCLAMATION, Ok,  "GAUCE-1005", "팀");            
         LC_O_DEPT_CD.Focus();
         return false;
     }else if( LC_O_TEAM_CD.BindColVal == "" || LC_O_TEAM_CD.BindColVal == "%"){
         showMessage(EXCLAMATION, Ok,  "GAUCE-1005", "파트");            
         LC_O_TEAM_CD.Focus();
         return false;
     }else if( LC_O_PC_CD.BindColVal == "" || LC_O_PC_CD.BindColVal == "%"){
         showMessage(EXCLAMATION, Ok,  "GAUCE-1005", "PC");            
         LC_O_PC_CD.Focus();
         return false;
     }else if( EM_O_STK_YM.Text == ""){
         showMessage(EXCLAMATION, Ok,  "GAUCE-1005", "년월");            
         EM_O_STK_YM.Focus();
         return false;
     }     
     
     return true;
 }
     
/**
  * setPumbunPopup()
  * 작 성 자 : 이재득
  * 작 성 일 : 2010.05.19
  * 개    요 : 브랜드POPUP를 조회한다.
  * return값 : void
  */
 function setPumbunPopup(evnflag){
      
     var strStrCd  = LC_O_STR_CD.BindColVal; 
     var strDeptCd  = LC_O_DEPT_CD.BindColVal;
     var strTeamCd = LC_O_TEAM_CD.BindColVal;  
     var strPcCd  = LC_O_PC_CD.BindColVal;
     var strCornerCd = "00";     
     
     var strOrgCd = strStrCd+strDeptCd+strTeamCd+strPcCd+strCornerCd; 
     var codeObj = EM_O_PUMBUN_CD;
     var nameObj = EM_O_PUMBUN_NAME;
      
     if(codeObj.Text == "" && evnflag != "POP" ){  
         nameObj.Text = "";
         return;
     }         

     var result = null;

     if( evnflag == "POP" ){
         result = strPbnPop(codeObj,nameObj,'Y', '',strStrCd, strOrgCd,'','','','','','','','','','');
          
     }else if( evnflag == "NAME" ){
         setStrPbnNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj,"Y", '1','',strStrCd, strOrgCd,'','','','','','','','','','');
         strSkuType = DS_SEARCH_NM.NameValue(1, "SKU_TYPE");   
     }

     if( result != null ){           
         strSkuType = result.get("SKU_TYPE");        
     }
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

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=JavaScript for=LC_O_STR_CD event=OnSelChange>
    
    DS_O_DEPT_CD.ClearData();
    DS_O_TEAM_CD.ClearData();
    DS_O_PC_CD.ClearData();
    EM_O_PUMBUN_CD.Text = "";
    EM_O_PUMBUN_NAME.Text = "";
    if (this.BindColVal == '%'){
        insComboData(LC_O_DEPT_CD, "%", "전체", 1);
        setComboData(LC_O_DEPT_CD, "%");
        return;     
    }
    
    getDept("DS_O_DEPT_CD", "Y", LC_O_STR_CD.BindColVal, "N");
    if(DS_O_DEPT_CD.CountRow < 1){
        insComboData(LC_O_DEPT_CD, "%", "전체", 1);       
    }
    LC_O_DEPT_CD.Index = 0;

</script>

<script language=JavaScript for=LC_O_DEPT_CD event=OnSelChange>
    
    DS_O_TEAM_CD.ClearData();
    DS_O_PC_CD.ClearData();
    EM_O_PUMBUN_CD.Text = "";
    EM_O_PUMBUN_NAME.Text = "";
    if (this.BindColVal == '%'){
        insComboData(LC_O_TEAM_CD, "%", "전체", 1);
        setComboData(LC_O_TEAM_CD, "%");
        return;     
    }
    
    getTeam("DS_O_TEAM_CD", "Y", LC_O_STR_CD.BindColVal,
                LC_O_DEPT_CD.BindColVal, "N");

    if(DS_O_TEAM_CD.CountRow < 1){
        insComboData(LC_O_TEAM_CD, "%", "전체", 1);       
    }
    LC_O_TEAM_CD.Index = 0;
</script>

<script language=JavaScript for=LC_O_TEAM_CD event=OnSelChange>
    
    DS_O_PC_CD.ClearData();
    EM_O_PUMBUN_CD.Text = "";
    EM_O_PUMBUN_NAME.Text = "";
    if (this.BindColVal == '%'){
        insComboData(LC_O_PC_CD, "%", "전체", 1);
        setComboData(LC_O_PC_CD, "%");
        return;     
    }
    getPc("DS_O_PC_CD", "Y", LC_O_STR_CD.BindColVal,
                LC_O_DEPT_CD.BindColVal, LC_O_TEAM_CD.BindColVal, "N");

    if(DS_O_PC_CD.CountRow < 1){ 
        insComboData(LC_O_PC_CD, "%", "전체", 1);       
    }
    LC_O_PC_CD.Index = 0;
</script>

<script language=JavaScript for=LC_O_PC_CD event=OnSelChange>
    EM_O_PUMBUN_CD.Text = "";
    EM_O_PUMBUN_NAME.Text = "";
</script>

<!-- 브랜드코드 변경시 -->
<script language=JavaScript for=EM_O_PUMBUN_CD event=OnKillFocus()>   
    if(!this.Modified)
        return;    
    setPumbunPopup("NAME");
</script>

<!-- 년월 -->
<script language=JavaScript for=EM_O_STK_YM event=onKillFocus()>
    if(!checkDateTypeYM(this))
        return;
</script>

<!-- Grid Detail oneClick event 처리 -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
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
<object id="DS_O_STR_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_DEPT_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_TEAM_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_PC_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_BUY_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_PBNMONTHAMT" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_PBNMONTHQTY" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_SEARCH_NM" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->

<script language='javascript'>
window.onresize = function(){
	
var obj   = document.getElementById("GD_PBNMONTHQTY");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
	var obj   = document.getElementById("GD_PBNMONTHAMT");
    
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
        <td class="PT01 PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
            class="o_table">
            <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th class="point" width="80">점</th>
            <td width="165">
                 <comment id="_NSID_">
                    <object id=LC_O_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=165 tabindex=1 align="absmiddle">
                    </object>
                </comment><script>_ws_(_NSID_);</script>
            </td>
            <th class="point" width="80">팀</th>
            <td width="165"><comment id="_NSID_"> <object id=LC_O_DEPT_CD
                classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165 tabindex=1
                align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
            <th class="point" width="80">파트</th>
            <td><comment id="_NSID_"> <object id=LC_O_TEAM_CD
                classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=170 tabindex=1
                align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td> 
          </tr>
          <tr>
            <th class="point" width="80">PC</th>
            <td><comment id="_NSID_"> <object id=LC_O_PC_CD
                classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165 tabindex=1
                align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
            <th class="point" width="80">년월</th>
            <td colspan = "2"><comment id="_NSID_"> <object
                id=EM_O_STK_YM classid=<%=Util.CLSID_EMEDIT%> width=138 tabindex=1
                align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
                src="/<%=dir%>/imgs/btn/date.gif" class="PR03"
                onclick="javascript:openCal('M',EM_O_STK_YM)" align="absmiddle" /></td>                        
            <td>
                <comment id="_NSID_">
                    <object id=RD_TAX_FLAG classid=<%=Util.CLSID_RADIO%> tabindex=1 style="height:20; width:180">
                    <param name=Cols    value="2">
                    <param name=Format  value="A^세포함,B^세제외">
                    <param name=CodeValue  value="A">
                    </object>  
                </comment><script> _ws_(_NSID_);</script> 
            </td>           
          </tr>
            <tr>
            <th width="80">브랜드</th>
            <td colspan="3">
                <comment id="_NSID_">
                      <object id=EM_O_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%>  width=70 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03" onclick="javascript: setPumbunPopup('POP')" align="absmiddle" />
                <comment id="_NSID_">
                      <object id=EM_O_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%>  width=168 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>                
            </td>   
            <th width="80">매입구분</th> 
            <td><comment id="_NSID_"> <object id=LC_BUY_FLAG
                classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165 tabindex=1
                align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>          
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>  
  <tr>
      <td class="dot"></td>
  </tr>  
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" >
        <tr>
          <td valign="top"  class="PT05">
            <div id=TAB_MAIN  width="100%" height=780 TitleWidth=90 TitleAlign="center" >
              <menu TitleName="금액기준"       DivId="tab_page1" Enable='true' />
              <menu TitleName="수량기준"       DivId="tab_page2" Enable='true' />
            </div>
            <div id=tab_page1 width="100%" >
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
              <tr>
                <td width="100%">
                  <comment id="_NSID_"> <object 
                  id=GD_PBNMONTHAMT width=100% height=424 classid=<%=Util.CLSID_MGRID%>>
                     <param name="DataID" value="DS_PBNMONTHAMT">
                     <Param Name="IndicatorInfo"       value='
                       <INDICATORINFO width="20" fontsize="9" indexnumber="true"/>'>
                     <Param Name="sort"      value="false">
                  </object> </comment><script>_ws_(_NSID_);</script></td>
              </tr>
            </table>
            </div>
            <div id=tab_page2 width="100%" >
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
              <tr>
                <td>
                  <comment id="_NSID_"><object id=GD_PBNMONTHQTY width="100%" height=424 classid=<%=Util.CLSID_GRID%>>
                    <param name="DataID" value="DS_PBNMONTHQTY">
                  </object></comment><script>_ws_(_NSID_);</script>
                </td>
              </tr>
            </table>
            </div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>

