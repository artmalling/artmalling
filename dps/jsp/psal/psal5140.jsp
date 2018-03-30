<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > POS정산 > POS시재 정정(통합정보)
 * 작 성 일 : 2012.06.23
 * 작 성 자 : DHL
 * 수 정 자 : 
 * 파 일 명 : psal5140.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : POS별 정산/마감현황
 * 이    력 :2011.05.24 박종은
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


/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 var bfMasterRowPos = 0;
 
 
/**
 * doInit()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 150;		//해당화면의 동적그리드top위치

function doInit(){
    
	var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	
	var obj   = document.getElementById("GD_GIFT"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	
	
    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');      
    DS_O_GIFT.setDataHeader('<gauce:dataset name="H_SEL_GIFT"/>');      
    
    //그리드 초기화
    gridCreate2(); //마스터
    gridCreate3(); // 상품권 현황
    
    // EMedit에 초기화
    initEmEdit(EM_SALE_DT_S,                      "YYYYMMDD",                PK);   //시작일자
    initEmEdit(EM_POSNO_S,                        "GEN^4",                NORMAL);   //시작포스번호
    EM_SALE_DT_S.alignment = 1;
    EM_POSNO_S  .alignment = 3;
    
    //현재년도 셋팅
    EM_SALE_DT_S.text =  varToday;

    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);              //점(조회)
    
//    getStore("DS_STR_CD", "N", "", "N");                                                          // 점        
    getStore("DS_STR_CD", "Y", "", "N");                                                          // 점        

    //POS층
    //POS구분
    var strcd = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드
    
    LC_STR_CD.BindColVal = strcd;
    
    GD_MASTER.focus();
    LC_STR_CD.Focus();
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("psal514","DS_O_MASTER" );
    
}


function gridCreate2(){
    var hdrProperies = '<FC>id={currow}                name="NO"      edit=none width=30   align=center    bgcolor={IF(BALANCE_FLAG = "0" OR BALANCE_FLAG = "50" OR BALANCE_FLAG = "100" OR BALANCE_FLAG =  "190" OR BALANCE_FLAG =  "600" OR BALANCE_FLAG =  "500","#FFFACD", IF(BALANCE_FLAG = "49" OR BALANCE_FLAG = "98" OR BALANCE_FLAG = "99" OR BALANCE_FLAG =  "189", "#FFFFE0", "white"))}</FC>'
                     + '<FC>id=BALANCE_FLAG            name="SEQ"     edit=none width=40   align=right     bgcolor={IF(BALANCE_FLAG = "0" OR BALANCE_FLAG = "50" OR BALANCE_FLAG = "100" OR BALANCE_FLAG =  "190" OR BALANCE_FLAG =  "600" OR BALANCE_FLAG =  "500","#FFFACD", IF(BALANCE_FLAG = "49" OR BALANCE_FLAG = "98" OR BALANCE_FLAG = "99" OR BALANCE_FLAG =  "189", "#FFFFE0", "white"))}</FC>'
                     + '<FC>id=COMM_NAME1              name="항목명"  edit=none width=110  align=left      bgcolor={IF(BALANCE_FLAG = "0" OR BALANCE_FLAG = "50" OR BALANCE_FLAG = "100" OR BALANCE_FLAG =  "190" OR BALANCE_FLAG =  "600" OR BALANCE_FLAG =  "500","#FFFACD", IF(BALANCE_FLAG = "49" OR BALANCE_FLAG = "98" OR BALANCE_FLAG = "99" OR BALANCE_FLAG =  "189", "#FFFFE0", "white"))}</FC>'
                     + '<C>id=NORM_TRAN_CNT            name="건수"    edit=none  width=50   align=right     mask="###,###"   bgcolor={IF(BALANCE_FLAG = "0" OR BALANCE_FLAG = "50" OR BALANCE_FLAG = "100" OR BALANCE_FLAG =  "190" OR BALANCE_FLAG =  "600" OR BALANCE_FLAG =  "500","#FFFACD", IF(BALANCE_FLAG = "49" OR BALANCE_FLAG = "98" OR BALANCE_FLAG = "99" OR BALANCE_FLAG =  "189", "#FFFFE0", "white"))} </C>'
                     + '<C>id=NORM_TRAN_AMT            name="금액"    edit={if(MODYGB="Y", true, false)}  width=100  align=right     mask="###,###"   bgcolor={IF(BALANCE_FLAG = "0" OR BALANCE_FLAG = "50" OR BALANCE_FLAG = "100" OR BALANCE_FLAG =  "190" OR BALANCE_FLAG =  "600" OR BALANCE_FLAG =  "500","#FFFACD", IF(BALANCE_FLAG = "49" OR BALANCE_FLAG = "98" OR BALANCE_FLAG = "99" OR BALANCE_FLAG =  "189", "#FFFFE0", "white"))} </C>'
                     + '<C>id=MODYGB                   name="flag"    edit=none  width=100  align=right   show=false </C>'
                     ;
        
    initGridStyle(GD_MASTER, "common", hdrProperies, true);
    
}




function gridCreate3(){
    var hdrProperies = '<FC>id={currow}                name="NO"       edit=none width=30   align=center    </FC>'
                     + '<FC>id=BALANCE_FLAG            name="항목순서"  edit=none width=60   align=right     </FC>'
                     + '<FC>id=GIFT_NAME               name="항목명"    edit=none width=110  align=left      </FC>'
                     + '<C>id=USE_CNT                  name="건수"      edit=none  width=50   align=right     mask="###,###"    </C>'
                     + '<C>id=USE_AMT                  name="금액"      edit={if(MODYGB="Y", true, false)}  width=100  align=right     mask="###,###"    </C>'
                     + '<C>id=MODYGB                   name="flag"      edit=none  width=100  align=right   show=false </C>'
                     ;
        
    initGridStyle(GD_GIFT, "common", hdrProperies, true);
    
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
 * 작 성 자 : PJE
 * 작 성 일 : 2011-03-16
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    
    //마스터, 디테일 그리드 클리어
    DS_O_MASTER.ClearData();
    
    if(!chkValidation("search")) return;
    
    var strStrCd        = LC_STR_CD.BindColVal;      //점
    var strPosNoS       = EM_POSNO_S.text;           //포스시작번호
    var strSaleDtS      = EM_SALE_DT_S.text;         //시작일자
    
    
 
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strPosNoS="          +encodeURIComponent(strPosNoS)
                   + "&strSaleDtS="         +encodeURIComponent(strSaleDtS) ;
    
    TR_MAIN.Action="/dps/psal514.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER, "+action+":DS_O_GIFT=DS_O_GIFT)"; //조회는 O
    TR_MAIN.Post();
    
    GD_MASTER.focus();
    // 조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.CountRow);

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
    // 저장할 데이터 없는 경우
    if (!DS_O_MASTER.IsUpdated && !DS_O_GIFT.IsUpdated ) {
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028"); 
        setFocusGrid(GD_MASTER,DS_O_MASTER,DS_O_MASTER.RowPosition,"NORM_TRAN_AMT");
        return;
    } else if ( DS_O_MASTER.IsUpdated && DS_O_GIFT.IsUpdated){
    	//변경또는 신규 내용을 저장하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
            setFocusGrid(GD_MASTER,DS_O_MASTER,DS_O_MASTER.RowPosition,"NORM_TRAN_AMT");
            return;     
        }
    	saveMaster();
    	saveDetail();
    } else if( DS_O_MASTER.IsUpdated ){
    	//변경또는 신규 내용을 저장하시겠습니까?
    	if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
            setFocusGrid(DS_O_MASTER,DS_O_MASTER.RowPosition,"NORM_TRAN_AMT");
            return;     
        }
    	saveMaster();
    } else if( DS_O_GIFT.IsUpdated ){
    	//변경또는 신규 내용을 저장하시겠습니까?
    	if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
            //setFocusGrid(DS_O_MASTER,DS_O_MASTER.RowPosition,"NORM_TRAN_AMT");
            return;     
        }
    	saveDetail();
    }
    
    
    
}

/**
 * btn_Excel()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : 
 */
function btn_Excel() {

}


/**
 * btn_Print()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : 
 */
function btn_Print() {

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



 
 /**
  * btn_modConf()
  * 작 성 자 : 
  * 작 성 일 : 
  * 개     요 : 시재정정 완료
  * return값 : void
  */

  function btn_modConf() {
   	  
  }


  /**
   * btn_modCancel()
   * 작 성 자 : 
   * 작 성 일 : 
   * 개     요 : 시재정정 취소
   * return값 : void
   */

   function btn_modCancel() {
   }

 
/*************************************************************************
 * 3. 함수
 *************************************************************************/
function saveMaster(){
	
    
    btnClickSave = true;
    TR_MAIN.Action="/dps/psal514.ps?goTo=saveData";
    TR_MAIN.KeyValue="SERVLET(I:DS_O_MASTER=DS_O_MASTER)"; //조회는 O//,I:DS_O_GIFT=DS_O_GIFT
    TR_MAIN.Post();
    btnClickSave = false;

    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
        btn_Search();
        GD_MASTER.Focus();
    }
    GD_MASTER.Focus();    
	 
}

function saveDetail(){
	
    btnClickSave = true;
    TR_MAIN.Action="/dps/psal514.ps?goTo=saveGfData";
    TR_MAIN.KeyValue="SERVLET(I:DS_O_GIFT=DS_O_GIFT)"; //조회는 O//,
    TR_MAIN.Post();
    btnClickSave = false;
    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
        btn_Search();
        GD_GIFT.Focus();
    }
    GD_GIFT.Focus();
}

/**
 * chkValidation(gbn)
 * 작 성 자 : 박종은
 * 작 성 일 : 2011-03-14
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
            showMessage(Information, OK, "USER-1027","매출일자","8");
            EM_SALE_DT_S.focus();
            return false;
        }
        if(!checkYYYYMMDD(EM_SALE_DT_S.text)){
        	showMessage(Information, OK, "USER-1004","매출일자");
            EM_SALE_DT_S.focus();
            return false;
        }
        	
        if (isNull(EM_SALE_DT_S.text) ==true ) {
            showMessage(Information, OK, "USER-1003","매출일자"); 
            EM_SALE_DT_S.focus();
            return false;
        }
       
        if (isNull(EM_POSNO_S.text) == true) {
            showMessage(Information, OK, "USER-1003","POS번호"); 
            EM_POSNO_S.focus();
            return false;
        }
        
        break;
   
    }
    return true;
}




/**
 * chkValidation(gbn)
 * 작 성 자 : 박종은
 * 작 성 일 : 2011-03-14
 * 개    요 :  저장
 * return값 : void
 */
function setGiftAmt() {
	var saleAmt = 0 ;
	var balFg  = "" ; 

 
	 // 마스터 금액 SELECT
	 for (i = 1; i < 100; i++){		 
		 balFg = DS_O_MASTER.NameValue(i, "BALANCE_FLAG");		  
		 if (balFg == "114") {
			 saleAmt = DS_O_MASTER.NameValue(i, "NORM_TRAN_AMT");
	         break;
		 }
	 } 
	 
	 var  modFg = "N";
	 var giftAmt = 0 ;
	 
	 // 상품권 금액 SELECT
	 for(j=1; j < 20; j++){
		 modFg = DS_O_GIFT.NameValue(j, "MODYGB"); 
		 
		 if (modFg == "Y"){
			 giftAmt = giftAmt + DS_O_GIFT.NameValue(j, "USE_AMT");
		 }
	 }
	 
	 
	 if (saleAmt != giftAmt) { 
		 DS_O_MASTER.NameValue( i , "NORM_TRAN_AMT") = giftAmt; 
	 }
	 
	 
	 return ;
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
<script language=JavaScript for=DS_O_GIFT event=OnColumnChanged(row,colid)>

     //if( row < 1 || bfMasterRowPos == row) return;
//     bfMasterRowPos = row;
//     setGiftAmt();
</script>


<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬 
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
<comment id="_NSID_"><object id="DS_STR_CD" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_POSNOMM" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
 
<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_GIFT" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

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
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_MASTER");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
	
    var obj   = document.getElementById("GD_GIFT");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top) {
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
                  <th width="70" class="point">점</th>
                  <td width="105"><comment id="_NSID_"> <object
                     id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  
                  <th width="70" class="point">매출일자</th>
                  <td width="105" ><comment id="_NSID_"> <object
                     id=EM_SALE_DT_S classid=<%=Util.CLSID_EMEDIT%> width=75
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif"
                     onclick="javascript:openCal('G',EM_SALE_DT_S)" align="absmiddle" />
                     
                  <th class="point" width="110">POS번호</th>
                  <td><comment id="_NSID_"> <object
                     id=EM_POSNO_S classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>   
                  
               </tr>
               <tr>
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
         <tr>
             <td>
             <table width="100%" border="0" cellspacing="0" cellpadding="0">
                 <tr>
                     <td class="sub_title PB03 PT10"><img
                         src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
                         align="absmiddle" />POS별 시재내역</td>
                      
                 </tr>
             </table>
             </td>
             
             <td class="PL10">
             <table width="100%" border="0" cellspacing="0" cellpadding="0">
                 <tr>
                     <td class="sub_title PB03 PT10"><img
                         src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
                         align="absmiddle" />POS별 상품권현황</td>
                     
                 </tr>
             </table>
             </td>
             
            </tr>    

            <tr>
	            <td>
	            <table width="100%" border="0" cellspacing="0" cellpadding="0"
	               class="BD4A">
	               <tr>
	                  <td width="100%">
	                  <comment id="_NSID_"> <object
	                     id=GD_MASTER width=100% height=470 classid=<%=Util.CLSID_GRID%> tabindex=1>
	                     <param name="DataID" value="DS_O_MASTER">
	                  </object> </comment><script>_ws_(_NSID_);</script></td>
 
	               </tr>
	            </table>
	            </td>
	            

                <td  class="PL10">
                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                   class="BD4A">
                   <tr>
                      <td width="100%">
                      <comment id="_NSID_"> <object
                         id=GD_GIFT width=100% height=470 classid=<%=Util.CLSID_GRID%> tabindex=1>
                         <param name="DataID" value="DS_O_GIFT">
                      </object> </comment><script>_ws_(_NSID_);</script></td>
 
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