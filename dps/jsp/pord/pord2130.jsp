<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 발주결재 > 검품현황조회
 * 작 성 일 : 2010.04.08
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : pord2130.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 검품현황조회 
 * 이    력 :
 * 
 ******************************************************************************/
-->

<%@ page language="java" contentType="text/html;charset=utf-8"
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%
    request.setCharacterEncoding("utf-8");
%>
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
var strToday        = "";                            // 현재날짜
var g_searchFlag    = "";                            // 구분에 따른 조회조건 구분값


var intSearchCnt      = 0;
var bfListRowPosition = 0;


var g_excelStrNM      = "";
var g_excelBuMunNM    = "";
var g_excelTeamNM     = "";
var g_excelPcNM       = "";
var g_excelGgDt       = "";
var g_excelStartDt    = "";
var g_excelEndDt      = "";
var g_excelGbn        = "";
var g_excelGbnCd      = "";
var g_excelConfFlag   = "";
var g_excelOrdOwn     = "";
var g_excelSlipFlagNM = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-09
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 530;		//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID

 function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GR_DETAIL1"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	 var obj   = document.getElementById("GR_DETAIL2"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	 var obj   = document.getElementById("GR_DETAIL3"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	 var obj   = document.getElementById("GR_DETAIL4"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	 var obj   = document.getElementById("GR_DETAIL5"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

     // Input  Data Set Header 초기화
     
     strToday        = getTodayDB("DS_O_RESULT")
     // Output Data Set Header 초기화
     DS_LIST.setDataHeader('<gauce:dataset name="H_LIST"/>');     
     DS_DETAIL1.setDataHeader('<gauce:dataset name="H_DETAIL1"/>');
     DS_DETAIL2.setDataHeader('<gauce:dataset name="H_DETAIL2"/>');
     DS_DETAIL3.setDataHeader('<gauce:dataset name="H_DETAIL2"/>');
     
     DS_O_TEAM.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
     DS_O_PC.setDataHeader('CODE:STRING(2),NAME:STRING(40)'); 
     
     // 그리드 초기화
     gridCreate();  //마스터
     gridCreate1(); //디테일(품목)
     gridCreate2(); //디테일(규격 신선 의류)
     gridCreate3(); //디테일(매가인상하)
     gridCreate4(); //디테일(대출)
     gridCreate5(); //디테일(대입)
     
     // EMedit에 초기화  
     initEmEdit(RD_S_FLAG,     "GEN",       NORMAL);      //구분     
     initEmEdit(EM_S_FLAG_CD,  "GEN",       NORMAL);      //구분코드   
     initEmEdit(EM_S_FLAG_NM,  "GEN",       READ);        //구분명   
     initEmEdit(RD_S_CONF_FLAG,"GEN",       NORMAL);      //확정구분     
     initEmEdit(EM_S_START_DT, "SYYYYMMDD", PK);          //조회용 시작일
     initEmEdit(EM_S_END_DT,   "TODAY",     PK);          //조회용 종료일
     
     //콤보 초기화
     initComboStyle(LC_O_STR,    DS_STR,           "CODE^0^30,NAME^0^80", 1, PK);              //조회용 점코드     
     initComboStyle(LC_O_BUMUN,  DS_O_DEPT,        "CODE^0^30,NAME^0^80", 1, NORMAL);          //조회용 팀     
     initComboStyle(LC_O_TEAM,   DS_O_TEAM,        "CODE^0^30,NAME^0^80", 1, NORMAL);          //조회용 파트     
     initComboStyle(LC_O_PC,     DS_O_PC,          "CODE^0^30,NAME^0^80", 1, NORMAL);          //조회용 PC     
     initComboStyle(LC_O_GJDATE, DS_O_GJDATE_TYPE, "CODE^0^30,NAME^0^80", 1, PK);              //조회용 기준일     
     initComboStyle(LC_O_ORD_OWN_FLAG,   DS_O_OWN_FLAG,   "CODE^0^30,NAME^0^80", 1, NORMAL);   //조회용 발주주체 

    getStore("DS_STR", "Y", "", "N");                                                          //점        
    getEtcCode("DS_O_GJDATE_TYPE", "D", "P214", "N");                                          //기준일
    getEtcCode("DS_O_OWN_FLAG",    "D", "P202", "Y");       // 발주주체구분


    LC_O_STR.Index      = 0; 
    LC_O_BUMUN.Index    = 0;
    LC_O_TEAM.Index     = 0;
    LC_O_PC.Index       = 0;  
    LC_O_GJDATE.Index   = 0;
    LC_O_ORD_OWN_FLAG.Index = 0;
    LC_O_STR.Focus();
    CHK_1.checked            = true;
    RD_S_FLAG.CodeValue      = 1;
    RD_S_CONF_FLAG.CodeValue = 1;
    g_searchFlag             = 1;
    controlGrid();

    document.getElementById("detail1").style.display ="";       //품목 그리드를 디포F
    document.getElementById("detail2").style.display ="none";
    document.getElementById("detail3").style.display ="none";
    document.getElementById("detail4").style.display ="none"; 
    
    
    registerUsingDataset("pord213","DS_LIST,DS_DETAIL1,DS_DETAIL2,DS_DETAIL3");
 } 

 
 function gridCreate(){
     var hdrProperies = '<FC>id={currow}           name="NO"          width=30      align=center  sumtext="" </FC>'
                     + '<FC>id=STR_CD              name="점"           width=65     align=center show=false</FC>'
                     + '<FC>id=STR_NM_1            name="점명"         width=65     align=left show=false</FC>'
                     + '<FC>id=ORD_OWN_FLAG_1      name="발주주체"     width=80     edit=none align=left </FC>'
                     + '<FC>id=PUMBUN_CD           name="브랜드1"      width=70     align=center show=false</FC>'
                     + '<FC>id=PUMBUN_NM_1         name="브랜드명1"    width=100    align=left show=false</FC>'
                     + '<FC>id=VEN_CD              name="협력사"       width=65     align=center </FC>'
                     + '<FC>id=VEN_NM_1            name="협력사명"     width=130    align=left </FC>'
                     + '<FC>id=ORD_OWN_FLAG_2      name="발주주체"     width=80     edit=none align=left </FC>'
                     + '<FC>id=PUMBUN_CD_2         name="브랜드1"      width=70     align=center </FC>'
                     + '<FC>id=PUMBUN_NM_2         name="브랜드명1"    width=100    align=left </FC>'
                     + '<C>id=ORD_OWN_FLAG_3       name="발주주체"     width=80     edit=none align=left </C>'
                     + '<C>id=BUYER_CD             name="바이어"       width=65     align=center </C>'
                     + '<C>id=BUYER_NM_1           name="바이어명"     width=100    align=left </C>'
                     + '<C>id=PUMBUN_CD_3          name="브랜드1"      width=70     align=center </C>'
                     + '<C>id=PUMBUN_NM_3          name="브랜드명1"    width=100    align=left </C>'
                     + '<C>id=VEN_CD_2             name="협력사"       width=90     align=center </C>'
                     + '<C>id=VEN_NM_2             name="협력사명"     width=100    align=left </C>'
                     + '<C>id=SLIP_FLAG            name="구분"     width=65     align=center show=false</C>'
                     + '<C>id=SLIP_FLAG_NM         name="구분"     width=65     align=left </C>'
                     + '<C>id=SLIP_NO              name="전표번호"     width=110    align=center mask="XXXX-X-XXXXXXX"</C>'
                     + '<C>id=ORD_DT               name="발주일"       width=80     align=center mask="XXXX/XX/XX"</C>'
                     + '<C>id=CONF_DT              name="발주확정일"   width=80     align=center mask="XXXX/XX/XX"</C>'
                     + '<C>id=DELI_DT              name="납품예정일"   width=80     align=center mask="XXXX/XX/XX"</C>'
                     + '<C>id=CHK_DT               name="검품확정일"   width=80     align=center mask="XXXX/XX/XX"</C>'
                     + '<C>id=MG_RATE              name="마진율"       width=65     align=right show=false</C>'
                     + '<C>id=COST_TAMT            name="원가합계"     width=120    align=right sumtext=@sum</C>'
                     + '<C>id=SALE_TAMT            name="매가합계"     width=120    align=right sumtext=@sum</C>'
                     + '<C>id=SALE_GAP_TAMT        name="매가차액"     width=120    align=right sumtext=@sum</C>'
                     + '<C>id=GAP_TAMT             name="점출차익액"   width=120    align=right sumtext=@sum</C>'
                     + '<C>id=GAP_RATE             name="점출차익율"   width=65     align=right </C>'
                     + '<C>id=BIZ_TYPE             name="거래형태"     width=65     align=center show=false</C>'
                     + '<C>id=BIZ_TYPE_NM          name="거래형태"     width=65     align=left </C>'
                     + '<C>id=TAX_FLAG             name="과세구분"     width=65     align=center show=false</C>'
                     + '<C>id=TAX_FLAG_NM          name="과세구분"     width=65     align=left </C>'
                     + '<C>id=PAY_COND             name="지불구분"     width=65     align=center show=false</C>'
                     + '<C>id=PAY_COND_NM          name="지불구분"     width=65     align=left </C>'
                     + '<C>id=PUMBUN_CD_4          name="브랜드2"      width=70     align=left </C>'
                     + '<C>id=PUMBUN_NM_4          name="브랜드명2"    width=90     align=left </C>'
                     + '<C>id=BUYER_NM_2           name="바이어명"     width=100    align=left </C>'
                     + '<C>id=SLIP_PROC_STAT       name="전표상태"     width=65     align=center show=false</C>'
                     + '<C>id=SLIP_PROC_STAT_NM    name="전표상태"     width=65     align=left </C>'
                     + '<C>id=PAIR_STR_CD          name="상대점"       width=65     align=center show=false</C>'
                     + '<C>id=PAIR_SLIP_NO         name="상대전표"     width=65     align=center show=false</C>'
                     + '<C>id=SKU_FLAG             name="단품구분"     width=65     align=left show=false</C>'
                     + '<C>id=SKU_TYPE             name="단품종류"     width=65     align=left show=false</C>';
     initGridStyle(GR_LIST, "common", hdrProperies, false);
     
     GR_LIST.ViewSummary = "1";      
     DS_LIST.SubSumExpr  = "PUMBUN_CD"; 
     GR_LIST.ColumnProp("PUMBUN_CD", "SubSumText")        = "브랜드소계";  
     GR_LIST.ColumnProp("PUMBUN_CD", "sumtext")           = "합계";  
     GR_LIST.ColumnProp("GAP_RATE",  "SubSumText")        = 0;  
 }

 
 function gridCreateBuyer(){
     var hdrProperies = '<FC>id={currow}           name="NO"           width=30     align=center  sumtext="" </FC>'
                     + '<FC>id=STR_CD              name="점"           width=65     align=center show=false</FC>'
                     + '<FC>id=STR_NM_1            name="점명"         width=65     align=left show=false</FC>'
                     + '<FC>id=ORD_OWN_FLAG_1      name="발주주체"     width=80     edit=none align=left </FC>'
                     + '<FC>id=PUMBUN_CD           name="브랜드1"      width=70     align=center show=false</FC>'
                     + '<FC>id=PUMBUN_NM_1         name="브랜드명1"    width=100    align=left show=false</FC>'
                     + '<FC>id=VEN_CD              name="협력사"       width=65     align=center </FC>'
                     + '<FC>id=VEN_NM_1            name="협력사명"     width=130    align=left </FC>'
                     + '<FC>id=ORD_OWN_FLAG_2      name="발주주체"     width=80     edit=none align=left </FC>'
                     + '<FC>id=PUMBUN_CD_2         name="브랜드1"      width=70     align=center </FC>'
                     + '<FC>id=PUMBUN_NM_2         name="브랜드명1"    width=100    align=left </FC>'
                     + '<FC>id=ORD_OWN_FLAG_3      name="발주주체"     width=80     edit=none align=left </FC>'
                     + '<FC>id=BUYER_CD            name="바이어"       width=65     align=center </FC>'
                     + '<FC>id=BUYER_NM_1          name="바이어명"     width=100    align=left </FC>'
                     + '<FC>id=PUMBUN_CD_3         name="브랜드1"      width=70     align=center </FC>'
                     + '<FC>id=PUMBUN_NM_3         name="브랜드명1"    width=100    align=left </FC>'
                     + '<C>id=VEN_CD_2             name="협력사"       width=90     align=center </C>'
                     + '<C>id=VEN_NM_2             name="협력사명"     width=100    align=left </C>'
                     + '<C>id=SLIP_FLAG            name="구분"     width=65     align=center show=false</C>'
                     + '<C>id=SLIP_FLAG_NM         name="구분"     width=65     align=left </C>'
                     + '<C>id=SLIP_NO              name="전표번호"     width=110    align=center mask="XXXX-X-XXXXXXX"</C>'
                     + '<C>id=ORD_DT               name="발주일"       width=80     align=center mask="XXXX/XX/XX"</C>'
                     + '<C>id=CONF_DT              name="발주확정일"   width=80     align=center mask="XXXX/XX/XX"</C>'
                     + '<C>id=DELI_DT              name="납품예정일"   width=80     align=center mask="XXXX/XX/XX"</C>'
                     + '<C>id=CHK_DT               name="검품확정일"   width=80     align=center mask="XXXX/XX/XX"</C>'
                     + '<C>id=MG_RATE              name="마진율"       width=65     align=right show=false</C>'
                     + '<C>id=COST_TAMT            name="원가합계"     width=120    align=right sumtext=@sum</C>'
                     + '<C>id=SALE_TAMT            name="매가합계"     width=120    align=right sumtext=@sum</C>'
                     + '<C>id=SALE_GAP_TAMT        name="매가차액"     width=120    align=right sumtext=@sum</C>'
                     + '<C>id=GAP_TAMT             name="점출차익액"   width=120    align=right sumtext=@sum</C>'
                     + '<C>id=GAP_RATE             name="점출차익율"   width=65     align=right </C>'
                     + '<C>id=BIZ_TYPE             name="거래형태"     width=65     align=center show=false</C>'
                     + '<C>id=BIZ_TYPE_NM          name="거래형태"     width=65     align=left </C>'
                     + '<C>id=TAX_FLAG             name="과세구분"     width=65     align=center show=false</C>'
                     + '<C>id=TAX_FLAG_NM          name="과세구분"     width=65     align=left </C>'
                     + '<C>id=PAY_COND             name="지불구분"     width=65     align=center show=false</C>'
                     + '<C>id=PAY_COND_NM          name="지불구분"     width=65     align=left </C>'
                     + '<C>id=PUMBUN_CD_4          name="브랜드2"  width=70     align=left </C>'
                     + '<C>id=PUMBUN_NM_4          name="브랜드명2"    width=90     align=left </C>'
                     + '<C>id=BUYER_NM_2           name="바이어명"     width=100    align=left </C>'
                     + '<C>id=SLIP_PROC_STAT       name="전표상태"     width=65     align=center show=false</C>'
                     + '<C>id=SLIP_PROC_STAT_NM    name="전표상태"     width=65     align=left </C>'
                     + '<C>id=PAIR_STR_CD          name="상대점"       width=65     align=center show=false</C>'
                     + '<C>id=PAIR_SLIP_NO         name="상대전표"     width=65     align=center show=false</C>'
                     + '<C>id=SKU_FLAG             name="단품구분"     width=65     align=left show=false</C>'
                     + '<C>id=SKU_TYPE             name="단품종류"     width=65     align=left show=false</C>';
     initGridStyle(GR_LIST, "common", hdrProperies, false);
 }
  
 //품목
 function gridCreate1(){
     var hdrProperies = '<FC>id={currow}            name="NO"          width=30     align=center  sumtext="" </FC>'
                     + '<FC>id=STR_CD               name="점코드"      width=65      align=center show=false</FC>'
                     + '<FC>id=STR_NM               name="점명"        width=65      align=left show=false</FC>'
                     + '<FC>id=SLIP_NO              name="전표번호"      width=110    align=center mask="XXXX-X-XXXXXXX"</FC>'
                     + '<FC>id=ORD_SEQ_NO           name="전표상세번호" width=65     align=left show=false</FC>'
                     + '<FC>id=PUMMOK_SRT_CD        name="단축코드"     width=55     align=center </FC>'
                     + '<FC>id=PUMMOK_CD            name="품목코드"     width=85     align=center </FC>'
                     + '<FC>id=PUMMOK_NM            name="품목명"       width=110     align=left </FC>'
                     + '<FC>id=ORD_UNIT_CD          name="단위코드"     width=65     align=left show=false</FC>'
                     + '<FC>id=ORD_UNIT_NM          name="단위명"       width=65     align=left </FC>'
                     + '<FC>id=ORD_QTY              name="수량"         width=65     align=right </FC>'
                     + '<FC>id=CHK_QTY              name="검품수량"     width=65     align=right </FC>'
                     + '<FC>id=MG_RATE              name="마진율"       width=65     align=right </FC>'
                     + '<FG>  name ="원가"'
                     + '<FC>id=NEW_COST_PRC         name="단가"         width=80     align=right </FC>'
                     + '<FC>id=NEW_COST_AMT         name="금액"         width=120    align=right </FC>'
                     + '</FG>'
                     + '<FG>  name ="매가"'
                     + '<FC>id=NEW_SALE_PRC         name="단가"         width=80     align=right </FC>'
                     + '<FC>id=NEW_SALE_AMT         name="금액"         width=120     align=right </FC>'
                     + '</FG>';

     initGridStyle(GR_DETAIL1, "common", hdrProperies, false);
 }
  

 //규격발주
 function gridCreate2(){
     var hdrProperies = '<FC>id={currow}            name="NO"          width=30     align=center  sumtext="" </FC>'
                     + '<FC>id=STR_CD               name="점코드"      width=65      align=left show=false</FC>'
                     + '<FC>id=STR_NM               name="점명"        width=65      align=left show=false</FC>'
                     + '<FC>id=SLIP_NO              name="전표번호"     width=110    align=center mask="XXXX-X-XXXXXXX"</FC>'
                     + '<FC>id=ORD_SEQ_NO           name="전표상세번호" width=65     align=left show=false</FC>'
                     + '<FC>id=SKU_CD               name="단품코드"     width=110     align=center </FC>'
                     + '<FC>id=SKU_NM               name="단품명"       width=130     align=left </FC>'
                     + '<FC>id=STYLE_CD             name="스타일"       width=100     align=center </FC>'
                     + '<FC>id=COLOR_CD             name="칼라"         width=65     align=center </FC>'
                     + '<FC>id=SIZE_CD              name="사이즈"       width=65     align=center </FC>'
                     + '<FC>id=ORD_UNIT_CD          name="단위코드"     width=65     align=left show=false</FC>'
                     + '<FC>id=ORD_UNIT_NM          name="단위명"       width=65     align=left </FC>'
                     + '<FC>id=ORD_QTY              name="수량"         width=65     align=right </FC>'
                     + '<FC>id=CHK_QTY              name="검품수량"     width=65     align=right </FC>'
                     + '<FC>id=RATE                 name="목표;이익율"   width=90     align=right </FC>'
                     + '<FG>  name ="원가"'
                     + '<FC>id=NEW_COST_PRC         name="단가"         width=80     align=right </FC>'
                     + '<FC>id=NEW_COST_AMT         name="금액"         width=120     align=right </FC>'
                     + '</FG>'
                     + '<FG>  name ="매가"'
                     + '<FC>id=NEW_SALE_PRC         name="단가"         width=80     align=right </FC>'
                     + '<FC>id=NEW_SALE_AMT         name="금액"         width=120     align=right </FC>'
                     + '</FG>'
                     + '<FC>id=NEW_GAP_RATE         name="차익율"       width=65     align=right </FC>';         
      initGridStyle(GR_DETAIL2, "common", hdrProperies, false);
 }
  

 //매가인상하
 function gridCreate3(){
     var hdrProperies = '<FC>id={currow}            name="NO"          width=30     align=center  sumtext="" </FC>'
                     + '<FC>id=STR_CD               name="점코드"      width=65      align=left show=false</FC>'
                     + '<FC>id=STR_NM               name="점명"        width=65      align=left show=false</FC>'
                     + '<FC>id=SLIP_NO              name="전표번호"     width=110    align=center mask="XXXX-X-XXXXXXX"</FC>'
                     + '<FC>id=ORD_SEQ_NO           name="전표상세번호" width=65     align=left show=false</FC>'
                     + '<FC>id=SKU_CD               name="단품코드"     width=110     align=center </FC>'
                     + '<FC>id=SKU_NM               name="단품명"       width=130     align=left </FC>'
                     + '<FC>id=STYLE_CD             name="스타일"       width=100     align=center </FC>'
                     + '<FC>id=COLOR_CD             name="칼라"         width=65     align=center </FC>'
                     + '<FC>id=SIZE_CD              name="사이즈"       width=65     align=center </FC>'
                     + '<FC>id=ORD_UNIT_CD          name="단위코드"     width=65     align=left show=false</FC>'
                     + '<FC>id=ORD_UNIT_NM          name="단위명"       width=65     align=left </FC>'
                     + '<FC>id=ORD_QTY              name="수량"         width=65     align=right </FC>'
                     + '<FC>id=CHK_QTY              name="검품수량"     width=65     align=right </FC>'
                     + '<FG>  name ="구매가"'
                     + '<FC>id=OLD_SALE_PRC         name="단가"         width=80     align=right </FC>'
                     + '<FC>id=OLD_SALE_AMT         name="금액"         width=120     align=right </FC>'
                     + '</FG>'
                     + '<FG>  name ="신매가"'
                     + '<FC>id=N_NEW_SALE_PRC       name="단가"         width=80     align=right </FC>'
                     + '<FC>id=N_NEW_SALE_AMT       name="금액"         width=120     align=right </FC>'
                     + '</FG>'
                     + '<FC>id=NEW_GAP_AMT          name="차익액"       width=65     align=right </FC>';      
     initGridStyle(GR_DETAIL3, "common", hdrProperies, false);
 }
  

 //대출
 function gridCreate4(){
     var hdrProperies = '<FC>id={currow}            name="NO"          width=30     align=center  sumtext="" </FC>'
                     + '<FC>id=STR_CD               name="점코드"      width=65      align=left show=false</FC>'
                     + '<FC>id=STR_NM               name="점명"        width=65      align=left show=false</FC>'
                     + '<FC>id=SLIP_NO              name="전표번호"     width=110    align=center mask="XXXX-X-XXXXXXX"</FC>'
                     + '<FC>id=ORD_SEQ_NO           name="전표상세번호" width=65     align=left show=false</FC>'
                     + '<FC>id=PUMMOK_CD            name="품목코드"     width=85     align=center show=false</FC>'
                     + '<FC>id=PUMMOK_NM            name="품목명"       width=65     align=left show=false</FC>'
                     + '<FC>id=SKU_CD               name="단품코드"     width=110     align=center </FC>'
                     + '<FC>id=SKU_NM               name="단품명"       width=130     align=left </FC>'
                     + '<FC>id=STYLE_CD             name="스타일"       width=100     align=center </FC>'
                     + '<FC>id=COLOR_CD             name="칼라"         width=65     align=center </FC>'
                     + '<FC>id=SIZE_CD              name="사이즈"       width=65     align=center </FC>'
                     + '<FC>id=ORD_UNIT_CD          name="단위코드"     width=65     align=left show=false</FC>'
                     + '<FC>id=ORD_UNIT_NM          name="단위명"       width=65     align=left </FC>'
                     + '<FC>id=ORD_QTY              name="수량"         width=65     align=right </FC>'
                     + '<FC>id=CHK_QTY              name="검품수량"     width=65     align=right </FC>'
                     + '<FC>id=RATE                 name="목표;이익율"   width=90     align=right </FC>'
                     + '<FG>  name ="원가"'
                     + '<FC>id=NEW_COST_PRC         name="단가"         width=80     align=right </FC>'
                     + '<FC>id=NEW_COST_AMT         name="금액"         width=120     align=right </FC>'
                     + '</FG>'
                     + '<FG>  name ="매가"'
                     + '<FC>id=NEW_SALE_PRC         name="단가"         width=80     align=right </FC>'
                     + '<FC>id=NEW_SALE_AMT         name="금액"         width=120    align=right </FC>'
                     + '</FG>'
                     + '<FC>id=NEW_GAP_RATE         name="차익율"       width=65     align=right </FC>';            
                 initGridStyle(GR_DETAIL4, "common", hdrProperies, false);
 }

 //대입
 function gridCreate5(){
    var hdrProperies = '<FC>id={currow}            name="NO"          width=30     align=center  sumtext="" </FC>'
                     + '<FC>id=STR_CD               name="점코드"      width=65      align=left show=false</FC>'
                     + '<FC>id=STR_NM               name="점명"        width=65      align=left show=false</FC>'
                     + '<FC>id=SLIP_NO              name="전표번호"     width=110    align=center mask="XXXX-X-XXXXXXX"</FC>'
                     + '<FC>id=ORD_SEQ_NO           name="전표상세번호" width=65     align=left show=false</FC>'
                     + '<FC>id=PUMMOK_CD            name="품목코드"     width=85     align=left show=false</FC>'
                     + '<FC>id=PUMMOK_NM            name="품목명"       width=65     align=left show=false</FC>'
                     + '<FC>id=SKU_CD               name="단품코드"     width=110     align=center </FC>'
                     + '<FC>id=SKU_NM               name="단품명"       width=130     align=left </FC>'
                     + '<FC>id=STYLE_CD             name="스타일"       width=100     align=center </FC>'
                     + '<FC>id=COLOR_CD             name="칼라"         width=65     align=center </FC>'
                     + '<FC>id=SIZE_CD              name="사이즈"       width=65     align=center </FC>'
                     + '<FC>id=ORD_UNIT_CD          name="단위코드"     width=65     align=left show=false</FC>'
                     + '<FC>id=ORD_UNIT_NM          name="단위명"       width=65     align=left </FC>'
                     + '<FC>id=ORD_QTY              name="수량"         width=65     align=right </FC>'
                     + '<FC>id=CHK_QTY              name="검품수량"     width=65     align=right </FC>'
                     + '<FC>id=RATE                 name="목표;이익율"   width=90     align=right </FC>'
                     + '<FG>  name ="원가"'
                     + '<FC>id=NEW_COST_PRC         name="단가"         width=80     align=right </FC>'
                     + '<FC>id=NEW_COST_AMT         name="금액"         width=120     align=right </FC>'
                     + '</FG>'
                     + '<FG>  name ="매가"'
                     + '<FC>id=NEW_SALE_PRC         name="단가"         width=80     align=right </FC>'
                     + '<FC>id=NEW_SALE_AMT         name="금액"         width=120     align=right </FC>'
                     + '</FG>'
                     + '<FC>id=NEW_GAP_RATE         name="차익율"       width=65     align=right </FC>';    

     initGridStyle(GR_DETAIL5, "common", hdrProperies, false);
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
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-10
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    
     if(checkValidation("Search")){
         
         DS_DETAIL1.ClearData();
         DS_DETAIL2.ClearData();
         DS_DETAIL3.ClearData();
         
         setOutPutValue();  //엑셀출력시 조회조건세팅
         intSearchCnt = 0;
         bfListRowPosition = 0;
         controlGrid();
         getList();
/*
         if(g_searchFlag == 1){
             sortColId( eval(GR_LIST.DataID), 0, "PUMBUN_CD");
         }else if(g_searchFlag == 2){
             sortColId( eval(GR_LIST.DataID), 0, "BUYER_CD");
         }else if(g_searchFlag == 3){
             sortColId( eval(GR_LIST.DataID), 0, "VEN_CD");
         }
*/
//         
         // 조회결과 Return
         setPorcCount("SELECT", GR_LIST);
         if(DS_LIST.CountRow <= 0)
             LC_O_STR.Focus();
     }
}

/**
 * btn_New()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-10
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {  
    
}

/**
 * btn_Delete()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-10
 * 개    요    : 삭제버튼 클릭 (신규등록일 경우 DS_IO_MASTER 삭제, 기존데이터일 경우 삭제 Action실행)
 * return값 : void
 */
function btn_Delete() {
    
}

/**
 * btn_Save()
 * 작 성 자 : 박래형
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
     
    var ExcelTitle = "검품현황조회"  
    
    var parameters = "점="          +g_excelStrNM
                   + " - 팀="     +g_excelBuMunNM
                   + " - 파트="       +g_excelTeamNM
                   + " - PC="       +g_excelPcNM
                   + " - 기준일="    +g_excelGgDt
                   + " - 조회기간="  +g_excelStartDt + "~" + g_excelEndDt
                   + " - 구분="      +g_excelGbn
                   + " - " + g_excelGbn + "코드=" + g_excelGbnCd
                   + " - 확정구분="  +g_excelConfFlag
                   + " - 발주주체="  +g_excelOrdOwn
                   + " - 전표구분="  +g_excelSlipFlagNM;
    
    //openExcel2(GR_LIST, ExcelTitle, parameters, true );
    openExcel5(GR_LIST, ExcelTitle, parameters, true , "",g_strPid );

    GR_LIST.Focus();
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
 * getList()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-15
 * 개    요 :  마스터 리스트 조회
 * return값 : void
 */
 function getList(){

    // 조회조건 셋팅
    var strStrCd         = LC_O_STR.BindColVal;        //점
    var strBumun         = LC_O_BUMUN.BindColVal;      //팀
    var strTeam          = LC_O_TEAM.BindColVal;       //파트
    var strPc            = LC_O_PC.BindColVal;    
    var strOrgCd         = strStrCd + strBumun + strTeam + strPc; // 조직//PC
    var strGiJunDtType   = LC_O_GJDATE.BindColVal;     //기준일
    var strStartDt       = EM_S_START_DT.Text;         //시작일
    var strEndDt         = EM_S_END_DT.Text;           //종료일
    var strSearchFlag    = g_searchFlag;
    var strFlag          = EM_S_FLAG_CD.Text;          //구분에 따른 조회조건
    var strConfFlag      = RD_S_CONF_FLAG.CodeValue;
    var strOrdOwnFlag   = LC_O_ORD_OWN_FLAG.BindColVal;
    
    strOrgCd   = replaceStr(strOrgCd,"%","00")+"00";
    
    var slipFlagList = setSlipFlag();   
    if(!slipFlagList){ 
        return;
    }
    
    var goTo        = "getList" ;    
    var action      = "O";     
    var parameters  = "&strStrCd="+encodeURIComponent(strStrCd)     
                    + "&strBumun="+encodeURIComponent(strBumun)     
                    + "&strTeam="+encodeURIComponent(strTeam)     
                    + "&strPc="+encodeURIComponent(strPc)        
                    + "&strOrgCd="+encodeURIComponent(strOrgCd)        
                    + "&strGiJunDtType="+encodeURIComponent(strGiJunDtType)
                    + "&strStartDt="+encodeURIComponent(strStartDt)   
                    + "&strEndDt="+encodeURIComponent(strEndDt)   
                    + "&slipFlagList="+encodeURIComponent(slipFlagList)
                    + "&strSearchFlag="+encodeURIComponent(strSearchFlag)
                    + "&strFlag="+encodeURIComponent(strFlag)
                    + "&strConfFlag="+encodeURIComponent(strConfFlag)
                    + "&strOrdOwnFlag="+encodeURIComponent(strOrdOwnFlag); 
    TR_MAIN.Action="/dps/pord213.po?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_LIST=DS_LIST)"; //조회는 O
    TR_MAIN.Post();        
 }
        
 
 /**
 * getDetail1()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-04-13
 * 개    요 :  디테일  조회(매입,반품,점출입,매가인상하)
 * return값 : void
 */
 function getDetail1(){

    var strStrCd    = DS_LIST.NameValue(DS_LIST.RowPosition, "STR_CD");
    var strSlip     = DS_LIST.NameValue(DS_LIST.RowPosition, "SLIP_NO");
    var strSlipFlag = DS_LIST.NameValue(DS_LIST.RowPosition, "SLIP_FLAG");

//    alert(strStrCd);
//    alert(strSlip);
//    alert(strSlipFlag);
  
    var goTo        = "getDetail1";    
    var action      = "O";     
    var parameters  = "&strStrCd="+encodeURIComponent(strStrCd)     
                    + "&strSlip="+encodeURIComponent(strSlip)     
                    + "&strSlipFlag="+encodeURIComponent(strSlipFlag);  
    TR_S_MAIN.Action="/dps/pord213.po?goTo="+goTo+parameters;  
    TR_S_MAIN.KeyValue="SERVLET("+action+":DS_DETAIL1=DS_DETAIL1)"; //조회는 O
    TR_S_MAIN.Post();     
 }
 
 

 /**
 * getDetail2()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-04-13
 * 개    요 :  대출입
 * return값 : void
 */
 function getDetail2(){
    var strStrCd    = DS_LIST.NameValue(DS_LIST.RowPosition,"STR_CD");
    var strSlipNo   = "";
    var strPSlipNo  = "";
    var strSlipFlag = DS_LIST.NameValue(DS_LIST.RowPosition,"SLIP_FLAG");
    
    if(strSlipFlag == 'C'){
        strSlipNo  = DS_LIST.NameValue(DS_LIST.RowPosition,"SLIP_NO");
        strPSlipNo = DS_LIST.NameValue(DS_LIST.RowPosition,"PAIR_SLIP_NO");
    }else{
        strSlipNo  = DS_LIST.NameValue(DS_LIST.RowPosition,"PAIR_SLIP_NO");
        strPSlipNo = DS_LIST.NameValue(DS_LIST.RowPosition,"SLIP_NO");
    }
    
//    alert("strSlipNo = " + strSlipNo);
//    alert("strPSlipNo = " + strPSlipNo);
    
    var goTo       = "getDetail2" ;    
    var action     = "O";     
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                     + "&strSlipNo="+encodeURIComponent(strSlipNo)
                     + "&strPSlipNo="+encodeURIComponent(strPSlipNo)
                     + "&strSlipFlag="+encodeURIComponent(strSlipFlag);
    
    TR_S_MAIN.Action="/dps/pord213.po?goTo="+goTo+parameters;  
    TR_S_MAIN.KeyValue="SERVLET("+action+":DS_DETAIL2=DS_DETAIL2,"+action+":DS_DETAIL3=DS_DETAIL3)"; //조회는 O
    TR_S_MAIN.Post();
 }
 
 

 /**
  * setSlipFlag()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-04-08
  * 개    요 :  전표구분에 따른 조회조건 셋팅
  * return값 : 조회조건 문자열로 리턴
  */
 function setSlipFlag(){

     var strSlipIssueCnt = "SLP.SLIP_FLAG IN (";
     
     if(CHK_1.checked){
         strSlipIssueCnt += "'A','B','C','D','E','F','G')";
     }else{      
         if(CHK_2.checked){
             strSlipIssueCnt += "'A'," ;
         } 
         
         if(CHK_3.checked){
             strSlipIssueCnt += "'B'," ;             
         }
         
         if(CHK_4.checked){
             strSlipIssueCnt += "'C','D'," ;             
         }
         
         if(CHK_5.checked){
             strSlipIssueCnt += "'E','F'," ;             
         }
                  
         if(CHK_6.checked){
             strSlipIssueCnt += "'G'," ;             
         }
         strSlipIssueCnt = strSlipIssueCnt.substring(0, strSlipIssueCnt.length-1);
         strSlipIssueCnt += ")";
     }     
         
     if(CHK_1.checked == false && CHK_2.checked == false && CHK_3.checked == false 
     && CHK_4.checked == false && CHK_5.checked == false && CHK_6.checked == false){    
//       alert();
         showMessage(StopSign, OK, "GAUCE-1005", "전표구분");
         CHK_1.checked  = true;
//       var obj = document.getElementById("CHK_1");         
//       setTimeout("obj.Focus()",50);
         
         DS_LIST.ClearData();
         return false;
     }              
     return strSlipIssueCnt;
 }
 
 

 /**
  * checkSlipFlag()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-04-08
  * 개    요 :  전표구분 선택시 체크 
  * return값 : 조회조건 문자열로 리턴
  */
 function checkSlipFlag (checkId){
      
     if(checkId == CHK_1){
         CHK_1.checked = true;
         CHK_2.checked = false;
         CHK_3.checked = false;
         CHK_4.checked = false;
         CHK_5.checked = false;
         CHK_6.checked = false;
     }else{
         CHK_1.checked = false;
     }
 }



 /**
  * setOutPutValue(Gubun)
  * 작 성 자     : 박래형
  * 작 성 일     : 2010-07-22
  * 개    요        : 조회를 누르는 시점에서 출력할 데이터의 조회조건을 넘긴다.
  * return값 : void
  */
 function setOutPutValue() {
     // 조회조건 명 (장표에서 화면구성)    
     var disPlayStrNM      = LC_O_STR.Text;             // 점명
     var disPlayBuMunNM    = LC_O_BUMUN.Text;           // 팀명
     var disPlayTeamNM     = LC_O_TEAM.Text;            // 파트명
     var disPlayPcNM       = LC_O_PC.Text;              // PC명    
     var disPlayGgDt       = LC_O_GJDATE.Text;          // 기준일    
     var disPlayStartDt    = EM_S_START_DT.Text;        // 시작일    
     var disPlayEndDt      = EM_S_END_DT.Text;          // 종료일    
     var disPlayGbn        = null;                      // 구분     
     var disPlayGbnCd      = nvl(EM_S_FLAG_CD.Text,'전체');         // 구분코드
     var disPlayConfFlag   = null;                      // 확정구분     
     var disPlayOrdOwn     = LC_O_ORD_OWN_FLAG.Text;    // 발주주체    
     var disPlaySlipFlagNM = "";                        // 전표구분명A

     //확정구분
     if(RD_S_CONF_FLAG.CodeValue == "1"){
    	 disPlayConfFlag = "전체";
         
     }else if(RD_S_CONF_FLAG.CodeValue == "2"){
    	 disPlayConfFlag = "확정";
         
     }else if(RD_S_CONF_FLAG.CodeValue == "3"){
    	 disPlayConfFlag = "미확정";
     }
     
     //브랜드,바이어,협력사에 따른 구분
     if(RD_S_FLAG.CodeValue == "1"){
         disPlayGbn = "브랜드";
         
     }else if(RD_S_FLAG.CodeValue == "2"){
         disPlayGbn = "바이어";
         
     }else if(RD_S_FLAG.CodeValue == "3"){
         disPlayGbn = "협력사";
     }
     
     //전표 구분에 따른 전표구분명셋팅
     if(CHK_1.checked){
         disPlaySlipFlagNM += "매입, 반품, 대출입, 점출입, 매가인상하";
     }else{      
         if(CHK_2.checked){
             disPlaySlipFlagNM += "매입, " ;
         }         
         if(CHK_3.checked){
             disPlaySlipFlagNM += "반품, " ;             
         }        
         if(CHK_4.checked){
             disPlaySlipFlagNM += "대출입, " ;             
         }        
         if(CHK_5.checked){
             disPlaySlipFlagNM += "점출입, " ;             
         }                 
         if(CHK_6.checked){
             disPlaySlipFlagNM += "매가인상하, " ;             
         }
         disPlaySlipFlagNM = disPlaySlipFlagNM.substring(0, disPlaySlipFlagNM.length-2);
     }
     
     g_excelStrNM       = disPlayStrNM;
     g_excelBuMunNM     = disPlayBuMunNM;    
     g_excelTeamNM      = disPlayTeamNM;      
     g_excelPcNM        = disPlayPcNM;        
     g_excelGgDt        = disPlayGgDt;        
     g_excelStartDt     = disPlayStartDt;        
     g_excelEndDt       = disPlayEndDt;         
     g_excelGbn         = disPlayGbn;         
     g_excelGbnCd       = disPlayGbnCd;       
     g_excelConfFlag    = disPlayConfFlag;       
     g_excelOrdOwn      = disPlayOrdOwn;       
     g_excelSlipFlagNM  = disPlaySlipFlagNM; 
 }
 
 
        

/**
 * checkValidation(Gubun)
 * 작 성 자     : 박래형
 * 작 성 일     : 2010-02-28
 * 개    요        : 조회조건 값 체크 
 * Gubun : Search, Save, Delete
 * return값 : void
 */
function checkValidation(Gubun) {
     
     var messageCode = "USER-1001";

     switch (Gubun) {
     case "Search": 
         if(LC_O_STR.Text.length == 0){                                         // 점
               showMessage(INFORMATION, OK, messageCode, "점");
               LC_O_STR.Focus();
               return false;
         }  
         /*
         if(LC_O_BUMUN.Text.length == 0){                                       // 팀
             showMessage(INFORMATION, OK, messageCode, "팀");
             LC_O_BUMUN.Focus();
             return false;
         }  
         if(LC_O_TEAM.Text.length == 0){                                        // 파트
             showMessage(INFORMATION, OK, messageCode, "파트");
             LC_O_TEAM.Focus();
             return false;
         }  
         if(LC_O_PC.Text.length == 0){                                          // PC
             showMessage(INFORMATION, OK, messageCode, "PC");
             LC_O_PC.Focus();
             return false;
         }  
         */
         if(LC_O_GJDATE.Text.length == 0){                                      // 기준일
             showMessage(INFORMATION, OK, messageCode, "기준일");
             LC_O_GJDATE.Focus();
             return false;
         }

         if(EM_S_START_DT.Text.length == 0){                                    // 조회일 정합성
             showMessage(INFORMATION, OK, "USER-1002", "조회시작일");
             EM_S_START_DT.Focus();
             return false;
        }
         if(EM_S_END_DT.Text.length == 0){                                      // 조회일 정합성
             showMessage(INFORMATION, OK, "USER-1002", "조회종료일");
             EM_S_END_DT.Focus();
             return false;
        }
         if(EM_S_START_DT.Text > EM_S_END_DT.Text){                             // 조회일 정합성
             showMessage(INFORMATION, OK, "USER-1015");
             EM_S_START_DT.Focus();
             return false;
         }
         return true; 
     }     
}




/**
 * searchPumbunPop()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-04-12
 * 개    요 :  조회조건 브랜드팝업
 * return값 : void
 */
 function searchPumbunPop(){
     var tmpOrgCd        = LC_O_STR.BindColVal + LC_O_BUMUN.BindColVal + LC_O_TEAM.BindColVal + LC_O_PC.BindColVal;
     var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
     var strStrCd        = LC_O_STR.BindColVal;                                       // 점
     var strOrgCd        = replaceStr(tmpOrgCd,"%","00")+"00";                        // 조직코드
     var strVenCd        = "";                                                        // 협력사
     var strBuyerCd      = "";                                                        // 바이어
     var strPumbunType   = "";                                                       // 브랜드유형
     var strUseYn        = "Y";                                                       // 사용여부
     var strSkuFlag      = "";                                                        // 단품구분(2:비단품)
     var strSkuType      = "";                                                        // 단품종류(1:규격단품)
     var strItgOrdFlag   = "";                                                        // 통합발주여부
     var strBizType      = "";                                                        // 거래형태(1:직매입) 
     var strSaleBuyFlag  = "";                                                        // 판매분매입구분
     
     var rtnMap = strPbnPop( EM_S_FLAG_CD, EM_S_FLAG_NM, 'Y'
                            , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                            , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                            , strBizType,strSaleBuyFlag);
     if(rtnMap != null){
         return true;
     }else
         return false;
 }

 

 
 /**
  * getBuyerInfo()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-18
  * 개    요 :  바이어 팝업
  * return값 : void
  */
 function getBuyerInfo(){
     var tmpOrgFlag      = '<c:out value="${sessionScope.sessionInfo.ORG_FLAG}" />'; // 세션 조직구분  
     var tmpOrgCd        = LC_O_STR.BindColVal + LC_O_BUMUN.BindColVal + LC_O_TEAM.BindColVal + LC_O_PC.BindColVal;
     var strOrgCd        = replaceStr(tmpOrgCd,"%","00")+"00";                        // 조직코드

     var rtnMap = buyerPop( EM_S_FLAG_CD, EM_S_FLAG_NM , 'Y', '', tmpOrgFlag, strOrgCd, '1', 'Y','');
     
     if(rtnMap != null){
         return true;
     }else
         return false;
 }
 

 
 /**
  * getVenInfo(code, name)
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-18
  * 개    요 :  협력사 팝업
  * return값 : void
  */
 function getVenInfo(){
     var strStrCd        = LC_O_STR.BindColVal;                                       // 점
     var strUseYn        = "Y";                                                       // 사용여부
     var strPumBunType   = "";                                                       // 브랜드유형(0:정상)
     var strBizType      = "";                                                        // 거래형태
     var strMcMiGbn      = "1";                                                       // 매출처/매입처구분
     var strBizFlag      = "";                                                        // 거래구분       

     var rtnMap = venPop(EM_S_FLAG_CD, EM_S_FLAG_NM
                          ,strStrCd,strUseYn,strPumBunType,strBizType,strMcMiGbn
                          ,strBizFlag);
     if(rtnMap != null){
         return true;
     }else
         return false;
 }
 
 

 /**
  * searchPumbunNonPop()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-27
  * 개    요 :  조회조건 브랜드팝업
  * return값 : void
  */
  function searchPumbunNonPop(){   
      var tmpOrgCd        = LC_O_STR.BindColVal + LC_O_BUMUN.BindColVal + LC_O_TEAM.BindColVal + LC_O_PC.BindColVal;
      var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
      var strStrCd        = LC_O_STR.BindColVal;                                       // 점
      var strOrgCd        = replaceStr(tmpOrgCd,"%","00")+"00";                        // 조직코드
      var strVenCd        = "";                                                        // 협력사
      var strBuyerCd      = "";                                                        // 바이어
      var strPumbunType   = "";                                                       // 브랜드유형
      var strUseYn        = "Y";                                                       // 사용여부
      var strSkuFlag      = "";                                                       // 단품구분(2:비단품)
      var strSkuType      = "";                                                        // 단품종류(1:규격단품)
      var strItgOrdFlag   = "";                                                        // 통합발주여부
      var strBizType      = "";                                                       // 거래형태(1:직매입) 
      var strSaleBuyFlag  = "";                                                       // 판매분매입구분

      var rtnMap =  setStrPbnNmWithoutPop( "DS_O_RESULT", EM_S_FLAG_CD, EM_S_FLAG_NM, "Y", "1"
                                , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                                , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                                , strBizType,strSaleBuyFlag);       
      if(rtnMap != null){
//        EM_S_FLAG_CD.Text = rtnMap.get("PUMBUN_CD");
//        EM_S_FLAG_NM.Text = rtnMap.get("PUMBUN_NAME");
          return true;
      }else{
          return false;
      }       
  }


  
  /**
   * getBuyerNonInfo()
   * 작 성 자 : 박래형
   * 작 성 일 : 2010-03-18
   * 개    요 :  바이어 팝업
   * return값 : void
   */
  function getBuyerNonInfo(){
      var tmpOrgFlag      = '<c:out value="${sessionScope.sessionInfo.ORG_FLAG}" />'; // 세션 조직구분  
      var tmpOrgCd        = LC_O_STR.BindColVal + LC_O_BUMUN.BindColVal + LC_O_TEAM.BindColVal + LC_O_PC.BindColVal;
      var strOrgCd        = replaceStr(tmpOrgCd,"%","00")+"00";                        // 조직코드

      var rtnMap = setBuyerNmWithoutPop( "DS_O_RESULT",EM_S_FLAG_CD, EM_S_FLAG_NM , 'Y', '1', '', tmpOrgFlag, strOrgCd, '1', 'Y','');
      
      if(rtnMap != null){
//          EM_S_FLAG_CD.Text = rtnMap.get("BUYER_CD");
//          EM_S_FLAG_NM.Text = rtnMap.get("BUYER_NAME");
          return true;
      }else
          return false;
  }
  
  
  /**
   * getVenNonInfo(code, name)
   * 작 성 자 : 박래형
   * 작 성 일 : 2010-03-18
   * 개    요 :  브랜드에 따른 협력사 팝업
   * return값 : void
   */
  function getVenNonInfo(){
      var strStrCd        = LC_O_STR.BindColVal;                                       // 점
      var strUseYn        = "Y";                                                       // 사용여부
      var strPumBunType   = "";                                                       // 브랜드유형(0:정상)
      var strBizType      = "";                                                        // 거래형태
      var strMcMiGbn      = "1";                                                       // 매출처/매입처구분
      var strBizFlag      = "";                                                        // 거래구분
      
      var rtnMap = setVenNmWithoutPop( "DS_O_RESULT", EM_S_FLAG_CD, EM_S_FLAG_NM, "1"
                                          ,strStrCd,strUseYn,strPumBunType,strBizType,strMcMiGbn
                                          ,strBizFlag);
      if(rtnMap != null){
//        EM_S_FLAG_CD.Text = rtnMap.get("VEN_CD");
//        EM_S_FLAG_NM.Text = rtnMap.get("VEN_NAME");
          return true;
      }else{
          return false;
      }   
  }
  
  

 
 /**
  * callPopupForFlag()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-04-12
  * 개    요 :  조회조건에 따른 팝업 분기
  * return값 : void
  */
  function callPopupForFlag(){
      if(g_searchFlag == 1){
          searchPumbunPop();          //브랜드 팝업
      }else if(g_searchFlag == 2){
          getBuyerInfo();             //바이어 팝업
      }else if(g_searchFlag == 3){
          getVenInfo();               //협력사 팝업
      }
  }
 

  /**
   * controlGrid()
   * 작 성 자 : 박래형
   * 작 성 일 : 2010-04-13
   * 개    요 :  조회조건에 따른 조회조건및 그리드 셋팅
   * return값 : void
   */
  function controlGrid(){    
       
      if(g_searchFlag == 1){          //브랜드기준
          gridCreate();
          GR_LIST.ColumnProp("ORD_OWN_FLAG_1","show") = true;
          GR_LIST.ColumnProp("PUMBUN_CD",   "show")   = true;
          GR_LIST.ColumnProp("VEN_CD",      "show")   = true;
          GR_LIST.ColumnProp("VEN_NM_1",    "show")   = true;

          GR_LIST.ColumnProp("BUYER_CD",    "show")   = true;
          GR_LIST.ColumnProp("BUYER_NM_1",  "show")   = true;
          GR_LIST.ColumnProp("PUMBUN_NM_1", "show")   = true;

          GR_LIST.ColumnProp("ORD_OWN_FLAG_2","show") = false;
          GR_LIST.ColumnProp("ORD_OWN_FLAG_3","show") = false;
          GR_LIST.ColumnProp("PUMBUN_CD_2", "show")   = false;
          GR_LIST.ColumnProp("PUMBUN_NM_2", "show")   = false;
          GR_LIST.ColumnProp("PUMBUN_CD_3", "show")   = false;
          GR_LIST.ColumnProp("PUMBUN_NM_3", "show")   = false;
          GR_LIST.ColumnProp("VEN_CD_2",    "show")   = false;
          GR_LIST.ColumnProp("VEN_NM_2",    "show")   = false;
          GR_LIST.ColumnProp("BUYER_NM_2",  "show")   = false; 
          
          DS_LIST.SubSumExpr  = "PUMBUN_CD";      
          GR_LIST.ColumnProp("PUMBUN_CD", "sumtext")           = "합계";  
          GR_LIST.ColumnProp("BUYER_CD",  "sumtext")           = "";  
          GR_LIST.ColumnProp("VEN_CD",    "sumtext")           = "";  
          GR_LIST.ColumnProp("PUMBUN_CD", "SubSumText")        = "브랜드소계";
          GR_LIST.ColumnProp("VEN_CD",    "SubSumText")        = "";  
          GR_LIST.ColumnProp("BUYER_CD",  "SubSumText")        = "";  
          GR_LIST.ColumnProp("GAP_RATE",  "SubSumText")        = " ";  

//          sortColId( eval(GR_LIST.DataID), 0, "PUMBUN_CD");
          
      }else if(g_searchFlag == 2){    //바이어기준
          gridCreateBuyer();
          GR_LIST.ColumnProp("ORD_OWN_FLAG_3","show") = true;
          GR_LIST.ColumnProp("BUYER_NM_1",  "show")   = true;
          GR_LIST.ColumnProp("PUMBUN_CD_3", "show")   = true;
          GR_LIST.ColumnProp("PUMBUN_NM_3", "show")   = true;
          GR_LIST.ColumnProp("VEN_CD_2",    "show")   = true; 
          GR_LIST.ColumnProp("VEN_NM_2",    "show")   = true;   

          GR_LIST.ColumnProp("ORD_OWN_FLAG_1","show") = false;
          GR_LIST.ColumnProp("ORD_OWN_FLAG_2","show") = false;
          GR_LIST.ColumnProp("PUMBUN_CD",   "show")   = false;
          GR_LIST.ColumnProp("VEN_CD",      "show")   = false; 
          GR_LIST.ColumnProp("PUMBUN_NM_1", "show")   = false;
          GR_LIST.ColumnProp("PUMBUN_CD_2", "show")   = false;
          GR_LIST.ColumnProp("PUMBUN_NM_2", "show")   = false;
          GR_LIST.ColumnProp("VEN_NM_1",    "show")   = false;
          GR_LIST.ColumnProp("BUYER_NM_2",  "show")   = false;           

          DS_LIST.SubSumExpr  = "BUYER_CD"; 
          GR_LIST.ColumnProp("BUYER_CD", "sumtext")           = "합계";  
          GR_LIST.ColumnProp("VEN_CD",   "sumtext")           = "";  
          GR_LIST.ColumnProp("PUMBUN_CD","sumtext")           = "";  
          GR_LIST.ColumnProp("BUYER_CD", "SubSumText")        = "바이어소계";
          GR_LIST.ColumnProp("VEN_CD",   "SubSumText")        = "";  
          GR_LIST.ColumnProp("PUMBUN_CD","SubSumText")        = "";  
          GR_LIST.ColumnProp("GAP_RATE", "SubSumText")        = "";  
          
//          sortColId( eval(GR_LIST.DataID), 0, "BUYER_CD");
                    
      }else if(g_searchFlag == 3){    //협력사기준
          gridCreate();
          GR_LIST.ColumnProp("ORD_OWN_FLAG_1","show") = true;
          GR_LIST.ColumnProp("VEN_CD",      "show")   = true;
          GR_LIST.ColumnProp("PUMBUN_CD_2", "show")   = true;
          GR_LIST.ColumnProp("PUMBUN_NM_2", "show")   = true;
          GR_LIST.ColumnProp("BUYER_NM_1",  "show")   = true;
          GR_LIST.ColumnProp("VEN_NM_1",    "show")   = true;

          GR_LIST.ColumnProp("VEN_CD_2",      "show") = false;
          GR_LIST.ColumnProp("VEN_NM_2",      "show") = false;
          GR_LIST.ColumnProp("ORD_OWN_FLAG_2","show") = false;
          GR_LIST.ColumnProp("ORD_OWN_FLAG_3","show") = false;
          GR_LIST.ColumnProp("PUMBUN_CD",   "show")   = false;
          GR_LIST.ColumnProp("PUMBUN_NM_1", "show")   = false;
          GR_LIST.ColumnProp("PUMBUN_CD_3", "show")   = false;
          GR_LIST.ColumnProp("PUMBUN_NM_3", "show")   = false;
          GR_LIST.ColumnProp("BUYER_NM_2",  "show")   = false;
          
          DS_LIST.SubSumExpr  = "VEN_CD"; 
          GR_LIST.ColumnProp("VEN_CD",   "sumtext")        = "합계";  
          GR_LIST.ColumnProp("BUYER_CD", "sumtext")        = "";  
          GR_LIST.ColumnProp("PUMBUN_CD","sumtext")        = "";  
          GR_LIST.ColumnProp("VEN_CD",   "SubSumText")     = "협력사소계";
          GR_LIST.ColumnProp("BUYER_CD", "SubSumText")     = "";  
          GR_LIST.ColumnProp("PUMBUN_CD","SubSumText")     = "";  
          GR_LIST.ColumnProp("GAP_RATE", "SubSumText")        = "";  
          
//          sortColId( eval(GR_LIST.DataID), 0, "VEN_CD");
      }
  }
  /**
   * controlSearchCondition()
   * 작 성 자 : 박래형
   * 작 성 일 : 2010-04-13
   * 개    요 :  조회라디오버튼에 따른 조회조건변경
   * return값 : void
   */
  function controlSearchCondition(){    
       
      EM_S_FLAG_CD.Text = "";
      EM_S_FLAG_NM.Text = "";
      document.getElementById('FLAG_CD').innerHTML = RD_S_FLAG.DataValue;
//      document.getElementById('FLAG_NM').innerHTML = RD_S_FLAG.DataValue + "명";
      g_searchFlag   = RD_S_FLAG.CodeValue;
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

<script language=JavaScript for=TR_S_MAIN event=onSuccess>
    for(i=0;i<TR_S_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_S_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_S_MAIN event=onFail>
    trFailed(TR_S_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--  ===================DS_IO_MASTER============================ -->
<!-- Grid DS_IO_MASTER 변경시 DS_LIST의 마스터 내용 변경 -->

<!--  ===================DS_IO_MASTER============================ -->

<script language=JavaScript for=DS_LIST event=CanRowPosChange(row)>

</script>


<script language=JavaScript for=DS_LIST event=onRowPosChanged(row)>

    var strSlipFlag  = DS_LIST.NameValue(row, "SLIP_FLAG");       //전표구분
    var strSkuFlag   = DS_LIST.NameValue(row, "SKU_FLAG");        //단품구분
    var strSkuType   = DS_LIST.NameValue(row, "SKU_TYPE");        //단품종류
    var strStyleType = DS_LIST.NameValue(row, "STYLE_TYPE");      //스타일타입
    
    //대출입 브랜드에 따른 단품 종류
    var strShowFlag1 = "";     //하단그리드 매입 반품 점출입 매가인상하
    var strShowFlag2 = "";     //하단그리드 대출
    var strShowFlag3 = "";     //하단그리드 대입   
    
    if(row != 0){
        if( bfListRowPosition == row)
            return;
        bfListRowPosition = row;       
        
        if(strSlipFlag == 'C' || strSlipFlag == 'D'){       //대출입
            getDetail2();
        }else{                                              //매입 반품 점출입 대출입 매가인상하
            getDetail1(); 
        } 

        strShowFlag1 = DS_DETAIL2.NameValue(DS_DETAIL1.RowPosition, "SKU_TYPE");
        strShowFlag2 = DS_DETAIL2.NameValue(DS_DETAIL2.RowPosition, "SKU_TYPE");
        strShowFlag3 = DS_DETAIL3.NameValue(DS_DETAIL3.RowPosition, "SKU_TYPE");
                
        //alert("strStyleType = " + strStyleType);
        if(strSkuFlag == '2'){                                              //품목
            document.getElementById("detail1").style.display ="";
            document.getElementById("detail2").style.display ="none";
            document.getElementById("detail3").style.display ="none";
            document.getElementById("detail4").style.display ="none"; 
            
            if(strSlipFlag == 'A'){
                document.getElementById('FFF').innerHTML = "품목(매입)";     
                
            }else if(strSlipFlag == 'B'){
                document.getElementById('FFF').innerHTML = "품목(반품)";   
                
            }else{
                document.getElementById('FFF').innerHTML = "품목(소계)";
            }
            
        }else if(strSkuFlag == '1'){                                                              //단품
            if(strSlipFlag == 'C' || strSlipFlag == 'D'){                  //대출입
                document.getElementById("detail1").style.display ="none";
                document.getElementById("detail2").style.display ="none";
                document.getElementById("detail3").style.display ="none";
                document.getElementById("detail4").style.display ="";

                if(strSlipFlag == "C"){
                    strCStyleType = DS_LIST.NameValue(row, "STYLE_TYPE1");
                    strDStyleType = DS_LIST.NameValue(row, "STYLE_TYPE2");
                }else{
                    strCStyleType = DS_LIST.NameValue(row, "STYLE_TYPE2")
                    strDStyleType = DS_LIST.NameValue(row, "STYLE_TYPE1");
                }
                
                if(strShowFlag2 == '3'){
                    if(strCStyleType == "1"){
                        GR_DETAIL4.ColumnProp("STYLE_CD", "show")   = true;
                        GR_DETAIL4.ColumnProp("COLOR_CD", "show")   = true;
                        GR_DETAIL4.ColumnProp("SIZE_CD",  "show")   = true;                             
                    }else{
                        GR_DETAIL4.ColumnProp("STYLE_CD", "show")   = true;
                        GR_DETAIL4.ColumnProp("COLOR_CD", "show")   = false;
                        GR_DETAIL4.ColumnProp("SIZE_CD",  "show")   = false;                        
                    }             
                    document.getElementById('BBB').innerHTML = "대출(의류)";
                    
                }else{
                    GR_DETAIL4.ColumnProp("STYLE_CD", "show")   = false;
                    GR_DETAIL4.ColumnProp("COLOR_CD", "show")   = false;
                    GR_DETAIL4.ColumnProp("SIZE_CD",  "show")   = false; 
                    
                    if(strShowFlag2 == '1'){
                        document.getElementById('BBB').innerHTML = "대출(규격)";  
                        
                    }else if(strShowFlag2 == '2'){
                        document.getElementById('BBB').innerHTML = "대출(신선)"; 
                        
                    }else{
                        document.getElementById('BBB').innerHTML = "대출(소계)";                        
                    }                   
                }   
                
                if(strShowFlag3 == '3'){
                    if(strDStyleType == "1"){
                        GR_DETAIL5.ColumnProp("STYLE_CD", "show")   = true;
                        GR_DETAIL5.ColumnProp("COLOR_CD", "show")   = true;
                        GR_DETAIL5.ColumnProp("SIZE_CD",  "show")   = true;                     
                    }else{
                        GR_DETAIL5.ColumnProp("STYLE_CD", "show")   = true;
                        GR_DETAIL5.ColumnProp("COLOR_CD", "show")   = false;
                        GR_DETAIL5.ColumnProp("SIZE_CD",  "show")   = false;                        
                    }
                    
                    document.getElementById('AAA').innerHTML = "대입(의류)";
                }else{
                    GR_DETAIL5.ColumnProp("STYLE_CD", "show")   = false;
                    GR_DETAIL5.ColumnProp("COLOR_CD", "show")   = false;
                    GR_DETAIL5.ColumnProp("SIZE_CD",  "show")   = false; 
                    
                    if(strShowFlag3 == '1'){
                        document.getElementById('AAA').innerHTML = "대입(규격)";  
                        
                    }else if(strShowFlag3 == '2'){
                        document.getElementById('AAA').innerHTML = "대입(신선)";    
                        
                    }else{
                        document.getElementById('AAA').innerHTML = "대입(소계)";                        
                    }               
                }
                
            }else if(strSlipFlag == 'G'){                                  //매가인상하
                document.getElementById("detail1").style.display ="none";
                document.getElementById("detail2").style.display ="none";
                document.getElementById("detail3").style.display ="";
                document.getElementById("detail4").style.display ="none";
                
                if(strSkuType == '3'){                                      //의류단품
                    if(strStyleType == "1"){
                        GR_DETAIL3.ColumnProp("STYLE_CD", "show")   = true;
                        GR_DETAIL3.ColumnProp("COLOR_CD", "show")   = true;
                        GR_DETAIL3.ColumnProp("SIZE_CD",  "show")   = true;                     
                    }else{
                        GR_DETAIL3.ColumnProp("STYLE_CD", "show")   = true;
                        GR_DETAIL3.ColumnProp("COLOR_CD", "show")   = false;
                        GR_DETAIL3.ColumnProp("SIZE_CD",  "show")   = false;    
                    }

                    document.getElementById('CCC').innerHTML = "매가인상하(의류)";                    
                }else{                                                      //규격신선단품
                    GR_DETAIL3.ColumnProp("STYLE_CD", "show")   = false;
                    GR_DETAIL3.ColumnProp("COLOR_CD", "show")   = false;
                    GR_DETAIL3.ColumnProp("SIZE_CD",  "show")   = false;          
                    
                    if(strShowFlag1 == '1'){
                        document.getElementById('CCC').innerHTML = "매가인상하(규격)";  
                        
                    }else if(strShowFlag1 == '2'){
                        document.getElementById('CCC').innerHTML = "매가인상하(신선)";   
                        
                    }else{
                        document.getElementById('CCC').innerHTML = "매가인상하(소계)";  
                    }               
                }
                
            }else{                                                         //규격단품
                document.getElementById("detail1").style.display ="none";
                document.getElementById("detail2").style.display ="";
                document.getElementById("detail3").style.display ="none";
                document.getElementById("detail4").style.display ="none"; 
                
                if(strSkuType == '3'){                                      //의류단품
                    if(strStyleType == "1"){
                        GR_DETAIL2.ColumnProp("STYLE_CD", "show")   = true;
                        GR_DETAIL2.ColumnProp("COLOR_CD", "show")   = true;
                        GR_DETAIL2.ColumnProp("SIZE_CD",  "show")   = true;                     
                    }else{
                        GR_DETAIL2.ColumnProp("STYLE_CD", "show")   = true;
                        GR_DETAIL2.ColumnProp("COLOR_CD", "show")   = false;
                        GR_DETAIL2.ColumnProp("SIZE_CD",  "show")   = false;                            
                    }
                    
                }else{                                                      //규격신선단품
                    GR_DETAIL2.ColumnProp("STYLE_CD", "show")   = false;
                    GR_DETAIL2.ColumnProp("COLOR_CD", "show")   = false;
                    GR_DETAIL2.ColumnProp("SIZE_CD",  "show")   = false;                    
                }
                
                if(strSlipFlag == 'A'){
                    document.getElementById('DDD').innerHTML = "단품(매입)"; 
                    
                }else if(strSlipFlag == 'B'){
                    document.getElementById('DDD').innerHTML = "단품(반품)"; 
                    
                }else if(strSlipFlag == 'E'){                       
                    document.getElementById('DDD').innerHTML = "단품(점출)"; 
                    
                }else if(strSlipFlag == 'F'){
                    document.getElementById('DDD').innerHTML = "단품(점입)";  
                    
                }else{
                    document.getElementById('DDD').innerHTML = "단품(소계)";  
                }                
            }
        }else{
            document.getElementById('AAA').innerHTML = "대입(소계)";
            document.getElementById('BBB').innerHTML = "대출(소계)";
            document.getElementById('CCC').innerHTML = "매가인상하(소계)";
            document.getElementById('DDD').innerHTML = "단품(소계)";
            document.getElementById('FFF').innerHTML = "품목(소계)";
            
            DS_DETAIL1.ClearData();
            DS_DETAIL2.ClearData();
            DS_DETAIL3.ClearData();
        }
        
        if(intSearchCnt == 0){
            // 조회결과 Return;
            intSearchCnt++;
        }else{
            setPorcCount("SELECT", DS_DETAIL1.CountRow);
        }
    } 

    //신선단품일때만 목표이익율을 보여준다
    if(strSkuType == "2"){
        GR_DETAIL2.ColumnProp("RATE", "show")   = true;
        GR_DETAIL4.ColumnProp("RATE", "show")   = true;
        GR_DETAIL5.ColumnProp("RATE", "show")   = true;
    }else{
        GR_DETAIL2.ColumnProp("RATE", "show")   = false;
        GR_DETAIL4.ColumnProp("RATE", "show")   = false;
        GR_DETAIL5.ColumnProp("RATE", "show")   = false;
    }

    if(clickSORT)
        return;

</script>

<script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(row)>
</script>
<script language=JavaScript for=DS_IO_MASTER event=onRowPosChanged(row)>
</script>

<script language=JavaScript for=DS_IO_MASTER
    event=OnColumnChanged(row,colid)>

</script>
<!--  ===================DS_LIST============================ -->
<!--  DS_LIST 변경시 -->
<script language=JavaScript for=DS_LIST
    event=OnColumnChanged(row,colid)>

</script>

<!-- 디테일 삭제시 컴퍼넌트 총금액-->
<script language=JavaScript for=DS_LIST event=OnRowDeleted(row)>   
 
</script>


<!-- GR_LIST CanColumnPosChange(Row,Colid) event 처리 -->
<script language="javascript"  for=GR_LIST event=CanColumnPosChange(Row,Colid)>

</script>


<!--  ===================GR_LIST============================ -->
<!-- Grid Master oneClick event 처리 -->

<script language=JavaScript for=GR_LIST event=OnClick(row,colid)>
   // sortColId( eval(this.DataID), row, colid);
    
</script>



<!--*************************************************************************-->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 점(조회)  변경시  -->
<script language=JavaScript for=LC_O_STR event=OnSelChange()>
    if(LC_O_STR.BindColVal != "%"){
        getDept("DS_O_DEPT", "Y", LC_O_STR.BindColVal, "Y");                                              // 팀 
        LC_O_BUMUN.Index = 0;
    }
    EM_S_FLAG_CD.Text = "";
    EM_S_FLAG_NM.Text = "";
</script>

<!-- 팀(조회)  변경시  -->
<script language=JavaScript for=LC_O_BUMUN event=OnSelChange()>
    if(LC_O_BUMUN.BindColVal != "%"){
        getTeam("DS_O_TEAM", "Y", LC_O_STR.BindColVal, LC_O_BUMUN.BindColVal, "Y");                       // 파트  
    }else{
        DS_O_TEAM.ClearData();
        insComboData( LC_O_TEAM, "%", "전체",1);
        DS_O_PC.ClearData();
        insComboData( LC_O_PC, "%", "전체",1);
    }
    LC_O_TEAM.Index = 0;
    EM_S_FLAG_CD.Text = "";
    EM_S_FLAG_NM.Text = "";
</script>

<!-- 파트(조회)  변경시  -->
<script language=JavaScript for=LC_O_TEAM event=OnSelChange()>
    if(LC_O_TEAM.BindColVal != "%"){
        getPc("DS_O_PC", "Y", LC_O_STR.BindColVal, LC_O_BUMUN.BindColVal, LC_O_TEAM.BindColVal, "Y");     // PC  
    }else{
        DS_O_PC.ClearData();
        insComboData( LC_O_PC, "%", "전체",1);
    }
    LC_O_PC.Index = 0;
    EM_S_FLAG_CD.Text = "";
    EM_S_FLAG_NM.Text = "";
</script>

<!-- 구분에 따른 조회기준 변경 -->
<script language=JavaScript for=RD_S_FLAG event=OnSelChange()>
//    controlGrid();
    controlSearchCondition();

</script>


<!-- 조회부 브랜드 KillFocus -->
<script language=JavaScript for=EM_S_FLAG_CD event=onKillFocus()>
    
    if(g_searchFlag == 1){          // 브랜드
        if(EM_S_FLAG_CD.Text != ""){
            searchPumbunNonPop();
        }else
            EM_S_FLAG_NM.Text = ""; 
        
    }else if(g_searchFlag == 2){    // 바이어
        if(EM_S_FLAG_CD.Text != ""){
            getBuyerNonInfo();
        }else
            EM_S_FLAG_NM.Text = ""; 
        
    }else if(g_searchFlag == 3){    //협력사
        if(EM_S_FLAG_CD.Text != ""){
            getVenNonInfo();
        }else
            EM_S_FLAG_NM.Text = "";         
    } 
        
</script>

<!-- 조회시작일 변경시  -->
<script lanaguage=JavaScript for=EM_S_START_DT event=OnKillFocus()>

var strSyyyymmdd = strToday.substring(0,6) + "01";
    checkDateTypeYMD( EM_S_START_DT , strSyyyymmdd);    
/*
    var strSyyyymmdd = strToday.substring(0,6) + "01";
    checkDateTypeYMD( EM_S_START_DT, strSyyyymmdd );
*/    
</script>

<!-- 조회종료일 변경시  -->
<script lanaguage=JavaScript for=EM_S_END_DT event=OnKillFocus()>
    checkDateTypeYMD( EM_S_END_DT );
</script>

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
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_DEPT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_TEAM" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_PC" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_GJDATE_TYPE" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_PROC_STAT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_OWN_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_STR" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_LIST" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_DETAIL1" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_DETAIL2" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_DETAIL3" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>


<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_S_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>


<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<script language='javascript'>
window.onresize = function(){
	var obj   = document.getElementById("GR_DETAIL1");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
	var obj   = document.getElementById("GR_DETAIL2");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
	var obj   = document.getElementById("GR_DETAIL3");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
	var obj   = document.getElementById("GR_DETAIL4");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
	var obj   = document.getElementById("GR_DETAIL5");
    
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
<body onLoad="doInit();" class="PL10 PT15 ">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<DIV id="testdiv" class="testdiv">

<table width="100%" border="0" cellspacing="0" cellpadding="0">

    <tr>
        <td class="PT01 PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
            class="o_table">
            <tr>
                <td>
                <table width="100%" border="0" cellpadding="0" cellspacing="0"
                    class="s_table">
                    <tr>
                        <th class="point" width="70">점</th>
                        <td width="110"><comment id="_NSID_"> <object
                            id=LC_O_STR classid=<%=Util.CLSID_LUXECOMBO%> height=100
                            width=100 align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script>
                        </td>
                        <th width="70">팀</th>
                        <td width="110"><comment id="_NSID_"> <object
                            id=LC_O_BUMUN classid=<%=Util.CLSID_LUXECOMBO%> width=100
                            align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script></td>
                        <th width="70">파트</th>
                        <td width="110"><comment id="_NSID_"> <object
                            id=LC_O_TEAM classid=<%=Util.CLSID_LUXECOMBO%> width=100
                            align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script></td>
                        <th width="70">PC</th>
                        <td><comment id="_NSID_"> <object id=LC_O_PC
                            classid=<%=Util.CLSID_LUXECOMBO%> width=100 align="absmiddle" tabindex=1>
                        </object> </comment><script>_ws_(_NSID_);</script></td>
                    </tr>
                    <tr>
                        <th class="point">기준일</th>
                        <td><comment id="_NSID_"> <object
                            id=LC_O_GJDATE classid=<%=Util.CLSID_LUXECOMBO%> height=100
                            width=100 align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script>
                        </td>
                        <th class="point">조회기간</th>
                        <td colspan="5"><comment id="_NSID_"> <object
                            id=EM_S_START_DT classid=<%=Util.CLSID_EMEDIT%> width=70
                            tabindex=1 align="absmiddle" tabindex=1> </object> </comment><script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/date.gif"
                            onclick="javascript:openCal('G',EM_S_START_DT)" align="absmiddle" />~<comment id="_NSID_"> <object id=EM_S_END_DT
                            classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
                            align="absmiddle" tabindex=1> </object> </comment><script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/date.gif"
                            onclick="javascript:openCal('G',EM_S_END_DT)" align="absmiddle" />
                        </td>
                    </tr>
                    <tr>
                        <th>구분</th>
                        <td colspan="3"><comment id="_NSID_"> <object
                            id=RD_S_FLAG classid=<%=Util.CLSID_RADIO%>
                            style="height: 20; width: 196" tabindex=1>
                            <param name=Cols value="3">
                            <param name=Format value="1^브랜드,2^바이어,3^협력사">
                            <param name=CodeValue value="1">
                            <param name=AutoMargin  value="true">                            
                        </object> </comment> <script> _ws_(_NSID_);</script></td>    
                        
                        
                        <th><span id="FLAG_CD" style="Color: 146ab9">브랜드</span></th>    
                        <td colspan="3"><comment id="_NSID_"> <object
                            id=EM_S_FLAG_CD classid=<%=Util.CLSID_EMEDIT%> width=80
                            tabindex=1 align="absmiddle"> </object> </comment><script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03" id=IMG_FLAG  align="absmiddle" 
                        onclick="javascript:callPopupForFlag();"/>  <comment id="_NSID_"><object id=EM_S_FLAG_NM classid=<%=Util.CLSID_EMEDIT%> 
                        width=193 tabindex=1 align="absmiddle"></object>
                            </comment><script> _ws_(_NSID_);</script>
                        </td>       
   
                    </tr>
                    <tr>
                        <th class="point">확정구분</th>
                        <td colspan="3"><comment id="_NSID_"> <object
                            id=RD_S_CONF_FLAG classid=<%=Util.CLSID_RADIO%>
                            style="height: 20; width: 196" tabindex=1>
                            <param name=Cols value="3">
                            <param name=Format value="1^전체,2^확정,3^미확정">
                            <param name=CodeValue value="1">
                            <param name=AutoMargin  value="true">
                        </object> </comment> <script> _ws_(_NSID_);</script></td>
                        <th>발주주체</th>
                        <td colspan="3"><comment id="_NSID_"> <object
                            id=LC_O_ORD_OWN_FLAG classid=<%=Util.CLSID_LUXECOMBO%> height=100
                            width=100 align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script>
                        </td>
                    </tr>
                    <tr>
                        <th class="point">전표구분</th>
                        <td colspan="7">                            
                            <input type="checkbox" id=CHK_1 onclick="javascript:checkSlipFlag(CHK_1);">전체
                            <input type="checkbox" id=CHK_2 onclick="javascript:checkSlipFlag(CHK_2);">매입
                            <input type="checkbox" id=CHK_3 onclick="javascript:checkSlipFlag(CHK_3);">반품
                            <input type="checkbox" id=CHK_4 onclick="javascript:checkSlipFlag(CHK_4);">대출입
                            <input type="checkbox" id=CHK_5 onclick="javascript:checkSlipFlag(CHK_5);">점출입
                            <input type="checkbox" id=CHK_6 onclick="javascript:checkSlipFlag(CHK_6);">매가인상하            
                        </td> 
                    </tr>
                </table>
                </td>
            </tr>
        </table>
        </td>
    </tr>
    <tr>
        <td class="dot"></td>
    </tr>
    <tr valign="top">
        <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr valign="top">
                <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                        <td><comment id="_NSID_"> <OBJECT id=GR_LIST
                            width=100% height=300 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID" value="DS_LIST">
                        </OBJECT> </comment><script>_ws_(_NSID_);</script></td>
                    </tr>
                </table>
                </td>
            </tr>
        </table>
        </td>
    </tr>
    <tr>
        <td>
        <div id ="detail1">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">        
            <tr>
                <td class="sub_title PB03 PT10"><img
                    src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
                    align="absmiddle" /> <span id="FFF" class="sub_title PB03 PT10"></span></td>
            </tr>
            <tr valign="top">
                <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                        <td><comment id="_NSID_"> <OBJECT id=GR_DETAIL1
                            width=100% height=350 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID" value="DS_DETAIL1">
                        </OBJECT> </comment><script>_ws_(_NSID_);</script></td>
                    </tr>
                </table>
                </td>
            </tr>
        </table>
       </div>
        <div id ="detail2">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">        
            <tr>
                <td class="sub_title PB03 PT10"><img
                    src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
                    align="absmiddle" /> <span id="DDD" class="sub_title PB03 PT10"></span></td>
            </tr>
            <tr valign="top">
                <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                        <td><comment id="_NSID_"> <OBJECT id=GR_DETAIL2
                            width=100% height=350 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID" value="DS_DETAIL1">
                        </OBJECT> </comment><script>_ws_(_NSID_);</script></td>
                    </tr>
                </table>
                </td>
            </tr>
        </table>
       </div>
        <div id ="detail3">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">        
            <tr>
                <td class="sub_title PB03 PT10"><img
                    src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
                    align="absmiddle" /> <span id="CCC" class="sub_title PB03 PT10"></span></td>
            </tr>
            <tr valign="top">
                <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                        <td><comment id="_NSID_"> <OBJECT id=GR_DETAIL3
                            width=100% height=350 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID" value="DS_DETAIL1">
                        </OBJECT> </comment><script>_ws_(_NSID_);</script></td>
                    </tr>
                </table>
                </td>
            </tr>
        </table>
       </div>
        <div id ="detail4">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">        
            <tr>
                <td class="sub_title PB03 PT10"><img
                    src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
                    align="absmiddle" /> <span id="BBB" class="sub_title PB03 PT10"></span></td>
            </tr>
            <tr valign="top">
                <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                        <td><comment id="_NSID_"> <OBJECT id=GR_DETAIL4
                            width=100% height=350 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID" value="DS_DETAIL2">
                        </OBJECT> </comment><script>_ws_(_NSID_);</script></td>
                    </tr>
                </table>
                </td>
            </tr>
        </table>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">        
            <tr>
                <td class="sub_title PB03 PT10"><img
                    src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
                    align="absmiddle" /> <span id="AAA" class="sub_title PB03 PT10"></span></td>
            </tr>
            <tr valign="top">
                <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                        <td><comment id="_NSID_"> <OBJECT id=GR_DETAIL5
                            width=100% height=350 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID" value="DS_DETAIL3">
                        </OBJECT> </comment><script>_ws_(_NSID_);</script></td>
                    </tr>
                </table>
                </td>
            </tr>
        </table>
       </div>
        </td>
    </tr>
</table>
</div>
<body>
</html>

