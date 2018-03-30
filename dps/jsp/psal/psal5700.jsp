<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출관리 > POS정산
 * 작 성 일 : 2017.03.19
 * 작 성 자 : 김준영
 * 수 정 자 : 
 * 파 일 명 : psal5700.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 저널리스트 조회(결제상세)
 * 이    력 :2017.03.19 김준영
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
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js"
   type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
var f = document.all;

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 170;		//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("TX_MESSAGE"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";


    
    // Input Data Set Header 초기화
    
    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');      
    
    //그리드 초기화
    gridCreate1(); //마스터
    //gridCreate2(); //디테일
    // EMedit에 초기화
    
    initEmEdit(EM_SALE_DT_S,                      "YYYYMMDD",                PK);   //시작일자
    EM_SALE_DT_S.alignment = 1;

    initEmEdit(EM_POSNO_S,                        "CODE^4^#",                NORMAL);   //시작포스번호
    EM_POSNO_S.alignment = 3;

    initEmEdit(EM_POSNO_E,                        "CODE^4^#",                NORMAL);   //종료포스번호
    EM_POSNO_E.alignment = 3;
    
    initEmEdit(EM_TRAN_NO_S,          "CODE^5^0",  NORMAL);          //
    initEmEdit(EM_TRAN_NO_E,          "CODE^5^0",  NORMAL);          //
    
    initEmEdit(f.TX_MESSAGE, NORMAL);
    searchPosNoMM();
    if(DS_O_POSNOMM.CountRow >0 ){
    	EM_POSNO_S.text = DS_O_POSNOMM.NameValue(1, "POSNO_MIN");
        EM_POSNO_E.text = DS_O_POSNOMM.NameValue(1, "POSNO_MAX");
    }
    
    //현재년도 셋팅
    EM_SALE_DT_S.text =  varToday;
    
    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_STR_CD, "CODE^0^30,NAME^0^140", 1, PK);              //점(조회)
    
    getStore("DS_STR_CD", "Y", "", "N");                                                          // 점        
    
    //POS구분
    initComboStyle(LC_POS_FLAG,DS_POS_FLAG, "CODE^0^30,NAME^0^140", 1, NORMAL);             
    getEtcCode("DS_POS_FLAG", "D", "P082", "Y");
    LC_POS_FLAG.Index = 0;
    var strcd = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드
    
    LC_STR_CD.BindColVal = strcd;
    
    GD_MASTER.focus();
    LC_STR_CD.Focus();
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("psal570","DS_O_MASTER" );
    
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}                name="NO"                width=60    align=center    </FC>'
                     + '<FC>id=STR_CD                  name="점코드"             width=60    align=center    </FC>'
                     + '<FC>id=SALE_DT                 name="매출일자"           width=80    align=right      </FC>'
                     + '<FC>id=POS_NO                  name="POS번호"           width=60    align=center     suppress="2"    sumtext="합계"</FC>'
                     + '<FC>id=POS_NM                  name="POS명"           width=100    align=center     suppress="2"    </FC>'                     
                     + '<FC>id=TRAN_NO                 name="거래번호"           width=60    align=center       </FC>'
                     + '<FC>id=TRAN_FLAG               name="거래구분"            width=80    align=left   </FC>'
                     + '<FC>id=SALE_TOT_AMT            name="총매출" width=80    gte_columntype="number:0:true" gte_Summarytype="number:0:true"		align=right     mask="###,###"   sumtext={subsum(SALE_TOT_AMT)}</FC>'
                     + '<FC>id=CASH_TOT_AMT            name="현금"               gte_columntype="number:0:true" gte_Summarytype="number:0:true"		width=80    align=right    </FC>'// mask="###,###"   sumtext={subsum(CASH_TOT_AMT)}
                     + '<FC>id=CARD_AMT                name="카드"               gte_columntype="number:0:true" gte_Summarytype="number:0:true"		width=80    align=right     </FC>'//mask="###,###"   sumtext={subsum(CARD_AMT)}
                     + '<FC>id=GIFT_AMT                name="자사상품권"             gte_columntype="number:0:true" gte_Summarytype="number:0:true"		width=80    align=right     </FC>'//mask="###,###"   sumtext={subsum(GIFT_AMT)}
                     + '<FC>id=CUPON_AMT               name="타사상품권"               gte_columntype="number:0:true" gte_Summarytype="number:0:true"		width=80    align=right    </FC>'// mask="###,###"   sumtext={subsum(CUPON_AMT)}
                     + '<FC>id=OKCASHBAG_AMT           name="외상매출"           gte_columntype="number:0:true" gte_Summarytype="number:0:true"		width=80    align=right   </FC>'// mask="###,###"   sumtext={subsum(OKCASHBAG_AMT)}
                     ;
                     

    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    //합계표시
    //GD_MASTER.ViewSummary = "1";
    //GD_MASTER.DecRealData = true;
}
/* function gridCreate2(){
    var hdrProperies = '<FC>id=E_JNL                 name="영수증"        width=350      </FC>'
                     ;
                     

    initGridStyle(GD_DETAIL, "common", hdrProperies, false);
    //합계표시
    //GD_DETAIL.ViewSummary = "1";
    //GD_DETAIL.DecRealData = true; 
} */
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
 * 작 성 자 : PJE
 * 작 성 일 : 2010-03-16
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    
    //마스터, 디테일 그리드 클리어
    DS_O_MASTER.ClearData();
    
    if(!chkValidation("search")) return;
    
    var strStrCd        = LC_STR_CD.BindColVal;      //점
    var strPosFlag      = LC_POS_FLAG.BindColVal;    //포스구분
    var strPosNoS       = EM_POSNO_S.text;           //포스시작번호
    var strPosNoE       = EM_POSNO_E.text;           //포스종료번호
    var strSaleDtS      = EM_SALE_DT_S.text;         //일자
    var strTranNoS      = EM_TRAN_NO_S.text;              //거래 시작번호
    var strTranNoE      = EM_TRAN_NO_E.text;              //거래 끝번호
    if(strTranNoS==""){
    	strTranNoS="00001";
    }
    if(strTranNoE==""){
    	strTranNoE="99999";
    }
    var strSaleUserId   = EM_SALE_USER_ID.text;           //캐셔번호
    var strSaleTotAmtS  = EM_SALE_TOT_AMT_S.text;         //총매출 시작
    var strSaleTotAmtE  = EM_SALE_TOT_AMT_E.text;         //총매출 끝
    if(strSaleTotAmtS==""){
    	strSaleTotAmtS="-999999999";
    }
    if(strSaleTotAmtE==""){
    	strSaleTotAmtE="999999999";
    }
    //var strSaleFlag     = EM_SALE_FLAG.CodeValue;              //결제형태
    var strSaleFlag = '%'
    if(strPosNoS == "") strPosNoS = "0000";
    if(strPosNoE == "") strPosNoE = "9999";
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strPosFlag="         +encodeURIComponent(strPosFlag)
                   + "&strPosNoS="          +encodeURIComponent(strPosNoS)
                   + "&strPosNoE="          +encodeURIComponent(strPosNoE)
                   + "&strSaleDtS="         +encodeURIComponent(strSaleDtS)
                   + "&strTranNoS="         +encodeURIComponent(strTranNoS)
                   + "&strTranNoE="         +encodeURIComponent(strTranNoE)
                   + "&strSaleUserId="      +encodeURIComponent(strSaleUserId)
                   + "&strSaleTotAmtS="     +encodeURIComponent(strSaleTotAmtS)
                   + "&strSaleTotAmtE="     +encodeURIComponent(strSaleTotAmtE)
                   + "&strSaleFlag="        +encodeURIComponent(strSaleFlag)
                   ;
    
    TR_MAIN.Action="/dps/psal570.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();

    GD_MASTER.focus();
    // 조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.CountRow);

    //스크롤바 위치 조정
    GD_MASTER.SETVSCROLLING(0);
    GD_MASTER.SETHSCROLLING(0);
    
}

/**
 * btn_New()
 * 작 성 자 :  
 * 작 성 일 :  
 * 개     요 :   
 * return값 : 
 */
function btn_New() {

}

/**
 * btn_Delete()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개    요 : 
 * return값 : 
 */
function btn_Delete() {

}

/**
 * btn_Save()
 * 작 성 자 :  
 * 작 성 일 :  
 * 개     요 :  
 * return값 : void
 */
function btn_Save() {

    
}

/**
 * btn_Excel()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : 
 */
function btn_Excel() {

    if(DS_O_MASTER.CountRow <= 0){
      showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
        return;
    }
    var strTitle = "저널조회";

    var strStrCd        = LC_STR_CD.text;      //점
    var strPosFlag      = LC_POS_FLAG.text;    //포스구분
    var strPosNoS       = EM_POSNO_S.text;           //포스시작번호
    var strPosNoE       = EM_POSNO_E.text;           //포스종료번호
    var strSaleDtS      = EM_SALE_DT_S.text;         //시작일자
    

    var strTranNoS      = EM_TRAN_NO_S.text;              //거래 시작번호
    var strTranNoE      = EM_TRAN_NO_E.text;              //거래 끝번호

    var strSaleUserId   = EM_SALE_USER_ID.text;           //캐셔번호
    var strSaleTotAmtS  = EM_SALE_TOT_AMT_S.text;         //총매출 시작
    var strSaleTotAmtE  = EM_SALE_TOT_AMT_E.text;         //총매출 끝
    
    var parameters = 
		         "점 "               + strStrCd
		       + " , 일자 "          + strSaleDtS
		       + " , POS구분 "       + strPosFlag
		       + " , POS번호 "   		+ strPosNoS
		       + " ~ "   			+ strPosNoE 
		       + " , 거래번호 "		+ strTranNoS
		       + " ~ "   			+ strTranNoE 
		       + " , 총매출액 "		+ strSaleTotAmtS
		       + " ~ "   			+ strSaleTotAmtE 
		       + " , 캐셔번호 "		+ strSaleUserId
		       
		       ;
        
    //openExcel2(GD_MASTER, strTitle, parameters, true );
    openExcel5(GD_MASTER, strTitle, parameters, true , "",g_strPid );
    
}


/**
 * btn_Print()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : 
 */
function btn_Print() {
	// 조회조건 셋팅
	if(DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"TRAN_MODE")=="준비금"){
		return false;
	}
    var strStrCd  = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"STR_CD");
	var strSaleDt = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"SALE_DT");
	var strPosNo  = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"POS_NO");
	var strTranNo = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"TRAN_NO");
    var strPayInfo = "";
    
   /*  strPayInfo = "월" + strPayCyc +"회, " +  LC_S_PAY_CNT.Text;
     */
     var parameters = "&strStrCd="+strStrCd  
                   + "&strSaleDt="+strSaleDt
			       + "&strPosNo="+strPosNo                  
			       + "&strTranNo="+strTranNo
			       ;
			       
    window.open("/dps/psal570.ps?goTo=print"+parameters,"OZREPORT", 1000, 700);   
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : void
 */

 function btn_Conf() {
 }

/*************************************************************************
 * 3. 함수
 *************************************************************************/

/**
 * chkValidation(gbn)
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-14
 * 개    요 :  저장
 * return값 : void
 */
function chkValidation(gbn){
    switch (gbn){
    case "search" :

        //점 체크
        if (isNull(LC_STR_CD.BindColVal)==true ) {
            showMessage(Information, OK, "USER-1003","점");
            LC_STR_CD.focus();
            return false;
        }
        //기간
        if (EM_SALE_DT_S.text.replace(" ","").length != 8 ) {
            showMessage(Information, OK, "USER-1027","매출시작일자","8");
            EM_SALE_DT_S.focus();
            return false;
        }
        /* 
        if(!checkYYYYMMDD(EM_SALE_DT_S.text)){
        	showMessage(Information, OK, "USER-1004","매출시작일자");
            EM_SALE_DT_S.focus();
            return false;
        } */
        	
        if (isNull(EM_SALE_DT_S.text) ==true ) {
            showMessage(Information, OK, "USER-1003","매출시작일자"); 
            EM_SALE_DT_S.focus();
            return false;
        }

        //기간
        

        /* if(!isBetweenFromTo(EM_SALE_DT_S.text)){
            showMessage(INFORMATION, OK, "USER-1015"); 
            EM_SALE_DT_S.focus();
            return false;
        } */
        /*
        if (EM_POSNO_S.text.replace(" ","").length != 4 && EM_POSNO_S.text != "") {
            showMessage(Information, OK, "USER-1027","POS시작번호","4");
            EM_POSNO_S.focus();
            return false;
        }

        if (EM_POSNO_E.text.replace(" ","").length != 4  && EM_POSNO_E.text != "") {
            showMessage(Information, OK, "USER-1027","POS종료번호","4");
            EM_POSNO_E.focus();
            return false;
        }
        */
        break;
   
    }
    return true;
}

/**
 * searchPosNo()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-14
 * 개    요 :  저장
 * return값 : void
 */
function searchPosNo(strPosNo){

    var goTo       = "searchPosNo" ;    
    var action     = "O";     
    var parameters = "&strPosNo="           +encodeURIComponent(strPosNo);
    
    TR_DETAIL.Action="/dps/psal570.ps?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_POSNO=DS_O_POSNO)"; //조회는 O
    TR_DETAIL.Post();
    
    if(DS_O_POSNO.CountRow > 0){
    	
        return true;
    }
    
    return false;
}

/**
 * searchPosNoMM()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-14
 * 개    요 :  저장
 * return값 : void
 */
function searchPosNoMM(){

    var goTo       = "searchPosNoMM" ;    
    var action     = "O";     
    var parameters = "";
    
    TR_DETAIL.Action="/dps/psal570.ps?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_POSNOMM=DS_O_POSNOMM)"; //조회는 O
    TR_DETAIL.Post();
    
    if(DS_O_POSNOMM.CountRow > 0){
        return true;
    }
    return false;
}
function searchDetail(strStrCd,strSaleDt,strPosNo,strTranNo){
	
	var goTo       = "searchDetail" ;    
    var action     = "O";     
    var parameters = "";
	
    var parameters = "&strStrCd="   +encodeURIComponent(strStrCd)
    			   + "&strSaleDt="  +encodeURIComponent(strSaleDt)
    			   + "&strPosNo="   +encodeURIComponent(strPosNo)
    			   + "&strTranNo="  +encodeURIComponent(strTranNo)
    			   ;
    
	TR_DETAIL.Action="/dps/psal570.ps?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
    TR_DETAIL.Post();
    
//     TX_MESSAGE.value=DS_O_DETAIL.NameValue(1,"E_JNL");
   /*  GD_DETAIL.SETVSCROLLING(0);
    GD_DETAIL.SETHSCROLLING(0); */
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
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_DETAIL.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_DETAIL event=onFail>
    trFailed(TR_DETAIL.ErrorMsg);
</script>



<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
</script>

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
var strStrCd  = DS_O_MASTER.NameValue(row,"STR_CD");
var strSaleDt = DS_O_MASTER.NameValue(row,"SALE_DT");
var strPosNo  = DS_O_MASTER.NameValue(row,"POS_NO");
var strTranNo =DS_O_MASTER.NameValue(row,"TRAN_NO");
//searchDetail(strStrCd,strSaleDt,strPosNo,strTranNo);

</script>

<script language="javascript">
    var today    = new Date();
    var old_Row = 0;
    var searchChk = "";

    // 오늘 일자 셋팅 
    var now = new Date();
    var mon = now.getMonth()+1;
    if(mon < 10)mon = "0" + mon;
    var day = now.getDate();
    if(day < 10)day = "0" + day;
    var varToday = now.getYear().toString()+ mon + day;
    var varToMon = now.getYear().toString()+ mon;
</script>

<!-- POS시작번호 -->
<script language=JavaScript for=EM_POSNO_S event=onKillFocus()>
/*
    var strPosNo = EM_POSNO_S.text;
    
    if(strPosNo != ""){
        if(!searchPosNo(strPosNo)){
        	showMessage(Information, OK, "USER-1000","존재하지 않는 POS시작번호입니다.");
        	return true;
        }
    }
    return true;
    */
</script>

<!-- POS종료번호 -->
<script language=JavaScript for=EM_POSNO_E event=onKillFocus()>
/*
    var strPosNo = EM_POSNO_E.text;
    if(strPosNo != ""){
        if(!searchPosNo(strPosNo)){
            showMessage(Information, OK, "USER-1000","존재하지 않는 POS종료번호입니다.");
            return true;
        }
    }
    return true;
    */
</script>

<!-- 매출시작일 -->
<script language=JavaScript for=EM_SALE_DT_S event=onKillFocus()>

    //영업조회일
    if (isNull(EM_SALE_DT_S.text) ==true ) {
        showMessage(Information, OK, "USER-1003","시작일자"); 
        EM_SALE_DT_S.text = varToMon+"01";
        return ;
    }
    //영업조회일 자릿수, 공백 체크
    if (EM_SALE_DT_S.text.replace(" ","").length != 8 ) {
        showMessage(Information, OK, "USER-1027","시작일자","8");
        EM_SALE_DT_S.text = varToMon+"01";
        return ;
    }
    //일자형식체크
    if (!checkYYYYMMDD(EM_SALE_DT_S.text) ) {
        showMessage(Information, OK, "USER-1069","시작일자");
        EM_SALE_DT_S.text = varToMon+"01";
        return ;
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
<!-- =============== Input용 -->
<!-- 검색용 -->
<comment id="_NSID_">
<object id="DS_STR_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_POSNOMM" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_POS_FLOOR" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_POS_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>>
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_DETAIL" classid=<%=Util.CLSID_DATASET%>>
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_POSNO" classid=<%=Util.CLSID_DATASET%>></object>
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
<object id="TR_DETAIL" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                               *-->
<!--*************************************************************************-->
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
    
	var obj   = document.getElementById("TX_MESSAGE");
    
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
<!--* E. 본문시작                                                           *-->
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
                  <th width="80" class="point">점</th>
                  <td width="150"><comment id="_NSID_"> <object
                     id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=140 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  
                  <th width="80" class="point">일자</th>
                  <td ><comment id="_NSID_"> <object
                     id=EM_SALE_DT_S classid=<%=Util.CLSID_EMEDIT%> width=90
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif"
                     onclick="javascript:openCal('G',EM_SALE_DT_S)" align="absmiddle" />
                 
                  
                  <th width="80" >POS구분</th>
                  <td ><comment id="_NSID_"> <object
                     id=LC_POS_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=140 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
               </tr>
               <tr>
                  <th width="80">POS시작번호</th>
                  <td><comment id="_NSID_"> <object
                     id=EM_POSNO_S classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>   
                  <th >POS종료번호</th>
                  <td width="150"><comment id="_NSID_"> <object
                     id=EM_POSNO_E classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                     
                 <th width="80">캐셔번호</th>
               	<td ><comment id="_NSID_"> <object
                     id=EM_SALE_USER_ID classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>          
                       
               </tr>
               <tr>
               	
               
               	<th width="80">거래번호</th>
               	<td><comment id="_NSID_"> <object
                     id=EM_TRAN_NO_S classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1 
                     align="absmiddle" ></object> </comment><script>_ws_(_NSID_);</script> ~  
               		 <comment id="_NSID_"> <object
                     id=EM_TRAN_NO_E classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1 
                     align="absmiddle"  ></object> </comment><script>_ws_(_NSID_);</script></td>   
                <th width="80" >총매출액</th>   
               		<td  colspan="3"><comment id="_NSID_"> <object
                     id=EM_SALE_TOT_AMT_S classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>~  
               		 <comment id="_NSID_"> <object
                     id=EM_SALE_TOT_AMT_E classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>            
                
               </tr>
               <!--  tr>
	               <th width="80">결제형태</th>
	               <td colspan="5" >
	                  <comment id="_NSID_">
	                    <object id="EM_SALE_FLAG" classid=<%=Util.CLSID_RADIO%> tabindex=1 style="height:20; width:500">
	                    <param name=Cols    value="7">
	                    <param name=Format  value="%^전  체   ,0^현  금   ,1^카  드   ,2^자사상품권,3^쿠  폰  ,4^타사상품권 ,5^OK캐쉬백">    
	                    <param name=CodeValue  value="%">
	                    </object>  	
	                    </comment><script> _ws_(_NSID_);</script> 
	                    </td>
	               
               </tr-->
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
			<td	width="70%"	class="PR03">
			<table width="100%"	border="0" cellspacing="0" cellpadding="0"
			   class="BD4A">
			   <tr>
				  <td width="100%">
				  <comment id="_NSID_">	<object
					 id=GD_MASTER width=100% height=430	classid=<%=Util.CLSID_GRID%> tabindex=1>
					 <param	name="DataID" value="DS_O_MASTER">
				  </object>	</comment><script>_ws_(_NSID_);</script></td>
			   </tr>
			</table>
			</td>
			
				  <td>
					<!-- Grid_Border -->
					<table cellSpacing="0" cellPadding="0" border="0" width="100%" class="emedit_border">
						<tr>
							<td>
								<textarea name="TX_MESSAGE" readonly style="width:332px;height:432px;border:solid 0;font-familly:굴림체;font-size:9pt;font-style:normal;line-height:normal;font-weight:bold;color:#757575;padding:10px;" ></textarea>
							</td>
						</tr>
						
					</table>
					<!-- Grid_Border // -->
				</td>
			   </tr>
			   
			</table>
			</td>
		 </tr>
	  </table>
	  </td>
	  
   </tr>

</table>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</div>
<body>
</html>
