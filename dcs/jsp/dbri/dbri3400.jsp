<!-- 
 * 시스템명 : 포인트카드 > 고객관리 > 회원관리 > 회원조회
 * 작 성 일 : 2016.11.01
 * 작 성 자 : KHJ
 * 수 정 자 : 
 * 파 일 명 : dbri3400.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
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
<%
    request.setCharacterEncoding("utf-8");
    String dir = BaseProperty.get("context.common.dir");
    
    String fromDate = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());  
    fromDate = fromDate + "01";
    String toDate   = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    
 // PID 확인을 위한
    String pageName = request.getRequestURI();
    int nSubStrFr = pageName.lastIndexOf("/") + 1 ;
    int nSubStrTo = pageName.lastIndexOf(".jsp") - 1 ;
    pageName = pageName.substring(nSubStrFr, nSubStrTo).toUpperCase();
    
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>

	
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--
var strCompPersFlag = "P";
var g_strPid           = "<%=pageName%>";                 // PID
var	now	= new Date();
var	mon	= now.getMonth()+1;
if(mon < 10)mon	= "0" +	mon;
var	day	= now.getDate();
if(day < 10)day	= "0" +	day;
var varbfYear= now.getYear()-1; //전년도
var	varToday = now.getYear().toString()+ mon + day;
var	varToMon = now.getYear().toString()+ mon;
var	varBf_Year_Mon = varbfYear.toString()+ mon;
var old_Row = 0;

var CUR_GRD;

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-29
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 100;		//해당화면의 동적그리드top위치
function doInit(){

    //Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	
	obj   = document.getElementById("GD_SALELIST"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top-340) + "px";
	
    // Input Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_O_PUMBLIST.setDataHeader('<gauce:dataset name="H_PUMBLIST"/>');
    DS_O_SALELIST.setDataHeader('<gauce:dataset name="H_SALELIST"/>');
    
    
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2();
    gridCreate3();
    
    // EMedit에 초기화
    //-- 검색 필드
    
//    initComboStyle(LC_CUST_GRADE, DS_O_CUST_GRADE, "CODE^0^30,NAME^0^110", 1, PK); //회원등급
//    initComboStyle(LC_SEX_CD, DS_O_SEX_CD, "CODE^0^30,NAME^0^110", 1, PK); //성별
//     initComboStyle(LC_MOBILE_COMP, DS_O_MOBILE_COMP, "CODE^0^30,NAME^0^110", 1, PK); //통신사
//    initComboStyle(LC_BIR_MONTH_S, DS_O_BIR_MONTH, "CODE^0^0,NAME^0^60", 1, NORMAL); //생일월
//    initComboStyle(LC_STR_CD,	DS_IO_STR_CD,	"CODE^0^30,NAME^0^150", 1, PK);        // 점(조회)

//    initEmEdit(EM_ADDR,    "GEN^100",    NORMAL);     //주소
    // EMedit에 초기화
    initEmEdit(EM_FROM_DT, "YYYYMMDD", PK);            // 시작일
    initEmEdit(EM_TO_DT, 	"YYYYMMDD", PK);            // 종료일
    initEmEdit(EM_PUMBUN_CD,   "CODE^6^0", NORMAL);          //브랜드(조회)
    initEmEdit(EM_PUMBUN_NAME, "GEN^40",   READ);            //브랜드(조회)

//    initEmEdit(EM_FROM_POINT, 	"NUMBER^9^0", NORMAL);            // 포인트
//    initEmEdit(EM_TO_POINT, 	"NUMBER^9^0", NORMAL);            // 포인트
//	  initEmEdit(TXT_EM_MEMO,   "GEN^2000", NORMAL); //내용
      
//    getEtcCode("DS_O_CUST_GRADE", "D", "D011", "Y");
//    getEtcCode("DS_O_SEX_CD", "D", "D002", "Y");
//    getEtcCode("DS_O_MOBILE_COMP", "D", "D131", "Y");
//    getEtcCode("DS_O_BIR_MONTH", "D", "M100", "Y");
//    getStore("DS_IO_STR_CD",     "Y", "", "N");  
   
    //조회일자 초기값.
//    LC_CUST_GRADE.Index = 0;
//    LC_SEX_CD.Index = 0;
//     LC_MOBILE_COMP.Index = 0;
//    LC_BIR_MONTH_S.Index = 0;

//    EM_FROM_POINT.Text = 0;
//    EM_TO_POINT.Text = 999999999;
    
//    LC_STR_CD.index   = 0;
//    LC_STR_CD.Focus(); 
     
    EM_FROM_DT.Text = varToday;
    EM_TO_DT.Text = varToday;
    //TXT_EM_MEMO.Enable = true;
    //TXT_EM_MEMO.Readonly = true;
    //TXT_EM_MEMO.text="조회되는 내역을 선택하면 문자 내용을 확인할 수 있습니다.";
    
    //화면OPEN시 조회
    //btn_Search();
    
    GD_MASTER.Focus();
    
    TR_MAIN.SyncLoad = false;
    
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}     	name="NO"           	width=40    edit=none	align=center  color={DECODE(CUST_STAT_FLAG,"1","red","#000000")}</FC>'
                     + '<FC>id=ENTR_DT    		name="가입일자" 		width=100   edit=none	align=center sumtext="회원 수" mask="XXXX/XX/XX" color={DECODE(CUST_STAT_FLAG,"1","red","#000000")}</FC>'
                     + '<FC>id=CUST_ID    		name="회원ID" 			width=80   edit=none	align=center sumtext=@count color={DECODE(CUST_STAT_FLAG,"1","red","#000000")}</FC>'
                     + '<FC>id=MASKED_NAME  	name="회원명" 	     	width=110   edit=none	align=center  color={DECODE(CUST_STAT_FLAG,"1","red","#000000")}</FC>'
                     + '<FC>id=REG_ID   		name="등록자코드"      	width=120   edit=none	align=center color={DECODE(CUST_STAT_FLAG,"1","red","#000000")}</FC>'
                     + '<FC>id=REG_NAME     	name="등록자명"    		width=150   edit=none	align=left color={DECODE(CUST_STAT_FLAG,"1","red","#000000")}</FC>'
                     + '<FC>id=CUST_STAT  		name="탈퇴구분"        	width=80    edit=none	align=center color={DECODE(CUST_STAT_FLAG,"1","red","#000000")}</FC>'                     
                     ;
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, true); 
    //합계표시
    GD_MASTER.ViewSummary = "1";
  
}

function gridCreate2(){
    var hdrProperies = '<FC>id={currow}     	name="NO"           	width=40    edit=none	align=center </FC>'
                     + '<FC>id=PUMBUN_CD      	name="브랜드코드"      	width=90    edit=none	align=center </FC>'
                     + '<FC>id=PUMBUN_NAME    	name="브랜드명" 		width=150   edit=none	sumtext="합  계" </FC>'
                     + '<FC>id=CNT    			name="방문일수" 		width=90   edit=none	align=center sumtext=@sum </FC>'
                     + '<FC>id=AMT    			name="구매금액" 		width=90   edit=none	align=left sumtext=@sum </FC>'
                     + '<FC>id=LAST_DT   		name="최근구매일"      	width=100   edit=none	align=center mask="XXXX/XX/XX" </FC>'
                     ;
                    
    initGridStyle(GD_PUMBLIST, "common", hdrProperies, true); 
    //합계표시
    GD_PUMBLIST.ViewSummary = "1";
  
}

function gridCreate3(){
    var hdrProperies = '<FC>id={currow}		name="NO"           width=40    edit=none	align=center bgcolor={decode(ROWCOLOR,"0","#EFFBFB","#ffffff")} color ={decode(TRAN_FLAG,"1","#FF0000","#000000")}</FC>'
                     + '<FG>				name="영수증정보"	'				
    				 + '<FC>id=STR_CD      	name="점코드"      	width=70    edit=none	Suppress=2 align=center bgcolor={decode(ROWCOLOR,"0","#EFFBFB","#ffffff")} color ={decode(TRAN_FLAG,"1","#FF0000","#000000")}</FC>'
                     + '<FC>id=SALE_DT    	name="매출일자" 	width=95   edit=none	Suppress=2 align=center mask="XXXX/XX/XX" bgcolor={decode(ROWCOLOR,"0","#EFFBFB","#ffffff")} color ={decode(TRAN_FLAG,"1","#FF0000","#000000")}</FC>'
                     + '<FC>id=POS_NO    	name="POS번호" 		width=80   edit=none	Suppress=2 align=center bgcolor={decode(ROWCOLOR,"0","#EFFBFB","#ffffff")} color ={decode(TRAN_FLAG,"1","#FF0000","#000000")}</FC>'
                     + '<FC>id=TRAN_NO   	name="거래번호" 	width=80   edit=none	Suppress=2 align=center bgcolor={decode(ROWCOLOR,"0","#EFFBFB","#ffffff")} color ={decode(TRAN_FLAG,"1","#FF0000","#000000")}</FC>'
                     + '<FC>id=SALE_TIME   	name="거래시간" 	width=90   edit=none	align=center mask="XX:XX:XX" bgcolor={decode(ROWCOLOR,"0","#EFFBFB","#ffffff")} color ={decode(TRAN_FLAG,"1","#FF0000","#000000")}</FC>'
                     + '<FC>id=TRAN_FLAG_NM	name="매출구분"     width=65   edit=none	align=center bgcolor={decode(ROWCOLOR,"0","#EFFBFB","#ffffff")} color ={decode(TRAN_FLAG,"1","#FF0000","#000000")}</FC>'
                     + '<FC>id=PUMBUN_CD    name="브랜드코드"	width=80   edit=none	align=center bgcolor={decode(ROWCOLOR,"0","#EFFBFB","#ffffff")} color ={decode(TRAN_FLAG,"1","#FF0000","#000000")}</FC>'
                     + '<FC>id=PUMBUN_NM  	name="브랜드명"     width=150    edit=none	align=left  sumtext="합  계" bgcolor={decode(ROWCOLOR,"0","#EFFBFB","#ffffff")} color ={decode(TRAN_FLAG,"1","#FF0000","#000000")}</FC>'                     
                     + '<FC>id=SALE_AMT    	name="매출금액"     width=90   edit=none	align=right sumtext=@sum bgcolor={decode(ROWCOLOR,"0","#EFFBFB","#ffffff")} color ={decode(TRAN_FLAG,"1","#FF0000","#000000")}</FC>'
                     + '</FG>'
                     + '<FG>				name="원거래정보"	'
                     + '<FC>id=O_SALE_DT    name="매출일자" 	width=95   edit=none	align=center mask="XXXX/XX/XX" bgcolor={decode(ROWCOLOR,"0","#EFFBFB","#ffffff")} color ={decode(TRAN_FLAG,"1","#FF0000","#000000")}</FC>'
                     + '<FC>id=O_POS_NO		name="POS번호" 		width=80   edit=none	align=center bgcolor={decode(ROWCOLOR,"0","#EFFBFB","#ffffff")} color ={decode(TRAN_FLAG,"1","#FF0000","#000000")}</FC>'
                     + '<FC>id=O_TRAN_NO   	name="거래번호" 	width=80   edit=none	align=center bgcolor={decode(ROWCOLOR,"0","#EFFBFB","#ffffff")} color ={decode(TRAN_FLAG,"1","#FF0000","#000000")}</FC>'
                     + '</FG>'
                     ;
         
                     
    initGridStyle(GD_SALELIST, "common", hdrProperies, true); 
    //합계표시
    GD_SALELIST.ViewSummary = "1";
  
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
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-29
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {

//	var strStrCd  = LC_STR_CD.BindColVal;				//점
    var strFromDt = EM_FROM_DT.text;      				//시작일자
	var strToDt   = EM_TO_DT.text;       				//종료일자
	var strChkCustStat = "";
	var strPumbCd = EM_PUMBUN_CD.text;
	 

	if (document.getElementById("CHK_CUST_STAT").checked) {
		strChkCustStat = "0"; 
	}
	else {
		strChkCustStat = "%";
	}
    
    //alert(strChkCustStat)
    
    //strMOBILE_COMP = LC_MOBILE_COMP.BindColVal;
    
//    var strBIR_MONTH_S = LC_BIR_MONTH_S.BindColVal;     //생일월
//    var strHOME_ADDR   = EM_ADDR.Text;					//주소
    
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  =// "&strStrCd="     	   + encodeURIComponent(strStrCd)
			         "&strFromDt="        + encodeURIComponent(strFromDt)
			       + "&strToDt="	      + encodeURIComponent(strToDt)
			       + "&strPumbCd="	      + encodeURIComponent(strPumbCd)
			       + "&strChkCustStat="   + encodeURIComponent(strChkCustStat)
                    ;
                  
    TR_MAIN.Action  = "/dcs/dbri340.db?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();    
    
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
    
    if (DS_O_MASTER.CountRow > 0 ) {
		var strCustId = DS_O_MASTER.NameValue(1, "CUST_ID");
		var strEntrDt = DS_O_MASTER.NameValue(1, "ENTR_DT");
		
    	searchPumbList(strCustId,strEntrDt);
    	searchSaleList(strCustId,strEntrDt);
    	
    }
 
    GD_MASTER.Focus();
}

/**
 * btn_Excel()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-29
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

	 var ExcelTitle = "";
	 var strCustId	= "";
	 var strEntrDt	= "";
	
	 var strFromDt 	= EM_FROM_DT.text;      				//시작일자
	 var strToDt   	= EM_TO_DT.text;       				//종료일자
	 var strPumbunNm = EM_PUMBUN_NAME.text;				// 브랜드 명
	    
	    
	 var parameters =  "조회 가입 기간="   + strFromDt + " ~ " + strToDt
	   				+ " 가입 브랜드="	+ strPumbunNm;
	 
	 
	if (CUR_GRD == GD_MASTER) {
		ExcelTitle = "회원 가입 리스트";
	} else if (CUR_GRD == GD_PUMBLIST) {
		ExcelTitle 	= "회원 브랜드 방문 내역";
		strCustId	= DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "CUST_ID");
		strEntrDt	= DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ENTR_DT");
		parameters = parameters 
				   + " 회원ID=" + strCustId
				   + " 가입일자=" + strEntrDt;
	} else if (CUR_GRD == GD_SALELIST) {
		ExcelTitle = "회원 구매 이력";
		strCustId	= DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "CUST_ID");
		strEntrDt	= DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ENTR_DT");
		parameters = parameters 
		   + " 회원ID=" + strCustId
		   + " 가입일자=" + strEntrDt;
	} else {
		alert("Excel 변환할 내역이 선택되지 않았습니다.");
		return;
	}
            
    //openExcel2(GD_MASTER, ExcelTitle, parameters, true );
    openExcel5(CUR_GRD, ExcelTitle, parameters,true, "",g_strPid );
}

/**
 * btn_New()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-22
 * 개      요      : 신규추가 초기화
 * return값 : void
 */
function btn_New() {
	 
    //조회일자 초기값.   	    
//    EM_ADDR.Text = ""; 

}


/*************************************************************************
 * 3. 함수
 *************************************************************************/
function searchPumbList(custid, entrdt) {
	
	var goTo        = "searchPumbList";    
    var action      = "O";     
    var parameters  ="&custid="        + encodeURIComponent(custid)
			       + "&entrdt="	      + encodeURIComponent(entrdt)
                    ;
                  
    TR_MAIN.Action  = "/dcs/dbri340.db?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_PUMBLIST=DS_O_PUMBLIST)"; //조회는 O
    TR_MAIN.Post();    
	
}

function searchSaleList(custid, entrdt) {
	
	var goTo        = "searchSaleList";    
    var action      = "O";     
    var parameters  ="&custid="        + encodeURIComponent(custid)
			       + "&entrdt="	      + encodeURIComponent(entrdt)
                    ;
                  
    TR_MAIN.Action  = "/dcs/dbri340.db?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_SALELIST=DS_O_SALELIST)"; //조회는 O
    TR_MAIN.Post();
	
}


function dispGrdName(objGrd) {

	var strGrdName = "";
	
	CUR_GRD = objGrd;
	
	if (objGrd == GD_MASTER)
		strGrdName = "가입회원리스트";
	else if (objGrd == GD_PUMBLIST)
		strGrdName = "회원 구매브랜드 방문내역";
	else if (objGrd == GD_SALELIST)
		strGrdName = "회원 구매 이력";
	else 
		strGrdName = "";
	
	obj 			= document.getElementById("grdName");
	obj.innerText  = "* 선택 내역 : " + strGrdName;

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
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<!-- 매출시작일 -->
<script	language=JavaScript	for=EM_FROM_DT event=onKillFocus()>

	//영업조회일
	if (isNull(EM_FROM_DT.text) ==true ) {
		showMessage(Information, OK, "USER-1003","가입기간"); 
		EM_FROM_DT.text =	varToMon;
		return ;
	}
	//영업조회일	자릿수, 공백	체크
	if (EM_FROM_DT.text.replace("	","").length != 8 )	{
		showMessage(Information, OK, "USER-1027","가입기간","8");
		EM_FROM_DT.text =	varToMon;
		return ;
	}
	//일자형식체크
	if (!checkYYYYMMDD(EM_FROM_DT.text)	) {
		showMessage(Information, OK, "USER-1069","가입기간");
		EM_FROM_DT.text =	varToMon;
		return ;
	}

</script>

<script	language=JavaScript	for=EM_TO_DT event=onKillFocus()>

	//영업조회일
	if (isNull(EM_TO_DT.text) ==true ) {
		showMessage(Information, OK, "USER-1003","가입기간"); 
		EM_TO_DT.text =	varToMon;
		return ;
	}
	//영업조회일	자릿수, 공백	체크
	if (EM_TO_DT.text.replace("	","").length != 8 )	{
		showMessage(Information, OK, "USER-1027","가입기간","8");
		EM_TO_DT.text =	varToMon;
		return ;
	}
	//일자형식체크
	if (!checkYYYYMMDD(EM_TO_DT.text)	) {
		showMessage(Information, OK, "USER-1069","가입기간");
		EM_TO_DT.text =	varToMon;
		return ;
	}

</script>

<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>
	if(row > 0 && old_Row > 0 && row!=old_Row  ){
		var strCustId = DS_O_MASTER.NameValue(row, "CUST_ID");
		var strEntrDt = DS_O_MASTER.NameValue(row, "ENTR_DT");
		
    	searchPumbList(strCustId,strEntrDt);
    	searchSaleList(strCustId,strEntrDt);
	}
	old_Row = row; 
//old_Row = row;
</script>

<!-- Grid sorting 기능  -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
    
    
</script>

<script language=JavaScript for=GD_PUMBLIST event=OnClick(row,colid)>
    //sortColId(eval(this.DataID), row, colid);
    
    
</script>

<script language=JavaScript for=GD_SALELIST event=OnClick(row,colid)>
    //sortColId(eval(this.DataID), row, colid);
    
    
</script>


<!-- 브랜드코드 변경시 -->   
<script language=JavaScript for=EM_PUMBUN_CD event=OnKillFocus()>
	EM_PUMBUN_NAME.Text = "";

	if(EM_PUMBUN_CD.text.length != 0){    
	    setStrPbnNmWithoutPop( "DS_O_PUMBUN_CD", EM_PUMBUN_CD, EM_PUMBUN_NAME, 'Y', '1','','','');
	}
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
<comment id="_NSID_">
<object id="DS_IO_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
 
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_PUMBLIST" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_SALELIST" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_PUMBUN_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_CUST_GRADE" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>


<comment id="_NSID_">
<object id="DS_O_SEX_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_MOBILE_COMP" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>


<comment id="_NSID_">
<object id="DS_O_BIR_MONTH" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->

<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_MASTER");
    var obj2  = document.getElementById("GD_SALELIST");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
   
    obj2.style.height  = grd_height - 340 + "px";
}
</script>

<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">
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
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						
						<th width="80" class="point">가입기간</th>
						<td width="300" > 
						 <comment id="_NSID_">
		                      <object id=EM_FROM_DT classid=<%=Util.CLSID_EMEDIT%>  width=110 tabindex=1 align="absmiddle">
		                      </object>
		                  </comment><script> _ws_(_NSID_);</script>
		                  <img src="/<%=dir%>/imgs/btn/date.gif" id="IMG_FROM_DT" onclick="javascript:openCal('G',EM_FROM_DT)" align="absmiddle" />
		                  ~
		                  <comment id="_NSID_">
		                      <object id=EM_TO_DT classid=<%=Util.CLSID_EMEDIT%>  width=110 tabindex=1 align="absmiddle">
		                      </object>
		                  </comment><script> _ws_(_NSID_);</script>
		                  <img src="/<%=dir%>/imgs/btn/date.gif" id="IMG_FROM_DT" onclick="javascript:openCal('G',EM_TO_DT)" align="absmiddle" />
			            </td>
			            <th width="80">브랜드</th>
		               <td width="220"><comment id="_NSID_"> <object id=EM_PUMBUN_CD
		                   classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1
		                   align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
		                   src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
		                   onclick="javascript:strPbnPop(EM_PUMBUN_CD,EM_PUMBUN_NAME, 'Y'); EM_PUMBUN_CD.focus();"
		                   align="absmiddle" /> <comment id="_NSID_"> <object
		                   id=EM_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%> width=120
		                   align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
		               </td> 
						<td width="552">
							<input type="checkbox" id="CHK_CUST_STAT" checked="true"> 탈퇴 회원 제외
						</td>
						<th>
							<div id=grdName style="color:red; font-weight: bold ;"> </div>
						</th>
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
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr valign="top">
				<td width="35%"  height="100%" rowspan="4">
					<img src="/<%=dir%>/imgs/comm/ring_blue.gif"  align="absmiddle" /> <font style="font-size:13" align="absmiddle"><b>가입리스트</b></font>
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
		               class="BD4A">
		               <tr>
		                  <td width="100%">
		                  <comment id="_NSID_"> <object
		                     id=GD_MASTER width=100% height=740 classid=<%=Util.CLSID_GRID%> tabindex=1 onfocus="dispGrdName(GD_MASTER);">
		                     <param name="DataID" value="DS_O_MASTER">
		                  </object> </comment><script>_ws_(_NSID_);</script></td>
		               </tr>
		            </table>
				</td>
				<td width="65%" >
					 <img src="/<%=dir%>/imgs/comm/ring_blue.gif"  align="absmiddle" /> <font style="font-size:13" align="absmiddle"><b>구매 브랜드 방문내역</b></font>
				</td>
			</tr>
			<tr>
				<td>
					 <table width="100%" border="0" cellspacing="0" cellpadding="0"
		               class="BD4A">
		               <tr>
		                  <td width="100%">
		                  <comment id="_NSID_"> <object
		                     id=GD_PUMBLIST width=100% height=320 classid=<%=Util.CLSID_GRID%> tabindex=1 onfocus="dispGrdName(GD_PUMBLIST);">
		                     <param name="DataID" value="DS_O_PUMBLIST">
		                  </object> </comment><script>_ws_(_NSID_);</script></td>
		               </tr>
		            </table>
				</td>
			</tr>			
			<tr>
				<td>
				<img src="/<%=dir%>/imgs/comm/ring_blue.gif"  align="absmiddle" /> <font style="font-size:13" align="absmiddle"><b>구매 이력</b></font>
				</td>
			</tr>
			<tr>
				<td width="65%" height="100%">
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
		               class="BD4A">
		               <tr>
		                  <td width="100%">
		                  <comment id="_NSID_"> <object
		                     id=GD_SALELIST width=100% height=462 classid=<%=Util.CLSID_GRID%> tabindex=1 onfocus="dispGrdName(GD_SALELIST);">
		                     <param name="DataID" value="DS_O_SALELIST">
		                  </object> </comment><script>_ws_(_NSID_);</script></td>
		               </tr>
		            </table>
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
