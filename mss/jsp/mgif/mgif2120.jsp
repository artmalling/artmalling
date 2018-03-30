<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 상품권관리 > 상품권 입/출고 > 점내 불출 내역 조회
 * 작 성 일 : 2011.03.14
 * 작 성 자 : 신익수
 * 수 정 자 : 
 * 파 일 명 : mgif2120.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 점내 불출내역을 조회 한다.
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
//디테일 조회 두번 막기 위해 
var old_Row = 0;
var g_strPid           = "<%=pageName%>";                 // PID

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
 var top = 400;		//해당화면의 동적그리드top위치
function doInit(){

	initTab("TAB_MAIN"); 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var adjObj = 30;
	 var obj   = document.getElementById("GD_DETAIL"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top-adjObj) + "px";
	 obj   = document.getElementById("GD_MASTER2");
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top-adjObj+275) + "px";

    // Input Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    DS_O_MASTER2.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_S_REQ_YMD_FROM, "SYYYYMMDD", PK);       //입고일자 from
    initEmEdit(EM_S_REQ_YMD_TO, "TODAY", PK);         //입고일자 to 
  
    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_O_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);  //점
    initComboStyle(LC_POUT_TYPE,DS_O_POUT_TYPE, "CODE^0^30,NAME^0^180", 1, NORMAL);  //불출유형   
    initComboStyle(LC_POUT_FLAG,DS_O_POUT_FLAG, "CODE^0^30,NAME^0^180", 1, NORMAL);  //불출유형   
    initEmEdit(EM_O_EVENT_CD,   "GEN^11", NORMAL);         //행사코드(조회)
    initEmEdit(EM_O_EVENT_NAME, "GEN^40", READ);           //행사명(조회)
    
    
    getStore("DS_O_STR_CD", "Y", "", "N");
    getEtcCode("DS_O_POUT_TYPE","D", "M014", "Y","N",LC_POUT_TYPE);
    getEtcCode("DS_O_POUT_FLAG","D", "M007", "Y","N",LC_POUT_FLAG);
    DS_O_STR_CD.Filter();     // 점 : 본사점 제외 셋팅
    LC_STR_CD.index = 0;
    
    LC_STR_CD.Focus();
    
}

function gridCreate(){
	 var hdrProperies =  '<FC>id={currow}         name="NO"          width=25   align=center</FC>'
				         + '<FC>id=STR_CD         name="점코드"       width=30  SHOW=FALSE  </FC>'
				         + '<FC>id=STR_NAME       name="점"          width=100  align=left sumtext="합계"</FC>' 
                         + '<FC>id=POUT_FLAG       name="불출구분"     width=100   align=left editstyle=Lookup Data="DS_O_POUT_FLAG:CODE:NAME" </FC>'
				         + '<FC>id=POUT_FLAG_NM    name="불출유형"     width=110   align=left SUBSUMTEXT="소계" </FC>'
		                 + '<FC>id=EVENT_CD      name="행사코드"   width=100   align=center</FC>'
		                 + '<FC>id=EVENT_NAME    name="행사명"     width=120   align=left</FC>'
				         + '<FC>id=CONF_DT         name="불출일자"        width=80   align=center mask="XXXX/XX/XX" </FC>'
				         + '<FC>id=CONF_SLIP_NO      name="블출순번"     width=60   align=center </FC>'
				         + '<FC>id=CONF_QTY         name="수량"  gte_columntype="number:0:true" gte_Summarytype="number:0:true"   width=60   align=light sumtext=@sum </FC>'
				         + '<FC>id=CONF_AMT         name="금액"  gte_columntype="number:0:true" gte_Summarytype="number:0:true"   width=100   align=light sumtext=@sum </FC>'
				         + '<FC>id=POUT_REQ_DT         name="신청일자"        width=100   align=center mask="XXXX/XX/XX" </FC>'
                         + '<FC>id=POUT_REQ_SLIP_NO      name="신청순번"     width=60   align=center </FC>'
				         ;
	initGridStyle(GD_MASTER, "common", hdrProperies, false);
	DS_O_MASTER.SubSumExpr  = "POUT_TYPE" ;
	
	var hdrProperies1 =   '<FC>id={currow}             name="NO"          width=25   align=center</FC>'
		                + '<FC>id=GIFT_TYPE_NAME     name="상품권종류"          width=120  align=left sumtext="합계" </FC>'
						+ '<FC>id=GIFT_AMT_NAME     name="금종"        gte_columntype="number:0:true" gte_Summarytype="number:0:true"	  width=120  align=left  </FC>'
				        + '<FC>id=GIFTCERT_AMT      name="상품권금액"  gte_columntype="number:0:true" gte_Summarytype="number:0:true"	sumtext=@sum   width=80   align=right   </FC>'
				        + '<FC>id=GIFT_S_NO             name="시작번호"    width=150   align=center align=center </FC>'
				        + '<FC>id=GIFT_E_NO             name="종료번호"    width=150   align=center </FC>'
				        + '<FC>id=OUT_QTY                   name="수량"   gte_columntype="number:0:true" gte_Summarytype="number:0:true"	width=60   align=light sumtext=@sum </FC>'
				        + '<FC>id=OUT_AMT               name="입고금액"   gte_columntype="number:0:true" gte_Summarytype="number:0:true"	 width=80   align=light sumtext=@sum </FC>'
						;

	initGridStyle(GD_DETAIL, "common", hdrProperies1, false);
	
	var hdrProperies2 =   '<FC>id={currow}       	name="NO"          width=25   align=center</FC>'
				        + '<FC>id=STR_CD         	name="점코드"       width=30  SHOW=FALSE  </FC>'
				        + '<FC>id=STR_NAME       	name="점"          width=100  align=left sumtext="합계"</FC>' 
				        + '<FC>id=POUT_FLAG      	name="불출구분"     width=100   align=left editstyle=Lookup Data="DS_O_POUT_FLAG:CODE:NAME" </FC>'
				        + '<FC>id=POUT_FLAG_NM   	name="불출유형"     width=110   align=left SUBSUMTEXT="소계" </FC>'
				        + '<FC>id=EVENT_CD      	name="행사코드"   width=100   align=center</FC>'
				        + '<FC>id=EVENT_NAME    	name="행사명"     width=120   align=left</FC>'
				        + '<FC>id=CONF_DT         	name="불출일자"        width=80   align=center mask="XXXX/XX/XX" </FC>'
				        + '<FC>id=CONF_SLIP_NO     	name="블출순번"     width=60   align=center </FC>'
				        + '<FC>id=CONF_SEQ_NO      	name="블출번호"     width=60   align=center </FC>'
				        + '<FC>id=CONF_QTY         	name="수량"  gte_columntype="number:0:true" gte_Summarytype="number:0:true"   width=60   align=light sumtext=@sum </FC>'
				        + '<FC>id=CONF_AMT         	name="금액"  gte_columntype="number:0:true" gte_Summarytype="number:0:true"   width=100   align=light sumtext=@sum </FC>'
				        + '<FC>id=GIFT_AMT_NAME    	name="금종"     width=120   align=center</FC>'
				        + '<FC>id=GIFT_S_NO        	name="시작번호"    width=150   align=center </FC>'
				        + '<FC>id=GIFT_E_NO        	name="종료번호"    width=150   align=center </FC>'
				        + '<FC>id=POUT_REQ_DT      	name="신청일자"        width=100   align=center mask="XXXX/XX/XX" </FC>'
				        + '<FC>id=POUT_REQ_SLIP_NO 	name="신청순번"     width=60   align=center </FC>'
				        ;
	
	
	initGridStyle(GD_MASTER2, "common", hdrProperies2, false);
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
	
	switch(getTabItemSelect("TAB_MAIN")){
    case 1:
    	searchReport1();
        break;
    case 2:
    	searchReport2();
        break;
	}

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
	
	 
	 var objGrd 	  = "";
   	 var strStrCd     = LC_STR_CD.Text;       		//점코드
   	 var strPoutDtFr  = EM_S_REQ_YMD_FROM.Text;	    // 불출기간from
	 var strPoutDtTo  = EM_S_REQ_YMD_TO.Text;	    // 불출기간to
	 var strPoutType  = LC_POUT_TYPE.Text;	        // 불출구분
	 var strPoutFlag  = LC_POUT_FLAG.Text;	        // 불출유형
	 var strEvtCd  	  = EM_O_EVENT_CD.Text;         // 행사코드
	 
	 var strTitle = "점내 불출내역 조회"; 
	
	switch(getTabItemSelect("TAB_MAIN")){
    case 1:
    	var rtnVal 	  = showMessage(STOPSIGN, CHOOSEUD, "USER-1000", "다운로드 할 그리드를 선택해 주세요.");
    	if(rtnVal == "1"){
    		objGrd = GD_MASTER;
    	}else if(rtnVal == "2"){
    		objGrd = GD_DETAIL;
    		strTitle = strTitle + "_상세"
    	}else{
    		return;
    	}
        break;
    case 2:
    	objGrd = GD_MASTER2;
        break;
	} 
	 
	 
    if(objGrd.CountRow <= 0){
        showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
          return;
      }


    var parameters = " 점= "+strStrCd
    	+ " , 기간= "+strPoutDtFr
		+ " ~ "+strPoutDtTo
    	+ " , 불출유형= "+strPoutType
    	+ " , 불출구분= "+strPoutFlag
    	+ " , 행사코드= "+strEvtCd		;

	
	//openExcel2(objGrd, strTitle, parameters, true );
	openExcel5(objGrd, strTitle, parameters, true , "",g_strPid );

	

}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
	     
		var strStrCd = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "STR_CD");
	    var strConfDt = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "CONF_DT");
	    var strConfSlipNo = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "CONF_SLIP_NO");
	    
	    //alert("strStrCd===="+strStrCd);
	    //alert("strConfDt===="+strConfDt);
	    //alert("strConfSlipNo===="+strConfSlipNo);
	    
	    var parameters = "&strStrCd="+strStrCd
		            + "&strConfDt="+strConfDt
		            + "&strConfSlipNo="+strConfSlipNo;
		    
		 window.open("/mss/mgif212.mg?goTo=print"+parameters, "OZREPORT", 1000, 700);         
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
function getPoutrReqDtl(strStrCd,strConfDt,strConfSlipNo){
	
    var goTo       = "getPoutrReqDtl" ;    
    var action     = "O";     
    var parameters = "&strStrCd="     + encodeURIComponent(strStrCd)
                   + "&strConfDt="    + encodeURIComponent(strConfDt)
                   + "&strConfSlipNo="+ encodeURIComponent(strConfSlipNo);
    
    TR_MAIN1.Action="/mss/mgif212.mg?goTo="+goTo+parameters;  
    TR_MAIN1.KeyValue="SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
    TR_MAIN1.Post();
    
    // 조회결과 Return
    setPorcCount("SELECT", GD_DETAIL);
}

function btn_Excel_detail() {
	 
    if(DS_O_DETAIL.CountRow <= 0){
        showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
          return;
      }

    var strStrCd        = LC_STR_CD.Text;       //점코드
    var strReqYmdFrom   = EM_S_REQ_YMD_FROM.Text;     //입고일자 FROM
    var strReqYmdTo     = EM_S_REQ_YMD_TO.Text;       //입고일자 TO
    var strPoutType     =  LC_POUT_TYPE.Text;   //불출유형        
    var strPoutFlag     = LC_POUT_FLAG.Text;    //불출구분
    var strVenCd    = EM_O_EVENT_CD.Text;         //행사코드
    
    var parameters = " 점= "+strStrCd
    	+ " , 기간= "+strReqYmdFrom
		+ " ~ "+strReqYmdTo
    	+ " , 불출유형= "+strPoutType
    	+ " , 불출구분= "+strPoutFlag
    	+ " , 행사코드= "+strVenCd		;

	var ExcelTitle = "점내불출내역조회(디테일)"
	
	//openExcel2(GD_DETAIL, ExcelTitle, parameters, true );
		openExcel5(GD_DETAIL, ExcelTitle, parameters, true , "",g_strPid );

}

function searchReport1() {
	
	if(LC_STR_CD.BindColVal.length == 0){ 
        showMessage(INFORMATION, OK, "USER-1001", "점");
        LC_STR_CD.focus();
        return;
     }
	
     // 조회조건 셋팅
     var strStrCd        = LC_STR_CD.BindColVal;       //점코드
     var strReqYmdFrom   = EM_S_REQ_YMD_FROM.Text;     //입고일자 FROM
     var strReqYmdTo     = EM_S_REQ_YMD_TO.Text;       //입고일자 TO
     var strPoutType     =  LC_POUT_TYPE.BindColVal;   //불출유형        
     var strPoutFlag     = LC_POUT_FLAG.BindColVal;    //불출구분
     var strVenCd    = EM_O_EVENT_CD.Text;         //행사코드
     
     if(strReqYmdFrom > strReqYmdTo) {
         showMessage(INFORMATION, OK, "USER-1015");
         EM_S_REQ_YMD_FROM.Focus();
         return;
     }
     
     //데이타 셋 클리어
     DS_O_MASTER.ClearData();
     DS_O_DETAIL.ClearData();
     
     var goTo       = "getPoutrReqMst" ;    
     var action     = "O";     
     var parameters = "&strStrCd="     + encodeURIComponent(strStrCd)
                    + "&strReqYmdFrom="+ encodeURIComponent(strReqYmdFrom)
                    + "&strReqYmdTo="  + encodeURIComponent(strReqYmdTo)
                    + "&strPoutType="  + encodeURIComponent(strPoutType)
                    + "&strPoutFlag="  + encodeURIComponent(strPoutFlag)
                    + "&strVenCd="     + encodeURIComponent(strVenCd)
                    ;
    
     TR_MAIN.Action="/mss/mgif212.mg?goTo="+goTo+parameters;  
     TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
     TR_MAIN.Post();
     
     old_Row = 1;
  
     // 조회결과 Return
     setPorcCount("SELECT", GD_MASTER);
	
}

function searchReport2() {
	
	if(LC_STR_CD.BindColVal.length == 0){ 
        showMessage(INFORMATION, OK, "USER-1001", "점");
        LC_STR_CD.focus();
        return;
     }
	
     // 조회조건 셋팅
     var strStrCd        = LC_STR_CD.BindColVal;       //점코드
     var strReqYmdFrom   = EM_S_REQ_YMD_FROM.Text;     //입고일자 FROM
     var strReqYmdTo     = EM_S_REQ_YMD_TO.Text;       //입고일자 TO
     var strPoutType     =  LC_POUT_TYPE.BindColVal;   //불출유형        
     var strPoutFlag     = LC_POUT_FLAG.BindColVal;    //불출구분
     var strVenCd    = EM_O_EVENT_CD.Text;         //행사코드
     
     if(strReqYmdFrom > strReqYmdTo) {
         showMessage(INFORMATION, OK, "USER-1015");
         EM_S_REQ_YMD_FROM.Focus();
         return;
     }
     
     //데이타 셋 클리어
     DS_O_MASTER2.ClearData();
     
     var goTo       = "getPoutrReqMst2" ;    
     var action     = "O";     
     var parameters = "&strStrCd="     + encodeURIComponent(strStrCd)
                    + "&strReqYmdFrom="+ encodeURIComponent(strReqYmdFrom)
                    + "&strReqYmdTo="  + encodeURIComponent(strReqYmdTo)
                    + "&strPoutType="  + encodeURIComponent(strPoutType)
                    + "&strPoutFlag="  + encodeURIComponent(strPoutFlag)
                    + "&strVenCd="     + encodeURIComponent(strVenCd)
                    ;
    
     TR_MAIN.Action="/mss/mgif212.mg?goTo="+goTo+parameters;  
     TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER2=DS_O_MASTER2)"; //조회는 O
     TR_MAIN.Post();
     
     //old_Row = 1;
  
     // 조회결과 Return
     setPorcCount("SELECT", GD_MASTER2);
	
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
   /* showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN1.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN1.ErrorMsg);
    for(i=1;i<TR_MAIN1.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN1.SrvErrMsg('GAUCE',i));
    }*/
    trFailed(TR_MAIN1.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_STR_CD event=OnFilter(row)>
if (DS_O_STR_CD.NameValue(row, "GBN") != "0") {// 본사점 제외
    return true;
}
return false;
</script>
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>
   if (DS_O_MASTER.NameValue(row,"STR_CD") == "") {
	   DS_O_DETAIL.ClearData();
	   old_Row = row;
   } else {
    if(row > 0 && old_Row != row ){
		var strStrCd = DS_O_MASTER.NameValue(row, "STR_CD");
	    var strConfDt = DS_O_MASTER.NameValue(row, "CONF_DT");
	    var strConfSlipNo = DS_O_MASTER.NameValue(row, "CONF_SLIP_NO");
	    
	    //점내 불출 내역 디테일 조회
	    getPoutrReqDtl(strStrCd,strConfDt,strConfSlipNo);
	}
    old_Row = row;
   }
</script>


<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=LC_POUT_TYPE event=OnSelChange()>
    if(LC_POUT_TYPE.BindColVal == "3") {
        EM_O_EVENT_CD.Text = "";
        EM_O_EVENT_NAME.Text = "";
        EM_O_EVENT_CD.Enable = true;
        enableControl(EventImg, true);
    }
    else {
        EM_O_EVENT_CD.Text = "";
        EM_O_EVENT_NAME.Text = "";
        EM_O_EVENT_CD.Enable = false;
        enableControl(EventImg, false);
        
    }
</script> 
  
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               *-->
<!--*************************************************************************-->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    //그리드 정렬기능
    if( row < 1) {
        sortColId( eval(this.DataID), row , colid );
    }
</script>
<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
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
<comment id="_NSID_"><object id="DS_O_STR_CD"          classid=<%=Util.CLSID_DATASET%>>
<param name=UseFilter   value=true>
</object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_POUT_TYPE"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_POUT_FLAG"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_DETAIL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_ORG_NM"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_MASTER2"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

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

<script language='javascript'>
window.onresize = function(){
	var adjObj = 30;
    var obj   = document.getElementById("GD_DETAIL");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150 - adjObj) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top - adjObj);
    }
    obj.style.height  = grd_height + "px";
    
    
    obj   = document.getElementById("GD_MASTER2");

    if((parseInt(window.document.body.clientHeight)) <= top+150 - adjObj + 275 ) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top - adjObj + 275);
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
             <th width="80" class="POINT" >점</th>
             <td width="140">
               <comment id="_NSID_">
                 <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=140 align="absmiddle"></object>
               </comment>
               <script>_ws_(_NSID_);</script> 
             </td>
             <th width="80" class="POINT">기간</th>
             <td width="210">
                <comment id="_NSID_">
                    <object id=EM_S_REQ_YMD_FROM classid=<%=Util.CLSID_EMEDIT%> width="70" onblur="javascript:checkDateTypeYMD(this);" align="absmiddle"> 
                    </object>
                 </comment><script>_ws_(_NSID_);</script>
                 <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_S_REQ_YMD_FROM)" /> ~ 
                 <comment id="_NSID_">
                    <object id=EM_S_REQ_YMD_TO classid=<%=Util.CLSID_EMEDIT%> onblur="javascript:checkDateTypeYMD(this);" width="70" align="absmiddle">
                    </object>
                 </comment><script>_ws_(_NSID_);</script>
                 <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_S_REQ_YMD_TO)" align="absmiddle" />
             </td>
             <th width="80">불출구분</th>
             <td >
                <comment id="_NSID_">
                       <object id=LC_POUT_FLAG classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=150 align="absmiddle">
                       </object>
                 </comment><script>_ws_(_NSID_);</script> 
               
             </td>
         </tr>
         <tr>
         <th width="80">불출유형</th>
         <td >
             <comment id="_NSID_">
                   <object id=LC_POUT_TYPE classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=140 align="absmiddle">
                   </object>
             </comment><script>_ws_(_NSID_);</script> 
         </td> 
         <th>행사</th> 
             <td colspan=3>
                 <comment id="_NSID_">
                       <object id=EM_O_EVENT_CD classid=<%=Util.CLSID_EMEDIT%>   width=90 tabindex=1 align="absmiddle">
                       </object>
                 </comment><script>_ws_(_NSID_);</script> 
                 <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle"  id=EventImg  
                      onclick="javascript:mssEventMstPop('SEL_STR_EVENT_POP',EM_O_EVENT_CD,EM_O_EVENT_NAME,LC_STR_CD.BindColVal, '4');"  class="PR03"/> 
                 <comment id="_NSID_">
                       <object id=EM_O_EVENT_NAME classid=<%=Util.CLSID_EMEDIT%>   width=300 tabindex=1 align="absmiddle">
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
</table>

<div id=TAB_MAIN  width="100%" height=870 TitleWidth=90  TitleAlign="center" >
	<menu TitleName="양식1"       DivId="tab_page1" Enable='true' />
	<menu TitleName="양식2"       DivId="tab_page2" Enable='true' />
</div>
<div id=tab_page1 width="100%" >
<table width="100%" border="0" cellspacing="0" cellpadding="0">  
    <td class="PT01 PB03">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
      <tr>
      <td>
          <comment id="_NSID_"><OBJECT id=GD_MASTER width=100% height=240 classid=<%=Util.CLSID_GRID%>>
              <param name="DataID" value="DS_O_MASTER">
               <Param Name="ViewSummary"   value="1" >
          </OBJECT></comment><script>_ws_(_NSID_);</script>
      </td>  
       </tr>
      </table> 
    </td>
    </tr>
<!--  그리드의 구분dot & 여백  -->
	<tr>
            </td>
            <td class="right" valign="bottom">
            <img src="/<%=dir%>/imgs/btn/excel.gif" onclick="btn_Excel_detail();" style="display:none" />
            </td>	
    </tr>   
  <tr><td class="dot"></td></tr>
  <!--  그리드의 구분dot & 여백  -->

  <tr>
    <td class="PT01 PB03">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
      <tr>
      <td>
          <comment id="_NSID_"><OBJECT id=GD_DETAIL width=100% height=370 classid=<%=Util.CLSID_GRID%>>
              <param name="DataID" value="DS_O_DETAIL">
               <Param Name="ViewSummary"   value="1" >
          </OBJECT></comment><script>_ws_(_NSID_);</script>
      </td>  
       </tr>
      </table> 
    </td>
    </tr>
</table>
</div>

<div id=tab_page2 width="100%" >
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>  
    <td class="PT01 PB03">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
      <tr>
      <td>
          <comment id="_NSID_"><OBJECT id=GD_MASTER2 width=100% height=750 classid=<%=Util.CLSID_GRID%>>
              <param name="DataID" value="DS_O_MASTER2">
               <Param Name="ViewSummary"   value="1" >
          </OBJECT></comment><script>_ws_(_NSID_);</script>
      </td>  
       </tr>
      </table> 
    </td>
    </tr>
</table>
</div>
</DIV>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>

