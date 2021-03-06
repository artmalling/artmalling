<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 재고수불 > 재고실사> 기간조직별손익명세서
 * 작 성 일 : 2010.06.20
 * 작 성 자 : 이재득
 * 수 정 자 : 
 * 파 일 명 : pstk306.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 조직별 기간합계 손익명세서를 보여준다.
 * 이    력 :
 *        2010.06.20 (이재득) 작성
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
 var excelStkYm;
 var excelStkToYm;
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.06
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 150;		//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID

function doInit(){
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	
	

    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');  
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화( gauce.js )    i
    initEmEdit(EM_O_STK_YM, "THISMN",  PK); //일자FROM
    initEmEdit(EM_O_STK_TO_YM, "THISMN",  PK); //일자TO
    //콤보 초기화
    initComboStyle(LC_O_STR_CD,DS_O_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);  //점(조회)
    initComboStyle(LC_O_DEPT_CD,DS_O_DEPT_CD, "CODE^0^30,NAME^0^110", 1, PK);  //팀    
    initComboStyle(LC_O_TEAM_CD,DS_O_TEAM_CD, "CODE^0^30,NAME^0^110", 1, NORMAL);  //파트
    initComboStyle(LC_O_PC_CD,DS_O_PC_CD, "CODE^0^30,NAME^0^110", 1, NORMAL);  //PC
    
    // 로딩시 값을 가겨오지 않는 콤보 데이셋 초기화    
    DS_O_DEPT_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_O_TEAM_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_O_PC_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');

    initComboStyle(LC_BUY_FLAG,DS_BUY_FLAG, "CODE^0^30,NAME^0^110", 1, NORMAL);  //매입구분
    getEtcCodeRefer("DS_BUY_FLAG", "D", "P613", "Y");
    LC_BUY_FLAG.Index = 0;
    
    //점콤보 가져오기 ( gauce.js )     
    getStore("DS_O_STR_CD", "Y", "", "N");  
    
  //시스템 코드 공통코드에서 가지고 오기( popup.js ) 
    getEtcCode("DS_O_TAX_FLAG", "D", "P004", "N");       //기획년도  
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_O_STR_CD, '<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); 
    
    LC_O_STR_CD.Focus();
}

function gridCreate1(){
    var hdrProperies = '<COLUMNINFO>' 
                     + '       <COLUMN id="STRCD" refcolid="STR_CD" >'
                     + '           <HEADER left="0" top="0" right="0" bottom="0" text="점코드" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="0" top="0" right="0" bottom="0" borderstyle="Line" bordercolor="#cacaca"/>'                            
                     + '       </COLUMN>'

                     + '       <COLUMN id="TOP_DEPT_CD"   >'
                     + '           <HEADER left="0" top="0" right="140" bottom="20" text="팀" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="DEPTCD" refcolid="DEPT_CD" >'
                     + '           <HEADER left="0" top="20" right="40" bottom="60" text="코드" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="0" top="0" right="40" bottom="40" borderstyle="Line" bordercolor="#cacaca"/>'                            
                     + '       </COLUMN>'

                     + '       <COLUMN id="DEPTNAME"  refcolid="DEPT_NAME" >'
                     + '           <HEADER left="40" top="20" right="140" bottom="60" text="명" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="40" top="0" right="140" bottom="40" align="leftCenter" borderstyle="Line" bordercolor="#cacaca" align="LeftCenter"/>'                               
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="TOP_TEAM_CD"   >'
                     + '           <HEADER left="140" top="0" right="280" bottom="20" text="파트" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="TEAMCD"  refcolid="TEAM_CD" >'
                     + '           <HEADER left="140" top="20" right="180" bottom="60" text="코드" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="140" top="0" right="180" bottom="40" borderstyle="Line" bordercolor="#cacaca"/>'                                
                     + '       </COLUMN>'   
        
                     + '       <COLUMN id="TEAMNAME"  refcolid="TEAM_NAME" >'
                     + '           <HEADER left="180" top="20" right="280" bottom="60" text="명" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="180" top="0" right="280" bottom="40" align="leftCenter" borderstyle="Line" bordercolor="#cacaca" align="LeftCenter"/>'                               
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="TOP_PC_CD"   >'
                     + '           <HEADER left="280" top="0" right="420" bottom="20" text="PC" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="PCCD"  refcolid="PC_CD" >'
                     + '           <HEADER left="280" top="20" right="320" bottom="60" text="코드" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="280" top="0" right="320" bottom="40" borderstyle="Line" bordercolor="#cacaca"/>'                              
                     + '       </COLUMN>'   
        
                     + '       <COLUMN id="PCNAME"  refcolid="PC_NAME" >'
                     + '           <HEADER left="320" top="20" right="420" bottom="60" text="명" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="320" top="0" right="420" bottom="40" align="leftCenter" borderstyle="Line" bordercolor="#cacaca" align="LeftCenter"/>'                             
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="TAXFLAG_NAME" refcolid="TAX_FLAG_NAME" >'
                     + '           <HEADER left="420" top="0" right="480" bottom="60" text="과세;구분" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="420" top="0" right="480" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="TOP_BASE_AMT"   >'
                     + '           <HEADER left="480" top="0" right="760" bottom="20" text="기초재고" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="CAOSALE_AMT" refcolid="CAO_SALE_AMT" >'
                     + '           <HEADER left="480" top="20" right="570" bottom="40" text="점출액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="480" top="0" right="570" bottom="20" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="CAOGAP_AMT"  refcolid="CAO_PROFIT_AMT" >'
                     + '           <HEADER left="480" top="40" right="570" bottom="60" text="점출차액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="480" top="20" right="570" bottom="40" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="CAOSALE_VAT_AMT" refcolid="CAO_TAX_AMT" >'
                     + '           <HEADER left="570" top="20" right="660" bottom="60" text="점출부가세" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="570" top="0" right="660" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="CAOEX_VAT_SALE_AMT" refcolid="CAO_EX_VAT_SALE_AMT" >'
                     + '           <HEADER left="660" top="20" right="760" bottom="40" text="점출액(세제외)" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="660" top="0" right="760" bottom="20" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="CAOEX_VAT_STR_GAP_AMT" refcolid="CAO_EX_VAT_PROFIT_AMT" >'
                     + '           <HEADER left="660" top="40" right="760" bottom="60" text="점출차액(세제외)" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="660" top="20" right="760" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>' 
        
                     + '       <COLUMN id="TOP_BUY_SALE_AMT"   >'
                     + '           <HEADER left="760" top="0" right="850" bottom="20" text="매입" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="BUYSALE_AMT" refcolid="BUY_SALE_AMT" >'
                     + '           <HEADER left="760" top="20" right="850" bottom="40" text="점출액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="760" top="0" right="850" bottom="20" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="BUYGAP_AMT" refcolid="BUY_PROFIT_AMT" >'
                     + '           <HEADER left="760" top="40" right="850" bottom="60" text="점출차액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="760" top="20" right="850" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="TOP_RFD_SALE_AMT"   >'
                     + '           <HEADER left="850" top="0" right="940" bottom="20" text="반품" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="RFDSALE_AMT" refcolid="RFD_SALE_AMT" >'
                     + '           <HEADER left="850" top="20" right="940" bottom="40" text="점출액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="850" top="0" right="940" bottom="20" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="RFDGAP_AMT" refcolid="RFD_PROFIT_AMT" >'
                     + '           <HEADER left="850" top="40" right="940" bottom="60" text="점출차액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="850" top="20" right="940" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="TOP_BORROW_SALE_AMT"   >'
                     + '           <HEADER left="940" top="0" right="1030" bottom="20" text="대입" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="BORROWSALE_AMT" refcolid="BORROW_SALE_AMT" >'
                     + '           <HEADER left="940" top="20" right="1030" bottom="40" text="점출액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="940" top="0" right="1030" bottom="20" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="BORROWGAP_AMT" refcolid="BORROW_PROFIT_AMT" >'
                     + '           <HEADER left="940" top="40" right="1030" bottom="60" text="점출차액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="940" top="20" right="1030" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="TOP_LEND_SALE_AMT"   >'
                     + '           <HEADER left="1030" top="0" right="1120" bottom="20" text="대출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="LENDSALE_AMT" refcolid="LEND_SALE_AMT" >'
                     + '           <HEADER left="1030" top="20" right="1120" bottom="40" text="점출액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="1030" top="0" right="1120" bottom="20" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="LENDGAP_AMT" refcolid="LEND_PROFIT_AMT" >'
                     + '           <HEADER left="1030" top="40" right="1120" bottom="60" text="점출차액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="1030" top="20" right="1120" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="TOP_STRI_SALE_AMT"   >'
                     + '           <HEADER left="1120" top="0" right="1210" bottom="20" text="점입" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="STRISALE_AMT" refcolid="STRI_SALE_AMT" >'
                     + '           <HEADER left="1120" top="20" right="1210" bottom="40" text="점출액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="1120" top="0" right="1210" bottom="20" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="STRIGAP_AMT" refcolid="STRI_PROFIT_AMT" >'
                     + '           <HEADER left="1120" top="40" right="1210" bottom="60" text="점출차액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="1120" top="20" right="1210" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="TOP_STRO_SALE_AMT"   >'
                     + '           <HEADER left="1210" top="0" right="1300" bottom="20" text="점출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="STROSALE_AMT" refcolid="STRO_SALE_AMT" >'
                     + '           <HEADER left="1210" top="20" right="1300" bottom="40" text="점출액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="1210" top="0" right="1300" bottom="20" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="STROGAP_AMT" refcolid="STRO_PROFIT_AMT" >'
                     + '           <HEADER left="1210" top="40" right="1300" bottom="60" text="점출차액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="1210" top="20" right="1300" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="TOP_STK_ADJ_SALE_AMT"   >'
                     + '           <HEADER left="1300" top="0" right="1390" bottom="20" text="재고조정" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="STKADJ_SALE_AMT" refcolid="STK_ADJ_SALE_AMT" >'
                     + '           <HEADER left="1300" top="20" right="1390" bottom="40" text="점출액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="1300" top="0" right="1390" bottom="20" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="STKADJ_GAP_AMT" refcolid="STK_ADJ_PROFIT_AMT" >'
                     + '           <HEADER left="1300" top="40" right="1390" bottom="60" text="점출차액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="1300" top="20" right="1390" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="TOP_SALE_PRC_AMT"   >'
                     + '           <HEADER left="1390" top="0" right="1480" bottom="20" text="매가" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="SALEPRC_UP_BF_AMT" refcolid="SALE_PRC_UP_BF_AMT" >'
                     + '           <HEADER left="1390" top="20" right="1480" bottom="40" text="매가인하" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="1390" top="0" right="1480" bottom="20" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="SALEPRC_DOWN_AF_AMT" refcolid="SALE_PRC_DOWN_AF_AMT" >'
                     + '           <HEADER left="1390" top="40" right="1480" bottom="60" text="매가인상" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="1390" top="20" right="1480" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
        			 
                     
                     + '       <COLUMN id="TOP_DW_BUY_SALE_AMT"   >'
                     + '           <HEADER left="1480" top="0" right="1570" bottom="20" text="당월매입합계" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '       </COLUMN>'  
                     
                     + '       <COLUMN id="DW_BUY_SALE_AMT" refcolid="DW_BUY_SALE_AMT" >'
                     + '           <HEADER left="1480" top="20" right="1570" bottom="40" text="점출액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="1480" top="0" right="1570" bottom="20" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
       
                     + '       <COLUMN id="DW_BUY_PROFIT_AMT"  refcolid="DW_BUY_PROFIT_AMT" >'
                     + '           <HEADER left="1480" top="40" right="1570" bottom="60" text="점출차액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="1480" top="20" right="1570" bottom="40" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
                     
                     
                     
                     + '       <COLUMN id="TOP_BUY_TOT_SALE_AMT"   >'
                     + '           <HEADER left="1570" top="0" right="1850" bottom="20" text="매입합계" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '       </COLUMN>'  
        
                     + '       <COLUMN id="BUYTOT_SALE_AMT" refcolid="BUY_TOT_SALE_AMT" >'
                     + '           <HEADER left="1570" top="20" right="1660" bottom="40" text="점출액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="1570" top="0" right="1660" bottom="20" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="BUYTOT_GAP_AMT"  refcolid="BUY_TOT_PROFIT_AMT" >'
                     + '           <HEADER left="1570" top="40" right="1660" bottom="60" text="점출차액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="1570" top="20" right="1660" bottom="40" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="BUYVAT_SALE_AMT" refcolid="BUY_TOT_TAX_AMT" >'
                     + '           <HEADER left="1660" top="20" right="1750" bottom="60" text="점출부가세" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="1660" top="0" right="1750" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="BUYEX_VAT_SALE_AMT" refcolid="BUY_TOT_EX_VAT_SALE_AMT" >'
                     + '           <HEADER left="1750" top="20" right="1850" bottom="40" text="점출액(세제외)" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="1750" top="0" right="1850" bottom="20" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="BUYEX_VAT_STR_GAP_AMT" refcolid="BUY_TOT_EX_VAT_PROFIT_AMT" >'
                     + '           <HEADER left="1750" top="40" right="1850" bottom="60" text="점출차액(세제외)" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="1750" top="20" right="1850" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>' 
        
                     
                     + '       <COLUMN id="TOP_BUY_TOT_SALE_AMT"   >'
                     + '           <HEADER left="1850" top="0" right="2150" bottom="20" text="매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '       </COLUMN>'  
                     
                     + '       <COLUMN id="SALEAMT" refcolid="SALE_SALE_AMT" >'
                     + '           <HEADER left="1850" top="20" right="1950" bottom="40" text="총매출액(세포함)" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="1850" top="0" right="1950" bottom="20" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
       
                     + '       <COLUMN id="DCAMT"  refcolid="SALE_DC_AMT" >'
                     + '           <HEADER left="1850" top="40" right="1950" bottom="60" text="에누리(세포함)" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="1850" top="20" right="1950" bottom="40" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="SALEEXVATAMT" refcolid="SALE_EX_VAT_AMT" >'
                     + '           <HEADER left="1950" top="20" right="2050" bottom="40" text="총매출액(세제외)" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="1950" top="0" right="2050" bottom="20" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'


                     + '       <COLUMN id="SALEDCEXAMT"  refcolid="SALE_DC_EX_AMT" >'
                     + '           <HEADER left="1950" top="40" right="2050" bottom="60" text="순매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="1950" top="20" right="2050" bottom="40" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'

       
                     + '       <COLUMN id="SALEVATAMT"  refcolid="SALE_VAT_AMT" >'
                     + '           <HEADER left="2050" top="20" right="2150" bottom="40" text="순매출부가세" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="2050" top="0" right="2150" bottom="20" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
                     
                     + '       <COLUMN id="SALENETSALEAMT"  refcolid="SALE_NET_SALE_AMT" >'
                     + '           <HEADER left="2050" top="40" right="2150" bottom="60" text="세제외순매출액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="2050" top="20" right="2150" bottom="40" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
                  
				 	/*
                     + '       <COLUMN id="TOP_BUY_TOT_SALE_AMT"   >'
                     + '           <HEADER left="1850" top="0" right="2250" bottom="20" text="매출" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '       </COLUMN>'  
        
                     + '       <COLUMN id="SALEAMT" refcolid="SALE_SALE_AMT" >'
                     + '           <HEADER left="1850" top="20" right="1950" bottom="40" text="총매출액(세포함)" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="1850" top="0" right="1950" bottom="20" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="DCAMT"  refcolid="SALE_DC_AMT" >'
                     + '           <HEADER left="1850" top="40" right="1950" bottom="60" text="에누리(세포함)" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="1850" top="20" right="1950" bottom="40" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="SALEEXVATAMT" refcolid="SALE_EX_VAT_AMT" >'
                     + '           <HEADER left="1950" top="20" right="2050" bottom="40" text="총매출액(세제외)" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="1950" top="0" right="2050" bottom="20" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
                       
                     + '       <COLUMN id="DCEXVATAMT"  refcolid="SALE_EX_VAT_DC_AMT" >'
                     + '           <HEADER left="1950" top="40" right="2050" bottom="60" text="에누리(세제외)" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="1950" top="20" right="2050" bottom="40" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="NETSALEAMT" refcolid="SALE_NET_SALE_AMT" >'
                     + '           <HEADER left="2050" top="20" right="2150" bottom="40" text="순매출액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="2050" top="0" right="2150" bottom="20" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="SALEVATAMT"  refcolid="SALE_VAT_AMT" >'
                     + '           <HEADER left="2050" top="40" right="2150" bottom="60" text="매출부가세" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="2050" top="20" right="2150" bottom="40" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="SALEPROFITAMT" refcolid="SALE_PROFIT_AMT" >'
                     + '           <HEADER left="2150" top="20" right="2250" bottom="40" text="매출이익액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="2150" top="0" right="2250" bottom="20" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="SALEPROFITRATE"  refcolid="SALE_PROFIT_RATE" >'
                     + '           <HEADER left="2150" top="40" right="2250" bottom="60" text="매출이익율" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="2150" top="20" right="2250" bottom="40" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
        			*/
                     
                     + '       <COLUMN id="TOP_BASE_AMT"   >'
                     + '           <HEADER left="2150" top="0" right="2430" bottom="20" text="월말재고" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="LASTSALE_AMT" refcolid="DW_SALE_AMT" >'
                     + '           <HEADER left="2150" top="20" right="2240" bottom="40" text="점출액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="2150" top="0" right="2240" bottom="20" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'

                     + '       <COLUMN id="LAST_VAT_SALE_AMT"  refcolid="DW_PROFIT_AMT" >'
                     + '           <HEADER left="2150" top="40" right="2240" bottom="60" text="점출차액" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="2150" top="20" right="2240" bottom="40" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="LASTVAT_SALE_AMT" refcolid="DW_TAX_AMT" >'
                     + '           <HEADER left="2240" top="20" right="2330" bottom="60" text="점출부가세" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="2240" top="0" right="2330" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="LASTEX_VAT_SALE_AMT" refcolid="DW_EX_VAT_SALE_AMT" >'
                     + '           <HEADER left="2330" top="20" right="2430" bottom="40" text="점출액(세제외)" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="2330" top="0" right="2430" bottom="20" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'                            
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="LASTEX_VAT_GAP_AMT" refcolid="DW_EX_VAT_PROFIT_AMT" >'
                     + '           <HEADER left="2330" top="40" right="2430" bottom="60" text="점출차액(세제외)" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="2330" top="20" right="2430" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'                           
                     + '       </COLUMN>'

        

                     + '       <COLUMN id="EXVATPROFITAMT" refcolid="EX_VAT_PROFIT_AMT" >'
                     + '           <HEADER left="2430" top="0" right="2530" bottom="60" text="세제외점출차익율" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="2430" top="0" right="2530" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,###.000"/>'                           
                     + '       </COLUMN>'
                    
                     + '       <COLUMN id="COSTRATE" refcolid="COST_RATE" >'
                     + '           <HEADER left="2530" top="0" right="2630" bottom="60" text="원가율" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="2530" top="0" right="2630" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,###.000"/>'                           
                     + '       </COLUMN>'
                     
                     + '       <COLUMN id="SALECOST" refcolid="SALE_COST_AMT" >'
                     + '           <HEADER left="2630" top="0" right="2730" bottom="60" text="매출원가" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="2630" top="0" right="2730" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'                           
                     + '       </COLUMN>'
        
                     + '       <COLUMN id="LMMC_PROFIT_AMT" refcolid="LM_MC_PROFIT_AMT" >'
                     + '           <HEADER left="2730" top="0" right="2830" bottom="60" text="상품매출이익" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="2730" top="0" right="2830" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'                           
                     + '       </COLUMN>'
                    
                     + '       <COLUMN id="NETSALE_PROFIT_RATE" refcolid="NETSALE_PROFIT_RATE" >'
                     + '           <HEADER left="2830" top="0" right="2930" bottom="60" text="순매출이익율" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="2830" top="0" right="2930" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,###.000"/>'                           
                     + '       </COLUMN>'
                 
                     + '       <COLUMN id="LM_COST_AMT" refcolid="LM_COST_AMT" >'
                     + '           <HEADER left="2930" top="0" right="3030" bottom="60" text="매입원가" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="2930" top="0" right="3030" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'                           
                     + '       </COLUMN>' 
                     
                     
                     + '       <COLUMN id="STKCOSTAMT" refcolid="DW_STK_COST_AMT" >'
                     + '           <HEADER left="3030" top="0" right="3130" bottom="60" text="원가재고" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="3030" top="0" right="3130" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,##0"/>'                           
                     + '       </COLUMN>'

                     
                     + '       <COLUMN id="STKCYCLE_RATE" refcolid="STK_CYCLE_RATE" >'
                     + '           <HEADER left="3130" top="0" right="3230" bottom="60" text="회전율" bgcolor="#eaeef4" borderstyle="Line" bordercolor="#cacaca"/>'
                     + '           <VIEW left="3130" top="0" right="3230" bottom="40" edit="" borderstyle="Line" bordercolor="#cacaca" align="RightCenter" displayformat="#,###.000"/>'                             
                     + '       </COLUMN>'
        
                     + '     </COLUMNINFO>';
                     
    initMGridStyle(GD_MASTER, "common", hdrProperies);
    DS_IO_MASTER.UseChangeInfo = true;           
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
 * 작 성 일 : 2010.06.20
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() { 
    if( LC_O_STR_CD.BindColVal == "" ){
        showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "점");            
        LC_O_STR_CD.Focus();
        return false;
    }else if( EM_O_STK_YM.Text == "" || EM_O_STK_TO_YM.Text == ""){
        showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "기간");            
        EM_O_STK_YM.Focus();
        return false;
    }
    
    DS_IO_MASTER.ClearData();
    
    var strStrCd      = LC_O_STR_CD.BindColVal;
    var strDeptCd     = LC_O_DEPT_CD.BindColVal;
    var strTeamCd     = LC_O_TEAM_CD.BindColVal;
    var strPcCd       = LC_O_PC_CD.BindColVal;   
    var strStkYm      = EM_O_STK_YM.Text;
    var strStkToYm    = EM_O_STK_TO_YM.Text;
    var strYyyy       = EM_O_STK_YM.Text.substring(0, 4)- "1";
    var strStkBfYm    = EM_O_STK_YM.Text - "01";
    var strStkSYm     = EM_O_STK_YM.Text.substring(0, 4) + "01";
   
    if(strStkYm.substring(4, 7)== "01"){
    	strStkBfYm = "000000";
    	strStkSYm  = "000000";
    }    	
    var strBuyFlag    = LC_BUY_FLAG.BindColVal;
    
    setSearchValue2Excel();
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                    +"&strDeptCd="+encodeURIComponent(strDeptCd)
                    +"&strTeamCd="+encodeURIComponent(strTeamCd)
                    +"&strPcCd="+encodeURIComponent(strPcCd)
                    +"&strStkYm="+encodeURIComponent(strStkYm)
                    +"&strStkToYm="+encodeURIComponent(strStkToYm)
                    +"&strStkSYm="+encodeURIComponent(strStkSYm)
                    +"&strStkBfYm="+encodeURIComponent(strStkBfYm)
                    +"&strYyyy="+encodeURIComponent(strYyyy)
                    +"&strBuyFlag="+encodeURIComponent(strBuyFlag);    
    
    TR_MAIN.Action="/dps/pstk306.pt?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    //조회후 결과표시
    setPorcCount("SELECT", GD_MASTER);      
}

/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.06.20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
     
 }
/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.06.20
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {  
    
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.06.20
 * 개    요 : DB에 저장 / 수정 
 * return값 : void
*/
function btn_Save() {    
     
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.06.20
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {	 
	var parameters = "점="+nvl(excelStrCd,'전체')                    
                   + " -팀="+nvl(excelDeptCd,'전체')    
                   + " -파트="+nvl(excelTeamCd,'전체')     
                   + " -PC="+nvl(excelPcCd,'전체')    
                   + " -기간="+nvl(excelStkYm,'전체')
                   + " ~ ="+nvl(excelStkToYm,'전체')
                   + " -매입구분=" +nvl(excelBuyFlag,'전체');
	
    //openExcelM(GD_MASTER, "기간조직별손익명세서", parameters, true );
    openExcelM2(GD_MASTER, "기간조직별손익명세서", parameters, true ,g_strPid );

    GD_MASTER.Focus();
    
}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.06.20
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
	var strStrCd      = LC_O_STR_CD.BindColVal;
	var strDeptCd     = LC_O_DEPT_CD.BindColVal;
	var strTeamCd     = LC_O_TEAM_CD.BindColVal;
	var strPcCd       = LC_O_PC_CD.BindColVal; 
	var strStrNm      = LC_O_STR_CD.Text;
    var strDeptNm     = LC_O_DEPT_CD.Text;
    var strTeamNm     = replaceStr(LC_O_TEAM_CD.Text,"전체","");
    var strPcNm       = replaceStr(LC_O_PC_CD.Text,"전체","");
    var strOrgName    = strStrNm + "/" + strDeptNm + "/" + strTeamNm + "/" + strPcNm;
	var strStkYm      = EM_O_STK_YM.Text;
	var strYyyy       = EM_O_STK_YM.Text.substring(0, 4)- "1";
	var strStkBfYm    = EM_O_STK_YM.Text;
	var strStkSYm     = EM_O_STK_YM.Text.substring(0, 4) + "01";
	
	if(strStkYm.substring(4, 7)== "01"){
		strStkBfYm = "000000";
		strStkSYm  = "000000";
	}		
	   
	setSearchValue2Excel();
   
	var params     = "&strStrCd="+strStrCd
	                +"&strDeptCd="+strDeptCd
	                +"&strTeamCd="+strTeamCd
	                +"&strPcCd="+strPcCd
	                +"&strOrgName="+strOrgName
	                +"&strStkYm="+strStkYm
	                +"&strStkSYm="+strStkSYm
	                +"&strStkBfYm="+strStkBfYm
	                +"&strYyyy="+strYyyy; 
	    
	window.open("/dps/pstk306.pt?goTo=print"+params,"OZREPORT", 1000, 700);
}

/**
 * btn_Conf()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.06.20
 * 개    요 : 확정 처리
 * return값 : void
 */
function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 
 /**
  * setSearchValue2Excel()
  * 작 성 자 : 
  * 작 성 일 : 2010.06.20
  * 개    요 : 엑셀다운시 조회조건 입력을 위한 값 바인드
  * return값 : void
  */
 function setSearchValue2Excel(){
     excelStrCd    = LC_O_STR_CD.Text;
     excelDeptCd   = LC_O_DEPT_CD.Text;
     excelTeamCd   = LC_O_TEAM_CD.Text;
     excelPcCd     = LC_O_PC_CD.Text;
     excelStkYm    = EM_O_STK_YM.Text;
     excelStkToYm  = EM_O_STK_TO_YM.Text;
     excelBuyFlag  = LC_BUY_FLAG.Text;
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
<!--------------------- 3. Excelupload  --------------------------------------->

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_IO_MASTER
    event=OnDataError(row,colid)>
var colName = GD_MASTER.GetHdrDispName(-3, colid);
if( this.ErrorCode == "50018" ) {
    showMessage(STOPSIGN, OK, "GAUCE-1005", colName);
} else if ( this.ErrorCode == "50019") {
    showMessage(STOPSIGN, OK, "GAUCE-1007", row);
} else {
    showMessage(STOPSIGN, OK, "USER-1000", this.ErrorMsg);
}
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 기간From -->
<script language=JavaScript for=EM_O_STK_YM event=onKillFocus()>
    if(!checkDateTypeYM(this))
        return;    
</script>

<!-- 기간To -->
<script language=JavaScript for=EM_O_STK_TO_YM event=onKillFocus()>
    if(!checkDateTypeYM(this))
        return;    
</script>

<script language=JavaScript for=LC_O_STR_CD event=OnSelChange>

    DS_O_DEPT_CD.ClearData();
    DS_O_TEAM_CD.ClearData();
    DS_O_PC_CD.ClearData();
    if (this.BindColVal == '%'){
        insComboData(LC_O_DEPT_CD, "%", "전체", 1);
        setComboData(LC_O_DEPT_CD, "%");
        return;     
    }
    
    getDept("DS_O_DEPT_CD", "Y", LC_O_STR_CD.BindColVal, "Y");
    if(DS_O_DEPT_CD.CountRow < 1){
        insComboData(LC_O_DEPT_CD, "%", "전체", 1);       
    }
    LC_O_DEPT_CD.Index = 0;
    
</script>

<script language=JavaScript for=LC_O_DEPT_CD event=OnSelChange>
    
    DS_O_TEAM_CD.ClearData();
    DS_O_PC_CD.ClearData();
    if (this.BindColVal == '%'){
        insComboData(LC_O_TEAM_CD, "%", "전체", 1);
        setComboData(LC_O_TEAM_CD, "%");
        return;     
    }
    
    getTeam("DS_O_TEAM_CD", "Y", LC_O_STR_CD.BindColVal,
                LC_O_DEPT_CD.BindColVal, "Y");

    if(DS_O_TEAM_CD.CountRow < 1){
        insComboData(LC_O_TEAM_CD, "%", "전체", 1);       
    }
    LC_O_TEAM_CD.Index = 0;
</script>

<script language=JavaScript for=LC_O_TEAM_CD event=OnSelChange>    
    DS_O_PC_CD.ClearData();
    if (this.BindColVal == '%'){    
        insComboData(LC_O_PC_CD, "%", "전체", 1);
        setComboData(LC_O_PC_CD, "%");
        return;     
    }
    
    getPc("DS_O_PC_CD", "Y", LC_O_STR_CD.BindColVal,
                LC_O_DEPT_CD.BindColVal, LC_O_TEAM_CD.BindColVal, "Y");
   
    if(DS_O_PC_CD.CountRow < 1){    	
        insComboData(LC_O_PC_CD, "%", "전체", 1);       
    }   
    LC_O_PC_CD.Index = 0;
</script>

<!-- Grid Master oneClick event 처리 -->
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
<object id="DS_IO_MASTER" classid=<%= Util.CLSID_DATASET %>></object>
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
<object id="DS_O_TAX_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
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
            <th width="80">팀</th>
            <td width="165"><comment id="_NSID_"> <object id=LC_O_DEPT_CD
                classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165 tabindex=1
                align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
            <th width="80">파트</th>
            <td><comment id="_NSID_"> <object id=LC_O_TEAM_CD
                classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=195 tabindex=1
                align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td> 
          </tr>
          <tr>
            <th width="80">PC</th>
            <td><comment id="_NSID_"> <object id=LC_O_PC_CD
                classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165 tabindex=1
                align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
            <th class="point" width="80">년월</th>
            <td colspan="3">
                <comment id="_NSID_">
                      <object id=EM_O_STK_YM classid=<%=Util.CLSID_EMEDIT%>  width=138 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/date.gif" class="PR03" onclick="javascript:openCal('M',EM_O_STK_YM)" align="absmiddle" />
                 ~ <comment id="_NSID_">
                      <object id=EM_O_STK_TO_YM classid=<%=Util.CLSID_EMEDIT%>  width=138 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/date.gif" class="PR03" onclick="javascript:openCal('M',EM_O_STK_TO_YM)" align="absmiddle" />
            </td>            
          </tr>
          <tr>
            <th>매입구분</th> 
            <td colspan="5"><comment id="_NSID_"> <object id=LC_BUY_FLAG
                classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=195 tabindex=1
                align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>                   
          </tr>
      </table></td>
    </tr>
  <tr>
    <td class="dot"></td>
  </tr>
  <tr>
     <td class="PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
            <tr>
                <td>
                    <comment id="_NSID_"> <object 
                  id=GD_MASTER width=100% height=455 classid=<%=Util.CLSID_MGRID%>>
                     <param name="DataID" value="DS_IO_MASTER"> 
                     <Param Name="IndicatorInfo"       value='
                       <INDICATORINFO width="20" fontsize="9" indexnumber="true"/>'>
                     <Param Name="sort"      value="false">
                  </object> </comment><script>_ws_(_NSID_);</script></td>
                </td>
            </tr>
        </table>
     </td>
  </tr>   
</table>
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>

