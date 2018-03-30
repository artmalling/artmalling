<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 발주결재 > 전표출력
 * 작 성 일 : 2010.04.08
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : pord1200.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 전표출력 
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
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"
    type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
var strToday        = "";                            // 현재날짜
var prinCount       = 0;
var g_popUp         = false;
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
 var top = 200;		//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID

 function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GR_MASTER"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    // Input  Data Set Header 초기화
     
    strToday        = getTodayDB("DS_O_RESULT");  
    // Output Data Set Header 초기화
    DS_LIST.setDataHeader('<gauce:dataset name="H_LIST"/>');
    DS_CHECKMASTER.setDataHeader('<gauce:dataset name="H_LIST"/>');     
    DS_O_TEAM.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_O_PC.setDataHeader('CODE:STRING(2),NAME:STRING(40)'); 
    
    DS_PRINT.setDataHeader('<gauce:dataset name="H_PRINT"/>');
    
    // 그리드 초기화
    gridCreate1(); //마스터
     
    // EMedit에 초기화
//     initEmEdit(RD_S_SLIP_FLAG,            "GEN",       NORMAL);      //전표구분     
    initEmEdit(RD_S_SLIP_ISSUE_CNT_FLAG,  "GEN",       NORMAL);      //발행구분     
    initEmEdit(EM_S_START_DT,             "SYYYYMMDD", PK);          //조회용 시작일
    initEmEdit(EM_S_END_DT,               "TODAY",     PK);          //조회용 종료일

//     initEmEdit(RD_SLIP_FLAG,  "GEN"  ,    PK);                     //입력용 전표구분  

     
    //콤보 초기화
    initComboStyle(LC_O_STR,    DS_STR,           "CODE^0^30,NAME^0^140", 1, PK);              //조회용 점코드     
    initComboStyle(LC_O_BUMUN,  DS_O_DEPT,        "CODE^0^30,NAME^0^80", 1, NORMAL);          //조회용 팀     
    initComboStyle(LC_O_TEAM,   DS_O_TEAM,        "CODE^0^30,NAME^0^80", 1, NORMAL);          //조회용 파트     
    initComboStyle(LC_O_PC,     DS_O_PC,          "CODE^0^30,NAME^0^80", 1, NORMAL);          //조회용 PC     
    initComboStyle(LC_O_GJDATE, DS_O_GJDATE_TYPE, "CODE^0^30,NAME^0^80", 1, NORMAL);          //조회용 기준일     
    initComboStyle(LC_OUTPUT_FLAG,     DS_O_OUTPUT_FLAG,    "CODE^0^30,NAME^0^80", 1, NORMAL);   //출력구분용       

    getStore("DS_STR", "Y", "", "N");                                                            // 점        
    getEtcCode("DS_O_GJDATE_TYPE", "D", "P214", "N");       // 기준일
    getEtcCode("DS_O_OUTPUT_FLAG",  "D", "P234", "Y");   // 출력구분

	LC_O_STR.Index       = 0; 
	LC_O_BUMUN.Index     = 0;
	LC_O_TEAM.Index      = 0;
	LC_O_PC.Index        = 0;  
	LC_O_GJDATE.Index    = 0;
	LC_OUTPUT_FLAG.Index = 0;
	LC_O_STR.Focus();
	CHK_1.checked        = true;
   
    registerUsingDataset("pord120","DS_LIST");
    
 } 
 
  
 function gridCreate1(){
     var hdrProperies = '<FC>id={currow}           name="NO"         width=30    edit=none align=center  sumtext=""     </FC>'
                      + '<FC>id=CHECK1             name="선택"       width=50     align=center  HeadCheckShow=true EditStyle=CheckBox</FC>'
                      + '<FC>id=STR_CD             name="점코드"      width=65    edit=none align=left show=false</FC>'
                      + '<FC>id=STR_NM             name="점"         width=60     edit=none align=left </FC>'
                      + '<FC>id=ORD_DT             name="발주일"      width=93    edit=none align=center Mask="XXXX/XX/XX"</FC>'
                      + '<FC>id=SLIP_FLAG          name="전표구분코드" width=80   edit=none align=left show=false</FC>'
                      + '<FC>id=SLIP_FLAG_NM       name="전표구분"    width=60    edit=none align=left </FC>'
                      + '<FC>id=SLIP_NO            name="전표번호"    width=110    edit=none align=center Mask="XXXX-X-XXXXXXX"</FC>'
                      + '<FC>id=PUMBUN_CD          name="브랜드코드"    width=65    edit=none align=center </FC>'
                      + '<FC>id=PUMBUN_NM          name="브랜드"        width=130   edit=none align=left</FC>'
                      + '<FC>id=VEN_CD             name="협력사코드"  width=70    edit=none align=center </FC>'
                      + '<FC>id=VEN_NM             name="협력사"      width=130   edit=none align=left </FC>'
                      + '<FC>id=SLP_TQTY           name="수랑계"      width=80    edit=none align=right </FC>'
                      + '<FC>id=SLP_COST_TAMT      name="원가계"      width=120    edit=none align=right </FC>'
                      + '<FC>id=SLP_OLD_TAMT       name="(구)매가계"  width=120    edit=none align=right</FC>'
                      + '<FC>id=SLP_NEW_TAMT       name="(신)매가계"  width=120    edit=none align=right</FC>'
                      + '<FC>id=SLP_GAP_RATE       name="차익율"      width=80    edit=none align=right </FC>'
                      + '<FC>id=SKU_FLAG           name="단품구분"    width=80    edit=none align=right show=false</FC>';

     initGridStyle(GR_MASTER, "common", hdrProperies, true);
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

	 GR_MASTER.ColumnProp('CHECK1','HeadCheck')= "FALSE";
    
     if(checkValidation("Search")){
         getList();
         // 조회결과 Return
         setPorcCount("SELECT", GR_MASTER);
//         if(DS_LIST.CountRow <= 0)
//           LC_O_STR.Focus();
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
	 
	if(DS_LIST.CountRow	<= 0){
		  showMessage(INFORMATION, OK, "USER-1000","다운 할	내용이 없습니다. 조회 후 엑셀다운 하십시오.");
			return;
		}
		var	strTitle = "전표출력";

		var	strStrCd		= LC_O_STR.Text;			//점
		var	strLevelCd		= LC_O_BUMUN.Text;			//팀
		var	strSaleDtS		= EM_S_START_DT.text;		//시작년월
		var	strSaleDtE		= EM_S_END_DT.text;		//종료년월

		
		var	parameters = "점 "			 + strStrCd
					   + " ,   레벨	"	  +	strLevelCd
					   + " ,   매출시작일자	"  + strSaleDtS
					   + " ,   매출종료일자	"  + strSaleDtE
		

		GR_MASTER.GridToExcelExtProp("HideColumn") = "{currow}";	   // GridToExcel 사용시 숨길 컬럼지정
		//openExcel2(GR_MASTER, strTitle,	parameters,	true );
		openExcel5(GR_MASTER, strTitle,	parameters,	true , "",g_strPid );

		
	 
}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print(){ 	
	 
	// 변경된 내역 존재
    if(!DS_LIST.Isupdated){
    	showMessage(EXCLAMATION , OK, "USER-1000", "반드시 선택 후 출력하십시오.");
    	return;
    }
	
	// 선택된 데이터셋 Copy(DS_CHECKMASTER)
	setMasterDs();
	
	/* 출력전표 디테일 조회 */
	var goTo        = "getPrintList";
	var strStrCd    = "";
	var strSlipNo   = "";
	
	// 체크된 건수만큼 데이터 조회후 전표출력호출
	for(var nRow = 1; nRow <= DS_CHECKMASTER.CountRow; nRow++){
		
		strStrCd  = DS_CHECKMASTER.NameValue(nRow, "STR_CD");
		strSlipNo = DS_CHECKMASTER.NameValue(nRow, "SLIP_NO");
		
		var parameters  = "&strStrCd="  + encodeURIComponent(strStrCd)
				        + "&strSlipNo=" + encodeURIComponent(strSlipNo)
				        ; 

		TR_PRINT.Action  ="/dps/pord120.po?goTo="+goTo+parameters;  
		TR_PRINT.KeyValue="SERVLET(O:DS_PRINT=DS_PRINT)"; //조회는 O
		TR_PRINT.Post();
		
		// 전표 출력
		var strOutFlag = LC_OUTPUT_FLAG.BindColVal;
		if(strOutFlag == "%"){
			outPrint(nRow, "01", "매입팀용");
			outPrint(nRow, "02", "재무팀용");
			outPrint(nRow, "03", "협력사용");
		}else if(strOutFlag == "01"){
			outPrint(nRow, "01", "매입팀용");
		}else if(strOutFlag == "02"){
			outPrint(nRow, "02", "재무팀용");
		}else if(strOutFlag == "03"){
			outPrint(nRow, "03", "협력사용");
		}
	}
}

/**
 * outPrint()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-04-26
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
 function outPrint(nRow, strOutFlag, strOutFlagNm) { 

	var strord_dt      = DS_CHECKMASTER.NameValue(nRow, "ORD_DT");      
	var strstr_cd      = DS_CHECKMASTER.NameValue(nRow, "STR_CD");
	var strstr_nm      = DS_CHECKMASTER.NameValue(nRow, "STR_NM");
	var strteam_cdnm   = DS_CHECKMASTER.NameValue(nRow, "TEAM_CDNM");   
	var strpumbun_cdnm = DS_CHECKMASTER.NameValue(nRow, "PUMBUN_CDNM"); 
	var strdeli_dt     = DS_CHECKMASTER.NameValue(nRow, "DELI_DT");
	var strpc_cdnm     = DS_CHECKMASTER.NameValue(nRow, "PC_CDNM");     
	var strmg_app_dt   = DS_CHECKMASTER.NameValue(nRow, "MG_APP_DT");
	var strven_cdnm    = DS_CHECKMASTER.NameValue(nRow, "VEN_CDNM");    
	var strremark      = DS_CHECKMASTER.NameValue(nRow, "REMARK");      
	var strslip_no     = DS_CHECKMASTER.NameValue(nRow, "SLIP_NO");     
	var strcomp_no     = DS_CHECKMASTER.NameValue(nRow, "COMP_NO");     
	var strrep_name    = DS_CHECKMASTER.NameValue(nRow, "REP_NAME");    
	var strbiz_stat    = DS_CHECKMASTER.NameValue(nRow, "BIZ_STAT");   
	var strsajubjang   = DS_CHECKMASTER.NameValue(nRow, "SAJUBJANG");   
	var strcomp_name   = DS_CHECKMASTER.NameValue(nRow, "COMP_NAME");   
	var strfax_no      = DS_CHECKMASTER.NameValue(nRow, "FAX_NO");      
	var strbiz_cat     = DS_CHECKMASTER.NameValue(nRow, "BIZ_CAT");     
	var strchk_dt      = DS_CHECKMASTER.NameValue(nRow, "CHK_DT");

	var strSkuFlag     = DS_CHECKMASTER.NameValue(nRow, "SKU_FLAG");        // 1:단품 2:비단품
	var strbiz_type_nm = DS_CHECKMASTER.NameValue(nRow, "BIZ_TYPE_NM"); 
	var strSlipFlag    = DS_CHECKMASTER.NameValue(nRow, "SLIP_FLAG");       // 전표구분 (A:매입, B:반품)
	var strSlipFlagNm  = DS_CHECKMASTER.NameValue(nRow, "SLIP_FLAG_NM");
	
	// 타이틀 세팅
	var strTitle = "";
	if(strSkuFlag == "1"){
		strTitle += "단품";
	}else{
		strTitle += "품목";		
	}
	strTitle += strSlipFlagNm + "발주";
	
	/* 날짜타입 Mask 처리 */
	strord_dt    = strord_dt.substring(0,4)    + '/' + strord_dt.substring(4,6)    + '/' + strord_dt.substring(6,8);
	strdeli_dt   = strdeli_dt.substring(0,4)   + '/' + strdeli_dt.substring(4,6)   + '/' + strdeli_dt.substring(6,8);
	strmg_app_dt = strmg_app_dt.substring(0,4) + '/' + strmg_app_dt.substring(4,6) + '/' + strmg_app_dt.substring(6,8);
	strchk_dt    = strchk_dt.substring(0,4)    + '/' + strchk_dt.substring(4,6)    + '/' + strchk_dt.substring(6,8);
	
    var PR_format = "";
    
    // 헤더 시작
    PR_format += "<B>id=Header,                       left=0,    top=0,    right=2971,  bottom=330,  face='Tahoma', size=10, penwidth=1 " ;
    PR_format += "  <T>id='발주일',                   left=0,    top=0,    right=200,   bottom=60,   face='Tahoma', size=10, bold=true,  align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='점',                       left=0,    top=60,   right=200,   bottom=120,  face='Tahoma', size=10, bold=true,  align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='파트',                     left=0,    top=120,  right=200,   bottom=180,  face='Tahoma', size=10, bold=true,  align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='브랜드',                   left=0,    top=180,  right=200,   bottom=240,  face='Tahoma', size=10, bold=true,  align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='납품예정일',               left=0,    top=240,  right=200,   bottom=300,  face='Tahoma', size=10, bold=true,  align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='"+strord_dt+"',            left=200,  top=0,    right=800,   bottom=60,   face='Tahoma', size=9,  bold=false,                 underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='"+strstr_nm+"',            left=200,  top=60,   right=800,   bottom=120,  face='Tahoma', size=9,  bold=false, align='left',   underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='"+strteam_cdnm+"',         left=200,  top=120,  right=800,   bottom=180,  face='Tahoma', size=9,  bold=false,                 underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='"+strpumbun_cdnm+"',       left=200,  top=180,  right=800,   bottom=240,  face='Tahoma', size=9,  bold=false,                 underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='"+strdeli_dt+"',           left=200,  top=240,  right=800,   bottom=300,  face='Tahoma', size=9,  bold=false,                 underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id=' ',                        left=800,  top=0,    right=2818,  bottom=120,  face='Tahoma', size=16, bold=false,                 underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='( '"+strbiz_type_nm+"' )', left=800,  top=0,    right=1400,  bottom=60,   face='Tahoma', size=16, bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF </T> " ;
    PR_format += "  <T>id='"+strTitle+"',             left=800,  top=0,    right=2000,  bottom=60,   face='Tahoma', size=17, bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF </T> " ;
    PR_format += "  <T>id='(거래명세서겸용)',         left=800,  top=0,    right=2700,  bottom=60,   face='Tahoma', size=12, bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF </T> " ;
    PR_format += "  <T>id='("+strOutFlagNm+")',       left=800,  top=0,    right=2000,  bottom=160,  face='Tahoma', size=14, bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF </T> " ;
    PR_format += "  <T>id='PC',                       left=800,  top=120,  right=1000,  bottom=180,  face='Tahoma', size=10, bold=true,  align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='거래형태',                 left=800,  top=180,  right=1000,  bottom=240,  face='Tahoma', size=10, bold=true,  align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='마진적용일',               left=800,  top=240,  right=1000,  bottom=300,  face='Tahoma', size=10, bold=true,  align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='"+strpc_cdnm+"',           left=1000, top=120,  right=1800,  bottom=180,  face='Tahoma', size=9,  bold=false, align='left',   underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='"+strbiz_type_nm+"',       left=1000, top=180,  right=2400,  bottom=240,  face='Tahoma', size=9,  bold=false, align='left',   underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='"+strmg_app_dt+"',         left=1000, top=240,  right=1800,  bottom=300,  face='Tahoma', size=9,  bold=false,                 underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='협력사',                   left=1800, top=120,  right=2000,  bottom=180,  face='Tahoma', size=10, bold=true,  align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='비고',                     left=1800, top=240,  right=2000,  bottom=300,  face='Tahoma', size=10, bold=true,  align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='"+strven_cdnm+"',          left=2000, top=120,  right=2400,  bottom=180,  face='Tahoma', size=9,  bold=false, align='left',   underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='"+strremark+" ',           left=2000, top=240,  right=2818,  bottom=300,  face='Tahoma', size=9,  bold=false, align='left',   underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='전표번호',                 left=2400, top=120,  right=2600,  bottom=180,  face='Tahoma', size=10, bold=true,  align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='PAGE',                     left=2400, top=180,  right=2600,  bottom=240,  face='Tahoma', size=10, bold=true,  align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='"+strslip_no+"',           left=2600, top=120,  right=2818,  bottom=180,  face='Tahoma', size=9,  bold=false, align='left'    underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='#p/#t',                    left=2600, top=180,  right=2818,  bottom=240,  face='Tahoma', size=9,  bold=false, align='center'  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "</B>" ;
    // 헤더 종료
    
    // 반복구간 시작
    PR_format += "<A>id=Area2,                        left=0,    top=0,    right=2871,  bottom=133,  RecCount=17" ;
    PR_format += "   <R>id='전표출력',                left=0,    top=0,    right=2871,  bottom=132,  DetailDataID='DS_PRINT', MasterDataID='DS_PRINT', SuppressColumns='1:RNUM'" ;

    // 디테일 그리드 시작
    PR_format += "<B>id=DHeader,                      left=0,    top=0,    right=2971,  bottom=0,    face='Arial',  size=10, penwidth=1 " ;
    PR_format += "    <X>                             left=0,    top=0,    right=2818,  bottom=114,  backcolor=#C0C0C0, border=true, penstyle=solid,     penwidth=1 </X> " ;
    PR_format += "    <T>id='No',                     left=0,    top=34,   right=85,    bottom=87,   face='굴림',   size=10, bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0 </T> " ;
    
    if(strSkuFlag == "1"){
        PR_format += "    <T>id='상품코드',           left=130,  top=34,   right=400,   bottom=87,   face='굴림',   size=10, bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0 </T> " ;
        PR_format += "    <T>id='상품명',             left=471,  top=34,   right=950,   bottom=87,   face='굴림',   size=10, bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0 </T> " ;
    }else{
        PR_format += "    <T>id='품목코드',           left=130,  top=34,   right=400,   bottom=87,   face='굴림',   size=10, bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0 </T> " ;
        PR_format += "    <T>id='품목명',             left=471,  top=34,   right=950,   bottom=87,   face='굴림',   size=10, bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0 </T> " ;
    }
    
    PR_format += "    <T>id='단위',                   left=728,  top=34,   right=1290,  bottom=87,   face='굴림',   size=10, bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0 </T> " ;
    PR_format += "    <T>id='수량',                   left=1064, top=34,   right=1188,  bottom=87,   face='굴림',   size=10, bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0 </T> " ;
    PR_format += "    <T>id='원가(VAT제외)',          left=1191, top=3,    right=1800,  bottom=56,   face='굴림',   size=10, bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0 </T> " ;
    PR_format += "    <T>id='단가',                   left=1191, top=58,   right=1490,  bottom=111,  face='굴림',   size=10, bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0 </T> " ;
    PR_format += "    <T>id='금액',                   left=1492, top=58,   right=1791,  bottom=111,  face='굴림',   size=10, bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0 </T> " ;
    PR_format += "    <T>id='매가(VAT제외)',          left=1794, top=3,    right=2400,  bottom=56,   face='굴림',   size=10, bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0 </T> " ;
    PR_format += "    <T>id='단가',                   left=1794, top=58,   right=2093,  bottom=111,  face='굴림',   size=10, bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0 </T> " ;
    PR_format += "    <T>id='금액',                   left=2096, top=58,   right=2394,  bottom=111,  face='굴림',   size=10, bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0 </T> " ;
    PR_format += "    <T>id='마진율(%)',              left=2397, top=32,   right=2550,  bottom=85,   face='굴림',   size=10, bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0 </T> " ;
    PR_format += "    <T>id='상품명',                 left=2550, top=32,   right=2815,  bottom=85,   face='굴림',   size=10, bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0 </T> " ;
    PR_format += "    <L>                             left=70,   top=0,    right=70,    bottom=111   </L> " ;	// |
    PR_format += "    <L>                             left=468,  top=3,    right=468,   bottom=114   </L> " ;	// |
    PR_format += "    <L>                             left=950,  top=3,    right=950,   bottom=114   </L> " ;	// |
    PR_format += "    <L>                             left=1061, top=3,    right=1061,  bottom=114   </L> " ;	// |
    PR_format += "    <L>                             left=1188, top=0,    right=1188,  bottom=111   </L> " ;	// |
    PR_format += "    <L>                             left=1188, top=56,   right=2394,  bottom=56    </L> " ;	// ㅡ
    PR_format += "    <L>                             left=1490, top=57,   right=1490,  bottom=114   </L> " ;	// |
    PR_format += "    <L>                             left=1791, top=3,    right=1791,  bottom=114   </L> " ;	// |
    PR_format += "    <L>                             left=2093, top=57,   right=2093,  bottom=111   </L> " ;	// |
    PR_format += "    <L>                             left=2394, top=3,    right=2394,  bottom=114   </L> " ;	// |
    PR_format += "    <L>                             left=2550, top=3,    right=2550,  bottom=114   </L> " ;	// |
    PR_format += "</B>" ;
    PR_format += "<B>id=default,                      left=0,    top=0,    right=2971,  bottom=56,   face='Arial', size=10, penwidth=1 " ;
    PR_format += "    <X>                             left=0,    top=114,  right=2818,  bottom=170,  border=true</X> " ;
    PR_format += "    <C>id='{currow}',               left=3,    top=114,  right=70,    bottom=170,  face='굴림',   size=9,  bold=false,                 underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </C> " ;

    if(strSkuFlag == "1"){
        PR_format += "    <C>id='SKU_CD',             left=70,   top=114,  right=468,   bottom=170,  face='굴림',   size=9,  bold=false, align='center', underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </C> " ;
        PR_format += "    <C>id='SKU_NM',             left=471,  top=114,  right=725,   bottom=170,  face='굴림',   size=9,  bold=false, align='left',   underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </C> " ;
    }else{
        PR_format += "    <C>id='PUMMOK_CD',          left=70,   top=114,  right=468,   bottom=170,  face='굴림',   size=9,  bold=false, align='center', underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </C> " ;
        PR_format += "    <C>id='PUMMOK_NM',          left=471,  top=114,  right=725,   bottom=170,  face='굴림',   size=9,  bold=false, align='left',   underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </C> " ;
    }
    
    PR_format += "    <C>id='ORD_UNIT_NM',            left=950,  top=114,  right=1061,  bottom=170,  face='굴림',   size=9,  bold=false, align='left',   underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </C> " ;
    PR_format += "    <C>id='ORD_QTY',                left=1064, top=114,  right=1188,  bottom=170,  face='굴림',   size=9,  bold=false, align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </C> " ;
    PR_format += "    <C>id='NEW_COST_PRC',           left=1191, top=114,  right=1490,  bottom=170,  face='굴림',   size=9,  bold=false, align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </C> " ;
    PR_format += "    <C>id='NEW_COST_AMT',           left=1490, top=114,  right=1791,  bottom=170,  face='굴림',   size=9,  bold=false, align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </C> " ;
    PR_format += "    <C>id='NEW_SALE_PRC',           left=1791, top=114,  right=2093,  bottom=170,  face='굴림',   size=9,  bold=false, align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </C> " ;
    PR_format += "    <C>id='NEW_SALE_AMT',           left=2093, top=114,  right=2394,  bottom=170,  face='굴림',   size=9,  bold=false, align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </C> " ;
    PR_format += "    <C>id='MG_RATE',                left=2397, top=114,  right=2550,  bottom=170,  face='굴림',   size=9,  bold=false, align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2 </C> " ;
    PR_format += "    <C>id='SKU_NM',                 left=2550, top=114,  right=2815,  bottom=170,  face='굴림',   size=9,  bold=false, align='left',   underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </C> " ;
    PR_format += "    <L>                             left=70,   top=114,  right=70,    bottom=170   </L> " ;	// |
    PR_format += "    <L>                             left=468,  top=114,  right=468,   bottom=170   </L> " ;	// |
    PR_format += "    <L>                             left=950,  top=114,  right=950,   bottom=170   </L> " ;	// |	
    PR_format += "    <L>                             left=1061, top=114,  right=1061,  bottom=170   </L> " ;	// |
    PR_format += "    <L>                             left=1191, top=114,  right=1191,  bottom=170   </L> " ;	// |
    PR_format += "    <L>                             left=1490, top=114,  right=1490,  bottom=170   </L> " ;	// |
    PR_format += "    <L>                             left=1791, top=114,  right=1791,  bottom=170   </L> " ;	// |
    PR_format += "    <L>                             left=2093, top=114,  right=2093,  bottom=170   </L> " ;	// |
    PR_format += "    <L>                             left=2394, top=114,  right=2394,  bottom=170   </L> " ;	// |
    PR_format += "    <L>                             left=2550, top=114,  right=2550,  bottom=170   </L> " ;	// |
    PR_format += "</B>" ;
    
    // 디테일 그리드 합계
    PR_format += "<B>id=Tail,                         left=0,    top=0,    right=2971,  bottom=56,   face='Arial',  size=10, penwidth=1 " ;
    PR_format += "    <X>                             left=0,    top=114,  right=2818,  bottom=170,  border=true</X> " ;
    PR_format += "    <C>id=' ',                      left=3,    top=114,  right=70,    bottom=170,  face='굴림',   size=9,  bold=false,                 underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </C> " ;
    PR_format += "    <T>id='합계',                   left=130,  top=114,  right=468,   bottom=170,  face='굴림',   size=11, bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </T> " ;
    PR_format += "    <C>id=' ',                      left=471,  top=114,  right=725,   bottom=170,  face='굴림',   size=9,  bold=false,                 underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </C> " ;
    PR_format += "    <C>id=' ',                      left=950,  top=114,  right=1061,  bottom=170,  face='굴림',   size=9,  bold=false,                 underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </C> " ;
    PR_format += "    <C>id=' ',                      left=1064, top=114,  right=1188,  bottom=170,  face='굴림',   size=9,  bold=false, align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </C> " ;
    PR_format += "    <C>id=' ',                      left=1191, top=114,  right=1490,  bottom=170,  face='굴림',   size=9,  bold=false, align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </C> " ;
    PR_format += "    <C>id='{Sum(NEW_COST_AMT)}',    left=1490, top=114,  right=1791,  bottom=170,  face='굴림',   size=9,  bold=false, align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </C> " ;
    PR_format += "    <C>id='   ',                    left=1791, top=114,  right=2093,  bottom=170,  face='굴림',   size=9,  bold=false, align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </C> " ;
    PR_format += "    <C>id='{Sum(NEW_SALE_AMT)}',    left=2093, top=114,  right=2394,  bottom=170,  face='굴림',   size=9,  bold=false, align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </C> " ;
    PR_format += "    <C>id=' ',                      left=2397, top=114,  right=2550,  bottom=170,  face='굴림',   size=9,  bold=false, align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C> " ;
    PR_format += "    <C>id=' ',                      left=2550, top=114,  right=2815,  bottom=170,  face='굴림',   size=9,  bold=false, align='left',   underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </C> " ;
    PR_format += "    <L>                             left=70,   top=114,  right=70,    bottom=170   </L> " ;
    PR_format += "    <L>                             left=468,  top=114,  right=468,   bottom=170   </L> " ;
    PR_format += "    <L>                             left=950,  top=114,  right=950,   bottom=170   </L> " ;
    PR_format += "    <L>                             left=1061, top=114,  right=1061,  bottom=170   </L> " ;
    PR_format += "    <L>                             left=1191, top=114,  right=1191,  bottom=170   </L> " ;
    PR_format += "    <L>                             left=1490, top=114,  right=1490,  bottom=170   </L> " ;
    PR_format += "    <L>                             left=1791, top=114,  right=1791,  bottom=170   </L> " ;
    PR_format += "    <L>                             left=2093, top=114,  right=2093,  bottom=170   </L> " ;
    PR_format += "    <L>                             left=2394, top=114,  right=2394,  bottom=170   </L> " ;
    PR_format += "    <L>                             left=2550, top=114,  right=2550,  bottom=170   </L> " ;                                                                                                                  
    PR_format += "</B>" ;
    // 디테일 그리드 종료
    
    // 하단 정보 시작
    PR_format += "<B>id=footer,                       left=0,    top=1500, right=2000,  bottom=1600, face='Tahoma', size=10, penwidth=1 " ;
    PR_format += "  <T>id='사업자등록번호',           left=0,    top=0,    right=300,   bottom=60,   face='Tahoma', size=10, bold=true,  align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='대표자',                   left=0,    top=60,   right=300,   bottom=120,  face='Tahoma', size=10, bold=true,  align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='업태',                     left=0,    top=120,  right=300,   bottom=180,  face='Tahoma', size=10, bold=true,  align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='사업장',                   left=0,    top=180,  right=300,   bottom=240,  face='Tahoma', size=10, bold=true,  align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='"+strcomp_no+"',           left=300,  top=0,    right=900,   bottom=60,   face='Tahoma', size=9,  bold=false,                 underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='"+strrep_name+"',          left=300,  top=60,   right=900,   bottom=120,  face='Tahoma', size=9,  bold=false, align='left'    underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='"+strbiz_stat+"',          left=300,  top=120,  right=900,   bottom=180,  face='Tahoma', size=9,  bold=false, align='left'    underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='"+strsajubjang+"',         left=300,  top=180,  right=2000,  bottom=240,  face='Tahoma', size=9,  bold=false, align='left',   underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='상호',                     left=900,  top=0,    right=1200,  bottom=60,   face='Tahoma', size=10, bold=true,  align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='협력사연락처',             left=900,  top=60,   right=1200,  bottom=120,  face='Tahoma', size=10, bold=true,  align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='종목',                     left=900,  top=120,  right=1200,  bottom=180,  face='Tahoma', size=10, bold=true,  align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='"+strcomp_name+"',         left=1200, top=0,    right=2000,  bottom=60,   face='Tahoma', size=9,  bold=false, align='left',   underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='"+strfax_no+"',            left=1200, top=60,   right=2000,  bottom=120,  face='Tahoma', size=9,  bold=false,                 underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='"+strbiz_cat+"',           left=1200, top=120,  right=2000,  bottom=180,  face='Tahoma', size=9,  bold=false, align='left',   underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='부가가치세',               left=2000, top=0,    right=2300,  bottom=60,   face='Tahoma', size=10, bold=true,  align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='점출차익액',               left=2000, top=60,   right=2300,  bottom=120,  face='Tahoma', size=10, bold=true,  align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='합계차익율(%)',            left=2000, top=120,  right=2300,  bottom=180,  face='Tahoma', size=10, bold=true,  align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='검품확정일',               left=2000, top=180,  right=2300,  bottom=240,  face='Tahoma', size=10, bold=true,  align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id=' ',                        left=2300, top=0,    right=2818,  bottom=60,   face='Tahoma', size=9,  bold=false,                 underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id=' ',                        left=2300, top=60,   right=2818,  bottom=120,  face='Tahoma', size=9,  bold=false,                 underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id=' ',                        left=2300, top=120,  right=2818,  bottom=180,  face='Tahoma', size=9,  bold=false, align='left',   underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='"+strchk_dt+"',            left=2300, top=180,  right=2818,  bottom=240,  face='Tahoma', size=9,  bold=false,                 underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> " ;
    PR_format += "  <T>id='영업팀',                   left=0,    top=300,  right=80,    bottom=510,  face='Tahoma', size=9,  bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000, vmode=true </T> " ;
    PR_format += "  <T>id='SM',                       left=80,   top=300,  right=480,   bottom=350,  face='Tahoma', size=9,  bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000  </T> " ;
    PR_format += "  <T>id='영업팀장',                 left=480,  top=300,  right=880,   bottom=350,  face='Tahoma', size=9,  bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000  </T> " ;
    PR_format += "  <T>id='점장',                     left=880,  top=300,  right=1280,  bottom=350,  face='Tahoma', size=9,  bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000  </T> " ;
    PR_format += "  <T>id=' ',                        left=80,   top=350,  right=480,   bottom=510,  face='Tahoma', size=9,  bold=false,                 underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000  </T> " ;
    PR_format += "  <T>id=' ',                        left=480,  top=350,  right=880,   bottom=510,  face='Tahoma', size=9,  bold=false,                 underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000  </T> " ;
    PR_format += "  <T>id=' ',                        left=880,  top=350,  right=1280,  bottom=510,  face='Tahoma', size=9,  bold=false,                 underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000  </T> " ;
    PR_format += "  <T>id='매입팀',                   left=1370, top=300,  right=1450,  bottom=510,  face='Tahoma', size=9,  bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000, vmode=true </T> " ;
    PR_format += "  <T>id='바이어',                   left=1450, top=300,  right=1850,  bottom=350,  face='Tahoma', size=9,  bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000  </T> " ;
    PR_format += "  <T>id='매입팀장',                 left=1850, top=300,  right=2250,  bottom=350,  face='Tahoma', size=9,  bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000  </T> " ;
    PR_format += "  <T>id=' ',                        left=1450, top=350,  right=1850,  bottom=510,  face='Tahoma', size=9,  bold=false,                 underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000  </T> " ;
    PR_format += "  <T>id=' ',                        left=1850, top=350,  right=2250,  bottom=510,  face='Tahoma', size=9,  bold=false,                 underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000  </T> " ;
    PR_format += "  <T>id='검품팀',                   left=2335, top=300,  right=2415,  bottom=510,  face='Tahoma', size=9,  bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000, vmode=true</T> " ;
    PR_format += "  <T>id='검품',                     left=2415, top=300,  right=2815,  bottom=350,  face='Tahoma', size=9,  bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000  </T> " ;
    PR_format += "  <T>id=' ',                        left=2415, top=350,  right=2815,  bottom=510,  face='Tahoma', size=9,  bold=false,                 underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000  </T> " ;
    PR_format += "</B>" ;
    // 하단 정보 종료
    
    PR_format += "    </R> " ;
    PR_format += "</A> ";
    // 반복구간 종료
		             
	PR_List.PaperSize         = "A4";        	// 용지크기 
	PR_List.LandScape         = true;        	// 용지모양  
	PR_List.MasterDataID      = "DS_PRINT";	// 사용데이타셋
	PR_List.DetailDataID      = "DS_PRINT";	// 사용데이타셋       
	PR_List.PrintMargine      = false;       	// 프린트 자체마진    
	PR_List.format            = PR_format;   	// 레포트 포멧
	PR_List.PrintSetupDlgFlag = false;			// 인쇄도구상자 
// 	PR_List.Preview();                       // 미리보기
	PR_List.Print();                       	// 바로출력
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
    var strSlipIssueCnt  = RD_S_SLIP_ISSUE_CNT_FLAG.CodeValue;   //발행구분        
    
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
                    + "&strSlipIssueCnt="+encodeURIComponent(strSlipIssueCnt); 
    TR_L_MAIN.Action="/dps/pord120.po?goTo="+goTo+parameters;  
    TR_L_MAIN.KeyValue="SERVLET("+action+":DS_LIST=DS_LIST)"; //조회는 O
    TR_L_MAIN.Post();    

//    GR_MASTER.SetColumn("STR_NM");
//    GR_MASTER.Focus();     
//    outPrint();
 }

 /**
 * updateData()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-05-02
 * 개    요 :  전표출력시 데이터 업데이트
 * return값 : void
 */
 function updateData(){

//	 alert("updateData = " + DS_CHECKMASTER.CountRow);
     TR_S_MAIN.Action="/dps/pord120.po?goTo=save"; 
     TR_S_MAIN.KeyValue="SERVLET(I:DS_CHECKMASTER=DS_CHECKMASTER)";
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

     var strSlipIssueCnt = "A.SLIP_FLAG IN (";
     
     if(CHK_1.checked){
//          strSlipIssueCnt += "'A','B','C','D','E','F','G')";
         strSlipIssueCnt += "'A','B')";
     }else{      
         if(CHK_2.checked){
             strSlipIssueCnt += "'A'," ;
         } 
         
         if(CHK_3.checked){
             strSlipIssueCnt += "'B'," ;             
         }
         
//          if(CHK_4.checked){
//              strSlipIssueCnt += "'C','D'," ;             
//          }
         
//          if(CHK_5.checked){
//              strSlipIssueCnt += "'E','F'," ;             
//          }
                  
//          if(CHK_6.checked){
//              strSlipIssueCnt += "'G'," ;             
//          }
         strSlipIssueCnt = strSlipIssueCnt.substring(0, strSlipIssueCnt.length-1);
         strSlipIssueCnt += ")";
     }     
         
//      if(CHK_1.checked == false && CHK_2.checked == false && CHK_3.checked == false 
//      && CHK_4.checked == false && CHK_5.checked == false && CHK_6.checked == false){  
         
     if(CHK_1.checked == false && CHK_2.checked == false && CHK_3.checked == false){    
//       alert();
         showMessage(EXCLAMATION, OK, "GAUCE-1005", "전표구분");
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
//          CHK_4.checked = false;
//          CHK_5.checked = false;
//          CHK_6.checked = false;
     }else{
         CHK_1.checked = false;
     }
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
               showMessage(EXCLAMATION, OK, messageCode, "점");
               LC_O_STR.Focus();
               return false;
         }  
         /*
         if(LC_O_BUMUN.Text.length == 0){                                       // 팀
             showMessage(EXCLAMATION, OK, messageCode, "팀");
             LC_O_BUMUN.Focus();
             return false;
         }  
         if(LC_O_TEAM.Text.length == 0){                                        // 파트
             showMessage(EXCLAMATION, OK, messageCode, "파트");
             LC_O_TEAM.Focus();
             return false;
         }  
         if(LC_O_PC.Text.length == 0){                                          // PC
             showMessage(EXCLAMATION, OK, messageCode, "PC");
             LC_O_PC.Focus();
             return false;
         }  
         */
         if(LC_O_GJDATE.Text.length == 0){                                      // 기준일
             showMessage(EXCLAMATION, OK, messageCode, "기준일");
             LC_O_GJDATE.Focus();
             return false;
         }

         if(EM_S_START_DT.Text.length == 0){                                    // 조회일 정합성
             showMessage(EXCLAMATION, OK, "USER-1002", "조회시작일");
             EM_S_START_DT.Focus();
             return false;
        }
         if(EM_S_END_DT.Text.length == 0){                                      // 조회일 정합성
             showMessage(EXCLAMATION, OK, "USER-1002", "조회종료일");
             EM_S_END_DT.Focus();
             return false;
        }
         if(EM_S_START_DT.Text > EM_S_END_DT.Text){                             // 조회일 정합성
             showMessage(EXCLAMATION, OK, "USER-1015");
             EM_S_START_DT.Focus();
             return false;
         }
         return true; 
     }     
}

/**
* setMasterDs()
* 작 성 자 : 박래형
* 작 성 일 : 2010-03-17
* 개    요 : 행사구분 데이터셋 복사
* return값 : void
*/

function setMasterDs(){
	
    DS_CHECKMASTER.ClearData();         //복사될 데이터셋 초기화
    
    /*마스터에서 선택된 데이터만 Copy */
    for(var i = 1; i <= DS_LIST.CountRow; i ++){
    	if(DS_LIST.NameValue(i, "CHECK1") == "T"){
            DS_CHECKMASTER.Addrow();
            DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "ORD_DT")       = DS_LIST.NameValue(i, "ORD_DT");
            DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "STR_CD")       = DS_LIST.NameValue(i, "STR_CD");
            DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "STR_NM")       = DS_LIST.NameValue(i, "STR_NM");
            DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "TEAM_CDNM")    = DS_LIST.NameValue(i, "TEAM_CDNM");
            DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "PUMBUN_CDNM")  = DS_LIST.NameValue(i, "PUMBUN_CDNM");
            DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "DELI_DT")      = DS_LIST.NameValue(i, "DELI_DT");
            DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "PC_CDNM")      = DS_LIST.NameValue(i, "PC_CDNM");
            DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "BIZ_TYPE_NM")  = DS_LIST.NameValue(i, "BIZ_TYPE_NM");
            DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "MG_APP_DT")    = DS_LIST.NameValue(i, "MG_APP_DT");
            DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "VEN_CDNM")     = DS_LIST.NameValue(i, "VEN_CDNM");
            DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "REMARK")       = DS_LIST.NameValue(i, "REMARK");
            DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "SLIP_NO")      = DS_LIST.NameValue(i, "SLIP_NO");
            DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "COMP_NO")      = DS_LIST.NameValue(i, "COMP_NO");
            DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "REP_NAME")     = DS_LIST.NameValue(i, "REP_NAME");
            DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "BIZ_STAT")     = DS_LIST.NameValue(i, "BIZ_STAT");
            DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "SAJUBJANG")    = DS_LIST.NameValue(i, "SAJUBJANG");
            DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "COMP_NAME")    = DS_LIST.NameValue(i, "COMP_NAME");
            DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "FAX_NO")       = DS_LIST.NameValue(i, "FAX_NO");
            DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "BIZ_CAT")      = DS_LIST.NameValue(i, "BIZ_CAT");
            DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "CHK_DT")       = DS_LIST.NameValue(i, "CHK_DT");
            DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "BIZ_TYPE")     = DS_LIST.NameValue(i, "BIZ_TYPE");
            DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "SLIP_FLAG")    = DS_LIST.NameValue(i, "SLIP_FLAG");
            DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "SLIP_FLAG_NM") = DS_LIST.NameValue(i, "SLIP_FLAG_NM");
            DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "SKU_FLAG")     = DS_LIST.NameValue(i, "SKU_FLAG");
    	}
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
        showMessage(EXCLAMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<script language=JavaScript for=TR_S_MAIN event=onSuccess>
    for(i=0;i<TR_S_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(EXCLAMATION, OK, "USER-1000", TR_S_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>


<script language=JavaScript for=TR_L_MAIN event=onSuccess>
    for(i=0;i<TR_L_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(EXCLAMATION, OK, "USER-1000", TR_L_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<script language=JavaScript for=TR_PRINT event=onSuccess>

	//전표 출력
// 	outPrint();
 	//alert(DS_PRINT.NameValue(0, "SLIP_NO"));
	
    for(i=0;i<TR_L_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(EXCLAMATION, OK, "USER-1000", TR_PRINT.SrvErrMsg('UserMsg',i));
    }
</script>


<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_S_MAIN event=onFail>
    trFailed(TR_S_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_S_MAIN event=onFail>
    trFailed(TR_L_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_PRINT event=onFail>
    trFailed(TR_PRINT.ErrorMsg);
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
<script language=JavaScript for=DS_LIST  event=OnColumnChanged(row,colid)>

	switch (colid) {
		case "CHECK1":
			var count = 0;
			for(var i = 1; i <= DS_LIST.CountRow; i ++){
				if(DS_LIST.NameValue(i, "CHECK1") == "T"){
					count++
				}
			}
// 			if(count >1){
// 				showMessage(INFORMATION, OK, "USER-1000","한건만 출력이 가능합니다.");
// 				DS_LIST.NameValue(row, "CHECK1")="F";
// 				count = 0;
// 				return;
// 			}
		    break;
	}
</script>

<!-- 디테일 삭제시 컴퍼넌트 총금액-->
<script language=JavaScript for=DS_LIST event=OnRowDeleted(row)>   
 
</script>


<!-- GR_MASTER CanColumnPosChange(Row,Colid) event 처리 -->
<script language="javascript"  for=GR_MASTER event=CanColumnPosChange(Row,Colid)>

</script>


 


<!-- 디테일 선택시 전체 선택/해제 -->
<script language=JavaScript for=GR_MASTER
    event="OnHeadCheckClick(Col,Colid,bCheck)">       
    if (Colid == "CHECK1") {
        if (bCheck == 1) {
            GR_MASTER.Redraw = false;
            for (var i = 0; i < DS_LIST.CountRow; i++)
            {
                DS_LIST.NameValue(i + 1, "CHECK1") = "T";
            }    
            GR_MASTER.Redraw = true;
        }
        else if (bCheck == 0) {
            GR_MASTER.Redraw = false;
            for (var i = 0; i < DS_LIST.CountRow; i++)
            {
                DS_LIST.NameValue(i + 1, "CHECK1") = "F";
            } 
            GR_MASTER.Redraw = true;
        }
    }
</script>

<!--  ===================GR_MASTER============================ -->
<!-- Grid Master oneClick event 처리 -->

<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid); 
</script>



<!--*************************************************************************-->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 점(조회)  변경시  -->
<script language=JavaScript for=LC_O_STR event=OnSelChange()>
    if(LC_O_STR.BindColVal != "%"){
        getDept("DS_O_DEPT", "Y", LC_O_STR.BindColVal, "Y");                                              // 팀 
        LC_O_BUMUN.Index = 0;
    }
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
</script>

<!-- 조회시작일 변경시  -->
<script lanaguage=JavaScript for=EM_S_START_DT event=OnKillFocus()>
//    checkDateTypeYMD( EM_S_START_DT );
    
    var strSyyyymmdd = strToday.substring(0,6) + "01";
    checkDateTypeYMD( EM_S_START_DT, strSyyyymmdd );
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
<!-- 출력용 -->
<comment id="_NSID_">
<object id="PR_List" classid=<%=Util.CLSID_REPORT%>></object>
</comment>
<script>_ws_(_NSID_);</script>
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
<object id="DS_O_OUTPUT_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
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
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>


<comment id="_NSID_">
<object id="DS_CHECKMASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_PRINT" classid=<%=Util.CLSID_DATASET%>></object>
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

<comment id="_NSID_">
<object id="TR_L_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_PRINT" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>


<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GR_MASTER");
    
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
                        <th class="point">발행구분</th>
                        <td colspan="2"><comment id="_NSID_"> <object
                            id=RD_S_SLIP_ISSUE_CNT_FLAG classid=<%=Util.CLSID_RADIO%>
                            style="height: 20; width: 183" tabindex=1>
                            <param name=Cols value="3">
                            <param name=Format value=" ^전체,A^발행,B^미발행">
                            <param name=CodeValue value=" ">
                            <param name=AutoMargin  value="true">
                        </object> </comment> <script> _ws_(_NSID_);</script></td>
                        <th class="point">전표구분</th>
                        <td colspan="4">
                            <input type="checkbox" id=CHK_1 onclick="javascript:checkSlipFlag(CHK_1);">전체
                            <input type="checkbox" id=CHK_2 onclick="javascript:checkSlipFlag(CHK_2);">매입
                            <input type="checkbox" id=CHK_3 onclick="javascript:checkSlipFlag(CHK_3);">반품
<!--                             <input type="checkbox" id=CHK_4 onclick="javascript:checkSlipFlag(CHK_4);">대출입 -->
<!--                             <input type="checkbox" id=CHK_5 onclick="javascript:checkSlipFlag(CHK_5);">점출입 -->
<!--                             <input type="checkbox" id=CHK_6 onclick="javascript:checkSlipFlag(CHK_6);">매가인상하                     -->
                  
                    </tr>
                </table>
                </td>
            </tr>
        </table>
        </td>
    </tr>    
	<tr>
	    <td class="right PB03"><table width="180" border="0" cellpadding="0" cellspacing="0" class="s_table">
	            <tr>
	                <th>출력구분</th>
	                <td><comment id="_NSID_"> <object
	                    id=LC_OUTPUT_FLAG classid=<%=Util.CLSID_LUXECOMBO%> height=100
	                    width=100 align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script>
	                </td>
	            </tr>
	    </table></td>   
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
                        <td><comment id="_NSID_"> <OBJECT id=GR_MASTER
                            width=100% height=427 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID" value="DS_LIST">
                        </OBJECT> </comment><script>_ws_(_NSID_);</script></td>
                    </tr>
                </table> 
                </td>
            </tr>            
        </table> 
        </td>
    </tr>
</table>
</div>
    <form name="hiddenForm" action="">
        <INPUT TYPE="hidden" name="StrCd"     value=""></INPUT>
        <INPUT TYPE="hidden" name="SlipNo"    value=""></INPUT>
        <INPUT TYPE="hidden" name="SlipFlag"  value=""></INPUT>
        <INPUT TYPE="hidden" name="SkuFlag"   value=""></INPUT>
        <INPUT TYPE="hidden" name="Loop"      value=""></INPUT>  
        <INPUT TYPE="hidden" name="TotCount"  value=""></INPUT>  
        <iframe name=hiddenReportPage width=0 height=0>
        </iframe>
    </form>
<body>
</html>

